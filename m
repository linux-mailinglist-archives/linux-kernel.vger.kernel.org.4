Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339A6CBA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjC1JVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjC1JV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D25252
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679995240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmenFZrPmab5EsKw3TDMXYEC3Wdv3EkUt5K0GPSSZs0=;
        b=fz7l7tiKbQlSyglQ8VimGjBmkU9MMDEulhBOabibeOBY1SLdChJl2CAwG8YO31Mb1RM914
        k1VQPKZSXJ7lkUnYfuS/bs86otIR7vUfL5kWRQFSV5yc6F8PpvoBGM7Tl4vtlNsDiJGxpS
        K3+0cCL9Lb/VU9ZdrQ5Y2oB8MRDQYsw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-CTcXMRQgOoW-qAB61ofMZg-1; Tue, 28 Mar 2023 05:20:39 -0400
X-MC-Unique: CTcXMRQgOoW-qAB61ofMZg-1
Received: by mail-wm1-f71.google.com with SMTP id bi5-20020a05600c3d8500b003edda1368d7so6118512wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmenFZrPmab5EsKw3TDMXYEC3Wdv3EkUt5K0GPSSZs0=;
        b=3/mFvWj9lJRIr0/sshmJRpiJ+jOtep7Xuf9MUYHjJJWbNnc+BzC0WY5gZoeU7uSlhC
         XjcNEZo9B4pgyHWHxksUUJQZfmHolzogj+Zm8yVY/Qfca0Tmw3SpqwkEbq0XJn1b8mnJ
         iFeSDuwvHZ3dFeAUkR3QQc+sES5kv8cv+Phh8Qe7cQcOy38UaWnJusZeP6DUMNYMsmaw
         B2cWu1YRGY9fUub/EgL8fjvFFFvzYMIcphoHMviWpV24Yy4dXcVefI21liOzrYqu09Pp
         OnwulAk/BiLILFphOhpGjuJye0SPOjJpHSMNH3Cs6KHsl72y6OQTgaLi3hGVDnmrstIj
         12xQ==
X-Gm-Message-State: AAQBX9cdmhyXw9f6GHKXw7s6RV64OK6bOU/M1jk2i5HO3hxGr9WHqwir
        JpkGoGmDsnj+wM8dEN4ghHokjW4fPp1F4idESICHFFOKECraHRT9sum1S8LpteNSMu/1nYKLBo2
        179sKMmyNxd/u9ldMY5dTuLsgAXxiejDarI8=
X-Received: by 2002:a5d:4b0d:0:b0:2d7:8254:bc14 with SMTP id v13-20020a5d4b0d000000b002d78254bc14mr11626369wrq.47.1679995238003;
        Tue, 28 Mar 2023 02:20:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzbnxZqk7E1yEYPpAjTaJXCiLIyKzmOLraPzZ/v8H+G8UaOf8S3BcIKhbMbICZjtEJDUPb6w==
X-Received: by 2002:a5d:4b0d:0:b0:2d7:8254:bc14 with SMTP id v13-20020a5d4b0d000000b002d78254bc14mr11626354wrq.47.1679995237687;
        Tue, 28 Mar 2023 02:20:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm20275639wrt.73.2023.03.28.02.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:20:36 -0700 (PDT)
Message-ID: <fce5c1ad-24a3-febf-127e-e97238492143@redhat.com>
Date:   Tue, 28 Mar 2023 11:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] KVM: x86/pmu: Fix emulation on Intel counters' bit
 width
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322093117.48335-1-likexu@tencent.com>
 <CABgObfYfiUDf4zY=izcg_32yGCbUxxVc+JAkHGHwiQ0VmGdOgA@mail.gmail.com>
 <871434fe-ae80-bec6-9920-a6411f5842c0@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <871434fe-ae80-bec6-9920-a6411f5842c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 11:16, Like Xu wrote:
> 
> 
> If IA32_PERF_CAPABILITIES.FW_WRITE[bit 13] =1, each IA32_PMCi is 
> accompanied by a
> corresponding alias address starting at 4C1H for IA32_A_PMC0.
> 
> The bit width of the performance monitoring counters is specified in 
> CPUID.0AH:EAX[23:16].
> If IA32_A_PMCi is present, the 64-bit input value (EDX:EAX) of WRMSR to 
> IA32_A_PMCi will cause
> IA32_PMCi to be updated by:
> 
>      COUNTERWIDTH =
>          CPUID.0AH:EAX[23:16] bit width of the performance monitoring 
> counter
>      IA32_PMCi[COUNTERWIDTH-1:32] := EDX[COUNTERWIDTH-33:0]);
>      IA32_PMCi[31:0] := EAX[31:0];
>      EDX[63:COUNTERWIDTH] are reserved
> 
> ---
> 
> Some might argue that this is all talking about GP counters, not
> fixed counters. In fact, the full-width write hw behaviour is
> presumed to do the same thing for all counters.
But the above behavior, and the #GP, is only true for IA32_A_PMCi (the 
full-witdh MSR).  Did I understand correctly that the behavior for fixed 
counters is changed without introducing an alias MSR?

Paolo

