Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B276DB942
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDHHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHHHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:07:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFE1D515
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:07:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504718a2282so1100920a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680937660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXoFjgpD9Cwq3kIRxNGd8ecDEoW5EyNl4Aqp94FhPuY=;
        b=T3cs/IbldKyYw0jlOQBYubSsMBksZ/OsOf01EiSQRyLFouIQ/LDT6VDaWTlzucFVme
         RSog9LR8VZ4x519GvDIpPxMIeqdaNYkx/9wcSNiDms+hRFIxycfbb2vt/vJSRXP7GG8/
         bq5r5YGs8GbCitPKhjmMiXFm917Yv4Osfscaa5ScKJNuBPNjLtOIIgnEdyfIz8CLEiy9
         KcDOBHFXhvjTUzSF/hP7E8h2EGvBLHJJNFz9vXMbRbOV0UqwzixgBXrC2WlY+5hJIogd
         CIHCqETGiVSLF9EXN2q69VUcLduz0rrPXxn/vxw0FT5shCF0rvelG2pwLZdE/ZSCRqsw
         uPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680937660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXoFjgpD9Cwq3kIRxNGd8ecDEoW5EyNl4Aqp94FhPuY=;
        b=rYy6Y1otWUKuc5kQjMYAFB+2EafrayiFYtCiPLfkugiuaPrTChubLh32U6YbnVzNj/
         euscAuIoK60yKdFZGJSMD4ECB9gukCR4ScEVMdZdfGI2gqUp4MN9XznyVlfw6e4y0HGn
         3nE44xjBM78Mhp9MI/19ZeuvC/8/6IxtgJzc1zdf5yFDat2ASUS+Z6icbZ/Rpp64eX6u
         9/7Ym/vDQXTzJbkv3aCz7txgcwmusjtFrqFbLWVwKML9F5ohHbPI4QBivZMJiJ1ub5my
         VYeoaVsNr3m29Lg35eI0EdOQhJL5d47BVfLUZjgckPEYjUsz40sLIS6MR2oLvg0/lbj8
         VyZA==
X-Gm-Message-State: AAQBX9fZ8zq8LA40Piv8QU2g5CRudxT01kSF5nOL/LTI39H87+BPK9PI
        i9iFBUrUo5eV1HlHL/rpewM=
X-Google-Smtp-Source: AKy350ax5r2EKzYegd2xSOZGrwHN58yVwJQh5K3T49zBPaaDMonr78zO1J+MoRtd49ztjKFYPf0xuw==
X-Received: by 2002:a05:6402:b09:b0:501:cde5:4cc9 with SMTP id bm9-20020a0564020b0900b00501cde54cc9mr3621206edb.39.1680937659702;
        Sat, 08 Apr 2023 00:07:39 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id c90-20020a509fe3000000b005047d3c8700sm1285380edf.65.2023.04.08.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:07:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Roman Beranek <romanberanek@icloud.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from TCON0_DCLK_REG
Date:   Sat, 08 Apr 2023 09:07:37 +0200
Message-ID: <2219295.iZASKD2KPV@jernej-laptop>
In-Reply-To: <CROTQHUM88W0.2URPO95U5ZMS5@void.crly.cz>
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <20230329195802.veybo3367zifw77n@penduick>
 <CROTQHUM88W0.2URPO95U5ZMS5@void.crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 05. april 2023 ob 14:34:11 CEST je Roman Beranek napisal(a):
> Hello Maxime,
> 
> On Wed Mar 29, 2023 at 9:58 PM CEST, Maxime Ripard wrote:
> > > In order to preserve semantic correctness however, I propose to preface
> > > the change with a patch that renames sun4i_dotclock and tcon-pixel-clock
> > > such that dot/pixel is replaced with d/data. What do you think?
> > 
> > I don't think it's exposed to the userspace in any way so it makes sense
> > to me
> Here's a new series that includes those renames:
> <https://lore.kernel.org/all/20230331110245.43527-1-me@crly.cz/>
> 
> It turns out however that the new dclk rates can't be set exactly as
> requested without touching pll-video0*, tcon0 now therefore gets
> reparented from pll-mipi to pll-video0-2x which, as it further turns
> out, breaks DSI. While simply forbidding the video0-2x mux option seems
> to me as the right way to go because there's not much use for it with
> non-DSI interfaces either besides the opportunity to power pll-mipi
> down, I'd like to run by you first.

It's been a long time since I looked at A64 HDMI clocks, but IIRC, pll-video0 
is the only useful source for HDMI PHY (as opposed to HDMI controller.)
So question remains how to properly support both displays at the same time.

Have you ever tried to make HDMI and DSI work at the same time? This is one of 
issues of the PinePhone IIUC.


> 
> Kind regards,
> Roman
> 
> * As pll-mipi doesn't have CLK_SET_RATE_PARENT flag set, pll-video0
>   retains its boot-time rate of 294 MHz set by sunxi-dw-hdmi driver
>   in u-boot. Why 294 MHz (as opposed to the default rate of 297 MHz)?
>   The driver actually asks for 297 MHz, clock_set_pll3 rounds it to
>   294 MHz though because it limits itself to 6 MHz steps.

Yeah, we added CLK_SET_RATE_PARENT flag to several clocks after initial driver 
was merged. Adding this flag sounds completely reasonable.

Best regards,
Jernej


