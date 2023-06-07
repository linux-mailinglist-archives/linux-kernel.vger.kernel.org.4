Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92172673B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjFGRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFGRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:25:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2109.outbound.protection.outlook.com [40.92.53.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152C1FFC;
        Wed,  7 Jun 2023 10:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSjdaadQECMUkXwEnX+CSAEwtkZEtrAT0Yyd0vGOnZNtm+6vmVsTnSLKtcdSZogGZ2B2SNdW3L8ZeWpLc9+cVwx8QVX6y2LlSrsUfmPMrKYTUH5gBnEM50qbLUWMiuqVfXgeifvySPSi0slVGTjrB+9p/FuAhEHVfMFO/0+OWkP+5/59gk6op5w7bmBmNswugFezV+c3U+vUixKsgkgTFSu723zLLTxMT/YT5kYebx47ds1rpYcBRMkd8L2JVwZFnpLADxopBbHnnbczGsnF8LwDqwFNYYZN8vEztpRn/dpalvqwsrHx5dUFGRGfOjlMXLeL2nZQprooreSOjZ6tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjsFZDOeFbXmZ/FHpET+aoUUHIz8zXWVptnl36q3kdk=;
 b=X7fWRoQY0xWozCBq/MEp6fRpIYpTa4BuOlE+bo4i9WI9+coacL2xGxFXx9L8YKyTNgtz7Xjl6TyNAE05hvgsKXE8tsPq969etvN16nS+vPIBJQivKWgY/RkVd4cZjGQGF2ko20sw7UkSpD5UzS29Sk5hZBQcmqUP1WgZ7HgQWwZ59C18pitWlpLieFDkJIQRtYvVdOr/TnQqFRQkoSMNf/ZSvnUsZIe0Ci/RTajNWRWiZ3uWbA321tqKYvTpBsxkYnK2ltZ2wV9wzIsDKLXVttLIRxSz+QW5YNNNM/6Pam7SPslbDUD1Ffeum9vvdKf0rCpxY7xQI/YZIKUIPOqAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjsFZDOeFbXmZ/FHpET+aoUUHIz8zXWVptnl36q3kdk=;
 b=l9VYAJOhwGcaajqpRItul5um3z+0AMeSGRvvIK9yAvOyK2cuGmRG3QxETWs5dcridgpjz59du938ZOXpOqu3qEJplsmSqR0xAKqd5crYbcoX8aktQU0tKAiNPo+q3F9jUqj3+lPVhckhs30ZFNyvIO5UjtBkH5wgNmt2FJxLocUw4IqxobkB89axIuyxCNRwT0E+wLBQnBmE5a/cWLb1+3EpaxpD9CgOJlNN1mtn2jbCT5p0uSxX8yQORH3t7aiaG0R29FXt9sgpiI5lQEXWU5D3d7lz/d+FajBfbJNFji8IiWBiciZvk4m6pA0UhtB1u7SJXjaqLQW9sZ80f07zkQ==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4396.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:25:10 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204%7]) with mapi id 15.20.6411.021; Wed, 7 Jun 2023
 17:25:10 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     kvalo@kernel.org
Cc:     quic_srirrama@quicinc.com, quic_kathirve@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 3/3] wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018
Date:   Wed,  7 Jun 2023 17:24:39 +0000
Message-ID: <TYZPR01MB5556D6E3F63EAB5129D11420C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607172439.2258343-1-hzyitc@outlook.com>
References: <TYZPR01MB5556F7C9F8E5BB5F5E1C8770C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <20230607172439.2258343-1-hzyitc@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [S1vJLvpyVh2ZDXzIU2XfyMIll0s/yY3wNMkNpYrMtzE=]
X-ClientProxiedBy: PH7PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:510:174::10) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230607172439.2258343-3-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b03e03-fec9-4ce7-512a-08db677c2533
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmoiyiq1W/GNGVw8decNWbLwvhgVJWAqOg6Loi2mrNdp7493WXjId/ZjOljL6/3gWVHZksCFo6DEsqFO9bOSq6MfuHlb0dZXM0jvaunchaTH7DQ1+QxZA74zEzHfYRY+at9KtI9aySzVpTUgGuOC/jQFlx1KlUFbjbUit3wQcjTpZ8aFDzhlFHWARhvNpThBRsBYAlcJ8EiLmGExWcOynCkEiGdIt+3DgGvQnUlrzqrnE0Upr90gR4bM5XMjN1RbQCNKq1vOTVGKBSMoNQebrDjVlP4PEndfdaYtW4Iw6XZEFOqcGJ/8wHRkOquhrELlDRTVBinD9vIJjGmpK9N9ywBS9Oiwo9CRhiR64aJcSx25W02l+eComIl9fyZkADb3gORCdxY3HkJoK7edazNF8WlLcU5yPqBUzRcsAY1djo4oBPLEm6o0wd/pDQg/c0tNHgRPTTaLSz2tyKtqOMenSqIzgiO0tQjzhIsLMM0UPe4zSo1EDyNLvIGXxbqQz7l5j6lecwqWU+x12IDdsicO2XyOE+mkyaW11M+oR3vwoMrQIxCjhNaw5e1FJl/eH95xwwpfgoa0Hb10u983eoLrI36ACtf5EjVqCVNy43e9i/MYJTh/v89Tb0GkDC1tR3IEdByt8f68jAK5sJVCAQXvoJmUiEEkmguwy02sCZ7hwL6Z+pIYFTlINVenjKZK3+2kNQxpfeHE0vvqji0CQp0Rc1RtwGnMCdXQF2ksK4ZTQYMwjwC7n8hUHm0oyfgwvbmKMiE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0pUCniQrpWtjCV4WSggYStx4Re7lDaXWiQ9x7+3Uhqpv/AbI0r8w2L/QOClC5crviAulRtyxWnwToH8jNhsDlveg5OtvTL1biuDjyp7YKkg+kqSEYav8kg8P5kjPEncGbcT3NcHK4NwkpPN/KT1T7BGRcXxpY1ts3cF7k11/Qp1SBE4ATaFvebFe5OL5VCV7CB+TQboY62BsrcmEmfkvvK5YES7yJMduLwAnep2wIWGnrmCDXI5m16AmJ4ofoupnGfZgLDGc7PpIBACvOcZ5zwAzncQ7YG+Lf0Zxu8QJ6zwTOkJKlFsmbl0rsjepI5YEtkT/cFgJzc3ZuxT5HdUPGhvQWAyL5i0FCnFoduR71rAuyefnUhZjM/0a2425K0Jjn3cVMa3COeT0+HqkiUppY8asVSJQR327NEuiul7UJYNzpn0EOhR4Osk4zLtGzcpgq2saIrcQqCO80pKheNoe5VGcFDosEzNR8wRvBHB1SFejCRMjV7i1OGOjm9GsSO8zwoy2aP0P1UFIgz/jojd+NCuZTQexbFzGm8Qd9Jy2iMnyrN4zCqTPGydul02mpQ1yzVFx+1nt+UZaBYdCHDUn1KUYDMEXGlhf0LF508YoL6PEqb/nIWrI9lJuRgPa5VF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlS+rE8gquezvfY5B/geAvwAT53qV9rZr526ORx1dA7Q5chg7HFERfDebw87?=
 =?us-ascii?Q?MnMpm4zDQjlEKL7yvs1J/wGYGCu57GnBG1bRR4A9OgpdsftQn+mpSkf7koq+?=
 =?us-ascii?Q?urU1/90Klrp0Ut7c6aV1clSP4UYo0IBrM4f6G66upflxX6DLyAt1fnzhCGET?=
 =?us-ascii?Q?0bvAMSUb6tPEnDtGKaGEVppkYCPuVhv/3vTs6IK0ZCa9TQKU+L+wJsKAusWE?=
 =?us-ascii?Q?YPCh0WYMCw5epHauqzWmD6EiEjkHXFrKbg/Irkf8jHh8fJz90+9o0OpUhbkL?=
 =?us-ascii?Q?EsmrKPIZzx9y+SnjJclBdj4i0oiJeQEzNH7ySKJMgaIaTrZSLEjB78QhVBp5?=
 =?us-ascii?Q?zOREMhs6De7DU124q1/OJFpxFndsgYqOKBOBjlB5MA7NA2vlL/i8jFOdQO/j?=
 =?us-ascii?Q?dR3FrZR4tIfMgb5RoFEQJM4ScRkbQGNnzL1H4wtF9hfPZQwKkU+c8dy3MGBs?=
 =?us-ascii?Q?nHgxStqtffgJ1viWyRYRDaxC12M66hbIDkP8Xh0NE5Q3DtNJf614zp1AB38i?=
 =?us-ascii?Q?qfYUfKwbIljvR7qnxGtMM/whKabEbnmnG1lVr8nlwvfqMymSCvbGaEUVk38+?=
 =?us-ascii?Q?OUPbTe1hQteuSN4u67EoP8C5FBaidzmoy/bmAstmuW6KjR8Cwi2Slw5WfXQ6?=
 =?us-ascii?Q?77PbxG8M+CYuCEbqQcu2oCqgnKgfslMmxuKTwFeCV2HWXyNtAgUFbCbvVnkQ?=
 =?us-ascii?Q?qG5cXFvKGMupBxwH+d2bTcc8BDDjHN1g+s2iVru7oHbJAl70vlDKVVtO9VTI?=
 =?us-ascii?Q?c2wCOwdyrkKkVoYF1NtagHEzXM2RVzSQauQTK3E0sFspTC+P9y7bl38flXR1?=
 =?us-ascii?Q?vkZwlkbuFkvMSe3FyfhHCsfMN5pkMeBwq2Cj+e+HK+SRR00ozgM9tOM2dtGp?=
 =?us-ascii?Q?NmsCs9O/sbLWKSKMyEWVpkM+86duekv9HuNDf2vkTmlsu7WK+z7BzSq5EXJv?=
 =?us-ascii?Q?yqzDQvwYAcw24Tq8+3WIyvUHlK2SdNCOECFrbNr2P4MuoW7eoCufM3x0Ve10?=
 =?us-ascii?Q?TiTVS4oG7B6n+bM52DzABAzGZ2a99mS4wv1gKg0++YsSCB3Agj60vs6dvUX8?=
 =?us-ascii?Q?SFFnpFKkfSmidTOLU2Ls2ifhMdQ1u1YQvEMcAoVRQ6OcQmo3H9BiVdaG8RAb?=
 =?us-ascii?Q?wJd0kWeOxh8sWkaH9mzF8dBNlnDrQmQAa43jaxe0biavx7oJMFqGokJzfsMW?=
 =?us-ascii?Q?c/ymA0kgp//e+pNxQTo0+hy/NdwQfzSCtBR2NR2B/wSmQbCXfsjMffp4wVA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b03e03-fec9-4ce7-512a-08db677c2533
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:25:10.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During sending data after clients connected, hw_ops->get_ring_selector()
will be called. But for IPQ5018, this member isn't set, and the
following NULL pointer exception will be occurred:

	[   38.840478] 8<--- cut here ---
	[   38.840517] Unable to handle kernel NULL pointer dereference at virtual address 00000000
	...
	[   38.923161] PC is at 0x0
	[   38.927930] LR is at ath11k_dp_tx+0x70/0x730 [ath11k]
	...
	[   39.063264] Process hostapd (pid: 1034, stack limit = 0x801ceb3d)
	[   39.068994] Stack: (0x856a9a68 to 0x856aa000)
	...
	[   39.438467] [<7f323804>] (ath11k_dp_tx [ath11k]) from [<7f314e6c>] (ath11k_mac_op_tx+0x80/0x190 [ath11k])
	[   39.446607] [<7f314e6c>] (ath11k_mac_op_tx [ath11k]) from [<7f17dbe0>] (ieee80211_handle_wake_tx_queue+0x7c/0xc0 [mac80211])
	[   39.456162] [<7f17dbe0>] (ieee80211_handle_wake_tx_queue [mac80211]) from [<7f174450>] (ieee80211_probereq_get+0x584/0x704 [mac80211])
	[   39.467443] [<7f174450>] (ieee80211_probereq_get [mac80211]) from [<7f178c40>] (ieee80211_tx_prepare_skb+0x1f8/0x248 [mac80211])
	[   39.479334] [<7f178c40>] (ieee80211_tx_prepare_skb [mac80211]) from [<7f179e28>] (__ieee80211_subif_start_xmit+0x32c/0x3d4 [mac80211])
	[   39.491053] [<7f179e28>] (__ieee80211_subif_start_xmit [mac80211]) from [<7f17af08>] (ieee80211_tx_control_port+0x19c/0x288 [mac80211])
	[   39.502946] [<7f17af08>] (ieee80211_tx_control_port [mac80211]) from [<7f0fc704>] (nl80211_tx_control_port+0x174/0x1d4 [cfg80211])
	[   39.515017] [<7f0fc704>] (nl80211_tx_control_port [cfg80211]) from [<808ceac4>] (genl_rcv_msg+0x154/0x340)
	[   39.526814] [<808ceac4>] (genl_rcv_msg) from [<808cdb74>] (netlink_rcv_skb+0xb8/0x11c)
	[   39.536446] [<808cdb74>] (netlink_rcv_skb) from [<808ce1d0>] (genl_rcv+0x28/0x34)
	[   39.544344] [<808ce1d0>] (genl_rcv) from [<808cd234>] (netlink_unicast+0x174/0x274)
	[   39.551895] [<808cd234>] (netlink_unicast) from [<808cd510>] (netlink_sendmsg+0x1dc/0x440)
	[   39.559362] [<808cd510>] (netlink_sendmsg) from [<808596e0>] (____sys_sendmsg+0x1a8/0x1fc)
	[   39.567697] [<808596e0>] (____sys_sendmsg) from [<8085b1a8>] (___sys_sendmsg+0xa4/0xdc)
	[   39.575941] [<8085b1a8>] (___sys_sendmsg) from [<8085b310>] (sys_sendmsg+0x44/0x74)
	[   39.583841] [<8085b310>] (sys_sendmsg) from [<80300060>] (ret_fast_syscall+0x0/0x40)
	...
	[   39.620734] Code: bad PC value
	[   39.625869] ---[ end trace 8aef983ad3cbc032 ]---

Fixes: ba60f2793d3a ("wifi: ath11k: initialize hw_ops for IPQ5018")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/wireless/ath/ath11k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index eb995f9cf0fa..72797289b33e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1175,7 +1175,7 @@ const struct ath11k_hw_ops ipq5018_ops = {
 	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
-
+	.get_ring_selector = ath11k_hw_ipq8074_get_tcl_ring_selector,
 };
 
 #define ATH11K_TX_RING_MASK_0 BIT(0)
-- 
2.25.1

