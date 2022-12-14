Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC164CB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiLNNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLNNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:32:00 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0946360
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:31:59 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEAosHJ030155;
        Wed, 14 Dec 2022 07:31:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0ZmkgIHHH2z0Z3N58VJyuMPU40yJoMjSH3qtapRnbuE=;
 b=Z/8I6l8EL/lnWOsYK5CeeicPmqPN5go0y339LUCcw8HrJ6+Ka5Rjt0UXENYdilkwsAkG
 8+VUYXqOl7k/rsn24/SL6CqwIfWEhxG81w/cdFvB26fkj1Zv+S7Kp/X5kyEQ8529qVLe
 Ce615jIL9q5q2W6mMdrh3Cc8HKigIXI5l4x0+/It+cgdyDxF0j/w70ozNYfXqz1y5AAa
 UuIRpoNIDYay9MTPUW7u0InZ3b59hBkUjLKeDYK7hcukJxc11E7OQsXyRa0D6qsvAF5Y
 Et0uAUBNCk8yjsLFE9NMKQH0UQcvt8PkamwPwo1Tlg0UvrPKnt1BnO8dlvmY8Jybyh1k Cw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3mf6rh8e69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 07:31:37 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 14 Dec
 2022 07:31:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 14 Dec 2022 07:31:36 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3153E458;
        Wed, 14 Dec 2022 13:31:36 +0000 (UTC)
Date:   Wed, 14 Dec 2022 13:31:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lukasz Majewski <lukma@denx.de>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <20221214133136.GQ105268@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221214123743.3713843-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221214123743.3713843-3-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: ciLYuOB-zJb_vroAegOl3Jla7YXlKn3d
X-Proofpoint-GUID: ciLYuOB-zJb_vroAegOl3Jla7YXlKn3d
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:37:41PM +0100, Lukasz Majewski wrote:
> Without this change, the wm8940 driver is not working when
> set_sysclk callback (wm8940_set_dai_sysclk) is called with
> frequency not listed in the switch clause.
> 
> This change adjusts this driver to allow non-standard frequency
> set (just after the boot) being adjusted afterwards by the sound
> system core code.
> 
> Moreover, support for internal wm8940's PLL is provided, so it
> can generate clocks when HOST system is not able to do it.
> 
> Code in this commit is based on previous change done for wm8974
> (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  	struct snd_soc_component *component = dai->component;
> +	struct wm8940_priv *priv = snd_soc_component_get_drvdata(component);
>  	u16 iface = snd_soc_component_read(component, WM8940_IFACE) & 0xFD9F;
>  	u16 addcntrl = snd_soc_component_read(component, WM8940_ADDCNTRL) & 0xFFF1;
>  	u16 companding =  snd_soc_component_read(component,
>  						WM8940_COMPANDINGCTL) & 0xFFDF;
>  	int ret;
>  
> +	priv->fs = params_rate(params);
> +	ret = wm8940_update_clocks(dai);
> +	if (ret)
> +		return ret;
> +

I think this all looks mostly good, my only slight concern would
be the interaction with the manual functions for settings the PLL
etc. I guess under this code, whatever manual settings were
configured will be overwritten with the new auto settings, I
think this should be fine as the PLL wants to be run in a pretty
narrow band anyway, so the settings are likely identical. Do you
have any thoughts?

Thanks,
Charles
