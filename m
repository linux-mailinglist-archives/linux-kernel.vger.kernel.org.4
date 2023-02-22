Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D969F55C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjBVN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBVN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:28:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27391BB;
        Wed, 22 Feb 2023 05:28:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k14-20020a05600c1c8e00b003e22107b7ccso1160349wms.0;
        Wed, 22 Feb 2023 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRqorO2vW/DufntBHkr33Jk+mJdL3BUMcZ2IPymDsYQ=;
        b=UZGYmUBk9dzhFyTJ1mKIzeCgtz3H8PPlnNWpL6GNgTh+WCEVQIs6MyBhpYapgTzHzb
         LmnkbOn6oPezl1KawOa5hQqnXZPTWd9lxLUIoEknDT8ydTZz3AyYJkgMiJBbMDPu2RZ2
         vziscPHbZEtDqKiksO4g1bjQmu9l8XMfeQ/sH5ZipD1bBiCtXVTLa+oZ+QYrq/qjNLo0
         GoqdbW+iAFseShtisMEEYCaPCBbJ/9R6ahQlFNMd33yvu2xqRA7sqtiaLIQobfy26yr6
         uxOFMQxxpi2HrxkuiwwQftRpannj5OABrzbwOjUHXHXOFFalmKb6XYjTTG7WYewLnR48
         FRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRqorO2vW/DufntBHkr33Jk+mJdL3BUMcZ2IPymDsYQ=;
        b=NZouR2xuEwjgQEeWd9OLPjuSnVK3wIGPeL/qI/s5zuC8x6rdC4eIffLFYMztBnwayd
         DRXiyA4DST+Cz12yC7ZX0QHuY9UbxOS2v8Lm14QraN5G+mTQU84XZBqZ3UOa8OzP+rrj
         8WMJboKnlliSvpEclhP09HR/S2RfYwaBBgL4sRCfVqnwWdE+cl+Q8O91n6F7uxojXGty
         LCsRsahQTBZ7fmJNQFC5nkPj9YutZBr9Uy/RpvEsSte2pXwdYOHUHBdsBcC7NkJfetJw
         D1wfESFpZTM43SZGY4TAAWnhAzdvHRUzSvSNgCkVLU/LEy95uFy36SPuimLHwAkRao9P
         yf6Q==
X-Gm-Message-State: AO0yUKXBWOTbiIpM9vvPIw/5JcXs3t3GbsUDsQPsjJe1rlni0zT5Wbv7
        s+FcfjpQW43F2+1oynRgJ/o=
X-Google-Smtp-Source: AK7set+1T7UXYTMG+b5hEaUsQLKpOa7X0ZCsLXXfMprUIO7Z2kOeVL2AXaWm/ZKLRpGhcUYrnXFSlA==
X-Received: by 2002:a05:600c:4493:b0:3e1:97d:612e with SMTP id e19-20020a05600c449300b003e1097d612emr318020wmo.29.1677072497017;
        Wed, 22 Feb 2023 05:28:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003e9ded91c27sm1370wmq.4.2023.02.22.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:28:16 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:28:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
Message-ID: <Y/YYaVhE7WwqLIey@kadam>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-5-clamor95@gmail.com>
 <Y/UcXNueAmrrhWG0@kadam>
 <CAPVz0n01YWQ6FY9RDsa1rw_36n=NKpRLokFiVTxLsMDpQEd4YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n01YWQ6FY9RDsa1rw_36n=NKpRLokFiVTxLsMDpQEd4YA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:55:52AM +0200, Svyatoslav Ryhel wrote:
> вт, 21 лют. 2023 р. о 21:32 Dan Carpenter <error27@gmail.com> пише:
> >
> > On Tue, Feb 21, 2023 at 08:32:05PM +0200, Svyatoslav Ryhel wrote:
> > > diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
> > > index 78faa8bcae27..607800ec07a6 100644
> > > --- a/sound/soc/tegra/tegra_asoc_machine.c
> > > +++ b/sound/soc/tegra/tegra_asoc_machine.c
> > > @@ -51,6 +51,17 @@ static struct snd_soc_jack_gpio tegra_machine_headset_jack_gpio = {
> > >  };
> > >
> > >  /* Mic Jack */
> >
> > This comment doesn't make sense now.  It was never super useful, though.
> > Just delete it.
> 
> It does. Headset is Mic Jack + Headphones combined. headset_check function
> performs check for a Mic Jack component in plugged Jack 3.5
> 

I feel if we need to discuess what a comment means or if it even means
anything then that's a useless comment by definition.

regards,
dan carpenter

