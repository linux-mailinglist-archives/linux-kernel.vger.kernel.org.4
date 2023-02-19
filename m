Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE569BFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 11:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBSKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 05:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 05:20:33 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA911147
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 02:20:31 -0800 (PST)
Received: from [192.168.1.103] (31.173.84.108) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sun, 19 Feb
 2023 13:20:22 +0300
Subject: Re: [PATCH] irq: ipi: fix NULL pointer deref in
 irq_data_get_affinity_mask()
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru>
 <774e2812-2856-f146-b8b3-e4f772c5e38a@omp.ru> <875ycb2jwe.ffs@tglx>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <028ccd43-1474-1f90-653e-044641cc533f@omp.ru>
Date:   Sun, 19 Feb 2023 13:20:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <875ycb2jwe.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.108]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/19/2023 09:59:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175607 [Feb 19 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 504 504 dc137e1f9c062eb6c0671e7d509ab442ae395562
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.108 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 31.173.84.108:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.108
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/19/2023 10:01:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/19/2023 9:03:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 1:49 PM, Thomas Gleixner wrote:
[...]

>>> Iff ipi_send_{mask|single}() get called with e.g. an invalid IRQ #, all the
>>> local variables there will be NULL -- the problem is that ipi_send_verify()
>>> (that's called first thing) doesn't verify its 'data' parameter, resulting
>>> in a kernel oops in irq_data_get_affinity_mask() as the passed NULL pointer
>>> gets dereferenced.  Add a missing NULL check in ipi_send_verify()...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Fixes: 3b8e29a82dd1 ("genirq: Implement ipi_send_mask/single()")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>>    Patch fell thru the cracks? :-/
> 
> Obviously :)
> 
> /me goes to find trash tongs to pick it up

   Need help? :-)

MBR, Sergey
