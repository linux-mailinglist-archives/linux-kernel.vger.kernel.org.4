Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0164473C701
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjFXGCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXGCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:02:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E5271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:02:04 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b2e1023f30so1307623a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687586524; x=1690178524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csp/Ru/rsPdrsyLLiC9Gguj9U+Fgh5fKjxfjDtdRMQc=;
        b=gS9kbMULFiG5NJj1EiFPcDYOOAup9/tIYjoErj5QPwPUKfxlRIHemxYeuuGkT5IQ7O
         c7q1PnCnFxwmLm5wqs6wVNDP5EQtrHa797c31u61Sgb85CyTExELo6fgumeVKtazTkyK
         Z0tONjwKKfwuqUa0VYa6gAf1NOYJjIRLgduxS9PxrqNq74VKXp1RulJr+WnM3zLjPrG5
         Zo0uawG94qyB46FVOaEEYDmgx1l4uSMAuNQUM1KfWD+PiwXcUnlLfyYnt00jtZp34JhC
         q175zRHArEOYlIBtL9cu4uFsnh1rrh3BGoc9HuBWEuyyP94jOMRtugS15V/YXnhSUlNG
         xi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586524; x=1690178524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csp/Ru/rsPdrsyLLiC9Gguj9U+Fgh5fKjxfjDtdRMQc=;
        b=GI1LnW3p41KLdUzwhndUicotEEBh5MNcfc2daTElpV6PNYZWmPG4MSqdKez09v8tQA
         lFTcpKJsE5b6eRsUQcI35cuRZO3+HuiTJJdnoX2WWYxr+LWLLI5uZ6QRl8tkIu8XKpXW
         MCOTatCA/HDXJc1s2O//FM6nZcaOOFL6pP4jVBPfou/05/t4i3MjWy+4cI/y9ArjsacI
         rt48fhpSZkp7hVQB848xcpNI2pxH5/yNKBke1vz7QWJb5oEmB1fiv3j+A1hYIWLsyYiQ
         IlyhsmETb2CQ1WfZIMeParJ0NF61WeASyIEFv/Qwnt4is9zMZMx2b9z0McPEpFXCSfoW
         QRFA==
X-Gm-Message-State: AC+VfDxesCu7DgO2AJ2PkgHlmf0v8CW7AEpAmBJLgx5v88B51oCteCdE
        tWWRGEZFHEQjZKAmPIjf3+Dfzw==
X-Google-Smtp-Source: ACHHUZ4VWeUnMU1s0UNjPDk6IpqAzSQZeQ6tdhcnWHwHrt+4vWuGVhE3lrk990AA40VrSim2Lx43JA==
X-Received: by 2002:a05:6359:622:b0:132:ddc3:ebf5 with SMTP id eh34-20020a056359062200b00132ddc3ebf5mr3656158rwb.28.1687586524069;
        Fri, 23 Jun 2023 23:02:04 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id u4-20020a634544000000b0052c9d1533b6sm571594pgk.56.2023.06.23.23.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:02:03 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: sifive: Fix sifive_serial_console_setup() section
Date:   Fri, 23 Jun 2023 23:01:59 -0700
Message-Id: <20230624060159.3401369-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called indirectly from the platform driver probe
function. Even if the driver is built in, it may be probed after
free_initmem() due to deferral or unbinding/binding via sysfs.
Thus the function cannot be marked as __init.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 1f565a216e74..a19db49327e2 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -811,7 +811,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	local_irq_restore(flags);
 }
 
-static int __init sifive_serial_console_setup(struct console *co, char *options)
+static int sifive_serial_console_setup(struct console *co, char *options)
 {
 	struct sifive_serial_port *ssp;
 	int baud = SIFIVE_DEFAULT_BAUD_RATE;
-- 
2.40.1

