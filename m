Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506D6697A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbjAMMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbjAMMoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BA3D5E4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so32929109ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcVlem0HZR7YKz5CwTwpHOGM7j8McIJNietyZfce8tM=;
        b=lG6G/hEiefVVw2KVntwXpYtJaFeZcpH/bmr8zyHNCudsGl5VmkDU4N+8sUHUREXchX
         9t4DexO2EUVb8fflnf450J/HAESsipmjohr0+8leLKzThOAy98UQ2LNsyLzog2q6Kzi+
         QVc7cJtKfrFOMAyGHpbwA7+OSX5P+PCXYau7IJ/hQGeeG8IpWzilFfaTpUp/ICcu55XU
         EWCiyQyNs3M3/+PLd/ykAbv6s4xWjuiggSTvES0cZ505UVSpnzqJxFikHe08w8as1LD7
         eZUOw5vgYoOmRVieRXXUIyiZkfFZ95VHB7frMXY1SD9V03Qlh0ffq17r7g+1O8AfcAJ8
         iNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcVlem0HZR7YKz5CwTwpHOGM7j8McIJNietyZfce8tM=;
        b=miA7YI6qVMDz4dCAEmln+QmqVroLcPGa3bG2Ic6Vl67VGzJ2+lP7nUva6LiKETcrSo
         e8lfNeKqGGqRTpjh3KxgysJZVSBI/3nDkknGTDsWG2CM/0neZfBk6eC9ZWisKYvTPq4s
         PKBzK/sv694r0sOjqj9NxodeF7c5oPAAEqgOLv1dTamwaLANKjrmZZ+DrczyF9tKoDqa
         ck7Jn7mp6ug3J+nJv6veE44XjXI7A/AHoPLEVctiGbRAuzUY1DxTbntZ0KwyYM9WZ1la
         jVHEXeStUQ91Ysw6jC9I4WxFKbDNplzjgpQKTT7wp2GPAdLcx9ZZE7Qmg1ybbHbtDA2Y
         Kbxw==
X-Gm-Message-State: AFqh2kop5xlXbJoUH/TMRk+D6/QkYgCLg8xwWtN5ZhpgvukDshm5A6H8
        t2/fJIJaum0PQKmy1yEt6MjaGw==
X-Google-Smtp-Source: AMrXdXvmEfVGE0E0aDpzmsg2EuQkWLIHv64IwT9jaTlSW7PkvawhNzp4GxxGZWti7I9S0phQqs5NJA==
X-Received: by 2002:a17:907:8b89:b0:7c1:6f86:eeb with SMTP id tb9-20020a1709078b8900b007c16f860eebmr66679431ejc.7.1673613344302;
        Fri, 13 Jan 2023 04:35:44 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:43 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Robert Altnoeder <robert.altnoeder@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 2/8] drbd: fix DRBD_VOLUME_MAX 65535 -> 65534
Date:   Fri, 13 Jan 2023 13:35:32 +0100
Message-Id: <20230113123538.144276-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Altnoeder <robert.altnoeder@linbit.com>

The protocol uses -1 as a reserved value for
'no specific volume', and since the protocol field
is a 16 bit unsigned value, -1 is converted to
65535. Therefore, limit the range of valid volume
numbers to [0, 65534].

Signed-off-by: Robert Altnoeder <robert.altnoeder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index d64271ccece4..058f7600f79c 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -21,7 +21,7 @@
 #define DRBD_MINOR_COUNT_DEF 32
 #define DRBD_MINOR_COUNT_SCALE '1'
 
-#define DRBD_VOLUME_MAX 65535
+#define DRBD_VOLUME_MAX 65534
 
 #define DRBD_DIALOG_REFRESH_MIN 0
 #define DRBD_DIALOG_REFRESH_MAX 600
-- 
2.38.1

