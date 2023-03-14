Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042D86B8EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCNJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCNJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C064875
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678787082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tc33Dyw3A45txAm+RYSoa9jmj4bMCoI+2lkYJK1jmjA=;
        b=Qli6DlihsJEJID/MSY9O63ukrkDsf1/z1Hmfbqat/e51zGnA9Q3ciIj9vyr5wbpRIJaqfl
        In3pANpUMfnQADBscaLvCewiOvB1e59bZD48++xUN7UWd72P9PNuSSY0uRPsEprUkHSYxI
        tyy/zFNq296zpMhSeGWLI1Qq9bGOI+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-93LZ3i7JO2-DcUNVGLhv1Q-1; Tue, 14 Mar 2023 05:44:37 -0400
X-MC-Unique: 93LZ3i7JO2-DcUNVGLhv1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AF14101A52E;
        Tue, 14 Mar 2023 09:44:36 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0ED9202701E;
        Tue, 14 Mar 2023 09:44:35 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, bristot@redhat.com, ebiederm@xmission.com,
        brauner@kernel.org, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        walters@verbum.org, avagin@gmail.com, alexl@redhat.com,
        peterz@infradead.org, bmasney@redhat.com
Subject: Re: [PATCH v4 1/3] exec: add PR_HIDE_SELF_EXE prctl
References: <20230310112554.1261731-1-gscrivan@redhat.com>
Date:   Tue, 14 Mar 2023 10:44:34 +0100
In-Reply-To: <20230310112554.1261731-1-gscrivan@redhat.com> (Giuseppe
        Scrivano's message of "Fri, 10 Mar 2023 12:25:52 +0100")
Message-ID: <87o7ovlla5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> processes to hide their own /proc/self/exe file. When this prctl is
> used, every access to /proc/self/exe for the calling process will
> fail with EPERM.
>
> This is useful for preventing issues like CVE-2019-5736, where an
> attacker can gain host root access by overwriting the binary
> in OCI runtimes through file-descriptor mishandling in containers.
>
> The current fix for CVE-2019-5736 is to create a read-only copy or
> a bind-mount of the current executable, and then re-exec the current
> process.  With the new prctl, the read-only copy or bind-mount copy is
> not needed anymore.
>
> Once prctl(PR_HIDE_SELF_EXE) is set, it will blocks PR_SET_DUMPABLE to
> be set again.  It is not done automatically so that PR_SET_DUMPABLE
> can be set at a later time if needed, e.g. a container runtime might
> want to do that after the user namespace is joined.
>
> It is currently kind of expected that a container uses execve to pass
> control to a binary in the container chroot, since the /proc/self/exe
> and /proc/self/map_files refer to files that are not part of the
> container itself; so if the process can be compromised in any way
> (e.g. an interpreter running a script in the container without calling
> execve), it could potentially lead to host compromise.  It is
> necessary to ensure that the current process cannot be set to dumpable
> anymore, since that would allow another process in the container to
> get access to its proc files.
>
> A container runtime could use the new prctl in the following way:
>
> - run prctl(PR_HIDE_SELF_EXE) as soon as possible.
> - if prctl(PR_HIDE_SELF_EXE) fails then use the more expensive current
>   fallbacks mechanism.
> - perform all operations that require the process to be dumpable.
> - prctl(PR_SET_DUMPABLE, 0), as it is already done today.
> - execve the new binary or run directly the interpreter.
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v3: https://lkml.org/lkml/2023/1/20/434
>
> Differences from v3:
>
> - rebased on top of the latest upstream master.
> - now prctl(PR_HIDE_SELF_EXE) blocks access only from the same thread group, it
>   won't break CRIU as v3 did.
> - extend the prctl to also cover files under /proc/self/map_files.
> - once prctl(PR_HIDE_SELF_EXE) is used, it is not possible to unset
>   SUID_DUMP_DISABLE anymore.  This is useful for the case where the container
>   doesn't use execve to pass the control to a binary in the container chroot, and it
>   prevents the process to be set to dumpable again since it would allow a different
>   process in the container to get access to its proc files.
> - cleaned up the selftest and added more checks.

I've done a mistake in this version of the patchset, so please everyone just ignore it.

