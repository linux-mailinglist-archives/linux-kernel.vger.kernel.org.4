Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F5683398
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjAaRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjAaRRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:17:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3668568A3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:17:00 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pMuEv-0000k5-9M; Tue, 31 Jan 2023 18:16:13 +0100
Date:   Tue, 31 Jan 2023 18:16:13 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix NULL check for rcu pointer
Message-ID: <20230131171613.mubqpogkk5e6lnrk@viti.kaiser.cx>
References: <20230131090057.241779-1-martin@kaiser.cx>
 <Y9kvF0C1kiDctEUw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kvF0C1kiDctEUw@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg and all,

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> On Tue, Jan 31, 2023 at 10:00:57AM +0100, Martin Kaiser wrote:
> > Fix the NULL check for padapter->pnetdev->rx_handler_data.

> > The current code calls rcu_dereference while it holds the rcu read lock
> > and checks the pointer after releasing the lock. An rcu pointer may only be
> > used between calls to rcu_read_lock and rcu_read_unlock.

> > Replace the check with rcu_access_pointer. My understanding is that this
> > function returns the value of the pointer and needs no locking. We can
> > then check the pointer but we must not dereference it.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>

> What commit id does this fix?

the code that checks br_port has been around since the driver was
imported into staging.

If the patch is considered as a fix, it should have

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")

Best regards,

   Martin
