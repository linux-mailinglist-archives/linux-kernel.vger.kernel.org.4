Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAA5BEAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiITQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiITQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06355AC42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7859EB81643
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237CC433C1;
        Tue, 20 Sep 2022 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663690537;
        bh=HGH0DEX/B5xGu+4qt8RGzR+GvT8ac7GQqwwjXmz+Tys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UL1R0B52rEay+3d57IwjGXD4wLHejYn7mSTiEcAq0XnT8XRPmfckViCJa0Xsou/73
         8suRQch4R9cf+gig9UcvU+60ilqlE1QKgfyn/elI8c+g6AMVl0qlaljrDb4LljPbAO
         9W16CgWW8yK1yobx7KZK3H2HSkY3c+4mOcQoxWM39NVmWNTcUjvwiqDm+7TXdkxzsP
         QnUGVR2D/OwCN4nBtUBUyXvYBm6x36yZTHSTNYdmaFAiZZAiL5qhaaL2/Rom8wQGlk
         dRt2NtbKF+KR2KQP6hGsUvGZQcElFzuglAtZy+jLyuX8KKbgOwkrqHW5F48wwqR2rq
         TKROkrGUYDJEw==
Date:   Tue, 20 Sep 2022 18:15:31 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v1 1/3] sysctl: Allow change system v ipc sysctls inside
 ipc namespace
Message-ID: <YynnI2ySUkpu9j6S@example.org>
References: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
 <cover.1660664258.git.legion@kernel.org>
 <63e9e1ff5f988108ceb663a2fbc23a137b0b4311.1660664258.git.legion@kernel.org>
 <87mtav2xn4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtav2xn4.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:26:39AM -0500, Eric W. Biederman wrote:
> >
> > diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> > index ef313ecfb53a..87eb1b1e42fa 100644
> > --- a/ipc/ipc_sysctl.c
> > +++ b/ipc/ipc_sysctl.c
> > @@ -192,23 +192,47 @@ static int set_is_seen(struct ctl_table_set *set)
> >  
> >  static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
> >  {
> > -	int mode = table->mode;
> > -
> > -#ifdef CONFIG_CHECKPOINT_RESTORE
> >  	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Historically that was the best we could do.  But now that we have
> an ipc_set member in struct ipc_namespace you can use container_of
> to compute this value.
> 
> For a permission check that is much safer.

Yes. It make sense.

> > +#ifdef CONFIG_CHECKPOINT_RESTORE
> >  	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
> >  	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
> >  	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
> >  	    checkpoint_restore_ns_capable(ns->user_ns))
> > -		mode = 0666;
> > +		return 0666;
> >  #endif
> > -	return mode;
> > +	if (ns->user_ns != &init_user_ns) {
> > +		kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
> > +		kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
> > +
> > +		if (uid_valid(ns_root_uid) && uid_eq(current_euid(), ns_root_uid))
> > +			return table->mode >> 6;
> > +
> > +		if (gid_valid(ns_root_gid) && in_egroup_p(ns_root_gid))
> > +			return table->mode >> 3;
> 
> >From 10,000 fee this is fine.  But this has to interact with
> test_perm in proc_systl.c.  So can you please do what
> net_ctl_permissions does and replicate the chosen mode all through
> the mode line.
> 
> Perhaps something like:
> 
> 	kuid_t ns_root_uid;
> 	kgid_t ns_root_gid
> 
> 	ipc_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
> 
> #ifdef CONFIG_CHECKPOINT_RESTORE
> 	if (...)
>         	mode = 0666;
>         else
> #endif        
>         if (uid_eq(current_euid(), ns_root_uid))
> 		mode >>= 6;
>         
>         else if (uid_eq(in_group_p(ns_root_gid))
> 		mode >>= 3;
> 
> 	mode &= 7;
>         mode = (mode << 6) | (mode << 3) | mode;
>         return mode;
>         
> 
> If we always pass through the same logic there is the advantage that we
> will always test it, and there is less room for bugs to slip through.
> 
> I added a couple of unnecessary simplifications in there that I just
> saw as I was writing my example code.

Thanks! It looks better. I'll fix it and send a new version.

-- 
Rgrds, legion

