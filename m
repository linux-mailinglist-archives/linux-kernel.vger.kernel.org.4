Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C355E649C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiIVOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIVOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:02:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA5D01DB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:02:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so14885702lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8Qr+Np5t9Y63zhneaqTSaUKT3Y92nvZPdJtmRHNWz/M=;
        b=W9B83d9H9sTyIbYxJivWPqKI+Ito69l6yl/cIkPgGex0RP6FgSDCr90Blr3EqWzERM
         fn0GNcczRCFStx5pHE0PT+zosktAI93nhADi1VQ3+MeEyq41BPECrYrjYkuDhwRf3om4
         4DPN6Z/m+e2/Mm8jsTewSiHXuV/bOI9bslEpXtvHSBGZZVU5XcIAhH1hWh3PQk+q2fQm
         lgKqbJYewnmsfcMtGkYzbn/mtE1K5Rt7esBHbrFHs4VbmArx2haZ5yNV7MHm+MymDjrb
         koM4NFjX0csjmvDg+pqwR80tJS4u6DbsIGqijMR5oWODXdh/pYErs9bx6JGC8xFO2Xum
         y0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8Qr+Np5t9Y63zhneaqTSaUKT3Y92nvZPdJtmRHNWz/M=;
        b=AyTLNQf4woGz+c0SMAhVF25uVuA0AuejmuglHSv0cBDt+Rd6OTTGeui8mAqL9Kw3Ef
         F0awEBVHOYmJziCGaFVeT9W8POVvf7sFMWlvqI+UgICw6/SnLgv1LnV50qwDENUXFGHy
         FecCqe8rw0S29Lj3id9k0eZIucPs7PLjn1RbPYklrc9ByMlW7ylOcvJww4qMgbjQuCJw
         4/f8IB33W9J9leWXNV4i91ovsnYu2/z7foEVqo2KW2KyAB97jzTymlfvVvuVA4bIPE9n
         YfZvobxxJCKJZ01HhVAYs7+PBRc+zCGthCNfkDIB83WozKTo2aAcm7OaCutWgr5wtCMk
         GwYQ==
X-Gm-Message-State: ACrzQf3t2SGMu++1hK2BPXAgGnzzqkH6uGAfZViU7YNk+gb1T7E9vn1M
        2u/Y2nb4qYi75OM6vZVYwdIUGklzjLnF+meSmPdChg==
X-Google-Smtp-Source: AMsMyM5SzPAVgqMljHaOHCRQNR3EJrv/psqbe+ClI5j8S6bfp4wf2oasFfIvAheu3s+axplbhd14cuqd1bfTORYHgUg=
X-Received: by 2002:a05:6512:2345:b0:49e:359f:5579 with SMTP id
 p5-20020a056512234500b0049e359f5579mr1439468lfu.478.1663855327161; Thu, 22
 Sep 2022 07:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <1663854664-76165-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1663854664-76165-1-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 22 Sep 2022 16:01:55 +0200
Message-ID: <CAMGffE=TnrtRMBZemnfkSf6C63=TkWZfdpeC9Cr29TK__OiM-A@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Fix running_req for internal abort commands
To:     John Garry <john.garry@huawei.com>
Cc:     jinpu.wang@ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, damien.lemoal@opensource.wdc.com
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

On Thu, Sep 22, 2022 at 3:57 PM John Garry <john.garry@huawei.com> wrote:
>
> Disabling the remote phy for a SATA disk causes a hang:
>
> root@(none)$ more /sys/class/sas_phy/phy-0:0:8/target_port_protocols
> sata
> root@(none)$ echo 0 > sys/class/sas_phy/phy-0:0:8/enable
> root@(none)$ [   67.855950] sas: ex 500e004aaaaaaa1f phy08 change count has changed
> [   67.920585] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
> [   67.925780] sd 0:0:2:0: [sdc] Synchronize Cache(10) failed: Result: hostbyte=0x04 driverbyte=DRIVER_OK
> [   67.935094] sd 0:0:2:0: [sdc] Stopping disk
> [   67.939305] sd 0:0:2:0: [sdc] Start/Stop Unit failed: Result: hostbyte=0x04 driverbyte=DRIVER_OK
> ...
> [  123.998998] INFO: task kworker/u192:1:642 blocked for more than 30 seconds.
> [  124.005960]   Not tainted 6.0.0-rc1-205202-gf26f8f761e83 #218
> [  124.012049] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  124.019872] task:kworker/u192:1  state:D stack:0 pid:  642 ppid: 2 flags:0x00000008
> [  124.028223] Workqueue: 0000:04:00.0_event_q sas_port_event_worker
> [  124.034319] Call trace:
> [  124.036758]  __switch_to+0x128/0x278
> [  124.040333]  __schedule+0x434/0xa58
> [  124.043820]  schedule+0x94/0x138
> [  124.047045]  schedule_timeout+0x2fc/0x368
> [  124.051052]  wait_for_completion+0xdc/0x200
> [  124.055234]  __flush_workqueue+0x1a8/0x708
> [  124.059328]  sas_porte_broadcast_rcvd+0xa8/0xc0
> [  124.063858]  sas_port_event_worker+0x60/0x98
> [  124.068126]  process_one_work+0x3f8/0x660
> [  124.072134]  worker_thread+0x70/0x700
> [  124.075793]  kthread+0x1a4/0x1b8
> [  124.079014]  ret_from_fork+0x10/0x20
>
> The issue is that the per-device running_req read in
> pm8001_dev_gone_notify() never goes to zero and we never make progress.
> This is caused by missing accounting for running_req for when an internal
> abort command completes.
>
> In commit 2cbbf489778e ("scsi: pm8001: Use libsas internal abort support")
> we started to send internal abort commands as a proper sas_task. In this
> when we deliver a sas_task to HW the per-device running_req is incremented
> in pm8001_queue_command(). However it is never decremented for internal
> abort commnds, so decrement in pm8001_mpi_task_abort_resp().
>
> Fixes: 2cbbf489778e ("scsi: pm8001: Use libsas internal abort support")
> Signed-off-by: John Garry <john.garry@huawei.com>
lgtm
Acked-by: Jack Wang <jinpu.wang@ionos.com>
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 91d78d0a38fe..628b08ba6770 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -3612,6 +3612,10 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 pm8001_dbg(pm8001_ha, FAIL, " TASK NULL. RETURNING !!!\n");
>                 return -1;
>         }
> +
> +       if (t->task_proto == SAS_PROTOCOL_INTERNAL_ABORT)
> +               atomic_dec(&pm8001_dev->running_req);
> +
>         ts = &t->task_status;
>         if (status != 0)
>                 pm8001_dbg(pm8001_ha, FAIL, "task abort failed status 0x%x ,tag = 0x%x, scp= 0x%x\n",
> --
> 2.35.3
>
