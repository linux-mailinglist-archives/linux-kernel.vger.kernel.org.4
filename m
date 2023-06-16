Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA97333E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjFPOp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjFPOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:45:23 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 07:45:21 PDT
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438392D73;
        Fri, 16 Jun 2023 07:45:21 -0700 (PDT)
Message-ID: <4440a0b1-bf67-9c37-0526-1a447ff8568a@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
        t=1686926376; bh=D3G6HTwRcPV6KnfEheAEItSyD7W7vt2jWXDdc7E1V78=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=YFPavAo7QyVgTMfpKQgwgzy89b8jO6AdVmNablD2JZi8OCPQXDzYs+QyGqPgKsEGq
         4n0fCMiL6DuOta7+rR04nkyzUtIe1dU+nMrXFbekxjeDLHcrEd4noPqjQllCHMPu0p
         5J1V03UYBKBcrr8RaZEFob8Xqxz9Sx9McIpT1mo0=
Date:   Fri, 16 Jun 2023 22:39:09 +0800
MIME-Version: 1.0
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>
References: <20211007123632.697666-1-anup.patel@wdc.com>
 <20211007123632.697666-6-anup.patel@wdc.com>
Content-Language: en-US
From:   Vivian Wang <uwu@dram.page>
Subject: Re: [RFC PATCH v4 05/10] dt-bindings: interrupt-controller: Add
 ACLINT MSWI and SSWI bindings
In-Reply-To: <20211007123632.697666-6-anup.patel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are working on devicetree generation for rocket-chip, specifically
generating ACLINT nodes instead of CLINT nodes. (WIP at [1].) We were
wondering if riscv,aclint-{m,s}swi should really be an interrupt-controller.

According to the devicetree specification (v0.3 found at [2]), an
interrupt-controller *receives* interrupts. The ACLINT devices only ever
generates interrupts, so they would be classified as interrupt
generating device rather than interrupt controller or interrupt nexus.

These bindings, as is, require the MSWI and SSWI devices to have the
interrupt-controller property and #interrupt-cells = <0>, which does not
reflect its functionality. It nonsensically implies that another device
may have an interrupt routed through an MSWI/SSWI as interrupt-parent.
Removing these requirements makes more sense.

I'm not sure about what other node name to use though. It seems that
these are more like mailboxes, but also not exactly. In any case a
clarification of the bindings would be appreciated.

Thanks,
dram

[1]: https://github.com/chipsalliance/rocket-chip/pull/3330
[2]: https://www.devicetree.org/specifications/

