Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB96A8FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCCDGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:06:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0257D12
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:06:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q189so681011pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 19:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677812810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGhwusBobxSy0Ximwk7sp5ZnC5ri+nh8363yR1Q/BSE=;
        b=ImXAB3gqENAj74ss8oVPqfvT8C+7j4TPbTqAkWJ9z7JNoX+DSWxEdiIWtIyJtwgj+W
         AqSrJcIlZzWxYJAfi2XpRIIVuyb/TsYxR/ZkY2EGM0lzOWvo8XPWoa8ChXeb7HhDMLBd
         FbQtrAgV08Ct1F+sTX89ZDoXso3zJ85S2TxdZM5zn4mF522N+A91LKRJW+uzuNmla76Z
         4gpoNAHjKwSQuItlaU9ke/6PX3t5VcLGDeQC0h98Jgo67KgiyHpOD4Cy13lx31gSjnoI
         HwIEBzEGQb0amE+RKiYOOMiq5phFiF2bVSwwkcN00bqSAHVmcvsv524vwFTOCNkxJmwx
         wzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677812810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGhwusBobxSy0Ximwk7sp5ZnC5ri+nh8363yR1Q/BSE=;
        b=K0c05AxP0Fsw2IQgY7YKYK5Ft+RCIyHQpEXLMxYWaf0MQszpg8RPBlM3hAJz5x1SCP
         HkEEqpHbi/21JjvuHcA/nHHI1B3iiIpy6fI+mLcEmCaFM5q3eCIHFBoF2WLj1zMZMQ6H
         InjvywXcdUFAdXdfoFZc9Lr7bjnINjLGto7b7qYEsQXhcyY7Ebwy3bBnkp3TN9ANk8Ub
         i2Hu/DhKLKQuatnb17XjKYDFyfhYFwcxnnsyvC4Xkr52qNRrRvinfRGMRJJk1bhr0Prq
         tFjM7/yMBXr3nH4maa1etk53C0TPLNaglXDZhDvcQdrkS3tiuK60T7gg7eYamhXiyrRl
         SM7g==
X-Gm-Message-State: AO0yUKXliEjPv3C85aaTQEKc/DKp7C5cZ5HioQg0BPJoQqAOlDYTwbhX
        xVG+wt6fglPadyMxcQA1PLd7SFY3E/hBycOYKqpgQg==
X-Google-Smtp-Source: AK7set/k+iYHrswIgrEMZtrD+gsZ2q/VNLmEyHTV85AMahzxzbfH5hXIwlMOXgX7+oFfOaydm3W7R2/NpiWbMrcRIcQ=
X-Received: by 2002:a63:7d1d:0:b0:4fb:1f2a:e6c6 with SMTP id
 y29-20020a637d1d000000b004fb1f2ae6c6mr9382pgc.2.1677812810012; Thu, 02 Mar
 2023 19:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20230215010717.3612794-1-rananta@google.com> <20230215010717.3612794-8-rananta@google.com>
In-Reply-To: <20230215010717.3612794-8-rananta@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Thu, 2 Mar 2023 19:06:33 -0800
Message-ID: <CAAeT=FxVyHVRTj_78Jebz9nsc79yfYcbOu2c2hcekJTLgKFFaQ@mail.gmail.com>
Subject: Re: [REPOST PATCH 07/16] selftests: KVM: aarch64: Add PMU cycle
 counter helpers
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
> Add basic helpers for the test to access the cycle counter
> registers. The helpers will be used in the upcoming patches
> to run the tests related to cycle counter.
>
> No functional change intended.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../testing/selftests/kvm/aarch64/vpmu_test.c | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_test.c b/tools/test=
ing/selftests/kvm/aarch64/vpmu_test.c
> index d72c3c9b9c39f..15aebc7d7dc94 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_test.c
> @@ -147,6 +147,46 @@ static inline void disable_counter(int idx)
>         isb();
>  }
>
> +static inline uint64_t read_cycle_counter(void)
> +{
> +       return read_sysreg(pmccntr_el0);
> +}
> +
> +static inline void reset_cycle_counter(void)
> +{
> +       uint64_t v =3D read_sysreg(pmcr_el0);
> +
> +       write_sysreg(ARMV8_PMU_PMCR_C | v, pmcr_el0);
> +       isb();
> +}
> +
> +static inline void enable_cycle_counter(void)
> +{
> +       uint64_t v =3D read_sysreg(pmcntenset_el0);
> +
> +       write_sysreg(ARMV8_PMU_CNTENSET_C | v, pmcntenset_el0);
> +       isb();
> +}

You might want to use enable_counter() and disable_counter()
from enable_cycle_counter() and disable_cycle_counter() respectively?

Thank you,
Reiji

> +
> +static inline void disable_cycle_counter(void)
> +{
> +       uint64_t v =3D read_sysreg(pmcntenset_el0);
> +
> +       write_sysreg(ARMV8_PMU_CNTENSET_C | v, pmcntenclr_el0);
> +       isb();
> +}
> +
> +static inline void write_pmccfiltr(unsigned long val)
> +{
> +       write_sysreg(val, pmccfiltr_el0);
> +       isb();
> +}
> +
> +static inline uint64_t read_pmccfiltr(void)
> +{
> +       return read_sysreg(pmccfiltr_el0);
> +}
> +
>  static inline uint64_t get_pmcr_n(void)
>  {
>         return FIELD_GET(ARMV8_PMU_PMCR_N, read_sysreg(pmcr_el0));
> --
> 2.39.1.581.gbfd45094c4-goog
>
