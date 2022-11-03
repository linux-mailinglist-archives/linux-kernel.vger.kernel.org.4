Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE88617F62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKCOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKCOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:24:51 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF2726DC;
        Thu,  3 Nov 2022 07:24:50 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v7-20020a4aa507000000b00496e843fdfeso281177ook.7;
        Thu, 03 Nov 2022 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/xSN01Y9d0jDzJ8OY9Uml07yt5pXMZDHAA6O3LIwM4=;
        b=NNfn/U3u6fGUpwAIsw3QI8vNRnfExdw5AISKpSm4hA6ez4yskkICLV8O8q13vBNKGy
         LBoq/BR7pVxnBdmFGt3N2K+QjSb67MZKOkjy/6Cpcp6i0HveRrVB87dbnQpHrpRVp5CA
         VGRXD5zRtwfjbHGuS01PUBwws170k6uz3M7FF45R1A2x3CYKOpYY9fQYmV4vyxg3cUFu
         uMkh4HmUbnTHjukHQ5YYvKPAqXRMwLy6pw/asV0tJBah6yMnfKUGyvEjznb1A6P62YX9
         5s9pr6+zOe7WD8wmYtuovrLYL6CjXWg1i6hiFt0Yqovv681rh6t0OqM/LQXQElYc5sGI
         FUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/xSN01Y9d0jDzJ8OY9Uml07yt5pXMZDHAA6O3LIwM4=;
        b=8RQIHLAEFG9ncEQANCddvXBa9jGL3gYJaAzMjacrOJxDCpVzELbISKSj2v0QZJYrmY
         yY/eWrNao9z4x0njFID/QmlUOr+JCPpgn56/H9TofYfVOMTkZim6aASIMiu9Xotezb8I
         vEyBqCrzb2fhNggDjgyo7mAHLbrVhP9MZiValesyUb7V89J8uq7/Ne8D2+SF9g7mc/Ad
         DiuOfES3wx6sbkQA4PW+jsAnh7qoyavnlsYD84lmiYV1OWy9qpOyzIYp54L04AJz+76I
         XP2x1Nj4eCYrrtKG54ViINg4AewAZtFyBK1dMe4CSNJDj0KHl6hs3OImTKQlD6IpPlcQ
         Wi3g==
X-Gm-Message-State: ACrzQf3QcmL6U9PwLpZztw4NPliyYjp/fMBvFIQ9Z+xBj9bChGM5plBm
        ambj7lGwIP3aJxXWsbhcm+YWx3LpOjh8bkTeiGE=
X-Google-Smtp-Source: AMsMyM6J5QRMxRp64kRAdhF5yjjfT9WHNQctflNk+E6Xp1u2gW/bCaFAXyDhIRKAHdTzy+3zP3AgCHbpg71s/ISYB+o=
X-Received: by 2002:a4a:a68b:0:b0:496:2521:c81d with SMTP id
 f11-20020a4aa68b000000b004962521c81dmr12952579oom.80.1667485489693; Thu, 03
 Nov 2022 07:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221101223319.165493-1-robdclark@gmail.com> <20221101223319.165493-3-robdclark@gmail.com>
 <bf5fb954-c71b-f02f-5300-4e030b10811a@linaro.org>
In-Reply-To: <bf5fb954-c71b-f02f-5300-4e030b10811a@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 3 Nov 2022 07:25:07 -0700
Message-ID: <CAF6AEGtzfoxKLi7FrHRgdp-ft32rFH1XzEeu11SeH3c0Lodj0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm: Hangcheck progress detection
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
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

On Wed, Nov 2, 2022 at 4:26 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 02/11/2022 01:33, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If the hangcheck timer expires, check if the fw's position in the
> > cmdstream has advanced (changed) since last timer expiration, and
> > allow it up to three additional "extensions" to it's alotted time.
> > The intention is to continue to catch "shader stuck in a loop" type
> > hangs quickly, but allow more time for things that are actually
> > making forward progress.
>
> Just out of curiosity: wouldn't position also change for a 'shader stuck
> in a loop'?

There is some pipelining, in that there can be a couple draws in
flight at the same time, and SQE is running ahead of that, but with a
shader stuck in a loop the associated draw will not complete, and that
will halt forward progress through the cmdstream.  Basically what this
is doing is detecting that forward progress through the cmdstream has
stopped.

BR,
-R

>
> > Because we need to sample the CP state twice to detect if there has
> > not been progress, this also cuts the the timer's duration in half.
> >
> > v2: Fix typo (REG_A6XX_CP_CSQ_IB2_STAT), add comment
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>
>
>
> --
> With best wishes
> Dmitry
>
