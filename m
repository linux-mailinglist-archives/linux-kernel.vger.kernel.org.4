Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578268C93A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBFWRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFWRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:17:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DAF126F0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:17:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so38373020ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nC6xC54EQvps3Ky2cRXzTWC/M+PD3ChLKHO+gA8/xto=;
        b=KU+umniGYKf1VCPRVo4cc9eVZQ+hD9FcJLgQdHFue9famLT9alPW/pAPgYIltimHRK
         JOpP3uN5dt6f/H0j+/QPjFGqIjGwmRrcdOdsIAR4fw6O8GTV+hlh1ldwKAskm6m5fYOE
         3TCrMcdCszZtIhwcVKkiCSHlqX5McGBIdv9cChht330WR2WswpgO3P596U2pUBZBW9Fe
         IXc6qLRJU7+/9+uk5s1l+1qkzC0IgOUkKVVRDTYl9XCbpg5ibooTBEBuQM9RyLNFjNsS
         rI85rHcH48LSECTkd7+WSqkaIJPPZN/vd9BZPNaRK7WegvONAffiU7ptOpOH0IT6+TxQ
         IqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC6xC54EQvps3Ky2cRXzTWC/M+PD3ChLKHO+gA8/xto=;
        b=dvEcKIHeuPVep1E6ARaJbHV1lpBDQHcbjPNa4yX9XI/4/gydsMJcE7J2bc+2rk1q9m
         plJJhrHhgivbrVKmbkJKccvTTZAO4/y7qBuR7hxOTZliTY7M9qRWDPIr0uO6dCCAUptx
         ZHlwhD5MC48EjNKIGhLaGjjtgzNn17iSuPgad27jxdIvKesg13l6j+S4XhsPDPPHvdKx
         8r1JcdjG3LhJrakromqzOsjav5BgGS9iC+137nzIyrRpAwJDOUY2CttFk+/X8kx4eVW6
         jaafiwQj4TUIRMmxB13v1Z22nSbSS5lXIR8qbvh1lwjinEzwqlr6T2EATF0YoGuPEB89
         7Sqg==
X-Gm-Message-State: AO0yUKXftAqxostCSNWnBgfHb2ZRjti4rz5rLyXWJmNgbXJURjSmTTnT
        UNYHlvFl4VFdVK95vV9Rc7V7Nbsfk50bxP2mP0iTag==
X-Google-Smtp-Source: AK7set9zG3Ji+a3VKGeceKn9IjBVJKG2Ph/BPhBNftp1IcWkdSA8t7OwoZ+mwNNLzTNG+wXfUCJeRJZsl6WKgLBwZ7s=
X-Received: by 2002:a17:906:3008:b0:878:8bd5:4bdf with SMTP id
 8-20020a170906300800b008788bd54bdfmr265584ejz.270.1675721837590; Mon, 06 Feb
 2023 14:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-4-vipinsh@google.com>
In-Reply-To: <20230203192822.106773-4-vipinsh@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 6 Feb 2023 14:17:06 -0800
Message-ID: <CANgfPd8NF88V+ddqeCBsz=NRgm-YV7nH1DwDhRsHpA_AnFBB7g@mail.gmail.com>
Subject: Re: [Patch v2 3/5] KVM: x86/mmu: Optimize SPTE change for aging gfn range
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Feb 3, 2023 at 11:28 AM Vipin Sharma <vipinsh@google.com> wrote:
>
> No need to check all of the conditions in __handle_changed_spte(). Aging
> a gfn range implies resetting access bit or marking spte for access
> tracking.
>
> Use atomic operation to only reset those bits. This avoids checking many
> conditions in __handle_changed_spte() API. Also, clean up code by
> removing dead code and API parameters.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 68 ++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 83f15052aa6c..18630a06fa1f 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -697,7 +697,7 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
>
>
>  /*
> - * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
> + * _tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping

Nit: Not sure how we got to the point of having a single and double
underscore of the function, but what do you think about just calling
this one tdp_mmu_set_spte and the other tdp_mmu_iter_set_spte?
