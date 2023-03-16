Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0E6BC879
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCPIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCPIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:12:17 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B4B4207;
        Thu, 16 Mar 2023 01:12:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 88FC76809E5;
        Thu, 16 Mar 2023 16:11:53 +0800 (CST)
From:   Frank Wang <frank.wang@rock-chips.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2] usb: typec: tcpm: fix multiple times discover svids error
Date:   Thu, 16 Mar 2023 16:11:49 +0800
Message-Id: <20230316081149.24519-1-frank.wang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlCSVZJQx8fTUxIGE1IH0NVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6SBw6Sz0WVhg5OTMMIglJ
        NhgaCjZVSlVKTUxDQk5PSEpPT0lJVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk5KNwY+
X-HM-Tid: 0a86e979b8762eb5kusn88fc76809e5
X-HM-MType: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
the Discover SVIDs Command Shall be executed multiple times until a
Discover SVIDs VDO is returned ending either with a SVID value of
0x0000 in the last part of the last VDO or with a VDO containing two
SVIDs with values of 0x0000.

In the current implementation, if the last VDO does not find that the
Discover SVIDs Command would be executed multiple times even if the
Responder SVIDs are less than 12, and we found some odd dockers just
meet this case. So fix it.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 66de02a56f512..a3ae2c79f3540 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
 		pmdata->svids[pmdata->nsvids++] = svid;
 		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
 	}
-	return true;
+
+	/*
+	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
+	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
+	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
+	 * SVIDs Command Shall be executed multiple times until a Discover
+	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
+	 * the last part of the last VDO or with a VDO containing two SVIDs
+	 * with values of 0x0000.
+	 *
+	 * However, some odd dockers support SVIDs less than 12 but without
+	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
+	 * request and return false here.
+	 */
+	return cnt == 7;
 abort:
 	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
 	return false;
-- 
2.17.1

