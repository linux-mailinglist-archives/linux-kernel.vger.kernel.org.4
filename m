Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E716611CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjAGV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjAGV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:28:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F3618B24;
        Sat,  7 Jan 2023 13:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gZ5XmGirc6FCl6ou2Qasr4G69KVXbpNVAED/n34XKmY=; b=GwYMpCxOsC5bIi02qz3OvrHrjM
        eFp7IWCI81rHwWO06k46VsOYFJrOZ0ht/tmsvIbYSoJke0COmGPPn5jemp3pNDRJRoCXBGKPODDtr
        tKOgo9ur1OaZPJv9kKsSe30Gq71u7lnUeRlTels09XTfftiYZqwPS+8P6345PZoEDXhSz++RKp0gH
        qtQooygv8hOtZMwmthUPlt47vLbOfe+QtjD43QndHSSGEQ3PYaozFVJyRodIwy6xf0lK+boHm21RY
        KaxIzchTGwDvij3zVMvNEU/OshVbeSnWPnn1UvAg+4oew+vtnKrcvSrqFDJgblJYFvZ8orUSX8+lW
        XVUB1hKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pEGjk-000X3D-06;
        Sat, 07 Jan 2023 21:28:20 +0000
Date:   Sat, 7 Jan 2023 21:28:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Henderson <rth@twiddle.net>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: fix FEN fault handling
Message-ID: <Y7nj80buxCO3u69l@ZenIV>
References: <Y7jD8XDZGnQkTvMI@ZenIV>
 <84c0d4ea-09e2-4907-d03d-939d40fa3c96@twiddle.net>
 <Y7jdARsEQXPugR0t@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7jdARsEQXPugR0t@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 02:46:26AM +0000, Al Viro wrote:

> Not sure it's worth bothering with in palcode-clipper - for Linux it's
> useless (run out of timeslice and FEN will end up set, no matter what),
> nothing in NetBSD or OpenBSD trees generates that call_pal, current
> FreeBSD doesn't support alpha and their last version to do so hadn't
> generated that call_pal either...  What else is out there?  OSF?

BTW, out of curiosity - what was
              case 5: /* illoc */
              default: /* unexpected instruction-fault type */
about in that switch in do_entIF()?

All documentation I'd been able to find had only 0..4 as expected
values (bpt/bugcheck/gentrap/fen/opdec)...
