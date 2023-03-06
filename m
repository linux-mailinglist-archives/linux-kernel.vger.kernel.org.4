Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9156AB4FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCFDNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCFDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:13:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806878A78;
        Sun,  5 Mar 2023 19:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDE760B67;
        Mon,  6 Mar 2023 03:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465C3C4339B;
        Mon,  6 Mar 2023 03:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678072416;
        bh=1id7DTe/+f1dfmJRxlDDt09X978sszhSG5u3A0Kl24M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wlpYsNDyAbe3C10L1svZunLISycVuUMzPZqCuIvTAcE2FvKN9KK89jCXG21vWTlha
         u5yf+InUGGpCVdBu6Pr4Z3eTCbs3ojhn+xwo1vxbpyXFyDFPW4Xr5hyfljGL6t2WZH
         B8xCibrHxRJoMkMhLg1qqAqh+HC7KbrpOlubT9KY=
Date:   Sun, 5 Mar 2023 19:13:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20230305191335.fee8e6aa285b0ca771cab9dd@linux-foundation.org>
In-Reply-To: <20230306135447.2c657f48@canb.auug.org.au>
References: <20230306135447.2c657f48@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 13:54:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (various) failed
> like this:
> 
> mm/khugepaged.c:1702:9: error: implicit declaration of function ‘vma_try_start_write’; did you mean ‘vma_start_write’? [-Werror=implicit-function-declaration]
> 
> Caused by commit
> 
>   92e3612279f9 ("mm/khugepaged: fix vm_lock/i_mmap_rwsem inversion in retract_page_tables")
> 
> The definition of vma_try_start_write() is protected by
> CONFIG_PER_VMA_LOCK, but its use is not.

Thanks.  Suren has a fix, but I haven't pushed it out yet :(


From: Suren Baghdasaryan <surenb@google.com>
Subject: txt-mm-khugepaged-write-lock-vma-while-collapsing-a-huge-page-fix-fix
Date: Sat, 4 Mar 2023 15:24:15 -0800

I missed vma_try_start_write() definition for CONFIG_PER_VMA_LOCK=n
configuration.

Link: https://lkml.kernel.org/r/CAJuCfpFjWhtzRE1X=J+_JjgJzNKhq-=JT8yTBSTHthwp0pqWZw@mail.gmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/include/linux/mm.h~mm-khugepaged-write-lock-vma-while-collapsing-a-huge-page-fix-fix
+++ a/include/linux/mm.h
@@ -717,6 +717,8 @@ static inline bool vma_start_read(struct
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
+static inline bool vma_try_start_write(struct vm_area_struct *vma)
+		{ return true; }
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 
 #endif /* CONFIG_PER_VMA_LOCK */
_

