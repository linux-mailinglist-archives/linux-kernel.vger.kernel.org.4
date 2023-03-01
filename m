Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E786A6E51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCAOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157CF367F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677680615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkimFynSnxK6YsAaiTKJQJFBKhhOmj+Wb4G+OWeGENQ=;
        b=RU2gX3F+qDTH9lsmmUiswS64vz9n/DIU07Orq6kiXsMftXRY4nRr/wEx9p3JrytcjJPXXs
        Tkxe85mrRmzEWzVIomZQYKSXS7XZJGPXD3XgAhCjcYYMVqIG8JchzYIJE1e6pGvSm1GqAg
        9hSHVsFq5lria9hYEuvJg4Peup1pvmc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-qxxc4FIeNEqaQMgRRf5a5A-1; Wed, 01 Mar 2023 09:23:34 -0500
X-MC-Unique: qxxc4FIeNEqaQMgRRf5a5A-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so19148834edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkimFynSnxK6YsAaiTKJQJFBKhhOmj+Wb4G+OWeGENQ=;
        b=1X6Z0qdUQDn1knwvl58QePwEn3rrQGJ56MLWOyBA4ksO+JlGaF/qFqofebONg9GfWl
         Ko4pPWOjWt0qygUvoJjaMInQ3pichbni2Lz840qlUyaNEfM73D/hLhly33qMSrENWOc8
         juIIRYfDmJGntSJSVqEFYtJO2v+3IKtjPqCZd0NMP11kGXXp9LoKeFAVK+RZj097YBJP
         TptM+pBaj5CD6VuhsBNdRz2abjy0IDAoQ3SIM+kz5hUXe0yzkE3k6INz+deT3bYoYFUx
         xR3Sq//DkP4aqjyqVuS7GNozxx0EAmFK1rYkTabZAgcrO9SXUHTaq5RicjcSUule29BF
         bYCw==
X-Gm-Message-State: AO0yUKVA1ty1RTxycvf8VKIoZRiZl2ZZBCGqxqQmoWgZmXU5dvTIQqFo
        e47GDzfmk33NQw8Qxlz59z0o2GIHBq7jZyApSRmNk8tC6UoRtMVQ5aufsaGBZSbJ9eTaoriGdn7
        +Rwj+Ng54TLuVUV8KOrTBqyho
X-Received: by 2002:a17:907:b682:b0:8dc:cfe8:da53 with SMTP id vm2-20020a170907b68200b008dccfe8da53mr8667799ejc.10.1677680613078;
        Wed, 01 Mar 2023 06:23:33 -0800 (PST)
X-Google-Smtp-Source: AK7set89iR0qASUFFJ53En29c14nxWvTRDWTIt+BGVnixoWXFvL1LfSTHymUQ2K2OKvzj/ced7v/3Q==
X-Received: by 2002:a17:907:b682:b0:8dc:cfe8:da53 with SMTP id vm2-20020a170907b68200b008dccfe8da53mr8667781ejc.10.1677680612818;
        Wed, 01 Mar 2023 06:23:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906178800b008dcf89a72d7sm5966994eje.147.2023.03.01.06.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:23:32 -0800 (PST)
Message-ID: <39b98cb1-1ef5-dabf-5f01-2f673b2b59b1@redhat.com>
Date:   Wed, 1 Mar 2023 15:23:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/12] platform/x86: ISST: Fix kernel documentation
 warnings
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-2-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211063257.311746-2-srinivas.pandruvada@linux.intel.com>
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
> Fix warning displayed for "make W=1" for kernel documentation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, I've applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I'll rebase that branch once 6.3-rc1 is out and then push the rebased
patch to the fixes branch and include it in my next 6.3 fixes pull-req
to Linus.

Regards,

Hans





> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3 ++-
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index a7e02b24a87a..63d49fe17a16 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -112,6 +112,7 @@ static void isst_delete_hash(void)
>   * isst_store_cmd() - Store command to a hash table
>   * @cmd: Mailbox command.
>   * @sub_cmd: Mailbox sub-command or MSR id.
> + * @cpu: Target CPU for the command
>   * @mbox_cmd_type: Mailbox or MSR command.
>   * @param: Mailbox parameter.
>   * @data: Mailbox request data or MSR data.
> @@ -363,7 +364,7 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  /**
>   * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
>   * @cpu: Logical CPU number.
> - * @bus_number: The bus number assigned by the hardware.
> + * @bus_no: The bus number assigned by the hardware.
>   * @dev: The device number assigned by the hardware.
>   * @fn: The function number assigned by the hardware.
>   *
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> index fdecdae248d7..35ff506b402e 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> @@ -40,6 +40,7 @@
>   * @offset:	Offset to the first valid member in command structure.
>   *		This will be the offset of the start of the command
>   *		after command count field
> + * @owner:	Registered module owner
>   * @cmd_callback: Callback function to handle IOCTL. The callback has the
>   *		command pointer with data for command. There is a pointer
>   *		called write_only, which when set, will not copy the

