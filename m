Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57005BCB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISLvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:51:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614D2B257
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59EB161B45
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC81AC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663588297;
        bh=T4Aldjlo2BWzH0Mn7gk/BMER5+OG7C6yap81edbjfWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f9Hacj1zzg1QoJk220QR3y9AnKR1VfqwajUrdjJBHFuuFutd3OcgMsCxb1pAOn6M8
         kuyk/yuzOxjXox6NrU1PL9tw0O+T7UuHc5owiKInbkLJUCC4gEJVVIN9+Fuj/lQHLh
         Aw2bLeeTtpFqkfECNcVOv4tRFPPMyhbr0fHMTVT2Xa6kPKPOw7DRD0KMidxQg/91ny
         UVbfi2ISm+ro3lAbVLBXZ2s6V2eFb1xJV8Vzxto1AyA8LdC19jA26P2cGhmVwnHkB9
         xFfQG+MGx2d6QdtTaHD7AZYYpJS6nbOaUHTlyYYFTTR0LX+0TJR7HQkUb7YqwecYNM
         tzt0fU7H3ErFg==
Received: by mail-il1-f170.google.com with SMTP id a14so3485795ild.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:51:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf1m6RIO3UNgUek1gRPm8wu6kF4X1HzWfAHsCKc13Tv3d9VsJN6I
        iHUOXx6yptRCEv6bDd4CU++yYpM+1uREcqBjwHo=
X-Google-Smtp-Source: AMsMyM5cGk38oh8WgCWl47gBsBbgTBRY4EV+4sqEa+ltTLYtk2Yta9qRWeMc3OXJf8vStPoJm6XhASt65lJo7bnie7U=
X-Received: by 2002:a92:b110:0:b0:2e9:9c90:dd0e with SMTP id
 t16-20020a92b110000000b002e99c90dd0emr6640476ilh.322.1663588296790; Mon, 19
 Sep 2022 04:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919022054.3813-1-zeming@nfschina.com>
In-Reply-To: <20220919022054.3813-1-zeming@nfschina.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 19 Sep 2022 14:51:10 +0300
X-Gmail-Original-Message-ID: <CAFCwf12pq9OfU_B2HuwP1_T94zZdZ8kcZeR0TvahdDcZCZK-GA@mail.gmail.com>
Message-ID: <CAFCwf12pq9OfU_B2HuwP1_T94zZdZ8kcZeR0TvahdDcZCZK-GA@mail.gmail.com>
Subject: Re: [PATCH] drivers: habanalabs: Remove unnecessary (void*) conversions
To:     Li zeming <zeming@nfschina.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ttayar@habana.ai,
        obitton@habana.ai, osharabi@habana.ai, bdotan@habana.ai,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 5:21 AM Li zeming <zeming@nfschina.com> wrote:
>
> The void pointer object can be directly assigned to different structure
> objects, it does not need to be cast.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  drivers/misc/habanalabs/gaudi2/gaudi2.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> index 98336a1a84b0..264376617310 100644
> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
> @@ -6149,7 +6149,7 @@ static int gaudi2_non_hard_reset_late_init(struct hl_device *hdev)
>  static void gaudi2_is_tpc_engine_idle(struct hl_device *hdev, int dcore, int inst, u32 offset,
>                                         void *data)
>  {
> -       struct gaudi2_tpc_idle_data *idle_data = (struct gaudi2_tpc_idle_data *)data;
> +       struct gaudi2_tpc_idle_data *idle_data = data;
>         u32 tpc_cfg_sts, qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts;
>         bool is_eng_idle;
>         int engine_idx;
> @@ -6727,7 +6727,7 @@ static int gaudi2_mmu_shared_prepare(struct hl_device *hdev, u32 asid)
>  static void gaudi2_tpc_mmu_prepare(struct hl_device *hdev, int dcore, int inst,        u32 offset,
>                                         void *data)
>  {
> -       struct gaudi2_tpc_mmu_data *mmu_data = (struct gaudi2_tpc_mmu_data *)data;
> +       struct gaudi2_tpc_mmu_data *mmu_data = data;
>
>         WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_MMU_BP + offset, 0);
>         WREG32(mmDCORE0_TPC0_CFG_AXUSER_HB_ASID + offset, mmu_data->rw_asid);
> @@ -9336,7 +9336,7 @@ static u32 gaudi2_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
>
>  static u32 gaudi2_gen_signal_cb(struct hl_device *hdev, void *data, u16 sob_id, u32 size, bool eb)
>  {
> -       struct hl_cb *cb = (struct hl_cb *) data;
> +       struct hl_cb *cb = data;
>         struct packet_msg_short *pkt;
>         u32 value, ctl, pkt_size = sizeof(*pkt);
>
> @@ -9429,7 +9429,7 @@ static u32 gaudi2_add_fence_pkt(struct packet_fence *pkt)
>
>  static u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_properties *prop)
>  {
> -       struct hl_cb *cb = (struct hl_cb *) prop->data;
> +       struct hl_cb *cb = prop->data;
>         void *buf = (void *) (uintptr_t) (cb->kernel_address);
>
>         u64 monitor_base, fence_addr = 0;
> @@ -9481,7 +9481,7 @@ static u32 gaudi2_gen_wait_cb(struct hl_device *hdev, struct hl_gen_wait_propert
>
>  static void gaudi2_reset_sob(struct hl_device *hdev, void *data)
>  {
> -       struct hl_hw_sob *hw_sob = (struct hl_hw_sob *) data;
> +       struct hl_hw_sob *hw_sob = data;
>
>         dev_dbg(hdev->dev, "reset SOB, q_idx: %d, sob_id: %d\n", hw_sob->q_idx, hw_sob->sob_id);
>
> --
> 2.18.2
>
This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.
Thanks,
Oded
