Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EF6E6E37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjDRVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDRVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF829118CD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D82B63943
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234BDC433EF;
        Tue, 18 Apr 2023 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681853324;
        bh=2SNZxN9hzt7Hcn612PhEVKLrSU4yAg5SPreBYxtfaP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TDvWQVGeqhj3/mWi/MRa3z2d2YtdyfUdrfzN4bDApR8Tccgr04pUJspvHZgMWe2sH
         KAVTt5BWR0pdykBB6joWO8tyUNmSIdqamNfJ5Hu2MwsWjSat5dIAPM4t4AitEminqe
         RzukRKpSuFilmu6UtJ5QUqZB4vOQeLzDzp70LC/8=
Date:   Tue, 18 Apr 2023 14:28:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>,
        himadrispandya@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, linux-mm@kvack.org,
        skhan@linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Message-Id: <20230418142843.4ef62be30f529458344fa0e0@linux-foundation.org>
In-Reply-To: <5dc97e10-8c64-4818-2642-dd8edb21c016@gmail.com>
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
        <20230331013301.ecgkjymaf3ws6rfb@google.com>
        <CAHbLzkoJ2zvKZpqd6NqikpCc8rGR02C87f0fPq8qwb1BF3K+9Q@mail.gmail.com>
        <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
        <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
        <5dc97e10-8c64-4818-2642-dd8edb21c016@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 22:28:51 +0400 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:

> Tested today on the latest rc7, the bug still exists.

OK, thanks.  I'll send this patch upstream during the next merge window. 
If you, Zach or someone else decides to remove SCAN_STORE_FAILED and
perhaps those WARN_ON_ONCE()es then we can address these things later.

