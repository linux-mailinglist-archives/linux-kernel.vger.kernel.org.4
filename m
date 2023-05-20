Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EA70A6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjETJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjETJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BFE4D;
        Sat, 20 May 2023 02:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D4F60A4A;
        Sat, 20 May 2023 09:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D854C433D2;
        Sat, 20 May 2023 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684576459;
        bh=srxttNx0ob8d7XPvQiozrPbGXHOOjc+3+6ZLqelbWZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po5DJeGEXC01gw+dVqJSepdFqD35vsu9JmgFBZwNQ7klC+RJ/FmdJf4yyzEW/87Oh
         Fj2Ppy23niTqhFNsDpJxsaIHCui37wnsHbaPVXQbEpK0zSE8XhJAz4k3eldvGvxS8A
         7GQMPSNqxAGH/bye5xn2Oa7XVNeqFbuq45zMHaaw=
Date:   Sat, 20 May 2023 10:54:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: fix UAF of alloc->vma in race with munmap()
Message-ID: <2023052048-sloping-credible-8871@gregkh>
References: <20230519195950.1775656-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519195950.1775656-1-cmllamas@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 07:59:49PM +0000, Carlos Llamas wrote:
> [ cmllamas: clean forward port from commit 015ac18be7de ("binder: fix
>   UAF of alloc->vma in race with munmap()") in 5.10 stable. It is needed
>   in mainline after the revert of commit a43cfc87caaf ("android: binder:
>   stop saving a pointer to the VMA") as pointed out by Liam. The commit
>   log and tags have been tweaked to reflect this. ]

I'm confused, is this for a stable release (and if so, which one), or is
this for Linus's tree?

thanks,

greg k-h
