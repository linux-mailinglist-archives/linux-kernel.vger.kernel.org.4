Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51115ECA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiI0RHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiI0RHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:07:09 -0400
Received: from mail-m118204.qiye.163.com (mail-m118204.qiye.163.com [115.236.118.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBADB85A99
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:07:04 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118204.qiye.163.com (HMail) with ESMTPA id 65288A2246A;
        Wed, 28 Sep 2022 01:07:02 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     me@inclyc.cn
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, david.laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: RE: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Wed, 28 Sep 2022 01:07:02 +0800
Message-Id: <20220927170702.209578-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927164411.99297-1-me@inclyc.cn>
References: <20220927164411.99297-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWRkdQktWSExJQ0wdQklJTENPVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6SSo*SzlDSjcQQ082Tw8M
        CzYaCg9VSlVKTU1PSUJDT0lISEJNVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUpNT0w3Bg++
X-HM-Tid: 0a837fea92b02d26kusn65288a2246a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In LLVM Phab we have discussed difference between using offsetof and _Alignof.

> Technically there's no requirement that they return the same value (the
> structure could insert arbitrary padding, including no padding), so it's
> theoretically possible they return different values. But I can't think of a
> situation in which you'd get a different answer from `TYPE_ALIGN` as you
> would get from `_Alignof`.

Link: https://reviews.llvm.org/D133574#3815253
