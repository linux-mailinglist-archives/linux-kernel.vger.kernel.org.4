Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE1655E57
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiLYV0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:26:43 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EB100C;
        Sun, 25 Dec 2022 13:26:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fc4so22959134ejc.12;
        Sun, 25 Dec 2022 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/E1jZmkwb1esjiwXZMefQocpoKRbXtxkKRar3SCHMA=;
        b=az3jv0s85qiKaR442hQ2uE40XDD1xitIGabb+yE0b1hXUJKM4MAGrtp5RnvBrUbeNo
         v2swLM9C9V8UOav15rdymBS/ExyElRz39AJoxm/pMtzJSS4O2+6/8Ex4HaHbhoxG9a7W
         pFI99tBdvcmVVuLFpNbiTqka7lXP7YA4hbX7DrWC6MWs7oajo7Dp5kGgHQiDjow3BYw2
         oLwpXx+ZaBRYhiT6odPADTODxH6oRDrbvhBebuCwWSieYRa1PVaAzR0TP9PkH1VL7/Om
         gcepUpbf4Z5ohVp+6JeNwWsCABY2C5rMpV/2qVepLu5N4/j/Uu99iJkkI1pJARbY8HD8
         QLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/E1jZmkwb1esjiwXZMefQocpoKRbXtxkKRar3SCHMA=;
        b=WbDc4ajjLgfHuSTHG7tsnkFqRXuEG+zL94YJNCyoqY+Lrb7eVCT/aLcW4gJV8AzZFd
         qWMNUaB6sBSQIdNv0AzIbMKfvhHkFxgnMOQ0krkC2dYCUyMilNYuob3lTVUavcAQkLMb
         4nkPb8P2VYImOdwF+I2DWDc6s5U4Gr9rZX/j8BjR+spQrdoKZSuxQ19X9P42/q5No7i+
         lxVURKMjX9BnGhFtSii146KA6Z5fy4zG0WaCOCkxgGYI5s53dQ0YV2SxzEKviUl9GPdJ
         RHXJ0s0wobYY+cad64ASBb0VF9Hl4wWor7TJrJRBpnSWWg00p1Tzj5KUJEFzKP8BPOGL
         I5qg==
X-Gm-Message-State: AFqh2kq3i7heRcFMjRkxdSl4YX4+yGIEphtXtey6eS5jFjlsnkTnbaQj
        8CGYt6I7wKdL3Mo0SOtaaWQ=
X-Google-Smtp-Source: AMrXdXvNfb+HnZA1tZA4Lpc1SIwFbLT4cjW/FBQ7b4LKAbTVQpf6Nwx5iz+9YwBlZ2ksbG/a+Fcu6w==
X-Received: by 2002:a17:906:a186:b0:82d:e2a6:4b0d with SMTP id s6-20020a170906a18600b0082de2a64b0dmr14248970ejy.18.1672003600133;
        Sun, 25 Dec 2022 13:26:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c49f-b200-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c49f:b200::e63])
        by smtp.googlemail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm4062567ejc.36.2022.12.25.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:26:39 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/4] clk: meson: switch from .round_rate to .determine_rate
Date:   Sun, 25 Dec 2022 22:26:28 +0100
Message-Id: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
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

The goal of this series is to switch the meson sub-drivers to use
clk_ops.determine_rate instead of clk_ops.round_rate. The former has
lower precision (2^31 instead of 2^32 on 32-bit systems). Also the idea
of the .determine_rate callback is that is replaces .round_rate so the
latter can be removed at some point.

No functional changes (apart from the 2^31 to 2^32 difference mentioned
bove) intended.


Martin Blumenstingl (4):
  clk: meson: mpll: Switch from .round_rate to .determine_rate
  clk: meson: dualdiv: switch from .round_rate to .determine_rate
  clk: meson: sclk-div: switch from .round_rate to .determine_rate
  clk: meson: clk-cpu-dyndiv: switch from .round_rate to .determine_rate

 drivers/clk/meson/clk-cpu-dyndiv.c |  9 ++++-----
 drivers/clk/meson/clk-dualdiv.c    | 21 +++++++++++++--------
 drivers/clk/meson/clk-mpll.c       | 20 +++++++++++++-------
 drivers/clk/meson/sclk-div.c       | 11 ++++++-----
 4 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.39.0

