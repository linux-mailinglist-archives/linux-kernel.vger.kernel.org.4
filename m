Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49686915B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjBJAks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjBJAj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:39:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D723C60;
        Thu,  9 Feb 2023 16:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1B461C3C;
        Fri, 10 Feb 2023 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FBAC4339B;
        Fri, 10 Feb 2023 00:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675989544;
        bh=jEwmi6wnqlIOydXMYjIjJWBpR66lOa4Z2v2npxC57VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEb8v+Y2Mymj2T1mQ4Ou1HB2htonnJrWJmTIpYGb8Z0GZWG239wISKGZh+tkRmKyz
         IuwDIF8ufjaPBMV3OVD4fod3PMKKne6eT/0dYpOM7Emz9DhgNS1lIhCcym+1ptbxkO
         sQOobbu/n2sv3tqdBxSEfsqHGtfEO0zknTYULNOf0JCx/zjojpfztVLpYlgnOc3jS4
         +wghTXfWzzgJb+ibFXxe+26RycL2T1Pv8BVI3l/K1lcKrR4gNuje/3E/X2VOjPswnr
         8IlvjsgeGp+RbQbFKlFeEEnmFrrsd+9Xfm1ubGoaKmc9M5r1xYHrQngLe8qqB1VA4M
         Ye+mSqd71Xfdg==
Date:   Fri, 10 Feb 2023 01:39:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Message-ID: <Y+WSJRjlB4qDI1ul@lothringen>
References: <20230210000021.1007853-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210000021.1007853-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for checking this!

On Fri, Feb 10, 2023 at 08:00:21AM +0800, Zqiang wrote:
> For kernels built with CONFIG_NO_HZ_FULL=y, running the following tests:
> 
> runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" bootparams=
> "console=ttyS0 nohz_full=0,1 rcu_nocbs=0,1 sched_verbose" -d

Has this ever worked? Again I'm tempted to just:

    git revert 08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5

> 
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu2/online
> root@qemux86-64:~# echo 0 > /sys/devices/system/cpu/cpu3/online
> 
> [   22.838290] BUG: unable to handle page fault for address: ffffffff84cd48c0
