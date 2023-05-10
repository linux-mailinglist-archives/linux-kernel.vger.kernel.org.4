Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9445F6FDF73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjEJOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbjEJOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:01:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073D358C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:01:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso50447578b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683727315; x=1686319315;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8O+Xva6SSKUOzu8cD6VykU+fN8y+E0NtB9pirvzzQ9U=;
        b=xm7Lt7K+fM4a6fbPP7MIva3KYIsdEH2pn6NhTnqMZWDxfwMmfjfuC2iA7TIUgSp9X7
         iapnslzabTi/3hpYysj/Y+Qpo/U+trS4YUbBrAymZCbRPQc2GdzYMvfSXRt75xnkQ7HH
         9YmGcBzN1XGEnBnDnk4hqc6szvJ0vnbRYHR7DYbbDIfxitLJRxJHVDjlkZx/sb2Dalmd
         NMN9fv1UEU3MEvWMv2OyK363gty+uPi7R5tqnoKyXja1AZDDzs7OuMx+xXPfQOPl3EBu
         5ahAyXiN9ZWDD9X3LQrrN5sPj7Sd7WcMwJ/uvJSD2iG4PimTEA2R4mrq6SpEbr7//1lB
         gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727315; x=1686319315;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O+Xva6SSKUOzu8cD6VykU+fN8y+E0NtB9pirvzzQ9U=;
        b=HalSr54yU1scgaxBeTdCTJYwsPf/iMJT9WWzPRGQoGDoJVYqOt1XytgzJM0lxfPwQI
         nbKFh0mb2XF8Tbn8xT2bUuKvEAlj3j6aSCuyeOi0WilomuYyzAGALjd67wH9Vh9Apwyu
         O182DzHSkgbSD+0xm4T15tDkaI3HGotK6+cIGILDUJxZfQ5rGiaVlw4hMqOhl8JTH6b5
         WC74hhbUvP0ANY8lD1eLzDvtWUIA13Q+IKcoMWHfpIOLYu2/tRK3Gdv9ayuC0LFSsgeY
         9HDL5GMVlT+cnJWrHOcbQbWEuEX+Zax/21Wle6IE0kEDsWP2O7HUMILIaq7ZNsRW5cCK
         7b0g==
X-Gm-Message-State: AC+VfDxYLQaygti3fvGRQn1XSQRVqJ2EStAI7OH65LIybbHnoIWoC8z/
        P8+IbWc6u11XRtcM/okuN9Llfg==
X-Google-Smtp-Source: ACHHUZ5DO6A5G9Iwzn4Bquam+4PsWMq7WswXOCHPFyT+gtbX2VPfleyC7b8WGb0kQumaiIfRAr9lsw==
X-Received: by 2002:a17:902:9a03:b0:1ad:1be7:2a76 with SMTP id v3-20020a1709029a0300b001ad1be72a76mr1572089plp.10.1683727315241;
        Wed, 10 May 2023 07:01:55 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b001ac55a5e5eesm3819212plx.121.2023.05.10.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:01:54 -0700 (PDT)
Date:   Wed, 10 May 2023 07:01:54 -0700 (PDT)
X-Google-Original-Date: Wed, 10 May 2023 07:01:48 PDT (-0700)
Subject:     Re: [PATCH 14/23] riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <d1e54510-9ea2-edf-3851-fa7635ce1e5e@google.com>
CC:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org, david@redhat.com, surenb@google.com,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, geert@linux-m68k.org,
        gerg@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        deller@gmx.de, dave.anglin@bell.net, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, alexghiti@rivosinc.com, hca@linux.ibm.com,
        borntraeger@linux.ibm.com, imbrenda@linux.ibm.com,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hughd@google.com
Message-ID: <mhng-fa58638c-1b42-4264-8bf1-55d4bc42a5e2@palmer-ri-x1c9>
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

On Tue, 09 May 2023 21:59:57 PDT (-0700), hughd@google.com wrote:
> pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
> that: to keep balance in future, use the recently added pte_alloc_huge()
> instead; with pte_offset_huge() a better name for pte_offset_kernel().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/riscv/mm/hugetlbpage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a163a3e0f0d4..80926946759f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -43,7 +43,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>
>  	for_each_napot_order(order) {
>  		if (napot_cont_size(order) == sz) {
> -			pte = pte_alloc_map(mm, pmd, addr & napot_cont_mask(order));
> +			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
>  			break;
>  		}
>  	}
> @@ -90,7 +90,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>
>  	for_each_napot_order(order) {
>  		if (napot_cont_size(order) == sz) {
> -			pte = pte_offset_kernel(pmd, addr & napot_cont_mask(order));
> +			pte = pte_offset_huge(pmd, addr & napot_cont_mask(order));
>  			break;
>  		}
>  	}

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
