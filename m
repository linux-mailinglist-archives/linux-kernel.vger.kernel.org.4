Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7915EC75D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiI0POY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiI0POV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:14:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273C1251B0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:14:16 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i15so6398537qvp.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jbmPaXjwsVDY1AN/HRtWM1ofxdcO2XSj8Vv58jSa1+U=;
        b=HeQBREf2pKuUYgS4eZIcHY8BNuj31cGuPueOiQUEHmUMRmz1K/eQOieKIDnMrFM6Gv
         zb9bF1NNPsnO7jhA9+Jb1/BmSK3lGWsV2jhv7js/c8fcOJZ9xIPgBs/eQjgaGuF/w6T0
         mwlV4fA6Q3CL6nd5UClqCcS2AwIPtrQT0Cad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jbmPaXjwsVDY1AN/HRtWM1ofxdcO2XSj8Vv58jSa1+U=;
        b=57jVAzLrMOXG0+jHveyMWWiQavI4aq64FrEe+Efu202GNTPkbW7lcJvT6WGY2qzWZO
         +fekd08FPAGQsRIwSdWb+02XY1R+xzSB4A46MExgwwBf6ExFO+X2GMg7YHyOHb//mXL7
         JTVkaYPpMQmkcgpSmDcQdkTZihyTubixmyFdPKFrSAvrZmaysrjdZqDQDnHHijAINETy
         GBElGIWlgXaGCz7ieuRA6MThXJbYFuk1Tc+6h1tMY+pfElB13vERL5xMn5/wFKHCCrNV
         b/ur/qhkOOfPVQ1VNLk2t6UsgTLRyXNLOOavv+jg+vKVSQ3EtdESp1/jfGIh4XCxGM3X
         e4NQ==
X-Gm-Message-State: ACrzQf3aTPAfjf/vrlByXKwYbfc+KOX+7BfzEG3n2m84mpMf7Uxs5bcf
        asQB6CZPhLKMUBHRFauHPXgsRQ==
X-Google-Smtp-Source: AMsMyM5qFpL6YVYNNOcjFaiePEUxR+p5LZkevzl6LVx2pIMIsxWABx/5VMEnMVA7XW7hljToBvef6g==
X-Received: by 2002:a05:6214:2629:b0:4ad:88cb:66ac with SMTP id gv9-20020a056214262900b004ad88cb66acmr17341441qvb.87.1664291655354;
        Tue, 27 Sep 2022 08:14:15 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id dt39-20020a05620a47a700b006bbd2c4cccfsm1159084qkb.53.2022.09.27.08.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:14:15 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:14:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzMTRrMKCnEMl/ov@google.com>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <YzH/646RHxhHBy6+@pc636>
 <YzIRg2u2JYXN9bnK@google.com>
 <YzMD0pdR6rvGSZ/o@pc636>
 <YzMI68pbXXVWWKEN@google.com>
 <YzMP4LaIUY8Dh9Nw@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMP4LaIUY8Dh9Nw@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 04:59:44PM +0200, Uladzislau Rezki wrote:
[...]
> > >    systemd-udevd-642     [050] .....    17.349832: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.349834: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-675     [012] .....    17.349835: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-675     [012] .....    17.349853: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-642     [050] .....    17.349861: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > >    systemd-udevd-675     [012] .....    17.349873: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.349879: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350007: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350011: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350080: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350175: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350362: dev_change_name: --> renamed from eth0
> > > <snip>
> > > 
> > > First delay:
> > > 
> > > <snip>
> > > systemd-udevd-645     [053] .....     2.339024: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > >   kworker/0:3-546     [000] d..1.     6.329516: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70effe40a0
> > > <snip>
> > > 
> > > __dentry_kill() function and after 4 seconds there is another one queue_rcu_work().
> > > I have checked the __dentry_kill() if it can do any sync talk with RCU but from the
> > > first glance i do not see anything critical. But more attention is required.
> > 
> > Can you log rcu_barrier() as well? It could be that the print is just a side
> > effect of something else that is not being printed.
> > 
> It has nothing to do with rcu_barrier() in my case. Also i have checked
> the synchronize_rcu() it also works as expected, i.e. it is not a
> blocking reason.
> 
> Have you tried my config?

Yes I am in the process of trying it.

thanks,

 - Joel

