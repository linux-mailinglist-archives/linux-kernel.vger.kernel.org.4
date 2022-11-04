Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A1619E44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKDRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiKDRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:16:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE832BA7;
        Fri,  4 Nov 2022 10:16:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so5102850pjk.1;
        Fri, 04 Nov 2022 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5KS79M5S1sveLfe1zMPMHe02sw00ENM39EcOJ2UpjU=;
        b=RhNCT2RKZYmehPwYURClj2BoXL6iPjh69O0IXfi3Jpy58k0lCjSUYmA6yVSSkJAAHH
         9Wdq5WKMehoWOUNIy9r54MpYPuYRL9OJFu07BXz3bkRAvlm0FAH8iy42eF2ZbJG4q/Rk
         pKEhKO4GSxSmXQ41CKBp9HEpXh1c9yc6rLXl3xPRHiwgsRjJXEQjO8tAxoHlEeEIDVks
         wSVOWzpw58sxVFwSy3nuZj8FG3RnkuuRzAqVLFcCpSXlUJ3AWBujVE7kka4LY9xs/ZrR
         a+FaiqtpoLUnQLcWaJUm6/OwHpds0MBv7FSOj2KW2LAfIla6W/0wVDimshs+KM6u12Xx
         UnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5KS79M5S1sveLfe1zMPMHe02sw00ENM39EcOJ2UpjU=;
        b=o+KZmLzfAbqrx0n6sgRC89VTcKi+uihPCj3b8QTARTPe81Oz/1mu08DK+UPSWpb24W
         jsar6Nj0lCkyw79FjJWauy9iZkTmC6OhQlLguvThYi1QF9tBTXEipnOlmkD7JuUlaBen
         d4DPkHrD4HXb4EhSVZD34pyXZS60SGZ9GGjbgWuPIjuKXJloMs2AJfRPf38xZYnaxi0f
         Zmg20s8dBDw3fAMYSknDlSnltTeeTOeopCBTkZVWNmkqp6ECXQJwokNz63rxqJn6OXuy
         MQDJM3zPHi19vh/OZJHtPXvFlDwCvHUsCgi40bZuGi2mu1N+AeoYnR5w6h6H3iK0bWa6
         iNAw==
X-Gm-Message-State: ACrzQf3ud3oyhVtJb3SwLSZ2pqtndpH02LxloOqYfcNCFllJOLLMVYkq
        EA1XPyg5FhHS5+iCEzrkeZyZuy2y5HE=
X-Google-Smtp-Source: AMsMyM7/6/cUj5YvpTrzjB5O1p8qruE1FX9H85tTANK1LbnH7sIxYOJYlFZunQ13GQXGngQbhAz4fA==
X-Received: by 2002:a17:902:ef89:b0:188:5e9a:c665 with SMTP id iz9-20020a170902ef8900b001885e9ac665mr6737942plb.62.1667582194113;
        Fri, 04 Nov 2022 10:16:34 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090a450f00b00212c27abcaesm1917655pjg.17.2022.11.04.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:16:33 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/3] can: etas_es58x: report firmware version
Date:   Sat,  5 Nov 2022 02:16:01 +0900
Message-Id: <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this series is to report the firmware version of ETAS
ES58x devices through ethtool.

The easiest way to do so is by using usb_cache_string so that we do
not have to manage errors.

First patch exports usb_cache_string(). The second patch then does a
small cleanup in the existing function and replace existing code with
usb_cache_string(). The third and final patch reports the firmware
version of the device to the userland through ethtool.

* Changelog *

v1 -> v2:

  * was a single patch. It is now a series of three patches.
  * add a first new patch to export  usb_cache_string().
  * add a second new patch to apply usb_cache_string() to existing code.
  * add missing check on product info string to prevent a buffer overflow.
  * add comma on the last entry of struct es58x_parameters.

Vincent Mailhol (3):
  USB: core: export usb_cache_string()
  can: etas_es58x: use usb_cache_string() to retrieve the product info
    string
  can: etas_es58x: report the firmware version through ethtool

 drivers/net/can/usb/etas_es58x/es581_4.c    |  5 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 75 ++++++++++++---------
 drivers/net/can/usb/etas_es58x/es58x_core.h |  8 ++-
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  5 +-
 drivers/usb/core/message.c                  |  1 +
 drivers/usb/core/usb.h                      |  1 -
 include/linux/usb.h                         |  1 +
 7 files changed, 60 insertions(+), 36 deletions(-)

-- 
2.37.4

