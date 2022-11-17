Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724DE62DCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiKQNbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiKQNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A773415
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668691815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKR7OdPNU6xaK3dFkFAJM5RIPG7b+zn03F5YyC8LFZI=;
        b=OeGAfhNPFC6iXIr9P3ZdCnC7BY/PKPs1lYlOxf0IqnSIPF1DE73CmUI9diuI2B3N/9INup
        OeUHy+zBvxP3BcZ/pjWHjR41jo/x77OAFoeBRleqIHoobRRMhXzQZ75kqSvpoZvuzixnX8
        eLVkpbnGP1l1IiEPF+sdmNsw8DWkwLo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-G_gfcoyCPZqIbM9JWp-axA-1; Thu, 17 Nov 2022 08:30:14 -0500
X-MC-Unique: G_gfcoyCPZqIbM9JWp-axA-1
Received: by mail-ed1-f70.google.com with SMTP id f17-20020a056402355100b00466481256f6so1215248edd.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKR7OdPNU6xaK3dFkFAJM5RIPG7b+zn03F5YyC8LFZI=;
        b=TaHanl6iynFYhNe63YuaamMB/BHjIFzB3mmE7+lbEjGhYzsdown1RiieaL0PpwdwqA
         O9K1dYwlAykA9ku3lLvjrYUn/DtFaIX4hFzKfy7AOFbYBK608y67tqN3idsyVnrzRi2U
         3O9b2qTM8m5cYetF7+8F+hIIFZkn2FZg0MBriJAL76HFivHcxz48+nwJowbGqoiiawbm
         j69bCknxEpLe6ximbqg3J7l2gUQaQMwWJMZraQlruyIq+XZ+/eJfeIuD/0xuaydLxsTW
         vfSLC6uLj2WjeltyeREYpi/IFBv7JWF+cWXDzermlqN3ktI2jNilk8IGkYkZ3ZdItrA5
         5DXQ==
X-Gm-Message-State: ANoB5pmWM1+DltZ3nh10M5T2YCTRGRnuEvL0WPmE4+cn1n6CfXWMdh9o
        N9K3dsMh9fC0OtN0oGdb8RuO9Qu5APYQHKkdI/GDEMqaq9dIVRm3L+z30yHnHY6sdHdl8hf4yLF
        eVQ5I8DnhnF/MD2WgRInrqlhv
X-Received: by 2002:a17:906:89a3:b0:78d:408a:4a18 with SMTP id gg35-20020a17090689a300b0078d408a4a18mr2151386ejc.261.1668691813312;
        Thu, 17 Nov 2022 05:30:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Mr9Thk+iu83nP3PZhm8MCu1iNsVDI2q6WqfWQgRtxGVtuAUwCYqgtUhYaDBwU3RjeKYZ4Ow==
X-Received: by 2002:a17:906:89a3:b0:78d:408a:4a18 with SMTP id gg35-20020a17090689a300b0078d408a4a18mr2151378ejc.261.1668691813156;
        Thu, 17 Nov 2022 05:30:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jp8-20020a170906f74800b007adaca75bd0sm370553ejb.179.2022.11.17.05.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:30:12 -0800 (PST)
Message-ID: <7412dae3-c8b7-c826-ab70-d3f63d788f0e@redhat.com>
Date:   Thu, 17 Nov 2022 14:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/9] platform/x86/intel/sdsi: Support different GUIDs
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-4-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-4-david.e.box@linux.intel.com>
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
> Newer versions of Intel On Demand hardware may have an expanded list of
> registers to support new features. The register layout is identified by a
> unique GUID that's read during driver probe. Add support for handling
> different GUIDs and add support for current GUIDs [1].
> 
> [1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

With Andy's remarks fixed this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/sdsi.c | 47 +++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index bca05b4dd983..ab1f65919fc5 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -27,10 +27,10 @@
>  #define ACCESS_TYPE_LOCAL		3
>  
>  #define SDSI_MIN_SIZE_DWORDS		276
> -#define SDSI_SIZE_CONTROL		8
>  #define SDSI_SIZE_MAILBOX		1024
> -#define SDSI_SIZE_REGS			72
> +#define SDSI_SIZE_REGS			80
>  #define SDSI_SIZE_CMD			sizeof(u64)
> +#define SDSI_SIZE_MAILBOX		1024
>  
>  /*
>   * Write messages are currently up to the size of the mailbox
> @@ -76,6 +76,9 @@
>  #define DT_TBIR				GENMASK(2, 0)
>  #define DT_OFFSET(v)			((v) & GENMASK(31, 3))
>  
> +#define SDSI_GUID_V1			0x006DD191
> +#define SDSI_GUID_V2			0xF210D9EF
> +
>  enum sdsi_command {
>  	SDSI_CMD_PROVISION_AKC		= 0x04,
>  	SDSI_CMD_PROVISION_CAP		= 0x08,
> @@ -100,6 +103,9 @@ struct sdsi_priv {
>  	void __iomem		*control_addr;
>  	void __iomem		*mbox_addr;
>  	void __iomem		*regs_addr;
> +	int			control_size;
> +	int			maibox_size;
> +	int			registers_size;
>  	u32			guid;
>  	u32			features;
>  };
> @@ -444,6 +450,18 @@ static ssize_t registers_read(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct sdsi_priv *priv = dev_get_drvdata(dev);
>  	void __iomem *addr = priv->regs_addr;
> +	int size =  priv->registers_size;
> +
> +	/*
> +	 * The check below is performed by the sysfs caller based on the static
> +	 * file size. But this may be greater than the actual size which is based
> +	 * on the GUID. So check here again based on actual size before reading.
> +	 */
> +	if (off >= size)
> +		return 0;
> +
> +	if (off + count > size)
> +		count = size - off;
>  
>  	memcpy_fromio(buf, addr + off, count);
>  
> @@ -496,6 +514,24 @@ static const struct attribute_group sdsi_group = {
>  };
>  __ATTRIBUTE_GROUPS(sdsi);
>  
> +static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
> +{
> +	switch (table->guid) {
> +	case SDSI_GUID_V1:
> +		priv->control_size = 8;
> +		priv->registers_size = 72;
> +		break;
> +	case SDSI_GUID_V2:
> +		priv->control_size = 16;
> +		priv->registers_size = 80;
> +		break;
> +	default:
> +		dev_err(priv->dev, "Unrecognized GUID 0x%x\n", table->guid);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *parent,
>  				   struct disc_table *disc_table, struct resource *disc_res)
>  {
> @@ -537,7 +573,7 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
>  	if (IS_ERR(priv->control_addr))
>  		return PTR_ERR(priv->control_addr);
>  
> -	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
> +	priv->mbox_addr = priv->control_addr + priv->control_size;
>  	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
>  
>  	priv->features = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
> @@ -572,6 +608,11 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
>  
>  	priv->guid = disc_table.guid;
>  
> +	/* Get guid based layout info */
> +	ret = sdsi_get_layout(priv, &disc_table);
> +	if (ret)
> +		return ret;
> +
>  	/* Map the SDSi mailbox registers */
>  	ret = sdsi_map_mbox_registers(priv, intel_cap_dev->pcidev, &disc_table, disc_res);
>  	if (ret)

