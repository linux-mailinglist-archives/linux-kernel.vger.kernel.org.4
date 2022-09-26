Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD635EA216
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiIZLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiIZK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030531CB03
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59FBDB8055F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16247C4347C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664188176;
        bh=JVwL4+pk2gSajzwoirsepcBDoh5zf/iqBLZKL+RXzEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YTMZlICd2btn54Usu3uloEJlo9oTQ+/fpFHnrcmB8FHfPJUwYfXWjWSizTJFGFkDA
         PI4tKfD0Kb1dGrq4i/IawlFd6djEjupZbtxR5WsqxaQ2UcP/hMuYW1aXqJKk04U0Dl
         H2ch8IyISmugVHGVDX5JIE0rjn6BzFx7aN/LaWCbMBdP0qib7lO/TrjKZ2IXdbMvMs
         7F50SN9PZ1izFFB8q+LUtGnl1emkntPrOvtqm0Z2pxhNZ7Zns/lyBWyZVcpA90ReB7
         zNM9C8JuF3J8VLPhYXqpd+yMqDJipFsbsHcqCwiQpxeP6hkc8ufIqusazcNbOPxKkY
         c+OaCa5BYygLA==
Received: by mail-io1-f54.google.com with SMTP id d8so4783411iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:29:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ts9Zq9ZU+UK5sPG0HKqZobk/3XkYa21RoipEI9f6L+Z2CkZkT
        4TC8KPT7r75lMUTxNQcokZznhqgnLQlwDmfX0xY=
X-Google-Smtp-Source: AMsMyM75fqYuuUAe4LsKRaBxqTPe3IyfH95/iEbBvlxniiH3YhjGy+8uesAEvVvbAplnKK7JrDKOsDA2ptM3aZ3R6rs=
X-Received: by 2002:a05:6638:3886:b0:35a:2856:ac2c with SMTP id
 b6-20020a056638388600b0035a2856ac2cmr11401304jav.279.1664188175228; Mon, 26
 Sep 2022 03:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220926015208.3794-1-liubo03@inspur.com>
In-Reply-To: <20220926015208.3794-1-liubo03@inspur.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 26 Sep 2022 13:29:10 +0300
X-Gmail-Original-Message-ID: <CAFCwf13Q-m24+7_zC2XCSVF1dO6Cy25YCGr4oj=qsgjRXyyhSg@mail.gmail.com>
Message-ID: <CAFCwf13Q-m24+7_zC2XCSVF1dO6Cy25YCGr4oj=qsgjRXyyhSg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Use simplified API for p2p dist calc
To:     Bo Liu <liubo03@inspur.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:52 AM Bo Liu <liubo03@inspur.com> wrote:
>
> Use the simplified API that calculates distance between two devices.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/misc/habanalabs/common/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
> index ef28f3b37b93..99b1d6ce26ae 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -1689,7 +1689,7 @@ static int hl_dmabuf_attach(struct dma_buf *dmabuf,
>         hl_dmabuf = dmabuf->priv;
>         hdev = hl_dmabuf->ctx->hdev;
>
> -       rc = pci_p2pdma_distance_many(hdev->pdev, &attachment->dev, 1, true);
> +       rc = pci_p2pdma_distance(hdev->pdev, attachment->dev, true);
>
>         if (rc < 0)
>                 attachment->peer2peer = false;
> --
> 2.27.0
>

Thanks, but this change is already queued for upstream in our internal tree.
Oded
