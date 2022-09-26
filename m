Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB865EA2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiIZLQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiIZLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157265652
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0528560C0D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E33C43470
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664188633;
        bh=Hi250lEcHmqRMCiFu+o46KKfJcBRe2v5BAaGrTHzJ8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kkh/WR7IOKRZ66iHOypufEgTHC0l/U+CzvyZ05EY992B4QYmkV2uVsEehV2GGKxkp
         WKeuVG6teAu8AWZsMC5S3DYJSFzR+Ajbv7iw0raNo/rvnJTVc9mcH81raRO3SjlqNn
         DGlJI4d4AxogYluWWT5oBJN0tia/kT0xsnhht4t3VMg1fKngSxlkmwo3+wWqnW+jfG
         dT++q8sg+U36xk1bXD1gj6FkYAem77F4zEAKwJ6pHhX4xI5iGHQ6+4YDvqXwlfuAd4
         29bzcYXB0Ml6VIZ/xHK51ZJ24/LISK+gjfWLjDONezej/C8/JUFt7HmrpidJ2JvIBs
         M++x5RptcuGpw==
Received: by mail-io1-f43.google.com with SMTP id g8so4874562iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:37:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf3c66qD58hqEhvPFHuYs/helus7XPejln65tHhrXopT5WpcgZLM
        o6IG+qx9Xp0rJvEj2Q7nyRwcJvzUEJKkDNRD3nY=
X-Google-Smtp-Source: AMsMyM6lhUIhWYz1NOxb+QDnwllrltezphEOuSB7EWp47L2Uoz90jO54lbx5TopvNQSrC9tjw/8M0ZcMvnP8GQyHURs=
X-Received: by 2002:a05:6638:2686:b0:35a:40db:95ea with SMTP id
 o6-20020a056638268600b0035a40db95eamr11599524jat.303.1664188632631; Mon, 26
 Sep 2022 03:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220923143913.102197-1-yangyingliang@huawei.com>
In-Reply-To: <20220923143913.102197-1-yangyingliang@huawei.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 26 Sep 2022 13:36:45 +0300
X-Gmail-Original-Message-ID: <CAFCwf12Y5Ncifc-DUPp=88QWdRJmxttfJSFLWAvX_KmfVioVsg@mail.gmail.com>
Message-ID: <CAFCwf12Y5Ncifc-DUPp=88QWdRJmxttfJSFLWAvX_KmfVioVsg@mail.gmail.com>
Subject: Re: [PATCH -next] habanalabs: fix return value check in hl_fw_get_sec_attest_data()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dliberman@habana.ai
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 5:32 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If hl_cpu_accessible_dma_pool_alloc() fails, we should check
> 'req_cpu_addr', fix it.
>
> Fixes: 0c88760f8f5e ("habanalabs/gaudi2: add secured attestation info uapi")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/misc/habanalabs/common/firmware_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
> index 2de6a9bd564d..f18e53bbba6b 100644
> --- a/drivers/misc/habanalabs/common/firmware_if.c
> +++ b/drivers/misc/habanalabs/common/firmware_if.c
> @@ -2983,7 +2983,7 @@ static int hl_fw_get_sec_attest_data(struct hl_device *hdev, u32 packet_id, void
>         int rc;
>
>         req_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, size, &req_dma_addr);
> -       if (!data) {
> +       if (!req_cpu_addr) {
>                 dev_err(hdev->dev,
>                         "Failed to allocate DMA memory for CPU-CP packet %u\n", packet_id);
>                 return -ENOMEM;
> --
> 2.25.1
>

Thanks!
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.
Oded
