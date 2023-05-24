Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5570F226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbjEXJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbjEXJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:20:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8797;
        Wed, 24 May 2023 02:20:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso1697483a12.2;
        Wed, 24 May 2023 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920054; x=1687512054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sM32gSBhwgEqaXvzS8WOOQz2iG5ex22tKZyotsu4MA=;
        b=svSeqL2a836MyN3Lh+GhmGvhRNpuYmyJzL09ZhhsYR0nYfng/wK0beNPJ7h0wCO9Z3
         Kp+C8zfucYeFSg1+uXvXE969TH5l6WEDw1PdrHnh21DoiwsfcgkGl8AyC9K9iEqyJ4zJ
         18qc3rkONa9hgoZxF632LUWLsMg+xU3ee6mX67de6g/hAN2u+3Aw8WLGYuF+iqmDI3oi
         ACEfsCivMPPlsh94ZBBhu4WYDEhwX0DTX+ITOurDYwHPqLSYejqownFAbV+JqgvqUcP8
         YWYqlz58drVwQcGI9f/VpEABoGUq4cXMjFMF842TjWMN4jz0uODZbwU2EuqPtdFp5s5M
         CFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920054; x=1687512054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sM32gSBhwgEqaXvzS8WOOQz2iG5ex22tKZyotsu4MA=;
        b=BM9uv77uuiahDyDprKhX/jh7kDnJW4P148XrUuUNjFW3GrEPQ7fFceanRhnoMf5JAm
         ct87wvQmGeC6h2uXC7YssVRGSBdCp1cItEEYrbo+Y9P3AbwRbYyLiHXG/xEBQFZ6f9UG
         LeyQ2OmbCeZtPwYZyYaykVkPowI1O3Vmu9bFEU3d79Ou6wPGoNqPbDAc63jLoXrrdcON
         Rq9NyLzo0FGdu+PTm7M0hABodKD/AGkVtpks3dpSFh2RYPmKiKXDJ8/yF6DD1/o1Rk34
         Eo9SucCqW2pTCXO+koonaDLZTZD2iphuwnVGKDcVUmrQaes539oVOfYFn6CoRhXffSvk
         AKGw==
X-Gm-Message-State: AC+VfDyofME22gDLSkfYGEq5JQghcycMUyVNe/hqkpp0KQpmFAJITln5
        JLoqcSexKU7jpAEoRhbBx9Q=
X-Google-Smtp-Source: ACHHUZ6VV5ioQe3gO5I8qNjlJascX2pu++ASofeKQ2DiCk/4YAb+mhkr8Q90SzoVVowk1ARtuuZpjg==
X-Received: by 2002:a17:907:94d5:b0:973:8198:bbf7 with SMTP id dn21-20020a17090794d500b009738198bbf7mr1706801ejc.11.1684920053544;
        Wed, 24 May 2023 02:20:53 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:53 -0700 (PDT)
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
Subject: [PATCH v6 4/5] spi: spidev_test: Sorted the options into logical groups
Date:   Wed, 24 May 2023 11:19:47 +0200
Message-Id: <20230524091948.41779-5-boerge.struempfel@gmail.com>
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

