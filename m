Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C76DF295
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDLLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDLLJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:09:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E36B7;
        Wed, 12 Apr 2023 04:09:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e7so397526wrc.12;
        Wed, 12 Apr 2023 04:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681297766; x=1683889766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD04tvq+M9m50iyP6xVhtqLbPbgsKDIvDjFswr8cjxc=;
        b=mmmmbdiYt67XYwHB4JJGDHgGj/0WqOUnZKlnLbxhhm9g922yNLznh/ubB9I6GbwgJP
         ssMgUgKNOUSdjFM71EEAotwNazn9gsaAxYt6KahL8nUFsm21Oujq029r2WVYk/BFEyb5
         usQAUlQ6F9/JhCZ0gVGlMEEs8MPP6OrkI8GwgqtgEAEf/Csy9vtVyoVZ8/35NbwxGakr
         +Dh2X3DhyKHR+KzuHOB//COuoDGVKLxUHac7yNsRJkGTZDov5CZA63VPgsN3IB2mdwZa
         MSZNpNNqfColZwj1k1nvyU+dq+kuZrc/YSY7ZM3XlZNHAUg4wG4WQhBPKxb3jiVSjZuF
         WEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297766; x=1683889766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pD04tvq+M9m50iyP6xVhtqLbPbgsKDIvDjFswr8cjxc=;
        b=dQh5s6H0xWErHWs2VzrZ54rlOAMUMlLRNfmooTQdp40h7QUEsrgwFPN/JjoeZkTyQB
         NRl7IhltKHPyDsz1CiFQSz2Yn3PWh8oC4DggH4iXIZABGmZFeqK5xrmVwz156hz0acy7
         SuLkwrJMJ+dPIFZmtST0jjMW1f2beNlBuABKIdSp6WRtcKvfs+NdVKRz8YKPxNEbgAho
         EeZhbRkIb3oLKNIUOtJMWZmWubRNvOqOfTdhn4oV84vKObmfNqRZdU+4NbK8ljGQ/03z
         FeBVvAaj/gix2zZ50rIeAqjdPdLq6nItVZhv23X11CbKmp1s/+aXZDPg+bVN7Uj2GTtK
         L9iA==
X-Gm-Message-State: AAQBX9d0Q6vrwhk/d6C+Dh9ulx1Zj6kiR7crjkxJXPTjJDdvT0kMBB7t
        mX3s2wlRlSQf8BEUuxfE+3Q=
X-Google-Smtp-Source: AKy350ZG+ziQg2f5yeP8bvPDaskt2sxwWBoOSz80nvmpvV5ou9fl8wAEhJk9S4Fpi5rT8+zmvU8WAA==
X-Received: by 2002:adf:cd05:0:b0:2f0:c90:b720 with SMTP id w5-20020adfcd05000000b002f00c90b720mr3459066wrm.61.1681297766125;
        Wed, 12 Apr 2023 04:09:26 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:783d:9280:20c4:db22])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d668d000000b002e61e002943sm16863582wru.116.2023.04.12.04.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:09:25 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v8 2/7] riscv: asm: vendorid_list: Add Andes Technology to the vendors list
Date:   Wed, 12 Apr 2023 12:08:55 +0100
Message-Id: <20230412110900.69738-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v7 -> v8
* No change

v6 -> v7
* No change

v5 -> v6
* No change

v4 -> v5
* Included RB tags

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

