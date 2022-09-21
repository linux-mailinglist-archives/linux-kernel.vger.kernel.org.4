Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA695BFA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIUJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIUJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E17754D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z97so7638008ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=IsXtqWi3aYMJWgr4SCjULTHnfzXmNkyNP5+0rfZs3GE=;
        b=D5dWOBVCXSFCIYutIjsZl3tuC7Gbz1jUg3Jqlrd+KveJIV4oHb9x461iEStk9ydmel
         7gIaoD0QqbpcR+M8WP7JkH30/C9/H47vFcmAVGIZ3Cf6WrOyVxz/DzM8JRQjruJoyLrD
         td43m0lqDpmccDYZ30s2YBTEQe8B4O3OXg6eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IsXtqWi3aYMJWgr4SCjULTHnfzXmNkyNP5+0rfZs3GE=;
        b=lT4jKrVWeaiGhUWNZs4Slo9R8f0+OTMXpKlUiM9xGwoAxEMYen8BtHkmsWrlQPKFSm
         dPZgXppHFA7C5SfOz7vIzJZZPA5nCX4uoY5R+TL00hPooenlBsMZLcigBw09zI2AzxUw
         0QcdnJISveQIMMQmZJ/0014g/bGV1wJKepYMK+vcA7Vo7CHx696MqTcH6ftKrJkTGbfj
         LLZYE1l56o50o26VM1C65CBvCbVWd/9zNF2bYNjepKpd1hcRQucex6EtzWZ8CWgy1LhO
         2IFrSNXEpYQjZJssIbKiW+rgK2TpxVMsvEk7R1Ky5HHWzW74Im610NeuR0wDx7FGfynh
         /iUA==
X-Gm-Message-State: ACrzQf1UQCajNToxAMbDIIxv5LAMU8rgPinVFiPsZiFiHYuyDIstYRiN
        nMoJAC9cXYvv+BMKPHI8B1Klpw==
X-Google-Smtp-Source: AMsMyM4iDz6AGIhyiulChGF8onMxrBupc/sNx2B0SKGHn+GNycyiSHWZ8Q0DnwgBwOhFQo8wym4PWQ==
X-Received: by 2002:a05:6402:538f:b0:444:c17b:1665 with SMTP id ew15-20020a056402538f00b00444c17b1665mr24115315edb.98.1663751554504;
        Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:34 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:11 +0200
Subject: [PATCH v2 2/7] media: uvcvideo: improve error logging in uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-2-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=xuDJMTqPwFnBT90gGjW9sM+//WBwScMY4uWO/jQUOuQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV2RPEvj88EgsUg65wSnyUdNi4LSH8DMQKZ3kGB
 eS8lFF6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVdgAKCRDRN9E+zzrEiGkvEA
 CDWupK2HASX3jyHXFdbPjDfnZRZ6DuAdx4X7fjB+vQkdIA2cGSRE8IOQX5ebjbc7ghiDUPDVM5sxH/
 KKr/sVF6wsd5x03qIaIYSs9yIBJyN6r58KMh7WWAVOEkfog9Gb1mcXf7q3x52LJ9nqY4xCrWg4HpL5
 GyWP7WUteO6Peowx6euwQ7yr1v+CteV0XQJjDfOSfrbnyjW6Yfz782ZyIHPdbZ+MZkXayVchQO3QKN
 58jG7rN1PPKzMaGsRqksHGxsAkPnlv42/3V70tCJtGBvCiFmFC0Xg8+YDiDZvezyCTSPJX6cthkgCj
 J9uPl4mNpogil2bsrXCUkPFrWmitZx+jKEDbJw99Qft7hxztwy4bCPY7iDgPc6ng+5SQojVpQVeShB
 bMEJpRf+TbAobyPTUlf5fRdhjnbrUO6Vk7tRch5halXh7oyZG8HomLUrNea0ZF6FRQVxC7PTlsQAzt
 qmRzWx+OOqjhkCOBCr4N8ha165pruzGKcO6PCH7bZ+mwX//meRExlXQZcTjl89xEDMdKHGGHoC++sa
 FA6akvATIHZWrn3J9t/qvDKu4fgB9Ndjcb39WlgvoIyF0N059BGHMsv1Ob7qPqJhOYeLocRwDK2tfY
 w/gy9m+I4SzchuPUbDtqEpmmEAcw4j55NWzkUqVi17Iks2DuJmptpY6qCuBQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

If __uvc_query_ctrl() failed with a non-EPIPE error, then
report that with dev_err. If an error code is obtained, then
report that with dev_dbg.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..2cf7f692c0bb 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,13 +79,14 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
-	dev_err(&dev->udev->dev,
-		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
-		uvc_query_name(query), cs, unit, ret, size);
-
-	if (ret != -EPIPE)
+	if (ret != -EPIPE) {
+		dev_err(&dev->udev->dev,
+			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
+			uvc_query_name(query), cs, unit, ret, size);
 		return ret;
+	}
 
+	/* reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
 
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,

-- 
b4 0.11.0-dev-d93f8
