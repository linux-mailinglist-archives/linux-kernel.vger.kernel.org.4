Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25986E60E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDRMMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjDRMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80070B777
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681819804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pK6/Jsd6qCRDUY6MLyVVq/KSoYjj907IkYNaHbXLumg=;
        b=QQlez4UUZh9NUbk911CSATh/AARVsF7zaJ0FkDwAIPEDx7WYeie0B7zmlxwgOju77xYStz
        jjHndk2reTZAcUZWoXfqJFw6QZlaA19dPFEVmBGQzDY5s9GJj1AmXZB0EWXkFBzdID9+EE
        S40ICitbN50EIbVoxmMc3xcuBmyVgvU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-_lFIKsezOTqZ4RLVN6U24A-1; Tue, 18 Apr 2023 08:10:03 -0400
X-MC-Unique: _lFIKsezOTqZ4RLVN6U24A-1
Received: by mail-qv1-f70.google.com with SMTP id o14-20020a0cc38e000000b005e62747d93aso15297609qvi.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819801; x=1684411801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK6/Jsd6qCRDUY6MLyVVq/KSoYjj907IkYNaHbXLumg=;
        b=bEGFHXzcpolNK2YeGuq2QLl24o3PBgxygsAhuXT4tXnNVV2d1Ra6s3ASc3VODvS2Sq
         XpwrFAtvMxset5MqY3ATt7G6bwAPThWt/f4x8TlhjgSGB+VllZdusEfTaTIZGIS6V5qq
         Kr9kyzRxhnLZ8vewbCs0ZrMjT3sxQm9m7JYZGWYIie6C73/ILZ0rqBbdpAEZEwLvK+uR
         LtMZh/I5ZoUZsJcbYAISqvgUzKheBLSOhNdTztuKTXOsu7XXzR+OcIsBM2w+Q/oHrTnv
         P6r+9JgmlqffdBc4OR773xNkPFaP9GrG0VpjlMzrWAWXiAs73waqg6u1zEIb2Mmdakxd
         ODSg==
X-Gm-Message-State: AAQBX9dHIHiqt8lj8AR94BQKfeD3Yyf2MjEMXpqPiBKpW+ZMMozZqDhU
        mtIRu8W6fICciQf431huFdNubxtPIHHQceDNpHQ0cCrtCsjJL33LWBbR4Mpq0UrCXt0wtQFHhra
        xLRUxXAlplrSg+0ckrfEea4fT
X-Received: by 2002:a05:622a:100d:b0:3ef:3824:b8b0 with SMTP id d13-20020a05622a100d00b003ef3824b8b0mr4901524qte.5.1681819801602;
        Tue, 18 Apr 2023 05:10:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bOLcjSKxSHpofNzJcaPxLEh2nUi7FC1BrTGAF/mAedpATg6zJUv4zkRCxYqhwooGe4UgjcQw==
X-Received: by 2002:a05:622a:100d:b0:3ef:3824:b8b0 with SMTP id d13-20020a05622a100d00b003ef3824b8b0mr4901483qte.5.1681819801322;
        Tue, 18 Apr 2023 05:10:01 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p129-20020a374287000000b007339c5114a9sm3875322qka.103.2023.04.18.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:10:01 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nathan@kernel.org, ndesaulniers@google.com,
        CTLIN0@nuvoton.com, luca.ceresoli@bootlin.com, peda@axentia.se,
        javierm@redhat.com, u.kleine-koenig@pengutronix.de,
        ckeepax@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: nau8825: fix bounds check for adc_delay
Date:   Tue, 18 Apr 2023 08:09:55 -0400
Message-Id: <20230418120955.3230705-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build reports
sound/soc/codecs/nau8825.c:2826:31: error: overlapping comparisons
  always evaluate to false [-Werror,-Wtautological-overlap-compare]
        if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a bug, a logical-or should have been used.

Fixes: fc0b096c9291 ("ASoC: nau8825: Add delay control for input path")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index c4389f5fe603..f4eb999761a4 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2823,7 +2823,7 @@ static int nau8825_read_device_properties(struct device *dev,
 	ret = device_property_read_u32(dev, "nuvoton,adc-delay-ms", &nau8825->adc_delay);
 	if (ret)
 		nau8825->adc_delay = 125;
-	if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
+	if (nau8825->adc_delay < 125 || nau8825->adc_delay > 500)
 		dev_warn(dev, "Please set the suitable delay time!\n");
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
-- 
2.27.0

