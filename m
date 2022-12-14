Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38E64C45C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiLNH2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLNH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:28:46 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E16113CCE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8R4/0gcfk6Fwf/REbRVgHB3prN/h5dhWd1tDAdhUD1YG0J4lsQMMQe4NJsyamOZ4SrbKKiF4g6jQ2cCOEIGBuRFOkZveme40R26HXjxFIoMTDQ4hhDmYYlz4moQuy6OG+Z7gBkgDq3gUhtWKW4/MTZWDPeG3Tn35Wk4Vv1UWQjsEmKAth/HIrjaDHF+eUhO6s2Mpiphc5XI8tjKTs2UcfOPdODqNcnmLCHVQ7+/6kXbI1nAfaJ18sISwjnBpnt9IGgfWuSsLaWDF4NiMU1V781gdr4dlhp4rr714QsL0wvw+xs26M7gxRFU/0I/yqReTtl6QY9ETFyKNXnHlTzcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+evfzJGO5bXzwwuQH40Duf3SYTMz5IIn8OGTLdJpC0=;
 b=EhMjTeMkQWfOHF9gum9i3Pe8DZxdlLrWv9x51YGSTaXPyUyuRzQFScFylSc6hpbKOjyrY3YuaWeC5v+uwTB0RcJd98LxGnwZ7B8hzp8jwxdWblgXOsssQ4iyQML0TeqyirUprWEvdUl8otMFEKgiUqgqC+y5Q1DMyEXx007q0pUiJN5FLd2HSFJ6wMWYSlJf2fRnibY97DWHc/CWK4V0VUuveqBGHhKfR0ZdtFfNLnb3tTJGf241FXrOG2J4bNP3ePd3rFqdFD/X4WgOezn/92OUMw+0wtlob4yYpSNBAeH6YKdOACcuqv4z9XRFT/t6EJT3kYk7zgAmgnOhA9p5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+evfzJGO5bXzwwuQH40Duf3SYTMz5IIn8OGTLdJpC0=;
 b=p2Xif6U51XA2EXQVm5KiYkD7BsA5fTzC3kuIGfY1eEjwzzHCoXm6bR97iA7Zw7WuiKgP0yMp1pffF70FpfuFk65llianGhdSxXMsHIfKECQ/+Yqdmz5E7FxUZUYfQAFnux/MJLDaPd3XGMjIOy7ZfKt+RsZ3Dks1B2x7+O0ZH9QQrgNiS8uog9FWmjv7qTLJFci61nUnWNNN6y5SgGJaGpO1jKBSQSrs+tDjqSkiZW++K2EGWduMnA+WrTQ+H2mF/SO2hJy5KWtZVLYidkQq1SIDNs+d3gPppjjd/1qGovZ8iK6yRXS36PNhVmRzBy3NdqQxlXz+dU5yDgTUwiiqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5001.apcprd06.prod.outlook.com (2603:1096:400:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 07:28:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 07:28:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard cmd
Date:   Wed, 14 Dec 2022 15:28:30 +0800
Message-Id: <20221214072830.32911-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y5jPyEiAtDPx7VSI@google.com>
References: <Y5jPyEiAtDPx7VSI@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: ef74d7c3-f84d-4d4e-7aca-08dadda4d0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpsV3I/okrGWKkicxUxjv5VlrM0eMhkn1hJ7nIlhKL8u59bdB0pCROtFeggzy6fVgQp4+xpNROrlW4dDoLc/jK0BrOKStAvmwqps6SaI8uPr2wATD/KYsJ8Gh0i3YPh5jpLnu9l9FucuZDujJvnMh9jsyBF9ZPfuDxsv7NZC7/YvjQveFtQMPavNC3QIVIA9mH62CbSmDEJnNlP22+i70EWplyMxMo4G/NKhRt+pJnEZsDunChOVWkPxX9Cs3Z3sFZbs8yTmlHQHAlY3iNUEGHhaycsPQsZo9kQSqK/1eTxeIV35Qv2ei6TATspUR8jBv9o2fFfD6jsHeRavh44jM61YLTvu2301AXuLqUomw2wCKVO4czI5Tuw/uDH5XzpFDa/4CnyUQcd1hV4kvE/H1klxmAmSxWYU3Sy+lZbZOZeX6feqR44mfyPeGt5PjFw/mjht2Rys5RXxERFDe+51upTcvrdKG1ufFX2mDyZ/h22z5lnko0JgCJ6k/998Zje3uC6reheh8aCwtYgsg45MCj4JAywHuTazSHm786DQxMWspWsH6rcC05Geco1D2H6PDGg41/rGjygQWv150AaaQqi5AB+V9yd+QTEblqFldR7bpqPDUjHb7zB7vT435ZJ/rqE1F7DYr37PotIxOuemiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(66946007)(86362001)(4326008)(8936002)(1076003)(186003)(66556008)(478600001)(41300700001)(2616005)(966005)(66476007)(6486002)(6506007)(52116002)(6666004)(38100700002)(38350700002)(83380400001)(316002)(5660300002)(2906002)(4744005)(8676002)(6512007)(26005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NT+hYrRzF418qxLQrZlBQF1uqxYouTaz4uSHqNl7fti16wrqvw9yToVZCK1J?=
 =?us-ascii?Q?VJ8fXhObVDild5a6U1x5yUJfR2xjXNY0qswj7utcaVUHIOwa+aVPpmuFAtyJ?=
 =?us-ascii?Q?pRvU0cbQ7jS18FkmdM+J2zjaKBhHQpkvBcYmMPsdx9ItNFZtVCczjqcaBcmX?=
 =?us-ascii?Q?vQD1EOxE983146dhx/zl9nbU6PeoBAwzQQ/iAhbkIG0tDmHhCVWXCDbnuuBA?=
 =?us-ascii?Q?a1KfLdDJ4hn/sC7ytcZo2GQFBCe8yqaTiOhiq2nBCygh3OMoGdcOsv+GjN/n?=
 =?us-ascii?Q?3T+SNgig5vcXHvQgdzkl1LMQiDMUaEW6yJd4pYxP2SgQA9cS1sUdqmWwEiOj?=
 =?us-ascii?Q?Z1sA2Q6PajV1c8aKn1yoO5NqpyqZ64AmuUQsVraSt6fVHZCSFs7cTsWg8RJL?=
 =?us-ascii?Q?OxPK/8O14Jfnh8MaUxRqfQl/oUf/FeJh0Z1GuoBmd4ONd0nLs3a3KLw5Snfv?=
 =?us-ascii?Q?i5yKMoTvX8ieSyaqLW8RanpE68f4Ztro61xLAvUMtivt0YkStDqzZncKFVIg?=
 =?us-ascii?Q?77f5zEh7tkoJrUj93HrGE6RERgStp8c9S/HkTfb2Pcd1Neh5hI2EugktEdF6?=
 =?us-ascii?Q?VQ3oDXBj5LQM32vjX2Yu+Fm6TxI1EYbOKqAjp8oUB6OC416VckkvWBb0sv1G?=
 =?us-ascii?Q?iZJV92z5rf2QVhhXFlyWEURFeKaV3N1rDnQk7majcME8xGUJtpuhU2ed6SBj?=
 =?us-ascii?Q?dMUJiRbGOriLKWD2c5r8cCAQeS7nGU67k5iS9GXo+PHyQSVA2QiCvxOQ1p+/?=
 =?us-ascii?Q?8bR4jAr5T6ixDNtNHhfUxWAMQJDwYIxjxV/TYG88o/ge7kKH36okBeBcW80J?=
 =?us-ascii?Q?rVUUlKLw/nlUetvlRLV+1b3JXK5dllbDEy+CBMPbbb70o1txpZC/8viwU9EL?=
 =?us-ascii?Q?2O1vdTdbxiI+UyskFHH8O7ukPepnKQl6Lm4ZjpDOMVW9p1SvZ2grkwFE/JLj?=
 =?us-ascii?Q?y8eMr5Zh13ZtPiEKZgdiS5oLEVNII0x3J9VxdqLAOcBD2QofFtvh3Fa/PRtG?=
 =?us-ascii?Q?6xwqjSZxojX2LIdVq39IxrS5pKZ3OTR3ovKR888VdaSeb6k/XiQmlU1zDjzb?=
 =?us-ascii?Q?WZ3SDvtcJSHg41qK9/37sgHIjn3biQaqvGoWUzDpQzjvox6FnzW6Svxrulk2?=
 =?us-ascii?Q?pSLqGyyll0SBBpkHweZD67aysZU5yZR/d76IrWPEeQZAuAA84FyU26u5GVis?=
 =?us-ascii?Q?o1//DUi5cg6hjU318/gE4DARi2y6nOKfFtOc/UqtCNjJvfea+sdqs/4o7rYi?=
 =?us-ascii?Q?2QM7keHBkWQboGj6LRF8l8dP+NETZCdzGEEvATGf4N5gpA6W6jUDaNtRVc4u?=
 =?us-ascii?Q?I/WRKbu0nrp3accRPpW4qWqPydkj08W30RgXaEwrvFI1YQpA6sdktK+1DUaO?=
 =?us-ascii?Q?+OPssAMVTSTrERiPREvexYdb2jKQhf0ZmcDUlYnLX/4lSU/I87L+STbgCy5G?=
 =?us-ascii?Q?X6Ff2woY2olfXJBtzcbx7TQeM7M+vfaxXbEDkj0D85fMRdKY3A5/ywOT3+dU?=
 =?us-ascii?Q?leAVX1pIPKGeOW0OHiF8Kl5cVRfJJtBnJEXJsYKzJaNl1kXnjI59ofrfmnUm?=
 =?us-ascii?Q?3koC4g8KugPiiRnE9yP5bccBrxnIMzad+cfKoKDd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef74d7c3-f84d-4d4e-7aca-08dadda4d0d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 07:28:37.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoVwQqfvttasCARd289UC8Ty6INQZd4U7XT5l42j/KaYKltJvI74BsXpz/u087RngS+V77l5eimLhYWmjsCTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5001
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

> I cut off the patches for this merge window. Please consider next release.

Alright, thanks for your reminder.

> BTW, could you please send a patch set instead of random posts?

Most of the patches were noticed when I looked at the code, and they were scattered.
On the one hand, there is not much relationship between them, so I send patches based
on the f2fs-dev branch every time. On the other hand, it is also to avoid that a patch
may not be received and block subsequent patches.

> It's quite hard to find which one was merged or not.

Why not to use patchwork to manage patches?
This tool is used by many kernel subsystems. And This tool has a more friendly
interface and can mark the status of the patch.

https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration

Thx,
Yangtao
