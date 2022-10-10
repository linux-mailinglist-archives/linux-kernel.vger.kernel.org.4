Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2C5FA293
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJJRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJJRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:17:12 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2BB74DFF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:17:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id C90BB2015F;
        Mon, 10 Oct 2022 19:17:07 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JDNmcF0NPE6w; Mon, 10 Oct 2022 19:17:07 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 61F9A2011C;
        Mon, 10 Oct 2022 19:17:07 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1ohwOo-006OrU-36;
        Mon, 10 Oct 2022 19:17:06 +0200
Date:   Mon, 10 Oct 2022 19:17:06 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mushahid Hussain <mushi.shar@gmail.com>, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speakup: fix a segfault caused by switching consoles
Message-ID: <20221010171706.7omuxueiuyqugjha@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mushahid Hussain <mushi.shar@gmail.com>, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20221010165720.397042-1-mushi.shar@gmail.com>
 <Y0RQNt80BnQjozZC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0RQNt80BnQjozZC@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH, le lun. 10 oct. 2022 19:02:46 +0200, a ecrit:
> On Mon, Oct 10, 2022 at 09:57:20PM +0500, Mushahid Hussain wrote:
> > This patch fixes a segfault by adding a null check on synth in
> > speakup_con_update(). The segfault can be reproduced as follows:
> > 
> > 	- Login into a text console
> > 
> > 	- Load speakup and speakup_soft modules
> > 
> > 	- Remove speakup_soft
> > 
> > 	- Switch to a graphics console
> > 
> > This is caused by lack of a null check on `synth` in
> > speakup_con_update().
> > 
> > Here's the sequence that causes the segfault:
> > 
> > 	- When we remove the speakup_soft, synth_release() sets the synth
> > 	  to null.
> > 
> > 	- After that, when we change the virtual console to graphics
> > 	  console, vt_notifier_call() is fired, which then calls
> > 	  speakup_con_update().
> > 
> > 	- Inside speakup_con_update() there's no null check on synth,
> > 	  so it calls synth_printf().
> > 
> > 	- Inside synth_printf(), synth_buffer_add() and synth_start(),
> > 	  both access synth, when it is null and causing a segfault.
> > 
> > Therefore adding a null check on synth solves the issue.
> > 
> > Signed-off-by: Mushahid Hussain <mushi.shar@gmail.com>
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  drivers/accessibility/speakup/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What commit id does this fix?

It is there since 2610df41489f548e235171b86895d4b49e6acb1f
("staging: speakup: Add pause command used on switching to graphical
mode")

> Should it go to stable kernels?

Yes, please.

Mushahid, you can see in Documentation/process/submitting-patches.rst
how to encode this in the patch submission.

Samuel
