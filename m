Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9F70D7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEWIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjEWIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:45:38 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25CC5;
        Tue, 23 May 2023 01:45:37 -0700 (PDT)
Received: from [192.168.1.103] (31.173.81.19) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 23 May
 2023 11:45:28 +0300
Subject: Re: [PATCH] usb: host: xhci: Do not re-initialize the XHCI HC if
 being removed
To:     Wesley Cheng <quic_wcheng@quicinc.com>, <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>
References: <20230523015354.18497-1-quic_wcheng@quicinc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f34927c3-7f23-3971-9f16-88cb5773f973@omp.ru>
Date:   Tue, 23 May 2023 11:45:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230523015354.18497-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.81.19]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 05/23/2023 08:32:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177532 [May 23 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 513 513 41a024eb192917672f8141390381bc9a34ec945f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.19 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;31.173.81.19:7.7.2,7.7.3
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.19
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/23/2023 08:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/23/2023 7:21:00 AM
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

Hello!

On 5/23/23 4:53 AM, Wesley Cheng wrote:

> During XHCI resume, if there was a host controller error detected the
> routine will attempt to re-initialize the XHCI HC, so that it can return
> back to an operational state.  If the XHCI host controller is being
> removed, this sequence would be already handled within the XHCI halt path,
> leading to a duplicate set of reg ops/calls.  In addition, since the XHCI
> bus is being removed, the overhead added in restarting the HCD is
> unnecessary.  Check for the XHC state before setting the reinit_xhc
> parameter, which is responsible for triggering the restart.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/host/xhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index b81313ffeb76..2017ed3ae4a7 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1028,7 +1028,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>  	temp = readl(&xhci->op_regs->status);
>  
>  	/* re-initialize the HC on Restore Error, or Host Controller Error */
> -	if (temp & (STS_SRE | STS_HCE)) {
> +	if ((temp & (STS_SRE | STS_HCE)) &&
> +		!(xhci->xhc_state & XHCI_STATE_REMOVING)) {

  Please add one more tab here in order not to blend it with the following lines.

>  		reinit_xhc = true;
>  		if (!xhci->broken_suspend)
>  			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);

MBR, Sergey
