Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0126D5B30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjDDIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjDDIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF2197
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680598035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=St04fATWGfIT10g6i4L0siP3WzQxgjh0uTI5uZltYvQ=;
        b=cU7zg75eMs763VHrY2sozQOKDBK8tDlpeUZ2X3nNmjv56Q4d9dv/ip83iUNDAVJgBzsVKY
        9x3THEtFPGyc733s92DrSgIC3BwPeB4ioCtlci1JK3DGIqD0PRGsQIMT02vXQ67/IkawSh
        AXE7k9yWKUe51qztDlKVGMaj2kKYpbc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-uyj8PsRUP9eMbqVDov0oSg-1; Tue, 04 Apr 2023 04:47:14 -0400
X-MC-Unique: uyj8PsRUP9eMbqVDov0oSg-1
Received: by mail-pf1-f199.google.com with SMTP id o4-20020a056a00214400b00627ddde00f4so14451551pfk.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680598033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St04fATWGfIT10g6i4L0siP3WzQxgjh0uTI5uZltYvQ=;
        b=zKHoUaL/K3/GT1E19HvyQqYfrQWdML4kKi+7YuJxagHhOGRZ1fziwqoTIRE6EoqKhj
         H/svpS1KqN5rt4x+3ykEXH3dHLTqlZNfsps6xB92/pR2dDq7iqVyXlU605ca3TGQBQl/
         LggfmP9vKo7eoGk+7vxW5KQ4qcnuPc3tzWvoAmPIoNe4H8cmy4x6SxpWHWMh3g3QhxWJ
         l9qwX4gVdzeUckAMTmb0D7vinHzRTHxaaqWOPmE/FPNiPXRSGB8v6cOAVk+R7TMTpkS1
         hT3ub53aFcjxIFh1sjkwtQpajmD34+mGEBlNC+10JKZLZIW6l9ancI0KuL13sIXd+MSk
         IMyQ==
X-Gm-Message-State: AAQBX9eSac8DDQW7BH+zjS2my5EXDg2cRUbptKDCNsin3OpSV0VCoL1O
        mqwUdZYv7j4Kk/8AievJlQyzrg3aUg6yG5DpKh+T1YkgcSexK26m2faGQ3aGD9EjIwmq2lGCsiU
        /8xafJX8qrudHd9v/6CMaSM1j
X-Received: by 2002:a17:90b:3b48:b0:23d:29c7:916f with SMTP id ot8-20020a17090b3b4800b0023d29c7916fmr1944931pjb.32.1680598033474;
        Tue, 04 Apr 2023 01:47:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJxkPLNVMHl66unDdw9/W27jgaZhktSUj9RGv0cbVeSHmAFsbM+C5lpa1lJz5XglkZhaNqRg==
X-Received: by 2002:a17:90b:3b48:b0:23d:29c7:916f with SMTP id ot8-20020a17090b3b4800b0023d29c7916fmr1944909pjb.32.1680598033010;
        Tue, 04 Apr 2023 01:47:13 -0700 (PDT)
Received: from zeus.flets-east.jp ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090ada0500b00234e6d2de3dsm7352937pjv.11.2023.04.04.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:47:12 -0700 (PDT)
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
To:     djwong@kernel.org
Cc:     Ryosuke Yasuoka <ryasuoka@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: Use for_each_perag() to iterate all available AGs
Date:   Tue,  4 Apr 2023 17:47:01 +0900
Message-Id: <20230404084701.2791683-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.39.2
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

for_each_perag_wrap() doesn't expect 0 as 2nd arg.
To iterate all the available AGs, just use for_each_perag() instead.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 fs/xfs/xfs_filestream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index 22c13933c8f8..48f43c340c58 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -151,7 +151,7 @@ xfs_filestream_pick_ag(
 		 * grab.
 		 */
 		if (!max_pag) {
-			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
+			for_each_perag(args->mp, start_agno, args->pag)
 				break;
 			atomic_inc(&args->pag->pagf_fstrms);
 			*longest = 0;
-- 
2.39.2

