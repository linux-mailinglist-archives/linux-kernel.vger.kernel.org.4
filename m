Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D566E7C55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjDSOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjDSOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:22:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257707690
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52160b73bdfso206101a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681914157; x=1684506157;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yB70xeJV1N0ZlteQUIRM4Nk0DPs/RCkhgDAa0rx6NU=;
        b=FGr5Z0zW4TGX3/eVr4y3eJPb2jFX9DbliZVi7umZ2GZlwZ+2GsTc/Xh2fkFs9PUu+F
         WAt3LkmHaWOmFIYENjePl8OoWg21kk335vx0Ap0xvGiTHgo2NMY39AeP3YfuDdK+dnCF
         gkGN+ntnQkXyV8zhwtreIXNDsm6tMkcMYpCRyEllxz1jzmoPguDZBEARb27KEbOyLr+6
         sRYhlmkSp1nDK6KovQcJ60RG4sT4q3IJxazWV5Vk9t1H+vaHdeRXnfIe5fAUS3i5Z4Y+
         LZzpCNezRR/YdHW14aU5gzBuMCvvX23ts/K/yIVQikCFrQKpNDo721r/VZg8F6FCWLjb
         6eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914157; x=1684506157;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yB70xeJV1N0ZlteQUIRM4Nk0DPs/RCkhgDAa0rx6NU=;
        b=J4ugagg2+12TTHBme6AUVgt2gjuHFiq1YYHfrA0rrUVUsHS/4PAyS/jziFKXlVXvou
         IyKBLRq2TUqVKOr7SNMB1LPnecwyERKb1KpyZe44OXZQvYar5/bmlB5/tIomKT7LByGd
         p+YanszEwtPNRVoZ2trmf3BdqcyRI1JT8TqaJ5Y62UsDX7+xFE/anXCBn9P7+7ySh+yx
         eLNiSx/n+e0q6ZuD2RfdsdSXjIuJgXLzjpl7LiGICzpuLJZ+9d1d71LbgujE+dTGH+AG
         SA3lzmNXcUH+cD07BfU1WoEeK7tH5gWU7ica2E5fVNhnKqISRFZLRqWp1bB4qp6Urkhz
         ZSiQ==
X-Gm-Message-State: AAQBX9fnug2VM52Rqv4zQWsTkmEx0r4nYpv+3eVL2PjsCd65F+FCfOti
        fEvFm7THAX+7rgZvh6C6C3H9rQ==
X-Google-Smtp-Source: AKy350aHkXwf30YbPEbBzVJv8xaBmpUhBvlebeT1NzRnd6NI8H7duPFB3Lfsb9xeVpykk8F3OPFYiQ==
X-Received: by 2002:a17:90a:b28b:b0:23f:29a:5554 with SMTP id c11-20020a17090ab28b00b0023f029a5554mr2484436pjr.48.1681914157446;
        Wed, 19 Apr 2023 07:22:37 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id jl12-20020a170903134c00b0019fea4d61c9sm11512208plb.198.2023.04.19.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:37 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:22:37 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Apr 2023 20:30:26 PDT (-0700)
Subject:     Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
In-Reply-To: <20230323172403.nfrtgm5vea4qvinu@orel>
CC:     suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ajones@ventanamicro.com
Message-ID: <mhng-d4a888a4-a2c5-4520-82d1-b8eb66a7f3d1@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 10:24:03 PDT (-0700), ajones@ventanamicro.com wrote:
> On Thu, Mar 23, 2023 at 08:39:24PM +0800, Song Shuai wrote:
>> RISC-V now manages CPU topology using arch_topology which provides
>> CPU capacity and frequency related interfaces to access the cpu/freq
>> invariant in possible heterogeneous or DVFS-enabled platforms.
>>
>> Here adds topology.h file to export the arch_topology interfaces for
>> replacing the scheduler's constant-based cpu/freq invariant accounting.
>>
>> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> ---
>> changes from V1:
>>   - fix the leading underscore and tidy the patch up
>> ---
>>  arch/riscv/include/asm/topology.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 arch/riscv/include/asm/topology.h
>>
>> diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
>> new file mode 100644
>> index 000000000000..727e8d163a3b
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/topology.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_RISCV_TOPOLOGY_H
>> +#define _ASM_RISCV_TOPOLOGY_H
>> +
>> +#include <linux/arch_topology.h>
>> +
>> +/* Replace task scheduler's default frequency-invariant accounting */
>> +#define arch_scale_freq_tick	topology_scale_freq_tick
>> +#define arch_set_freq_scale	topology_set_freq_scale
>
> I was thinking all the right hand side would line up, which means
> the above two need additional tabs and so does topology_get_cpu_scale.

I don't see a respin, but given that the feedback in just whitespace 
changes I've got and picked this up while fixing the whitespace.

>
>> +#define arch_scale_freq_capacity	topology_get_freq_scale
>> +#define arch_scale_freq_invariant	topology_scale_freq_invariant
>> +
>> +/* Replace task scheduler's default cpu-invariant accounting */
>> +#define arch_scale_cpu_capacity	topology_get_cpu_scale
>> +
>> +/* Enable topology flag updates */
>> +#define arch_update_cpu_topology	topology_update_cpu_topology
>> +
>> +#include <asm-generic/topology.h>
>
> I'd also prefer a blank line here.
>
>> +#endif /* _ASM_RISCV_TOPOLOGY_H */
>> --
>> 2.20.1
>>
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Thanks,
> drew
