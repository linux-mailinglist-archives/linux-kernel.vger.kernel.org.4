Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551669DDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjBUKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjBUKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:31:16 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2045.outbound.protection.outlook.com [40.92.53.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B623C51;
        Tue, 21 Feb 2023 02:31:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv+rYeXxquPbuSUdZC+CWsUfjCtkQG74LC8+buaARih0iLJP4cna3E0KRB5UMl1zcm7/y52HoDhYT0AkDb9wXdLQjrEt5IHsyfCCTgYqTtDvaMCDxok0ZU/fZhYQyTzGC7t3gy2/J/fHHpmKJKTRf95a7YfuJCxg7X0Z3kX56Ogym43eASiGtFrhWU7lZjhYkCo2TiL2X5EhlASB/32DNu4jjOel2vqMX0r5QIMQtZZAeWSSsUo6l72Nvu+2QW6COlgCWZjrS2BW2HQ43LIR9TehdzgxF9H6Q6sJVjjPKUEsOKqrZFfW5EQkIFgUIFlBZ4N0VxQmu9DDsWk1WPpFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkdkZkJkLYmAH2Al6/ONrJI6OZhfs1DSlJaGL0hUUQE=;
 b=KsaaJQDqHiQbgMC/f9DZwox017EOr54BdRhrOsNYijvhMfyZ58KUgBb9DhTsv+W+bru8nX65fdz16Y2JqB8/8FgltJJ44yU+JnV/4+mzaNN9iQHsJHv6enCNkZCTy6LeSN+sryZu2+dwUVkMUAxocbOkigK5gPhnlOJZDdq7ODmiCVT8iRmc2o+wwAUTU6h4WTAzdxkVw9ZGOFs8xiamYr6v0UkZzWRKwEpJK2BLjcdRPDnfGf3zq7tHioA73N2kqUu5NnnOqDZkQ29nK3xnBlkCHqW3KAyE0mMJE4a4t6Um1hGgY+v79XAfPePBaJ5XxpxNdGq/L+anNt1vvjSkBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkdkZkJkLYmAH2Al6/ONrJI6OZhfs1DSlJaGL0hUUQE=;
 b=gt4d1QZfyUX1UayhExiyWOHP2hB/nRAGdpEjqL8TyT4IVX5xtgLGGNyeeJVrFjCu+kSI8HblW0s27hb/nhxVdaqjRcraCDqYz9DRxsldmxraOFCzUN0BCLR4wNrZMs18gg4WK/5tClKbegafSo18LfgFVR6a5aGgGWC2DUvwgnx7h52QWt4gOhof0xvaW+RQDODqhWgqiZLkNvAv795eRhua8cwsBYudXC4c1JKeSPyw6h0NeEZhfYByGhRcxE1XmZD2P33a8VBzlCnibGk0/hnt2C7T0r8dqYGhHTcUteHQ3c5k7IyME4WywFyQAEMGgjt68jcJ1chpyJMnW3/x2A==
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12) by SEYPR01MB4832.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 10:31:10 +0000
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa]) by SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa%6]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 10:31:10 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, fabrice.gasnier@foss.st.com,
        amelie.delaunay@foss.st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if role-switch-default-mode="host"
Date:   Tue, 21 Feb 2023 18:30:04 +0800
Message-ID: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ECLCJHFvFC3wQkHMwRGEW81V05WJbD9NGMCqNsrDx88sJsx+aXfFIw==]
X-ClientProxiedBy: TYCPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:2::16) To SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12)
X-Microsoft-Original-Message-ID: <20230221103004.1692090-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB2048:EE_|SEYPR01MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5ad32a-63d0-4211-45a5-08db13f6bf68
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGlsF3Bc/vl9LcCcx4OW7BQWLCOLqIEtcbYlcgVRy2SlejKJ7qzhpypzec3Ws5q5hpt66La+jjInXvD7GZCH23rAkrYzhP/0Nu1MxvNWXeNpXhPNXptU+zrpgsKv4JX/eDmUn+xBzbNG5Y5mOBp9bpHdEJniPjnkla/ruCr6mfnB5t0ZUNv2MDQyOS9gw4hz8oKzAL4DrhZ4fLrvfsHdWMeWD1NkY3Fq+bHkQJHEqQ0s7Qe/crZJufdaIbDlLu5UKp/Nx95N3vPwh1Rr9Aa9m+q3yFKcqDJE2Pb67Ff39WDmPCUZnSF06pvU72Nlp2gmggjR1Hc5NGYVv9xh6mEBioXMoZzKrlWpuB5JCADHWPyqdPyYBn12BrqdyQsDw927xlDpSlh5LlKYysxCk1kxIF1ZHiVkTB4BH8OoVvhPwho/gB2f1u4G7+5ubtVvrueQDTMwV6nv19s3N+DBU1eptwH3YubFP0nUPKKbR6Nhec1KrIJJETfBAssddrfk3nnnXdnhYajlp9Er7XJca9uaTSsot7Tj9DJKKgZ+LJYgooqUoDdBePSWvg4r2dYGopWDdeHcYGD9t6zHT3IwYhHwj7+sgUBjuC7s7POmJz3hUdJTsrsPiDUa2PNfT3LB5N3+O/aj6u34Hk5EOheTd4PTSEk6kDBO6DCqOVug+epA7JmLRGaS+wI+HhHb8zk5izo7Lf44Mf4H8SMjcoxSap1ORIHEr8PN9q+MOMJhe4unmrwwv4vcGaGh8gz0h
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGD32vwjOZLxMViaBChdYvL/E4TSBsrYEMc3azR1/yKIr19QEpMz6ruhwCNIa6mkFCZ1HdYztdmwshg/MLxWHhnF3AO07bxTj/yTxbgA012vgwA2Fe76Vdb4v17DUN8bzZS9gTb3xzwk+m9czWa9CZlAPsN2vnjSVLPhDBKFI/ArHDx542VcY3SG9kO46CgGIruCQXEcR/gpgweyiKZF6GuX8kewint5zvi5XNPRiaBiIGYJr1besEXq6b2xSl1zvvPVQ1VYMx/TpOuUwUIeSstOUcL25oD4rmOAu6cUMrwD5mUmKiWpxpVBL3zCR7vFphFghNr2etZiGVqtyYsiYynviECCtY/o8CIN4d/bbx+kn8ELcukXXAMGAlTjUv/ih6i6DeS5aiXEBEx1arewPMgHExwrv1oFIf97mWezd65Zj5IqyJ4tM4GEjl/isT8S0a+53LMevy80LWRe+58EPxXeEDID2K2qKQ/ANPbUbmtwDltnZhuVbohJuzC0YRVW3eOPZyt4Pa6goO/kxpV/Bh9O3qAFcFGYbo7jbB2dGEFyyUf+SDyzjIbJNcSTmdTmntH1+sdDC0QgQlipXMg5vm7N23anbVCclRyjzclElOH7P/F+S8gVk7RZdNtLujfQnxiNQxXHCN4YWJhSQSRTuw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wrG5K4X67RdxxC9O8oYS2M8QxycNV1xdlDto1tF5k7RcG7OWu9aqqPDANoc1?=
 =?us-ascii?Q?DS7zcnIGjKBgl48TuVHcwu+Jvjhm8nAwfdUOH96IEbyMSufqRHBaFVl4EMuV?=
 =?us-ascii?Q?IKC7RkXmSr7CIMFfA5fGuVThpjmREup1Sr4Q53ryPlbB+udQDOUHRJu/sJu5?=
 =?us-ascii?Q?A1dFDYVsQYUoOvcHAiGn4P8cLp//u5ETYr0kqTkdeKn+TG1I2hyOJSmFJXMn?=
 =?us-ascii?Q?pxcYUBnM2FbfPEYdYJUCXVsXQ1nlG0U952u5KvyUBzJbWR7F2HGr5+lF6cQi?=
 =?us-ascii?Q?Wvy4+E7aK7qmKEszgjb7JK65RJvmVYpj29WOUt4Loi42rUurffOuto4YVs2u?=
 =?us-ascii?Q?Ploghd11aKedB1M0GJyQ4onlx1JVvmKFUfaE+X5CsrCdnkzIaHcsIMNRfH8f?=
 =?us-ascii?Q?IpxgC8t4okpClMEkpOtIUjDjJGSc3eIu/sZYdUBFyPOlkGGQpoMiVJ7nz34+?=
 =?us-ascii?Q?P095fI/ZR+tyN9/H/PlGrol1pqyD6u4tzW+VqCj2eOaWhe0Jb1d2amFBpcnv?=
 =?us-ascii?Q?iq+Exsr7r3z6DbJQyVhXQ2nKp/aYNXJ2gOLbCUhosNizQKA626ckq0ztyyBL?=
 =?us-ascii?Q?usV4eY08rq0hoYibQ33ika2wh37MHreUW8PkWN5BnB83AGr7fL9JAYSRcCX6?=
 =?us-ascii?Q?LPEIBc82WrQ2AWRX8FyphLxj7wjjM08jIQue+tCZIOz3JLWqWTy1qcqzOPYE?=
 =?us-ascii?Q?dizacJle7V1bNHjZB/ItjrKTAtU4oDy8q81NE81MnxtZjtMprIPK5ZSP7fYt?=
 =?us-ascii?Q?oGXDkWeeaDTBu9MPk+RXBSoweyW0qPLJEtHFKB/+56/yl+xWzRE8W6QyxOjq?=
 =?us-ascii?Q?Rk6c8vFKQkYly4jgLBpdaUtOrKgMmolEgLoEH9A6Sj4Bt9+xAfuYCv116pCi?=
 =?us-ascii?Q?PfnpjpVHnV3sH9L5p+vlbEQ3B0ut5k5TV7Fnkg7BahaP6B15R69HclKB3AYF?=
 =?us-ascii?Q?3Ehx9HHqKkKlGNCgJzhv96rCBjFKsUdDt9Kw1a8zBbhc0xbrzTu63MO1q7z+?=
 =?us-ascii?Q?m9s7KV4yiEaaVIhOur5URwyHe8TcNxt0gkjbjIbO4GMHQ55FqkTIb/Jf6adb?=
 =?us-ascii?Q?VaCZD2bMtOn4ZfAvcCiieVYfiW/hteWcLb50B/i8d4Ug0CdSwJxYDWsq/JoB?=
 =?us-ascii?Q?wQtzaFNh/NwWKDTgMIcP8SPTATW8dn1Rs8Aa/dUlUC9jJ2RHs6KM5OyZQPEF?=
 =?us-ascii?Q?AI6/c1gLjKGVNTmInFv2Dll/VH2TW6/PmKzLNs+MgDNjxY0ICzLELjkTIrSK?=
 =?us-ascii?Q?MV48U9AdWRkyYS4Hy4+eG64WJUnh0OYHvQQ8StPBRg5FaojwS5bATuYScQxC?=
 =?us-ascii?Q?tbw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5ad32a-63d0-4211-45a5-08db13f6bf68
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2048.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 10:31:10.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards might use USB-A female connector for USB ports, however,
the port could be connected to a dual-mode USB controller, making it
also behaves as a peripheral device if male-to-male cable is connected.

In this case, the dts looks like this:

	&usb0 {
		status = "okay";
		dr_mode = "otg";
		usb-role-switch;
		role-switch-default-mode = "host";
	};

After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
dwc2_force_mode() with parameter host=false, which causes inconsistent
mode - The hardware is in peripheral mode while the kernel status is
in host mode.

What we can do now is to call dwc2_drd_role_sw_set() to switch to
device mode, and everything should work just fine now, even switching
back to none(default) mode afterwards.

Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
Changes since v1
- Use corrent name in Signed-off-by

 drivers/usb/dwc2/drd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index d8d6493bc457..a8605b02115b 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -35,7 +35,8 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST));
+	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST) ||
+				(hsotg->role_sw_default_mode == USB_DR_MODE_HOST));
 }
 
 static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
-- 
2.34.1

