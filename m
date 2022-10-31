Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AA613D88
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJaSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:40:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF0DF77;
        Mon, 31 Oct 2022 11:40:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so2038961wmb.2;
        Mon, 31 Oct 2022 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMgETaAE4cSZ0k4hJhUAcCXN4b9qeptJfCrItoYYMYI=;
        b=gu0KikZeI0bIt0XggQjkFqcYoKXY8TXoey1wf6kgwmriaGpLk68bf8r4BJNdJGSw9d
         a/d5mHoTYv5vGK1vKN6sgbY/eRdxVuHrwq9gIzWO2Gt7ochovMmMxhBLdFHpeyEQhOGI
         AG0hBNxeclmPenIBhCjh48FVT3jBZVCp8y112ZL/G6i7+dLzm/IJtnUXPcd6MUnzgl0Y
         2fZK35rSyVip1kRU2zrZ5Efl2vyA9GreVtaigMXDQ1na98/m3Debqnnn7evrj0SDLoMr
         MFTNsUVmvmFVw3JNHDNiT2+vCbE7IOyin43/yam5p4CRiI58qWxTgeB8WoZ18xG8eRBK
         5UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMgETaAE4cSZ0k4hJhUAcCXN4b9qeptJfCrItoYYMYI=;
        b=1tvFfbkR98woGFkVl99vYXr1Ndslz8PmQX8dybbVZbKZn8xPei+MZWpViFjZkTOk+M
         A0+lHuYeR/4dbYVXGVsn6WpSD6O1IeQUhy+l0FDgpdGRAVUUhLXZhjGRByIIQm7JLP/a
         aw3A2vQl/AJhmU5XdrmW0NJairRTfcSSC7JDcQpesDMG0BLNF2WAmneJ3UJmptFRupi5
         O9Fm9Izd7sGO0bDLAqrTEbBJzdsnTFmG9/wX4lzXCKXQrsgmjsmjtboKIQV8v7wuG+7U
         gvQXcMJnJz5ptp5KnQM0Y4gjDRsyV1xyBll44cJn2/58XoqDhAOItA0vhZLKd93k/6xN
         B/mA==
X-Gm-Message-State: ACrzQf1g3uQ/H4D33NavtjwsaubuTq+nf3k/zlACyucAbraRZb2dz3jt
        0ietxuDcyBUW9c6L7vdOQHs=
X-Google-Smtp-Source: AMsMyM5sqUekBItN5y+a486TSf5NZ2MkgnKD5heHK2bdojq3gb9fZdANpYFY8qwzfXA82d4a0NhnWg==
X-Received: by 2002:a05:600c:21c9:b0:3cf:7833:2940 with SMTP id x9-20020a05600c21c900b003cf78332940mr2003113wmj.35.1667241645352;
        Mon, 31 Oct 2022 11:40:45 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c081200b003b4935f04a4sm8525887wmp.5.2022.10.31.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:40:44 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 0/2] serial: 8250/ingenic: Add support for the JZ4750
Date:   Mon, 31 Oct 2022 21:40:38 +0300
Message-Id: <20221031184041.1338129-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JZ4750 and JZ4755 have an extra clock divisor in CGU called CPCCR.ECS.
It needs to be handled properly in the early console driver.

v4:
 - move duplicate code
 - apply Paul's description for the quirk & commit msg
v3:
 - fix build errors
v2:
 - serial moved into separate patchset
 - code refactored to avoid peek in CGU register
 - Krzysztof's ack picked
v1:
 - big patchset for the whole JZ4755 support

Siarhei Volkau (2):
  dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
  serial: 8250/ingenic: Add support for the JZ4750/JZ4755

 .../bindings/serial/ingenic,uart.yaml         |  4 +++
 drivers/tty/serial/8250/8250_ingenic.c        | 32 +++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.36.1

