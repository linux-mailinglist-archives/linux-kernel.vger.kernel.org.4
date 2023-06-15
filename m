Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB211731DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFOQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFOQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AAE69
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686847165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85Cde2lC1B5p+slsHblZ/ywkw9kOFzxqw+4KoOzSvts=;
        b=X3QeXZJ0RtvYoNO9SuP6yMVxqUZI0T+sfOuGeGuwhl9AkGtTEIv9O4bJBsq8kfSSqzvskE
        eJy30LQCeZA4vxK+Z3AaYN+C/tfjjKWB0CdE1KH2Qfp3+qTPh3iVALMyNI5uFweCxNBVPT
        kw1pMd7wlsL3Pno3SaqrBtNZ0X0m1yQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-fMIfcx93MeuviMYHQaplfg-1; Thu, 15 Jun 2023 12:39:24 -0400
X-MC-Unique: fMIfcx93MeuviMYHQaplfg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9749b806f81so177721266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847162; x=1689439162;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85Cde2lC1B5p+slsHblZ/ywkw9kOFzxqw+4KoOzSvts=;
        b=UfLt3AAS0vz7z90/VMZQdbcWnH9efZ0S78kcBpJ3Oc6mSOGi745Qs7GoLcxx5Chw/R
         gRbrbVS28BasLXzVI94joKRHjk6ZVsMxnMfWFWHxY8i+/JD3fznXr4aQYZn2O7LWe/db
         DnHG2mTbZVRNe4JwkvEcH/LtN5MGKsq5OfhFKHM48Fttpj6bmI7j0irJJb4JIeYmemQG
         fbvK25aSdnvj0w0oLvqEHlG/4huiTIKzt32aczY/jm+ZjwPsy0RxGhrdJASJ/1FslZEV
         H5SWb7Js/dMLZaudqgbh4nk08dK5hjqcH9EsDkfzf6y/DV8KykhRyv88lTkivdyfNY4N
         9vBw==
X-Gm-Message-State: AC+VfDz3orhxY/keXWoa6lypYiJQM2k05oJxGRZX3uaq1l8D/GMAB7vT
        GVjWU55tTVXLAMUuawB+CerDgDVL4hGdRkZt5yUIANJs6wsCP1hXhCd0Z5Wf+mH67YieaweyzjQ
        IYPwmV2Xv8+1CNjVTfRsXvEkalfqhYTsQ
X-Received: by 2002:a17:906:478f:b0:96f:aadb:bf81 with SMTP id cw15-20020a170906478f00b0096faadbbf81mr20890712ejc.45.1686847162685;
        Thu, 15 Jun 2023 09:39:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HFzj8oji+QgifVAS8W5rrkeLVzDVniPUlQYTVJZN7par6lelAUrI2LEXLSV910896GtiXog==
X-Received: by 2002:a17:906:478f:b0:96f:aadb:bf81 with SMTP id cw15-20020a170906478f00b0096faadbbf81mr20890694ejc.45.1686847162404;
        Thu, 15 Jun 2023 09:39:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906684d00b0096f7500502csm9582514ejs.199.2023.06.15.09.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 09:39:22 -0700 (PDT)
Message-ID: <68cd25de-e767-725e-2e7b-703217230bb0@redhat.com>
Date:   Thu, 15 Jun 2023 18:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v4 00/14] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
Content-Language: en-US
To:     Liam.Howlett@oracle.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230606223130.6132-1-dakr@redhat.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230606223130.6132-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 00:31, Danilo Krummrich wrote:

>    Maple Tree:
>      - Maple tree uses the 'unsinged long' type for node entries. While this
>        works for 64bit, it's incompatible with the DRM GPUVA Manager on 32bit,
>        since the DRM GPUVA Manager uses the u64 type and so do drivers using it.
>        While it's questionable whether a 32bit kernel and a > 32bit GPU address
>        space make any sense, it creates tons of compiler warnings when compiling
>        for 32bit. Maybe it makes sense to expand the maple tree API to let users
>        decide which size to pick - other ideas / proposals are welcome.

I remember you told me that the filesystem folks had some interest in a 
64-bit maple tree for a 32-bit kernel as well. Are there any news or 
plans for such a feature?

For the short term I'd probably add a feature flag to the GPUVA manager, 
where drivers explicitly need to promise not to pass in addresses 
exceeding 32-bit on a 32-bit kernel, and if they don't refuse to 
initialize the GPUVA manager on 32-bit kernels - or something similar...


