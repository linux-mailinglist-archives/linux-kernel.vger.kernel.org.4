Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44923744BFB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 03:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGBBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGBBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 21:24:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BF1701728
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 18:24:16 -0700 (PDT)
Received: (qmail 1028027 invoked by uid 1000); 1 Jul 2023 21:24:15 -0400
Date:   Sat, 1 Jul 2023 21:24:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: r8a66597-hcd: host: fix port index underflow and
 UBSAN complains
Message-ID: <9e9a4e29-2507-41fe-b857-1bdb698fab76@rowland.harvard.edu>
References: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
 <20230701171648.orex7hx6jpkkpub3@pengutronix.de>
 <ad575ac5-fccb-4b1e-b6f4-26caa814414f@rowland.harvard.edu>
 <20230701221911.5mqh677uyhh2s67u@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230701221911.5mqh677uyhh2s67u@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 12:19:11AM +0200, Uwe Kleine-König wrote:
> Hello Alan,
> 
> On Sat, Jul 01, 2023 at 02:54:46PM -0400, Alan Stern wrote:
> > wIndex should never be == 0 or > max_root_hub in the cases where rh gets 
> > used; such values would be meaningless.  But we don't control the value 
> > of wIndex, because it can come from userspace.  So we can't simply 
> > assume it will always be valid; it has to be checked.
> > 
> > That being understood, the changes Zhang is making here are meant mostly 
> > to prevent UBSAN and the compiler from complaining or making false 
> > assumptions.  The actual checks on wIndex occur later in the subroutine.
> 
> I'm guilty of not having looked at all on that function, but it sounds
> wrong to me to calculate values from some untrusted input and only
> later validate the input. It should be the other way round, shouldn't
> it? This is calling for compiler optimisations stepping on your toes.

Six of one, half a dozen of the other.  In the end I don't think it 
makes much difference; it basically comes down to personal choice.  
Which is fine, provided the final choice is one of the correct ones.

Alan Stern
