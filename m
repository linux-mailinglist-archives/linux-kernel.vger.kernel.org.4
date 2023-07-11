Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6556B74F997
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGKVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKVL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:11:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E46133
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BZQBp1qDo2IW6ftJFZfiSBAckDEB2qosFIbNvmf9QzU=; b=w6Om+AAn3svGPuxzHcd7yzbMO2
        9wR+1BoeKDrU9s9Ve90gOkkxX3V8s/G3SQwPNn+r3q90IKOFyCZjok4kkSHWjF0yMFl8KFJ1iRDJH
        CAK76Exuq2cbWSfjkG2VVPGJ3SQbilaWh1scwV3JeAbdEKuHXmxbMu/2OMk4xAlRMn+j8wmVx6Qm1
        6kfawQ2dTBzqT5X0emrDwBItOLNbex5IvVDdn+MpF76R1zRHqceQCdj6iOYBFsitc3gmgweffrk/X
        9GVQknMD8Vfb9MFaOTk3UBEOppORSP8NRJmD+C7/qB/fmThirspRpgFoFBuGOwd68f9XN04P1Mjk6
        AN6mZZrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJKdj-00Ftm9-2r;
        Tue, 11 Jul 2023 21:11:19 +0000
Date:   Tue, 11 Jul 2023 14:11:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Message-ID: <ZK3FdyqlhIs5HRk8@bombadil.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKgPIXSrxqymWrsv@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 02:12:01PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
> 
> > Is swapping working as expected? zswap?
> 
> Suboptimally.  Swap will split folios in order to swap them.

Wouldn't that mean if high order folios are used a lot but swap is also
used, until this is fixed you wouldn't get the expected reclaim gains
for high order folios and we'd need compaction more then?

> Somebody needs to fix that, but it should work.

As we look at shmem stuff it was on the path so something we have
considered doing. Ie, it's on our team's list of items to help with
but currently on a backburner.

  Luis
