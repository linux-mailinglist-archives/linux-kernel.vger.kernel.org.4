Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812A6A0EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBWRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBWRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:43:34 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8A2737
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:43:33 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n21-20020a634d55000000b004f340df037cso4155787pgl.22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEW2x7lvcZVgNquM9X5miuc098m/bUXcKiqyROdfsvA=;
        b=GnEFv8ZYEKJq2FLsbqFXmOIsxOoE4EVShbkz1ukBp++CxWl81cjyx0bklp6nXH3I70
         1Dn7JrVCVuKLElNcGdQ1U6YXznFPEHlKh91jnsTXumsHU8puSiTvyoKnzjCVZbQPKnWS
         QXdxzapoB+4T797LXxDe2I0aHK2NBTy6Rw4ivHdiib/6jaI04ABl+Dtf1ReAAkKNrGSl
         8NHnqSqy6ru6z4leh6bzy1EQMm6tgE5IBBFzAYn+bp+FpfKImc6YedR1CZMkmMlPEp36
         c2HXP4yjSNThuM60YRVKyVgt+SlF71LlRuX35DyTXLuiC4Od9uaQKbklKgKjNGtAO3hZ
         O4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEW2x7lvcZVgNquM9X5miuc098m/bUXcKiqyROdfsvA=;
        b=cpmMtUSJ70oWRwWt2NaYUDv3U/945Z836SdUWemyvwPJHNDNujUlBeRi+OEVcDIqmo
         hIEaxnmyLHrYrCyYmWU2CctxOYRxg+UNKFfpTaI9QtNUs44Z/MEa0VjD7s7w5Mr9EpIL
         XfPGfQOM2oDYTCfhtYhcl87w2iAChxP/bM/6AQUEjG2kvLPmE+vMXHKrroX4IQ4hgdqp
         4oQrYhhC2ctLv7MNm18FjEolI1qB+GbcMCvvaBB8L57FRn2A5N03t4eZUFf003jjCgff
         HfB+NYRWWFcXpLwXucKEtz6qrgszWNboWFcJybNsP0z10w6bpvOjbXTncFAKqVsr5shw
         GonQ==
X-Gm-Message-State: AO0yUKXOC1kMyUBTCrIRbaIhom1qgKds3fu+TVM+U8X4vduqPcM8WFFO
        mlSBAcm4JXrvHT9niBIlumSEFGojcg4=
X-Google-Smtp-Source: AK7set83+Pnlpt5peCqIhQBtdMvaXZZfXzsbtxsBRoLRt6jnUdFR+O/gyNEyxZMgKJ7oNYHyvpri8MhadHU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6944:0:b0:4fd:2170:b2da with SMTP id
 w4-20020a656944000000b004fd2170b2damr1506614pgq.0.1677174212817; Thu, 23 Feb
 2023 09:43:32 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:43:31 -0800
In-Reply-To: <20230217041230.2417228-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-6-yuzhao@google.com>
Message-ID: <Y/elw7CTvVWt0Js6@google.com>
Subject: Re: [PATCH mm-unstable v1 5/5] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023, Yu Zhao wrote:
> An existing selftest can quickly demonstrate the effectiveness of this
> patch. On a generic workstation equipped with 128 CPUs and 256GB DRAM:

Not my area of maintenance, but a non-existent changelog (for all intents and
purposes) for a change of this size and complexity is not acceptable.

>   $ sudo max_guest_memory_test -c 64 -m 250 -s 250
> 
>   MGLRU      run2
>   ---------------
>   Before    ~600s
>   After      ~50s
>   Off       ~250s
> 
>   kswapd (MGLRU before)
>     100.00%  balance_pgdat
>       100.00%  shrink_node
>         100.00%  shrink_one
>           99.97%  try_to_shrink_lruvec
>             99.06%  evict_folios
>               97.41%  shrink_folio_list
>                 31.33%  folio_referenced
>                   31.06%  rmap_walk_file
>                     30.89%  folio_referenced_one
>                       20.83%  __mmu_notifier_clear_flush_young
>                         20.54%  kvm_mmu_notifier_clear_flush_young
>   =>                      19.34%  _raw_write_lock
> 
>   kswapd (MGLRU after)
>     100.00%  balance_pgdat
>       100.00%  shrink_node
>         100.00%  shrink_one
>           99.97%  try_to_shrink_lruvec
>             99.51%  evict_folios
>               71.70%  shrink_folio_list
>                 7.08%  folio_referenced
>                   6.78%  rmap_walk_file
>                     6.72%  folio_referenced_one
>                       5.60%  lru_gen_look_around
>   =>                    1.53%  __mmu_notifier_test_clear_young

Do you happen to know how much of the improvement is due to batching, and how
much is due to using a walkless walk?

> @@ -5699,6 +5797,9 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
>  	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
>  		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
>  
> +	if (kvm_arch_has_test_clear_young() && get_cap(LRU_GEN_SPTE_WALK))
> +		caps |= BIT(LRU_GEN_SPTE_WALK);

As alluded to in patch 1, unless batching the walks even if KVM does _not_ support
a lockless walk is somehow _worse_ than using the existing mmu_notifier_clear_flush_young(),
I think batching the calls should be conditional only on LRU_GEN_SPTE_WALK.  Or
if we want to avoid batching when there are no mmu_notifier listeners, probe
mmu_notifiers.  But don't call into KVM directly.
