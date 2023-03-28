Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78C6CC736
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjC1P4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjC1P4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:56:15 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED44B6;
        Tue, 28 Mar 2023 08:56:13 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17ab3a48158so13198140fac.1;
        Tue, 28 Mar 2023 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLQmwWJisvp20MnJ4qDI8yRnwjPlaeebVHetENzuzzU=;
        b=OMbM7O9EwBPWWFjEMJ+FlcmYiUgbLAfQbAtSTuyxoESDSgQ8hxghe6qUyRx/vWMcwh
         aHVOiBp14eBMTCpWI7EXffI2UDinCk6c7HEi5vnnMdOt0RWbeGRltPE7QsecSf6UZvCy
         m/dzpD6UfN14mpt/DqrhS//y9OxBhElytj2WCu1DJ5badiC7j7HoZfUgvU669VHBXz3N
         UzYknZTA9gE7NJ0H/WeB9SV6uKDRhvEHjv5o2wMVCnVVIh+eKF+8tCUOzzC7LjAztv/T
         v47jIBW3dO77hkBHYiaxICiyfMo4YGu/+7ZHQcLuQUMzxJDp4W3IVeKVsm+FbzfXUSp3
         fyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLQmwWJisvp20MnJ4qDI8yRnwjPlaeebVHetENzuzzU=;
        b=eSFt3fhxwSl2ZGqh8ZDH//fnVK1hkyaU5gKa4gKf9dd9vwht7huHUzMAtP6ihmzNEr
         H5aciabOKAML7h7z3+S5XtbbG61tnXJETsugfdbFBIODUFOD82Lrp3SZUJZl+Udv7zLK
         4Lrg8JJ/TDnkzKmZUBZlIbrsuuSZ94e4RqWa6G+VeFojUdugv/dj0jURjvuQwr01AmH9
         I5NH01fswoP0TTQWvsMVpO4oriUBeAprSNL8fUvSywv52kPOlvR2n1Nr8/J+pPWWHSOD
         6C+Z1vWfOmqk26XofxYHb52zmsxH1ZLnzje0kaKCoe3+tiofyHkn/jiwPGOKeor9SQYZ
         pEyA==
X-Gm-Message-State: AO0yUKWQfP3gdHgkzXb9EVwb+1wq/kEPvrzVU5RaMw0tiWboPP+Ptnm+
        3TURxseA8dumaZK8GY5qEpNPoGPul3KtuCk4BHs=
X-Google-Smtp-Source: AK7set9Dbu34N1vzrjqQsCVc28MeYvZObEv0k5MjUDJn0LlSibv+c/2Gjo7q6ZirexlX1fKiTuUOUJWWFpxN4YAPvJI=
X-Received: by 2002:a05:6871:4796:b0:17a:df9b:6b1b with SMTP id
 qa22-20020a056871479600b0017adf9b6b1bmr5890211oab.5.1680018971653; Tue, 28
 Mar 2023 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230324220013.191795-1-robdclark@gmail.com> <af31e11c-6c70-a358-1198-3cddc3ee2f89@linaro.org>
In-Reply-To: <af31e11c-6c70-a358-1198-3cddc3ee2f89@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Mar 2023 08:56:00 -0700
Message-ID: <CAF6AEGs8yH4SHvjDHKkHT3c4UNc35m3tFGiPBcHA3oATZQiKVA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Avoid rounding down to zero jiffies
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 8:28=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 25/03/2023 00:00, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If userspace asked for a timeout greater than zero, but less than a
> > jiffy, they clearly weren't planning on spinning.  So it is better
> > to round up to one.
> >
> > This fixes an issue with supertuxkart that was (for some reason)
> > spinning on a gl sync with 1ms timeout.  CPU time for a demo lap
> > drops from:
> >
> >    15.83user 20.98system 0:47.46elapsed 77%CPU
> >
> > to:
> >
> >    8.84user 2.30system 0:46.67elapsed 23%CPU
>
> Interesting. We potentially increased the timeout, but the overall
> (elapsed) time has decreased. Nevertheless:

There is some randomness from run to run so small variations in total
--profile-laps=3DN time are normal.  So I wouldn't read too much into
that, compared to %CPU.  This shouldn't really change how long it
takes for the fence to signal, as much as just prevent the CPU from
busy looping until the fence does signal ;-)

(In theory the CPU busy looping could cause GPU thermal throttling,
but I don't think that was happening in this case.)

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

thx

> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_drv.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_dr=
v.h
> > index 9f0c184b02a0..7936aa6cad03 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -548,7 +548,7 @@ static inline unsigned long timeout_to_jiffies(cons=
t ktime_t *timeout)
> >               remaining_jiffies =3D ktime_divns(rem, NSEC_PER_SEC / HZ)=
;
> >       }
> >
> > -     return clamp(remaining_jiffies, 0LL, (s64)INT_MAX);
> > +     return clamp(remaining_jiffies, 1LL, (s64)INT_MAX);
> >   }
> >
> >   /* Driver helpers */
>
> --
> With best wishes
> Dmitry
>
