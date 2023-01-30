Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031B68201A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjA3Xx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjA3Xxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD1302AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675122766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKD7Ng7UvAzKLXBrUaimEwRxHK+MyuacubW4mg2URxg=;
        b=Lw7cWDGf4RP42Ks5PVWsln72yGIy4TEA6LiN9TlHEGCYJLJg+53KCYgtb/NZ8N2iDHT/Bu
        RdrDD2/YP5XcYt9NVdpWTGWG+Nnz3ngRcBYZJo//Aivee3whWovQl3vqulZwnzZ/YdKzfj
        sDoSyNKfp5AH97dBmlEd1l62FvCzgSY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-2rJKTKY_P3aa_8eM-hlCsA-1; Mon, 30 Jan 2023 18:52:45 -0500
X-MC-Unique: 2rJKTKY_P3aa_8eM-hlCsA-1
Received: by mail-il1-f200.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so8312557ilu.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKD7Ng7UvAzKLXBrUaimEwRxHK+MyuacubW4mg2URxg=;
        b=NeQrDbJdDwZhSrYKPKdH3DT3Pk5GGL5X/eR6Gnnkcua4a36J53RWu+QG3ZQbslIlvS
         pkne2Fhcfbfzx19fldSUB33tv53M15yeVo2Vd53oTeC8B8MJyEWjAXinRNjz34RYQuZO
         5LmQxvPO4VwHlNvuLa3IgKAivl5HAlbAaAQGA5pmUdXgDl3WGLQpl6A1OBOOMLnIlcyL
         MawAcMgXdoBw/KMHg020N1ngk7e0bgtK1r80tCNj2D0c3Y19JR2fSozcG/pexCKJXxm9
         bEGMGJyAAaUDvgsshVPn3+E7OJ2hPmqDi40nojsfxaWChB7fAMEOoIhZ5kN+QgQDv4+H
         hdlw==
X-Gm-Message-State: AO0yUKW+Gmv8KZwQLD3121kbwfaA85SKV1JCyo14BVkVcTgALhv4Ubas
        lVreEBxiwpk13UTYlFMq/AZNx1++spbs+pG/2+7AejAtYpe9ZgD+uD8L6TTvr41tRN9sGgQvPc6
        gf6aFSY+AJVEKZjGxtFRJBtJd
X-Received: by 2002:a05:6e02:1aa2:b0:310:8399:1509 with SMTP id l2-20020a056e021aa200b0031083991509mr22217143ilv.18.1675122764651;
        Mon, 30 Jan 2023 15:52:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+SYPzk/v2QyO4PU/9yKnGirV3bDuYR4HmA3IJ5hh/xidJibQ3xrKIEMlyAVnxfFdEcqRtuEQ==
X-Received: by 2002:a05:6e02:1aa2:b0:310:8399:1509 with SMTP id l2-20020a056e021aa200b0031083991509mr22217130ilv.18.1675122764420;
        Mon, 30 Jan 2023 15:52:44 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x15-20020a0566380caf00b003a958069dbfsm5121053jad.8.2023.01.30.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:43 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:52:43 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <ye.xingchen@zte.com.cn>
Cc:     <akrowiak@linux.ibm.com>, <rostedt@goodmis.org>, <jgg@ziepe.ca>,
        <gregkh@linuxfoundation.org>, <mhiramat@kernel.org>,
        <ojeda@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples: fix the prompt about SAMPLE_VFIO_MDEV_MBOCHS
Message-ID: <20230130165243.7d50125c.alex.williamson@redhat.com>
In-Reply-To: <202301301013518438986@zte.com.cn>
References: <202301301013518438986@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Mon, 30 Jan 2023 10:13:51 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Change the prompt about SAMPLE_VFIO_MDEV_MBOCHS as
> 'Build VFIO mbochs example mediated device sample code'.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  samples/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 56b191d128d8..1b49f99f3074 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -208,7 +208,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
>  	  Guest fbdev driver for the virtual display sample driver.
> 
>  config SAMPLE_VFIO_MDEV_MBOCHS
> -	tristate "Build VFIO mdpy example mediated device sample code"
> +	tristate "Build VFIO mbochs example mediated device sample code"
>  	select VFIO_MDEV
>  	select DMA_SHARED_BUFFER
>  	help

Applied to vfio next branch for v6.3.  Thanks,

Alex

