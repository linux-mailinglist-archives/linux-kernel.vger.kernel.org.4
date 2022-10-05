Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFAB5F571C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJEPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJEPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D140631ED;
        Wed,  5 Oct 2022 08:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFAB61745;
        Wed,  5 Oct 2022 15:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D94C433D6;
        Wed,  5 Oct 2022 15:07:04 +0000 (UTC)
Date:   Wed, 5 Oct 2022 11:07:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Message-ID: <20221005110707.55bd9354@gandalf.local.home>
In-Reply-To: <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
        <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
        <YzG51Jyd5zhvygtK@arm.com>
        <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
        <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
        <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
        <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
        <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
        <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 22:54:15 +0800
Xu Kuohai <xukuohai@huawei.com> wrote:

> 1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s
> 
> 
> 1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'
> 
> # dd if=/dev/zero of=/dev/null count=1000000
> 1000000+0 records in
> 1000000+0 records out
> 512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s

Can you show the implementation of the indirect call you used?

Thanks,

-- Steve
