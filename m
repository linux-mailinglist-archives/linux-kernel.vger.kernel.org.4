Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6166235D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbjAIKmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjAIKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:41:14 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE718686
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:32:53 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id s127so8091559vsb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG1EBP5y9ccRxvLO1fx1xbReFeFjuMxeUoDDtyCUWMA=;
        b=efGLwc3OAfzNE2E1Nz97beiexHdD/S486shc0iAWBhaaQ84dyyLYAJQxX8x94mhJ5m
         EUE7fLQ8Pce0SYXuGrfMDkei9O7PV+O3q0BwQDy7xxo7yYvMUakcrhd/Hui9VolcfJbA
         UNjqw6Q86j+Nl6A6ZPxln3MA6ejGdBR6TSg6wPZ+q44u+Q5WaSMej+bsDcCyrn/tslId
         MKFEgQLi0mBfCh0CPAyU1Gt3iUr0bDdfP0jyh3t/VG1RdkPigGoRPCwr5yKC7QmQZB+P
         d20lJ66lS0potRePakGv+HP55XFZaSyarSD7XI1sKPoUUDKkG8PiUZAv7GZ+HUPBPoDG
         qB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG1EBP5y9ccRxvLO1fx1xbReFeFjuMxeUoDDtyCUWMA=;
        b=Q0xUoSaBJCqDjgP4PBulwzzzgxfGlm0uC+atPa/yqQ/0oBQrEHH/DHALBPyBgZbgxO
         d8WyFAuKlLgyKRegY1Ck5hbCfcKRxJ0yk60GHFe//Arnz3K8FeuxvAVtBJYEK0BFB6Sa
         OQxH40GmIyTGHtMuV4ri32+GUr8XSuEqkMQ2SjR9s65S+BW03an1OytSa2r7PNCLZkds
         rtGTYK6obH0xQzeiWJo5OlEnyrN3QEh5KmrmPz+YaurnuZsmTbpoCHckPNkzsjd32pSo
         ZeHuWUmJl1eADwcmR7ek1sFqqv/9OooSKPrLN6Ao0WAJesePS7B1You0heqD7yaT8Vdn
         wdoA==
X-Gm-Message-State: AFqh2kqXRWelE6MxG0+n21hOrlk8c6FYiQGJUfP2dW2qVQlrN/sBgjx+
        aDfjPb/749IJq4lcv/xZoyTwN1V76qJ4XuCBNUXdgw==
X-Google-Smtp-Source: AMrXdXsJOVB10ql2VCnWdFa4hlkIU+1tI0ArpGkJtnno2x2SvStjRUyMtY8zRp/9COAk1Bnnxnb6YDHvZPoTSdbYJyg=
X-Received: by 2002:a05:6102:3108:b0:3c8:e71a:61ff with SMTP id
 e8-20020a056102310800b003c8e71a61ffmr7691861vsh.23.1673260373013; Mon, 09 Jan
 2023 02:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20221207-rpi-hvs-crtc-misc-v1-0-1f8e0770798b@cerno.tech> <20221207-rpi-hvs-crtc-misc-v1-8-1f8e0770798b@cerno.tech>
In-Reply-To: <20221207-rpi-hvs-crtc-misc-v1-8-1f8e0770798b@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 9 Jan 2023 10:32:37 +0000
Message-ID: <CAPY8ntDmSKB-u2FNALeGgh2bZwxDfPXGnP1kV4LnGT_NrZ-4Wg@mail.gmail.com>
Subject: Re: [PATCH 08/15] drm/vc4: hvs: Ignore atomic_flush if we're disabled
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 7 Dec 2022 at 11:55, Maxime Ripard <maxime@cerno.tech> wrote:
>
> atomic_flush will be called for each CRTC even if they aren't enabled.
>
> The whole code we have there will thus run without a properly affected
> channel, which can then result in all sorts of weird behaviour.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 3582ede1a0aa..5fadbf219542 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -579,6 +579,9 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>                 return;
>         }
>
> +       if (vc4_state->assigned_channel == VC4_HVS_CHANNEL_DISABLED)
> +               return;
> +
>         if (debug_dump_regs) {
>                 DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
>                 vc4_hvs_dump_state(hvs);
>
> --
> 2.38.1
