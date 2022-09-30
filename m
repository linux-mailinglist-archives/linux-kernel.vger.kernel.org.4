Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11595F0706
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiI3JCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiI3JCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:02:08 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E551156572
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:02:05 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Mf43t4FVLzMqD50;
        Fri, 30 Sep 2022 11:02:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Mf43s2cmgzMppDL;
        Fri, 30 Sep 2022 11:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664528522;
        bh=aC4QKGPDZMbJdQ0W7A9p/17bN27c9EdicPq0RM/j37k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YbJXZ2P1SH+4l0eTUOF0o+v3sT5NgpeRB462Hwg1gQMOdv15ux8YAUHlVk0hChXry
         5kFZoSnjBMgXsZnEDEYh5SGbY6149JEHn2vnpkf53Fe37Shujjl0rnc/dZ1XgPCcnh
         W3QVYxCXUQa7LHz+PZ6lSsH3VrstGomdm1jifM2c=
Message-ID: <48bb80b5-3bc0-7072-c02d-d62a02c75bf3@digikod.net>
Date:   Fri, 30 Sep 2022 11:02:00 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [mic:next 4/9] fs/open.c:191: undefined reference to
 `security_file_truncate'
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>
References: <202209301029.GH8uhPky-lkp@intel.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <202209301029.GH8uhPky-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This build error arises when CONFIG_SECURITY_PATH is disabled. Indeed, 
security_file_truncate() is only defined in security/security.c for such 
option.

I have pushed the (rebased) fix in my next branch. FYI, you can keep the 
current Acked-by.

Original patch: 
https://lore.kernel.org/all/20220908195805.128252-2-gnoack3000@gmail.com/


On 30/09/2022 04:57, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git next
> head:   054fdc359167ae7c17a5fb47c0edbf5cb4b737b0
> commit: 0052f28b7cba97cefa48623ef087d1c1cc06078f [4/9] security: create file_truncate hook from path_truncate hook
> config: x86_64-rhel-8.3-func
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?id=0052f28b7cba97cefa48623ef087d1c1cc06078f
>          git remote add mic git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
>          git fetch --no-tags mic next
>          git checkout 0052f28b7cba97cefa48623ef087d1c1cc06078f
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ld: fs/open.o: in function `do_sys_ftruncate':
>>> fs/open.c:191: undefined reference to `security_file_truncate'
>     ld: fs/namei.o: in function `handle_truncate':
>>> fs/namei.c:3214: undefined reference to `security_file_truncate'
> 
> 
> vim +191 fs/open.c
> 
>     155	
>     156	long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>     157	{
>     158		struct inode *inode;
>     159		struct dentry *dentry;
>     160		struct fd f;
>     161		int error;
>     162	
>     163		error = -EINVAL;
>     164		if (length < 0)
>     165			goto out;
>     166		error = -EBADF;
>     167		f = fdget(fd);
>     168		if (!f.file)
>     169			goto out;
>     170	
>     171		/* explicitly opened as large or we are on 64-bit box */
>     172		if (f.file->f_flags & O_LARGEFILE)
>     173			small = 0;
>     174	
>     175		dentry = f.file->f_path.dentry;
>     176		inode = dentry->d_inode;
>     177		error = -EINVAL;
>     178		if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
>     179			goto out_putf;
>     180	
>     181		error = -EINVAL;
>     182		/* Cannot ftruncate over 2^31 bytes without large file support */
>     183		if (small && length > MAX_NON_LFS)
>     184			goto out_putf;
>     185	
>     186		error = -EPERM;
>     187		/* Check IS_APPEND on real upper inode */
>     188		if (IS_APPEND(file_inode(f.file)))
>     189			goto out_putf;
>     190		sb_start_write(inode->i_sb);
>   > 191		error = security_file_truncate(f.file);
>     192		if (!error)
>     193			error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
>     194					    ATTR_MTIME | ATTR_CTIME, f.file);
>     195		sb_end_write(inode->i_sb);
>     196	out_putf:
>     197		fdput(f);
>     198	out:
>     199		return error;
>     200	}
>     201	
> 
