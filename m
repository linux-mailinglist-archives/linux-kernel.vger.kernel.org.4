Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D63E6B19CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCIDKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCIDKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:10:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99F8093D;
        Wed,  8 Mar 2023 19:10:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi9so594212lfb.2;
        Wed, 08 Mar 2023 19:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678331428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZT0VdYfK85i7JqaF0sU+l1RnZ8kiQAjGhATCe5ADqc=;
        b=CHHP2Dg4BzqFPcWOJV9lYrMn63gamrZxZZLFr7TXXPL3rAWCRoceYt3/tq8F7Ptluv
         04qPrirU6WtuuqeUVRPyCUTsfgINz9Uu2bZ0X/Zm4olcaaVAiPiOcvO7x4eJxdaDxxuJ
         HLGvdEYv2gWoj8YXNrPtAoDViBTP42nXW6x+bcgw3+V1rvjMCLolH+qY19gpOyil5j6q
         MchgKMvDsIFEW7ofbBVVN64ub5uzbQsuXZ75KXRuUvuoyl6wyen9itBKUnDBFqg47h6l
         IqsNZzLNpR5s7iVrekgL1yA2yUigq4+0bHtqciPemqf0M4uU6Uck04kfx3xls7QFH3uw
         /3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678331428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZT0VdYfK85i7JqaF0sU+l1RnZ8kiQAjGhATCe5ADqc=;
        b=mGljUWLP3IL3ALqLYes/kXrxNmIZgGv+Oj6kYpyUMTXEj39B+WtcM79FSZbpqM1ePz
         Dzbw/3W0Z9mbgcQoG5eLrWSJNf/U3ZOhrJFrmcHzPPZUZtLWT/LxEvGrbOTpVC2lmN6p
         tMx1Eepr1LrAqTM5axwdi0zjGN6GgJSZdRcM8Z3D4dVOHVzgwDxKC7GVu2i2BxMnClyp
         65o2HF82LxNYwOCCTpNYmexd8kvSxJIofBJK5uq/B9WbzEJQFau5yYYfAc+09NqlgTEQ
         NjAZjnnPqDXkRKA0OocMYmpaV+IecjIN7toOgu8dLsa4hCpdipbr39X+iV+kgSr1Z1ho
         Fymg==
X-Gm-Message-State: AO0yUKWlpKpjlATdLH+z5CQRJhqP3tiRwms48jUAmAGNpJcRc/9G7W11
        hBlnk1wpnk2uqg9z4NbotiXBNlDR7arb9FdT7g==
X-Google-Smtp-Source: AK7set8ulpWzK57+vwWTfXuanyiIynSqBU0FD/z4SN1OvW8kkILOi7VeSWTmRJwQ4Xpyc5XvqA3I3/k97ows1IKmn7A=
X-Received: by 2002:ac2:530d:0:b0:4db:1809:29a1 with SMTP id
 c13-20020ac2530d000000b004db180929a1mr11230830lfh.2.1678331427410; Wed, 08
 Mar 2023 19:10:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1678247309.git.quic_nguyenb@quicinc.com> <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
In-Reply-To: <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 9 Mar 2023 11:10:15 +0800
Message-ID: <CAGaU9a_CkxHU-k519TL2hfLZSM6Hfoo6sAELmJ+6Vy2X2ZCOrw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao,

On Wed, Mar 8, 2023 at 12:10=E2=80=AFPM Bao D. Nguyen <quic_nguyenb@quicinc=
.com> wrote:
>
> Add ufshcd_mcq_abort() to support ufs abort in mcq mode.
>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 76 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/ufs/core/ufshcd-priv.h |  5 ++-
>  drivers/ufs/core/ufshcd.c      | 11 ++++--
>  3 files changed, 88 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index e27d8eb..6c65cd5 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -646,3 +646,79 @@ static bool ufshcd_mcq_cqe_search(struct ufs_hba *hb=
a,
>         spin_unlock(&hwq->cq_lock);
>         return ret;
>  }
> +
> +/**
> + * ufshcd_mcq_abort - Abort the command in MCQ.
> + * @cmd - The command to be aborted.
> + *
> + * Returns SUCCESS or FAILED error codes
> + */
> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
> +{
> +       struct Scsi_Host *host =3D cmd->device->host;
> +       struct ufs_hba *hba =3D shost_priv(host);
> +       int tag =3D scsi_cmd_to_rq(cmd)->tag;
> +       struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
> +       struct ufs_hw_queue *hwq;
> +       int err =3D FAILED;
> +
> +       if (!lrbp->cmd) {
> +               dev_err(hba->dev,
> +                       "%s: skip abort. cmd at tag %d already completed.=
\n",
> +                       __func__, tag);
> +               goto out;
> +       }
> +
> +       /* Skip task abort in case previous aborts failed and report fail=
ure */
> +       if (lrbp->req_abort_skip) {
> +               dev_err(hba->dev, "%s: skip abort. tag %d failed earlier\=
n",
> +                       __func__, tag);
> +               goto out;
> +       }
> +
> +       hwq =3D ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
> +
> +       if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
> +               /*
> +                * Failure. The command should not be "stuck" in SQ for
> +                * a long time which resulted in command being aborted.
> +                */
> +               dev_err(hba->dev, "%s: cmd found in sq. hwq=3D%d, tag=3D%=
d\n",
> +                               __func__, hwq->id, tag);
> +               /* Set the Command Type to 0xF per the spec */
> +               ufshcd_mcq_nullify_cmd(hba, hwq);
> +               goto out;
> +       }
> +
> +       if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
> +               dev_err(hba->dev, "%s: cmd found in cq. hwq=3D%d, tag=3D%=
d\n",
> +                               __func__, hwq->id, tag);
> +               /*
> +                * The command should not be 'stuck' in the CQ for such a=
 long time.
> +                * Is interrupt missing? Process the CQEs here. If the in=
terrupt is
> +                * invoked at a later time, the CQ will be empty because =
the CQEs
> +                * are already processed here.
> +                */
> +               ufshcd_mcq_poll_cqe_lock(hba, hwq);
> +               err =3D SUCCESS;
> +               goto out;
> +       }
> +
> +       /*
> +        * The command is not in the Submission Queue, and it is not
> +        * in the Completion Queue either. Query the device to see if
> +        * the command is being processed in the device.
> +        */
> +       if (ufshcd_try_to_abort_task(hba, tag)) {
> +               dev_err(hba->dev, "%s: device abort failed %d\n", __func_=
_, err);
> +               lrbp->req_abort_skip =3D true;
> +               goto out;
> +       }
> +
> +       err =3D SUCCESS;
> +       if (lrbp->cmd)
> +               ufshcd_release_scsi_cmd(hba, lrbp);
> +
> +out:
> +       return err;
> +}
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-pri=
v.h
> index 0527926..d883c03 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -77,7 +77,10 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba =
*hba,
>                                        struct ufs_hw_queue *hwq);
>
>  int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result=
);
> -
> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> +                               struct ufshcd_lrb *lrbp);
>  #define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 408c16c..e06399e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -302,7 +302,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba,=
 bool on);
>  static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
>  static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>                                          struct ufs_vreg *vreg);
> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
>  static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
>                                                  bool enable);
>  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
> @@ -5414,7 +5413,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_=
hba *hba, u32 intr_status)
>  }
>
>  /* Release the resources allocated for processing a SCSI command. */
> -static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
>                                     struct ufshcd_lrb *lrbp)
>  {
>         struct scsi_cmnd *cmd =3D lrbp->cmd;
> @@ -7340,7 +7339,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hb=
a *hba, unsigned long bitmap)
>   *
>   * Returns zero on success, non-zero on failure
>   */
> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>  {
>         struct ufshcd_lrb *lrbp =3D &hba->lrb[tag];
>         int err =3D 0;
> @@ -7500,6 +7499,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>                 goto release;
>         }
>
> +       if (is_mcq_enabled(hba)) {
> +               /* MCQ mode. Branch off to handle abort for mcq mode */
> +               err =3D ufshcd_mcq_abort(cmd);
> +               goto release;
> +       }
> +
>         /* Skip task abort in case previous aborts failed and report fail=
ure */
>         if (lrbp->req_abort_skip) {
>                 dev_err(hba->dev, "%s: skipping abort\n", __func__);
> --
> 2.7.4
>

It seems that ufshcd_abort_all() also needs an error handling flow for MCQ.

Thanks,
Stanley
