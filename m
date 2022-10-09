Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2139C5F8D25
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJIS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJIS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:27:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606BA252A9;
        Sun,  9 Oct 2022 11:27:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bi26-20020a05600c3d9a00b003c1e11f54d2so4096501wmb.2;
        Sun, 09 Oct 2022 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PS7csLc85uEKkCZYUniKkURfmvYd6XN26COmZB1Jdxk=;
        b=bR5211TQJ7TQMkrPhLKq4irYkXEil3oZDmp8K0EJ0hNJFXV6CIAbLe5DRrgMxrJtwm
         DFZ1F21o8t8l3mwsh3tV22Q4QBsPF/XbFkMQedPI4miubgUHH7zyyuOnR1NXhKDnkzZe
         Q2HBbMBd579Fx3qHI7NcuGAfQmfybaATC8GQcYKdcRNKns/rBPQV55a7R42OwyvUNUdp
         Ms1FZAG+gq+AEFp2q/BOwfCUv/+4YdzbkS4stiqY4Vpeip0TVSY1BOxeSYjrdr3yIAcr
         hKGA/v6PR6Grcq4lmsouBTO5L5nWzzQdP6cXno0aosv9YVHL23npmXS61OXSC+EQ5OYj
         +0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS7csLc85uEKkCZYUniKkURfmvYd6XN26COmZB1Jdxk=;
        b=7X+efpA8gHYXywZW2JzaQdhudlwgx8v5RHNFMSgQY4MsC98/2Hsyj8YMThSzPVG8nX
         jzSYNV1jvXpThCmMzgEKQl1MUgevg94AfRYDbdvdSAAGtBn2LosDZ19kgbhn+2ZasSuj
         hnvTQKu/TzNBrJ9P8WuKawr0ZOM2pupGnjvbibqOlEOuVp8QZwvcten6XldN24L31XH1
         6DHOdTYTTFROS2/5Jisr7iOc1Q7GpgaFj9M7gtJ5mcheZb6dXlAQGEXZv2yEiqxcJ0dr
         Np/wIikkru7keoyojh6V7Ti04Ypyj9pXexEfd1Xe4wYqMOX7UQ/OEjGHZ53bR68R8pdk
         Z9sA==
X-Gm-Message-State: ACrzQf0tGHB6GSLJXNWC6aNGRxvqvQwPpNFxEWYeF0YEskxxOcy7h1e6
        0b2F0zbhpXiSfW7IAlC/kHM=
X-Google-Smtp-Source: AMsMyM4sjir9Eplbd3FQlMDGgseBl8zuuuGLQ1QMLcdPsExCTuKr+1d1D3drsc50TeflxBp8GlJpdA==
X-Received: by 2002:a05:600c:221a:b0:3b4:75b8:3f7f with SMTP id z26-20020a05600c221a00b003b475b83f7fmr9927436wml.175.1665340075581;
        Sun, 09 Oct 2022 11:27:55 -0700 (PDT)
Received: from localhost.localdomain ([94.73.35.102])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b0022dd3aab6bfsm6909438wre.57.2022.10.09.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:27:55 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Nulo <git@nulo.in>
Subject: [PATCH] HID: magicmouse: Do not set BTN_MOUSE on double report
Date:   Sun,  9 Oct 2022 20:27:47 +0200
Message-Id: <20221009182747.90730-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under certain conditions the Magic Trackpad can group 2 reports in a
single packet. The packet is split and the raw event function is
invoked recursively for each part.

However, after processing each part, the BTN_MOUSE status is updated,
sending multiple click events. [1]

Return after processing double reports to avoid this issue.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/811  # [1]
Fixes: a462230e16ac ("HID: magicmouse: enable Magic Trackpad support")
Reported-by: Nulo <git@nulo.in>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 664a624a363d..c9c968d4b36a 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -480,7 +480,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
 			size - 2 - data[1]);
-		break;
+		return 0;
 	default:
 		return 0;
 	}
-- 
2.25.1

