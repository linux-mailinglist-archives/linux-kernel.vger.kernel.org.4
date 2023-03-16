Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B726BD252
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCPO1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCPO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13405C2D8D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678976782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+t0FQM1SXGREWQfdJtHY3I1HKU/ZnlZED0zT9n5/2Q=;
        b=iLMuDI7RJSJh+HVGVSdV2YXTfGY5Lu5GgipEvwgTD5Xix/GKNqEYl5LOv7zcQE6YhgZUNi
        Bh5Z1gVF+fhxXnCmFtVWzue+Q75KFNKX7fkYQzo9586WsjkcwVS9PkJG58gsvHGbIbsTiQ
        3vxh8ZuONDrQ1qWrPeuseVZVAoaSRag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-5awTnXjGMF2ie6--02E7Jw-1; Thu, 16 Mar 2023 10:26:21 -0400
X-MC-Unique: 5awTnXjGMF2ie6--02E7Jw-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so2702576wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+t0FQM1SXGREWQfdJtHY3I1HKU/ZnlZED0zT9n5/2Q=;
        b=Sete+PfXJfO6HP8WXaeL7m+aVbtS8vwONosB83iYOE43q4qQ9MjvguszggliJHa35q
         IGSGguTpvLAonnjdc8NNyDhhH/479j6GIuzfdY9aDNOQ6gLvfylbpg6yBCDm49IvfS4g
         IUjQLTFVo81XrVEWtYXDHfmtIMXfCsOUSOc6gLnrjUFbZzmO/5uFX8QNbzZmR9HtU3n/
         i6UgUw+59ivOJbARX7Hzq15ccfe0w8m/FxI/t781wkgAlgdofAMCZzSHiwItCNMe9XYF
         Gws2iOPLIjGLetgS2wOuxIeTkbV1Z2jPGiw9Q79rN5OZbgZ2Hj4PD31ltAK0XL7zzubL
         KJcQ==
X-Gm-Message-State: AO0yUKVmlLrGDJSqM95mzLvvccQ0KMVcrkwO3eHiPCL6B/0+d9GfOGph
        afOMXK9tcNlDc2rm4N6nwo2QTQpDH30poXUt83yCUonI+GG0RoGqgkZraB+31ZpIqwpRfbfYGmC
        Vcu5TlRh0avlb2Ps68vhK6Sd6
X-Received: by 2002:a05:600c:524c:b0:3ed:352a:a1d3 with SMTP id fc12-20020a05600c524c00b003ed352aa1d3mr6108088wmb.22.1678976779915;
        Thu, 16 Mar 2023 07:26:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9AFgIwgZtesQeZrKDqTHiyMJr7QX7EG8KXFGvafsXjEIbH9RVzYKFU5l/MjR2qG7KpTFB/bA==
X-Received: by 2002:a05:600c:524c:b0:3ed:352a:a1d3 with SMTP id fc12-20020a05600c524c00b003ed352aa1d3mr6108070wmb.22.1678976779650;
        Thu, 16 Mar 2023 07:26:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id l3-20020a1ced03000000b003ed29f5616dsm4998937wmh.4.2023.03.16.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:26:19 -0700 (PDT)
Message-ID: <904d2bd6-459f-aee9-226e-a94c4a0dab39@redhat.com>
Date:   Thu, 16 Mar 2023 15:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] KVM: x86: Fix kvm/queue breakage on clang
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20230315191128.1407655-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230315191128.1407655-1-seanjc@google.com>
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

On 3/15/23 20:11, Sean Christopherson wrote:
> Fix clang build errors for patches sitting kvm/queue.  Ideally, these
> fixes will be squashed before the buggy commits make their way to kvm/next.
> If you do fixup kvm/queue, the VMX commit also has a bad SOB chain; Jim
> either needs to be listed as the author or his SOB needs to be deleted.

I added it as Co-developed-by and squashed the patches.

Paolo

