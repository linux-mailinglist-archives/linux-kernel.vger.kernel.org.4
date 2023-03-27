Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790296CAEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjC0TfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjC0TfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC262D41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 824A5B818CF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23AAC433EF;
        Mon, 27 Mar 2023 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679945716;
        bh=VV3ldEpOx0P39yJVKJBI5DINfFgk8FV4H4sar4q+pig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TbC+dyQaeBWfFc1BZYZAnhRD235FHY0HXhFMgibBTOECMpqJsBFYtJA5SoYDflYGc
         kadBO3aY3C7TExyYJOBzalBVRtAserOoUI9Ft8ietLPaiG9/ppSsPNnvadm2Cd3v3p
         gWhFZAHjYY0+WIpEMHQ+X7X7uhN0REDSYEzWKUn0=
Date:   Mon, 27 Mar 2023 12:35:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/8] Fix VMA tree modification under mmap read lock
Message-Id: <20230327123515.bce6c1ea3660e9b17db50c33@linux-foundation.org>
In-Reply-To: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
References: <20230327185532.2354250-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 14:55:24 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> These patches have been in -next since next-20230301, and have received
> intensive testing in Android as part of the RCU page fault patchset.
> They were also sent as part of the "Per-VMA locks" v4 patch series.
> Patches 1 to 7 are bug fixes for RCU mode of the tree and patch 8 enables
> RCU mode for the tree.

What's happening here?  I assume you've decided that the first 8
patches of the "Per-VMA locks v4" series should be fast-tracked into
6.3-rcX and backported?  And we retain the rest of that series for
6.4-rc1?

Patch [3/8] hasn't come through to me, to linux-mm or to linux-kernel.
