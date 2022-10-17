Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E616009EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJQJI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJQJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:08:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217DCC8;
        Mon, 17 Oct 2022 02:08:44 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:08:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665997722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3cvKWVDDXmSC/pi5fBn4+ZGRH5VYnyrxLgb7Uzgxnw=;
        b=nf2GJcpJytL/HFwfwuN82XbcEzOosVAqnmQbT+Ti4SBMWOLv89ns9xs5skIC8ffgnkNwTW
        XWJEnJkzFU6di9yby4JjM8SC4NAl9HveO149uSp+8Zwk5Kf/78x32SMPoizA6eem4tMP7u
        9sd9i5WklPNxXGaAhQLSA1dHXyk/G1/xUfqMc70l6M9ZxjgcBEo9oqIZjRxgbTjnH89G1A
        v0L+azazxFRfX+NZ9AGh/bNL4AwLSOHiyEKTmJzIFPjBDwEqI5cPeOZQme/JwvC7qqm1+R
        zjMwAjknyBX/JXMy9jP1qvrHkwtB+xAPXJAOYlTtWpy1/XsccYZOOwaA+pzIWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665997722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3cvKWVDDXmSC/pi5fBn4+ZGRH5VYnyrxLgb7Uzgxnw=;
        b=Yr3px8mYGxJLV1EKNFbqUB2b3sGLhUz+mXR7RE3LdlJEq1bIDVrI2qmGis6BspKYYa9vMd
        yxzw1E8yz7q20cCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_omap: remove wait loop from Errata i202
 workaround
Message-ID: <Y00bmec4hvWxtnB5@linutronix.de>
References: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
 <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-17 11:12:41 [+0300], Ilpo J=C3=A4rvinen wrote:
> On Thu, 13 Oct 2022, Matthias Schiffer wrote:
>=20
> > We were occasionally seeing the "Errata i202: timedout" on an AM335x
> > board when repeatedly opening and closing a UART connected to an active
> > sender. As new input may arrive at any time, it is possible to miss the
> > "RX FIFO empty" condition, forcing the loop to wait until it times out.
>=20
> I can see this problem could occur and why your patch fixes it.
>=20
> > Nothing in the i202 Advisory states that such a wait is even necessary;
> > other FIFO clear functions like serial8250_clear_fifos() do not wait
> > either. For this reason, it seems safe to remove the wait, fixing the
> > mentioned issue.
>=20
> Checking the commit that added this driver and the loop along with it,=20
> there was no information why it would be needed there either.

I don't remember all the details but I do remember that I never hit it.
The idea back then was to document what appears the problem and then
once there is a reproducer address it _or_ when there is another problem
check if it aligns with the output here (so that _this_ problem's origin
could be this). This was part of address all known chip erratas and
copied from omap-serial at the time so that the 8250 does not miss
anything.
Looking closer, this is still part of the omap-serial driver and it was
introduced in commit
   0003450964357 ("omap2/3/4: serial: errata i202: fix for MDR1 access")

If someone found a way to trigger this output which is unrelated to the
expected cause then this is clearly not helping nor intended.

I would prefer to keep the loop and replace the disturbing output with a
comment describing _why_ the FIFO might remain non-empty after a flush.

In worst cases that loop causes a delay of less than 0.5ms while setting
a baud rate so I doubt that this is causing a real problem.

Either way I would like to see Tony's ACK before this is getting removed
as suggested in this patch.

> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Thanks.

Sebastian
