Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321166163F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKBNlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKBNlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C22AC60
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667396425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ijbFF0H/xCdH726+uTnvXQpvPZW6ByxgMWw5uU67hZo=;
        b=KdVf4YNKPbDK5dNacv0XfJLFrVLQZ/fgT2bGwPNPjZvhW1gT7Ttm2t2AYvUWGLyznn1DkE
        5mbv8Nghjjg72Rk+RvJ+CX/4hbVoWGNst2cchovRY3l6ziPxil1cLC+g6xUYXrknbuXpP9
        L7wLunGQmYuku2bLx6m26CvWUbwlcxw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-68TQfd2DM1is9NmDJ3sHUw-1; Wed, 02 Nov 2022 09:40:23 -0400
X-MC-Unique: 68TQfd2DM1is9NmDJ3sHUw-1
Received: by mail-ej1-f72.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so5728395ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijbFF0H/xCdH726+uTnvXQpvPZW6ByxgMWw5uU67hZo=;
        b=LuUMcU0Emrqa5XDpvWeXUd+CwbujSUdzkdsOJ9k4YI2fpJne4OaRnPu7xPKneGYmAX
         FFyfmP9/uzB7pjb5s3e0oSa7TNHYSFdyHJb/BL2I8/Z6evzGADL0gLNrARHQGJIfgHW8
         h4eyT5+KCLHG48IyKfk44ESAlVwdIA0c99mU1ylxOO/sNp91oYPwDAsad/I1L0ed/OlP
         bYZR3+hTsIC15/UDbMAUhZtSADDFu8Nj1s22nCVYcsLDadDWJeObWUVc7dPE255oT27P
         w8qB/p8eVw6AJjhI+OVFBZ8dYHvpzpIhxGW5BSzSlwVj6/yc7430vfPkad5PUXFsi8QS
         0HwA==
X-Gm-Message-State: ACrzQf3cVTcq8PWsKbbbOO2WbM7+6pcozrEeFeNjiqexiTOme1AeVkl+
        0T77uQCj7wSd9VFg/2nwksq8a/pAvz6e7Smm9ueWsjSDJBaqKEgNkzTj3IsxyksgmYEOW72oqRw
        makLoq9J4+TYmwmXbKqsgduFz
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id hy12-20020a1709068a6c00b007a82f09d88dmr23410427ejc.49.1667396422547;
        Wed, 02 Nov 2022 06:40:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7THT0zUdd+gaQKQVjw1hUNTdgrVAacvK5K9pvBd4DnFuaiL9Pt4e5ApNNFqqflSgh+2NrUjA==
X-Received: by 2002:a17:906:8a6c:b0:7a8:2f09:d88d with SMTP id hy12-20020a1709068a6c00b007a82f09d88dmr23410402ejc.49.1667396422319;
        Wed, 02 Nov 2022 06:40:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id eg35-20020a05640228a300b004638ba0ea96sm2998079edb.97.2022.11.02.06.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 06:40:20 -0700 (PDT)
Message-ID: <fd2cf028-bd83-57ff-7e6d-ef3ee11852a1@redhat.com>
Date:   Wed, 2 Nov 2022 14:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/5] perf/x86/intel/lbr: use setup_clear_cpu_cap
 instead of clear_cpu_cap
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
References: <20220718141123.136106-1-mlevitsk@redhat.com>
 <20220718141123.136106-2-mlevitsk@redhat.com> <Yyh9RDbaRqUR1XSW@zn.tnic>
 <c105971a72dfe6d46ad75fb7e71f79ba716e081c.camel@redhat.com>
 <YzGlQBkCSJxY+8Jf@zn.tnic>
 <c1168e8bd9077a2cc9ef61ee06db7a4e8c0f1600.camel@redhat.com>
 <Y1EOBAaLbv2CXBDL@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y1EOBAaLbv2CXBDL@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 10:59, Borislav Petkov wrote:
> On Wed, Sep 28, 2022 at 01:49:34PM +0300, Maxim Levitsky wrote:
>> Patch 5 is the main fix - it makes the kernel to be tolerant to a
>> broken CPUID config (coming hopefully from hypervisor), where you have
>> a feature (AVX2 in my case) but not a feature on which this feature
>> depends (AVX).
> 
> I really really don't like it when people are fixing the wrong thing.
> 
> Why does the kernel need to get fixed when something else can't get its
> CPUID dependencies straight? I don't even want to know why something
> would set AVX2 without AVX?!?!

Users do so because they just "disable AVX" (e.g. in QEMU -cpu 
host,-avx) and that removes the AVX bit.  Userspace didn't bother to 
implement the whole set of CPUID bit dependencies for AVX because:

1) Intel is adding AVX features every other week and probably half the 
time people would forget to add the dependency

2) anyway you absolutely need to check XCR0 before using AVX, which in 
the kernel is done using cpu_has_xfeatures(XFEATURE_MASK_YMM), and 
userspace *does* remove the XSAVE state from 0Dh leaf if you remove AVX.

(2) in particular holds even on bare metal.  The kernel bug here is that 
X86_FEATURE_AVX only tells you if the instructions are _present_, not if 
they are _usable_.   Indeed, the XCR0 check is present for all other 
files in arch/x86/crypto, either instead or in addition to 
boot_cpu_has(X86_FEATURE_AVX).

Maxim had sent a patch about a year ago to do it in aesni-intel-glue.c 
but Dave told him to fix the dependencies instead 
(https://lore.kernel.org/all/20211103124614.499580-1-mlevitsk@redhat.com/). 
  What do you think of applying that patch instead?

Thanks,

Paolo

