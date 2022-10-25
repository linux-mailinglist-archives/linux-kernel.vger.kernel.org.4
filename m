Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC460C9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiJYKWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiJYKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A221290AC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666693131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SXA47cu2kRp4Fi4dLuQ4em2pKNdxxQ8Fg0d1TX3Qq34=;
        b=N4T2RBJTlEZV5ZRcxVlLEidUeDMHSGjgQNL0m9LHfKuuYUGS1c3t7jvbD/oEnqo/P8mO6L
        5Gs494d50zqX16sWt4+dWgsDl9Mek7UxTFMLZ29wx6i8s5knzJ9q9L9zpY8LYLjx8avpV+
        asChgPBDUdroqhqh6pNjX5BRWX6N9Tk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-D5fbiyQzPcKxNoCBN36U-w-1; Tue, 25 Oct 2022 06:18:50 -0400
X-MC-Unique: D5fbiyQzPcKxNoCBN36U-w-1
Received: by mail-wm1-f72.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso437372wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXA47cu2kRp4Fi4dLuQ4em2pKNdxxQ8Fg0d1TX3Qq34=;
        b=aX42Zr/RTptHiy1Uo7XtNi1wp1KHj2aIDJZYoJZNubEnCUcuHUekxE9PVHL/fMbRt2
         3jru85ciA7Dtcm7wfH8ZGjCsp8Q6x5X7elxgZ2+l5tXQMrkcgowTDpLXciu3YbUzU31k
         DjtfQWzG8ddmpJD5GRe1vx3mvxcYdxQRPzjPhgw2vLhbNMiMbzc2BbunSHdyB/5+YEuP
         Pcsgei8cbcGeoXz7H5VaGvSO10tEMMDYVYQ6KARuo32MsXZ5q7MvlE1Wg2p3pDNjHHPC
         cVT+FAaKpMQ3dxlNNv2VTKQelIbOWoUx3yaCYrSXsbsfH4P2/SXQQftF2XFAGj0hm6yq
         mMPQ==
X-Gm-Message-State: ACrzQf2LMiVxGvG7v+7eIb53gVaBS7qalAy89RDqyKSKQ/7Gi1874qnX
        yvlcXwjf3tqK8PoJJhmaFCkwhQsoQ1GQwPuwnaPeqj7aBkAes1QGuqYYkWj/UAfOiM5uHKyMC3c
        0/6l+6HcZhWS0D5nPL2datzQI
X-Received: by 2002:a05:600c:468a:b0:3c6:f1ae:3e95 with SMTP id p10-20020a05600c468a00b003c6f1ae3e95mr25551266wmo.152.1666693129119;
        Tue, 25 Oct 2022 03:18:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6puwz/55DZ3rXyf9X2tFB3ea5/Zm1rwqyhGbqCvzGWOzYvH36S16hJRbfVGi0WMwv6B0ixsg==
X-Received: by 2002:a05:600c:468a:b0:3c6:f1ae:3e95 with SMTP id p10-20020a05600c468a00b003c6f1ae3e95mr25551249wmo.152.1666693128920;
        Tue, 25 Oct 2022 03:18:48 -0700 (PDT)
Received: from p1.Home ([2001:8a0:672b:1200:af07:c9d2:aa37:4cdd])
        by smtp.gmail.com with ESMTPSA id bo9-20020a056000068900b00228a6ce17b4sm2222525wrb.37.2022.10.25.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 03:18:48 -0700 (PDT)
From:   Eric Curtin <ecurtin@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     Eric Curtin <ecurtin@redhat.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org (open list:SPEAKUP CONSOLE SPEECH DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] speakup: include types.h so u_char is a known type
Date:   Tue, 25 Oct 2022 11:18:24 +0100
Message-Id: <20221025101828.1626490-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes build of utils.h header file, occurred when building kernel on
postmarketOS on Lenovo Duet Chromebook.

  drivers/accessibility/speakup/utils.h:57:9: error: unknown type name 'u_char'; did you mean 'char'?
     57 |         u_char *pn = (u_char *)name;
        |         ^~~~~~
        |         char

Fixes: 6a5c94d92699 ("speakup: Generate speakupmap.h automatically")
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 drivers/accessibility/speakup/utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
index 4bf2ee8ac246..f6fe477ecb28 100644
--- a/drivers/accessibility/speakup/utils.h
+++ b/drivers/accessibility/speakup/utils.h
@@ -7,6 +7,7 @@
  */
 
 #include <stdio.h>
+#include <sys/types.h>
 
 #define MAXKEYS 512
 #define MAXKEYVAL 160
-- 
2.37.3

