Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12B5E9580
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiIYSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiIYSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B2167E7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 11:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB5F61046
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E3EC433C1;
        Sun, 25 Sep 2022 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664132106;
        bh=JnreWzYlaXt+qG6J1AJlu8aX3QHJxspcwK2I5tAySJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RcXjl9m/RrMJdrBYwidtkX3wAmcQ15xoa/TsGa1u5GXa24+eUm3EQHJjkO2MhP9/J
         nK7EJTzAsbSUXoldnh2nlibBo2kxFEuFXfxrTFeX9AfcK8HByaJl+/3Q7hTl7EH5NQ
         A1bGS63DcQtvXaf/BAMdHUgoR+i+SUT2YrkyXsuQ=
Date:   Sun, 25 Sep 2022 11:55:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-Id: <20220925115503.43dd5b4530ab40be88795630@linux-foundation.org>
In-Reply-To: <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
References: <0000000000006c300705e95a59db@google.com>
        <Yy4g/BKpnJga1toG@monkey>
        <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 17:14:38 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2060,7 +2060,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = file_inode(vma->vm_file);
>  	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
> -	struct folio *folio;
> +	struct folio *folio = NULL;
>  	int err;
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
> @@ -2127,7 +2127,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  				  gfp, vma, vmf, &ret);
>  	if (err)
>  		return vmf_error(err);
> -	vmf->page = folio_file_page(folio, vmf->pgoff);
> +	if (folio)
> +		vmf->page = folio_file_page(folio, vmf->pgoff);
>  	return ret;
>  }

I grabbed this as a fix against
shmem-convert-shmem_fault-to-use-shmem_get_folio_gfp.patch.  Hopefully
someone can send along something more formal when ready.

