Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9C6053F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiJSXcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiJSXcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:32:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276E1A0F80
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:32:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 077DFB825F9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C04C433B5;
        Wed, 19 Oct 2022 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666222323;
        bh=n2ewGIoOoQ0xjDm3+ym1Q7RG9dkwD2HTi2Am3VIhXM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oZohpQa1CdCHvVB31KH/zY6estnojxNW0VFQso9RRXxKytes7qPty30TQCCp9ZGZl
         Qpb27Ej6zTjazx8ZBF9M5KjDWbMwdxZHu2wlNp8tAbUThkYYi/kzMv+8oZFZXO1ARg
         e6xgXA7XZzvZnV7iw3StM4P8C877ffBTcjc2upIY=
Date:   Wed, 19 Oct 2022 16:32:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [ammarfaizi2-block:akpm/mm/mm-unstable 39/119]
 mm/memremap.c:521:6: warning: no previous prototype for
 'zone_device_page_init'
Message-Id: <20221019163202.500fd181836f47dce6bd81c1@linux-foundation.org>
In-Reply-To: <202210191735.jdAY5fBg-lkp@intel.com>
References: <202210191735.jdAY5fBg-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 17:17:36 +0800 kernel test robot <lkp@intel.com> wrote:

> >> mm/memremap.c:521:6: warning: no previous prototype for 'zone_device_page_init' [-Wmissing-prototypes]
>      521 | void zone_device_page_init(struct page *page)
>          |      ^~~~~~~~~~~~~~~~~~~~~

huh, sorry, I must have fat-fingered the reject resolution on that one.

--- a/mm/memremap.c~mm-memremap_pages-replace-zone_device_page_init-with-pgmap_request_folios-fix
+++ a/mm/memremap.c
@@ -518,18 +518,6 @@ void free_zone_device_page(struct page *
 		put_dev_pagemap(page->pgmap);
 }
 
-void zone_device_page_init(struct page *page)
-{
-	/*
-	 * Drivers shouldn't be allocating pages after calling
-	 * memunmap_pages().
-	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
-	set_page_count(page, 1);
-	lock_page(page);
-}
-EXPORT_SYMBOL_GPL(zone_device_page_init);
-
 static __maybe_unused bool folio_span_valid(struct dev_pagemap *pgmap,
 					    struct folio *folio,
 					    int nr_folios)
_

