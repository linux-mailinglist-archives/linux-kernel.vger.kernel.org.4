Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B83700D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjELQoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbjELQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:43:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7F94C1F;
        Fri, 12 May 2023 09:43:55 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGhg8j002411;
        Fri, 12 May 2023 11:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=KHP+zGWNNyEYE5XHABG55hQK3WgV3doZaTwhtsR76zM=;
 b=Fyny9AMPJnQBeSmw7GKI8YAxgT4aRKeApQ/nFtPDj1eu3PYBhfHlZZHkIzGtqyFgD2cx
 SVR65Fz1Z5CwcMms6IIGGHyxsOT92q4qB9Xb/sngsD6VEpvb+yXRUrfS6rWMOJrQgWht
 la7mK6UC0sFzksXpPXu/+jigbnSCitkpPNAYQeLefwq36Y3NJQcVVxD43FQrver+74lE
 tUVOiURbOciTmuAiTgbnzto7tyJKOPUPI0PjYC+4VKRAFpQTsnjZYm9XwF62PaxIb+6k
 b97gupOvD88OX/mw6TGL022a48m/xbOT4gBKqcKrO55ZIoPQG/ouLjDO5FnD1Fcfd2wO Ag== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7nb5r4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:43:42 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 11:43:40 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 11:43:40 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 098AC45;
        Fri, 12 May 2023 16:43:40 +0000 (UTC)
Date:   Fri, 12 May 2023 16:43:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <20230512164340.GO68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-2-ckeepax@opensource.cirrus.com>
 <0471f085-14bf-c159-9b92-62983af6c19a@linux.intel.com>
 <20230512160224.GK68926@ediswmail.ad.cirrus.com>
 <5363c7b7-7a5b-490c-445b-fb7ccd693c63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5363c7b7-7a5b-490c-445b-fb7ccd693c63@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: CoZYeJn9JTKmEOtjTGiNl15yYAnAwqjj
X-Proofpoint-GUID: CoZYeJn9JTKmEOtjTGiNl15yYAnAwqjj
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

On Fri, May 12, 2023 at 11:34:44AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/12/23 11:02, Charles Keepax wrote:
> > On Fri, May 12, 2023 at 08:45:51AM -0500, Pierre-Louis Bossart wrote:
> >>> @@ -1711,6 +1739,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
> >>>  				struct device *dev = &slave->dev;
> >>>  				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> >>>  
> >>> +				if (slave->prop.use_domain_irq && slave->irq)
> >>> +					handle_nested_irq(slave->irq);
> >>> +
> >>
> >> I am a bit lost here, I can understand that alerts would be handled by a
> >> dedicated handler, but here the code continues and will call the
> >> existing interrupt_callback.
> >>
> >> Is this intentional? I wonder if there's a risk with two entities
> >> dealing with the same event and programming the same registers.
> >> Shouldn't there be some sort of 'either or' rule?
> >>
> > 
> > I guess there is a risk of them "handling" the IRQ twice,
> > although it is hard to see why you would write the driver that
> > way. Also since they are sequencial the second would I guess
> > just see that no IRQs are pending.
> > 
> > The intention for calling both is that it facilitates using
> > the same IRQ handler for I2C and SoundWire. At least on the
> > Cirrus devices there are a bunch of chip specific registers
> > that need treated exactly the same on I2C and SoundWire, but
> > then a couple of extra registers that need handled in the
> > SoundWire case. This way the handling of those can be kept
> > completely in the SoundWire part of the code and not ifdef-ed
> > into the main IRQ path.
> 
> Sounds good to me, but it's worth adding a comment and improving the
> commit message with design intent/rules since it's a common part in
> drivers/soundwire/

Yeah no issues with updating the commit message to explain that
in more detail.

Thanks,
Charles
