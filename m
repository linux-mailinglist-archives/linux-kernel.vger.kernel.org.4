Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60166651450
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiLSUql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLSUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:26 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D54A1262B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:25 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id f23-20020a5d8157000000b006dfb209094fso4607860ioo.18
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfA/1MB8RCHraPM1ZZUmCBSUNYuUoVh3fP3DF148QbI=;
        b=QMFV2eSAxUPCmTJI+06ooZ3vGoXfoKx9XX7IFkpYAWPmeSDxtIfwAsBfcWJN3ni5CY
         25IOWkIGivPYJA0uHFNBUp35c/G0iYTakt4DY1MuCHflFGzugguEePHY+Vu2CKxLAjFp
         J3ZmBGY6/+5Z4rEPgWVdX1UEwAkvBCZ1G1zuAQu0z+SJiGnK7fTmMyLdgdDm8wi6UGne
         Cdh4YEx0jvHcPTK9u4UIUZmhQzMFoZSwy+SG4IkGOKvNoNrQRrj3FbfeQD7SyJJujU/M
         T9HJPmiiYpy3SNigeHCTqpnQ6orCvOXBTd8k+sG4aeEYDIpL5//nDkDulHNYEviaf3FE
         AUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfA/1MB8RCHraPM1ZZUmCBSUNYuUoVh3fP3DF148QbI=;
        b=1IqMLqxLJw1pbuEbGPWOqUerWYNzYHMsk8VqW+hUpXKnGNi76qVTaOsHR90i0fmWPI
         /xxA24mxMKH5VxoE5oHlgb9/xnBZllC9aVFh1c0ZY1/+VjdwjovZOve3TD9uvwKynbdh
         38xsGnW5q7Z8lMGhhEWbT4qLReTVeTQwA+rAQH/enJbzB9qyaiBDQem/4y5QjnjXx0wP
         xa84c8MdUfG+5oELgK3dbZE1GsMO3P3s7+G/uuVxxC/Vg6y0Iubp1yOh7XGUqRUzKyiJ
         Wvw8FlzY0EhpAwqCdL+wuNkXsVCPU141URVxHKap52yC5kNG30CndPq3sU7v7TY1mFAk
         jGgQ==
X-Gm-Message-State: ANoB5pnhf/OJR9yeJ1ufhruVz5xsw8edRefqDf8Ewda2dmGpShM96aBf
        FsnKiPABUNVt5iS2ERjkFwyBtSaF7YUfA/4=
X-Google-Smtp-Source: AA0mqf42brmElZpSWauXQ+iaomUsERDxLYbZCYOb5hC0qb/ABxbLEAqvt0k0H8xCEJxKX02bTeR1ahkNBsBOJbU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:e719:0:b0:6e0:38cf:f538 with SMTP id
 b25-20020a6be719000000b006e038cff538mr6718031ioh.108.1671482784948; Mon, 19
 Dec 2022 12:46:24 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:11 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-4-allenwebb@google.com>
Subject: [PATCH v9 03/10] scsi/BusLogic: Always include device id table
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
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

A future patch makes use of the device table for built-in modules, so
do not ifdef out the match id table.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/scsi/BusLogic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index f2abffce2659..0c60867c9e7c 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3715,7 +3715,6 @@ static void __exit blogic_exit(void)
 
 __setup("BusLogic=", blogic_setup);
 
-#ifdef MODULE
 /*static struct pci_device_id blogic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -3731,7 +3730,6 @@ static const struct pci_device_id blogic_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT)},
 	{0, },
 };
-#endif
 MODULE_DEVICE_TABLE(pci, blogic_pci_tbl);
 
 module_init(blogic_init);
-- 
2.37.3

