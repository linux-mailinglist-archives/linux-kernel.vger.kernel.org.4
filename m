Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2AA67A9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 05:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAYEcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 23:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAYEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 23:32:03 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B9470B6;
        Tue, 24 Jan 2023 20:32:01 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 39-20020a9d032a000000b006884aad0b15so513315otv.12;
        Tue, 24 Jan 2023 20:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZCOPHA0/p0Gbg3tDBBAk1F9iMjCBVQ4LhqzTjtLUlc=;
        b=PIGzX+Cn3rTHzBnT3XP8S1yiSzGHAUp/z6VrqRL6xmgM2SvAsDmO7SbuJRBZ3jphRL
         6Q1EM14mKr45ZLB1KzzUCaz8HEfe//VyfUhU/nljcLPchmq+5NY7qtKhZc9iblzBhnYP
         66bQKH08hFj+u/qxPPfdxvLpbY5BUChD0wj58icB0a5u8IWrXvv+iP4H3ITh3oAhIsVA
         RUx5nuQI1B3QQmWHbTTifd2cIi1bdSilW+2sCQm0zTZH9LGEGidud/qHLB0VZPYYUOs+
         xv0bc709P7FEg3crFeFVOeHaYl0EOTnVBxCHZGOrhoEsyp+irmy8BTUrLKV9BLyMLcLK
         /a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZCOPHA0/p0Gbg3tDBBAk1F9iMjCBVQ4LhqzTjtLUlc=;
        b=V96q7RM2Tvtv6j/LHDCDeteJJ86dAp0u0ejALf+2iVJyLkMn38uFybTpe51P59KpgM
         gKIdkKKPXegM18wsUkspGHPSEZDUBMNY9hX2TlV25OmZZTBvbe/MK92SRwzk9WSkZ6lW
         wSd7pDS1GhOjK6BhYjtflGyQ9dTLcv8aG7SyvHrAAShp1UDZe49NWbBB36ZRpOIdIBkV
         dW0Ou24Q0SlMN5rpNtFhk2+U+MXvqvAvs6YgOh7CrGDRMUcHJDCVeAyMm4G7AlpN54X9
         LAPt5UVx14T+xeVUryRylh8OoZxj57/kiMsJVCt/oAZsmI1sbw4ZD+pZQq7sPIp8l8mS
         l6ag==
X-Gm-Message-State: AFqh2kqWz2hA1mdyXmqNmz8+B8rqd0qqT3cwGr3UXd+AOi7CV+fm36FY
        tECAAs5xWiJMv+n3YeTWR/C9/EnlTCA3KgYSAYSbDEk9
X-Google-Smtp-Source: AMrXdXvluqehiZTX7OCAaPBmXMEQ0kJO/eyrrCev37lHlLGYry5SOIYOuUe0aRZeRjVD10hiBxNkKQGxw+x0vmlo2qo=
X-Received: by 2002:a9d:5c89:0:b0:686:60f4:b300 with SMTP id
 a9-20020a9d5c89000000b0068660f4b300mr1151897oti.328.1674621120883; Tue, 24
 Jan 2023 20:32:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230123153745epcas1p17e57cf83ed371e86258139473befc615@epcms1p1>
 <20230123153745.3185032-1-robdclark@gmail.com> <20230125040403epcms1p1646e9668b87df3e9c344ad58d39b6eb6@epcms1p1>
In-Reply-To: <20230125040403epcms1p1646e9668b87df3e9c344ad58d39b6eb6@epcms1p1>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 24 Jan 2023 20:31:58 -0800
Message-ID: <CAF6AEGud-ESF=VgcaSFzKsWas0H5eSXZDdZGcnd8Ju=pr-W2EQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix build issues with devfreq disabled
To:     myungjoo.ham@samsung.com
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chia-I Wu <olvaffe@gmail.com>,
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

On Tue, Jan 24, 2023 at 8:04 PM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>
> >Sender : Rob Clark <robdclark@gmail.com>
> >Date : 2023-01-24 00:37 (GMT+9)
> >Title : [PATCH] PM / devfreq: Fix build issues with devfreq disabled
> >
> >From: Rob Clark <robdclark@chromium.org>
> >
> >The existing no-op shims for when PM_DEVFREQ (or an individual governor)
> >only do half the job.  The governor specific config/tuning structs need
> >to be available to avoid compile errors in drivers using devfreq.
> >
> >Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> >Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Doesn't this imply that DRM_MSM should depend on PM_DEVFREQ ?
>
> It appears that gpu/drm/msm/DRM_MSM uses PM_DEVFREQ without actually
> declaring the dependency on PM_DEVFREQ.
> You cannot use SIMPLE_ONDEMAND without DEVFREQ.

Possibly that would resolve some issues, and that might have been my
mistake in assuming that depending on SIMPLE_ONDEMAND implied a
dependency on DEFREQ (which seems like a reasonable assumption, IMHO)

But AFAICT some kernel configs that could otherwise use DRM_MSM don't
support PM_DEVFREQ.. either way, lets solve this properly and remove
needless dependencies on devfreq.

BR,
-R


> Cheers,
> MyungJoo
>
> >---
> >Assuming this doesn't conflict with anything else landing via another
> >tree, an a-b to land this via drm/msm-next would let us un-break builds.
> >(And also start removing "select DEVFREQ_GOV_SIMPLE_ONDEMAND"s added in
> >various places to try to work around this issue.)
> >
> > include/linux/devfreq.h | 7 ++-----
> > 1 file changed, 2 insertions(+), 5 deletions(-)
> >
> >diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> >index 4dc7cda4fd46..7fd704bb8f3d 100644
> >--- a/include/linux/devfreq.h
> >+++ b/include/linux/devfreq.h
> >@@ -273,8 +273,8 @@ void devm_devfreq_unregister_notifier(struct device *dev,
> > struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node);
> > struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
> >                                 const char *phandle_name, int index);
> >+#endif /* CONFIG_PM_DEVFREQ */
> >
> >-#if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
> > /**
> >  * struct devfreq_simple_ondemand_data - ``void *data`` fed to struct devfreq
> >  *        and devfreq_add_device
> >@@ -292,9 +292,7 @@ struct devfreq_simple_ondemand_data {
> >         unsigned int upthreshold;
> >         unsigned int downdifferential;
> > };
> >-#endif
> >
> >-#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> > enum devfreq_parent_dev_type {
> >         DEVFREQ_PARENT_DEV,
> >         CPUFREQ_PARENT_DEV,
> >@@ -337,9 +335,8 @@ struct devfreq_passive_data {
> >         struct notifier_block nb;
> >         struct list_head cpu_data_list;
> > };
> >-#endif
> >
> >-#else /* !CONFIG_PM_DEVFREQ */
> >+#if !defined(CONFIG_PM_DEVFREQ)
> > static inline struct devfreq *devfreq_add_device(struct device *dev,
> >                                         struct devfreq_dev_profile *profile,
> >                                         const char *governor_name,
> >--
> >2.38.1
> >
>
