Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030F652324
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiLTOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiLTOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:51:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530501C93B;
        Tue, 20 Dec 2022 06:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FF97CE131B;
        Tue, 20 Dec 2022 14:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54F5C433EF;
        Tue, 20 Dec 2022 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671547876;
        bh=kGMXu02MAUd9IY696qws7gEYoafHdtsgJ2OQAK7H7nA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lXpBWJsI0IM3IVu8x4LJxHv0XIVEn1CtDiNiuZCVgXt83S0wKrdcLyo9hH+LiMV4S
         YxBCzCLsCbrFthuHNY8swZgC9QDAGEAQPzzVREcdDVFg5BJ8qGHJkzto2wdL53V5OV
         ds+76LbLpoxBcka3Hv/mD5az29ZeTLL2aN5/s6MPjYVxmtnSj1GEru7zKgaghnTco3
         6WGjLqmuASRPP/zTM3Z1PLI4ZfNZgSKt0BFPVF2Op+kaPp7Zo2vEFcZsEn3pYSqGbH
         OlrVm3aw59InBWk8SR9eRskAhNZJq9Rs2uKwf+D45EHwGJSTR0K12ps7Es8adISGIs
         4pr4wSkCf4gtw==
Date:   Tue, 20 Dec 2022 15:51:17 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel_ish-hid: Add check for ishtp_dma_tx_map
In-Reply-To: <20221122134823.540-1-jiasheng@iscas.ac.cn>
Message-ID: <nycvar.YFH.7.76.2212201550060.9000@cbobk.fhfr.pm>
References: <20221122134823.540-1-jiasheng@iscas.ac.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, Jiasheng Jiang wrote:

> As the kcalloc may return NULL pointer,
> it should be better to check the ishtp_dma_tx_map
> before use in order to avoid NULL pointer dereference.
> 
> Fixes: 3703f53b99e4 ("HID: intel_ish-hid: ISH Transport layer")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Srinivas, can I get your Ack on this one, please?

I'd much prefer to perform the check right at the allocation time, but 
that would need some more code refactoring (as 
there is currently no way for ishtp_cl_alloc_dma_buf() to fail).

> ---
>  drivers/hid/intel-ish-hid/ishtp/dma-if.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/dma-if.c b/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> index 40554c8daca0..00046cbfd4ed 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/dma-if.c
> @@ -104,6 +104,11 @@ void *ishtp_cl_get_dma_send_buf(struct ishtp_device *dev,
>  	int required_slots = (size / DMA_SLOT_SIZE)
>  		+ 1 * (size % DMA_SLOT_SIZE != 0);
>  
> +	if (!dev->ishtp_dma_tx_map) {
> +		dev_err(dev->devc, "Fail to allocate Tx map\n");

I'd also suggest to use "Failed to ..." instead.

Thanks,

-- 
Jiri Kosina
SUSE Labs

