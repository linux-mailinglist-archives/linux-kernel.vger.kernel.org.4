Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F57616BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKBSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:07:47 -0400
Received: from mail-m118205.qiye.163.com (mail-m118205.qiye.163.com [115.236.118.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58F52EF2E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:07:45 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.48])
        by mail-m118205.qiye.163.com (HMail) with ESMTPA id AE4722C0508;
        Thu,  3 Nov 2022 02:07:41 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     bp@alien8.de
Cc:     chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        david.laight@aculab.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, me@inclyc.cn, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH RESEND v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Thu,  3 Nov 2022 02:07:19 +0800
Message-Id: <20221102180719.2115424-1-me@inclyc.cn>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <Y2KhCyofvfG5W5hE@zn.tnic>
References: <Y2KhCyofvfG5W5hE@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUNNSBhWHU0aGhpPSBgeT04YVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6Syo4MDlDNzQdHy8*STQj
        MhcwCTNVSlVKTU1MT0pJT01JTE5DVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU9DWVdZCAFZQUlKSEI3Bg++
X-HM-Tid: 0a8439870ab72d27kusnae4722c0508
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What does that paragraph have to do with fixing the kernel?

The clang patch D133574 has been made to satisfy the requirements of WG14
N2350. Compiling the kernel with this patched clang allows me to test where
type definitions are used in the kernel in the first argument of offsetof.

> Is this patch going to be part of clang? If so, which version?

Yes. Probably clang-16 because this patch is not landed to LLVM codebase
currently. The kernel needs this patch to be successfully compiled, in order
not to break the ability of LLVM mainline to compile the kernel, I am happy to
not landing D133574 for now.

> Does gcc need it too?

Since WG14 N2350 is generally applied to the C standard, I feel that GCC should
reject/fire a warning pointing out type definitions within offsetof.

> If so, should a gcc bug be opened too?

I'm not very familiar with the GCC community, but I thought it should be good
to file a bug.

Link: https://reviews.llvm.org/D133574
