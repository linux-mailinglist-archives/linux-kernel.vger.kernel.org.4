Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4F70F227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbjEXJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbjEXJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:21:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D33195;
        Wed, 24 May 2023 02:20:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51426347bd2so521304a12.2;
        Wed, 24 May 2023 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920055; x=1687512055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3S98eKsmu2BFFqj9FoRZCJ7VYZdqAy52J8ICuBM5wA=;
        b=I2E8B+EExYp0Evh1Ei1iZTtTSQh2hhyTyS+CDeeLozxgHfeVVlRRYmGiQ5V4hFuzKl
         uD/IPQ2EdLmzKbl07uy3UnAvHmL6S3oyCBRgmHfNEB7djRY4uNW9Nj9ml29W9ym6/KhE
         KLICc43Cb7AqC27HvTK3/5jQdSZPg/6aq1AjjgAbIOd9RrHj3lrTm6V0FLhnQe2rAwdc
         Atk2hq3j+gnldy+Ati8DhBOUaJmvr3nT/00UKFC65JoCqaS0C3Coyh5wykzTOX4UqAs8
         ZxSldTIvhdbqYobVq8RVBA0L4Y4enKzndB2UlzLpSXT+xng63CUJOqZ5DlU/MBIGU0i0
         cvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920055; x=1687512055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3S98eKsmu2BFFqj9FoRZCJ7VYZdqAy52J8ICuBM5wA=;
        b=GaC5IbepcCjYxk6EJWJY1FSlIuSqR1R74Ak0E3OsiSR4qEYr8mN7z0MPys0hwWrpQL
         ENLcXaqz4ZKuQNlUQjXKuTevFAXzj+QYMnbTrULAWlM0zT5ld4w2Lr961aoFqkKTENdF
         LAldDaFExQpPs2jUINnuEzokurKZqr6y+cZIFwkJ3osZvzruKLrFZzuE+1Yy9ksQ9GZJ
         b5a0o3aw+2cVbQxmTCCE8M082yah3Kyv5mx/6Uzv8B836v30QqsnRQOHxIePfxkB+kYD
         jjWD4ph0Pknahaq3k2NXKN7dfh888q6T28CViQouPnBC+r2D1+rSpoeyd5ZYKfNmfv/n
         m01g==
X-Gm-Message-State: AC+VfDz3LT1SiX1j4V+uVQLn6+n4Hom0ZoBwpSSnWc4vv7ZOTavR83p7
        GSYa1ZYnho47G9vFM0yQIx8=
X-Google-Smtp-Source: ACHHUZ7se64qwjasCPMUqE0Jm/aXFla0NiRJTyI+0UtLKLFcLGR3R6dR9FfIqijKkIlUCdkXv5d8yA==
X-Received: by 2002:a17:906:4d8f:b0:94f:3bf7:dacf with SMTP id s15-20020a1709064d8f00b0094f3bf7dacfmr15858057eju.71.1684920055149;
        Wed, 24 May 2023 02:20:55 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:54 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] spi: spidev_test Add three missing spi mode bits
Date:   Wed, 24 May 2023 11:19:48 +0200
Message-Id: <20230524091948.41779-6-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524091948.41779-1-boerge.struempfel@gmail.com>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the three missing spi mode bits SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP,
and SPI_MOSI_IDLE_LOW.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 tools/spi/spidev_test.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 2d2cee339b39..9179942d7f15 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -172,7 +172,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDHILNORSbdilopsv]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilopsv]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
@@ -181,11 +181,13 @@ static void print_usage(const char *prog)
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
 		 "  -O --cpol           clock polarity\n"
+		 "  -F --rx-cpha-flip   flip CPHA on Rx only xfer\n"
 		 "number of wires for transmission:\n"
 		 "  -2 --dual           dual transfer\n"
 		 "  -4 --quad           quad transfer\n"
 		 "  -8 --octal          octal transfer\n"
 		 "  -3 --3wire          SI/SO signals shared\n"
+		 "  -Z --3wire-hiz      high impedance turnaround\n"
 		 "data:\n"
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
@@ -198,6 +200,7 @@ static void print_usage(const char *prog)
 		 "  -C --cs-high        chip select active high\n"
 		 "  -N --no-cs          no chip select\n"
 		 "  -R --ready          slave pulls low to pause\n"
+		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
 		 "misc:\n"
 		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
@@ -213,10 +216,12 @@ static void parse_opts(int argc, char *argv[])
 			{ "loop",          0, 0, 'l' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
+			{ "rx-cpha-flip",  0, 0, 'F' },
 			{ "dual",          0, 0, '2' },
 			{ "quad",          0, 0, '4' },
 			{ "octal",         0, 0, '8' },
 			{ "3wire",         0, 0, '3' },
+			{ "3wire-hiz",     0, 0, 'Z' },
 			{ "input",         1, 0, 'i' },
 			{ "output",        1, 0, 'o' },
 			{ "size",          1, 0, 'S' },
@@ -226,12 +231,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "cs-high",       0, 0, 'C' },
 			{ "no-cs",         0, 0, 'N' },
 			{ "ready",         0, 0, 'R' },
+			{ "mosi-idle-low", 0, 0, 'M' },
 			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -274,6 +280,15 @@ static void parse_opts(int argc, char *argv[])
 		case '3':
 			mode |= SPI_3WIRE;
 			break;
+		case 'Z':
+			mode |= SPI_3WIRE_HIZ;
+			break;
+		case 'F':
+			mode |= SPI_RX_CPHA_FLIP;
+			break;
+		case 'M':
+			mode |= SPI_MOSI_IDLE_LOW;
+			break;
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
-- 
2.40.1

