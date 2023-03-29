Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2BD6CED32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjC2PnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjC2PnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:43:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BA2720;
        Wed, 29 Mar 2023 08:43:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7so14413814pjg.5;
        Wed, 29 Mar 2023 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es16+5r67lDTkeZGkNgX2L6ri/WdoWiVAuB5GMI9+FU=;
        b=WpVQV2vBGC83MtKhnNev0kg80aWJ+jx48URZIlEqdDz2+oA7SNOuueBtYuSR/jjHSe
         5Uk4941khc9MHuFmcxe2eHpRiD3TFRuAqjP8jpnYXUQAld5Ei+zLQaO89wkOn1/7GiKU
         Dsf/HZykv9WD/JmggFTpVjI+h4Nl+r9AoHfn4lpCBiZ7ZTBMLg2YnbUl0I3n0BVeWBqD
         O3tkytSP5BU7R/l+itbMtNDePZpjgHl7Ym3qGIHyTkDU+/0t9ebor29yS6WY3lczWYao
         5Plee9CanuY5Uzg4dXNZWFnpqUBLAC5rG/X9/MFlQb2j1bPohONJPYSH+fW4BtOr5vKT
         ukEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es16+5r67lDTkeZGkNgX2L6ri/WdoWiVAuB5GMI9+FU=;
        b=qZU8GzCcKgwlNTTxFpXYmHTogeyeXtshV/d8hANyJZRcAthhPS07RkjUWVWTdrEmMK
         XjYzBIrqkJf68G4BzqMCJzTIG27r7VRdtxIQoJp0J8nRcYCmILBQ2wg9aDvDkZtKyKPO
         SIP1DqfsCwqagJeo3Z0zzMmYs81HlJEIL4542vmLe4qkTtrNQvhxxUvTIk3llttMcc4C
         EM87iYjMbElW7mPQQnedLCtcV8p+/0+5cZfYd787OXdgYgbhL4s9eT1u/4EFt9PY3J7+
         260tv/GVqXhfL19Og3MXW/Cb8f7MM38suJDZdlCXzHpPY+Rh+2ROTr6+hEydE0ZDoOe/
         ER9g==
X-Gm-Message-State: AAQBX9ciX29PdAHODSNnDrzVCKuWu7s0VT7RCJFf2oZV5DS5UZROWvFA
        mCjem0W5v1DcEhgZqJbpLvc=
X-Google-Smtp-Source: AKy350ZXDVdlAQT1MlVwLZOXdf2CwL8TWro1D/n5/ekFA4WdAGgoXvpltfTLuXro/ft7/M7dcNfC7Q==
X-Received: by 2002:a17:902:da8e:b0:19c:c9d0:5bf8 with SMTP id j14-20020a170902da8e00b0019cc9d05bf8mr25108787plx.35.1680104598021;
        Wed, 29 Mar 2023 08:43:18 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b0019a997bca5csm23106033plb.121.2023.03.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:43:17 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:43:10 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Message-ID: <ZCRcjgMWhV0dp8p0@Gentoo>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
 <57c5a3b3-00cd-5b44-02f4-dedabacc7662@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c5a3b3-00cd-5b44-02f4-dedabacc7662@opensource.cirrus.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:33:08PM +0100, Richard Fitzgerald wrote:
> On 29/3/23 14:05, Jianhua Lu wrote:
> > For platform using fdt, system_name is NULL, it doesn't provide
> > a way to load firmware with prefix name, so add it.
> 
> This is intended behavior.
> 
> To load per-amp tuning you must know the function of each amp.
> You only know that if you know what hardware platform you are running
> on.
> 
> So if system_name is NULL it should fall back to generic firmware.
Make sense
