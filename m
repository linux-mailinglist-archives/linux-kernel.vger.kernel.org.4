Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C80637E43
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKXRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKXRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:22:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541715C0DA;
        Thu, 24 Nov 2022 09:22:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso3716472wmc.4;
        Thu, 24 Nov 2022 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utYHq/Eub/BXbR5vrvSJsruIG0O9SmYPcZyptCx8AhU=;
        b=Npx+EPqniIEdw0EGXuCVh/54/X2bN/m9Ko8XV6byM7vi6TFjX6rxSlG+IXu1nwxbN9
         u3oQhCq9Xyr/SS9lUJAvnbNJ8++PpWAvj4DYNW0ypn0RC8fi+mPwpcDd8dNRRGIulcFC
         Qbisx1RteagjzWBSAoE649Y/WYFrfKcLVeGkhB49mTkiLyf26sh5bwDIhsFtQbfX7Li6
         N4uaVDVzLkz7kfsoU/giseFXlLTk0qHHl+/3MVqXy3jDpVigxfQEWMu2AEh9ij/5M4Ye
         nbrVlTqQnLLIYETbjzD8HtUduC8AYGf0Uzr7Tui1nE9uu8BvCOtwpsq7kVqKRCau2f8G
         VYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utYHq/Eub/BXbR5vrvSJsruIG0O9SmYPcZyptCx8AhU=;
        b=2l1p/Jmll8nib8gB+t6WpF5wLlZSoI8XNxHF07FPwqvQECzaCP99pm3IKY0ftyW97x
         35ZvXuRpG/k5UqbOHcYoXsfYurR8++O0kNMgjNrS5HowTbeAmQM+aBkVIUj6wngHQVFC
         HEFJv/se5zjTqslPV2a53UmHAAX3xitbT91eP9AloW7C7Zs89doyiHNLgrosBlTVeKb9
         hG/FCfS8SwzfOTPbkFy5iFu5qSuDbVmpfj18TzSdEqJdEBgHVrOgRK58QDQy5gWcwGCk
         qpaghPyPe+FLLP6zkw7cepEB+HBI217pvIOpAAi3reQZc8v6t7O8VKCSnKHET5rOYeoy
         6o8A==
X-Gm-Message-State: ANoB5pn9wx6Hls/wNiTPiVYrvMB7k51NKthywzWUWk1EqGY8rpOKE3St
        TEz/bI70ljS5XvLRfRsWW18=
X-Google-Smtp-Source: AA0mqf7zKWGNZV2S6uoeTnYAAunHGD4Gcv0UaFe1QxECQqw2HOvWZNeKoOOsjFHF9DXN8XqFA8XrbQ==
X-Received: by 2002:a1c:4b12:0:b0:3cf:90de:7724 with SMTP id y18-20020a1c4b12000000b003cf90de7724mr28080170wma.18.1669310560602;
        Thu, 24 Nov 2022 09:22:40 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:89ee:3f5d:1c99:35d8])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003c64c186206sm2698086wmn.16.2022.11.24.09.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:22:39 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 2/7] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Thu, 24 Nov 2022 17:22:02 +0000
Message-Id: <20221124172207.153718-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add Andes Technology to the vendors list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC v3 -> v4
* New patch
---
 arch/riscv/include/asm/vendorid_list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index cb89af3f0704..e55407ace0c3 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -5,6 +5,7 @@
 #ifndef ASM_VENDOR_LIST_H
 #define ASM_VENDOR_LIST_H
 
+#define ANDESTECH_VENDOR_ID	0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
-- 
2.25.1

