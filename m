Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274B613941
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJaOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E91004F;
        Mon, 31 Oct 2022 07:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50BC61283;
        Mon, 31 Oct 2022 14:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1779C433C1;
        Mon, 31 Oct 2022 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667227626;
        bh=bvPTrbd4wsEEynw/oCcmxS/LyrJJESkFjn0KKYoaQSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FcBuQIXt+s50/NKa2f1CIohqF8AYtt4q9g4aGbWG8PiP67t+hFyEcQEyCF2vmuphd
         i53y2LSODUOZcjr/oYqboojx+OYIWfkQlLCG8cGg6BpMqTgff2jTV/8Nd8oZmyPR39
         phLULipsj7Fcv9rVjGcffVnzecxcSN5zJb4dwjwcyOIYMHDSZiWYda62NrK8wmz6xv
         TnUR9o4BPPt/E9ZutKS+eFb/UQBwwsDS2/bk6PUMXU/gtwKiW+eJ4QkimZ/nBwTHzs
         tYT6RtMhd/z2/fCPlGdcwJJVbYiaweBVMNASnk/jwGGyQCfiJUIS/HNWfgV3yuNU4c
         MWjufoIv1tTTQ==
Date:   Mon, 31 Oct 2022 23:47:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] tracing/user_events: Use remote writes for
 event enablement
Message-Id: <20221031234703.e275650899728e64cd3fb6c3@kernel.org>
In-Reply-To: <20221027224011.2075-2-beaub@linux.microsoft.com>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
        <20221027224011.2075-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some comments.

On Thu, 27 Oct 2022 15:40:10 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

[...]
> @@ -1570,11 +1610,12 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
>   * Registers a user_event on behalf of a user process.
>   */
>  static long user_events_ioctl_reg(struct user_event_file_info *info,
> -				  unsigned long uarg)
> +				  struct file *file, unsigned long uarg)
>  {
>  	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
>  	struct user_reg reg;
>  	struct user_event *user;
> +	struct user_event_enabler *enabler;
>  	char *name;
>  	long ret;
>  
> @@ -1607,8 +1648,12 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
>  	if (ret < 0)
>  		return ret;
>  
> +	enabler = user_event_enabler_create(file, &reg, user);
> +
> +	if (!enabler)

Shouldn't we free the user_event if needed here?
(I found the similar memory leak pattern in the above failure case
 of the user_events_ref_add().)

> +		return -ENOMEM;
> +
>  	put_user((u32)ret, &ureg->write_index);
> -	put_user(user->index, &ureg->status_bit);
>  
>  	return 0;
>  }
[...]
> @@ -1849,7 +1863,6 @@ static int user_status_open(struct inode *node, struct file *file)
>  
>  static const struct file_operations user_status_fops = {
>  	.open = user_status_open,
> -	.mmap = user_status_mmap,

So, if this drops the mmap operation, can we drop the writable flag from
the status tracefs file?

static int create_user_tracefs(void)
{
[...]
        /* mmap with MAP_SHARED requires writable fd */
        emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
                                    NULL, NULL, &user_status_fops);

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
