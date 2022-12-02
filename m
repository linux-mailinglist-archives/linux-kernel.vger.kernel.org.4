Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C07640D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiLBS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiLBS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379655FC8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670005662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54ctooy2QqFYuJAUYh1DElEphCo1HVKkIgS8Rlu6y1s=;
        b=STT/hajNgav/BmVQD2sRJ+7IG2T95inCcYl5wbLZz18p+MZMOl7dsxDB/8PEt7b+sslUHM
        RyLZFW+TffKiX3f1BDJ+6xmw0werntPw08OarPQG+IKlvElCdYVUMY9ewDo9+ZMWH1grKo
        Dj65x47RHxcgzqJcdQqhZR7pS2GOCfE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-g37Wa3yoPp2jHJ8ayrtkFQ-1; Fri, 02 Dec 2022 13:27:41 -0500
X-MC-Unique: g37Wa3yoPp2jHJ8ayrtkFQ-1
Received: by mail-wm1-f69.google.com with SMTP id 6-20020a1c0206000000b003d082ecf13cso1521576wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54ctooy2QqFYuJAUYh1DElEphCo1HVKkIgS8Rlu6y1s=;
        b=cS20jnEFeJ4aEYOCf63+3yeazZJFiLezoOkHUZjOMTJ+tjeNDVWXb0W08/tL66itY7
         HqW4Qm5qRz9bj7Ibht6VhpGzzqX2/CXWHvYpqxy2Ll6/I26lIw/5uMeglqcgB5CAChgM
         Wez36ETiGb/SoI9j6Pk16E6knMVsNiu3SVCNnRjzELQ4O814N409ZWaD8G/NiOPmxdlE
         0w+G+1JD6zGLHJT2OoxO7W4NXij+GQi+2vDPC30pODxOY74w764gd2dBb883vcXQ0wHw
         XIid2fzh7VlOsevrXgIqUDFB2FEGjW944U7FgeRiCygzrTuoAcgugd0d/o2hZm5F7Mql
         4/Cg==
X-Gm-Message-State: ANoB5pmPV+oLKQM7El6223r+RxJBNIpOk1BVxImmGLEehEgBz9LW1SDM
        S9pL96as8jtvyf6Upa09XvIBfbO+Ek3M0J2Y+lbU10HThj3hRgoW97SSZrJ6A7ljgg8f52OgP9U
        QBRDEM5fFY73WUmqhx+AGIO8V
X-Received: by 2002:a5d:4247:0:b0:241:a82b:5dee with SMTP id s7-20020a5d4247000000b00241a82b5deemr33101734wrr.425.1670005660258;
        Fri, 02 Dec 2022 10:27:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4bv7vlxU81ieqvd+1vTTRoDR95EdMlYVUn4OoUKLb4/+a4NyF4K4UfXapKxpaQkNnmTY+sig==
X-Received: by 2002:a5d:4247:0:b0:241:a82b:5dee with SMTP id s7-20020a5d4247000000b00241a82b5deemr33101729wrr.425.1670005660048;
        Fri, 02 Dec 2022 10:27:40 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c315100b003cfd64b6be1sm17954901wmo.27.2022.12.02.10.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:27:39 -0800 (PST)
Message-ID: <4405c412-f9df-ed43-8050-4d4a90d5dcc5@redhat.com>
Date:   Fri, 2 Dec 2022 19:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
Content-Language: en-US
To:     Space Meyer <spm@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kpsingh@kernel.org
References: <20221130161946.3254953-1-spm@google.com>
 <e43ffb47-6526-6b2d-f7b3-0755f3c54a71@redhat.com>
 <CAOLenvaUpnk=w7TSArwK-WqUsQDQ=GY=vOHcW4apH1E5hWTCJg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAOLenvaUpnk=w7TSArwK-WqUsQDQ=GY=vOHcW4apH1E5hWTCJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 16:52, Space Meyer wrote:
>> Also, this does not work I think, because there is
>> add_wait_queue()/remove_wait_queue() pair.  Adding it is not easy
>> because KVM is using a struct rcuwait here instead of a wait_queue_t.
> Ah, sorry. I really was a bit quick on this one. I agree nothing would ever call
> woken_wake_function, hence my patch doesn't make sense. Looking at the rcuwait
> code I don't see something similar to wait_woken.
> 
> Do you see some other way we could avoid the pattern susceptible to the nested
> sleeping problem?

No, I think we should just treat them as bugs and fix them.

Paolo

