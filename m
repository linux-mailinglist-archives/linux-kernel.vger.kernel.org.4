Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6505FCCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJLVTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJLVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:19:41 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC013FC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:19:39 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MnlsP3w5jzMq2xd;
        Wed, 12 Oct 2022 23:19:37 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MnlsN2gQzzMpnPh;
        Wed, 12 Oct 2022 23:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609577;
        bh=f6ho670Ssi6Yqc2ZmExLTISuEG5IR6eG35aVRS+Fu2U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LUVLoE6CLixE3PA0iPieAPohZNjCdXMIkJaMh64frVqd9un42jIQgUe4f4lOqt8P5
         8f8LjeW5fN3D3tkDuwQZF/NzA3wWpuWwGOlBVW2pQtioyTcpXou/DD7Roa7qcSEQli
         aH8WiKzb5XHSPSwmMJ8ZVe9lnD2IFzePJ0p7ITec=
Message-ID: <ecfb35c0-147c-52c8-b733-7ab753c152ea@digikod.net>
Date:   Wed, 12 Oct 2022 23:19:35 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 20/39] LSM: Specify which LSM to display
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-21-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927195421.14713-21-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/09/2022 21:54, Casey Schaufler wrote:
> Create two new prctl() options PR_LSM_ATTR_SET and PR_LSM_ATTR_GET
> which change and report the Interface LSM respectively.
> 
> The LSM ID number of an active LSM that supplies hooks for
> human readable data may be passed in the arg2 value with the
> PR_LSM_ATTR_SET option. The PR_LSM_ATT_GET option returns the
> LSM ID currently in use. At this point there can only be one LSM
> capable of display active. A helper function lsm_task_ilsm() is
> provided to get the interface lsm slot for a task_struct.
> 
> Security modules that wish to restrict this action may provide
> a task_prctl hook to do so. Each such security module is
> responsible for defining its policy.
> 
> AppArmor hook initially provided by John Johansen
> <john.johansen@canonical.com>. SELinux hook initially provided by
> Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

[...]

> diff --git a/security/security.c b/security/security.c
> index 80133d6e982c..43d2431dbda0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/string.h>
>   #include <linux/msg.h>
> +#include <linux/prctl.h>
>   #include <uapi/linux/lsm.h>
>   #include <net/flow.h>
>   #include <net/sock.h>
> @@ -81,7 +82,16 @@ static struct kmem_cache *lsm_file_cache;
>   static struct kmem_cache *lsm_inode_cache;
>   
>   char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +
> +/*
> + * The task blob includes the "interface_lsm" slot used for
> + * chosing which module presents contexts.
> + * Using a long to avoid potential alignment issues with
> + * module assigned task blobs.
> + */
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(long),
> +};
>   
>   /* Boot-time LSM user choice */
>   static __initdata const char *chosen_lsm_order;
> @@ -691,6 +701,8 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> +	int *ilsm;
> +
>   	if (blob_sizes.lbs_task == 0) {
>   		task->security = NULL;
>   		return 0;
> @@ -699,6 +711,15 @@ static int lsm_task_alloc(struct task_struct *task)
>   	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>   	if (task->security == NULL)
>   		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "interface" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	ilsm = task->security;
> +	*ilsm = LSMBLOB_INVALID;
> +
>   	return 0;
>   }
>   
> @@ -1765,14 +1786,26 @@ int security_file_open(struct file *file)
>   
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   {
> +	int *oilsm = current->security;
> +	int *nilsm;
>   	int rc = lsm_task_alloc(task);
>   
> -	if (rc)
> +	if (unlikely(rc))
>   		return rc;
> +
>   	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>   		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	if (oilsm) {
> +		nilsm = task->security;
> +		if (nilsm)
> +			*nilsm = *oilsm;
> +	}
> +
> +	return 0;
>   }
>   
>   void security_task_free(struct task_struct *task)
> @@ -2031,10 +2064,15 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>   int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>   			 unsigned long arg4, unsigned long arg5)
>   {
> +	int *ilsm = current->security;
>   	int thisrc;
> +	int slot;
>   	int rc = LSM_RET_DEFAULT(task_prctl);
>   	struct security_hook_list *hp;
>   
> +	if (lsm_slot == 0)
> +		return -EINVAL;
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
>   		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
>   		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
> @@ -2043,6 +2081,25 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>   				break;
>   		}
>   	}
> +
> +	switch (option) {
> +	case PR_LSM_ATTR_SET:
> +		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
> +			return rc;
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (lsm_slotlist[slot]->id == arg2) {

This doesn't build if LSMBLOB_ENTRIES == 0


> +				*ilsm = lsm_slotlist[slot]->slot;
> +				return 0;
> +			}
> +		return -EINVAL;
> +	case PR_LSM_ATTR_GET:
> +		if (rc && rc != LSM_RET_DEFAULT(task_prctl))
> +			return rc;
> +		if (*ilsm != LSMBLOB_INVALID)
> +			return lsm_slotlist[*ilsm]->id;
> +		return lsm_slotlist[0]->id;
> +	}
> +
>   	return rc;
>   }
>   
