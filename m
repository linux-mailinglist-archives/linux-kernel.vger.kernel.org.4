Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB47722DED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFERxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFERxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:53:19 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C36CD3;
        Mon,  5 Jun 2023 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5wQ79+3ie9B5Wrf6oahpgoNv8SQzC2LUU6mondumang=; b=bXDrMcbEpmir14t0N38XT0dSXa
        ZS/kN+n+usAnHqQbCP7yZ799X4vnucRbXKhw5Dv/J8oaB5mLRqrvxeqU7st7Sh6AOdehTEwz6QFaz
        Yj355uOAGg1LjUCYJ5twy3gf8jTLvUtxEXZePBJ1RQvY4gc86ckTL1q8Ow9RjIMvabRQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41322 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q6EOA-0001lv-Ku; Mon, 05 Jun 2023 13:53:07 -0400
Date:   Mon, 5 Jun 2023 13:53:05 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Message-Id: <20230605135305.918dd2b2a88912fbb28e8fbb@hugovil.com>
In-Reply-To: <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
        <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
        <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
        <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2023 22:31:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 4, 2023 at 8:45 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Sun, 4 Jun 2023 14:57:31 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > > On Sun, Jun 4, 2023 at 10:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:
> > >
> > > ...
> > >
> > > > > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
> > > >
> > > > This returns what, mctrl?  If so, please document that, it doesn't look
> > > > obvious.
> > >
> > > Good suggestion. Because I also stumbled over the returned type.
> > >
> > > >  And as the kernel test robot reported, you do nothing with the
> > > > return value so why compute it?
> > >
> > > It seems that the entire function and respective call has to be moved
> > > under #ifdef CONFIG_GPIOLIB.
> >
> > Hi,
> > it cannot. See my explanations in response to Greg's comments.
> 
> Then as Greg suggested, store in the structure and make this function
> to return an error code (with int), with this amendment you don't need
> to add a comment about the returned variable anymore.

Hi,
Yes, that is what I have done for V8. Simplifies/clean things a lot.

Hugo.
