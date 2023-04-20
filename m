Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621BE6E93AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjDTMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDTMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CA19AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cfu30d15ow+avOD5lgzsB1BefQFrsp299WM+lwWiBEk=; b=oaOdSM1B7MdYwXCEKHrqG27tWs
        9KUuiFRuJBfJst+NFhbr1jUPCMSCozabAry2m3EkXTHfYDcNhdVc+g3CXNXkqTUu8tsFo7Z+G/J2Y
        UywJWtyVXi5CluJ+0ynUHHBZZhuEv+pwxZOu7I9WzC1/1tgX98k2uSztCKsMH2Fi1OMcUan0P5v6h
        ktKfRN+bwSDw4d0d+fhNE0UXfz9PIR2wtEfR0mOixmej8JGGFrI7ITUDW7XuLAD7KbBdcAozswkMa
        5IvVCFwxIO2Och28OqAeVGGfq/3bmPfwdnUkS5lYOScn/IdO9w1ql1IJX0TRGoGVrpBGOt9fS/Ebb
        yznLN8ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppT3u-00EEMu-Nk; Thu, 20 Apr 2023 12:06:54 +0000
Date:   Thu, 20 Apr 2023 13:06:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [Resend PATCH] mm: mark folio as workingset in lru_deactivate_fn
Message-ID: <ZEEq3lsyhswWzhYR@casper.infradead.org>
References: <1681980304-11719-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681980304-11719-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 04:45:04PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The folio will be set as workingset by shrink_active_pages during normal reclaiming.
> However, it will be escaped from doing so when madvise move it by lru_deactivate_<file>_fn,
> which will affect accuracy of thrashing.

Why are you resending this?  Johannes pointed out that your
understanding of this situation is wrong.  The folio is being
made _inactive_.  It's clearly no longer part of the working set!
