Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4706DF923
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDLO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDLO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:56:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B76A6D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:56:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a52eca0bedso7314005ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681311363; x=1683903363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj+HK1PXhiZUmw4ub4zWzXu/Z00UR5grQJU2WWuB2yk=;
        b=U4cBIb+r+3TFzkH8HK8PyheNq8FAx17FSHTN3EZbt1Ed0VXFPS+hlTadzYaqO8IPXl
         Qj9bAn1lsvVyhB/Hov4juKCKNnmRR1NiM12pPgfLvldEwHKBiVzK6loXT/T2jjKp84PM
         1JyO5DwGErdNljBWhQdo2pcjTIks1FU9VTN2RSkBR4u4E02WtRGZIzJxup2nwVv+gdrO
         d7CLYC55NHMgeTOl5E1ANBK9Sr2ORM1EN1bNFOtTxZQeclmn4+LR0hL1Yby4L/jLiTMK
         q6HJHWXb7s72qZMyJDPBjwWx/KpzM2kr1B6uWk2FuUWyY8zQRYQMY6GZRLkAeqXSBHdD
         CZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311363; x=1683903363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj+HK1PXhiZUmw4ub4zWzXu/Z00UR5grQJU2WWuB2yk=;
        b=ydQ3EG9NA1ZHZULDYagdpsIiqGbEVLEy1hfj+zLnLfqEQUJFsiEqAlyI6VFBlGTq/8
         II/uVb2inmu4mL8MKhPx9q9HrVb2LXFBjCNUIaCTDZfgyUwZYhXe/zebQRV+SJrKF1LM
         DfuYKgtk9geyNLo8xXtZgSeR3lfnr8hXaBRcZzQXVUC1RUTTBRvVm4hEYsSU1OebESGf
         LPieCDSCEvNZCiNhcTl5mCrn7N3UoYt5MC/pefPrUn81M/Q8JA/Xx/V7hCt1xVG1mAAT
         37+vei7Z1yo5ki3q+G5XS7+515b9hSGwmeqdKYdfHMfvdt2fi7u85d7XUfusiEhJ4wK0
         0KLw==
X-Gm-Message-State: AAQBX9cTIuh9BqQXD9RCjadFFB8q3gmKEaDul9oTq9fFZHj34ZZSGQ/w
        MqHJ/gxAXheTnFOP8I86RKDVL3kXc0FMm6PlHNFDMI5+vCGyd5mc3vw=
X-Google-Smtp-Source: AKy350brRxPeOL2bMvV0NLXcDEF/MSHx/y7bf8qaMSYqPXXdJDfKKTNG/2FX8FgrenBEmPFcgmUAp50DCkFxTScbnG8=
X-Received: by 2002:a05:6a00:15c1:b0:62d:dade:825 with SMTP id
 o1-20020a056a0015c100b0062ddade0825mr1214342pfu.3.1681311363377; Wed, 12 Apr
 2023 07:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230404155121.1824126-1-james.clark@arm.com> <20230404155121.1824126-9-james.clark@arm.com>
In-Reply-To: <20230404155121.1824126-9-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 12 Apr 2023 15:55:52 +0100
Message-ID: <CAJ9a7Vjr73_CcfXULOHPwAQV2sCkeg0Vq4vSBKBiMhEuWE-VRQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] coresight: Simplify connection fixup mechanism
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 at 16:52, James Clark <james.clark@arm.com> wrote:
>
> There is some duplication between coresight_fixup_device_conns() and
> coresight_fixup_orphan_conns(). They both do the same thing except for
> the fact that coresight_fixup_orphan_conns() can't handle iterating over
> itself.
>
> By making it able to handle fixing up it's own connections the other
> function can be removed.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 84 ++++++++------------
>  1 file changed, 32 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0b738960973b..8d377a59e0be 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1316,42 +1316,46 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  {
>         int i, ret = 0;
>         bool still_orphan = false;
> -       struct coresight_device *csdev, *i_csdev;
> +       struct coresight_device *dst_csdev = data;
> +       struct coresight_device *src_csdev = to_coresight_device(dev);
>         struct coresight_connection *conn;
> -
> -       csdev = data;
> -       i_csdev = to_coresight_device(dev);
> -
> -       /* No need to check oneself */
> -       if (csdev == i_csdev)
> -               return 0;
> +       bool fixup_self = (src_csdev == dst_csdev);
>
>         /* Move on to another component if no connection is orphan */
> -       if (!i_csdev->orphan)
> +       if (!src_csdev->orphan)
>                 return 0;
>         /*
> -        * Circle throuch all the connection of that component.  If we find
> -        * an orphan connection whose name matches @csdev, link it.
> +        * Circle through all the connections of that component.  If we find
> +        * an orphan connection whose name matches @dst_csdev, link it.
>          */
> -       for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
> -               conn = i_csdev->pdata->out_conns[i];
> -
> -               /* We have found at least one orphan connection */
> -               if (conn->dest_dev == NULL) {
> -                       /* Does it match this newly added device? */
> -                       if (conn->dest_fwnode == csdev->dev.fwnode) {
> -                               ret = coresight_make_links(i_csdev,
> -                                                          conn, csdev);
> -                               if (ret)
> -                                       return ret;
> -                       } else {
> -                               /* This component still has an orphan */
> -                               still_orphan = true;
> -                       }
> +       for (i = 0; i < src_csdev->pdata->nr_outconns; i++) {
> +               conn = src_csdev->pdata->out_conns[i];
> +
> +               /* Skip the port if it's already connected. */
> +               if (conn->dest_dev)
> +                       continue;
> +
> +               /*
> +                * If we are at the "new" device, which triggered this search,
> +                * we must find the remote device from the fwnode in the
> +                * connection.
> +                */
> +               if (fixup_self)
> +                       dst_csdev = coresight_find_csdev_by_fwnode(
> +                               conn->dest_fwnode);
> +
> +               /* Does it match this newly added device? */
> +               if (dst_csdev && conn->dest_fwnode == dst_csdev->dev.fwnode) {
> +                       ret = coresight_make_links(src_csdev, conn, dst_csdev);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       /* This component still has an orphan */
> +                       still_orphan = true;
>                 }
>         }
>
> -       i_csdev->orphan = still_orphan;
> +       src_csdev->orphan = still_orphan;
>
>         /*
>          * Returning '0' in case we didn't encounter any error,
> @@ -1366,28 +1370,6 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>                          csdev, coresight_orphan_match);
>  }
>
> -
> -static int coresight_fixup_device_conns(struct coresight_device *csdev)
> -{
> -       int i, ret = 0;
> -
> -       for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -               struct coresight_connection *conn = csdev->pdata->out_conns[i];
> -
> -               conn->dest_dev =
> -                       coresight_find_csdev_by_fwnode(conn->dest_fwnode);
> -               if (conn->dest_dev && conn->dest_dev->has_conns_grp) {
> -                       ret = coresight_make_links(csdev, conn, conn->dest_dev);
> -                       if (ret)
> -                               break;
> -               } else {
> -                       csdev->orphan = true;
> -               }
> -       }
> -
> -       return ret;
> -}
> -
>  static int coresight_remove_match(struct device *dev, void *data)
>  {
>         int i;
> @@ -1595,7 +1577,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         csdev->subtype = desc->subtype;
>         csdev->ops = desc->ops;
>         csdev->access = desc->access;
> -       csdev->orphan = false;
> +       csdev->orphan = true;
>
>         csdev->dev.type = &coresight_dev_type[desc->type];
>         csdev->dev.groups = desc->groups;
> @@ -1645,8 +1627,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         registered = true;
>
>         ret = coresight_create_conns_sysfs_group(csdev);
> -       if (!ret)
> -               ret = coresight_fixup_device_conns(csdev);
>         if (!ret)
>                 ret = coresight_fixup_orphan_conns(csdev);
>
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
