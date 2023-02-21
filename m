Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6769DCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjBUJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjBUJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:24:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309501A67E;
        Tue, 21 Feb 2023 01:24:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c12so3636255wrw.1;
        Tue, 21 Feb 2023 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj1tWf52J//HqTj7v4fnk+SHbatlNJyYhDkNDwjnWLI=;
        b=jQPWrwJ9BFRMxt4ko0FDpUzvVxLURzjsioTAtz0Q13xhHZhYNfKaldXSsd21hvu3dl
         SdLhg/NZaqSpS6E8Kf6M+UoEsXfFV4sPLh63XeUU468wGmN7WARp8iBdX0mrK83yWLxt
         hcdCavCWDXqptZaQAju7QCSb95MMG5J/xVoAZy9wJxBSClFbX5//uHxCVQ6fcXdO4Yhu
         CS6uNwH7DAASJhm0ra+PtXFiFhThCrCLLKCeptxESIUWD2iMjR7R454OalqvSJTaqsUi
         zb4TTvYqx6LzsZF7hr/0++aflYP+VOjtmGFxgaUQkyqcK2tn9fobYgFZ3y1IIlFAPb9G
         mF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zj1tWf52J//HqTj7v4fnk+SHbatlNJyYhDkNDwjnWLI=;
        b=gYKsB9zKaU9UKkD6PKM6XbmpzREpaub2LFrppyXMnuViXfIXqvEJlHGzJo5NSRW/0n
         /9CW23yLu2fNWNp3+cKvShuUsX6lbVvy56KGiyWB4+Ad4OfGC8ZsvMZ6Lts8eNZ/QrxV
         cJl1aaYrVM/fGgD/F3r1+lHmY94zxO/DZeGk4w9cBoicW0hVJfDN95iYczG8ajnMmRyz
         msHqrw6vKuH+/x/5PpJ8NRV95wDa18CZtDP0cdPZfYIjd0A0zjZRvQf6JDeGpxRtVhoN
         VKeQcao2lszaK5mqGnmN89dZaBw1NIdxBdVEmF6AZ7XlNVUGECx04nyGitDlPhI9HwZA
         l2gg==
X-Gm-Message-State: AO0yUKWAknYruhOj3wEOUR5kFyHs6VI0t5Xe0uPHOn9XabzmOjWrPljy
        OFpVH8bqmFplUUqd+JNglDo=
X-Google-Smtp-Source: AK7set8CJ8+KKQtN0pDVYaDjnrpvJDbxFT9JF1rviXW2IefJQ2QpZNM0gQKqZxbGcBAjzKvxbXZxLw==
X-Received: by 2002:adf:ea83:0:b0:2c5:6180:516e with SMTP id s3-20020adfea83000000b002c56180516emr2254316wrm.39.1676971480545;
        Tue, 21 Feb 2023 01:24:40 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id i18-20020adfe492000000b002c56287bd2csm4272573wrm.114.2023.02.21.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:24:40 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        erkin.bozoglu@xeront.com
Subject: [PATCH 2/2] mips: ralink: make SOC_MT7621 select PINCTRL
Date:   Tue, 21 Feb 2023 12:24:35 +0300
Message-Id: <20230221092435.22069-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221092435.22069-1-arinc.unal@arinc9.com>
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Currently, out of every Ralink SoC, only the dt-binding of the MT7621 SoC
uses pinctrl. Because of this, PINCTRL is not selected at all. Make
SOC_MT7621 select PINCTRL.

Remove PINCTRL_MT7621, enabling it for the MT7621 SoC will be handled under
the PINCTRL_MT7621 option.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/ralink/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 06031796c87b..83e61e147b90 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -54,7 +54,7 @@ choice
 		select HAVE_PCI
 		select PCI_DRIVERS_GENERIC
 		select SOC_BUS
-		select PINCTRL_MT7621
+		select PINCTRL
 
 		help
 		  The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc
-- 
2.37.2

