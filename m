Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E104F5E6243
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiIVMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIVMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:23:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8846E6A1D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:23:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a29so9119196pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Sq86kzDOcqsN5l5kHfnuCcSu+rF/jyTPvh8HDjjPPXQ=;
        b=GZcjdflzUG6u/+FDp+Ml4obgd2j6AJL2qwoyrfKOqMzkAb8n6U+AePYDmXAMV3D2wm
         n3FoTl8rExGyVWXPsfdpUEYrPGpSu/5KIs9dMVXumv+i0rkhOGIiNbkQtXMASFHjiu5U
         UPLvfCh5LHJteCoGuuXpU59YdgHUb7DE2U1KsHQV551e7Wfiy9ukS1C5zNaRojUNrbzy
         euZjri486OIYdA/O/+SKOb9uocNJKIzn4+6ZHvE04XzpAlZ2NapbA4nUwM95lJVfRhQp
         V2E9O7rZRTJgkgFsGtJrRApErqzuVq6+3B/3FFkiOeq7Jxm/XRo6+g9Ieow60QpZO4LV
         V07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sq86kzDOcqsN5l5kHfnuCcSu+rF/jyTPvh8HDjjPPXQ=;
        b=PrclZvJvf/SrRTRGiIQIJd3EwYi+/S8UvD/mOWIVttk2xM5BDPYA79W3uYpRADPLmd
         wUW2YT+uGxvsCelxA2rW5k/Y6aNbpewL/YZHGI8U2DnbziwFwHVtnCN+QMaKEXu5RiRz
         AOoom8ucNm/ZYq7uS5V2tB07i8kSPt3kYR1g+6LtoUKhMG+I8cd57LdKFzg5MmVHFneq
         ID/rvfqgkk/kh5PFUrl1XKhcmX8WDwr6K1975AbDECZTZGK52Dyar1DHhlNpm+8KLlNq
         1OVYBgXrOI04C1Kr8g7lDh8Q6kQLlr8Su8QFMJbepKPtyT6eGHvj9pbnd56VAETJXYk2
         zE8w==
X-Gm-Message-State: ACrzQf0R75N4aWYYnV7yf1inS+oDqEIo3kLgGCTDOOT4thd+tApddwD7
        OUXl7UvLG0urqEj/A5/cMnk=
X-Google-Smtp-Source: AMsMyM4nPxxmURICchfAdqEO6or8oE6xV6pqBVDmicYDJM+JQ+BpmlUVn62uLlbhRCF7RcIuJx1Uhg==
X-Received: by 2002:a05:6a00:3287:b0:542:33ca:8bce with SMTP id ck7-20020a056a00328700b0054233ca8bcemr3449307pfb.20.1663849434234;
        Thu, 22 Sep 2022 05:23:54 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b00178acc7ef16sm3942901plp.253.2022.09.22.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 05:23:53 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        GUO Zihua <guozihua@huawei.com>,
        Hannes Braun <hannesbraun@mail.de>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 4/4] staging: rtl8723bs: Add a blank line after declarations
Date:   Thu, 22 Sep 2022 21:23:10 +0900
Message-Id: <20220922122310.3379711-5-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922122310.3379711-1-tegongkang@gmail.com>
References: <20220922122310.3379711-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a blank line in order to fix checkpatch warning

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 57a68f9edec7..6aeb169c6ebf 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1849,6 +1849,7 @@ static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
 inline bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter)
 {
 	struct rtw_wdev_priv *rtw_wdev_priv = adapter_wdev_data(adapter);
+
 	return rtw_wdev_priv->power_mgmt;
 }
 
@@ -1954,6 +1955,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
 	{
 		struct station_info sinfo = {};
 		u8 ie_offset;
+
 		if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
 			ie_offset = _ASOCREQ_IE_OFFSET_;
 		else /*  WIFI_REASSOCREQ */
-- 
2.34.1

