Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13B62AD83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKOWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKOWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76782F65F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668549614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWVdEQSGnUT5FS0ewLKb5wfJc/7a9atoeI2Gx/iKg8A=;
        b=aGOoEFmnPxcOgeIfdOnMZWAe6ki9DB28GTEBChU4qaF9A1SsLKS3JC6EZVN7eDHY5d4VQH
        HEdsYiFcKcZx1NUwjJuYykIrHQTTzURlPn85F6jwTVvn9/wsy84g25L3ZpyO+2jC/awKkW
        jFX1v454fw2so2oKqpYoZDfbBZFbTy8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-D3ZHYzSIOHOiA07YWueZ2w-1; Tue, 15 Nov 2022 17:00:13 -0500
X-MC-Unique: D3ZHYzSIOHOiA07YWueZ2w-1
Received: by mail-il1-f200.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so11930227ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWVdEQSGnUT5FS0ewLKb5wfJc/7a9atoeI2Gx/iKg8A=;
        b=0QB9BAAXLztKJmhDauHPasmwtLS1CgqFlj5znzElsPA5AxR+R6cIH2HD8odNXz3npU
         wmdjg7GvQIvAUIFF1B0KJPVOxBdEa3dk3xRxB0bRDnxfHzn5WpH0YiVjlBXAI7+P/7eP
         JP8yuqqOg77UUQdVeINu4YTQjYQ1cp8qdzl/BdeWjYZIJ8NI1D29gpZ8wtgf7r2iKJn6
         6M92AKPCutTKIoFcKaNp1qvxEj9enV1eZnoThuiWb3T4mpteSL2IeGqtL0E48wE4lyTH
         +1wGhFz09G95VR7QcAQ8nww1GavP67BoE29lkGHGxzR9syYihJpqLX+0Nq7fXbt6DcGM
         zg6A==
X-Gm-Message-State: ANoB5pmopNB44r+xt+n1zfUtVabBHq7g2D06uCwtHsHAF1FIzhURqlx3
        NqcWtl54npdkXVcHPWmbkj+9SzqiCcEIoWJziMNlZNNdcbpSwEZJgwc2a2sEDsLAaoOfaJJjKu2
        GT7CGmuFhPp4YqFm01iwx+d0P
X-Received: by 2002:a05:6638:3f17:b0:375:ca55:284e with SMTP id ck23-20020a0566383f1700b00375ca55284emr9180776jab.248.1668549612756;
        Tue, 15 Nov 2022 14:00:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7oQSLhB2PYlLP7mKdWIRx+wC8V8U3i1U/ad+EQyX/KiYKoJehO7s0GWEhKea9lm6xMuQBKiA==
X-Received: by 2002:a05:6638:3f17:b0:375:ca55:284e with SMTP id ck23-20020a0566383f1700b00375ca55284emr9180764jab.248.1668549612485;
        Tue, 15 Nov 2022 14:00:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cd15-20020a0566381a0f00b0037494035324sm5218448jab.48.2022.11.15.14.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:00:11 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:00:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch 09/10] vfio/fsl-mc: Remove linux/msi.h include
Message-ID: <20221115150009.7bca909e.alex.williamson@redhat.com>
In-Reply-To: <20221113202428.826924043@linutronix.de>
References: <20221113201935.776707081@linutronix.de>
        <20221113202428.826924043@linutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2022 21:34:08 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Nothing in this file needs anything from linux/msi.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Diana Craciun <diana.craciun@oss.nxp.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
> @@ -8,7 +8,6 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/eventfd.h>
> -#include <linux/msi.h>
>  
>  #include "linux/fsl/mc.h"
>  #include "vfio_fsl_mc_private.h"
> 

Acked-by: Alex Williamson <alex.williamson@redhat.com>

