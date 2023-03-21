Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C36C268F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCUAvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:51:46 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044C19C42
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:51:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pt5-20020a17090b3d0500b0023d3ffe542fso224141pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679359905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/SMhSBZYB4QrO41/CqVDHVj5QCw+KIQVOvV8RHW7oQ=;
        b=QlzmdFo1nDpm+wIQODt3WZ/QoYJiX0f0RCxgNInszVHp6ThweNaHOrPIexS+mXTIlX
         Bc2bQXNn/PBS6/3MHpa/oJeTVvH7vOiuoWXotEgAzpRIForAVnQNDm+zNofe06qDcAWs
         6cbhuRztX85Td5BfBSdK71O464/4tBhWJSjV1M2mmsCVqJpYOTrsMK7DRhMU6SXtos79
         WmJcjmYtM1fvHz44QawEZsfnwT3e0MT5rk5ZaW00q5fNPNRcyqfkLVwDjBhKD+XpTB0H
         z/jGF6gx2OnHz+FwHYBMPLMqKgI+vsFbQPl+fMQmZ02W3iODT3khJnbsEXFQBkosRI0s
         cLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679359905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/SMhSBZYB4QrO41/CqVDHVj5QCw+KIQVOvV8RHW7oQ=;
        b=iyoaE8/0dsBscl8CGG3dpU/Cms9ZvbD2VcE8lUG59WLZjrODW+OW2+fAQHcorq+Txb
         WuCK3D5DfkIa1QIaEmiUJ7P1u0oReB90po8j6XoYiP4qwsw4HmZsNXrqwpVDtaAKAEGX
         fEZ9FxYVWO4ZpNdwhsfMOZQ/xgofrAuVcu1HQla+2Gll+qKEaUwziOcMxfTJ3Yo7yXXq
         ntExF4k20Qc9pROv6QYJcd+vTkSag4LswvjXHygP8334KKSLOZ7e5vPGIx1sZ1k0zApk
         LuU9RElub4/+MJNY5GG7Zsg3Xl1JoHcMu6wWi/v3sbBCZeczfifhD6oklAKMhARNk1Eo
         EPwA==
X-Gm-Message-State: AO0yUKWwngUiR7jRxRpPyMJ0bWH2K/eBlXLojzTfu4R16Ayxb9LXBlTH
        ZetXiI7f79FEjVl8+6b/dGnkE9GSLzw=
X-Google-Smtp-Source: AK7set8KtsLFLTwxOD4erVt1H/bOkxkh/tyZkv0yk6tDNjxc1lEz0yYY/2i35y3pTcA3sr60speiI/JMGX4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d506:b0:19f:22b3:508d with SMTP id
 b6-20020a170902d50600b0019f22b3508dmr118964plg.11.1679359905121; Mon, 20 Mar
 2023 17:51:45 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:51:43 -0700
In-Reply-To: <20230211014626.3659152-5-vipinsh@google.com>
Mime-Version: 1.0
References: <20230211014626.3659152-1-vipinsh@google.com> <20230211014626.3659152-5-vipinsh@google.com>
Message-ID: <ZBj/n3g/c0iqQAUj@google.com>
Subject: Re: [Patch v3 4/7] KVM: x86/mmu: Optimize SPTE change for aging gfn range
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
>  	} else {
> +		new_spte = mark_spte_for_access_track(iter->old_spte);
> +		iter->old_spte = kvm_tdp_mmu_write_spte(iter->sptep,
> +							iter->old_spte, new_spte,
> +							iter->level);
>  		/*
>  		 * Capture the dirty status of the page, so that it doesn't get
>  		 * lost when the SPTE is marked for access tracking.
>  		 */
> -		if (is_writable_pte(new_spte))
> -			kvm_set_pfn_dirty(spte_to_pfn(new_spte));
> -
> -		new_spte = mark_spte_for_access_track(new_spte);
> +		if (is_writable_pte(iter->old_spte))
> +			kvm_set_pfn_dirty(spte_to_pfn(iter->old_spte));

Moving this block below kvm_tdp_mmu_write_spte() is an unrelated change.  Much to
my chagrin, I discovered that past me gave you this code.  I still think the change
is correct, but I dropped it for now, mostly because the legacy/shadow MMU has the
same pattern (marks the PFN dirty before setting the SPTE).

I think this might actually be a bug fix, e.g. if the XCHG races with a fast page
fault fix and drops the Writable bit, the CPU could insert writable entry into the
TLB without KVM invoking kvm_set_pfn_dirty().  But I'm not 100% confident that I'm
not missing something, and _if_ there's a bug then mmu_spte_age() needs the same
fix, so for now, I dropped it.
