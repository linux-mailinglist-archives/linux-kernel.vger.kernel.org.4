Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7864E61A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLPDEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLPDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:04:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754A5FB84;
        Thu, 15 Dec 2022 19:04:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 375C1B81C95;
        Fri, 16 Dec 2022 03:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C848FC433EF;
        Fri, 16 Dec 2022 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671159844;
        bh=sSaFUt2pb4yIoudJ1qDnuZcyiA9aBB7pOV13DZf4gWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0IXJJFXsviBB+Qg3dgnby87S+C9MoypSgbZRV2iLHT45KmniZ61w8d9aOK1m7wo+W
         K24krhFue93w9VbtfVYjdumE8Y3GoADDNxsQaaKwQZj9D4uu2xjaYq/dKmtECDARH3
         j/YdWihY9Ro4KPoVLYK9BhOn1F/Sx0aJb6g1RQiE=
Date:   Thu, 15 Dec 2022 19:04:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20221215190402.f98d02c525423be8c8a657f4@linux-foundation.org>
In-Reply-To: <20221216122627.6a3ded39@canb.auug.org.au>
References: <20221216122627.6a3ded39@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 12:26:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (sparc defconfig)
> failed like this:
> 
> kernel/pid_namespace.c: In function 'create_pid_namespace':
> kernel/pid_namespace.c:114:9: error: implicit declaration of function 'initialize_memfd_noexec_scope'; did you mean 'set_memfd_noexec_scope'? [-Werror=implicit-function-declaration]
>   114 |         initialize_memfd_noexec_scope(ns);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         set_memfd_noexec_scope
> kernel/pid_namespace.c: In function 'pid_namespaces_init':
> kernel/pid_namespace.c:462:9: error: implicit declaration of function 'register_pid_ns_sysctl_table_vm'; did you mean 'register_pid_ns_ctl_table_vm'? [-Werror=implicit-function-declaration]
>   462 |         register_pid_ns_sysctl_table_vm();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         register_pid_ns_ctl_table_vm
> 
> Caused by commit
> 
>   70ebb551866e ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> 

Thanks.

--- a/kernel/pid_sysctl.h~mm-memfd-add-mfd_noexec_seal-and-mfd_exec-fix
+++ a/kernel/pid_sysctl.h
@@ -52,8 +52,10 @@ static inline void register_pid_ns_sysct
 	register_sysctl_paths(vm_path, pid_ns_ctl_table_vm);
 }
 #else
+static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void set_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void register_pid_ns_ctl_table_vm(void) {}
+static inline void register_pid_ns_sysctl_table_vm(void) {}
 #endif
 
 #endif /* LINUX_PID_SYSCTL_H */
_

