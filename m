Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1B64CEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiLNRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A16284
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671039987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MRU/7YOQt2xy6rWvIiu4YOafJ8TK5XKhpXf423rIVa8=;
        b=KJOqLkvRRyEtnh8BZAxyCweUMn67kgNTs5f+Nu7BzFzvmbhtRw2qPgoj082BYu/gKaQzdL
        LuAyJtFRiWeGXC7J0ByTmWdssJUNYqGZZQX0T+MTLwD5NvvRbBKFpzHqphNxPo1nLaeI7F
        ptOkl7BNu59EFtW5xs2Q1OS3sG5buJ0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-bIugAmTfM0mDJcBmKfLhMA-1; Wed, 14 Dec 2022 12:46:18 -0500
X-MC-Unique: bIugAmTfM0mDJcBmKfLhMA-1
Received: by mail-io1-f69.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so4267454ioj.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRU/7YOQt2xy6rWvIiu4YOafJ8TK5XKhpXf423rIVa8=;
        b=acGlVSyL0JE2kC22CLcWpP3iFlFlBltdC6OfLMwxq6znLg3xMEPBoPN0pZcL6lGVrm
         njCOVikbpyRKgs0MExyQAeDiGavsVDez0NRVSMadKKlbhHHBLBdEVJ3P26r1bQdVbd7N
         51X5EZWLgd/cIHZ2cn1JgVG0Bm+fADZoWRUmoPiJHdg09lG536Pg/WvobR3ASrh4IRUs
         CY5GBd/HT0EM2u9Agy+SMI36rbiYdAe0/cWutpJ9fUxTENxkaDgslZxO9ovS5ywjcb0V
         SEVfGjvlrgSyUIgQGo3yas8jPlyELUQsHaq01NOu4xnICFScynXlUh6cjruwS0fc3PgA
         9/Tg==
X-Gm-Message-State: ANoB5pkn2F/TWdh0qIdlkBWr85oo4FZye06ZSI84/xkw1dA6u6e8zdH3
        23y6HjFl2WTYL0H8ISSJ2UWR3SAYwWvtWBXVEfACXZfeD6ZybfKEUz1gJXKJEYsIoif0ZuAZFRL
        2gJXTuqDq8tGBho1TBSqXYBFg
X-Received: by 2002:a92:d644:0:b0:302:3883:e567 with SMTP id x4-20020a92d644000000b003023883e567mr12733990ilp.29.1671039977125;
        Wed, 14 Dec 2022 09:46:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4SQFXckK9/JRL6xKFoc8c9f5Tf7g8nePOQ32v8JjKhIjrT887ZPaM+qLxN/EXk8MQ3BE7Eqw==
X-Received: by 2002:a92:d644:0:b0:302:3883:e567 with SMTP id x4-20020a92d644000000b003023883e567mr12733970ilp.29.1671039976890;
        Wed, 14 Dec 2022 09:46:16 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t11-20020a02b18b000000b0038ab4a09610sm1898401jah.112.2022.12.14.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:46:16 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: enable crypto userspace API
Date:   Wed, 14 Dec 2022 12:46:07 -0500
Message-Id: <20221214174607.2948497-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_CRYPTO_USER so that libkcapi can be used. This was tested
using kcapi-rng on a Qualcomm SA8540p automotive development board.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..cbe4ed6403d0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1370,6 +1370,7 @@ CONFIG_9P_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
+CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_ANSI_CPRNG=y
-- 
2.38.1

