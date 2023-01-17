Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9752166E868
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjAQV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAQV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:26:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CFD4C6E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:45:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so48604897lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVHl3CyYmBwOxeuIn2rI4GuiLJQNlWei9nWh+ruH28g=;
        b=OgRLjzfKd5KOKCaXGS+Y2kcI38Z+2Yub/6sPZFuD77pvpFzZlLpKlvxeWe1gz7pwap
         yKN0UWxUcLWGSOaCLuvUti/tne5oRXq/e0+qWi07lmVabjRBVLXIRoel+B2yVFLYc0zv
         TLq9idplrIeMg0mzOH2KnnszI7v9PUo1v8SA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVHl3CyYmBwOxeuIn2rI4GuiLJQNlWei9nWh+ruH28g=;
        b=Sly7fZMZhpxFacA1pZm2mCjWIZnMlRksZQlNGQj3XIX2FAbmv2pfrk6SXa6Q9yvor2
         TcbUqOEx3QVov1Nil43cQCchYO6FhYrYj9zm8NrvRkXnkYVvrEDw3jGYc5WFMDCimCL5
         HlHwqtwQIqaLQgbX9d+y4Mx99BkKPCb3JS0W8Nr7cWww/6HyXOOzXLYA5jTLL/k3VPfM
         uY6nLoCQuw0DCxTANryuciiFVy5Otz76M4AC9nri68xA/hL0IBe4CDrYhnscstF3IdO6
         JsFZdZb0j2zkwgg2QLnX1Y+erM4/fdwxrmdvMKmrkkS6mJ9c+LiSRYKhydj4HDrML63A
         Ns/w==
X-Gm-Message-State: AFqh2kr0Ks6FqB1w3TmqfTfQBwiTLB2FY+OIBIfCif9fC/OoyYZuG1Uy
        iujdbVlPyds4xhK10qE1ZzHIFUtDKEHBoRfSz+IPeQ==
X-Google-Smtp-Source: AMrXdXuzz3EDyHUSdqZSl1JThqJwC2ye2DRobi9jaBxz9vJJTfFX5SHt4UHysiacaNRt8YrvXGQ+4o3NF4WuZiO7D0E=
X-Received: by 2002:a05:6512:39ce:b0:4aa:148d:5168 with SMTP id
 k14-20020a05651239ce00b004aa148d5168mr228410lfu.561.1673984723933; Tue, 17
 Jan 2023 11:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230115162504.08ef72b0@rorschach.local.home> <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
 <20230117143224.6fbf7da8@gandalf.local.home> <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Jan 2023 19:45:12 +0000
Message-ID: <CAEXW_YRYuroym5e4ApJ8oYofsocVj6ApCmCCf07kfJy=PD-9ww@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 7:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jan 17, 2023 at 02:32:24PM -0500, Steven Rostedt wrote:
> > On Sun, 15 Jan 2023 16:34:58 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > > > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> > > > >
> > > >
> > > > Where do you plan on calling these externally, as they are being
> > > > marked exported?
> > > >
> > > > If you allow random drivers to enable this, I can see something
> > > > enabling it and hitting an error path that causes it to never disable
> > > > it.
> > >
> > > You mean, just like rcu_expedite_gp() ?
> > >
> > > > I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> > > > needed externally.
> > >
> > > At the moment it is not called externally but in the future, it could
> > > be from rcutorture. If you see rcu_expedite_gp(), that is exported
> > > too. I was just modeling it around that API.
> >
> > The reason for the export should have been mentioned in the change log if
> > the patch is not obvious to why it is being exported.
>
> Would something like this suffice?  With attribution, of course.
>
>         Export rcu_async_should_hurry(), rcu_async_hurry(), and
>         rcu_async_relax() for later use by rcutorture.

Looks good to me Paul, and thanks for the suggestion Steven!

 - Joel
