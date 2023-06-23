Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31473B0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFWGhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWGhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:37:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47119AB;
        Thu, 22 Jun 2023 23:37:33 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687502250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFT78m20kv5Zp0OWG9o9DdfECnlPgnpU2lfqbrc0Nbo=;
        b=4T3Sz18MnmUimjVRkNoAm3Fu5/eHk6ybOUbOYWBpO402H9BWYf2eWbpUn2RB4TWo3bbMdF
        PUh2CZEDl0cAEqQFZ74o1/g2zCuy+ZNJKwn2KC5O6y8foZsDc0uMmltY9PWaFJFdAQOjQ/
        J5BTyJejsz3K5ht7ueZzaCGfkeM4vg6xQWVrmiDCbHY1vZaYniXwDAgooqwMj1l4xq7qOY
        2fUW3AK8oBOgMbsRrUnNg4vLFhKRmy6nNKv7bRo2S2BuGLm13yePZPomjbpBNVdecpMzCQ
        0pkwgvmVPq58SjfB1KCQvAIrlv0BLgcRxlJpAHOC2eiia1Ia21LIJp0VTDwLYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687502250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFT78m20kv5Zp0OWG9o9DdfECnlPgnpU2lfqbrc0Nbo=;
        b=4AZg7Crmy4sooozGf5+58z1+wkgZjvwgAY6qEBanFmt8OT6GujGaYk7HW+e47rsfzV2WpX
        Fr9JYVfCbS914oBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230623063726.ejuc6v9D@linutronix.de>
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
 <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-21 16:59:31 [-0700], John Johansen wrote:
> > Which turned a per-cpu cache into a global memory pool protected by a spinlock. It may benefit RT, but it does not appear to be so great at scaling.
> > 
> it is not. And I have a patch that needs some more formal testing for some stats.
> Ubuntu pulled it in last cycle so it has gotten a fair bit of use and is looking good
> on that end. There are probably some tweaks that can be done to improve it. The
> backoff in particular is something that has mostly been adjusted in response to some
> basic benchmarking.
> 
> anyways patch below
> 
> commit e057e9b47f1749882ea0efb4427d6b9671c761ab

I think I've been looking at this patch, or a former version of it, and
it looked good.

Sebastian
