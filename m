Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640C26CAE23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjC0TGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0TGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:06:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83D2134;
        Mon, 27 Mar 2023 12:06:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q6so4346231iot.2;
        Mon, 27 Mar 2023 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679943960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/6pCbry1/ETo4U2530l82j/Esz1dkFEPg21dCL6WTw=;
        b=qEjf8I4GOQ3ShgwJE6dqrPcG9qSLP1lpAnbSL/0QwbfT1gw6trLRerbTznbRPCRWGl
         ptSbtzVddhG0DF8sVXgPL8e0GpPUdTihkFWyQ2IeBBZCx3d9pTXVufkQvN4Ln2eoFpho
         minaZRNBe4lO/t3G2g5qBtUXF96q+1EmUvZVp86unc7ExQxECI7xGikVOPtjmWcztXlO
         RvVP3tNTL8YCaIKjtdq6QujfVIMo6xUontUVN+nJQBg/aNtTfhXedAA3JZ25BODvyIt1
         EK3lQYu0LF0cIkZghChlDy5bfu+7aBMkXpcUyHtmnra0GZc1Y0wCFi+hqwWmUvZdo855
         UU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/6pCbry1/ETo4U2530l82j/Esz1dkFEPg21dCL6WTw=;
        b=iu727alM6AIfswEzBidd94Bvvv3RjV4VxcRG3RL81zYj52kIlZ9Z1wRZsY0IsB9bl/
         USjWHGNPelS6lf4MMAJpylHHMaOipDC2x4G60KiIodzHogkDnBn873kh+mLsCPeqTqhT
         WRoh+fh5OpaQ1fb7vpYKfoEOmAAwHBs3V8exFY44PLfm0MErB6Fu0a37rpZQB9CHJidz
         NpgfwSLgY+j6bGCJGDgCvai7jv2vuTaiPonEfX3HZi+9VI0oI7KInf37rUZGOngiKpZv
         klT/j/43UQq1DUdFqxGCNcaqsHBmwx3LUO8mrcl0cJxeTSGVt5/wu9XH2wPUlIG7RQ0q
         YJDg==
X-Gm-Message-State: AO0yUKUFZVkaX7+wbTTyTMfDjxIiPPKBxkxgILMru+uoiu5rUd+G8mAS
        kHEXtWvwNCTeRBWx/OgtecrvL7FnVyphkBN//vQ=
X-Google-Smtp-Source: AK7set+YB0mgSsfhYO28hAVommFXrSJ7Khtm4bPRuGYAQdnaWKxQKYL1vrIABfxBGJd0YlxvVRZhRVs+2KV9z5cUoZY=
X-Received: by 2002:a02:2208:0:b0:3ad:65e:e489 with SMTP id
 o8-20020a022208000000b003ad065ee489mr5198516jao.1.1679943959800; Mon, 27 Mar
 2023 12:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230308155322.344664-1-robdclark@gmail.com>
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 27 Mar 2023 15:05:48 -0400
Message-ID: <CAEdQ38FGQe_z2T2vUCsSYvH52WZc75OPCCFYOSEKJ9MzXq0ynw@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] dma-fence: Deadline awareness
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 10:53=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This series adds a deadline hint to fences, so realtime deadlines
> such as vblank can be communicated to the fence signaller for power/
> frequency management decisions.
>
> This is partially inspired by a trick i915 does, but implemented
> via dma-fence for a couple of reasons:
>
> 1) To continue to be able to use the atomic helpers
> 2) To support cases where display and gpu are different drivers
>
> This iteration adds a dma-fence ioctl to set a deadline (both to
> support igt-tests, and compositors which delay decisions about which
> client buffer to display), and a sw_sync ioctl to read back the
> deadline.  IGT tests utilizing these can be found at:


I read through the series and didn't spot anything. Have a rather weak

Reviewed-by: Matt Turner <mattst88@gmail.com>

Thanks!
