Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BE5F83E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 08:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJHG7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 02:59:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4B26CD;
        Fri,  7 Oct 2022 23:59:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 10so6401264pli.0;
        Fri, 07 Oct 2022 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSvlYX8e1v8IcVa7ZdS+LbOU2TiaIvYeSlxWuVBo8Oo=;
        b=H1fGSKe7R4b/cSt8qy60T/JfI3VvuIYnGsruIlFvA3rf0J67og4dQBHcOWlTaNMEz9
         0IwD9Y7v7uPTotHLciTOh0CXxusBke6aSf8ZCqJqY14HlqDEk+uk3ZS7Wmh685NPXkQN
         p0CNXzHxzPupiI763vpRxS8UgjaZECKx2RX+AG8h36qE091YzbIHi4nghzS7Mc1xTgMv
         Cl7mrFn4ygGu2xkJUQsjsrU27rnwr7WNjJLv4n5G0CV03BuQTctgurRu8Bh7Ypnd/b5e
         LP7XgDe1iaATog4PWqBc6STToO6MT6vzXWCvdX9qyrXg8sbe2VGsL5g1E9qFJ7OM+i7y
         3Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSvlYX8e1v8IcVa7ZdS+LbOU2TiaIvYeSlxWuVBo8Oo=;
        b=t43CP4x+l975Nkx7yz2+xEc8p0r1l25NPIHBSqJlZFdNJEY6yu557/aJx6kCV83OK4
         JWCujtzrBhGfutsY/NtZMdLfPbE76lwtx+0Rh+ggsjI/OBHLsefAtALihvVTtb42hTt8
         HTROXu/Qz4j5pJyEvIgjazMyV/LX1A4l20kO63gPHC+/yFU2W65y2/tNpj2gRvA2mkxQ
         bt0cs8ohOQk6X3QNDVOdZrGj2LKmJw7Qr4mh+OBVFJbLo0A6UmjiWQVM51Sk8F2dN5Qm
         D1Z/719PPx+bmKN6IPGUT3tEYv4Zuc2CMzH7VOhaPZuRO7NpgwJz8RSR6LsiM7CQ2nNZ
         FJRg==
X-Gm-Message-State: ACrzQf0OkVxpNvnHXleXx1SVFD+CnBCqaiSxmaPb3UfLd9FDoKITMrnQ
        inwhWVWFH8J8zi8l1lhBSDW44vm1H5Q=
X-Google-Smtp-Source: AMsMyM7ksHv23h9s5VSaF0uLKlsI143oa9T5yDfVaU7PTsLPVlqJzDIZo07Thv4oZf8D1XppCj6w5g==
X-Received: by 2002:a17:90b:4c45:b0:202:6308:d9c4 with SMTP id np5-20020a17090b4c4500b002026308d9c4mr9406978pjb.40.1665212379990;
        Fri, 07 Oct 2022 23:59:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b0017f9147983asm2598996plh.175.2022.10.07.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 23:59:39 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] leds: leds-bd2802: replace strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 06:59:34 +0000
Message-Id: <20221008065934.308408-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/leds/leds-bd2802.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index 2b6678f6bd56..cbbda0cccf46 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -451,9 +451,9 @@ static ssize_t bd2802_store_adv_conf(struct device *dev,
 		return -EINVAL;
 
 	down_write(&led->rwsem);
-	if (!led->adf_on && !strncmp(buf, "on", 2))
+	if (!led->adf_on && sysfs_streq(buf, "on"))
 		bd2802_enable_adv_conf(led);
-	else if (led->adf_on && !strncmp(buf, "off", 3))
+	else if (led->adf_on && sysfs_streq(buf, "off"))
 		bd2802_disable_adv_conf(led);
 	up_write(&led->rwsem);
 
-- 
2.25.1

