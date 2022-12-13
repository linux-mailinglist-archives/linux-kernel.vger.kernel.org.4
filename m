Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F164B18D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiLMIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiLMIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:51:46 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A765A1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:51:45 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i186so16783171ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJvRbaiPchBmTkfubLEGTz0Ogu9fRyx82WgeZC745Dk=;
        b=ZpHfmBlgH+6RvPy+iw040Q1a/x2t0YWMLcJwMQD3S8cZdwC/xYa+V6HyUN7KGXpi+2
         36YMqlrgVPV1zrkc93/2NZakTM4vx/ImER9F352ObvZeibsGV4teZQxkE/fo1tzifH9e
         Yc2iHtdCSEqVWV1GeUjQ5uYzbstfwfUdnZXjPfJSSPTlkYFKUVLJ0MmJ9wt8P7L4gquG
         CBDrtjx+mNywlWR3ftbIetLyixDXPymvK9WF3eIHs7dzj5woK+oEmTy20MbcNQEwsJ8X
         ZgsHwnJ3uWSNL5sHsL2Tn1Xku2LecpnHCqdZA5A43kZa+PgJWfiH4yZvot9cU+yLMVo0
         j8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJvRbaiPchBmTkfubLEGTz0Ogu9fRyx82WgeZC745Dk=;
        b=elYyOoKsQ9Ye4d/HJyk26KWudbl6LpEbvjSFlGLjxZ6FCYXpfe4I/vlH19gVX9IkT+
         PRlTirMEg+UJXYTKYmRKz+w30CTSJP/Ktn3QyZB+HYDnTm1PeZyYkTgeI1fIN8tDVqjG
         U27oET0JOohQli7xAUNFX1nVrAOgr/9qO3hn2R787lX8CqT9ZmoFDM3Cx0qWoRgrFZmV
         ount2nAZJJQornEwd/aFgOd6jKCbPSjccb3cGnltbW7D3l18zqfMvtvMATflIosmqRqv
         gKDRrarn3/vj8xCgnyqM5dbcy08RQ8CPbCJmB2GdbjdqmW5ttqy1FelN/U0TsboOeeZp
         zv0g==
X-Gm-Message-State: ANoB5plfjCaSPRNY4Nif1BbS8pLRVmuxMGWLU93OJpiyRuCOZPySo2Oj
        oqwDVF83GYYZycx27uvexXQR2tL+MWLiOIFLu53GHg==
X-Google-Smtp-Source: AA0mqf4FpckKPAuWRQQ8f1huRLbn/zDOCLdbrA1eKTP4TVYP5K7QRu9Fo8bs6ostcX0AVXjxTtAkgaXDGmofby9tx84=
X-Received: by 2002:a25:d2ce:0:b0:710:f2e2:eb92 with SMTP id
 j197-20020a25d2ce000000b00710f2e2eb92mr2938674ybg.304.1670921504954; Tue, 13
 Dec 2022 00:51:44 -0800 (PST)
MIME-Version: 1.0
References: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
In-Reply-To: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Dec 2022 09:51:33 +0100
Message-ID: <CACRpkdaXxPE3XhPnprhJ7GGjn9X_GMsCJ3mn26P90GcHzhsQDg@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 7:01 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:

> I do not read a strict requirement on /chosen node in either ePAPR or in
> Documentation/devicetree. Help text for CONFIG_CMDLINE and
> CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependent on
> the presence of /chosen or the presense of /chosen/bootargs.
>
> However the early check for /chosen and bailing out in
> early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is not
> really related to /chosen node or the particular method of passing cmdline
> from bootloader.
>
> This leads to counterintuitive combinations (assuming
> CONFIG_CMDLINE_EXTEND=y):
>
> a) bootargs="foo", CONFIG_CMDLINE="bar" => cmdline=="foo bar"
> b) /chosen missing, CONFIG_CMDLINE="bar" => cmdline==""
> c) bootargs="", CONFIG_CMDLINE="bar" => cmdline==" bar"
>
> Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() so that
> cases b and c above result in the same cmdline.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Excellent debugging Alexander!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I also think this should go to stable.

Yours,
Linus Walleij
