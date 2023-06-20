Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C17377EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFTXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CE1703
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A09361382
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC362C433C9;
        Tue, 20 Jun 2023 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687303513;
        bh=vKs3Nn3T/tb9VC69M13qftg8yAfs62GKs6eI5yArd/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h5gLCg7QDfJ81tP2+/Va4XfHxM18mMN55498n2NiTw+wlLeE47Renbz+YpICVh7Pu
         7HwHvpMMzlKqGH5VHfEDJd0TxWWVvLFpD0PxnXkKHHhksurtr4o3tIeC0tN0ctUjd2
         TWYf5jgsXMdjMY7mfU8NMcWF1mK6u1UwbUd2DYDe93s5lKkVWG+1+pd21v5wS6hzEd
         nRek0IVVuGsep5lInTahMLflKtF2nnFulQGIgbsM/tkPYXWNRaSgqsjjrCumRPtxqj
         mWrHQVsfjs52o4Em9fcr0qV0pyzi3/MGBXmTczaXSotOXXzww7ExGPtt7WYt1TtzWJ
         91mikawwFt2VQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so3635579e87.0;
        Tue, 20 Jun 2023 16:25:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDz86lk3HuLQ2UsHx4Wafl5ht1m1hvMMru3+OT54EHu1T5EaLgbw
        87C70i1WjDTYDSyo8XdxNc/EMrIej8lw1k5C0h4=
X-Google-Smtp-Source: ACHHUZ4uR5DEQ8f5ra7Q+/O6bWWssR1OOIHGdmsuiBLVUBsE5Y0ZJwFefrImhfNab17AYlhtRbsnMCBYBbG4Wlixexs=
X-Received: by 2002:a05:6512:2346:b0:4f6:1307:80b0 with SMTP id
 p6-20020a056512234600b004f6130780b0mr7329104lfu.12.1687303511923; Tue, 20 Jun
 2023 16:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230619100121.27534-1-puranjay12@gmail.com> <20230619100121.27534-4-puranjay12@gmail.com>
In-Reply-To: <20230619100121.27534-4-puranjay12@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 20 Jun 2023 16:24:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FHYpccw-YRK6ka_EX8pVDuHvhvT0myLhZOkrGjJ6=Ng@mail.gmail.com>
Message-ID: <CAPhsuW7FHYpccw-YRK6ka_EX8pVDuHvhvT0myLhZOkrGjJ6=Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 3:01=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Use bpf_jit_binary_pack_alloc for memory management of JIT binaries in
> ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer
> with bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM64
> JIT as these functions are required by bpf_jit_binary_pack allocator.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

LGTM! Thanks!

Acked-by: Song Liu <song@kernel.org>
