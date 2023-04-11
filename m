Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFF6DE5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDKUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDKUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786C3C11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B479F623CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F37C433EF;
        Tue, 11 Apr 2023 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681246082;
        bh=/wdeyyx7dv1HsPlpNEj9Dj0LTQdnHO4YhWLcKbfowbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yvkJo8w5JRqMbsDaKL0WE+RV+xa72xSSyH3AtInII8c9HGUqW8Bw/v5EspEjXw/yi
         Nzx07fMbxXI9usH5NoJlJ5iYqax54AtHi/KMi/JEsUSGjoXYIBHEs3TpRjmZ7pnSIQ
         kLYH8XJzneET2Y/jBw+pS3ytqmsllwmKZK8xWz8E=
Date:   Tue, 11 Apr 2023 13:48:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wenyang.linux@foxmail.com
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: optimize compact_memory to comply with
 the admin-guide
Message-Id: <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
In-Reply-To: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
References: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 02:24:26 +0800 wenyang.linux@foxmail.com wrote:

> For the /proc/sys/vm/compact_memory file, the admin-guide states:
> When 1 is written to the file, all zones are compacted such that free
> memory is available in contiguous blocks where possible. This can be
> important for example in the allocation of huge pages although processes
> will also directly compact memory as required
> 
> But it was not strictly followed, writing any value would cause all
> zones to be compacted. In some critical scenarios, some applications
> operating it, such as echo 0, have caused serious problems.

Really?  You mean someone actually did this and didn't observe the
effect during their testing?

> It has been slightly optimized to comply with the admin-guide.
