Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA716A1A77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBXKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBXKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:38:12 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A059FE;
        Fri, 24 Feb 2023 02:37:52 -0800 (PST)
Received: from [192.168.1.103] (31.173.87.22) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 24 Feb
 2023 13:37:42 +0300
Subject: Re: [tip: irq/urgent] genirq/ipi: Fix NULL pointer deref in
 irq_data_get_affinity_mask()
To:     <linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
        <maz@kernel.org>
References: <b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru>
 <167689775708.387.18354451760866911184.tip-bot2@tip-bot2>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <491f6ae2-408b-fa3a-58e1-31a7e4d9bb74@omp.ru>
Date:   Fri, 24 Feb 2023 13:37:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <167689775708.387.18354451760866911184.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.87.22]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/24/2023 10:17:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175702 [Feb 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 504 504 dc137e1f9c062eb6c0671e7d509ab442ae395562
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.22 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 31.173.87.22:7.1.2;git.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.22
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/24/2023 10:20:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/24/2023 1:12:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 3:55 PM, tip-bot2 for Sergey Shtylyov wrote:
> The following commit has been merged into the irq/urgent branch of tip:
> 
> Commit-ID:     feabecaff5902f896531dde90646ca5dfa9d4f7d
> Gitweb:        https://git.kernel.org/tip/feabecaff5902f896531dde90646ca5dfa9d4f7d
> Author:        Sergey Shtylyov <s.shtylyov@omp.ru>
> AuthorDate:    Wed, 17 Aug 2022 23:00:45 +03:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 20 Feb 2023 13:53:41 +01:00
> 
> genirq/ipi: Fix NULL pointer deref in irq_data_get_affinity_mask()
> 
> If ipi_send_{mask|single}() is called with an invalid interrupt number, all
> the local variables there will be NULL. ipi_send_verify() which is invoked
> from these functions does verify its 'data' parameter, resulting in a
                       ^^^^
   Looks like you spoiled the commit log: it should be "doesn't" -- as in my
original patch. :-/

> kernel oops in irq_data_get_affinity_mask() as the passed NULL pointer gets
> dereferenced.
> 
> Add a missing NULL pointer check in ipi_send_verify()...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Fixes: 3b8e29a82dd1 ("genirq: Implement ipi_send_mask/single()")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru
> 
> 
> ---
>  kernel/irq/ipi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
> index bbd945b..961d4af 100644
> --- a/kernel/irq/ipi.c
> +++ b/kernel/irq/ipi.c
> @@ -188,9 +188,9 @@ EXPORT_SYMBOL_GPL(ipi_get_hwirq);
>  static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
>  			   const struct cpumask *dest, unsigned int cpu)
>  {
> -	const struct cpumask *ipimask = irq_data_get_affinity_mask(data);
> +	const struct cpumask *ipimask;
>  
> -	if (!chip || !ipimask)
> +	if (!chip || !data)
>  		return -EINVAL;
>  
>  	if (!chip->ipi_send_single && !chip->ipi_send_mask)
> @@ -199,6 +199,10 @@ static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> +	ipimask = irq_data_get_affinity_mask(data);
> +	if (!ipimask)
> +		return -EINVAL;
> +
>  	if (dest) {
>  		if (!cpumask_subset(dest, ipimask))
>  			return -EINVAL;

MBR, Sergey
