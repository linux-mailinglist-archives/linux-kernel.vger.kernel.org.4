Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7470FDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjEXSZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbjEXSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:25:07 -0400
X-Greylist: delayed 1712 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 11:25:02 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578613E;
        Wed, 24 May 2023 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Message-Id:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Subject:Date:From:References:In-Reply-To:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=SPrqV6ntExTuKWUGea554T7MrMdxYL653Yvti6t/SiQ=; b=QxbJe9w+BZfDdaA+dQgy0917EL
        /AGNlLaD6S2fxjGnGhkr9zUNSsXN67n/7C1/hCqU7sQwp31g1SSiBKuRluPdKJdT5kVWn0TCBq/Nf
        coK8ehnJxJgzCvV0lSlzRBLsWcdRERV9AZiJAXE1F+EdmjsOg4BkjMEBtl59SdPZYKBslHubkmx4H
        FlVhfuAhpsYhGdeF4XAkcSYaz+KxChhAcyJJN7YtpfKbgPwM6yRE+nu0Y8412hCotoJqi3/QR6I1l
        +yqQEX13g05r68Ga3dmwVH8phbTvG2ikw+W3oYqlAaPik1WnlgJXKWIcOTZwAZjlv/aqlCbdsnbpr
        dHpziR2Q==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q1sio-002A2x-Ty; Wed, 24 May 2023 19:56:26 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 24 May 2023 19:56:21 +0200
Subject: [PATCH] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
X-B4-Tracking: v=1; b=H4sIAMVPbmQC/x2N0QqDMAwAf0XybCCrOsRfGT6kXZyBUkuLsk389
 4U93sFxJ1QpKhWm5oQih1bdksGtbSCsnF6C+jQGR66jwfW45YyRvx/cecE7MVHvu3GQAJZ4roK
 +cAqrRWmP0WQusuj7/3jM1/UDqZFnUnMAAAA=
To:     Viresh Kumar <vireshk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Fix this by removing the opp_table from the list before freeing it.

Cc: stable@vger.kernel.org
Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
This fixes the crash I ran into after adding an OPP table with
both "required-opps" and interconnect paths (opp-peak-kBps).

By the way, the "lazy_opp_tables" does not seem to be protected by any
locks(?) so I could imagine that theoretically there could be a race
condition while adding/removing OPP tables there. This is unrelated
to the crash I saw, though.
---
 drivers/opp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 85cbc8de407c..6a3a320be7df 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1358,6 +1358,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	return opp_table;
 
 remove_opp_dev:
+	list_del(&opp_table->lazy);
 	_remove_opp_dev(opp_dev, opp_table);
 err:
 	kfree(opp_table);

---
base-commit: 9e28f7a74581204807f20ae46568939038e327aa
change-id: 20230524-opp-lazy-uaf-60a004b385ec

Best regards,
-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

