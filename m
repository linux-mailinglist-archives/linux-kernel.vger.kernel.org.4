Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D4686E02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBASfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBASfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:35:03 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FD6E423;
        Wed,  1 Feb 2023 10:35:01 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id p26so42901854ejx.13;
        Wed, 01 Feb 2023 10:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4mO2LOMTlhhSzjTQiiSHJojH9cnyM5bnRTNJd66iHE=;
        b=r41V/RyaMIsJDZMK0WQ0yZ/KeHWYW4Ain6jaOJr05pxXcoI3IeqXrg5ihwtFrpOXH+
         i2XMEk0PLcJ1ZI4NW7k4uwP4hholM6dZnQdb3z9H2hGdCmbk1KU3eys8BRvjZxjLX0IL
         fP6SkXwET9ruiXna+182nysnYBUlOM1rnDIT/tYN20G5OYNairsrqNQdvfUtMUyniC86
         eP6MMW089+OmtSLvAwF7auPo8VU7J0uWqBhkBxoLcuTLTazRr8hzK2aTNUHMXpGwmFzw
         RQ/PRID1/0PfcfNMWv3+eACdv0NbLHlYjZR7MZY1RkjnEkJ2RXbpFVko2NVYit/+z5C5
         WcVQ==
X-Gm-Message-State: AO0yUKVHY7ayQb/unaKXS+KIzOX7FUflRROpY26ZytLJmpEg+yesFAFM
        Coqm+UArIaMKf1iCQamA85wdITI+K0IhW/m9lwY=
X-Google-Smtp-Source: AK7set+BQe+ocpEmZK4Pctf0Q5KHupY/TyCik+Cqn9iBGKunAHCtNCglB7IKz6fkKEGL/oFTXRZ2lCCiY5Wy1Pe5mso=
X-Received: by 2002:a17:906:85c7:b0:878:581b:63ee with SMTP id
 i7-20020a17090685c700b00878581b63eemr895179ejy.244.1675276500194; Wed, 01 Feb
 2023 10:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
In-Reply-To: <20230131233755.58942-1-pedro.falcato@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Feb 2023 19:34:48 +0100
Message-ID: <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Hang Zhang <zh.nvgt@gmail.com>,
        Swift Geek <swiftgeek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato <pedro.falcato@gmail.com> wrote:
>
> Make custom_method keep its own per-file-open state instead of global
> state in order to avoid race conditions[1] and other possible conflicts
> with other concurrent users.
>
> Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
> Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> Cc: Swift Geek <swiftgeek@gmail.com>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  This patch addresses Hang's problems plus the ones raised by Rafael in his review (see link above).
>  https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was submitted but since there were still people
>  that wanted this feature, I took my time to write up a patch that should fix the issues.
>  Hopefully the linux-acpi maintainers have not decided to remove custom_method just yet.

Well, thanks for the patch, but yes, they have.  Sorry.

>  drivers/acpi/custom_method.c | 119 +++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index d39a9b47472..034fb14f118 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -17,73 +17,138 @@ MODULE_LICENSE("GPL");
>
>  static struct dentry *cm_dentry;
>
> +struct custom_method_state {
> +       char *buf;
> +       u32 max_size;
> +       u32 uncopied_bytes;
> +       struct mutex lock;
> +};
> +
> +static int cm_open(struct inode *inode, struct file *file)
> +{
> +       struct custom_method_state *state;
> +
> +       state = kzalloc(sizeof(struct custom_method_state), GFP_KERNEL);
> +
> +       if (!state)
> +               return -ENOMEM;
> +
> +       file->private_data = state;
> +       mutex_init(&state->lock);
> +
> +       return 0;
> +}
> +
> +static int cm_release(struct inode *inode, struct file *file)
> +{
> +       struct custom_method_state *state;
> +
> +       state = file->private_data;
> +
> +       mutex_destroy(&state->lock);
> +
> +       /* Make sure the buf gets freed */
> +       kfree(state->buf);
> +
> +       kfree(state);
> +       return 0;
> +}
> +
>  /* /sys/kernel/debug/acpi/custom_method */
>
>  static ssize_t cm_write(struct file *file, const char __user *user_buf,
>                         size_t count, loff_t *ppos)
>  {
> -       static char *buf;
> -       static u32 max_size;
> -       static u32 uncopied_bytes;
> +       struct custom_method_state *state;
> +       char *buf;
>
>         struct acpi_table_header table;
>         acpi_status status;
>         int ret;
>
> +       state = file->private_data;
> +       buf = state->buf;
> +
>         ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
>         if (ret)
>                 return ret;
>
> +       mutex_lock(&state->lock);
> +
>         if (!(*ppos)) {
>                 /* parse the table header to get the table length */
> -               if (count <= sizeof(struct acpi_table_header))
> -                       return -EINVAL;
> +               if (count <= sizeof(struct acpi_table_header)) {
> +                       count = -EINVAL;
> +                       goto out;
> +               }
> +
>                 if (copy_from_user(&table, user_buf,
> -                                  sizeof(struct acpi_table_header)))
> -                       return -EFAULT;
> -               uncopied_bytes = max_size = table.length;
> +                                  sizeof(struct acpi_table_header))) {
> +                       count = -EFAULT;
> +                       goto out;
> +               }
> +
> +               state->uncopied_bytes = state->max_size = table.length;
>                 /* make sure the buf is not allocated */
>                 kfree(buf);
> -               buf = kzalloc(max_size, GFP_KERNEL);
> -               if (!buf)
> -                       return -ENOMEM;
> +               buf = state->buf = kzalloc(state->max_size, GFP_KERNEL);
> +               if (!buf) {
> +                       count = -ENOMEM;
> +                       goto out;
> +               }
>         }
>
> -       if (buf == NULL)
> -               return -EINVAL;
> +       /* Check if someone seeked ahead or if we errored out
> +        * (buf will be NULL)
> +        */
> +       if (buf == NULL) {
> +               count = -EINVAL;
> +               goto out;
> +       }
>
> -       if ((*ppos > max_size) ||
> -           (*ppos + count > max_size) ||
> +       if ((*ppos > state->max_size) ||
> +           (*ppos + count > state->max_size) ||
>             (*ppos + count < count) ||
> -           (count > uncopied_bytes)) {
> -               kfree(buf);
> -               buf = NULL;
> -               return -EINVAL;
> +           (count > state->uncopied_bytes)) {
> +               count = -EINVAL;
> +               goto err_free;
>         }
>
>         if (copy_from_user(buf + (*ppos), user_buf, count)) {
> -               kfree(buf);
> -               buf = NULL;
> -               return -EFAULT;
> +               count = -EFAULT;
> +               goto err_free;
>         }
>
> -       uncopied_bytes -= count;
> +       state->uncopied_bytes -= count;
>         *ppos += count;
>
> -       if (!uncopied_bytes) {
> +       if (!state->uncopied_bytes) {
>                 status = acpi_install_method(buf);
>                 kfree(buf);
> -               buf = NULL;
> -               if (ACPI_FAILURE(status))
> -                       return -EINVAL;
> +               state->buf = NULL;
> +
> +               if (ACPI_FAILURE(status)) {
> +                       count = -EINVAL;
> +                       goto out;
> +               }
> +
>                 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
>         }
>
> +out:
> +       mutex_unlock(&state->lock);
> +       return count;
> +err_free:
> +       mutex_unlock(&state->lock);
> +       kfree(buf);
> +       state->buf = NULL;
>         return count;
>  }
>
>  static const struct file_operations cm_fops = {
>         .write = cm_write,
> +       .open = cm_open,
> +       .release = cm_release,
>         .llseek = default_llseek,
>  };
>
> --
> 2.39.0
>
