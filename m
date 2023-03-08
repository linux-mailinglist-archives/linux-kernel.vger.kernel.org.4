Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32F6AFB5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCHAiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCHAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:38:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B024AFDD;
        Tue,  7 Mar 2023 16:38:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p20so16057962plw.13;
        Tue, 07 Mar 2023 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678235855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SR/547FI3dqnvDn6OGe6fd1eQrMxuzZlhfxHSEijotM=;
        b=jSHi7HiOYmICS2einqkRKlS3BB6yDS8GWRRqvlKgJ83cDSAEFpchQlYT65HgZatLld
         xo5dCXUzEAaOlz8q+Z99Ky/55G4zU8SwJ6y2a1z+AusQZz2c23pDbbTsEuxo7dyonXQw
         6Y8Zk/7/WCynhK9sC+VZSDKTd8Nz+ruO6cred+KXkgv1VnoPvOLySw/kuSASgnos9UeZ
         jkJiGxUO8KDwyPEb3RiTFEBWDKnAWlAF1BbJqWcnc9T+iRIMTHRhOChF5oW9g2qV6ydD
         iKCLgt7VbgdmV1OwOOdr6lCYOUqLb5yO0Gj7NtOjm90Q5pLXDjnDyArhXihmY2AF4QFM
         DOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SR/547FI3dqnvDn6OGe6fd1eQrMxuzZlhfxHSEijotM=;
        b=vTxsRwVoAJ13AVIKf2rKSV9DVelO9qGZq7V/nGppZixvBnjjddgiXuL8YLnjdia397
         T8KvL3V96fbGG1R8hurp/GoZVRZ/YInsdn/cDY19r1eUe5WiW6dICDrIwTMS2PFeJtf8
         qDANKhP8fFhmBWQdUgo920haqv85wgLKxE9LzxPfRhELRsLyhkBRCz+A6D7hJoL3Wt8i
         D74OINixA2nA95rBijUv5E38/33RgBzhMML/MZMXpvA93C+f9tdYWJy4dLpdlMIBRRz8
         so+veP1Xi9i/fd6cF7CusW4LoO1DtRFyafbvMXu/6/WMwtixpBU/teWWPmdKRp5UvCOr
         H4cg==
X-Gm-Message-State: AO0yUKVzZdBmas0fggkHumBidYMZh/2u+BlLrir2l3d+WslHK05P0sKq
        F4fBYMs5qPzn1D52wbd2jmA=
X-Google-Smtp-Source: AK7set/se6v/Sndm89S1Z/vrVsycl4pwMfQjcUCTQghs6L4+WuIXgEpNbcCUDIjHdCHeCV/t/+JKLQ==
X-Received: by 2002:a17:90a:1946:b0:233:c9e7:c885 with SMTP id 6-20020a17090a194600b00233c9e7c885mr16960269pjh.36.1678235855549;
        Tue, 07 Mar 2023 16:37:35 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090aca9400b0023317104415sm9767834pjt.17.2023.03.07.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:37:35 -0800 (PST)
Date:   Wed, 8 Mar 2023 08:37:27 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Novatek NT36523
Message-ID: <ZAfYx9Im0j5LMuMn@Gentoo>
References: <20230220121258.10727-1-lujianhua000@gmail.com>
 <20230220121258.10727-2-lujianhua000@gmail.com>
 <CACRpkdbZCZiMM_qeqMd9=txVvPVHEzM4szOnPR-gCYdiXW_9eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbZCZiMM_qeqMd9=txVvPVHEzM4szOnPR-gCYdiXW_9eA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:34:55PM +0100, Linus Walleij wrote:
> Hi Jianhua,
> 
> thanks for your patch!
> 
> It appears Konrad is working on a very similar driver, so I suggest merging
> them into one Novatek NT36523 driver.
> 
> Possibly we can fix this up first and then add Konrads Lenovo-panel with
> a patch on top.
> 
> On Mon, Feb 20, 2023 at 1:13 PM Jianhua Lu <lujianhua000@gmail.com> wrote:
> 
> > Add a driver for panels using the Novatek NT36523 display driver IC.
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> 
> (...)
> 
> I like how you abstract the panel with init commands in the panel info.
> 
> > +enum dsi_cmd_type {
> > +       INIT_DCS_CMD,
> > +       DELAY_CMD,
> > +};
> > +
> > +struct panel_init_cmd {
> > +       enum dsi_cmd_type type;
> > +       size_t len;
> > +       const char *data;
> > +};
> > +
> > +#define _INIT_DCS_CMD(...) { \
> > +       .type = INIT_DCS_CMD, \
> > +       .len = sizeof((char[]){__VA_ARGS__}), \
> > +       .data = (char[]){__VA_ARGS__} }
> > +
> > +#define _INIT_DELAY_CMD(...) { \
> > +       .type = DELAY_CMD,\
> > +       .len = sizeof((char[]){__VA_ARGS__}), \
> > +       .data = (char[]){__VA_ARGS__} }
> 
> I have seen this type of reinvented wheels a few times now. Don't do this.
> 
> Look into other recently merged drivers and look how they do it, for example
> drivers/gpu/drm/panel/panel-himax-hx8394.c
> 
> For example:
> 
> - Use mipi_dsi_dcs_write_seq()
> 
> - If the delay is just used at one point in the sequence, do not invent
>   a command language like above for it, open code the delay instead
> 
> - Try to decode as much magic as possible, if you look in Konrads
>   driver you clearly see some standard MIPI commands, I bet you have
>   some too.
> 
> - Maybe use callbacks to send sequences instead of tables, like in
>   the himax driver?
I use init cmd tables in order to send init sequences to dsi0 and dsi1 at the
same time (sync dual dsi mode). I don't found a convenient way to use
mipi_dsi_dcs_write_seq() for sync dual dsi mode.
> 
> Other than that it seems like something that could also handle the Lenovo
> display, or the other way around, I don't know which driver is the best
> starting point, but this one has the right Novatek name at least.
> 
> Yours,
> Linus Walleij
