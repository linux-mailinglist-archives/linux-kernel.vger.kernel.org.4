Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D829D7294A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjFIJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbjFIJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46854691
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686301872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lS4qtD2LImPdpu4Ozd1FIICWXob78VQWCuBmNpNqeU=;
        b=DicECw0HM5Qbsnt9tKJKT23jXtCdmxkd62vrvgbm3rIdnxdDRx7ae8CSb3aSM5bNsf44ft
        McMhWc/LT1YUIKoAbyOS9bs0AMzT3fnZ+bDWxNQb4poc6Am6n1iF4CIUjhSa2tFF8J1KJ3
        8tvD1sXhLNY5Tw7ztWbHXsHxOqp5fdQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-mkwWysXkMGiWiG6FNY3HHQ-1; Fri, 09 Jun 2023 05:08:02 -0400
X-MC-Unique: mkwWysXkMGiWiG6FNY3HHQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a341efd9aso186737266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301681; x=1688893681;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lS4qtD2LImPdpu4Ozd1FIICWXob78VQWCuBmNpNqeU=;
        b=Sm2ER3xch9E9iXKpWfbfd56f71yZRLaEqWvA5O6aAF54GXkTC4s4nPDPLSoGRXabJW
         M6xDnVHgx6VREvpZ4rtf7xqZ2V6UN2OtoF1Na94Tep6Y3d1XK9LqAvEgoMiEBPvvEygA
         V3Nrwaou/K63OCRK5Tuh/0jU8p9zMS9709kRTOW5RiUInnHX5KTZfhFGxmHOyj6bbD3i
         VuNnhJys8noE84HYPk8ToiA2l9iB2pafWFUxwtLjBZJF/pQO3jl3kOcfjmOnpAJSi9HZ
         gmBUORTq7vpMIL/lNLxajpASGL+3w1tSdQIYD+FQlg9n+59h+P+c7K+jndNUD56G7bGq
         LJBQ==
X-Gm-Message-State: AC+VfDweXRcoREpDJgEboSxOz8lrW9bNU3dV5L7NveI7thQclMb4N/G3
        V0mnvy3wqdutHYM36AsbeKQ2gvpw51iBhfL4xI8/J4ArO2zdIjZbRvvbXgPSLdyhIKAqj/g7iM0
        ZqaburQqUpR01yrJ8WhqZo0CG
X-Received: by 2002:a17:907:94cb:b0:97a:e0c0:2f8f with SMTP id dn11-20020a17090794cb00b0097ae0c02f8fmr315219ejc.65.1686301681501;
        Fri, 09 Jun 2023 02:08:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fk08I4RsyK9p9wcnjDRbMYLy3XBaoHlqt3xl1DLkFDODgHMHCV4XPzuR/CPTVwoW0y6Qefw==
X-Received: by 2002:a17:907:94cb:b0:97a:e0c0:2f8f with SMTP id dn11-20020a17090794cb00b0097ae0c02f8fmr315171ejc.65.1686301681128;
        Fri, 09 Jun 2023 02:08:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id z8-20020a1709067e4800b00977ecf6942bsm1036209ejr.90.2023.06.09.02.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 02:08:00 -0700 (PDT)
Message-ID: <26cf0b0a-cda5-08a9-a669-6966f9e626b1@redhat.com>
Date:   Fri, 9 Jun 2023 11:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com
References: <20230526234435.662652-1-yuzhao@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH mm-unstable v2 00/10] mm/kvm: locklessly clear the
 accessed bit
In-Reply-To: <20230526234435.662652-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/23 01:44, Yu Zhao wrote:
> TLDR
> ====
> This patchset adds a fast path to clear the accessed bit without
> taking kvm->mmu_lock. It can significantly improve the performance of
> guests when the host is under heavy memory pressure.
> 
> ChromeOS has been using a similar approach [1] since mid 2021 and it
> was proven successful on tens of millions devices.
> 
> This v2 addressed previous requests [2] on refactoring code, removing
> inaccurate/redundant texts, etc.
> 
> [1]https://crrev.com/c/2987928
> [2]https://lore.kernel.org/r/20230217041230.2417228-1-yuzhao@google.com/

 From the KVM point of view the patches look good (though I wouldn't 
mind if Nicholas took a look at the ppc part).  Jason's comment on the 
MMU notifier side are promising as well.  Can you send v3 with Oliver's 
comments addressed?

Thanks,

Paolo

