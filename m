Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4636AFB70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCHApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:45:46 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBDDA8EB7;
        Tue,  7 Mar 2023 16:45:45 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d10so8700443pgt.12;
        Tue, 07 Mar 2023 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678236345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D0ax2sgEUzQvZjIaGlw0Pyd5UALWxKyMm5VBST2yrms=;
        b=S6zpXba3J9uT8dvc2HWZijtfHcp2L7rJl2Ast5TkGZ8YVO/H6ll3ykNJjFHJsXnqux
         ei6hh093Jk8HfmQwlRBUr7zzRDjo7T56wfbTsVrbwEpu55KtMBquJw7KWq8ZyLnNk2IN
         /Hz0Uh9ce7j7kIf9FpHj4n2rpx7xJ9fYs75zCggSHD9pORo5XLVatbqSYvLThpz9i33j
         +C2p5tIT3PGUOu7YHiNjtX6R0x8BCYDjSWowJvKqk8BP6Fd82fTSP69ESk2W8p3UNCpK
         5wJCySoPBNXgQpKgvLVxMGxPKBfNTgBgrNVJjC40b7MS43p/nbppitfdNEdFglU6i6K+
         +4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0ax2sgEUzQvZjIaGlw0Pyd5UALWxKyMm5VBST2yrms=;
        b=dh34AVw+fsZNPd2gXyi/i5spO3F9/9N8GxWk2Dy+mDUVhW1/U9PgAP24oxz9XOZH7m
         16rGNb/baphHqlesVXGWD+tyQ7ncyEdNTCL0fidyRu/fVgPZ9Vt816BshHCpX53uJNXD
         OkFS+xgXeiEXqD6wetJB4Z92+pb8qX3v5zEV8Vs3GcXTjY2BU2pI18mIFGxrdcvxhxvy
         eUlwdLxIUr2iQXxVn6kIP+SmKQ28BrbcB2gM67SouS83/rK7/hy0CM2JEOlHRiwARWl2
         P4rkCCt8VTqJANf2L/j8msPyu/mauPGMAnDwYKkR6+r9Cz4501jCp7hDYV+yjiQwqT4v
         t/gw==
X-Gm-Message-State: AO0yUKV5bbpdMja4Z/qcA5r5d9Bvp496XjOXQqAp84ZxVTu9qVc7vQ/I
        RX5lW1m8Dlf6uf4PEWvhec4D178pb2yceg==
X-Google-Smtp-Source: AK7set/rVZxSWwprvQ/WvKDRZWKKzRf3KDO7wMLtXsnaYD8WLoki0emzW55feMtlyajY9GwzZAtmPQ==
X-Received: by 2002:a62:1741:0:b0:5b9:49a5:5ddc with SMTP id 62-20020a621741000000b005b949a55ddcmr14301856pfx.3.1678236345021;
        Tue, 07 Mar 2023 16:45:45 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79259000000b005d866d184b5sm8345765pfp.46.2023.03.07.16.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:45:44 -0800 (PST)
Date:   Wed, 8 Mar 2023 08:45:37 +0800
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
Message-ID: <ZAfasb9aKTgyjbFc@Gentoo>
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
Maybe I should create a wrapper of mipi_dsi_dcs_write_seq() for sync dual dsi mode.
> 
> Other than that it seems like something that could also handle the Lenovo
> display, or the other way around, I don't know which driver is the best
> starting point, but this one has the right Novatek name at least.
> 
> Yours,
> Linus Walleij
