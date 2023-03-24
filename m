Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9F6C8612
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCXTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCXTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:41:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786B35BBB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:41:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n125so3579161ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679686870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IUCD+IxRLqwZzbEH30wWX1QCJBeJYUOVFgyf9bSu9hM=;
        b=kG7mEr+AyiSspI904z+BgOxO0ChJNkROnsq0QV+jI5dKx/vtfbi9ldMLD967dOzPIn
         fr1AjHm0vYdhY8RNYqgs8jBPt7vtGZcuXWLo81Wer4eszGIUI/zgis0PV9gU2l2U4WZ7
         L0aLLZ/yGqpciuFzH1Vb22wpt5ZY89HZEsgqg0srlSfWtMWMYQ7FCl6qplFzV8Y+WS4H
         L7XZCX6vYV/9PDvnZj8w2AwI9NDJxDcs9OY3CQg3zGYnCZmvlzTSFRb28s7BUaTyL6Vk
         nLbewqemd7B68TTFOTzerrXm99ib/mgoNYbg6KUOQsxfRZLG3XR2sxTzn/NIxwEjxL7E
         MAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679686870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUCD+IxRLqwZzbEH30wWX1QCJBeJYUOVFgyf9bSu9hM=;
        b=X9N/oZIJ1kiA4WbfRxXqQAOoR8q+c2wybYXz65Hdc85oQ0Pf5ylzSaPnVnf+lnvKHE
         zrPYzhwGmPJNBwvPbz2iuUMpL21LCWDFCYKV/TgiqCH17ypDuHNrfGj1VxcDjc5EbrWo
         rSoa3BgWNHA9tCT9gIilumzy750AcjJAT5AbIBQ8e9CTDD/iOlh/rqXDbbNFwXd8DXr8
         Q3WhIrdlFgHJvi/QdS9/9LA1ZkQn2Ejz0TKkMKxDHVa38juVQUQ+Le7+N/6IPYHww8X7
         LRIpn7FpUohk1TwNlUuW0QxMiRiINRfPlrfVuXYFhMH/8Yi26vTj3JdYUOlekdcISlT0
         K/HQ==
X-Gm-Message-State: AAQBX9djJdZRHuc+D6vwTTIHfHzrGH8DjPv/hY2vJW14oqoNtyDio97R
        3pQ4qKnAKFF0esDDRJPSLQZuDZWoISDmBmMA8Xv/Ng==
X-Google-Smtp-Source: AKy350ab+2+iDDqjp/8MtBPau3csSAqLpql7w1Couc3tePNqHMKcEaSxPYFWamsrYuol36PWs6TWCUU1P72W7/eLEug=
X-Received: by 2002:a05:6902:a93:b0:b78:5f10:672d with SMTP id
 cd19-20020a0569020a9300b00b785f10672dmr674911ybb.9.1679686870645; Fri, 24 Mar
 2023 12:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230324192058.3916571-1-markyacoub@google.com> <20230324192058.3916571-2-markyacoub@google.com>
In-Reply-To: <20230324192058.3916571-2-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 24 Mar 2023 21:40:59 +0200
Message-ID: <CAA8EJpo1Ki+Axav2FXc68AxXbM6Vof=FGLejW_EYUMZs=qdwQw@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] drm/hdcp: Add drm_hdcp_atomic_check()
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 at 21:21, Mark Yacoub <markyacoub@chromium.org> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> Move the hdcp atomic check from i915 to drm_hdcp so other
> drivers can use it. No functional changes, just cleaned up some of the
> code when moving it over.
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>

Please:

1) Cc the cover letter to all parties, so that we know what is going on
2) Please also Cc the whole series including the cover letter to
freedreno@ so that it hits patchwork as a whole.

-- 
With best wishes
Dmitry
