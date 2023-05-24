Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211CE710130
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjEXW5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEXW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731090
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684968986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
        b=YK+qnrCTP8ByBFJjvr6gI48dutejVK7ZpLhAb2iwEcqMLQB1NPA6OY39gDHe8CZcc7dcW4
        PTpJnPlW/Skhsn7+A8ILvHzsyvbu71uynHkJl9+Kzwt6IZLwxtkuTMxib8ZF55FVoHLjDI
        0pvY95F6wjl3e9K1B66M1rajjsRM9NE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-lcfbXe-_MfK4rYzSfbZ6sA-1; Wed, 24 May 2023 18:56:24 -0400
X-MC-Unique: lcfbXe-_MfK4rYzSfbZ6sA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f52eb10869so6282751cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968984; x=1687560984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Jcq95wsHIqLNg9wbmmJlT15+6EzUdpG8ilf/jMgQ8=;
        b=fwpKj1SRqTwvZWJoKMnoGmD60CXNxiTcBm+LF50P1dcW1DgmZFbVE9WmU5p3iBB+iT
         Jo8LA3xUgrg+MMQZyOjOQh5+0eASSnfcWOWEOhi3+KhJYIThHE7YxXbk8Jiq5fukm2Yv
         ZppOrbbBoPPoM1c2jPYkl3a3R2rvrE3qgVUDMyR9B3Kp0DgMyaIoiQbpit3gqbkyZsQt
         yhlkz2mlJNa//d6yvReCvetA91Gm/9At+NXmVBd604KLJtiw1CowuRDh9/0v5hUy6Rf8
         +HTUGCa3ygV1Dw1m4fqdiEO8w9UBu2Ws8SeaJdsX98YW9lXWYDBmk+LYhSPc1MZy1QJi
         URZQ==
X-Gm-Message-State: AC+VfDwSkwEKHNqaHCCGdX/0yXm6NaKpyNGTwzsCa51A9XUonXmz2cDW
        6aCBgnaYsMW761Y802IljlwuZbB29SUMTJFY6FOeyp1ehWiwCL0XmLHIx28I7jm+o4w+bsD9A9d
        VKKxQkMZHDpSbS75kqKOOmXxd
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325804qtv.64.1684968984358;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YIOLa22uHsyvn/hEoIII2YehPLAhvw1u1EoIWqYO1cyYh5aCnNjvQkCcKdtrNBcB8QhnYhA==
X-Received: by 2002:ac8:7c54:0:b0:3f6:b7a3:8450 with SMTP id o20-20020ac87c54000000b003f6b7a38450mr11325796qtv.64.1684968984135;
        Wed, 24 May 2023 15:56:24 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a010700b003f6a8379fa4sm3555602qtw.70.2023.05.24.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:56:23 -0700 (PDT)
Date:   Wed, 24 May 2023 15:56:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v9 1/4] drivers: of: kexec ima: Support 32-bit platforms
Message-ID: <a2dx66ug4gnbokit35in5c2qjsq2fcewtw35bwknnsav4pw2ee@c3s4wsbszeyb>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-2-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:44:06AM -0400, Stefan Berger wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> RISC-V recently added kexec_file() support, which uses enables kexec
> IMA.  We're the first 32-bit platform to support this, so we found a
> build bug.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/of/kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..1373d7e0a9b3 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -250,8 +250,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> -		 image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> +		 &image->ima_buffer_addr, image->ima_buffer_size);
>  
>  	return 0;
>  }
> -- 
> 2.38.1
> 

