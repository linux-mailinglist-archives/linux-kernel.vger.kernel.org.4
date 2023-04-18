Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07A26E572E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDRByn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDRByk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:54:40 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3675BB4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:54:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VgMyoZU_1681782265;
Received: from 30.221.129.246(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VgMyoZU_1681782265)
          by smtp.aliyun-inc.com;
          Tue, 18 Apr 2023 09:44:26 +0800
Message-ID: <1cd0f938-72b8-2686-1db9-d8c229700e14@linux.alibaba.com>
Date:   Tue, 18 Apr 2023 09:44:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
To:     Arnd Bergmann <arnd@kernel.org>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20230417205631.1956027-1-arnd@kernel.org>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230417205631.1956027-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 4:56 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit architectures with KASAN_STACK enabled, the total stack usage
> of the ocfs2_ioctl function grows beyond the warning limit:
> 
> fs/ocfs2/ioctl.c: In function 'ocfs2_ioctl':
> fs/ocfs2/ioctl.c:934:1: error: the frame size of 1448 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
> 
> Move each of the variables into a basic block, and mark ocfs2_info_handle()
> as noinline_for_stack, in order to have the variable share stack slots.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/ioctl.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
> index 811a6ea374bb..b1550ba73f96 100644
> --- a/fs/ocfs2/ioctl.c
> +++ b/fs/ocfs2/ioctl.c
> @@ -803,8 +803,8 @@ static int ocfs2_get_request_ptr(struct ocfs2_info *info, int idx,
>   * a better backward&forward compatibility, since a small piece of
>   * request will be less likely to be broken if disk layout get changed.
>   */
> -static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
> -			     int compat_flag)
> +static noinline_for_stack int
> +ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info, int compat_flag)
>  {
>  	int i, status = 0;
>  	u64 req_addr;
> @@ -840,27 +840,26 @@ static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
>  long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> -	int new_clusters;
> -	int status;
> -	struct ocfs2_space_resv sr;
> -	struct ocfs2_new_group_input input;
> -	struct reflink_arguments args;
> -	const char __user *old_path;
> -	const char __user *new_path;
> -	bool preserve;
> -	struct ocfs2_info info;
>  	void __user *argp = (void __user *)arg;
> +	int status;
>  
>  	switch (cmd) {
>  	case OCFS2_IOC_RESVSP:
>  	case OCFS2_IOC_RESVSP64:
>  	case OCFS2_IOC_UNRESVSP:
>  	case OCFS2_IOC_UNRESVSP64:
> +	{
> +		struct ocfs2_space_resv sr;
> +
>  		if (copy_from_user(&sr, (int __user *) arg, sizeof(sr)))
>  			return -EFAULT;
>  
>  		return ocfs2_change_file_space(filp, cmd, &sr);
> +	}
>  	case OCFS2_IOC_GROUP_EXTEND:
> +	{
> +		int new_clusters;
> +
>  		if (!capable(CAP_SYS_RESOURCE))
>  			return -EPERM;
>  
> @@ -873,8 +872,12 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		status = ocfs2_group_extend(inode, new_clusters);
>  		mnt_drop_write_file(filp);
>  		return status;
> +	}
>  	case OCFS2_IOC_GROUP_ADD:
>  	case OCFS2_IOC_GROUP_ADD64:
> +	{
> +		struct ocfs2_new_group_input input;
> +
>  		if (!capable(CAP_SYS_RESOURCE))
>  			return -EPERM;
>  
> @@ -887,7 +890,14 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		status = ocfs2_group_add(inode, &input);
>  		mnt_drop_write_file(filp);
>  		return status;
> +	}
>  	case OCFS2_IOC_REFLINK:
> +	{
> +		struct reflink_arguments args;
> +		const char __user *old_path;
> +		const char __user *new_path;
> +		bool preserve;
> +
>  		if (copy_from_user(&args, argp, sizeof(args)))
>  			return -EFAULT;
>  		old_path = (const char __user *)(unsigned long)args.old_path;
> @@ -895,11 +905,16 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		preserve = (args.preserve != 0);
>  
>  		return ocfs2_reflink_ioctl(inode, old_path, new_path, preserve);
> +	}
>  	case OCFS2_IOC_INFO:
> +	{
> +		struct ocfs2_info info;
> +
>  		if (copy_from_user(&info, argp, sizeof(struct ocfs2_info)))
>  			return -EFAULT;
>  
>  		return ocfs2_info_handle(inode, &info, 0);
> +	}
>  	case FITRIM:
>  	{
>  		struct super_block *sb = inode->i_sb;
