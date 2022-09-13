Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709585B76AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIMQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIMQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:47:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FFDBD13F;
        Tue, 13 Sep 2022 08:41:21 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F1876601FFD;
        Tue, 13 Sep 2022 16:21:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663082507;
        bh=NUa1OR6r2YL7gqnNpqtAfFahv7FW51v7az7dmzd//2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mmg2KKuQgNfwZM4YmjTZs2YlfG3d64XkYl5FYOkjb8zFnmR/fYrb4lQY37gPz8cy5
         uwe25u0Jh15EpeNEoOiWdZF3QeeNbbri+AV2m5zUUew85xJIt2pfyWhc60h6RXpUrW
         LVpMXzEIxkQTTevmotPnYV2inYPafP+Wl055i6loL+Mh1SJIL1ODahKbEGh17ArxrT
         iQKWNvifQ883mm8eWQjF67vr9ivItdEWa5xFY6pyJ6C3SJBFEJ7QbZgJEzoEkRFsfI
         kAcTiFXIGkjcO+GwJYaemMX+DiuQpyQpWi9J2103ivv3t5yTNTG9IKh0zPSV45r9OJ
         fH+r3RkaKTDNg==
Received: by mercury (Postfix, from userid 1000)
        id 6E94C106084A; Tue, 13 Sep 2022 17:21:40 +0200 (CEST)
Date:   Tue, 13 Sep 2022 17:21:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     peng.fan@oss.nxp.com
Cc:     festevam@gmail.com, linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, marex@denx.de,
        mazziesaccount@gmail.com, mturquette@baylibre.com,
        peng.fan@nxp.com, sboyd@kernel.org, shawnguo@kernel.org,
        tharvey@gateworks.com
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Message-ID: <20220913152140.iikckob5h3ecagfi@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6njs6zsqbehlyas"
Content-Disposition: inline
In-Reply-To: <57b89f2e-dc70-9890-143c-f6da5aaba015@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6njs6zsqbehlyas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I had the same trouble before for QMX6 system on module, which feeds
the i.MX6 32k clock via I2C RTC's 32k output. Here is how it has
been solved upstream:

https://lore.kernel.org/all/20210428222953.235280-1-sebastian.reichel@collabora.com/

Patch 1 and patch 5 (look for "rtc_sqw") are relevant for this
specific issue. Discussion history is linked from the cover letter.

-- Sebastian

--d6njs6zsqbehlyas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMgn/gACgkQ2O7X88g7
+ppZ3w/8COoF/mtQh0ZKXTMdGaUv4W257a1AiVH61kU8s6d4+ud5HyNXrSBqSVw8
qbEyCvIIgLHHpTsanm+/k/WA5GQSy505Fa/EvPWQ+pcD6pOqgttDdERSNMPobSXl
UsJyEw2aUgBdHxrhMg03geb0VptS1QuOhgbqL5qRJ/Kel7EqhMnGF4v95f6BtX46
EhhdtkeO+tORGrFN0pISTz6IZjmUHg5MEHFKuVSV4ZRGD1dhTobfoEakV+JRJEOU
4SkhDTCwPaXHAxHTzuPv+vAQPyZhjPZl1gJA8Bi0qfOisydLNvnz4je99J3sx4ki
n4Twu8Q/r8TekWPUAxMTKTqWE81l33DR2hsF7Sb3EmIj8XN1NOmjQKhggqTwdB0j
xYSjDyEsmTUqFfvbg7OpZaJyyxwGQEpam6NCbwn5P8HwNiPFV9PrTuCyz2RrbvNT
voBHYTFj1Pd3eFuzMNWi6eOH20SjWhBvH7larbcr1jgMs+Px3ExxqPeaNnrknteY
ipTQcPaIIggG57FyeQO2A+O77aT+IfDGdbKwNnNz/YYihcUhoDi6fDUkpuTD6tEm
4snyhXrkNuu5394w4CKIs3wctQABXXmKY65GVRsVu3aooNtFMfdGsLgVvAss/CyK
uXlCo4ix8QjpNGFVLg25ECg4Nc1vzkpcrgc/CYuHCCK6MGz6/Qk=
=Yq+I
-----END PGP SIGNATURE-----

--d6njs6zsqbehlyas--
