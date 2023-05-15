Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95534702EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjEON4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjEON4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:56:50 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E151BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:56:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a8019379fso117639017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684159008; x=1686751008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teWz0EnerAwE3r7aSKxt/gky1I2iKks1EDmjro+jGDo=;
        b=NkB14x8Y6ABswTKEqTjeFZU9VLAc1XaDLKcVg9FAEb1ACCsOk0QaB2hgGSZtameO7j
         vWOycHHky8zFB7lWSD4pHRZvFYTVdJJI0qlB8WIQRs2taiF4DnIAt/9R1ZPInBSorrUp
         lIIr1xkR5rPfSIXFwEcijgVNzaol2WVDORzXIF3hqY1BEi5cAT89jlTemO8Gx1V9cvvS
         h9I2V87iBixfNg5+jeNJrIqRgAfwIXRfVBE00XLHsji0mzheyCkCMv3GmBYo5E8uwWws
         97LSOuIh/ezyQEPeW/mSTeezyhqhuX2vCkBi2iWfuqhnltrwRrRldAm48qsxqkCdnTL5
         2IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159008; x=1686751008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teWz0EnerAwE3r7aSKxt/gky1I2iKks1EDmjro+jGDo=;
        b=VWzJ0jqGJ7/IJT+nGJqgBcDwykkPe466zzJPiBBxEWOc5s6ro5Y5mm3YgK6MpHSZfO
         2sFrUUY6+r84TJV+MyJl67ZM7GzAC8IT9A2yOaL+w70xaZOUc1vRtB9PBNIK7LrrlLBm
         IA5E+3RdwNT8lMTnN0e/H4RWiYxRjlxkHoPDxjB0hD4S88QrLyupiPjhAd4FrhOYA8UW
         ZXp4ukzXnRauxCNtitgMjH/blsTqwZxxkDfcP/7gd/KY+PP1paB6jxe2kxjAQfyfUQPJ
         Kk6aC1vdanvFGq6IvaufN69pvk+grW8Xxu1Jcn0bfEm+qFLvelJ01bdxuDrrdfoK+Nhf
         63Yg==
X-Gm-Message-State: AC+VfDwEy04nQshACrj98uXx3MFg47y5hojipEeLP/+Ky6NRFQEn2K0R
        ku3ztZETpU38d6CBha4Mj7109cggt/VHVBqrJ/NtRg==
X-Google-Smtp-Source: ACHHUZ7O1LiIbtQX+zmoHxglBzWhI/O6tIpDkgoQjUEf9z98dTQ77xPtNk67wJVfKqP+YDwEOEnftls4EhFpZPx5UHk=
X-Received: by 2002:a0d:d852:0:b0:55a:4f00:b053 with SMTP id
 a79-20020a0dd852000000b0055a4f00b053mr34599226ywe.12.1684159008446; Mon, 15
 May 2023 06:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com>
In-Reply-To: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 May 2023 15:56:12 +0200
Message-ID: <CAPDyKFp5zi=KEgq7P4E7y5u7owM+C2991sBs+8QVGGCN8C+89A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 13:57, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Userspace currently has no way of checking for error bits of
> detection mode X. These are error bits that are only detected by
> the card when executing the command. For e.g. a sanitize operation
> this may be minutes after the RSP was seen by the host.
>
> Currently userspace programs cannot see these error bits reliably.
> They could issue a multi ioctl cmd with a CMD13 immediately following
> it, but since errors of detection mode X are automatically cleared
> (they are all clear condition B).
> mmc_poll_for_busy of the first ioctl may have already hidden such an
> error flag.
>
> In case of the security operations: sanitize, secure erases and
> RPMB writes, this could lead to the operation not being performed
> successfully by the card with the user not knowing.
> If the user trusts that this operation is completed
> (e.g. their data is sanitized), this could be a security issue.
> An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
> successful sanitize of a card is not possible. A card may move out
> of PROG state but issue a bit 19 R1 error.
>
> This patch therefore will also have the consequence of a mmc-utils
> patch, which enables the bit for the security-sensitive operations.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c       | 34 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/mmc/ioctl.h |  2 ++
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 35ff7101cbb1..386a508bd720 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -457,7 +457,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_=
cmd __user *ic_ptr,
>                          sizeof(ic->response)))
>                 return -EFAULT;
>
> -       if (!idata->ic.write_flag) {
> +       if (!idata->ic.write_flag && idata->buf) {

If needed, this looks like it should be a separate change.

>                 if (copy_to_user((void __user *)(unsigned long)ic->data_p=
tr,
>                                  idata->buf, idata->buf_bytes))
>                         return -EFAULT;
> @@ -610,13 +610,43 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *car=
d, struct mmc_blk_data *md,
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsl=
eep_max_us);
>
>         /* No need to poll when using HW busy detection. */
> -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> +       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp =
&&
> +                       !(idata->ic.write_flag & MMC_AGGREGATE_PROG_ERROR=
S))

Do we really need a new flag for this? Can't we just collect the error
code always for writes? Or collect the errors based upon a selection
of commands?

>                 return 0;
>
>         if (mmc_host_is_spi(card->host)) {
>                 if (idata->ic.write_flag)
>                         err =3D mmc_spi_err_check(card);
>         }
> +       /*
> +        * We want to receive a meaningful R1 response for errors of dete=
ction
> +        * type X, which are only set after the card has executed the com=
mand.
> +        * In that case poll CMD13 until PROG is left and return the
> +        * accumulated error bits.
> +        * If we're lucky host controller has busy detection for R1B and
> +        * this is just a single CMD13.
> +        * We can abuse resp[1] as the post-PROG R1 here, as all commands
> +        * that go through PRG have an R1 response and therefore only
> +        * use resp[0].

Hmm, for these cases, is the resp[0] containing any interesting
information? Probably not, right?

In that case, why not override the resp[0], this should make the
behaviour more consistent from user space point of view.

> +        */
> +       else if (idata->ic.write_flag & MMC_AGGREGATE_PROG_ERRORS) {
> +               unsigned long timeout =3D jiffies +
> +                       msecs_to_jiffies(busy_timeout_ms);
> +               bool done =3D false;
> +               unsigned long delay_ms =3D 1;
> +               u32 status;
> +
> +               do {
> +                       done =3D time_after(jiffies, timeout);
> +                       msleep(delay_ms++);
> +                       err =3D __mmc_send_status(card, &status, 1);
> +                       if (err)
> +                               return err;
> +                       idata->ic.response[1] |=3D status;
> +               } while (R1_CURRENT_STATE(status) !=3D R1_STATE_TRAN && !=
done);
> +               if (done)
> +                       return -ETIMEDOUT;
> +       }

We have moved away from open-coding polling loops. Let's not introduce
a new one. In fact, it looks a bit like we could re-use the
mmc_blk_busy_cb() for this, as it seems to be collecting the error
codes too.

In any case, let's at least make use of __mmc_poll_for_busy() to avoid
the open-coding.

>         /* Ensure RPMB/R1B command has completed by polling with CMD13. *=
/
>         else if (idata->rpmb || r1b_resp)
>                 err =3D mmc_poll_for_busy(card, busy_timeout_ms, false,
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioct=
l.h
> index b2ff7f5be87b..a9d84ae8d57d 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -8,9 +8,11 @@
>  struct mmc_ioc_cmd {
>         /*
>          * Direction of data: nonzero =3D write, zero =3D read.
> +        * Bit 30 selects error aggregation post-PROG state.
>          * Bit 31 selects 'Reliable Write' for RPMB.
>          */
>         int write_flag;
> +#define MMC_AGGREGATE_PROG_ERRORS (1 << 30)
>  #define MMC_RPMB_RELIABLE_WRITE (1 << 31)
>
>         /* Application-specific command.  true =3D precede with CMD55 */

Kind regards
Uffe
