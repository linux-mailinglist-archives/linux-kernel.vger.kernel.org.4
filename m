Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39735739C60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFVJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjFVJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:13:33 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DA27A9B;
        Thu, 22 Jun 2023 02:04:22 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C00D13F2A1;
        Thu, 22 Jun 2023 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687424660;
        bh=ayzNnVsbZ0qeDBn5EvGx27yHY9+ZBPBaAooVSL1pPUY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dmozHwgfcnxYKNUZTPAqBT53uMVSoRswGrYTR/0vGMWQPOFBDSxQiiU3FBdG37uDj
         Ijie988tucDwwL8SgglHdSPwrNY5gHypA2dzF1yvLQ2dvVy9qXx8a5lvZdu6D8KheK
         XRhvGGJ2AokB5paiC8XSLw7bAbhAJn6SyW3fHv5nIxI1ZoYHekE22mBZogWphzK9Y3
         +wiMMhtiSr4WPuhLWq5hvl5GoA4pqOo3V8SQP6efLzUyb1fG9axShfTA5Ax22w9wbz
         Wwnl6C4Gs5wkP2tJl0kvwHNs7UxWNrUMCeNF1AYLdy8ICi8RR7pWrxwJuURZ5UP++D
         HrFdabCy8MuGg==
Message-ID: <5ab83751-e0e2-a0ef-ffd4-4bd292e8498f@canonical.com>
Date:   Thu, 22 Jun 2023 02:04:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 76/79] apparmor: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-75-jlayton@kernel.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230621144735.55953-75-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 07:46, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
lgtm
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/apparmorfs.c    | 6 +++---
>   security/apparmor/policy_unpack.c | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 3d0d370d6ffd..8c72a94dd9e3 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -226,7 +226,7 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
>   
>   	inode->i_ino = get_next_ino();
>   	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>   	inode->i_private = data;
>   	if (S_ISDIR(mode)) {
>   		inode->i_op = iops ? iops : &simple_dir_inode_operations;
> @@ -1557,7 +1557,7 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
>   		if (new->dents[i]) {
>   			struct inode *inode = d_inode(new->dents[i]);
>   
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_ctime_set_current(inode);
>   		}
>   		old->dents[i] = NULL;
>   	}
> @@ -2546,7 +2546,7 @@ static int aa_mk_null_file(struct dentry *parent)
>   
>   	inode->i_ino = get_next_ino();
>   	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>   	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
>   			   MKDEV(MEM_MAJOR, 3));
>   	d_instantiate(dentry, inode);
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 4c188a44d65c..334d69b118a9 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -89,10 +89,10 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
>   		struct inode *inode;
>   
>   		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_ctime_set_current(inode);
>   
>   		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_ctime_set_current(inode);
>   	}
>   }
>   

