Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB526C7352
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCWWvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjCWWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543EB75A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d2-20020a170902cec200b001a1e8390831so145700plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679611865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqFc8A4lyhPY/42dCbIU0IYFB1GySYWnAocQAi1+h4Q=;
        b=BPiGWjMeDRpQTgZB97UOimTIL3OYBXSDT/6fJgZVC6gQgZ5fCzvw1lRDNKKawrXLv2
         E4PvzehXk27nt/drVvcaTHR9RfvY1ewNnFoU10fr+1Bw5wJGJAEvr9IlV+tYUIe1jSLS
         go12kdYqwO37wrDkww5Pk4Sg28nsUokR0/t6+6HxBHhBgfvCdRRiq82yIPmJWwekGzv5
         7hiF3kgoFEvlUc2wb11M9OqS7XWiI6j6q12XRxrhO9zaDi8/tNMkKP01RUNiQlh4ugyh
         6GgqD3giutQ3Oy505lN1UgV0cSUu3sK69NQGcsNXXvMU0zCcFLrIZTwUHA23JZUJ87hE
         wwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqFc8A4lyhPY/42dCbIU0IYFB1GySYWnAocQAi1+h4Q=;
        b=ILtmpd6lwZO9CYJ39bQcA3+gwse5AiNJSKuJldB8K8B36OftJW9nHJMKTypQqqiSSA
         SgGkV3Gywhn3v3/Yvbzt6ezB2OkJ8lD5caws4HvByqqRngoHOut1PrXm9+6t5cOSVw5e
         DmL5Avu8wnSkq7Fbqm8yEHp2N0Rrof6fZ2iIR4yfaTjBXAMVtBMZ7iHkC0f94Ekzp3RZ
         1FCj8LEc2fUZDXYXtbj0AQ2mXqVzC/DRWgk7kdsML1BU8udH8M/CAQgUHMIrywDWGcWm
         mRt41DxXVVn+mRSUmYsRLRrfMbpZNXGfSEqX2HLhkBG7v9qXjmQVwSKR4v+bNfJ/80jn
         di9A==
X-Gm-Message-State: AO0yUKU/mW+tG5qIer+yLNU12MoPA2jnUx1VaSzRMq2gnWD33xyV9wsi
        BUcHSOMD3UjqOQ5CTbKuWaVIhuwMGUQ=
X-Google-Smtp-Source: AK7set+c5Oe8EOFfr51iU86OvsiSeB7dYNOcFLpSUDdYqdgPEt9K+BfSwaK38fcJtMRO5Wf6VIN+Mei8mGY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8891:0:b0:5a8:daec:c325 with SMTP id
 z17-20020aa78891000000b005a8daecc325mr3364999pfe.1.1679611865307; Thu, 23 Mar
 2023 15:51:05 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:50:30 -0700
In-Reply-To: <20230113122910.672417-1-jiangshanlai@gmail.com>
Mime-Version: 1.0
References: <20230113122910.672417-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167934153606.1941128.1026865175616779306.b4-ty@google.com>
Subject: Re: [PATCH] kvm: x86/mmu: Simplify pte_list_{add|remove}
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 20:29:10 +0800, Lai Jiangshan wrote:
> Simplify pte_list_{add|remove} by ensuring all the non-head pte_list_desc
> to be full and addition/removal actions being performed on the head.
> 
> To make pte_list_add() return a count as before, @tail_count is also
> added to the struct pte_list_desc.
> 
> No visible performace is changed in tests.  But pte_list_add() is no longer
> shown in the perf result for the COWed pages even the guest forks millions
> of tasks.
> 
> [...]

Applied to kvm-x86 mmu, thanks!  I added quite a few comments and a BUG_ON() to
sanity check that the head is never empty when trying to remove an entry, but I
didn't make anything changes to the code itself.

[1/1] kvm: x86/mmu: Simplify pte_list_{add|remove}
      https://github.com/kvm-x86/linux/commit/141705b78381

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
