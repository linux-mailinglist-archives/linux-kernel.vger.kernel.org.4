Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FAE6A0C63
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjBWPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjBWO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:59:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6699211D9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:59:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ko13so13842710plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+yWMvIWvw3WCrNeIHfg2T45OrUG0bC11D4EFok9F+M=;
        b=EB6dxFuO49E9hfnx+Osyz4QjHI3/kf2CZqPTbL8bZbPI2QTYpJp+BuVJf6x9/Op3aS
         xof+1Uoax1p7nvbELL+hvfbo39TWfpBmEBoy9EpUsAQdrTSvZuTrHRoWXL0gdYKaEor+
         FlUMT4ZM537FZvyLzQVS2uN0IxwQHFIi6aHEt02yLOvzx/nI4cU6h6Jhn6sPqf2zGz3q
         7n1Fj4k/PR8q2dQfzWmocEZdEerzfVqSvdFp8in5t8rCq1veO/qkTc35xDsvKZ7O1cgU
         codFdh6jBnohjFOUx2BlZiCyA2YSs+IROp6V+lyMbfz4+T3nV1nwcz5dHnaW98oy8QVz
         yOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+yWMvIWvw3WCrNeIHfg2T45OrUG0bC11D4EFok9F+M=;
        b=eRH4eCou+L577H7bTI7fP0pe9kgdoKvF5OeEzsnUoLldCgcb/7iUkxN92aCtmgsmzc
         iELE9OjbdoTGI7UG1BeJkdMGKo4Ew4Vjb3mVyr5IpMFPMXbx9VA3tuDYgUArqGw88q0F
         hPNFm8SUUtunGzMrZQgtXky2NmQ/JvSzxjB1Jw84XpIeHwYAT4CcZg37VjGPXUKRsqkv
         j0cFIfz5C+WRwU8oMAcUCbHZRW7+75Kqic6HI+nkYVbXxPNUS4fa4+XZUpbk1KpEUzLF
         vJgfdjtJO5bOiiIs+9q8zVrUuwwwEJ3tOpchHa66KlZ2sERokDDF1ywjkJd4HLnfM7kl
         zo0A==
X-Gm-Message-State: AO0yUKX2guW0rfNvSDA+BIOIVqfD8nGJv/V3hvMIgBzqUlvTd+nZi+jK
        5B6a3HzPMjd29c6cv3FbFqA=
X-Google-Smtp-Source: AK7set/Qc2kRq6mVoIFJONVn7gWNZxeDHePlIGkq7CYhB6h9Zfh2pnK8s5XWdm4snMLVlByeQRXokw==
X-Received: by 2002:a05:6a20:3d0c:b0:c7:1bac:6ef9 with SMTP id y12-20020a056a203d0c00b000c71bac6ef9mr12306390pzi.46.1677164386983;
        Thu, 23 Feb 2023 06:59:46 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b005ac419804d5sm1703160pfb.98.2023.02.23.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:59:46 -0800 (PST)
Date:   Thu, 23 Feb 2023 14:59:34 +0000
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
Message-ID: <Y/d/Vs1R/+ldNeuG@localhost>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-17-surenb@google.com>
 <Y/d9b5Ev6vAEzzVO@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/d9b5Ev6vAEzzVO@localhost>
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

On Thu, Feb 23, 2023 at 02:51:27PM +0000, Hyeonggon Yoo wrote:
> On Wed, Feb 15, 2023 at 09:17:31PM -0800, Suren Baghdasaryan wrote:
> > Decisions about whether VMAs can be merged, split or expanded must be
> > made while VMAs are protected from the changes which can affect that
> > decision. For example, merge_vma uses vma->anon_vma in its decision
> 
> Did you mean vma_merge()?
> 
> > whether the VMA can be merged. Meanwhile, page fault handler changes
> > vma->anon_vma during COW operation.
> > Write-lock all VMAs which might be affected by a merge or split operation
> > before making decision how such operations should be performed.
> >
> 
> It doesn't make sense (to me) to update vma->anon_vma during COW fault.
> 
> AFAIK children's vma->anon_vma is allocated during fork() and
> page->anon_vma is updated on COW to reduce rmap walking because it's now
> unshared, no?
> 
> As patch 26 just falls back to mmap_lock if no anon_vma is set,
> I think we can assume nothing updates vma->anon_vma (and its interval
> tree) if we are holding mmap_lock in write mode.

*Not interval tree, as it can be modified by other processes*

> 
> Or am I missing something?
> 
> --
> Regards,
> Hyeonggon
> 
