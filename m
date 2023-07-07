Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125D774AC02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGGHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGHgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:36:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017651FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:36:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qy4w46pjhzBRpqh
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:36:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688715394; x=1691307395; bh=+GJqPJbp3LFwLc7m2bzftPN2OQL
        OJD/1/I/T+zJyo00=; b=FQionAeSBgHS8nuowajNZMDBoCSJe00qILTYfpNmB9T
        W5dzvC1OK4K7fI655po99bObdTEwnYM7tHCgK+idCYNwOpFckX9QYXtCO6lEgKGx
        SOs5GqW6tGsKkTR4lrE3qpqHTW8gH3jbPbtOeQEpWzVKyAUhGQGMaNhbb/BhxtTl
        LKSHfXhM/XvRDnn/t4SzIIy+FmbFHbyNXxi0K/BkHlBBwcmrRxYY9VdlWBrBO9eA
        9Ii6Hth9VRXH7XbFUbSIWLZ1IjzU6aJvwX2OPkQWuaJg7vzdKlyunDuvawsVH/u3
        Nis0hyI8XwBJGNFNw62nz6AlyO7XyY2V4CCwap5wRUw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pYV00fVjFCPC for <linux-kernel@vger.kernel.org>;
        Fri,  7 Jul 2023 15:36:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qy4w2351bzBJ8lL;
        Fri,  7 Jul 2023 15:36:34 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 07 Jul 2023 15:36:34 +0800
From:   sunran001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] csi: myrs: Convert snprintf to scnprintf
In-Reply-To: <20230707073016.11786-1-xujianghui@cdjrlc.com>
References: <20230707073016.11786-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <20fbbc099e132bb4d3c367da18051c7c@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports: WARNING: use scnprintf or sprintf

Adding to that, there has also been some slow migration from snprintf to
scnprintf. This article explains the rationale for this change:
https: //lwn.net/Articles/69419/

Signed-off-by: RAN SUN <sunran001@208suo.com>
---
  drivers/scsi/myrs.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..852aceb81f28 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1408,7 +1408,8 @@ static ssize_t cache_size_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+    return scnprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+
  }
  static DEVICE_ATTR_RO(cache_size);
