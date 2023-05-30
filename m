Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7A716827
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjE3Pz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjE3Py4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:54:56 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F64C5;
        Tue, 30 May 2023 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Message-Id:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Subject:Date:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=jb0TWNMdj00Yo7l1c5KV/Xu5496JxdVZgvDLfmprk18=; b=oDIO6Ui9TmTc1K+WBD770C45IN
        fL9bAvFFVSpuZ6INoZVmvn4v1+zfvjUGyOuM+R4blZPATfbhi7VER3VJ0chV2WLiHLulJmUEakwwL
        0GzE+AEQADt+HDS7/giYRi0MJO+fcyyFZGnKCyHu9c3vqHvScF2WxxjJWlJ9MLUioO5Ag4xfH2Gm5
        +UKHUcv+cdUZKSWTeYGD7pl5ThL9ya4RcCQZwg1B2ji0ZsWXmki81VItTFxErIpV87QD8QJZqJCS5
        b7IeeqsJwzyZWaVtOEaIg1yD2PIeImA3k1pKmJaNebWmRt154g3SAnMh50w0WzB4IRvLf6frMRMCV
        lhwkUGDQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q41gP-003j9c-UX; Tue, 30 May 2023 17:54:49 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 30 May 2023 17:54:46 +0200
Subject: [PATCH v2] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-opp-lazy-uaf-v2-1-c26304544a47@kernkonzept.com>
X-B4-Tracking: v=1; b=H4sIAEUcdmQC/3WNwQ6CMBAFf8Xs2TWlUKKe/A/DoS1bacC2aYEIh
 H+3cvc4k7w3GySKlhLcTxtEmm2y3mXg5xPoTroXoW0zA2e8ZIJX6EPAQa4LTtJgzSRjlSqvgjT
 kiZKJUEXpdJdHbhqGLEMkYz9H49lk7mwafVyO5Fz87J/3ucACjTA3oVWl6pYePUXXe7dSGC/av
 6HZ9/0LG9gCXMMAAAA=
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dev_pm_opp_of_find_icc_paths() in _allocate_opp_table() returns
-EPROBE_DEFER, the opp_table is freed again, to wait until all the
interconnect paths are available.

However, if the OPP table is using required-opps then it may already
have been added to the global lazy_opp_tables list. The error path
does not remove the opp_table from the list again.

This can cause crashes later when the provider of the required-opps
is added, since we will iterate over OPP tables that have already been
freed. E.g.:

  Unable to handle kernel NULL pointer dereference when read
  CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-rc3
  PC is at _of_add_opp_table_v2 (include/linux/of.h:949
  drivers/opp/of.c:98 drivers/opp/of.c:344 drivers/opp/of.c:404
  drivers/opp/of.c:1032) -> lazy_link_required_opp_table()

Fix this by calling _of_clear_opp_table() to remove the opp_table from
the list and clear other allocated resources. While at it, also add the
missing mutex_destroy() calls in the error path.

Cc: stable@vger.kernel.org
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v2:
- Call _of_clear_opp_table() as suggested by Viresh
- Also add missing mutex_destroy() calls in the error path
- Link to v1: https://lore.kernel.org/r/20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com
---
This fixes the crash I ran into after adding an OPP table with
both "required-opps" and interconnect paths (opp-peak-kBps).
---
 drivers/opp/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 85cbc8de407c..7046487dc6f4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1358,7 +1358,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	return opp_table;
 
 remove_opp_dev:
+	_of_clear_opp_table(opp_table);
 	_remove_opp_dev(opp_dev, opp_table);
+	mutex_destroy(&opp_table->genpd_virt_dev_lock);
+	mutex_destroy(&opp_table->lock);
 err:
 	kfree(opp_table);
 	return ERR_PTR(ret);

---
base-commit: 9e28f7a74581204807f20ae46568939038e327aa
change-id: 20230524-opp-lazy-uaf-60a004b385ec

Best regards,
-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

