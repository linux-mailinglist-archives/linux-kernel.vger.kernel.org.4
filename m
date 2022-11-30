Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E041363DBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiK3RVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiK3RVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041EF12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669828838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfQ7QiYfoE52xD4bGT55kmCqWuS4ZEeF86n+w8XG+J4=;
        b=hart12MsIU73q+g+SRqvjMk7N2sT4ug9Tp+WsU6exB/AQ+6X2mCUyOq6YAtF3iHGUkgBAs
        vpYYC+8mCailYv1VnnfWO+bGBw0zUXI5uj3d2coij0xFxP4OSPkGAj/jF1uemZi8Qjp2jw
        gUocgymHVBIQf2s9yQLeqeNj4Qu36Nw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-ItchuhRFPiO5R54dfapdLQ-1; Wed, 30 Nov 2022 12:20:36 -0500
X-MC-Unique: ItchuhRFPiO5R54dfapdLQ-1
Received: by mail-qv1-f70.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so20186755qvx.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfQ7QiYfoE52xD4bGT55kmCqWuS4ZEeF86n+w8XG+J4=;
        b=mm8gTRpT21uPiwCy+ENhAkKHMKd5ei6ZXBn5rB7IFYKy6n1NME4c6XA18EtjE7LKqJ
         j5ZKZfcQP2TCVTx0ZN8E4DFBLgNv7LG3fRd7i1xiAQsSU4WrrR/hjsdL0j+8/g+6/Ers
         4WrTZknaJJh5qqr0UNq5/5CYXD44w8jnAIl34BkWyboS9cCrmAVlnqiSOLXwLBuR+F4/
         uh1W3YeFdIB3P7rX0AUAZtw2N7klRJMOQZw+9Ox3NyGWmDNgFWZfDIKyNRCRnIsfv4XH
         R+0KKy/3q85VL/4l4jtkebat7cfHKlWTlsyB7mnElhXQ5ygGKy+hPCNQqtDV3nUCiFTF
         HB4A==
X-Gm-Message-State: ANoB5pnHPaaSaML8Z8KYJhKJzRzFbB2dDdF/gAsMA53uctocdB9MefIw
        7+EYLsLIAwJrKuiwAnWZa4z/GgpkUU/cP6IDAifwkqDAcegYOkflzccRxdscMcxvxN8fLTnbvqQ
        BZncHeySIBdmLzwX8vo+RBQE=
X-Received: by 2002:a05:620a:488a:b0:6f1:187c:8f79 with SMTP id ea10-20020a05620a488a00b006f1187c8f79mr54581820qkb.593.1669828836037;
        Wed, 30 Nov 2022 09:20:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf49GCx1/laAUqNn7mO4+ckiGxudVpsJ4syaVLU2WQZPInCZ5ZPiOQmmgbJIPYZ+XjnCfR89xA==
X-Received: by 2002:a05:620a:488a:b0:6f1:187c:8f79 with SMTP id ea10-20020a05620a488a00b006f1187c8f79mr54581789qkb.593.1669828835765;
        Wed, 30 Nov 2022 09:20:35 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-144.cust.vodafonedsl.it. [2.34.28.144])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a28c500b006cf19068261sm1539708qkp.116.2022.11.30.09.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:20:35 -0800 (PST)
Message-ID: <0f28f75d-ac27-1f3d-2531-6b0f7504db85@redhat.com>
Date:   Wed, 30 Nov 2022 18:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Fix probe rollback
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20221130091158.4732-1-ilpo.jarvinen@linux.intel.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20221130091158.4732-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-11-30 10:11, Ilpo Järvinen wrote:
> Handle probe error rollbacks properly to avoid leaks.
> 
> Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")

Reviewed-by: Marco Pagani <marpagan@redhat.com>

> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 79d48852825e..03f1bd81c434 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -574,20 +574,27 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>  	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>  			sec->fw_name_id);
>  	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> -	if (!sec->fw_name)
> -		return -ENOMEM;
> +	if (!sec->fw_name) {
> +		ret = -ENOMEM;
> +		goto fw_name_fail;
> +	}
>  
>  	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>  				       &m10bmc_ops, sec);
>  	if (IS_ERR(fwl)) {
>  		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> -		kfree(sec->fw_name);
> -		xa_erase(&fw_upload_xa, sec->fw_name_id);
> -		return PTR_ERR(fwl);
> +		ret = PTR_ERR(fwl);
> +		goto fw_uploader_fail;
>  	}
>  
>  	sec->fwl = fwl;
>  	return 0;
> +
> +fw_uploader_fail:
> +	kfree(sec->fw_name);
> +fw_name_fail:
> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> +	return ret;
>  }
>  
>  static int m10bmc_sec_remove(struct platform_device *pdev)

