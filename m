Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B363274F462
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGKQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjGKQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC241711;
        Tue, 11 Jul 2023 09:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DE96155D;
        Tue, 11 Jul 2023 16:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4FC433C9;
        Tue, 11 Jul 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689091526;
        bh=Egr4Nmsjw6Y0jeMOfXu4eTy8nCTKbSXKZXnI7ZlXo/c=;
        h=From:To:Cc:Subject:Date:From;
        b=L+UWYDm5ai+hAXkV5yxUUa2XGYoy3rY5U6Dse8nIWJKam4nO5OXLEDw2Ari4VWyqy
         VgE2kHngUBrYaBzng/Y4Iv32eg/ALoKoTgCgEKpx5xqezdNhX9s/S3DcgeUAW3kBHm
         Rqxahq+tBj4c+kVEMGWv4ZQwsjqh6pcNG02xJRuVhP2OoojQCrINIe273109VK1GJx
         QAc/Hxh8yK9M20JUXCI7VB3/3s2zr5b3zL9dc7CtiqS4Vu/NI3OEer+iThU0hJCkXb
         GXgvdRvJL0hRjPpbV2r3wDB0TOno3HTlq5ebw7VkKbYgtnnKOmWt7kERPBb9w70zVM
         SBEgYO5W5Z3lg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qJFsB-0007wW-1i;
        Tue, 11 Jul 2023 18:05:55 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] serial: qcom-geni: use icc tag defines
Date:   Tue, 11 Jul 2023 18:05:16 +0200
Message-ID: <20230711160516.30502-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Qualcomm interconnect defines rather than magic numbers for the
icc tags also in the restore() PM callback.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 444c74eeab7d..88ed5bbe25a8 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1757,7 +1757,7 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
 	private_data = uport->private_data;
 
 	if (uart_console(uport)) {
-		geni_icc_set_tag(&port->se, 0x7);
+		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);
 		geni_icc_set_bw(&port->se);
 		ret = uart_resume_port(private_data->drv, uport);
 		/*
-- 
2.41.0

