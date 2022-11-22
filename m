Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2F63378A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiKVIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiKVIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:47 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71995558E;
        Tue, 22 Nov 2022 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669107165; x=1700643165;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NJKojUVVwfNiBj6nGyV2BiX29XXsfamg3FpOm3EoRFg=;
  b=Gt3LBIz9oHgyzomZwcxeqav31aVyo6XiXNPK+XKmS61/rcy/b2FgBFvl
   A1OIWRl+Wt2PafYKJsyiisBVfpl63hNiXhMPZ6D6pi4eLjg/iumGvmgMJ
   5FV+6yDLUqO2hDePwzTVGR9L/gIycojND194Ud/1FHEq5ZP8w4AbZyqr/
   G+Gm2vCiE7nMwZ/Pw3ENJ3Dv4YG2g7Itueiz64sQJKFtMlLIs++as7MhX
   6K3phmMrUNqpUbkJ9814Mi0OgukDtYGHBHebYMiJf4Rh7mgYbYCl1sq8U
   0lKHoOHXTNVLCwvlg/+ixRmLMmNnZEudvqxtd9rkrfS0nHm2gkEjoNymp
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665439200"; 
   d="scan'208";a="27501948"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Nov 2022 09:52:42 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 22 Nov 2022 09:52:42 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 22 Nov 2022 09:52:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669107162; x=1700643162;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NJKojUVVwfNiBj6nGyV2BiX29XXsfamg3FpOm3EoRFg=;
  b=HXl9zXP+aCc45pS/jaSoSRLNYYPTiNQqVUhyQLLm9f9eVdXTBT/H9XrL
   vVkOBVA3TiO5wbRe/1R3qQEPV+0DkrPsvS86zvlnQoV4RYy3Svzlb5flV
   7iSi+/KwWNSkmlCH2qF/wZIxvTb59iVbiNwtJWFyM2cVn9WFMmwBW0tuI
   mNvgDfLhvKC3iFio1hwh4H9jqx3u6opOequa7edR0CsddIIRdMNSVBX8p
   XqlxOm1gFKmz2VQr9q1a6OKow3Avg7xriBQJRh4LpfRJ5NgWVIW3qB8Jh
   ZuEVdW6Gb843ST4sclTMrDWeLFJLg37uaBEq9S1lz1VbEjOZDqM+kT7rf
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665439200"; 
   d="scan'208";a="27501947"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Nov 2022 09:52:42 +0100
Received: from [192.168.2.129] (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 52450280056;
        Tue, 22 Nov 2022 09:52:42 +0100 (CET)
Message-ID: <bce6407bc42eeec8f459f09bc1326761327c98ec.camel@ew.tq-group.com>
Subject: Re: 8250_omap: incorrect RS485 RTS on close during transmission
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 09:52:40 +0100
In-Reply-To: <f7cf39a9c152031a09608a68115e32988617f626.camel@ew.tq-group.com>
References: <f7cf39a9c152031a09608a68115e32988617f626.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-18 at 12:57 +0100, Matthias Schiffer wrote:
> Hi Lukas,
>=20
> I've discovered a new issue with EM485 in 8250_omap (and probably other
> serial drivers as well?): When closing the TTY device while there is
> still an ongoing transmission, the RTS pin will get stuck active until
> the TTY is opened again. This can be easily reproduced by running `cat
> /dev/zero > /dev/ttySx` and then stopping it using Ctrl-C.
>=20
> The issue exists in current mainline (6.1-rc5+), and applying "serial:
> 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()" from next
> doesn't solve it. I think it should work with "serial: 8250: 8250_omap:
> Support native RS485", but we also need RS485 on AM57xx CPUs, which
> don't have native RS485.
>=20
> I intend to look into this myself next week, but as you've worked on
> this code a lot lately, maybe you already have an idea how to fix it?
>=20
> Regards,
> Matthias
>=20

Okay, I've narrowed down the issue to uart_shutdown() ->
uart_port_shutdown() - here, ops->shutdown() is called, which clears
the FIFOs (in the case of the default 8250_port and 8250_omap)
implementations, but doesn't wait for the clear to finish, and doesn't
call ops->stop_tx().

I believe a similar problem can occur in uart_suspend_port(). Here,
ops->stop_tx() is called before ops->shutdown(), but stop_tx() is a no-
op when the TX FIFO is not empty (again, for the 8250 case - I haven't
really looked at other drivers).

Given that EM485 is handled in 8250_port by __stop_tx(), which is
called both internally in the 8250 driver and from the serial core
through stop_tx(), it is not clear to me what the correct layer to fix
this is. Two ideas:

(1) Have ops->shutdown() wait until the TX FIFO is empty. Call
ops->stop_tx() after ops->shutdown() in serial core. For this to work,
calling stop_tx() after shutdown() must be allowed in all drivers; I'm
not sure if this is currently the case, and if it is desirable at all.

(2) Do the whole handling in the driver's ops->shutdown(), do not
further involve the serial core.

So far, I've implemented (1) locally for 8250_omap, and together with
"serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()" it
fixes the issue on my test devices, but I'm not too happy about the
"shutdown then tx_stop" order of calls. So maybe (2) is the better
solution after all?
