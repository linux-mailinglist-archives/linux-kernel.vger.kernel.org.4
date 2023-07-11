Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6674F868
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGKTcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGKTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A410D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 430BE614E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5584AC433C8;
        Tue, 11 Jul 2023 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689103966;
        bh=WbGGH319GGiAliOny1Q0FGLHKF8BtHi4+zSqoKNuvBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a2ZSyKfkoLOLhvWO8FGdNVPfSyG27ErAEjli61nTXq9TEUiz31rUOWB0Bwa24zBlR
         bWe9aFNV2pjACx1jIHzhbZyXmky5VZTfH1HqoKDdAhDacDOYXhwg2HKVzoEwh3vrQ4
         niTbR3LtGB2DB9HZ5LfrLHt4N7Sh8KFYbEt0tX0c=
Date:   Tue, 11 Jul 2023 12:32:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-Id: <20230711123245.473400853fd1227459017650@linux-foundation.org>
In-Reply-To: <20230710230450.110064-2-sidhartha.kumar@oracle.com>
References: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
        <20230710230450.110064-2-sidhartha.kumar@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 16:04:50 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Remove special cased hugetlb handling code within the page cache by
> changing the granularity of each index to the base page size rather than
> the huge page size. Adds new wrappers for hugetlb code to to interact with the
> page cache which convert to a linear index.

folio_more_pages() was just removed by "filemap: add
filemap_map_folio_range()"
(https://lkml.kernel.org/r/20230710204339.3554919-35-willy@infradead.org).
It looks like simply dropping that hunk is OK, but please check.

I'll be pushing this all out in a couple hours I expect.

However the series which contains "filemap: add
filemap_map_folio_range()" might be about to be dropped because of
possible s390 breakage.

Also, I don't think it's necessary to have a [0/N] intro for a single
patch.  Maybe crunch all the (useful) info into the single patch's
changelog?

Thanks.
