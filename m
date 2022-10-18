Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E2602DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJROF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiJROFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:05:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E022873E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:05:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so18018260ljq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmkA2nahqdV5ZLpSxnhtvorkwi04wOolQrPdVytHYxY=;
        b=iWheTxqNCTGD6qvm2sGjasEQyED8ePFU44tPaGNDrpaJjoPe0dH+S41dNqxChtvW5M
         q5b/S3rYjJsIwrcV/pk7wvSkVGfCx2Xf8RtyRfFW2skFRLg80j+bzq4z20gDuB43J88H
         Edtntnqx/mw7GNiSJxZxAasKAM8SgN32D3DULcXHN2xFbIl//d5Al0K3CjeCXkyreBFf
         iw5823odvlMw5gBsnSB+SmEc+TO1ftMSfJp78de4cLSX/DaJyR9ZSCzjsMSIvExsR/xQ
         QhqAdsemR3fg5ETBkKvfFWfWK4q+MxO6OeCzHEWiJvUBmGzynSmqthjLyWmp9oYeztPY
         pwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmkA2nahqdV5ZLpSxnhtvorkwi04wOolQrPdVytHYxY=;
        b=uWEG+iv5AuMiQ7S1cjYOJCpZu3mZbCf3ZklJOTCOYaJc49RJeSl55sB0V0esgJuKsK
         8GDKNOdNY8t3GRCSHuH4kFkDVCGGJ0ON5arlNJefCChezt3yn8pKBmdORQeKGTCMECCJ
         B5eJ9J+FFOe+z3Mr1Dai6JtyGcZ1J4kMMHPD7q7qlqKFuOUBNfS7bk/D+JwVt42qgiJY
         MQfgaialhkpm9iUfup3rFcrAQbP6dl8Qiug3sXLJE3fxMZQVHPi7yVXOtbWWcSWK5JDX
         xE+Ce1LXt06yPQubsLed0udKFqzuUWXMxjwxMLRrbfHWgyKTDNj5nWmpWSdSVsPmxbMs
         qMYA==
X-Gm-Message-State: ACrzQf2xFTzfoPXvdQw7bGwqUBkwWKr3ymlUiOq5Zzl70WW5H0fHC55N
        xHiJ5on7gmIayppDC23uW9UPgdvhI+wFvu4k
X-Google-Smtp-Source: AMsMyM7R+09+9nCvaMMUp+hbCV4Cov9DsqksHf3+0pMwbNT+EH5zakKKH6rKc72O2RgKizvbC1mVpg==
X-Received: by 2002:a2e:3310:0:b0:26e:61d7:870b with SMTP id d16-20020a2e3310000000b0026e61d7870bmr1210454ljc.88.1666101898734;
        Tue, 18 Oct 2022 07:04:58 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id l29-20020ac2555d000000b00498fd423cc3sm1859113lfk.295.2022.10.18.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:04:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:04:56 +0000
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: [PATCH] staging: rts5208: Replace instances of udelay by usleep_range
Message-ID: <Y06yiBaluz6X0C4G@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of udelay by usleep_range as suggested by checkpatch:

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+               udelay(30);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+               udelay(50);

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/rts5208/ms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 14449f8afad5..ae72437b5482 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
 			return STATUS_FAIL;
 		}
 
-		udelay(30);
+		usleep_range(30, 30);
 
 		rtsx_init_cmd(chip);
 
@@ -4157,7 +4157,7 @@ int mg_set_ICV(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 #ifdef MG_SET_ICV_SLOW
 	for (i = 0; i < 2; i++) {
-		udelay(50);
+		usleep_range(50, 50);
 
 		rtsx_init_cmd(chip);
 
-- 
2.34.1

