Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8AA5B4D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIKJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIKJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:59:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96D1111
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k12so4212513qkj.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=05QawunNkBTDZNRfoCgb3ddj6vEbyg8mxMOwfq8BU7w=;
        b=FITg0qC1SJ9aTWSShCLy+0XEwLiqqzm16acwEyJX+XAOfrkrL3gQKFBN6iNFjhoHZG
         EYZSqPwq89StyoiXOzPi38OdVfen6Kch8+/0qdeqz32WP9rIf/YfnNlK9jiEjdznFivN
         AWmO7rucIghTBighws2gKH3KXmkj8HoMUlZFBEiOrRJ3AiTCYs9aOifMWtWN6LwtdZ9Q
         gvQ28/d6rSLqSZWi9KMMqD5dqriCMSBexYGH4bchWXrRUAM6shbXX1zRtugVZ+iidlYX
         OtB+AesCotlHvIHNl28PHVO62PQklu7/96OO8IaLxQocXyu9UWL4GRPuzYDaYlM5l80F
         PvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=05QawunNkBTDZNRfoCgb3ddj6vEbyg8mxMOwfq8BU7w=;
        b=Wu71RQIU4zN8rFqPpMtdAHzRbXdZbwwLqH/Np+tLeQCKcUsonba+axMNdpfIdSwgCB
         uehKdB8Uzc5JFJHoIlq+xV6vwvs2Tp+DKaLXtg5BESxbCsdHBXbEo2aIjDzmNs5qrEB0
         tCbbvElabF4UCnFosE0gP7HUTydoCPIaQdYVUQDHem6ibNwXkG4xJgwsg+IptUE59Ccb
         eRS0vmlZTTDIDsXzJcjcrKsxdBUWarvwnENDjgqLkUb4EIu8lC1Imh7EkP98CUhywm96
         0hCk7WE6xnMwRxf17xCl/joN76+E7O5z8KJ4r9D+99M3rIDfSNFi8ogpwxnSTt5dLKgb
         BFuA==
X-Gm-Message-State: ACgBeo0rM7v/7nWZlBp+JiZsrQ5WWzPfvLMEM2+U0LQyKbPQf5ZC7svk
        DtCXpU7LpDu4AXQAYt5amFWwrw==
X-Google-Smtp-Source: AA6agR71DltUgDiY2jCMkxrf+AZs/phfKSzHNt2mi1NjERR2m+qoQs1XuGvQYq7t2EcHdQja6Z5EDA==
X-Received: by 2002:a05:620a:144b:b0:6cd:5fc9:372 with SMTP id i11-20020a05620a144b00b006cd5fc90372mr7364483qkl.452.1662890368474;
        Sun, 11 Sep 2022 02:59:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006cbd60c14c9sm4625233qkj.35.2022.09.11.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 02:59:27 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: [PATCH 0/3] page table check default to warn instead of panic
Date:   Sun, 11 Sep 2022 09:59:20 +0000
Message-Id: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Page table check when detects errors panics the kernel. Let instead,
print a warning, and panic only when specifically requested via kernel
parameter:

	page_table_check=panic

The discussion about using panic vs. warn is here:
https://lore.kernel.org/linux-mm/20220902232732.12358-1-rick.p.edgecombe@intel.com

Pasha Tatashin (2):
  mm/page_table_check: Do WARN_ON instead of BUG_ON by default
  doc/vm: add information about page_table_check=panic

Rick Edgecombe (1):
  mm/page_table_check: Check writable zero page in page table check

 Documentation/mm/page_table_check.rst | 16 ++++----
 mm/page_table_check.c                 | 53 ++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 20 deletions(-)

-- 
2.37.2.789.g6183377224-goog

