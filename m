Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FD62DD58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiKQN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiKQN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647856EC5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668693317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VU4C6CmS9harcFa62LfE5qAVlu8HjoUDGoNd41Mn+o=;
        b=bJRC4xJoBOQhPIwQG6fYbuMLyzJxtzCQzf7x12h0EBIUDxEG8R3ai9jIJmLc+9EoDyHe+z
        GiaZumRjIZHxvdoHSrf4RE7qJTQGtlRRDE3JmzTkTj2f8C/NdpJG1yFR5BGtNCESjZrZh/
        7dZ6As+eB6cltpEASRwkxDHu5/Zb7vM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-e9DXrdAIOTG7-gJQQkkI4g-1; Thu, 17 Nov 2022 08:55:16 -0500
X-MC-Unique: e9DXrdAIOTG7-gJQQkkI4g-1
Received: by mail-ej1-f71.google.com with SMTP id jg27-20020a170907971b00b007ad9892f5f6so1147186ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VU4C6CmS9harcFa62LfE5qAVlu8HjoUDGoNd41Mn+o=;
        b=hICQCyGWEXgUeTVsvUlggKdxaPKjP3ZRryW602I+e2l6Q+QYtn6sVk+ebXNTa5zSc+
         a28fpHku4HiEj0EzqzyKSjko6/soRgzP30flSMm5rqw+BDO+A/qfdJ2ejgVWU9EAcxD+
         8x0dzlFkzon17FJewyUE5AHdqziHNvoSmM8t1XSIeFI3ugqDBbPB3QHoOgo0Tl8Ph+dp
         EMoN80bbKMdKQLN/tTselmFwb6ItWIsO3ktgkWk6jXjQN0gLVI47nj0iK4FYYv78+FRL
         ILXajH74zJ1VrxjmboHhdPmh3ilA/V/SyQV7Voz/VxU+PCOhE9b6On1Z7Ztbd+q+Op2J
         6V3A==
X-Gm-Message-State: ANoB5pldIcZEZDuxThYlWuH7uYAm5bC7i+MP9anFw0vEeYEUwAG3F5K0
        MOsUeN2pjFBHCL5aHfXa/cyWWY/b+pmMZGnJtAj39IS92y/Q0uw2dKtDftGMzdtES0KG/ykuSmY
        wT4FlwuckPa9i9xhKMfDVcbCL
X-Received: by 2002:aa7:cc14:0:b0:468:58d4:a10e with SMTP id q20-20020aa7cc14000000b0046858d4a10emr2285473edt.222.1668693315272;
        Thu, 17 Nov 2022 05:55:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4N92CIy25ejHeBQGzRcvXfCxvshvEL1ipcU/1azPUfJWY7a2uW9qv8qKVoXeIHglqEkaXy+A==
X-Received: by 2002:aa7:cc14:0:b0:468:58d4:a10e with SMTP id q20-20020aa7cc14000000b0046858d4a10emr2285460edt.222.1668693315116;
        Thu, 17 Nov 2022 05:55:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id n24-20020a05640204d800b00458dc7e8ecasm562896edw.72.2022.11.17.05.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:55:14 -0800 (PST)
Message-ID: <11af2739-e5f6-2c61-8451-13f19025d4d3@redhat.com>
Date:   Thu, 17 Nov 2022 14:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 8/9] tools/arch/x86: intel_sdsi: Add support for new GUID
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-9-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-9-david.e.box@linux.intel.com>
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

On 11/1/22 20:10, David E. Box wrote:
> The structure and content of the On Demand registers is based on the GUID
> which is read from hardware through sysfs. Add support for decoding the
> registers of a new GUID 0xF210D9EF.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 32 ++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 01b5f9994e11..0680eda78b1a 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -35,7 +35,8 @@
>  #define SDSI_DEV		"intel_vsec.sdsi"
>  #define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
>  #define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
> -#define GUID			0x6dd191
> +#define GUID_V1			0x6dd191
> +#define GUID_V2			0xF210D9EF
>  #define REGISTERS_MIN_SIZE	72
>  #define STATE_CERT_MAX_SIZE	4096
>  #define STATE_MAX_NUM_LICENSES	16
> @@ -100,9 +101,17 @@ struct sdsi_regs {
>  	struct availability prov_avail;
>  	struct nvram_update_limit limits;
>  	uint64_t pcu_cr3_capid_cfg;
> -	uint64_t socket_id;
> +	union {
> +		struct {
> +			uint64_t socket_id;
> +		} v1;
> +		struct {
> +			uint64_t reserved;
> +			uint64_t socket_id;
> +			uint64_t reserved2;
> +		} v2;
> +	} extra;
>  };
> -
>  #define CONTENT_TYPE_LK_ENC		0xD
>  #define CONTENT_TYPE_LK_BLOB_ENC	0xE
>  
> @@ -146,7 +155,7 @@ struct sdsi_dev {
>  	struct state_certificate sc;
>  	char *dev_name;
>  	char *dev_path;
> -	int guid;
> +	uint32_t guid;
>  };
>  
>  enum command {
> @@ -199,7 +208,7 @@ static int sdsi_update_registers(struct sdsi_dev *s)
>  		return -1;
>  	}
>  
> -	if (s->guid != GUID) {
> +	if (s->guid != GUID_V1 && s->guid != GUID_V2) {
>  		fprintf(stderr, "Unrecognized guid, 0x%x\n", s->guid);
>  		fclose(regs_ptr);
>  		return -1;
> @@ -207,7 +216,7 @@ static int sdsi_update_registers(struct sdsi_dev *s)
>  
>  	/* Update register info for this guid */
>  	ret = fread(&s->regs, sizeof(uint8_t), sizeof(s->regs), regs_ptr);
> -	if (ret != sizeof(s->regs)) {
> +	if (ret > (int)sizeof(s->regs)) { /* FIXME: Check size by guid */

This is wrong, fread will never return more then requested, that
would lead to buffer overflows. But it may return 0 on errors, or
a short read on an error.

So you need to fix the FIXME comment you added here as now you
have just disabled all error checking.

Regards,

Hans



>  		fprintf(stderr, "Could not read 'registers' file\n");
>  		fclose(regs_ptr);
>  		return -1;
> @@ -252,10 +261,13 @@ static int sdsi_read_reg(struct sdsi_dev *s)
>  	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
>  	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
>  	printf("NVRAM Udate Limit\n");
> -	printf("    50%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
> -	printf("    75%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
> -	printf("    90%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
> -	printf("Socket ID:                      %ld\n", s->regs.socket_id & 0xF);
> +	printf("    50%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
> +	printf("    75%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
> +	printf("    90%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
> +	if (s->guid == GUID_V1)
> +		printf("Socket ID:                      %ld\n", s->regs.extra.v1.socket_id & 0xF);
> +	else
> +		printf("Socket ID:                      %ld\n", s->regs.extra.v2.socket_id & 0xF);
>  
>  	return 0;
>  }

