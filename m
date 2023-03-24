Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972D6C7E73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCXNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjCXNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:08:00 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738C233DD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:07:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g9so1491847qvt.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679663273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3vQj34vzrMBA2WIoSNH6hX0n26uNjWcoxtz3gH5P0E=;
        b=CleiV3Ty0G2rd0o9YuFhecAdGql5KjOQTvU+hxcM+6jvhTm3pdefhB0faTyi+nkm1k
         WphylGuD5qGOl7c8CEHALGnJqovkc+ew1E3dgtFCCnuTHWiJlU8dCkZQ4vURVhG5z4Nc
         5u9ZUUDLIcYzA6xmiR45hN3U7FXyffKDMTK5+zUGZ0ktoJja1XP/ygmgZ+YloETi0c8h
         EnfLR6Pa7tluCddW5ff5eCiYM0DqotFW5t/7EN0/g/DTToyM4ESNiL+q+e7WR7Mdr9gO
         Rc5z1vFVQKwQ5CkXHBx5o+T9BXj7RfKlkFAGMfQbniSi9GOJh4pdYEcZiIBp//BMmgda
         c0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679663273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3vQj34vzrMBA2WIoSNH6hX0n26uNjWcoxtz3gH5P0E=;
        b=tvpIOnq0ILvfieGMIqwdwNX7VTJ0vYnuymzzpCLI4op2+hsCMlW4eyTdGcsho1zCOa
         Mzr56Un/i8DFvSH2Vv09QRjmMr8shjMkeGpIRZuBpby29fqCwLcykwhii6PXcRuvhK5H
         0sLUqddsjayja8KMXr4KAUNz90k7fBLtpmMpUCahkqPZDA4S+Z7AZrBKj9cwJmk1wHLZ
         XJwxTFuTtm7r6fBNfSSEWVBTykbcaWiet1EtGkrR1Vzk+32ceg2lwvD73w9+XySaKJem
         yYFLD571cwfWnTQ6WMuVukHCkk3ED7UR1BY5hc5TH4MBHfQ8IqoltBUxEw7jyJxaCtbp
         nP2w==
X-Gm-Message-State: AAQBX9dQ/DT305/aLsYBKIVuJRw/9vTqRyCxGWC5IedE4DgZ9Fk+h0Ng
        fIqun912yAkY1I57MqeefxWn5MG8c8E=
X-Google-Smtp-Source: AKy350ayzz7z/EsUWKBov9atQF8fUoHx7R7iRtRYyHhmePRaGyXODhfBVvBPYX6U8GW2KIqz0rMJzQ==
X-Received: by 2002:a05:6214:2506:b0:56e:9dd8:47f3 with SMTP id gf6-20020a056214250600b0056e9dd847f3mr4560640qvb.13.1679663272770;
        Fri, 24 Mar 2023 06:07:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u19-20020a0ced33000000b005dd8b9345c0sm672167qvq.88.2023.03.24.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:07:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Leonard Crestez <cdleonard@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>
Subject: [PATCH] mailmap: Add an entry for Leonard Crestez
Date:   Fri, 24 Mar 2023 06:07:36 -0700
Message-Id: <20230324130737.3360169-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 317e51a0065c..9a450f17690b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -263,6 +263,7 @@ Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@canonical.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
+Leonard Crestez <leonard.crestez@nxp.com> Leonard Crestez <cdleonard@gmail.com>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
-- 
2.34.1

