Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF265D0DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbjADKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjADKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A713D6E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b88so40703703edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eP05S7oAYieh5bsYhS+hlRcyIQXVRRrXBen8HZvF0wQ=;
        b=TYUlwgGUYxQtBfQgr6HAF4WRrUCCs6+Q0x3+s33syXNwAyHgUx7MmRNnZfoFphJsO0
         giJw/1wEtflygRfp6kGmlMJDw0homhhm1lP9eBOGsSi3lviMr8vlVOAWJRvLfG29jOsg
         po0ua4KgiALWE8geDkbcEIRjGDq71eMrpXthk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP05S7oAYieh5bsYhS+hlRcyIQXVRRrXBen8HZvF0wQ=;
        b=uMDO0hQ0Z1+1CFtXnXggyh6GQi7R/8F/aHgcNHjPLkz7V2EqR5PcelgfSYNacnTnh8
         vLYtfcQQ3abc+j4V9XxMMGLgqZjpouFav8kPgIK2AJ/uPmkzFR0NURFGuYA/R+/qWqiu
         8qgVJMtw5Kpn6HFMOTayL9x6So3p3kFIFqSUi5oRVQZstX/AFV4y9//ESOapTxiyHEte
         bF7xeQc9xMvu9W7sDQck2boexY5YFkLHOSBD2bRaj640RkCjOY8/Sqlh8a2aFEvujusy
         KihUPMoG/HZJSvfBZRIx0Q1+Mx1KPlQH1QR2afbGxviqe5qUA27Ih6TYEsxaFEZnUO4B
         bPFA==
X-Gm-Message-State: AFqh2krQtI80EgHVVAvCsLMEyzVGWRrSObHJ9piFxt5S7M8jA9j6ntYa
        i/cmu2qclRS7lMceApSh49VLXA==
X-Google-Smtp-Source: AMrXdXvd+WHy9nXxH5I+9ehCk4+Sg6r2oo8mlgxL89YAHSiwKcCD6N70vX93Szq2dJp1Zd5DaPF84w==
X-Received: by 2002:a05:6402:104d:b0:486:ac69:b9e4 with SMTP id e13-20020a056402104d00b00486ac69b9e4mr24243186edu.4.1672829150883;
        Wed, 04 Jan 2023 02:45:50 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:19 +0100
Subject: [PATCH v3 1/8] media: uvcvideo: Extend documentation of
 uvc_video_clock_decode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-1-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=uQh57Ft7V9nCoa2uBX998qypJtqw/WiItNoLfzr8WTk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjPU3f5Z2E9svRZE/BWIO4lXtzruJFEEjK/8sH6
 EOknXiiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VYzwAKCRDRN9E+zzrEiLUTD/
 sGwSgyt23Hqu3cs30g8YGANyD6AaaRfERUnK4WLltA5EAVO8D1bab/irnj6GJhQDRXxO4nIGlB4XRc
 +0PsAYCMV9axdVIaNuLR7416mKF8eV/yCVrBN1KDbAH/9UkW+YQA8YAdDw9hUPJDAgukr9Y+B0E95w
 zrOkB5+o3TLiPXZiJ9eQXg//iOP2OEvJlxirJBDMXCNUX7ajl86WuMZAnDNhD0D5rFAk2UpP4SKJF5
 MaNc0uIvYZhhjqYyLYiKOX5QawWqoGnsMza4unUGUxiil+tRpYoiqs7Uuz+t6TpWw6H/wciwm337in
 JqDChnNCGVn6lrg6parvA6l4xoCpEHedrm8R4noQtpCO4SO9lxB4QxruJmYzMU4Qmr4vNYL9eaIFR2
 /y8tS1ZDt/dcKCUemWtMeuS2zJs4p9BrTneYpOGq7R+8LnbHpzah8tvJ9H3ytwHC7LK2ec5za8aCB7
 HkiUx8c2cmP4iIKD7My9Zg8LzDIKb8FTJ7PB2i9RK/UXZfQfLuB2JyXqSTkUE2o4IOZDmvFbGO08r/
 lzpZjb3rrWmw8NQQdq6a5odzPqbsc6jMveYNyTlsMqVjjjAbenmR75obHlP2RVsgfetnErHOeReOgz
 RLrrFZngMRK6YLqc0l3+bklN0NFKE67ARUQB6+Fvn6GZzHD0aEYLWpDsw1CA==
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

Make an explicit reference to UVC 1.5, explaining how the algorithm
supports the different behaviour of UVC 1.1 and 1.5.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..def079c7a6fd 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -516,7 +516,9 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 
 	/*
 	 * To limit the amount of data, drop SCRs with an SOF identical to the
-	 * previous one.
+	 * previous one. This filtering is also needed to support UVC 1.5, where
+	 * all the data packets of the same frame contains the same SOF. In that
+	 * case only the first one will match the host_sof.
 	 */
 	dev_sof = get_unaligned_le16(&data[header_size - 2]);
 	if (dev_sof == stream->clock.last_sof)

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
