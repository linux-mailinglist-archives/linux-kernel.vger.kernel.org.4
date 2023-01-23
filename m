Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46957677B10
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjAWMfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjAWMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:35:54 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0F185
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:35:53 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4b718cab0e4so169079517b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRqufKGpq8OIKxs+o5lWh04QILIZLR5qRWq3GvSO1mU=;
        b=OajGPIP57i5I+E+8SVUz58G0n20LKTWv6ySCJE/UiVurFet35iiypKPwGhoTUT2xb2
         w/KoQ0uPNvQnaVVNf57JrobNUN6FTmd4QoZEYkbKE4FvmkZhzn3Kdbey1aN5wVUyZzT1
         ortleaMASuw2WdOhTzTG8DqQCnte4JiDPFv9EraUG0dECbVocrZgVmVM+ACSe30xQixC
         sDl4uq+1Gb0Lx0AnRPfBLUVQ4/mEs3yvYqoVtGSFY7ba9hQ7WWlO/Ivk1nGTRo/u6Cam
         WGJGTWicRZxvs+5rgKXe34XHbNyMGfWlK5ELxRg9TTriXkK4W70+zyR1/8pBiFSEqe2E
         YkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRqufKGpq8OIKxs+o5lWh04QILIZLR5qRWq3GvSO1mU=;
        b=uYZWhS89svWzSaM9sqQlUGZOPuLQ3qloXQ6+rXwzyTben4CcjxNbEVUmm9B3xSuFz+
         AzLjkUtVf32I434jFARrmvHxniSeUqfC0MAsOqVKOaBX5N8odYhp074FSgzw938RDPDN
         9egCNHENKWLmYuuMoLTnyn+PUswGT+iKE9lfNWlBpWmWmXyBB/fjN0gfqnRU0UQC7sLJ
         ezBI4IAD6GjEWMdh6I+JpXyHNHTAlU+K12MYpPEeRI1eQGg/zRvC0HZz86IIi/SSSUUu
         XksgfW2Wu4yh3BHHMgNfZ0RQpm3pRW96wrZ4k442QpwVEIlj0cPzcxgsLu8a5ixTTyDs
         qyvw==
X-Gm-Message-State: AFqh2krLg5zSklo4Mkn4cO6Z1/6CmDnfnjj+xrsQyg0rggx3rtsUzxd5
        THdEElbIuJEXlNd1Lay9jN+k37e63xp1+cZ8ciE4TZk1O2KVnU8F
X-Google-Smtp-Source: AMrXdXsVIZDh3BsWKYx2LOu+u5G3IXjxA8DnVCWIZMa0wViIKxzHZVUQPEfiyf8sfNpppSrPuUXEntqWEl/HTXzYzu8=
X-Received: by 2002:a05:690c:e0b:b0:4fe:1637:459e with SMTP id
 cp11-20020a05690c0e0b00b004fe1637459emr1468191ywb.363.1674477352148; Mon, 23
 Jan 2023 04:35:52 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
In-Reply-To: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Mon, 23 Jan 2023 12:35:41 +0000
Message-ID: <CAC=wTOgrEP3g3sKxBfGXqTEyMR2-D74sK2gsCmPS2+H-wBH6QA@mail.gmail.com>
Subject: Re: eBPF verifier does not load libxdp dispatcher eBPF program
To:     linux-kernel@vger.kernel.org
Cc:     Chris Ward <tjcw@uk.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.15.0 kernel (built by 'git checkout v5.15' from the kernel.org
torvalds tree) fails in the same way that the 6.2.0-rc5+ kernel fails.
So it seems that something Canonical did for the Ubuntu 20.04 kernel
causes eBPF to work correctly.

On Mon, 23 Jan 2023 at 11:06, Chris Ward <tjcw01@gmail.com> wrote:
>
> I am trying to use the 'bleeding edge' kernel to determine whether a
> problem I see has already been fixed, but with this kernel the eBPF
> verifier will not load the dispatcher program that is contained within
> libxdp. I am testing kernel commit hash 2475bf0 which fails, and the
> kernel in Ubuntu 22.04 (5.15.0-58-generic) works properly. I am
> running the test case from
> https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth ; to
> build it go to the AF_XDP-filter directory and type 'make', and to run
> it go to the AF_XDP-filter/runscripts/iperf3-namespace directory and
> type 'sudo FILTER=af_xdp_kern PORT=50000 ./run.sh' .
> The lines from the run output indicating the failure are
> libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid argument
> libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
> Func#11 is safe for any args that match its prototype
> btf_vmlinux is malformed
> reg type unsupported for arg#0 function xdp_dispatcher#29
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; int xdp_dispatcher(struct xdp_md *ctx)
> 0: (bf) r6 = r1                       ; R1=ctx(off=0,imm=0)
> R6_w=ctx(off=0,imm=0)
> 1: (b7) r0 = 2                        ; R0_w=2
> ; __u8 num_progs_enabled = conf.num_progs_enabled;
> 2: (18) r8 = 0xffffb2f6c06d8000       ; R8_w=map_value(off=0,ks=4,vs=84,imm=0)
> 4: (71) r7 = *(u8 *)(r8 +0)           ; R7=1
> R8=map_value(off=0,ks=4,vs=84,imm=0)
> ; if (num_progs_enabled < 1)
> 5: (15) if r7 == 0x0 goto pc+141      ; R7=1
> ; ret = prog0(ctx);
> 6: (bf) r1 = r6                       ; R1_w=ctx(off=0,imm=0)
> R6=ctx(off=0,imm=0)
> 7: (85) call pc+140
> btf_vmlinux is malformed
> R1 type=ctx expected=fp
> Caller passes invalid args into func#1
> processed 84 insns (limit 1000000) max_states_per_insn 0 total_states
> 9 peak_states 9 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'xdp_dispatcher': failed to load: -22
> libbpf: failed to load object 'xdp-dispatcher.o'
> libxdp: Failed to load dispatcher: Invalid argument
> libxdp: Falling back to loading single prog without dispatcher
>
> Can this regression be fixed before kernel 6.2 ships ?
