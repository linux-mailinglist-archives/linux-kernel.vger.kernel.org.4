Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C16FE09B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjEJOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbjEJOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:41:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D99268E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:41:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683729670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2Qh6i4Y+AB0pDG6u/iYkTlhIK7xQT7b36qrwW0oarA=;
        b=3uewY1C7KOXhSuvl1De6gi9NZzV1cOm2flGjELQem0gRhXBtDrycninQeL2Hb5GoZqUghu
        Q3oIOJ7LuWlrUZNJb49WBmLVqxGGRRjwEdJqXXKyJwISvxUY15uqXaksugkuxxtHJ6zMkN
        qB3Kw9vI9J5XN4gkEkMuH8o6dC7z32+ZO14zUMnO7GzPFU30ia2QjdVLbRcAcdCSNvOpf6
        RHBxQDn2l3AhPhbwQgsCaQDWTN6dFl0OvydSLDvQ31SB+gUn32Bn72ZPdvrSUEOAtng7Nw
        vdDW5yBX+VyAiaqI1rT2Zuas5x/ecR2IGvrAWtEjjMrtc5fCjrNoOer2NdkeJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683729670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2Qh6i4Y+AB0pDG6u/iYkTlhIK7xQT7b36qrwW0oarA=;
        b=trce9v7ndgkCG97sqWC7ONvp59REw9dhfEULHP6zIDcTMl2qCslDv1Sgd1Z9B61gH70GKw
        U2qDk7+OkSfqxbAw==
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <ZFtGvfDFLyHeFVFH@yujie-X299>
References: <202304251035.19367560-yujie.liu@intel.com>
 <87a5yuzvzd.ffs@tglx> <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299> <87mt2f2mhm.ffs@tglx>
 <ZFtGvfDFLyHeFVFH@yujie-X299>
Date:   Wed, 10 May 2023 16:41:09 +0200
Message-ID: <87ttwkxn96.ffs@tglx>
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

Yujie!

On Wed, May 10 2023 at 15:24, Yujie Liu wrote:
> On Mon, May 08, 2023 at 11:36:37AM +0200, Thomas Gleixner wrote:
>> Ok. So one difference might be that a 64 bit kernel enables interrupt
>> rempping. Can you add 'intremap=off' to the kernel command line please?
>
> Sorry, my previous info was incorrect.
>
> The block/008 (do IO while hotplugging CPUs) failure also happens on a
> 64-bit kernel no matter having 'intremap=off' or not, and persists when
> tested against v6.3, but the warning in default_send_IPI_mask_logical
> function is not triggered on a 64-bit kernel. Not sure if that function
> is 32-bit specific since it is set in arch/x86/kernel/apic/probe_32.c.

Ok. That makes more sense as the issue is clearly independent of 32 or
64 bit.

I decoded it by now and that maple_tree conversion is the culprit. It
broke irq_get_next_irq() which is used during hotplug. It misses every
other interrupt, so affinities are not fixed up.

Please ignore that series.

Thanks a lot for your help!

       tglx
