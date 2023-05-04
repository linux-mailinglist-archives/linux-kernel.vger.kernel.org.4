Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831D6F7989
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEDXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9C9EF8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683241276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkwlQPMGMIxAlMZp1ec5I95UHcrfctVyRuyNlrEK4fQ=;
        b=ALfhyBGsB5RjJqbuwmfiTDMZGSrRVIlMRGKMwIJOgqPZ9O0vZsFakIv1issIp6UXseUXeC
        rGUMZc3rxSCfMVFZw+U5OjWS2T4k6Wuoep/fejKgHK71G1RV8mwqEYtaoXUextsO7KiRq3
        IttTaWOpDnoCa/VpjcoxLPtt+DveK6I=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-vyMgwY0RNiWoEF5g24Gg8g-1; Thu, 04 May 2023 19:01:15 -0400
X-MC-Unique: vyMgwY0RNiWoEF5g24Gg8g-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3315646c88cso15669185ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 16:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683241274; x=1685833274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkwlQPMGMIxAlMZp1ec5I95UHcrfctVyRuyNlrEK4fQ=;
        b=By4D7kjbP0y8swhu8b7Wwy3V7c/btT4QKKXq2rOpIiPlGimHcn7qriB04y1y+TVpdI
         /+g/HpmKYDsUqWrfZcd09FmxBtziW6d5wgGzoUsHZfZfKL0jrJV1tCKRLU99Ye27hHx1
         5Ecl5OoZpd3kVC4GrP9ZsiVBoF7ZAOvENkolVSEmNorjxaS2Vida61ejYlFBjqVhByKW
         3o4XOSFB9Dx5POXnp3yrzDsqEzSuiUHOaegh3BcQtKEtf75wwzpFUUNGSQmFbsxhaNvy
         oe2FnKmTCG8NbVoCsOT0oA7+loVoDkLxQAykLiriPhzUKPqSCE9FwrzKCCeXfx7BnOmS
         4aLQ==
X-Gm-Message-State: AC+VfDx0ICnm0smRpnEy6I0YsSsl0lL+2JtzVF76OQFgtJKuKc18CUdZ
        ppDMMBhhQW8DF/MzSGjymKmCQ/k2XGGrI6kimaLZpSVf3cy87aduvGsMhT1XKnJosJzYgKkgs0y
        2+pSmRQ+j1o6y4SdCzEZ18VT2
X-Received: by 2002:a05:6e02:146:b0:331:3564:7834 with SMTP id j6-20020a056e02014600b0033135647834mr315432ilr.18.1683241274344;
        Thu, 04 May 2023 16:01:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7joMrRtHf14hwBbCTLXHwHP/1+v9CBqB712KbTwQW+NU3pHYjDHXwtRYc/cTXA3sw36Qzx2Q==
X-Received: by 2002:a05:6e02:146:b0:331:3564:7834 with SMTP id j6-20020a056e02014600b0033135647834mr315410ilr.18.1683241274089;
        Thu, 04 May 2023 16:01:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y9-20020a92c749000000b00325de773339sm68010ilp.64.2023.05.04.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 16:01:13 -0700 (PDT)
Date:   Thu, 4 May 2023 17:01:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>, Bo Liu <liubo03@inspur.com>,
        "K V P, Satyanarayana" <satyanarayana.k.v.p@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: demote hiding ecap messages to debug level
Message-ID: <20230504170111.70a7f639.alex.williamson@redhat.com>
In-Reply-To: <20230504131654.24922-1-oleksandr@natalenko.name>
References: <20230504131654.24922-1-oleksandr@natalenko.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 May 2023 15:16:54 +0200
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Seeing a burst of messages like this:
> 
>     vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x19@0x1d0
>     vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x25@0x200
>     vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x26@0x210
>     vfio-pci 0000:98:00.0: vfio_ecap_init: hiding ecap 0x27@0x250
>     vfio-pci 0000:98:00.1: vfio_ecap_init: hiding ecap 0x25@0x200
>     vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x19@0x1d0
>     vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x25@0x200
>     vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x26@0x210
>     vfio-pci 0000:b1:00.0: vfio_ecap_init: hiding ecap 0x27@0x250
>     vfio-pci 0000:b1:00.1: vfio_ecap_init: hiding ecap 0x25@0x200
> 
> is of little to no value for an ordinary user.
> 
> Hence, use pci_dbg() instead of pci_info().
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 948cdd464f4e..dd8dda14e701 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1643,7 +1643,7 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>  		}
>  
>  		if (!len) {
> -			pci_info(pdev, "%s: hiding ecap %#x@%#x\n",
> +			pci_dbg(pdev, "%s: hiding ecap %#x@%#x\n",
>  				 __func__, ecap, epos);
>  
>  			/* If not the first in the chain, we can skip over it */

Looks fine to me, though I might adjust that next line to keep the
previous alignment.  In general this has certainly caused more
confusion than insightful information, so demoting it to debug is a
good idea.  Thanks,

Alex

