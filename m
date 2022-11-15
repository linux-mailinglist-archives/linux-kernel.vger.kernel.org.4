Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEB629FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKORB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKORBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:01:49 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094B29347
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:01:47 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h206so11117971iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brEUw/dNAfIztfV+3la/SeAE46B1ZsC0fklrGox8adM=;
        b=CT+fT3KmJQS9My7oK3mwrS/aQA4MsWegBwk6bLB+DfaNkO/Ja+SuYhMlKh9R12rWGl
         n9hNvxOqF88WOxIco5HRZvRmHNKE+g2RE3EPmAmnOlJqznWOx36R4OvFIvdoCoxHrxv/
         zecmjC7Nqu/hZcpTjVKN3VSVk3hDSHGuRD/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brEUw/dNAfIztfV+3la/SeAE46B1ZsC0fklrGox8adM=;
        b=T5kJhLQ2BAw1aHXyk1+LJ072ueQntF6RxqPKS9JK/4KsL/JPNcqMQEXE9Ejm9EvGou
         BPyDO8o/tL1J7qpEasNwNou/gVsOn29S1+1TtjYC0EHOO5h9qIJaXtw0eYdocscZzSuf
         V0RRAFaEAMbkWqNN2OBUOXMvSQyEllPZBCtsoSB8oIzRmzEtq90q4oP16wwKwo7eNcKm
         /xQcRpJ4a9gOC9eJ9PGIFypX8iGd61jXABYf/zHCwX8N4TaHl/Q1YZGw15OeP4nbHjvW
         BOZ3IhFFd94gVomRKRFwtTk8ma9TuhIVtp2RaPn/Mwv+1OqpHPBIFxA1QKQr/vnmea+V
         2/rQ==
X-Gm-Message-State: ANoB5pkO3l52pL8/7GalMwfpAI+E3NaEmi2PmgOTgXpKidM6a9OZwUlQ
        /sd0MlBofMJqyOJd4tlMpBcOpg==
X-Google-Smtp-Source: AA0mqf5Uq1xnby4AmdSDPypiM2o8XKoDNyckNvth3+apJal6pXvwau1Fu5Wqrf9EuVixXZJhP+bm0w==
X-Received: by 2002:a05:6638:380c:b0:375:8bcb:a486 with SMTP id i12-20020a056638380c00b003758bcba486mr8194477jav.134.1668531706255;
        Tue, 15 Nov 2022 09:01:46 -0800 (PST)
Received: from chromium.org ([2620:15c:183:204:3b76:9466:c618:779e])
        by smtp.gmail.com with ESMTPSA id k8-20020a0566022a4800b006ca91aa55b3sm5430574iov.8.2022.11.15.09.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:01:45 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:01:42 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     jwerner@chromium.org, gregkh@linuxfoundation.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH -next] firmware: google: fix a NULL vs IS_ERR() check in
 cbmem_entry_probe()
Message-ID: <Y3PF9k8/ofe8EatQ@chromium.org>
References: <20221115091138.51614-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115091138.51614-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-15 at 09:11 +0000, Peng Wu wrote:
> The devm_memremap() function returns error pointers on error,
> it doesn't return NULL.
> 
> Fixes: 19d54020883c ("firmware: google: Implement cbmem in sysfs driver")
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Reviewed-by: Jack Rosenthal <jrosenth@chromium.org>

> ---
>  drivers/firmware/google/cbmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
> index 685f3070ce9d..88e587ba1e0d 100644
> --- a/drivers/firmware/google/cbmem.c
> +++ b/drivers/firmware/google/cbmem.c
> @@ -106,8 +106,8 @@ static int cbmem_entry_probe(struct coreboot_device *dev)
>  	entry->mem_file_buf = devm_memremap(&dev->dev, dev->cbmem_entry.address,
>  					    dev->cbmem_entry.entry_size,
>  					    MEMREMAP_WB);
> -	if (!entry->mem_file_buf)
> -		return -ENOMEM;
> +	if (IS_ERR(entry->mem_file_buf))
> +		return PTR_ERR(entry->mem_file_buf);
>  
>  	entry->size = dev->cbmem_entry.entry_size;
>  
> -- 
> 2.17.1
> 
