Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633265B7AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjABWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjABWg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:36:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C995AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:36:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z10so27574691wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JcpeTvadU5Tog/xue6k6ZJ3yGd7vrQ+zBzOEtD1ges=;
        b=WoN0jqoZxWZ+sX/jIpoVGzAct/1iHN+DeD+qkRj2voaxz+pVnwcqdA1Ip2eEQdcc/9
         k0ZPPjHOxOW08O1FLJEkTUyW39Ou6Hwn2gFrJmpTq1kC3aYx3kbHljvG5KBXspaQqPbE
         jKnX3i5d1HSeHh5uuCGExXBY2BXNmu+k6Pat7DXaE93G+6k8OAkFwfkwtN9X9kvK7MtL
         02iM3OiyUC7KFKO47nkyNEY7spz2ZrC3WAce++UgRb29jFaAPgw/FYyqaiGIxRH8LCWU
         Lr/sebaT64Rsv73FNemcKwLHi/BpcwtZdngL0wkxL+SZMapUxuj9IGdtGWDinYfJgU4W
         5EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JcpeTvadU5Tog/xue6k6ZJ3yGd7vrQ+zBzOEtD1ges=;
        b=V9qNDK5x2aXH2brszicPjL91+fWzh0Ty0ublIYKlG+Gt1UoMgqTXRCJq1mOZUohIvc
         N8I41hJH529pMrM6EuhgeD6Ypj8d0SiC4H4YK9TB2jXRQf8rb5s3THKphG4pBwj371ft
         JK8W7/6r6JKTen7mn1ml935xCu6t3PfXz7jzmQtkPWqey/tDRic+uA//am2DWQbsFx6z
         xZ3CVGfCuSF0jhk9OBs5dPJoVVM1VLIxXJX7IT1V2woiJLIxQQ4ymh+vdZN0c9k0DZdI
         TnHwqSkkvk0hlgA86oJKhZjnxNMs7uIPTgb++3mBZLMDKoqPgpjOhDpk2memmzSBCKGJ
         QVFA==
X-Gm-Message-State: AFqh2kpBGoNOsOxaBefQYmQbIu/ccvlikYoxJAUoVcGOILi0Hr+XxSH9
        Z5J7VESTnyjk9urc714ZlyPxww==
X-Google-Smtp-Source: AMrXdXuMKb9aoopqhrEI1EsTNuvk91/H8xLxImT0dmvAd0Klcy6YKtl4ERaUDY+mykgVwV602Ncbow==
X-Received: by 2002:a5d:4403:0:b0:268:f9de:d551 with SMTP id z3-20020a5d4403000000b00268f9ded551mr27160473wrq.40.1672699013173;
        Mon, 02 Jan 2023 14:36:53 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o5-20020adfe805000000b0028cc9d2ec1csm15340814wrm.54.2023.01.02.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:36:52 -0800 (PST)
Date:   Tue, 3 Jan 2023 00:36:51 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Message-ID: <Y7Ncg9DMbHBagcoz@linaro.org>
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
 <Y7KUFMjnra22YGlv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7KUFMjnra22YGlv@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-02 09:21:40, Johan Hovold wrote:
> On Sun, Jan 01, 2023 at 10:58:42PM -0600, Steev Klimaszewski wrote:
> > On Sat, Dec 31, 2022 at 8:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > The actual name is R133NW4K-R0.
> > >
> > > Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >
> > > Assuming the information from here is correct:
> > > https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
> > >
> > >  drivers/gpu/drm/panel/panel-edp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > > index 5cb8dc2ebe18..ef70928c3ccb 100644
> > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > @@ -1891,7 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
> > >         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
> > >
> > >         EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
> > > -       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
> > > +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
> > >
> > >         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
> > >         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
> > > --
> > > 2.34.1
> > >
> > 
> > Thanks for this - when I was looking for the panel, I simply went with
> > what I found on panel-look.
> 
> Did you check what string your panel reports? For example, using
> something like:
> 
> 	# strings /sys/class/drm/card0-eDP-1/edid
> 	...
> 	B133UAN02.1

Mine shows: M133NW4J R3

But since both R0 and R3 have the same product ID, I decided to drop the
revision part, otherwise we would need to add a second entry with the
only difference between them being the revision part (Rx). This is what
I did in patch #2.

> 
> Johan
