Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEA688DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjBCDbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBCDbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:31:35 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0803BD8E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:31:34 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bx13so3151886oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 19:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NgQSLokvwU3xl/z3+4tOZd74mTxtVDbtBbouLR5jhw=;
        b=cFyMM3SiwbziMvxNgcWq5RGBzk52Bd+fgfN6Kj9qn0CMK/vdEu+rCeFjv4WnoUlLvs
         cIRZkGqsWDzMZcaxgCFZ+D6mrTi0xGUR4ubJ9vG+UWf3Z3dViXTddFDujr/R/qDexpJV
         DtpGHBQSk5oltkJEN0IVZWZsvy0rDrJniLsj2KgZKdxA48Gdl1XN65dqBuyjp7kHwoi6
         MaolpCLmEclyNCOKsXzZ5oqQkx8PwJXThllO8evxJsZh8EfPgs9TBTNcus/veUQtkL2v
         CbQdnrXyH1KIImnR2+K7etsTeNGkJXehuv+eQK80rr/nmRxIFuBbjccpHZx27XyMtBfb
         1DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgQSLokvwU3xl/z3+4tOZd74mTxtVDbtBbouLR5jhw=;
        b=Uff95kBskpZrYgk/A1vYirgl0VHdH5yy3JOHdDPFLfx32e2RjFGrxvc2Z4rHnR9aWr
         B3l3Ej4bFE3uoVB5oCEv66ehCfCTmaPS9J9RF/btJe+qj25cHVxEpFnBBkcYxaa7g47j
         bVUcAvsTSVMsfEDZ60X08v3+TKGwkriqeBDJPYUuvtYg9cimASO+37DE2FcyygiHM5CX
         XGc8QNgjHNPmdwpq8Rn3U9JvP4N5t9RXSj4Wtvvf7AZpaSPtYboIZOscFA+Klk3pHvT7
         bKxGFiAmcmyslfvx7ae0AjPntAd6rUM8AwO/o4YOKvrqLIBDr0tMONp289Hm/0x/bAl3
         a/BA==
X-Gm-Message-State: AO0yUKVWVNivkYCScw51NkALkL08GCLsiK1vNd/liWa2uDsrJQbr7O9w
        0uHEafI/61B93Zzzfygi4XnFgh0lOM1Dz0olxhs=
X-Received: by 2002:a05:6808:1b23:b0:378:4bd3:b100 with SMTP id
 bx35-20020a0568081b2300b003784bd3b100mt571110oib.199.1675395093917; Thu, 02
 Feb 2023 19:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20221227001001.51626-1-zh.nvgt@gmail.com>
In-Reply-To: <20221227001001.51626-1-zh.nvgt@gmail.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Thu, 2 Feb 2023 22:31:22 -0500
Message-ID: <CAO2zrtbhnry5k+daY0DS0vfNqQM5ajz4hLAmne_dJRa6m4W8xA@mail.gmail.com>
Subject: Re: [PATCH] scsi: dpt_i2o: fix a potential use-after-free in __adpt_reset()
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 7:10 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
>
> __adpt_reset() invokes adpt_hba_reset(), which can free "pHba"
> on error paths and return an negative error code in those
> situations. The problem is that "pHba" is from the global pointer
> "cmd->device->host->hostdata[0]", regardless of the possible free
> of "pHba", that original global pointer is never nullified and
> thus may become a dangling pointer and be dereferenced later,
> potentially causing a use-after-free.
>
> Fix the issue by nullifying "cmd->device->host->hostdata[0]" if
> adpt_hba_reset() returns a negative error code to __adpt_reset(),
> which indicates the free of "pHba". Also add a NULL check before
> any dereference of "pHba", or the aliased global pointer. Note
> that the similar NULL check already exists at other places, like
> in adpt_queue_lck().
>
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>  drivers/scsi/dpt_i2o.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> index 2e9155ba7408..9827517a1898 100644
> --- a/drivers/scsi/dpt_i2o.c
> +++ b/drivers/scsi/dpt_i2o.c
> @@ -753,6 +753,9 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>         char name[32];
>
>         pHba = (adpt_hba*)cmd->device->host->hostdata[0];
> +       if (!pHba) {
> +               return FAILED;
> +       }
>         strncpy(name, pHba->name, sizeof(name));
>         printk(KERN_WARNING"%s: Hba Reset: scsi id %d: tid: %d\n", name, cmd->device->channel, pHba->channel[cmd->device->channel].tid);
>         rcode =  adpt_hba_reset(pHba);
> @@ -760,6 +763,7 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>                 printk(KERN_WARNING"%s: HBA reset complete\n", name);
>                 return SUCCESS;
>         } else {
> +               cmd->device->host->hostdata[0] = NULL;
>                 printk(KERN_WARNING"%s: HBA reset failed (%x)\n", name, rcode);
>                 return FAILED;
>         }
> --
> 2.39.0
>

Hi James and Martin, could we get some feedback from you
regarding this patch? We want to clarify that this issue was
originally detected by our static analyzer, so we do not have
PoC or dynamic execution traces. However we do have a careful
manual code review to confirm the issue, and we think that
it seems apparent that the global pointer should be cleared after
its points-to object gets freed (and checked before use), which
is not the case in the current __adpt_reset() function. Please
feel free to let us know if we missed anything here, thank you
very much!

Best,
Hang
