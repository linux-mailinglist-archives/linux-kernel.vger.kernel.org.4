Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6974854F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGENp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGENpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3419B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688564659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T+o2RTG0Hb65gnco//4sOAJzUPOXWOr/LTu5B+NLPrw=;
        b=d5J+DoqWckaRpbZQsVgF6QpfsM9si5lYjHctRoNLFT5xwvo4NVepIwnPGi/0kZZBorMAM9
        JaOW1fRkdgUd04r0ZLm0lADPvaciEPYSG7wM60xt6h2tEGZJWXHbIPpd8onDsUX3JfvWT3
        vIm3qyAO3WdStLhiYsSlAvYGDnA5Gj0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-UqAw2cqDMV-k3OSd_p0Wtw-1; Wed, 05 Jul 2023 09:44:18 -0400
X-MC-Unique: UqAw2cqDMV-k3OSd_p0Wtw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-565d5d7b58cso4246894eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564657; x=1691156657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+o2RTG0Hb65gnco//4sOAJzUPOXWOr/LTu5B+NLPrw=;
        b=jUP3WKFJiHX5p2L8SR9daxX5k5j4OQnQMqzXpRtvnVJuoNnd6t0I64B7XEfLlX4tji
         wplrgRvzjXk5a6zWdkR6YHvWM1NHtNYCSHkky9pvsSDsWnH16ElQcC/NJXcOwwRE+WQJ
         DwrQ5ZKE/u9V0KISGKu9438v4i7S93Fs+QouH8muJ9pnPsX8YbYUF4Q2ZMTlr+YR27ml
         RCDBkZiT+GlTW9pewqjIjSjtVHMR65I9KirmQvmf5ttFbEds3mpbCYPCLUN6JN9bb6M5
         KOZYqsfAqt7ddkoPm7atnR7hVBOBfEgGJVhVLYKWX9ceIvju6lnHou43cF4mvc6tzq2Y
         VxnQ==
X-Gm-Message-State: ABy/qLZtL6zvEBF/7cszO1sNuioZaShDwBpTL151JJibnJw5FJ7GpdEZ
        WXLkUY0KfKrh3xXCIHmW38WpSBw1cJyY3lKNptz48169REyQ1Sz0BA6H24AdW3gSAFN9stn5lCA
        xaJjpXyUo6OV/f/N57v6g6WbWSslpvkGd
X-Received: by 2002:a05:6358:ce2f:b0:135:24ed:5108 with SMTP id gt47-20020a056358ce2f00b0013524ed5108mr3704008rwb.10.1688564656768;
        Wed, 05 Jul 2023 06:44:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGE0zZqSbKFgTrY3B/H+Rx4zZXdmwzYAHOS/f6BcW3q/kf/NXLDYjZFmgseUK8rdA7x+IOmA==
X-Received: by 2002:a05:6358:ce2f:b0:135:24ed:5108 with SMTP id gt47-20020a056358ce2f00b0013524ed5108mr3703995rwb.10.1688564656468;
        Wed, 05 Jul 2023 06:44:16 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
        by smtp.googlemail.com with ESMTPSA id v29-20020a63481d000000b00553d27ab0e0sm17550034pga.69.2023.07.05.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:44:15 -0700 (PDT)
From:   Ani Sinha <anisinha@redhat.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     Ani Sinha <anisinha@redhat.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vmbus_testing: fix wrong python syntax for integer value comparison
Date:   Wed,  5 Jul 2023 19:14:07 +0530
Message-Id: <20230705134408.6302-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is incorrect in python to compare integer values using the "is" keyword.
The "is" keyword in python is used to compare references to two objects,
not their values. Newer version of python3 (version 3.8) throws a warning
when such incorrect comparison is made. For value comparison, "==" should
be used.

Fix this in the code and suppress the following warning:

/usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did you mean "=="?

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tools/hv/vmbus_testing | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
index e7212903dd1d..4467979d8f69 100755
--- a/tools/hv/vmbus_testing
+++ b/tools/hv/vmbus_testing
@@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
 def get_all_devices_test_status(file_map):
 
         for device in file_map:
-                if (get_test_state(locate_state(device, file_map)) is 1):
+                if (get_test_state(locate_state(device, file_map)) == 1):
                         print("Testing = ON for: {}"
                               .format(device.split("/")[5]))
                 else:
@@ -203,7 +203,7 @@ def write_test_files(path, value):
 def set_test_state(state_path, state_value, quiet):
 
         write_test_files(state_path, state_value)
-        if (get_test_state(state_path) is 1):
+        if (get_test_state(state_path) == 1):
                 if (not quiet):
                         print("Testing = ON for device: {}"
                               .format(state_path.split("/")[5]))
-- 
2.39.1

