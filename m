Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2263624690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKJQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:06:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318F193EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XRJO342NxsRyiDudQHOMiZ5Co7mlgzo2SPrLUXk2G/c=; b=W12B0zLu0ErcUhv93tcXe+rETb
        dlfBbc/4B9qwSyLH7H7lBd+QlyRAf+I4DwU9Zd/TLpZ1Y5gY2A649PoHSkb5DLujPGeGkL+7/stJC
        GnX9ubTqT3gGl7nMCj84xWo9BovSzKFm5SSIpxZ9PI5ZG+Vxv947z6EyY6wRkN7FoNhr6xmPSOwgG
        jmT+JVusRGfGhRMCDiaUer1E1dXKNxruZMbfhUe4dUJv+U+WbW0WGiEOltWhV7LOF7X669EXaTLqT
        h1oJC62jGxakAk1E40dG0alNAV+7RbJMALvE6DII9TiaNoK4sBCqHWc3d/3l0nglwdqe9lFKfSF/1
        81kam1GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otA4D-00CCAN-OK; Thu, 10 Nov 2022 16:06:13 +0000
Date:   Thu, 10 Nov 2022 16:06:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rong Tao <rtoax@foxmail.com>, Rong Tao <rongtao@cestc.cn>,
        wuchi <wuchi.zero@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] radix tree test suite: Fix uninitialized variable
 compilation warning
Message-ID: <Y20hded53owR/dPo@casper.infradead.org>
References: <tencent_DF74099967595DCEA93CBDC28D062026180A@qq.com>
 <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:23:48PM -0800, Andrew Morton wrote:
> On Wed,  9 Nov 2022 22:34:25 +0800 Rong Tao <rtoax@foxmail.com> wrote:
> 
> > [PATCH] radix tree test suite: Fix uninitialized variable compilation warning
> 
> This is not the test suite.
> 
> > We need to set an initial value for offset to eliminate compilation
> > warning.
> > 
> > How to reproduce warning:
> > 
> > $ make -C tools/testing/radix-tree
> > radix-tree.c: In function ‘radix_tree_tag_clear’:
> > radix-tree.c:1046:17: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >  1046 |                 node_tag_clear(root, parent, tag, offset);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > ...
> >
> > --- a/lib/radix-tree.c
> > +++ b/lib/radix-tree.c
> > @@ -1029,7 +1029,7 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
> >  {
> >  	struct radix_tree_node *node, *parent;
> >  	unsigned long maxindex;
> > -	int offset;
> > +	int offset = 0;
> >  
> >  	radix_tree_load_root(root, &node, &maxindex);
> >  	if (index > maxindex)
> 
> Are we sure this isn't actually a bug?  What happens if the tree is empty?

If the tree is empty, then node is NULL and we never use offset.
The compiler is too stupid to know this.  This warning is only observed
when building the test suite and not when building the kernel itself.
I'm not sure the patch is worth it, tbh.
