Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48816CCCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjC1WDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjC1WDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:03:03 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BF2126;
        Tue, 28 Mar 2023 15:03:01 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C1E7100002;
        Tue, 28 Mar 2023 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680040980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLxkuolFWCKZXPrFlMPQjelZHZ3iSSYl5Tg09kEuqFw=;
        b=d3DHupHtgpyZn5uk+D8NQEu58+ECXt01ErHNlny0J/E0YjfOAJaSOEjiG9TI/wnH/gW/ej
        KPFXJy8WF0osovYQDJ34GWropPaupUo9/YOi6gsMeDHKr++/pLaN10oyBAtigCx98668at
        FgALOR5hLwWMksRrX0XOvtsvxzlB0sfjdzzNvu3XJSVAoz0GFsnfgppZvcMJoDjjIG56z2
        4Mp6ccWaJwIrozvs8ZWwLMD7+d2exHQ9My+7GZgMW1gwRA5sbaG2j+m0P/UU2qmJJwrJD0
        8ahTaL/n6mgL8LGyTq+D2KKg6kYugZnevH6PVPEC5wAKjChLgpcrN3i2PEPnqA==
Date:   Wed, 29 Mar 2023 00:02:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resent] clk: at91: sama7g5: Add two jump labels in
 sama7g5_pmc_setup()
Message-ID: <202303282202593dfa4106@mail.local>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5ed1bc78-77a1-8eb8-43f9-6005d7de49c8@web.de>
 <9e3705dc-7a70-c584-916e-ae582c7667b6@web.de>
 <7890284f-5809-2f46-9d5f-52e20a3ec327@microchip.com>
 <7985ac57-5b33-e7df-f319-ad6ee0788e2c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7985ac57-5b33-e7df-f319-ad6ee0788e2c@web.de>
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 21:24:00+0200, Markus Elfring wrote:
> >> The label “err_free” was used to jump to another pointer check despite of
> >> the detail in the implementation of the function “sama7g5_pmc_setup”
> >> that it was determined already that the corresponding variable contained
> >> a null pointer (because of a failed memory allocation).
> >>
> >> * Thus use additional labels.
> >>
> >> * Delete an extra pointer check at the end which became unnecessary
> >>    with this refactoring.
> >>
> >> This issue was detected by using the Coccinelle software.
> >
> > Fine, but I'm sorry that it complexity the function for no real value.
> 
> Under which circumstances can advice be taken better into account
> also from another information source?
> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandreleasingresources-CompliantSolution%28POSIX,GotoChain%29
> 
> 
> 
> > Other clk drivers have the same pattern so I want them to all stay the same.
> > This is a NACK, sorry about that.
> 
> I am curious if other contributors (or code reviewers) would like to influence
> the software situation a bit more.
> 

I agree with Nicolas here, this is useless churn.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
