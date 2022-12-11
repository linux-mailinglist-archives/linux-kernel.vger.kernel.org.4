Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991826493F9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLKLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiLKLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:41:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8CE1144D;
        Sun, 11 Dec 2022 03:41:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A4560DCE;
        Sun, 11 Dec 2022 11:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E4FC433D2;
        Sun, 11 Dec 2022 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670758864;
        bh=jUTEc3uGlq6adigpAK5Z3RLJdmVRR7w090wuCdCc8kQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpbdrPgubxN7CAs8cYB2Va0nlCvmdXA1ULduCLBxyMG9cV7JUyb51AziMxf7EqExP
         6mnkpc49Hbd4Lyff0kG+8ZsSHxBspHKxyeUki0X/ql6KY4nkE9PKkUvqSX4Yw+e0Jw
         sVrDWjzSSeiOpAfWN089Dtp4fCW3yvCilGIEt9B/TkAVEV31/5PVFgO5xj4Zf69P0r
         /2oU0sMZmnI7PMbBZHmzO0CYv7RIwcdZMuxGDrXB0lhWdPpUp4XO0XBzAGM3SV292p
         HI2dw0jNKq4Hwpl7rjTCQDboS+mpXzi1BoJW/H29l0jyiLbk7cqueBlv6QWBApNMF1
         JoXsSNxnqMxfA==
Date:   Sun, 11 Dec 2022 11:53:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, jiasheng@iscas.ac.cn, paul@crapouillou.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iio:adc:twl6030: Enable measurements of VUSB, VBAT and
 others
Message-ID: <20221211115358.19f547f2@jic23-huawei>
In-Reply-To: <20221204212751.2de52084@aktux>
References: <20221201181635.3522962-1-andreas@kemnade.info>
        <20221204154152.5f7948b9@jic23-huawei>
        <20221204212751.2de52084@aktux>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 21:27:51 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Sun, 4 Dec 2022 15:41:52 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu,  1 Dec 2022 19:16:35 +0100
> > Andreas Kemnade <andreas@kemnade.info> wrote:
> >   
> > > Some inputs need to be wired up to produce proper measurements,
> > > without this change only near zero values are reported.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>    
> > 
> > Sounds like a fix to me.  If so, Fixes tag?  
> 
> seems to be there since the beginning, to it would be
> Fixes: 1696f36482e70 ("iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver")
> 
> I think it was just not used with the charger (which is not in mainline yet),
> so it was probably ignored.
Makes sense.  I've applied it at marked it for stable on basis it wants the
fixes tag and would get picked up anyway + appears unlikely to have bad side effects.
> 
> > 
> > Anything in here we should be turning off again if the driver is removed 
> > or toggling on suspend? If not, other than the space below this looks fine to me.
> >   
> I would consider that as configuration, comparing with the nearest relative twl4030,
> there a similar bit is set in the probe() without disabling it in the remove().
> 
> But I think we should set TWL6030_GPADCR in remove() as we do in suspend(),
> but that is another fix.

There are always more fixes :)

Jonathan

> 
> Regards,
> Andreas

