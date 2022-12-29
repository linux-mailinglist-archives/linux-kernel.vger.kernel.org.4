Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5F65906B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiL2Saz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiL2Sas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:30:48 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32067E00
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:30:47 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 203so21389238yby.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eK7n1ws2WcG0waDTRu+O3A0BCNoRbhODPLcsgDDo3Q8=;
        b=Yh2zmxWqOHHAFR+IODFXfo5EgugJNXP4HS+funosv9mmvuhpi4TvuWuiZ+y+1boM+L
         DCQwVIYI4gDwvrYFw9r7EZOrtCVuG36+ZUJnwt5AQGFUbton0k7San2dVW01iboObhkZ
         0k4YR5DY/YluFcU5B1zoNmxcczFqOOTazjVs4ZqfsDKeM4wQj6/Eb2+fP3EoitKsKV+I
         iy7mKRUbK0AxKphCHG4dADG0FfFVsWkhIrzL3TlwMekDQY435VISVhjnYPmA5BtW7IKy
         17SPZ0NMOwVEjZ6lhpIX/vWoZBGoF75LZPBIk4JtY4BA/9wPc6oML228NwQrWo/oXZaC
         SpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eK7n1ws2WcG0waDTRu+O3A0BCNoRbhODPLcsgDDo3Q8=;
        b=q6OB6hxrjGBzri2KsdPdIlfUdS+8Ek4bYzpIOaBHvoQYYMq1Xz3QpAjI/4Oxl+czrc
         Ff5tAufkdBhjWYgMGo3WgvdK9dPPrQ9H8ACwHDTjZf9YkCWpDJaE5qwKzTFFurDBMn2U
         Uxl4wiHbdP5BqwvdLG4tnBbnaOldBoGvxqc5hhbLFx5/kB77myFKqyUpqkCWnjL5BubB
         BjGM+a0uLvqYpYm7s9yh2yITR0Bw9eBd0+cvGXcr34rkbTzfhXGysdq/Q8qR6rJO17PS
         5Cm1wVJ9+2ni2o/ksIvv1FKzfEXpTcD2B087ViJ2F35F9f1mTPvxwsG779+uNl5ok/SS
         5WbA==
X-Gm-Message-State: AFqh2kq7WeAnUZCYjzC46Os89a5nlqKwvF/A+kv3BmwOqed4tg+fswUI
        TqNeJh4Z5T9dBbTxyxkod74TC7OVl+VynchDeAvZ6Q==
X-Google-Smtp-Source: AMrXdXvhdOITh6b9oxTSQEr0IMc24EgLs659VNyESwPFjQBFdoFblc7lunk3l5kSHBeDRzZwl20npxuFRk8xJg+N8dA=
X-Received: by 2002:a5b:1c8:0:b0:6fe:46c9:7479 with SMTP id
 f8-20020a5b01c8000000b006fe46c97479mr3327366ybp.191.1672338646326; Thu, 29
 Dec 2022 10:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-10-bgardon@google.com>
In-Reply-To: <20221221222418.3307832-10-bgardon@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 29 Dec 2022 10:30:20 -0800
Message-ID: <CALzav=e5xeUVCJVPax216MxbQJWEDuZrAtULWLH7GBXB5RURnw@mail.gmail.com>
Subject: Re: [RFC 09/14] KVM: x86/MMU: Only make pages available on Shadow MMU fault
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
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

On Wed, Dec 21, 2022 at 2:24 PM Ben Gardon <bgardon@google.com> wrote:
>
> Now that the Shadow MMU has been factored out of mmu.c and the naming
> sheme has been cleaned up, it's clear that there's an unnecessary
> operation in direct_page_fault(). Since the MMU page quota is only
> applied to the Shadow MMU, there's no point to calling
> kvm_shadow_mmu_make_pages_available on a fault where the TDP MMU is
> going to handle installing new TDP PTEs.

Jinx! An equivalent change recently went into kvm/queue:

https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=1290f90e77186bf8a06a3a35ebf254f5b004676b
