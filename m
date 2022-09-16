Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32325BA9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiIPJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIPJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:54:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444641012
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:54:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb3so18584479ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=wj5OSFKMaMShL9kPf9grhYXO/iiEFQNYTLIygfPbFF0=;
        b=S6xb6kIuhT4wmw6S0ZJybtoz5CCAknGQsMFFQnrGHHo3d2Ll9idaadbGuZs6jO7l+D
         dr/azVWd76TnRURvVGtfM6Oiy8Dp7zpdkmw8uSUsmnXQofb+o6pku/GY1GfzqM1FWbVi
         cKwp/4kSV9G/KVvg8EtC+T3Vj9o/TBA8G3eMQ2AJZrdLJE4Z2diCTtswodnQoQ8nRx2o
         PB2FP1KgRsl6kPuxLYHw66MJfF7QBL9+m9eeE97hAbSIDqOHPEq+ts90j9a1wCZg5mTj
         +CUPvMcXHgYwye+YV8XA+I02UgkEIMkzEzwNYmCjBecIRWqD0wvteipHzfMOxWOBjIAS
         aX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wj5OSFKMaMShL9kPf9grhYXO/iiEFQNYTLIygfPbFF0=;
        b=Q/S5kmHTIyUHq2J8MtTNC48iqyM85OkLd0qYNr/hUJkzA2o3hOLWnwh2//spAeB/fW
         3kkUai+a6AIeYyQEGwdfY1dYnRk8aGvLr0vuSBij5oZ0XFfz5mbc0gARfXnL9yOYjV8F
         QZuEIFrI53Bmmk5BeboDOoxMHhWioeGfA3HI+zIRHefytWI8tg3bV/kzFyin4vwaTQPd
         Pg1yRYJLK21kDZ9w15xvVYWg84VgKOG8N+/v68vE5Wq8S4RyzJLxy8YB74t5lvIINwPy
         qjWwiUbly/YbqGWeycyrb7kcczJ4uIWngKajMAJtohp7I76qriG8CWUQKPYTdHq78RwI
         +dQg==
X-Gm-Message-State: ACrzQf2AINXuIDQ7aaMCoOq0M4zbARBj6wU0TLrYeR73vcdX8zjJj5Hp
        YhKrOnfFVBnMRx5et98NkBfWug==
X-Google-Smtp-Source: AMsMyM5skfvX+xKarZa0E3BhB7qnCyF5lJUhezWEizPxPZ6QA1BYGU8dFI52cG7Cw1lUgonjj0uv7Q==
X-Received: by 2002:a17:906:fc6:b0:72f:d080:416 with SMTP id c6-20020a1709060fc600b0072fd0800416mr2995012ejk.1.1663322068752;
        Fri, 16 Sep 2022 02:54:28 -0700 (PDT)
Received: from localhost (guests-out.ms.mff.cuni.cz. [195.113.20.231])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b0074136cac2e7sm9984592ejd.81.2022.09.16.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:54:28 -0700 (PDT)
Date:   Fri, 16 Sep 2022 02:54:28 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Sep 2022 02:54:22 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
In-Reply-To: <9b9ff287-75e5-3ee5-e6c5-1daca6c562dc@microchip.com>
CC:     Vineet Gupta <vineetg@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        cmuellner@ventanamicro.com, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-11eafba7-7b0e-4d68-a7cd-c56595ff9a7c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 23:58:05 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 16/09/2022 07:34, Conor Dooley wrote:
>> On 16/09/2022 05:23, Vineet Gupta wrote:
>>> [You don't often get email from vineetg@rivosinc.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> As of now the software stack needs work to support ztso. Until that work
>>> is finished, disallow binaries needing TSO.
>>>
>>> This patch is needed to help ztso ratification and prolifiration of tso
>>> bits in tooling.
>> 
>> I have to admit to being a little confused here, if Ztso is not ratified
>> why do we need to protect ourselves from it?
> 
> Also, since this is not marked as a fix, why would we not just apply the
> patchset from Palmer that looks like a more complete version of this
> patch:
> https://lore.kernel.org/linux-riscv/20220902034352.8825-1-palmer@rivosinc.com/
> 
> Maybe you could offer an R-b or some comments on that patch instead?

IMO that's the better way to go, Ztso is frozen so we can expect 
software to start using it.  Might as well let it run if the machine is 
going to be TSO anyway (and IIRC some of the T-Head stuff either is or 
can be TSO, so we'll need to detection soon anyway).

I was also planning on re-spinning the QEMU stuff so we can test it, but 
given how simple the Linux patch is I think it's fine to just go ahead 
and take it.

Happy to hear any comments, though.

> 
> Thanks,
> Conor.
> 
>> 
>>>
>>> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
>>> ---
>>> Changes since v1
>>>    - Build error (and boot tested on qemu)
>>>    - Improved the comments a bit
>>> ---
>>>   arch/riscv/include/asm/elf.h      | 11 ++++++++++-
>>>   arch/riscv/include/uapi/asm/elf.h |  2 ++
>>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
>>> index f53c40026c7a..b6b4542b3039 100644
>>> --- a/arch/riscv/include/asm/elf.h
>>> +++ b/arch/riscv/include/asm/elf.h
>>> @@ -26,10 +26,19 @@
>>>
>>>   #define ELF_DATA       ELFDATA2LSB
>>>
>>> +/*
>>> + * Make sure the elf being loaded is compatible with extensions.
>>> + *
>>> + * In the final incarnation this will get the extension list from DT and
>>> + * make sure elf can run on given hardware+kernel.
>>> + * For now disallow TSO built binaries.
>>> + */
>>> +#define rv_ext_ok(x)   (!((x)->e_flags & EF_RISCV_TSO))
>>> +
>>>   /*
>>>    * This is used to ensure we don't load something for the wrong architecture.
>>>    */
>>> -#define elf_check_arch(x) ((x)->e_machine == EM_RISCV)
>>> +#define elf_check_arch(x) ((x)->e_machine == EM_RISCV && rv_ext_ok(x))
>>>
>>>   #define CORE_DUMP_USE_REGSET
>>>   #define ELF_EXEC_PAGESIZE      (PAGE_SIZE)
>>> diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
>>> index d696d6610231..fa9e4c52c7ac 100644
>>> --- a/arch/riscv/include/uapi/asm/elf.h
>>> +++ b/arch/riscv/include/uapi/asm/elf.h
>>> @@ -32,6 +32,8 @@ typedef union __riscv_fp_state elf_fpregset_t;
>>>   #define ELF_RISCV_R_TYPE(r_info)       ELF32_R_TYPE(r_info)
>>>   #endif
>>>
>>> +#define EF_RISCV_TSO           (1 << 3)
>> 
>> s/EF/ELF ?
>> 
>> Thanks,
>> Conor.
>> 
>>> +
>>>   /*
>>>    * RISC-V relocation types
>>>    */
>>> -- 
>>> 2.34.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>> 
> 
