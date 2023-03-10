Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A126B32D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCJAhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCJAhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:37:03 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9551009F4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:37:02 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n18so3772142ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 16:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678408622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAzBBc9wHE3faAQaHPnJrzBYGicXWfO6YwSCnEUYwO8=;
        b=DP801WyB9U7zGzT/wgHu2FqpcApFrv30zcfazOvaL/QbMhY+5UMOiBKi9iletv3b2+
         BdsHI56hT7iu4nY0wvzW2XE3B5pG6LV7vevijrN9KvG67biMrDWkTxPH4MVQvoahknWl
         NMzP6AqxUaxgSJOU78wmtxBCot39quUVXNJ0iDWAA0HdPCdUM1Etlm6A+kMs19wjT1TN
         HD1wUzxcmQBK8OUmtH5OWX+Cg74EuyKV6DplhR6tktVccIUbNCnmrjLntJv+h+GSrYV4
         WAbVX3Y9XYnsicXx4KSAsJmnRsn7XLeBWlmTnnJR+XwvkPn+ocN7zpdZwMi5v4nVxJNm
         viVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678408622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAzBBc9wHE3faAQaHPnJrzBYGicXWfO6YwSCnEUYwO8=;
        b=DaQ70bkN6ycXB+jUu/c4DxC1HnYY5CdaZoHEVJBkN+peasqkC3o58C/FTEjsL1F0M7
         olxK/6DiJwSQpvqHq49cJLw8DrV0wxmYVoWWXmFrvjStu8YE2pKZUzB2ObhaMKRlqiHJ
         drwIfT0/IS4EGMswiQaSeAFjVIqmzu47lPJoiJsA0/Vl2H3+1t456XSsVmZU74dScUMy
         /P5RRrr5OAZKpkgzxTGPLV70a18FAJTed+/Fq89n/fshGlejnIycIb5aMABqqOO6yvSS
         7wSa4IwsysssiYwk3DhrcwPirQmaTkIFg0U1y5FRnb64zfToKxyCXpDWrzFJkihvHYld
         NNUw==
X-Gm-Message-State: AO0yUKWVdWZArlnWX8Yftj3pwX03beRysIaqvTJRi2ZdSMwfV0cw38P/
        a3Io15D08obH/IFjn7TYEJe+BwBYpL3XWkwRjJ1OCw==
X-Google-Smtp-Source: AK7set8Yeo5N8u/LejHHlCHchZWu+69KL1Q3WfPtOJGkyHp006nurs5zxDXdmyxrnnCzgJcZSC8U8vwsygq9QuT+t3g=
X-Received: by 2002:a25:9d06:0:b0:a58:7139:cf85 with SMTP id
 i6-20020a259d06000000b00a587139cf85mr14574043ybp.13.1678408622000; Thu, 09
 Mar 2023 16:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com> <20230306224127.1689967-4-vipinsh@google.com>
 <ZAp4Tb8MYoggn/Rb@google.com>
In-Reply-To: <ZAp4Tb8MYoggn/Rb@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Mar 2023 16:36:26 -0800
Message-ID: <CAHVum0ffHpUCyZTVUYwk4AT1hYqrts6_ErrMo1wrFSFpDZNcEA@mail.gmail.com>
Subject: Re: [Patch v4 03/18] KVM: x86/mmu: Track count of pages in KVM MMU
 page caches globally
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 9, 2023 at 4:22=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Mon, Mar 06, 2023 at 02:41:12PM -0800, Vipin Sharma wrote:
> >
> >  static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
> >  {
> >       kvm_mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
> > -     kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
> > +     mutex_lock(&vcpu->arch.mmu_shadow_page_cache_lock);
> > +     mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
> > +     mutex_unlock(&vcpu->arch.mmu_shadow_page_cache_lock);
>
> Is this lock necessary (even when the shrinker is hooked up)?
> mmu_free_memory_caches() is only called when KVM fails to create a vCPU
> (before it has been added to vcpu_array) or during VM destruction (after
> the VM has been removed from vm_list).

My approach was if shrinker ran just before VM destruction and removed
pages, it would reduce nobjs variable in the cache. Now, when the VM
is being destroyed, mmu_free_sp_memory_cache() will first read the
nobjs variable to update the global counter and free the cache. To be
sure that the latest value is read and there is no memory ordering
issue I used mutex.

I discussed with Sean offline and he pointed out that x86 is strongly
ordered and mutex is not needed when freeing memory caches.
