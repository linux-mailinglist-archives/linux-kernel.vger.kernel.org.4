Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BB68FA70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjBHWwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBHWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:52:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0E26CE0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:52:08 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id x4so297080ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWgdfewcuTEh14INhw6BmK3uAeHTsrDazjd7F3wRM/0=;
        b=spW3XuyI/ZmenUIo3SlG/R12eVoe/Pf15SlWNRc9gRkynL3q0Ve5gDlvPvxGr5tL4K
         mcTMicw9Zjz2h6ON6hEbkjYsmis4nZlv92NdKCxPbDkkJwh9cs0FyskIRsVTA9hxPI2Q
         XQJc66YQLdNEdtTW3vISbX366QltjagIKXbQZQHxwgCIcgHMS8OwhGyPuHJxxHInduG2
         Eh9RiDfrCkqOt9ZBReWfrg2MIO7oCvm4C5nfCwSrRKTn9rlv3KBb9kZQNtTt9EXiHxDm
         nLFyjkFyP02fD3/KFpe3R6jwgkJjnqSazEzy15NdcR13YsvHjSTMczhuq6lbef5aYz28
         g1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWgdfewcuTEh14INhw6BmK3uAeHTsrDazjd7F3wRM/0=;
        b=2PYY8JOEq8Gk3JbozYYocw4ugvwxYjakzubN9EzATn8eLOgFuQZEsmpbXfTHPv2Vqh
         HpXr0+54arfIDTHG7a80wdSWNq+LpXBWZInu6NWzg0Sd8KJUHrNkK0AxC78LCQBjckSh
         es44L1ivmL0dEGk7SLwccjFJfv1vrs4B4wL1ZlHptC+ECcab90XE0EHTDxO31SEUOALu
         VFCRRFA61W3glMXW8/HJYXKUZDpMoljRGWhCFLxewUeDSFgS06i2/eqihBljlNAT8gZ+
         3FOZoBDWzytiuN2q07edKlo05PsXW0OBKKmhHKkIf7mYP15HwbDoIRHqbMPjUANxlbgJ
         Obuw==
X-Gm-Message-State: AO0yUKVi0jOt4qm1I10PEqXgjWjWJbp2vtLksxcT9JjlUUrMJwekovqc
        fuMjpOqs195OFSEBkY2I/+ZjjQog1a1bZ1hMSOfv8g==
X-Google-Smtp-Source: AK7set+cBVwl3WKu8ayEG6S7I+s11uOQIyTr0nUdZPy51noECceladhOojkPBxzdODT8q3dVsqZRU1lvg6Kfw5MVNjY=
X-Received: by 2002:a5b:3:0:b0:816:c63:dc96 with SMTP id a3-20020a5b0003000000b008160c63dc96mr972144ybp.119.1675896727702;
 Wed, 08 Feb 2023 14:52:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675690847.git.quic_charante@quicinc.com>
 <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
 <CAJuCfpH7Jag9qEcKjGTx9Qv_oekM6qRVkGwzTrXShgYbLdLKtg@mail.gmail.com> <8f40873d-8a9c-bcec-6742-885478365e4c@quicinc.com>
In-Reply-To: <8f40873d-8a9c-bcec-6742-885478365e4c@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 8 Feb 2023 14:51:56 -0800
Message-ID: <CAJuCfpE35_8JBq4DAqHZh0eJ3cynxkZXxqV32L_7xJn9uB7Jbw@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, shakeelb@google.com,
        mhocko@suse.com, vbabka@suse.cz, quic_pkondeti@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 8, 2023 at 6:55 AM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Suren!!
>
> On 2/8/2023 4:18 AM, Suren Baghdasaryan wrote:
> >> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> >> +{
> >> +       loff_t endbyte;
> >> +       pgoff_t start_index;
> >> +       pgoff_t end_index;
> >> +       struct address_space *mapping;
> >> +       struct inode *inode = file_inode(file);
> >> +       int ret = 0;
> >> +
> >> +       if (S_ISFIFO(inode->i_mode))
> >> +               return -ESPIPE;
> >> +
> >> +       mapping = file->f_mapping;
> >> +       if (!mapping || len < 0 || !shmem_mapping(mapping))
> >> +               return -EINVAL;
> >> +
> >> +       endbyte = fadvise_calc_endbyte(offset, len);
> >> +
> >> +       start_index = offset >> PAGE_SHIFT;
> >> +       end_index   = endbyte >> PAGE_SHIFT;
> >> +       switch (advice) {
> >> +       case POSIX_FADV_DONTNEED:
> > Should (SHMEM_I(inode)->flags & VM_LOCKED) be checked here too?
> >
> Is this w.r.t context from shmem_lock() perspective which does set this
> flag?  If so, Isn't the PageUnevictable check cover this part? And to
> avoid unnecessary Unevictable check later on the locked shmem file, How
> about just checking mapping_unevictable() before performing
> shmem_fadvise_dontneed)()? Please let me know If I failed to get your point.

Yes, you got my point and checking for mapping_unevictable() should
work fine I think.

>
> >> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
> >> +               break;
> >> +       case POSIX_FADV_WILLNEED:
> >> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
> >> +               break;
> >> +       case POSIX_FADV_NORMAL:
> >> +       case POSIX_FADV_RANDOM:
> >> +       case POSIX_FADV_SEQUENTIAL:
> >> +       case POSIX_FADV_NOREUSE:
>
> --Charan
