Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746286D2DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 05:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjDADWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjDADWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 23:22:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6011CDBF0;
        Fri, 31 Mar 2023 20:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR/Eb0Uo9Em57k61eJYHhJskmlU7a8EmjqNFZIoR844feO768WAZ7gHPobflTzGpXRIChWKfmUqUv96tpqO/gEPjRQ4KFdNHLpmOCrckunL2fFWODBrQ+N6E3m1N7fjjdUdGpUoXBLK0jPrPO6//1UlhWZcvgqVrAAfE+XxuQVuab9AEot9IgeyRuCRjpf+R0bMj9fFxiJTRiKHBAlBYTZyUjuVrB8S1xsaI/q4S1G/jZsIHnql9ARkgOPcqwLIe1BspgLW+QE2b6kniVYKlXq/a+OhkF+Elf5JIAxDxKNFRgzMRZeIWva+QjVRQJkZneOo5CvBYLCGoLubRTakwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vC+TcVf7biSaXXbs809HuUKxokujMPoBfi1gFjlvMk=;
 b=M1Mbeq1ObzpInWC1gyRrGcR1F/gqnOdvV55J+fgWImfFQU+uWr64BTUCAxh3kvNt8XWX7wPAzyCXktLKI0BbiSzyCSrCjLBynxSBr2hbu/mwVo3S3KeK2JbItISvZfOHqEbMlNLv7nxPkUG81AjGnrzBrRg3+EKL584k9QAwcd8Wn30Ij2fHxP1Yr5If7sMhIdkvFHoJ6T4g4T4QT0ow0kPGmxJbbIWiuIT1OE8qolSXh2tfiZAGobQba7FujbmO+eAhBvlz0GAb5+tDDDO/7inZ18KCRXGzqJUksG9/Oo+ESjkmn2XVSkz/fYchVCIkmeuYTUj5E47le/1A/iGIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vC+TcVf7biSaXXbs809HuUKxokujMPoBfi1gFjlvMk=;
 b=FUJ94L1tqZxKxyKR/2SZ7ngIYVqWuuYOUxXBWRbZyWrVGDzfjwopzpK6XaoQkpP5ktQlXtV8tKquzXsQXZOfB8ENMdjkE9NIuSk344rHcIx2oL5VJy7Q+vgt+EPo/zj/1oAFoqz70IRP9QuuVywlXkB0mxxweZA9a9EevJIiaqt3r13LFfw9WZGc61WJj9QRx5x13pSdQPaDMraj5keRLifSEXPYOKR/pRLcmGLMSUGGjT5ySKt6xMz9Ac24Rwc2IahIJ2uxWKFa0IryEpUQ3MD1dL6ECQWSXDQCtFHJDzGy/zhYccw1nLTduL1t5do+ED8KoQpyPj8hRLziChHDCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Sat, 1 Apr
 2023 03:22:03 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3559:931:66c6:7507]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3559:931:66c6:7507%3]) with mapi id 15.20.6254.024; Sat, 1 Apr 2023
 03:22:02 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v1 RESEND 0/1] HID: shield
Date:   Fri, 31 Mar 2023 20:21:50 -0700
Message-Id: <20230401032150.7424-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bbce5c-5d48-4dc8-de1e-08db32604326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ioATjfPOM8j9tHAtJxcvQ9OFHGHZJe9L+bLhbBIKomiKqOOPkLZMjl+S7dnaf8WgEUdYuqXGSdkG3o0qzn9NZqDK5MZyglU+NSzCjhr/klgVkQF3Sc/foKx+qGLm0ADMRMVz7kIpKC5mIo9a9vWqTDekGRqSiAD4N1nXzUcg0Kb//2fBC/flvV3zh+zgHNHdrd+mP8UzKIp5vUPmXWDCQSfY8W42NfVuXDVMw7HZwzRGs7rrsvSXUZOcm+361oNCqE6zs6DnEoPsgZWsHjfZmcWqylwrvCdeEzHy5ivSTV3yfqjnKe7TMcr9coPoPr+xuJ2f7P/HQpjyfeUkE2Pw7YguH84ziGZaaH6yUhZDExKwSLUBYh0nRJqsfeflunuH9/znWrCYG9ZriQ4GgkhXGJthGZwHJUY8+U8VQHfMC6xLM+FOUJkWNPklr41omcOZmr+uAQJ4ykyFOYIbf6zwHxoQqHNBV0fHwtBIuhO8inn20MASbV9GxDZ4smW6RJYiC8LvHcSmih2J5pltAL0lVSa/GmcHvroYn1CtS1U3WUuugYaiD1rYG9xcDe96lTLMKics4TBMlDNIwYrA0BBxDsughtwa2Yk/eEsILjsvaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(5660300002)(38100700002)(41300700001)(8936002)(8676002)(86362001)(4744005)(2906002)(107886003)(66556008)(6512007)(1076003)(6506007)(6486002)(6666004)(966005)(2616005)(36756003)(66476007)(4326008)(66946007)(316002)(478600001)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6ExYi98D0lZCi/u9zsShj2gNSn468nQ8AjjxWecfohlTFru8cnGd4WDWqXf?=
 =?us-ascii?Q?m1KWomzxU4zg52Vk20roRhMAe49RDjZsbVRVw8UAt2kw/k+ESg8yAu2h0q+7?=
 =?us-ascii?Q?cN4Kr8ATyw0KQvqd/75or9brhQNtDRXZGGyy/rxZbKooeH1Gha7wP40uuayZ?=
 =?us-ascii?Q?I1AEQe6vmUU7icM6NUHm/MknBuNfgzt4QFQ0PpL62ADL1VfH4Jcp1Vj9NFv7?=
 =?us-ascii?Q?F9Tu/EiLWmGyWmvwR45AHhX0QFv7ylANuf2s97iQdaoJhkx9kYi7iwKg7d1I?=
 =?us-ascii?Q?CLkjVn7PkrCmBkS8Gkn8AhD93iWjy0UQtXqG6hu/Yw4cBIAFYVCgMv0LHjpF?=
 =?us-ascii?Q?XzeRrjAR+zb84r9TayKfibf1GcB5mlHJvcIgf/YPesVsNZi9IgR93/gARN1R?=
 =?us-ascii?Q?zm0inqak/H38Fndzf1Fme9gnPrk8nYkKyznvx0Ru2sV+MSb0od0T5nOX9hSt?=
 =?us-ascii?Q?Sa6QakeFYmEUIERj4vd3MNYqbaF311fraI/pc4yy+tPfAuAaIL3WV+cuWjYI?=
 =?us-ascii?Q?JVBIWwGM/3/eOIqjtAg/Efc9wM2Y8DoLCOHzglfym8geBxCRSUVeHG8kxhiT?=
 =?us-ascii?Q?pwnJEANO2q6SKe7oVzPImNKiGENDxjKwklLVBSCCgRCTWrGzNaMGRu0VrX2t?=
 =?us-ascii?Q?cw6CLU4qXZe3RLLOSZsziTzctOEl/fTEf/aY3Sye1RkajBTCPwi36jRoX2Lt?=
 =?us-ascii?Q?CPbgH6JUxC8T72JylztgAViAPQt+ktUU8oikO2Av4uG0r+K/A/hdRHwGSE8q?=
 =?us-ascii?Q?BW2OMf7tb93t586AG45imU+EQSM4RY7fdqvmbDHe3c6n7wrsmMzfOqrOtYvN?=
 =?us-ascii?Q?thL9G18jkecplKOGD/y1icZc3NAbVLklz1dukuBLnunM4XFhjEcjRpDJIKHl?=
 =?us-ascii?Q?Tp4X/05kAJje+/O40bW7vL2Ymdf3zf3LV/NyH+4F8oJxwaNDL/2w28kORIch?=
 =?us-ascii?Q?4XQoRjDs2Ohe+DL+S+r0yWPf3fr055ihd1YAAu76cTG4fMlrxEqyEJvGtuHw?=
 =?us-ascii?Q?BV93Ac2M/Z/Z3EawB2a8IhsnFwSoHpbSeBqZsv0c5IBG+notxZnvF2n6EyBc?=
 =?us-ascii?Q?on0JVHofhYvkotxNMeLYlcqOZHWQD41OK/RDy/xaLGoh3cJROxJOcaWs3hRc?=
 =?us-ascii?Q?ossGB+SX1QQrlO30lnQE6bNP1kTj0R2iVt7QF6NeRgyBofIkcqSrIh0rVmMy?=
 =?us-ascii?Q?3Cc5l4d/nYe5qKIGap0X53lBSEFY8zKs57KLzDD7QjcODhdCyIaKSBzO2HZw?=
 =?us-ascii?Q?5vMzBSZjLApG4dDmOlnjmgaXHzcKW/6SWaEReplgqwXus/oK2zRFf4+p07rY?=
 =?us-ascii?Q?Z6KzRzPXhdBq2fV4bN8tRsytVXfJwCkBIbO1wwd+ourHbAK3DzhqPd9i6XbY?=
 =?us-ascii?Q?Yivaaff6INkMLnZU5TpzN/BHwde4hCgNlrlqcX7WDRYVc/84ECozEmaQbiaS?=
 =?us-ascii?Q?EHSiySUuatGuO55ZaEvQwN8yisSJm1Gd6LfpARi3dqTlFl/CAtGCSX8367Kt?=
 =?us-ascii?Q?ZerzxKweE9CouZpfrM4H9GbSp5cmmjycEyV3yQJs+8nwAOXcytzrWWERtRy/?=
 =?us-ascii?Q?aP9CrSToMM5+ioK2lPUzfIJ+LEeX6IqR45tNHk+0Xw5GDrKyWI63hrXSK8BY?=
 =?us-ascii?Q?EExMlIY31nu7kZvPuNEZHUzaDfS0J9VMIT+8luW9dYpCP5ii9ErimFfeNjBT?=
 =?us-ascii?Q?C6nvOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bbce5c-5d48-4dc8-de1e-08db32604326
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 03:22:02.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZlIinl40vFjoBTmASlwdk9LCZFZ1j+qNq3lKdmiote4zQTsbN5RCeUJutDRypc4wAJQwv9volM+hBf+OVXX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is an initial driver implementation for supporting NVIDIA SHIELD
peripherals. Currently supports the following functionality for the
THUNDERSTRIKE (SHIELD 2017) controller.

  - Haptics (ff_memless)
  - Serial number query (sysfs)
  - Hardware information query (sysfs)
  - Firmware version query (sysfs)

Rahul Rameshbabu (1):
  HID: shield: Initial driver implementation with Thunderstrike support

 MAINTAINERS              |   6 +
 drivers/hid/Kconfig      |  18 ++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-ids.h    |   3 +
 drivers/hid/hid-shield.c | 587 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-shield.c

Link: https://lore.kernel.org/linux-input/20230311010940.57585-1-rrameshbabu@nvidia.com/
-- 
2.38.3

