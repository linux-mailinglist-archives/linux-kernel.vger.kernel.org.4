Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2156A70C51A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjEVSYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjEVSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:24:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169FC186
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:24:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2535edae73cso4425545a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684779841; x=1687371841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msgMReVyIvBu/bwIUP7X7q2ZMnoRqp8LGJXsMcFUvcs=;
        b=aHRH/zKGBDEc02+tUp4uzQfBwuRMYKhtH/VSuyaJ+fL4LRwlVratK6g5Ty0wfGlV/7
         Y/VyfeULzj3JpgHIQBBrC9MtY/lF88HAZ0kM+hRL8Yte8RRWf4oSdlYRF/XqpF2XA2Vg
         Y/TBhVrCE5UVfu/3DPCR/eGCu5HHdDIPvWJbwZoG6y01qPt/jfHqLq2YSEyrxZgpYPOZ
         5TeWBF8wX2Hl7c/4w4Wjfe9Y/AHiyPIm2pHjBcmDKl/I63SEPBuRujPlyBZmGp/Eq4q5
         sv5hd33nwR1BM9jefCd6kQ+ZNnJaSfCWvqDe+M0wEL70LWLYrdvJ409IFNQvdJFQXqdp
         h0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779841; x=1687371841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msgMReVyIvBu/bwIUP7X7q2ZMnoRqp8LGJXsMcFUvcs=;
        b=ZduAVw94YZtcFVc/U2juWHiiUvQg7SR4x/kMvN4v7AVwwwksT1Ise6MgIQ2ZAQKocz
         O1bBcvvPp7jKuCcyppzYBg0Zdn6NCizOh+VFta6zkEDKX73p2LrP2K7vKZHe8PYLPNGF
         r/q83BRgE9+REGp9L/Pxgm+9XJfodSNfD/5sJSuw7/sR5cQIwyWFhODT29+Xw63NjUFR
         mnY1lG0Wcs7MeIMFjCVTzpzW66OanunZiiiMfjUwIDJrH1l74Tq18RnoFU08sHVUo5ib
         Y0deg+u+XOeaLzxlQz9wS/ezLAaTxmvF9fqcUdG5CdUYLuacF92EK6xADiDUGpmzTzva
         BbEg==
X-Gm-Message-State: AC+VfDxD+K7S+vrrT7gEU8SUux8af2bMIqlhgxVe20dJj8vPg7wYKOx1
        00jVFaBvnJmyWDgWTLA+4J9Q9DuS8B2O3vxDNtfYPg==
X-Google-Smtp-Source: ACHHUZ6kdZR7qEFCbldz7uvdvDR5AlZ74YO/t4UiDPEmkgkrjjjgqDRSNzOgFw8RL8QhF7CCiVwX7Jzh4v1RebH6w3M=
X-Received: by 2002:a17:90a:b292:b0:255:4b79:1ef9 with SMTP id
 c18-20020a17090ab29200b002554b791ef9mr6188889pjr.16.1684779841457; Mon, 22
 May 2023 11:24:01 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 22 May 2023 12:23:50 -0600
Message-ID: <CAEUSe78ip=wkHUSz3mBFMcd-LjQAnByuJm1Oids5GSRm-J-dzA@mail.gmail.com>
Subject: Stable backport request: skbuff: Proactively round up to kmalloc
 bucket size
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux- stable <stable@vger.kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        ndesaulniers@google.com, rientjes@google.com, vbabka@suse.cz,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Would the stable maintainers please consider backporting the following
commit to the 6.1? We are trying to build gki_defconfig (plus a few
extras) on Arm64 and test it under Qemu-arm64, but it fails to boot.
Bisection has pointed here.

We have verified that cherry-picking this patch on top of v6.1.29
applies cleanly and allows the kernel to boot.

commit 12d6c1d3a2ad0c199ec57c201cdc71e8e157a232
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Oct 25 15:39:35 2022 -0700

    skbuff: Proactively round up to kmalloc bucket size

    Instead of discovering the kmalloc bucket size _after_ allocation, roun=
d
    up proactively so the allocation is explicitly made for the full size,
    allowing the compiler to correctly reason about the resulting size of
    the buffer through the existing __alloc_size() hint.

    This will allow for kernels built with CONFIG_UBSAN_BOUNDS or the
    coming dynamic bounds checking under CONFIG_FORTIFY_SOURCE to gain
    back the __alloc_size() hints that were temporarily reverted in commit
    93dd04ab0b2b ("slab: remove __alloc_size attribute from
__kmalloc_track_caller")

    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Eric Dumazet <edumazet@google.com>
    Cc: Jakub Kicinski <kuba@kernel.org>
    Cc: Paolo Abeni <pabeni@redhat.com>
    Cc: netdev@vger.kernel.org
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: David Rientjes <rientjes@google.com>
    Acked-by: Vlastimil Babka <vbabka@suse.cz>
    Link: https://patchwork.kernel.org/project/netdevbpf/patch/202210212347=
13.you.031-kees@kernel.org/
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Link: https://lore.kernel.org/r/20221025223811.up.360-kees@kernel.org
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>


Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
