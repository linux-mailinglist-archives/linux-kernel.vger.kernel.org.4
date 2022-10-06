Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2365F6974
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJFOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiJFOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:17:29 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1D606A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:15:03 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id oo23so1042551qkn.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntnmdCz7v5r64kcnWi8DSkoYbZLsQCVuJJM9qyrDCnw=;
        b=B/MELwvxGHOUB9n/4IZqtXNP45/GUA/qzSkuclVSpXk/hHNETuFosn1BksqfdAO6YC
         Uk7s0kBfRcQno51w58ZZeR1JRQ1FTx0KFzVowH5ahSpQFM00sjiLAqu/8a/6V2kjdyFE
         BOaF5+dyP6N9n6rqssedaIY+lIsodO8jDsqxqQBbqPohnWSKRIraCSTiiKRhNJUswxrA
         4OuQOHS8dxZNaz8aBi+/Q0+h81aVB2UEnUYx43vpmtGk6gpAbkgxX8X/+FJPS0zlByMk
         QEl/foNsH27xCm2+Aj2r75obbZHv8GOoPql58jPWQ960t+qDJUHVZ0NHmJQhg+RSFZuv
         gUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ntnmdCz7v5r64kcnWi8DSkoYbZLsQCVuJJM9qyrDCnw=;
        b=2TjRsl/jo6cZl0K6YxSZ/NP3W+r2+0Nem+M2R0eqyuBS4B6rypuMdnamWIutH8aro1
         MhKQTXoCSk55Vs4ZqxbJ3SGP3vxbzGqVxX4uAZAqpXltA166LqDU/udm/tDx++LSEgrh
         +w2q9XC1gThfxQgtu1QTwEseQ4w2HiSr/ZHiQ0remQ1b+5r+xMd8uSJsGU6PyupTN332
         VMr/zOVVSaegteEgyt721RgZOAfeazOAVZhuAwxvuvyBaBZ4NEYkt5kH7BpfqS0U4Ji/
         f3kJHsr9WrrCGlGyEXFDBh+1va1kIlOZ0R545LfWyMfTejmWs1lVEX1w2lQPAySCIDZn
         rC6Q==
X-Gm-Message-State: ACrzQf1V7i7pLvAWqEHnH8Xclk0HVGt3kEYAZI8jv5pa+LX7raZ3rlC7
        9wMeAnA4hlsd0e6OqOQfJg==
X-Google-Smtp-Source: AMsMyM73nX69TZE1+MgUVtlQx7xVnxr/lUPIFB2FR88zpn3YmI15D7PxjegZ0vi/YooQMgojpkOXKQ==
X-Received: by 2002:a37:9302:0:b0:6ce:3765:eb95 with SMTP id v2-20020a379302000000b006ce3765eb95mr130459qkd.177.1665065401988;
        Thu, 06 Oct 2022 07:10:01 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.126])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006b98315c6fbsm3686391qkk.1.2022.10.06.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:10:01 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from dell1.minyard.net (unknown [IPv6:2001:470:b8f6:1d::35])
        by serve.minyard.net (Postfix) with ESMTPSA id 8D0D2180015;
        Thu,  6 Oct 2022 14:09:59 +0000 (UTC)
Date:   Thu, 6 Oct 2022 09:09:57 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
Message-ID: <Yz7htdRvb+IhU060@dell1.minyard.net>
Reply-To: minyard@acm.org
References: <20220812144741.240315-1-andrew@aj.id.au>
 <CACPK8XdnFPXZuzAaSMOUnV6ng9y2_ZMcAff12q8Zxvr2HJZy-w@mail.gmail.com>
 <f6a85e5e-a3b1-4e5c-9db6-1222dcabd780@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a85e5e-a3b1-4e5c-9db6-1222dcabd780@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:36:51PM +1030, Andrew Jeffery wrote:
> 
> 
> On Thu, 6 Oct 2022, at 10:20, Joel Stanley wrote:
> > On Fri, 12 Aug 2022 at 14:48, Andrew Jeffery <andrew@aj.id.au> wrote:
> >>
> >> The ASPEED KCS devices don't provide a BMC-side interrupt for the host
> >> reading the output data register (ODR). The act of the host reading ODR
> >> clears the output buffer full (OBF) flag in the status register (STR),
> >> informing the BMC it can transmit a subsequent byte.
> >>
> >> On the BMC side the KCS client must enable the OBE event *and* perform a
> >> subsequent read of STR anyway to avoid races - the polling provides a
> >> window for the host to read ODR if data was freshly written while
> >> minimising BMC-side latency.
> >>
> >
> > Fixes...?
> 
> Is it a fix though? It's definitely an *improvement* in behaviour, but 
> the existing behaviour also wasn't *incorrect*, just kinda unfortunate 
> under certain timings? Dunno. I'm probably splitting hairs.
> 
> In any case, if we do want a fixes line:
> 
> Fixes: 28651e6c4237 ("ipmi: kcs_bmc: Allow clients to control KCS IRQ state")

I added the Fixes and Joel's review.

Thanks,

-corey

> 
> >
> >> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks!
> 
> >
> >> ---
> >>  drivers/char/ipmi/kcs_bmc_aspeed.c | 24 +++++++++++++++++++++---
> >>  1 file changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> index cdc88cde1e9a..417e5a3ccfae 100644
> >> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> >> @@ -399,13 +399,31 @@ static void aspeed_kcs_check_obe(struct timer_list *timer)
> >>  static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 state)
> >>  {
> >>         struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
> >> +       int rc;
> >> +       u8 str;
> >
> > str is status, it would be good to spell that out in full.
> 
> I guess if it trips enough people up we can rename it later.
> 
> >
> >>
> >>         /* We don't have an OBE IRQ, emulate it */
> >>         if (mask & KCS_BMC_EVENT_TYPE_OBE) {
> >> -               if (KCS_BMC_EVENT_TYPE_OBE & state)
> >> -                       mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> >> -               else
> >> +               if (KCS_BMC_EVENT_TYPE_OBE & state) {
> >> +                       /*
> >> +                        * Given we don't have an OBE IRQ, delay by polling briefly to see if we can
> >> +                        * observe such an event before returning to the caller. This is not
> >> +                        * incorrect because OBF may have already become clear before enabling the
> >> +                        * IRQ if we had one, under which circumstance no event will be propagated
> >> +                        * anyway.
> >> +                        *
> >> +                        * The onus is on the client to perform a race-free check that it hasn't
> >> +                        * missed the event.
> >> +                        */
> >> +                       rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> >> +                                                     !(str & KCS_BMC_STR_OBF), 1, 100, false,
> >> +                                                     &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
> >> +                       /* Time for the slow path? */
> >
> > The mod_timer is the slow path? The question mark threw me.
> 
> Yeah, mod_timer() is the slow path; read_poll_timeout_atomic() is the 
> fast path and we've exhausted the time we're willing to wait there if 
> we get -ETIMEDOUT.
> 
> The comment was intended as a description for the question posed by the 
> condition. It made sense in my head but maybe it's confusing more than 
> it is enlightening?
> 
> Andrew
> 
> >
> >> +                       if (rc == -ETIMEDOUT)
> >> +                               mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> >> +               } else {
> >>                         del_timer(&priv->obe.timer);
> >> +               }
> >>         }
> >>
> >>         if (mask & KCS_BMC_EVENT_TYPE_IBF) {
> >> --
> >> 2.34.1
> >>
