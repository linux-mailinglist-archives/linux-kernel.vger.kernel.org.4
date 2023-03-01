Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193A26A7659
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCAVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:49:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF735241
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:49:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so1782886ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677707396;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RECI28gZMH42xFUmeyPKXZCKhhTKa9MVymREOSN0hE=;
        b=T+pFFGwgPa4pI0wvbgJ5Nv1XTD6EzJ980GZ2CigJCMiXo/2H5AX2iP09w37S8IkDjs
         fKurysuLB9rmkvZMmooNXV33jeMaXBLYE+5q5Hd3LoaMckW1hbMyXwpg/jW00gJz8UvF
         XFYJqb8SbTGqi0KRJmYp9lbhlAPBOuwHK9/+l/NS4grrK6z11GVzoj/jdA5tf4L8oGCw
         68Yk/Wz6Tlqn1Xwc2FN6OogUeAXezh7Ih9ks48KB0WwQdmIv9vQbpEF4U7gQHfJXcVKT
         51y6dDi03TLct9Z3/7qP68F9zjaGT7rZKFKlLOUKzTf5HC359WvrKA0LAIEq8HeYF3NA
         NkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707396;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RECI28gZMH42xFUmeyPKXZCKhhTKa9MVymREOSN0hE=;
        b=k89NZSmrvJvonrhUt9OkT+TzKSsMfms4QxgFnH/yNUozNFi51J5SPFJ+LfoPnDVDTc
         +6NwKj4DuVG+EgAW8oyc6IGEgiDM1Zd+LEwRLZ8uh6mBuJi1pzgq6QnvZ3J0XLP9aJ5+
         bQ6z5Bt1JN0bXsKjA4lfCeP+EybzBxFWap39C9Aa9shCGa/aIrh7Qnz5xKE8z5GQGJyq
         +SpdxmJI44FTXlzRGyPom2RPd6Fo6UgLlUsgnBtfGWBLF/BjwlfDXcLZl4G0/1ykAJGm
         NNYKzJkww6AqJEtpLOYOdP6BfzaIUL98cOGpct5CKeiC2QUc/IUkhIvXtjwzeZCfcj6j
         C+iQ==
X-Gm-Message-State: AO0yUKWeMdDINtjZthRb8pyF7hypnx8ecXqAj/+NuTCKAT0vONJ1mNfa
        YNF0qd2TYciKXQSoVY9zg2epSiigtGIif50=
X-Google-Smtp-Source: AK7set9qQzjT7IWidSbI9GPtE0+6SsLSf3v2Z8moxU6S0G3hx6ZtJgjiUAecBGiGtoIpLuPquRTIbXuK7rxyQ4w=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:debf:1aed:5c45:c92])
 (user=saravanak job=sendgmr) by 2002:a05:690c:f0d:b0:52e:e8b1:d51e with SMTP
 id dc13-20020a05690c0f0d00b0052ee8b1d51emr7909315ywb.1.1677707395850; Wed, 01
 Mar 2023 13:49:55 -0800 (PST)
Date:   Wed,  1 Mar 2023 13:49:47 -0800
Message-Id: <20230301214952.2190757-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongqin, Martin, Amelie,

We recent refactor of fw_devlink that ends with commit fb42378dcc7f
("mtd: mtdpart: Don't create platform device that'll never probe"),
fw_devlink is smarter and doesn't depend on compatible property. So, I
don't think these calls are needed anymore. But I don't have these
devices to test on and be sure and the hardware I use to test changes
doesn't have this issue either.

Can you please test these changes on the hardware where you hit the
issue to make sure things work as expected?

Yongqin, If you didn't have the context, this affected hikey960.

Greg,

Let's wait for some tests before we land these.

Thanks,
Saravana

Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>

Saravana Kannan (4):
  usb: typec: stusb160x: Remove use of
    fw_devlink_purge_absent_suppliers()
  usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
  usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
  driver core: Delete fw_devlink_purge_absent_suppliers()

 drivers/base/core.c           | 16 ----------------
 drivers/usb/typec/stusb160x.c |  9 ---------
 drivers/usb/typec/tcpm/tcpm.c |  9 ---------
 drivers/usb/typec/tipd/core.c |  9 ---------
 include/linux/fwnode.h        |  1 -
 5 files changed, 44 deletions(-)

-- 
2.39.2.722.g9855ee24e9-goog

