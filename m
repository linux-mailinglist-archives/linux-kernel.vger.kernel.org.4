Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C3645559
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLGIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:21:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C16576
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED349B815D4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453F2C433C1;
        Wed,  7 Dec 2022 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670401281;
        bh=AHYARf/KLi6/VS3V2qrLnnBM6L3OOASJ3QfbNSJr3v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZGIe60FWKXP45dBXICPi7LeOroY6MUvczqbZPpmq6lSJAK4VPWND04yyHI0Yb7Uh
         SOIfA8o9Qc6g1DtF5JGJAYNoO2o5ZiVbKk25gzRtGa7G2lVGqOo0xadjhjmxib97r/
         DnZwJSXcI12HjJPRHr0Ad/twnSiAc7SSnNbfWjhM=
Date:   Wed, 7 Dec 2022 09:21:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] VT: Add height parameter to con_font_get/set consw
 operations
Message-ID: <Y5BM/q4K2a9V6SvR@kroah.com>
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.751605665@ens-lyon.org>
 <27ade063-79df-dad9-0427-e16f1ddb43ef@kernel.org>
 <20221206203947.5yifmkntf4uy7lt6@begin>
 <fa5d6cbc-8f83-9e41-0513-adcb32422d2f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa5d6cbc-8f83-9e41-0513-adcb32422d2f@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 08:39:18AM +0100, Jiri Slaby wrote:
> On 06. 12. 22, 21:39, Samuel Thibault wrote:
> > Jiri Slaby, le mar. 06 déc. 2022 07:40:30 +0100, a ecrit:
> > > On 05. 12. 22, 1:07, Samuel Thibault wrote:
> > > > --- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
> > > > +++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> > > ...
> > > > @@ -1268,7 +1271,7 @@ sisusbcon_font_get(struct vc_data *c, st
> > > >    	}
> > > >    	/* Copy 256 chars only, like vgacon */
> > > > -	memcpy(font->data, sisusb->font_backup, 256 * 32);
> > > > +	memcpy(font->data, sisusb->font_backup, 256 * height);
> > > 
> > > Have you tested this?
> > 
> > Ah, no, I had assumed that this was for a specific arch. But actually I
> > wasn't getting it because it depends on BROKEN.
> 
> Hmm, for two years... I will remove the con support completely next week if
> noone beats me to it.

If you do it this week we can get it into 6.2 :)

