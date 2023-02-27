Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395AC6A4FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjB0Xkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjB0Xkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:40:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB642596D;
        Mon, 27 Feb 2023 15:40:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F68560D57;
        Mon, 27 Feb 2023 23:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B249C433D2;
        Mon, 27 Feb 2023 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677541241;
        bh=oYGfSP1jQ+oQxI9MEK053Arzs+AetogJWsAlkK1901U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbANs9xmu9YhQNFdX1EkZQUH3qFdDNgtZmdwYNO+W6NPmx5MVKfSFw7d9at24fgbb
         S+gyftqTmay9cEJGytle7rQTxiFGPci4ejFlJvens2xba4LaMHMs5+3/CsW4Ep3G3+
         LHowdroLMvyl+v/Cz96cuEJ9499EN1R4x1T2/RGFcPhA4IWAP5vdbKlktZGfBsb4HI
         /vVyWB53w9KAgy1/BRkLQYemwPDBx9Q0Kk+69zH7gMwudkEqgZ0KcldCBpZ8gtK8ap
         P076wavYZXRaC9146f14DI+J3e1C6/tOo78tITg0lDp4XrgRrsUp+ZpwyXKJn/dz9W
         QSYHFE+9DkHYQ==
Date:   Tue, 28 Feb 2023 00:40:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/0/dnmIk508sidK@lothringen>
References: <Y/z0fHHYdxEXcWMT@pc636>
 <7EBE4F51-F2BD-4B42-AFC1-CA234E78CC7B@joelfernandes.org>
 <Y/z9Its1RKetIr8V@pc636>
 <CAEXW_YSjT_orp8TbomBFU+ETS7YJ7TrbHTdrsBRTzCKG5_SBdw@mail.gmail.com>
 <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227230502.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:05:02PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 27, 2023 at 02:10:30PM -0500, Joel Fernandes wrote:
> 
> The combination of sysfs manipulated by userspace and a kernel failsafe
> makes sense to me.  Especially if by default triggering the failsafe
> splats.  That way, bugs where userspace fails to update the sysfs file
> get caught.
> 
> The non-default silent-failsafe mode is also useful to allow some power
> savings in advance of userspace getting the sysfs updating in place.
> And of course the default splatting setup can be used in internal testing
> with the release software being more tolerant of userspace foibles.

I'm wondering, this is all about CONFIG_RCU_LAZY, right? Or does also expedited
GP turned off a bit early or late on boot matter for anybody in practice?

So shouldn't we disable lazy callbacks by default when CONFIG_RCU_LAZY=y and then
turn it on with "sysctl kernel.rcu.lazy=1" only whenever userspace feels ready
about it? We can still keep the current call to rcu_end_inkernel_boot().

And if suddenly disabling lazy by default is an ABI breakage we can still add
CONFIG_RCU_LAZY_DEFAULT_DISABLED.
