Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62B73424F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjFQQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:48:11 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DA198C;
        Sat, 17 Jun 2023 09:48:08 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Qk25c6srzz9sNf;
        Sat, 17 Jun 2023 18:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687020485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oywZapLqwNyrHkbuwEVveNFbHDemaqJwUKPIXYQhvIg=;
        b=LF3YZg2+edsmb61SmLOGvaNJisClVcQaaOe3GNcmYcrAoTU9J3ldeQNZhINufqXqAx4cRr
        OEdMmzwMIeYSlvWOelY16SOs8u1IGozEzhemqj5UwrDhU6bQdLbabbvkuO7lOQWYDBErp9
        jDjk6esNVRCFUWdnvw/Bf+ODrP6cVjz2jZXTvhNl9bl0/eKRzEl0/2mpSCzD66YJ2kUtdS
        Z5db+8uyLmoIxLTIc+2409SBd08VvhnO/jlBG0LO7DY7b5TNjr9JTBHar8RFm2HKAe9fJ9
        r7bpWcfg/GHx+Qu03kbK8D9sP8c8VNY+twdR0KZLQT5BqRes0T7bjHy3p1a7+g==
References: <20230613083626.227476-3-frank@oltmanns.dev>
 <202306132038.nUB6hmCv-lkp@intel.com> <87edmeqwva.fsf@oltmanns.dev>
 <aa23f41c0e313e97122ac384d66e2325.sboyd@kernel.org>
 <875y7ps3tq.fsf@oltmanns.dev>
 <dab61757f0c33453ad19857350117c62.sboyd@kernel.org>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tests: Add tests for fractional divisor
 approximation
In-reply-to: <dab61757f0c33453ad19857350117c62.sboyd@kernel.org>
Date:   Sat, 17 Jun 2023 18:47:54 +0200
Message-ID: <87cz1u2fyd.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
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

On 2023-06-16 at 12:33:51 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Frank Oltmanns (2023-06-14 22:16:17)
>> Hi Stephen,
>>
>> On 2023-06-14 at 13:02:24 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
>> > Quoting Frank Oltmanns (2023-06-14 01:19:37)
>> >> Hi,
>> >>
>> >> On 2023-06-13 at 20:48:21 +0800, kernel test robot <lkp@intel.com> wrote:
>> >> Can someone more knowlegdable than me please confirm if my understanding
>> >> is correct?
>> >
>> > Export the symbol.
>>
>> Ok. I can do that. Please note that I had already submitted a V3 [1],
>> that went the way of using clk_fractional_divider_ops.round_rate. I
>> apologize for not waiting for your feedback prior to submission. It
>> won't happen again.
>>
>> I liked the approach of calling clk_fd_round_rate directly via the ops,
>> because it might allow me to test the other ops as well using the same
>> blueprint. Of course, I will not add test cases, if you don't want it.
>> (Calling clk_fd_round_rate also had the side effect of teaching me, that
>> fd clocks expect the fraction to be less than or equal to 1.)
>>
>> I don't want to waste your time, but if you could maybe have a chance to
>> look at the approach I took in V3 and tell me if you still want me to
>> export the symbol instead, that would be really helpful. I'll follow
>> your preference.
>>
>> If I don't hear back until the weekend, I will treat your three words
>> above as your preference and prepare a V4 that goes back to calling
>> clk_fractional_divider_general_approximation directly.
>>
>
> Just call the API directly. That narrows the test to exactly what we
> want to test. If you export the API it will make the rockchip folks
> happy too[1]. We of course need to make sure that the registration API
> works as well and actually uses the widths that are passed in, but it
> doesn't need to fully exercise the approximation algorithm.
>
> [1] https://lore.kernel.org/r/20230601095512.18029-1-zhangqing@rock-chips.com

I've now submitted V5 [1] of this patchset. Unfortunately, V4 [2] had a
compiler warning on clang that slipped through the cracks. I'm sorry for
the noise.

In my opinion V5 is ready for review and hopefully addresses all your
previous concerns.

Thank you for your patience.

Best regards,
  Frank

[1] https://lore.kernel.org/all/20230617131041.18313-1-frank@oltmanns.dev/
[2] https://lore.kernel.org/all/20230617102919.27564-1-frank@oltmanns.dev/
