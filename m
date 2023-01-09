Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86FC6629CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAIPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjAIPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:22:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8BD32185
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:22:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so9325502wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vOTKWnDZmwehJAU6Nl1hb49nz4Cs660rzRHE7sjmWA=;
        b=AGc30VpVOrKwF+dKIvUbevde6oEnt0lII78VVfHLfyT53Wz0n1Yh/KCOEybIswI2zD
         2xxjsJidh6GvzQ2K1+Oxy5V4RKPOVuLgTexEgK1e/MEJIMRqfTjWKjQvFVE7e1XEnxSA
         Ns3U7whvAy8xH9apVcq6bypl6/NrOj1V1hz7bu0TVBxinqNgwQT7SUgoxl2RuYroxL0/
         3QPhi9+xNcKCelo5p1EJ++1aQvXHGU80JKC7ZazNkAG+d/rlhmUzpqRtOinhTctxZEUm
         l7BiIN0qNf9jrqlFznod+Yo1bi4BVSZav2FDu4G1YF6N1r3rHbJGTsrgki87TCzb8MXm
         tUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vOTKWnDZmwehJAU6Nl1hb49nz4Cs660rzRHE7sjmWA=;
        b=0+clGPPVC21F37Pd2HFtUQUng6NwBCxXCooi3d46ayEKc2ykSTaJkKus0hpDPTw3Ny
         MN3fvHEDRRMSRfxto6vC1THXPTrVX1w4pnxeM/2SxFViY/vM06ndxpnVZza/K34jBKSY
         ifr5ixtX11fBW3W/8nB4//2ww7IjEztGMXsN5iFLpSqpGUfBadf/HPsSwDsxIKDlymYQ
         apv6wcDxvzEfMLha/KPicls11Jkq+DV6LQnMF66VqEpbZp8Po7ogZsxun9tpzqi8jyxa
         klx4nVSgN4xlaIzDTB8q9eVUDvXkVXcR/BadeW7ZyH9zk6QW6eyrnFUG2lI5x5FVS3rD
         cpNQ==
X-Gm-Message-State: AFqh2koirnlBAPEW5T2GgNF+QD3FZ1qMqsoYnnT+8YmE5kvOlK5H1pYa
        nZfQw4SmD9SZQbiOE5a1duIXOw==
X-Google-Smtp-Source: AMrXdXtRAL3NMvlUqZrrkSZbPdNqDQn6dQLhR41NfSr1it0b0iJqWDDrRJBt7KxQZX/oUuox/jGqyA==
X-Received: by 2002:a05:600c:1d20:b0:3d2:2aaf:316 with SMTP id l32-20020a05600c1d2000b003d22aaf0316mr47036944wms.36.1673277737004;
        Mon, 09 Jan 2023 07:22:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm17314027wmo.34.2023.01.09.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:22:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] serial: msm: add lock annotation to msm_set_baud_rate()
Date:   Mon,  9 Jan 2023 16:22:12 +0100
Message-Id: <20230109152212.343476-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm_set_baud_rate() releases and re-acquires the port->lock, thus add
lock annotation for Sparse static code checks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7dd19a281579..44e1e83127ac 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1125,6 +1125,7 @@ msm_find_best_baud(struct uart_port *port, unsigned int baud,
 
 static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 			     unsigned long *saved_flags)
+	__must_hold(&port->lock)
 {
 	unsigned int rxstale, watermark, mask;
 	struct msm_port *msm_port = to_msm_port(port);
-- 
2.34.1

