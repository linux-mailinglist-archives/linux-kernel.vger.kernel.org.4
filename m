Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DF72CB72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbjFLQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjFLQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8FE4A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686587130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqwXplhA6elh/wvBFScazI5+BTtK4bRNV6UTAcVMSLo=;
        b=QDl526gfS80DLDukjzr28BiopN3qfjRpev1xrUKRkkzKjO5obJiW7E54+pjNderk+41/Sz
        B8n2z3Btr3CfyWlJR1fmdxWJgUFnwGpg0zY8jzXd229fBv39mwipudg3QQIL9RGdS9zSZU
        gGRbEmMKJC5QljPSUy+bDDAzqK0jv3s=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-L9VbadRiPGirau3DnLF1Rw-1; Mon, 12 Jun 2023 12:25:22 -0400
X-MC-Unique: L9VbadRiPGirau3DnLF1Rw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b29945510fso209694a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587121; x=1689179121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqwXplhA6elh/wvBFScazI5+BTtK4bRNV6UTAcVMSLo=;
        b=Wu0LyQZfCpMcFt2+GRc+inMd8j+4FCoVUP1SfFYrG5VuHabdNo0omYtOAIb4idGP+2
         9usDYCLEat1WWRRbcqHMI+nyL87+U9P4owuLixraE1hJjqfSD4tyM4msLgD3Q/2COA9I
         kWqgwwbaDilH1AutnPmpxSMcRmCeNL72MZhTR16gkZERp3eeOl0r20lwd0ZFwMJ6B/W3
         KL5fVhTuTfbmzwCqjUcwYtN/Im70jhgUBgm/c3sb9ZUzp9kWlpwVgDimXJ29+j9G81yj
         vPY+Y9vhtBuM0KYkgYn3wXCZeIxVauxNZ0TkrZ/wzNISBLyIjlwFTeQa6UoamSrWJlvA
         44tg==
X-Gm-Message-State: AC+VfDzfTkwwbhsu10fSRmAUHghF03IRZcc1e7p1F4U+Z/7zhQ9E9sFz
        mqqb+WvLWsXo/qKBNrd4Ydj88QdZZ2NEmPjGmCTPN0YhQUwke+ySjvrjwSggOvnAik2jloYr5NY
        nqMPupT3HKFM5C/0u1u94Rhxs
X-Received: by 2002:a05:6830:6116:b0:6b1:5075:87ec with SMTP id ca22-20020a056830611600b006b1507587ecmr5481302otb.1.1686587121464;
        Mon, 12 Jun 2023 09:25:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oDPJ4lumFhl21SxU7udUxydSD4vf4JJO9yBFnkI9xGni4BGh7usWoNwiiWtsG9588r15Cdw==
X-Received: by 2002:a05:6830:6116:b0:6b1:5075:87ec with SMTP id ca22-20020a056830611600b006b1507587ecmr5481276otb.1.1686587121169;
        Mon, 12 Jun 2023 09:25:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j3-20020a0cf303000000b00627a6fd04ddsm3313829qvl.122.2023.06.12.09.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:25:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 12:25:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH RFC v2 0/4]  Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <ZIdG7rMDY6649hSp@x1n>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:49:47AM -0600, Khalid Aziz wrote:
> This patch series adds a new flag to mmap() call - MAP_SHARED_PT.

Since hugetlb has this, it'll be very helpful if you can provide a
comparison between this approach and hugetlb's - especially on the
differences - and reasonings about those.

Merging anything like this definitely should also pave way for hugetlb's
future, so it even seems to be an "requirement" of such patchset even
though implicitily..  considering the "hotness" that hugetlb recently has
on refactoring demand (if not a rewrite).

Some high level questions:

  - Why mmap() flag?

    For this one, I agree it should be opt-in - sharing pgtable definitely
    means sharing of a lot of privileges operating on current mm, so one
    should be aware and be prepared to be messed up.

    IIUC hugetlb doesn't do this but instead when something "racy" happens
    itt just unshares by default.  To me opt-in makes more sense if to
    start from zero, because I don't think by default a process wants to
    leak its mm to others.

    I think you mentioned allowing pgtable to be shared even for mprotect()
    from one MM then all MMs can see; but if so then DONTNEED should really
    do the same - when one MM DONTNEED it it should go away for all.  It
    doesn't make a lot of sense to me to treat it differently with a
    DONTNEED refcount anywhere..

  - Can guest MM opt-out?

    Should we allow guest MM to opt-out when they want?  It sounds like a
    good thing to have to me, especially for file that sounds like as
    simple as zapping the pgtable.  But then mmap flag will stop working
    iiuc, so goes back to that question (e.g. what about madvise or prctl?).

  - Why mm_struct to represent shared pgtable?

    IIUC hugetlb used the pgtable page itself plus some refcounting (the
    refcounting is racy with gup-fast that Jann used to point out, but
    that's another story..).  My question is do you think that won't work?
    Are there reasons to explain?  Why mm_struct is the structure you chose
    for representing a shared pgtable?  Why per-file?

Thanks,

-- 
Peter Xu

