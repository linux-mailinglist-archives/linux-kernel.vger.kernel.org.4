Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F867C01F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjAYWoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjAYWox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067636446
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674686644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KLbKwODJaOigvAcLcDeGQGOJa4mEOCY0SOM+5pGAPuQ=;
        b=TmTu09OdQurQQjycM3pwNLQnQQBhQHSd5VqQ24jtSPApT53yncsBJRir564DFCIxuBQGw0
        7bWe+1aKGpRGCaeUim9wVLTfa50xfmIT5PTMOv941H4oEX5CBYBZs9g8EL9Gqx6xximI+m
        u889hDY5RWMKqaxvsqjAKThSRyJpUhI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-hNLK7brKNEa2JpF5CrrfWA-1; Wed, 25 Jan 2023 17:44:02 -0500
X-MC-Unique: hNLK7brKNEa2JpF5CrrfWA-1
Received: by mail-ed1-f71.google.com with SMTP id t17-20020a056402525100b0049e0d2dd9b1so183133edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLbKwODJaOigvAcLcDeGQGOJa4mEOCY0SOM+5pGAPuQ=;
        b=gRbIsyKixIUZx5E7WVM0vgS15cJbeRdW0XI40pvbUX/rnQYIglXadPiOZwsLx/FSWy
         aU5xxR5n+NKyFV6iP5fOma6yCVUMPYy0y9sbKvOI4FzAaW5509DQIMj+4zXXPS4L1vPv
         d4Qyff0kyxkjGBSYDLCHKki784saNnLqlvryLxLAGDZHbeEnI5fE+4gpzXGX9iW7KX8n
         CnQu1q/Xm0BrzuGQfA9IIWygPYcbbQri0mEl5BoKhqvJ7ztZdgYMA1uxGSia4+MfZuHG
         EeUCDi0bYhuU5KIopmYW2Zl5NVxWX2aVMrCMtbvBokP1a+iPCI7PzcY757ej/t3dNDJc
         Qdgg==
X-Gm-Message-State: AFqh2koPHqpoX21P7dPeqOPEgbO3zzdSMq5FTnsEGg5mZd1F8DZWd/cj
        tMfokY/+JpYquB0F13MVYzP/mMYwmTZv6OQrlrbv185TzQCVlIsGOZQur71mIB4faTI/M18NVpS
        LmFOAncj7Tx1qXCMplDnjf64Z
X-Received: by 2002:a17:906:b78b:b0:877:60aa:7081 with SMTP id dt11-20020a170906b78b00b0087760aa7081mr30468525ejb.22.1674686641559;
        Wed, 25 Jan 2023 14:44:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsF9rG7NEbV4kTmoPrQ6fv3l2ffKJPwc0x73+fD4Ik30Ilpoo75g1U/Oil1SDEclFHq7VBmgA==
X-Received: by 2002:a17:906:b78b:b0:877:60aa:7081 with SMTP id dt11-20020a170906b78b00b0087760aa7081mr30468514ejb.22.1674686641261;
        Wed, 25 Jan 2023 14:44:01 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id e4-20020a17090681c400b008785b27b36fsm140778ejx.138.2023.01.25.14.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 14:44:00 -0800 (PST)
Message-ID: <dec8c012-885a-6ed8-534e-4a5f0a435025@redhat.com>
Date:   Wed, 25 Jan 2023 23:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, stable@vger.kernel.org
References: <20221027092036.2698180-1-pbonzini@redhat.com>
 <CALMp9eQihPhjpoodw6ojgVh_KtvPqQ9qJ3wKWZQyVtArpGkfHA@mail.gmail.com>
 <3a23db58-3ae1-7457-ed09-bc2e3f6e8dc9@redhat.com>
 <CALMp9eQ3wZ4dkq_8ErcUdQAs2F96Gvr-g=7-iBteJeuN5aX00A@mail.gmail.com>
 <8bdf22c8-9ef1-e526-df36-9073a150669d@redhat.com>
 <CALMp9eRKp_4j_Q0j1HYP2itT2+z3pRotQK8LwScMsaGF5FpARA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Do not return host topology information from
 KVM_GET_SUPPORTED_CPUID
In-Reply-To: <CALMp9eRKp_4j_Q0j1HYP2itT2+z3pRotQK8LwScMsaGF5FpARA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 23:09, Jim Mattson wrote:
> The topology leaves returned by KVM_GET_SUPPORTED_CPUID *for over a
> decade* have been passed through unmodified from the host. They have
> never made sense for KVM_SET_CPUID2, with the unlikely exception of a
> whole-host VM.

True, unfortunately people have not read the nonexistent documentation 
and they are:

1) rarely adjusting correctly all of 0xB, 0x1F and 0x8000001E;

2) never bounding CPUID[EAX=0].EAX to a known CPUID leaf, resulting for 
example in inconsistencies between 0xB and 0x1F.

*But* (2) should not be needed unless you care about maintaining 
homogeneous CPUID within a VM migration pool.  For something like 
kvmtool, having to do (2) would be a workaround for the bug that this 
patch fixes.

> Our VMM populates the topology of the guest CPUID table on its own, as
> any VMM must. However, it uses the host topology (which
> KVM_GET_SUPPORTED_CPUID has been providing pass-through *for over a
> decade*) to see if the requested guest topology is possible.

Ok, thanks; this is useful to know.

> Changing a long-established ABI in a way that breaks userspace
> applications is a bad practice. I didn't think we, as a community, did
> that. I didn't realize that we were only catering to open source
> implementations here.

We aren't.  But the open source implementations provide some guidance as 
to how the API is being used in the wild, and what the pitfalls are.

You wrote it yourself: any VMM must either populate the topology on its 
own, or possibly fill it with zeros.  Returning a value that is 
extremely unlikely to be used is worse in pretty much every way (apart 
from not breaking your VMM, of course).

With a total of six known users (QEMU, crosvm, kvmtool, firecracker, 
rust-vmm, and the Google VMM), KVM is damned if it reverts the patch and 
damned if it doesn't.  There is a tension between fixing the one VMM 
that was using KVM_GET_SUPPORTED_CPUID correctly and now breaks loudly, 
and fixing 3-4 that were silently broken and are now fixed.  I will 
probably send a patch to crosvm, though.

The VMM being _proprietary_ doesn't really matter, however it does 
matter to me that it is not _public_: it is only used within Google, and 
the breakage is neither hard to fix in the VMM nor hard to temporarily 
avoid by reverting the patch in the Google kernel.

Paolo

