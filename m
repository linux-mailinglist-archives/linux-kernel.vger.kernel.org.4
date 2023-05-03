Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD66F4E27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 02:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjECAbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjECAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 20:31:48 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494902D4E
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:31:47 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id a1e0cc1a2514c-772a3262ef4so1559528241.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683073906; x=1685665906;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+pEr4mb5Zur3Q3nUnZ4OhrYzy499wJZFFnvzigIXG3U=;
        b=QjeFE6mN5MiGDi87j71j4nSAbzIq4rwt81w91exCeiaudrO8/oRdMesqlfCSMIW511
         6N6QfSJlrZC0qIQL3SvOqCcGfXaRHvybRC7/vc4Ypj0YYNRdFMe0o9GbLaFHALniSHfe
         rHp7Wh1hTbOtqFlB0KB5+hb9+Da3Q5SdUrKvOpwu+0XhpFOkv6tV12I3kP5TtUUx/vn1
         jF+GNo+zsX/WUVCjTctR6GUZFQcy1eereto34TUxgJUnDgXH3VcatopWh4l8B1pK8g1k
         bUR7hwTf+8upbpdYgGDUgMbVSHTqndYVQWUUMGgpGXaIQY15KmNoknqdlB4BJi/at1W0
         vrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683073906; x=1685665906;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pEr4mb5Zur3Q3nUnZ4OhrYzy499wJZFFnvzigIXG3U=;
        b=lYbasUgS04/nJDCSVGHsVCLOj72/p3iiId9ETgn1jtjINyx5qeLgFcYiw7tiaX2Vji
         zxoKAFlc//Lz2Roxex2axUToUcND6FiLyI3gIjFmRkDhAkvcGAkvranrFWZHcOcVtqnB
         Xstrav1M3itt3T3hjbVS0YkOv4JNdgUpccgtDDwCOO8c7bBvbugepDfdR3cK3aiPzPI2
         bkLxthWEcDYhMartVMJTX/thScnpmrIaertA7QXf3WEo5gs1owoM4RBJSNI2t6HhMyt7
         E88G6LxAeKoWYE3/LnU44g/3angJRzkqt3BmS+wUPm/gAbIayCKgakSFjDebfi2goelp
         QEcw==
X-Gm-Message-State: AC+VfDw2HycFIvyg+9sKuFp10LbmpuwtbLJY4hmMXNZq1ZvRbLJB9XT7
        DTMASUoAnvnxQ1EAZWucDoSoRbuU3hU=
X-Google-Smtp-Source: ACHHUZ7/RAEnxBFqidksbK7And5YR7lq0R5mnWyIA/9GMcY3+gk7lH9NZZH3ZK5Ci2pzSoAk9j/YwZbOM3Q=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a67:d885:0:b0:430:6da5:c64a with SMTP id
 f5-20020a67d885000000b004306da5c64amr1033123vsj.2.1683073906412; Tue, 02 May
 2023 17:31:46 -0700 (PDT)
Date:   Wed,  3 May 2023 00:31:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503003144.3782774-1-royluo@google.com>
Subject: [PATCH v1] usb: dwc3: Add error logs for unknown endpoint events
From:   Roy Luo <royluo@google.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, Roy Luo <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where the controller somehow fails to write to event buffer
memory (e.g. due to incorrect MMU config), the driver would receive
all-zero dwc3 events. However, the abnormal event is silently dropped
as a regular ep0out event.
Add error logs when an unknown endpoint event is received to highlight
the anamoly.

Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/dwc3/ep0.c    | 2 ++
 drivers/usb/dwc3/gadget.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 953b752a5052..8c9560a9999e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1207,5 +1207,7 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc,
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		}
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
 	}
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c0ca4d12f95d..054f6f297e17 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3803,6 +3803,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
+	default:
+		dev_err(dwc->dev, "unknown endpoint event %d\n", event->endpoint_event);
 	}
 }
 

base-commit: c8c655c34e33544aec9d64b660872ab33c29b5f1
-- 
2.40.1.495.gc816e09b53d-goog

