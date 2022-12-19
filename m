Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131A650812
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiLSHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF626E3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671435196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0d/LzPh9tLeJeMKVu3lKsG2+7fr+JIeuFdunk+ZR8IY=;
        b=eK48hdlhZ1eg7EIYr3XYNn0h8+XbBPqopGiR+inq6OXZOh76vNB/FgCDFH3fmOeJxZfnGL
        hWP+Q5TppsuC1S5ZlbjOG/xLljzXffXWr3r10QW9UfWJpVP1PwxJI0Toydr2yCllHOKrc5
        XP4RtWUsAmTzMUltVCBR8bQKIncBoRA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-_5t_uoxhOpy3kI-9uhfsiA-1; Mon, 19 Dec 2022 02:33:15 -0500
X-MC-Unique: _5t_uoxhOpy3kI-9uhfsiA-1
Received: by mail-qt1-f197.google.com with SMTP id j26-20020ac84c9a000000b003a7e6d38e01so3692833qtv.14
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d/LzPh9tLeJeMKVu3lKsG2+7fr+JIeuFdunk+ZR8IY=;
        b=v/d6Eljf83tRKfQp2zLuVzvFCzKI9Nuyql+JRecdFbFlL13wJ1QmarlzFHXMM1jIlP
         sH0i9Ck2GypYOEtW6kPonh2C31oXIXXavrG5ewgtqRLP20I+6KDtexDsqVYBVfNCy+Nh
         MsCv4bxraVU28/ePvt1o/F5gmVTFw3kr8SCs3TKmIK9sKmxA2ylgIiTR2zXGnflcR8fz
         rUi9b/HQ+UGwapbh2/PWc7B0hqKvDTFCGN/71IE8QGZ255lOunPUnh55n4iYDLaKHtNy
         3sLzjfceythKdUm2VHxqK749WBWmnINXNBErqH9hC5Vhyv4CDiMeIT7mBqdRCU4vJliD
         asDg==
X-Gm-Message-State: AFqh2kqXApTrCvuMrhcxIya3b8OKsB9DKY1Z9nnuxbKfjxrQI+NGJco/
        LCZ5N2UHOfKLUPzvWqpmH3RDihZk7h8wZeusg4ee+Fh9m/59uzw1GWbwWLXXFcFn3V0ymSlsB/I
        pOuSIHcfW3ZueZ2dXad1VEhNl
X-Received: by 2002:ac8:48d3:0:b0:3a9:7d16:ef64 with SMTP id l19-20020ac848d3000000b003a97d16ef64mr9349779qtr.57.1671435194904;
        Sun, 18 Dec 2022 23:33:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXueArC7fYe0/6MSkh/5pNiFIk1IZRkyewdVHEmCriamttbg+rOsLqUBb3auPDqAq6r2srRb9Q==
X-Received: by 2002:ac8:48d3:0:b0:3a9:7d16:ef64 with SMTP id l19-20020ac848d3000000b003a97d16ef64mr9349769qtr.57.1671435194641;
        Sun, 18 Dec 2022 23:33:14 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id d8-20020ac847c8000000b003a7e38055c9sm5574821qtr.63.2022.12.18.23.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:33:13 -0800 (PST)
Date:   Mon, 19 Dec 2022 02:33:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20221219023253-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205084127.535-2-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> Export irq_create_affinity_masks() so that some modules
> can make use of it to implement interrupt affinity
> spreading mechanism.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

So this got nacked, what's the plan now?

> ---
>  kernel/irq/affinity.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index d9a5c1d65a79..f074a7707c6d 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -487,6 +487,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  
>  	return masks;
>  }
> +EXPORT_SYMBOL_GPL(irq_create_affinity_masks);
>  
>  /**
>   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
> -- 
> 2.20.1

