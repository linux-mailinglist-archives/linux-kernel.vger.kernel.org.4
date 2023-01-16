Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90766BD20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAPLqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjAPLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:46:40 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84791166E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:46:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so42344826lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2OdVCxscFBwkj+WHQvDCT4AfcJ0wsNcveu9dJ6prnw=;
        b=aUmQL0Rs3d2DzgO79BFrfqkvipGhdBdlKzfd7auWKvFmBGOfKG+BFjEAZWrdlEQTw8
         wYAcp8P/PWBak2lFktCPcHpJ9VYcf0t4dJBZd9kwKkJEHoYhq61QoopHbkFxA9GR3hmM
         mPhqgmNNWqDFZBID5zR1Au2vijb3xJmDXcdO6y9wUuAXYuKJgYIOPDtRc6o5+g9KLAvt
         kMsONe0GDMhgEkpXZRVl2XqpbiiIduxHWSWRGW3dWuLnVMIyL8kVTASM5Rnt6T/Uz80a
         Tm+AVc9e1q8fdCpbZ4nboMCZaTDFQH4BhLC6wa1p4Z5vksvx/jajzY4e2YMHd0bm+OQv
         I4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2OdVCxscFBwkj+WHQvDCT4AfcJ0wsNcveu9dJ6prnw=;
        b=wiazKgjehhvATtu/TRVpwldvvIWC29Xrx9qeyF7VxZ98+UifLQ0WSqdZVDkn+8gga/
         oUXDuockVcleGsBUIZNIYoKEFlrszFGpGP4kfzMribetf1KFzBGYZAaUOkwnV6pclWH1
         fZ+6iO9psetKFSQtqWOQE2B0IIhuV9LVbKLDX+8+4r0zkhvXqdLLyQioCyMJ3FRi59PQ
         NkbVRrMhDdY43koNG0fiHiIF6Vdjo2vBxEzIGPTjwGo/QqfLls9SwdExUFhaxc/nipK+
         yf3rCb+DEbVSz8sTet3g2Rg0nwCnQNAIs8Y2ed9KFA4bsAg+cRxQ1GzCHj7c0Og403kh
         1TeA==
X-Gm-Message-State: AFqh2kpHKArShcDBxxt9PJsNt7m82DyJWDyedh9TxEY9v9crnPmvu3Hj
        /ywvNc0iHsbw08N4mtiBcBo=
X-Google-Smtp-Source: AMrXdXsGJLfyATdXtlbR2UPnlJJ/t1q3z5q8W/hrnl+Ksa6A4k7xOXUkr7nONOdfQSqmAXOc5hbOHw==
X-Received: by 2002:a19:f607:0:b0:4d2:a821:5f1c with SMTP id x7-20020a19f607000000b004d2a8215f1cmr2615405lfe.3.1673869597734;
        Mon, 16 Jan 2023 03:46:37 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id k6-20020a05651c10a600b00287d9d49939sm2388853ljn.81.2023.01.16.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:46:37 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:46:34 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 6/7] powerpc: mm: add VM_IOREMAP flag to the vmalloc
 area
Message-ID: <Y8U5GmaI4l3koYV8@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-7-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:20AM +0800, Baoquan He wrote:
> Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
> specific alignment clamping in __get_vm_area_node(), they will be
>  1) Shown as ioremap in /proc/vmallocinfo;
>  2) Ignored by /proc/kcore reading via vread()
> 
> So for the io mapping in ioremap_phb() of ppc, we should set VM_IOREMAP
> in flag to make it handled correctly as above.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/powerpc/kernel/pci_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 0c7cfb9fab04..fd42059ae2a5 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -132,7 +132,7 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
>  	 * address decoding but I'd rather not deal with those outside of the
>  	 * reserved 64K legacy region.
>  	 */
> -	area = __get_vm_area_caller(size, 0, PHB_IO_BASE, PHB_IO_END,
> +	area = __get_vm_area_caller(size, VM_IOREMAP, PHB_IO_BASE, PHB_IO_END,
>  				    __builtin_return_address(0));
>  	if (!area)
>  		return NULL;
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
