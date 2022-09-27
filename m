Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B2F5EC9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiI0Qo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiI0QoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:44:19 -0400
Received: from mail-m118207.qiye.163.com (mail-m118207.qiye.163.com [115.236.118.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 057F11E05CE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:44:16 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118207.qiye.163.com (HMail) with ESMTPA id 10B7F9016AB;
        Wed, 28 Sep 2022 00:44:12 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     david.laight@aculab.com
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, me@inclyc.cn, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: RE: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Wed, 28 Sep 2022 00:44:11 +0800
Message-Id: <20220927164411.99297-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <38114d1b752c497eba1640360daf5b9e@AcuMS.aculab.com>
References: <38114d1b752c497eba1640360daf5b9e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWRpLTk1WGRpPHRhLQk1KSB5KVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6Qxw4PjlNGTc5NE4xFDQI
        AgxPCT5VSlVKTU1PSUJMS05IS0NDVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUlIT0M3Bg++
X-HM-Tid: 0a837fd5a9cc2d29kusn10b7f9016ab
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting - what justification do they give?
> Linux kernel requires that the compiler add no unnecessary padding
> so that structure definitions are well defined.

Yes, that's a clarification given in 2019.

> So using a type definition inside offsetof() won't give a
> useful value - but it still isn't really UB.

WG14 may worry about commas and the scope of new definitions. So they provide
new words into the standard and said:

> If the specified type defines a new type or if the specified member is a
> bit-field, the behavior is undefined.

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm

I've provided this link in the patch.

> Has that ever worked?
> Given:
> 	struct foo {
> 		int a;
> 		char b;
> 		char c;
> 	};

TYPE_ALIGN(struct foo) evaluates to 4 in the previous approach (based on
offsetof). _Align(struct foo) evaluates to the same value.

See https://godbolt.org/z/sqebhEnsq

> I think CHECK_MEMBER_AT_END_OF_TYPE(struct foo, b) is true.

Hmm, both the previous version and after this patch the macro gives me
false. (See the godbolt link).
