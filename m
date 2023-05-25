Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4C7108EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjEYJcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjEYJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:32:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB25C5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:32:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1afeec98a00so8328105ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685007127; x=1687599127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI/JSFAyYGipbA4uL3stbZaz5dYY5JtH3gdway4WSgc=;
        b=boYi4NLXerPw97PswPhsYDxCqgI3jujXAEbpHtDkemVKS062IlrXyMZhbtOF9TaRoo
         +OzXk1JU0LSMpCbkRh+BZ/uDUJvB2a7ztAgzldZetfGDqCnkz+pGZMeBexDuysX9hZIu
         kxRcTZDTIZM4P6pS6txQn9r0Kh/TzgNw4vAuQ9JTdvD+sOsiL+X9pz55tgLfGs66x1wF
         eLc29YlpeDTWc2OBGjesOdLGkLPpkXN2Yds1JXO0bKKcHu/ob3hxp/zv7E620ZYBIfKd
         Q4A036oUJoe0N92ikeeKm4WlmbKHOvcI9FgxHcDRYv3PbODFzFy5JFKi6O/+pDDMftSF
         x7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685007127; x=1687599127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI/JSFAyYGipbA4uL3stbZaz5dYY5JtH3gdway4WSgc=;
        b=Qt6Pwy6aWV0nq7vNvsl3FmPoDroIHvfyY6SDFCFRErgkc6+6JuVpHW0i7IQOA5Gc9+
         L58bK/4Sv7cpUnVmG6iUFlURKbTtp0mJle/TsVO0HflWsEHKRSTAXKlNw3gEbOw+UZRZ
         XHSW42Qy+S0lxO/nGps5k9st348xLRVFCOk4f+hA6c347/4RYs6TF5XdI8EiFF512uVO
         Yp8wJOCFIdIE8t7KTyyBYqR6y6X98TvX+/169eTKrcoeVX9dUMmiPQm8VDWw6+krh64g
         +botxWTZcwmRFqm15LWIEpahhcGNUSW+oMnTiTEWjRnIACmPL4zI62FwOOquG0/CwHlV
         kEOg==
X-Gm-Message-State: AC+VfDxBRqIjCf41Fyn/HQoMJH/hDHPb7Ggn/MFC56LdltsVOjsfi9Lg
        IL+HSeiZI4T69BJ4wkWAx2sAPw==
X-Google-Smtp-Source: ACHHUZ6Gpg14W4sxMXQqBgOORHLA/TU8V3NBkldPWO4L0bafwxjOTd6MsgABzWE6mFVD+PVFtrvdkA==
X-Received: by 2002:a17:903:124b:b0:1ae:a44:841c with SMTP id u11-20020a170903124b00b001ae0a44841cmr1157895plh.42.1685007126912;
        Thu, 25 May 2023 02:32:06 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001afa7040a70sm951039plf.276.2023.05.25.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:32:06 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@google.com, daniel@ffwll.ch, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [v4 0/4] Support Starry-himax83102-j02 and Starry-ili9882t TDDI MIPI-DSI panel
Date:   Thu, 25 May 2023 17:31:47 +0800
Message-Id: <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copare V3:Resend without Conor's acks on patches 2 and 4.

Cong Yang (4):
  dt-bindings: display: panel: Add compatible for Starry himax83102-j02
  drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel
  dt-bindings: display: panel: Add compatible for Starry ili9882t
  drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   4 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 471 ++++++++++++++++++
 2 files changed, 475 insertions(+)

-- 
2.25.1

