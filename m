Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB38570AAA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjETTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjETTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:09:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A9FB;
        Sat, 20 May 2023 12:09:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f7bf29550so233695566b.3;
        Sat, 20 May 2023 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609765; x=1687201765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxu/hN/yK7OupNfwRZcHuiPf8qpTU+y9P6Uuv9Z+8+k=;
        b=fI8cbEpZa+OoKwzjyrGPjKaOFq3Lq7USodXSV/3C+uJTowv8BGnn543SNz5+7Kkiwz
         NabcaqAofjndqfnHRA4Dq4lm3iJjBPTuSieYEhnseD+Z4y7wlJaLYB/ypZaclnX6EbVx
         IqSt9rfXj7PWLXzapc9fehES/xzM8QX0Wh7UnFOI7P9Eh4+BWOESjvRg9iSceK7FwFvU
         L2Vcq2X4kQhzGrjP+JvAG8D/kahtaDk4jWniGsdi3IpW04njFz+1+LPY6h1yB1ZMWw+j
         daIHObvkPSmbRzu/sFTh/DDPnGrrYbktJLGMstLBWLAJikjhxAMz5PshgupdSVc4koh0
         HvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609765; x=1687201765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxu/hN/yK7OupNfwRZcHuiPf8qpTU+y9P6Uuv9Z+8+k=;
        b=JB0BdC+Bb5CYfY9w/yXuqDzJbVgJNwFJuwDgoTKy3iwIonIrstqNs3i+G41enr9l2a
         lirjIQEwhIE2jPrlkL+Ro0c8pD20SORwcWAG+RpT+QHhiuqXJExNbXHkYEh1/S9PUOsV
         DbPWSjG6tItKrXdV0Fzlq82c9gStwbO0fAuqLV6XCTOKls9OSpdfZuDF7iswp42BBPzF
         Zl5nStMNVSstKeGnyAlWHmj/scbaUQxL+OoN67abNGH4BGrbEef6NqylKfYx4bk/keUo
         i47qizrU8gJU1bvs2k4mK8CG8hOMOcJucvUi+E08ZCKgRaY89NCheRVgy/QbGiP/d4LM
         CXaQ==
X-Gm-Message-State: AC+VfDxgiNZ/qxcQUQHvg3c62Hb2l2vV0wrUZMhdDnuQrd5CZrOLpVTX
        OiGbTXK8vVCHPrdZlfDFP8kDwR7Ju8ouDtMu
X-Google-Smtp-Source: ACHHUZ7s03mDt2dM5b8wIGEec+Qgu4rxkO5o3ziWSbAfs/ZsSJ2/+Reu1b5H8B/isfZs0YyNS9z7NA==
X-Received: by 2002:a17:906:5d04:b0:96a:8412:a44d with SMTP id g4-20020a1709065d0400b0096a8412a44dmr5353078ejt.36.1684609764743;
        Sat, 20 May 2023 12:09:24 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900cb504b662390cd6b.dip0.t-ipconnect.de. [2003:c7:8700:c900:cb50:4b66:2390:cd6b])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm1065889edb.64.2023.05.20.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 12:09:24 -0700 (PDT)
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
Subject: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
Date:   Sat, 20 May 2023 21:08:55 +0200
Message-Id: <20230520190856.34720-5-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520190856.34720-1-boerge.struempfel@gmail.com>
References: <20230520190856.34720-1-boerge.struempfel@gmail.com>
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
and SPI_MOSI_IDLE_LOW. Due to the length of the new options, the
indentation of the options in the help message was also adjusted for all
other options.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 tools/spi/spidev_test.c | 101 +++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index b0ca44c70e83..66bfe90c541e 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -172,28 +172,31 @@
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-DsbdlHOLC3vpNR24SI]\n", prog);
-	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
-	     "  -s --speed    max speed (Hz)\n"
-	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word\n"
-	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
-	     "  -o --output   output data to a file (e.g. \"results.bin\")\n"
-	     "  -l --loop     loopback\n"
-	     "  -H --cpha     clock phase\n"
-	     "  -O --cpol     clock polarity\n"
-	     "  -L --lsb      least significant bit first\n"
-	     "  -C --cs-high  chip select active high\n"
-	     "  -3 --3wire    SI/SO signals shared\n"
-	     "  -v --verbose  Verbose (show tx buffer)\n"
-	     "  -p            Send data (e.g. \"1234\\xde\\xad\")\n"
-	     "  -N --no-cs    no chip select\n"
-	     "  -R --ready    slave pulls low to pause\n"
-	     "  -2 --dual     dual transfer\n"
-	     "  -4 --quad     quad transfer\n"
-	     "  -8 --octal    octal transfer\n"
-	     "  -S --size     transfer size\n"
-	     "  -I --iter     iterations\n");
+	printf("Usage: %s [-DsbdlHOLC3ZFMvpNR24SI]\n", prog);
+	puts("  -D --device         device to use (default /dev/spidev1.1)\n"
+	     "  -s --speed          max speed (Hz)\n"
+	     "  -d --delay          delay (usec)\n"
+	     "  -b --bpw            bits per word\n"
+	     "  -i --input          input data from a file (e.g. \"test.bin\")\n"
+	     "  -o --output         output data to a file (e.g. \"results.bin\")\n"
+	     "  -l --loop           loopback\n"
+	     "  -H --cpha           clock phase\n"
+	     "  -O --cpol           clock polarity\n"
+	     "  -L --lsb            least significant bit first\n"
+	     "  -C --cs-high        chip select active high\n"
+	     "  -3 --3wire          SI/SO signals shared\n"
+		 "  -Z --3wire-hiz      high impedance turnaround\n"
+		 "  -F --rx-cpha-flip   flip CPHA on Rx only xfer\n"
+		 "  -M --mosi-idle-low  leave mosi line low when idle\n"
+	     "  -v --verbose        Verbose (show tx buffer)\n"
+	     "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
+	     "  -N --no-cs          no chip select\n"
+	     "  -R --ready          slave pulls low to pause\n"
+	     "  -2 --dual           dual transfer\n"
+	     "  -4 --quad           quad transfer\n"
+	     "  -8 --octal          octal transfer\n"
+	     "  -S --size           transfer size\n"
+	     "  -I --iter           iterations\n");
 	exit(1);
 }
 
@@ -201,31 +204,34 @@ static void parse_opts(int argc, char *argv[])
 {
 	while (1) {
 		static const struct option lopts[] = {
-			{ "device",  1, 0, 'D' },
-			{ "speed",   1, 0, 's' },
-			{ "delay",   1, 0, 'd' },
-			{ "bpw",     1, 0, 'b' },
-			{ "input",   1, 0, 'i' },
-			{ "output",  1, 0, 'o' },
-			{ "loop",    0, 0, 'l' },
-			{ "cpha",    0, 0, 'H' },
-			{ "cpol",    0, 0, 'O' },
-			{ "lsb",     0, 0, 'L' },
-			{ "cs-high", 0, 0, 'C' },
-			{ "3wire",   0, 0, '3' },
-			{ "no-cs",   0, 0, 'N' },
-			{ "ready",   0, 0, 'R' },
-			{ "dual",    0, 0, '2' },
-			{ "verbose", 0, 0, 'v' },
-			{ "quad",    0, 0, '4' },
-			{ "octal",   0, 0, '8' },
-			{ "size",    1, 0, 'S' },
-			{ "iter",    1, 0, 'I' },
+			{ "device",        1, 0, 'D' },
+			{ "speed",         1, 0, 's' },
+			{ "delay",         1, 0, 'd' },
+			{ "bpw",           1, 0, 'b' },
+			{ "input",         1, 0, 'i' },
+			{ "output",        1, 0, 'o' },
+			{ "loop",          0, 0, 'l' },
+			{ "cpha",          0, 0, 'H' },
+			{ "cpol",          0, 0, 'O' },
+			{ "lsb",           0, 0, 'L' },
+			{ "cs-high",       0, 0, 'C' },
+			{ "3wire",         0, 0, '3' },
+			{ "3wire-hiz",     0, 0, 'Z' },
+			{ "rx-cpha-flip",  0, 0, 'F' },
+			{ "mosi-idle-low", 0, 0, 'M' },
+			{ "no-cs",         0, 0, 'N' },
+			{ "ready",         0, 0, 'R' },
+			{ "dual",          0, 0, '2' },
+			{ "verbose",       0, 0, 'v' },
+			{ "quad",          0, 0, '4' },
+			{ "octal",         0, 0, '8' },
+			{ "size",          1, 0, 'S' },
+			{ "iter",          1, 0, 'I' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -268,6 +274,15 @@ static void parse_opts(int argc, char *argv[])
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
2.25.1

