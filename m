Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B639BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiK0RLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0RLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:11:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16819B1D6;
        Sun, 27 Nov 2022 09:10:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so12568830edb.9;
        Sun, 27 Nov 2022 09:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3J2xzWHIw55DDcC/Xx1Keqro9xP3bkWfqBSr0xjIc8=;
        b=OwTDbKi7orj8bjtZEIajGIWFwbXQOoaWTopvxPMNlIjAmEj15b1eBU09bL9l6Vkajf
         S+okTlIAhtMICgzJqFDKern6feAuD1rGdivxv3p2Y7ghl8VXaGY93X40PC0aYSm/FqTl
         lsOOhtMnZgK+ANelc+Mbx3mZY744MWhFqKk+4NtJ21IAp9NuQlEdZAIA33s74DH32/TW
         +CcfcpEBWZjFSGO3hP9j21fx2SrKJ8IZ1IXem4ahfeEtCZbqSrFqZiLCd+hYLsty1a2x
         HEWEiJC998EMCFFGfFSbumI+IalG3LYxuHmj21eInlXhk8lfX3ChXaujZuvaIYB+DSQn
         +bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3J2xzWHIw55DDcC/Xx1Keqro9xP3bkWfqBSr0xjIc8=;
        b=iDg/MDd1RcutkA4l3q14ZCceqBQ0n/o3UB/YNFSsRdP5pdO8oSz+lA/NpuiOWj7753
         UOivvuf5cK4y5FQTKqbJXpR2hvhwAiFU6LpH27J0JGpD+13yZq5tnvXHzeQnd/7mDr4L
         yyF24OrjHuNGzg21g9KVOrju+52+KKB/QfsOhcAiVcuOzE2nHsATCdt7ZyGjS56Cs3kR
         81oQD2h3zTx1PgmpGYJR3AzHNLAVMTWmon74i9VNls4kF9SGGGw1uwN/gJJ2zVwhfGRo
         v2xhmFXRlTH/7q1ExuJJxNXatY0YcFxL9C6KT7W0jJ6mSDvoJI+AnzrTHKeozGlyX2L8
         1GFw==
X-Gm-Message-State: ANoB5plDolei0G/H0N4kOeCeW5lX8jexwoeIEtrLcn+VriE1LkE5wVnT
        GlLDVeLbEQF+qE1BsbpNpmJUd6aDaRKLSg==
X-Google-Smtp-Source: AA0mqf6neuQ9EqC6RFsSYbHbOsIX04C4NAXbcV9uRns4K2+bDEGZjH7PYYPN3pNe7Q96AOddG2qVGg==
X-Received: by 2002:a05:6402:1045:b0:461:68e1:ced5 with SMTP id e5-20020a056402104500b0046168e1ced5mr34948365edu.142.1669569057211;
        Sun, 27 Nov 2022 09:10:57 -0800 (PST)
Received: from xps13.. (77.241.128.90.mobile.3.dk. [77.241.128.90])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b007aee7ca1199sm3990394ejo.10.2022.11.27.09.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 09:10:56 -0800 (PST)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Bruno Thomsen <bth@kamstrup.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Subject: [PATCH] USB: serial: cp210x: add Kamstrup RF sniffer PIDs
Date:   Sun, 27 Nov 2022 18:08:11 +0100
Message-Id: <20221127170811.7141-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The RF sniffers are based on cp210x where the RF frontends
are based on a different USB stack.

RF sniffers can analyze packets meta data including power level
and perform packet injection.

Can be used to perform RF frontend self-test when connected to
a concentrator, ex. arch/arm/boot/dts/imx7d-flex-concentrator.dts

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 3bcec419f463..f6fb23620e87 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -195,6 +195,8 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x16DC, 0x0015) }, /* W-IE-NE-R Plein & Baus GmbH CML Control, Monitoring and Data Logger */
 	{ USB_DEVICE(0x17A8, 0x0001) }, /* Kamstrup Optical Eye/3-wire */
 	{ USB_DEVICE(0x17A8, 0x0005) }, /* Kamstrup M-Bus Master MultiPort 250D */
+	{ USB_DEVICE(0x17A8, 0x0011) }, /* Kamstrup 444 MHz RF sniffer */
+	{ USB_DEVICE(0x17A8, 0x0013) }, /* Kamstrup 870 MHz RF sniffer */
 	{ USB_DEVICE(0x17A8, 0x0101) }, /* Kamstrup 868 MHz wM-Bus C-Mode Meter Reader (Int Ant) */
 	{ USB_DEVICE(0x17A8, 0x0102) }, /* Kamstrup 868 MHz wM-Bus C-Mode Meter Reader (Ext Ant) */
 	{ USB_DEVICE(0x17F4, 0xAAAA) }, /* Wavesense Jazz blood glucose meter */

base-commit: faf68e3523c21d07c5f7fdabd0daf6301ff8db3f
-- 
2.38.1

