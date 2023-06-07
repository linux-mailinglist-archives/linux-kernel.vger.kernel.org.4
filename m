Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D67726730
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjFGRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFGRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:24:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2075.outbound.protection.outlook.com [40.92.53.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2B211C;
        Wed,  7 Jun 2023 10:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9Sv8N3ciING5ls6RTPbBMpGU6weYwCfhU2pkQ1i2Pe7ItXgOYYmo8ev/9s93v9eL+fDytQmXK4xwUsAoJ7b4bn1Txm4jTaOgFiggAI7lmmXTs4bs39lMM1xBdxzFLOn7kiUPLsPpNstBiVqffaZR7spMsvVjukpKA41FJ63lmQmpJj3ebDG3WY/sFVtEcpw7sr7E6MKzLGSStMzLeAla9jASjPlFomyPDCOto4RWms6Dl/kJ5oB1xwWrLo1laWYS6l+XZpMifVEG9d7liAZLMHIjzuOk2kLaUtGe13vgFKRuwokP3st+wX5wEGgn0+ybKTnawj1YbM51tGKfjGKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f33TL65L+W1/+oRk1KEhe7DHLVC1ecKeaiUIWK4X/Yw=;
 b=EQlXeimPVV3SkyUhhgNQR5XRXc1VcHh/NFBZCflNhbhklJl/o9UEPuoJJd8JYR3XRiMfyLs60NyExwhkOjJ32X2azrv975xDdBAqu3UiBnOHrszd/l2R0MThL9kmNvwtmz4FSiQTTKDkIqPHGa2m3vO7Qr3NmG7mA7uPcvnAY70UEhbs9GGuFdXiPV0dblGIFeGltDAbcSLZdOZInjUl/R9DcCwKcwWGT5iEYX66s/CGsxu8pv3aClvjzb7cMo5Cx/bVQPAkLb4pY0GqoncLxNTGa+BvWd0Y6xaJFYvTNGfX8feCUd2P/XqahAH5ylrByp3/5AZ/2AOrvs3aEyMN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f33TL65L+W1/+oRk1KEhe7DHLVC1ecKeaiUIWK4X/Yw=;
 b=utzeflnbLHcBVpEbM93EF0lQuLX8+gYdu/+pi9utZsljtv3ywDn/Sku9ZLeWMKhHHYzd14dZdYR7r5SkUfN2qFjOzKGoRai5xdHBpU9BLexmCRxxspLHcfxvkf7YME1se/XwqXvT5FRwj+a50hgVR4NVx1xDV7uiRvdbmKkYtT2odTwvJNYSMeXvHEEuSpLuSWaO2KqkjgXkUiRrF5AcIoyUWnrRMf13bwsUAJazGMXV4XVjhDOsdeykf4D7NrAEwdDPmsj61VxPhGdq/yLktnuleofjg/cXbm1VONaKIwNPxfguEez4aZoIT7sVd/SNqs7DkG3WNr2zBLbxcwUokA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SI2PR01MB4396.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:24:03 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204%7]) with mapi id 15.20.6411.021; Wed, 7 Jun 2023
 17:24:03 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     kvalo@kernel.org
Cc:     quic_srirrama@quicinc.com, quic_kathirve@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 0/3] wifi: ath11k: Fix runtime issues for IPQ5018
Date:   Wed,  7 Jun 2023 17:23:16 +0000
Message-ID: <TYZPR01MB5556F7C9F8E5BB5F5E1C8770C953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yl7HxIGS7K46dCY8V62DMej7eIOPo2aH6PWBOLeb/+E=]
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230607172316.2258278-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SI2PR01MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a91e872-dc66-4a38-e01d-08db677bfd45
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6cnTu4xI/FKWkMgAUSlrozNByv3waylnVfc7LOQkKuwdoTDj6/k8SSvAM8dzgnqRcJVqBQKhFyIKzmB2NHcWopPB8SOjljTsq8RwC0BGdXP+HeW32ICwq4pc3RoMFkuZKZyHrlwrsoylMplajJIgN2/TrnM9CAf0PYwiixW2ryNAGu95HEMRLvFyHKVQidr6wIG+sX9IkeKLIvPu169FCj+UjJw61BNSMoD3sa7V9Wb4AI4RW6XrVMv0zIsyGxyhBbPmkzsnIwbskYg1EwRLOYpki2ZilznjLc/e5pxZvwu+y5F47o8FokD5GTTPRHSqy9LPMuA5LqtdEasSbcePE3iqa4T9GtF3kAmv3dmWjj4xq1E4h4eijwhP9+qI7tH+fuctTAz5W9iXLmI4OVtuRtCa4XpjqquvmIw8Z/pMFC+cV75gzYjB5/PQTb7Ch2kKKKlud14LH62ZD3/k/DvdZKJDKpS18WyXqRbQm8Q2vEM4RbcpidAVG/+PAVztm0X8TRLfQwHHvEdvXz4E/6yt7elxziuav9u4NM53P6lXyAVx7Pdmc0o5jz9pyLyA+8WDPAX+lDkibsOe94QBxC9TxnbLx5V4IO8Qoc7wVgU+LDA8o7i0al7t3+bKUUCYp7R3aFJW+glW2vlGlE4f2l3nOtBFSrTBYpiVvOLlkylSeo9TEmwUMS+psurBXSjiv3rPy5//kVRARfRuEuJw1Vs4ghA9c5ihmOSbxzoGMxwtLoIJGw7/IS44HvMLiW7xLGV8B0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4sdrrfZnM/K26VzKzZvkiMo+3BaIb+C7lkbOt85kqVhjRPQ+1qthIBJ5l42PLcwRbRo5ghtyAXAyjP95bshuyuQtLfZ6ENWakq02fGI60K/JcR9PLBn/C/gHdtr0CwXTpVmHGOrhdVATBvfw1yqfQ9Hkc9p+oiLElXKThkCuydfQIX/tfTDFellfuTxINcYu5frPyYaoO0iS1cNzSONvl6YExMyinbkmtvrMh6vY2BDI0Z6FG28npb7xmfIhhf/n8LcbDg20GUUcDuxCvDJV1DZBckMGeC1haJFq1Eepla99F4Etp6d6FsCWqwRcxoksa3du605af2hk08e1if5K1ZVLuIB8xK4It+Ohsy2NMse8Eq5mu9Aa/ryW9oj6qHYgDkdeOXb+oR0KymTstnSi3IWEfyp0mNJObFi23T9IwLJ/8vH8Ll/tSmBKr+DKHm26AbFc4PStrMhsJ/oFxCz39/hP0eW+d499Le/ttPIbL6XIYOoQISIYcyEna/JdiNjDTeaDXtdfUrPBowGVH1jbcRTu61FOhVd+7jCVlJwPBYMPh8Rpuga2lvqr3QteHsNEaBc4F7qLyn9eENfTSIOOZZFdveBfWlm5kCDna5zZWo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x4rPDnrGJ+hbvkZuGSespSGSe6M0fP3sANp/cjqqRSvEbVab5pKL3E9BaulC?=
 =?us-ascii?Q?y823boqW7bx8PgrmjX7OlfQlhQoKCASAvD+NvgMoAM/zJjj88BOLy0wZ/Ltj?=
 =?us-ascii?Q?Smst+ovDHnSvPZ+xzZXX6vVbTvD+0b4GMJ+Op5w6AibcVUv+uHTNq4dF3TPa?=
 =?us-ascii?Q?g2Lghb+iNQbmk4uZLy7EZfiSqZQtERhHln2W9KA+c1oSaySwLfuqidkfeDdW?=
 =?us-ascii?Q?nEvUJKOIjKmi4hwQPI2vHCH2cT5BjtzvUBZyIEWq3t/3am0PyQQE5qJYrVqE?=
 =?us-ascii?Q?L4kzyaryULeeZQhNi2bN3z55/tguyTF/a5KDA03YGjUMqDpSrl0lxtjayqq9?=
 =?us-ascii?Q?ksTTdHWYkX7yhn83rShVmRmflBStA0lrwGIVlXo3Eb/5GkEmIWee4bPDAUkO?=
 =?us-ascii?Q?sZZhMoteLIdC1QGuRmu9lCGROh9OsiMiY3yuNYwxzaM03kKsWA4f3kguZGI6?=
 =?us-ascii?Q?RHEsyEeCZCQzAaFenOcjwXBFFTW8/buWseZ66zEV1H+zM67FIpp4TBfeLpOT?=
 =?us-ascii?Q?cX3yjLyXq0eDvUNVpEjhMCZF5WKj8AXfYyr/7YEvrIi20g+NEJXaPsWlfbC5?=
 =?us-ascii?Q?jZzX0TrL9ehOKeG8zyl0dIm8wgiRtlEXExo18mQjP7fpyC5UHx6BStkCdWYo?=
 =?us-ascii?Q?4hs0zTOvcjzqirCFUyt+qd3pWXbiukdk7DG8zVJ+j+zx4bVsOJDhm7M/zVsX?=
 =?us-ascii?Q?YxLyVxhL843AP2DduXSf7NbEB0qpQH/FhxIJsEICbagKzs6sfAwskKS3QxYY?=
 =?us-ascii?Q?sW88vz/vyrcY+PnlsyCoyEX5uszFMIs80UQ4pe+rbX58Kikm6mdQXk3eSIOW?=
 =?us-ascii?Q?wqWJoLLcLBIZzplolHDb6CFjrDBOjYmbrp6zWQuJCHA7dVlWdWrnghAvKlsO?=
 =?us-ascii?Q?LHQsmV/yfFYqDxvFITvuLCCca21T/3C0Mi1dum7stl+vGxOZC3Uo91UG94ca?=
 =?us-ascii?Q?+Gocbn9xK8ZKYs/ACYtMxOesBe1yaUiJMfmOxe/wifCx2qm2vasD0Ai5kBYS?=
 =?us-ascii?Q?zyIippfyIA8B79lhfTc5COo7EEY2/F9HrWW22FzoX10lfKernOKz7wLhcu1s?=
 =?us-ascii?Q?QsbrLwGKH3OEMdUbiLuWYtb3FP7fxE45mk7oIwih+veRs4hubiMIfrG1UGNL?=
 =?us-ascii?Q?BphPYvkhEdgSOpNTnjwFQwfSezc5p4m3NBTIJFBvyfj7axrbtdwS+eeEBk6c?=
 =?us-ascii?Q?aIR6NBm8Wdziz6Lwgc3KhAtj1jB+eWpxBoVJI/VIfpZLDfgOnJoaxxzPJSc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a91e872-dc66-4a38-e01d-08db677bfd45
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:24:03.5661
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

When I try to boot the IPQ5018 WiFi, I found some runtime issues. This
series of patches will fix them.

Ziyang Huang (3):
  wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
  wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
  wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

 drivers/net/wireless/ath/ath11k/ahb.c  | 1 +
 drivers/net/wireless/ath/ath11k/core.c | 1 +
 drivers/net/wireless/ath/ath11k/hw.c   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

