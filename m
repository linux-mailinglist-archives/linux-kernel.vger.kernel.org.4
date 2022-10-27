Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B860FD90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiJ0Qxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiJ0Qxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:53:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3906B64D;
        Thu, 27 Oct 2022 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/U8S3Hm7GM0N6bSRIg6fGWmqOXH9FpB3PcS4vcOVE4s=; b=LssFHjU3t3g7NhCPsPAUbQXcNS
        /acApWjgm1hBREBZAMSdkS+j4BidQLmuo0qgb16z1ZemttbxkkAiAhb3KNonWYweDrx9fmJwx2+eJ
        HscLMxV5H4nw3V1np3WxeeY8HKUIaYtDjvFGi21dnd2vxyXIsGjyYtbBe/Zxlmj9thgIWDc8eAc0b
        adhHkvlG35IqPDYoV+kT6hiHUBye/VPnBk6WB8AVsenW87uV37WQn7PBbkBKquyoWW0c8wCVgTKLv
        5AqWnbk0e0eIqrWQOIeZv6MFdezzYUn3IZxlaH4wQLgYDzAdkUGRE8u/LKOjNz+7UsRWKPmowhbPF
        aIDUDNzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo68C-006uwr-8y; Thu, 27 Oct 2022 16:53:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3746230020C;
        Thu, 27 Oct 2022 18:53:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BEDC2C646598; Thu, 27 Oct 2022 18:53:23 +0200 (CEST)
Date:   Thu, 27 Oct 2022 18:53:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y1q3gzbPUCvEMHGD@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
 <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
 <Y1qC7d7QVJB8NCHt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1qC7d7QVJB8NCHt@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:09:01PM +0300, Ville Syrjälä wrote:
> On Wed, Oct 26, 2022 at 01:43:00PM +0200, Peter Zijlstra wrote:

> > Could you please give the below a spin?
> 
> Thanks. I've added this to our CI branch. I'll try to keep and eye
> on it in the coming days and let you know if anything still trips.
> And I'll report back maybe ~middle of next week if we haven't caught
> anything by then.

Thanks!
