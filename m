Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAE6A8E42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCCArL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCArJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:47:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3935266
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:47:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so964233pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 16:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677804428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU0rjrjUgK9UPMJSdQ+7dnHdl8K0SghnjzsbTsmj3Ag=;
        b=TYHVnKkDpwjH8a1fiWkJJLS9ndCnG4I1g1BYddtN2ar35mGnN82+tbX39xKwI/8BeN
         pWtnDWV66OhFYew1W1q/3kd2qI1+LtJP4x/AGPYYEpVxSmeognokqWfMBNklHWLD2hZ1
         CGZ5WUBRFIRQPGZPGhZVLHAHsvgtfRytOC6uRcIGBQ0ZIvQOqvogS9uHjoP3pIda/iLF
         7+jq/ot2GajAKp9C2SoVb1SCXKcoau+giMPlZSv4fJ759gStAl4UMKZnHbtj7nlYv+Xm
         YDXb52RmdERNx7ntXJa5wxxuWZiunxYYlvwPxrPSlGxPbSp9EY78yguj+1zh28akhwk+
         ddNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677804428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU0rjrjUgK9UPMJSdQ+7dnHdl8K0SghnjzsbTsmj3Ag=;
        b=sryoqPaEpPQX4ALoxKVY5yK0qfvAm4hLWUOD2PX9Kq0Mrix+tNhFjIkZaoNC039GHo
         /qgRAfuCjjqp1RDnkd9XweSSuPCOFV6wY2RYzhC2mJtq9Cl7PET+xVmPBogIzk8W/GQ3
         eCmnHfh3a/CWxE202jH/KtrAJG0XAT1YZQbK168AWgvGQUgVN8K2lAlyBV4cS723iL5A
         yxqaVSjR08v9bN+anapigmbZYLaCshArIP3c44D6Z7s2TV85PRd/XcMT1AkdcZXUOEDz
         tF7IFMw4BtB3bmCkf38YZG4OPE47MIyWER+igV6YzVotgTXodAPijY0CEtRqN0CRKJ4T
         R6EA==
X-Gm-Message-State: AO0yUKVXCs8Vv49ZxFJbrTYijTrICMSpAT82fUVQBVNpVMRXOpwXlMs6
        Fa+tzi8WGg+FgMmagM0AIdGWU0iEL643+mHmqLufnWPCUN0oTLj1
X-Google-Smtp-Source: AK7set8ZZrRi0qeKqTr30s8g0fTBn8gg+Ebb9eSsgyj8YAUkp51xb+A200hC7FaZ6ERHui06IV+QymO/X0I7sksnzUs=
X-Received: by 2002:a17:902:f783:b0:19c:140d:aada with SMTP id
 q3-20020a170902f78300b0019c140daadamr70591pln.2.1677804428140; Thu, 02 Mar
 2023 16:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20230215010717.3612794-1-rananta@google.com> <20230215010717.3612794-7-rananta@google.com>
In-Reply-To: <20230215010717.3612794-7-rananta@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 2 Mar 2023 16:46:51 -0800
Message-ID: <CAAeT=FyrgUjQWhL75n7z43msubHHghhy3Tj2JjsYop14f3kFhg@mail.gmail.com>
Subject: Re: [REPOST PATCH 06/16] tools: arm64: perf_event: Define Cycle
 counter enable/overflow bits
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

On Tue, Feb 14, 2023 at 5:07=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> Add the definitions of ARMV8_PMU_CNTOVS_C (Cycle counter overflow
> bit) for overflow status registers and ARMV8_PMU_CNTENSET_C (Cycle
> counter enable bit) for PMCNTENSET_EL0 register.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/arch/arm64/include/asm/perf_event.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/arch/arm64/include/asm/perf_event.h b/tools/arch/arm64=
/include/asm/perf_event.h
> index 97e49a4d4969f..8ce23aabf6fe6 100644
> --- a/tools/arch/arm64/include/asm/perf_event.h
> +++ b/tools/arch/arm64/include/asm/perf_event.h
> @@ -222,9 +222,11 @@
>  /*
>   * PMOVSR: counters overflow flag status reg
>   */
> +#define ARMV8_PMU_CNTOVS_C      (1 << 31) /* Cycle counter overflow bit =
*/

Nit: This macro doesn't seem to be used in any of the patches.
Do we need this ?

Thank you,
Reiji


>  #define        ARMV8_PMU_OVSR_MASK             0xffffffff      /* Mask f=
or writable bits */
>  #define        ARMV8_PMU_OVERFLOWED_MASK       ARMV8_PMU_OVSR_MASK
>
> +
>  /*
>   * PMXEVTYPER: Event selection reg
>   */
> @@ -247,6 +249,11 @@
>  #define ARMV8_PMU_USERENR_CR   (1 << 2) /* Cycle counter can be read at =
EL0 */
>  #define ARMV8_PMU_USERENR_ER   (1 << 3) /* Event counter can be read at =
EL0 */
>
> +/*
> + * PMCNTENSET: Count Enable set reg
> + */
> +#define ARMV8_PMU_CNTENSET_C    (1 << 31) /* Cycle counter enable bit */
> +
>  /* PMMIR_EL1.SLOTS mask */
>  #define ARMV8_PMU_SLOTS_MASK   0xff
>
> --
> 2.39.1.581.gbfd45094c4-goog
>
