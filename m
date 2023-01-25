Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E562067B0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjAYLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjAYLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E1A26870
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674645140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xu2Ks1Oyc6eAEybGJDnJPNvc/nQTbBhirvgxNSCpiG0=;
        b=HAsRhEBcjYohL0eotdrZaIf1T2HJ7TgXF3VDTLPZEv4wmKvLemATuT2817Jt9CYkxlCtwS
        0LirfzOUk3Mq081voV5Sr3meMMXmWp69BbS6QXDNoIKVT0jpobOulGxDFyd57aRYEUsgkm
        VJUq/UM24yFggKmtMkyq6qNkMKWqqos=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-DkW878q_PruVnr-Qqhgahw-1; Wed, 25 Jan 2023 06:12:14 -0500
X-MC-Unique: DkW878q_PruVnr-Qqhgahw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64A29380390B;
        Wed, 25 Jan 2023 11:12:14 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 670E92026D4B;
        Wed, 25 Jan 2023 11:12:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 2/2] extcon: intel-cht-wc: Add support for Lenovo Yoga Tab 3 Pro YT3-X90F
Date:   Wed, 25 Jan 2023 12:12:09 +0100
Message-Id: <20230125111209.18343-3-hdegoede@redhat.com>
In-Reply-To: <20230125111209.18343-1-hdegoede@redhat.com>
References: <20230125111209.18343-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga Tab 3 Pro YT3-X90F needs the same handling as
the Lenovo Yogabook models. That is it needs the extcon code to:

1. Control the Vbus regulator and USB-role-switch for the micro-USB
   port's host/device mode switching.
2. Register a power_supply device so that the charger-chip driver can
   see what sort of charger (SDP/CDP/DCP) is connected.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index c45d7ff6cc61..323ab8731284 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -539,6 +539,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 		cht_wc_extcon_set_gpio(ext, CHT_WC_VBUS_GPIO_CTLO, false);
 		break;
 	case INTEL_CHT_WC_LENOVO_YOGABOOK1:
+	case INTEL_CHT_WC_LENOVO_YT3_X90:
 		/* Do this first, as it may very well return -EPROBE_DEFER. */
 		ret = cht_wc_extcon_get_role_sw_and_regulator(ext);
 		if (ret)
-- 
2.39.0

