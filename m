Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965235F0766
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiI3JR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3JRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:17:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA315267A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:17:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z4so5959279lft.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NnBHj6Jm00QlEIkg5QEyKWHMco5NoRPNiraJmXmG3Es=;
        b=TjTqxzGB2EnTTEAlMksMyGaiQNtxUAcR5qjsVE8zTX5Fu26NSD9Go8md7jOUbvKz1k
         wSajMMP0gtgsVhOPY0hrOk8xeFQjn9SQ/vAEAJ0fPlD/jPOudPTYNWxLhxH/0bgS6laS
         ZAXw3pzgkAkZCBgipHw/KvH1MRzL3dHPJ+PSrmJHbKxVBTXMT0o9+ix5xFfijipFQJbP
         HJQzQ6iIly2k+LThIqpSYoWdFX2VRUG7rl3VBiabhLh7k1/19auw80OD/xpbkIEqkESK
         Aq6mHr7AhtiUK7x5sKTN5gjpTFfHdxOksTips72l/EZU6P6cdnRxsPlDE/y96SiPVEET
         2rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NnBHj6Jm00QlEIkg5QEyKWHMco5NoRPNiraJmXmG3Es=;
        b=CimDdNvS5PrtyUGcm59RTefhE7TML2X1CnofWYu/O9fd2bcvnNPTuBwpxK4hCnqwND
         52SzodUdwF0i99Hwd9QWc4P23vIeXSbuyjQn1UOpAE6DWKvmadAhOSgDjvDksAeC1YFt
         rErQE1jBtMBgvhrcmHTPf5IBbSO50d4JTkPuAimbI48K1+6mJ/uSPhxuVA3qa6nawHtf
         1P8kh26zBMim/jPZYcFBgCdoR1y5+DXAOYDXa+QunoNRjz9TzyO6pBsHX6lbT4JLrAPR
         Z54zFZuD6nztPNaQ/4lHcc49VwX0hJycBG/iaXd/AmoKfv7LwgBeXzlXucpVci+Julpr
         wvag==
X-Gm-Message-State: ACrzQf08+lmWxlk9gwBCCduZutM8jd2azGX2Q+QRwVM2YJckv6AKQXYU
        n8WZ6jQNCp4nbrrvnVO45KrLawPnsDvzH0gO817zRQ==
X-Google-Smtp-Source: AMsMyM7IGmH6Am3BnEp6IOCbdye4HSl8XbvSKRe+WUKghTJ/ITUSMaGGzIBOsNabEe0jVbGNWGTU7bUwyF/uhRvqMd8=
X-Received: by 2002:a05:6512:39c5:b0:4a2:e51:4e5c with SMTP id
 k5-20020a05651239c500b004a20e514e5cmr1729987lfu.657.1664529439503; Fri, 30
 Sep 2022 02:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com> <1664528184-162714-5-git-send-email-john.garry@huawei.com>
In-Reply-To: <1664528184-162714-5-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 30 Sep 2022 11:17:08 +0200
Message-ID: <CAMGffEkgR6VmfMV1eLVeTn+b8b0GC_B9=vj3HxF6cn5Er6+CTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@ionos.com, damien.lemoal@wdc.com, hare@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:03 AM John Garry <john.garry@huawei.com> wrote:
>
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a CCB.
>
> Unfortunately we don't support reserved commands in the SCSI midlayer yet,
> so in the interim continue to manage those tags internally (along with
> tags for private commands).
>
> Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
nice, I would expect this can improve performance, do you have numbers?
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 12 ++++--------
>  drivers/scsi/pm8001/pm8001_sas.c  | 16 ++++++++++++----
>  drivers/scsi/pm8001/pm8001_sas.h  | 11 ++++++++---
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 17 +++--------------
>  4 files changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 0edc9857a8bd..abb884ddcaf9 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -196,7 +196,7 @@ static void pm8001_free(struct pm8001_hba_info *pm8001_ha)
>         }
>         PM8001_CHIP_DISP->chip_iounmap(pm8001_ha);
>         flush_workqueue(pm8001_wq);
> -       bitmap_free(pm8001_ha->tags);
> +       bitmap_free(pm8001_ha->rsvd_tags);
>         kfree(pm8001_ha);
>  }
>
> @@ -1208,18 +1208,15 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>         struct Scsi_Host *shost = pm8001_ha->shost;
>         struct device *dev = pm8001_ha->dev;
>         u32 max_out_io, ccb_count;
> -       u32 can_queue;
>         int i;
>
>         max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
>         ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
>
> -       /* Update to the scsi host*/
> -       can_queue = ccb_count - PM8001_RESERVE_SLOT;
> -       shost->can_queue = can_queue;
> +       shost->can_queue = ccb_count - PM8001_RESERVE_SLOT;
>
> -       pm8001_ha->tags = bitmap_zalloc(ccb_count, GFP_KERNEL);
> -       if (!pm8001_ha->tags)
> +       pm8001_ha->rsvd_tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
> +       if (!pm8001_ha->rsvd_tags)
>                 goto err_out;
>
>         /* Memory region for ccb_info*/
> @@ -1244,7 +1241,6 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
>                 pm8001_ha->ccb_info[i].task = NULL;
>                 pm8001_ha->ccb_info[i].ccb_tag = PM8001_INVALID_TAG;
>                 pm8001_ha->ccb_info[i].device = NULL;
> -               ++pm8001_ha->tags_num;
>         }
>
>         return 0;
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 066dfa9f4683..d60bc311a4e9 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -65,9 +65,14 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>    */
>  void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>  {
> -       void *bitmap = pm8001_ha->tags;
> +       void *bitmap = pm8001_ha->rsvd_tags;
>         unsigned long flags;
>
> +       if (tag < pm8001_ha->shost->can_queue)
> +               return;
> +
> +       tag -= pm8001_ha->shost->can_queue;
> +
>         spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>         __clear_bit(tag, bitmap);
>         spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> @@ -80,18 +85,21 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>    */
>  int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
>  {
> -       void *bitmap = pm8001_ha->tags;
> +       void *bitmap = pm8001_ha->rsvd_tags;
>         unsigned long flags;
>         unsigned int tag;
>
>         spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
> -       tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
> -       if (tag >= pm8001_ha->tags_num) {
> +       tag = find_first_zero_bit(bitmap, PM8001_RESERVE_SLOT);
> +       if (tag >= PM8001_RESERVE_SLOT) {
>                 spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>                 return -SAS_QUEUE_FULL;
>         }
>         __set_bit(tag, bitmap);
>         spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
> +
> +       /* reserved tags are in the upper region of the tagset */
> +       tag += pm8001_ha->shost->can_queue;
>         *tag_out = tag;
>         return 0;
>  }
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 9acaadf02150..ba32b009f412 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -510,8 +510,7 @@ struct pm8001_hba_info {
>         u32                     chip_id;
>         const struct pm8001_chip_info   *chip;
>         struct completion       *nvmd_completion;
> -       int                     tags_num;
> -       unsigned long           *tags;
> +       unsigned long           *rsvd_tags;
>         struct pm8001_phy       phy[PM8001_MAX_PHYS];
>         struct pm8001_port      port[PM8001_MAX_PHYS];
>         u32                     id;
> @@ -737,9 +736,15 @@ pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
>                  struct pm8001_device *dev, struct sas_task *task)
>  {
>         struct pm8001_ccb_info *ccb;
> +       struct request *rq = NULL;
>         u32 tag;
>
> -       if (pm8001_tag_alloc(pm8001_ha, &tag)) {
> +       if (task)
> +               rq = sas_task_find_rq(task);
> +
> +       if (rq) {
> +               tag = rq->tag;
> +       } else if (pm8001_tag_alloc(pm8001_ha, &tag)) {
>                 pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
>                 return NULL;
>         }
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 4484c498bcb6..ed2d65d3749a 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4247,24 +4247,13 @@ static int check_enc_sat_cmd(struct sas_task *task)
>
>  static u32 pm80xx_chip_get_q_index(struct sas_task *task)
>  {
> -       struct scsi_cmnd *scmd = NULL;
> +       struct request *rq = sas_task_find_rq(task);
>         u32 blk_tag;
>
> -       if (task->uldd_task) {
> -               struct ata_queued_cmd *qc;
> -
> -               if (dev_is_sata(task->dev)) {
> -                       qc = task->uldd_task;
> -                       scmd = qc->scsicmd;
> -               } else {
> -                       scmd = task->uldd_task;
> -               }
> -       }
> -
> -       if (!scmd)
> +       if (!rq)
>                 return 0;
>
> -       blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> +       blk_tag = blk_mq_unique_tag(rq);
>         return blk_mq_unique_tag_to_hwq(blk_tag);
>  }
>
> --
> 2.35.3
>
