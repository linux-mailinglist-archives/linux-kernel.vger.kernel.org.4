Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68964B348
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiLMKfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLMKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:35:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9ECC9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx10so15153084wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ+oG18BpB/sUkSsgGkM5HhNA1Kuu7R1xdDpK29jyxM=;
        b=aJuA4KSQ/36OgI+ArvCuLzBTlSRB3Fpd8xFXsuy7ONz5DQfQiQG9yBEgRCVCBF5X6x
         okvFEm26de3qYfrCKwrbeqeGCPDZHvyJvcOs3AhhADkAPMBNC0m9Zo37Wg05Dck4RiPf
         Rq97sVpIuVkOLFFy9o1wr6p/qckk4v0OsZ4B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZ+oG18BpB/sUkSsgGkM5HhNA1Kuu7R1xdDpK29jyxM=;
        b=eDJaH/5tteG7JjGQSZXAuhttpJIPvJYlUXJzTh4CoRCHPB2q5zgIdRt1raS481pOIL
         LFmyv93Aq+l1chvzp70AlaUjSE1N62+xDe1VnV1734YpBSSQNfIryxdVgSckMrbxRrLs
         qGG59plydAixebZNgtkPrBLq/HkkSQIiraiuF+ZEmjqAHcukvvXpLkuOXywP5tfScLcm
         4lAty0L+k2jQdiaAcYVOnP98ZReRG7I62tyUPcyO9zuVwAEfvgrGQoXJPyoFhmedU8hT
         yhbxUjaRTvMY5kHdNEesYQByHyUwoW/btQTVTq2FonRlKZ20Sa4/NOfp/G12K9ZETHKX
         fqwQ==
X-Gm-Message-State: ANoB5pkBb75a6pFbf0TUvy08NHYsFD5WHz1K5kYat0QIjA4OyDEPCgIn
        GJv/+F8uKWIh97+EQUUFSTc6ug5aijZA+l8w7MDKguBaPwcriYfUxuuAVaHn4M5MQo1RLRHkVuY
        5aIltjGSMRt6YdB5FyvjSHpPhK99Z7t9XgKSUEZQEDF9ZleP1kBG9gWasUhHi9t2rY12gbH17pV
        KNzrnjLc+9xsAM+QtQfL7p
X-Google-Smtp-Source: AA0mqf66Zql6jry4QfggPK7QEtCs6cQstXlGjXP/tk50ybF5XQlKTNR9cOe9MU2KbqQ5FWX0JqObig==
X-Received: by 2002:a05:6000:38e:b0:242:2390:15a with SMTP id u14-20020a056000038e00b002422390015amr18597161wrf.71.1670927702723;
        Tue, 13 Dec 2022 02:35:02 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:a0bd:cef2:7a82:b529])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002366553eca7sm11295813wrw.83.2022.12.13.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:35:02 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com
Subject: [PATCH v2 0/3] Replace invocations of prandom_u32_state, prandom_bytes_state with get_random_u32, get_random_bytes
Date:   Tue, 13 Dec 2022 12:34:56 +0200
Message-Id: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David <david.keisarschm@mail.huji.ac.il>

 The security improvements for prandom_u32 done specifically in
commits c51f8f88d705e06bd696d7510aff22b33eb8e638 from October 2020
 and d4150779e60fb6c49be25572596b2cdfc5d46a09 from May 2022)
 didn't handle the cases when prandom_bytes_state() and prandom_u32_state()
  are used. We have now added the necessary changes to handle
   these cases as  well.

David (3):
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Replace invocation of weak PRNG in arch/x86/mm/kaslr.c

 arch/x86/mm/kaslr.c |  5 +----
 mm/slab.c           | 20 ++++++++------------
 mm/slab_common.c    | 10 +++-------
 3 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.38.0

