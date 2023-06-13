Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098BE72DCDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbjFMIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbjFMIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:40:54 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 01:40:45 PDT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E7A0;
        Tue, 13 Jun 2023 01:40:45 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QgMT62WB0z9smX;
        Tue, 13 Jun 2023 10:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686645642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4YR6IC11dblIqgF9IfE7gEo2pRgRczWDAIr1+EuyLQ=;
        b=uHu3KnFjumsj3KVvsIxFa5qbz7R5TJoEBx6uzPIP9sPj+t/s4QhN2PBRzU9hQ3Z1ukHlk6
        K5E3nwo9JPvEUni832RmtTxLZ4ajKne4JDpllxjTjtJtpa3/70x5VrUlzIAxCmRs0FITXB
        IAQsd9Cydes9Jys/2+edOYNSq/kVAoMn5Rpe1XGI5TyYZdrT/YZuPSMFJOQhrkTaemDZFL
        /6hF8VNRzVG0rBZEvJ+vZWyIpNeKyHJvp/Tg+fcjpz0ooTk3XLXtV/+1TirGKKDyU5qEAd
        ZcWbBi7Fs+uVLpC6+hZ2gZCYP2BTX7d9483Apo2SgMjGX+H7Ii+cRDM3ZzKLfQ==
References: <20230529133433.56215-1-frank@oltmanns.dev>
 <69a0b07442116b52e359534d93433f55.sboyd@kernel.org>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: fractional-divider: Improve approximation when
 zero based
In-reply-to: <69a0b07442116b52e359534d93433f55.sboyd@kernel.org>
Date:   Tue, 13 Jun 2023 10:40:33 +0200
Message-ID: <875y7r21ry.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QgMT62WB0z9smX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2023-06-12 at 14:39:00 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Frank Oltmanns (2023-05-29 06:34:33)
>> Consider the CLK_FRAC_DIVIDER_ZERO_BASED flag when finding the best
>> approximation for m and n. By doing so, increase the range of valid
>> values for the numerator and denominator by 1.
>>
>> Cc: A.s. Dong <aisheng.dong@nxp.com
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>> I stumpled upon this, when familiarizing myself with clk drivers. Unfortunately,
>> I have no boards to test this patch. It seems the only user of this flag in
>> mainline is drivers/clk/imx/clk-composite-7ulp.c, therefore I'm cc-ing
>> get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
>> in the hopes of a wider audience.
>>
>> Thank you for considering this contribution,
>
> Thanks for looking at this. Can you add a kunit test (or a suite of
> tests) to confirm that this doesn't break existing functionality and
> also improves a case that would have failed or been suboptimal before?

Thank you for your feedback, I've submitted a V2 that contains the
tests:

https://lore.kernel.org/lkml/20230613083626.227476-1-frank@oltmanns.dev/

Thanks,
  Frank
