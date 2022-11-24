Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B274F6374C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKXJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiKXJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:07:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25448114BA9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:07:17 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 136so1096005pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpL02dGcoTUalThfsMc31KdRPIILnilJbSOEG5Kb9y4=;
        b=xuOWLB3Iz4pLV8nX5PJJwG5wnnDiw+8nv1bEH0tn67EhN3Qn9j8udQ7KhDgolwrhog
         5q8qP9nBckLfPqZZZOAdlVR4Av+Ss86Bt809mCKDiP4x62zuyW4NPQNox/o/VPl+eFd0
         I/tu3n4zSJASsbLouZo3Fzo6nBp7rLnzAL7SqVaPid6Qi00PB+8X/+KYLsaUrURweUtx
         VENIRuByfidHHg5PIn2M79yzDA99P5zcVQ+VeYjJNNKlgMCjZcewq9xsWA89guIN7IAC
         mQCinBYiEsFZAjGhjfOVsNyuAsmPPLaA2blFXFq4ZKabk0+XanY32bRJ6yZXZSux0+68
         97aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpL02dGcoTUalThfsMc31KdRPIILnilJbSOEG5Kb9y4=;
        b=IBymxjgr0lWNV/T4Zu914lFfCkqjf3aP6ByU82WZ2BaGDxwx6sY1D3m7wid+KykpKE
         tX3Ic5yyyJSVGCgnw6Xc9XyB4VzZ5DrlcLOLAMFyXOQzKqW0sqSfTTNWviZpUWekhscB
         3XNUPgUZJIrn6AX9YkIBvfMbMi4Qxkn+wxIuxc2WwluSa3ssIgJ11F/1/VBOvzkyNGvh
         v2PMP/zagqeZBRVk5Ubzep4HH5yNxncpMqbVQR2Rm8bXuRLf86zsV67/7heIZXbyeYHo
         Ck56B613GjSbAGRMlbBo07JHB5WBpwURrDCUHhRuxjp5VwhI5RtVRo+1OgXFkgnYn2Z/
         3nxg==
X-Gm-Message-State: ANoB5pl29LGRWgtjAfM6SHJcWf7c70okUhnTfZ+W074lWvGYfdwQL1h5
        R09lbAWl97DCyoPNdgDEFtKLMg==
X-Google-Smtp-Source: AA0mqf6si1IGznSHWnZ+h7AWUXjrfpg/7ui/LT2s/cqluG2WdGIoszugXSSrlm72tGWOuAGPIPa68Q==
X-Received: by 2002:a05:6a00:99b:b0:56d:3de3:c401 with SMTP id u27-20020a056a00099b00b0056d3de3c401mr12958411pfg.6.1669280836701;
        Thu, 24 Nov 2022 01:07:16 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id o13-20020a63fb0d000000b0047791c6cc10sm633506pgh.93.2022.11.24.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:07:16 -0800 (PST)
Date:   Thu, 24 Nov 2022 01:07:14 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221124090714.GB1896875@debug.ba.rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <CAJF2gTSwMZQvSNxb2_5GNrVG0pwfXWsHmp8zZG=gFHnhc95bjQ@mail.gmail.com>
 <20221124082612.GC1149630@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221124082612.GC1149630@debug.ba.rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:26:12AM -0800, Deepak Gupta wrote:
>On Thu, Nov 24, 2022 at 09:32:19AM +0800, Guo Ren wrote:
>>>+.macro asm_per_cpu dst sym tmp
>>>+       REG_L \tmp, TASK_TI_CPU_NUM(tp)
>>>+       slli \tmp, \tmp, 0x3
>>>+       la \dst, __per_cpu_offset
>>>+       add \dst, \dst, \tmp
>>>+       REG_L \tmp, 0(\dst)
>>>+       la \dst, \sym
>>>+       add \dst, \dst, \tmp
>>Another tricky asm code of using percpu, I don't know how the percpu
>>maintenance guy thinks.
>
>On this, if you can point me to someone, I would like to get their feedback.
>While discussing this, one issue that comes in my mind is if the shift 
>of 0x3 is correct or not on 32bit systems. I don't know what's the 
>size of each entry
>in `__per_cpu_offset`. On 64bit it's 8 bytes and thus 3 bit shift.

Yes this would need a fix for 32bit.
`__per_cpu_offset` is an array of `unsigned long` and thus shift should be 2 bit
on 32bit systems.

