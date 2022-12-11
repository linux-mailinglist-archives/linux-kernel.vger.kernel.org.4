Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9C6493C9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiLKK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 05:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:56:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCFFAE6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:56:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so9262611wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAvGt3vLdbPiY+2Of1sNsoY/Xfkar684+8jXtNIqH/o=;
        b=olfa3spiHiwdBT4E0YPycmSCjFe+kp3ZbHrQPbsQmCqGxibWDc8qV4Cz+GMaAg5VrV
         BzxYFgRm30SHRXMekG2Y+n/dNSrDUBP3mmi80lzChaXL99dUyYlG/cuQEhzo8zyZjtMR
         qxWv49uCs4ip8zaJUbclokn8H9YjUAaQ9rC+soeBppNF2TwXGZ3i2lCc9InDHa3G3w3Z
         +QP5le2wL94RYD5WQEKe80IIFZQHJbBgN4uvZEZ6iQrgGivWQSjPWAK/b9DYR+3AoTk2
         onOFyAIFAudQBNZkkNMJa8pEJY4HcUQIFhm2X7CzIpd/88ifNl2FPeGeJQkpVGo+kr7X
         AuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAvGt3vLdbPiY+2Of1sNsoY/Xfkar684+8jXtNIqH/o=;
        b=t6VgZHmlV9VQVZYh0Gg4IvpX2/0KQpwW9p97oQSs0Gvn0gmL9/Mo3mhVeGbfDnhSed
         4pm/8xI7OI4xg/jp5u8yvzn12skB/NrMB0nsz4I0KtVKpP6LYvFRkBZAf46TBwxjOhzk
         XkAKEuFCKKDJmW+4DKksUaegihtq2Opgg2/XyhQAe+e1CP8HYwGO52ONaHUcC0k5THHZ
         XLXuMmpp4Ay5x41BaH75tOSGz6Oticj80RBIz+WEo4CM6OVPKiWow8joDwPf2rMxuxhz
         5LILbhqNoerc62wquSKLmfsB1AlAgz/3MdoQu/+zJOE5fTqcs9/LJBKmu+x5R8Nu7YHD
         4OnQ==
X-Gm-Message-State: ANoB5pkTiAs+K+ZXC0uVBJQlpEXXzpoAjcKL9B9wDhqnniXXdn0pqAVl
        X8TFzT7t+dPLckp7oGvLqtHkbcY51TYM
X-Google-Smtp-Source: AA0mqf7zKuKHJILouCKRvL3z3BO4PlGpMm7J84X65Ob+k1s7jKSRMTqf9I/8n9TZCQ3eRFCbyf7EKg==
X-Received: by 2002:adf:f88c:0:b0:242:5563:c3b with SMTP id u12-20020adff88c000000b0024255630c3bmr7406248wrp.59.1670756211870;
        Sun, 11 Dec 2022 02:56:51 -0800 (PST)
Received: from koolguy (dslb-094-217-227-056.094.217.pools.vodafone-ip.de. [94.217.227.56])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4fd1000000b0024246991121sm5821908wrw.116.2022.12.11.02.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 02:56:51 -0800 (PST)
Date:   Sun, 11 Dec 2022 11:56:49 +0100
From:   Dalvin Aiguobas <pharcodra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: wlan-ng: fix checkpatch error for spinlock
Message-ID: <20221211105649.GA4683@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch Styleproblem fixed by adding comment.

Signed-off-by: Dalvin <pharcodra@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 0611e37df6ac..ad117d570bb6 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1171,6 +1171,7 @@ struct hfa384x_usbctlx {
 };
 
 struct hfa384x_usbctlxq {
+	/* lock: Protect structure fields */
 	spinlock_t lock;
 	struct list_head pending;
 	struct list_head active;
-- 
2.25.1

