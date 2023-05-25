Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D756711929
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbjEYVb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjEYVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:31:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D11B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=to7pioPumMAlTGKORpUeQh361tXFOrBDpzDI+Fvoclg=; b=tRdLECtjpF0/xZKIdrNOLP93Bn
        bdu58jxSyqv95/kwtDk6ZnWYhoZy8EsbcBGnBw5WmAF2SUa9W5nMMiZ3zFRbtikrcY3MhfubZOC2q
        a4NcLl7xysf0q00JKf9RDXjqyKIDM7jjLztn3QVdh1U9J2zeS4Fl1zTTQBq/iRWlZKfWlhQfgsrSp
        krTH6naUlXufrN3WJ5CNY0/Nz5LgdIIysjweaBXrvstuZLFkfmjhMoCcN0GQB63Z/2O+Lm4TGCQuE
        pJ2/AqvieLBelwv49KgNBbvk30a5LqE6sz21L6asEvhwqayv9AACbXlH1xNuwW4XuGc706ORXV3fQ
        /S8CwKPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2IYF-00FjtV-LU; Thu, 25 May 2023 21:31:15 +0000
Date:   Thu, 25 May 2023 22:31:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-ID: <ZG/To8Z3StoVoenU@casper.infradead.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/I7tYY4uV/32hP@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:45:34PM +0100, Matthew Wilcox wrote:
> > > Isn't "long term pinning" the wrong description of the problem?  Long term
> > > pins suggest to me FOLL_LONGTERM.  I think this is simple short term
> > > pins that we care about here.
> > 
> > vfio pins are held for a long time - Steve
> 
> So this is a third sense of "pinned pages" that is neither what
> filesystems nor the mm means by pinned pages, but whatever it is that
> vfio means by pinned pages?  If only "pin" weren't such a desirable
> word.  Can somebody explain to me in small words what a vfio pin looks
> like because I've tried reading vfio_iommu_type1_pin_pages() and I
> don't recognise anything there that looks like pinning in either of
> the other two senses.

Oh, I think I found it!  pin_user_pages_remote() is called by
vaddr_get_pfns().  If these are the pages you're concerned about,
then the efficient way to do what you want is simply to call
folio_maybe_dma_pinned().  Far more efficient than the current mess
of total_mapcount().
