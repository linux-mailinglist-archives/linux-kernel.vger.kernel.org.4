Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A681165851E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiL1RKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiL1RKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:10:32 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829F1A6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:10:31 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-47fc4e98550so87249977b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYsqnZ8FJ65xaJlOCHcTfd528vZbbXtntY5OMB92i10=;
        b=UkbVoEG8EXDv03CU0ZLBkw9xvwi0gUbu6WtMl0/cSzlfr+HMnEoXWh9otr4CKs9Z5c
         atkhIsOItvBZKXOFzukIjmG6UfPDzKOLfYFLaFznsoXUsFpLdrbpXxDYygAfihpc+4Dq
         Ndu6c8nz2L5bcq+UhdEY+T8o4G/wAD8HnBjKmkx86AIZCsfCjrPcCMuorp/pP9jghs8k
         XixkENiqi6u9SIG3RFGPBKdIfgdy8FDxBbGKAY+OgI8e4BYXGrt6cB6+DRjFBvUnLTyK
         BHtSjt7JzK2d1dYz6w21gB7Tf4P6hL5jo5wrTZbG3/rnZSAnEpXX55QM6cxuRKlg9QGs
         3MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYsqnZ8FJ65xaJlOCHcTfd528vZbbXtntY5OMB92i10=;
        b=wjSZ2t2oHaOnSHkOpImzxKo27Ikv4PzxI5Y4dWwtkqNpbarGLM/sFhyCC9JW3z7iMw
         vwauNrOY/fADjLmR2gEGBWO59vFsAh4VkJBZW2rorUdUmOhJJFNgGZ28ZAtQl7JkPauG
         jLiDnGFVMKuE/LUR7PLYJF+GvIssynL8VfP/NHr9evottGp2Cxmv4zvkNG9gXjcYWT7A
         Hp5ZzjWD59EsPNMxqROrIcJfhlqSCaWkNIntw5xHYX/+/DFIq+QMhBZx/BdtGagVD7Xg
         RC5zSGTwbk34ffsJ2cNJGmZHuAbiCaTzlWDS92ntO4Sf4n+6go6B90GvbNftwNTeHzVC
         6f8g==
X-Gm-Message-State: AFqh2krtGnVIG6B5u+gbfEl8XsljDPrvWaGWyMcFAVs/Vlrril7RIKSd
        rIkXaBdCGyRPKIS7hiaLBUosxb3iSDchVJryzqC6xQ==
X-Google-Smtp-Source: AMrXdXs/YzI0oXArYeCy16hKt7OLDtsFcLJcGXyrSW1Mncb+52cj9t7LwjbFR8qZe929ZW6axi9srVWhK3wRT1TIZek=
X-Received: by 2002:a0d:d611:0:b0:479:b6a1:d9a4 with SMTP id
 y17-20020a0dd611000000b00479b6a1d9a4mr1119032ywd.263.1672247430626; Wed, 28
 Dec 2022 09:10:30 -0800 (PST)
MIME-Version: 1.0
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
In-Reply-To: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Dec 2022 09:10:20 -0800
Message-ID: <CAJuCfpFUh4qGqePueUd5snz27nxLUPehQeAmbkshheno==KtcA@mail.gmail.com>
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock scalability
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, willy@infradead.org,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

On Wed, Dec 28, 2022 at 4:49 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> Hello mm folks,
>
> I have a few questions about the current status of mmap_lock scalability.
>
> =============================================================
> What is currently causing the kernel to use mmap_lock to protect the maple tree?
> =============================================================
>
> I understand that the long-term goal is to remove the need for mmap_lock in readers
> while traversing the maple tree, using techniques such as RCU or SPF.
> What is the biggest obstacle preventing this from being achieved at this time?

Maple tree has an RCU mode which does not need mmap_lock for
traversal. Liam and I were testing it recently and Liam fixed a number
of issues to enable it. It seems stable now and the fixes are
incorporated into the "per-vma locks" patchset which I prepared in
this branch: https://github.com/surenbaghdasaryan/linux/tree/per_vma_lock.
I haven't posted this patchset upstream yet but it's pretty much ready
to go. I'm planning to post it in early January.
Thanks,
Suren.

>
> ==================================================
> How does the maple tree provide RCU-safe manipulation of VMAs?
> ==================================================
>
> Is it similar to the approach suggested in the RCUVM paper (replacing the original
> root node with a new root node that shares most of its nodes and deferring
> the freeing of stale nodes using RCU)?
>
> I'm having difficulty understanding the design of the maple tree in this regard.
>
> [RCUVM paper] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf
>
> Thank you for your time.
>
> ---
> Hyeonggon
