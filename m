Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8B6352F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiKWImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiKWImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC97FCDC8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669192872;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHQQmYIEEBZ9VkfBzqKM+BIdC+GLpfqg7qXfPAGQGqc=;
        b=KGk/9HvPlZ0fWJ0pC19dYYaE5gzo4WeIKFvkRRs4Lago7Wp1WH1ZpJ0vkfA1ePbdm25VPO
        /tTJTaeGEWt0nKAzqgP/o/ziIbeIIXupYpf5lxr73YKFiBONs/hFfPvlsHofuSX928dhkv
        wgl5Z8cItvrJeovUUC4xUp1YTXRNsrU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-GCP8zRyfM6WbSGEY2X6LrA-1; Wed, 23 Nov 2022 03:41:10 -0500
X-MC-Unique: GCP8zRyfM6WbSGEY2X6LrA-1
Received: by mail-qk1-f200.google.com with SMTP id h13-20020a05620a244d00b006fb713618b8so21688607qkn.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHQQmYIEEBZ9VkfBzqKM+BIdC+GLpfqg7qXfPAGQGqc=;
        b=atOsmKEdVqZzEpcycGQ2v+D9j3mIHB+bqcTwec7fQ4/GD4eUaMmiv18exHsjLCMMY2
         NhJ6clZ8jL9fn8hCDbLfCQ2Hi4twYFDEgA7B+o//wi7jm3RruzWBQwBmNXZyiqYdTZGq
         SJD+1Bt20aX+pVXiVIPvAMkeYc5hiFil4NmAIH54ssLdMtIZ23ve8jcMWqTUsbr/AA5+
         d4XjMTPbrVGg8vV59XfnEX+Ac7aI98StmEJVaGT5BRa0neFRdpA7d9BdQO/Ipc27zMu0
         F38iSYpSOdnI7h9hDEd54pismXamws9QCCUKRwGQ+gdKGmfbYlrFFksWh3ujdog40+oz
         0YFw==
X-Gm-Message-State: ANoB5pmHaTeTtlBIrB8VHiSza/Ze5bGHIl/U74iVhcyj+V0ENd18ZWoS
        krIuTMkC5jAsucNowVDC6SrLi2XL/oOOHKUC1WfcetI8cU7dwqQQYtCtpiCzkhlHMDYiZ64CYYa
        9caGIXSUHLoPrZ5ebYIZorR0K
X-Received: by 2002:ac8:1182:0:b0:35a:7084:23b8 with SMTP id d2-20020ac81182000000b0035a708423b8mr25333612qtj.135.1669192870476;
        Wed, 23 Nov 2022 00:41:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Y0qBYKMl1SoRA3ubAQywr0BMQO7sZ5iQggmcJKCTt7PBjQ1vVRH6b2wzwuZzrWtChYBQhDQ==
X-Received: by 2002:ac8:1182:0:b0:35a:7084:23b8 with SMTP id d2-20020ac81182000000b0035a708423b8mr25333605qtj.135.1669192870258;
        Wed, 23 Nov 2022 00:41:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fab68c7e87sm12102348qkp.70.2022.11.23.00.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:41:08 -0800 (PST)
Message-ID: <762b7c68-5ae3-b27e-1018-b930de61b99e@redhat.com>
Date:   Wed, 23 Nov 2022 09:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio/platform: Remove the ACPI buffer memory to fix
 memory leak
Content-Language: en-US
To:     Hanjun Guo <guohanjun@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>
References: <1669116598-25761-1-git-send-email-guohanjun@huawei.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1669116598-25761-1-git-send-email-guohanjun@huawei.com>
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

On 11/22/22 12:29, Hanjun Guo wrote:
> The ACPI buffer memory (buffer.pointer) returned by acpi_evaluate_object()
> is not used after the call of _RST method, so it leads to memory leak.
>
> For the calling of ACPI _RST method, we don't need to pass a buffer
> for acpi_evaluate_object(), we can just pass NULL and remove the ACPI
> buffer memory in vfio_platform_acpi_call_reset(), then we don't need to
> free the memory and no memory leak.
>
> Fixes: d30daa33ec1d ("vfio: platform: call _RST method when using ACPI")
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 55dc4f4..1a0a238 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -72,12 +72,11 @@ static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev,
>  				  const char **extra_dbg)
>  {
>  #ifdef CONFIG_ACPI
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct device *dev = vdev->device;
>  	acpi_handle handle = ACPI_HANDLE(dev);
>  	acpi_status acpi_ret;
>  
> -	acpi_ret = acpi_evaluate_object(handle, "_RST", NULL, &buffer);
> +	acpi_ret = acpi_evaluate_object(handle, "_RST", NULL, NULL);
>  	if (ACPI_FAILURE(acpi_ret)) {
>  		if (extra_dbg)
>  			*extra_dbg = acpi_format_exception(acpi_ret);
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thank you for the fix!

Eric

