Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E056D8F59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjDFGZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjDFGZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:25:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB149027
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:25:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545e529206eso319490557b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680762353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOlLzWfgNnbnW7p6oIl7dNBSN44VuNGNPEzVTHeVNvI=;
        b=DhEC60Ow8vPo7JguqG0tasYKWhlNR5us0qs3pPUwuVjtYwga24d+eHKIyJUuxHP8/C
         mMoWhG6yZNsZjWCJ/hm88BJ0JjGjx2rzO7NXlC7W0S2Duh4RR1Oy9wc3BFxm/eKP7seu
         DLd4Xs4bQ5MIlQ4uR056N6YH9lIdLWC4z3bIeCUY8xxTWI5gRm1O0tXRDBVXEcXq1XNH
         Y2FHXHYgQNIJp9eSvjAIpegVdlmn1drVcN4dKHlRFjYWaC7S+SAa53jtLrx8oy2XH+mD
         wWb3TiBEFkib0WdW3AFnNpU8L5h/H2bs8rIT+cDvR6hu11qQAhv+PMc0AndApEDkr0ba
         SeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOlLzWfgNnbnW7p6oIl7dNBSN44VuNGNPEzVTHeVNvI=;
        b=Z8BaUD1Yjsf851xrZlRLG/PVYOEuf09sEuzP9yBT4e/rx5+gSVRv6CEnY4pBNeYyfD
         A/uIgdVdBxcSC1+kmXPtxDK8bcvEEUtZibWOEFtVnHw9NPcDu2n+/AeiS+r1KzFhaZ9K
         IjqjadzjwqFoKM7y8k2dEKnwaz5DQS8CROHPc22oTfh3MP5C+ku/a13DBKWvBFTuCzb5
         NEIZGrrH8+Kr1SpEPwxU4ZV46QtKZV3enLznge+/atrLAfp+ODBhoVUkW2o0EMdNDRaZ
         liGy19Mbp0A6hp+FW2oDeZoxQB8Ee0yMazH+gOwM7k90Dle2B5UVx4bmf553SgjB+jnM
         rlUA==
X-Gm-Message-State: AAQBX9f30FdwLG+Bbn+u0tsUqbtphprOcntmEPSfPPJ7GuHN5wCXDlUl
        7Kmm5p3nw3ou9P35yGqTD1cSuJmEBh0=
X-Google-Smtp-Source: AKy350YUDdDDNkrME3F9EeJBYbj79ysZP1gTcrePjQ9P9oS27Z2z0m05XdL6A446zrghoQ6/MmpBDWdvr1c=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a05:690c:72c:b0:52f:184a:da09 with SMTP id
 bt12-20020a05690c072c00b0052f184ada09mr3270357ywb.2.1680762353705; Wed, 05
 Apr 2023 23:25:53 -0700 (PDT)
Date:   Thu,  6 Apr 2023 06:25:49 +0000
In-Reply-To: <20230406062549.2461917-1-badhri@google.com>
Mime-Version: 1.0
References: <20230406062549.2461917-1-badhri@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230406062549.2461917-2-badhri@google.com>
Subject: [PATCH v2 2/2] usb: gadget: udc: core: Prevent redundant calls to pullup
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_gadget_connect calls gadget->ops->pullup without checking whether
gadget->connected was previously set. Make this symmetric to
usb_gadget_disconnect by returning early if gadget->connected is
already set.

Cc: stable@vger.kernel.org
Fixes: 5a1da544e572 ("usb: gadget: core: do not try to disconnect gadget if it is not connected")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
* Fixed commit message comments.
---
 drivers/usb/gadget/udc/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 41d3a1998cff..f18a5ef7e6ab 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -702,6 +702,9 @@ int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		goto out;
 	}
 
+	if (gadget->connected)
+		goto out;
+
 	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
-- 
2.40.0.348.gf938b09366-goog

