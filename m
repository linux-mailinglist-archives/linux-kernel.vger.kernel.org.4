Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD4727B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjFHJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjFHJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:33:31 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CA1269F;
        Thu,  8 Jun 2023 02:33:25 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QcJtB2TJ5z9sZL;
        Thu,  8 Jun 2023 11:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686216802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3o9iqTcADNP2uWhkzkA0IAS3M4zfQXXf39LOvZbbnI=;
        b=1fEf6UiDIdhopDV6j7Dk1tMGFq0ig6NZ2MA940WCp61viWTy27wmj4mfZnGtR+JGk+IZqY
        mWrMyLLWLSZKsXdngHvAviG48sXcw/AhNQUrYIJN+a9ZJKZiPjNQSBQMFjZKK4U65/VePH
        h6RzbAafwJgYsQq4Vcj6+YpnAs6Djd+qnk0X1/oAGiWFmzKRuDJWIO/YSwfRNEWaeCrjte
        H0tNJNpvZDVTWAt0veQnC4O/S/LeeHxx/m5Z5WUr5TsJJS+4KFbv2YJeHWTyNO8Q9f3wY4
        kh5Kr9u/7KjFDsz3zFuBC/rBaY1xHC0pCTHSPiTfTuspWSzS1pM7wQ3Hm1Fhww==
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <87legv2093.fsf@oltmanns.dev>
 <vvmdk3fqtjt3jspxgvlbypdxajchymydshya5b5ivk3wfodwwr@yyi26m6toosh>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Date:   Thu, 08 Jun 2023 11:29:05 +0200
In-reply-to: <vvmdk3fqtjt3jspxgvlbypdxajchymydshya5b5ivk3wfodwwr@yyi26m6toosh>
Message-ID: <871qim1eow.fsf@oltmanns.dev>
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


On 2023-06-07 at 14:27:46 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Wed, Jun 07, 2023 at 09:35:20AM +0200, Frank Oltmanns wrote:
>> So, my question: Is spending the 30 ms fine or do I need to optimize for
>> speed in order for this patchset to be accepted? Or is 2 ms also too
>> much of an increase, in which case I'm out of ideas. :-)
>
> You keep mentioning it, but it's really not clear to me why you think
> that both are intertwined, or depend on one another?

I'm sorry about that. I guess, I got carried away. And furthermore I
took your mentioning of all bets being of how often setting rates
happens when HDMI comes into play as encouragement to optimize for
speed, which it clearly wasn't.

I saw the increase in time as a regression, because it might break
boards that I don't have access to. But since you say it's fine, I'll
speak no more of it.

> What's wrong with just merging (some later version of) this series?

Nothing. :-)

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
