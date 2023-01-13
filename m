Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6B66A1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjAMS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjAMS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:26:16 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C737EC85;
        Fri, 13 Jan 2023 10:21:47 -0800 (PST)
Received: from [192.168.1.103] (178.176.75.110) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 13 Jan
 2023 21:21:37 +0300
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <b2bccbca-6acf-7129-0099-7ad21bf13430@omp.ru>
Organization: Open Mobile Platform
Message-ID: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
Date:   Fri, 13 Jan 2023 21:21:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b2bccbca-6acf-7129-0099-7ad21bf13430@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.75.110]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 01/13/2023 17:57:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 174716 [Jan 13 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.110 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.110
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/13/2023 17:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/13/2023 4:01:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/3/22 11:42 PM, Sergey Shtylyov wrote:

> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> at 0 -- modify that code to start the IRQ #s from 16 instead.
> 
> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> [1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/
> 
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> ---
> The patch is against Linus Torvalds' 'linux.git' repo.

   So, this patch hasn't been merged... may I ask why? :-(

MBR, Sergey
