Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD469632E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjBNMMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBNMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:12:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1815F211D;
        Tue, 14 Feb 2023 04:12:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63EEB1042;
        Tue, 14 Feb 2023 04:13:04 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009EB3F881;
        Tue, 14 Feb 2023 04:12:19 -0800 (PST)
Date:   Tue, 14 Feb 2023 12:12:17 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230214121217.43f6124f@donnerap.cambridge.arm.com>
In-Reply-To: <20230214104554.35338faa@posteo.net>
References: <20230213231931.6546-1-bage@debian.org>
        <20230213231931.6546-3-bage@debian.org>
        <20230214104554.35338faa@posteo.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 09:45:54 +0000
Wilken Gottwalt <wilken.gottwalt@posteo.net> wrote:

Hi,

> On Tue, 14 Feb 2023 00:19:29 +0100
> Bastian Germann <bage@debian.org> wrote:
> 
> > The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> > and reset-names set to "ahb" as required by the driver.  
> 
> Hmm, this one is a bit odd. If you look into my earlier versions of the
> patchset, you may notice, that I actually included these bindings and they
> were refused. I think the argumentation was like
> "there is only one bus = no need for it".

That's interesting, because your driver implementation relies on there
being a clock name. And if I chased down devm_clk_get() correctly, there
must be a named clock in the DT, otherwise it would fail? I haven't tested
this, though, but I guess this is the  reason for Bastian's patch.

Regarding "one bus clock only": while this is true, I think there
is (or was?) also the rationale of using names being more future-proof, so
adding clocks (for future hardware revisions) can be done more easily,
without breaking compatibility. It's not a big problem, since you probably
have a new compatible string in this case anyway, but it also doesn't
hurt, and allows to use more generic helpers like devm_clk_get().

> If it gets accepted now, I really like to know why. (It was some trouble
> back then to get the documentation properly done and accepted.)

IIUC, it simply doesn't work without a clock-names property.
 
Cheers,
Andre
