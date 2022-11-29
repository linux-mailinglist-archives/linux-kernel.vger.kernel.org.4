Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72A63B854
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiK2DAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiK2DAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5402F303F3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669690794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jICdvc9DXcnwskTHg4NcjxqsN06Ny3H6HZZrLEpXAiY=;
        b=d/yYDA1SiXj+lPrk3ZeeLFRhPtfta20OvzOVTlLl4mTuaCd6VvGb08lN6v/p1Drb4faOmE
        mzxIK+mRTPOeVPI57yQTx0EstqW/TALERSdFIN7/x54qhftSWM5F8m+NPFOaXgzlv69gNY
        5DHK4zB5PLy0tUiNwx/QBE1r3VoBB8o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-UaTNM98mOz-PBDxtauKvDQ-1; Mon, 28 Nov 2022 21:59:47 -0500
X-MC-Unique: UaTNM98mOz-PBDxtauKvDQ-1
Received: by mail-oi1-f200.google.com with SMTP id p133-20020acaf18b000000b0035b236c8554so4718865oih.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jICdvc9DXcnwskTHg4NcjxqsN06Ny3H6HZZrLEpXAiY=;
        b=CT7m40Hxpy4HxWbKhdw+iSWSYQkOZpFoOeDheVJ7EiwLkHG9nXGorpTzleTk7WdGFO
         Yq1RIqWkXu9/M3xfBE27icaTzqCcO72dMAOlkaEXb9aDMUMn7tfJmFVmvo7r9K7H1ZgC
         Qs5yJ15aZam94/A56XOjTxQ7QNtCgt2bzaacGrDOISRtPxO28BVt6cMeQ230yGFrP+b/
         7QwLfQMHWpcMi1fhdzR7CztA9K+wOTGrCne959n4/PY35J+aqhe5XqWoElj0U+lGwx3i
         exqrUYKOcAy9QlIrt+vhHEPevP6ygwwehVwNDm/BsGobru8QF783fBiXZzm8DQR3ffmd
         9KZw==
X-Gm-Message-State: ANoB5plm+YzF6rVp/XhZAYG7ON3PmmiwkkjCOmQ09tYu8XjICREMmiUi
        hSw/82czvDsGZZmiAM2NbtxyGncHSusPZ9OYHRiecZEJRJGerqxzq22PlomrUH0m61hNWuYNPoY
        ZFDkoMtYFkHmZ3FR5MAqfiIfxwnFCO9htsF48Xu9s
X-Received: by 2002:aca:906:0:b0:354:68aa:9c59 with SMTP id 6-20020aca0906000000b0035468aa9c59mr28156749oij.35.1669690787154;
        Mon, 28 Nov 2022 18:59:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6CVNwUgwdj4oC+9mc6XrKlb7k1ISyHQEbQFZggMlCP7aWq/QQQWHqA/iMa/W0aTsOefe6aRq2cy/DzsDKEZSA=
X-Received: by 2002:aca:906:0:b0:354:68aa:9c59 with SMTP id
 6-20020aca0906000000b0035468aa9c59mr28156741oij.35.1669690786942; Mon, 28 Nov
 2022 18:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20221128155717.2579992-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20221128155717.2579992-1-harshit.m.mogalapalli@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Nov 2022 10:59:36 +0800
Message-ID: <CACGkMEuPe_Q1+F47YXdi2=L5bO4JB9+cRB0mn4eZKF6O4N3=Aw@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Validate vq_num in vduse_validate_config()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     sgarzare@redhat.com, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:57 PM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Add a limit to 'config->vq_num' which is user controlled data which
> comes from an vduse_ioctl to prevent large memory allocations.
>
> Micheal says  - This limit is somewhat arbitrary.
> However, currently virtio pci and ccw are limited to a 16 bit vq number.
> While MMIO isn't it is also isn't used with lots of VQs due to
> current lack of support for per-vq interrupts.
> Thus, the 0xffff limit on number of VQs corresponding
> to a 16-bit VQ number seems sufficient for now.
>
> This is found using static analysis with smatch.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v1->v2: Change title of the commit and description, add a limit to
>         vq_num.
>
> v2->v3: Improve commit message to include reason for setting limit to
>         0xffff
>
> Only compile and boot tested.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..31017ebc4d7c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
>         if (config->config_size > PAGE_SIZE)
>                 return false;
>
> +       if (config->vq_num > 0xffff)
> +               return false;
> +
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> --
> 2.38.1
>

