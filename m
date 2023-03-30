Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B836D0ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjC3QQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjC3QQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:16:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A490903A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J17Mul2/skz4NXg0DHh+r1mKlA/ja9ByiRIBGEgmZ6C2gjf/cOtXjvO2aFTe+QbuTUbPQGUblzV/dkVFkm/t+ZqXeM62bHLOeffUP6nJW4jwEYHo5Bgeirz9A7pJHR1knBR6wAA3l8qqM33WhB9VguTJGQ3ATx0p0+BP9mrjHVGRs5pHyCjzJu3snkdBsNkkCNDM5+U2Td9R2dZeHHgAkfHKxvy1nsTdhe6D1FB5ls5tyaW77YJVbsR+CGlEN/+LLArZpigPkddbMFiMJ8EKVOUfGqhW2u7gzof6wLGqD/KtyZgQZbyBliXQ0CKUy4fV4cCw1I2Tu0YdEZhewjzzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAlJvjYzVaSw46YLu12Stghylz9PDV1pfEvSMqVuWeU=;
 b=AfgSouIoMXtlPceVagjOgrRwB1GHpNO/Z8nYPFQFhkgJRAL75TO96lpUgt5o+dAnAgfMWBlYLeGrpk3ThiK1sa1JhekEGHV+ImnHF5W3dFJ9x6gWs5RFtKYqme2xrsXKLDG70emC57uCUpG7zuR6ZHir/fqsIvV9q0qyQID3LeKaJ9SDJ1zgjj3fqFBjUcewxSN9qrZxt0Jp2llbrLUHvkEiphvPNRvMLNqfZxk4Xoj67DxJsCF8Ky5BiWl9c7M4bbVcgH3m0oPV9Kcq+VOxZ2c/hyvbGKO0xCTDLgX6ih67btggZQqMtlt15dpDOBQcg9tF6/YeAxSywi8EeEo28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAlJvjYzVaSw46YLu12Stghylz9PDV1pfEvSMqVuWeU=;
 b=AP4M04A6+L91f6TExcBY8+YyIuGnLgI/9qW60zvhkrzefhYz1OnAb19OCdGLA51dD1BIFcvSE/erb3I85k0mItMeEOOOf9XSMNHpQ7RvnrWUaMg6WPoYWyDAuBzvB1FMYEURKpEQzlQ6RQquLuMIs7eRwiqv6ylYiao8D5q+Uu/kUfLwZD/n251iPsFwGv5HjxPmZ5yGS1m3VGOYs3VcvgNUkQlcUcdJcIDddACwns2G0w4B73VyYSG24s4hwK1fq+jCeXpYNvftYbk/ABV1fk9DFtJp2xDL9G4Bi9fU9x7ZwuQzcsumuZnLylURuGSh42lf0fm9o/vU+J9Q9P928Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5166.apcprd06.prod.outlook.com (2603:1096:101:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 16:15:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 16:15:48 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        shengyong@oppo.com
Subject: Re: [RFC PATCH] f2fs: expand f2fs_compr_option to allow ioctl setting compression level
Date:   Fri, 31 Mar 2023 00:15:38 +0800
Message-Id: <20230330161538.13233-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230330153719.3085164-1-shengyong@oppo.com>
References: <20230330153719.3085164-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b22f10-9b4a-4c46-fe42-08db313a056e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbwGwwZL4aKGCbAhtNHi3kfdlQl8k3zudfAjuS6LtG/5VObNlNnjgtsm3rQjtjwm3j8I9QW2KkA7FO6ySxoOU+VK/kXyBYo6N/IQzmDMZeQA9tglSR+fUnH+EJRSsw7OE6lUAetpMwy4BPslN+tSOqGxxJDU7giBdgtcanMvbh1TYhVQoSP2vwVSYiceh2Q5DI9zd0SqNNvfXOBPRC+Z2yUY/YEUm31ahfigxFzXA1J9m+OhYSCnyrIBAMp1h7CbR4lwVwb/1Ck24BfaMErz592/DU+4p9Ti7Nto4fcUAKEYEpBk6fdscTqn30dtxy/JsUXjLeoNY/z70TYuzaQWo+owD1fKswXzB8Srpg0tbTFccnMgTb60X+P16pYNOY/uzIfMznlRuCu0Jg7SUITdCL7TFYH947JBiHpx4SFv6yabXB7nOSoKOx3PJ01WHE0SEia/Qt22iYSEwxlZJQ+YKig5LgO4JYik6vURuSgSPg35nB8mEbMsZV2VgndfT343HAvO9arO0PuBqmP4RwONsGnL1vw5KiXIaNUr/DEFvL22h0ua/LYsLiSNDLzGbvjo7iJ1yJeLKBmL1flLBytEx7JpOYnHjwtL82xiAhwTsoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(52116002)(6916009)(4326008)(41300700001)(316002)(8676002)(66556008)(66476007)(478600001)(66946007)(38100700002)(38350700002)(83380400001)(186003)(5660300002)(2616005)(558084003)(86362001)(36756003)(966005)(6486002)(6666004)(6506007)(2906002)(6512007)(26005)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HglN92VqOil7l+4c4Leaq51dvNFvf4ZKzURZTWMdSosV8LAPw1KPs+tKkJm0?=
 =?us-ascii?Q?hj1Mx4J7a+IN8OYfVKnLY1c8byzr17WMJWi/2BiUQ9v4AX7nUTju2eH0qKHC?=
 =?us-ascii?Q?sMBg9pZlgXfU55bAoj7KPmC2PNKFpqrFhKMP6mjxdk7ldjMPoM+TI8+HFCIs?=
 =?us-ascii?Q?1LJCKKsK9zxh6KxmIL0X3/iVNPoP4GMQSkCLWpR4ERnUGyjG8Qb13rGLafc5?=
 =?us-ascii?Q?aB8ipSNzHMo3xZS4EW4ucZo03HFymIOO7RgEXYiYc0yzH5tRC/BwvNYNsjEF?=
 =?us-ascii?Q?RGt8JL4+nWPHFq1WW9AqnIsK66uvqU0xi9TjQwWfMFAcTiFRn0a/fDq2usk1?=
 =?us-ascii?Q?699HeymQAgP9iuugzvY8YL2NozAEJPy8K6fEyxlVS7YxP7gzFBaopGLYENnv?=
 =?us-ascii?Q?Fj1Ocu5kTZ41wcJ7GBomqE+pDBoTRSmUVK37axkVME7+PDNh6O55lAjlvu5s?=
 =?us-ascii?Q?0uaX4YSo+nMS20v2bWz5ZKyxUhrEgBRgc6ObG8pYqe4tNUZoDs7tTfFUXobg?=
 =?us-ascii?Q?cwPFnhoVSQPG/wShdPKH0yeiF1UES3qgEjx0eauAyQSpTOvNfwVfrS95tL+/?=
 =?us-ascii?Q?FzUMWO+av/1ggOioa+VDlzH4LL8/BbVjoVAAQaouDuLBGGqxy1ZlLjgS7gvj?=
 =?us-ascii?Q?f4Nzzj28G2KxqTbr1UvGH8W6EPbwLuv276N+WGRa9eQx3vbtS19ufguZ+KZT?=
 =?us-ascii?Q?YTA661HaMRFcTx/6EuENCmPWaOV74UCkNuTfI40eCigsXpQo0mfoXczomBAN?=
 =?us-ascii?Q?5/GcYnuwJKFmJmxUVxqk+14APJyL/WFl3ziiAXQDfpT6LZdmqNVnIh20OfNi?=
 =?us-ascii?Q?4zrfCa0JJ/a+Szoif6lFZLRB5iYQMuoH8tEfrzGUj0vQ0QB1IEWQ6mOcrT6/?=
 =?us-ascii?Q?+LiO1V3my1vx0BtQfHl6yngbpo+JLEOOyOgQ3TQ/mJbVxBSd47cfY/HWgoF7?=
 =?us-ascii?Q?Bazqago5422hIoIB7eHdgiFOCxbSYWu6oL6i1aKq1iRkRAKHrqiX7uHwsuaJ?=
 =?us-ascii?Q?MbMpmnHKDWTogh/r7Wv7J++IDHDBYH8Slh7kZThqu8auwe3avNup5k1ZNuI7?=
 =?us-ascii?Q?Sf3lz5e67/P2LKPCP20QHLgMDrAvxDGMY8flua6iQlwlcSlZm+hINhgdz6yC?=
 =?us-ascii?Q?SAj/bX365PDuKSUOV3lysol6NAz6mZ531tJLOZM60x5qfychYklp8FbxmnK+?=
 =?us-ascii?Q?5YmwDfxIHWzMGgDl+wTCidK4sVK4pKMAp7CFiGhXoSl19tuWMJY592njyTWq?=
 =?us-ascii?Q?OD9TlpwkIEXvDhKO/L+tbK2rZy7LhiKtoha/d8V1nYAcYfJxsKFCh1fVdHmI?=
 =?us-ascii?Q?daiIyWt/wUnsdgNU+XwSq4OpxRtEIob14A4PR5UFrTkzmtex7XtRM5fUSfmR?=
 =?us-ascii?Q?rNRcW+J9yAfuFkINBVRUutSwVZnf6ozlg/onLXmbKBT2zlKZ8PB+4YmjakhJ?=
 =?us-ascii?Q?Ej3RfYJ15+u85dyK+QcMh/ekYegjSBYNE4w99YFk8MK8Ne3lkJIko4Sdv2zs?=
 =?us-ascii?Q?DzlMRic/+fM4r+BhjVc2zblmSVOj5OePCGOQ/0H+N6J/lnD2EAI4PSenEI9f?=
 =?us-ascii?Q?SqLj4G4NRiXpRXJ9TjVxHQfLM5YdiV1WbFv1LRCt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b22f10-9b4a-4c46-fe42-08db313a056e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:15:47.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd1op4iPJO13QrPkY8IbInIy06qlFJyplWrsTi2WXQAiiN+/SwFBQMxBciP9J5zSHT987l3yqJb4klxo1sOKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5166
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sheng Yong,

Your idea, I also put forward before.

And has been sent to version 2, but Chao and Jaegeuk have no comments yet.
Time to talk about the series?

https://lore.kernel.org/linux-f2fs-devel/20230112133503.16802-1-frank.li@vivo.com/

Thx,
Yangtao
