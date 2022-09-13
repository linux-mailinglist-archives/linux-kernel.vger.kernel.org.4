Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E955C5B6DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIMMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiIMMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:54:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6E53D0C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:54:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-127f5411b9cso31807319fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5TnxhzR41y27enyoDQVCBsyG5YGCmMj80Vbs/LaBjPA=;
        b=iunP141jgptqOjugxEabUf2knnXqzZJpBN/a8q6fTpOZZnTE/e7GY8Cbl4Lbq9FbRx
         tEa+EMwvfc6L6RedT381kcEc82fehbYdZuAM2scDrA0qK4lSB+GsEZRxjVRkDC6lymTk
         rtLbg8kaFJUR6/UJb6c7CqU3uBWBT4zhrmylJP4Trmlc1EAcK3daixgapIqpRId6bO1Q
         4xX4cNOW41gXOMjiIXRuZLdmtyaFIVRhezj+dxDPi2m2ZrZfpaVTOJOFeRXgxPK7vIBn
         nIViGYEeLQM1HrSZD9UKkB+CfaKoawJmjsfIJ+Ix+AUloFE/VdJL3VcaxsuuGeWxsG30
         +wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5TnxhzR41y27enyoDQVCBsyG5YGCmMj80Vbs/LaBjPA=;
        b=AnZW2WMNhyQt3KsPkQFn3RKW1WJFCwDFdn0qfRvkXFebb8ynZvxaatFWNxJy4mWyxK
         O2hoNlerxGWDFTOREr6Bug2ZAE+/ukUP7szQzpKRQnOmzry5Bi9snmpIli7BCeG2Y43w
         u/LEPvKrhQ6XSoVihWZfdjLDCINfTxKq3QTA1nHjsBcl6MT46I9qgdE/zxa5Jv6MjTFG
         dmzhYLvyyP7JvuWKZDkq8lbdWRrxvda/G0K4LjA2DwkvGUzq84H18I3f8p4RQibLvtPR
         Y7e4kNtXHOkM5WdgGbprhagUPLyA21+sqr7GWtgYVTQOdDvCB3gEHIpKwmLXHLKE8se4
         F66A==
X-Gm-Message-State: ACgBeo1FTn578Yv6C3nbV4/uzGWtH5TbUGC+/YrCPnP3R7lMhMAfkMsV
        XGQ+6dyLHAFfKtVgtk/tmj98QoRYDNs+2rq1iQU=
X-Google-Smtp-Source: AA6agR5QvSx5fPiwcvfDfW7ueJTgIPtjqIpSYpqsnt08vDJvKgxOwiQ+IHHzrSB8wLR9QEJBKQjchySvJMJNEgN3ljk=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr1695825oam.96.1663073653794; Tue, 13
 Sep 2022 05:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220912223433.630364-1-rafaelmendsr@gmail.com>
In-Reply-To: <20220912223433.630364-1-rafaelmendsr@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Sep 2022 08:54:02 -0400
Message-ID: <CADnq5_PoJ2GiigfBt87EoE3GYLOFiOvsmBRF74TK6MtRc+t5jw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak in hpd_rx_irq_create_workqueue()
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Sep 12, 2022 at 10:12 PM Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
>
> If construction of the array of work queues to handle hpd_rx_irq offload
> work fails, we need to unwind. Destroy all the created workqueues and
> the allocated memory for the hpd_rx_irq_offload_work_queue struct array.
>
> Fixes: 8e794421bc98 ("drm/amd/display: Fork thread to offload work of hpd_rx_irq")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5140d9c2bf3b..6a2e455c5466 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1295,13 +1295,21 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
>
>                 if (hpd_rx_offload_wq[i].wq == NULL) {
>                         DRM_ERROR("create amdgpu_dm_hpd_rx_offload_wq fail!");
> -                       return NULL;
> +                       goto out_err;
>                 }
>
>                 spin_lock_init(&hpd_rx_offload_wq[i].offload_lock);
>         }
>
>         return hpd_rx_offload_wq;
> +
> +out_err:
> +       for (i = 0; i < max_caps; i++) {
> +               if (hpd_rx_offload_wq[i].wq)
> +                       destroy_workqueue(hpd_rx_offload_wq[i].wq);
> +       }
> +       kfree(hpd_rx_offload_wq);
> +       return NULL;
>  }
>
>  struct amdgpu_stutter_quirk {
> --
> 2.34.1
>
