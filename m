Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAB969C794
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBTJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBTJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:20:55 -0500
X-Greylist: delayed 39791 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 01:20:50 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A1C168;
        Mon, 20 Feb 2023 01:20:50 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CCC12100D9401;
        Mon, 20 Feb 2023 10:20:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A54F036B4A; Mon, 20 Feb 2023 10:20:48 +0100 (CET)
Date:   Mon, 20 Feb 2023 10:20:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230220092048.GA25532@wunner.de>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
 <20230218132007.3350-5-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218132007.3350-5-orlandoch.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 12:20:06AM +1100, Orlando Chamberlain wrote:
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -28,15 +28,17 @@
>   * DOC: Overview
>   *
>   * gmux is a microcontroller built into the MacBook Pro to support dual GPUs:
> - * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on retinas.
> + * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2 retinas.
> + * The chip used on T2 Macs is not known.

I've just taken a look at the schematics of the MBP16,1 and it turns out
that T2 *is* the gmux.  The chip is called H9M.  The interaction with the
OS is through that MMIO area.

There's a GPIO expander attached to T2 via I2C (NXP PCAL6524), probably
because they didn't have enough GPIO pins available on T2 itself.
The GPIO expander enables/disables the voltage regulators of the discrete
GPU, hence can cut power to it.  It also drives panel power and has a GPIO
to switch the mux.

The mux is an NXP CBTL06142 as on previous models.

Thanks,

Lukas
