Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201C9624CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKJVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKJVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C5BB4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668115104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyanxJQo8O8tyLYuJxAe30a/zahGnsdNcEvhKOiSFyw=;
        b=GHj2IYVmQweUEQVMVPxQ/Xq9qvByR6v/ySQ8P7X4VikW4TeIvFK4YZm6s85Y6QKiBVJKv8
        qvlVjbQQdPwkJ8K+hpEfN1a58rsbVFaUkzjheWFpCmmz7BqhY+j4JB43Pyyn1aOLtEyfbX
        SCeLgD1UkEAeaAoRY4Rlr2Hdi9ZwH1k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-LcYy-vYpOs6Ju_YOXTEf2g-1; Thu, 10 Nov 2022 16:18:23 -0500
X-MC-Unique: LcYy-vYpOs6Ju_YOXTEf2g-1
Received: by mail-ej1-f71.google.com with SMTP id hq18-20020a1709073f1200b007ade8dd3494so1902888ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyanxJQo8O8tyLYuJxAe30a/zahGnsdNcEvhKOiSFyw=;
        b=BwOKvQq2jAD8obaFwTcCaoeWP4jVtE4j2dWcFq46+h/zDY6rAj1tm+V0bwd6gYPTcu
         FpPA+C5nadz859wFn9XxlyucW51UlDaDKYKjbEbEHvo1HV0mh/D+6861fWgC4epBkt+/
         69nSJs54sCJmKjIGCMK5cJpyVyzUtpQxIVwN6xg7+5VQaoRiQ1Yt1SOCG0kAag/POn0/
         78R2gcZ5PvBgDLv5/6RY9qhsrGjb5DDUnmlm4eQ0NhZdKNprKD619gn0RE+vy4QOJz6h
         ZP2vnL3f8jB7ghzQd9Dy3ICv7WEBl93o06WXeVbsrCIJiL8/jR/FGaBm5OzQQhtN+T4p
         JFBA==
X-Gm-Message-State: ACrzQf0xv0hZcWlIxxYCpFioybz4SXv5LO3GSL4WErRIiMmujI9fNNZl
        WWefZlqu1m4EPDhEsbT5p31G0LikAsji0+p4yYLe9U+R11ST3kAeks4aQ3JyGyor6N/mjIQFlSG
        N0zmcESRMSb2t3+nInAvtZraE
X-Received: by 2002:a17:906:456:b0:78d:a01b:b474 with SMTP id e22-20020a170906045600b0078da01bb474mr3933787eja.8.1668115102168;
        Thu, 10 Nov 2022 13:18:22 -0800 (PST)
X-Google-Smtp-Source: AMsMyM53PNvGGxh9kTmc1lDCcu/Wa92QTRpwzY7HGiOC2LyH6DTM8Gozdbedc89+dWdIY0l8HUk55Q==
X-Received: by 2002:a17:906:456:b0:78d:a01b:b474 with SMTP id e22-20020a170906045600b0078da01bb474mr3933782eja.8.1668115101961;
        Thu, 10 Nov 2022 13:18:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id bc22-20020a056402205600b0045bccd8ab83sm322006edb.1.2022.11.10.13.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:18:21 -0800 (PST)
Message-ID: <ecf5632b-5fba-ad84-41be-a335b164809f@redhat.com>
Date:   Thu, 10 Nov 2022 22:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221107225323.2733518-11-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/22 23:53, Jithu Joseph wrote:
> The data portion of IFS test image file contains a metadata
> region containing possibly multiple metadata structures in
> addition to test data and hashes.
> 
> Introduce the layout of this meta_data structure and validate
> the sanity of certain fields of the new image before loading.
> 
> Tweak references to IFS test image chunks to reflect the updated
> layout of the test image.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/ifs/ifs.h  |  2 +
>  drivers/platform/x86/intel/ifs/load.c | 53 +++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 3ff1d9aaeaa9..98ca91bdd5ca 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -196,6 +196,7 @@ union ifs_status {
>   * @valid_chunks: number of chunks which could be validated.
>   * @status: it holds simple status pass/fail/untested
>   * @scan_details: opaque scan status code from h/w
> + * @cur_batch: number indicating the currently loaded test file
>   */
>  struct ifs_data {
>  	int	integrity_cap_bit;
> @@ -205,6 +206,7 @@ struct ifs_data {
>  	int	valid_chunks;
>  	int	status;
>  	u64	scan_details;
> +	int	cur_batch;
>  };
>  
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 7c0d8602817b..f361fd42a320 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -8,7 +8,23 @@
>  
>  #include "ifs.h"
>  
> +struct meta_data {
> +	unsigned int meta_type;		// metadata type
> +	unsigned int meta_size;		// size of this entire struct including hdrs.
> +	unsigned int test_type;		// IFS test type
> +	unsigned int fusa_info;		// Fusa info
> +	unsigned int total_images;	// Total number of images
> +	unsigned int current_image;	// Current Image #
> +	unsigned int total_chunks;	// Total number of chunks in this image
> +	unsigned int starting_chunk;	// Starting chunk number in this image
> +	unsigned int size_per_chunk;	// size of each chunk
> +	unsigned int chunks_per_stride;	// number of chunks in a stride
> +	unsigned int reserved[54];	// Align to 256 bytes for chunk alignment.
> +};
> +
>  #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
> +#define META_TYPE_IFS	1
> +#define IFS_CHUNK_ALIGNMENT	256
>  static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
>  static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
>  static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
> @@ -129,6 +145,40 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
>  	complete(&ifs_done);
>  }
>  
> +static int validate_ifs_metadata(struct device *dev)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	struct meta_data *ifs_meta;
> +	char test_file[64];
> +	int ret = -EINVAL;
> +
> +	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
> +		 boot_cpu_data.x86, boot_cpu_data.x86_model,
> +		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> +
> +	ifs_meta = (struct meta_data *)ifs_find_meta_data(ifs_header_ptr, META_TYPE_IFS);
> +	if (!ifs_meta) {
> +		dev_err(dev, "IFS Metadata missing in file %s\n", test_file);
> +		return ret;
> +	}
> +
> +	ifs_test_image_ptr = (u64)ifs_meta + sizeof(struct meta_data);
> +
> +	/* Scan chunk start must be 256 byte aligned */
> +	if (!IS_ALIGNED(ifs_test_image_ptr, IFS_CHUNK_ALIGNMENT)) {
> +		dev_err(dev, "Scan pattern offset is not 256 byte aligned in %s\n", test_file);
> +		return ret;
> +	}
> +
> +	if (ifs_meta->current_image != ifsd->cur_batch) {
> +		dev_warn(dev, "Mismatch between filename %s and batch metadata 0x%02x\n",
> +			 test_file, ifs_meta->current_image);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * IFS requires scan chunks authenticated per each socket in the platform.
>   * Once the test chunk is authenticated, it is automatically copied to secured memory
> @@ -145,6 +195,9 @@ static int scan_chunks_sanity_check(struct device *dev)
>  	if (!package_authenticated)
>  		return ret;
>  
> +	ret = validate_ifs_metadata(dev);
> +	if (ret)
> +		return ret;
>  
>  	ifsd->loading_error = false;
>  	ifsd->loaded_version = ifs_header_ptr->rev;

