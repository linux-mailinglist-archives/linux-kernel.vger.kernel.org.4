Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF506EA0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjDUBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDUBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86759E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682038896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gqaNSPIG3egbVU/231FllxDEwXJCGtSU1G0fwdxkTnY=;
        b=bGcgwLBZcXR51qtDo8QJrDvWRGHNMmLZ5mDvYZC1fDyl12fcsPKJhHRNVUZVxsLwpFcABH
        VHKspkQnAbE7jnmfBewH4TOSwuZ3HEwH2LqojINH+seRa+5v37CIrCYh/FjFphTgdrda+j
        ++6UIJQy9DPNu9z3LUHbhYRsL8iia58=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-NzFWwzTUOUSZV0ak0fG9SA-1; Thu, 20 Apr 2023 21:01:35 -0400
X-MC-Unique: NzFWwzTUOUSZV0ak0fG9SA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ef344b76ccso8648761cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682038895; x=1684630895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqaNSPIG3egbVU/231FllxDEwXJCGtSU1G0fwdxkTnY=;
        b=Qv31YZOLXCllCbcEYjb7LsLY0jED4l2qgoo++ZnPT8DLFCprxHvHLm/vZCjO8gPXn8
         mlrBboPguNm4po9nIp9FLfaaVrlzceo2odjskZ4nYoXIxUTnnYqO/4Hru9NDzmVNusO9
         bGack2Vtiom8V0W+7qYHVvbrTFhDdn8S0Pbu0PWigSD3udkG8bmIcJrFR0d9DaBuD5Sz
         SCvJhUKGNPTg/k81st8pT5OihLXXaXzIN7rSWWiQMM+KIcdYBTv3qjJCLtgWO9VnvAWJ
         C2tj7hGMS8D8g2NDZyAuuE03RO8SX3LLcL/GJriyZ1/iUY2IbIFsLm1HrKjcn5T9OIjx
         z1+A==
X-Gm-Message-State: AAQBX9faAcrKKRwOcy2s7MrEoRowAeA4Mn87bRVC0Tqad20f863p89MF
        Y30BLNaL1XztgZY3RAtqO6ePmRK5Ny2wz1OGm1SgDSi2JLCbvfhXPEAhzM+dViYrlAedHx7v6Xk
        NY3KL4cd/3nH14kdhdHKBWQcE
X-Received: by 2002:a05:622a:1812:b0:3d9:525d:f024 with SMTP id t18-20020a05622a181200b003d9525df024mr6177114qtc.28.1682038894943;
        Thu, 20 Apr 2023 18:01:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z9MGDHoM5IgGuEW+LbaHPP9uqc55u+dxchvXXi/TlvPPj+ER2zP7d/2B7M5G7OGn6mH++c3g==
X-Received: by 2002:a05:622a:1812:b0:3d9:525d:f024 with SMTP id t18-20020a05622a181200b003d9525df024mr6177086qtc.28.1682038894641;
        Thu, 20 Apr 2023 18:01:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g17-20020ac87d11000000b003edce7e34bfsm908086qtb.81.2023.04.20.18.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 18:01:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] NFS: set varaiable nfs_netfs_debug_id storage-class-specifier to static
Date:   Thu, 20 Apr 2023 21:01:32 -0400
Message-Id: <20230421010132.3898278-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
fs/nfs/fscache.c:260:10: warning: symbol
  'nfs_netfs_debug_id' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfs/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 95c2b3056e2b..8c35d88a84b1 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -257,7 +257,7 @@ int nfs_netfs_readahead(struct readahead_control *ractl)
 	return 0;
 }
 
-atomic_t nfs_netfs_debug_id;
+static atomic_t nfs_netfs_debug_id;
 static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = get_nfs_open_context(nfs_file_open_context(file));
-- 
2.27.0

