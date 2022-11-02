Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75C616FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKBV0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAB6386;
        Wed,  2 Nov 2022 14:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC0861C35;
        Wed,  2 Nov 2022 21:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85261C433C1;
        Wed,  2 Nov 2022 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667424401;
        bh=nMOrWfydMBV1jOA8PjMF1bu6xK2aRHeDMNS4YGxjy5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bnsHNSkhdNhKGnhnh3N2Cnw4UXUMgDYNkPDGlDU2BdlKpetMV9NFzlT5q7KdTsgpX
         NwieXZ6hvSLyjKMTTZ/QX7+RdEj7VJdyStnjZXz2r0RVSkV/+PwX+qqxxv/87EMoXD
         bemDxUlJh2lB+7xM1cE7tCHRGon1tvHkHPrns1kE=
Date:   Wed, 2 Nov 2022 14:26:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20221102142640.e61459b0f1302597c791f5a6@linux-foundation.org>
In-Reply-To: <20221102145532.1b6e5891@canb.auug.org.au>
References: <20221102145532.1b6e5891@canb.auug.org.au>
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

On Wed, 2 Nov 2022 14:55:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> mm/migrate.c: In function 'unmap_and_move_huge_page':
> mm/migrate.c:1315:13: error: implicit declaration of function 'hugetlb_folio_subpool'; did you mean 'hugetlb_page_subpool'? [-Werror=implicit-function-declaration]
>  1315 |         if (hugetlb_folio_subpool(src) && !folio_mapping(src)) {
>       |             ^~~~~~~~~~~~~~~~~~~~~
>       |             hugetlb_page_subpool
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>   fa7dc4d80445 ("mm/hugetlb: convert move_hugetlb_state() to folios")
> 
> This build does *not* have CONFIG_HUGETLB_PAGE set.
> 

Thanks, let's try this:

--- a/include/linux/hugetlb.h~mm-hugetlb-convert-move_hugetlb_state-to-folios-fix
+++ a/include/linux/hugetlb.h
@@ -991,6 +991,11 @@ void hugetlb_unregister_node(struct node
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
+static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
 	return NULL;
_

