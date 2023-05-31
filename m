Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2671738D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjEaCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjEaCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:12:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F223EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:12:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so8755934a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1685499129; x=1688091129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucx4kwK8ujRzNJbb04V3YLVl0GtgGlj1PvcZVvmj1Eg=;
        b=UksYza6wNv++MXgkLV6TDe5P04amEFt0Y/STxFL5ddTVUpx9Oof8N9nejDVj0LJBaZ
         Qp9nHyCFEoOR2KT7C59Zo4iAZgnllES/CX4UtbLXNF/cafT7E7uaRCE5ICzrl5osOrzh
         MS2F0URjTIywWbkLqEpmPRsMFkH/rpfcRCPP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685499129; x=1688091129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucx4kwK8ujRzNJbb04V3YLVl0GtgGlj1PvcZVvmj1Eg=;
        b=EDkrxbVkQHPaj+pfXW7Cvhbp+yzo3CEbgH3X1rg4bHRWnwXPF0wsg9ZrtGA/1cLEyx
         fZp+XKhbdzd29zaehKul4T0bOf5r0YSNwQ4dYZ8yCYqNJl/icDBWMIeSLqjoBpNCzDNx
         +kO6qeuIFyOjU4fJe1Wdw6vTjc45s3p94tEJ7aGy0vUxAT4MYSDdNugGIZS/uIwyTVxh
         RTg1aUWxrlhZd0X9KSMKBT+GQzOalcoHBX0sFXwmoTvU9IsaLV90BCHPxDhyDAP9BbYv
         vj7gimvLQVQwoPvj7z0pD+4QWAsntvncniCfkp9UdoOsvefYUBmVapZOskyrxyV9FLUW
         yLKA==
X-Gm-Message-State: AC+VfDwf7CW/rgwabMDb6yPe1LYOVwWc4znN/JgGQnUGg3Afzn0mwaA2
        XSNq6vJJv7pPGNSexgPE1ap0H88TIRVhrqL0SS4=
X-Google-Smtp-Source: ACHHUZ5oxahDY3MaQoUQVhM7Tbdz41DGYhxrKbPGA+375sD6ptx3fcUhjX/tVD5i8ak/I8xYWweHuxNKoat820sgwb0=
X-Received: by 2002:a17:907:70e:b0:94f:5847:8ac with SMTP id
 xb14-20020a170907070e00b0094f584708acmr4252784ejb.51.1685499128511; Tue, 30
 May 2023 19:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230317134638.3128232-1-eajames@linux.ibm.com>
In-Reply-To: <20230317134638.3128232-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 May 2023 02:11:56 +0000
Message-ID: <CACPK8XeSemvhR2_mn_Qb2Xtt2K5=UqEufnKd1HnQxO2MfWXHSg@mail.gmail.com>
Subject: Re: [PATCH] fsi: sbefifo: Add configurable in-command timeout
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, alistair@popple.id.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 13:46, Eddie James <eajames@linux.ibm.com> wrote:
>
> A new use case for the SBEFIFO requires a long in-command timeout
> as the SBE processes each part of the command before clearing the
> upstream FIFO for the next part of the command. Add ioctl support
> to configure this timeout in a similar way to the existing read
> timeout.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I've got one minor suggestion below that I'll make when applying.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/fsi/fsi-sbefifo.c | 33 ++++++++++++++++++++++++++++++++-
>  include/uapi/linux/fsi.h  | 10 ++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9912b7a6a4b9..223486b3cfcb 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -127,6 +127,7 @@ struct sbefifo {
>         bool                    dead;
>         bool                    async_ffdc;
>         bool                    timed_out;
> +       u32                     timeout_in_cmd_ms;
>         u32                     timeout_start_rsp_ms;
>  };
>
> @@ -136,6 +137,7 @@ struct sbefifo_user {
>         void                    *cmd_page;
>         void                    *pending_cmd;
>         size_t                  pending_len;
> +       u32                     cmd_timeout_ms;
>         u32                     read_timeout_ms;
>  };
>
> @@ -508,7 +510,7 @@ static int sbefifo_send_command(struct sbefifo *sbefifo,
>                 rc = sbefifo_wait(sbefifo, true, &status, timeout);
>                 if (rc < 0)
>                         return rc;
> -               timeout = msecs_to_jiffies(SBEFIFO_TIMEOUT_IN_CMD);
> +               timeout = msecs_to_jiffies(sbefifo->timeout_in_cmd_ms);
>
>                 vacant = sbefifo_vacant(status);
>                 len = chunk = min(vacant, remaining);
> @@ -802,6 +804,7 @@ static int sbefifo_user_open(struct inode *inode, struct file *file)
>                 return -ENOMEM;
>         }
>         mutex_init(&user->file_lock);
> +       user->cmd_timeout_ms = SBEFIFO_TIMEOUT_IN_CMD;
>         user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
>
>         return 0;
> @@ -845,9 +848,11 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
>         rc = mutex_lock_interruptible(&sbefifo->lock);
>         if (rc)
>                 goto bail;
> +       sbefifo->timeout_in_cmd_ms = user->cmd_timeout_ms;
>         sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
>         rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
>         sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
> +       sbefifo->timeout_in_cmd_ms = SBEFIFO_TIMEOUT_IN_CMD;
>         mutex_unlock(&sbefifo->lock);
>         if (rc < 0)
>                 goto bail;
> @@ -937,6 +942,28 @@ static int sbefifo_user_release(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int sbefifo_cmd_timeout(struct sbefifo_user *user, void __user *argp)
> +{
> +       struct device *dev = &user->sbefifo->dev;
> +       u32 timeout;
> +
> +       if (get_user(timeout, (__u32 __user *)argp))
> +               return -EFAULT;
> +
> +       if (timeout == 0) {
> +               user->cmd_timeout_ms = SBEFIFO_TIMEOUT_IN_CMD;
> +               dev_dbg(dev, "Command timeout reset to %u\n", user->cmd_timeout_ms);

%u ms ? Or divide it by 1000 to print it in seconds?

> +               return 0;
> +       }
> +
> +       if (timeout > 120)
> +               return -EINVAL;
> +
> +       user->cmd_timeout_ms = timeout * 1000; /* user timeout is in sec */
> +       dev_dbg(dev, "Command timeout set to %u\n", user->cmd_timeout_ms);

Same here.

> +       return 0;
> +}
> +
>  static int sbefifo_read_timeout(struct sbefifo_user *user, void __user *argp)
>  {
>         struct device *dev = &user->sbefifo->dev;
> @@ -971,6 +998,9 @@ static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned lon
>
>         mutex_lock(&user->file_lock);
>         switch (cmd) {
> +       case FSI_SBEFIFO_CMD_TIMEOUT_SECONDS:
> +               rc = sbefifo_cmd_timeout(user, (void __user *)arg);
> +               break;
>         case FSI_SBEFIFO_READ_TIMEOUT_SECONDS:
>                 rc = sbefifo_read_timeout(user, (void __user *)arg);
>                 break;
> @@ -1025,6 +1055,7 @@ static int sbefifo_probe(struct device *dev)
>         sbefifo->fsi_dev = fsi_dev;
>         dev_set_drvdata(dev, sbefifo);
>         mutex_init(&sbefifo->lock);
> +       sbefifo->timeout_in_cmd_ms = SBEFIFO_TIMEOUT_IN_CMD;
>         sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
>
>         /*
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> index b2f1977378c7..a2e730fc6309 100644
> --- a/include/uapi/linux/fsi.h
> +++ b/include/uapi/linux/fsi.h
> @@ -59,6 +59,16 @@ struct scom_access {
>   * /dev/sbefifo* ioctl interface
>   */
>
> +/**
> + * FSI_SBEFIFO_CMD_TIMEOUT sets the timeout for writing data to the SBEFIFO.
> + *
> + * The command timeout is specified in seconds.  The minimum value of command
> + * timeout is 1 seconds (default) and the maximum value of command timeout is
> + * 120 seconds.  A command timeout of 0 will reset the value to the default of
> + * 1 seconds.
> + */
> +#define FSI_SBEFIFO_CMD_TIMEOUT_SECONDS                _IOW('s', 0x01, __u32)
> +
>  /**
>   * FSI_SBEFIFO_READ_TIMEOUT sets the read timeout for response from SBE.
>   *
> --
> 2.31.1
>
