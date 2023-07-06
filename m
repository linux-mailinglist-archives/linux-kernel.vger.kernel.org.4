Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0154974A48B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGFTtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGFTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:49:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4C1BEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E2gzTkf0PtkXeEQW8FKB5ymf4Nj8iv6XCGSy6pM3Cug=; b=E3ycVKWA+dZ0D9c8Dsum8/ZKcC
        68dcNObmqGRU9lNcD5uU4oMcvNEDJl/Ij7/0V0ZZsCAjVh+ssNhSIUf47wWL5IZmtpI7CdOokMTxi
        hfm4WlVKzNjxVivL6ycN0lwk70QL56IgBikYwZYjQzDBj0/RhhwAIuLdWTI5fC0cdYzU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:46308 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qHUyw-0003Gs-21; Thu, 06 Jul 2023 15:49:38 -0400
Date:   Thu, 6 Jul 2023 15:49:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, Lars Poeschel <poeschel@lemonage.de>,
        geert@linux-m68k.org
Message-Id: <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
In-Reply-To: <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
References: <20230706185100.84322-1-hugo@hugovil.com>
        <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear
 display command
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 21:33:05 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Thu, Jul 6, 2023 at 8:51 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > The "clear display" command on the NewHaven NHD-0220DZW-AG5 display
> > does NOT change the DDRAM address to 00h (home position) like the
> > standard Hitachi HD44780 controller. As a consequence, the starting
> > position of the initial string LCD_INIT_TEXT is not guaranteed to be
> > at 0,0 depending on where the cursor was before the clear display
> > command.
> >
> > Extract of CLEAR_DISPLAY command from datasheets of:
> >
> >     Hitachi HD44780:
> >         ... It then sets DDRAM address 0 into the address counter...
> >
> >     NewHaven NHD-0220DZW-AG5 datasheet:
> >         ... This instruction does not change the DDRAM Address
> >
> > Move the cursor home after sending clear display command to support
> > non-standard LCDs.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thanks! Sounds good to me, as long the extra command does not
> introduce some issue with the actual HD44780 -- can we double-check
> the HD44780 still works as expected?
> 
> Cc'ing Lars and Geert since they may be able to give it a quick test.

Hi Miguel,
I do not have a standard Hitachi controller to test it on, so lets wait
for feedback from Lars and Geert or others.

> > +       /*
> > +        * Some LCDs (ex: NewHaven) do not reset the DDRAM address when
> > +        * executing the CLEAR_DISPLAY command. Explicitely move cursor
> > +        * to home position to account for these non-standard LCDs:
> > +        */
> > +       return hd44780_common_home(lcd);
> 
> Few nits:
> 
>   - Explicitely -> Explicitly.
>   - Isn't the command `DISPLAY_CLEAR` instead of `CLEAR_DISPLAY`? (at
> least the identifier above is `LCD_CMD_DISPLAY_CLEAR`).

Yes, I have also modified the commit log message to be consistent with
the code.

>   - `:` -> `.`.
> What about something like:
> 
>     The Hitachi HD44780 controller (and compatible ones) reset the
> DDRAM address when executing the `DISPLAY_CLEAR` command, thus the
> following call is not required. However, other controllers do not
> (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> unconditionally to support both.

Ok, changed comments to that.

Thank you,
Hugo.
