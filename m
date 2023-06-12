Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836972C283
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjFLLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjFLLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:08:19 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFF5277;
        Mon, 12 Jun 2023 03:56:39 -0700 (PDT)
Received: from [192.168.1.103] (178.176.77.197) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 12 Jun
 2023 13:56:29 +0300
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        <linux-kernel@vger.kernel.org>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
 <983d701befce7fc0010c53d09be84f5c330bdf45.camel@physik.fu-berlin.de>
 <837a586e-5e76-7a5b-a890-403ce26ea51b@gmail.com>
 <3fff103bcea3874cc7fd93c3a765ca642aa7f632.camel@physik.fu-berlin.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f32a649e-3563-2485-234e-640f9dace105@omp.ru>
Date:   Mon, 12 Jun 2023 13:56:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3fff103bcea3874cc7fd93c3a765ca642aa7f632.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.77.197]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/12/2023 10:41:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177977 [Jun 09 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 516 516 efd4d74ff4b68f90ca62ae34a19f27bf46d81db5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.77.197 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.77.197
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/12/2023 10:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/12/2023 4:54:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/23 8:28 AM, John Paul Adrian Glaubitz wrote:
[...]

>>>> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
>>>> return -EINVAL instead.  However, the kernel code supporting SH3/4 based
>>>> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
>>>> IRQ #s from 16 instead.
>>>>
>>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>>>> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...
>>>
>>> Do you mind if I remove the ellipsis at the end of this sentence when I merge
>>> this later today? I think it makes no sense from a grammatical point of view.
>>
>>    No, I don't mind. :-)
> 
> Applied to my for-next branch.

   Note that this was positioned as a fix.
   Where is your tree, BTW? :-)

> Thanks,
> Adrian

MBR, Sergey
