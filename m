Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA78D601A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJQUij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJQUiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:38:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100FA444
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49A9CB818FD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AA9C433D6;
        Mon, 17 Oct 2022 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666038976;
        bh=KKvT8SejwGPUN61J8aIsq/7MbiFb3qzppV3aenFVJCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eTQxk4r0XcGPoKADbojUMK46eqeEndOKctk9KWD9S/zi6+FF75h7ggU489Mc4PQI8
         3xn4uG0/29mFJwmujQ66CZCVKg0QXh9/dqkMdpSa2LR/9C7Wu6vrMq/Wfo/kKbuXzV
         5P7uX6+/Oss4G4pKSBpqLwEuR8pnsMfI6xju6HbY=
Date:   Mon, 17 Oct 2022 13:36:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 6/9] mm/hugetlb: convert free_huge_page to folios
Message-Id: <20221017133615.2b24099673d2ca296f9c355b@linux-foundation.org>
In-Reply-To: <20221014031303.231740-7-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
        <20221014031303.231740-7-sidhartha.kumar@oracle.com>
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

On Thu, 13 Oct 2022 20:13:00 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Use folios inside free_huge_page(), this is in preparation for converting
> hugetlb_cgroup_uncharge_page() to take in a folio.

I added this build fix.

--- a/mm/hugetlb.c~mm-hugetlb-convert-free_huge_page-to-folios-fix
+++ a/mm/hugetlb.c
@@ -1704,7 +1704,7 @@ void free_huge_page(struct page *page)
 	unsigned long flags;
 
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
-	VM_BUG_ON_PAGE(folio_mapcount(folio), folio);
+	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
 
 	hugetlb_set_folio_subpool(folio, NULL);
 	if (folio_test_anon(folio))
_

