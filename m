Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF266F1E70
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjD1S71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbjD1S7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:59:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685F6A4F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:58:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a9290a6f96so557035ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682708298; x=1685300298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWv7yMEpyQoEe4U7b9znrOaiU21oK5MGaoZZWk9b61k=;
        b=mHJf/vRsxzIbrsWPHnWcur9NXpHbxre+RNm1R0jSsB1HV9e+qgYGsnabCuOKuMBkdl
         glBr04imslXb11CooqamPIOJxZpO02LUcuU7UZrf3WAtVJ9FrSJYUz3SdK8qU+7imZj9
         uzBUz6M++X5VcqmqzffnPFss0WFhULX+DdwPemtpobY5aHIYlutJio9Tme6VKbwY5KKD
         XGBeeGYFkU5jFxH8o+hoSICxyLKbIXb0M/yBjD6E0Wq+WSFpxJxszt7C31o8mcIVVsBO
         0ZOwUFuVvQ0tlQUdXQmO2DEexdAzgWM6AkOFAB8xBtPgIO9qozuLQe16/vcdx6KklGzs
         5V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708298; x=1685300298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWv7yMEpyQoEe4U7b9znrOaiU21oK5MGaoZZWk9b61k=;
        b=EJBcvcfoKGyaMlTs3W6l+4sYEhFnw/FlDqpzqTzwHnkHKqr7K3KA0/ewVO/PIhSuzc
         CKkomuLG5g07j6xc11R6BOMSag/VCbDOYOid+UqYM/ngAupS3XRN3D004bc2awIaIrtR
         gNe1UfGXfi3U2ym29Lz2t4sl0yWIQa8OKieazKl5GEieS2LdCmHuPnk8F+EJ1cPUmzmW
         L90MuvAv8rtcRAgvEiqVdBlmpIo6n8EHQF/dIcQX45wSCxmc5ZOlnB4V9bix32RL/DB/
         2NRed03S8D40+p+rvt9RJY6OKSjs0kN2Qa03WwInU+Fms4Q3jhRbVm1Ws8YeLAWVFPBt
         hyFw==
X-Gm-Message-State: AC+VfDytZ5idNuGzxA/mbOR4kxqG+W83QP/pVYuqMFCktP1XRMuof7Q7
        k4fG52XOAXHhJ8nOVWWfwzy2RQ==
X-Google-Smtp-Source: ACHHUZ4NfddWa+12nWfyZP9HV+HNaMWf1B5NzO1GgLklmNC/tYXEeCS4jisgnpTvqBLG28RpcAGMBg==
X-Received: by 2002:a17:902:e809:b0:19a:5a9d:3c with SMTP id u9-20020a170902e80900b0019a5a9d003cmr27368plg.16.1682708297588;
        Fri, 28 Apr 2023 11:58:17 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id y3-20020a634943000000b0051b460fd90fsm13426512pgk.8.2023.04.28.11.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:58:17 -0700 (PDT)
Date:   Fri, 28 Apr 2023 18:58:14 +0000
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
Message-ID: <20230428185814.mmnb3jafp7fnwdrh@google.com>
References: <20230428050442.180913-1-maskray@google.com>
 <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28, Ard Biesheuvel wrote:
>Hello Fangrui,

Hello Ard, thank you for the rapid response.

>On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
>>
>> Currently, the .got section is placed within the output section .text.
>> However, when .got is non-empty, the SHF_WRITE flag is set when linked
>> by lld. GNU ld recognizes .text as a special section and ignores the
>> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
>>
>> Conventionally, the .got section is placed just before .got.plt (which
>> should be empty and omitted in the kernel). Therefore, we move the .got
>> section to a conventional location (between .text and .data) and remove
>> the unneeded `. = ALIGN(16)`.
>>
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
>>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index b9202c2ee18e..2bcb3b30db41 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -181,18 +181,8 @@ SECTIONS
>>                         KPROBES_TEXT
>>                         HYPERVISOR_TEXT
>>                         *(.gnu.warning)
>> -               . = ALIGN(16);
>> -               *(.got)                 /* Global offset table          */
>>         }
>>
>> -       /*
>> -        * Make sure that the .got.plt is either completely empty or it
>> -        * contains only the lazy dispatch entries.
>> -        */
>> -       .got.plt : { *(.got.plt) }
>> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> -              "Unexpected GOT/PLT entries detected!")
>> -
>>         . = ALIGN(SEGMENT_ALIGN);
>>         _etext = .;                     /* End of text section */
>>
>> @@ -247,6 +237,16 @@ SECTIONS
>>
>>         . = ALIGN(SEGMENT_ALIGN);
>>         __inittext_end = .;
>> +
>> +       .got : { *(.got) }
>
>This is the .init region, which gets freed and unmapped after boot. If
>the GOT is non-empty, it needs to remain mapped, so we cannot place it
>here.

Thanks.  I did not know the constraint.

>We have the same issue with the .rodata section, which incorporates
>variables marked as __ro_after_init, which are not const qualified. So
>given that .rodata is already emitted as WA, and we cannot do anything
>about that, let's move the GOT in there.

Yes, writable .data..ro_after_init and __jump_table sections in
include/asm-generic/vmlinux.lds.h (#define RO_DATA(align)) makes the
output section .rodata writable.  Perhaps this is very difficult to fix,
and we will have writable .rodata for a long time.

What do you think of moving .got/.got.plt immediately before .data?
I want to place .got/.got.plt before the guaranteed-writable sections,
not some sections which are "unfortunately" writable (.rodata, __modver,
.hyp.rodata, .rodata.text, etc).

For userspace programs, either linked with GNU ld or lld, .got/.got.plt
are usually immediately before .data .

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b9202c2ee18e..48bd7c25b6ab 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -181,18 +181,8 @@ SECTIONS
  			KPROBES_TEXT
  			HYPERVISOR_TEXT
  			*(.gnu.warning)
-		. = ALIGN(16);
-		*(.got)			/* Global offset table		*/
  	}
  
-	/*
-	 * Make sure that the .got.plt is either completely empty or it
-	 * contains only the lazy dispatch entries.
-	 */
-	.got.plt : { *(.got.plt) }
-	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
-	       "Unexpected GOT/PLT entries detected!")
-
  	. = ALIGN(SEGMENT_ALIGN);
  	_etext = .;			/* End of text section */
  
@@ -286,6 +276,15 @@ SECTIONS
  	__initdata_end = .;
  	__init_end = .;
  
+	.got : { *(.got) }
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
+	       "Unexpected GOT/PLT entries detected!")
+
  	_data = .;
  	_sdata = .;
  	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
-- 
2.40.1.495.gc816e09b53d-goog


>> +       /*
>> +        * Make sure that the .got.plt is either completely empty or it
>> +        * contains only the lazy dispatch entries.
>> +        */
>> +       .got.plt : { *(.got.plt) }
>> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>> +              "Unexpected GOT/PLT entries detected!")
>> +
>>         __initdata_begin = .;
>>
>>         init_idmap_pg_dir = .;
>> --
>> 2.40.1.495.gc816e09b53d-goog
>>
