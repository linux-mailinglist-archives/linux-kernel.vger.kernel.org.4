Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57571F7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjFBBWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjFBBWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:22:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65E19A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:22:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ba5667d5so19716587b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685668959; x=1688260959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L8VyB36ynvlSOk2tKH4CvN2Q83nfEAT9W0QbjLZrOQ=;
        b=7w+gX6kgASJ/T3O0D33AM4Mmaq7PbMn5szbebv99khay7USD1J+MPAnpWXWGptmyiR
         Ct3j55Eyy7UcYi2fvgDkQQC5Q2sxAEDmzadHexhsLdo+YaMYHP4GGoE1Fxmzph2AFjU/
         fnw8No0DW3K5vT3CqkG3CUY+FsDUub5elQUNHZhl0TruMbazJJJ6IHxjxUIkbZWA4qFH
         OAWEgUvTV08CE1ZUEVVJ6oEZvngJ6hUVKITxHUFYkhd4GQDTKCXnNIErjvwfabynxO2U
         bmUQRn2i7tacoRu3/6/549iWU4k0Lkl6ZQxwV9b4w08l6ccowCS4ctimUd2LfQ546d99
         TxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668959; x=1688260959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L8VyB36ynvlSOk2tKH4CvN2Q83nfEAT9W0QbjLZrOQ=;
        b=Z4ofygFjWP4AxKTuLpbzrUgGil6Ta9jMIYpxfW6VJTgC9Q0mSSwBHBYLH7CVdCMmie
         hAWQWdjIyfLooEAONsq2KCDAmyxi0PNSpLvglJ46AEY2IkCpvVXTbBjWLfONrZh9zX/V
         pKhjYLzRqEPMdt1enqRJH5+sF0O4AFQSt+rqpejIW6NCdw9F5ptuHAAl4iOiuduqcnxo
         LWOqZdBv5TwPuuObQL0DC0H/Ntm2b2Brl8AtVtZ2j8urAIqNpZKhIDCwQAXToKxV0Rcm
         xu/yS6jNis8hTOfQiQHutUz/Pl4NFQpCKRUhg9ipLFhckwAqR3FceVhmwpyfxbXg2Eey
         etDQ==
X-Gm-Message-State: AC+VfDytqH3wethEuZZp8HinC6FnLzthI8Y6udhDn+vYczdv/v7X6Fbu
        yrMPOZF3UEUNd1ypzsA6YXSd7tKXiXI=
X-Google-Smtp-Source: ACHHUZ5uVuOeEkTL+OUZ1Y7x8ro5g3vpmIb3LVVqWQ0B/p751jpgkE/1XSnj0awaLDOg8bBE2EjQ/C3UFO8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af10:0:b0:559:c032:eb5e with SMTP id
 n16-20020a81af10000000b00559c032eb5emr6090590ywh.1.1685668959204; Thu, 01 Jun
 2023 18:22:39 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:21:51 -0700
In-Reply-To: <20230526210340.2799158-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230526210340.2799158-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168565363778.667891.6228323233552429426.b4-ty@google.com>
Subject: Re: [PATCH v3 0/2] KVM: x86: Report actual nent from KVM_GET_CPUID2
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takahiro Itazuri <itazur@amazon.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 14:03:38 -0700, Sean Christopherson wrote:
> Essentially v3 of Takahiro's patch.  Update cpuid->nent on a successful
> KVM_GET_CPUID2 so that userspace knows exactly how many entries were
> filled.  Add a testcase to verify KVM's ABI.
> 
> v3:
>  - Don't bother updating cpuid->nent in the error path, the data is never
>    copied to userspace.
>  - Add testcase to cpuid_test
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Update number of entries for KVM_GET_CPUID2 on success, not failure
      https://github.com/kvm-x86/linux/commit/ab322c43cce9
[2/2] KVM: selftests: Extend cpuid_test to verify KVM_GET_CPUID2 "nent" updates
      https://github.com/kvm-x86/linux/commit/2c7613131998

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
