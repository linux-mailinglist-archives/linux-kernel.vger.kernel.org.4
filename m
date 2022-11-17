Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22FF62E2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiKQR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:26:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9AC4C252
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:25:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f27so6860723eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7rh9znBXsFKpv/JRJo88opLzz4QQKJoh7e7ZIix0R5c=;
        b=mojJmptnETuCrRADBiymgqt9Ztwx8PnEPoJX0GAXmR6QOws+o5duVYpswPjZ2Rczqk
         6EblxUIk7HUZ41mzG3+saD5VFiZDnoRbemfg6pXTdvYRLAIn3AeIbULlCYXEupOZZdH6
         Si94ZrcsmFk5y0xQe/OTfyEE30OCO9fS9Z7ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rh9znBXsFKpv/JRJo88opLzz4QQKJoh7e7ZIix0R5c=;
        b=kxB+57glVun9WOIyDNfO2b/mAjo2qA/D75/7gYo2XAahcLIfK1lhRWD6vFe4/9sh9K
         ttuJ7p01YC+47/aPYEYD6AooIlKEGaGIQAHdcQ9tEpGH90RJDeGWC9esDkyAsu+tpzzr
         RMVhYzuZ6c4Y+dgBEWDsTb2juu70SwaGrmPB/5DTLP1Ilxj3/0IIkygu1oPC9MfSC6DD
         6gxdccR5iuluKkyV8aBh2Kse1E9O0nj2NNJwUgwJPg9mh8HA7/MgxTrMBGzfDFcoOdrM
         0ha5hoPsqkQ5yvhsQysjZBZeo7vWdwVFMcw//DX6MmjG2EE/NPMrxGm0TXryeY/E++kx
         QwfA==
X-Gm-Message-State: ANoB5pnG2aT2ndc4sfX2S/XzBX8GcKzLCL4BpwVCKKCqWnjrkn7TYAEU
        8WnLfEIWn18YK8K8VsGFKBxp5F6EAlglphfl
X-Google-Smtp-Source: AA0mqf7zMG4uyZTWpNf2KynbkW6tGB/X95NXQUgVEg6R1WsV5UPPw6I6/XVqF1WnZ3g2uBylzm70Ug==
X-Received: by 2002:a17:906:455:b0:7ad:b97e:283a with SMTP id e21-20020a170906045500b007adb97e283amr2882949eja.567.1668705958135;
        Thu, 17 Nov 2022 09:25:58 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0074134543f82sm627775ejf.90.2022.11.17.09.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 09:25:57 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id y16so4940109wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:25:57 -0800 (PST)
X-Received: by 2002:adf:cd82:0:b0:238:b29e:4919 with SMTP id
 q2-20020adfcd82000000b00238b29e4919mr2112282wrj.583.1668705956712; Thu, 17
 Nov 2022 09:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20221117110804.1431024-1-hsinyi@chromium.org> <CAD=FV=VEC=GzkDfaOqauBB5Y79teS1ENA5wFUHZmnTRkg6Z4tg@mail.gmail.com>
 <CAJMQK-gQj83N1MBu1s+_YDJ4qbqN4McSqCnOwWAq4iaNXo5Sfg@mail.gmail.com>
In-Reply-To: <CAJMQK-gQj83N1MBu1s+_YDJ4qbqN4McSqCnOwWAq4iaNXo5Sfg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 09:25:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VoF5PyeNWX+4_3sseyRemZVsr5WtQVeg-8mhfgm40w3g@mail.gmail.com>
Message-ID: <CAD=FV=VoF5PyeNWX+4_3sseyRemZVsr5WtQVeg-8mhfgm40w3g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm_bridge: register content protect property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 9:12 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, Nov 17, 2022 at 11:57 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Nov 17, 2022 at 3:08 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Some bridges are able to update HDCP status from userspace request if
> > > they support HDCP.
> > >
> > > HDCP property is the same as other connector properties that needs to be
> > > created after the connecter is initialized and before the connector is
> > > registered.
> > >
> > > If there exists a bridge that supports HDCP, add the property to the
> > > bridge connector.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Not sure it's worth spinning for, but FWIW I wouldn't put
> > "Reported-by: kernel test robot <lkp@intel.com>". The emails from that
> > bot are always a bit confusing in this regards, but I think they mean
> > "if the patch has already landed and you're sending a separate patch
> > with a fix then please add the "Reported-by" tag". ...but adding it to
> > the original patch just doesn't make a lot of sense.
>
> Got it, thanks. I think I'll wait for a while to see if there's other
> comments. Otherwise should I send another version to remove the tag?

I don't think it's necessary. Someone could just remove it when they
land the patch.

Speaking of which, I'm OK with landing the first two patches with
Sean's Reviewed-by, but ideally we'd get a non-Google review from
someone that maintains the bridge stuff on the patches. That being
said, in another email thread [1] it was pointed out that the bridge
subsystem is mainly under maintained. When I got committer access for
drm-misc access I was told in IRC that part of my job would be to deal
with landing ChromeOS-related stuff assuming it was properly reviewed.

I'm about to head on vacation for ~1 week and don't want to land and
run, so how about this? Let's see if you can get Sean to review the
3rd patch in the series. If he's happy with it and things aren't on
fire when I get back, I'll send another email to the list saying that
I'll give that patch another ~1 week on the list and then land it if
there are no objections. This way folks will have plenty of warning if
they want to review the series, but if not then it won't sit waiting
forever. Assuming everything with v6 still looks good and there is no
other reason to spin, I'm happy removing the extra Reported-by tag
when I land.

[1] https://lore.kernel.org/r/20221117143411.5sdyrx6v2nunql5n@houat
