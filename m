Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEB6154E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKAWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKAWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:22:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499319C13
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:22:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso256418pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhDBAUhO5scPlfZQJJkosTaLVirDeVVGs54DNXhKQpg=;
        b=U4JBkHwZ9YjBgtJFqGJIhTwVRG1U3DJ4XqLA9TnHH1CZp6GdyHKLYgQ+o5Y1u2QBPj
         fTJmP6U1Z+wznRqQT5hkSlw+EphKFYnQYZIvuC0uUkiVK5TUEWxPnwpd4m/RpbXlL0HC
         4qwqxdROBnxcvdQzFKuAwLc0tcgH8e4nkt54U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhDBAUhO5scPlfZQJJkosTaLVirDeVVGs54DNXhKQpg=;
        b=IiAAYv9OsMzlSfgZZDILC9PVqp5vlvq0sW70OPiREE3T8L1/oigf9lt3of95d2zswy
         3wMDCiLs0Bx/OxXWzFvKgg3/93XIUFKx+KVoJ0QsSgI5tviTPLCbNQsI+uuz0suBwEoA
         lkoWThmMYH/OyBq6cmuwyuUitnv0bZ5dbezrTVlSErXCyfwmLntFCdW4IFt4mt3UCAQe
         kh+iO5IsVGQ0dDY2rA024VVRPq8omDE9Hyv6ixppto3lWMzaFweTq7tGhZSyfsx8gGbe
         4TKchYXYwONe0O+X5jf8Jrpf+Blq/6a/kxYzU1HoOw/5WHV3Yo4aEI0FjYQbwyDid4gv
         xoIA==
X-Gm-Message-State: ACrzQf3CeZhtauquCZpN0TCyuWImgaZT2twNtEL3bE7SRB+HOO5s7IIs
        poVOVfbXGz2CHODp0LmXMseqLg==
X-Google-Smtp-Source: AMsMyM4WLgDDjTjLX67kShDt6zODkWQSyOwZps+yLROfGu6JclUPAsRo+ohLF+F9J+909Trqzs+Ybw==
X-Received: by 2002:a17:90b:1950:b0:212:de19:b3ce with SMTP id nk16-20020a17090b195000b00212de19b3cemr21874558pjb.16.1667341371422;
        Tue, 01 Nov 2022 15:22:51 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9c5f:7c8e:b8a2:3495])
        by smtp.gmail.com with UTF8SMTPSA id cp15-20020a170902e78f00b0017f5ba1fffasm6797659plb.297.2022.11.01.15.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:22:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/5] platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS
Date:   Tue,  1 Nov 2022 15:22:07 -0700
Message-Id: <20221101152132.v2.2.Ib1036816e77aba71ebc16b71f7615c55d054689c@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
References: <20221101152132.v2.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This takes on the order of 60ms to probe on some systems, so let it
probe asynchronously. It shouldn't have any dependencies that aren't
handled cleanly.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/platform/chrome/cros_ec_lpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 48302183d62e..2e4dba724ada 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -557,6 +557,7 @@ static struct platform_driver cros_ec_lpc_driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = cros_ec_lpc_acpi_device_ids,
 		.pm = &cros_ec_lpc_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_lpc_probe,
 	.remove = cros_ec_lpc_remove,
-- 
2.38.1.273.g43a17bfeac-goog

