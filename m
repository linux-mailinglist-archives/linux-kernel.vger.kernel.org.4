Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD996D1F55
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCaLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCaLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:41:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B451EA11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:40:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so15123195wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680262840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BMda4uP/trXOPVFbxA+44piSZybxeHCQYh1voebKMY=;
        b=KrfJ+JLUhiklGuQ0qODImm/axxyEiVkecB4sK8IKbUhsoUeJMyhW/jzDbm/eFnTSDn
         qHWkSqXGrFpua1u7aLcPeMLLjsAOkSZhERpQ1lZzDCIvUPo5h3MxQrUGHTCgjFCvzLgL
         ymlxxrZvMM11Y6Lr/Vzo+VLUY1C9L3P/Ms6q5duVI9o+tGZjU7NrDSp5O8rC387qiYfY
         885BRfMAk/DgNlOejW5WZuJW0QHM6/dKPQLTowFCPxBi67uSQxcb8VBaLYJPiC3iHZqs
         /3HycxrKcjZmgm+IKlOotX+L7+zEZ5+sJZ6sak8RJsw6LBJA7fKec+dmTVEWi0wzSuB8
         GpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680262840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BMda4uP/trXOPVFbxA+44piSZybxeHCQYh1voebKMY=;
        b=vSB1Dk5soU2jECZvAhOSwMAu78dRVQpgwBFbkH/3CUtLt9XIK20cEj4cUB8We1E6wA
         LiYiU79Nirl2XtfyXHtPPSxsNE/5ylSHtK+I00Wm3wTiLWRcSMB7vWcvIQfZAjyuEAwM
         l+mYyzb33G7ARIPR8kgL2cIt0k2fznTkPGMgBIbo0QFoYxeTVl6oEG5Y642iZhaP85Wk
         TiXOQrFrj2i2/+YH/9gBZ0V0rlPB77jFz5ZAhF+dxfUSohHFKponYINyH87gmoLoskMV
         jSIW69VFcjwI01kYW49xc5jA25UWAugejoqx+7XG4tL2KsW+rKVjdmkKaW8UdtmbC6Wz
         ooZg==
X-Gm-Message-State: AAQBX9cY+2N9K/K5uc2nrSqDltFPWjyxpICbhusMQrsE7e4uPI1hxnGa
        vIJvkLWRdBVRKHgujw/aw905Pw==
X-Google-Smtp-Source: AKy350akXFV8HM8s/Ha6Lz3ESFXQ5hdrtXgaWbnYOF6NFoTV9iTpZm5oM2jthlq8wOd0t4RVLzWtXA==
X-Received: by 2002:a7b:c852:0:b0:3ef:64b4:b081 with SMTP id c18-20020a7bc852000000b003ef64b4b081mr16262072wml.39.1680262839961;
        Fri, 31 Mar 2023 04:40:39 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b566:0:668d:6a39:bcbb:5910? ([2a02:6b6a:b566:0:668d:6a39:bcbb:5910])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003edff838723sm2451209wml.3.2023.03.31.04.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 04:40:39 -0700 (PDT)
Message-ID: <144fbadc-8d27-796b-0263-ff2662b283ae@bytedance.com>
Date:   Fri, 31 Mar 2023 12:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v17 6/8] x86/smpboot: Send INIT/SIPI/SIPI
 to secondary CPUs in parallel
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, dwmw2@infradead.org,
        kim.phillips@amd.com, brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>
References: <20230328195758.1049469-1-usama.arif@bytedance.com>
 <20230328195758.1049469-7-usama.arif@bytedance.com> <87v8iirxun.ffs@tglx>
 <CAFC43E6-97E9-4E89-AABB-78E31037048A@alien8.de> <87sfdmrtnj.ffs@tglx>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <87sfdmrtnj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2023 19:17, Thomas Gleixner wrote:
> On Thu, Mar 30 2023 at 19:05, Borislav Petkov wrote:
> 
>> On March 30, 2023 6:46:24 PM GMT+02:00, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> So that violates the rules of microcode loading that the sibling must be
>>> in a state where it does not execute anything which might be affected by
>>> the microcode update. The fragile startup code does not really qualify
>>> as such a state :)
>>
>> Yeah I don't think we ever enforced this for early loading.
> 
> We don't have to so far. CPU bringup is fully serialized so when the
> first sibling comes up the other one is still in wait for SIPI lala
> land. When the second comes up it will see that the microcode is already
> up to date.
> 

A simple solution is to serialize load_ucode_ap by acquiring a spinlock 
at the start of ucode_cpu_init and releasing it at its end.

I guess if we had topology_sibling_cpumask initialized at this point we 
could have a spinlock per core (not thread) and parallelize it, but 
thats set much later in smp_callin.

I can include the below in next version if it makes sense?

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80a688295ffa..b5e64628a975 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2155,10 +2155,13 @@ static inline void setup_getcpu(int cpu)
  }

  #ifdef CONFIG_X86_64
+static DEFINE_SPINLOCK(ucode_cpu_spinlock);
  static inline void ucode_cpu_init(int cpu)
  {
+       spin_lock(&ucode_cpu_spinlock);
         if (cpu)
                 load_ucode_ap();
+       spin_unlock(&ucode_cpu_spinlock);
  }

