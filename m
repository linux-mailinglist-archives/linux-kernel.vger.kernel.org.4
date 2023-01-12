Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911A668631
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbjALVvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbjALVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:49:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4D5F69
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:43:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s67so13704136pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7Ge98iYbW9+59PEfzNDi44Q4iiB25ayX+9FCzJG+KU=;
        b=Q/xxU0FH2OQWU8NojejcIMTAZqTBGgnHKZ3vy49w9Wjey5NCdcq4R5vsd3oIzrZKIs
         4oEKE1TfnoEQmnnZxQaNN7YuXnG/XysEgaFLicZP6O85YnQtOEMumDb+zVK8DVls1Zan
         5WtVdrhJFM+tYohljO2p2WvBUVq1LWppCowMh++wekm7I0oLVMDVE2R2TawboCRLqLV/
         zOffdpmVq37ARuXMeSk0c+EiD7NId+BPACpvI2AXHkWuKLezPYzhCpTTKlPTZlWrTmcO
         8bkZTZC83urnoYPmvHvPBk1GCuKCsIEbg+f8vilZEVydMa4Ond8OeBUF2OpDX37MLKwj
         13Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7Ge98iYbW9+59PEfzNDi44Q4iiB25ayX+9FCzJG+KU=;
        b=KVCJzJny+Ycg5K8amtRiIVQoIYBsbHqS1kGGONHoYoTNyCpksjmYGK2DoGEOPK05Nb
         JZ1JO8ZXv1XS79f6dncfKSucAvSzhm8PU1NYQ8823CmjJ/+KYoLCgI+p1qILo0aPcaVv
         alucFsDNUcFqR0RU4I7vMkgT495cCu0rMgy/wo9JvuB2wSFcLba5gZ0bgfnn1fCfKuMT
         Oj1IcPkMcKeTh85vK1a5HRK8dIFc9BLB/3jC2JLSxEYQVNDrk7TzyAwXmCyNmQfc5R5J
         v4jIK8p72Tob7YM9jg/T2bk8SVLHW8pTZmOE/bI9gIR0k9hfchmcFxrsHx8hlCJOpUhm
         uCZg==
X-Gm-Message-State: AFqh2kpbIm4O/uLMHZR1q/19Ovc+KrLAnvLkmTaTWq0IY+fXZJ4pKki0
        lisSGv+5YdYchdoipwtPPd0B/f5g7Avuh2dw+G6s
X-Google-Smtp-Source: AMrXdXsTWCOAsf593kAuk5vXk8SWPCprApE2bQ7G/HYv2nPn+uRJkEj48Tbck/WjVnesf8n2/A8D05yOLKYpIvoEQ80=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1367513pfv.23.1673559813139; Thu, 12
 Jan 2023 13:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-6-casey@schaufler-ca.com> <CAHC9VhTFRXdRZnnORw-fU4Wo84HMUMw8+JTTJvc4+pv8YELBHw@mail.gmail.com>
 <8b345948-5b9d-37f9-16df-6d632af41477@schaufler-ca.com>
In-Reply-To: <8b345948-5b9d-37f9-16df-6d632af41477@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 16:43:22 -0500
Message-ID: <CAHC9VhQn0QxYW7wZ4H14AYNMik0AnojB6qmTCn2Swkep956WMg@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] LSM: Create lsm_module_list system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 8:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/11/2023 1:07 PM, Paul Moore wrote:
> > On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call to report the list of Linux Security Modules
> >> that are active on the system. The list is provided as an array
> >> of LSM ID numbers.
> >>
> >> The calling application can use this list determine what LSM
> >> specific actions it might take. That might include chosing an
> >> output format, determining required privilege or bypassing
> >> security module specific behavior.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  Documentation/userspace-api/lsm.rst |  3 +++
> >>  include/linux/syscalls.h            |  1 +
> >>  kernel/sys_ni.c                     |  1 +
> >>  security/lsm_syscalls.c             | 41 +++++++++++++++++++++++++++++
> >>  4 files changed, 46 insertions(+)
> > ..
> >
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> index 55e8bf61ac8a..92af1fcaa654 100644
> >> --- a/security/lsm_syscalls.c
> >> +++ b/security/lsm_syscalls.c
> >> @@ -180,3 +180,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr,
> >>         kfree(final);
> >>         return rc;
> >>  }
> >> +
> >> +/**
> >> + * sys_lsm_module_list - Return a list of the active security modules
> >> + * @ids: the LSM module ids
> >> + * @size: size of @ids, updated on return
> >> + * @flags: reserved for future use, must be zero
> >> + *
> >> + * Returns a list of the active LSM ids. On success this function
> >> + * returns the number of @ids array elements. This value may be zero
> >> + * if there are no LSMs active. If @size is insufficient to contain
> >> + * the return data -E2BIG is returned and @size is set to the minimum
> >> + * required size. In all other cases a negative value indicating the
> >> + * error is returned.
> >> + */
> >> +SYSCALL_DEFINE3(lsm_module_list,
> >> +               u32 __user *, ids,
> >> +               size_t __user *, size,
> >> +               u64, flags)
> >> +{
> >> +       size_t total_size = lsm_active_cnt * sizeof(*ids);
> >> +       size_t usize;
> >> +       int i;
> >> +
> >> +       if (flags)
> >> +               return -EINVAL;
> >> +
> >> +       if (get_user(usize, size))
> >> +               return -EFAULT;
> >> +
> >> +       if (put_user(total_size, size) != 0)
> >> +               return -EFAULT;
> >> +
> >> +       if (usize < total_size)
> >> +               return -E2BIG;
> >> +
> >> +       for (i = 0; i < lsm_active_cnt; i++)
> >> +               if (put_user(lsm_idlist[i]->id, ids++))
> >> +                       return -EFAULT;
> >> +
> >> +       return lsm_active_cnt;
> >> +}
> > Similar to my comments in 4/8, I would probably create a new LSM hook
> > for this syscall so that the lsm_ctx is passed through the LSM layer
> > directly to the target LSM:
> >
> >   int security_sys_setselfattr(u64 attr, struct lsm_ctx __user *ctx,
> > size_t len);
>
> That seems like a whole lot of work when you can just look it up
> in an existing table.

D'oh!  Sorry, this comment was intended for patch 6/8, the
lsm_set_self_attr() syscall patch.  I agree, it would be very silly to
have a dedicated hook for lsm_module_list() :)

-- 
paul-moore.com
