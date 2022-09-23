Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B75E7521
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIWHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWHry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04CE248D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663919272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+P/fMW7VDMnmP5VRBiHacncvYL8dIY+LMFFHhigG8Q=;
        b=EFe5ezpAqPuvYdUVUYm1eD8sQMmZyT4esZ5FuCnQFOERNaBbPBGu8H1i+oh24PFbzfQTTI
        7R+KeWUIlTUq5IzNnXC6GUmkc/kWrNyJSVo9VszsKfB71iWP5E44ZQJEFbdznEzaH4v1g8
        4QZEc+pS2jp61m+CLbZtkq4f/XGyslE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-505-mDYvXDE1PqukDptpKf-iSw-1; Fri, 23 Sep 2022 03:47:51 -0400
X-MC-Unique: mDYvXDE1PqukDptpKf-iSw-1
Received: by mail-wm1-f70.google.com with SMTP id r7-20020a1c4407000000b003b3309435a9so1938176wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/+P/fMW7VDMnmP5VRBiHacncvYL8dIY+LMFFHhigG8Q=;
        b=Y6Z0W0ncFwFZf+BOo6Aa2kgj/UAWaZuWh755y032FFuHj4RSCBuJC4LicfguIsDSh9
         h7xUBJ2w1Sdcf/st7WDAaWlqMHPRvo6ONC03e4uzJu+IYn/qJOuOIRLQ2RW66NgpaGpH
         4NJCPBW2zn1xqqL/KLsQy2pFOt9aTABMjbScnkVq1L9c3AzxVSSdsj0fbR1frx0gxYni
         MstReB+JbtvRfWXNiX+MQ22SIgzi5fdymzuxdGw9srwOiJKfgKqJ62kdcG65J0S9JOil
         e6ayiuCAcfRMLFk/F1G4kDAUEVyFL10XTZAzuU6subbatT1Fm8iu8fgqp69Wr98ARWYw
         dZRg==
X-Gm-Message-State: ACrzQf1sHxSRkJb7v63oe7fClmGG+QudiKY+hc/nXtTELUR7qZ0RvX5H
        Hy27Z8ECfM+vq6KPmlg5aMLkIQnpcxlOY1CgmnZZLppVJ08tO7SmjpeaOxayZBm9zGDD3fzTrn4
        0spjBuV8KfBHWGVxGwIpkDfaW
X-Received: by 2002:a05:600c:6025:b0:3b4:8c0c:f3c9 with SMTP id az37-20020a05600c602500b003b48c0cf3c9mr11665690wmb.206.1663919270123;
        Fri, 23 Sep 2022 00:47:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7a95m6opm7J4WD6s/vx9Rcuct08uvQpDL9tFS6iwAukDQSmGR/COOIY7aqMip2kcbGqylyIA==
X-Received: by 2002:a05:600c:6025:b0:3b4:8c0c:f3c9 with SMTP id az37-20020a05600c602500b003b48c0cf3c9mr11665675wmb.206.1663919269777;
        Fri, 23 Sep 2022 00:47:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:cc00:4585:a83b:64f2:ad21? (p200300cbc704cc004585a83b64f2ad21.dip0.t-ipconnect.de. [2003:cb:c704:cc00:4585:a83b:64f2:ad21])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm2077518wmq.45.2022.09.23.00.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 00:47:49 -0700 (PDT)
Message-ID: <9c4af0f9-22ff-4e4f-58c7-65808d55ca67@redhat.com>
Date:   Fri, 23 Sep 2022 09:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4 7/8] memory: remove unused
 register_hotmemory_notifier()
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Christoph Lameter <cl@linux.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220923033347.3935160-1-liushixin2@huawei.com>
 <20220923033347.3935160-8-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220923033347.3935160-8-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.22 05:33, Liu Shixin wrote:
> Remove unused register_hotmemory_notifier().
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   include/linux/memory.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index aa619464a1df..98d2a2ebcc10 100644
> --- a/include/linux/memory.h

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

