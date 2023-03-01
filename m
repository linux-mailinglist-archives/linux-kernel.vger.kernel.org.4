Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2CD6A6E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCAOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB3E4346E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677681612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUe84QSOVYverBpq1niZlZhICIXFK69PLbV0XFl4JEU=;
        b=G0lDtyJvBNYX56skDKwy94BXXhm2hdHqR5efEyfzgs2X0L+3buAKEFEKFwq+YwslccVr16
        sKZFva4GxWywnG2w6gQ1L1smdCgX7154JA8931sKwJ70STT1taCTS2edGCvzx24MhzLBCZ
        4BIUZXkyTIc4bXPYIgOJF7GygtPsPHo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-SuSPdDRWNFuP4cytxhBfGw-1; Wed, 01 Mar 2023 09:40:11 -0500
X-MC-Unique: SuSPdDRWNFuP4cytxhBfGw-1
Received: by mail-ed1-f71.google.com with SMTP id dn8-20020a05640222e800b004bd35dd76a9so2225995edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUe84QSOVYverBpq1niZlZhICIXFK69PLbV0XFl4JEU=;
        b=SnvgZegd2hbE6pV42m336vT2IRh2kf3sgLFBzQ2f07gTLP1FHMnK8FrQ4wVu+t1utP
         B9SRIvtpA9Sqzm9djI6hO2XXo3nXE3IIPsyXE9+UkMutpmT+mevRpupi2uHEhhepBsf6
         IQE0gmxktsjPvHJUJWT1XVDx5WaSzp4qw07ehZXAKNDVAs6/o4yimKqLP6hbtzg3gbAq
         YlpKpNxrrjIOMdL86YSujyYarTt3+yObK8/wj21gwBL4fG6zqPH30b4R2k0Wcf4K/wiS
         yX9gRvkeDIFWURreMjlNSic4QTGwE4ehUyv/crH9uHpM4woPC6E38wkAW7ntgwjQ1x98
         peug==
X-Gm-Message-State: AO0yUKWYWWZLUrqw87NqQvIk0c0zv7957na0nTIn01e3yITLgv6s0KAB
        EWsMOOG+Z98f9kCFXORDjwMtRaOFZvUAmGi8f/6dCNOhVzMlZarPTk0KwKIiwJoecrbysHKV6ul
        XYfDRdVziDmtfqDd96Vh+ZnUu
X-Received: by 2002:a17:906:7388:b0:87b:7c1d:e02b with SMTP id f8-20020a170906738800b0087b7c1de02bmr6791851ejl.36.1677681609832;
        Wed, 01 Mar 2023 06:40:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8rY5wbw5ky+nn2/yCUAwhQkuYV4x9SsI264LFcCqMzD7Rt9yOQXfbo87zvMm1VEOUGhw1GMQ==
X-Received: by 2002:a17:906:7388:b0:87b:7c1d:e02b with SMTP id f8-20020a170906738800b0087b7c1de02bmr6791830ejl.36.1677681609509;
        Wed, 01 Mar 2023 06:40:09 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090798c500b008c0b8dd4cbdsm5873065ejc.112.2023.03.01.06.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:40:08 -0800 (PST)
Message-ID: <bba19fc3-0cbc-7829-6721-7d84ac4d9136@redhat.com>
Date:   Wed, 1 Mar 2023 15:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 12/12] platform/x86: ISST: Add suspend/resume callbacks
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-13-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211063257.311746-13-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/23 07:32, Srinivas Pandruvada wrote:
> To support S3/S4 with TPMI interface add suspend/resume callbacks.
> Here HW state is stored in suspend callback and restored during
> resume callback.
> 
> The hardware state which needs to be stored/restored:
> - CLOS configuration
> - CLOS Association
> - SST-CP enable/disable status
> - SST-PP perf level setting
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../x86/intel/speed_select_if/isst_tpmi.c     | 21 ++++++++
>  .../intel/speed_select_if/isst_tpmi_core.c    | 49 +++++++++++++++++++
>  .../intel/speed_select_if/isst_tpmi_core.h    |  2 +
>  3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> index 7b4bdeefb8bc..ef39870c9829 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> @@ -34,6 +34,24 @@ static void intel_sst_remove(struct auxiliary_device *auxdev)
>  	tpmi_sst_exit();
>  }
>  
> +static int __maybe_unused intel_sst_suspend(struct device *dev)
> +{
> +	tpmi_sst_dev_suspend(to_auxiliary_dev(dev));
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused intel_sst_resume(struct device *dev)
> +{
> +	tpmi_sst_dev_resume(to_auxiliary_dev(dev));
> +
> +	return 0;
> +}

Please drop the __maybe_unused here; and

> +
> +static const struct dev_pm_ops intel_sst_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(intel_sst_suspend, intel_sst_resume)
> +};
> +

Replace this with:

static DEFINE_SIMPLE_DEV_PM_OPS(intel_sst_pm, intel_sst_suspend, intel_sst_resume);

>  static const struct auxiliary_device_id intel_sst_id_table[] = {
>  	{ .name = "intel_vsec.tpmi-sst" },
>  	{}
> @@ -44,6 +62,9 @@ static struct auxiliary_driver intel_sst_aux_driver = {
>  	.id_table       = intel_sst_id_table,
>  	.remove         = intel_sst_remove,
>  	.probe          = intel_sst_probe,
> +	.driver = {
> +		.pm = &intel_sst_pm,

And use:

		.pm = pm_sleep_ptr(&intel_sst_pm),


Here, this is the new #ifdef and __maybe_unused free way of dealing with pm_ops.

Regards,

Hans


> +	},
>  };
>  
>  module_auxiliary_driver(intel_sst_aux_driver);
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 9eaff90bb649..e173167085ea 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -229,6 +229,10 @@ struct perf_level {
>   * @status_offset:	Store the status offset for each PP-level
>   * @sst_base:		Mapped SST base IO memory
>   * @auxdev:		Auxiliary device instance enumerated this instance
> + * @saved_sst_cp_control: Save SST-CP control configuration to store restore for suspend/resume
> + * @saved_clos_configs:	Save SST-CP CLOS configuration to store restore for suspend/resume
> + * @saved_clos_assocs:	Save SST-CP CLOS association to store restore for suspend/resume
> + * @saved_pp_control:	Save SST-PP control information to store restore for suspend/resume
>   *
>   * This structure is used store complete SST information for a power_domain. This information
>   * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
> @@ -250,6 +254,10 @@ struct tpmi_per_power_domain_info {
>  	struct pp_status_offset status_offset;
>  	void __iomem *sst_base;
>  	struct auxiliary_device *auxdev;
> +	u64 saved_sst_cp_control;
> +	u64 saved_clos_configs[4];
> +	u64 saved_clos_assocs[4];
> +	u64 saved_pp_control;
>  };
>  
>  /**
> @@ -1333,6 +1341,47 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
>  
> +void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
> +{
> +	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
> +	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
> +	void __iomem *cp_base;
> +
> +	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
> +	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
> +
> +	memcpy_fromio(power_domain_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
> +		      sizeof(power_domain_info->saved_clos_configs));
> +
> +	memcpy_fromio(power_domain_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
> +		      sizeof(power_domain_info->saved_clos_assocs));
> +
> +	power_domain_info->saved_pp_control = readq(power_domain_info->sst_base +
> +						    power_domain_info->sst_header.pp_offset +
> +						    SST_PP_CONTROL_OFFSET);
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, INTEL_TPMI_SST);
> +
> +void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
> +{
> +	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
> +	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
> +	void __iomem *cp_base;
> +
> +	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
> +	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
> +
> +	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, power_domain_info->saved_clos_configs,
> +		    sizeof(power_domain_info->saved_clos_configs));
> +
> +	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, power_domain_info->saved_clos_assocs,
> +		    sizeof(power_domain_info->saved_clos_assocs));
> +
> +	writeq(power_domain_info->saved_pp_control, power_domain_info->sst_base +
> +				power_domain_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, INTEL_TPMI_SST);
> +
>  #define ISST_TPMI_API_VERSION	0x02
>  
>  int tpmi_sst_init(void)
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> index 356cb02273b1..900b483703f9 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> @@ -13,4 +13,6 @@ int tpmi_sst_init(void);
>  void tpmi_sst_exit(void);
>  int tpmi_sst_dev_add(struct auxiliary_device *auxdev);
>  void tpmi_sst_dev_remove(struct auxiliary_device *auxdev);
> +void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev);
> +void tpmi_sst_dev_resume(struct auxiliary_device *auxdev);
>  #endif

