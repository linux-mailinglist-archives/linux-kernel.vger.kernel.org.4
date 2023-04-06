Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCA6D9AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbjDFOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjDFOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:42:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DAB468
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:40:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l18so29191649oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5QEeXDXo+8Slk68c7cxRCftpIfRluY8LXkH8WgnI7Y=;
        b=SK/NklCaaBaTM/Glz90edPtzaUc6wm8CheJFHJgxB8egsFyIDt2Uvlk7xVY4DH/N60
         Xw8We6CFUka6LZHvkAmbJKtbDzNt6QAlYNLNDqKpjl9TmYLz6572rYsyj7XXiA4j2huU
         Xz8ZRRPP5tfvmrV/Ce7cHv19ONC+txfVah0vXoAvUHHq3Ja3Vii+yJvncPhW+ruhT1kG
         RBJvzn9m3rE8N5b2lvHF7tDG2iUi7h0MraW/l6fbhv+9RVcVOW3RueTVEmn1p7DOWIGy
         kUiWGMzcL8R3zUCCdwlOb2yPG0qmbJPcVRruLB5U1Ep3w6OwRAJMCB7aOt/oqFK5miXM
         iCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5QEeXDXo+8Slk68c7cxRCftpIfRluY8LXkH8WgnI7Y=;
        b=A8SzWunRUqoHIGQTdu8nFkQQc6cIuIEOOUC+DaCatlTQvTI4paAtrJ60xJ33cGbbV6
         MGWEavl1/ZanFKC89AoAuPIKhSSx4dAKeB/hM3MQljFlYfEWNYU641OMD1ArbqyViYtJ
         +zE6KG5QhUWYoBOLTrkwdsSCDgOy0UBeyG55lKlyn+sPjfm2zx1hLDffWb++gcaAnCLj
         dgHwQN9Cq5kaA7zWdOe0hRn44hR6/5GH9aPzOdsNQZVsfffADzuPywo4pMRfZknHry0k
         9qHqXG+EWbJV6luhrtjvWhus8i+fbaYx+hNc5A6fL62QV4zF96c999fOcnq/KuEifpXk
         kfaw==
X-Gm-Message-State: AAQBX9dcktLA+jpc8BBfVnilGMqLaXp3dl3joqyAtYaCiLRtr4lQYKKE
        VqgUonzIvI/ERfTahquxiKEJGw==
X-Google-Smtp-Source: AKy350Z4NesDaNZ6svLg943zXrdWqiqQrl3C+lM0UCfe+MlQeUzwbcQUQpigKabEFPi1BbuXIWWbSA==
X-Received: by 2002:a05:6808:285:b0:384:2b1d:45a with SMTP id z5-20020a056808028500b003842b1d045amr4430203oic.30.1680792036750;
        Thu, 06 Apr 2023 07:40:36 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:36 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 4/6] iio: addac: stx104: Improve indentation in stx104_write_raw()
Date:   Thu,  6 Apr 2023 10:40:13 -0400
Message-Id: <487d17da9e2612f3e6b2bd1c3def2fa1b955db9b.1680790580.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By bailing out early if chan->output is false for the IIO_CHAN_INFO_RAW,
indentation can be decreased by a tab and code readability improved.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5: none

 drivers/iio/addac/stx104.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 0ed5f71b18cb..81020b710195 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -181,19 +181,19 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 
 		return 0;
 	case IIO_CHAN_INFO_RAW:
-		if (chan->output) {
-			if (val < 0 || val > U16_MAX)
-				return -EINVAL;
+		if (!chan->output)
+			return -EINVAL;
 
-			mutex_lock(&priv->lock);
+		if (val < 0 || val > U16_MAX)
+			return -EINVAL;
 
-			priv->chan_out_states[chan->channel] = val;
-			iowrite16(val, &priv->reg->dac[chan->channel]);
+		mutex_lock(&priv->lock);
 
-			mutex_unlock(&priv->lock);
-			return 0;
-		}
-		return -EINVAL;
+		priv->chan_out_states[chan->channel] = val;
+		iowrite16(val, &priv->reg->dac[chan->channel]);
+
+		mutex_unlock(&priv->lock);
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.39.2

