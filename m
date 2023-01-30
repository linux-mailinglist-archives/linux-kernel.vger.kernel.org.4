Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D581B680E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjA3NIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjA3NID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41535AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675084037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhuuL4VJtt9u4xrt/8UaIaAI26VYNj4ZGP0qPBQSDMo=;
        b=Deghtt9Jyiz/eV7saC0SoQSgd1/MZ/m3nwt8SFeIE6VpEIIIDTgwm2US9X2FATTU2w8X61
        LJPOtw3CdW6uHzLewpFQk7TzOwtzQ6uqc1OJsWKyS+j/yjJOayu5H/qqISfVph98k4Q1Cq
        b/Z+3rOsBqRRBPpR0FpFQHLVxd52e0w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-bXIP14TjPiS4GT74cC-s1A-1; Mon, 30 Jan 2023 08:07:13 -0500
X-MC-Unique: bXIP14TjPiS4GT74cC-s1A-1
Received: by mail-ed1-f70.google.com with SMTP id s26-20020a056402037a00b004a25c2875d6so386426edw.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhuuL4VJtt9u4xrt/8UaIaAI26VYNj4ZGP0qPBQSDMo=;
        b=YKHaumz/KoW+DRzrJ9VpqKPhxm26yBrJDB8pcQn2RMUxQwdhISdNo8HlZcJl30pQM1
         N+85m8qhmjgzIwr8SxniryZZDWHK6uvsQIuQW+VF0sjpRr6b9bdbEOJnxCDzxJtrDDtM
         wd71ZX0OcHlkZ/lgflaA06tueBV1jxywGfMW+X/AitkjQ0JYNxmnXOPA5b5cPaYES2NY
         OIp1TgQ9U0YzxMx/yqcM37fkqQNqaPLwiHUpJ9OAaYFBN6V/2tFOp98R4Y6rpjfZpJek
         0KBP0uf0csvk8aP+iRhXQAV9IRGcrYoLihEiLQk4KNc0EbgvW/NHZC/8bInoPLcMzqef
         t5Sw==
X-Gm-Message-State: AFqh2krcgywvd71u3NPrwmWjvjzz+UHkD0PJPk0uhiXYvnnkI8Lv2QHN
        VcfaCoSS7L+GteCgYa8sK++y0nZi9hsWPVcE/Yn8AVPX/LbUFM0mzwuUfsSvHf7MqAn2tnpML/a
        1qu/a7gB//0T1ynxxFaZEb5wR
X-Received: by 2002:a05:6402:4cd:b0:46c:8544:42be with SMTP id n13-20020a05640204cd00b0046c854442bemr50458815edw.5.1675084032634;
        Mon, 30 Jan 2023 05:07:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXumSvWj/TeMun8vPGBGZbjbXwpW5FL5AdECHv5wlI57T3t7cBf+ik9Ms0CmInU+iH6TJ6uC7Q==
X-Received: by 2002:a05:6402:4cd:b0:46c:8544:42be with SMTP id n13-20020a05640204cd00b0046c854442bemr50458806edw.5.1675084032453;
        Mon, 30 Jan 2023 05:07:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id v24-20020a056402185800b004a258718d72sm558461edy.63.2023.01.30.05.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:07:11 -0800 (PST)
Message-ID: <25af7aed-514c-e18c-1223-d4fc28517011@redhat.com>
Date:   Mon, 30 Jan 2023 14:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Content-Language: en-US
To:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
References: <20230125124301.1366990-1-rajat.khandelwal@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230125124301.1366990-1-rajat.khandelwal@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/25/23 13:43, Rajat Khandelwal wrote:
> From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> 
> Currently, 'ltr_ignore' sysfs attribute, when read, returns nothing, even
> if there are components whose LTR values have been ignored.
> 
> This patch adds the feature to print out such components, if they exist.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
> 
> v2: kmalloc -> devm_kmalloc
> 
>  drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
>  drivers/platform/x86/intel/pmc/core.h |  2 +-
>  2 files changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 3a15d32d7644..d4196b10b8af 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -53,6 +53,14 @@ const struct pmc_bit_map msr_map[] = {
>  	{}
>  };
>  
> +struct ltr_entry {
> +	u32 comp_index;
> +	const char *comp_name;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(ltr_ignore_list);

You need to add a static mutex here to protect this list and then take
that mutex in places where you modify or read the list.

Regards,

Hans



> +
>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
>  {
>  	return readl(pmcdev->regbase + reg_offset);
> @@ -435,27 +443,18 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>  
> -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
> +void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>  {
>  	const struct pmc_reg_map *map = pmcdev->map;
>  	u32 reg;
> -	int err = 0;
>  
>  	mutex_lock(&pmcdev->lock);
>  
> -	if (value > map->ltr_ignore_max) {
> -		err = -EINVAL;
> -		goto out_unlock;
> -	}
> -
>  	reg = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
>  	reg |= BIT(value);
>  	pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, reg);
>  
> -out_unlock:
>  	mutex_unlock(&pmcdev->lock);
> -
> -	return err;
>  }
>  
>  static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> @@ -464,6 +463,8 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
>  {
>  	struct seq_file *s = file->private_data;
>  	struct pmc_dev *pmcdev = s->private;
> +	const struct pmc_reg_map *map = pmcdev->map;
> +	struct ltr_entry *entry;
>  	u32 buf_size, value;
>  	int err;
>  
> @@ -473,13 +474,35 @@ static ssize_t pmc_core_ltr_ignore_write(struct file *file,
>  	if (err)
>  		return err;
>  
> -	err = pmc_core_send_ltr_ignore(pmcdev, value);
> +	if (value > map->ltr_ignore_max)
> +		return -EINVAL;
>  
> -	return err == 0 ? count : err;
> +	list_for_each_entry(entry, &ltr_ignore_list, node) {
> +		if (entry->comp_index == value)
> +			return -EEXIST;
> +	}
> +
> +	entry = devm_kmalloc(&pmcdev->pdev->dev, sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->comp_name = map->ltr_show_sts[value].name;
> +	entry->comp_index = value;
> +	list_add_tail(&entry->node, &ltr_ignore_list);
> +
> +	pmc_core_send_ltr_ignore(pmcdev, value);
> +
> +	return count;
>  }
>  
>  static int pmc_core_ltr_ignore_show(struct seq_file *s, void *unused)
>  {
> +	struct ltr_entry *entry;
> +
> +	list_for_each_entry(entry, &ltr_ignore_list, node) {
> +		seq_printf(s, "%s\n", entry->comp_name);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 810204d758ab..da35b0fcbe6e 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -396,7 +396,7 @@ extern const struct pmc_reg_map adl_reg_map;
>  extern const struct pmc_reg_map mtl_reg_map;
>  
>  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
> -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
> +extern void pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>  
>  void spt_core_init(struct pmc_dev *pmcdev);
>  void cnp_core_init(struct pmc_dev *pmcdev);

