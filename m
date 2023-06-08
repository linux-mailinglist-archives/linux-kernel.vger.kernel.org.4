Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2EB7277D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjFHGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFHGwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:52:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5AF173B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:52:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514ae02330cso46962a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686207132; x=1688799132;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AApGBls8JQyZYvibg1v9QuUQ1wNmSNLlZC0v6OInY7s=;
        b=mx+QD9xiYnSO+K49SLPU1xOnSvH7+vYqTO6sPwiMbeYcJ1r8yW+vF4HkBGw6jODTDx
         UDn1nAuFZnxPa/6PHmMbzVdrojbA03MwvLyP84PlYKEEHTWOZHi6GpxXW15lUeCdowgS
         RL25wMc1jdGD7kmqYODx4zRZHuTlvQvVQDot/am0g3XbIavpy8ndF9dOfrBbnGU56jg1
         PzdoUVBMmvf/EnFUVjlUvVQIGU64rHJD6i3XugMQGpa+B09xxDqTe6xgLvm25hMqad/k
         UVOEcL4oun7GeOiL5Bq7oI0KlmNrQIYtvXb6EUN05aI/yjPo+RMqAYFpll4fPmHjCsWI
         CeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207132; x=1688799132;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AApGBls8JQyZYvibg1v9QuUQ1wNmSNLlZC0v6OInY7s=;
        b=SYRBJQKvW0iqy5fa1eIxyO9varl9LvGmdn4RmrkZjCszBOLTLEuyDgVURhzGX0lR9i
         RtZH0qk1XzTjTXqGYoWrCU2GdvxTND7SrMe2lI8dmm+q0xfp1cCgEx0G8JW9jEMMPDgj
         +HXpc1xA25TPe4ou5xGtgvcQ5eRPSjnli20nzlDoGQ39s4xLM4UNALQezdfl78hvgv2R
         m1gIxBqmnztVlrgok0yRFZ+AZg/M5RUqvt4jeHVD2comvOwoh36Jg2KhPT92NVduSu3e
         qde/rIx4NpsJxFeSfPQA3aNA2jrQAbTiD86Z49wVq8FBkMrddZqK0VislWZD7xR5pfRg
         DeBg==
X-Gm-Message-State: AC+VfDxbGxWB0L5Tv66pKYHcgXdJrxgSuGbVYGDNnafqWl3azujEnqbO
        cNchgA2to/rbEr+7XtyMecY=
X-Google-Smtp-Source: ACHHUZ7PYSyOdvHHRlEizjcsqjs886tH/M4fmlSAty4EUnDcSjIU2PAjola7RqiGuk+D6ZDBKg7aUQ==
X-Received: by 2002:a05:6402:4303:b0:514:7874:ca64 with SMTP id m3-20020a056402430300b005147874ca64mr4351214edc.0.1686207131851;
        Wed, 07 Jun 2023 23:52:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id g25-20020a50ee19000000b0050bfeb15049sm179474eds.60.2023.06.07.23.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:52:11 -0700 (PDT)
Date:   Thu, 8 Jun 2023 08:52:09 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Use standard api to calculate
 frequency <-> channel
Message-ID: <cover.1686166624.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard api to calculate frequency to channel and channel to
frequency. Usage of cfg80211 is required to merge driver into wireless
subsystem.

---
Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (2):
  staging: rtl8192e: Use standard api to calculate frequency to channel
  staging: rtl8192e: Use standard api to calculate channel to frequency

 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  6 ++++--
 drivers/staging/rtl8192e/rtllib.h            |  2 --
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 22 +++-----------------
 3 files changed, 7 insertions(+), 23 deletions(-)

-- 
2.40.1

