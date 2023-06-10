Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0596872A7DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjFJBv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjFJBv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:51:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D33A82
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rvR6dekxmIrpYjXvV65854iQwAmXJOxjH90USp3ojPU=; b=dkJFJ8ZYNaV+JBxahyxLYGOPcC
        D0MaV1ccDO7CA8v+voLS6TUWourA/iBtlDzY00iqgT1KwrznvuJ+qbuSaTqnxcYdaNZdVgx0z18oq
        w/mJVrR6Kpy0V74k2ke/icCzvaiUixHLy8V69u8iwAxnBVklfVLIAgX72mh4703GeLA8137nmVmmt
        0eJDTD83WgeQrBXKMzXf/f6CFmzgChGE5Z7NIYUgvutdMQSNZC56Dbjir2TBUM/kLc9kVQrES4Tns
        rFm1JOZa+i1aU6XX7O7nR2pOelHBxPCkbLqQLzKu6WXea+K3iZrai+ysfUZ0/eNRHH2LzrMZJEINk
        AD4piwdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7nlQ-00HMf4-Sc; Sat, 10 Jun 2023 01:51:36 +0000
Date:   Sat, 10 Jun 2023 02:51:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv5] mm: skip CMA pages when they are not available
Message-ID: <ZIPXKMMgKSfzDlau@casper.infradead.org>
References: <1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609153519.ff01046ef0faff00a74bd5b0@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:35:19PM -0700, Andrew Morton wrote:
> > This patch fixes unproductive reclaiming of CMA pages by skipping them when they
> > are not available for current context. It is arise from bellowing OOM issue, which
> > caused by large proportion of MIGRATE_CMA pages among free pages.
> 
> We saw plenty of feedback for earlier versions, but now silence.  Does
> this mean we're all OK with v5?

I'm fine with the implementation now.  I have no idea if this is the right
approach.
