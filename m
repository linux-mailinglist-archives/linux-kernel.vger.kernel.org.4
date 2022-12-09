Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D14647CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIEdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIEdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:33:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B101FCE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 20:33:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6897062pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 20:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8V2911JbsQ7q3MV8ByLBMvoup/1u6ZZgGLRpPzpF/E8=;
        b=tD9/OuaQk4Ny5ftlapIHalH7LY+UdxT5DNVq73qwQk5brpKADBpSV9VBVZOrdrU7xS
         jFYq052qCafhdRHVC/bdhkALtxcuHOOH4BEpTNI66zXOXYxyZbqg6kxKdhXeXo4nGBza
         5raDi1jiqsQ2OAWGNFkv8XlefPj1uC0aaWRqbqYnuABo/HjzH+yfNp/qVKmpqkN8Uk9L
         1jFrGeZRQQm3n+1vkzjJxQHzxx9nTNlMKkY0QL8t/OPY/2B3lTzZRNUV5HS+9OMTCEO9
         1bgrkOd/X4V6rKK8IF5TqW3xRVzi6tBpzp4i+FDIcjZDj/1mxWREQIOM5UTRTd2emXnf
         eEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V2911JbsQ7q3MV8ByLBMvoup/1u6ZZgGLRpPzpF/E8=;
        b=Px2V0svFpML8rCKYjKmfx5XvOaVa/R/bD6jXZ4i92hjyKxiCvh7fjJfsfvPwcO/hyf
         0LKNMGxIR99k1bUuT2C3cozP4e2FOH6/PtfC++Z0jkL6yW3vo+DuDQR1UofKOZNH3rLL
         4XACd+1uaxYeAuud030E3ucLlxMgHuIxvsgYkvD/nLqQRf0z7VjT6MFCbtD5xZWLjA1P
         xt/AnAg6tw/6+zmN2pNUYFeGExOTwAQ+7CAS5PI8s5XpqUBfmgi47MLuwMnWEaSnSGx7
         bMwyEeTP8sL6VeZMMXHPa0xd+2YFpHeCWDh37pmwChnH2UTGxUbPifZyofDAuYcAubNR
         oUGA==
X-Gm-Message-State: ANoB5pmJnXZqAMz90YA2VTMAnGSI+x54/64jMtbHi8QUzEDiMpggHZ8x
        Tmxh+oDmBoNk8jZExIfiP0eAlw==
X-Google-Smtp-Source: AA0mqf53l7n1lwXWo6ELFRoXqPMMWNSKJ4uBBIpg0VM28LtzLEoabSx/gaDvmcRZcN05Lor9GtpL0A==
X-Received: by 2002:a05:6a20:e68f:b0:9d:efbf:48d7 with SMTP id mz15-20020a056a20e68f00b0009defbf48d7mr6076987pzb.27.1670560390227;
        Thu, 08 Dec 2022 20:33:10 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b0056bbeaa82b9sm296387pfr.113.2022.12.08.20.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 20:33:09 -0800 (PST)
Date:   Thu, 08 Dec 2022 20:33:09 -0800 (PST)
X-Google-Original-Date: Thu, 08 Dec 2022 20:32:57 PST (-0800)
Subject:     Re: [PATCH 6/9] RISC-V: Export sbi_get_mvendorid() and friends
In-Reply-To: <CAOnJCUJ6b5=e=k19q0Q51Gptgw_QSr_989cN8q0xoBN+yq=Mmw@mail.gmail.com>
CC:     apatel@ventanamicro.com, pbonzini@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        ajones@ventanamicro.com, anup@brainfault.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-1fa7f552-95e4-4299-ab83-52001eab8b30@palmer-ri-x1c9a>
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

On Mon, 28 Nov 2022 13:07:27 PST (-0800), atishp@atishpatra.org wrote:
> On Mon, Nov 28, 2022 at 8:14 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>
>> The sbi_get_mvendorid(), sbi_get_marchid(), and sbi_get_mimpid()
>> can be used by KVM module so let us export these functions.
>>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> ---
>>  arch/riscv/kernel/sbi.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 775d3322b422..5c87db8fdff2 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
>>  {
>>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
>>  }
>> +EXPORT_SYMBOL_GPL(sbi_get_mvendorid);
>>
>>  long sbi_get_marchid(void)
>>  {
>>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
>>  }
>> +EXPORT_SYMBOL_GPL(sbi_get_marchid);
>>
>>  long sbi_get_mimpid(void)
>>  {
>>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>>  }
>> +EXPORT_SYMBOL_GPL(sbi_get_mimpid);
>>
>>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
>>  {
>> --
>> 2.34.1
>>
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
