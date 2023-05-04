Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D126F68F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjEDKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjEDKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:16:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28472128;
        Thu,  4 May 2023 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gsECIUQqgZWVmtyCs0d/qSHL8f2CR0oUbiSXmdx/aXQ=; b=ecdF9meQsYMxekqiG3qKkBDmlm
        xkitMCwc7VbbEApg3ONkQVzJxyCCMXrZ2iYfpTk28l3dEDvvTAqrJ5KYEwihCsLrh/BAoOMAPQX0G
        OT3u3/v0XpgAgK1lTQ7Dovu9hM9N91ywoxF8em0kPFuH5ejSswlH4Rr3vEl5dtgKY6DlKETRslQHN
        U9NMeWkktgPy9+fvLrlyEmMiC7mw4tPZn/2GYyN00uzMfIhxdUQ0UaB+1+esgxEpt6RFcMcHiIpem
        MPd44oLPklrGyz516qpf9q/sAMLiO8EVYkEWf1qjiIZP92GgXPAtrEiKmghZX/qBmCqFnC/Q1MGm8
        KC8471/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puW0O-001hzF-22;
        Thu, 04 May 2023 10:16:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E96EF3003CF;
        Thu,  4 May 2023 12:16:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA78F241A3588; Thu,  4 May 2023 12:16:06 +0200 (CEST)
Date:   Thu, 4 May 2023 12:16:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     kan.liang@linux.intel.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
Message-ID: <20230504101606.GA1735197@hirez.programming.kicks-ass.net>
References: <20230421184529.3320912-2-kan.liang@linux.intel.com>
 <202304251457.d108dbb3-yujie.liu@intel.com>
 <20230504091123.GJ1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504091123.GJ1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:11:23AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 03:16:29PM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "Kernel_panic-not_syncing:Timeout:Not_all_CPUs_entered_broadcast_exception_handler" on:
> > 
> > commit: a17c97370d1fb9b2eac75c85136a1f70ec44eded ("[PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update")
> > url: https://github.com/intel-lab-lkp/linux/commits/kan-liang-linux-intel-com/perf-x86-intel-ds-Delay-the-threshold-update/20230422-024743
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 15def34e2635ab7e0e96f1bc32e1b69609f14942
> > patch link: https://lore.kernel.org/all/20230421184529.3320912-2-kan.liang@linux.intel.com/
> > patch subject: [PATCH V4 2/2] perf/x86/intel/ds: Delay the threshold update
> > 
> > in testcase: kvm-unit-tests-qemu
> > 
> > compiler: gcc-11
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Link: https://lore.kernel.org/oe-lkp/202304251457.d108dbb3-yujie.liu@intel.com
> > 
> > 
> > [  179.997768][ T2324] 2023-04-23 15:30:10 ./run_tests.sh
> > ...
> > [  180.442663][T20263] x86/split lock detection: #AC: qemu-system-x86/20263 took a split_lock trap at address: 0x1e3
> > [  182.372875][ T2324] 
> 
> I'm going to try and replicate this on my ADL which should have
> split_lock crud on. How does one run this kvm-unit-test stuff, inside
> kvm or on bare metal?

Bare metal it is..

Anyway, on the ADL I can see the split lock thing with or without the
patches in question so thta can't be it.
