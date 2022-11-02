Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9A617001
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKBVnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKBVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:43:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E8F6591;
        Wed,  2 Nov 2022 14:43:07 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF48C660037C;
        Wed,  2 Nov 2022 21:43:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667425385;
        bh=I6k0VYTBtgXqylue8+whQkMj2wwlEM89xgbgwhw/Gmg=;
        h=From:To:Cc:Subject:Date:From;
        b=dFDgAJLbSFI9EOSca34tAKkHzdhLLdsf9vnQaR0Cj4ijTC5sqJoLsaeZn+rGY1jb6
         U6X1C7odwcSRrtrUaMkS4wwAoXiiWuwbYXxswZBS/MoSVB7LY9AlgGvbNvMbSFTuU2
         jjAuXo3zpDnwoHnrkdtpRg/0Q89AiQr17/T2VxqhPDyt2EmbR1c0wDcggEYth7R1Of
         kyvmIb2DOC2+/uDdqom/3gfaKCs1wWZCun5vXp7ysr76L0n+OZaQ368qfxswpO6MDG
         YqQkW5COIllOaScVlOUvE45dtf/EUl2TiKmOpPx/lY4/4OmmOb5jyIiVJ0y+z1V3qv
         n0XRk4mlOJWjA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] docs: dt: writing-schema: Document usage of CHECK_DTBS make flag
Date:   Wed,  2 Nov 2022 17:43:00 -0400
Message-Id: <20221102214300.309347-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to run checks on a Devicetree by passing the CHECK_DTBS
flag when building. This is a useful shortcut to the dtbs_check make
target since it avoids checking unrelated Devicetrees, which can take
some time and is unnecessary if no bindings were modified. Document it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/writing-schema.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 4a381d20f2b4..55ad556472b4 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -167,6 +167,13 @@ setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
     make dt_binding_check DT_SCHEMA_FILES=/gpio/
     make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
 
+Note that ``make dtbs_check`` will validate every DT source file that is
+enabled. When making changes to a DT but not to the bindings, a possible
+shortcut to validate only the DT in question is to explicitly build it with
+the ``CHECK_DTBS`` flag enabled. For example::
+
+    make CHECK_DTBS=y mediatek/mt8192-evb.dtb
+
 
 json-schema Resources
 ---------------------
-- 
2.38.1

