Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C493A6779CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjAWLG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:06:55 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2160234D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:06:54 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d62so14245153ybh.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPjqicpT5Bjj+0xFow7d0lAjazsxJymEfQfty9QBpI4=;
        b=VYuiitzB0pXpcp5ssg3YxsJNwYAZ5uk3Ya+ixMP1MbO9LCAa5iwUDUmUwtTcDW7C+O
         11yLQwGl/KsB395AImq0qTntzxowxu28bp5oirfKiF+C8gOcW8T202mp9N7cwX/9JLmL
         r8JpKXNvrSXVAtd4pxQof5+pO8tUqzdA5SA572wZUuHP9q+fuu8Cq19VjU2Yw/vhJq2W
         AA80z3qDvr3wVR92NuW0tkAJt9Rk6Hv32Jfzk0paklrmxhwp5GEfXMK12xt69pjrSjcl
         OObRE4SRy14z4ZfEy8zz95o/50R6zMjpJnat9XyFDykUJWnmuWB9Sx0M3JuWstFjA6mv
         Zh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPjqicpT5Bjj+0xFow7d0lAjazsxJymEfQfty9QBpI4=;
        b=1UNdAUkvx9CfrkyO/qIFtxhIVQRsdCgRv95N9jxuh2sjoAA96fu7gMpZT3Wie5u5sd
         S+srLdjwTIlDd1fKY+m7I67ndoe8lQsJfzwbE35nTYYCSeEPAIIYu2uxOFnniV5JE9O2
         0bGBISrMa0kWRyYrAx+hQncUJw67Z2eLXLYtw4V3gdht2bzNVFGoHjYu+19MLvdcrCHE
         mYntds9NnZ/VPpzv570ndjAJkXz2WxS97AxPqfwn3tfY4y5J379sMrKI5Bb2OvI5n5ru
         qZK5y3OOWnQ1jweVLd3RrL2gWlE2BTU0sO/r0kT1UD6gribnmhe9CeRqL27zvb23yaCv
         LpTw==
X-Gm-Message-State: AFqh2krgPgpubejaE0DnpkzZdaQWoru9X61JcTR4ZL35hs3g5yg3PI8h
        taUkLRO8ylhePLtNxwnSi6Llrr0puJPcQVItZKy027mRYIaKH3zn
X-Google-Smtp-Source: AMrXdXsXCiRgpfZshFYU4XS/DBhWQV7E5Jfh7ZFyaTHTy6vEPLWQEBXPSUZy4ALLbuNRSli/+SE9CWoVeNvlkukPrMs=
X-Received: by 2002:a25:2514:0:b0:7f5:14a4:1fb7 with SMTP id
 l20-20020a252514000000b007f514a41fb7mr2307250ybl.625.1674472013721; Mon, 23
 Jan 2023 03:06:53 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Mon, 23 Jan 2023 11:06:43 +0000
Message-ID: <CAC=wTOhhyaoyCcAbX1xuBf5v-D=oPjjo1RLUmit=Uj9y0-3jrw@mail.gmail.com>
Subject: eBPF verifier does not load libxdp dispatcher eBPF program
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

I am trying to use the 'bleeding edge' kernel to determine whether a
problem I see has already been fixed, but with this kernel the eBPF
verifier will not load the dispatcher program that is contained within
libxdp. I am testing kernel commit hash 2475bf0 which fails, and the
kernel in Ubuntu 22.04 (5.15.0-58-generic) works properly. I am
running the test case from
https://github.com/tjcw/bpf-examples/tree/tjcw-explore-sameeth ; to
build it go to the AF_XDP-filter directory and type 'make', and to run
it go to the AF_XDP-filter/runscripts/iperf3-namespace directory and
type 'sudo FILTER=af_xdp_kern PORT=50000 ./run.sh' .
The lines from the run output indicating the failure are
libbpf: prog 'xdp_dispatcher': BPF program load failed: Invalid argument
libbpf: prog 'xdp_dispatcher': -- BEGIN PROG LOAD LOG --
Func#11 is safe for any args that match its prototype
btf_vmlinux is malformed
reg type unsupported for arg#0 function xdp_dispatcher#29
0: R1=ctx(off=0,imm=0) R10=fp0
; int xdp_dispatcher(struct xdp_md *ctx)
0: (bf) r6 = r1                       ; R1=ctx(off=0,imm=0)
R6_w=ctx(off=0,imm=0)
1: (b7) r0 = 2                        ; R0_w=2
; __u8 num_progs_enabled = conf.num_progs_enabled;
2: (18) r8 = 0xffffb2f6c06d8000       ; R8_w=map_value(off=0,ks=4,vs=84,imm=0)
4: (71) r7 = *(u8 *)(r8 +0)           ; R7=1
R8=map_value(off=0,ks=4,vs=84,imm=0)
; if (num_progs_enabled < 1)
5: (15) if r7 == 0x0 goto pc+141      ; R7=1
; ret = prog0(ctx);
6: (bf) r1 = r6                       ; R1_w=ctx(off=0,imm=0)
R6=ctx(off=0,imm=0)
7: (85) call pc+140
btf_vmlinux is malformed
R1 type=ctx expected=fp
Caller passes invalid args into func#1
processed 84 insns (limit 1000000) max_states_per_insn 0 total_states
9 peak_states 9 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'xdp_dispatcher': failed to load: -22
libbpf: failed to load object 'xdp-dispatcher.o'
libxdp: Failed to load dispatcher: Invalid argument
libxdp: Falling back to loading single prog without dispatcher

Can this regression be fixed before kernel 6.2 ships ?
