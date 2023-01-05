Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1948965F795
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjAEXaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAEXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:30:50 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032AB2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:30:49 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e21so16929653pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kb9iyUzhyO/yRzb2MYwodXEuGzEEK2s/5ms6ha74TY=;
        b=K2xGRq7G4hmwZEoqOU3XlLDiETKQHO9+A5b4Tov2tqJ+k8AEB6AO/1u/GQYNqkiLu2
         dstWxDme7prx3+57EQ5zsDeSxJPWT7MGvnScvFWG1yPwcVl/8k+gHkoOkrRLzuupqmbM
         H6iBV0VDltRm+UguJYJwc6hiA1U7Y1dBKaqQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kb9iyUzhyO/yRzb2MYwodXEuGzEEK2s/5ms6ha74TY=;
        b=H069wLgRFuZzshMMphaCkFeGOO3hlK/94LcsvTj1C5EfketFW0C1ad7MGD6c/VOuAx
         ikhEiCVm3rVRTAw1TeyS7ZQ84uhnVmKf22KsDH8VSRgQff4Q1jZbj+my1825zsQtp01d
         6J9wWtH+F1rpFHPth1DkPnqV0ZyPphyw1hWe95IOkHLPGeyOfk+3+dTzUzJI0DYaGqOo
         aUQo1f3svBXAMZdP2/e/h99HOWo9Lmfg8MZj1mCwEkoD5MTiglzZkcqngBntV9oObry3
         PQBdzsv/ssG6w54vdzQPBrzOFhAXHr/Vg0TmlanUKihOVPmqUVv/x5tqZlM0nHTh5Fim
         ZWZA==
X-Gm-Message-State: AFqh2kqNctteoNhiAM071SHLJQQWZZz79Kf1UbiqdKws7+jDcsb0EX86
        ZPl+A/Tf8L2317hUbq5Vw2OAsg==
X-Google-Smtp-Source: AMrXdXsj5O4joddqMSTZXpv69162aECI5Dzi5VNoqbAV/i09rRJxMqVl5jPGCKZGH8jOS5qDthEtmw==
X-Received: by 2002:aa7:9568:0:b0:582:c719:c4c3 with SMTP id x8-20020aa79568000000b00582c719c4c3mr10986633pfq.1.1672961448866;
        Thu, 05 Jan 2023 15:30:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5-20020a622905000000b005749f5d9d07sm25612530pfp.99.2023.01.05.15.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:30:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: uapi: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 15:30:46 -0800
Message-Id: <20230105233042.never.913-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; h=from:subject:message-id; bh=q3MZZI/G03tkvHIrcWE8wPRyhsUgVE4YDeJgdc87eVk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt12m2noJQ0jbdpBQb9ezPHSRQ44ShDkRwOksJrbr ejldZpOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7ddpgAKCRCJcvTf3G3AJh+oD/ 47/EsWNMsn/xLs5i5vG8E0HCv/MuHSbxzpgTiOJe+SnzeFfmBYvMd08diHEm/DLW0xoa0eQDvMRHnZ s0qBRnY17u/bnD9+bffPS/n6PEG58eDqA8T1M7foIagxJxgXW8ZoBiMzVn/TmHHl1rQdmORZPdHXVH mjifc2qlU88nvKAadmK8/7Mgo497j1Ad8u4oPGB1Nx3aigCn2p9ea5bzS9jRwXiFrpy7UEOidCPpwj MnK1rSY6OH7H8aY2gd6P+bpJ83mGOlb+U9frd8jOeQAxTqTxzZaCcGmojiKrnqGQ/FDoDYyX6nNtwp 9iOZ6i4qjHumo6BXmLk2ygVOAUw5a/PNHq49NLn2IaVpwdW8v3nEFpchB5Ocm0AQOGrB45zxc7KCqQ 6IIsmogebFOg6K8wZONPGP0uSAvd5GvgdPzfVNHMHVkmv6DChPEYKxT7hv7N16z18OWx9oLwuao2nY 4iQBvOFRUlzPrZuVaqK5L1Hvb3HNwtrIYTbaR3vr/z2l4YzuqeAENVCOVhdAzTV34o0pl08VKZqmji MatpWW+2ROOuUztF3MLTYaKGoALw8EId8q1a4KuljvyHDEfXMuMQkIoHJvrNnTXz/4/T5RqkcnAt5P 05W/xRrDvfN6KIROXRjOn9zrovwj4h6MgGZJtLFE30jHga+2I23SE9CbmNDQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct
fc_bsg_host_vendor_reply's "vendor_rsp" 0-length array with a flexible
array. Detected with GCC 13, using -fstrict-flex-arrays=3:

drivers/scsi/qla2xxx/qla_isr.c: In function 'qla25xx_process_bidir_status_iocb.isra':
drivers/scsi/qla2xxx/qla_isr.c:3117:54: warning: array subscript 0 is outside array bounds of '__u32[0]' {aka 'unsigned int[]'} [-Warray-bounds=]
 3117 |         bsg_reply->reply_data.vendor_reply.vendor_rsp[0] = rval;
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from drivers/scsi/qla2xxx/qla_def.h:34,
                 from drivers/scsi/qla2xxx/qla_isr.c:6:
include/uapi/scsi/scsi_bsg_fc.h:219:15: note: while referencing 'vendor_rsp'
  219 |         __u32 vendor_rsp[0];
      |               ^~~~~~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/scsi/scsi_bsg_fc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
index 7f5930801f72..5e46cf1054af 100644
--- a/include/uapi/scsi/scsi_bsg_fc.h
+++ b/include/uapi/scsi/scsi_bsg_fc.h
@@ -216,7 +216,7 @@ struct fc_bsg_host_vendor {
  */
 struct fc_bsg_host_vendor_reply {
 	/* start of vendor response area */
-	__u32 vendor_rsp[0];
+	__DECLARE_FLEX_ARRAY(__u32, vendor_rsp);
 };
 
 
-- 
2.34.1

