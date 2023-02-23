Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060556A10B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBWTn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBWTnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:43:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC602D5F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVZb1Kw2FmNDMOjOwuTzqSEDiuj+5VoxP2eTw4On0pE=; b=qYE1tLntalOV4p5Sdahb7kYLAh
        Fq2blhmozsVIHX4c2ONgkcjKdfgNAN2g9Ql7iAU6frxprhdLbQKFE6yA4pPACZVwmK15A2rUsLPSO
        X7Tq1Sm/KBoNtvDPfqcVOdGCUEvVMewfOhC9PQFIraoGydWNBwTuWf2DveQIK07z8DzZEUsIC7mVo
        +xzQjXy4kP7tXfSZuQVKbHajfby6R/79dhw5OpzYNETaUPjvo8ZsakCu+PsM6Du/HasOpFIPsvgk8
        3QnZ2G9rmZrMNUT8grZl17VT4rqNWdGwtKGBziBQ8SYwweJTMJN8cEUY0dSZUy6Utj7By+dCocgH2
        AVcUJaUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVHUp-00089d-1J; Thu, 23 Feb 2023 19:43:15 +0000
Date:   Thu, 23 Feb 2023 11:43:14 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        yosryahmed@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/5] shmem: add support to ignore swap
Message-ID: <Y/fB0mcvwsp/YX4A@bombadil.infradead.org>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
 <20230223024412.3522465-6-mcgrof@kernel.org>
 <20230223122631.hwvhbqxadvbm23nb@wittgenstein>
 <Y/eDOXC4+vpCCBic@infradead.org>
 <20230223160914.cwvt53drn2bckpdc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223160914.cwvt53drn2bckpdc@wittgenstein>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 05:09:14PM +0100, Christian Brauner wrote:
> On Thu, Feb 23, 2023 at 07:16:09AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 23, 2023 at 01:26:31PM +0100, Christian Brauner wrote:
> > > We would have use-cases for this in systemd. We currently use ramfs for
> > > systemd's credential logic since ramfs is unswappable. It'd be very neat
> > > if we could use tmpfs instead,
> > 
> > What is the advantage of using a swapless tmpfs over ramf?
> 
> There are a few reasons we usually prefer tmpfs over ramfs. Iirc, ramfs
> doesn't have limits and grows dynamically. So we currently only use it
> from the most privileged process where we do our own accounting and
> immediately remount the superblock read-only. Tmpfs on the other hand
> offers various ways to restrict memory consumption.

Size limits is just one bell, in fact ramfs has no configurable options.
So in fact *all* options parsed on shmem_parse_options() are only
available with tmpfs, some of the options are:

  * size
  * number of blocks
  * number of inodes
  * NUMA memory allocation policy
  * huge pages

> Other reasons are that ramfs doesn't support selinux labels, xattrs, and
> acls in general which come in quite handy. Starting with kernel v6.3
> tmpfs does also support idmapped mounts. So we usually always prefer
> ramfs over tmpfs unless we have a very specific need such as the memory
> not being swapped out.

I guess its time to update Documentation/filesystems/tmpfs.rst.

  Luis
