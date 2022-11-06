Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73D561E528
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKFR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:56:34 -0500
Received: from p3plwbeout21-03.prod.phx3.secureserver.net (p3plsmtp21-03-2.prod.phx3.secureserver.net [68.178.252.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDEBAE42
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:56:31 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id rjskoEkuS3OJnrjslogoqF; Sun, 06 Nov 2022 10:56:31 -0700
X-CMAE-Analysis: v=2.4 cv=d/cwdTvE c=1 sm=1 tr=0 ts=6367f54f
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=FXvPX3liAAAA:8
 a=31H9X7WVGsjyKINbH1UA:9 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  rjskoEkuS3OJn
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1orjsj-0006XY-I7; Sun, 06 Nov 2022 17:56:30 +0000
Message-ID: <0119f3d3-c0f9-503d-db01-22d9dbc15edb@squashfs.org.uk>
Date:   Sun, 6 Nov 2022 17:56:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/1] squashfs: enable idmapped mounts
To:     =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfC1/rWtEVBdAHoip2LDfRaY6SFqBl33ZMyWYcufcXt0QvhlSHmiYpiz3T1q/WuBgKpjLJQwd7l5r9iGt5yUoePzq9Adki157pssyAIFXnGtI6NMvgBff
 qeUhTQBsPVU2HlZmSWtA+Iu2/yvFbBgvaV9fL0EmW0kifELD9tEXWn6ukT2C33N2weDfnnlkdrQ+kIkF9TeaTySGHRJ33TLh/u4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 20:15, Michael Weiß wrote:
> For squashfs all needed functionality for idmapped mounts is already
> implemented by the generic handlers in the VFS. Thus, it is sufficient
> to just enable the corresponding FS_ALLOW_IDMAP flag to support
> idmapped mounts.
> 
> We use this for unprivileged (user namespaced) containers based on
> squashfs images as rootfs in GyroidOS.
> 
> A simple test using the mount-idmapped tool executed as user with
> uid=1000 looks as follows:
> 
> $ mkdir test
> $ echo "test" > test/test_file
> $ mksquashfs test/ fs.img
> $ sudo mkdir /mnt/test
> $ sudo mkdir /mnt/mapped
> $ sudo mount fs.img -o loop /mnt/test/
> $ sudo ./mount-idmapped --map-mount b:1000:2000:1 /mnt/test/ /mnt/mapped/
> 
> $ mount | tail -n2
> fs.img on /mnt/test type squashfs (ro,relatime,errors=continue)
> fs.img on /mnt/mapped type squashfs (ro,relatime,idmapped,errors=continue)
> 
> $ ls -lan /mnt/test/
> total 5
> drwxr-xr-x 2 1000 1000   32 Okt 24 13:36 .
> drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
> -rw-r--r-- 1 1000 1000    5 Okt 24 13:36 test_file
> 
> $ ls -lan /mnt/mapped/
> total 5
> drwxr-xr-x 2 2000 2000   32 Okt 24 13:36 .
> drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
> -rw-r--r-- 1 2000 2000    5 Okt 24 13:36 test_file
> 
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>

Looks OK.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 32565dafa7f3..2636cb354435 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -568,7 +568,7 @@ static struct file_system_type squashfs_fs_type = {
>   	.init_fs_context = squashfs_init_fs_context,
>   	.parameters = squashfs_fs_parameters,
>   	.kill_sb = kill_block_super,
> -	.fs_flags = FS_REQUIRES_DEV
> +	.fs_flags = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>   };
>   MODULE_ALIAS_FS("squashfs");
>   

