Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB976DA4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDFV02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjDFV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:26:01 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C010EF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1680816360; x=1712352360;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dw2FXW+kXlTDs2MZ5yKwncsONZt9jql57ufr5g/GGhU=;
  b=tOC8jbwqyy/PUhjffXKZlmtUeZmkw89XHH4HNDvEZVgiGBU1pQxohZ0A
   GwT+z2+hFPqylKEAxqK03Yzlo3FpE38pMSNaXFI8TG0k4tS75TXGNSboU
   gDq5fbCuqdswpLgFowwrMMqNcp2wPmsI/Hl6V0nbepmQPjstqXeTt1Sew
   w=;
X-IronPort-AV: E=Sophos;i="5.98,323,1673913600"; 
   d="scan'208";a="315704168"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 21:25:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id CFE0681BA3;
        Thu,  6 Apr 2023 21:25:57 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Apr 2023 21:25:48 +0000
Received: from freeip.amazon.com (10.106.178.8) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Apr 2023 21:25:47 +0000
Date:   Thu, 6 Apr 2023 16:25:39 -0500
From:   Geoff Blake <blakgeof@amazon.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix DTC reset
In-Reply-To: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
Message-ID: <b2488619-a306-981c-1172-7efce749c10e@amazon.com>
References: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.106.178.8]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ran this patch on an AWS C6g.metal and unfortunately still see the 
spurious IRQs trigger quickly (within 10 tries) when using the following 
flow:

perf stat -a -e arm_cmn_0/event=0x5,type=0x5/ -- sleep 600
kexec -e 

Adding in the simple shutdown routine, I have run over 100 of the 
above cycles and the spurious IRQs haven't triggered.  I think we still 
need both for now.

-Geoff  

On Thu, 6 Apr 2023, Robin Murphy wrote:

> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> It turns out that my naive DTC reset logic fails to work as intended,
> since clearing PMCR.PMU_EN appears to result in writes to PMOVSR_CLR
> being ignored, while some hard-to-characterise combination of conditions
> (differently between DTC0 and secondary DTCs) also appears to result in
> PMOVSR reading as zero even when an overflow remains asserted. Thus
> rather than resetting the PMU to a nice clean state, we can currently
> end up with screaming spurious interrupts from secondary DTCs which we
> can neither see nor clear. This behaviour is of course not documented.
> 
> Resetting PMCR to disable the interrupt output but enable the PMU itself
> seems to at least make the PMOVSR_CLR write work as expected on DTC0
> (although it looks like writing to PMCR twice has actually been having
> some hidden side-effect of clearing any pending overflows there).
> Unfortunately this still does not seem to help secondary DTCs, but going
> beyond PMU scope and additionally resetting DTC_CTL does seems to make
> everything work out, and superficially looks sensible. Therefore pile
> that onto the house of empirical cards too, until I can check with the
> hardware team whether there's actually any proper recommended way of
> recovering from an arbitrary PMU state after an oops/kexec/whatever.
> 
> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> Reported-by: Geoff Blake <blakgeof@amazon.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> This supersedes the previous shutdown/IRQ patches, now that I've
> finally managed to make *some* sense of what's really going on. If
> anyone's interested, this is the contrivance I used for testing:
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/d8f1035c5bc510516d6e4f0b7bf0b875a749daf7
> ---
>  drivers/perf/arm-cmn.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 144cc08d9e04..81fe01171e33 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1899,7 +1899,10 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
>         if (dtc->irq < 0)
>                 return dtc->irq;
> 
> -       writel_relaxed(0, dtc->base + CMN_DT_PMCR);
> +       if (idx == 0)
> +               writel_relaxed(0, dtc->base + CMN_DT_DTC_CTL);
> +
> +       writel_relaxed(CMN_DT_PMCR_PMU_EN, dtc->base + CMN_DT_PMCR);
>         writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
>         writel_relaxed(CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
> 
> --
> 2.39.2.101.g768bb238c484.dirty
> 
> 
