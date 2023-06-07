Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB3725B85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjFGKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972501BE4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686133366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10WEMRlJl3R5JipFtSHmTTfpUyTlWcI4Le8JAbuqijA=;
        b=aNA8upD0CK6h2P4PTPt9k0o4UB66iDEFAxUTdFhu6SeZoOoWO0r5uRnvAtLsX7L30oQsBU
        ongVavF6vq/TgYvwi3pNdc1XTajdcx/DtDSJhe90rb19TIu29ngkWCNKW+TrJO+XwXkpSe
        HWP7oOiwOv9kRh537fqO6skv8qQSCrY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-F4mkgew7MMWmXyCFPKcm9Q-1; Wed, 07 Jun 2023 06:22:45 -0400
X-MC-Unique: F4mkgew7MMWmXyCFPKcm9Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e8c24a92so9410245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133364; x=1688725364;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10WEMRlJl3R5JipFtSHmTTfpUyTlWcI4Le8JAbuqijA=;
        b=UMmrJSMgxFIgRnKPIQcbzwxm1eKzmOTBj5EMF9LDrVUBKlZhqhFPjG6WjDYJtsiXkd
         LaO6E/xOYjJx8+NeuTq2y02/G2ot1cWUPy/f9ZiNDJhBuORaaM7Ia3lQPr56h3VCk32G
         NTgZPOm2B/UEJeSXrbgwclFjwNrUhV5SPSL8NMVGE9daNSxvDzqCXfG6OJauOdbWgybK
         Ep2p/xLcPxJqwYg06hiR6aygjZ66vYZMm2Duq1PYb1O+00HR3IuvD6aPgM6YA7KHdntf
         c5PT7c6Cyr1CuDIwOMEBbTRpQa3owv5BllkGW9bcBOwj/J/atKyPRHcvlCzqd7qIl3JN
         GYuQ==
X-Gm-Message-State: AC+VfDxo8A3YVDpXD4Dmvk5M9vQXHABNWZMTl1xrUrmdpFiZQNac63tA
        PrLkTcEXUJHtsf8KFVmBJWaeEnn6mQaX6n3YeVbz1qy6cTWif2ve1F7R1drZygesoyXCm+Zzbu/
        lcj80745od4H0swqXKwy23ko0744yQiyA
X-Received: by 2002:a1c:4c1a:0:b0:3f6:7fb:b60e with SMTP id z26-20020a1c4c1a000000b003f607fbb60emr4483939wmf.35.1686133364027;
        Wed, 07 Jun 2023 03:22:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ687U0HJXhqyPFlHBcyt7kCtziXIXhNePsOSbGYXltWRXRA/2DdJnAXRj3eC3703LUv42ipkg==
X-Received: by 2002:a1c:4c1a:0:b0:3f6:7fb:b60e with SMTP id z26-20020a1c4c1a000000b003f607fbb60emr4483919wmf.35.1686133363677;
        Wed, 07 Jun 2023 03:22:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f734ee1670sm1631931wmf.31.2023.06.07.03.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 03:22:43 -0700 (PDT)
Message-ID: <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
Date:   Wed, 7 Jun 2023 12:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Haifeng Xu <haifeng.xu@shopee.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.23 12:16, Michal Hocko wrote:
> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
>> If freesize is less than dma_reserve, print warning message to report
>> this case.
> 
> Why?

I'd like to second that question, and add

a) Did you run into that scenario?
b) What can an admin do in that case with that error messages?

If it reveals a buggy situation, maybe a WARN_ON_ONCE() is warranted ... 
but maybe only if anybody actually ran into that issue.

-- 
Cheers,

David / dhildenb

