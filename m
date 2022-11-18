Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223F630341
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKRX0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiKRXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED47FF2B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668813265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2sD/7nQDcm641haY/C3yaUw5XrSrZUByds8laMM8v4=;
        b=HoL/SSNhF9pdXc2mxLhkXne1M+5LPhc8p13aatvEH/F2p5D1aRVgqIa7vEln8q/HFv3taQ
        KavfgJUPMuSJxTGzoysPNvoVvUTp1G0leYCgvb7+Djp4cjrIvoCfUc5LRnnLiHn5t7fu/i
        Nq7ADBmHF2i+QllPjBqQia+nFt04QeY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-SHf3nRw4M8yeVBOaxllzPA-1; Fri, 18 Nov 2022 18:14:23 -0500
X-MC-Unique: SHf3nRw4M8yeVBOaxllzPA-1
Received: by mail-qk1-f199.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso8134029qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2sD/7nQDcm641haY/C3yaUw5XrSrZUByds8laMM8v4=;
        b=FL/eqUWmxZVrMKq47NXmdaIAAvWWEjur29CnLyoy6iEw5eghU54rxg7ZvLITc9Q8tv
         TH3NYdgdp0yM3XqLP7kou2TNlaNjHO1jywDMotBEVplkeq8HpgnCk5yzIkyp7xJCH2Fs
         813jTLVMv1IFpD1h7xGaSoyybujLP6GQnQ03kz6IqDJ6pWQCM5XW4kBe2HkOGf0D3186
         BcPjsyhfq2Ij+hrnPSUCxvY6iFKg8uUO9uGZ395IuWpMSrA4UWz82lA8PgLLbTmDlHux
         MvQUAlSOXmcGdHp2risb/8T/Hx+KaTVWUnQcuRaHN/VKIzf9HGR4rKGmLMEjmvxZuiK9
         /5Ig==
X-Gm-Message-State: ANoB5pmlgYldJqowo2ngYt+Wv8M8BbzA/eZtxvc8OxHcpO8ZeveM4dQb
        C/WCMbZYSsk8kO1PT3tpwMo5TommsT1bHaAG/KV1WSJf6IOmNVcUI/7L/s1j/HGhAcFGk2yh7DY
        FiGz7Fc+PXClWuqGnHuxIT3Lb
X-Received: by 2002:a05:6214:5702:b0:4c6:9e2f:4496 with SMTP id lt2-20020a056214570200b004c69e2f4496mr1810699qvb.98.1668813263139;
        Fri, 18 Nov 2022 15:14:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6WH3JJ8PgUUP/Sm2JEOSSc5NnnJvB7CdYJAp7s3wC8wuiFRnbp9WovIi90V3/q5zkzHZ9GJw==
X-Received: by 2002:a05:6214:5702:b0:4c6:9e2f:4496 with SMTP id lt2-20020a056214570200b004c69e2f4496mr1810689qvb.98.1668813262860;
        Fri, 18 Nov 2022 15:14:22 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t20-20020a05620a451400b006ceb933a9fesm3408375qkp.81.2022.11.18.15.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:14:21 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:14:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Message-ID: <Y3gRy8pUiYWFGqcI@x1n>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:16:26AM +0500, Muhammad Usama Anjum wrote:
> Hi Peter and David,

Hi, Muhammad,

> 
> On 7/25/22 7:20 PM, Peter Xu wrote:
> > The check wanted to make sure when soft-dirty tracking is enabled we won't
> > grant write bit by accident, as a page fault is needed for dirty tracking.
> > The intention is correct but we didn't check it right because VM_SOFTDIRTY
> > set actually means soft-dirty tracking disabled.  Fix it.
> [...]
> > +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> > +{
> > +	/*
> > +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> > +	 * enablements, because when without soft-dirty being compiled in,
> > +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> > +	 * will be constantly true.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +		return false;
> > +
> > +	/*
> > +	 * Soft-dirty is kind of special: its tracking is enabled when the
> > +	 * vma flags not set.
> > +	 */
> > +	return !(vma->vm_flags & VM_SOFTDIRTY);
> > +}
> I'm sorry. I'm unable to understand the inversion here.
> > its tracking is enabled when the vma flags not set.
> VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
> soft-dirty. When we write to clear_refs to clear soft-dirty bit,
> VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
> is enabled when the vma flags not set?

Because only when 4>clear_refs happens would VM_SOFTDIRTY be cleared, and
only until then the real tracking starts (by removing write bits on ptes).

> I'm missing some obvious thing.  Maybe the meaning of tracking is to see
> if VM_SOFTDIRTY needs to be set. If VM_SOFTDIRTY is already set, tracking
> isn't needed. Can you give an example here?

If VM_SOFTDIRTY is set, pagemap will treat all pages as soft-dirty, please
see pagemap_pmd_range():

		if (vma->vm_flags & VM_SOFTDIRTY)
			flags |= PM_SOFT_DIRTY;

So fundamentally it reports nothing useful when VM_SOFTDIRTY set.  That's
also why we need the clear_refs first before we can have anything useful.

Feel free to reference to the doc page (admin-guide/mm/soft-dirty.rst):

---8<---
The soft-dirty is a bit on a PTE which helps to track which pages a task
writes to. In order to do this tracking one should

  1. Clear soft-dirty bits from the task's PTEs.

     This is done by writing "4" into the ``/proc/PID/clear_refs`` file of the
     task in question.

  2. Wait some time.

  3. Read soft-dirty bits from the PTEs.

     This is done by reading from the ``/proc/PID/pagemap``. The bit 55 of the
     64-bit qword is the soft-dirty one. If set, the respective PTE was
     written to since step 1.
---8<---

The tracking starts at step 1, where is when the flag is cleared.

Thanks,

-- 
Peter Xu

