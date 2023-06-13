Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C336772E2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbjFMM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjFMM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90D1FCD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686659249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CnFB1DNmO6T96vOB/65A5+oQ7wctSJhf7OTxF1Wbzs=;
        b=bBOAfgh4Xmnsc66WzSNZjdvRJlmyo/Rod0LRmzhNl/KOGBo5mCS8x2ckVwbX4/NXnA3bWe
        rCrVAp4G4nz6CURxj5dUUSDVxgyARTccCQ24Aj3KjD4cdyEh3Z/nWguv67iVRoNE86J+Eh
        G05askvt3RK7SvYINSaF2C1GAkDVL4s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ZI3OgeZOPFOowuws229kWA-1; Tue, 13 Jun 2023 08:27:28 -0400
X-MC-Unique: ZI3OgeZOPFOowuws229kWA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f63eed2413so3741855e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659247; x=1689251247;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CnFB1DNmO6T96vOB/65A5+oQ7wctSJhf7OTxF1Wbzs=;
        b=FEvIBlJhAgVBELIm0yTutJPdVx8yW7rbkGM8qLdNcCAmvPIo7ovixz5wq3Ou0DdaLP
         w08EoRM4giDwHuLgVfUblPwLsN8WssHBfbUUQVoPBZrDJ8Hppeb5so/hspIwYn5JAIz4
         oDvTCfqmLB4FuEV7cErFONjcZoq2P7lsG9mLyYBXZNiQKM8wUFzh+C7xSg8p5zTLXoSB
         QpmJcnowtUvmfWH7ozgoFAO/4WG+leJBY5O4edqhpKygTixl1lTUaTP9dlNSJicXqECk
         BdKbPU+KKqm3PwwU9Bw7TIgKyGrmJkjYjWEx2kpEc1ssJ/XKBEnyTI7w0jmf++U+D4/t
         qNjA==
X-Gm-Message-State: AC+VfDzFmMXA4K948RdrjMAtONo2oK+nqzPCUw5U2x3EC+9sgimYHuf3
        5nF4HxSxfP9rGLJsSolGSK2h7Zqa8zIw/Oojm+EtaLgLG6d3SlDo+JfUqMIoW3ZXJwCe7EDVjO1
        3nLGLyWCGphQslJNWEps1krE2Fz3cyc8x
X-Received: by 2002:a19:f248:0:b0:4f1:43b9:a600 with SMTP id d8-20020a19f248000000b004f143b9a600mr4757387lfk.60.1686659246351;
        Tue, 13 Jun 2023 05:27:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qxg+OUnNnuA/wq9a021d2mLhWsjtTUxn0p2SKKfWwVdEEV9g+Xp/WxtiQmQ4d7Ue+u9rDFA==
X-Received: by 2002:a19:f248:0:b0:4f1:43b9:a600 with SMTP id d8-20020a19f248000000b004f143b9a600mr4757320lfk.60.1686659245781;
        Tue, 13 Jun 2023 05:27:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b003f195d540d9sm14232474wmr.14.2023.06.13.05.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:27:25 -0700 (PDT)
Message-ID: <ab7853ca-70dd-b885-07df-c0764509997f@redhat.com>
Date:   Tue, 13 Jun 2023 14:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
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

On 13.06.23 02:10, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requires
> some core mm changes to function properly.
> 
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
> that the x86 implementation of it can know whether to create regular
> writable memory or shadow stack memory.
> 
> But there are a couple of challenges to this. Modifying the signatures of
> each arch pte_mkwrite() implementation would be error prone because some
> are generated with macros and would need to be re-implemented. Also, some
> pte_mkwrite() callers operate on kernel memory without a VMA.
> 
> So this can be done in a three step process. First pte_mkwrite() can be
> renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
> added that just calls pte_mkwrite_novma(). Next callers without a VMA can
> be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
> can be changed to take/pass a VMA.
> 
> Previous patches have done the first step, so next move the callers that
> don't have a VMA to pte_mkwrite_novma(). Also do the same for
> pmd_mkwrite(). This will be ok for the shadow stack feature, as these
> callers are on kernel memory which will not need to be made shadow stack,
> and the other architectures only currently support one type of memory
> in pte_mkwrite()
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

