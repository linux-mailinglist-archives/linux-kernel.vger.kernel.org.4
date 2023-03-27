Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E16CA3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0MYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC0MYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:24:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE912D65;
        Mon, 27 Mar 2023 05:24:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so8561285wra.13;
        Mon, 27 Mar 2023 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679919846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSN9Ecs9VgPdHBd5DnU/Mgt1P34wB8c/uf3669zchqk=;
        b=UsozCZrqIdoaol4lsXeG6Jm+fEgT2eIoHwmPfbkhHu60pYddYnrGELrNj1HM16VO+g
         0VN25oOSeZkqv+Hu3w+i2vQLWz2f3sg0+zUfS7wRrFIA8riP8pcogE6cJkmeQXdKvZaq
         lshsdJbAYQWg9U4GfIh7vlX1Ns9/q30KoaujAEnVjQz2l6EcV21uCqoLbxfkDapZ3v21
         6dZh9/nq2oLXkDjurwy0B06V1qGbqMp73x3uKoedFJ6b70VBP15kVuNSNa6hN41rTjO8
         shSZupws5iDXSHKpEdTl+LpxUyyTrFmh01bL3urp/TTUdRq0xesowqqTlw28UrJv2dj3
         aJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSN9Ecs9VgPdHBd5DnU/Mgt1P34wB8c/uf3669zchqk=;
        b=pBptnsgdE9KT35Zm8RFLsmWAf+Zr+Y6OT73O0ne3Zq+dR9PyHXNcjIm3TrqKL6xfpA
         b81dn2JqeSw6TPaEdZGJXhhJa55UyMVm33uxw7jKwr+yOysw0QY4f7LZD887MTDoDPK+
         53RPoTW/I+D1/fs4eWvN5AgaOE6WuFkeM4XIN2LojmKPGIUM1G2DmZPBB+ywGHJr1+5A
         vmAMD81b5Td0V6GOzU1D1YubezsXQcShuxxBJjsHm3igJGqcAU7CXT6emBwIzgiLpyY/
         WY2micAfftODI5AbqanMpSI0wNaGHp8kbm9L6QTq8T70cpriBXPBc2QwmHHuBj9JBsY4
         YZZg==
X-Gm-Message-State: AAQBX9f4qZTqEr/LW/0nwN3I27j63cZtwXZhuV2dkh5GIMRaHyiwnurX
        6wG8j4OLLeyIEOteuLvHVl/m2fN5V+3ubf38
X-Google-Smtp-Source: AKy350Y4+SmDaAw0i4BZZuuGJw+65kINTLrCwALVgm/y45Sj0LIANiuD5QhZrxawSRu+H/4ReKGB9w==
X-Received: by 2002:adf:d849:0:b0:2ce:aa2f:55ff with SMTP id k9-20020adfd849000000b002ceaa2f55ffmr10455838wrl.1.1679919846201;
        Mon, 27 Mar 2023 05:24:06 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b002cfe63ded49sm25001223wrr.26.2023.03.27.05.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:24:05 -0700 (PDT)
Date:   Mon, 27 Mar 2023 17:24:03 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: nvec: replace udelay() with usleep_range()
Message-ID: <ZCGK4+zUDT1lLz6s@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'udelay()' with 'usleep_range()' with 1000us as upper limit.
This issue is reported by checkpatch.pl script.

CHECK: usleep_range is preferred over udelay; see
Documentation/timers/timers-howto.rst

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index b3f114cb00dc..1b51935dba4f 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 		break;
 	case 2:		/* first byte after command */
 		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-			udelay(33);
+			usleep_range(33, 1000);
 			if (nvec->rx->data[0] != 0x01) {
 				dev_err(nvec->dev,
 					"Read without prior read command\n");
@@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * We experience less incomplete messages with this delay than without
 	 * it, but we don't know why. Help is appreciated.
 	 */
-	udelay(100);
+	usleep_range(100, 1000);
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1

