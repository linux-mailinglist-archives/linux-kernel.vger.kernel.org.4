Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2E6A50B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjB1Baa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjB1Ba2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:30:28 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475425245
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:30:27 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cf14so8915699qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuMQ4R7Qcpzp+24B3X8Yl/9yUt6uqVFoa6RSbqcjeIs=;
        b=O/BNoI/bjDmKlfOByyzuulTXcHp5SUbRqGfj7S7wmalXNQbMw9EVxdYHrAseqJAKiN
         jLMgDufyroK/6c4CRtZePBt4DV1vdZp/RTM1LheCrhD365AVTTRvutIjw6YZTcx0VZfA
         eCwyTGl7qT4tK7neqUgNGkGQAexQEc03nXBjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuMQ4R7Qcpzp+24B3X8Yl/9yUt6uqVFoa6RSbqcjeIs=;
        b=REj2zB8T1WGVLvpUQEg0GP/xKODCac6F3S7n0/ow5BoTeWx8c935QpQkP8rXQhAUPI
         OcWFuo2cJVBFl6DbXCIUfs7Lc9xuZqJ3SiqRZYuClRJ2GT5jFCf0HB0GTwwkL24QA3Rs
         VrV4zw9TTokFWSJP5UPSs2nfFX6ePY20ngFq05XRNBWhNIF/em7eX8Ms2FfcroT+rROU
         mdsh0DjUeDb0stdx22uJY8RkEO/YXqff5R9T6m95V5ZKEVCXNVZKqL+eT0HxhIjoJOdb
         kP4gjhaGMSp4B2eyfc/lOVATi2a3BGwquA5P3owbWNhIsgr0pNu+TyLGHi/cMPCdt1YM
         QMXA==
X-Gm-Message-State: AO0yUKU+kahiJEQ64zCbH5+c5/1r5fRb7ou3Ly7DZ1mXF3CVcBNyCYyl
        8GIw8jcWRTZNdATRhCIOlbnhQg==
X-Google-Smtp-Source: AK7set+gzmpHwGjyqAH6OmnNysxwS8GhOVYZrcGN/dDY8QQ38IcGvcm+qQyKvVQ2LWTIavMzLD4X+Q==
X-Received: by 2002:ac8:5848:0:b0:3bf:a72f:d0bd with SMTP id h8-20020ac85848000000b003bfa72fd0bdmr2602796qth.3.1677547826325;
        Mon, 27 Feb 2023 17:30:26 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id g2-20020ac870c2000000b003b868cdc689sm5690048qtp.5.2023.02.27.17.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:30:25 -0800 (PST)
Date:   Tue, 28 Feb 2023 01:30:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/1ZMXsNZtwYPJNW@google.com>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/0/dnmIk508sidK@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0/dnmIk508sidK@lothringen>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 12:40:38AM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 27, 2023 at 03:05:02PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 27, 2023 at 02:10:30PM -0500, Joel Fernandes wrote:
> > 
> > The combination of sysfs manipulated by userspace and a kernel failsafe
> > makes sense to me.  Especially if by default triggering the failsafe
> > splats.  That way, bugs where userspace fails to update the sysfs file
> > get caught.
> > 
> > The non-default silent-failsafe mode is also useful to allow some power
> > savings in advance of userspace getting the sysfs updating in place.
> > And of course the default splatting setup can be used in internal testing
> > with the release software being more tolerant of userspace foibles.
> 
> I'm wondering, this is all about CONFIG_RCU_LAZY, right? Or does also expedited
> GP turned off a bit early or late on boot matter for anybody in practice?

Yes, if you provide 'rcu_normal_after_boot', then after the boot ends, it
switches expedited GPs to normal ones.

It is the same issue for expedited, the kernel's version of what is 'boot' is
much shorter than what is actually boot.

This is also the case with suspend/resume's rcu_pm_notify(). See the comment:
  /*
   * On non-huge systems, use expedited RCU grace periods to make suspend
   * and hibernation run faster.
   */

There also we turn on/off both lazy and expedited. I don't see why we
shouldn't do it for boot.

> So shouldn't we disable lazy callbacks by default when CONFIG_RCU_LAZY=y and then
> turn it on with "sysctl kernel.rcu.lazy=1" only whenever userspace feels ready
> about it? We can still keep the current call to rcu_end_inkernel_boot().

Hmm IMHO that would add more knobs for not much reason honestly. We already
have CONFIG_RCU_LAZY default disabled, I really don't want to add more
dependency (like user enables the config and does not see laziness).

Thanks!

 - Joel

