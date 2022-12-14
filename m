Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0D64C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiLNKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:43:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14593FAE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CACA619AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74081C433D2;
        Wed, 14 Dec 2022 10:43:19 +0000 (UTC)
Date:   Wed, 14 Dec 2022 10:43:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/2] mm/kmemleak: Simplify kmemleak_cond_resched() usage
Message-ID: <Y5moxP0l4j8z/GG9@arm.com>
References: <20221210230048.2841047-1-longman@redhat.com>
 <20221210230048.2841047-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210230048.2841047-2-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 06:00:47PM -0500, Waiman Long wrote:
> The presence of a pinned argument and the 64k loop count make
> kmemleak_cond_resched() a bit more complex to read. The pinned argument
> is used only by first kmemleak_scan() loop.
> 
> Simplify the usage of kmemleak_cond_resched() by removing the pinned
> argument and always do a get_object()/put_object() sequence. In
> addition, the 64k loop is removed by using need_resched() to decide if
> kmemleak_cond_resched() should be called.

Not sure why we ended up with the 'pinned' argument, get/put_object()
can be nested.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
