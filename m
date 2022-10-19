Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279C604715
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiJSN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiJSN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2845F5D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XYcog8ocgROVcCPLoEEuCjc+/RbhDrn1MjAOaQsxUMQ=; b=Gx0C3ws/uzyETcYVQsF1zDuOVD
        LzolMU87iYcl9ByTKX/LtTd51rC/4W6tTJ5EAq7zlYOvFxRcBrR0RgGTiVH8tYV6mGPWBBgQLY1Rw
        AkDmfFKZNadjEpPKWbX00RapQQHUp3BIV82OJYvnzEpPvLdHyf6OZsRZhwIisT7DO1xOF3z+PYtHW
        o3+HyT90gdo7m1P8iuwOJ+Otfl2lffLG87WMlAuKWMKMCw9zvkQkD/yPMkPa5di8bRRy2PvCOae0+
        Q//DQ2BZs0AqybtkjtkhGiLLBC0GkaWJgw5/qeu/Yyulr43XFeydnqF+02t8mSI2f8GFHJNiiVd/j
        UCDcnlWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol8st-00BZHZ-Oi; Wed, 19 Oct 2022 13:13:23 +0000
Date:   Wed, 19 Oct 2022 14:13:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tuo Cao <91tuocao@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: folio-compat: fix bug for pagecache_get_page
Message-ID: <Y0/38zsvEgShWjLw@casper.infradead.org>
References: <20221018143639.5099-1-91tuocao@gmail.com>
 <Y066q/QNrBSRjPux@casper.infradead.org>
 <20221018134834.97e685f9a9445c4553ce158b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018134834.97e685f9a9445c4553ce158b@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:48:34PM -0700, Andrew Morton wrote:
> On Tue, 18 Oct 2022 15:39:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Oct 18, 2022 at 10:36:39PM +0800, Tuo Cao wrote:
> > > The folio returned from __filemap_get_folio may be a NULL, it will
> > > causes the kernel crash when access folio->page.
> > 
> > This is not a bug.  &folio->page does not dereference folio but performs
> > pointer arithmetic.
> 
> This is the third attempt to "fix" this.  So far.  I think we should
> take the hint and make the check for a null pointer more explicit.

I think it's doing a great job of pointing out how many alleged
kernel programmers don't actually understand C and aren't capable of
searching mailing lists to see if somebody else already sent a patch.
Hopefully somebody's keeping track and is feeding this information into
their hiring algorithms.

The real solution is to convert all the callers of pagecache_get_page()
to use folios, and then we can delete this code.  I have a small series
in progress.  The amount of text savings is immense; half a kilobyte
from one conversion alone.  Our compound_head() has got very bloated.
