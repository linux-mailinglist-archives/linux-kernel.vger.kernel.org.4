Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDD628AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiKNUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiKNUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:42:23 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF3B07;
        Mon, 14 Nov 2022 12:42:22 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h132so12723087oif.2;
        Mon, 14 Nov 2022 12:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhLdcZAhUiSSVqXijIiTlHHql4argBY05Hn7xx4K6sw=;
        b=kyWAoQ2hD6W55qcbLsRwPlrTRIQ0nY0WLSqB3VytSiIKvEvQz403hjsSpHt9afF2Nu
         XRUN8MzjE5iYZCsk3fUADAN+/Br97opF5pz9FX1TpuY1eNok0nRKJQrc/Giw2KYi8ShH
         aVnse/+6eousi/GRG/YP9wfN7GWFdRFbBGqekMAi6C721oUrOfjmCWPTlpWKb+shL34h
         SL4xyU6aF9DE0YxpIvUMk45hMhHdLBwzh+YL9N+pjP7D/iu7G/fpmIVp4PF9eowCuqXM
         5jTK6nf0VJarjCjDD7iX5vxdI5sUKGH72A4XoRRcgGd4pEpf+p9Bf73YfPAlpm2/cKyI
         RhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhLdcZAhUiSSVqXijIiTlHHql4argBY05Hn7xx4K6sw=;
        b=DfgJa5MjZUjKv+mqsk5y+ylAxEQJIcVCIC26bUS9YmmRnP6JKGIqgBRdTpI6xtawJf
         nYf1vL6unUXxvXyP4i1XNUQuuohZIMpNC3k43OCIo63SpFqHrGtjXroxWGLQrQf3T4No
         Yr2IzdAAbLYBrFMCiiE3olwhrsmP45/pxxupnjoxhSMT76DAtwGECJkM7WfORV+0cvU5
         351mbYV0hOrElf35rurOb8vltJqUEfNbkYQtz2nyJ9mMEXNcnAiz+ZBCQASu8iZAFcGL
         S0KShkIUWcFSQVyXxj4wQkK7ird+lYpt0sBhTpCHTG1EzCBU0osVLF3BJ0L1aC4bEcuW
         I1IA==
X-Gm-Message-State: ANoB5pmw8amA5Qg6NLwWo9+NAXnAnvENDt7DbEXXBlQ2NyGZYPoh0rzF
        HUl/w0Bako004WJneKTEiTptXr+iGB4rS49HzkUBXtTR
X-Google-Smtp-Source: AA0mqf71L3WKc2HDxj3fRALVFx6wOxJhsA0EVIkhcX1I0NDHUAJg5NqqTQf4KI1K7NDQjbxzzxa9EIfAXpYNFkTL9vQ=
X-Received: by 2002:a54:408e:0:b0:354:46fc:9bb3 with SMTP id
 i14-20020a54408e000000b0035446fc9bb3mr6745235oii.38.1668458541761; Mon, 14
 Nov 2022 12:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20221114194133.1535178-1-robdclark@gmail.com> <CAD=FV=WB__v5TPFOqnQMajR6MvLGjLYrKrV+qosJYQFTCpROzQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WB__v5TPFOqnQMajR6MvLGjLYrKrV+qosJYQFTCpROzQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 14 Nov 2022 12:42:41 -0800
Message-ID: <CAF6AEGtshehnG8vPonD=ckH8-xbW+D6ykCrZBWDT6bVh3U0pOw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:27 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Nov 14, 2022 at 11:41 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If we get an error (other than -ENOENT) we need to propagate that up the
> > stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up with
> > whatever OPP(s) are represented by bit zero.
>
> Can you explain the "whatever OPP(s) are represented by bit zero"
> part? This doesn't seem to be true because `supp_hw` is initiated to
> UINT_MAX. If I'm remembering how this all works, doesn't that mean
> that if we get an error we'll assume all OPPs are OK?

Oh, that's right.. and even worse!  Ok, stand by for v2

> I'm not saying that I'm against your change, but I think maybe you're
> misdescribing the old behavior.
>
> Speaking of the initialization of supp_hw, if we want to change the
> behavior like your patch does then we should be able to remove that
> initialization, right?
>
> I would also suspect that your patch will result in a compiler
> warning, at least on some compilers. The goto label `done` is no
> longer needed, right?
>
> -Doug
