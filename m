Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A555EDBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiI1LXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1LXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:23:47 -0400
Received: from mail-m118205.qiye.163.com (mail-m118205.qiye.163.com [115.236.118.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E31EDDCEBC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:23:44 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118205.qiye.163.com (HMail) with ESMTPA id 342F32C0D19;
        Wed, 28 Sep 2022 19:23:42 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     david.laight@aculab.com
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, me@inclyc.cn, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: RE: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Wed, 28 Sep 2022 19:23:41 +0800
Message-Id: <20220928112341.2255320-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <fc12d0d4c1064832955543217d0dbe4a@AcuMS.aculab.com>
References: <fc12d0d4c1064832955543217d0dbe4a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUIaSkhWHRhMTkNDGU1KHUNLVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Hgw6NjlNIzYUDAEBFw9D
        MBkwCg5VSlVKTU1PSE1PSUlISUpPVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUhCQks3Bg++
X-HM-Tid: 0a8383d6992c2d27kusn342f32c0d19
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: YingChi Long
> > Sent: 27 September 2022 17:44
> >
> > > Interesting - what justification do they give?
> > > Linux kernel requires that the compiler add no unnecessary padding
> > > so that structure definitions are well defined.
> >
> > Yes, that's a clarification given in 2019.
> >
> > > So using a type definition inside offsetof() won't give a
> > > useful value - but it still isn't really UB.
> >
> > WG14 may worry about commas and the scope of new definitions. So they provide
> > new words into the standard and said:
> >
> > > If the specified type defines a new type or if the specified member is a
> > > bit-field, the behavior is undefined.
> >
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
>
> Except that the kernel requires it to be defined.
>
> Did they clarify the clause that required offsetof() to return
> a compile-time constant?
> That stops you doing offsetof(struct x, member->array[expression]).
> (Oh and the compiler for a common OS disallows any version of that
> even when expression in an integer constant!)

WG14 N2350 may just not require implementation offsetof() accepts any type
definitions within the first param of (not the second), and no further changes
about whether it is compile-time constant?

https://godbolt.org/z/9GsEPnPd6

    #include <stdio.h>

    struct foo {
        int a;
        int b[100];
    };

    int main() {
        int i;
        scanf("%d", &i);
        printf("%d\n", __builtin_offsetof(struct foo, b[i]));
    }

We consider reject type definitions within the first parameter in clang.

For example

    offsetof(struct { int a, b;}, a)

However

    struct foo {
        int a;
        int b[20];
    }
    offsetof(struct foo, b[sizeof(struct { int a, b;})])

Shall be fine.

> >
> > I've provided this link in the patch.
> >
> > > Has that ever worked?
> > > Given:
> > > 	struct foo {
> > > 		int a;
> > > 		char b;
> > > 		char c;
> > > 	};
> >
> > TYPE_ALIGN(struct foo) evaluates to 4 in the previous approach (based on
> > offsetof). _Align(struct foo) evaluates to the same value.
> >
> > See https://godbolt.org/z/sqebhEnsq
> >
> > > I think CHECK_MEMBER_AT_END_OF_TYPE(struct foo, b) is true.
> >
> > Hmm, both the previous version and after this patch the macro gives me
> > false. (See the godbolt link).
>
> See https://godbolt.org/z/95shMx44j
>
> It return 1 for a and 0 for b and c (and char d,e following b).
> NFI what it is trying to do!

Switch _Alignof back to TYPE_ALIGN, CME seems return exactly the same values. I
don't know what CME do here, but seems TYPE_ALIGN and _Alignof have the same
semantics here?

https://godbolt.org/z/hYcT1M3ed
