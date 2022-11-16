Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894362BFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiKPNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKPNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9B1D30B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668606111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRrq0eBv0OrNigOniBgODL/kOmcDxSd8eLVyeuecC14=;
        b=QRoHys9guuZBjTYoS2uncY4aCAUdIN/K34S4eSkK41x4vLZSC1scjArKhIAK1bwzs4YwlU
        HAzuE6BpkZDvDkYezU8RJ1KC+I3Qy1HmR6r3Eqsu24hW08MdtTRv/kfV8YTIgc2FAzgS7+
        cYXNyftWCh/9tAl/ScI1/oR/7BVTGJo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-qM1GFLr3O-iGejYGAfBjXg-1; Wed, 16 Nov 2022 08:41:50 -0500
X-MC-Unique: qM1GFLr3O-iGejYGAfBjXg-1
Received: by mail-qv1-f70.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so13433159qvb.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRrq0eBv0OrNigOniBgODL/kOmcDxSd8eLVyeuecC14=;
        b=BCDWO8+6wtv4KYwAh2Afyd8LjaOMNe3VJauG5BG6O45WcoSe89us8vCng5/otuBeJT
         WDiMTxto4+mpB+ZoYbWM2JCbEdE8WW7m4EzAyNsMG8O7/3unuJ3wpV1AH03jNlBCN7a8
         apwqAMdZjX1SEMeJI26BLkwXlUb/ZAtU3V6QnuA068dfVoGYLMBqDr4s58D1mV35lgyC
         pL1WKuk9Gva+Vus5cIJkqlQjg7jpMnxFtoReehx4GqH0L0i0YuHDkBUkPXWTfl7dkz5I
         GcrnvHVgBOheyhjitqmsDAtAzQa0Jo0q0E+YkDTmS7zFMIaXhtQPD5WwRlwauhWA9ONN
         LaAw==
X-Gm-Message-State: ANoB5plauTUzljE5FjxMMCG2NH+hRldEltsTbWsFkDg3Nqxs71Bz55I9
        QXc13XWns7xVruwOO/67Y6/MB3Gy+E9r4JyS5KN/IjyE9Yn9ehSCuUgxEnosBgDl7Kx3EZntuSC
        DEceAt+ImBZke6qOGKSNye5U=
X-Received: by 2002:a0c:fb0f:0:b0:4bb:5ac4:126d with SMTP id c15-20020a0cfb0f000000b004bb5ac4126dmr20923420qvp.108.1668606109601;
        Wed, 16 Nov 2022 05:41:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vRYrhSARaqPwsQs6rT3Xr/jfGf2KQue/iDTxcO1L2lxZr5UoFKscXeWN4TkLQICT5cQ8AfA==
X-Received: by 2002:a0c:fb0f:0:b0:4bb:5ac4:126d with SMTP id c15-20020a0cfb0f000000b004bb5ac4126dmr20923405qvp.108.1668606109386;
        Wed, 16 Nov 2022 05:41:49 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-29.cust.vodafonedsl.it. [2.34.31.29])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85e54000000b0039ccbf75f92sm8801342qtx.11.2022.11.16.05.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:41:48 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] habanalabs: added return value check for hl_fw_dynamic_send_clear_cmd()
Date:   Wed, 16 Nov 2022 14:41:25 +0100
Message-Id: <20221116134126.199087-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang-analyzer reported a warning: "Value stored to 'rc' is never
read".

The return value check for the first hl_fw_dynamic_send_clear_cmd() call
in hl_fw_dynamic_send_protocol_cmd() appears to be missing.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/misc/habanalabs/common/firmware_if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2de6a9bd564d..311942108dbc 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1782,6 +1782,8 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 
 	/* first send clear command to clean former commands */
 	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
+	if (rc)
+		return rc;
 
 	/* send the actual command */
 	hl_fw_dynamic_send_cmd(hdev, fw_loader, cmd, size);
-- 
2.38.1

