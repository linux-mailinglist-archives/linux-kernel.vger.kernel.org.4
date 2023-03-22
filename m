Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE36C4E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjCVOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjCVOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:49:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE686780B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:47:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d14so5677514ion.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDOGO+KNCLOdYgcHnk8rDrs0nfv9Q715qQlcv78HGMQ=;
        b=GkS74GrVMU/JUAuKij1Ex9c43SEyFwQ+tr7pTB1hkgZaVwFGCSk3+KtqKY7ikd8Fi8
         sYiUQHWSpQ57+VMVdoXpUF2daaRDeXlVUW2B10HZjreLQnjzJ6wAfVBE5NClWEBFXE5n
         kaVqLZdhaY+tI9+t9A962fcjmgkRvd9nsnm5h0npdXtCDT5lUhMNVAM2rsaoxvl/4fwx
         oViDSucUmbU+2y+1/epPN08lm30GWO3S+017LkGEv1JvToO1PGhKu2WSIoICWYNAAAvb
         eY6z8rLf3780TQ0++R3WxZ020gqDF9uKopeZ8j0+XRARQnpWmeg1mNSmNH1BQunE+Iwg
         mGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDOGO+KNCLOdYgcHnk8rDrs0nfv9Q715qQlcv78HGMQ=;
        b=4D1l8BHhHtDy9yf2f+8a3+TAQqeerhP0kz87YJKS2KO8R8JUzP43heEIXvS4fjz1YU
         urhn1k+dauXsKt2ztuPp+ywD6NflZwyk/SydJ6CJACWAiTwmXj3qHrb2QBuZF/S/f/lH
         RItCbLoiSi//GGLyQIWzHXThSUmoh8xVr4A4UNCkv8/tfxUvQqXwLSTe9r9PS5RtjfKU
         lwiMagzQf9ULh1dm7Nx718AORNZojUHOnJUCP9ntOoHiC32WLJ2QXGn7iIl/z62MoqC9
         5CmdasDD1sTYgTwYTlPkGfpoZAMec2uv1cDwJajJohGw+At5Mvao9DADUw+zpS26yPKM
         4kVA==
X-Gm-Message-State: AO0yUKVdRcteoI4WIDxgX3nW+YhgR4erOmiEyRsXSEtJ6U6gEUUEfJi0
        xbR6ViSAz61JkHz7f/UfCl7GSA==
X-Google-Smtp-Source: AK7set/Bs0wJ3Xv1KtLWpP25dS54Xbl6M1c/LDLHW80vWT2Suh3IQrYWatnFoldkH2qGU0dSph+7wQ==
X-Received: by 2002:a5e:8d03:0:b0:74c:9450:8094 with SMTP id m3-20020a5e8d03000000b0074c94508094mr4514988ioj.17.1679496465936;
        Wed, 22 Mar 2023 07:47:45 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n24-20020a056638121800b00406132281e4sm5120463jas.109.2023.03.22.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:47:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipa: add IPA v5.0 to ipa_version_string()
Date:   Wed, 22 Mar 2023 09:47:42 -0500
Message-Id: <20230322144742.2203947-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the IPA device sysfs directory, the "version" file can be read to
find out what IPA version is implemented.  The content of this file
is supplied by ipa_version_string(), which needs to be updated to
properly handle IPA v5.0.

Signed-off-by: Alex Elder <elder@linaro.org>
---
This should have been included in the previous series...

 drivers/net/ipa/ipa_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index 14bd2f9030453..2ff09ce343b73 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -36,6 +36,8 @@ static const char *ipa_version_string(struct ipa *ipa)
 		return "4.9";
 	case IPA_VERSION_4_11:
 		return "4.11";
+	case IPA_VERSION_5_0:
+		return "5.0";
 	default:
 		return "0.0";	/* Won't happen (checked at probe time) */
 	}
-- 
2.34.1

