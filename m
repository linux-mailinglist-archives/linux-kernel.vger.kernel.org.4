Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F862FBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiKRRtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiKRRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:48:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01E5BD5B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668793676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkJx+RgAzofek0cetBCDV8S2wNiIF1AHyooRWAe/tSY=;
        b=Nx5mI0vSOMOsOf4SpRxKzRcOdaMvzy7RbIOl3yJ2IjsCMzydrKM36FyKXz0nml+Kb3nfwd
        AqGV1hZgL3VeNeCV/t5NDtF3hlsWYNvZJAyq7Ejs5SxuCE4DIcLy0lEO4No2hlP+aZLtvG
        wnWRxgAWLRFS+PUvbKOYmwf+IAAapUk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-Bf7GMJ6yPF2bVF9jBItWWg-1; Fri, 18 Nov 2022 12:47:54 -0500
X-MC-Unique: Bf7GMJ6yPF2bVF9jBItWWg-1
Received: by mail-ej1-f70.google.com with SMTP id qw20-20020a1709066a1400b007af13652c92so3475103ejc.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkJx+RgAzofek0cetBCDV8S2wNiIF1AHyooRWAe/tSY=;
        b=45vOZNa2N2ZeR2JXSujEKYa4M3tFPgjUQ9h/Xym0qN0kjXc17G5VI0EYdkATAkZ3Lo
         5z0E7wrk7U/Tkxnj404CSa1ST9UFZ4AqbStXcI58/VlJDNKfjYIJdLL6LViU+iMMCMHS
         LBz4OzctQG0BvCYRBl4FCKX1z2WQza8TFnQcoFuaVbv9OkH/7lN0lC74C01KrA10s7JV
         1H/IZuHE418NlpNAXr44BWtkcWr3ABL+K4NbMcDp3p4bgLsL8HZbqOWqxcRqVDRJKrXj
         PciAC0jLRntEr55SKDVWEtj4niEAYiCAxU31Stq0VN0I3J2DyCltISPXnSQc8PSfekCV
         okmg==
X-Gm-Message-State: ANoB5pkZnmpxIQATIjNoaBbxhPTBm11QJ+GI2n4AZ/fV+ogUPlTL9kCk
        vxZUfnaO98aeXtwQ4jhMiJMSaFWNwSPrN1Yu+3NHhnmj3LE8ST/vT8u/qXMRAJrwYpkk24pGy9R
        khU8j7jG9rkYG5+hogc9BpuER
X-Received: by 2002:a17:906:36d2:b0:7ae:9c7b:4d5c with SMTP id b18-20020a17090636d200b007ae9c7b4d5cmr6610694ejc.598.1668793673619;
        Fri, 18 Nov 2022 09:47:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6674asXcYMlwXIeAqeZcpNWB+Ml8RoaoS1i6tRUnXdDqv9oTJdkY86khk21Rzpsob0OPciOQ==
X-Received: by 2002:a17:906:36d2:b0:7ae:9c7b:4d5c with SMTP id b18-20020a17090636d200b007ae9c7b4d5cmr6610685ejc.598.1668793673439;
        Fri, 18 Nov 2022 09:47:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0073cf6ec3276sm1924617ejc.207.2022.11.18.09.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 09:47:53 -0800 (PST)
Message-ID: <c295e26b-283c-c643-f2ac-979466829227@redhat.com>
Date:   Fri, 18 Nov 2022 18:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH drm-misc-next v3 0/5] drm/arm/malidp: use drm managed
 resources
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>, daniel@ffwll.ch
Cc:     tzimmermann@suse.de, mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221026155934.125294-1-dakr@redhat.com>
 <Y3S+ZQ9gJVf9YYra@e110455-lin.cambridge.arm.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y3S+ZQ9gJVf9YYra@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Liviu, hi Daniel,

Thanks for submitting the patch series.

Unfortunately, I wasn't able to finish the work to make drm_dev_unplug() 
deal properly with non-hotunplug cases before my vacation, since I was 
working on another series. I'll finalize and submit it once I'm back in 
two weeks.

- Danilo

