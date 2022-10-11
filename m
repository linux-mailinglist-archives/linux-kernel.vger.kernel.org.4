Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117E45FBC99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJKVBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE4594135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665522098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+avVcnv70NWKcf9LkbwIbLGyy/FiaOAFyFBBxc5L0mg=;
        b=G+LbQgb04gicXElzH7aAysipBMcBP7IQRp6xPJPGWVm2bEr4rD6moFXk0NERB8P7FbP2N8
        qCYLkAGlflfhJYOMyyzdWtPUvsjJXij8BzewNTXUXx3xRi7Fbl1IvsUw7kXFdlo/TfnX4g
        9Qe6fW0smIeSdq8WDSE6RrnkjH6AKjk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-HPrN-kP7OLeUppY8enDuIw-1; Tue, 11 Oct 2022 17:01:37 -0400
X-MC-Unique: HPrN-kP7OLeUppY8enDuIw-1
Received: by mail-wm1-f70.google.com with SMTP id r132-20020a1c448a000000b003c3a87d8abdso6099944wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 14:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+avVcnv70NWKcf9LkbwIbLGyy/FiaOAFyFBBxc5L0mg=;
        b=cBXn7WZhcjxPwZfgWPGzq25Z/7tJ29XNnM50b24U8pyI4ekbKwDETdZ7hh1YapYvr4
         XAhEjp62AXSaiXG39Ekzsb657G6Oui4fZy0Ak/u1X/eA6iFH08y6UJw/b+BKBlsJHv5y
         86+5Z+wW3/w8Vnu+oGPDjjHHuy9mOV/D9aODZ6lX7eUI4Ckt2YRG3oF/HYwcG75joGBt
         8E2FY8pejAZ4AzMKNlCdyTlA0Xr8h251cQlKUjljLwW37DZqFP/R4m873C6nokDT1H1i
         13BrPktWri1OqOWdq/5U3M1ucBvWGDCw9RgZchfXXSeU0fw8JgEYJGLyi+AHcbPIhk+y
         E9HQ==
X-Gm-Message-State: ACrzQf1LOr5rIL700YzDPb35A5gHiSlKlYHjSGk0XSL4qMz+jJpkx1Y5
        87ziSE7rN/fpGC+u/cx5pWD3fiU9ovHXILqaqgO+6dhQ2s8x3XmsHIlAgy1VXPWXWaCj/6ceHlK
        ofdP4E0Rmjn4RRVRqLqLVi6jdGV2qu2li1nuEzJlkictYNlmStfMMG+WiEedTsmgV8B562g==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id u1-20020a5d6da1000000b00231c189e077mr1759310wrs.114.1665522093747;
        Tue, 11 Oct 2022 14:01:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4G5KpCt5HabCJPqECVt2VlLGntyZA6wlIwgpZa4/dWB/N71V/3QuGifG/JsGyxjQryAPV/Ow==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id u1-20020a5d6da1000000b00231c189e077mr1759294wrs.114.1665522093426;
        Tue, 11 Oct 2022 14:01:33 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id r16-20020adff710000000b0022afbd02c69sm11871911wrp.56.2022.10.11.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:01:32 -0700 (PDT)
Date:   Tue, 11 Oct 2022 17:01:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221011170037-mutt-send-email-mst@kernel.org>
References: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009191835.4036-1-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:12:20PM -0400, Michael S. Tsirkin wrote:
> virtio uses the same driver for VFs and PFs.  Accordingly,
> pci_device_is_present is used to detect device presence. This function
> isn't currently working properly for VFs since it attempts reading
> device and vendor ID. Result is device marked broken incorrectly.  As
> VFs are present if and only if PF is present, just return the value for
> that device.
> 
> Reported-by: gongwei <gongwei833x@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> Warning - compile tested only. gongwei could you help test and report
> please?


Just got a report in private email that it was tested and works well.
Will repost as non-RFC now.


>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..ba29b8e2f3c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
>  
> +	if (pdev->is_virtfn)
> +		return pci_device_is_present(pdev->physfn);
> +
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
>  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> -- 
> MST

