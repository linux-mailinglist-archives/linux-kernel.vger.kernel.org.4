Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A46C0EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCTKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCTKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E35244A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9j1tZlrjGVpFay8GqDUlBfl9N7iMb64uZJQ31+qiy4M=;
        b=FZJoz942bjyKwYGgfEQwGVLYSIUD5SzrRvBE/LKQ/kY2tvBVHH/8JIyCcu93eOOF+SnY9A
        wEM77w2Kpto8m4PnTHyLJhtET8fu1a31UtdFtPrs/JtyPZEk/SnsPOCH45t9u5RnsAOOIA
        3Rgbmv32xfx1WAB1AAUKtH30udXZszU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--vapcuRdP3CFNXEIv40iag-1; Mon, 20 Mar 2023 06:33:08 -0400
X-MC-Unique: -vapcuRdP3CFNXEIv40iag-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so16987470edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j1tZlrjGVpFay8GqDUlBfl9N7iMb64uZJQ31+qiy4M=;
        b=16TAVdYDl8WM2q/Tkvq2xYfkg7Fzbjw+BWEwIdKf3alzuL0wk0RmoYuAJM3XaNs5n4
         W91jjeUXvup0phOxMncGgFEgV3BOYtQYAvpDadlgfaAFQ6sgS+EKZw2Wp2P+ayjU8wF+
         p7d6Hm3n9SD3Xzmlc06vUqSuETl3oGY8bSAO6u2RNd+/mvr4Uey8VXNC0IQw9DiYj095
         UZbq1TjHjzr4JvomDesegjuOFQkEs+duXLuTcVept7BDDIeIYDmouOrpZxjZZRh1gzpj
         h0HczYptsdb8dqal14Fs2iMl/+twLffjXwo14BZ82ukbKHQKWRYjq1w0sLudtB4hxxiu
         pXGw==
X-Gm-Message-State: AO0yUKX+MJ5b02qU6ITe190bJX7AW/XCDMb7ARrVZ/R9CytzTNtljA5Y
        CHzA+KC8FvsGd6oTRGm7IQTVWIFBBwSak9lPDOupdgNwiNvvpEhPokBdcUOqyjOHPY0ypedN1gz
        jRt61dVI/R1Wva4ETg4W4iMqp
X-Received: by 2002:a17:906:185b:b0:931:4b0b:73e3 with SMTP id w27-20020a170906185b00b009314b0b73e3mr9410108eje.65.1679308387054;
        Mon, 20 Mar 2023 03:33:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set+sGoGYGtQ82gGOl/6rG2ufutdZdQ3DoxNT0cg8G5tz1D9dt9R9bGN4hVIxxjoCpOwQl1ethA==
X-Received: by 2002:a17:906:185b:b0:931:4b0b:73e3 with SMTP id w27-20020a170906185b00b009314b0b73e3mr9410097eje.65.1679308386885;
        Mon, 20 Mar 2023 03:33:06 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id gx24-20020a170906f1d800b0092d16623eeasm4244327ejb.138.2023.03.20.03.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:33:06 -0700 (PDT)
Message-ID: <8b58fbc5-93c6-9cbe-edda-e804c398ba52@redhat.com>
Date:   Mon, 20 Mar 2023 11:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next v2 2/3] drivers/platform/x86/intel/tpmi: revise
 the comment of intel_vsec_add_aux
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-3-dzm91@hust.edu.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230309040107.534716-3-dzm91@hust.edu.cn>
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

On 3/9/23 05:01, Dongliang Mu wrote:
> intel_vsec_add_aux() is resource managed including res and
> feature_vsec_dev memory.
> 
> Fix this by revising the comment of intel_vsec_add_aux since res variable
> will also be freed in the intel_vsec_add_aux.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/tpmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 882fe5e4763f..036d0e0dba19 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -239,8 +239,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>  	/*
>  	 * intel_vsec_add_aux() is resource managed, no explicit
>  	 * delete is required on error or on module unload.
> -	 * feature_vsec_dev memory is also freed as part of device
> -	 * delete.
> +	 * feature_vsec_dev and res memory are also freed as part of
> +	 * device deletion.
>  	 */
>  	return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
>  				  feature_vsec_dev, feature_id_name);

