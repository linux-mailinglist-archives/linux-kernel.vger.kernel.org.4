Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D463A6656F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbjAKJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbjAKJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:08:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF84B12ADA;
        Wed, 11 Jan 2023 01:05:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u19so35088054ejm.8;
        Wed, 11 Jan 2023 01:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJzxulyVKtTUohRS+QIHTGQPfrIKfOEeA/pyMeT2Lbs=;
        b=DY/rryyNK39lZK5j+YItCP3oSVCtzQjhwSqF3HO0q/oe6FH82woyqoU25NGEq8X/rq
         XfunZPk8zVRnmlZb1rmsjnBDg5s08a0KGuWotaJ5f6vET6cde5mvKMMV9h8NQajDgp9z
         q+BJKjsekiTpL6IdgDG3eRrjqad0G7vpdsKF1YG7tKoLjK5l4gWWTtnidGD2kbmEOi/B
         g41asBoarHpRy2wH6XGAwVVkOjhDsWE7+w0RsKUHtBA16Jnvcres+lUfXY916J9dSMY3
         VcHTXHb7MVJj79D1WOdqUy7MRbvGoMmym1q3KXcuaou0YlvumemC5qdqNztOhoC8Nq2T
         j2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJzxulyVKtTUohRS+QIHTGQPfrIKfOEeA/pyMeT2Lbs=;
        b=tvnqqMw6YyeZuXx9uTYk2wUDGPh1eSPVreL9H7PmyJvhZ0Gfo2XOTojh+IegGO4079
         NdA69ZySXcKXpK83AnKkN0iiNiQVT21idrldL9OjmMngGTVyL3dGnYdepe46spvCFKca
         Q46kH9kg1frtfjjU6hZSM08+v0fXRXVv8knjHtA6yFrsasm3vfiAnKVMM4GQCeuy8wLh
         0m/zeDXhEcUYt3tnUomWVH1anfdrsPJKhzzKUUodNiyIdihGhFkaPdZhDgD07sxW/6wp
         /x4hjk4rdQOqFb+9H9QFkZxBmxsevU4/7rfwI3taRagC33cLf45NP+SOSY5abDQCC0P6
         xBEg==
X-Gm-Message-State: AFqh2koNMSYHEGYrXkcpEK388f+LNMMQwogbatL7/1haoTxXr/sYU8iq
        wXHdkDYhsSuX+b3gTY5ZdeDWUPlvRQxqm1A/jRY=
X-Google-Smtp-Source: AMrXdXtXfmpdqGWNq6eUwbTgzMofXSFIKvUyk2JZof2j6k3abTmT7jfFV2CTFTewagAaJZluSZCQpXSdSy9YWMKWn8g=
X-Received: by 2002:a17:906:855:b0:7c1:5874:1d13 with SMTP id
 f21-20020a170906085500b007c158741d13mr4536440ejd.152.1673427929801; Wed, 11
 Jan 2023 01:05:29 -0800 (PST)
MIME-Version: 1.0
References: <MA0PR01MB7145CB5A2D487FB713CD7C01FFFC9@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA0PR01MB7145CB5A2D487FB713CD7C01FFFC9@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 11 Jan 2023 11:05:17 +0200
Message-ID: <CAEnQRZC2X5v6hh=-PRiaUgp3SZQYg1vot+4JKwEE6x5bzTKvwA@mail.gmail.com>
Subject: Re: [PATCH] Support for MAX98090/91 codec in iMX8MM evk
To:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "tommaso.merciai@amarulasolutions.com" 
        <tommaso.merciai@amarulasolutions.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "ryan.lee.analog@gmail.com" <ryan.lee.analog@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hardevsinh,

Does your imx8mm-evk have a max98090 codec? That's very strange
because I thought that EVK has wm8524?


On Wed, Jan 11, 2023 at 9:31 AM Hardevsinh Palaniya
<hardevsinh.palaniya@siliconsignals.io> wrote:
>
> From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Date: Sat, 7 Jan 2023 17:08:28 +0530
> Subject: [PATCH] Support for MAX98090/91 codec in iMX8MM evk
>
> - Adding node for MAX98090/91 in dts imx8mm-evk.dtsi
> - Adding tristate option in <sound/soc/codecs/Kconfig>

This should come as a separate patch.
