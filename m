Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53328729A23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjFIMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjFIMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:36:17 -0400
X-Greylist: delayed 4195 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 05:36:15 PDT
Received: from mx02-sz.bfs.de (mx01-sz.bfs.de [194.94.69.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2018C;
        Fri,  9 Jun 2023 05:36:15 -0700 (PDT)
Received: from SRVEX01-MUC.bfs.intern (unknown [10.161.90.31])
        by mx02-sz.bfs.de (Postfix) with ESMTPS id D93582035C;
        Fri,  9 Jun 2023 10:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1686301034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQL6Xx7tBCSJf4MPKoKnpIlIJILrgf9XX+dLjaTtw4c=;
        b=Sr5UmuMUh1u2zY3oY4r+zC7ZXH+xVGLoYr30Y8ctLEWaupUXos8aN2M7p11/6rcs1nM+n9
        x3LFAmIvl/Xlr1xwT8K50mUcHAOzFod0qnDceplCNOEFCbM/Xl+zIjQxyh+yA8SvwKIPYY
        DDpAnvRIyIjBXEeauBv+dUANrhxlFJrkSUja5wTbTNmfhClty2ieSoZo7UEl5WZrbML9os
        VL4Z21GwnHJASLXa5HHawZ/bS7YVEtZBnQNssypPUMhamEl8kHC8/l62fQBqihB2ll3IX/
        X29mOmfV3N4zYsfGnf71N++3Vx0XcFsWFDaZ3MQvaAo1MKD3tm+nSbQum8os0A==
Authentication-Results: mx02-sz.bfs.de;
        none
Received: from SRVEX01-MUC.bfs.intern (10.161.90.31) by SRVEX01-MUC.bfs.intern
 (10.161.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Fri, 9 Jun
 2023 10:57:14 +0200
Received: from SRVEX01-MUC.bfs.intern ([fe80::e8ba:5ab1:557f:4aad]) by
 SRVEX01-MUC.bfs.intern ([fe80::e8ba:5ab1:557f:4aad%5]) with mapi id
 15.01.2507.023; Fri, 9 Jun 2023 10:57:14 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        "Kukjin Kim" <kgene.kim@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: AW: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Thread-Topic: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Thread-Index: AQHZmo1JZHtkpWXz3Ey2tC0FGDzZt6+CJSbA
Date:   Fri, 9 Jun 2023 08:57:14 +0000
Message-ID: <f31523d7270d4a1f82d96b7891ed13e6@bfs.de>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>,<93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <93bf8f574310256fcea50e5c5a62b5c37e20bb14.1686285892.git.christophe.jaillet@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.128.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_SOFTFAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spamd-Result: default: False [-18.00 / 7.00];
        WHITELIST_LOCAL_IP(-15.00)[10.161.90.31];
        BAYES_HAM(-3.00)[99.98%];
        MIME_GOOD(-0.10)[text/plain];
        RCVD_NO_TLS_LAST(0.10)[];
        MIME_TRACE(0.00)[0:+];
        RCVD_COUNT_TWO(0.00)[2];
        FROM_EQ_ENVFROM(0.00)[];
        NEURAL_HAM(-0.00)[-1.000];
        FREEMAIL_TO(0.00)[wanadoo.fr,linaro.org,samsung.com,linuxfoundation.org,kernel.org];
        MID_RHS_MATCH_FROM(0.00)[];
        RCPT_COUNT_TWELVE(0.00)[12];
        FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
        HAS_XOIP(0.00)[];
        TO_DN_EQ_ADDR_SOME(0.00)[];
        DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
        FROM_HAS_DN(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        TO_DN_SOME(0.00)[];
        ARC_NA(0.00)[]
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


while we are here ....

perhaps INT_MAX from kernel.h ?

int   deviation =3D (1 << 30) - 1;

the part before looks a bit strange

if (ourport->info->has_divslot) {
                        unsigned long div =3D rate / req_baud;

                        /* The UDIVSLOT register on the newer UARTs allows =
us to
                         * get a divisor adjustment of 1/16th on the baud c=
lock.
                         *
                         * We don't keep the UDIVSLOT value (the 16ths we
                         * calculated by not multiplying the baud by 16) as=
 it
                         * is easy enough to recalculate.
                         */

                        quot =3D div / 16;
                        baud =3D rate / div;
because
   baud=3Drate/rate/req_baud =3D req_baud
can this be simplyfied ? (or is the numeric required  ?)


Homebrew abs()  kernel.h has a abs() can we use it here ?

            if (calc_deviation < 0)
                        calc_deviation =3D -calc_deviation;

to the patch:

+                       /*
+                        * If we find a better clk, release the previous on=
e, if
+                        * any.
+                        */
+                       if (!IS_ERR(*best_clk))
+                               clk_put(*best_clk);

the intentions are good. *best_clk is user supplied (and should be NULL)
filled & released in the next round but IMHO must be valid (is clk).
so no need to check. (ntl clk_put seems to handle NULL and ERR )
   if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
                return;

JM2C
 wh
________________________________________
Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Gesendet: Freitag, 9. Juni 2023 06:45:39
An: Krzysztof Kozlowski; Alim Akhtar; Greg Kroah-Hartman; Jiri Slaby; Thoma=
s Abraham; Kukjin Kim
Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christop=
he JAILLET; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.ke=
rnel.org; linux-serial@vger.kernel.org
Betreff: [PATCH 2/2] tty: serial: samsung_tty: Fix a memory leak in s3c24xx=
_serial_getclk() when iterating clk

When the best clk is searched, we iterate over all possible clk.

If we find a better match, the previous one, if any, needs to be freed.
If a better match has already been found, we still need to free the new
one, otherwise it leaks.

Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup"=
)
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Review with care.

I think that some clk_put() are also missing somewhere else in the driver
but won't be able to investigate further.
---
 drivers/tty/serial/samsung_tty.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_=
tty.c
index dd751e7010e3..c07877dd25fa 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1488,10 +1488,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3=
c24xx_uart_port *ourport,
                        calc_deviation =3D -calc_deviation;

                if (calc_deviation < deviation) {
+                       /*
+                        * If we find a better clk, release the previous on=
e, if
+                        * any.
+                        */
+                       if (!IS_ERR(*best_clk))
+                               clk_put(*best_clk);
                        *best_clk =3D clk;
                        best_quot =3D quot;
                        *clk_num =3D cnt;
                        deviation =3D calc_deviation;
+               } else {
+                       clk_put(clk);
                }
        }

--
2.34.1

