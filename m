Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B372BB68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjFLI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjFLI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:56:36 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEC335BE;
        Mon, 12 Jun 2023 01:54:13 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686560046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cajy4YCfvWDa+DGbifIsIf3ZaH6ZbGCujPLhQZZUKzE=;
        b=FNLmJEa5LvsFfK7gTOSXm+mpoSv2shNKq0Rg0H1XSGrfz3fVb77PYL6AWwAkyALJgGqFZM
        T1jVSkSu8nExLM6NLH/j0ElJBMHjMctTseez0fPHbi61JWltbmvx7z1/PS8LRob/MLL0Mf
        gynKShTksyl5wy5GsfvA15yiTDb3+jg2ygh1qP6Ia75loCDR6ELAN0SIeKZvFjNQvJJq1v
        oJo26DnnIxIncax4mrj12Q+eXcYCpqi0YFb9NU8bNLUWvt5u34PgP/2e9RilbMrkOLFOpd
        6Njq3cUZMN9ejg4rX2bUSDRXF1Xv9T55HUAdVyt/4dwAZGPoXRgl2ADzl0efYg==
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A11EA20009;
        Mon, 12 Jun 2023 08:54:04 +0000 (UTC)
Message-ID: <e650d15a-3fa6-5c76-8eee-ba21df3230f2@bootlin.com>
Date:   Mon, 12 Jun 2023 10:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: implement egress tbf
 qdisc for 6393x family
Content-Language: en-US
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com
References: <20230609141812.297521-1-alexis.lothore@bootlin.com>
 <20230609141812.297521-3-alexis.lothore@bootlin.com>
 <d196f8c7-19f7-4a7c-9024-e97001c21b90@lunn.ch>
 <dbec77de-ee34-e281-3dd4-2332116a0910@bootlin.com>
 <176f073a-b5ab-4d8a-8850-fcd8eff65aa7@lunn.ch>
 <bb799b06-8ca8-8a29-3873-af09c859ae88@bootlin.com>
 <CA+sq2CcG4pQDLcw+fTkcEfTZv6zPY3pcGCKeOy8owiaRF2HELA@mail.gmail.com>
From:   =?UTF-8?Q?Alexis_Lothor=c3=a9?= <alexis.lothore@bootlin.com>
In-Reply-To: <CA+sq2CcG4pQDLcw+fTkcEfTZv6zPY3pcGCKeOy8owiaRF2HELA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

On 6/12/23 08:34, Sunil Kovvuri wrote:
> 
> 
> On Fri, Jun 9, 2023 at 11:08 PM Alexis Lothoré <alexis.lothore@bootlin.com
> <mailto:alexis.lothore@bootlin.com>> wrote:
> 
>     On 6/9/23 19:16, Andrew Lunn wrote:
>     >> Yes, I can do that (or maybe -EINVAL to match Vladimir's comment ?). I think
>     >> it's worth mentioning that I encountered an issue regarding those values
>     during
>     >> tests: I use tc program to set the tbf, and I observed that tc does not even
>     >> reach kernel to set the qdisc if we pass no burst/latency value OR if we
>     set it
>     >> to 0. So tc enforces right on userspace side non-zero value for those
>     >> parameters, and I have passed random values and ignored them on kernel side.
>     >
>     > That is not good. Please take a look around and see if any other
>     > driver offloads TBF, and what they do with burst.
>     >
>     >> Checking available doc about tc-tbf makes me feel like that indeed a TBF
>     qdisc
>     >> command without burst or latency value makes no sense, except my use case can
>     >> not have such values. That's what I struggled a bit to find a proper qdisc to
>     >> match hardware cap. I may fallback to a custom netlink program to improve
>     testing.
>     >
>     > We don't really want a custom application, since we want users to use
>     > TC to set this up.
>     >
>     > Looking at the 6390 datasheet, Queue Counter Registers, mode 8 gives
>     > the number of egress buffers for a port. You could validate that the
>     > switch has at least the requested number of buffers assigned to the
>     > port? There is quite a bit you can configure, so maybe there is a way
>     > to influence the number of buffers, so you can actually implement the
>     > burst parameter?
> 
>     Thanks for the pointers. I will check the egress buffers configuration and see
>     if I can come up with something better
> 
> 
> For setting up simple per-port ratelimit, instead of TBF isn't "egress matchall"
> suitable here ?

I guess you are suggesting matchall + policer ? At first glance, I see no
obvious elements showing if one or another is more relevant. From user point of
view, controls are pretty much the same (rate + burst at least), but it looks
like policer is more of a pass/drop action, contrary to TBF which has some delay
notions, so it would solve the latency/limit absence of control. I am not sure
how it would look like on kernel side and how it would behave (how is managed
the filter, how can the policer be offloaded). I see some port_policer_add/del
callbacks in DSA, I will take a look at that as well and check differences with
TBF. Thanks for the suggestion.

Alexis
> 
> Thanks,
> Sunil. 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

