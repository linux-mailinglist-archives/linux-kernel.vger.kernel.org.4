Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3E5F8326
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJHFqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:46:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446676745
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DC7EB823A1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 05:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74EDC433D6;
        Sat,  8 Oct 2022 05:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665207972;
        bh=nDg21FtewsQFxbiJ9Em2i5TbxM2QihLggVdu6PHLss0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUEjNDNChNmdBb922klXuDpCzPSre6NtcXXP43X7CtkiX2JEHh12UxnJT2vV41moX
         6ulxPqoAWUuJaP4ho3lS29H4F8QY/ofkRMlU8vLtjfFjLcwBFqOc4XVGglrMOmHjAo
         OU572UYpMKTXrKxIKADViEbXORhKsMTERS09ioAnoY/0qFlZXG0RofSb9ERisAWqUD
         dpdjlLevmuvvfC7w20FjFmmH71paut5GF5s6/5C9Iy/9fsyd8DLjmdt6ngaIbGiWuY
         k3YjmUvxLbhz/3hKt90CayfIZStDU7ibliLAGkCXSV3zgrBuSZ9CRy+6+Qep8QWR6Y
         ueo1XzS9Uh7Nw==
Date:   Sat, 8 Oct 2022 07:46:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
Message-ID: <20221008054607.fyqzd7oil2ulzf34@wittgenstein>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:35:49AM -1000, Tejun Heo wrote:
> (cc'ing Christian and quoting whole body)
> 
> Christan, I can't repro it here but think what we need is sth like the
> following. The problem is that cgroup_is_dead() check in the fork path isn't
> enough as the perm check depends on cgrp->procs_file being available but
> that is cleared while DYING before DEAD. So, depending on the timing, we can
> end up trying to deref NULL pointer in may_write.
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 8ad2c267ff471..603b7167450a1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4934,6 +4934,10 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> +	/*if @cgrp is being removed, procs_file may already be gone */
> +	if (!cgrp->procs_file.kn)
> +		return -ENODEV;
> +
>  	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
>  	if (!inode)
>  		return -ENOMEM;

Tejun, thanks for the Cc.
Yep, that seems to be the correct analysis.
I assume you're turning this into a proper patch, so:

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
