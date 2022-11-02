Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5031C616BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKBSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiKBSIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1922EF5E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667412451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FxfvX4krt4abJfRYzsFsAKRNK0FMytHkvgVp73QFGQ0=;
        b=FmDOprvg0TKMbc6NlLv6Q8uX5Y4VxiGyqmGq+9Q3GoV3Ur69zd1z6GHGNgkcGOQp/xXvbv
        VfrpxI5TiFz2dxvagiKsPM3Ti95GkvgudL6oQkArnaQf7m0zoABEDG9R60WLdDMUAkzQO2
        FXXKfUh+AtHXgceKrx8UF2FJsPdW/WA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-wIq-7QvQON6xBatkhnTWqg-1; Wed, 02 Nov 2022 14:07:30 -0400
X-MC-Unique: wIq-7QvQON6xBatkhnTWqg-1
Received: by mail-qk1-f200.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso7471750qkb.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxfvX4krt4abJfRYzsFsAKRNK0FMytHkvgVp73QFGQ0=;
        b=wF0SXjHBR2d1BIiKgqZkECXb9CtUMYdZPQqzgR/xgiSUzp9Cx1TzQya5diHcLbSvpf
         1q41l3kn36VFS4zb3z8AlaRsiWf9LcF8GnKuu+eyQ6THPICyQu4c2jLghFX+zAfI4Ifx
         6oWTXGDWSawwv4OS3eEeV3x47emxzG5rRvuTp9OT3wR5Yy+Lfu6U0RrAVs0Y3ZKDR4bA
         rbdyPgmzc75oLb3ERfDcMl+IL+/OVEbfnocG0v3yZ9Ibt9F4FHFz/b6OSOmB5EWDMQjk
         M7vyjUsEE97fXa+Ye96Lp/g9rVMPd6xZ+C4KL74fOwBS6sIgbTrEWqQKvYvuZmSEA4Fd
         PHXA==
X-Gm-Message-State: ACrzQf3D8J/h7QRMUxTv+XzFahVal2Gx+PTU6TPf4cuzPLy++E6mRVFq
        u6X1ZYJHdXCcOn67wDnyzIPY+6w64WVO2sVqeCOKJmp7zDZtlkU4SotZqaDNP4NLf9JAX0K2MRF
        rUm7/Cxwqklz2YTg4BqIqhOmb
X-Received: by 2002:a05:622a:4d4b:b0:3a5:4106:4f16 with SMTP id fe11-20020a05622a4d4b00b003a541064f16mr6155046qtb.488.1667412449533;
        Wed, 02 Nov 2022 11:07:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73gGFi5A2/k5ejnsDKWbiYpJx1+K0ajgL+aoZE9BOqeMUbwF4ar5l/PPR04bf0bMhzO0Z3eA==
X-Received: by 2002:a05:622a:4d4b:b0:3a5:4106:4f16 with SMTP id fe11-20020a05622a4d4b00b003a541064f16mr6155020qtb.488.1667412449297;
        Wed, 02 Nov 2022 11:07:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cc8-20020a05622a410800b003a4cda52c95sm5086434qtb.63.2022.11.02.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:07:27 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:07:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more
 incorrectly.
Message-ID: <20221102180726.fuwwk2npsse56ius@cantor>
References: <20220930173652.1251349-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930173652.1251349-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thoughts on this patch?

Maybe changing the summary to "dmaengine: Fix double increment of client_count in dma_chan_get()"
would be clearer?

On Sat, Oct 01, 2022 at 01:36:52AM +0800, Koba Ko wrote:
> If the passed client_count is 0,
> it would be incremented by balance_ref_count first
> then increment one more.
> This would cause client_count to 2.
>
> cat /sys/class/dma/dma0chan*/in_use
> 2
> 2
> 2

Would this be better?

    The first time dma_chan_get() is called for a channel the channel
    client_count is incorrectly incremented twice for public channels,
    first in balance_ref_count(), and again prior to returning. This
    results in an incorrect client count which will lead to the
    channel resources not being freed when they should be. A simple
    test of repeated module load and unload of async_tx on a Dell
    Power Edge R7425 also shows this resulting in a kref underflow
    warning.


Regards,
Jerry

>
> Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> Reviewed-by: Jie Hai <haijie1@huawei.com>
> Test-by: Jie Hai <haijie1@huawei.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> V2: Remove [3/3] on subject.
> ---
>  drivers/dma/dmaengine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 2cfa8458b51be..78f8a9f3ad825 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
>  	/* The channel is already in use, update client count */
>  	if (chan->client_count) {
>  		__module_get(owner);
> -		goto out;
> +		chan->client_count++;
> +		return 0;
>  	}
>  
>  	if (!try_module_get(owner))
> @@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
>  			goto err_out;
>  	}
>  
> +	chan->client_count++;
> +
>  	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
>  		balance_ref_count(chan);
>  
> -out:
> -	chan->client_count++;
>  	return 0;
>  
>  err_out:
> -- 
> 2.25.1
> 

