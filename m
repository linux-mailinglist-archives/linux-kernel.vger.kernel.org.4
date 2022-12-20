Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD857651879
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLTBp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiLTBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:45:16 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C53F658C;
        Mon, 19 Dec 2022 17:32:47 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1443a16b71cso13756240fac.13;
        Mon, 19 Dec 2022 17:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQvrXc/8s0udwvhStpHx3CBuMZiJPXpwQx23qaaKMxc=;
        b=UO5yQjeZOpDKt2/JTfTRpOekvQ+gtBAH45m13+VNtfDKPF4P9JZ9JppxOnDbX7kCNI
         W6dUWYah1PqhuHdVNoui0qTNcymChOFEm2O+NBAA90IKPi6SSASQE1aCUKvShXkartGI
         RBRf4yKO5FMw60jeCpe9qBuPb8fd/IFfZ4p9TK2O9W8e07R8D4NsyTHTJ6EUmHX4di+4
         xRQk7/4XPMJM+/EP/zRjqeNfKQBHbKCkvcKfBQcw3CHVh5PdcHS+SCDciOGZSbJuy3xF
         nQrV3dc4qkdBEoK34Alv2oFg8PJwLo4L0pAm7nNk4ed/2jAPjmPwcG4N5LuZVPzcbgPs
         gCfQ==
X-Gm-Message-State: ANoB5pmqCQnDojvdYQ+rfGGPic11O8PHT4tTXlSKtEG/Mqb1eHxpbahE
        RwrDlkShFl+Qw8+zTnPbxXGGenptTQ==
X-Google-Smtp-Source: AA0mqf7GatWayAuECI3POSXHbaGq4XLQPhPgp1k4m3TjFC+RUTJQXxpsoTtbfPN/72Z7mzyAowZHBA==
X-Received: by 2002:a05:6870:2186:b0:144:687:9a3c with SMTP id l6-20020a056870218600b0014406879a3cmr21466639oae.45.1671499966220;
        Mon, 19 Dec 2022 17:32:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u8-20020a056871008800b0013d6d924995sm5436668oaa.19.2022.12.19.17.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:32:45 -0800 (PST)
Received: (nullmailer pid 2890620 invoked by uid 1000);
        Tue, 20 Dec 2022 01:32:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Marek Vasut <marex@denx.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Optionally enable schema checks for %.dtb targets
Date:   Mon, 19 Dec 2022 19:32:33 -0600
Message-Id: <20221220013233.2890335-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not documented, schema checks for single dtb targets mostly work
already by setting 'CHECK_DTBS=1'. However, the dependencies are not
handled and it only works if 'make dt_bindings_check' was run first and
generated processed-schema.json. In addition, changing a binding file
doesn't cause the schema to be rebuilt and dtb to be revalidated.

Making this work turns out to be simple. Whenever CHECK_DTBS is set,
make 'dt_binding_check' a 'dtbs_prepare' dependency.

I reimplemented here what Masahiro had originally come up with a while
back.

Cc: Marek Vasut <marex@denx.de>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6aa709df6bde..a99d5c4de0fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1467,7 +1467,10 @@ dtbs_prepare: include/config/kernel.release scripts_dtc
 
 ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
-dtbs: dt_binding_check
+endif
+
+ifneq ($(CHECK_DTBS),)
+dtbs_prepare: dt_binding_check
 endif
 
 dtbs_check: dtbs
-- 
2.35.1

