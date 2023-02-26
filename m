Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C06A2E05
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 04:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBZD6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 22:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBZD6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 22:58:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D1EF93;
        Sat, 25 Feb 2023 19:58:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB75B80B7F;
        Sun, 26 Feb 2023 03:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB023C433D2;
        Sun, 26 Feb 2023 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677383848;
        bh=u5JMUktpUpWlCnTnJk1blSAVxDd9PtV+f1/Md5D2mXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BB+pWGQCcNTcs6+i/yeNBgfrr0nQt9ronba8ak5FFCkA5yJvJRa1VDuGoz4nE7OnQ
         oL+j7EcSAc5wfOtSaMOytHTva2IjWusY4cGam8QCNaDcEzisC51FD9YK3x0EF4m1qY
         4JdWzZY3lbJagBic+7Q4se388wqaseO423ZLkyVE=
Date:   Sat, 25 Feb 2023 19:57:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
Message-Id: <20230225195727.1b73a356f4f1a79833a31885@linux-foundation.org>
In-Reply-To: <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com>
References: <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
        <CAHk-=whVN2gKO_7UvMqgG8cetrVs3BCTxQovJvhC5x7AcJDJgQ@mail.gmail.com>
        <CAHk-=wgxWDgLJ-e3uDiYQvmMEqTNYFvDxtHbu4inR=zgBEP11Q@mail.gmail.com>
        <CAHk-=wjFmVL7NiuxL54qLkoabni_yD-oF9=dpDgETtdsiCbhUg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 19:53:04 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Feb 25, 2023 at 7:27 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Will bisect further, but adding Liam to the participants because it's
> > now narrowed down to his changes.
> 
> Ok, it's commit 2286a6914c77 ("mm: change mprotect_fixup to vma iterator")

Liam sent us a fix yesterday, hopefully this?


From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: mm/mprotect: Fix successful vma_merge() of next in do_mprotect_pkey()
Date: Fri, 24 Feb 2023 16:20:55 -0500

If mprotect_fixup() successfully calls vma_merge() and replaces vma and
the next vma, then the tmp variable in the do_mprotect_pkey() is not
updated to point to the new vma end.  This results in the loop detecting a
gap between VMAs that does not exist.  Fix the faulty value of tmp by
setting it to the end location of the vma iterator at the end of the loop.

Link: https://lkml.kernel.org/r/20230224212055.1786100-1-Liam.Howlett@oracle.com
Fixes: 2286a6914c77 ("mm: change mprotect_fixup to vma iterator")
Link: https://lore.kernel.org/linux-mm/20230223120407.729110a6ecd1416ac59d9cb0@linux-foundation.org/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Bert Karwatzki <spasswolf@web.de>
  Link: https://bugzilla.kernel.org/show_bug.cgi?id=217061
Tested-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/mm/mprotect.c~mm-mprotect-fix-successful-vma_merge-of-next-in-do_mprotect_pkey
+++ b/mm/mprotect.c
@@ -832,6 +832,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (error)
 			break;
 
+		tmp = vma_iter_end(&vmi);
 		nstart = tmp;
 		prot = reqprot;
 	}
_

