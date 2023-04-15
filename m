Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084086E3080
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDOKOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDOKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:14:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3313C1E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:14:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso5934100wmo.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681553651; x=1684145651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp4YF3nuXkkMv51GOsaMipzQK0xp4qUusETg3DPFN8g=;
        b=BHtiDOmCoIbmYqc+lRKC9AGbsuXXPVL59n4uKYjY2OHzdHn8LVXDunshclHU+Cg1Dc
         OxHlZ3AY7JngwWJZYDOykxe9onYS69uQFcAJ21iNUfrforTNYjP5sN/81R9irXmZjhEa
         +bBkv8UfBLUMLAkJgUCEO9IhX8e8oxVjQYMUp12QpQmOdfDwbj3uZ31qEZ1fwG6CHdo9
         0qoUmYQ3ZINuIF5ytA5YGCU27dVvy2pcxBk2AMVSHHP0QXY6RYy1idnT1voA31bTfLKH
         AL+P4a6Z3grgQNZbfrXQS/BIrYwyAGVGRATaQ7FsG3KR4ncnHaFnxAMV21Cg3w0cQN/0
         XNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681553651; x=1684145651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp4YF3nuXkkMv51GOsaMipzQK0xp4qUusETg3DPFN8g=;
        b=Nn0vvZdNbmiTExfHhoy+ysDnmmqW1doPcIPEC449FggJi06yOv4SLFw8t1rG3ELB9x
         VHuwOuwnfUM+Fj5uy836AVImMQgQBGbCyZ8YgqaCfO8aLv5auofsCOMDlZj5hnv3auIc
         zpuYRFRHLNTsdsgFyJCGrcIBVvlB1lVHwik0SMHfBczNFkTc8v0wfKn+iZc46WOaCi7+
         ldJv6tE9oE0TJn54LAsTkMbdmpuSRkuQC145eHwyVVKV7Funt6qqtck5WOeohZbLhFcQ
         KMoCFc6jVZG2zuDKvrEQWSdD9VYiG1sgz6C2By+IAOI/udlE4Y4Uv7nZRNRBk/tbP9hw
         X8bg==
X-Gm-Message-State: AAQBX9cNFAMS3K6wPV6ZyYM/kS37AbepwpY+5wFKNHjf182pco/4hqt2
        1JflHiL4LrtSsdqPI65eq9m0JiG1GhU6ug==
X-Google-Smtp-Source: AKy350ZnRrIEAh9ODFGhrLIHMBWqoSdQAdDh4IPJYB3zTYwrbrzYWGdPLDKWsYqgnJv2+0ZnF7Eyxg==
X-Received: by 2002:a7b:ce89:0:b0:3f1:6788:a4b4 with SMTP id q9-20020a7bce89000000b003f16788a4b4mr1364773wmj.33.1681553650758;
        Sat, 15 Apr 2023 03:14:10 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c224100b003f072b22dbbsm6272869wmm.16.2023.04.15.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:14:09 -0700 (PDT)
Date:   Sat, 15 Apr 2023 11:14:08 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <63d92734-2185-439c-bbc7-53a4720f5d4a@lucifer.local>
References: <cover.1681547405.git.lstoakes@gmail.com>
 <631001ecc556c5e348ff4f47719334c31f7bd592.1681547405.git.lstoakes@gmail.com>
 <b4706369-f97c-8b78-f194-b45a870114e1@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4706369-f97c-8b78-f194-b45a870114e1@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 06:52:41PM +0900, Tetsuo Handa wrote:
> On 2023/04/15 18:08, Lorenzo Stoakes wrote:
> > @@ -475,10 +474,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >  		gup_flags |= FOLL_SPLIT_PMD;
> >  	/* Read the page with vaddr into memory */
> >  	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
> > -				    &old_page, &vma, NULL);
> > +				    &old_page, NULL);
> >  	if (ret <= 0)
> >  		return ret;
> >
> > +	vma = vma_lookup(mm, vaddr);
> > +	if (!vma)
> > +		goto put_old;
> > +
> >  	ret = verify_opcode(old_page, vaddr, &opcode);
> >  	if (ret <= 0)
> >  		goto put_old;
>
> This conversion looks wrong.
> This causes returning a positive number when vma_lookup() returned NULL.
>
>   * Return 0 (success) or a negative errno.
>

In reality it shouldn't be possible for vma to return NULL, I'm adding the
checks to be extra careful.

In any case you're right, attaching a -fix patch to avoid spam:-

----8<----
From 0710d01ea69ad4e846fa1e56a40b253ff59714ac Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Sat, 15 Apr 2023 11:09:15 +0100
Subject: [PATCH] mm/gup: remove vmas parameter from get_user_pages_remote()

Correct vma NULL check as indicated by Tetsuo.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 kernel/events/uprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b21993cd2dcc..affe42a13eff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -479,8 +479,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		return ret;
 
 	vma = vma_lookup(mm, vaddr);
-	if (!vma)
+	if (!vma) {
+		ret = -EINVAL;
 		goto put_old;
+	}
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
-- 
2.40.0

