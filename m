Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2872ECC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjFMUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjFMUSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:52 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA66C26A0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:32 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-56d304e5f83so28445487b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687512; x=1689279512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyB/1G7Q6i1VsPbRGZZY0Ao+K+/xzftdwFhDXXBFHKo=;
        b=rT3ZajUjJA98/gclSoBr2G07dYWdcxVivJ4ZbeCDyDekxoOUd0VRlMqAI9jSI96zMq
         5zkAR137NaIK9AArfOw4UGXJm64dFFTIffxGsKT78s5NwnnvEe1d2hrrhwIpFdbjmx0M
         9DJj4VEOBMhwqvHyOyL4+wJTAcFpmmXTN4JbAWz3lsXDBMQbzjgcHK3L7VqCWgUDHuW8
         Xx9WG7rjpJKrst5szCbUscP77kyyoPaIgnfdNuvnNWwTo/Ke0ETmaG9euOLx56cqmZ7T
         QaQntFknhqx8t62PObtn9sQZcmKTV57GaDv089HUlnqi372UPhsJnnxJQxhqJS6HocCs
         LOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687512; x=1689279512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyB/1G7Q6i1VsPbRGZZY0Ao+K+/xzftdwFhDXXBFHKo=;
        b=gmf5nH9LNVjlU1VdYF81c675ZvMgE0J8jP37tSnoBgYbrcvVN47iqck7ZoIq27XktI
         eccTRVyQn0Ja5u5/6HID5070qWDSqc8OCrJ2H+SSyjAxW0Lp8eHJsKhpKporTFcLpOUt
         I5Q/Kg70KCnoac0COkQW8JOwyAFXI448uE9gc5Gspi1bUf+UxhZb+PN3WdG83mU4KML+
         079nfLjgcQOeJgplN8OwZX78VADLQGHu5bqtus36hRkpSJBEpwiBjBKO5p37YpitxlJS
         U9TFd7V1/nqtZHvJpvTSpk2b0qeKz75LTCdXr9F7T9S1sCZ35XlFmo+yttRT8LGmEqsG
         7cIw==
X-Gm-Message-State: AC+VfDyjAIza+H3eoFucfxIO3XQeR3khRgqGE+0lKo8NZ1X9wWiGVpiU
        Ah3WAMky/GVCnB5bZymAJKA=
X-Google-Smtp-Source: ACHHUZ7J94Vx+rGd+gUj3DLifI71dxZiejNib8jaZXkwgAP4oore+1c4cGdUlczTBQ3Y+kZWouTfaA==
X-Received: by 2002:a81:93c3:0:b0:561:8602:1a40 with SMTP id k186-20020a8193c3000000b0056186021a40mr3287779ywg.46.1686687511835;
        Tue, 13 Jun 2023 13:18:31 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:31 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/5] Replace is_longterm_pinnable_page()
Date:   Tue, 13 Jun 2023 13:18:22 -0700
Message-Id: <20230613201827.9441-1-vishal.moola@gmail.com>
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

This patchset introduces some more helper functions for the folio
conversions, and converts all callers of is_longterm_pinnable_page() to
use folios.

Vishal Moola (Oracle) (5):
  mmzone: Introduce folio_is_zone_movable()
  mmzone: Introduce folio_migratetype()
  mm/gup_test.c: Convert verify_dma_pinned() to us folios
  mm/gup.c: Reorganize try_get_folio()
  mm: Remove is_longterm_pinnable_page() and Reimplement
    folio_is_longterm_pinnable()

 include/linux/mm.h     | 22 +++++------
 include/linux/mmzone.h |  8 ++++
 mm/gup.c               | 88 ++++++++++++++++++++++--------------------
 mm/gup_test.c          | 13 ++++---
 4 files changed, 70 insertions(+), 61 deletions(-)

-- 
2.40.1

