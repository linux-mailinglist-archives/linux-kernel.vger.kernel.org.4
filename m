Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202216D4B83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjDCPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB36B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680534783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJGlwjdQBeHi6YLZ8ILA8VzHl25fpiQW6XX1UoDjDiE=;
        b=G/AKnDseIYUOGjaXCGMQnlI9XLfbUr1wS/xvnn2TNhZAjr/mrh3uJ+M6Kh8D/rCSvDMBIs
        fDI5OMxjPGotEivJ1NfvxsGydx9EVhXFutAUOqV+uzkMPxOkS8sgEEFH9Yh1mtPOv4QUUy
        p528FvnKsrwLiqjUOdswHO8uVZOYuOI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-zAY2V83kPoK_ieRdd6Bmfg-1; Mon, 03 Apr 2023 11:13:02 -0400
X-MC-Unique: zAY2V83kPoK_ieRdd6Bmfg-1
Received: by mail-ed1-f70.google.com with SMTP id k14-20020a508ace000000b005024a8cef5cso30803801edk.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534780; x=1683126780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJGlwjdQBeHi6YLZ8ILA8VzHl25fpiQW6XX1UoDjDiE=;
        b=rClIY6cfa0qHs5z4ENugz7r8O5x8b7AZoE3iyiL/IfxegaBS4wEpLudn52jXI0cpAY
         Hy+eDtwrFk7yF04CKXond9vKa6gpuwWKkLugRMZzdl2VvLfHbJgu0k1jaaQsw5fUs7Bx
         BGCHja4JeYRXJeZIpVpzKSTfCpOt0qtnAkn/2ycY5LHHQ2IEtoASfByXYER1TNSbWZw3
         bD9/qz1J0xHLjr597Dx6sYHNGyhCf7NVcuZaIwMwVp5AIYd2dFWxfz+xgLhP5iZbofjh
         0G2guejjxfYBHi0qEqUPzzjT+TLZ6yv9tpZAQoABRN9VbKr9MteOpDrkWwUkHFFApZ/S
         USkA==
X-Gm-Message-State: AAQBX9eN02GjFOJykxjUCM8QpMYmv79GwKpXWLOmntlffgU+wi4jne3W
        GoogAyv8g9m81l3XA3mq3Ra45h2Qh+5+QHBVzNQtuH3uFWgbaMBs0vJa44K+ky+qaGBbc0QnQ3H
        5R46IP+T6ZO+Cqsfb1Rf6JuKOPzJtLTmAEBU=
X-Received: by 2002:a05:6402:26d5:b0:4af:7bdc:188e with SMTP id x21-20020a05640226d500b004af7bdc188emr18470947edd.16.1680534780396;
        Mon, 03 Apr 2023 08:13:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIBqpFmu+8nIFsIAOCGXx5GXxWZehiLtPezZpI5dUmdWJJTcc9ck45XoV8kzig2i+Rj3SX9Q==
X-Received: by 2002:a05:6402:26d5:b0:4af:7bdc:188e with SMTP id x21-20020a05640226d500b004af7bdc188emr18470927edd.16.1680534780085;
        Mon, 03 Apr 2023 08:13:00 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id w26-20020a50d79a000000b005021d1ae6adsm4677928edi.28.2023.04.03.08.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:12:59 -0700 (PDT)
Message-ID: <2add5a7e-ae72-c8ab-181d-23c1731cb966@redhat.com>
Date:   Mon, 3 Apr 2023 17:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] docs: kvm: x86: Fix broken field list
Content-Language: en-US
To:     Takahiro Itazuri <itazur@amazon.com>, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Dunn <daviddunn@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takahiro Itazuri <zulinx86@gmail.com>
References: <20230331093116.99820-1-itazur@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230331093116.99820-1-itazur@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 11:31, Takahiro Itazuri wrote:
> Add a missing ":" to fix a broken field list.
> 
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> Fixes: ba7bb663f554 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
> ---
> v1 -> v2
> * Fix commit message to say "Do foo" instead of "This commit does foo".
> * Add "Fixes:" tag.
> * Link to v1: https://lore.kernel.org/all/20230330233956.78246-1-itazur@amazon.com/
> 
>   Documentation/virt/kvm/api.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 62de0768d..f9163590c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8296,7 +8296,7 @@ ENOSYS for the others.
>   8.35 KVM_CAP_PMU_CAPABILITY
>   ---------------------------
>   
> -:Capability KVM_CAP_PMU_CAPABILITY
> +:Capability: KVM_CAP_PMU_CAPABILITY
>   :Architectures: x86
>   :Type: vm
>   :Parameters: arg[0] is bitmask of PMU virtualization capabilities.

Queued, thanks.

Paolo

