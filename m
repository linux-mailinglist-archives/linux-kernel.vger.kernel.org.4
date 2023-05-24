Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436671019C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjEXXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEXXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA299
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684970200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rC3XkpEnMUlObPvlNdUAlZ18aG/csjAe3tOi92J9ZaU=;
        b=E9jrJXhjcnZ96GQCFFWlnaZalx6V88jGA6gp3yNZgYNK9g4GNPpRhgzOHZMiXSUq2mjPlC
        aa54/XkGTahVkyQpGekDIJmGh/C6OeCzvNuVuphtTa4VVF4t0Q9K5kPOWLpZ7TMVjBgrWF
        emhpCpPPjUxZeX6PdchbwkHmVUOlW40=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-VpcFTtnJNNiMGYfS2JSlJg-1; Wed, 24 May 2023 19:16:38 -0400
X-MC-Unique: VpcFTtnJNNiMGYfS2JSlJg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-624b4176bf7so3840726d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970198; x=1687562198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC3XkpEnMUlObPvlNdUAlZ18aG/csjAe3tOi92J9ZaU=;
        b=S7y04hBskocC0Wk/9KwqMLlAF7hmoKOSToplmlqE+pLhSv045NyG0XtqGbc1zfHeKP
         DasbCgjW4kBTJu7H2orqrji2gX1EifYAZLjEjFn8+pmFq9n9O5jlpY8yU2XYSCZDj8j4
         X2CpvYfhPc4MdNwoC3foOo0iJsZX0MhaIn1/9wPYW30mdLmEBvr8B9DlhmxoLdAXPIpL
         buQ8QmGCP15rKLZo40NxMtOtDjkgxJGL0/EWPmKtvvzZq7ZVRTLXl40wtxbSbT7MYJbG
         2dhOXF9QSYjeLGtRxx18/avIP8oHIW2hlXPU3AJd1OJQEJeiE0MMzapcaai2mcgmwz2l
         H/dg==
X-Gm-Message-State: AC+VfDw31LYG8ydYJsr4QLD74v6937UYsqCJ2MjJ6CyoiPDmhbwXNb8E
        X0qi08vgU9i3gdOeFsnmdhjF/zezMou6QOic/J2KfeX6zQ69oKYcrS+lXGKKt2lOo4VkUaySLQ7
        uFIKV+GgKo/fvCZ8l98cBzGxm
X-Received: by 2002:a05:6214:dcf:b0:625:aa1a:9382 with SMTP id 15-20020a0562140dcf00b00625aa1a9382mr4273621qvt.62.1684970198255;
        Wed, 24 May 2023 16:16:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WSD2NeAj9TDAefu6IIkB5TL7jFniPwvvPSMgXeGQRYxzvXw+kCPSskMJ4F4eBL2mTzQ6Ysg==
X-Received: by 2002:a05:6214:dcf:b0:625:aa1a:9382 with SMTP id 15-20020a0562140dcf00b00625aa1a9382mr4273603qvt.62.1684970198014;
        Wed, 24 May 2023 16:16:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bz16-20020ad44c10000000b00621253d19f9sm3909907qvb.98.2023.05.24.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:16:37 -0700 (PDT)
Date:   Wed, 24 May 2023 16:16:36 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 3/4] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Message-ID: <m3gasjgsxlggzsayurbzjaeiallxeobtggtzifnivqfyvexqn6@7rv7oumuq46x>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-4-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:44:08AM -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Tested-by: Coiby Xu <coxu@redhat.com>
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> v6:
>  - Add __init to get_kexec_buffer as suggested by Jonathan
> 
> v5:
>  - Rebased on Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
>    forward IMA measurement log on kexec"
> v4:
>  - Move debug output into setup_buffer()
> ---
>  drivers/of/kexec.c | 126 ++++++++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 1373d7e0a9b3..fa8c0c75adf9 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -117,45 +117,57 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>  }
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> -/**
> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> - * @addr:	On successful return, set to point to the buffer contents.
> - * @size:	On successful return, set to the buffer size.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +static int __init get_kexec_buffer(const char *name, unsigned long *addr,
> +				   size_t *size)
>  {
>  	int ret, len;
> -	unsigned long tmp_addr;
>  	unsigned long start_pfn, end_pfn;
> -	size_t tmp_size;
>  	const void *prop;
>  
> -	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> +	prop = of_get_property(of_chosen, name, &len);
>  	if (!prop)
>  		return -ENOENT;
>  
> -	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	ret = do_get_kexec_buffer(prop, len, addr, size);
>  	if (ret)
>  		return ret;
>  
> -	/* Do some sanity on the returned size for the ima-kexec buffer */
> -	if (!tmp_size)
> +	/* Do some sanity on the returned size for the kexec buffer */
> +	if (!*size)
>  		return -ENOENT;
>  
>  	/*
>  	 * Calculate the PFNs for the buffer and ensure
>  	 * they are with in addressable memory.
>  	 */
> -	start_pfn = PHYS_PFN(tmp_addr);
> -	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
> +	start_pfn = PHYS_PFN(*addr);
> +	end_pfn = PHYS_PFN(*addr + *size - 1);
>  	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
> -		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
> -			tmp_addr, tmp_size);
> +		pr_warn("%s buffer at 0x%lx, size = 0x%zx beyond memory\n",
> +			name, *addr, *size);
>  		return -EINVAL;
>  	}
>  
> +	return 0;
> +}
> +
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +
> +	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
>  	*addr = __va(tmp_addr);
>  	*size = tmp_size;
>  
> @@ -188,72 +200,82 @@ int __init ima_free_kexec_buffer(void)
>  }
>  #endif
>  
> -/**
> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> - *
> - * @fdt: Flattened Device Tree to update
> - * @chosen_node: Offset to the chosen node in the device tree
> - *
> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> - * remove it from the device tree.
> - */
> -static void remove_ima_buffer(void *fdt, int chosen_node)
> +static int remove_buffer(void *fdt, int chosen_node, const char *name)
>  {
>  	int ret, len;
>  	unsigned long addr;
>  	size_t size;
>  	const void *prop;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> -		return;
> -
> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> +	prop = fdt_getprop(fdt, chosen_node, name, &len);
>  	if (!prop)
> -		return;
> +		return -ENOENT;
>  
>  	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> +	fdt_delprop(fdt, chosen_node, name);
>  	if (ret)
> -		return;
> +		return ret;
>  
>  	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
>  	if (!ret)
> -		pr_debug("Removed old IMA buffer reservation.\n");
> +		pr_debug("Remove old %s buffer reserveration", name);
> +	return ret;
>  }
>  
> -#ifdef CONFIG_IMA_KEXEC
>  /**
> - * setup_ima_buffer - add IMA buffer information to the fdt
> - * @image:		kexec image being loaded.
> - * @fdt:		Flattened device tree for the next kernel.
> - * @chosen_node:	Offset to the chosen node.
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>   *
> - * Return: 0 on success, or negative errno on error.
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> + * remove it from the device tree.
>   */
> -static int setup_ima_buffer(const struct kimage *image, void *fdt,
> -			    int chosen_node)
> +static void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return;
> +
> +	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
> +}
> +
> +#ifdef CONFIG_IMA_KEXEC
> +static int setup_buffer(void *fdt, int chosen_node, const char *name,
> +			phys_addr_t addr, size_t size)
>  {
>  	int ret;
>  
> -	if (!image->ima_buffer_size)
> +	if (!size)
>  		return 0;
>  
>  	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> -				       "linux,ima-kexec-buffer",
> -				       image->ima_buffer_addr,
> -				       image->ima_buffer_size);
> +				       name, addr, size);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
> -			      image->ima_buffer_size);
> +	ret = fdt_add_mem_rsv(fdt, addr, size);
>  	if (ret)
>  		return -EINVAL;
>  
> -	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
> -		 &image->ima_buffer_addr, image->ima_buffer_size);
> +	pr_debug("%s at 0x%pa, size = 0x%zx\n", name, &addr, size);
>  
>  	return 0;
> +
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int setup_ima_buffer(const struct kimage *image, void *fdt,
> +			    int chosen_node)
> +{
> +	return setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
> +			    image->ima_buffer_addr, image->ima_buffer_size);
>  }
>  #else /* CONFIG_IMA_KEXEC */
>  static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> -- 
> 2.38.1
> 

