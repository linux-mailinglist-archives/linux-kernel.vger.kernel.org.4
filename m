Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59A745857
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGCJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGCJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:29:16 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F218D;
        Mon,  3 Jul 2023 02:29:13 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Qvgbp2SrFz9snc;
        Mon,  3 Jul 2023 11:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688376550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBBsuTVav6vfnGbrZf+Lz4bRJkmuMheylCTqMuDos48=;
        b=SE+0JRdHcYANbRAfup4b7XMw745p4opXWmIMTCefwWUXzM/Gu7Q5gvZbRjq2mHSr/1+/uC
        JEsbcAbcDcTTnSuIh2uxqJ87CS3uj2ybDl47j0yhFYBdhH6DiL5Lkz+xcfiKKGZE2HVO1H
        y8590C3vyeYHHMeCqdzptH3wSgPrHHaGX/xnYFlp+rH2BfXw72uA67MFmDIrlJq2tlALF1
        0rorKXrMMH8n4hc22DkhOi7McBvtqzegVR7HOBg1oJV451l//enKeEcgXkP+NHBhVDp8lF
        vNruh85DGZ86zRaZngdXio2TMbdh8minYAYdTIOn9p4L+UMu1XIS49Pf2guwHA==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-8-46dcb8aa9cbc@oltmanns.dev>
 <lfcpuv5euy5w6e7jzn6fm2qusjj52w2hhn5sosqvoz54zc56py@5wh2eea3rrs3>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] clk: sunxi-ng: a64: select closest rate for
 pll-video0
In-reply-to: <lfcpuv5euy5w6e7jzn6fm2qusjj52w2hhn5sosqvoz54zc56py@5wh2eea3rrs3>
Date:   Mon, 03 Jul 2023 11:28:59 +0200
Message-ID: <878rbxs5r8.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-07-03 at 09:50:05 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Sun, Jul 02, 2023 at 07:55:27PM +0200, Frank Oltmanns wrote:
>> @@ -541,7 +542,7 @@ static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
>>  static const u8 tcon1_table[] = { 0, 2, };
>>  static struct ccu_div tcon1_clk = {
>>  	.enable		= BIT(31),
>> -	.div		= _SUNXI_CCU_DIV(0, 4),
>> +	.div		= _SUNXI_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ROUND_CLOSEST),
>>  	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),
>>  	.common		= {
>>  		.reg		= 0x11c,
>> @@ -549,6 +550,7 @@ static struct ccu_div tcon1_clk = {
>>  						      tcon1_parents,
>>  						      &ccu_div_ops,
>>  						      CLK_SET_RATE_PARENT),
>> +		.features	= CCU_FEATURE_CLOSEST_RATE,
>>  	},
>>  };
>
> I'm not super comfortable with having to set it twice for dividers (or
> composite clocks). Could we set CLK_DIVIDER_ROUND_CLOSEST automatically
> if CCU_FEATURE_CLOSEST_RATE is set?

You're of course right. If I'm not mistaken, I can use
SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST that I introduced in div patch
(PATCH 7). Otherwise I'll create a similar macro for use with tcon1.

>
> I'm guessing we would need it for muxes as well?
>

Yes, it's already in the mux and div patches.

Best regards,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
