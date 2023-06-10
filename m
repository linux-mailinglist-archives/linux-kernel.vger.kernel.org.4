Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A272AEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFJUkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJUkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:40:02 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2426B2;
        Sat, 10 Jun 2023 13:39:56 -0700 (PDT)
Received: from [192.168.1.103] (31.173.85.118) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 10 Jun
 2023 23:40:13 +0300
Subject: Re: [PATCH] ata: Use of_property_read_reg() to parse "reg"
To:     Rob Herring <robh@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230609183125.1765780-1-robh@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <26a907e3-f362-09c8-3cc6-fb68ba87c64c@omp.ru>
Date:   Sat, 10 Jun 2023 23:39:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230609183125.1765780-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.85.118]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/10/2023 20:10:09
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177977 [Jun 09 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 516 516 efd4d74ff4b68f90ca62ae34a19f27bf46d81db5
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.118 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.118
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2023 20:16:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2023 5:50:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/9/23 9:31 PM, Rob Herring wrote:

> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
[...]


Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

> diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
> index c47c3fb434d5..b3cc23d891d5 100644
> --- a/drivers/ata/sata_svw.c
[...]
> @@ -319,10 +320,10 @@ static int k2_sata_show_info(struct seq_file *m, struct Scsi_Host *shost)
>  	/* Match it to a port node */
>  	index = (ap == ap->host->ports[0]) ? 0 : 1;
>  	for (np = np->child; np != NULL; np = np->sibling) {
> -		const u32 *reg = of_get_property(np, "reg", NULL);
> -		if (!reg)
> +		u64 reg;

   An empty line wouldn't hurt here... :-)

> +		if (of_property_read_reg(np, 0, &reg, NULL))
>  			continue;
> -		if (index == *reg) {
> +		if (index == reg) {
>  			seq_printf(m, "devspec: %pOF\n", np);
>  			break;
>  		}

MBR, Sergey
