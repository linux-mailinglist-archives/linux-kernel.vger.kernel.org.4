Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102DB6B9FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCNThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCNThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:37:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886D30B10;
        Tue, 14 Mar 2023 12:37:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m4so8451598lfj.2;
        Tue, 14 Mar 2023 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678822636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n80OO2p0+yXsir8JhHPkqdbw+rH/st/LRf0u/i9phg=;
        b=KW/skMhjVyfqHnNbh+GsnTN6Mmmbazd6Ln+DuQUYGmVqkmdrwW/k7YpdNxOW66ljf/
         hFO3KmaQtG+Yo8GijJcttE8VgUOPiVzP2VL3gQx2UMlglwDt1VbI69FRvLVhOqbgItrL
         6HIUrnDWQH5cXbSEJOSHBr78IqMUq8AqBbcap5d1Al8Ls0cgWXzdtH2jNZ6gHYMpoEjZ
         G6jBaYeIe5MB1mxGExOB6walb7SbOdVGegs9YrFZYozTT/ybOOV5OlgRDMf4I7B6e5mV
         UTh7vHhLvBBMW4GcyUAJftYQPGuqSRF/dQmv+usb3q0YH848kjFuZC5JRdGhlYnQ+J2Q
         kpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6n80OO2p0+yXsir8JhHPkqdbw+rH/st/LRf0u/i9phg=;
        b=bfQPkz9txRzOx3scTgykqlqFU/za1yteozN2eWPUfNYMmfq4ineLP70AtURa1g15n2
         xdIiu5TcLZ73CGcqxbFaNr5C2XHAMbop2MuEsQuvjl1+NAM50L+cwTQAMyKP7GMO5f3W
         i07S/4UV5u5pTCGKJW+NVJ09MWEpjSWAFk6JyIk9dpsK7q/geTr2K8wuGUdldEwMyXIV
         6x4jZleZyZdYdmo3uYJ+xmZF1DmkG4lAO2TRc7/BCukk9AoDtoIZ77PumX2S6yC9AMLj
         hkccD8NhX220A25taOI54bCA/C7M6Up1Cmw0oXXjPUMCd236xXvUCGACpIFUU93g77wo
         BKeg==
X-Gm-Message-State: AO0yUKW1AEjPq3LYv2U/aVb8Rnewx3i37auUPMIUY4umJLkmQ5icze5O
        XADE3n9qnOHyCcGWeVSSejk=
X-Google-Smtp-Source: AK7set8quM8ygAx5/FCTuKrJMk0KUxoiB161DkMDpjqQkayM20GcKZn76VClTiuk/fZb/wkBOz6MkA==
X-Received: by 2002:ac2:4a91:0:b0:4e8:3f36:414a with SMTP id l17-20020ac24a91000000b004e83f36414amr1216390lfp.55.1678822636404;
        Tue, 14 Mar 2023 12:37:16 -0700 (PDT)
Received: from ruslan.. ([178.176.76.61])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651238cf00b004dc4d26c30dsm513859lft.63.2023.03.14.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:37:15 -0700 (PDT)
From:   Kasumov Ruslan <xhxgldhlpfy@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Subject: [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc_parse_channel()
Date:   Tue, 14 Mar 2023 22:37:09 +0300
Message-Id: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The left side of the loop condition never becomes false.
hwchan cannot be NULL, because it points to elements of the
hw_channels array that takes one of 4 predefined values:
pm8018_xoadc_channels, pm8038_xoadc_channels,
pm8058_xoadc_channels, pm8921_xoadc_channels.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")
Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index eb424496ee1d..64a3aeb6261c 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -758,7 +758,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
 	/* Find the right channel setting */
 	chid = 0;
 	hwchan = &hw_channels[0];
-	while (hwchan && hwchan->datasheet_name) {
+	while (hwchan->datasheet_name) {
 		if (hwchan->pre_scale_mux == pre_scale_mux &&
 		    hwchan->amux_channel == amux_channel)
 			break;
-- 
2.34.1

