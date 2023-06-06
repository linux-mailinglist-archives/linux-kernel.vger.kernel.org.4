Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D39724555
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjFFOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbjFFOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:08:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55819139;
        Tue,  6 Jun 2023 07:08:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f60e536250so52198825e9.1;
        Tue, 06 Jun 2023 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686060521; x=1688652521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEguAEjaUZuH5f9mkKjoRfJYtn4sBJWyZOqN3ONfKgg=;
        b=npYbs7JmwiQxzf9JlCFyhzW3qC4071I8viVqb+RtLUeKPAtNxQJpqYmyaY1InCiqWl
         MWOLREhVsDEYz83h0p+CJOcso4Dez5Ozwh8tadFN9MVEaoMgzcu4JvOiQERV+jcXdBBM
         m5W1EufUJAqZrHdRFADnN8xcVW+3XDphd6f53xPN4oN0iBA3V706PF4sEqFNWVB2C/O1
         zlIWLNBYQlg0491dnHGA8HcEoWmAboZfcJyYn/5dep/5qbGtO3z1mjiUjPciFnoxCtw2
         iUO/EZDyKCCYiqnYQMAvIXDLQsA4hFMwl4IFyRN0y2hwXA4F1AG0iEfDrYiFmUouqpTA
         gkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060521; x=1688652521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEguAEjaUZuH5f9mkKjoRfJYtn4sBJWyZOqN3ONfKgg=;
        b=EYZ5KDAM5v3Y41ZHBlUQCMcwK7br+hI70W/CyGXnUHi2iHAVkv7er/Jfo4zuBK4dM6
         c/HP5OTzTcUGVzcIepAfg7xUBl8y5hIpROB7PpR/SIFdQ5K+POL57AlsWC1XMWXCFC34
         UV1YmGkVSAHTlJxBMFv+vPWPBVNGTOUTKDZtzZn4weWX40uhxmbFRojTxnPfWonobhfe
         njgyAqwgayKVS+7NHzikxs3mgQ4hUIGN+57hqUXTlylcvXgcSVjRN6sJWoKDBCN2oEqx
         bPGmFzUT2fyEaegAF2phnRImTBLuueY0mnPZVb69p348iJepSjyr4Pvg64vxMcGh/WtH
         upIQ==
X-Gm-Message-State: AC+VfDy2mbyQLXDQkNP6qZFYk00CSTrB6vyi/xH55tPJnH4Mz5W/1kyX
        g88rEW69aa+4POCA75F5XCA=
X-Google-Smtp-Source: ACHHUZ6ENEiuQm4TEr/naGDnZLYWe7o/zzetEiafiqwV4/DSy/+2om7JMLlc1VzI0GYenJlJ+fb6/A==
X-Received: by 2002:adf:e752:0:b0:30e:5364:bf04 with SMTP id c18-20020adfe752000000b0030e5364bf04mr727730wrn.27.1686060520520;
        Tue, 06 Jun 2023 07:08:40 -0700 (PDT)
Received: from fedora.. ([212.15.177.3])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b0030903371ef9sm12694315wrv.22.2023.06.06.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:08:21 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v3 0/3] drm/panel: add fannal c3004 panel
Date:   Tue,  6 Jun 2023 16:07:54 +0200
Message-Id: <20230606140757.818705-1-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS
commands. After few initialization commands delay is required.

Paulo Pavacic (3):
  dt-bindings: add fannal vendor prefix
  dt-bindings: display: panel: add fannal,c3004
  drm/panel-fannal-c3004: Add fannal c3004 DSI panel

 .../bindings/display/panel/fannal,c3004.yaml  |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-fannal-c3004.c    | 318 ++++++++++++++++++
 6 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-fannal-c3004.c

-- 
2.40.1

