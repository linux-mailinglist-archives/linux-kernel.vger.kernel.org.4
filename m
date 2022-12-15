Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9964D7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLOIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:36:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B423BC9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:36:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i9so13161971edj.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ND4ijq68a4hb3gYR2CJ/DyOHYb8yeQZla7eXoYCzc=;
        b=HhdRvG4XYqrsh3k2OdCVvBgdTiaVmwG0SBDN9sjj9GgVVYL5OiZ05+na3YBpllG3q3
         BaH6jODcOq20FYy5olQ5z00qwXLAQSLkjyBAPZZwpTISHgoMsR+OV3TM1VlF+a7P7/J0
         X7sB6nMwvloE+xgIdTxcv93Y2l3zQV08/mEU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9ND4ijq68a4hb3gYR2CJ/DyOHYb8yeQZla7eXoYCzc=;
        b=Vu1KDl87r+NElXVoXQQd1EHESIOXAjjQWI/4pUwfL/mjaMBOgPMcAYQZaYx1b5XJ5f
         MMbLltFDhw3kWAIciNvZnpgXVE+md4UiISHb+Cfm9tN4e8zgjSAK5EgUUf8fyb3U7Dem
         hmOwumk22VwQC5HmbezYbpYf1j/FkmuUn0UVFVblUfmAAGHyeDLtBHCwUAMg0AmWMiED
         0sqFZNK7fE6GCXtokrBbao+oLSx8cO7rUquxfExEyyyDFfWnlufvhogdb5GyU8ffpnfh
         ELIB1CxzBWJWHDMaOxuqH/RNR+xzdUvqP2k6acwL/vjzhFvmsKEpjiO5/49pOFN5jBuQ
         I8ZQ==
X-Gm-Message-State: ANoB5pnaQE+afzm5L172tSLzG55osn+RdTxt6aNgujveZi7O/kAzdLA+
        RaWfW4/5IEdXSkkL7nwGRgt860QAyMLdGsD+IsP+XX8B8YaP1enP
X-Google-Smtp-Source: AA0mqf5u6VVY9Q5PyxQ+4FxYsGsBlaZT6Jdtf2Cwj/6QFxZ2lPdbWhu42bhr0RWrwu/RZ18Ude0UHGNKh0EyT7xNJew=
X-Received: by 2002:aa7:dd4d:0:b0:45c:98a9:7bbf with SMTP id
 o13-20020aa7dd4d000000b0045c98a97bbfmr71860623edw.372.1671093371372; Thu, 15
 Dec 2022 00:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20221115112720.911158-1-treapking@chromium.org> <167103665890.995711.9267085599513513874.b4-ty@linaro.org>
In-Reply-To: <167103665890.995711.9267085599513513874.b4-ty@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 15 Dec 2022 16:36:00 +0800
Message-ID: <CAEXTbpfgCVWNE=ao5=d8_Bo1YHmfb7e08aeMCaz38Tvt0jAcTw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Add caching for EDID
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        allen chen <allen.chen@ite.com.tw>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Thanks for the review.

I didn't see this patch on drm-misc-next, but my another patch merged
instead: https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5eb9a4314053bda7642643f70f49a2b415920812

Did something go wrong? Or is it me missing something?

Regards,
Pin-yen

On Thu, Dec 15, 2022 at 12:51 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Tue, 15 Nov 2022 19:27:20 +0800, Pin-yen Lin wrote:
> > Add caching when EDID is read, and invalidate the cache until the
> > bridge detects HPD low or sink count changes on HPD_IRQ.
> >
> > It takes 1.2s for IT6505 bridge to read a 3-block EDID, and skipping
> > one EDID read would be a notable difference on user experience.
> >
> >
> > [...]
>
> Applied, thanks!
>
> Repo: https://cgit.freedesktop.org/drm/drm-misc/
>
>
> [1/1] drm/bridge: it6505: Add caching for EDID
>       (no commit info)
>
>
>
> rob
>
