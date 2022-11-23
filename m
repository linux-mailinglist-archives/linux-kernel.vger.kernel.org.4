Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBD635B70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiKWLST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiKWLSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:18:15 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A307258
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:18:11 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221123111807euoutp02a29cf1c7f86dc9e981c55fbc0735e750~qMqLsMIyg1001110011euoutp02O
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:18:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221123111807euoutp02a29cf1c7f86dc9e981c55fbc0735e750~qMqLsMIyg1001110011euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669202287;
        bh=oV8cdo8lsj19m9T+aDjEGQsI2sOWRS3H2FicQr0PLLA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HNTAcsc+njbYIPYHK6eIPzGLe5vhJ8rAGLgL2chEClCU41sTXrYzb/QG79loO3sOR
         zXycC5ne1yKB5bOQYKQHMXUfppL/y/h0fcuLGD4hK6TOk9fDCOieu9E+rWrKyczuNH
         WMXug5fJfYXYa5hxABYHSaupbSmwW/aeIe2Uqjo0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221123111806eucas1p1c2f36c439afb89cddc7fe4389bfde16b~qMqLbun6l0190001900eucas1p12;
        Wed, 23 Nov 2022 11:18:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 84.82.10112.E610E736; Wed, 23
        Nov 2022 11:18:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9~qMqLEyky62370423704eucas1p2g;
        Wed, 23 Nov 2022 11:18:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123111806eusmtrp11243a6a94d3ac925e8b309001fec0b74~qMqLDp4tU2249622496eusmtrp1Y;
        Wed, 23 Nov 2022 11:18:06 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-e4-637e016ecc80
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.57.08916.E610E736; Wed, 23
        Nov 2022 11:18:06 +0000 (GMT)
Received: from AMDC3631.digital.local (unknown [106.120.9.77]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221123111805eusmtip2affe56757d284dbb3d78ebcfa0b19509~qMqKgII1g0259902599eusmtip2H;
        Wed, 23 Nov 2022 11:18:05 +0000 (GMT)
From:   Michal Lach <michal.lach@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     mcgrof@kernel.org, russell.h.weight@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ming.lei@canonical.com, tiwai@suse.de, michal.lach@samsung.com
Subject: [PATCH] drivers/firmware_loader: remove list entry before
 deallocation
Date:   Wed, 23 Nov 2022 12:14:56 +0100
Message-Id: <20221123111455.94972-1-michal.lach@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87p5jHXJBucWmlo0L17PZnF51xw2
        ixsTnjJazJ61gd1i18Pv7BZzv0xltlg6cwWzxcvNb5gcODxmNfSyeSze85LJY9OqTjaP/XPX
        sHv0bVnF6LH5dLXH501yAexRXDYpqTmZZalF+nYJXBmbTzUxFfQIVjxd+5OtgfEwXxcjJ4eE
        gInEspnzWLoYuTiEBFYwSiyeupENwvnCKPHmyQxGCOczo0R/0z8mmJYnd9cyQSSWM0pMndXI
        Alc1d+cyZpAqNgFtiU/H2llAbBEBBYnNvc9YQYqYBZYwSnz6eZYVJCEsECjRs+oM0EIODhYB
        VYnblyJBwrwCNhL37v9ghdgmLzHz0nd2iLigxMmZT8BmMgPFm7fOZgaZKSGwh0Niw74/7BAN
        LhJH3mxhhrCFJV4d3wIVl5E4PbmHBcIulrjzZD4bhF0j8e13B1S9tcSqrTfA7mEW0JRYv0sf
        IuwoMfvuP2aQsIQAn8SNt4IQJ/BJTNo2HSrMK9HRJgRRrSrxv/ET1FJpib0rD0EN95DoezoT
        zBYSiJW4enY92wRGhVlIHpuF5LFZCDcsYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJ
        EZiGTv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhrfesSRbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        yzZDK1lIID2xJDU7NbUgtQgmy8TBKdXANPe3ffiTxzsd7q8NjvzLFKj2XGT3+XuSZnJxpXOS
        FPNl3r3/tP27wLtJvyccmVrel/Oofs/jyNzXf+r7mgwDZRgCXCaZfviYe+GPzGuWu1VbkyWj
        XtVOrDu0ssNpmlXRnyN7nPLeyT+taXA7+6j7xad7k7ftWBB/UuBUmq7pUXmW0rqYA6z8a5lO
        vpKZWyjfGPps8+qLe26ypFwQff9oYb9B0/Oz/bppj/gczwW6H7D259KZKn9z3uZrDXqSK0p+
        O08p8wjfnbdefE3Ii62OTb3VF1Qncuz8a61aV7JszVKHVM+Tz6wurdVZIT89P9H06/IHsiWC
        gh0rnpgIspy2O650m18yNyZ7o/dsjgfrvJRYijMSDbWYi4oTASyaI1SyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xe7p5jHXJBu3TJC2aF69ns7i8aw6b
        xY0JTxktZs/awG6x6+F3dou5X6YyWyyduYLZ4uXmN0wOHB6zGnrZPBbvecnksWlVJ5vH/rlr
        2D36tqxi9Nh8utrj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzNp5qYCnoEK56u/cnWwHiYr4uRk0NCwETiyd21TF2MXBxCAksZJQ63
        zWLuYuQASkhLdM2ThqgRlvhzrYsNouYjo8S6nQ8ZQRJsAtoSn461s4DYIgIKEpt7n7GCFDEL
        rGGUmDllGRtIQljAX2LelhesIENZBFQlbl+KBAnzCthI3Lv/gxVigbzEzEvf2SHighInZz4B
        m8kMFG/eOpt5AiPfLCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSG/7ZjPzfv
        YJz36qPeIUYmDsZDjBIczEoivPWeNclCvCmJlVWpRfnxRaU5qcWHGE2BzpvILCWanA+MwLyS
        eEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqb0wLwNrYsPNFRxdVwp
        XzJjv2b6zHlf9qdnBmZu2q7mvT3+BU+sGevF7coclzOO6bfzNl7+u8Av5o7u92sbD5zb+2zt
        eavMI1WWoZnX2j9f5Y6X/hNb57fmyPpfvWW2T3RYTfytGXL8M/Kyjxpn3uZcw2cYqnODucfn
        v3zytWcrj3xMZc0Qatee1LHyn9L0JEHbuRXnJ33w0F94LWX38XvGv+YXxb1Ye/StoUCgcIW7
        S8yzE0enxl55dfuN4ZyT0dWXtf9sC+UKabGQiSh2lFn5/s+fueYmFxpLTppGNDq/9mfsOW0m
        4Tjlwsaw4o0PDPcsn7axPa5so3wi78+yo9mGpxZMnqpypT4w44nUyvdKLMUZiYZazEXFiQBR
        5NPnCAMAAA==
X-CMS-MailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9
References: <CGME20221123111806eucas1p23fdcdbe6e5f4a9e714db428fcd6552b9@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_FW_LOADER_USER_HELPER is enabled, it is possible to interrupt
the loading process after adding pending_list to pending_fw_list.
Subsequently, if user calls release_firmware() which deallocates the
fw_priv structure which pending_list is a member of, the entry in the
list is not deleted. This causes a use-after-free on further attempts
to add an entry to the list or on list traversal.

While not problematic in most drivers since this function is mainly used
in probe or init routines, some drivers expose firmware loading
functionality via user-accessible functions like write() etc.
In this case during the sysfs loading process, we can send SIGKILL to the
thread which is then in kernel, leave the entry in the list and then free
the structure.

Example kernel panics with CONFIG_DEBUG_LIST turned on:

kernel BUG at lib/list_debug.c:25!
/* ... */
Call trace:
 __list_add_valid+0x7c/0x98
 fw_load_sysfs_fallback+0xd4/0x334
 fw_load_from_user_helper+0x148/0x1f8
 firmware_fallback_sysfs+0xe0/0x17c
 _request_firmware+0x1a0/0x470
 request_firmware+0x50/0x78
/* ... */

or

kernel BUG at lib/list_debug.c:56!
/* ... */
Call trace:
 __list_del_entry_valid+0xa0/0xa4
 fw_load_abort+0x38/0x64
 fw_load_sysfs_fallback+0x354/0x468
 fw_load_from_user_helper+0x17c/0x1c0
 firmware_fallback_sysfs+0xc0/0x11c
 _request_firmware+0xe0/0x4a4
 request_firmware+0x20/0x2c
/* ... */

Fixes: fe304143b0c3 ("firmware: Avoid deadlock of usermodehelper lock at shutdown")
Signed-off-by: Michal Lach <michal.lach@samsung.com>
---
 drivers/base/firmware_loader/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 7c3590fd97c2..381997c84e4f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -209,6 +209,10 @@ static void __free_fw_priv(struct kref *ref)
 		 __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
 		 (unsigned int)fw_priv->size);
 
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+	list_del(&fw_priv->pending_list);
+#endif
+
 	list_del(&fw_priv->list);
 	spin_unlock(&fwc->lock);
 
-- 
2.25.1

