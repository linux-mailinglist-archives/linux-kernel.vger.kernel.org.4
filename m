Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE866536D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiLUTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiLUTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:13:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F402529D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:13:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so15930126wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loGkZ6fPSrrmhsnB/j6H1/AVCfOR2MAXJgzPNmIA2Q8=;
        b=FaVOUANB+JUidsrSRWcPVrk9vir9R7x13EZXvbbFJKhNPfY6MQVuzhcYF76JipPOh9
         G3oLP/cCugNtim+SoHolkoMY46Q4+FUVk89IKwlXBGRaDtFy8sIZgDSSFrA4+o1LeD+o
         7G0Pl5bYpMKuIlW9IMN+BZu4FdORmvf1DPnR0CM3xwThjvqJCKpULmerXqRa+9nDWdZO
         ChFRyGKk65HzSCiPKmMS8dEoyHPIk5lSyoApNLe7sBUzkyxjaOvicQv1Q8icK7vbI2Wv
         i5BybSBQHbpfJxvLHsuiX9keXUGHsZ5DttiD9e0YpMw3pgpqT69m5DFY9MWU1knvBJNr
         ZyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loGkZ6fPSrrmhsnB/j6H1/AVCfOR2MAXJgzPNmIA2Q8=;
        b=f89qkO5vm5i2Q2ObRH7DTsISxyE4jMFkIwyLZV1SnMqpUvOgjW/6Lvwe1ZGHL7+SNJ
         afxNK/Jc5ptSInvJ6z8HL3dds9y2zXPXn6mg9597BH4yhwrRChvRuZ9m21w2kFTO4+pB
         ERNiibB60Rsxi2jSNH26lhQOonFxSh2JPBEXtlmb3Qmb45Iqu+ikNpI6iL4p21e5S9rv
         A5kYY8rq8/Maz1DPhUglqQTac/mKH2Z4MZtEfWnR33X0TjmMw7ZBfo/0USj7JDTSgqc/
         HmpbyEu2pUHYNmTMQDlKrxu1T/8+sius8Jq6L4a4c+CSntLZfzSxqB58iduniJsIxLHC
         DSxA==
X-Gm-Message-State: AFqh2koZIurNTH5xQv6DIihHmySEKkatP44piZebaW9Pdj9wL6OzXwHZ
        US/gL3KO3V67Q5jyTFcFRu33XSr2Rzo=
X-Google-Smtp-Source: AMrXdXu5nCKznJHZrUQSE0Oijx3MYaVAi4blJLehAPfwEFKcFqI3ZBZGTh+4Ga7pdR4U6qZlW8OvaA==
X-Received: by 2002:a05:6000:16cb:b0:242:1b0d:9c58 with SMTP id h11-20020a05600016cb00b002421b0d9c58mr2117681wrf.69.1671649984661;
        Wed, 21 Dec 2022 11:13:04 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d5450000000b0026a4bb75477sm2473118wrv.28.2022.12.21.11.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:13:04 -0800 (PST)
Date:   Wed, 21 Dec 2022 19:13:03 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/3] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Message-ID: <Y6Nav+UHCPPdPO6Q@lucifer>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <20221221174454.1085130-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221174454.1085130-3-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:44:54PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently a vm_unmap_ram() functions triggers a BUG() if an area
> is not found. Replace it by the WARN_ON_ONCE() error message and
> keep machine alive instead of stopping it.
>
> The worst case is a memory leaking.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 17e688cc7357..221d8950e13c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2252,7 +2252,9 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	}
>
>  	va = find_unlink_vmap_area(addr);
> -	BUG_ON(!va);
> +	if (WARN_ON_ONCE(!va))
> +		return;
> +
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
>  	free_unmap_vmap_area(va);
> --
> 2.30.2
>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
