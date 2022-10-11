Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37485FBB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJKTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJKTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:12:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833C38478
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2C7CCE17F8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886E1C433C1;
        Tue, 11 Oct 2022 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665515525;
        bh=Z274Y55fxl3ROLH7kNnUBLHGgVMegcngw5GKYKX5RFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTzJKMTBkVOb0LyiFYAXUmupa/oDlihFElTSf/sEko+55LLXjrpw6jeqifcPcwdgH
         c60tbV68fcWGFqtcQTV1UW4x+ncz2+zY12coVvclNoYLT3jG0ouCi7aMr7d9LPE9ar
         wNF3jEwq5Fe5mqEJNQOgEBxR/0woO5vyEbE3imUK44gqoQIryURrq70v5ZqGeK3GXw
         PW9w/HtQHrq9k7c6vlb8dFDQFdD9dD1Sq97KdG8mgOw3DGL73rgc8YQ30N5coeeIUL
         k4ypNyK4oY72wQzvnq0PNBNpMd4MRi05iyUyxc+jcLwMdxlhe/VYy/ojI8pZJtwfqO
         kzqyF0D4nsjdA==
Date:   Tue, 11 Oct 2022 21:12:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/20] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v5
Message-ID: <20221011191203.GA1051279@lothringen>
References: <20220628131619.2109651-1-frederic@kernel.org>
 <43a38198-d80f-2135-646c-db7e7990a401@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a38198-d80f-2135-646c-db7e7990a401@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 07:37:48PM +0800, Xiongfeng Wang wrote:
> Hi, Frederic
> 
> Thanks for push RCU dynticks counters to upstream. It is very useful. After it
> is done, do we have plan to revive the sys-idle feature and use it to shutdown
> the tick on the last housekeeping when the whole system is idle. I'm very glad
> to help test it if you have some demo patches on your personal repo.

There is no plan yet but some other people seem to be interested. Would you
like to try to revive it yourself? Otherwise I may do it someday but I 
have quite some work to complete first (ie: making CPU isolation tunable through
cpusets).

Thanks.
