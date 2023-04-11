Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCB6DE4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDKT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963215590
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681241028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qhq9dpmn2VnCwqB0zz5VnZkW7xe5Ahb4i2F79uPfYtI=;
        b=AIquNZrOvUeKxJdSXBfmwIByQXR2EVwqbAyfRgXxYCjxuTU5/4v4KlQvPcah/r0bfjUBLe
        Qz0fm5JbggXJu44o78/PHMTkr+ewMAOqQ4fMIyUZ/NG2LFy0gQTArMG4bKnrV9QqeTwiVW
        av8Aj1xJmBO7VnqMvKjClKhqw6EybHE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-DxK9xDEeMFWrPi16RtqXpw-1; Tue, 11 Apr 2023 15:22:05 -0400
X-MC-Unique: DxK9xDEeMFWrPi16RtqXpw-1
Received: by mail-yb1-f199.google.com with SMTP id c67-20020a254e46000000b00b88f1fd158fso25289097ybb.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhq9dpmn2VnCwqB0zz5VnZkW7xe5Ahb4i2F79uPfYtI=;
        b=BFJC20XXFWSG6CtSqSz9kcgKDEqTDLT2W3/h5XyeG4omE7QpgQT4iLmqSPQj2CwqSx
         f5PMkHywLpvRlw7dpliXwn0FQs+QnbU6o3fsi5oArs6ULZkwrSo5a5SGk1xcRPB4D4VC
         JOTLxFR1QfgdkeYJyT7Ebpzd3bXUkmKKPa750d51xddmfk3GdkCpcA32MItWLkZYNCZq
         3FFWECylKKb6AbN5qZ3oVkTJqZ68hb06DSH7AjjXWr1Wl25zkDflJzivAAwmecTZHGfV
         6vfJcyFOcSXN6WU2ukNjr0js1qTGPzTeQqqJWPj50GVYizqpP795kGeVzY6/36pwFfqr
         CV9A==
X-Gm-Message-State: AAQBX9evv5Gd2uHsWMx6FjUqJFx/5ADkc05t4iy9J3MDlNkeOk3G/WzB
        w7hYrZ3ah8PHAnrgStK1kRe1hcABtH/M0G78raCO5+q1o3JF0X+nSSWC4bgQC5cNS+n25ziayWA
        xLGLvS6mxnUcdtXzXgZ/lD+A5
X-Received: by 2002:a81:4fc1:0:b0:54e:a6e3:4f28 with SMTP id d184-20020a814fc1000000b0054ea6e34f28mr11197578ywb.20.1681240924943;
        Tue, 11 Apr 2023 12:22:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350bAvGxiyboI6lM0HhwWpo/+tevQ7im6CkFWSvHGl5+7rsYinPvTzZuQW64FTQLBwLf4ZWk5xg==
X-Received: by 2002:a81:4fc1:0:b0:54e:a6e3:4f28 with SMTP id d184-20020a814fc1000000b0054ea6e34f28mr11197566ywb.20.1681240924699;
        Tue, 11 Apr 2023 12:22:04 -0700 (PDT)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id f10-20020a81414a000000b00545a08184desm3687792ywk.110.2023.04.11.12.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:22:03 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     corbet@lwn.net, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, linux-doc@vger.kernel.org
Subject: [PATCH] docs: clk: add documentation to log which clocks have been disabled
Date:   Tue, 11 Apr 2023 15:21:53 -0400
Message-Id: <20230411192153.289688-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing clk documentation has a section that talks about the
clk_ignore_unused kernel parameter. Add additional documentation that
describes how to log which clocks the kernel disables on bootup. This
will log messages like the following to the console on bootup:

    [    1.268115] clk: Disabling unused clocks
    [    1.272167] clk_disable: gcc_usb_clkref_en
    [    1.276389] clk_disable: gcc_usb30_sec_sleep_clk
    [    1.281131] clk_disable: gcc_usb30_prim_sleep_clk
    ...

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 Documentation/driver-api/clk.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 3cad45d14187..2199c0042e75 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -258,6 +258,11 @@ clocks properly but rely on them being on from the bootloader, bypassing
 the disabling means that the driver will remain functional while the issues
 are sorted out.
 
+You can see which clocks have been disabled by booting your kernel with these
+parameters:
+
+ tp_printk trace_event=clk:clk_disable
+
 To bypass this disabling, include "clk_ignore_unused" in the bootargs to the
 kernel.
 
-- 
2.39.2

