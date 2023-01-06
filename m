Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAD65FB59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjAFGSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAFGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:18:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DAC6ECAF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:17:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4349509pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVoLYcfDVSSj5Hj2x3GSCmfRlg0nzKREwK4vCCiBijM=;
        b=AyQ3QZW4y+sUR958e4HRcaZdsf/qgBkw1mlhowceF0XUEUWrY2e1ma6nmNllYeoV/Q
         Yy5UQs03pzNlRQAeKfjmpys5zi0J3ZFYI3CFleutVn2UmhUlRUTnNoHoZg9gZQxdi1sK
         ITivwS+vfEb+n4eN81dcLcd4zY2NXxnBYIXWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVoLYcfDVSSj5Hj2x3GSCmfRlg0nzKREwK4vCCiBijM=;
        b=dGku1j1AXvgfX3rrJt7921D9hOzxfvPPbhllSZ51DTVVpWZCbTHDjB13P7DMPfgceb
         6RfERjZKAsRM5FF7E2dRbVPRc5COsdhVys2VIHZ56G7oz9N4S3LWEnZXsK60x0EeQrxN
         sEyuKNrGvznboo9MgtAFHg7m6ZBeUDqlqyit4TwLrxrdaSA6qGEKXBg4Hzdc/utaKrC5
         GAwVokyWIPG8H9hmN2x2E5XS+ZPo+M73VglWAp78wU7nzpU+y7Qi6dcpgbW/PZu3zQVr
         ijGHBt41oauk95nobxZfIVrX4iHlV5shVZm6B7pj/6b6/B7hWoHCeb1WJjBfObHcIKG2
         4w2g==
X-Gm-Message-State: AFqh2koFLQ0x62D1nB/JykUPcybK7za55dZTfLU7HZ//QUSi/cN+29uZ
        PCMSdLoSCJM0dz7BD3blo4UZUw==
X-Google-Smtp-Source: AMrXdXu8EjH6zCt0hDwlIRVjDHugPnQhQK8vggGjZUTQDFpzSe1hy51vVrwqJVMV27Nnp3GrKotxqg==
X-Received: by 2002:a17:90a:b011:b0:226:8fc5:b55 with SMTP id x17-20020a17090ab01100b002268fc50b55mr13282906pjq.33.1672985826224;
        Thu, 05 Jan 2023 22:17:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090ae51700b00226d4009505sm278581pjy.3.2023.01.05.22.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 22:17:05 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kees Cook <keescook@chromium.org>, ionut_n2001@yahoo.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Silence memcpy() run-time false positive warnings
Date:   Thu,  5 Jan 2023 22:17:04 -0800
Message-Id: <20230106061659.never.817-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; h=from:subject:message-id; bh=HRw9p7KL+4QYDBK7zvJtazO5keiEwenv1mXQer7Jbt4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt7zf29HyDZw/F4MlHzU+Bl4G8jxpLHfoOnTvU5u5 FlEqB3GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7e83wAKCRCJcvTf3G3AJm9kD/ 47yg+LzAvpwtJYOb3OyV+MyCV2HpjQshWvE4+pgbpPOInmvvsqXeKW0Wm8McFGBzx2yl6blx5Pwpca /47EBMRpOiaT3GJNNxENwSAQHww/dF0ks2rY0PhvtPJbR+ZGd0MsSL03PBC85Kic9R1sf0fibXcTse 1/1izkyXUaxNymvLqFlfEIzecRP8k/7OXqvn9QcyXT/SOtVQb40dPRMPuxukLzjWqFxL0dA+kTz2uc RNSPIVy75p4LrE/mJBnwHLx/1tB3SJqNOxdimbYNR7+YP/fpUq6Bh7o1mhZJID8BxJJNDvbRqTPsn9 uURfsmbYsTr7rdQtiXrc2MLqikfo69Xdwm5Ufx/hpJ16yjjaU1d4ft7iT1kjKRc0hIsLsZVJgOXKhW hKw0Mrd5QMh7dm0xeoH49RHCtw3HUPdFfH+OdzuwPnVoPBSUDZuvKvdZ+Z/vpKbtOVIl/n0gzG/97j 8o76yXgd56XlarYhCNPv1gMoPKB1G8/7NUdoBNRR2QbCYZpCWjKuzxzfQ+sdKw4VZ3qTCLa1zS3TLV A49o0bouLm+QU+00+amCZ0rjTUw4yIyFfOm31Sg3Shec09zsbbMGjf9ShNfNpzy0zxZEswGJzvcZTh w4R++sq98XmsmnzSX/87MTHp2cWhQxB276FXEZS0Unn1URmr+UqjmtV/wfkg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcpy() in uvc_video_decode_meta() intentionally copies across the
length and flags members and into the trailing buf flexible array.
Split the copy so that the compiler can better reason about (the lack
of) buffer overflows here. Avoid the run-time false positive warning:

  memcpy: detected field-spanning write (size 12) of single field "&meta->length" at drivers/media/usb/uvc/uvc_video.c:1355 (size 1)

Additionally fix a typo in the documentation for struct uvc_meta_buf.

Reported-by: ionut_n2001@yahoo.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216810
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 4 +++-
 include/uapi/linux/uvcvideo.h     | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..b67347ab4181 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1352,7 +1352,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (has_scr)
 		memcpy(stream->clock.last_scr, scr, 6);
 
-	memcpy(&meta->length, mem, length);
+	meta->length = mem[0];
+	meta->flags  = mem[1];
+	memcpy(meta->buf, &mem[2], length - 2);
 	meta_buf->bytesused += length + sizeof(meta->ns) + sizeof(meta->sof);
 
 	uvc_dbg(stream->dev, FRAME,
diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
index 8288137387c0..a9d0a64007ba 100644
--- a/include/uapi/linux/uvcvideo.h
+++ b/include/uapi/linux/uvcvideo.h
@@ -86,7 +86,7 @@ struct uvc_xu_control_query {
  * struct. The first two fields are added by the driver, they can be used for
  * clock synchronisation. The rest is an exact copy of a UVC payload header.
  * Only complete objects with complete buffers are included. Therefore it's
- * always sizeof(meta->ts) + sizeof(meta->sof) + meta->length bytes large.
+ * always sizeof(meta->ns) + sizeof(meta->sof) + meta->length bytes large.
  */
 struct uvc_meta_buf {
 	__u64 ns;
-- 
2.34.1

