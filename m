Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B03735DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFSTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:36:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD1E55;
        Mon, 19 Jun 2023 12:36:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51a4088c4ebso3459158a12.1;
        Mon, 19 Jun 2023 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687203384; x=1689795384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQeLBbtBDqCJz2o5WSped30NPmSNwJA9YdQ5+YrIsjk=;
        b=oQ95idFkaTuzYgonNR/5tWxVTPbn8InGjLCI2QogNPyAbUXwK/uKtGheeB7enSHgVT
         MvHds7YH8ACbqYtkVaXWtUKPeI5djOJ3CsNohnZx3g/0Ki6TLgVfulo4SvgEIwdmG7tk
         XM2NY1Nol62rDHofMP/ob4ivDFvOBI24wwsyylPAhwEV9G1K3NFENScKP097+KZowkgU
         65u/9eXvtIOdyZ88kAss4g8P7nGtYQDOP9cxjOlGl/C+ud7+6vvnPiWXcaBgIQ2nlYnR
         6tCA2SBw45s/MBSdOr+ocnGv6hRWDxqcEz+g8/ggIdirHrNxh1CL8hol4AuK3I68nwS3
         pSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203384; x=1689795384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQeLBbtBDqCJz2o5WSped30NPmSNwJA9YdQ5+YrIsjk=;
        b=ltHvoFfs0QQFnTwmk8tGHYutpZIIl1UbYnPz/HZXO5qDr/gMMwieWcH1eawU/e8jib
         cjsjOFHoigJpglI+dSV1g88quZtj3egsiC7NzwmUsGNTHhlR2wfc3riwax/hCY1Al/mI
         EGekL0cQeorlqVKifE8Yn/jH7PKwIx7TddQsG8CIG8VwJsvPPNepSsPWm8QsJdG9CaTJ
         LtsJ+VSj7RQlpAk4yUaNIZz5ddvQQXefaB7i+sgTdHncHGE9eJ0IDBhGeIV6aLZUpURV
         DMfk+tUl7xnFkqqTrRMueoXiAGOQPv+mfIHQNIVXW8AbAG5rzLxBNhX1GZGUHeKZrbyW
         6XuQ==
X-Gm-Message-State: AC+VfDzXGTchkn2lzxqkOLEHYJ80D9sTBfsLN7mjQaImgGXA4fQO+O5L
        s5+CJXzXRAhILZ1+WcJEJf8=
X-Google-Smtp-Source: ACHHUZ7f6E9g8HqEpaKOWKYAlnw3K4xZeQJHpyTffUdlw1FJbMb9xfnH0BLn++8BujqtPQXiLOzIGA==
X-Received: by 2002:aa7:db89:0:b0:51a:265a:8fca with SMTP id u9-20020aa7db89000000b0051a265a8fcamr5494015edt.27.1687203384038;
        Mon, 19 Jun 2023 12:36:24 -0700 (PDT)
Received: from fedora.. (dh207-97-59.xnet.hr. [88.207.97.59])
        by smtp.googlemail.com with ESMTPSA id q26-20020aa7cc1a000000b005184165f1fasm109895edt.5.2023.06.19.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:36:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ulf.hansson@linaro.org, windhl@126.com, avri.altman@wdc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] mmc: core: disable TRIM on Kingston EMMC04G-M627
Date:   Mon, 19 Jun 2023 21:35:58 +0200
Message-ID: <20230619193621.437358-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that Kingston EMMC04G-M627 despite advertising TRIM support does
not work when the core is trying to use REQ_OP_WRITE_ZEROES.

We are seeing I/O errors in OpenWrt under 6.1 on Zyxel NBG7815 that we did
not previously have and tracked it down to REQ_OP_WRITE_ZEROES.

Trying to use fstrim seems to also throw errors like:
[93010.835112] I/O error, dev loop0, sector 16902 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 2

Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
to disable TRIM.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mmc/core/quirks.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 77caa0c903f8..8decb788a3db 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -107,6 +107,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	/*
 	 * Some SD cards reports discard support while they don't
 	 */
-- 
2.41.0

