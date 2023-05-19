Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066EA708EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjESENX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESENT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:13:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903B10EA;
        Thu, 18 May 2023 21:13:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9659f452148so529294666b.1;
        Thu, 18 May 2023 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469597; x=1687061597;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrcvNl9atwbaW1k9X95ljqmJldbIG/iywgMh4yMoDfM=;
        b=GGodfivCHSnFwM5Axova+wchu7kt4iW3YiEJKx8JonToADWamINBlFj4STqUZU1Xy4
         IGl/uoXkPfPzzGxTcoO1omSUWWoJtSVxe/J3v/Hg8q7PsObEo4riWksAdYiYNG8O6Cax
         fEReM7ol/DUAAUxioHOxe3ZOt8eRZHXTrtoioN3yl6cRMKupVD/GtNp1OrotfZDlAQfK
         /SnbwlSbpgpLiOEvtYY0SW0T1xUi15y559v3XaL6A08c411E3J2VdiWjQT25YYvRyLTn
         T7N8qmcFtq3upi/kEcWQ+2tF37//n9En0KRi2OZExg5MrnIQ4tMwQfrL8W7dbRAj+HuU
         M+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469597; x=1687061597;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrcvNl9atwbaW1k9X95ljqmJldbIG/iywgMh4yMoDfM=;
        b=R1sMc4pmZQ7szIuueyYLvLpsmfHfPOXmDL0i+FceyKIqLZL6me8CFls/M7iyQggjfS
         p03GAR8kL42nYP2VwmYxqBVcrINg1BzsA9MW67KIh8xw51Rl8MHg9L5uoTE9fKHp1f7P
         fuMt23W/4iT9rrZ18qyQaYkLtYCdYGoo9SALiMWOq687D68UiYdYjVNGSgLWQ7fz2IhI
         5BaLo7xraExHVydMShKW1wKWToamdgFq3QGgCUp/awKjQ20lH65F13dKVDPzDEPynVAr
         mp8jhf75SdGWwRcHL2EoLrBqQ3x67gUi7EHTuKTHaBagUgP5BJvZcAOxeR/dYv4z9bXb
         AXBA==
X-Gm-Message-State: AC+VfDwq9oIKPdYqsBRf/xhBJQeoa379dcPht3WZgQFOlTj5Lz4nye1P
        tfIDY5WfUTNRxJ2xdH7bHqnFVDlBUyw=
X-Google-Smtp-Source: ACHHUZ60TyXBhznQXFeygSMzxImdpYgfWzTepX/yEGme4rJ4Bq27UeQq+Ukv+TPSOx9yHx91zjsHhQ==
X-Received: by 2002:a17:907:9614:b0:966:2fdf:f66c with SMTP id gb20-20020a170907961400b009662fdff66cmr605789ejc.3.1684469596509;
        Thu, 18 May 2023 21:13:16 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cd27:98d3:5e2d:5b95])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709066c8900b0094f124a37c4sm1799505ejr.18.2023.05.18.21.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:13:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove broken entries in QUALCOMM TYPEC PORT MANAGER DRIVER
Date:   Fri, 19 May 2023 06:13:07 +0200
Message-Id: <20230519041307.32322-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
adds the section QUALCOMM TYPEC PORT MANAGER DRIVER in MAINTAINERS with
two file entries for header files in include/dt-bindings/usb/typec/.

However, these files are not added to the repository with this commit or
any commit in the related patch series. Probably, these file entries are
just needless leftover after the work went through some refactoring.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove the two file entries for non-existent header files.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Bryan, please ack.

Greg, please pick this minor cleanup patch on your usb-next tree.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3182992769aa..a987ed462d64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17559,8 +17559,6 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/qcom,pmic-*.yaml
 F:	drivers/usb/typec/tcpm/qcom/
-F:	include/dt-bindings/usb/typec/qcom,pmic-pdphy.h
-F:	include/dt-bindings/usb/typec/qcom,pmic-typec.h
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
-- 
2.17.1

