Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFF5F41A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJDLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJDLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:10:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784B13CDA;
        Tue,  4 Oct 2022 04:10:02 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 89FA1660225F;
        Tue,  4 Oct 2022 12:09:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664881800;
        bh=AvdV9cCb9MyFUjPM+yXgi5qVq0iERQTeijLa2X2YNUE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=bIUzx4Itf+luuKI3l69mI+QwJDdTse1Gehqbh9UIsH/HbZ93+iBxy7q+u8MxqkfYg
         Bnrlp8tZs5nplFmwrrv6/51r6ujXdW8lAiJuXBVHI40hFK901o+vZxDwKR+JMWNFmT
         bQFk4PUlGAR1uqV4w4b4C/BLCyl2tYU8l1ub2tK0I1Zu/L3TnGjY9H9V7CCeZeVKQI
         cgf0GZPJm+1gqNMmRvkO097YhplUpOx7IC0z9EfwLDbm0Qu3qGl9/6mKJuImoa/hWe
         pIKNm0a4QhoGnPKS7yCZ60KNXXUwEq86RP6j8bruZDPOhNBNQrqwiUM/e3886T0SGZ
         wiQLqqBtC8Zjw==
Message-ID: <01ae2244-99cd-e96d-1bb7-6082da017cc8@collabora.com>
Date:   Tue, 4 Oct 2022 16:09:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Remove the dead code
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
References: <20221004055620.371732-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20221004055620.371732-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch. This is wrong and not needed.

On 10/4/22 10:56 AM, Muhammad Usama Anjum wrote:
> The vmallocated_buf is being checked if it is true inside the body of a
> if condition which has already checked if it is true. Remove the
> duplication and dead code as a result.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/spi/spi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 44e4352d948b..4c51cd4e4ab0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1057,10 +1057,7 @@ static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
>  			min = min_t(size_t, desc_len,
>  				    min_t(size_t, len,
>  					  PAGE_SIZE - offset_in_page(buf)));
> -			if (vmalloced_buf)
> -				vm_page = vmalloc_to_page(buf);
> -			else
> -				vm_page = kmap_to_page(buf);
> +			vm_page = vmalloc_to_page(buf);
>  			if (!vm_page) {
>  				sg_free_table(sgt);
>  				return -ENOMEM;

-- 
Muhammad Usama Anjum
