Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6471F214
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjFASco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjFAScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:32:25 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8DA184;
        Thu,  1 Jun 2023 11:32:18 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.8) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 1 Jun 2023
 21:32:08 +0300
Subject: Re: [PATCH v5] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        <linux-kernel@vger.kernel.org>
References: <197b4ccb-2dc8-add6-02a5-2e241b15a5f9@omp.ru>
 <e9a5f27effa12a058fa944034ee581817f2e7928.camel@physik.fu-berlin.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d78797df-530e-229b-418a-5cb6c269d683@omp.ru>
Date:   Thu, 1 Jun 2023 21:32:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e9a5f27effa12a058fa944034ee581817f2e7928.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.8]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/01/2023 18:09:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177803 [Jun 01 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 515 515 1b17fc6ab778ab3730d780f30d802773a7d822ac
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;git.kernel.org:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.8
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/01/2023 18:17:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/1/2023 2:21:00 PM
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

On 6/1/23 9:38 AM, John Paul Adrian Glaubitz wrote:
[...]
>> Now that IRQ0 is no longer returned by platform_get_irq() and its ilk (they
>> now return -EINVAL instead).  However, the code supporting SH3/4 SoCs still
>> maps the IRQ #s starting at 0 -- modify that code to start the IRQ #s from
>> 16 instead.

  Now that I'm re-reading this passage, it seems unfinished... :-/

>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> I'm not sure I understand. Does that mean that the Ethernet controller on
> the AP-SH4A-3A/AP-SH4AD-0A boards will no longer work after this patch
> has been applied?

   Contrariwise, they should start working again! :-)
   Here's the story as I understand it:

1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=965b2aa78fbcb831acf4f669f494da201f4bcace broke IRQ0 use in the SMSC 9111x
driver.

2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ef9b803a4af0f5e42012176889b40bb2a978b18 fixed IRQ0 use in that driver.

3. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289 totally stopped returning IRQ0
from platform_get_irq(), thus breaking that driver again.

4. This patch remaps IRQ0 to IRQ16 and thus fixes the SMSC 911x driver again.

[...]

MBR, Sergey
