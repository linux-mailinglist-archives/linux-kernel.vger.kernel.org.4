Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72586BF5E4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCQXBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:01:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80382C66B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:01:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54196bfcd5fso59621187b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679093997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YapDD/Mt0aXDSOcci2EIiKNoTAf7rjZX7MnhdGB50Ks=;
        b=bjhGrbJw6Bt1WWmyjlVZdivoCSpFKu8WVIQ/OytX1BEqB0QCrGTIfTVNpP8hwD9a1R
         eaGeUJs1eLAu8UNcFTyqK8BfY21TpL+Z7JNb36ilp4xnihazWCdDU4HqsrroM0LUjKBl
         DaEtELyXdxd1CuJm5i5fNhwl8D53d0y61LN82gJ3kVeY2LXSgvuz782j+G5aR43YxZf6
         J0jRR0XFc/ba9JbrH0aEOakVlz55wwLznPjvrY4h94ajMIuMlWzYeYNGuMdsOrT8EtzO
         6h0FnbkgeZfyhkrD8VCw6LnffVEBWh3ciC3mORs8DFqf5DGQlrqE7dcZEfJqVw2no+Tw
         5X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679093997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YapDD/Mt0aXDSOcci2EIiKNoTAf7rjZX7MnhdGB50Ks=;
        b=ztJRaeo8FmxsbO0lsGPwhVZnxfo8aNWtNq89etkN+ElClMlHsWVzBb4D3xQnqa9XzY
         awdYT31IfqyTzOmXIJrr8bBo3vQvORYvkmLnZnG4KmUzirlcmRjzVYTTgY3m69pvF7za
         4ovN1aHmxJCaIjV5mwsUmrjNIbW5v7/rUhCCYNbbLa4Kjhz0bX5HsB3ykjg/gmlu/7MJ
         uFPC6MtLBwVSgMnvzewUyX6wrAQ80m2ZONW8rCMlhs+lcAO9OlixcEKWFDHuXdYrrouj
         LXYysEYBa/gcoYHL2SVtH0R1uj6D72H+d+MlrdQ+z2nZX+eBULmWjkkL5KbmDK72FMg2
         I2CQ==
X-Gm-Message-State: AO0yUKW3iYuu2JZjKMb6CUF1W+EyBaL2I3MDiptfHG6asKItVH6SRaEw
        MwBQwHFPIQzLKMw6+M7kT/G7DhWlR8U=
X-Google-Smtp-Source: AK7set/MGcnP3rj5T0NCU4SLVSPbm5HIm0Rp33HZlnjaoKcp3W0jYyKSuLF1f3HAgHy2M6OYQNehVhe3Lk4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b284:0:b0:533:99bb:c296 with SMTP id
 q126-20020a81b284000000b0053399bbc296mr5278110ywh.5.1679093996982; Fri, 17
 Mar 2023 15:59:56 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:59:55 -0700
In-Reply-To: <20230211014626.3659152-3-vipinsh@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com> <20230211014626.3659152-3-vipinsh@google.com>
Message-ID: <ZBTw6ymNg0gYxhtW@google.com>
Subject: Re: [Patch v3 2/7] KVM: x86/mmu: Atomically clear SPTE dirty state in
 the clear-dirty-log flow
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023, Vipin Sharma wrote:
> @@ -1677,8 +1670,13 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
>  static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
>  				  gfn_t gfn, unsigned long mask, bool wrprot)
>  {
> +	/*
> +	 * Either all SPTEs in TDP MMU will need write protection or none. This
> +	 * contract will not be modified for TDP MMU pages.
> +	 */
> +	u64 clear_bit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
> +							shadow_dirty_mask;

Switching from spte_ad_need_write_protect() to kvm_ad_enabled() belongs in a
separate.  In the unlikely event that the above assertion/contracts is invalid,
then any issues should bisect to the switch, not to a much more complex patch.

I'll make that happen when applying.
