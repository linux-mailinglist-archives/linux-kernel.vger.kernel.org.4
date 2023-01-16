Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045C66B91C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjAPIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAPIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732844B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673857997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cmV/tOhk1p9sXTBFFd4XL3CHoY6/k6Ee8FzcZCIih3w=;
        b=DMj291ZH6vVq45S/+0ytL8+rmTGDiC9DO9fJ2BfYLutWxWGjRnPuQuqhkeNfuOLMRDxVuT
        ZSvkmJ72Yey3NlkgAuvBHJmwus4ggGE9fqoo4Cq/HG9SocFTJHSYh8npDw4uQ41IadYw9c
        UyqtpohVsl6K6o6QFuwEnjuZJZNoIQI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-pNNpA1xyP0yHo3eJ-5aSFg-1; Mon, 16 Jan 2023 03:33:16 -0500
X-MC-Unique: pNNpA1xyP0yHo3eJ-5aSFg-1
Received: by mail-pj1-f69.google.com with SMTP id u7-20020a17090a410700b002291f69fbb5so4209378pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmV/tOhk1p9sXTBFFd4XL3CHoY6/k6Ee8FzcZCIih3w=;
        b=fOJu2t/TPqMn9ysryvrGahExz2jGeQAoFg1JEvvAE+IpAPV6HjwxXiKM1IXBB+1ite
         O1npzm6g1OOwx/Ldxso+h2+NJwMCjkDbYChUqTVAYk9q2+zGj62FwAtWYrko1SYfCn2P
         wnvLFZxG/YyqC3Zjpl4EUwt4bCt6KpHqD6Y6SwDwndPyYM8CWuLDbMlTw3bqG0EdyjSP
         cEvTmdcpzQwEC6YwzQfvdYgSp5WqO8Ll/8OTToUCC07DkpIozScZ9Yjllg2Fo/W7p7lJ
         6TZr7EiDX7D7enUlP3UNXWJ2zI7kwWpURzPYQDy5LdXURk93SVXd+NAtUAYR0FuDB2Ie
         NwQQ==
X-Gm-Message-State: AFqh2kpgwgUWW3hWIUE93od4yHdujP1I9oIuud0l3yFTk038tLbsN5V+
        +nCB+hxskHRckwcjMNlDw/9wRz8uPR45Dg/EnJgrIKqd3FknRLlUhEkmWy22+V6bHESbrr3n+9l
        3EOp3i9FnWqC7KuJQyQEO98MG
X-Received: by 2002:a05:6a21:3a8b:b0:b8:9c66:cd66 with SMTP id zv11-20020a056a213a8b00b000b89c66cd66mr797121pzb.18.1673857994963;
        Mon, 16 Jan 2023 00:33:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBW/iYBDAkVZlO7y7Rcp3EBSdUsSpj+rBDKBuXM+TTBzRL+KPGGwGnwO9CeXH45Jmu/Sj6EQ==
X-Received: by 2002:a05:6a21:3a8b:b0:b8:9c66:cd66 with SMTP id zv11-20020a056a213a8b00b000b89c66cd66mr797108pzb.18.1673857994750;
        Mon, 16 Jan 2023 00:33:14 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id z4-20020a623304000000b0058215708d57sm946601pfz.141.2023.01.16.00.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 00:33:14 -0800 (PST)
Date:   Mon, 16 Jan 2023 17:33:11 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Fix error handling in ntfs_new_inode()
Message-ID: <Y8ULxwOtdKWu/CzX@kernel-devel>
References: <20230104123902.978084-1-syoshida@redhat.com>
 <2f653f1c-161c-57d2-b3c7-f21ded261938@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f653f1c-161c-57d2-b3c7-f21ded261938@paragon-software.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 13, 2023 at 01:44:48PM +0400, Konstantin Komarov wrote:
> On 04.01.2023 16:39, Shigeru Yoshida wrote:
> > When memory allocation for mi->mrec fails, ntfs_new_inode() calls
> > iput().  iput() calls ni_write_inode() indirectly, it references
> > uninitialized mi->mrec, and this causes the kernel crash.  This patch
> > fixes the issue by making the inode bad before calling iput().
> > 
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >   fs/ntfs3/fsntfs.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> > index 567563771bf8..7b93f2aeb6f6 100644
> > --- a/fs/ntfs3/fsntfs.c
> > +++ b/fs/ntfs3/fsntfs.c
> > @@ -1683,6 +1683,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
> >   out:
> >   	if (err) {
> > +		_ntfs_bad_inode(inode);
> >   		iput(inode);
> >   		ni = ERR_PTR(err);
> >   	}
> 
> Hello.
> 
> This bug have been already fixed by Ye Bin (https://lore.kernel.org/lkml/20221117091912.3436127-1-yebin@huaweicloud.com/).

I've missed the fix you mentioned.
Thank you so much for your reply!

Shigeru

> 
>  * Thanks for your work.
> 

