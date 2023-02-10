Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C94692949
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjBJVbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjBJVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:30:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6DE7A7E6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B53B61DC5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 21:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972A2C433D2;
        Fri, 10 Feb 2023 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064655;
        bh=PX1l7KxgvRz5n2unS8kLZfPPyiH4tf7cS0ym9ZYONv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nfsmv95zxPHHDlxa/bEIb3VXEsOdEQP34ggZOA3Kfhy/T1ADJmBXnDgq4SRT4RZ0w
         crXuF76k5i8EbhmVQ97bAfYg3QYkrhLtPJ/41qEbDs4dxjdGM5vzUoF/qv6FPA2Lcx
         jRpPkXuveHbqkx5Xr1DjRSWch4ntDMjV9DNMiFzT7BNvlhF9pEXzE1mbUVyf/H771r
         PV3Ynds7p9ggU8wMvCcvo4sW0AXEjN1dQ8Y3CN+Wau9o6+DyXkwZnM8QNB/8kjxk9a
         iHHkPhxPxLHvokSA35bmldRhLs4H8P3DWxprZf0WAaW45OjTryPGOmONATG77k5VMR
         N9M6qf4XEazTQ==
Date:   Fri, 10 Feb 2023 13:30:53 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH] x86/unwind/orc: Fix unwind ip when kprobes hits push/pop
Message-ID: <20230210213053.fscxeamu7h56mjaj@treble>
References: <20221201085311.249883-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201085311.249883-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 04:53:11PM +0800, Chen Zhongjin wrote:
> When unwind stack at asm_exc_int3, the orc type is UNWIND_HINT_TYPE_REGS
> and the unwinder will use pt_regs->ip to find next orc, which point to
> the probed insn + INT3_INSN_SIZE.
> 
> If the probed insn is push/pop, it will point to the next insn which has
> different orc state. Before the probed insn has been really excuted in
> single step, using next insn ip to find orc will get a wrong unwinding
> result.
> 
> So, when there is kprobe running and the previous op code is int3,
> state->signal should be false so that ip - 1 will be used to find next
> orc, until the probed push/pop has been single steped and kprobe set
> kprobe_status as KPROBE_HIT_SSDONE.
> 
> Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Hi Chen,

Thanks for reporting this, and sorry for the delay.  I would rather fix
this in a more general way, by specifying 'signal' (or lack thereof) in
the ORC data.  I will work up a patch.

-- 
Josh
