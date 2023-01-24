Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBB67A3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAXUUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCB747403
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AF06132E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9F8C433D2;
        Tue, 24 Jan 2023 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674591616;
        bh=smoHtO6Rxx/MQd2CG0hXbAgi3D12tB1U0x9u3JHQYBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vHjd0emlZCbp/M8xwZ6WhpfPiT4YjtXSw+1iA/p4T/2yJqmdCM9b1vk+SvP4l0EBZ
         13R3a4Voy5tNLzRdgIkEK6euRkjlZl0jwBP55Bg9fHm8RhCjNR+1Tgrl6ILU9SHv0C
         AN+zSC2ezjZ5V0cxicdyleJ67jmP/G466tNN4bAM=
Date:   Tue, 24 Jan 2023 12:20:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-Id: <20230124122015.9f4e93e197153183085afbff@linux-foundation.org>
In-Reply-To: <Y8/96eIu47UfqsWO@arm.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
        <Y8gpfgEXtialPVLk@arm.com>
        <Y8neaPB2y689WKOf@google.com>
        <Y8/96eIu47UfqsWO@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 15:48:57 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Thanks for digging this out. This patch shouldn't have ended up upstream
> (commit 972fa3a7c17c "mm: kmemleak: alloc gray object for reserved
> region with direct map"). I thought both Calvin Zhang and I agreed that
> it's not the correct approach (not even sure there was a real problem to
> fix).
> 
> Do you still get the any faults with the above commit reverted? I'd
> prefer this if it works rather than adding unnecessary
> kmemleak_alloc/free callbacks that pretty much cancel each-other.
> 
> > I'm not sure if that commit is appropriate, given that reserved regions
> > that still have their direct mappings intact may be used for DMA, which
> > isn't appropriate for kmemleak scanning.
> 
> It's not. I think it should be reverted.

Could someone please send along a patch to revert this, along
with the explanation for doing so?  And please consider a cc:stable.
