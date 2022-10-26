Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58060DEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiJZKgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiJZKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:36:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745BA3470
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:36:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id be13so27663559lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Wz1A4CW5P5+RVQ39/cNozpWA6Bx+Md7zjb4gIkf3c=;
        b=g8zEnq/beTWN8RH2dXBmBuLwvlw2SmWEhU3NftmPP+qUNz9DXCf6yGvqeo8+t1ws59
         /JN55dHJqv4E+MueD1DVKO7hbvKudFvJz1Xi4DBpXYiYk5gdvEXsNPxBjzrEMlX+fNgB
         XnpCDxGgMHs/PBBGk2HQE5zO1niWkY6NHT3PwSHjJD+t0xpgLABG61YwFn0gbKEhM07S
         SSfVNx74D+Mc2sjJFwUVCopyAq2YEGjwE6Ybk8Qw2fukrqYhqacRu8oc8s4kweFBSJ9a
         RnMocn1g0OH6cY73RIqV7+603ABG1xU0c39i7oZGBh910Opg7Ie1t9tr9rvHcFwlDaNp
         Pobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6Wz1A4CW5P5+RVQ39/cNozpWA6Bx+Md7zjb4gIkf3c=;
        b=hJ4zPmGAGg/hO1WA2fLuhgDIE+dnXRgeDRBBV6blQwmCWvyv9gw1DnhZvN83fRjj1g
         pgQzfAFwdpsaUumJe1nVF7BhcTLO1qG1M265fIqZHqlJ3qFRkq5VNuyAvYS5aHwgg6n+
         wirwkK8WVpe9tn4TcrtXYBsWCWIUiGjSkUxu1eo+om95Hn53JYFfbA4x8T795LsKTmSS
         Mof6B3xOVFQMvC/A3ZAfWnv5yliSfFHyw6NIKjc/h/cM0BTTKi35yIjQ0oJEyqt7X3l7
         k2aAA+WzK81gOX/tC8BNQmdgrv+mpxeeuHYMcAqtIlqj2FeXPjqKuNE19qOP4WbrKqgd
         opjg==
X-Gm-Message-State: ACrzQf1nSRF5nVNyqrzgrVuYb1y7j5FJ+ResSjBPwBhyRfzpwSd6osbS
        ptckJZQY40HuEE2SM9MvuhIvBc4IQsYY3JRTQUJCT2AKLLo=
X-Google-Smtp-Source: AMsMyM6Xt+v7OH5mRPGsrIQWb2eDOsO+EHaqXYf/ZqgeRZzS0Rw5xY/XyjgtPZsbmOEf198RtGMqdjJlCchuCQ3Q/54=
X-Received: by 2002:a05:6512:298d:b0:4a3:371d:6cc3 with SMTP id
 du13-20020a056512298d00b004a3371d6cc3mr14788177lfb.422.1666780574194; Wed, 26
 Oct 2022 03:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 26 Oct 2022 12:36:03 +0200
Message-ID: <CAMGffE=4YHc0ErLpLxmLQbM-AoCaMQ+1TGxG_nxoJxx-W4U01g@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Drop !task check in pm8001_abort_task()
To:     John Garry <john.garry@huawei.com>
Cc:     jinpu.wang@ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:25 PM John Garry <john.garry@huawei.com> wrote:
>
> In commit 0b639decf651 ("scsi: pm8001: Modify task abort handling for SATA
> task"), code was introduced to dereference "task" pointer in
> pm8001_abort_task(). However there was a pre-existing later check for
> "!task", which spooked the kernel test robot.
>
> Function pm8001_abort_task() should never be passed NULL for "task"
> pointer, so remove that check. Also remove the "unlikely" hint, as this is
> not fastpath code.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 2359e827c9e6..e5673c774f66 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -979,7 +979,7 @@ int pm8001_abort_task(struct sas_task *task)
>         u32 phy_id, port_id;
>         struct sas_task_slow slow_task;
>
> -       if (unlikely(!task || !task->lldd_task || !task->dev))
> +       if (!task->lldd_task || !task->dev)
>                 return TMF_RESP_FUNC_FAILED;
>
>         dev = task->dev;
> --
> 2.25.1
>
