Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B690A61FAEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiKGRPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiKGRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:15:10 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5D1C42C;
        Mon,  7 Nov 2022 09:15:09 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id x18so7558789qki.4;
        Mon, 07 Nov 2022 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNZBxRCT6IoAOSKA4oKxRQJpHQcbfNkzKSkfJsFKok8=;
        b=qRICBuBNJv6NB+1PB2j41AL/m8SvYi7+EvVl85EQCCNPH/+jQEK9uTAyfj945g1WMU
         rBWhD5wZfyr4Bs24XemL3APERdst6BR/i0Iz1QpaKX0Nn02tXF8ApsB4PjVgcKes//co
         jhVCbO5K/KSZPQ7D2dSW2qm4wTgHCtXT3CYxm+N08uVSS6fFbiblth8cxKkkWtMVjSsO
         DfdPr6HEbvHryUdo8kTACRaMIqVRfQZtMXrO0GI8KuzUD10QAtdJReVX7FdXWd+J5jBB
         GTRMp5f674A2nePjRtwpdF3a23kzs7O26Vm7ReVa47Nw42JVc76B1WeRBJYSspkNMIEA
         5JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNZBxRCT6IoAOSKA4oKxRQJpHQcbfNkzKSkfJsFKok8=;
        b=X/K8V3rKDgcNXOIiC5Srov4GgXdxg1tQYkiZ50Kd5pPRw8eGbW06pEXbJLDY/I9Ib5
         kCk1mc+bTWrAdV3n+eng7O7utCBNW5GsSi8XRbR8VSmMfFFqEH0AqQFU7B/T9EN9y9UK
         Y8vzPUbyxJ7bv0rSzxlm1AP41N+hPqXgY3m6raLGJBhwile96mksv5dRp920bdn84XHW
         jLh78Pa5JJR0cj7mSE9vsmWlvgTnCWY9Xs6LVWHU8BbzWg3sC7AffgJbogNF+PeO9as4
         fkBDVwypAPct40VGLPIubPh/AbAta8JBwCjrneDp/dNnu8icAWG0gtzNO+Y3IdzJCDgq
         H2RA==
X-Gm-Message-State: ACrzQf1d+T5FQKQBn1iUErDoFbks+f0GhSH/djcjnhndR74F0lz4rsYn
        N1JxAeKVWfAPdlY57Vn3Qt7s1Sr9eQkaYw==
X-Google-Smtp-Source: AMsMyM6Fm9D00A5eYTrA5OD7zVWM0jWQTjM1Qkkzrb+Cs++Ch/5U1B6aI2DpxcQPvwgH8VkzE6I1IA==
X-Received: by 2002:a05:620a:15ba:b0:6fa:ae91:b2b7 with SMTP id f26-20020a05620a15ba00b006faae91b2b7mr8129203qkk.611.1667841308049;
        Mon, 07 Nov 2022 09:15:08 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b006ce9e880c6fsm7333611qkb.111.2022.11.07.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:15:07 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: [PATCH v1 0/3] serial: liteuart: add IRQ support
Date:   Mon,  7 Nov 2022 12:14:57 -0500
Message-Id: <20221107171500.2537938-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Add IRQ support to the LiteX LiteUART serial interface.

Gabriel Somlo (3):
  serial: liteuart: cosmetic changes
  serial: liteuart: separate RX loop from poll timer
  serial: liteuart: add IRQ support

 drivers/tty/serial/liteuart.c | 124 ++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 43 deletions(-)

-- 
2.37.3

