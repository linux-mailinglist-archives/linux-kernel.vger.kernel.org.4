Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2367C1B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjAZAbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjAZAbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABB64DA3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674693022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHSmXHW9yZ+UbSSxJPY4DxQLbjMrGPHlslJcTPeWITk=;
        b=beaSWHeKmNbjZVCJ8ObJo/bIdhbxQ3PUDahOCKXiuiu6ZSZEW6NjOVrLAmO5PNaBlndnYX
        6ZQ43reFXkAqhwRhQ3drvgTP2tcdCnzwEDDquuaxvpXyBTpWSgBeQxFmEGUZ8YmpmjY048
        aCK0nCyRpD53DQL6UoWWB7l8k5/H5g0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-BtXAPO8HM76e3a6RiLVqdg-1; Wed, 25 Jan 2023 19:30:15 -0500
X-MC-Unique: BtXAPO8HM76e3a6RiLVqdg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35FB185C06A;
        Thu, 26 Jan 2023 00:30:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 07FA1492C14;
        Thu, 26 Jan 2023 00:30:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 26 Jan 2023 01:30:12 +0100 (CET)
Date:   Thu, 26 Jan 2023 01:30:08 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
Message-ID: <20230126003008.GA31684@redhat.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125025126.787431-2-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24, Gregory Price wrote:
>
> Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> modify Syscall User Dispatch to suspend interception when enabled.
>
> This is modeled after the SUSPEND_SECCOMP feature, which suspends
> SECCOMP interposition.  Without doing this, software like CRIU will
> inject system calls into a process and be intercepted by Syscall
> User Dispatch, either causing a crash (due to blocked signals) or
> the delivery of those signals to a ptracer (not the intended behavior).

Cough... Gregory, I am sorry ;)

but can't we drop this patch to ?

CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
config->mode anyway as we discussed.

Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
with the same effect, no?

Oleg.

