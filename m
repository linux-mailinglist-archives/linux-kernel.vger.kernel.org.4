Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB53626186
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKSme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiKKSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:42:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0558960C;
        Fri, 11 Nov 2022 10:39:59 -0800 (PST)
Received: from zn.tnic (p200300ea9733e727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72C771EC0426;
        Fri, 11 Nov 2022 19:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668191998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CEslD/HvCx/SdG3211ZORSEWq/uAhGzfrIhYSSxCqGk=;
        b=PzswiiCra/SijzV9WnUy3rSxqXjK3d0axtSgBLPPJrkvDLpvDulmkhoiedcRbyFzzrvRc4
        1v9esP2Rit7qs0tMswHs+1ilOowBGwa0f6H8Y2HMZOkO3tavLwooJBbDHy3DN7GBddvDkU
        FncfnvAGRiqXnlVSIUtJ7nsl6OcaAiY=
Date:   Fri, 11 Nov 2022 19:39:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Message-ID: <Y26W+emSSL5Xik0G@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107225323.2733518-11-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:19PM -0800, Jithu Joseph wrote:
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

That looks weird.

__packed and __aligned doesn't work?

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

	" ... is not aligned on %d bytes...\n", test_file, IFS_CHUNK_ALIGNMENT);

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

Right, if you return here because validate_ifs_metadata() failed for
whatever reason, you leak package_authenticated. That's why, as I said
earlier, you should just use a stack variable where you simply set a
bit. A bitmask or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
