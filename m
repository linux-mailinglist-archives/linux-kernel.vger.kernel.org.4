Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B75BB173
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIPRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIPRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:06:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8875B515A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:06:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m3so12586636eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Jf4Jw0Mr6mHcpaxKKDf9yH/uSMECnB5VVFRTiPH6N2Y=;
        b=czwRI/FM2jh6/kmaXuRlb1t3D0Z9udFPCg+05gGRsv5RMIGSlCeVGNpEzuO3KdaVGE
         Vol5PkVs+tfj6ZXaZs58PUUXZhxv3/UUGlvr57iMDsRy/xUBlImv4eaDWYEk+9DxOWQq
         bZnuqOyLj55lIXj3ap2mxO6/FKx++EtEQlWJbzBXtZAUy2phPXAnGuehyPZo+FaQX2zo
         UKCB+IVONQJqyvPd2NT1sfNfnjpJ5LOt5dX5dciZxmCnEnt5Wtidyw3zgMKr61z3PA99
         bqTgD1xjeC6RzjsnL0vnQC+aOa6gYSt+ZAaYd+wcswT1rYhwSj7XaDZBqZ8Z5GPkdnsj
         aZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Jf4Jw0Mr6mHcpaxKKDf9yH/uSMECnB5VVFRTiPH6N2Y=;
        b=LwUwaxEZp2h3WRSmmpmeiXmaIRD1adtm6iRG2a+xgBmOp+23IH+jctM6W+mWE4VzcV
         pNq+FaIHD94hAX05hQqSraMux9XuENE3+/P3rirP8tp9jL/YrBQcuai2MRKYhfyx7hEa
         0IK07ItcLOG+sGZf12iak7Beeqk/NWaeY89lhlMia9JrXMxXF9lrNLxvCKG/05SUUfKk
         Rw/vOv/9vxwQzWV6tS9jER8Hr99yPdX15Q8jbctsQHcChKn9T+viVvLVQ4ZoIMNjyYM0
         Ed1ORR6L7JiAXQ6ony/JbxIdFVFsBYXv+/Hm+HGnap+6eg377y4uXBM0bQQJg0gTWhvk
         5XUA==
X-Gm-Message-State: ACrzQf0+q7h7vq/IXB5EAXy7esjpCSQX4v1vkVUD//Hj2EEkwd7jvMrs
        SU+aMzbs0ecA4RFUy1YKuOKorH19maYp5AmPCY2Atw==
X-Google-Smtp-Source: AMsMyM6IvbGdrxAK3FEcBKUBRjRQ7CJJ76UrRKk0kua5vRl4Px9VRUFVwlYnAqwUgMyDY0xJShAWO3UDN+jXMl7EsMw=
X-Received: by 2002:a05:6402:40d1:b0:44f:e974:f981 with SMTP id
 z17-20020a05640240d100b0044fe974f981mr4940790edb.222.1663347960267; Fri, 16
 Sep 2022 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <1662712413-38233-1-git-send-email-quic_aiquny@quicinc.com>
 <20220909192357.GA319190@p14s> <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
In-Reply-To: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 16 Sep 2022 11:05:48 -0600
Message-ID: <CANLsYkx0fEyezax_bk50ORGb7vPY3sBegKJcfAmmu366MrQkYw@mail.gmail.com>
Subject: Re: [PATCH v1] remoteproc: core: do pm relax when not first crash
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sept 2022 at 05:03, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>
> Hi Mathieu,
>
> pm_awake and pm_relax needed to be used as a pair. There is chance that
> pm_relax is not being called, and make the device always in cannot
> suspend state.
>
> On 9/10/2022 3:23 AM, Mathieu Poirier wrote:
> > Hi Maria,
> >
> > On Fri, Sep 09, 2022 at 04:33:33PM +0800, Maria Yu wrote:
> >> Even if it is not first crash, need to relax the pm
> >> wakelock otherwise the device will stay awake.
> >>
> >
> > The goal is exactly to keep the device awake...
> >
> >> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> >> ---
> >>   drivers/remoteproc/remoteproc_core.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> >> index e5279ed9a8d7..30078043e939 100644
> >> --- a/drivers/remoteproc/remoteproc_core.c
> >> +++ b/drivers/remoteproc/remoteproc_core.c
> >> @@ -1956,6 +1956,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
> >>      if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> >>              /* handle only the first crash detected */
> >>              mutex_unlock(&rproc->lock);
> >> +            pm_relax(rproc->dev.parent);
> >
> > If we are here it means that rproc_crash_handler_work() has already been called
> > _and_ that a recovery is in process.  When the first crash handler completes
> > pm_relax() will be called and the device will go to sleep as expected.
> If the rproc->state cannot be changed to running state, the device will
> always be awake from this return.
> Also APROC_OFFLINE state can be given in other path like an shutdown
> request is issued.
>
> While this patch is not considering carefully as well, I think I need to
> upload a new patchset with an ordered workqueue to make each work have
> each pm_relax before return.
> what do you think?

I was travelling this week and as such did not have the time to
follow-up with this thread, something I will do next week.

>
> >
> > Thanks,
> > Mathieu
> >
> >>              return;
> >>      }
> >>
> >> --
> >> 2.7.4
> >>
>
>
> --
> Thx and BRs,
> Aiqun(Maria) Yu
