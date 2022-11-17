Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2462D59F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiKQI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbiKQI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:56:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C75FFD;
        Thu, 17 Nov 2022 00:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1172E62118;
        Thu, 17 Nov 2022 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1E2C433B5;
        Thu, 17 Nov 2022 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668675410;
        bh=Tw6BAC0fGiYjOxb6MBJxYS5EJsfMYACdeY17dThGrFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGEKn8d5AcjmDphVrpB0RkyFaAiCI8vGwiPRulyuF/Wz5QVKBSK0CbAIPxx7JmY38
         gkG9Hfoz/djygXECh3OdHw/ORKHUJU2oZs2J9/fJYOXqauJvosbwe1qFaZ1eivICjD
         5j7ZF4/TCkcSamcxw0HUs4tENsS4kv/UAlBejKROwiPp8ZOF2jboOO/vIbLq9Z9N4B
         k5GRCJdJkxvnkNlrdrW4OwHNZ3AdpAaOpGmlAELFTGXDbwg3XC4+4yCjp/4KntZuPg
         l/M/9WMquLuxgVu5PxxupCwTf2BVAKAqLHpAM+yk325Y7JIaa8I90yb+1loPrcjuw1
         eKfx/caZAXJJA==
Date:   Thu, 17 Nov 2022 09:56:44 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ntfs3 tree
Message-ID: <20221117085644.52r6gviioifzysqn@wittgenstein>
References: <20221115101756.5d311f25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221115101756.5d311f25@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:17:56AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ntfs3 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/ntfs3/namei.c: In function 'ntfs_atomic_open':
> fs/ntfs3/namei.c:374:39: error: implicit declaration of function 'get_acl' [-Werror=implicit-function-declaration]
>   374 |                 struct posix_acl *p = get_acl(dir, ACL_TYPE_DEFAULT);
>       |                                       ^~~~~~~
> fs/ntfs3/namei.c:374:39: error: initialization of 'struct posix_acl *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> 
> Caused by commit
> 
>   2b108260ea2c ("fs/ntfs3: atomic_open implementation")
> 
> interacting with commit
> 
>   cac2f8b8d8b5 ("fs: rename current get acl method")
> 
> I have applied the following merge fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Nov 2022 10:07:59 +1100
> Subject: [PATCH] fix up for "fs: rename current get acl method"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/ntfs3/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 20a6ac883312..c8db35e2ae17 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -371,7 +371,7 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
>  		 * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
>  		 * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
>  		 */
> -		struct posix_acl *p = get_acl(dir, ACL_TYPE_DEFAULT);
> +		struct posix_acl *p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
>  
>  		if (IS_ERR(p)) {
>  			err = PTR_ERR(p);

Hey Stephen,

Thank you for the report! Your fix is correct. @Konstantin can either
pull in

ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.acl.rework

or I'll make a note and will let Linus know during the merge window
about this issue. In the latter case I'd just copy-paste your patch to
Linus, Stephen?

Thanks!
Christian
