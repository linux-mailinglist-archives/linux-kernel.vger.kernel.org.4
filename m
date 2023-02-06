Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC768B895
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBFJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:26:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B72721
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:26:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m2so11495606plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFKPLurvqWooNuoOnn6B72qjJ+oeiTEoNHbNUCWvH4Y=;
        b=SVCALRuYLc+yQPSg0ia2xc/8nN747k8/pNkf48/Dj7hbMPmTTZzDGe3uPQOVG0QCp4
         HMNC++cBBeqviPXTmrDKlyRFhdBcLXMHRkXVOu4TBvrc381TGTSKG2hf48znHGeOMXbh
         ffgNN0Nv0rNsAPBFD0CNX3N+286VXOGqjVYGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFKPLurvqWooNuoOnn6B72qjJ+oeiTEoNHbNUCWvH4Y=;
        b=dtcNwqi9E0URmGcwUWNHLmRzmSsVrrVAB1p+CrIrOTh19clqm79Xt6iBZjiniJhVPe
         3cMtwEOH973hiGUH22HdsmDAak+zfQ6sAQ+lWpfRJ1AxHzMguuT1gMCKdFzEa51R6kYC
         CQHqpRvACqDpXg2edxJ/ly8lI2PNrvegNd0KUgLTQpvh2kWMhAfubJAN/2EGJbQgL3fn
         wjr/KYqj4eyJOHGDpW2pU2Zv4JfN2i8Xmr86D07ABOKgYH1+p7ucOOxB9RUI7IVYzZt7
         Me8LfEPuk53ybxdfHkrlX1tmuvyQpMvR1dwwPoVxahNTfwwb6XodFBN29mRBllP8PjLg
         ex0Q==
X-Gm-Message-State: AO0yUKUkI1WeP+270BhmEmZUiHce3hKQFRl2DlS5+kSiKe/nIaDT/iUV
        QZfhxe1nMdWlU5tapWgozSNxk/qHw9SlieGk
X-Google-Smtp-Source: AK7set/GiztZW5rp9T9XWQiapa+PfI9oSx5eViTJnm9sy4SVTDmEGmtY1rkW4/qwDyKtXOkuzbJHng==
X-Received: by 2002:a17:90a:1a5d:b0:230:cc81:ae52 with SMTP id 29-20020a17090a1a5d00b00230cc81ae52mr1257627pjl.9.1675675571418;
        Mon, 06 Feb 2023 01:26:11 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4a1b:4fdb:174d:8f36])
        by smtp.gmail.com with ESMTPSA id ga23-20020a17090b039700b00228f45d589fsm5663008pjb.29.2023.02.06.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:26:10 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/2] zsmalloc: fine-grained fullness grouping
Date:   Mon,  6 Feb 2023 18:25:57 +0900
Message-Id: <20230206092559.2722946-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

	zsmalloc has only two fullness group to choose pages from during
zs_malloc() and zs_compact():
- ALMOST_EMPTY for pages with usage ratio equal or less to 3/4 of total
  page capacity
- ALMOST_FULL for pages with usage raio greater than 3/4 of total page
  capacity

This leads to suboptimal page selection for both zs_malloc() and
zs_compact().

This patchset reworks zsmalloc fullness grouping/classification.

Sergey Senozhatsky (2):
  zsmalloc: remove insert_zspage() ->inuse optimization
  zsmalloc: fine-grained inuse ratio based fullness grouping

 mm/zsmalloc.c | 253 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 156 insertions(+), 97 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

