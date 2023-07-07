Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16C74B7D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGGUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:32:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EFFC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P+FCa81j9ubiSAGO/SLe1juiHTz9AhiNjQZs1H2CNhM=; b=VaeBkhzojN83ipyJoaxI3rKpIN
        gkIatzNzoJEWjFht8ROxrPQRnc2o+1hGmyJNZLBiHXcYacL5O+Bahq8/sXBTv7BL2b5NQClJVhQEZ
        ckQ7iXEGATl9pHnhLZEn/OZlycP8YC24RHAwJumuKiDnsPAmXtkGyRL2mVmJ+L8mqftlxlrRqfCd3
        Cxpf+778t3L3gxgRPrYyfVze/+YOS7ybq48Q9gKgBXKZj+8mhNI/QjgkaLBTXFrTRMHrcEXPQaiDe
        aRy/rs6xavQV6DmWHc+xruBVnYs0h66BdY9c+SAEWyyTfXPlqWHrpLe+fWO9mFS2aMcpqC60/kezq
        GhsADLnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHs79-00CKsY-NA; Fri, 07 Jul 2023 20:31:39 +0000
Date:   Fri, 7 Jul 2023 21:31:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <ZKh2K7ObVtlXHkTk@casper.infradead.org>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707201904.953262-3-jiaqiyan@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:19:02PM +0000, Jiaqi Yan wrote:
> Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a

This is incorrect naming.  "subpage" was needed before we had the
folio concept, but it should not be used any more.  We have folios
and pages now.

Also, abbreviating "hwpoison" as "hwp" seems like a bad idea to me.
hwp is already used as an acronym by acpi, intel_pstate, some clock
drivers, an ethernet driver, and a scsi driver.

