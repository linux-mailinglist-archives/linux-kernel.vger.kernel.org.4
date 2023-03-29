Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAB6CEC55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjC2PEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjC2PD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD51BC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680102191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hlofjauJPlXfYADPzQPDVEUnQC/PDQRHvDqts/6T6UQ=;
        b=PW6zyBE1P1d2/vI0fDD0+j+6vSdYaqdkDhxyKhqek5wwiT3jPqHoA0D4bH9UgtjGKtcGV4
        rk9S0wMJldx0wQEs0Mad1vufDxZ+UkcG+ZO/mK2oWAubBu4WAI1Qve1aPEpyjZMufvgg6Y
        koSRyrNYQ23PhPP/gLZrnLVzf8WgKMY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-38ZlxmNiMOuGbWEYMHgItw-1; Wed, 29 Mar 2023 11:03:07 -0400
X-MC-Unique: 38ZlxmNiMOuGbWEYMHgItw-1
Received: by mail-qk1-f200.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so7341425qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlofjauJPlXfYADPzQPDVEUnQC/PDQRHvDqts/6T6UQ=;
        b=frgdJM+QWhymoIcDluYyktLOp6BixcGysGBCvB32qxl8cV9lrKcw/7o2x31AWQiNNP
         uM09HuXPgyOkQUYJvmn3hSSrbWjkpcHWgRPtqkoHrwjtMPVqkt+JCg9DmwT5vwzaFFxg
         +VwjoRcXUyP59VdbKuO9qg5uMXEIgXQk2QABMkH6nTkscfYHQtDcF7vefV2ItxWRa292
         IAl2nUX2tNr8eUfSF6sIE9z3L3vQH8lZR5evw/smquwz9Ie9WJk0/UcQoNZAthhvj3hl
         ilb9Poz3XKw5srXIyD8dv5f9C20C+vxE7/YK/RlXUaPVWvchy5M0kaF80CcVmtLO4YBu
         dQKg==
X-Gm-Message-State: AAQBX9enfgBapBIJYrc/VtfJ/NoeAUqSd5CQG+4ym72xG6M8lNOv3NEP
        VZqH/napT/iC7gK3KZj10+1MGP1iKfyb+nPcEFN0d49LNuP9ueRoIrSQ7x6upO05LxdvoM2LuD7
        GKTFDa6Q+PIBgXF8yqz1ohZSt
X-Received: by 2002:a05:6214:27c1:b0:56e:9ab5:cd9f with SMTP id ge1-20020a05621427c100b0056e9ab5cd9fmr31560868qvb.39.1680102187401;
        Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXCxRiiS8rCjA4Y3Ad7TR+rQzvZr5LeNmaq6ea2t6JngTuQWRCDL7OnMKrZ3QLfPO9P1kkbQ==
X-Received: by 2002:a05:6214:27c1:b0:56e:9ab5:cd9f with SMTP id ge1-20020a05621427c100b0056e9ab5cd9fmr31560837qvb.39.1680102187167;
        Wed, 29 Mar 2023 08:03:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q43-20020a05620a2a6b00b0074860fcfc00sm3225464qkp.136.2023.03.29.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:03:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 08:03:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Desnes Nunes <desnesn@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        noreply@ellerman.id.au
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <2w7rzdbzbii4ewliym6qw4svf2mzptsccz23yms5lsdioflcti@w63kwgzkra6r>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329071405.1568021-1-geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:14:05AM +0200, Geert Uytterhoeven wrote:
> On 32-bit without LPAE:
> 
>     kernel/dma/debug.c: In function ‘debug_dma_dump_mappings’:
>     kernel/dma/debug.c:537:7: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 9 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
>     kernel/dma/debug.c: In function ‘dump_show’:
>     kernel/dma/debug.c:568:59: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 11 has type ‘phys_addr_t’ {aka ‘unsigned int’} [-Wformat=]
> 
> Fixes: bd89d69a529fbef3 ("dma-debug: add cacheline to user/kernel space dump messages")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202303160548.ReyuTsGD-lkp@intel.com
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  kernel/dma/debug.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 676142072d997b6a..f190651bcaddc9e9 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -534,11 +534,11 @@ void debug_dma_dump_mappings(struct device *dev)
>  			if (!dev || dev == entry->dev) {
>  				cln = to_cacheline_number(entry);
>  				dev_info(entry->dev,
> -					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> +					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
>  					 type2name[entry->type], idx,
>  					 phys_addr(entry), entry->pfn,
>  					 entry->dev_addr, entry->size,
> -					 cln, dir2name[entry->direction],
> +					 &cln, dir2name[entry->direction],

Won't this just print out the address of cln declared at the beginning of debug_dma_dump_mappings() each time, instead of the value
returned from to_cacheline_entry() ?

>  					 maperr2str[entry->map_err_type]);
>  			}
>  		}
> @@ -565,13 +565,13 @@ static int dump_show(struct seq_file *seq, void *v)
>  		list_for_each_entry(entry, &bucket->list, list) {
>  			cln = to_cacheline_number(entry);
>  			seq_printf(seq,
> -				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
> +				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
>  				   dev_driver_string(entry->dev),
>  				   dev_name(entry->dev),
>  				   type2name[entry->type], idx,
>  				   phys_addr(entry), entry->pfn,
>  				   entry->dev_addr, entry->size,
> -				   cln, dir2name[entry->direction],
> +				   &cln, dir2name[entry->direction],

same for dump_show()

>  				   maperr2str[entry->map_err_type]);
>  		}
>  		spin_unlock_irqrestore(&bucket->lock, flags);
> -- 
> 2.34.1
> 

