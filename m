Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC07151C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjE2WVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjE2WVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:21:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472EA0;
        Mon, 29 May 2023 15:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na6hSHHAipT4dU7X3XmFMu+HhdIIRK+rUWlLOU6HZPiAo9xY9x0TG43UbVjVXqFLP9iwhzok09zCqFYiJyRyvEEc3929poyEFCztvy9KTG9PZK+AQWARv8dc7DHtEBiKVaIZYvf0H7v08a1p25P6mP73YSF2JDCkOP0yCMeNQvh7w+mbAdowSUhdS8j7mu55HYfezaYK4ERnfhr5siZD8DR1R4msvmAaUuxni2z4yRIPbayDxTpfLo6K5itpM9459aDgKG+PQWRSfkkw2QAzzyOxtXqGTxAFuH/jIpoTqsFMAr9cSTxJlu0+gZJLv1Q+s0a7RWG4PgNmYohL7ZKzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr6Hu+XIhMXZhfpvUZ3dlh1Rrs3bYziUTbV9Nv7mIAI=;
 b=FeSRAmpsjvWPIIYEfhdcwXmrDL1zFJ0QSRtpxbNGNvi9nIsjMLrGocoqDGJj6mt7WjQrzAlcBRHVGGtnxvv+OTGVLXtUpRWGD3e5dnxXkDC9uJR7MIFNmdpEbSz+/odu9anShRGNbLgCtNQEyWxVin968McYHxO2YCzVLgoxEE7vKxs9rT4lFWbygL5+b/25dCaVO8XO2N1EvHT6IjabSFD4Rz5ht6DYgw+uxtWZn53gCjjb6h9iHwM+91gItYz85Jwi9/vsRQxVMrTms6CWyPcUJJWIwhWwwJXY7YWU6ScJs9jORif0d2NQBHGGf6ynpNMxO8/gMgwfiO+8zSch9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr6Hu+XIhMXZhfpvUZ3dlh1Rrs3bYziUTbV9Nv7mIAI=;
 b=VZ20FPU2tv3JZCJdRilwn/jabA6+wMUGd0C2BiHMiXFQQTprZ1fcOS2aMZBzJx74EZiQBLL5mc2trd/Ygx7I7Ni6BFTQ4TlnEJYiHtE7ys3ZPy5nUQfSRt4UsDLcrcckLeYy+hSiT88RZsdrLR9w+iouiqBlEYhHGIZ7vYqx+cnlzBaLtxo0OcuZeR5sTGRc8HoE7hZ41XBETCXeMuXwTB+ZpVileHNknu5rYbIy/Shr78/W45WrOTWKWbrsAegkUXyHjJ3xxW7N2R7Fd6ZPjdBZcSzo7SknfWNwyPhRccMO8RgvY2a8YtztZ1vKkkjXJthni7SDus2mgxk4CT1xlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 22:21:02 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1%5]) with mapi id 15.20.6433.018; Mon, 29 May 2023
 22:21:02 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC v1 0/3] HID: nvidia-shield: More functionality on top of initial driver
Date:   Mon, 29 May 2023 15:20:49 -0700
Message-Id: <20230529222052.68913-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: d49755b5-acb4-4b61-d377-08db6092fcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqLg/fcXigGzT+dUWOult6KjgVFe2tFHqk//AHJQUQ5ylutN/NCdU1B5PNslmTOlAMkGp2gRL5w2K9TtUZAXzF3kf6/H47HZjJXZHFYlk4vPHsKmi6PXoAEr3kjhVWzH/515uwop180nfHCpf0WA87HWsVqdj+xP7JSyOwCcsYHZ7AMChXn0L/n0Xo9MKTZs9mp/cJD++LeVuHeKp6StCTWtCxld8MNk76uwWJFTJAicMCggABa9mWH5fXf0IcJCpHU5uXV6pHQcJEfQEjaJ9niZ95Dll/Vi7a0GZJtzHD7y9H9fteJjIL9iY+pfnqKF0O3fqjljH1CNtmOxrkxagojWNU107zr6vTTtk5puc0bBbPle80B2FI14cNTRAP8GmqBsEaZm10o0JClLqPcQummuevYx1Nt64CAZnRmtIJgdfqDO8Fgbf6T2G4AcaWFe5T2ejLoddDvUoeEUhGVPW8CGk0C0Ie3Z/Rb9b943Zy+OF8gQLkYS/hAHYvpOppnQaR6urnk20UIYuhxhxIJ+1XlKFfPKPJeHEgnad5PuwLsnLWv6jrT9wbZIKUiCdX3H84mOAEHqP1ASJEDd936cJeQiMMA7c5rHh2ejza+AJwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(6506007)(6512007)(4744005)(186003)(2906002)(2616005)(110136005)(478600001)(26005)(1076003)(83380400001)(8676002)(41300700001)(38100700002)(8936002)(6486002)(966005)(86362001)(6666004)(316002)(66946007)(5660300002)(66476007)(66556008)(36756003)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gez0mq2wH3HbHPdn7BRN6QOZIYVYuOa6MbVkpmxUeyfxCrrb5ifYtHs0DQwl?=
 =?us-ascii?Q?XMh0piiF+JddhaCCP/U7pba5B5wVUCqGfG7EBJ264xdmY6GKmoGT6Ig8Rv5e?=
 =?us-ascii?Q?za5O31IW2LzE/mcJXKAhMTK+dItCBYoY1jqNP3bZs1TsRS/mMcJW9mocFbaO?=
 =?us-ascii?Q?bYyjhYCEyMCizNEzPpQmKMi5mMpb2s9cwcuBGicj+YYaHf/8QHHyfQqIlqh1?=
 =?us-ascii?Q?N9ebn0m2+GHqHWHHiVFJH8+QcxAzzt5ocgsbXR9ZABff0TnTiAnLeqZfKNNx?=
 =?us-ascii?Q?0RK/yR3aEI12B84bTlks2s/P9iak5uxhlU7HV48OVrjEM4h+UofMQ/pdTk4g?=
 =?us-ascii?Q?+eTG6HPEdWvQnYsOPAjJrKHASoNYtKmeBTT3JTZBW9xqoyS3uRHq3/toRthe?=
 =?us-ascii?Q?QGZB/mDZE2nwNqvbQWku++j3VxY3SaRJlUjbwW9upFzysRMl/u57+n2ayHqg?=
 =?us-ascii?Q?2eUzSCpS9vPQWhi0lCaqcnPxo5DtH9uXJ8yIPWpNbtZw4mnZ7qnFnrH86XCc?=
 =?us-ascii?Q?vYazZsg75G4I9EQy+d45V0jg8TDgS4Ht7dhQ/WU3eN6dQCa3QblY1acBPgvY?=
 =?us-ascii?Q?oqfw1T2vV0+0S44NYqJXhOkeGLqCx0LC0fiKXd5096UDFNjZVrgTgvTgYRW6?=
 =?us-ascii?Q?34hvEoxvlOYn+iRAQhyUsRV98vNwfitEPukhEPobh/5rJmLTWwq4mGSvsP+d?=
 =?us-ascii?Q?QCuWb/A6HeZMCuhtZ2j2aSc9HTM734M+rZIQ4bMKL2HJb61X+KQMYaTOIvxj?=
 =?us-ascii?Q?2DRUlrzAJ1wmZPPJpmhRvD+INOlAMIfBhRk4xr80b7cEcOlUm/biNmZPeNC2?=
 =?us-ascii?Q?oLsCvRT9EFiQ3JPiYu3XokzuFgBiiQM7Msv+IyRjKRyRCHJ5p42YFwGtjpin?=
 =?us-ascii?Q?fIvieZJlDKWIAL+KrB9lx/1XLfsmZc80JQS1Rnt/KXQ22HhomSh8OnTpw9qF?=
 =?us-ascii?Q?EfdlrblWaH8RoLZAuaNo073bHuhNlskWbiyx1FbM8G7ekQgkgoXuUWrLWRup?=
 =?us-ascii?Q?fT7DNKU8ZKbU5lqtGdte0Dyvib+uaGMjflPYYkot0Pw3Fd9VFbS/wlL0hGhp?=
 =?us-ascii?Q?vo5jO2o0jK6/zCu0OaSYgODZ0FaWy3DqCiBEDWaZB1s+j84Yl4yVE/Bz4wt5?=
 =?us-ascii?Q?a1ymx6bbePxyjpf19t0f7p+Yn15PaNqJ/TmatTJyprdvyQR54Rtn35Z60ptF?=
 =?us-ascii?Q?0Fcv5KV7mnO1v8hrMzRtq2wtMEfzyEMXGoS3ABXtI+wYAI+D9BtpUKrUrPKv?=
 =?us-ascii?Q?iCUk/t93nQNVjLJTzp9Md15Ta4kDncecFg2wNrfGxz89e8ng002P+Trpempv?=
 =?us-ascii?Q?ofjBs+UF49jt2KAWN/XWV9/ym2pKgl8SCq7kfaPbxKqlMEOv5MRrevtSmCbY?=
 =?us-ascii?Q?dGVSH1f+tPbKH7zJHPhIa5dSt0MzOlBrHq2Nrh0b95bD07ysEFDdVLn2CoyY?=
 =?us-ascii?Q?qYGNT03jHSOOZueS2Prh7ootc8uAITI4d/azKIpAxcdpb5J2cy3x+rW/S+4x?=
 =?us-ascii?Q?tmJgUTEAgqq+142b/WeG68ieRyhhoKoeI52dC8kcZA5fnWV1vNpwa2vfDPr5?=
 =?us-ascii?Q?HjFODXttXrGpGjAuu/xsYFepG08JtVNNygNpk6rHhfP3sdDu5uyy+c8RCVvk?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49755b5-acb4-4b61-d377-08db6092fcac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 22:21:02.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJM7lPZzn5mFw67SIWRx1h380rc9f7xTfuh0s4u9iHQrLpXBtCA0Pysra5QvAhi8zCpEBLLdXbUDM8wPs96Sng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces more functionality on top of the initial
nvidia-shield HID driver sent to the linux-input mailing list. The android
media buttons, capacitive slider, and led on the Thunderstrike controller
are now supported. If possible, would appreciate an acknowledgment of the
initial driver patch or more feedback if needed.

Link: https://lore.kernel.org/linux-input/20230418203747.24000-1-rrameshbabu@nvidia.com/

Rahul Rameshbabu (3):
  HID: nvidia-shield: Add mappings for consumer HID USAGE buttons
  HID: nvidia-shield: Support LED functionality for Thunderstrike
  HID: nvidia-shield: Remove space prefix from label in
    shield_haptics_create

 drivers/hid/hid-nvidia-shield.c | 173 ++++++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 11 deletions(-)

-- 
2.38.4

