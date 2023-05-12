Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1770100A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjELVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjELVD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745C35AD
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EBE60C0D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 21:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDEC433EF;
        Fri, 12 May 2023 21:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683925435;
        bh=nqsLqlAN3czrFKPz/1Q7lmk66avDWHKVM8stcgmsqnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dFurDZZ/2x+jDThsWcbS37/WKCuCQ+sxDT+RC8KQoC23sQUhCwQdv2nUcq6VVmy9A
         efV/5NN1FwC33xgoQvFGoyVgwRAgRnC04ZvhCYqP5H7mgosf8ymMzLSMiUCh48D7Ly
         qG/7aY6Va0IWB0H/p9UsBjOlca1sq49eWSpIwBE4=
Date:   Fri, 12 May 2023 14:03:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Junxiao Chang <junxiao.chang@intel.com>
Cc:     kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
Message-Id: <20230512140353.8b95e8cb024c8e7a1a3b03c1@linux-foundation.org>
In-Reply-To: <20230512072036.1027784-1-junxiao.chang@intel.com>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 15:20:36 +0800 Junxiao Chang <junxiao.chang@intel.com> wrote:

> hugetlb page usually is mapped with pmd, but occasionally it might be
> mapped with pte. QEMU can use udma-buf to create host dmabufs for guest
> framebuffers. When QEMU is launched with parameter "hugetlb=on",
> udmabuffer driver maps hugetlb page with pte in page fault handler.

Are there any other situations in which a hugetlb page is mapped in
this fashion?

If not, can QEMU be changed to map with a pmd?

So we get one less weird special case in MM.
