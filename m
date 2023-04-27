Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142B6F0BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244515AbjD0SUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbjD0SUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:20:07 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C79449A;
        Thu, 27 Apr 2023 11:20:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-5ef8af5d211so68128706d6.3;
        Thu, 27 Apr 2023 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682619604; x=1685211604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3ybj49I0azNPq8mUJZxYJ7OaIdhKs0dZovAgS2rqE8=;
        b=U89HRMpmyZlcTTn96nVf6SFQOC43UMedTYIBj2PDadzSbWoo792cepjuYgCy9eXraJ
         MQqMMxvgMRxDDehnECB6pWT3pfAJYJqZK0dRfqBl+dw+QQTYS5ESUlhlikynsPChclad
         +ENs6hONhfCZ/hCQsha4vW28bgnCF9b48fBosFRrqgNZrlxTuzPWOyEjfkerrCHW+XsF
         t/cEk6NEYeoij5WzgaH+Ym0eaYUVFEIENQLnZ0NtxhZawULOn0rE8Rp/z+mBCwBO127a
         NU9N21v8CVfN65WuOYWzQlFJ8NFGCQqBQy9IKwLRXg7k/sTEEIN2Ivx1KGD9xL5AFiSB
         h9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682619604; x=1685211604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3ybj49I0azNPq8mUJZxYJ7OaIdhKs0dZovAgS2rqE8=;
        b=DFDiaurqMtRY2T0oNlYdr0qRX/zrI3f3GOL3nC0EXwc5WwFTL+J2mrccCExigxQDvN
         ObiBv1SmK/elOyJZcDPUTxqlq+yeqMdCDuVvi5TeGmHU4cVedMTTR8tRe15873OuUv1T
         2dlnarJefeZdLjKvV3ZeIW9oj+rajL+lklmgDOBqe4CBQZUgXzSr8DNQpgVwJFN2R5WV
         M15jndHfKzb+Ex3UDuFWgv8v37XoV358EsvvablVigMhJrWifqWSA82n3CYx0IPdHRUX
         ckDHth/KHUtTcm3nQ6AOWslysLzk0AiYnGTcB8Jh9BLenLKVAs9YrwrH75s9s26hlpBT
         HRTQ==
X-Gm-Message-State: AC+VfDwaHqrjclkzVY4Xc4+C0QSRtREByg9V+1nCYlNA/JYEDQ8+oQ0v
        I7rOgaM8ZJ5GNAaenbUqlXo=
X-Google-Smtp-Source: ACHHUZ5cYl3jgQZm6SGSvJtiMMs2doLTMTbPU0Kv/GWLf+po8Dd7JG/XRhHNP9301io5yiD2i8lx+Q==
X-Received: by 2002:a05:6214:5015:b0:5dd:aee7:dffb with SMTP id jo21-20020a056214501500b005ddaee7dffbmr3785649qvb.22.1682619603698;
        Thu, 27 Apr 2023 11:20:03 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s14-20020a0cdc0e000000b005e5b30eef24sm5788316qvk.56.2023.04.27.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:20:03 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Doug Berger <opendmb@gmail.com>
Subject: [PATCH 2/2] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Date:   Thu, 27 Apr 2023 11:19:16 -0700
Message-Id: <20230427181916.2983697-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427181916.2983697-1-opendmb@gmail.com>
References: <20230427181916.2983697-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.

The issue is fixed by using a managed clock.

Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Reported-by: XuDong Liu <m202071377@hust.edu.cn>
Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 90ee7bc12f77..af0e1c070187 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1012,7 +1012,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "clock-frequency", &clk_rate);
 
 	/* See if a Baud clock has been specified */
-	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
+	baud_mux_clk = devm_clk_get(dev, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
 		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-- 
2.34.1

