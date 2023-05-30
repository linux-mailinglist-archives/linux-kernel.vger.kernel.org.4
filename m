Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61EF71638F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjE3OSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjE3OR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BF6E41;
        Tue, 30 May 2023 07:17:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-974265a1a40so121981866b.0;
        Tue, 30 May 2023 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456241; x=1688048241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3S98eKsmu2BFFqj9FoRZCJ7VYZdqAy52J8ICuBM5wA=;
        b=ov8LXl4WkF1VfWNMmB1uQCeonT+IG1VR9wOt2IzJ8W57Woqmb7mPzeqwOfZFrcLAlq
         F6xqbA5iLqjZ5bueA2fd8kRnemFODCUKlZtljgpTtUBI4KRorV14PPLACw6QNMLl7uLQ
         asQKEeIAbcie0sEfwo5J6Dl5NLRhC/ghdvTUnJvDty3k3rXal3L6AhrPFwo4SaJ2HMhO
         VioOdC9Iw5uU0MzXeMc/68vOTzcZHHTrNrjGaNSNJ4p+/Yeguq+mkqFVUrEjbhd6MTsO
         rCWLdMQV05gAM9ldEKaNBBFPLYeXaDMhdsXqmkFQOSohIxWh26P3iIGlezxD152mQXYg
         PKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456241; x=1688048241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3S98eKsmu2BFFqj9FoRZCJ7VYZdqAy52J8ICuBM5wA=;
        b=VduUJQNB638FsKCfQng+7I0YeyoybfNeeOb17FudsLttezICCuWqhIKzp72qvVexRC
         Vz7t9yfPSBPVH6riCnj/0pjwIxGLJKHBObRyvzibODt4HUIgvfJhTnK8xoVYDfHkzlmU
         cKuqxXw2vkY9PpWWzFAJLgKirrats37WV22yubtUa8NR82oYKTchyIDEtjFLp1K/1eZ9
         9dJNVoFD398xcuMyzmf+oopwtAntoUDEhSYuSsnoAZ4RNsVjYcpHLBKZH7rqJzZ9niF/
         IQNvd8irJyNzlZVBATanGqnOm0W5iTrmzxb3Xdovk0zXzkSeaM0nuxYZ3BM2+cmhVcIg
         ODKQ==
X-Gm-Message-State: AC+VfDyfkOXjylX5il9lal2pp5xVyGrxD1IwL0pYTqKaJOlHxutATAcj
        DJqpqu03P3DSrcUuBcHt4IM=
X-Google-Smtp-Source: ACHHUZ5phJXRV21yCGp4Qg2DUt+RODu3VAOOjo2HgW2jQAGodKRI/nAcIr19GQgALEw/0XOG5xXkEg==
X-Received: by 2002:a17:907:940b:b0:96f:c545:6fd with SMTP id dk11-20020a170907940b00b0096fc54506fdmr10330494ejc.10.1685456240903;
        Tue, 30 May 2023 07:17:20 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:20 -0700 (PDT)
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
Subject: [PATCH v7 5/5] spi: spidev_test Add three missing spi mode bits
Date:   Tue, 30 May 2023 16:16:41 +0200
Message-Id: <20230530141641.1155691-6-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
References: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
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

