Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3353D62384A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiKJApE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:01 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C4510577;
        Wed,  9 Nov 2022 16:45:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v8so276240qkg.12;
        Wed, 09 Nov 2022 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlZX5OoXSR6dQu6BFUXNsw0d4qkRtcYOShuOxFg1Iz8=;
        b=clS4I7+fvJvuEFtwnJCI5Ij2i04DoGO8TvRN2+Oe9DEtu5VupjIhF2nvqzv3ufjwfM
         +LuKvWh9F8iDBqYHFjPEEpl5pSVITlujaQo6nOc1VKvxPzpw/a3st5EtlLoXRHplUI/n
         Hkju3Ks8Wvsc9RegrJ1xBlFM7V72ycNWzhG4Qp4YDAL0NZZTqKew9WC4y1rIp7XsfIAj
         A3+hwDW6ahsiMs2T2iFQARbXL6ljst6bn2PswExnYEfOaYFPBsYpY9NFdaLMSKKoVGDE
         S7JIBhTkf/pA1jye6pwXm+f9ZjhSybdYKrwqPaJq5eIuaumyD6Nt37vxaQ2nxs0XB0dd
         yAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlZX5OoXSR6dQu6BFUXNsw0d4qkRtcYOShuOxFg1Iz8=;
        b=3by7n7y+ZH3oZPuzz2r4fXTByBd0loRs3WBa1zmK+9x7gseuiIzEIGgSyBrLDAP+h9
         SXAuMewKNp9cvulODOpbl8Q8aJaSWSW4fQwuVZzAglAoGllZb9itc3dw0H/o9FiU+imY
         G4SQhOUNYqtS96Ink/nNUCS3gOdsyDrh6ARQT45MRcxnwI7XvbE0W14eLEE8ghZeHBFL
         RsrmRPMAU2Zl+ZK45KlT9e/sEOTQQFepjyTB1gYijOuILtO5JCKBL9rGPd81le9dSyjS
         QnpHF24BifCXix3PsYD1WR5QIjvYJePjeKXU2C7nhiMgOumXOUDAkBJsT8lQy2+828LB
         wHyA==
X-Gm-Message-State: ACrzQf16D0Jn5A0h/SpM3XYlH4kAQGj9ubVii8+VVUGUAV51Ueubv1+K
        OozxV/tvOPYY+JTa9YTL+S49g1JYaf7NyQ==
X-Google-Smtp-Source: AMsMyM7VcbFAoqQFEoZJrNxKTjOQV6SK029qE8vzEA0Sy9MM0U6VJZbH8NJtUzZMQ2n8Cv0jdnRodA==
X-Received: by 2002:a05:620a:25c8:b0:6ae:ba71:ea7d with SMTP id y8-20020a05620a25c800b006aeba71ea7dmr45719850qko.547.1668041099611;
        Wed, 09 Nov 2022 16:44:59 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:44:59 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 0/7] serial: liteuart: add IRQ support
Date:   Wed,  9 Nov 2022 19:44:43 -0500
Message-Id: <20221110004450.772768-1-gsomlo@gmail.com>
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

Add IRQ support to the LiteX LiteUART serial interface

Changes from v1:
	- split minor cosmetic changes out into individual patches
	  (1/3 became 1..5/7)
	- patches 6/7 and 7/7 unchanged (used to be 2/3 and 3/3)

Gabriel Somlo (7):
  serial: liteuart: use KBUILD_MODNAME as driver name
  serial: liteuart: use bit number macros
  serial: liteuart: remove unused uart_ops stubs
  serial: liteuart: don't set unused port fields
  serial: liteuart: minor style fix in liteuart_init()
  serial: liteuart: separate RX loop from poll timer
  serial: liteuart: add IRQ support

 drivers/tty/serial/liteuart.c | 123 ++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 43 deletions(-)

-- 
2.37.3

