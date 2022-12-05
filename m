Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E936435B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiLEUdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiLEUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:32:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E2E66
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8150CE13B4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749EDC433C1;
        Mon,  5 Dec 2022 20:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670272371;
        bh=515qPF4ILAV8vNYwyWFbsUeaPOTzvoOjmq/jBopabaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/hMUbqTKq2RpqhtLTtSqvnB3UePKDLYa4bTgvhyBCituIaZq4/FEhJugYyOdqR+Q
         SuS9dEKxP42yQfYIkuFhoSHa3VK3fy5468En0AEt0mvdRoQZtTA0zye3V7+Ahal8wx
         vff0ASaVF0gOM0MBWn4BS70YfOOOmS0OdBNzNlMc=
Date:   Mon, 5 Dec 2022 12:32:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously
 incorrect VMAs
Message-Id: <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
In-Reply-To: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
References: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 19:23:17 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Add more sanity checks to the VMA that do_brk_flags() will expand.
> Ensure the VMA matches basic merge requirements within the function
> before calling can_vma_merge_after().

I't unclear what's actually being fixed here.

Why do you feel we need the above changes?

> Drop the duplicate checks from vm_brk_flags() since they will be
> enforced later.
> 
> Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")

Fixes in what way?  Removing the duplicate checks?
