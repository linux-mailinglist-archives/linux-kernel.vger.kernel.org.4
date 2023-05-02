Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB876F4B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEBUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEBUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:34:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E41997;
        Tue,  2 May 2023 13:34:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso3077573b3a.2;
        Tue, 02 May 2023 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683059671; x=1685651671;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQ3mjNB18PJwmZ+twuLFKpTCTV95U8I5JkqBE5yVBMg=;
        b=O/xM7pixRfF3HafraVk7nXYz/EE1YDhNpopV/fr89Rz4GEAu1dce4tmBZtNShCvyMY
         WvDcGCFtQz7Yxs0dNBvbyEoxZDRNKrNB0qJ5ZBc+2ZXr6SWEO6GI9N3H9TQVvxPLF6hX
         hYwvgl5Chq1+Hn5yHFEuJoYtHUw3w1XnKrVIhQi5xBoLUfAV/61zSjhI5WJ0lHRLt79B
         6VRbwkmu13cOxekg2n88TCmG7zma36whMBI7ZWE2aORQrifva3iK1k2hrcvLaOfLpRhA
         vP7XiXK0YYi/YRWw9exMIImsGe3vnA1anbX+ZDx9DvxJoGmvxyokwdaNe2GDwvwdK4T2
         H5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059671; x=1685651671;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ3mjNB18PJwmZ+twuLFKpTCTV95U8I5JkqBE5yVBMg=;
        b=bjKFMjpQcQ5/qLRfZHPiBCey1kKx98LD5Y35tnPhGpqdMR/c8CA86B758bRbPCDfFN
         lzisK5lwOkYUVeORmaxR+KdJ6vTg16PCeluwW7gtosoSGQEgBIl+IvHwZ5Hb89jxBG/D
         arzXPb9JMXLD7OO1WaA2wdZrXfNTxr1R1+WrL4tCgKjxeWoaKA8BYzhpVHfTgm/YzIAj
         24K1tRU8fo4cZCyQ6fOvo8MFuWeB9G9GmsOoRrzcNoNvWXnLE5bMqfkoCqaJJ4qJSB33
         xSIu2bIJRBKd9o9LCo2tiyjOE4+emRPOxrb5JagjLyrLXBthfR1pe0AScDEjECYTccUo
         YAQQ==
X-Gm-Message-State: AC+VfDxvV1lQ/0Ul321CTWnK8MBNDzBrga14TFJmiSqjY1qvzTHWk60/
        xdCK1zOQgbC4V0hrPSWKQLU0/kymNAk=
X-Google-Smtp-Source: ACHHUZ7KWTtXy4fKW93zEk4BISCpysB9KrHIKp0qZq2IucUJLiCKVJvbqlqfhMl4WOa3Ktq1p5gomQ==
X-Received: by 2002:a05:6a21:168c:b0:f2:be63:23ed with SMTP id np12-20020a056a21168c00b000f2be6323edmr20181013pzb.35.1683059670531;
        Tue, 02 May 2023 13:34:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6edf:1ae0:55be:72db])
        by smtp.gmail.com with ESMTPSA id z21-20020a62d115000000b0063d24fcc2b7sm22180639pfg.1.2023.05.02.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:34:29 -0700 (PDT)
Date:   Tue, 2 May 2023 13:34:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Input: fix open count when closing inhibited device
Message-ID: <ZFFz0xAdPNSL3PT7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the kernel increments device's open count in input_open_device()
even if device is inhibited, the counter should always be decremented in
input_close_device() to keep it balanced.

Fixes: a181616487db ("Input: Add "inhibited" property")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index f791d14ecf23..8c5fdb0f858a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -705,7 +705,7 @@ void input_close_device(struct input_handle *handle)
 
 	__input_release_device(handle);
 
-	if (!dev->inhibited && !--dev->users) {
+	if (!--dev->users && !dev->inhibited) {
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
 		if (dev->close)
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Dmitry
