Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31252712409
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbjEZJtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbjEZJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4CD9;
        Fri, 26 May 2023 02:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A975B61248;
        Fri, 26 May 2023 09:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFCCC4339B;
        Fri, 26 May 2023 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685094588;
        bh=4rlsbDU/W6bbh6jxRAewvlT8eB/L1MX7PjShMljsAF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IEoxOTmEcdpGmMTIpJ641rXpC63sF/0VHHlvSgJKQTdkA6ILfSFxdjOkQ5DA5OPMv
         BFRf8HXxwRu10vPVfCZnIsgq5wGCQPLOyT08DbHqyPa+vR8dXM7ZuxtLM8inODLHB1
         vVBi6HHEC3sLLR60QAkJBrw3VEpGYJk7tUNrwdeeEtNwoMCfKwIuz0lD+/dLLsAgyD
         Lv5iX4x+DBbgeSflYMYahIj48bn8TV45j4DZhOeKOEM/9mdABwxMLz/AOcroGKLWbU
         U9lu58Fz3ADOo0XzAFuherq5N7e3IZ/139h5tGFRtHUpwC+lFsXCNQZoTRLjjbk0sj
         YcRUcBAuarjFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37B9ACE0CCF; Fri, 26 May 2023 02:49:44 -0700 (PDT)
Date:   Fri, 26 May 2023 02:49:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.05.20a] [rcuscale] 812195e4f7:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <59850ca7-aad7-4756-888e-12f62373198b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202305241757.57c30887-yujie.liu@intel.com>
 <e4328f8b-6ec5-46eb-bc43-1217feba7ca2@paulmck-laptop>
 <ZHBm9IfDk1QGj8SY@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBm9IfDk1QGj8SY@yujie-X299>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:59:48PM +0800, Yujie Liu wrote:
> Hi Paul,
> 
> On Thu, May 25, 2023 at 09:45:11AM -0700, Paul E. McKenney wrote:
> > On Thu, May 25, 2023 at 01:37:13AM +0800, kernel test robot wrote:
> > > Hello,
> > > 
> > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > > 
> > > commit: 812195e4f70ef0e9fc68127355c553c537749546 ("rcuscale: Measure grace-period kthread CPU time")
> > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.20a
> > > 
> > > in testcase: boot
> > > 
> > > compiler: clang-14
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > +---------------------------------------------+------------+------------+
> > > |                                             | 2393139b67 | 812195e4f7 |
> > > +---------------------------------------------+------------+------------+
> > > | boot_successes                              | 8          | 0          |
> > > | boot_failures                               | 0          | 8          |
> > > | BUG:kernel_NULL_pointer_dereference,address | 0          | 8          |
> > > | Oops:#[##]                                  | 0          | 8          |
> > > | Kernel_panic-not_syncing:Fatal_exception    | 0          | 8          |
> > > +---------------------------------------------+------------+------------+
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202305241757.57c30887-yujie.liu@intel.com
> > 
> > This commmit has since been replaced by this one, which should fix this
> > problem:
> > 
> > 60901dadfadc ("rcuscale: Measure grace-period kthread CPU time")
> > 
> > Please let me know if the problem still exists with that commit.
> 
> The problem is gone on commit 60901dadfadc. Thanks.
> 
> Tested-by: Yujie Liu <yujie.liu@intel.com>

And thank you again for your testing efforts!

							Thanx, Paul

> =========================================================================================
> compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>   clang-14/x86_64-randconfig-a015-20230522/debian-11.1-i386-20220923.cgz/300/vm-snb/boot
> 
> commit:
>   812195e4f70e ("rcuscale: Measure grace-period kthread CPU time")  <-- old commit from dev.2023.05.20a branch
>   60901dadfadc ("rcuscale: Measure grace-period kthread CPU time")  <-- new commit from rcu/next branch
> 
> 812195e4f70ef0e9 60901dadfadcc152ae5cad7ebae
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>           6:6         -100%            :7     dmesg.BUG:kernel_NULL_pointer_dereference,address
>           6:6         -100%            :7     dmesg.Kernel_panic-not_syncing:Fatal_exception
>           6:6         -100%            :7     dmesg.Oops:#[##]
>           6:6         -100%            :7     dmesg.boot_failures
> 
> --
> Best Regards,
> Yujie
> 
