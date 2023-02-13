Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6D695077
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBMTQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBMTQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CF20067
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676315718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uhQrqnCkN4d3EAtVP7068dcMTmtPV8cpYn4riXUGRrk=;
        b=Gybqfe3Ki77KOqK4GYR/DqkGwlkTALWHORQuz2tarJd1qio9bWvqKyt6tEqQruv/jdeUje
        LQCs0ObBhXCc2K+eRGrMdXjRnrGe6XALIvClRlhPKTFOdyyFS1l6V/QlUQ8y9UUAemaM9M
        LD8SkToRRWyx4SCQIIgk4pcHE8lgfn4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-0hLX_oN8OmayjHKAjpRNHQ-1; Mon, 13 Feb 2023 14:15:17 -0500
X-MC-Unique: 0hLX_oN8OmayjHKAjpRNHQ-1
Received: by mail-qv1-f69.google.com with SMTP id dz7-20020ad45887000000b0056e9274a7e1so5288774qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhQrqnCkN4d3EAtVP7068dcMTmtPV8cpYn4riXUGRrk=;
        b=j8e90ToCr0X4/5oEEBSnOiPFp0oxSjwY4g5dJta5tai1pja+RNCIvf4MHJHkDM3aJc
         ktfr2lNawcCi1b/o2bxZi9HdOQbHqFE97hDIQIvH+u9OGizeI2lCJKziWw5ngFw/861/
         cJUcD1q4u2JDB7pGRniAQLGzxEKKA2v49ZWp3EiA/pg8O49sZdf5I5e7F6gRPqE+KCub
         U2CCpXOqJJS/5S/DrWvQIm+QmVPXK4JXrqgk5DNiRx64OZIevREpAxrcp3CHe3xn4Wrn
         O6jrOUaVOwMmoA2PS9nWPxJvTgNIYC4kfkiB3N3nuLZBt5h6u9owjNx3BttJybowajpc
         qjpg==
X-Gm-Message-State: AO0yUKWD+xoJzAcHOhraIQosSoPZUFA1CHAGC1XvpzjK5OP0R0WcOujX
        p6CY5BIzWSbdabcRiPg6nqPsv5bfOioMj6WVis2Q4KmDnZNJPteJczgf7mY1iG47fppxa2k0/XM
        T61szt9UB+VRvi359V/Pu+P4Q
X-Received: by 2002:a05:622a:1052:b0:3b6:313a:e27a with SMTP id f18-20020a05622a105200b003b6313ae27amr47315514qte.40.1676315716713;
        Mon, 13 Feb 2023 11:15:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/KmINhbbACstO8ce6LNNQliPHLREUZooeeCezZ8zbOQ7+H4IMEPVrjOT/6IhGN4zaXKyioQA==
X-Received: by 2002:a05:622a:1052:b0:3b6:313a:e27a with SMTP id f18-20020a05622a105200b003b6313ae27amr47315471qte.40.1676315716450;
        Mon, 13 Feb 2023 11:15:16 -0800 (PST)
Received: from borg.redhat.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm10248485qka.93.2023.02.13.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:15:16 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC/amd64: remove unneeded call to reserve_mc_sibling_devs()
Date:   Mon, 13 Feb 2023 11:15:10 -0800
Message-Id: <20230213191510.2237360-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp_check reports
drivers/edac/amd64_edac.c:3943:37: error: Uninitialized variable: pci_id1 [uninitvar]
 ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                    ^
drivers/edac/amd64_edac.c:3943:46: error: Uninitialized variable: pci_id2 [uninitvar]
 ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                             ^
The call to reserve_mc_sibling_devs() will not fail because
  if (pvt->umc)
    return 0;

reserve_mc_sibling_devs() is only called by hw_info_get() and pvt->umc is only set
in hw_info_get(), so with fam >= 0x17, the call to reserver_mc_siblings will
just return, so the call the call is not needed.  And when that call is moved
the check for umc is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/amd64_edac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..f6d50561c106 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3179,9 +3179,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 static int
 reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 {
-	if (pvt->umc)
-		return 0;
-
 	/* Reserve the ADDRESS MAP Device */
 	pvt->F1 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
 	if (!pvt->F1) {
@@ -3938,11 +3935,11 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
-	}
 
-	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (ret)
-		return ret;
+		ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
+		if (ret)
+			return ret;
+	}
 
 	read_mc_regs(pvt);
 
-- 
2.26.3

