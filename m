Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2015FE3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJMVBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJMVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:01:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C61793A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:01:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z20so2894315plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdu8CDhPFUGuuqJLB1hm8uRgcdUvFaGH3LFEE7wY72E=;
        b=t3NB2tnT0mOyQNL9SqfMc3Y7GNvuenW4Yj9HqN57Y/yVtpYG8bqNmlprt00zkcnvli
         Obq7zW1RMHD9vOWjVQ3IKBcRS/3+J2JS40IujCdx+lxEzQrysdaZ+PekVHybVUDZ61rv
         HaBQNyAMXTPC78lu4kmOOyS5eypmwPQGVzg4djhqYBXV+5JNfXI9wQsQLMS0ywa9zMMx
         GAqg8GtUZGLgvq5Chtb3MjkGhS2Hxuk6nvFLsFTbq9ZeB8G/5nQa3/q/ogVb5PTHJP+o
         585fZTcCdT0YWiI1q5FI2p+cZs7xjz6ZI0ziP/Q7AVKlhYyDTOPvXzrtvCVoCicSxFEc
         axkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdu8CDhPFUGuuqJLB1hm8uRgcdUvFaGH3LFEE7wY72E=;
        b=jWE4z075/y/tXNCUxmgUYu7vC26Uqyh0Lf0unrphgiLDAx315s3Eb/WQtcd1t8C+WB
         VHETMYZVplms/DhAXz6KJM82giH5RvQZ9uKtEC72D7q8tJItdXAywLbEnNQlLsmRryEF
         KS7vi4WNR0T0PBR+n1qrzcDauE3toGKfvPE9UFat7aqG4zMRsTmESnEVBdBa+yfjYD9z
         YfUGu1suLbvJ3VmfCkrCamRKmH38ec9JhtEo4/gw5JpaNm7IYSXXDyJKHi/7d/cGxO9U
         rn/FELh88GI9w/34emznR0JGmaVFvc9VR4uaPIMmkZgELDDwwPdIumdgZK43EZ+y2pCS
         7gLg==
X-Gm-Message-State: ACrzQf3Gn6Bl4K05dS5YXRHG53d8QjDq+py2lngfArZYMi9hPpxPerA+
        l/toxIzkcYdB7e+jvqbZRb0hUg==
X-Google-Smtp-Source: AMsMyM6ItHsqYSboXb3Wt1sovvrB2QN7DJyWgsIfBNru+f2ZODqJjgkDFgWAMD/t9jyKG7ENUEuGpA==
X-Received: by 2002:a17:902:e549:b0:184:5c4a:fad0 with SMTP id n9-20020a170902e54900b001845c4afad0mr1659214plf.6.1665694884466;
        Thu, 13 Oct 2022 14:01:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001750361f430sm274955pll.155.2022.10.13.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:01:23 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:01:23 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 12:51:26 PDT (-0700)
Subject:     Re: [PATCH v4 0/2] Make mmap() with PROT_WRITE imply PROT_READ
In-Reply-To: <20220915193702.2201018-1-abrestic@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, coelacanthus@outlook.com,
        dramforever@live.com, c141028@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        abrestic@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     abrestic@rivosinc.com
Message-ID: <mhng-389708b4-d3b4-46a5-a56c-6ea59c8e322d@palmer-ri-x1c9a>
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

On Thu, 15 Sep 2022 12:37:00 PDT (-0700), abrestic@rivosinc.com wrote:
> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> invalid") made mmap() reject mappings with only PROT_WRITE set in an
> attempt to fix an observed inconsistency in behavior when attempting
> to read from a PROT_WRITE-only mapping. The root cause of this behavior
> was actually that while RISC-V's protection_map maps VM_WRITE to
> readable PTE permissions (since write-only PTEs are considered reserved
> by the privileged spec), the page fault handler considered loads from
> VM_WRITE-only VMAs illegal accesses. Fix the underlying cause by
> handling faults in VM_WRITE-only VMAs (patch 1) and then re-enable
> use of mmap(PROT_WRITE) (patch 2), making RISC-V's behavior consistent
> with all other architectures that don't support write-only PTEs.
>
> Both patches are tagged as fixes for the aforementioned commit since that
> commit made a userspace visible change that will break any software relying
> on mmap(PROT_WRITE). (Also cc: stable since the offending commit was
> itself backported to stable).
>
> v1 -> v2: Allow handling of load faults in VM_WRITE VMAs
> v2 -> v3: Split into two pathces
> v3 -> v4: Fixes tags (+ this cover letter)
>
> Andrew Bresticker (2):
>   riscv: Make VM_WRITE imply VM_READ
>   riscv: Allow PROT_WRITE-only mmap()
>
>  arch/riscv/kernel/sys_riscv.c | 3 ---
>  arch/riscv/mm/fault.c         | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)

Thanks, these are on for-next.
