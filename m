Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0696A557A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjB1JUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjB1JUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:20:38 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFED1F4BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtvpOsXmjYoUNwSd+CHAzGEQ4ASd17bvR96bxVcQVYnRmA6ED9Ce1FZxoCIlBMclems+fVfepfvqgOwbIjLEsF7lxFpx7LpNcfAWKAiclifKK4ulSGzcqLojMoiUwThgFzK/A6PANS3+l54R1phKnf3l8cFMXxUib/5IYX/JT+LsMwfJMiNooXWZrwAcVcuHJMUOgzV5o1nho96YrzBmz4RrU6uvP9a9GP5Rso4wnbCbaRzGxlwjDMHMdvITdD+KglDlYYZE0nGLjEata2m4DPWSyfSvL046UuVaR8FOS53MxkbHFHnyEu0B5fRnyym3MXIg+Kw/ibBL754IrnxBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIHvRndMn/09M4y/asnJoV/+PLLpWsf+3HKr/bJuLI0=;
 b=kmFQiz3/7g1LaGdzH1/B6TKZ9NLJvxOPILsSUC9oFDVGTdVxVqnUn+e7ExuNmvEyJqoGd6YSHVy/sCLyIgDwrgp72bAl0Mg6UcVbyIxbGeWYSzrwVtCo6Xzhf28VUL/9bV9l09G+HUJ5RmhqnjvedR6wwGub6/z4Guti5mpPluLs0cugooSKtkTtVnBBw+sh9fPwB5B5nfEucAr6IRM1WWRG9CE0LC3LWDoSlzKuSVWmVPHFz9A1VL6Tp1ltP45vm5bXQ7UlC96wWDUWjh0RwSQfJ8PucIlCh6A7gXAF/O5GxyyOtJKxDcY+/IJfflocPvqj5+i12IEbKA08VkCb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIHvRndMn/09M4y/asnJoV/+PLLpWsf+3HKr/bJuLI0=;
 b=bEjHY9jt2YCbN3NMa+LDV6eBSOPrypkrGBTiy+9CUAvDHUkes7wsUq8oueLEEWesV9BTVelzuIqXn6WFcWTmJ0/tkgchQRrDlgM9WqD5j4+UyWCsbbEadk89s56PEaMJkU7ovcrnrL2u18+uePboaaOor/4s+mzKhq6CQG8JTwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 MN0PR01MB7780.prod.exchangelabs.com (2603:10b6:208:37f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Tue, 28 Feb 2023 09:20:30 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ff57:42f9:7d6d:de10]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::ff57:42f9:7d6d:de10%3]) with mapi id 15.20.6134.028; Tue, 28 Feb 2023
 09:20:30 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>
Subject: [PATCH v2 0/2] Add DIMM 2x refresh event and failure syndrome
Date:   Tue, 28 Feb 2023 16:20:08 +0700
Message-Id: <20230228092010.1863419-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|MN0PR01MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8b8c0b-0960-4997-571b-08db196d0968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gbjh5YZXe2G8Q1D4Ph7cLtqrMoSvuElOczLXXK8bqr0e5eiv10P+b0idvdnoriseTp3irK1TZ9DrBfo/xFbFe1u+WnoSoiuRM1iGX04VHvl8V8JW5+6R+wZ6EHgl8uDm+JR0zmfI/C7LHDdkZzK6MZVxFD90VoU7SvPchFunK/LRFsx49tpXz3X8BuEq1ieM+oQBfHZto7fg4IoC+0ddZSqrErGApwKhi+elD9oBerVHxpI8rkK5rmZ9wXxuTD3CDynH6xdC7uEh0x0IOwYymi4l8Hi6PBOuJJU5GkYC+RphHQfXIL07iBMHNrBzhxIfug5WwGe+uXtpsv2cBnswYKwAtNyHXUUbSRjGcn6VDr1pVGg3k/cbP+1PJVpzNKDkReMFwNuk12Bcgq/pW1sLjCjBcsHmJlujCm7v2mo2aSoGfFONAXl0npOBYrSksHA30GLTCE3qCNiJrtI80O2efoYexaKhmhunyL8UBoURc2sCrJUaN/D+A/bb2HWqm8cdanE34IFm38bYwRlLe2fRbOkuBLdfqDc4ybK8zGvOkHzLgKlKMLD/hkKTKMR5skeUPtEG5gijQd3SUZkPRsOHBOd+gfp2Yx3uT4S2uXnoXpgQL0vVF47Rj6ph23olX+GMyCbPMxIVMdVdlFt9Z8H+D+UDoelYStjh8F3+axQgsXYfc3MR1SYC2ivPwN7UXseF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(396003)(376002)(346002)(136003)(451199018)(86362001)(8676002)(66556008)(4326008)(66946007)(8936002)(41300700001)(5660300002)(66476007)(4744005)(2906002)(38100700002)(38350700002)(966005)(6486002)(316002)(478600001)(52116002)(107886003)(6666004)(110136005)(54906003)(1076003)(6506007)(2616005)(186003)(6512007)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0pPIDILb3gg8n2CnI+ODCNPDVyzUOIy/slGClcYe9q1ehnpL7tc7UZi8IcLA?=
 =?us-ascii?Q?/tEvLKiA6KuG+M/HI+l+oywchwI/0iBJM8BREGmm5WUZBOXGyKmK3H5rWcQP?=
 =?us-ascii?Q?7wIjG3SXtY2cspflYWxZCeh3COGEZv+gx+eoyR/bYeTQBymAdPoJfnCm6g+h?=
 =?us-ascii?Q?pJk+AIh+p0zWbcb8jGw7UHkxADy20jVSFvCR+k3/8g8gaHyFLgotr6eD5r6B?=
 =?us-ascii?Q?rnifDgkLyMoFLevr/+q9S8gKYP7ldpx2ZdsnZCNFQKS8DeyJMpiN5lGLbZLs?=
 =?us-ascii?Q?hoj5PSNIeU0e7lU+OFRrVZ/lJBljiWuZeQc5rnkpsmrRt8YnGcUxZrS+1WyL?=
 =?us-ascii?Q?5tvNnWQcvV1PoONrqqSxPNTBr18NJORnTWrgB3tHP2YhipdxEsYMot41UxFE?=
 =?us-ascii?Q?4SUeHMlKDs0FayCt2J2OuRLY/xx8yi07rllx0emg0OeVAG7oaHP2djVSTWzK?=
 =?us-ascii?Q?IuS1E0k9ceHAip5BEcxoSy8CW8bN6RD2zI9284zAwKISl9SV0+F+PR20Mf6c?=
 =?us-ascii?Q?pewjxh4Pv6Fl4IPJrmDkpP1bRDZ/s2RrJdezaN7XeSq69pvf4ZR6Kw9wAfYu?=
 =?us-ascii?Q?kBGbrGpI4h2A+59oRTQjV09Hd0oobKwoGVyWaPF4B1Z1hriSVMOQvzcPwHOR?=
 =?us-ascii?Q?Spsh/F810q/zKJC2alQdyjnPUnzToDTFG0JmZCgL8BWv1QPlUGHuCkzY3pHD?=
 =?us-ascii?Q?uxfnez28SFi3EcuOqL/MBlpxJC+WbyRckgcG4/CwnEf/AK/+ImmhFuY1W4tS?=
 =?us-ascii?Q?rTvvDW70qzAcbvu5QTLOGFTShk4P6Tw4A4YSLq2fEoq9gojm3WZ1InjAQfkm?=
 =?us-ascii?Q?L9py1sZE7FPVSDcE+2/swYMx3fGtrl1eB+By5JGr5dUj6FtSQgPAjhqfGGjE?=
 =?us-ascii?Q?cbRtB6102oqnXwdKl9lflYJjd7zPphNK4xTNH2zBoZOvFkDoXvrQYe2f+yyU?=
 =?us-ascii?Q?38Jd27vsRkCA1bIfjmhKfkzr4brcOi+SoissIRXPsbRa3tmbhe522IbLnq0C?=
 =?us-ascii?Q?bkk1iMO7bQkOe4kYX/DGrLdQeHvoWv/+LAS7oy2B4yhJzuv0uEaUFPOB3EDn?=
 =?us-ascii?Q?xjfxjriHNjCYNO3yhoDfSzYrGTLnWISXLDCwuWTY1y8tH6QsbQUhRlJOFxoJ?=
 =?us-ascii?Q?f1oGw9I5rn49Xb9iDrFgHA9JmVVk+aEu5sZlN1MeedruMzme8PwJpEWGjVai?=
 =?us-ascii?Q?qC9qMKlHvTNpMk6CAz+M08M1eSBfKHEqzmRRYGt6DzX+3QHLZx2HftEZg8/Z?=
 =?us-ascii?Q?H7VxczSbGlefrRNnld3LwR8ApSII2u8pnBCncsXO6i/0Dmf/okjkMOVye7WL?=
 =?us-ascii?Q?cT37Tvw60ZYkyKUFdpGNPKdeMejKXCb0DF/mTyTuaC6U4AB0NA5kvwpAHgyK?=
 =?us-ascii?Q?n868I7wQjyWjkSTywEDjhf5+guA9jUTdrt2WToQVx5d5Qr33jmFtl3qSrQmk?=
 =?us-ascii?Q?s+V0KsPjsQqzY/lSxOgWwPYp7weeQWPY/ff3NFjOvuSGJPvBH2T24tn7IJtf?=
 =?us-ascii?Q?U6J0hGVr89q7n6Vrpfsw/IxdS7JHJ2L8qE39tPYvyjUNnjQAwvsNp9lNQPJi?=
 =?us-ascii?Q?wAytRG59+F6YzJKk16ecBygphrU3Wtb/bU31OC8HZflXK/8lxQ2OIlUsvP1V?=
 =?us-ascii?Q?7aji6F1WkMC+fkNiACnbaZQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8b8c0b-0960-4997-571b-08db196d0968
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:20:30.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7anci2Dyvc3o9G9FC27xxJNGU4SXVv3b+1rYjPhPiuCEW4oYfJTT/SMWIhbFllM/O4ZIyHIUFEX7uZuXBSHD6MCSsWDpMUiAr3acs+d+Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7780
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds event_dimm_2x_refresh sysfs to report doubling of DIMM refresh
rate on high temperature condition and event_dimm[0-15]_syndrome sysfs
to report the DDR failure syndrome to BMC when DIMM training failed.

Discussion for v1:
https://lore.kernel.org/lkml/20230214064509.3622044-1-quan@os.amperecomputing.com/T/

v2:
  + Change "to initialized" to "to initialize"            [Paul]
  + Corrected kernel version to 6.3                  [Greg,Paul]
  + Corrected variables type to 'unsigned int"            [Paul]

Quan Nguyen (2):
  misc: smpro-errmon: Add DIMM 2x Refresh rate event
  misc: smpro-errmon: Add dimm training failure syndrome

 .../sysfs-bus-platform-devices-ampere-smpro   | 19 ++++-
 drivers/misc/smpro-errmon.c                   | 82 +++++++++++++++++++
 2 files changed, 98 insertions(+), 3 deletions(-)

-- 
2.35.1

