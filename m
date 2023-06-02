Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD371FD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjFBJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjFBJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:04:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324BE7F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:03:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso278272566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1685696623; x=1688288623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z0aWs+76DsOLK1ZdUfTJiO33aieMzJYwE+Vw+aqL5o=;
        b=KC3pRTXttgRIUpt/J5diupn1SqWtaBkgdDbiDRQ9CHSU5XfIvtNfmd13SWzWayo0BX
         HUdX9gDctfwufnP09F5pk6O9FrRX9CPNX0VquDeoRD3xBs+lbLQULNZy2P5SHbu5QOp+
         vVWx2jGeYcbasf0SzGdw2+wev5PColDikoe8BxdKye8N6UOHmNUWu7zWwkWKnIls/aWz
         uOrgsS3LVLZ9/5YpqWY1MowwGZxt0EEyS3xhHdy3nQFyEAXAyfxIn4DNEmt8hJ80Qqmv
         Ih3npZIPQS+r5V3KrJ7tu7rOGu3425u8cI7pePSUbWQAZABx4ktAkyKBM4nbWPA7g8oT
         dnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696623; x=1688288623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z0aWs+76DsOLK1ZdUfTJiO33aieMzJYwE+Vw+aqL5o=;
        b=dMIb3eAIYGJdndQ5ov96ZVT3J5XFuhQDzsJBB+3LDfL0bwEKtziTZV2hGBucp/yLuL
         y3jI+ZJkzkdsbrnybt2sCMbg2/lusrI874XtTRkExRBWZwsDQsDOAu6eZrSyL6xeihsp
         bsrM/K4MEqcZZBeJCtKMQ5J73QCd3B/nfypZwy6tix9Tl7wzq+E0eehB7zxun2chQ2bq
         YkNAk73ixVy0ynJi9WrcOISOxfTmTcpRicrL7dFNTVL62ixLMUVm5sr2d3O4kvK8K6al
         gZp9ZRrYnlNVLY0cXmCSOuY8DAQx9QrZOBNgZf9FYXBwXuvnwcnEUfyazLqX6FWptTxp
         QhQQ==
X-Gm-Message-State: AC+VfDxDK6A/Gn8ubdrYeyEmQoTDU/hl20SLtMum8XDscOrv8MJgghLk
        DXfflnB9xhNvJwI25GmPg6oG1w==
X-Google-Smtp-Source: ACHHUZ5CDb7hi9sRLxSyOLWk2zLbnISHdDPJk09PJ3HtrxN665G3O5E6naqR5vu6cmuvrQV4abNDig==
X-Received: by 2002:a17:907:8a11:b0:93e:fa12:aa1a with SMTP id sc17-20020a1709078a1100b0093efa12aa1amr11368431ejc.1.1685696623017;
        Fri, 02 Jun 2023 02:03:43 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id w23-20020a170906385700b009707fa1c316sm488031ejc.213.2023.06.02.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:03:42 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ASoC: support dai-links with symmetric clock roles
Date:   Fri,  2 Jun 2023 11:03:17 +0200
Message-Id: <20230602090322.1876359-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Currently the ASoC core always assumes that one end of a dai-link is a 
clock provider and the other a consumer. This series adds support for
configuring dai-links where both ends are actually clock consumers.

Alvin Šipraga (4):
  ASoC: dt-bindings: document new symmetric-clock-role flag
  ASoC: core: add support for dai-links with symmetric clock roles
  ASoC: audio-graph-card2: parse symmetric-clock-roles property
  ASoC: simple-card: parse symmetric-clock-roles property

 .../devicetree/bindings/sound/simple-card.yaml        | 11 +++++++++++
 include/sound/soc.h                                   |  3 +++
 sound/soc/generic/audio-graph-card2.c                 |  7 ++++++-
 sound/soc/generic/simple-card.c                       |  4 ++++
 sound/soc/soc-core.c                                  |  4 +++-
 5 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.40.0

