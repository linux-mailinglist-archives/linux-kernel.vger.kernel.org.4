Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47A67E30D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjA0LTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjA0LTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516B7B416
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so830803wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=cmdzC9Ke79gvxiCkr5SpkgOurfvZ3Wm8ag6Gkp4JCb7OXo4I4Lts+zkSIMbngSt4KQ
         xVsXkfAQHqXy+iKqCW2yeforXQ8kyR9B4sBT6Pf8eFAEptQoWKJ0eWuTdXychNw338Rz
         8gg2BoWURGl6fOO1qfjbeKLekm873xf8Ig0IpXuis+8bFgk7vnWmLB4jlHdeEHG1rMrL
         7SWRjtvwXWHAQU4HMDZt5npnyhQWWDogyimSRSG8O1TaqvzpUzGd54ER4txsRPkOnPYG
         fGVA4MgfkLgkLZPlr8x65xoXcd0NpD4graK5JX+RCa+MK8I9gkn5W1znLV9lTEc8yjoa
         QbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPRxk+XR4q6rcvb7Uhvae10cdYLboc87AwhU8wC3gnk=;
        b=1t4NMpLA1R8Au8jw4CycqgzCYKs+Mcwh6d1Fm0Bx1P4oRZqmqMQ8yFDHfXCEBPvdHy
         jgh3dBBNJr/XMe4npEsYOuaUKm12Ta5kir1Bus29ZjmpzE5Gae9YdMR1mUyHo7KnjuRH
         5zFuzbLLuaqz5O/aGIsfaZp+AVimckoOWZjfZUEPm18dfFk5XKFIdZaO9lIw+GpeGWyF
         BsL922nwwQXcb86RoFH/UbMZFFtwxxFi2BjsyIB3v/DL195wmoBdTUI8vdFifl7rhvk+
         dLqFnJQ3ZKcjcD1BcwWe0e6Gqc9m9WAMXyuXiMFhuB6TiagZePhJ2cpigAa03xEgO5cz
         HG7g==
X-Gm-Message-State: AFqh2kpUo7wyYlfO4gOUyr8MLOFzq931f/Ly0O+vv1O+56OKPCs1ogmT
        VlISaEq8NBF4H7Sa1lObyDpe+g==
X-Google-Smtp-Source: AMrXdXuUsm+b7NMELikFvUJfhD05Q6hemQ5mgWLt2BZinivDsArUa4v5hhE4x5Keswi4KmnnGLkV3g==
X-Received: by 2002:a05:600c:22c6:b0:3da:fc30:bfc5 with SMTP id 6-20020a05600c22c600b003dafc30bfc5mr40185960wmg.13.1674818304679;
        Fri, 27 Jan 2023 03:18:24 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 33/37] nvmem: rave-sp-eeprm: fix kernel-doc bad line warning
Date:   Fri, 27 Jan 2023 11:16:01 +0000
Message-Id: <20230127111605.25958-34-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Convert an empty line to " *" to avoid a kernel-doc warning:

drivers/nvmem/rave-sp-eeprom.c:48: warning: bad line:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rave-sp-eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 66699d44f73d..c456011b75e8 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -45,7 +45,7 @@ enum rave_sp_eeprom_header_size {
  * @type:	Access type (see enum rave_sp_eeprom_access_type)
  * @success:	Success flag (Success = 1, Failure = 0)
  * @data:	Read data
-
+ *
  * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
  * SP ICD
  */
-- 
2.25.1

