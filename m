Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EBF6BBDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjCOTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjCOTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:54:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820411153
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A19DB81F18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6856C433EF;
        Wed, 15 Mar 2023 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678910066;
        bh=0Ogf5z7zGQ3ac3b00RiOxaszjgIv6vbqrXKM4psNy4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=luFvZF6tWoq9+enMeyRGeHx3K5LM6uqvaPC1JWTQ+ccSzzAaM9m5opUHOWQS5QxTm
         uptNY/OAhKwAPxvnCLqjYTlSyQR9JPPW0gHeUXshLg6e54hnwz3UN6AcWBaZFeYEpp
         SoUm/n4D1dFCs1PqqPVeqGCloit0UncmyutFf4lc=
Date:   Wed, 15 Mar 2023 12:54:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, jannh@google.com, sjpark@amazon.de,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] mm: kfence: fix using kfence_metadata without
 initialization in show_object()
Message-Id: <20230315125425.70a22d32cf46b23d249775ec@linux-foundation.org>
In-Reply-To: <CANpmjNMxDT+AHBZra9ryhm6aw+WqBsdJ_SKdcdZr6CBsh97LyQ@mail.gmail.com>
References: <20230315034441.44321-1-songmuchun@bytedance.com>
        <CANpmjNMxDT+AHBZra9ryhm6aw+WqBsdJ_SKdcdZr6CBsh97LyQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 09:07:40 +0100 Marco Elver <elver@google.com> wrote:

> On Wed, 15 Mar 2023 at 04:45, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The variable kfence_metadata is initialized in kfence_init_pool(), then, it is
> > not initialized if kfence is disabled after booting. In this case, kfence_metadata
> > will be used (e.g. ->lock and ->state fields) without initialization when reading
> > /sys/kernel/debug/kfence/objects. There will be a warning if you enable
> > CONFIG_DEBUG_SPINLOCK. Fix it by creating debugfs files when necessary.
> >
> > Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Tested-by: Marco Elver <elver@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks, I'll add cc:stable to this.

I assume the warning is the only known adverse effect of this bug?
