Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C6613D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJaSXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJaSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:23:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70B120B7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:23:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so31575511eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4rZhUH4ZpLMhBAqpfgdI9c7u8+KCLFpVpEFUicGMn4=;
        b=GgM4/QujTRQ05JzoJoxOXsdk7HHVGSupVn0YESMwsNLFruqKu9FeueaBfHbCvR1X9W
         /oKRptwJv97/KvG1CQqMuiJeDajS/M6d2xqOH5eEnH7o4jSh7hsRGIFN94u3DtCBQ5H0
         Bn1t0aM7ftW30HmemMZ3Zj8M4eIZ8zFwdMdew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4rZhUH4ZpLMhBAqpfgdI9c7u8+KCLFpVpEFUicGMn4=;
        b=s9/tQ1BvUlceRPWnbuaONK7np1GFetOYN2UuNFN9EyrJwy9gPY0ebHBv1IUTDNcSDK
         Aeo2EQWimT+t9m2U68NpoletJc5+xDs5yNDbwT4LgF2vMeunU/FlutJyLracLJQhw0xp
         MuABGVosUFhAbHeJdNTu0MY5D7XVzPWOHc45GFIwDgl0htKU8w+n2M4gn9I57DFWE/KM
         Vt8Uojp0DNOQ+pG1BdXiPRZSu+f9rxoQUWirS/jk/c/af90tcOmeTxBhqFBe3OrzTVhD
         wnPYepmXi377mGJuq9JVPILQw3FV34ebTiS8yeXi/YJSSo4QBcSxXJD+uSuqDSGvVtny
         s3EA==
X-Gm-Message-State: ACrzQf1/MuP5QBT4iGSlDZG3s4W52DxnH4fm+fIUxNTxk3+mw0utbIym
        1LWoMi86DhQDq5vEsUgOoefKNjZbYva/jsQYWjbudg==
X-Google-Smtp-Source: AMsMyM5DhoL8s28zzkeeLevlXOzn1Jye7+9SjSZzpbIqMEEJLmIGHYQyoMVmaWUIpW5aaCIrKN/r2n1OP2A/3CGeDSA=
X-Received: by 2002:a17:907:86a4:b0:7ab:afe4:5a94 with SMTP id
 qa36-20020a17090786a400b007abafe45a94mr14305688ejc.7.1667240586730; Mon, 31
 Oct 2022 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221027135711.24425-1-marcan@marcan.st> <CAFxkdAqjdonoEgOm4Nv-mbyw3OJuuO1=3dXYyn2+yszUp13Bbg@mail.gmail.com>
 <8cd3c731-5501-8bfb-9432-b1b9554aeb23@marcan.st>
In-Reply-To: <8cd3c731-5501-8bfb-9432-b1b9554aeb23@marcan.st>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 31 Oct 2022 13:22:55 -0500
Message-ID: <CAFxkdArt_C82q1OXtCS=b_+Rn2cw7QkZp8bg-DwPD-dbBdRAaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/format-helper: Only advertise supported formats
 for conversion
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:52 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 01/11/2022 01.15, Justin Forbes wrote:
> > On Thu, Oct 27, 2022 at 8:57 AM Hector Martin <marcan@marcan.st> wrote:
> >>
> >> drm_fb_build_fourcc_list() currently returns all emulated formats
> >> unconditionally as long as the native format is among them, even though
> >> not all combinations have conversion helpers. Although the list is
> >> arguably provided to userspace in precedence order, userspace can pick
> >> something out-of-order (and thus break when it shouldn't), or simply
> >> only support a format that is unsupported (and thus think it can work,
> >> which results in the appearance of a hang as FB blits fail later on,
> >> instead of the initialization error you'd expect in this case).
> >>
> >> Add checks to filter the list of emulated formats to only those
> >> supported for conversion to the native format. This presumes that there
> >> is a single native format (only the first is checked, if there are
> >> multiple). Refactoring this API to drop the native list or support it
> >> properly (by returning the appropriate emulated->native mapping table)
> >> is left for a future patch.
> >>
> >> The simpledrm driver is left as-is with a full table of emulated
> >> formats. This keeps all currently working conversions available and
> >> drops all the broken ones (i.e. this a strict bugfix patch, adding no
> >> new supported formats nor removing any actually working ones). In order
> >> to avoid proliferation of emulated formats, future drivers should
> >> advertise only XRGB8888 as the sole emulated format (since some
> >> userspace assumes its presence).
> >>
> >> This fixes a real user regression where the ?RGB2101010 support commit
> >> started advertising it unconditionally where not supported, and KWin
> >> decided to start to use it over the native format and broke, but also
> >> the fixes the spurious RGB565/RGB888 formats which have been wrongly
> >> unconditionally advertised since the dawn of simpledrm.
> >>
> >> Fixes: 6ea966fca084 ("drm/simpledrm: Add [AX]RGB210101
> >
> >
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >
> > There is a CC for stable on here, but this patch does not apply in any
> > way on 6.0 or older kernels as the fourcc bits and considerable churn
> > came in with the 6.1 merge window.  You don't happen to have a
> > backport of this to 6.0 do you?
>
> v1 is probably closer to such a backport, and I offered to figure it out
> on Matrix but I heard you're already working on it ;)

i am, but I didn't want to be, so I thought I would ask.

Justin
