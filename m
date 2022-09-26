Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681E5E9945
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIZGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiIZGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:09:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3224AA185
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:09:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w8so9149259lft.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sQb2JmefVYNSR5MgcX37Ilj9xnV/1y4mDFuh2VtRjEc=;
        b=AvYivGI/oFyhxCAUC0JBlztAoDXQX238Ae2UmwTjy8xt16mJeLjVq4bbWv8BEFNyjG
         n5n4sbjqE4JaHlk5LYDOvhXoF6LAiioLA+koGnvdSiT1r/9FDd7cCyZIqbI4YZfetSC5
         v3nTte2CORbMLep618e3saY8Ute37/KuqIpRE5Qwb7wL5p0eBNlYCWKjqPzJpdii/xX/
         t7O7ZN6fc5gzfWgraJ53gI9rRtHT0x5IbSZhbOmPVF6I0fPuPQQeuxAEC6/VFjP3u09E
         pn8skrkLYBSgmmRVTkUszlGEnw4+sNmLcITd7xeM9UkMtckr22RM8Fpn6t1JVbRUfek9
         mANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sQb2JmefVYNSR5MgcX37Ilj9xnV/1y4mDFuh2VtRjEc=;
        b=QnQVNlZwqEQTiELtiG+MNTTo2a0axdMZ8MJXKk/wGn6nKbvRL1cMgUbDXrEMsim9FU
         I5p9NWhI6YTtbCDyXcVOQt/ZXMBlnnuLQLsceRNYE/YtbM2sfst7KbDsZ89xm8bVwN+B
         Nh+JRFPodWclW8C1jOOOvJrglv4fgS806aTGVQ3FP2ZeAiLsqhsC+DbGNoS2+uNwimeu
         Xv7bP5+8fErvqcykESUHBB9NPPb3GVpz8PIV7XbP/TV88IMSq/dxTy/HrNdXSwdmvZdn
         qSrXLQK45EHmV/28/5F5K9Bh5eb0weuMWz5PX5AcT8FOLlfY1dERG4KVw7GgE8hmwcQ7
         N9+A==
X-Gm-Message-State: ACrzQf2TdnynNyP0BacAr/q9y5tFu1aSXQpHowo6Bk1RAUj9gN9elNgs
        +kbHBnf5rDTJx/GYEHxv1VaClX7KTEdKXVcOilfKnw==
X-Google-Smtp-Source: AMsMyM4t4BDW7oRmghw3NkUnQGipKIxFAfFkBOyBMpLeIdlWwSnZ2CidDPMIBbF0xakhgTKkBY1TRrWu2ExSGtz4LjI=
X-Received: by 2002:a05:6512:1087:b0:49e:5f7b:ffad with SMTP id
 j7-20020a056512108700b0049e5f7bffadmr9089274lfg.471.1664172564462; Sun, 25
 Sep 2022 23:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220924073455.2186805-1-yanaijie@huawei.com>
In-Reply-To: <20220924073455.2186805-1-yanaijie@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 26 Sep 2022 08:09:13 +0200
Message-ID: <CAMGffE=6BGVLqTbO3SGFZhCYDjo0U=Ay+JO4h+pNi10Hcb0w9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] scsi: libsas: sas address comparation refactor
To:     Jason Yan <yanaijie@huawei.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 9:24 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Sas address conversion and comparation is widely used in libsas and
> drivers. However they are all opencoded and to avoid the line spill over
> 80 columns, are mostly split into multi-lines.
>
> To make the code easier to read, introduce some helpers with clearer
> semantics and replace the opencoded segments with them.
>
> v1->v2:
>   First factor out sas_find_attached_phy() and replace LLDDs's code
>         with it.
>   Remove three too simple helpers.
>   Rename the helpers with 'sas_' prefix.
>
Hi Jason,

Thx for doing this.
> Jason Yan (8):
>   scsi: libsas: introduce sas_find_attached_phy() helper
>   scsi: pm8001: use sas_find_attached_phy() instead of open coded
>   scsi: mvsas: use sas_find_attached_phy() instead of open coded
>   scsi: hisi_sas: use sas_find_attathed_phy() instead of open coded
These 4 look good to me.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>   scsi: libsas: introduce sas address comparation helpers
>   scsi: libsas: use sas_phy_match_dev_addr() instead of open coded
>   scsi: libsas: use sas_phy_addr_same() instead of open coded
>   scsi: libsas: use sas_phy_match_port_addr() instead of open coded
These helpers are too simple to replace, we add more loc in the end.
>
>  drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ++------
>  drivers/scsi/libsas/sas_expander.c    | 40 ++++++++++++++++-----------
>  drivers/scsi/libsas/sas_internal.h    | 17 ++++++++++++
>  drivers/scsi/mvsas/mv_sas.c           | 15 +++-------
>  drivers/scsi/pm8001/pm8001_sas.c      | 16 ++++-------
>  include/scsi/libsas.h                 |  2 ++
>  6 files changed, 54 insertions(+), 48 deletions(-)
>
> --
> 2.31.1
>
