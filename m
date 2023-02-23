Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FC6A0C37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjBWOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjBWOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:51:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406672E62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:51:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c1so13420691plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEUVY9QBnLvwF98etOxaJbhE4h++5n3g+trhyX9ajRk=;
        b=kEJxBS9j71RwghpfwM+h/k5OW36kiC6Bau1D0zJJ3QwxCosQAEaUK7j8tlK41kc372
         jK1AADV4wurJ2USeEy3Qb3IoZYz7jy9ouXXwQiZPIOzN/hnHXnim+gNwkN6josRZPdKE
         zaRfSn3NnFGwiQk0EwXuHH+jFcCZgi9GSxH2IKqeJi43ijz+Inv/1bUpQb2rA+Gu9ZnD
         BdNhk1Rrg4YRto9XmYSTecFdDBjr+OkX2yPagOmgcXXAMVOBd7ja+dnDxpopcXvHVdyn
         uL/uyIVnexBrmXjc7Z4tOC4UdFSmA1l7Ga/SePzc4wptHfBfo+xOUElBSfukEMRbQAOn
         wWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEUVY9QBnLvwF98etOxaJbhE4h++5n3g+trhyX9ajRk=;
        b=qdrkcFf7O3cszieNSusMqTLbG/bfvNFoT61dOC10iHKeTw4ITJZylJ3+lFZXpTyEYL
         5RFutjuNZ1OwrKetQs5d3gP1LPZJMjY0flmh27epHSnA+c9Mdmk8bJEGNE/aSn5AZCS2
         THBP5fisB7Yt0PNLufzHLidNZvLwKVU0yaR+h1+3Yyu7YlsSryhhIltisHew5NER7qUW
         D4l2LiaBNvrhyQWiH7Nmde76+QvoDp4howg9ZJr9nylKLIL5ATdTGgqP7o9wPempzb8A
         1SEbzZ3Iz2/vnVVkuTB2n5ru9IHnUJ8NDCnDxP63YebG5Qqk37udm0Y3x3Eyt/l+6PTl
         CtVA==
X-Gm-Message-State: AO0yUKUwOTcUeGDw98zV50fS+TUMMmg1ROxVLEm7OFKvJlnkZzwo9lji
        oIjvXUye/ZTEnrs3it04RBo=
X-Google-Smtp-Source: AK7set+AXrDvurkmZHBIHkoQR4SlgO4/MpxUgUaKT4owdS7TPv/KoAYY+Ao1bQkwjxAqSPbEXm7qnQ==
X-Received: by 2002:a17:902:c408:b0:19a:b869:f2ef with SMTP id k8-20020a170902c40800b0019ab869f2efmr16382793plk.15.1677163901908;
        Thu, 23 Feb 2023 06:51:41 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id iz1-20020a170902ef8100b00195f0fb0c18sm966230plb.31.2023.02.23.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:51:40 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:51:27 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 16/35] mm/mmap: write-lock VMAs before merging,
 splitting or expanding them
Message-ID: <Y/d9b5Ev6vAEzzVO@localhost>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-17-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216051750.3125598-17-surenb@google.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:17:31PM -0800, Suren Baghdasaryan wrote:
> Decisions about whether VMAs can be merged, split or expanded must be
> made while VMAs are protected from the changes which can affect that
> decision. For example, merge_vma uses vma->anon_vma in its decision

Did you mean vma_merge()?

> whether the VMA can be merged. Meanwhile, page fault handler changes
> vma->anon_vma during COW operation.
> Write-lock all VMAs which might be affected by a merge or split operation
> before making decision how such operations should be performed.
>

It doesn't make sense (to me) to update vma->anon_vma during COW fault.

AFAIK children's vma->anon_vma is allocated during fork() and
page->anon_vma is updated on COW to reduce rmap walking because it's now
unshared, no?

As patch 26 just falls back to mmap_lock if no anon_vma is set,
I think we can assume nothing updates vma->anon_vma (and its interval
tree) if we are holding mmap_lock in write mode.

Or am I missing something?

--
Regards,
Hyeonggon
