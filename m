Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153D96CEE75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC2QB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjC2QBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:01:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660361B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:00:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k15so9556348pgt.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680105600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4mfqXcQDMgEMpQCXMX8Y+2J6yDMso+bxawxRo1V7AM=;
        b=IoeJ2hRhQlssC8YSqHzS3rfC3A9OTMPusiqg+SugGI1/VjTOihKklhmgsAt+q62Me+
         0ajaO36qZXpYrfgNfJUupAT+VNEwm/mxaA5pi4OEfitP2oW35BMdfFboI2nvBRBPfyoC
         87A0zVLVuVpvjT/ZoYoPLZfMr7dIZ8RE41w4qAl8ObYABbUxmreHfOU48C4cTAqblRde
         bBvteLztJDp89LaAGRZyxcGEcVTobi1FUByRwex2EiXXsDsnpSXi2Q7fJ3CFNP8zJn+6
         jOY3ixUYKa+AcrYIKDjjja8lhVYz/pxpNEidIZDdK27hiclc7yKU8RkJuzyZ3ZMj0fVS
         iusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4mfqXcQDMgEMpQCXMX8Y+2J6yDMso+bxawxRo1V7AM=;
        b=vtxNlUBp3+v1e8wmK8gqAFMAVPAXm20NEeFUAVacLHDlN1bOFnqrwnzkGF0txCR+Cx
         aD2v7ChIKd+gR7+OOk+agW/djmMsEEiA7ji7rKEchFd7w9x30WpNtGZLeuZgaIgSL8wA
         JDXhAU+G47ab6IJ2noXpLxIp8+GE8GYWGQLn+X9x9JHAjthrfNL0hNXS9537E4Llt1Co
         7vR83VjnNlVCG/tHUpa5Di11BpwInJIbjgZDP1Apj2VfTXs1VSzAEIn8hG3FUw41VREh
         aNirACGGP4KqKJalacx9sjStYYsR4fM4PvyJTxRZP2cTuZqFa2OOfIx1wmKL4E/KGfxI
         orHQ==
X-Gm-Message-State: AAQBX9catfJdVqGBYVNqHm4mFXrmeagqsgpf3Sb/fm+RYeiX2XvT4qYl
        ENiqVBSpdWwhKFDMY8WVtTUGF9hJ+lj0k8CIn4k=
X-Google-Smtp-Source: AKy350bbUeXsaVaGVMrLADFMTlcAvbwonbtuaLJzX0D/4hTRQY54aN2E+BeUy8yI+ufmlJloSvXo7M8yGD2YzbEXtz4=
X-Received: by 2002:a05:6a00:1a8b:b0:627:d4fa:6a9c with SMTP id
 e11-20020a056a001a8b00b00627d4fa6a9cmr10678222pfv.6.1680105599791; Wed, 29
 Mar 2023 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
In-Reply-To: <5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 29 Mar 2023 17:59:48 +0200
Message-ID: <CA+fCnZfVs44zQs1Sg_MXvyGcTHc=aNhx+5R+ku8Nh3yDBb45qg@mail.gmail.com>
Subject: Re: [BUG] Usersapce MTE error with allocation tag 0 when low on memory
To:     Peter Collingbourne <pcc@google.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <qun-wei.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:56=E2=80=AFAM 'Qun-wei Lin (=E6=9E=97=E7=BE=A4=E5=
=B4=B4)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Hi,
>
> We meet the mass MTE errors happened in Android T with kernel-6.1.
>
> When the system is under memory pressure, the MTE often triggers some
> error reporting in userspace.
>
> Like the tombstone below, there are many reports with the acllocation
> tags of 0:
>
> Build fingerprint:
> 'alps/vext_k6897v1_64/k6897v1_64:13/TP1A.220624.014/mp2ofp23:userdebug/
> dev-keys'
> Revision: '0'
> ABI: 'arm64'
> Timestamp: 2023-03-14 06:39:40.344251744+0800
> Process uptime: 0s
> Cmdline: /vendor/bin/hw/camerahalserver
> pid: 988, tid: 1395, name: binder:988_3  >>>
> /vendor/bin/hw/camerahalserver <<<
> uid: 1047
> tagged_addr_ctrl: 000000000007fff3 (PR_TAGGED_ADDR_ENABLE,
> PR_MTE_TCF_SYNC, mask 0xfffe)
> signal 11 (SIGSEGV), code 9 (SEGV_MTESERR), fault addr
> 0x0d000075f1d8d7f0
>     x0  00000075018d3fb0  x1  00000000c0306201  x2  00000075018d3ae8  x
> 3  000000000000720c
>     x4  0000000000000000  x5  0000000000000000  x6  00000642000004fe  x
> 7  0000054600000630
>     x8  00000000fffffff2  x9  b34a1094e7e33c3f  x10
> 00000075018d3a80  x11 00000075018d3a50
>     x12 ffffff80ffffffd0  x13 0000061e0000072c  x14
> 0000000000000004  x15 0000000000000000
>     x16 00000077f2dfcd78  x17 00000077da3a8ff0  x18
> 00000075011bc000  x19 0d000075f1d8d898
>     x20 0d000075f1d8d7f0  x21 0d000075f1d8d910  x22
> 0000000000000000  x23 00000000fffffff7
>     x24 00000075018d4000  x25 0000000000000000  x26
> 00000075018d3ff8  x27 00000000000fc000
>     x28 00000000000fe000  x29 00000075018d3b20
>     lr  00000077f2d9f164  sp  00000075018d3ad0  pc  00000077f2d9f134  p
> st 0000000080001000
>
> backtrace:
>       #00 pc 000000000005d134  /system/lib64/libbinder.so
> (android::IPCThreadState::talkWithDriver(bool)+244) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #01 pc 000000000005d448  /system/lib64/libbinder.so
> (android::IPCThreadState::getAndExecuteCommand()+24) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #02 pc 000000000005dd64  /system/lib64/libbinder.so
> (android::IPCThreadState::joinThreadPool(bool)+68) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #03 pc 000000000008dba8  /system/lib64/libbinder.so
> (android::PoolThread::threadLoop()+24) (BuildId:
> 8b5612259e4a42521c430456ec5939c7)
>       #04 pc 0000000000013440  /system/lib64/libutils.so
> (android::Thread::_threadLoop(void*)+416) (BuildId:
> 10aac5d4a671e4110bc00c9b69d83d8a)
>       #05 pc
> 00000000000c14cc  /apex/com.android.runtime/lib64/bionic/libc.so
> (__pthread_start(void*)+204) (BuildId:
> 718ecc04753b519b0f6289a7a2fcf117)
>       #06 pc
> 0000000000054930  /apex/com.android.runtime/lib64/bionic/libc.so
> (__start_thread+64) (BuildId: 718ecc04753b519b0f6289a7a2fcf117)
>
> Memory tags around the fault address (0xd000075f1d8d7f0), one tag per
> 16 bytes:
>       0x75f1d8cf00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d000: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d100: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d200: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d300: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d400: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d500: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d600: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>     =3D>0x75f1d8d700: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 [0]
>       0x75f1d8d800: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8d900: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8da00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8db00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8dc00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8dd00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>       0x75f1d8de00: 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
>
> Also happens in coredump.
>
> This problem only occurs when ZRAM is enabled, so we think there are
> some issues regarding swap in/out.
>
> Having compared the differences between Kernel-5.15 and Kernel-6.1,
> We found the order of swap_free() and set_pte_at() is changed in
> do_swap_page().
>
> When fault in, do_swap_page() will call swap_free() first:
> do_swap_page() -> swap_free() -> __swap_entry_free() ->
> free_swap_slot() -> swapcache_free_entries() -> swap_entry_free() ->
> swap_range_free() -> arch_swap_invalidate_page() ->
> mte_invalidate_tags_area() ->  mte_invalidate_tags() -> xa_erase()
>
> and then call set_pte_at():
> do_swap_page() -> set_pte_at() -> __set_pte_at() -> mte_sync_tags() ->
> mte_sync_page_tags() -> mte_restore_tags() -> xa_load()
>
> This means that the swap slot is invalidated before pte mapping, and
> this will cause the mte tag in XArray to be released before tag
> restore.
>
> After I moved swap_free() to the next line of set_pte_at(), the problem
> is disappeared.
>
> We suspect that the following patches, which have changed the order, do
> not consider the mte tag restoring in page fault flow:
> https://lore.kernel.org/all/20220131162940.210846-5-david@redhat.com/
>
> Any suggestion is appreciated.
>
> Thank you.

+Peter
