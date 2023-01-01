Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790365AA6C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjAAPlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjAAPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:41:09 -0500
Received: from ryne.moe (ryne.moe [157.90.134.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ECD71F4;
        Sun,  1 Jan 2023 07:41:04 -0800 (PST)
Received: from adrastea.localnet (unknown [170.55.83.2])
        by ryne.moe (Postfix) with ESMTPSA id 54B5C1900366;
        Sun,  1 Jan 2023 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redstrate.com;
        s=default; t=1672587663;
        bh=yuFQO/B9DLbhWgXBd8dhCFw3Fabkj++FF+sK5r52Idc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wasLQRFTkLpROUPjARpYn/k+HUyd0h89gZVzZM9KIrMnUUpdbNqRRJJt8cRmrbI8c
         +6q+a5h12CaxI8vysbzKKTPLRRtRHPjqlDVAgviRolkTi9CAfPxnNTmrASOCP0HVEC
         oC1cXCiKaBx3J16VcEUlb0ZjuB7CcQkmSqffY8DI=
From:   redstrate <josh@redstrate.com>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        kurikaesu@users.noreply.github.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Sun, 01 Jan 2023 10:40:59 -0500
Message-ID: <5985890.lOV4Wx5bFT@adrastea>
In-Reply-To: <Y7Gn4wVx3CgGYSeA@fedora>
References: <2068502.VLH7GnMWUR@adrastea> <3448509.5fSG56mABF@adrastea>
 <Y7Gn4wVx3CgGYSeA@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ah cool, then I guess we can remove the cases for "4" and "8"? I'd be
> nice to stick with decimal numbers in all cases for consistency.
> 

Oh yeah we totally could, I'm not sure why the double cases were there in the 
first place - it might have been for another device included in the original 
patch.

> 
> Also, buf[6] does not indicate the number of buttons (20?).
> 
> Did you check with Wireshark if the Windows driver is doing something
> different for your tablet? It'd be nice to avoid adding quirks but it
> might not be possible :S
> 
> We can ignore buf[12] and buf[14]. buf[0] indicates the size of the
> descriptor (12), so the last two bytes are random memory.
> 

I don't even think I have to drop into Windows, we have a userspace linux 
program for XP-PEN but I haven't tested it with this tablet yet. Yeah, I'd 
also like to avoid implementing device-specific quirks - hopefully I'll be able 
to shrink the init code but I might not be able to get rid of all of it. It's 
really weird that almost everything else (data frame wise) is the same, with 
the exception of init. And yes, this tablet contains 20 buttons and nothing in 
that buffer indicates button count :-/


