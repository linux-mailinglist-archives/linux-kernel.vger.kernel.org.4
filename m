Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F66E0078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDLVGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDLVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5008659D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD5363895
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D2DC433EF;
        Wed, 12 Apr 2023 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681333562;
        bh=tBuKzWjSMLs8UvYBdSDGzOLgtVGDJL5zVZa/hiwcI7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rmhB919gqmisPXX6gHRY+oQZFyU/szgZjbTc0ox+RrAHTyBXZ1JHeV66GM0B+wVeR
         1lzvypLhE5gOdWeXFCWLKqc0jPTeaeQ686SAQcyxCRsikU2PGYnz6buDKNXfKZGgOr
         OYuwzUfjWWBIpqdwtFXrI3k8H7wmiOxuaUxuDIwM=
Date:   Wed, 12 Apr 2023 14:06:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, urezki@gmail.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Subject: Re: [PATCH 1/2] mm: kmsan: handle alloc failures in
 kmsan_vmap_pages_range_noflush()
Message-Id: <20230412140601.9308b871e38acb842c119478@linux-foundation.org>
In-Reply-To: <202304130223.epEIvA1E-lkp@intel.com>
References: <20230412145300.3651840-1-glider@google.com>
        <202304130223.epEIvA1E-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 02:27:19 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Alexander,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> >> include/linux/kmsan.h:291:1: error: non-void function does not return a value [-Werror,-Wreturn-type]

Thanks, I'll do this:

--- a/include/linux/kmsan.h~mm-kmsan-handle-alloc-failures-in-kmsan_ioremap_page_range-fix
+++ a/include/linux/kmsan.h
@@ -289,6 +289,7 @@ static inline int kmsan_vmap_pages_range
 						 struct page **pages,
 						 unsigned int page_shift)
 {
+	return 0;
 }
 
 static inline void kmsan_vunmap_range_noflush(unsigned long start,
_

