Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7F682CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAaMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:35:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD536298F9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:35:13 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 74CA641AC7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675168511;
        bh=ueQfyKF8BlPF+R7M5uaK1t4wPoccd5BHGE7Whcp4jsA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jszm0xWwOwIamrip4oCB3bBeUY+JfjunatbLXcxfaDafcYKp6F3KV5DKrwocKV0ZY
         mchTkRugPGxkLGnkXy3fwafuNfA6I5DUI/UkwNmdpPr3kvH3ysIDnQNAQnsB7pgeWe
         ixfNHmcWsdZDhX37VSQSxEAp70X8lsUAbzR1v+i6pdwqDQcgd4Be2U5QS5OWM+oe4k
         Uwg3b3AshpEzeMCEAAFmLD2OyBnnqbYxxil8uv7jdl0mSwZVKnA6S65/r2G9gHM9Ad
         STtaNcj7AX0XEdj/tR4Z0A1lvDk8CNgX2hx5aO0Sa462OIR1tWqMoMhaPlFSFSA2tt
         V0+0ZuQ7zf6MA==
Received: by mail-ej1-f70.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so9511854ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueQfyKF8BlPF+R7M5uaK1t4wPoccd5BHGE7Whcp4jsA=;
        b=NGRWJI/b9f7+VELMI0bWvUrOBLHMGwer/wsFNRRu7pO2pz3zkhqSKrm8XWkpO7qet0
         DOW7ahAXuF7Tnzmu7azcRr52O3lDjfvtNPu5bkDMzWOgvKaR/uVww9T1e5MYb8h9F0XA
         M+sx/aIikr/+pLf0udayydRHP/RRtG9Aq4jh9oj4avP7fh90FP2KQkw+dw/WESGFxhPT
         /aBav2CnKZ2hqhPCkmBaroqAvQGRmYnEcJ9woVNTODK/6HzDgfoSYAKJGwRL5K4fsObi
         PbbplnqCmb7Ds8P2foM+EPouNg7vyT6xPFCCcoKDZ4TqRGP0oI/9dKDMOVfk1Hq3j/Z4
         +qrw==
X-Gm-Message-State: AO0yUKXaAsb1+okrF09sZKblcIM6DsKVaCVmVkhGRMV0X+JHlVJLlLqS
        a6rRiJ2qOPZLf8a+EW63dgfj4TNRR/DAeRj5fO65qWvHNxRf/aDcg0uqLULqpYpEvoY2MN3eVdw
        8PoewMZB8JoU3T8JAx2IdriwwdFzHRfZqldnrcWZfdg==
X-Received: by 2002:a05:6402:4d1:b0:4a0:a7d8:500e with SMTP id n17-20020a05640204d100b004a0a7d8500emr25819589edw.20.1675168510690;
        Tue, 31 Jan 2023 04:35:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+zhJgJ10F2JvGPNmG1Bjo6DZcP4Y9AkOapRMpD3BBbyBUK6HSSV7KfW6UKjkqN7ZU3DgtMFQ==
X-Received: by 2002:a05:6402:4d1:b0:4a0:a7d8:500e with SMTP id n17-20020a05640204d100b004a0a7d8500emr25819576edw.20.1675168510511;
        Tue, 31 Jan 2023 04:35:10 -0800 (PST)
Received: from amikhalitsyn.. (ip5f5bf399.dynamic.kabel-deutschland.de. [95.91.243.153])
        by smtp.gmail.com with ESMTPSA id a66-20020a509ec8000000b00482e0c55e2bsm253001edf.93.2023.01.31.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:35:10 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     akpm@linux-foundation.org
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add entry for Alexander Mikhalitsyn
Date:   Tue, 31 Jan 2023 13:34:56 +0100
Message-Id: <20230131123456.192657-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My old email <alexander.mikhalitsyn@virtuozzo.com> isn't working
anymore.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index ccba4cf0d893..49b0c280b561 100644
--- a/.mailmap
+++ b/.mailmap
@@ -25,6 +25,8 @@ Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
 Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
 Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <alexander.mikhalitsyn@virtuozzo.com>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@canonical.com>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electrons.com>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
-- 
2.34.1

