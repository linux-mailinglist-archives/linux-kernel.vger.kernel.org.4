Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716470EFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbjEXHpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjEXHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:45:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED411D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:45:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d24136685so392200b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684914324; x=1687506324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys/SLmJf9ZfMR5xC5B+aVb11E3cqyPInCe2lYcTys6w=;
        b=O9W4mEYJy3RzxDLdJdWLxzqiwP1Ylxa3TIWst/JvA9UPmhtF7kz4LB8Uj+MbWwkmae
         SXSaB7rj/iia708kLLPAIWPyhXKZYTeu+ETv86jb4viym/2+qNYdshXTG0Gl0DsRoneE
         4tIJUo1N2TdRgU/v7KgGHcYjwHrM5/V0NICA0Ak8okFSV8kPffJKvEB41gK15Vtp1asv
         t4teYeNXNQDDYyME4svL88fw2rJ7i3TslXTFF40WKh4wuZ2B8DBcOOe/Jq4kBFZClvz/
         Vgw7k7G51sRrEeaeEglVfpe/5JFAxcWfgIxDiolV75BV1y0CmOrBXhpcalLmMxn5duub
         oG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914324; x=1687506324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys/SLmJf9ZfMR5xC5B+aVb11E3cqyPInCe2lYcTys6w=;
        b=ksjF2XEIJZ1tt5H7BgULI3xdFcaJGcKlfJK7Qr3q41AygUYAnZW4TzaKM+DZwGIVwd
         JMuOgMYbUE9xbkbuD2XEUm286oOn+JBhpx9I6hLd+k9F66aMSVZ8uso9BrdP+ru1m1yY
         mXEaUH1kLkvLMehcYOE/q/TcYvpv48oHOKUUmJLcRn/rYvg0L16lgaZyZick2WD1unIX
         /bytI0UYIhDfkkQC1mku7P7Ju56u5cKB/IvP6l7e0QMC6LhuKN0UfhIBZPMLa+XNfecy
         Fn18JuIx1DsSl1yZRMyFiRUS0+wVvqicKO2o8YXYhCGr4c1GKAyEyJhwMXeU3pAyAAtD
         QsKA==
X-Gm-Message-State: AC+VfDxXLdn1L56bvHBzTtOjmCSyFJZoqDxs+L6HtQXXb6TPl2ymVY+j
        q/MQVwd7dQecsPNaSam4OSvphQ==
X-Google-Smtp-Source: ACHHUZ772BXLvv9iSKgRv0OHi1NApJDkZ266P3N+Twh6YGcaDgZs91atcx6DS8NTIqtu4xWPgBZR/w==
X-Received: by 2002:a05:6a00:4294:b0:64d:2a87:2596 with SMTP id bx20-20020a056a00429400b0064d2a872596mr1534767pfb.10.1684914324665;
        Wed, 24 May 2023 00:45:24 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id j6-20020a62e906000000b0063d29df1589sm6801336pfh.136.2023.05.24.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:45:24 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@google.com, daniel@ffwll.ch, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 4/4] dt-bindings: display: panel: Add compatible for Starry ili9882t
Date:   Wed, 24 May 2023 15:44:55 +0800
Message-Id: <20230524074455.1172064-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com>
References: <CAD=FV=WRecTWsFM96k81YAx1=jJT0vpS4EPP0ZfWFUGHNFx9Tw@mail.gmail.com>
 <20230524074455.1172064-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STARRY ili9882t is a 10.51" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 28a7beeb8f92..906ef62709b8 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -34,6 +34,8 @@ properties:
       - starry,2081101qfh032011-53g
         # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
       - starry,himax83102-j02
+        # STARRY ili9882t 10.51" WUXGA TFT LCD panel
+      - starry,ili9882t
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1

