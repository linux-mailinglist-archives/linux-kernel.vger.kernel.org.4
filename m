Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872816FE0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjEJOtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbjEJOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF3729D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:49:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683730150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4PYrEGEMOXxEV1AQsfzfB+2VLVGomw+1pc/feFlh8k=;
        b=I58W9uwEUu+oijCma024t84oIIWSBKw+u1WidIGL+32fFMRJ9FuTX91aLf1APgNOZAk61G
        xYlXRSEjM88VmlrFrl6deXwDoliC83OY8iOOaxB466V4LtkSNBuLoEi1CiuZKThtxqWFeo
        HPn7qy76FP63mrcv9Ju58gHyIbl6rIlmXyzo17ZRGy+nTdewOsuYgZ9P61IlowH/RWdJmh
        B4Ma+SzcYh+H2cvj9eHjzkVXMbIOLp0gR8ZG4ZWPJAn7YOyBV+7lnbutuRV5bzHSY/526/
        J0WspvheJfugFVOqMb5ERXRzehSHELup2U/ZBhHH5qol9t3ca340aEbDYV03yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683730150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4PYrEGEMOXxEV1AQsfzfB+2VLVGomw+1pc/feFlh8k=;
        b=rJeZ6FMWzGCVxkB5c5jXVdpdLSCmGVDQ4Zx/cp4cgm0YiJ57TzaoRD237GTvkoKxGwi8ll
        RytN5awKpztnwhDg==
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <87ttwkxn96.ffs@tglx>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx> <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299> <87mt2f2mhm.ffs@tglx>
 <ZFtGvfDFLyHeFVFH@yujie-X299> <87ttwkxn96.ffs@tglx>
Date:   Wed, 10 May 2023 16:49:09 +0200
Message-ID: <87r0roxmvu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanker!

On Wed, May 10 2023 at 16:41, Thomas Gleixner wrote:
> On Wed, May 10 2023 at 15:24, Yujie Liu wrote:
> I decoded it by now and that maple_tree conversion is the culprit. It
> broke irq_get_next_irq() which is used during hotplug. It misses every
> other interrupt, so affinities are not fixed up.

I'm seriously grumpy. You throw that untested stuff over the fence,
pester me about merging it and then ignore the fallout.

This breaks cpuhotplug, debugfs, /proc/stat, x86/IOAPIC and some more.

It's not asked too much that if you change an iterator implementation to
validate that the outcome is still the same on the usage sites.

That change has never seen CPU hotplug testing. It reproduces
instantaneously in a VM even without running blktest.

I grant you that the documentation of mt_next() is incorrect, but that's
absolutely no excuse for not testing such a fundamental change at
all. It's neither an excuse for ignoring the fallout and wasting other
peoples time.

I'm dropping this from my to-merge list.

Yours grumpy

      Thomas
