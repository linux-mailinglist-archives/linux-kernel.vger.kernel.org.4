Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C271638D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjE3OSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjE3OR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C8137;
        Tue, 30 May 2023 07:17:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f850b32caso872852466b.3;
        Tue, 30 May 2023 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456239; x=1688048239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sM32gSBhwgEqaXvzS8WOOQz2iG5ex22tKZyotsu4MA=;
        b=Qb2yMh3puMsqDv73oGMNHtqacdk2KMXoqnNGw8sOvBciiYaybvT7BMCPJHsstGOlw9
         Cd7eKKW9/8DrfapPmxA+g6NDPUMmkwzhJW6Edn1y0fQoQHsfM1oCdzxV46OAz6L2cPzr
         wg7L58d2WvP/pOifHDqrbOkLbLRlhqmWH3GOb9mXt0eDvxz6gEG1INlBPSdb9o+jXD7s
         pkCYrnd/od6XH+xCdjjJoVdhRvMXO8vwf02zaR142dXs5VIUKVm//DUVPlJH0IoK8pfe
         UDNF5vzjBAOBur5M2B/+lUiZYN0227ivyvCQt1eTQrHmIv+y+tL1hXpWPJhlRCSJGaYw
         N0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456239; x=1688048239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sM32gSBhwgEqaXvzS8WOOQz2iG5ex22tKZyotsu4MA=;
        b=SdHg3DEz4s3537KVEeoUW5ngdJhPH0DeEZAgXXQzEZNPBj48e/rzW09BGBRNDa5P0x
         2pWA8aal/JssAYqKVsxo/6DVtJSaCHeVD1/JJpQAjqXwocFtllfY2/+3QPAMTONOZefp
         Fd25TtVOxFelpUSD/EyHI9tD1YcYU/VO35anTYyUmoijptmdvHJ82HrCZUav5Wdy3QmC
         ASOC5odMm1/YC49txmw5UrbjdFELpYXFrMzl+zYy6NAkzFqvar57qCcclEMfmcxbdTPB
         mNqvvbVUtjqPRADRq+0OJkXB7ZRU+tiaC/CGZ2WhtgXFWBE3BlNjOsDbqkf1ItbF4xu6
         3bZg==
X-Gm-Message-State: AC+VfDzJg6obztIbQiZwDXUKlmO30Rirv27KXTzw8APMkOthHPzf9eA0
        RU7cS3JnHs+qTVopSiNjQv8=
X-Google-Smtp-Source: ACHHUZ6zEyEGWlL8jVkcQqCF8ixHKKTTN+4lsY0Lqfg40v077Z+OBlqg8uBSq69/uCSW/52PpBQhRA==
X-Received: by 2002:a17:907:7da3:b0:973:717c:26c3 with SMTP id oz35-20020a1709077da300b00973717c26c3mr2525620ejc.20.1685456238982;
        Tue, 30 May 2023 07:17:18 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:18 -0700 (PDT)
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
Subject: [PATCH v7 4/5] spi: spidev_test: Sorted the options into logical groups
Date:   Tue, 30 May 2023 16:16:40 +0200
Message-Id: <20230530141641.1155691-5-boerge.struempfel@gmail.com>
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

In order to increase usability, the command line options are sorted into
logical groups. In addition, the usage string was sorted alphabetically,
and the missing parameters '8','i' and 'o' were added. Furthermore, the
option descriptions were moved further to the right, in order to allow
for longer option names.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 tools/spi/spidev_test.c | 90 ++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index b0ca44c70e83..2d2cee339b39 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -172,28 +172,34 @@
 
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
+	printf("Usage: %s [-2348CDHILNORSbdilopsv]\n", prog);
+	puts("general device settings:\n"
+		 "  -D --device         device to use (default /dev/spidev1.1)\n"
+		 "  -s --speed          max speed (Hz)\n"
+		 "  -d --delay          delay (usec)\n"
+		 "  -l --loop           loopback\n"
+		 "spi mode:\n"
+		 "  -H --cpha           clock phase\n"
+		 "  -O --cpol           clock polarity\n"
+		 "number of wires for transmission:\n"
+		 "  -2 --dual           dual transfer\n"
+		 "  -4 --quad           quad transfer\n"
+		 "  -8 --octal          octal transfer\n"
+		 "  -3 --3wire          SI/SO signals shared\n"
+		 "data:\n"
+		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
+		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
+		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -S --size           transfer size\n"
+		 "  -I --iter           iterations\n"
+		 "additional parameters:\n"
+		 "  -b --bpw            bits per word\n"
+		 "  -L --lsb            least significant bit first\n"
+		 "  -C --cs-high        chip select active high\n"
+		 "  -N --no-cs          no chip select\n"
+		 "  -R --ready          slave pulls low to pause\n"
+		 "misc:\n"
+		 "  -v --verbose        Verbose (show tx buffer)\n");
 	exit(1);
 }
 
@@ -201,26 +207,26 @@ static void parse_opts(int argc, char *argv[])
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
+			{ "loop",          0, 0, 'l' },
+			{ "cpha",          0, 0, 'H' },
+			{ "cpol",          0, 0, 'O' },
+			{ "dual",          0, 0, '2' },
+			{ "quad",          0, 0, '4' },
+			{ "octal",         0, 0, '8' },
+			{ "3wire",         0, 0, '3' },
+			{ "input",         1, 0, 'i' },
+			{ "output",        1, 0, 'o' },
+			{ "size",          1, 0, 'S' },
+			{ "iter",          1, 0, 'I' },
+			{ "bpw",           1, 0, 'b' },
+			{ "lsb",           0, 0, 'L' },
+			{ "cs-high",       0, 0, 'C' },
+			{ "no-cs",         0, 0, 'N' },
+			{ "ready",         0, 0, 'R' },
+			{ "verbose",       0, 0, 'v' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
-- 
2.40.1

