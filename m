Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763B66A0CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjBWPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjBWPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:19:04 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0945567BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:19:02 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536cb25982eso174746067b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwN6HfLSUE5ZKSAzD6kxZTBLoYaNfg1FJI6Ev8TDx4M=;
        b=hY5XLuPCYfHmjKHQuLwKYFlB4WfA4hoN+aNfzERLVE6508A9iiPyioey5culYB5CI+
         ESYRSZAB2d9XOnbo+cPZOt5OLd7wLWB7difGrXDNSB7/03o81Ll8EMoLuzLSK2QUGew9
         awH6Y8ox1ORqwCp48m3OlXmzoIArA44JwGCBbwPMQ6k/CBSrsn6n1K6I40hBbX92WHjT
         DZ76eQqiDDhgz+O0wScTmQJ73Oa6UEiDlkgSHwECcXczHmoGueOLa/ZMalhUxiInxmv5
         MzDYTNI52JhbmS6KV9LughkC8xGgkDEItI0FrO9gg6tlDmWfV0LX6bJHB0udKm29d9zM
         Bz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwN6HfLSUE5ZKSAzD6kxZTBLoYaNfg1FJI6Ev8TDx4M=;
        b=YYHcTzLkHuQcxTYadgdd7vppyIjHICI3BWXOWLAnTicSKq9/12AfQXTeczqrmYkB6E
         v46sVL4ELabllkB+Zk4NpZYNu0yvW+5j1cYbbkWrG46ugfKzhKXTpSP1rmB0JY0gFuQD
         ILekcXKUn8U8JcRtaYpeaebDPXD8DwESCvV7mWXOYtUAyv0nnfmpfLb0BsNXPEpxwAfr
         29kdzM63gMR/n+eZhNRk/BRW4VCnundfY0QCVPmyJFBIeYGyafkCbG11mVMlxIndQxPS
         yw6YqzK0FABTfalE81OhDnP1Tc/je5TuaJgKc8/AvJKJYxG8pM61C4Ebf2dKK0lHHYJC
         QO8w==
X-Gm-Message-State: AO0yUKX72mNXY1dP8lKFYwWV5iLn4o9XCzI/PjaImAYNoNAj3+m4KXfz
        ihOhYyYJtDbWHl98lKAKV4NR4vxPmSXO2tyQsAcRxA==
X-Google-Smtp-Source: AK7set/MGnbOMGB+D2Et65I+FbFHFBA3n+THAUTHlhkT5fuvYhaHgIJXj5QE6uw1NwL5PDsQmt26jDgvePFLaYbOwRQ=
X-Received: by 2002:a5b:b8b:0:b0:a28:737a:b214 with SMTP id
 l11-20020a5b0b8b000000b00a28737ab214mr1359757ybq.10.1677165542095; Thu, 23
 Feb 2023 07:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20230223135635.30659-1-quic_sbillaka@quicinc.com>
In-Reply-To: <20230223135635.30659-1-quic_sbillaka@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Feb 2023 17:18:51 +0200
Message-ID: <CAA8EJppZ+Hyhb9MacaFX6xTrJ9XyYbbCRrBvO+yE0=-Bztk7CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] drm/msm/dp: refactor the msm dp driver resources
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com,
        quic_bjorande@quicinc.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 15:57, Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The DP driver resources are currently enabled and disabled directly based on code flow.
> As mentioned in bug 230631602, we want to do the following:

private bug tracker

>
> 1) Refactor the dp/edp parsing code to move it to probe (it is currently done in bind).

This is good. I'd suggest splitting this into smaller chunks. First,
move all resource binding, then move the actual dp_aux handling. It
would be easier to review it this way.

> 2) Then bind all the power resources needed for AUX in pm_runtime_ops.
>
> 3) Handle EPROBE_DEFER cases of the panel-eDP aux device.

This is not handled properly. The eDP aux probing is asynchronous, so
you should move the second stage into the done_probing() part, rather
than relying on the -EPROBE_DEFER. There can be cases, when the panel
driver is not available at the DP's probe time. In such cases we
should leave the DP driver probed, then wait for the panel before
binding the component.

> 4) Verify DP functionality is unaffected.
>
> These code changes will parse the resources and get the edp panel during probe.
> All the necessary resources required for the aux transactions are moved to pm_runtime ops.
> They are enabled or disabled via get/put sync functions.
>
> This is a RFC to verify with the community if the approach we are taking is correct.
>
> https://partnerissuetracker.corp.google.com/issues/230631602

This link is useless, since its contents are not public.

>
> Sankeerth Billakanti (2):
>   drm/msm/dp: enumerate edp panel during driver probe
>   drm/msm/dp: enable pm_runtime support for dp driver
>
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 155 +++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_catalog.c |  12 ++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |   1 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 185 ++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_power.c   |   7 --
>  5 files changed, 250 insertions(+), 110 deletions(-)
>
> --
> 2.39.0
>


-- 
With best wishes
Dmitry
