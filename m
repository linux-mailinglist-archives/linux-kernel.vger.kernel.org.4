Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D516D258C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjCaQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCaQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8422EA7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680279983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AvuVQhbB6sQNpw8Mymcj39/nOL4/GBRsblrkJXNADLc=;
        b=VuYXoM+Nm+7CDuDMY5QXoUDV533w3moevJVgfMQkYaelTqP+8TaJG4RPF1JJYZFPSsb+6Z
        2dU+yTf9zUYja4XHqDGtkRuXEpOL0ivnaytoNhUe3KIHLCKiyLUqy7Y62ovbhyremA7LcC
        R6A0jXcaZKOodX+SI7Ojcstze1WW7WY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-gqTpessBONWBThYXQ-_wlw-1; Fri, 31 Mar 2023 12:26:21 -0400
X-MC-Unique: gqTpessBONWBThYXQ-_wlw-1
Received: by mail-qt1-f200.google.com with SMTP id m7-20020a05622a118700b003e4e203bc30so12570524qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680279980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvuVQhbB6sQNpw8Mymcj39/nOL4/GBRsblrkJXNADLc=;
        b=7qVDgqAdX8DwU0r80m6hhJbrvoMVv7xwtcuQ63mh3DWxNYaOyaoRd4e9y91hgmaV9E
         vaV+7vZ0G3bqoZ2FJyEqHzhYDr4sDNaWrvfkQUWfkHgq5tJXdrjxuVj6kvRi4rI1R5N1
         pvyX3mgS9n//02hfgsg5xaIKKO0leDd1nHAltM+hEQsGWBXLHRk1pYyDDefV2WNum6HF
         ahZF73JWX2C7ISzs0Hnsv61je53uYlN/7L4qdjwhnjvUUI2WrVVCLgn/s0wX6aCWSMwk
         Ps2o9IdpWN7IokegAPzDLs1Vp7K1/2CMOLRB5C4cxYD2lUMsKiGz/WUtSZQleDqqBDvw
         p8Vw==
X-Gm-Message-State: AAQBX9eNxd38654UNHVP08AoRqwlKm480h40qtBUczU7DOH7/tTqaw+I
        dZ+RMuKLU4e5gETRbj04WxlWUUWv8bBMukUY9s+Bi0Dk8twO7q0WZnMrG6CYIRLzCzzifxDd9p0
        oZ2+FCdTPn0D9y6NM7v9tdKEP5ExDQcRs
X-Received: by 2002:a05:6214:29e6:b0:5c4:2d5b:9ecb with SMTP id jv6-20020a05621429e600b005c42d5b9ecbmr45686508qvb.44.1680279980620;
        Fri, 31 Mar 2023 09:26:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD0+MFLtyL0hz01T2VfOCtBoAHzNkgeAtkgnyc80Jt1xyT6cWzJEU09c2avvC5ytNcGXvx6g==
X-Received: by 2002:a05:6214:29e6:b0:5c4:2d5b:9ecb with SMTP id jv6-20020a05621429e600b005c42d5b9ecbmr45686486qvb.44.1680279980365;
        Fri, 31 Mar 2023 09:26:20 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j2-20020a0cc342000000b005dd8b93459esm711514qvi.54.2023.03.31.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:26:20 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: message: fusion: remove unused timeleft variable
Date:   Fri, 31 Mar 2023 12:26:17 -0400
Message-Id: <20230331162617.1858394-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/message/fusion/mptsas.c:4796:17: error: variable
  'timeleft' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned long    timeleft;
                         ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/message/fusion/mptsas.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 86f16f3ea478..d458665e2fc9 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4793,7 +4793,6 @@ mptsas_issue_tm(MPT_ADAPTER *ioc, u8 type, u8 channel, u8 id, u64 lun,
 	MPT_FRAME_HDR	*mf;
 	SCSITaskMgmt_t	*pScsiTm;
 	int		 retval;
-	unsigned long	 timeleft;
 
 	*issue_reset = 0;
 	mf = mpt_get_msg_frame(mptsasDeviceResetCtx, ioc);
@@ -4829,8 +4828,6 @@ mptsas_issue_tm(MPT_ADAPTER *ioc, u8 type, u8 channel, u8 id, u64 lun,
 	mpt_put_msg_frame_hi_pri(mptsasDeviceResetCtx, ioc, mf);
 
 	/* Now wait for the command to complete */
-	timeleft = wait_for_completion_timeout(&ioc->taskmgmt_cmds.done,
-	    timeout*HZ);
 	if (!(ioc->taskmgmt_cmds.status & MPT_MGMT_STATUS_COMMAND_GOOD)) {
 		retval = -1; /* return failure */
 		dtmprintk(ioc, printk(MYIOC_s_ERR_FMT
-- 
2.27.0

