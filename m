Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868C5EA427
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiIZLlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiIZLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:40:48 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA65280E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:45:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MbfWw08WqzMqLsX;
        Mon, 26 Sep 2022 12:44:28 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MbfWv15PqzxK;
        Mon, 26 Sep 2022 12:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664189067;
        bh=CD5C6xTOGWbxduJpk36+aJl7noaWIOhUL8dP/2UeQ/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f27C6uB+afTbOUHgc9hxBrFbzQZ/LtcH1vjNZiWc+OJq6D9yVYBIXLKKgpP9J8vgQ
         13dDbjoqZAYZz7mYDopFn355SCegOCr4rT1UBidp+4sHkHSL0ULdzXO9mC399Wi1lM
         l2Zz9rpF6JYX17RARkGQ6PNrcGR/mAYzayF6pCsM=
Message-ID: <0280dfc4-1497-280a-f0cc-c2867227219b@digikod.net>
Date:   Mon, 26 Sep 2022 12:44:26 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] landlock: Remove unnecessary conditionals
Content-Language: en-US
To:     Jingyu Wang <jingyuwang_vip@163.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908190239.76888-1-jingyuwang_vip@163.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908190239.76888-1-jingyuwang_vip@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review. I agree that this condition is optional but it 
makes the code less error prone, more consistent, easier to read, and 
avoids jumping to an external function. I then don't think this minor 
change is worth it.

On 08/09/2022 21:02, Jingyu Wang wrote:
> iput() has already handled null and non-null parameter, so it is no
> need to use if().
> 
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>   security/landlock/fs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6121e9834961..3d0a8a418ce4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1009,8 +1009,7 @@ static void hook_sb_delete(struct super_block *const sb)
>   	spin_unlock(&sb->s_inode_list_lock);
>   
>   	/* Puts the inode reference from the last loop walk, if any. */
> -	if (prev_inode)
> -		iput(prev_inode);
> +	iput(prev_inode);
>   	/* Waits for pending iput() in release_inode(). */
>   	wait_var_event(&landlock_superblock(sb)->inode_refs,
>   		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
> 
> base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
