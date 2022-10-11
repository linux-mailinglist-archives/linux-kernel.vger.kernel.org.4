Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F65FB796
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJKPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJKPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:43:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EFC4DBF;
        Tue, 11 Oct 2022 08:32:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5636B33D70;
        Tue, 11 Oct 2022 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665500269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uq2eyzBPhkHR87loB7Swe6vfT9JewwGCA0YfCXRfsuI=;
        b=jMVi+AsLr/wUxc5+USNsrnM9R6R2/FnU9ZHuL0emC3HbOW/FolepsIBMqNV7lHo+DPP0rx
        0ZphIu82iivF9WLhRY+M4s78H1w/vbYz+QXIu3/LiN13KzNw9B7rWlOmQkFE/mkPfMKEbN
        bT9o4QyIPXLovgr3RSu/+prVPmLWu6k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F56A139ED;
        Tue, 11 Oct 2022 14:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hBE9Cm2ERWNOSAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Oct 2022 14:57:49 +0000
Date:   Tue, 11 Oct 2022 16:57:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-10-22 17:48:42, Zhongkun He wrote:
> There is usecase that System Management Software(SMS) want to give a
> memory policy to other processes to make better use of memory.
> 
> The information about how to use memory is not known to the app.
> Instead, it is known to the userspace daemon(SMS), and that daemon
> will decide the memory usage policy based on different factors.

Please add some explanation why the cpuset interface is not usable for
that usecase.

> To solve the issue, this patch introduces a new syscall
> pidfd_set_mempolicy(2).  it sets the NUMA memory policy of the thread
> specified in pidfd.
> 
> In current process context there is no locking because only the process
> accesses its own memory policy, so task_work is used in
> pidfd_set_mempolicy() to update the mempolicy of the process specified
> in pidfd, avoid using locks and race conditions.

Why cannot you alter kernel_set_mempolicy (and do_set_mempolicy) to
accept a task rather than operate on current?

I have to really say that I dislike the task_work approach because it
detaches the syscall from the actual operation and the caller simply
doesn't know when the operation has been completed.
> 
> The API is as follows,
> 
> 		long pidfd_set_mempolicy(int pidfd, int mode,
>                                      const unsigned long __user *nmask,
>                                      unsigned long maxnode,
>                                      unsigned int flags);
> 
> Set's the [pidfd] task's "task/process memory policy". The pidfd argument
> is a PID file descriptor (see pidfd_open(2) man page) that specifies the
> process to which the mempolicy is to be applied. The flags argument is
> reserved for future use; currently, this argument must be specified as 0.
> Please see the set_mempolicy(2) man page for more details about
> other's arguments.

Please also describe the security model.
-- 
Michal Hocko
SUSE Labs
