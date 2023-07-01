Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF1744879
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGAK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGAK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:26:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9F3C2A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:26:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51dfa0771cdso733485a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688207179; x=1690799179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRU/4EgIG59FlYdUAQY/bxVUjSKGZZK/O/khm55mTyc=;
        b=Ui5ViJExRzULqY2c10lgXVJvlivZipx89e9cDYXQa6aFO/3yHYGLoOkPsq8ip03BV0
         jXwFWbnz4Y/Wa4AbyZljXjV4n8V7BUm0ex5ROA3LHxnKTsH1o7bmYD9PYiPf7lL4Mw60
         itfPn0WxcqM1+8LwCr68P7rYiQ9TGDd4jAvDHs5pfoe1jF6hBohgrTbo7Mngko8EJdum
         QFTn3E8tk1USWd47lA0Eee70JVPg5MYMu6ho3V1xLJ5Wt2WZ/r4HwBovwO9rMRcYOZhT
         CyGBC+h401EV7l/xHo8QyoTtokBczww9frocGE51YT1sySBK0PaOABst9nzNxLxumDqY
         5ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207179; x=1690799179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRU/4EgIG59FlYdUAQY/bxVUjSKGZZK/O/khm55mTyc=;
        b=H4c0MMlP36U77+wcoUVi7e86Ml860OZfUyRDQvjTDlwx9J5ILXNvCAPhwTts9eJqH6
         ytopJPVzkvXT4aHXkVofiFu5oXCkgCL5L63NIECRftW39TyJcgAJAqPkF8jRAJIv3cI1
         tz+cT23uvPbSpcb0bYKO78b8DDpci+kuDaByZ6WNoGCBWUiUgfLHP3+ufB5kjJcaiBDd
         Pm++wSUitZNhg9UrkbYc5ta0lJ2S1A+attLzLds+/muZ+8zvP4Lg74kcktgm3+YV1vc8
         6P4Djo2hbzm6L/e8PAhL60vKN3Af0529Eh6vnMSyB95xHPxBfisQ0g12JBF0CDiJgCgM
         wshA==
X-Gm-Message-State: ABy/qLZdwCRbdTsLphC9iX+tvMkPZVi/u/4kV0iGD1ke1zOHS367BGgd
        6Zw8iNAP/6j9wzuWpF4ZL4Y=
X-Google-Smtp-Source: APBJJlEOM2wyXiO811piYKKG/fldWxWfNc7UGh39pgsxm8pMfnhTINVSYue1eBWNQi8U0ef4m28PcQ==
X-Received: by 2002:aa7:d31a:0:b0:51d:d30c:f1e3 with SMTP id p26-20020aa7d31a000000b0051dd30cf1e3mr3058659edq.16.1688207178949;
        Sat, 01 Jul 2023 03:26:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:185:3db5:c5f0:49bb])
        by smtp.gmail.com with ESMTPSA id c19-20020a056402121300b0051dd19d6d6esm3385151edw.73.2023.07.01.03.26.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Jul 2023 03:26:18 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     dan.carpenter@linaro.org, eperi1024@gmail.com,
        gregkh@linuxfoundation.org, guozihua@huawei.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com
Subject: [PATCH v4 3/3] staging: rtl8723bs: Fix remaining blank line issue
Date:   Sat,  1 Jul 2023 12:26:13 +0200
Message-Id: <20230701102613.5420-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230701102223.5308-1-franziska.naepelt@googlemail.com>
References: <20230701102223.5308-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch blank line issue:
- CHECK: Please don't use multiple blank lines

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
v4: Fix sign-off email address
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8f30098168f1..292cba045023 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	}
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */

-
 	channel = pnetwork->network.configuration.ds_config;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);

--
2.39.2 (Apple Git-143)

