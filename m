Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819846F2635
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjD2UHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 16:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjD2UHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF1D1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b7588005fso991701b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682798848; x=1685390848;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPEqh8k2qdo+NeTZc6tPzCNg8vzJgNMkZZxTJJ82cVc=;
        b=CesUnoPpobeQ2vi5Uq289J04jpYmmsKF1v97GIvbSAOLF9eW2BPzblYzd84BU5tSud
         y1DUBRT8Q+c5WubZqOMxKOwsMMVdNAX2FLqxysqfdhlBQW5YBoP69vINYpYlpfaUB53F
         EN6pHvadBT4/e8ZiBj6gAz3bsQs+1XpXY5ZCYW+JB7M2329N9o7kB8eeAvfP5X8r+NMY
         iMuTznt72Rcpc6CeH+9mKoC803DZagcwR1X3GSNHBVB/KEyAuzP7a+KmCVNSDCwhK1E+
         1ay1BgalmYKhiJXxvvOoHE237ZmnJRl6R8+lE7d8YU+QF5ZySpHBMtumsDiMnde7GaSe
         Xdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798848; x=1685390848;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPEqh8k2qdo+NeTZc6tPzCNg8vzJgNMkZZxTJJ82cVc=;
        b=XurReeMP+eHz/Af+rlbedAqlqCPJixI20MGeHCPRWka8K4uv2AruR/qkdiJ+HWgEXV
         e08FAJv6WxJaBt2qW7P3lb71U/oA6wvNUombroiex81LiN3CLIFsRb25spVk5Gq27SOW
         vcoZkBTDQTMlcNinAkPKLOxpJI40IcQoor4PxMJ07hJ/PZaUwZo63+DTZ1kLpKkG+l3S
         DvW0L45Li4QPPwGfGUQhl3kTZ1oVM6rNwm3Bgrq5hTpKDzN8zRjgMjRndDL118JXzkGw
         Hag5MYq3j6HZ60ENJZxMH1pysfXHbacInRFG+QwHKpmI4S2zv4GNtr6BYoZ1nDnw1LuT
         02zA==
X-Gm-Message-State: AC+VfDzsC3107jaFZTgY9EPmn1MaxuIbl1DNRnXGFyg/WlZCKBlIGWMS
        fWcclkt/kPeMLV4l0uzxNutQtg==
X-Google-Smtp-Source: ACHHUZ7vRoRMpKih9uT6u2biyCmOg5cRRUaCfmME/Xfykcc4K5L91I3hl8zMkHpswkQldje/7mqS9A==
X-Received: by 2002:a05:6a20:72a7:b0:f0:662b:337 with SMTP id o39-20020a056a2072a700b000f0662b0337mr12264886pzk.60.1682798847993;
        Sat, 29 Apr 2023 13:07:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u6-20020a656706000000b005143448896csm12225770pgf.58.2023.04.29.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:27 -0700 (PDT)
Date:   Sat, 29 Apr 2023 13:07:27 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 13:07:04 PDT (-0700)
Subject:     Re: [PATCH 3/3] RISC-V: hwprobe: Expose Zba and Zbb
In-Reply-To: <20230429-gruffly-chrome-fd94628cc5ff@spud>
CC:     Evan Green <evan@rivosinc.com>, aou@eecs.berkeley.edu,
        abrestic@rivosinc.com, ajones@ventanamicro.com,
        coelacanthus@outlook.com,
        Conor Dooley <conor.dooley@microchip.com>,
        heiko.stuebner@vrull.eu, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-8585bbf5-7d6a-4e09-9c5f-8c6f36092b76@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 06:40:51 PDT (-0700), Conor Dooley wrote:
> On Fri, Apr 28, 2023 at 12:06:08PM -0700, Evan Green wrote:
>> Add two new bits to the IMA_EXT_0 key for ZBA and ZBB extensions. These
>> are accurately reported per CPU.
>> 
>> Signed-off-by: Evan Green <evan@rivosinc.com>
>> 
>> ---
>> 
>>  Documentation/riscv/hwprobe.rst       |  7 +++++
>>  arch/riscv/include/uapi/asm/hwprobe.h |  2 ++
>>  arch/riscv/kernel/sys_riscv.c         | 43 ++++++++++++++++++++++-----
>>  3 files changed, 45 insertions(+), 7 deletions(-)
>> 
>> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
>> index 9f0dd62dcb5d..21f444a38359 100644
>> --- a/Documentation/riscv/hwprobe.rst
>> +++ b/Documentation/riscv/hwprobe.rst
>> @@ -64,6 +64,13 @@ The following keys are defined:
>>    * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as defined
>>      by version 2.2 of the RISC-V ISA manual.
>>  
>> +  * :c:macro:`RISCV_HWPROBE_EXT_ZBA`: The Zba address generation extension is
>> +       supported, as defined in version 1.0 of the Bit-Manipulation ISA
>> +       extensions.
>> +
>> +  * :c:macro:`RISCV_HWPROBE_IMA_ZBB`: The Zbb extension is supporte, as defined
>
> Why is one EXT_ZBA and the other is IMA_ZBB? You do not use IMA below,
> so I assume this is a copy-paste mistake.

Looks like it.  Either way this was too late for the current merge 
window, so no big deal.

>
> Also, s/supporte/supported.
>
> Otherwise, looks fine.
> Cheers,
> Conor.
>
>> +       in version 1.0 of the Bit-Manipulation ISA extensions.
>> +
>>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>>    information about the selected set of processors.
>>  
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>> index 8d745a4ad8a2..ef3b060d4e8d 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -25,6 +25,8 @@ struct riscv_hwprobe {
>>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
>>  #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
>>  #define		RISCV_HWPROBE_IMA_C		(1 << 1)
>> +#define		RISCV_HWPROBE_EXT_ZBA		(1 << 2)
>> +#define		RISCV_HWPROBE_EXT_ZBB		(1 << 3)
>>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>> index 5db29683ebee..adfcb6b64db7 100644
>> --- a/arch/riscv/kernel/sys_riscv.c
>> +++ b/arch/riscv/kernel/sys_riscv.c
>> @@ -121,6 +121,41 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
>>  	pair->value = id;
>>  }
>>  
>> +static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>> +			     const struct cpumask *cpus)
>> +{
>> +	int cpu;
>> +	u64 missing = 0;
>> +
>> +	pair->value = 0;
>> +	if (has_fpu())
>> +		pair->value |= RISCV_HWPROBE_IMA_FD;
>> +
>> +	if (riscv_isa_extension_available(NULL, c))
>> +		pair->value |= RISCV_HWPROBE_IMA_C;
>> +
>> +	/*
>> +	 * Loop through and record extensions that 1) anyone has, and 2) anyone
>> +	 * doesn't have.
>> +	 */
>> +	for_each_cpu(cpu, cpus) {
>> +		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> +
>> +		if (riscv_isa_extension_available(isainfo->isa, ZBA))
>> +			pair->value |= RISCV_HWPROBE_EXT_ZBA;
>> +		else
>> +			missing |= RISCV_HWPROBE_EXT_ZBA;
>> +
>> +		if (riscv_isa_extension_available(isainfo->isa, ZBB))
>> +			pair->value |= RISCV_HWPROBE_EXT_ZBB;
>> +		else
>> +			missing |= RISCV_HWPROBE_EXT_ZBB;
>> +	}
>> +
>> +	/* Now turn off reporting features if any CPU is missing it. */
>> +	pair->value &= ~missing;
>> +}
>> +
>>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>>  {
>>  	int cpu;
>> @@ -164,13 +199,7 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>  		break;
>>  
>>  	case RISCV_HWPROBE_KEY_IMA_EXT_0:
>> -		pair->value = 0;
>> -		if (has_fpu())
>> -			pair->value |= RISCV_HWPROBE_IMA_FD;
>> -
>> -		if (riscv_isa_extension_available(NULL, c))
>> -			pair->value |= RISCV_HWPROBE_IMA_C;
>> -
>> +		hwprobe_isa_ext0(pair, cpus);
>>  		break;
>>  
>>  	case RISCV_HWPROBE_KEY_CPUPERF_0:
>> -- 
>> 2.25.1
>> 
