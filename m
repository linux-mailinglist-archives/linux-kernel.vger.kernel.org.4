Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3F5BB103
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIPQRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIPQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895BB6009
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663345034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2Tln14Ocv6kONUatrxC5kt37vjmPJnPDfeEkInI1oc=;
        b=hmHFRM3lf13doqqRSlmaocqcc+TiG3Pm4QS48MDPHsO/jsNHNqA20obVFDA5DIUGJv/pSS
        w5k35YI4REpsM6G+rN874d36mUcXOzb5Z/s14LPoQ5iYrLLe0pZXC+j+GxjaS/2x7uNcPK
        5de0+yFhVkPdHh230sgRZV6WZKrp978=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-lh4v1RnwPkuMPDgUjewTVQ-1; Fri, 16 Sep 2022 12:17:11 -0400
X-MC-Unique: lh4v1RnwPkuMPDgUjewTVQ-1
Received: by mail-pl1-f198.google.com with SMTP id n9-20020a170902d2c900b001782ad97c7aso11356331plc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=N2Tln14Ocv6kONUatrxC5kt37vjmPJnPDfeEkInI1oc=;
        b=hMuE9twMraRJrISRxXoz968OevOKwQUeA+Mfmt1DDo3cgwluocGdjMTGT1agWW5K90
         yeFWdKhFhWsTtsj3WUO39LM8X82sxMO5W2roOhXB3vHYPYgNH6aoLxpGScT5wrAip5vI
         TbywfAwTDFJvL2XR6pdu/nnvUL/1wMvjvjbd7ylBl4S0xFW3xZF3M+pYIqq8h1H7o/iR
         t8N3qkGdZvtF258zCtRfBPiPVLA/V82/gssAS9unI1BV5fkhCODIXdy+SZVa14PBD4ub
         YQ5EX3QHQluV+P+L3V2gdNhl9iAa0E7Etx+batr0nYqEsBy394hsoKTcdq6ocHUdVISJ
         XizQ==
X-Gm-Message-State: ACrzQf1ut3CmbBYnkHYkSkohsIacEYJkjv9Sa/leAiHtm2WuGFUFmfqu
        8IR2ZJvqkXbVlmaPXpscrhkbaH0kBPEpufk8p6kSmUo63j0sQ6vWUodAHYY6ExbdZ14bpug/OuE
        re/gsujQ8eFZjR/IC9SckcmId
X-Received: by 2002:a17:902:7281:b0:178:388d:6f50 with SMTP id d1-20020a170902728100b00178388d6f50mr573447pll.127.1663345030623;
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6X3Z9Gc3KaRdSev7M6ptsUUTZgZuBwPComTkQd67+aT/x+WuOixIxbO2qzm9/ewt/KUM4jKg==
X-Received: by 2002:a17:902:7281:b0:178:388d:6f50 with SMTP id d1-20020a170902728100b00178388d6f50mr573424pll.127.1663345030380;
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902dc8100b0017508d2665dsm15100299pld.34.2022.09.16.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:17:10 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:17:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix memory leak in idxd_alloc()
Message-ID: <20220916161709.p6srrszdp2qz2nmp@cantor>
References: <20220914230815.700702-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914230815.700702-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:08:14PM -0300, Rafael Mendonca wrote:
> If the IDA id allocation fails, then the allocated memory for the
> idxd_device struct doesn't get freed before returning NULL, which leads to
> a memleak.
> 
> Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/dma/idxd/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..fdc97519b8fb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -445,8 +445,10 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	idxd->data = data;
>  	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
>  	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
> -	if (idxd->id < 0)
> +	if (idxd->id < 0) {
> +		kfree(idxd);
>  		return NULL;
> +	}
>  
>  	device_initialize(conf_dev);
>  	conf_dev->parent = dev;
> -- 
> 2.34.1
> 

