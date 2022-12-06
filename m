Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119AE644C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLFTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLFTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:09:51 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF632B83
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:09:50 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-144bd860fdbso5441649fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdEVe1fkQEKVdGERRafaR9y25MuuPSNdqysHtrFxhBc=;
        b=NzZ9GEK2anazrjrWt8gm6BsL3RX9wGBqD0SD/nVRp+4i5wDcqbnK1HBEoEcik3nw/0
         KxgQWAtwcx7Az+bFJU0ZTKREJjSD1QfLbCoIBQ6J37UVPFymYsEBYQd+0WhtmCHG4R8m
         V1U95jTzB29gWmrrKg63QSTm5R30jjoCL9muHVq5BAPI5uGHnO/oQ3kLfpXU6zO8Hrot
         oO00ki8ruN9BAFZKQ/5TB9s8cAv/Hyg7DZxPymRHn27d1PcDKlZUNbisAcFJPAfwqi2E
         5uB19jFuR1j5dzyvpwyW7Fk2mdioyp28NpuTgHB5vDjQnVfvuCuMU0iKsd7aGjYXzPAa
         xcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdEVe1fkQEKVdGERRafaR9y25MuuPSNdqysHtrFxhBc=;
        b=tH6UW8EdwRdWtupn2bC/c0AEYzPMpBzD0aQ7rPp3ZEeBEGVyp+YHClLU6diBzCNUo7
         tPPB6/0R6AC4tKdweg6vlC7P7nmHnO3bLND3cko22R7XyRdYKTquZXcjntksfGMBD4Qs
         R8uknmi57G9BjjI5wpCFXCNeV76nEYGEAeua9uIG4I+v15wkJEkKvJTtu4e6LinAZ4Lr
         W07KqkA9oR4EBbfrpV+4A3H6112Vpo/lNoxrJuFjQ7Lcm3J91tnHEsH+v1FV82QgbD0M
         6V/wQTuDPmU4lSRX+WvhN+ZnDgZFvHM3azu9W7uP1/j4llMCX6Fo2Sk2nFNrQNi0CKhn
         a2OA==
X-Gm-Message-State: ANoB5pknPT3YEWES6xxAQyLSmbDvoz9egefTKkBZ8u7nUC6dYFIWMDF4
        5USFdgRMo170TID8yoXnSkso0A==
X-Google-Smtp-Source: AA0mqf7l0XL7uOo6BoG/g25r+wke4Y2gze6v3cH4Tc/K3CHqPCRxv+QBzSm0vFQeyELpckQ3fcD+rg==
X-Received: by 2002:a05:6870:c8c:b0:143:b006:7be9 with SMTP id mn12-20020a0568700c8c00b00143b0067be9mr22835025oab.69.1670353789957;
        Tue, 06 Dec 2022 11:09:49 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r16-20020a05687080d000b00142d7f2fd4fsm11141637oab.48.2022.12.06.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:09:49 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:09:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@goole.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while userfaultfd-wp
 is enabled for a VMA
In-Reply-To: <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
Message-ID: <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com>
References: <20221202122748.113774-1-david@redhat.com> <Y4oo6cN1a4Yz5prh@x1n> <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com> <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com> <Y45duzmGGUT0+u8t@x1n> <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 6 Dec 2022, David Hildenbrand wrote:
...
> 
> We never had to remove write permissions so far from the vma->vm_page_prot
> default. We always only added permissions.
> 
> 
> Now, uffd-wp on shmem as of now violates these semantics. vma->vm_page_prot
> cannot always be used as a safe default, because we might have to wrprotect
> individual PTEs. Note that for uffd-wp on anonymous memory this was not an
> issue, because we default to !write in vma->vm_page_prot.
> 
> 
> The two possible ways to approach this for uffd-wp on shmem are:
> 
> (1) Obey existing vma->vm_page_prot semantics. Default to !write and
>     optimize the relevant cases to *add* the write bit. This is
>     essentially what this patch does, minus
>     can_change_pte_writable() optimizations on relevant code paths where
>     we'd want to maintain the write bit. For example, when removing
>     uffd-wp protection we might want to restore the write bit directly.
> 
> (2) Default to write permissions and check each and every code location
>     where we remap for uffd-wp ptes, to manuall wrprotect -- *remove*
>     the write bit. Alternatively, as you said, always wrprotect when
>     setting the PTE bit, which might work as well.
> 
> 
> My claim is that (1) is less error prone, because in the worst case we forget
> to optimize one code location -- instead to resulting in a BUG if we forget to
> wrprotect (what we have now). But I am not going to fight for it, because I
> can see that (2) can be made to work as well, as you outline in your patch.
> 
> You seem to have decided on (2). Fair enough, you know uffd-wp best. We just
> have to fix it properly and make the logic consistent whenever we remap a
> page.
> 
...
> 
> But I'm not going to argue about whats valid and whats not as long as it's
> documented ;). I primarily wanted to showcase that the same logic based on
> vma->vm_page_prot is used elsewhere, and that migration PTE restoration is not
> particularly special.

I have not been following the uffd-wp work, but I believe that David's
painstaking and excellent account of vm_page_prot is correct.  Peter,
please I beg you to follow his advice and go for (1) for uffd-wp.

I do not share David's faith in "documented": documented or not,
depart from safe convention and you will be adding (at least the
opportunity for) serious bugs.

Hugh
