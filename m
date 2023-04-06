Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FE6DA20B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjDFT5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDFT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4A5253
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680811015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xFvooaDCxxNiVE/tqsdOIZToWIjBr1pdYolXCr6Si1c=;
        b=BkMil5zKf/KFZ3XZhup0e+Qip2fofU0zBcSX+U/NNuY6t20+yFngU0XBofSbkc2gPXTZqO
        p5xhUwniUg4oQ1AJ5QdjqJr4Ud287AlNpGrbaKkbsnzBKT0qqEZNdxuyDydTas4um1sGo9
        klBIM9EhXgsWlecs/vCk0kpytenfV7I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-QKegz2h4PWqFe3wiGJh1EA-1; Thu, 06 Apr 2023 15:56:54 -0400
X-MC-Unique: QKegz2h4PWqFe3wiGJh1EA-1
Received: by mail-qk1-f198.google.com with SMTP id d187-20020a3768c4000000b00746864b272cso18263752qkc.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFvooaDCxxNiVE/tqsdOIZToWIjBr1pdYolXCr6Si1c=;
        b=FNifVE2QsjNoH8NEcUXYofGVyrtsZmHueO9RgoCkltpWzBsSXESq4+qNozSJe84UMg
         rE9f8N5wMAao6JxsoyfRBw9WRJu+GEUbYF7onTzGzbBd/wPgeq3mSM4FBFGQ+G5k/oxs
         MAeQECDbRvyczUbK5FV1w3yuAKuzlp/pVaswNygsGIewqL7VTYO7CLpkdybJfPHmRDZZ
         4Tsj1xVI34GWhpB6piB6SlGOLxHAoN0jAwsLnToE2goR4kb7XL7/Dsg/dm/mF4hN28gn
         H6/0Oj2dRlML70QRyyDktBt/od8Yu4f673wvsa+2TmFD6HakH5qfQqZFpopkEVVd9YFM
         eDbw==
X-Gm-Message-State: AAQBX9d16NoQ5lvh9T7K7+NDCGcC4k5/J69+sLnNnyhrCPS8YlnqgKC1
        YzDzYE0TG3eipKn5DWzNJvDfLpiNtsdSuM1Ba0ICLrkDO738RvDxUC9XZWihqm1kmcqya8+VPmI
        g0HcZmBvzsSUG2Y5kj7CvFIfPC/xXkJaKljzm30r6NuAJkOWNTCzJxGZKFBphRwd+9C5XZZufPy
        DkSug=
X-Received: by 2002:a05:6214:2627:b0:5a7:a434:c307 with SMTP id gv7-20020a056214262700b005a7a434c307mr832207qvb.24.1680811013443;
        Thu, 06 Apr 2023 12:56:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yr39eU/3BQzwDa6C3lsT1xa0oUh6nRmH3aLTLxLyjD7oYT75tb6COI9XhY3d3gXEJAeSdfxQ==
X-Received: by 2002:a05:6214:2627:b0:5a7:a434:c307 with SMTP id gv7-20020a056214262700b005a7a434c307mr832176qvb.24.1680811013034;
        Thu, 06 Apr 2023 12:56:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v13-20020a0ccd8d000000b005e45f6a5bd5sm760576qvm.16.2023.04.06.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 12:56:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] samples/hw_breakpoint: set variable sample_hbp storage-class-specifier to static
Date:   Thu,  6 Apr 2023 15:56:45 -0400
Message-Id: <20230406195645.1957767-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
samples/hw_breakpoint/data_breakpoint.c:24:19: warning: symbol
  'sample_hbp' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..37c4f0ea8e53 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -21,7 +21,7 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 
-struct perf_event * __percpu *sample_hbp;
+static struct perf_event * __percpu *sample_hbp;
 
 static char ksym_name[KSYM_NAME_LEN] = "jiffies";
 module_param_string(ksym, ksym_name, KSYM_NAME_LEN, S_IRUGO);
-- 
2.27.0

