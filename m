Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4036B2CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCISUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCISUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:20:13 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75653C6411
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:20:12 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id o1so2852182ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678386011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2FHn4vNTsI7Pkb7eR9OOTXHHjNIfcX864otfH8ImVk=;
        b=c/Y+ySejKOs+mZC7cXA5f/Wl7S5l6jsKQzLG0Z5ZAFPREDe8DOqsYNmFdsV5JYIMWh
         AKzH22z/N8q+qc2Tpj5GwFJ5FicmnWwy5b5R/8P/s5y43WmDCKtcC2s4Y3DwnhzYzAQ5
         QPKrnxccRxl2ENsTl6La5FiRRemaNldkvVkFsNhA5VSqqplYF0v8Qz5OwwknfHspAyVG
         MsnEmwSpbDko1MPWzXAshuUYlw0bSQRS0WLvHx688TD4xYWdck3HLP0d57EESa3rHzyT
         zo5nMXFZlmeo0Yn3y+QP912ZfYI0ATUXQgbVSGI/uY50nMmY72DkR7c+smvqeTgy00mC
         m8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2FHn4vNTsI7Pkb7eR9OOTXHHjNIfcX864otfH8ImVk=;
        b=LbJWNboaHDYvzo6sg+LRJXmcsW0RrbfCibGiAiQdQmfBqa6r3jDPX74WomcU9ACeY8
         ccAG4M9p9fjX+bC9zXjjND9+X9PqOyBemcy+Gid4Ct8/xSroEVye+kjfNKDVZIx5X0Tw
         wK5Zx1NjCffTWRa8gzZRkYbXPl2na+8iT5k+AM3MCgonLaM2TzNrv8zoUWRMlVUFxL5u
         W5GP276RjwNvsB3xGQjLO/nm7HStPDwiWnqlS4AJW7htFmzh4cnKkVdRnlGF1PmExGFD
         HEwQGkZCmF8rtCxECM8pvzsCSPMlmd04wiGiSivOSbmssI7jR4BBEphqivbCt9Dnpgf1
         HrwQ==
X-Gm-Message-State: AO0yUKVy6zZp9G8ddvP7DlCO5a0gvnsSbOBC3c4vlOZS1gbfTsWok3J2
        /WiPJcvgqICE/y82ZhEKv+yM2q8Q70DbYmXVjMbIyS5LnOt7eGPoQr8=
X-Google-Smtp-Source: AK7set/g/HiwEjyA3yT4naLUcO9drgcQWzaFo7l8Z+z29sUgBInscWhDcw+bC7BmS+oMBV7W/gYz/KztcuNDxemkXCc=
X-Received: by 2002:a5b:bc6:0:b0:a0d:8150:be04 with SMTP id
 c6-20020a5b0bc6000000b00a0d8150be04mr11512210ybr.13.1678386011401; Thu, 09
 Mar 2023 10:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-4-vipinsh@google.com>
 <20230309173709.0000505e@gmail.com>
In-Reply-To: <20230309173709.0000505e@gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Mar 2023 10:19:35 -0800
Message-ID: <CAHVum0f9JBE9vL4FW1_iH7mq6xjGQWG3J6TZ2Z-rRMQM8GocVg@mail.gmail.com>
Subject: Re: [Patch v4 03/18] KVM: x86/mmu: Track count of pages in KVM MMU
 page caches globally
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com, jmattson@google.com, mizhang@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 9, 2023 at 7:37=E2=80=AFAM Zhi Wang <zhi.wang.linux@gmail.com> =
wrote:
>
> On Mon,  6 Mar 2023 14:41:12 -0800
> Vipin Sharma <vipinsh@google.com> wrote:
> >  /*
> > @@ -6994,3 +7048,11 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> >       if (kvm->arch.nx_huge_page_recovery_thread)
> >               kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
> >  }
> > +
> > +void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *shadow_pa=
ge_cache,
> > +                             bool count_allocation)
>
> Is it necessary to have the control of count_allocation in every call of
> mmu_sp_memory_cache_alloc() instead of taking
> shadow_page_cache->count_shadow_page_allocation directly?
>
 You have found in patch 7 that this is cleaned up.
