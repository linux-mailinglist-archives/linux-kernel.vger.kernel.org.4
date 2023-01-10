Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAE664200
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjAJNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAJNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:35:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488665792F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31F46171A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C4C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673357712;
        bh=BmAp7+2oGMy9Qz+PZtEGZR8TDXTyRNjGszzif7nd51U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qK135NfZd0Pd1DNzv//uXQgj/QSECzR55ROTx+eo3vYa95yNRFF9q0sa6ps3+j0FK
         mjyHFyi+fm1zIneJyS+I+DElIFfS+go2Z05h5EN03M8IXm4HRatHMEVshV2W9jduMz
         b6uIioQxe4hLX1ExUfWbJq5D4evhTZXmSEQ4v7KtCTDXWW1Ino7QgxGnm+HAGIdvwX
         FL883qhzEDvpKBrpAiDVT5tcpIzoC61Z2gFOHulUUp9mYntjC/RZZYdaFzzziKOY3G
         rkyg3p11FEN0ROZF1OFDEDVHXIdwLNFmpGYd4mGZPMI2PUMicpdHyiP0mJKkd+kMLh
         elNuD3ZaFuGHQ==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-476e643d1d5so154059987b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:35:12 -0800 (PST)
X-Gm-Message-State: AFqh2krCRBhTdcY80O0vdGcG/ibRyuZSM9sdpk20ZkCr1Yr0B5DNPEjt
        D+2VAdRO2A6PcUo0Ryvray50HbbE3qAz0L/bjCE=
X-Google-Smtp-Source: AMrXdXvXr4acp5vZ9s/zrcDb0XZMaF5BuGi20ML4PvQ6rGGroGlgHTEJDPCboCg4KIOPekQEqxj/8Ma387N3RIPEKRg=
X-Received: by 2002:a05:690c:81:b0:36c:aaa6:e571 with SMTP id
 be1-20020a05690c008100b0036caaa6e571mr857650ywb.467.1673357711421; Tue, 10
 Jan 2023 05:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20230110103512.4690-1-xupengfei@nfschina.com>
In-Reply-To: <20230110103512.4690-1-xupengfei@nfschina.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 10 Jan 2023 15:34:45 +0200
X-Gmail-Original-Message-ID: <CAFCwf11sCX2k_kaKEPjjc5TcdWi+TK1gQ90XPFfgM3bBpLm91g@mail.gmail.com>
Message-ID: <CAFCwf11sCX2k_kaKEPjjc5TcdWi+TK1gQ90XPFfgM3bBpLm91g@mail.gmail.com>
Subject: Re: [PATCH 1/1] habanalabs: remove unnecessary (void*) conversions
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, osharabi@habana.ai,
        obitton@habana.ai, dhirschfeld@habana.ai, mhaimovski@habana.ai,
        rkatta@habana.ai, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:35 PM XU pengfei <xupengfei@nfschina.com> wrote:
>
> data is a void * type and does not require a cast.
>
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---
>  drivers/misc/habanalabs/common/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
> index 2c1005f74cf4..a42ae8bc61e8 100644
> --- a/drivers/misc/habanalabs/common/mmu/mmu.c
> +++ b/drivers/misc/habanalabs/common/mmu/mmu.c
> @@ -781,7 +781,7 @@ static void mmu_dma_mem_free_from_chunk(struct gen_pool *pool,
>                                         struct gen_pool_chunk *chunk,
>                                         void *data)
>  {
> -       struct hl_device *hdev = (struct hl_device *)data;
> +       struct hl_device *hdev = data;
>
>         hl_asic_dma_free_coherent(hdev, (chunk->end_addr - chunk->start_addr) + 1,
>                                         (void *)chunk->start_addr, chunk->phys_addr);
> --
> 2.18.2
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
