Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A374EB05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6E100
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689068616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Od1/19kFhHmX9rdsBJAf2fw/H3xJi3JwZ125IHGO3Ho=;
        b=bUXf+Me8/RDa0ZsFb7p47JqDM0ZwhDji3S69fCs2+OWVRgzHPaPslkfG4Q8qGZ5DzA5hZe
        vCFYwfqtIaKYR4g2bZGUD43z21zNdIWD1mIbizjXIHs7UBxk+ap1DNlyr321a7ROmSIQa1
        kLckmop2sYvxMXZbPSZBg9eyyBpTxZg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-fud4YQYaNnSv4THIa1RaCQ-1; Tue, 11 Jul 2023 05:43:35 -0400
X-MC-Unique: fud4YQYaNnSv4THIa1RaCQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-978a991c3f5so369419966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068613; x=1691660613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od1/19kFhHmX9rdsBJAf2fw/H3xJi3JwZ125IHGO3Ho=;
        b=cWEHP1tFWpoZ/m+nl83gDc8LgbSeF/nIuvzxU9xBiOvBewvAUs1jYojZ/WlVzoGasx
         DinDNDc8sxHTLvMnyn32KQSTimPHGJQ0PRJ+CT8K2z3ehOef3pf1rNfjkZCuvHtqIqIm
         0uN7n2vlNtS4Gqfc7oe4109UU4cu2b++kiAzCQ/ZQgAHw/OD4Bn+t/n69mcDXIRhb0wn
         fBLjjdoBd2F0+oKDsXhvMsyp6xRhNNgfSNBKPfidmkZm/3CYsEF9LfleD35GNoo//n8A
         205tnm8mt0eFt+EfGDYoEglI5Z9mQNED3xhMCCVg/6g7Pd6AuZSP03zy1/eB+V6DhF1c
         bOxw==
X-Gm-Message-State: ABy/qLal6g5MaBqKaMUlPRwDDhAy8FqocYuEbK/Jpbiqs3trpUKzbode
        TiMVssg52SQZnPA39tO+OC+QTCMKvCycotDhVMWun9Jxpi2hXM28CC4r0tyRj6BJGwB9HHWYOqx
        DRSem1JhBbAYMPSJ1v8kZKxAGIPFJ77YL
X-Received: by 2002:a17:906:89a1:b0:992:9756:6a22 with SMTP id gg33-20020a17090689a100b0099297566a22mr13153274ejc.48.1689068613673;
        Tue, 11 Jul 2023 02:43:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMqb4E+QCCQyWkhsASzNp0G+JFQtsiQCik8JuUn+PF7LBYxukV6D1AZlMYmFRkVD/IFqP7BQ==
X-Received: by 2002:a17:906:89a1:b0:992:9756:6a22 with SMTP id gg33-20020a17090689a100b0099297566a22mr13153264ejc.48.1689068613415;
        Tue, 11 Jul 2023 02:43:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ox10-20020a170907100a00b00991dfb5dfbbsm935652ejb.67.2023.07.11.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:43:32 -0700 (PDT)
Message-ID: <c93f102d-d169-a693-95ed-6754e2f1a939@redhat.com>
Date:   Tue, 11 Jul 2023 11:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/x86/intel/tpmi: Prevent overflow for cap_offset
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230622195717.3125088-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230622195717.3125088-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/22/23 21:57, Srinivas Pandruvada wrote:
> cap_offset is a u16 field, so multiplying with TPMI_CAP_OFFSET_UNIT
> (which is equal to 1024) to covert to bytes will cause overflow. This
> will be a problem once more TPMI features are added.
> 
> This field is not used except for calculating pfs->vsec_offset. So, leave
> cap_offset field unchanged and multiply with TPMI_CAP_OFFSET_UNIT while
> calculating pfs->vsec_offset.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Rebased on top of
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> review-hans 

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> 
>  drivers/platform/x86/intel/tpmi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
> index 9c606ee2030c..d1fd6e69401c 100644
> --- a/drivers/platform/x86/intel/tpmi.c
> +++ b/drivers/platform/x86/intel/tpmi.c
> @@ -356,9 +356,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
>  		if (!pfs_start)
>  			pfs_start = res_start;
>  
> -		pfs->pfs_header.cap_offset *= TPMI_CAP_OFFSET_UNIT;
> -
> -		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset;
> +		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset * TPMI_CAP_OFFSET_UNIT;
>  
>  		/*
>  		 * Process TPMI_INFO to get PCI device to CPU package ID.

