Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019D62DC23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiKQM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiKQM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:58:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E243AD3;
        Thu, 17 Nov 2022 04:58:58 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l8so2545543ljh.13;
        Thu, 17 Nov 2022 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M57t7OTYcTJSURkZCimQgbB4Jr0X+04ID9CvGlRIYw=;
        b=UP34KdXI2/OgF70xNfa2goOp9brX4OwQZBDswcubWNdwRgwVK4rJTcDlD0tFWbPzpq
         5wRnHHSoO/9L7CuMY6jzi1jbE9T3vK1mczWnzoJm84STvjjcQodQgxwRbKugDX4Wbk5L
         mH+jITgl3PNOgLUUl8YAUoUn4ehLW9FC1VJ0IW9sbB2CSXAfSRcFtqTl7LgcmpXZSh+O
         Ck8NAOzXBjK2np4NbJM8r27pJzeUapbyStJ7WcevzAqjOoGbMH7cmKFGDQgkApoILMs/
         prEyTMncyPxHbnMCNiuUEqDW5fAE9qvJOERc8FZNeSlMsJ/rOhQDT6jsme8PYEn8s49s
         6/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M57t7OTYcTJSURkZCimQgbB4Jr0X+04ID9CvGlRIYw=;
        b=lfQHY3A2PFQKwsutBH29PAtmfoBzr5Af7jyWl6KVNlLVOe3ukNiMnsTMelW7JG7JPf
         hrbIPS2Oz41AQ1fm5FMNzd7RH0yTjwPGeRsE+TlYKUyuj7qE5/Oc7NMprNG4y7CB9eQW
         vTtKlYHCPB8BzNb1MAjrKki02ESBHw2n/sV/jTVFpBiGEQ73mq3i3iOVRrad6jp3sL0E
         134UIqT/ZZEm5u0hFX6c11IUpHjmWPzL8+1rQzRyX5IQSGYxbwKX3VPlOrUPcJ4YxyD9
         y6mVdR0+s20IFoByMX8SlfvvwlhhJWZdrqBuIE+5X4wVUUnwKE7xgaARiUwXA8GO9NLe
         J7bA==
X-Gm-Message-State: ANoB5plR9ToUq30lWcPaycG4AO9uHq5F+THjPWbzX49nco5kWJevGvkT
        t3CvyVh++1HPEhfmXHTvgSY=
X-Google-Smtp-Source: AA0mqf7st/5wwsDYJQtakeDuEYYh6gQHjTSvgKCecK6CrMPFGlT6HYFaePwvZ95gxNfflboIqyyTSg==
X-Received: by 2002:a05:651c:247:b0:278:fa62:bc91 with SMTP id x7-20020a05651c024700b00278fa62bc91mr900665ljn.100.1668689936666;
        Thu, 17 Nov 2022 04:58:56 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id q30-20020a19431e000000b0049735cec78dsm140026lfa.67.2022.11.17.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:58:56 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 17 Nov 2022 13:58:54 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3YwDuKibmOiz6/7@pc636>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636>
 <CAEXW_YR8ycdF0Y80p2qKXQm3Qc+XA441jQZ3uiHk=TbaXngNkQ@mail.gmail.com>
 <Y3OPI/pWZ5jf4X9y@pc636>
 <Y3U3zPzLMux8fpVY@pc638.lan>
 <CAEXW_YTVmGnC_aBNQ49OfNiD+CX1VX0-R6c_3mNZNvvAoAw0hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTVmGnC_aBNQ49OfNiD+CX1VX0-R6c_3mNZNvvAoAw0hA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:05:46PM +0000, Joel Fernandes wrote:
> On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > Hello, Paul, Joel.
> >
> > > >
> > > > Yes sure, I am doing a run now with my patch. However, I have a
> > > > question -- why do you feel blocking in the kworker is not an issue?
> > > > You are taking a snapshot before queuing the normal kwork and then
> > > > reading the snapshot when the normal kwork runs. Considering it is a
> > > > high priority queue, the delay between when you are taking the
> > > > snapshot, and reading it is likely small so there is a bigger chance
> > > > of blocking in cond_synchronize_rcu(). Did I miss something?
> > > >
> > > We can wait indeed in the reclaim worker. But the worker does not do any
> > > nasty or extra work here. If there is a need we block and wait. After a
> > > grace period, we are awoken and proceed.
> > >
> > > Therefore i do not see the reason in handling two cases:
> > >
> > > if (gp_done)
> > >     queue_work();
> > > else
> > >     queue_rcu_work();
> > >
> > > it is the same if we just queue the work and check on entry. The current
> > > scenario is: queue the work after a grace period. This is the difference.
> > >
> > > Right if the reclaimer was a high prio kthread a time would be shorter.
> > >
> > > In your scenario the time seems even shorter(i have not checked) because
> > > you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
> > > basically even though you have objects whose grace period is passed you
> > > do not separate it anyhow. Because you update the:
> > >
> > > krcp->gp_snap = get_state_synchronize_rcu();
> > >
> > > too often.
> > >
> > Once upon a time we discussed that it is worth to keep track of GP
> > per-a-page in order to reduce a memory footprint. Below patch addresses
> > it:
> 
> In the patch below, it appears you are tracking the GP per krwp, and
> not per page. But I could be missing something - could you split it
> into separate patches for easier review?
>
I will split. I was thinking about it. The GP is tracked per-a-page. As for
krwp it is only for channel_3. Everything goes there if no-page or no cache.

> 
> Also it still does cond_synchronize_rcu() :-(
> 
Sometimes we need to wait for a GP we can not just release :)

--
Uladzislau Rezki
