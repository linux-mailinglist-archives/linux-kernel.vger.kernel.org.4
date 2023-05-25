Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C97111F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbjEYRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEYRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:21:09 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A49195;
        Thu, 25 May 2023 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=b9Zte/1jFhBuFVD5ydCZfQdpJv9ttP11KPikJhqUxls=; b=AXPlcTFdx9qZlDVeR7WrLfgkZR
        8oVfKSuX/aewdBSKXqeOW5wDnFjnzXEBBjxe3iBNWEJIRhEks7aVeUdNTuQ1f8p5GJmNNBpbyYKBs
        uIhxlpQX3BKTy18j4WJTm8XESWyN0IgKrCbhaWZ3nLuV0jkYWZ8yVdXaizUb7TZWcL+g=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50040 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Edr-0001iA-0O; Thu, 25 May 2023 13:20:54 -0400
Date:   Thu, 25 May 2023 13:20:46 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525132046.6c48f2fd9235215f01238a04@hugovil.com>
In-Reply-To: <20230525113145.35cef67328b63ba4239d2361@hugovil.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-10-hugo@hugovil.com>
        <ZG9FBgX2useVeuWl@surfacebook>
        <20230525113145.35cef67328b63ba4239d2361@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 09/11] serial: sc16is7xx: add I/O register
 translation offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 11:31:45 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Thu, 25 May 2023 14:22:46 +0300
> andy.shevchenko@gmail.com wrote:
> 
> > Thu, May 25, 2023 at 12:03:23AM -0400, Hugo Villeneuve kirjoitti:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > If the shared GPIO pins on a dual port/channel variant like the
> > > SC16IS752 are configured as GPIOs for port A, and modem control lines
> > > on port A, we need to translate the Linux GPIO offset to an offset
> > > that is compatible with the I/O registers of the SC16IS7XX (IOState,
> > > IODir and IOIntEna).
> > > 
> > > Add a new variable to store that offset and set it when we detect that
> > > special case.
> > 
> > ...
> > 
> > > +/*
> > > + * We may need to translate the Linux GPIO offset to a SC16IS7XX offset.
> > > + * This is needed only for the case where a dual port variant is configured to
> > > + * have only port B as modem status lines.
> > > + *
> > > + * Example for SC16IS752/762 with upper bank (port A) set as GPIOs, and
> > > + * lower bank (port B) set as modem status lines (special case described above):
> > > + *
> > > + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> > > + * name        function     offset         offset
> > > + * --------------------------------------------------
> > > + * GPIO7/RIA    GPIO7          3              7
> > > + * GPIO6/CDA    GPIO6          2              6
> > > + * GPIO5/DTRA   GPIO5          1              5
> > > + * GPIO4/DSRA   GPIO4          0              4
> > > + * GPIO3/RIB    RIB           N/A            N/A
> > > + * GPIO2/CDB    CDB           N/A            N/A
> > > + * GPIO1/DTRB   DTRB          N/A            N/A
> > > + * GPIO0/DSRB   DSRB          N/A            N/A
> > > + *
> > > + * Example  for SC16IS750/760 with upper bank (7..4) set as modem status lines,
> > 
> > Single space is enough.
> 
> Fixed.
> 
>  
> > > + * and lower bank (3..0) as GPIOs:
> > > + *
> > > + * Pin         GPIO pin     Linux GPIO     SC16IS7XX
> > > + * name        function     offset         offset
> > > + * --------------------------------------------------
> > > + * GPIO7/RI     RI            N/A            N/A
> > > + * GPIO6/CD     CD            N/A            N/A
> > > + * GPIO5/DTR    DTR           N/A            N/A
> > > + * GPIO4/DSR    DSR           N/A            N/A
> > > + * GPIO3        GPIO3          3              3
> > > + * GPIO2        GPIO2          2              2
> > > + * GPIO1        GPIO1          1              1
> > > + * GPIO0        GPIO0          0              0
> > > + */
> > 
> > Wondering if you can always register 8 pins and use valid mask to define which
> > one are in use?
> 
> I will look into it, I think it may be a good idea and could help to simplify things a bit.

Hi,
finally, this was the way to go. The resulting code/patch is much simpler and elegant this way. Thank you for the suggestion.

I will submit a V4 with all the changes.

Hugo.
