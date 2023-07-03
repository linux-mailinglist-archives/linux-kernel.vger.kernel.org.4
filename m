Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F56745F74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGCPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGCPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:07:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1D0E44
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:07:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so115525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688396840; x=1690988840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yi73LNZtiJVtdv9XwcLHpbVmu5fGLj+HQkOyGONQFg=;
        b=nNLdtYLhT36EufRkpLv7ca6KV7NAAZgN9RHacCq/L6iFOvy47lS0Jtv965Pogb/qL4
         VxabMsMZuttYx2zc72BwOZdqEEv7R+4AL2E44+Ph/vn7lhek+4iddm/sETqfl2XYlQeR
         J+vySOqsZ5LRqFBT9cPIm2Pmu1HBOM0zkCXgvhQuph8X20jRqvsu1VTDFceEQFbHYCYJ
         5CgP4NseOo3j/3ZVP0wYcPlcBkFGO6BdRiJM/UwtfJ3fYbsyg78AplEsjvEKI3DMxH2+
         KBtrbQ4sd3cjcYmN79W0y6fMq3+aT81/iMF5RTkM3cIBrj1/zdi+9VzkgjmDLIhcu5iL
         fvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396840; x=1690988840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Yi73LNZtiJVtdv9XwcLHpbVmu5fGLj+HQkOyGONQFg=;
        b=BFvUZOQoRljlQjKEi+k6ZitxgBPLKcKFctLYsdaZ4sipvmvHpuNOw7kyRXi0OdKF1V
         C9ufVSa7ylM5j4QqMGSRctAsGak6y/fgBowSFEFVtmxnXGkPxklqz9Df12ezssxzCoY+
         ymEuB7Y/ygC+JNGeWH/6FdcsJCDTsdeXULDtbbpQeAD1/kA3p9Sioyup/MUQt0qx2QL1
         SOO/pHpNCH2THMw6vopwsVTiawBbxpqOdRpvt42zy2dts89yYpjntoNb8opPbyDo1XXt
         sR5jOwr/e/SCZ1pnW00I55EIaCMPQpSIrptJz1Bs/hpADT7z4rKMZ6FcbTU7ic5oYMes
         HVMg==
X-Gm-Message-State: ABy/qLbsKtz3WlczahFrQaDm/CtJiztrh9ACx85e7Uu8z8pmn74FiWwp
        eL2i96q5NkPYCqRrW+caPxbz6L6X3gj88x83sB5LCA==
X-Google-Smtp-Source: APBJJlErLYbKhG362h11ORTRwVJGnuMRUrvtq/Y89AtBohzfF9IqoDlTx3PR/gLXPUH5GATUu8k8ZqKi1AZSHsYpChk=
X-Received: by 2002:a05:600c:1e1d:b0:3f7:3654:8d3 with SMTP id
 ay29-20020a05600c1e1d00b003f7365408d3mr190166wmb.2.1688396839544; Mon, 03 Jul
 2023 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
In-Reply-To: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Jul 2023 17:06:42 +0200
Message-ID: <CAG48ez2oRPBdbfoNxGcV85CXFx1Su+dmhoWXE6rWsXui6_OTPg@mail.gmail.com>
Subject: Re: [QUESTION] Full user space process isolation?
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 4:45=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> I wanted to execute some kernel workloads in a fully isolated user
> space process, started from a binary statically linked with klibc,
> connected to the kernel only through a pipe.

FWIW, the kernel has some infrastructure for this already, see
CONFIG_USERMODE_DRIVER and kernel/usermode_driver.c, with a usage
example in net/bpfilter/.

> I also wanted that, for the root user, tampering with that process is
> as hard as if the same code runs in kernel space.

I believe that actually making it that hard would probably mean that
you'd have to ensure that the process doesn't use swap (in other
words, it would have to run with all memory locked), because root can
choose where swapped pages are stored. Other than that, if you mark it
as a kthread so that no ptrace access is allowed, you can probably get
pretty close. But if you do anything like that, please leave some way
(like a kernel build config option or such) to enable debugging for
these processes.

But I'm not convinced that it makes sense to try to draw a security
boundary between fully-privileged root (with the ability to mount
things and configure swap and so on) and the kernel - my understanding
is that some kernel subsystems don't treat root-to-kernel privilege
escalation issues as security bugs that have to be fixed.
