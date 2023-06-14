Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4072F52F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbjFNGvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjFNGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:51:47 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1991A3;
        Tue, 13 Jun 2023 23:51:44 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Qgx0s0vbgz9sq3;
        Wed, 14 Jun 2023 08:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686725501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yeolAlGiaOA7hn27bEnN56iwUdLLCYZptbHjpu/TbIw=;
        b=CwE7ziezRdBEkmfaCt0EPwQ0fNxLiidofeRpChilr6q9Dq2F0hsva2OUdsv/5WMFdP36VV
        rGAus/M9/QZ6WENp+VeTM89CquL8FFIMzgsOIDcpG1v36g4uJGIr5BabjV78L+g2W75Jfb
        NkMivWDQkVrLEohi/DfIhKtegxsM0oRxVPIoKB+aDPxNFKwTo4ZAmgz/NVh3jgM3jYNMT9
        SGuzK8MqShCicDYUTTj5AFUqXJNzTYZtRPpB7mkosMMT05c3UWWz+4pGNYXdaIDErp46ds
        HiA/QBkQss876reHmjEd+0pokwBYeKoiydtTSm42RDijGyecrTnBH3Or+hVspA==
References: <20230613083626.227476-1-frank@oltmanns.dev>
 <20230613083626.227476-3-frank@oltmanns.dev>
 <83f9ee3ce26e4d4ba7c395aab316cae6.sboyd@kernel.org>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
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
In-reply-to: <83f9ee3ce26e4d4ba7c395aab316cae6.sboyd@kernel.org>
Date:   Wed, 14 Jun 2023 08:51:32 +0200
Message-ID: <87pm5yzgcr.fsf@oltmanns.dev>
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

Thank you for your feedback.

On 2023-06-13 at 12:42:05 -0700, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Frank Oltmanns (2023-06-13 01:36:26)
>> In light of the recent discovery that the fractional divisor
>> approximation does not utilize the full available range for clocks that
>> are flagged CLK_FRAC_DIVIDER_ZERO_BASED, implement tests for the edge
>> cases of this clock type.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> Link: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev
>
> What is the link for?

The intention was to show why the tests were added ("In light of the
recent discovery..."). I announced this discovery in the mail I referred
to. Since that intention didn't come across: Should I drop the link?

>
>> ---
>>  drivers/clk/clk_test.c | 69 +++++++++++++++++++++++++++++++++++++++++-
>
> Please make a new file, drivers/clk/clk-fractional-divider_test.c
> instead.
>
>>  1 file changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
>> index f9a5c2964c65..b247ba841cbd 100644
>> --- a/drivers/clk/clk_test.c
>> +++ b/drivers/clk/clk_test.c
>> @@ -8,6 +8,9 @@
>>  /* Needed for clk_hw_get_clk() */
>>  #include "clk.h"
>>
>> +/* Needed for clk_fractional_divider_general_approximation */
>> +#include "clk-fractional-divider.h"
>> +
>>  #include <kunit/test.h>
>>
>>  #define DUMMY_CLOCK_INIT_RATE  (42 * 1000 * 1000)
>> @@ -2394,6 +2397,69 @@ static struct kunit_suite clk_mux_notifier_test_suite = {
>>         .test_cases = clk_mux_notifier_test_cases,
>>  };
>>
>> +
>> +/*
>> + * Test that clk_fractional_divider_general_approximation will work with the
>> + * highest available numerator and denominator.
>> + */
>> +static void clk_fd_test_round_rate_max_mn(struct kunit *test)
>> +{
>> +       struct clk_fractional_divider *fd;
>> +       struct clk_hw *hw;
>> +       unsigned long rate, parent_rate, m, n;
>> +
>> +       fd = kunit_kzalloc(test, sizeof(*fd), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_NULL(test, fd);
>> +
>> +       fd->mwidth = 3;
>> +       fd->nwidth = 3;
>> +
>> +       hw = &fd->hw;
>> +
>> +       rate = DUMMY_CLOCK_RATE_1;
>> +
>> +       // Highest denominator, no flags
>
> Use /* this for comments */
>
>> +       parent_rate = 10 * DUMMY_CLOCK_RATE_1;
>
> Just write out the actual frequency. Don't use DUMMY_CLOCK_RATE_1 at all
> in the test.

Sure, will do. The idea was to highlight that we want to have the parent
running at 10 times the speed, while the divider has a maximum value of
7 (or 8 if zero based).

>
>> +       clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
>> +       KUNIT_EXPECT_EQ(test, m, 1);
>> +       KUNIT_EXPECT_EQ(test, n, 7);
>
> This is a different test case.
>
>> +
>> +       // Highest numerator, no flags
>> +       parent_rate = DUMMY_CLOCK_RATE_1 / 10;
>> +       clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
>> +       KUNIT_EXPECT_EQ(test, m, 7);
>
> Is 7 related to mwidth? Maybe this should be clk_div_mask(fd->mwidth)
> instead of 7.

Yes, 7 is related to mwidth. I thought about this too, but I'm not sure
that's the best move here. The function under test uses:
    max_m = GENMASK(fd->mwidth - 1, 0);
    max_n = GENMASK(fd->nwidth - 1, 0);

I come from a safety-concerned industry and as a general rule we avoid
using functions from the code under test in our tests. I'm doing this
here as a hobby, but still I find it to be a good rule that I'd like to
stick to unless asked otherwise.

If I use the same code to generate the expected values, I'm not really
testing my change, but only the underlying best_rational_approximation.

Instead, how about I add a comment to the test function that more
thoroughly explains its intention?

Something along those lines:

    /*
     * Introduce a parent that runs at 10 times the frequency of the
     * requested rate.
     * m and n are 3 bits wide each.
     * The clock has no flags set, hence the maximum value that fits in
     * m and n is 7.
     * Therefore, expect the highest possible divisor.
     */
    static void clk_fd_test_round_rate_max_m(struct kunit *test)

    /*
     * Introduce a parent that runs at 1/10th the frequency of the
     * requested rate.
     * m and n are 3 bits wide each.
     * The clock has no flags set, hence the maximum value that fits in
     * m and n is 7.
     * Therefore, expect the highest possible multiplier.
     */
    static void clk_fd_test_round_rate_max_n(struct kunit *test)

    /*
     * Introduce a parent that runs at 10 times the frequency of the
     * requested rate.
     * m and n are 3 bits wide each.
     * The clock is zero based, hence the maximum value that fits in
     * m and n is 8.
     * Therefore, expect the highest possible divisor.
     */
    static void clk_fd_test_round_rate_max_m_zero_based(struct kunit *test)

    /*
     * Introduce a parent that runs at 1/10th the frequency of the
     * requested rate.
     * m and n are 3 bits wide each.
     * The clock is zero based, hence the maximum value that fits in
     * m and n is 8.
     * Therefore, expect the highest possible multiplier.
     */
    static void clk_fd_test_round_rate_max_n_zero_based(struct kunit *test)

Please note that from your original comment, I wasn't sure, if you
wanted a one time test or someting that could become part of the
clk-frameworks test suite. Therefore, I sent this test case to test the
waters and ask for your comments. It's clear to me now that you want it
to be permanent, so I'll spend some time on it to make it ready for
inclusion. :)

Is there anything else you'd like me to cover in the tests for the fix?

Thanks,
  Frank

>
>> +       KUNIT_EXPECT_EQ(test, n, 1);
>
> This is a different test case.
>
>> +
>> +       // Highest denominator, zero based
>> +       parent_rate = 10 * DUMMY_CLOCK_RATE_1;
>> +       fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
>> +       clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
>> +       KUNIT_EXPECT_EQ(test, m, 1);
>> +       KUNIT_EXPECT_EQ(test, n, 8);
>
> This is a different test case.
>
>> +
>> +       // Highest numerator, zero based
>> +       parent_rate = DUMMY_CLOCK_RATE_1 / 10;
>> +       clk_fractional_divider_general_approximation(hw, rate, &parent_rate, &m, &n);
>> +       KUNIT_EXPECT_EQ(test, m, 8);
>> +       KUNIT_EXPECT_EQ(test, n, 1);
>
> This is a different test case. If it has a meaningful name it will be
> easier to understand as well.
