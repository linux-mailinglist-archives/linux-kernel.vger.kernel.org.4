Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC6703854
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbjEORbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjEORbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:31:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCA14910
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OdG7f6znMQkKbie7LhqyJT2EpCYQ4RcchTRRUpChjcY=; b=YAFxSR24Z/WdxaDJBseB7qP0Bb
        qcUNWWbQUOVv7aEyq8FMZr4C246H8u+9gTBNkEuCV4hhkYIOCWl2SChHhyLRKYBEfFoXEdMD8PDE2
        PFcRSrWCKMDSvit2N1KwzmSIBXpbU7OEFsfPc8IbHmH0qME1dkYahPH90jZTQ0ygaBTvf7GdbVLun
        QMUvhGjLrfi1uAcVFFr+AYlEU4YWMeeoiRqZaymPSzCaUKLlhHAcaxhn9NWpjl4dPFd3JySgJUH5P
        SzTiW+m0GmzO0WPEYOSZywrdmMnexRhw88ivu3pU+OGEAc0Vf3C7dmeK4B3cBAvBSrjMShO6xjANT
        e/B1e4ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pybz7-003cMU-Qh; Mon, 15 May 2023 17:27:45 +0000
Date:   Mon, 15 May 2023 18:27:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 02/10] maple_tree: Drop mtree_alloc_{range,rrange}() and
 related functions.
Message-ID: <ZGJrketUDnGkWw8b@casper.infradead.org>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
 <20230515131757.60035-3-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515131757.60035-3-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:17:49PM +0800, Peng Zhang wrote:
> Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
> mtree_alloc_{range,rrange}() currently have no users and can be easily
> implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
> mas_fill_gap() are just their internal functions, drop them together.

No, I think this is the wrong way to go.

Most users should not be using the mas_* API.  These are the advanced
APIs.  Most users will want to use mtree_alloc_range().  Just like most
users of the XArray use the xa_insert() API rather than open-coding the
xa_state and calling the xas_* APIs.

Please read Documentation/core-api/xarray.rst and maple_tree.rst for more
details on Normal vs Advanced API.  The real problem is that we have so
few users today, so you haven't seen that most people don't want to use
the advanced APIs.
