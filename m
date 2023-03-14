Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C56B8F91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCNKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCNKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:16:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D509B2F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:16:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C9001F88C;
        Tue, 14 Mar 2023 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678788968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwHpkf9LDB4j61CdLEk43p8IDPlZHPFH+fNHk9C8L+g=;
        b=CaIcxf9TyEERgVm8JF6Eo3azpgAGg+yUc2eASVxgv/2fwHHi+pFsrOnxGHVglbEHl42TLI
        oExoxmrSmGrtI5tpI1WgYFEVEelen/bDc/5TcxQ8Vv1Kw0iZF83u+79O8u4fSw+QzW0fpi
        XW9hoIVOYDBgWYFXKccCS7AfzbRvxs0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A03213A26;
        Tue, 14 Mar 2023 10:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DzZpDGhJEGTBBwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Mar 2023 10:16:08 +0000
Date:   Tue, 14 Mar 2023 11:16:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/oom_kill: don't kill exiting tasks in
 oom_kill_memcg_member
Message-ID: <ZBBJZx3Em9L9/3jn@dhcp22.suse.cz>
References: <20230314091136.264878-1-haifeng.xu@shopee.com>
 <ZBA8NlwBTprShO3e@dhcp22.suse.cz>
 <f774cfeb-9524-5fd7-fe2d-e6c2a58684e2@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f774cfeb-9524-5fd7-fe2d-e6c2a58684e2@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-03-23 18:07:42, Haifeng Xu wrote:
> 
> 
> On 2023/3/14 17:19, Michal Hocko wrote:
> > On Tue 14-03-23 09:11:36, Haifeng Xu wrote:
> >> If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
> >> to kill all processes in the memcg. When scanning tasks in memcg, maybe
> >> the provided task is marked as oom victim. Also, some tasks are likely
> >> to release their address space. There is no need to kill the exiting tasks.
> > 
> > This doesn't state any actual problem. Could you be more specific? Is
> > this a bug fix, a behavior change or an optimization?
> 
> 
> 1) oom_kill_process() has inovked __oom_kill_process() to kill the selected victim, but it will be scanned
> in mem_cgroup_scan_tasks(). It's pointless to kill the victim twice. 

Why does that matter though? The purpose of task_will_free_mem in
oom_kill_process is different. It would bail out from a potentially
noisy OOM report when the selected oom victim is expected to terminate
soon. __oom_kill_process called for the whole memcg doesn't aim at
avoiding any oom victims. It merely sends a kill signal too all of them.

> 2) for those exiting processes, reaping them directly is also a faster way to free memory compare with invoking
> __oom_kill_process().

Is it? What if the terminating task is blocked on lock? Async oom
reaping might release those resources in that case.
-- 
Michal Hocko
SUSE Labs
