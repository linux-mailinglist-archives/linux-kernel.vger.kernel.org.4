Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6348E6632D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjAIVZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbjAIVYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:24:52 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47266101DA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:24:20 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pEzcr-0007gB-So; Mon, 09 Jan 2023 22:24:13 +0100
Date:   Mon, 9 Jan 2023 22:24:13 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] staging: r8188eu: make rtl8188eu_inirp_init a void
 function
Message-ID: <20230109212413.mcypwhpmtsj3rgj3@viti.kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
 <20230108185738.597105-7-martin@kaiser.cx>
 <ab4727b9-69c1-ba8d-38d8-6a3c721ba2aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab4727b9-69c1-ba8d-38d8-6a3c721ba2aa@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thus wrote Pavel Skripkin (paskripkin@gmail.com):

> Martin Kaiser <martin@kaiser.cx> says:

> > rtl8188eu_inirp_init's return value is not checked by its caller. Make
> > rtl8188eu_inirp_init a void function.

> Hm, shouldn't we actually check return value on caller side?

> This thing is called from netdev_open and issues urbs to read data from the
> device. So let's imagine that we fail on 1st iteration (for some reason):
> netdev_open() says all is OK, but driver does not communicate with the
> device.

your're right. It makes sense to relay the return value to _netdev_open.
We'd have to update/remove the intf_start pointer and usb_intf_start.

I'll resend the series without this patch and submit new patches for
relaying the error code.

Thanks & best regards,

   Martin
