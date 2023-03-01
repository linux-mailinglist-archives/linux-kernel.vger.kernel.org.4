Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40606A6C86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAMnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCAMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AB3C794
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677674543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRruoFijKI0eJ9z+j5eqOPxH2mXmxad09v4W8lYPbHg=;
        b=EkiDr9rnbaovXCytduXQLaSihS0YHPWOwLBS2kjTSQ09etz+GrUz1Bf3yu9RhdWJa2D8Fm
        6VT7m5fg4R1De4WNlp+3iIxWo9cIlUwgHnXSpTfUZRdPApI4BTSZJxOTlIbTCzDmLGVrkk
        1j+oI9+gXB3IGL7utPkwcYlxTMTZdCs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-_77wMMTIMsaVBOr1yMWrlg-1; Wed, 01 Mar 2023 07:42:22 -0500
X-MC-Unique: _77wMMTIMsaVBOr1yMWrlg-1
Received: by mail-ed1-f70.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so18932157edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRruoFijKI0eJ9z+j5eqOPxH2mXmxad09v4W8lYPbHg=;
        b=ngOck9igl/5KEt7uDU8ghrYvMUsE4rtX+hhfw3r17fy8ZArxCeIBNFO9+7E2li/LDs
         cN95PaMbg7gzWr+DwXKaY9Uc5/VN4b28ojBB1yFBgVA2h5mgxjWVa0u3bSwAJSwmHx5Q
         FbtkfYt/+Y8gKtKB9zJHt3GyUraX4u6kUg8mpEj9DQkysoidg0tn9YvS2CN/cXcAfB1c
         hNtTjtOv022vjN+CPnjWBRkkMJkJM6kyB1NeY9Pj2bB8cQ/kVZvRR/jaCR5hHxzw8gpq
         3QGPjeQCDOAqEHq/bZSsxvZLyjTCOcaHSMhTvMpf0a8LAVHl8lUBedJGBqwdSm7+QvuD
         NkRg==
X-Gm-Message-State: AO0yUKXVXrRRkHGAWzIY8bEfX80+DKmOGX7v4exDcwzEq1oNAjbOdvkq
        PjHhvv7qO6GB5ZyazPECSyzc5VIKqXBbT3Z3ukC2+QIDO0Hs6FaniN7jVQqhB8jWmDVAga5p02T
        mRCjrnZ1ae92s7IHOXcJ/D4XQ
X-Received: by 2002:aa7:c9c6:0:b0:4af:69e2:52cd with SMTP id i6-20020aa7c9c6000000b004af69e252cdmr6310942edt.28.1677674540873;
        Wed, 01 Mar 2023 04:42:20 -0800 (PST)
X-Google-Smtp-Source: AK7set9JMCjYKj4vd0F0V7y8ah9oSy/cKUWa/Bw9oYjoqHXJhv/cfc8loiLq+DIJ4RwXV6xsrLjKDQ==
X-Received: by 2002:aa7:c9c6:0:b0:4af:69e2:52cd with SMTP id i6-20020aa7c9c6000000b004af69e252cdmr6310921edt.28.1677674540586;
        Wed, 01 Mar 2023 04:42:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u26-20020a50d51a000000b004af6a840f21sm5517687edi.15.2023.03.01.04.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:42:19 -0800 (PST)
Message-ID: <5ffd8859-af37-5395-d309-ee04dbd5bdb8@redhat.com>
Date:   Wed, 1 Mar 2023 13:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: ISST: Increase range of valid mail box
 commands
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230227053504.2734214-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230227053504.2734214-1-srinivas.pandruvada@linux.intel.com>
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

On 2/27/23 06:35, Srinivas Pandruvada wrote:
> A new command CONFIG_TDP_GET_RATIO_INFO is added, with sub command type
> of 0x0C. The previous range of valid sub commands was from 0x00 to 0x0B.
> Change the valid range from 0x00 to 0x0C.
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
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index a7e02b24a87a..0829e793a8fc 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -47,7 +47,7 @@ struct isst_cmd_set_req_type {
>  
>  static const struct isst_valid_cmd_ranges isst_valid_cmds[] = {
>  	{0xD0, 0x00, 0x03},
> -	{0x7F, 0x00, 0x0B},
> +	{0x7F, 0x00, 0x0C},
>  	{0x7F, 0x10, 0x12},
>  	{0x7F, 0x20, 0x23},
>  	{0x94, 0x03, 0x03},

