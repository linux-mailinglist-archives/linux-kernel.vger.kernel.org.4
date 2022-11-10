Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71797623D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiKJIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiKJIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:20:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F542E9F8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:20:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLUAuoUfloi7vfPkfBHN45zS9WYAglsCluSVC0oPDL0Tv4cPYtUe7EytVi5Mit/IwXF9yaw/tldpItXijAFa1l/UMFsWrkVmC3B7pGMhwzecMCVrBc7fybKcc9lVGZ5XVu3oCMX0TFKDbycsM4BEhbtDrb/LWwn/e0TUODjve9U2ShVBRIdo0gmCQs8FvH+31WPG2AU+/nT+LEqiTcJgkb8holVmX3GbXFkHvu5XXSZOpDuq1gdh555LV2WNN32yDSwIlOt84hmobGAXLSM95us/EUVqxG/nt/2IXsVxLlitswLDP8CHIk/xgNXBuGpx72Gq7jVzBj2dGs/uLxCRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UXl5emY0XUTDJld2DEKPJf+qZ2Aqkf/iGNGpKeJSeo=;
 b=h8Rb142g6/G56fEuPmrpvejSk+7lPtPFPxaHoKe1nAFgQXMUKzjZtLlIvRdzfhJBuM72Xlm9W5aUMBC40hAacVLapxK2q7U5ikzYiiYU5/CYWq5+4VB/2yeKXYbaF2f88Ge+dahJCztt1rT/d2Y8VpP8/h2yf4viDI6agTiSh+4AnX/C2I+XrqXGNGO5uZW94l2+i2shxZ99Q/WLuVd/H6nvwkqZEv29q47CxM435mBbG0FqvUWBNPxUWMzhfuVXpniVTum1S/R8kxm52qPO05tBGwa+SqbqWqwQRQoht9oEmqSn2HohyUWUh+ScJn+gG1D47sN/hPPcV5Uu09m/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UXl5emY0XUTDJld2DEKPJf+qZ2Aqkf/iGNGpKeJSeo=;
 b=E1NZwKHtZxK2hqAINePVNqm+MTfP1R+tLIxcg4Q1H56bqsh8ObwshTr/tgAtQ4IGjkrjhrAM9BY7FPml8tGUb/a5Gv5dPULFrO3P2ormG6dZv/TwZvA1GpTE6xpUq21Qwxbllt4yWDaO5BHLpGh6MephMbw8sybZlG60hXzAV7XkleXfL+pW3KPIiSF/8Z9ZZBIQnqf4vPl/G0gUaIUb0sY1j9wZqPROo3ke3a1woAdlYrxjN6eJlEjG6VdE+jO0SBrZ+usKJqnWcq3B/Z9fu3YjHG5UHcd0apnzFw+5SGrE2irfMWRFgZRndbxyqDWciZq5DWWlnmrF8YCJzgyh1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5361.apcprd06.prod.outlook.com (2603:1096:4:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 08:19:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, frank.li@vivo.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove gc_urgent_high_remaining node
Date:   Thu, 10 Nov 2022 16:19:48 +0800
Message-Id: <20221110081948.31673-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y1wQp4Z9sHEqfWV1@google.com>
References: <Y1wQp4Z9sHEqfWV1@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 669dfe0f-7b7b-4293-7740-08dac2f45a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKS42JtGNEsHbNDUOpYeiU3MfoqMq2qM9tB6lupnNUdVdGGueb9ezzitoNaZGh+SMyjVG0iobeQZG3yZMK+a52sgqa7aC//+2GGuCEIjrywe+3m0iwyS5mB/xIJrHIw+xKYwwKlSlXaJglmBXS5AMQToDCo4NmJuX5SkNfb9G+EoroZhr1VAyVnKcDpvVDiUA6npukd1xOuKVDLX6A+Vq+vjMO5T8OGoE1l1CNwZ4HgV/HvkPpV+nCeePQXAG4SO5EAwHFN2LIZCL3+7oWd1wIR/6JZk0Jj/JlWqwYBrJBALVVoSLbcPaiEnLkNyAKEu5Y6/9cReNoskQwLh7mk6wRyrSncGxWTHLV7OKWI1NauHxGZuksbesaw4RI2ZTBXhtG2w0iSwAQQeawO/atFqX1LqUJkh3I2aC3fn4nuJmoRdcIGnhJzgdiju37m41lVuMRf5038+chfGjvN8yr+0e3sNl5pBSrZRcb5jS3LVBVmys4bYVMgieGTnf7j48GEz81i2vlatLnKyI12RWIzXhZzSNr+yV72VDFfgh2CevgwpOTbSj29SEtVqQ54M0158jJsoZ1E+3zt/ZuTPVfy4fwcUujALfbRF9BbynZL4S7e91CtNICMWEwpMBBCXOq47KKo1A62n3jWfa8ix+IEUfhjOZoEstzNvXBbgwKAfbFrZpagn0tTSHlOBlPb4Szbm2U6W+p178XIEaNbSS5lMgpBDiKTwgd3kFoyUb24hQeooRd2b7DyWcACgI8LD/x4UHW8OuTOf3g7zDELGnZO9kajH4oTii6qA+kNR3fppDRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(6512007)(86362001)(66946007)(6666004)(36756003)(66476007)(66556008)(4744005)(26005)(41300700001)(2616005)(4326008)(8936002)(8676002)(316002)(6916009)(52116002)(6506007)(5660300002)(38350700002)(2906002)(38100700002)(478600001)(186003)(6486002)(966005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhWWSn5n4gFqzNGmF6I2ruJIXSpa4BblmryV82puo5fvVlkFTjKLp9w8OzES?=
 =?us-ascii?Q?kl18CwThQjwAFAZnzefc0OgCh2cZvJXzmff60hT+VTue8/5qJTPOhkM3Q10u?=
 =?us-ascii?Q?tfOpoPva3IQ3w+4gMtIxh5FVyqfPdkmXfrwkaamXquDAJyOBdhCdxHs+54gD?=
 =?us-ascii?Q?AnrKanbmPHvDaLsKq5mTG13DN73YUnaewy1e9+RCGt8Dfz1nm9z6zcOlU5fg?=
 =?us-ascii?Q?SI/Zj2mkUZ5fkVmpbdBlgBbkJbS5h8/dDThwKYIRAZYCIbjy8CbUN5/ALdtJ?=
 =?us-ascii?Q?cxI1eGFVoRRnoqTtmee5S6wsZXj7WNRMCg3fsSTR/up77qC/B3nrMYQ2p6lQ?=
 =?us-ascii?Q?DeXhjQyqCG4oVwdNGl9B+EeKiMcx2c1LRkJjMaez/9ZGHlaF9En6vEDTpD6S?=
 =?us-ascii?Q?3t9TP7vgnqIdctQMN0xxL5fMydPjNtrZWSfGpWV7ozMD3Ex//MtW4KU1z3Ty?=
 =?us-ascii?Q?i29/1uTxUHDW+RseD4/tOpJUZuK2pW6HkVukPLVx0eIRJztUN3NaGH998Ers?=
 =?us-ascii?Q?Qvsre+5SJH6jJn4KenQJrRV64A/EXCgXPK64SONjHeBH6Ti8lgUpE1o0UJl/?=
 =?us-ascii?Q?UBAnreWvGqdnu6wVmn79TC/sJxSx9nmKK45rT7F77iUy6MWHGzZpvnVxG3RY?=
 =?us-ascii?Q?R1BLT1ZKshp/7jg5MpOgWmpxw7NeexX4g4yD3y/vnbaMdmysXI3GCoNxfFND?=
 =?us-ascii?Q?Crp+94qUWz6eG4OiTyvSnrWJ75TSShucMoWZ4MuJ2EltlGbyB1W6q55nrnLH?=
 =?us-ascii?Q?qoLOMB+rI93WwOSXqPxWoLCdJJSXlJ0PDjLESWZnSdZirgQ9NJarTN6u0Qvc?=
 =?us-ascii?Q?fiUeqyllWr0mrFvZtBxczFLTAsw3edf73ojC+HJStATMK56vIGt1/QDwbPKJ?=
 =?us-ascii?Q?BwFU/8x4yzeXD1Mw8nara3smtrPRbq1Yh9StR8S06jX6h8nnG2t7qtYtLEUb?=
 =?us-ascii?Q?T21RWu1ukSyGWW7BT1LSqTMqn4HbFtV7Ug26L8C0y4bYgfcsfI0Xb0XySf9C?=
 =?us-ascii?Q?tTRMhYo6u1jJOwASj//B7lPTRlbavr2W4vWrds+uskALrsOZAc/UnOxzjIl0?=
 =?us-ascii?Q?v9omsewIvM9Ls4+O6igfVfKBR9wJxmT4IG/A/QMGSas5QLXOpbFfTtqpdZAn?=
 =?us-ascii?Q?zg0Ye3lmvWgWSyz2Bi0vJxWJSqhQbsnUHrxafM1usGQ/06yMkC5OFrDQ+lQI?=
 =?us-ascii?Q?5AxNQUaWldruKY4721CVmzWO1eL7keFTMI17F8+waV93nAiI113wRyUGIpLc?=
 =?us-ascii?Q?rSoXSAmBzPtp0fm7Nr38+4wMp1qR1ZwdXhnkOchQri9WL++98pz8QR73w+Fe?=
 =?us-ascii?Q?MKQxt5zwIW8ZBceJh6suJYBH0wBcl6CHHB5QH15icYImSXc0NsJZpnoBOBpE?=
 =?us-ascii?Q?e21Q00cP96dtaITHN/Z8Z4NO9nznVa1wB2TodoVoa1i6r4EF0JUrKCMTUN6S?=
 =?us-ascii?Q?dN4lvNh/UBgsHPeCWoBhrOOf7qdIuOrUvX7uw3YC7rd5p3H/OpXZKKVQbhHt?=
 =?us-ascii?Q?ka007OnoTBHl8PwQhiSdtqsFttD70tp3fiAIuIllrp+H7QLYn4oeI8p+2k4B?=
 =?us-ascii?Q?Cba9p+iczrvufnghIVMzVOZ8Vbg1SO6EFcoW9Vsk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669dfe0f-7b7b-4293-7740-08dac2f45a26
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:56.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HUI3W+wC8n8p5ih9cpHPA6b+z4JgCpnYpHQVQWLXapPGOqN0Fmmo7ERy5aOvtmfAIik+Xm1NAB+uWJZGOmDaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

> Hi,

> I modified and integrated some patches as below. Could you please take a look?

> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d34f1e7212c1965a409d4581a32a92a1c91495fc

I've looked at the relevant changes on the branch, looks good to me.

One small question, does the name need to be changed to gc_remaining_count?
There are already controls based on the number of gcs, maybe we can add a
gc_remaining_ms later? Control the gc mode based on the expected time. When
the count is reduced to 0 or the gc ends and the expected value is reached,
switch back to the normal mode.

Thx,
Yangtao
