Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0043659B62
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiL3Sbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiL3Sbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:31:34 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF8120A2;
        Fri, 30 Dec 2022 10:31:33 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id a184so4152648pfa.9;
        Fri, 30 Dec 2022 10:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LUR/HulHa/R3ncf+4u4lbtVYPtu97Sf8AH2dzsrdYo=;
        b=5NNWwvGL3X+0RPkt+wpgPsSKvnuFkLPuFenS4cFRugtnITOHiUpgv3NfGUcMjDiyD2
         PsNUQxKd86C6X2Zj0kG2d0pYtGk6zkM4C5aUFyzLVn2FqblwCcJuAh0SmWuoRIhRFkhI
         EaoZUgdI0hVlNvXbKe3/rJIF5bnNBKD6M4trLu0S1W+GI+lAW1paidqnb1aO8ySlIXDH
         +wh0xxFOJkdeKCp/4IJi6Kz2J6sHnvxcEjuVZRtcS12CNTPlN4KRVpGhT6upKH1NiYNp
         AtnhITs011A6TyYyvvF6z39W5VmVsBHApBkjaEG22O61Um2Q+cVre7/2wkWnx1f5kZOo
         KAhA==
X-Gm-Message-State: AFqh2kr7djoop8j52UAfWf8FCmrXbGLyXjMaThvmCUKbWmLQNSZZnTPC
        xmNVELbWwdRPXJrYAb9bQntZr91M6mS6BxmtJiaKdKTN
X-Google-Smtp-Source: AMrXdXs0srt36RJwn01N1grV9jc8CWS0ahF4QEsEUY3kkg9aN6vqgGS4lVx2Ly4y6cm95QYGkNCNCXJxWWCDql3TAXA=
X-Received: by 2002:a92:d988:0:b0:30c:2ff1:ae45 with SMTP id
 r8-20020a92d988000000b0030c2ff1ae45mr418627iln.131.1672425082395; Fri, 30 Dec
 2022 10:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20221227063335.61474-1-zh.nvgt@gmail.com>
In-Reply-To: <20221227063335.61474-1-zh.nvgt@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:31:10 +0100
Message-ID: <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: custom_method: fix potential use-after-free issues
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 7:34 AM Hang Zhang <zh.nvgt@gmail.com> wrote:
>
> cm_write() is the .write callback of the custom_method debugfs
> interface, it operates on a global pointer "buf" (e.g., dereference,
> allocate, free, and nullification), the problem is that cm_write()
> is not protected by any locks, so concurrent invocations of it
> may cause use-after-free issues for "buf", e.g., one invocation
> may have just freed "buf" while being preempted before nullifying
> the pointer, then another invocation can dereference the now dangling
> "buf" pointer.
>
> Fix the issue by protecting the "buf" operations in cm_write() with
> the inode write lock. Note that the .llseek callback of the debugfs
> interface has been protected by the same lock, this patch basically
> introduces it to the .write callback as well.

The problem is there, but the whole state is not protected from
concurrent use and the fix doesn't look sufficient to me (for example,
a different writer may start writing into the file before the previous
one has finished and the result will still be broken AFAICS).

It looks like the file should be prevented from being opened by more
than one writer at a time.

Or maybe it's time to drop this interface from the kernel altogether.

> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>  drivers/acpi/custom_method.c | 43 +++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index d39a9b474727..e3de5a06d903 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -29,28 +29,38 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>         struct acpi_table_header table;
>         acpi_status status;
>         int ret;
> +       struct inode *inode = file_inode(file);
>
>         ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
>         if (ret)
>                 return ret;
>
> +       inode_lock(inode);
>         if (!(*ppos)) {
>                 /* parse the table header to get the table length */
> -               if (count <= sizeof(struct acpi_table_header))
> -                       return -EINVAL;
> +               if (count <= sizeof(struct acpi_table_header)) {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
>                 if (copy_from_user(&table, user_buf,
> -                                  sizeof(struct acpi_table_header)))
> -                       return -EFAULT;
> +                                  sizeof(struct acpi_table_header))) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
>                 uncopied_bytes = max_size = table.length;
>                 /* make sure the buf is not allocated */
>                 kfree(buf);
>                 buf = kzalloc(max_size, GFP_KERNEL);
> -               if (!buf)
> -                       return -ENOMEM;
> +               if (!buf) {
> +                       ret = -ENOMEM;
> +                       goto err;
> +               }
>         }
>
> -       if (buf == NULL)
> -               return -EINVAL;
> +       if (buf == NULL) {
> +               ret = -EINVAL;
> +               goto err;
> +       }
>
>         if ((*ppos > max_size) ||
>             (*ppos + count > max_size) ||
> @@ -58,13 +68,15 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>             (count > uncopied_bytes)) {
>                 kfree(buf);
>                 buf = NULL;
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto err;
>         }
>
>         if (copy_from_user(buf + (*ppos), user_buf, count)) {
>                 kfree(buf);
>                 buf = NULL;
> -               return -EFAULT;
> +               ret = -EFAULT;
> +               goto err;
>         }
>
>         uncopied_bytes -= count;
> @@ -74,12 +86,17 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
>                 status = acpi_install_method(buf);
>                 kfree(buf);
>                 buf = NULL;
> -               if (ACPI_FAILURE(status))
> -                       return -EINVAL;
> +               if (ACPI_FAILURE(status)) {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
>                 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
>         }
>
> -       return count;
> +       ret = count;
> +err:
> +       inode_unlock(inode);
> +       return ret;
>  }
>
>  static const struct file_operations cm_fops = {
> --
> 2.39.0
>
