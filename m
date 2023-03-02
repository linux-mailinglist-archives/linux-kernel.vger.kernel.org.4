Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0E6A82A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCBMvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:51:53 -0500
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 04:51:51 PST
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530B4A1E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:51:51 -0800 (PST)
Date:   Thu, 2 Mar 2023 13:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677761152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6NPpn9lnE9VN46m7Kz9u5WpXlX7L7nN99uIr6gXUSh8=;
        b=kkaqAPLJxMlF5jBJFTUgdiZbbOF8VbSmmAy0Y2OOaabuY0Mt67pKg+p1NiZdVukSscLx5j
        p9lz5GTqXUhiS2fEdyRU0I+oZtD/aj5UxRScNqBPjTYPvOW/3qQHdPH6yEg1kqd0tmeB6g
        GQu3l/NhZIl7D4tJFN3vYJFcdut4Wek=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Message-ID: <ZACafglBa201CUUd@g0hl1n.net>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
 <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:20:18PM +0000, Mark Brown wrote:
> On Thu, Mar 02, 2023 at 12:55:03PM +0100, richard.leitner@linux.dev wrote:
> 
> > +	max9867->mclk = devm_clk_get(&i2c->dev, "mclk");
> > +	if (IS_ERR(max9867->mclk))
> > +		return PTR_ERR(max9867->mclk);
> > +	ret = clk_prepare_enable(max9867->mclk);
> > +	if (ret < 0)
> > +		dev_err(&i2c->dev, "Failed to enable MCLK: %d\n", ret);
> > +
> 
> Nothing ever disables the clock - we need a disable in the remove path
> at least.

Sure. Sorry for missing that. I will send a v2 later today.

regards;rl

