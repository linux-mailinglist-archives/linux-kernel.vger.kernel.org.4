Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176436737FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjASMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjASMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:11:36 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500F69233;
        Thu, 19 Jan 2023 04:11:34 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id x36so2550042ede.13;
        Thu, 19 Jan 2023 04:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REGjeTPbZk4DoCVcHgFfFyTkT80xKveDiZMOpebK+fw=;
        b=VpqHnwzvDoZZV+sCo3cy99znMCblf/GymMyk2CvJk5bmtRplk7up694uJ0qPuc0lJe
         METTTewg3qZ/b95wbinR8Iw7NteeszPkHy2nPD5Piq3fP+0sBaBx3pi9XEH3ierg5UVi
         0Oi8FLZ0kKCITMDJflb2v9vux3Ft0twX6DBJKIO2rChEXgjmbZF6wvceameIlxN7Kq1B
         igT+k7i7MbSUpLFXkewFTAOKp2LvaK3fQq5IDnOkIUNKySobdQpQIwmxZri4LkX0V5g4
         Fa9dGloC1XNAdCAxU3Bm9WKbDyZpLFFuJjt2/g6pjD1GWM73OpeGG3k6Gi7w2l+/iyrp
         IsiA==
X-Gm-Message-State: AFqh2krTE1+9qINkqNEL3H+qEcwmIgd0dfXPoB5Fki+1DDh3Exy48Air
        CohYIZkSWokrghzMUrwx/y/htWGaGntFUfi72TQ=
X-Google-Smtp-Source: AMrXdXsnV1OfstiOKrJZDA4YiqLPRu7vHm7ba93HtUrTlzHKKY+nnPFrNk7oTerws3p2tOYCS20mWQe81xBbQspHot0=
X-Received: by 2002:a05:6402:4498:b0:495:f184:3971 with SMTP id
 er24-20020a056402449800b00495f1843971mr1510009edb.95.1674130293309; Thu, 19
 Jan 2023 04:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <20230118211123.111493-3-daniel.lezcano@linaro.org> <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
 <db701c97-883e-f231-68fa-c851c6a1a862@linaro.org>
In-Reply-To: <db701c97-883e-f231-68fa-c851c6a1a862@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 13:11:21 +0100
Message-ID: <CAJZ5v0jFQv09MQw8Z0gn1=Yf3JJD=BWKy3+Xy7RWUy1NXAK7wg@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/01/2023 08:41, Zhang, Rui wrote:
> > On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
> >> If the thermal framework fails to initialize, the mutex can be used
> >> by
> >> the different functions registering a thermal zone anyway.
> >
> > Hmm, even with no governors and unregistered thermal sysfs class?
> >
> > IMO, thermal APIs for registering a thermal_zone/cooling_device should
> > yield early if thermal_init fails.
> > For other APIs that relies on a valid
> > thermal_zone_device/thermal_cooling_device pointer, nothing needs to
> > be changed.
> >
> > what do you think?
>
> I think you are right.
>
> It would be nice if we can check if the thermal class is registered and
> bail out if not. But there is no function to check that AFAICS.
>
> Alternatively we can convert the thermal class static structure to a
> pointer and set it to NULL in case of error in thermal_init() ?

It doesn't matter if this is a NULL pointer or a static object that's
clearly marked as unused.
