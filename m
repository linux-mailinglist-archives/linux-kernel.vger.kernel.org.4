Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE59666A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjALEMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjALEL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:11:59 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD74C726
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qwRGgIGvMBSzTYRHyHH2uzDLZhpEJ+ybmVDBCoIg3A4=; b=MmyOjEdUGbl5SwLMEMD9tyv5++
        +emgk2X5tIqP5v43+brk1xCH7Ba1nG8Oor4w7gBbA3ok+XXy3aS2Cbop5uU9IwuUwBwn5l4IE9EWH
        Ez63w2gKegeZyNO/57gZAcSSDR9HoP/30R6rAWCBRkM5ITYI2m3oqhF2RSeJMV8iqyEc6nEEqNVBe
        JprWBUJhqdbj59B4H64EskcLuw8kpEEfSeYeeTbHLaAqEsKt9DMqt8ybcBSdm9mm+CnOeUYKmWOa3
        ilapNCbotEWqoSR9+JWbFHgEs6ZxA/vhr3RpgoRgJGCmRsr86IxyCKNFFM9mwFOK4RIRp1OM7WkYi
        bKkKYtig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFowK-001PtN-0S;
        Thu, 12 Jan 2023 04:11:44 +0000
Date:   Thu, 12 Jan 2023 04:11:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        kari.argillander@gmail.com, akpm@linux-foundation.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH -next] fs/ntfs3: Fix potential NULL/IS_ERR bug in
 ntfs_lookup()
Message-ID: <Y7+IgD3OslNt4XKY@ZenIV>
References: <20230112013248.2464556-1-zhangpeng362@huawei.com>
 <Y7+B40Mnnm7/rY+O@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7+B40Mnnm7/rY+O@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:43:31AM +0000, Al Viro wrote:
> On Thu, Jan 12, 2023 at 01:32:48AM +0000, Peng Zhang wrote:
> > From: ZhangPeng <zhangpeng362@huawei.com>
> > 
> > Dan Carpenter reported a Smatch static checker warning:
> > 
> > fs/ntfs3/namei.c:96 ntfs_lookup()
> > error: potential NULL/IS_ERR bug 'inode'
> > It will cause null-ptr-deref when dir_search_u() returns NULL if the
> > file is not found.
> > Fix this by replacing IS_ERR() with IS_ERR_OR_NULL() to add a check for
> > NULL.
> 
> That's a bad approach - you are papering over bad calling conventions instead of
> fixing them.
> 
> IS_ERR_OR_NULL is almost never the right tool.  Occasionally there are valid
> cases for function possibly returning pointer/NULL/ERR_PTR(...); this is
> almost certainly not one of those.
> 
> Incidentally, inodes with NULL ->i_op should never exist.  _Any_ place that
> sets ->i_op to NULL is broken, plain and simple.  A new instance of struct
> inode has ->i_op pointing to empty method table; it *is* initialized.

IOW, the real bug is in ntfs_read_mft() -
	inode->i_op = NULL;
in there is garbage.  Unless I'm misreading the history, it used to be possible
for the damn thing to get all the way to ntfs_lookup() - up until the
commit 0e8235d28f3a "fs/ntfs3: Check fields while reading" had taken that
path out:
-       if (!is_rec_base(rec))
-               goto Ok;
+       if (!is_rec_base(rec)) {
+               err = -EINVAL;
+               goto out;
+       }
is the relevant part.  Situation after that commit:

	* useless check in ntfs_lookup() is a dead code; it should be
taken out, especially since it's broken.
	* NULL assignment in ntfs_read_mft() is still garbage; thankfully,
with the current tree the inode will either have it overwritten by later
assignment or it won't make it out of ntfs_read_mft().  Still, that
assignment should be taken out and shot to get rid of bad example.

While we are at it, the calling conventions of ntfs_read_mft() could've
been better.  Look:

ntfs_read_mft(inode, ...) either returns its first argument (on success) or
it disposes of the inode the argument points to and returns ERR_PTR(-E...)
(on failure).  There is only one caller, and it would be easier to follow if
it had been
        /* If this is a freshly allocated inode, need to read it now. */
        if (inode->i_state & I_NEW) {
		int err = ntfs_read_mft(inode, name, ref);

		if (unlikely(err)) {
			if (name)
				ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
			iget_failed(inode);
			return ERR_PTR(err);
		}
	} else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
                /* Inode overlaps? */
                _ntfs_bad_inode(inode);
        }

        return inode;

with ntfs_read_mft() always acting the same way wrt inode refcount...
