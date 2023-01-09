Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82C4661CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjAIDjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjAIDi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:38:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707D959F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:38:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so11479591pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rwMtQBgKwO7eAmp8m9Hgu5RBxRCX5+X5JE5ozFyItE=;
        b=N+gCejtGUGSll5gVYjwLR9LLtG//JjdfH1iaeAVD3NDHajJx7yaNWQ+d56J3ctRWHr
         dlQW+f1kIcZLHC9GQYB6MfoUro1cJL1JEJOMKwIy/mv+jUTqietRabgBAlOnvgKtqdSm
         Q+2MeyCML9mxsJkcp2vAmx/5JAPVRKj/BQ8p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rwMtQBgKwO7eAmp8m9Hgu5RBxRCX5+X5JE5ozFyItE=;
        b=BIaxWdVWviF7H6H6XgDOjHydpQEytSxRUDByEUaCvi+gJCQ3+9DSKQ/tE2iZxokYdg
         YP9kHBlCPL72kLJ1wTqeehkgSEaZmXimpV5LtFEcLRJJELgOrs8D1haqYFNt8a0iTS8g
         MpmgSwfXjokQs2//8xPQetRFzJyNcvREQPxIO8Ere3Pu2vMAMA+9RJkIycVKN0Dsqnh/
         cWN0MG9/9GoUyrij1/G50/UegxTbQWcWKLMCuhCBP6oTjskdf+OWGGBqp9kbx8Qa0vNX
         WzD4IBmxjJJBNltaPwhzdSKmSSNpVU6jWFbEgGE8D47IymXaSMESacVSI8duBgaUPMMe
         dv3A==
X-Gm-Message-State: AFqh2kqwGGzdDWL9gbJOWkXk9x4sL1Vl2e+jc37JlyLHF2ti8ghQsPsv
        XgNFR+kAVmYJpg+ceG3RlwV0FDgPejTa7+fS
X-Google-Smtp-Source: AMrXdXuLOTYwxtcj3xS7+60j1kkgrt7TeaPlA3xpTfWv2I6LoNzwh68AFRfYVqio2KWOEdMkO9vj9g==
X-Received: by 2002:a05:6a20:4283:b0:a5:a9c1:5600 with SMTP id o3-20020a056a20428300b000a5a9c15600mr89003130pzj.48.1673235535583;
        Sun, 08 Jan 2023 19:38:55 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5ec1:f8d2:ce47:7ddc])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4896685plg.60.2023.01.08.19.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:38:54 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Date:   Mon,  9 Jan 2023 12:38:34 +0900
Message-Id: <20230109033838.2779902-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This turns hard coded limit on maximum number of physical
pages per-zspage into a config option. It also increases the default
limit from 4 to 8.

Sergey Senozhatsky (4):
  zsmalloc: rework zspage chain size selection
  zsmalloc: skip chain size calculation for pow_of_2 classes
  zsmalloc: make zspage chain size configurable
  zsmalloc: set default zspage chain size to 8

 Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  19 ++++
 mm/zsmalloc.c                 |  72 +++++----------
 3 files changed, 212 insertions(+), 47 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

