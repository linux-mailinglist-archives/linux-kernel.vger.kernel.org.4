Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266D700D33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjELQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjELQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:42:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58E9ECD;
        Fri, 12 May 2023 09:42:50 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C79TkL025224;
        Fri, 12 May 2023 11:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=yhZyXr8lHG2UYQnMB5K/v8MOBZCb9ZrOdJC0YRmRGa8=;
 b=E7pvxMu46+f0qJDoI0tbWmk1ppaoaZxPwNujd4EJ1fjmkq3wiJ1VuBahzVHA+HPv7P7T
 8qm3v/DlrDNQbQXvLYCBV3uvlYGPzR/GF7yZXfjZej5A6y+Cdc7fhmjfsxcqF0MsuSGx
 268U2NEZe61O33H77dy6hWMmIEI2CAXD2mYDWaea2Cn9dX0iWVVLjihqnwJbGn+ZvHFw
 u4w1ePOkTA0NLasMz+YUxsO3GYJ51WiI27DYJxB2TL5Cykzdo4ni4JuYURsVPcZHRvjG
 879KQaoqoKuMLsyatT7CvUiu5tCjILTc0p/VECcyEVS4fueZdqinm0Gw4fcj1JCDbC6X 8Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46s1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:42:35 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 11:42:33 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 12 May 2023 11:42:33 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8527911A8;
        Fri, 12 May 2023 16:42:33 +0000 (UTC)
Date:   Fri, 12 May 2023 16:42:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <20230512164233.GN68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86mt29mt2m.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: MwewUnRTmgtD-wNGy1bTINuTAa_F_N5D
X-Proofpoint-GUID: MwewUnRTmgtD-wNGy1bTINuTAa_F_N5D
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:07:45PM +0100, Marc Zyngier wrote:
> On Fri, 12 May 2023 16:39:33 +0100,
> Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > On Fri, May 12, 2023 at 04:10:05PM +0100, Marc Zyngier wrote:
> > > On Fri, 12 May 2023 13:28:35 +0100,
> > > Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > Is the objection here that regmap is making these calls for us,
> > rather than them being hard coded into this driver?
> 
> That's one of the reasons. Look at the existing irqchip drivers: they
> have nothing in common with yours. The regmap irqchip abstraction may
> be convenient for what you are doing, but the result isn't really an
> irqchip driver. It is something that is a small bit of a larger device
> and not an interrupt controller driver on its own. The irqchip
> subsystem is there for "first class" interrupt controllers.
> 

Thank you this is helpful. This device has GPIOs that other
devices might want to use for IRQs, so the chip is capable
of providing IRQ services to other devices in the system not
just itself. This is commonly used where external boosted
amps have their IRQs hooked up to the CODEC.

I guess if Mark doesn't mind I think the only internal bit of the
device that uses the IRQs is the CODEC driver so I could move the
IRQ handling in there, it does seem a little odd to me, but I
guess I don't have any problems with it.

> > Is the objection here the table mapping the register fields that
> > are provided as an IRQ on the device?
> 
> I'm referring to this sort of construct:
> 
> +	CS42L43_IRQ_REG(HP_STARTUP_DONE,			MSM),
> +	CS42L43_IRQ_REG(HP_SHUTDOWN_DONE,			MSM),
> +	CS42L43_IRQ_REG(HSDET_DONE,				MSM),
> +	CS42L43_IRQ_REG(TIPSENSE_UNPLUG_DB,			MSM),
> +	CS42L43_IRQ_REG(TIPSENSE_PLUG_DB,			MSM),
> +	CS42L43_IRQ_REG(RINGSENSE_UNPLUG_DB,			MSM),
> +	CS42L43_IRQ_REG(RINGSENSE_PLUG_DB,			MSM),
> +	CS42L43_IRQ_REG(TIPSENSE_UNPLUG_PDET,			MSM),
> +	CS42L43_IRQ_REG(TIPSENSE_PLUG_PDET,			MSM),
> +	CS42L43_IRQ_REG(RINGSENSE_UNPLUG_PDET,			MSM),
> +	CS42L43_IRQ_REG(RINGSENSE_PLUG_PDET,			MSM),
> 
> Why isn't this described in firmware tables?

So we probably could do that for device tree systems, but getting
this into ACPI I think will be exceedingly difficult, and that is
likely the primary market for the device.

> Why doesn't it need to be
> carried as part of the driver? Is "CLASS_D_AMP" something an interrupt
> controller driver should care about?

Ah ok so I think I am starting to understand, if I might
paraphrase, your main objection here is that many of the IRQs are
fixed purpose signals originating inside the chip itself, rather
than external lines that can be hooked up for generic purposes.

I guess most "first class" IRQ controllers have a lot more
generic IRQs than they do fixed purpose ones. Where as we only
have the 3 GPIOs as generic purpose IRQ lines.

Thanks,
Charles
