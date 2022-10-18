Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E602856
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJRJ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:27:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D451A11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:27:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 3so13549152pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rqb+aVpBsUbDEx7v0ZoQPE3JbRRMNEAN9tkBEWFtU+k=;
        b=sjpRVNDsx7InUD1sZ0hNW11SsPAOVf/U9F6PWMdb/rcR0J5P/+9BPG/i+jJQ8o5uzJ
         MB5l6mch73YCxJQkHnQ3kbyr7eQRZEUL+rh3P78SeGqEY2eRFOEm389Xlqc1Islcr6th
         WnHFGTbqPfud6d478+G/Xn1RCJgEulc9xVCPl6BdYBTPWlTLGnkFmlY0sYstClwBaU1Z
         Nc/lDjZNfsDOpY+hfoGJ2hs81xWvmAziDvsOpQZoaV4YhqA6+TDX9rytiCWe2Zfryok8
         YPkto9bJ86Hk9WVCa71s5KwOX4kTG3ckbSsqlnCXvOrSuUlfH4DcaM2vlKW9520BR1HW
         320g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rqb+aVpBsUbDEx7v0ZoQPE3JbRRMNEAN9tkBEWFtU+k=;
        b=HsNKbZwepY/Evw6LXnEIYiTdZWbZj4uzP82XsS7Y3tZh3pQx0zjpWB2btJNg3obPuF
         Fmu/Cv6YTJGttNhgdEXyUJpMYrsy7RwfHsdThsT5c2OLyMHC2RwdY0cw4eUvJUazsu1Z
         oMhIFEiWEbv1a8490w9lZPmzqt7kgZZK6Bauorb4KN2C6qJZRz7ovqQAxr1jO7/Jg2ER
         4OVId3+BxEoRC/O5egVsDHJtnvFZxncyBDJH8s18LEpUH1MPyaCoPjvTIpnREn+YgE3p
         xTYZ0YU2hYnY+jtfZLslcZx1etZ/EhNS8SudLPmN81oM0DnywSs+rvXe7nnOErO9cDYi
         A7iw==
X-Gm-Message-State: ACrzQf3/RH/pJrZSG2xxqL6vxVBQd5sd4vIjJhfmMChYht2rhXM2xIEr
        /S40LYofXDntjR573vJWv3ynS1K9X3T+YeVWwPYgUA==
X-Google-Smtp-Source: AMsMyM5eFSsStLxpRdShe9iJjt6fkVyLXgfU9vn4kgqDaDqaSQwiONHiI1Kka/58zD9swX46xe92agyCycA7WN5ZKXo=
X-Received: by 2002:a05:6a00:1946:b0:565:c337:c530 with SMTP id
 s6-20020a056a00194600b00565c337c530mr1992756pfk.47.1666085274296; Tue, 18 Oct
 2022 02:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com> <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com> <CABKxMyO4RvEx===iYr_m2dfB0mtUTqt8A3WEuJn4Dq7r_NNM3w@mail.gmail.com>
 <03b90a2f-2854-6e19-6ccd-41f9933d8813@redhat.com>
In-Reply-To: <03b90a2f-2854-6e19-6ccd-41f9933d8813@redhat.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 18 Oct 2022 17:27:42 +0800
Message-ID: <CABKxMyO21rF+f2vpS+t++DAFHiy_MeWDBjB-AvupysKnDHRJfA@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 20:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 17.10.22 13:46, =E9=BB=84=E6=9D=B0 wrote:
> > David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=881=
7=E6=97=A5=E5=91=A8=E4=B8=80 19:33=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 17.10.22 11:48, =E9=BB=84=E6=9D=B0 wrote:
> >>> David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=B8=80 16:44=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 12.10.22 10:15, Albert Huang wrote:
> >>>>> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >>>>>
> >>>>> implement these two functions so that we can set the mempolicy to
> >>>>> the inode of the hugetlb file. This ensures that the mempolicy of
> >>>>> all processes sharing this huge page file is consistent.
> >>>>>
> >>>>> In some scenarios where huge pages are shared:
> >>>>> if we need to limit the memory usage of vm within node0, so I set q=
emu's
> >>>>> mempilciy bind to node0, but if there is a process (such as virtiof=
sd)
> >>>>> shared memory with the vm, in this case. If the page fault is trigg=
ered
> >>>>> by virtiofsd, the allocated memory may go to node1 which  depends o=
n
> >>>>> virtiofsd.
> >>>>>
> >>>>
> >>>> Any VM that uses hugetlb should be preallocating memory. For example=
,
> >>>> this is the expected default under QEMU when using huge pages.
> >>>>
> >>>> Once preallocation does the right thing regarding NUMA policy, there=
 is
> >>>> no need to worry about it in other sub-processes.
> >>>>
> >>>
> >>> Hi, David
> >>> thanks for your reminder
> >>>
> >>> Yes, you are absolutely right, However, the pre-allocation mechanism
> >>> does solve this problem.
> >>> However, some scenarios do not like to use the pre-allocation mechani=
sm, such as
> >>> scenarios that are sensitive to virtual machine startup time, or
> >>> scenarios that require
> >>> high memory utilization. The on-demand allocation mechanism may be be=
tter,
> >>> so the key point is to find a way support for shared policy=E3=80=82
> >>
> >> Using hugetlb -- with a fixed pool size -- without preallocation is li=
ke
> >> playing with fire. Hugetlb reservation makes one believe that on-deman=
d
> >> allocation is going to work, but there are various scenarios where tha=
t
> >> can go seriously wrong, and you can run out of huge pages.
> >>
> >> If you're using hugetlb as memory backend for a VM without
> >> preallocation, you really have to be very careful. I can only advise
> >> against doing that.
> >>
> >>
> >> Also: why does another process read/write *first* to a guest physical
> >> memory location before the OS running inside the VM even initialized
> >> that memory? That sounds very wrong. What am I missing?
> >>
> >
> > for example : virtio ring buffer.
> > For the avial descriptor, the guest kernel only gives an address to
> > the backend,
> > and does not actually access the memory.
>
> Okay, thanks. So we're essentially providing uninitialized memory to a
> device? Hm, that implies that the device might have access to memory
> that was previously used by someone else ... not sure how to feel about
> that, but maybe this is just the way of doing things.
>
> The "easy" user-space fix would be to simply similarly mbind() in  the
> other processes where we mmap(). Has that option been explored?

This can also solve the problem temporarily, but we need to change all
processes that share memory with it, so it can't be done once and for
all

>
> --
> Thanks,
>
> David / dhildenb
>
