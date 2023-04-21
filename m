Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8946EA263
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjDUDfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjDUDfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:35:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6C4227
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vk6vT0qy+ECCFzU4hNaFnAUfUIPUhxxw3irMXMd3g9o=; b=AmAmpURdccY0WAb+yW9ouPnxZR
        R9KaxcSwQ5Hj8lQiB3QqZIQom1Ea82OomwCRB6Al3K2lv6fiRbAZrgARo+CuhK7+DVNfHXjDzFYMQ
        RBtzxhWTfLH/e0USYri74zAzq21ExPRsM4vZeGvkvtLzJ6XNaEFrOUJN1AUl3K6eV9W2Bwaa0/7wR
        JvHj7DIjYU0F2pNpHqrPE8aJjukY85+cmsnLJxSOUSkTxShPCvK/UsnJLmzuSl7sda+1Jqn8dE7sJ
        r6O5i2F8ie1PzF10xP85AFbbdVkPcaIytvl5EAC2FO8dGUrq2BXyfrleKGyArB3KbOoxEEibg7IAc
        gA9ClChw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pphY0-00B44L-1x;
        Fri, 21 Apr 2023 03:34:56 +0000
Date:   Fri, 21 Apr 2023 04:34:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mszeredi@redhat.com, bigeasy@linutronix.de, mcgrof@kernel.org,
        xiubli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: clean up d_backing_inode() function
Message-ID: <20230421033456.GC3390869@ZenIV>
References: <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
 <20230419104704.243950-1-haifeng.xu@shopee.com>
 <20230420204545.GN3390869@ZenIV>
 <2b0e06e0-5dd4-8ca7-6d85-b492468fd71a@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0e06e0-5dd4-8ca7-6d85-b492468fd71a@shopee.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:50:05AM +0800, Haifeng Xu wrote:
> 
> 
> On 2023/4/21 04:45, Al Viro wrote:
> > On Wed, Apr 19, 2023 at 10:47:04AM +0000, Haifeng Xu wrote:
> >> d_backing_inode() does the same thing with d_inode(), so using
> >> d_inode() to get the inode of dentry instead of d_backing_inode().
> >>
> >> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> >> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> > 
> > Fine by me, but generally that kind of search-and-replace is
> > better done differently:
> > 
> > 1) patch replacing the definition of d_backing_inode() with
> > #define d_backing_inode d_inode
> > 
> > 2) mail to Linus, asking to do mechanical search-and-replace
> > just prior to -rc1; see e.g. 7c0f6ba682b9 for example of
> > that being done.  In this case the script would be
> > sed -i -e "s/\<d_backing_inode\>/d_inode/g" $(git grep -l -w "d_backing_inode")
> > sed -i -e "/#define d_inode d_inode/d" include/linux/dentry.h
> 
> Thanks for your suggestion.
> 
> The file "include/linux/dentry.h" doesn't exist, do you mean "include/linux/dcache.h"?

Yes.

> By the way, why we need to add a definiton first and delete it later instead of replacing 
> the "d_backing_inode" directly?

Because it's much harder to do in a sed script ;-)  Taking out one line is
easier than doing the same to comment + definition.  Seriously, try it; it's
doable, but it's not fun to write and even less so - to read.

> In addition, there's another patch need to be reviewed.
> link: https://lore.kernel.org/all/20230419072736.172593-1-haifeng.xu@shopee.com/

No problems with that one.
