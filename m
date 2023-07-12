Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7A7508F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGLNA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGLNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:00:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B61981;
        Wed, 12 Jul 2023 06:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJXyLGQ9gbUfF1xOwBHjwMDWoOuP3WNfEnQGeIlcEQO2XR1OW2DlzOx+oXRPTyqX8pGHAkgk9JJxnlRL5yJsdBBLLpU0Rw4e+Tzdt2Zm5fRVXuKsC3GUsoToKh7P+75Er6WFL+Oy75ipLdzYPGOptGILIJyLseB86HaQ+DbdWqZ8w5MPgJphMKW1MivTsSn5/MY4AiPGUYKxLKWORxQa7+mO3fkZMvC58+G4qLePvOWiBu/ftlF0Rf8yjptGSX7SYbe9S0cMOT//i1mg1UfKVXfSc3cQQUhHy3oBFJ9nFIKRsxUPnIGfni+M31wl9ShpUBgljhl+2GAS31Kg3FsfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MsbiiOYH7QAY/DuQbpfGMnAX2rpx/XkuX+WX2ZdLCI=;
 b=GK8x1ruzMffZs7kwe0QPLOjBdqraiMtxA/lXDPYYpXN1b0WyylFwm6gGhlx7CHZnKybaJpYi1RdLs0DDGItYMaO2p1pXQ5zczIjFroih3HhWJB3Z92nZ6QTvk2fwzepenmvzu8dMxXx1NYRZM5zTxyZhTalq261Svc+pyMr3PIfi8dFO2a6iFp4tXP7sfSxUrMF105Yw/qyM9new3U5X+cquFOuY/pF8gJiAEr+5fylUzGXngGwxD6oXt9Zwj3oKStMaxPe1z1tkhpk6B5yF6qw0Es0oZRnmiofp3DeIL4HpUeyf8QwHlc8N8WeST2kNoRKe0T1oUHwD8fpN1QZ/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MsbiiOYH7QAY/DuQbpfGMnAX2rpx/XkuX+WX2ZdLCI=;
 b=B0P6TLdkfFA6Roz3Q9inln7v0zAAFrPzTb2MDkWVvo8oICV91wtGrtcLf75SvJ2UHY1Wks2uwF0d4q/uCe1RZSwLxuw4ye6MX14+Ven388/SZS4Fy4ymVbtX/1DXnUdmbsBRc4Ek5j+1nXhmes4ADr7xVM2ug4rI2XRNB5BZEJgXTPx5eawvZGejsfg+iWAvjs+rb3pLHgIe4Zo+4no5P+7om3TumQF0YCRSUXBd5VQHy2k0uoprUlRlW4pmExH7iBBkIt6QBazoGVtxvlNWEowoarjRRw3TygB66d69HPNEAzzboe9PQSBBIOhokNIQsn3iN1HH89PbZbiIrkkMWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB5280.apcprd06.prod.outlook.com (2603:1096:101:81::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.29; Wed, 12 Jul 2023 13:00:16 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:00:16 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org (open list:MEDIATEK MT76 WIRELESS LAN
        DRIVER),
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: wireless: mt76: fix parameter check in mt76_register_debugfs_fops()
Date:   Wed, 12 Jul 2023 21:00:05 +0800
Message-Id: <20230712130005.15809-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::26) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da29cc-3b33-4db1-c8da-08db82d7f046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crLjH8PJLuEYMoQFVREH71Pmu/g+O8R5dhQNOfefWHKmJtNCs63IvrAWfwVN3fkpTjUjWPeBU+hMzAu+Vse3VDSbNosnbOSHc450/AGh6JSEn9XVbRCYNX8uClGKdjIVFGC7Qbt8uHLoAMvhgy8xrvZ2Y4YiU4WGETJyqzYPJ8cIFFauTCh6M/KwpL//itfa65LP63R5ZNOBFE7I7hu7ClhucOfP4w0n2j1mVCVurJjXSjlBQcAf8JG5s9wlbH1oPQ5DpekDppjbN4pv6nVQK7zGFeaRB7IyXgqlUIaJzNH7YuaAsllYaz3yn8XTkF4MaUUybNUrwrGTMv2D7uCv/3tHsbbr33jDPJpOkl8qK+ak4UcabgbWZ8+fJKrGuzLN+upbJ93TTA8cT3K8LqUzFdatpNCN4wOU8rSDQgIgd9Rz2WEQ8myqXfipd0e9+Co0o5mfuhTk7ikGEZ2lS4ugHnuVmZIrIAtyex74nBOpd1Hh5fbJyeHtvqZqIyBGfgRwpzEaRBn/rNyf+lWXaLGbl+hJs5LLwMoI82KCdpKos8TkUsOtBWVbt3GsiqBRQr5Fy/7bgsorfQ+kmz+Zh/gj1D1gTYlN6ri7IoRaUl0ztr4lyMQ7LNbgrROy/uNX+/QpNOF0EJx9LGqaFdRNBKJbsnNoXCOswCnQGam6hbMPxxSGTB/FhGL2leVyvEVYzXGd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(4744005)(36756003)(2616005)(2906002)(41300700001)(83380400001)(5660300002)(6506007)(26005)(1076003)(186003)(7416002)(8936002)(8676002)(107886003)(921005)(110136005)(6486002)(66476007)(66556008)(66946007)(52116002)(4326008)(6666004)(86362001)(478600001)(38100700002)(38350700002)(316002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VBPAhBJfmr0oXceD12EtL8t21jlDUYVWZfYGXrcXgGZRo5GbpzEng8uVbC4u?=
 =?us-ascii?Q?bIgE/5IoDjCqVMdyROXCUunEAAWfXyNznvU3nsffqLVuDXt5AoQYnxwISCbK?=
 =?us-ascii?Q?oyGSOCa89SrWBQPylTKFsAK72v/lzlxQmd1KgxqiVW6Ymf6AEex5yMnpMPzQ?=
 =?us-ascii?Q?5f9rlLttqZt/8BP0uDJvJx78TO5fDHH/83JqEXWTeMPW9LTZ3LvmrfoVOQj4?=
 =?us-ascii?Q?eEMD6QcmCuUH2WnF/R+WRVmSUIhPo2008Mseyo3gTZZeQ92i5ET55Yd5Y8oR?=
 =?us-ascii?Q?dngYKfh4JaAjFRNkYU50LVnSoO3t3mlJgA7SMnbhv4k5qfkObBJcN+9yMb4U?=
 =?us-ascii?Q?/En7dwRX4FTuIwY0y5yMKG6mgUj3XT7m/Grl+H56s/F1o2HTb7FdLXX8Yq5M?=
 =?us-ascii?Q?slZL2nL48jgmUGrTqgf//zSNswV79ms6hFSICJszKL1B0rxlK9IBmE3LCn7n?=
 =?us-ascii?Q?mV8ktVoGBGFxWYBFdMtAP+AY1Ba0SQbFcsl+G1kl6gxlPH4XWko5dcYcnQT4?=
 =?us-ascii?Q?5wJ+SXxI5SIxE+3xjnB/g210aDCczlipI7drjJwuumzGuJM34O4IfwbFKPwE?=
 =?us-ascii?Q?ho6BAEszXK+RiPE9TFntLFTCKL8BkttG4mz2ymu+9GwZOaYX1E8crsJSplX7?=
 =?us-ascii?Q?Mp7KzMSCfpZ9tkAT3EsuUHJwySXz0+7lv5fpDXHwbJKqjhuCxkqCUaJg2T8i?=
 =?us-ascii?Q?rtiWM7hZyic9nIWftAgAUW6ghmjvRim5Jlh4H/AB0vkc/GJOTQsJJpP2kPjA?=
 =?us-ascii?Q?zv7m0TIa6ec4OaUH1eU5OQlzCMoT78WwKHDBfBH5MuQOwqkR1BuHOYZHeVOm?=
 =?us-ascii?Q?zQloz7bKUYTIKsZVBuTvkzersp8x3foKDhGB2mqVfcJJsSzhRb94G4PHumyh?=
 =?us-ascii?Q?M8D6ukV6Yk3gnTzh4hyjBcKF5JKV7pqgDmeK5lwGGzz9+bRqubpYFbh5JAKp?=
 =?us-ascii?Q?tUiuecAuqXKPtQCCuxYGPMc4srfiQW2xYxr2u9ytnl3jJbxMkFskuQPlDtk5?=
 =?us-ascii?Q?TKaPTNt7i0eHLzDTVQLZ8T9cBputnLmb9hTnfmmeRMWONl3xeDIEugl2Hq+l?=
 =?us-ascii?Q?VfuuWp78NtZO+rurrronTVI2HE/dXBUlciFMNnpa6DnIykyuSOjEU6wC5Fw+?=
 =?us-ascii?Q?eJoz1XVdGRIBzZCHWmsYkdrmEJChBlU3Sav3QQbuyJROt9hGokHFsSuja62E?=
 =?us-ascii?Q?DLBG1kwr8ILGxO3dfcx9YicdoF1QQFUgW93eEa9h1wFfgDyMkk+kAQDQK8an?=
 =?us-ascii?Q?d31IoRDaoFQwg3DrfXtdZCESpEjgG0r10M3U5r3/GLkQ+Kn30S/hQnmdhqc1?=
 =?us-ascii?Q?IQUqaGB315WDtppOliqv7eU5ki1fL+AlfPmlJN8olUrY22m7gJq55LIWqD/T?=
 =?us-ascii?Q?4AJyN2vsCPnNdmiCYzkrz+ZmK7KaVo/AFJ6ntwyVASNMbTW9ddPAC2y3jah3?=
 =?us-ascii?Q?eKzjVtxV0XuM4V8Jcvna+4AGzwaeYBtp6Q9zZoSGzXUzmmdcrmedyt9QvR3q?=
 =?us-ascii?Q?2wnmP5m6SbIQ023qnLe8lhRPUKq+rMCh5kuHscqqsEGA/Sey3iJ1u2YLuRb+?=
 =?us-ascii?Q?imvli1aXa6plH4HoqIVx7PE6YPcC279hLK09jyG4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da29cc-3b33-4db1-c8da-08db82d7f046
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:00:16.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgogDx697GKtcCVRYh7RBK5AxUosryOxxpCf1wjZAhl9dQY7TMeZjV8R/OCAoO/Ac/p2CbyKL/hUsznPaaikow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in mt76_register_debugfs_fops().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 57fbcc83e..d9ba70013 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -109,7 +109,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
-	if (!dir)
+	if (IS_ERR(dir))
 		return NULL;
 
 	debugfs_create_u8("led_pin", 0600, dir, &phy->leds.pin);
-- 
2.39.0

