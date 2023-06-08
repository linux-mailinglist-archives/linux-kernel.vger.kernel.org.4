Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9A7282CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjFHOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjFHOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:35:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14632715;
        Thu,  8 Jun 2023 07:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNcmzhO7WHmE4RFYXla02QZwrOfGjfWf/EZef2N0SmAtN/m83T3d8xXUTpW4F6Wf4oDpJ5pPBWEzJKDyJuf4V9J+il6Y9mss5+J6+35n6xKAXjZ8Az+sZHkqyOcw0RcIYMwhMDI4jF/Jd2R8R3sXO1Qzzur0VS07LzQLpJcFX7kM00Wc21HJZSH1+/gONeRe1PoGtkN+HQx+0IbgrAwrTlhhrlb8/QJrp9YmAdeiQ+mO7DHfaI7TFfV6nH50TUJOcXxh6dNtUfvBlflUQ4PEixmiKXTGp/DKwGcq7+vb236azR0JVn4m9A1GyxO84qaoGhd98D/Pf2LUjCEUDVMr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtfvvgxPEG7BaVELfaXR3f8nzcuHfTC9IQq4mkqvA9c=;
 b=NebLlrLlqRiKX7mKszIN2SGu95TPGJSZB7yUl3ot09cIedbh2jqCI9DVBYnZww337YSjbCKYdA86WQk/2c7BYTXJvprDSgQttY9Cm6QV1K23sEfAqT5ECds3Yl00SrIaWgYaOp7ocmlMhCvJqP4kCvmL406GSP8RDQsMVKl391VRgs4FE7wqaciXTWrh3bF07uQtCKe7zEE55wgQNr4MGEWNxEZNCQOW3YIhMu24xgj7DwRkkS8tnx9fyns1j+6avln2PdwHtARxfi4cwwnK+Kr7NqdlAXbpMWu8gjoarY0ZrcVs9zh3ms85M5axRkbHhnzYUqn1MqARlPOKF6Egtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtfvvgxPEG7BaVELfaXR3f8nzcuHfTC9IQq4mkqvA9c=;
 b=ry8LlE1M1V9IdG9c25y7X32b5752r3b5rnpH4gn5Tk4us4iO/klUz9K7t5rzk88zF2fU9vkdk8hKOxrXR8C6MQcq49tLCEtcFmqi2vsysKYCzNDIfPIHqQDq+S8ysFG90y3YuA1Ez6FJ64egecgvxOhLrR5Dx4lSnaue+YkCm3bikLK1qU1tSQ2C2pZx4SbnUTSHvcK3YGp3pRHlsotfK4/ryT7YzjwD3M20lyy2jTQMuOzrIVIw7qiAxL+xAjRoUNzLXLaOac5njw5zn+rNVhk6GQl9y372WgWFJE/rlDY8ccaA/t/OD+TY62Ii1aD4EeLXoEJZM77nsR+r0qHP3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 14:35:03 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 14:35:03 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RESEND v4 0/1] HID: nvidia-shield
Date:   Thu,  8 Jun 2023 07:34:49 -0700
Message-Id: <20230608143450.12283-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:a03:114::31) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3ae444-b20a-4b1c-ccf9-08db682d8bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjiTpIXm2ZyVRbFZ7GkzvfN56OnB79x5EyX8WMlvPzsZCodgA70I1XzMRxOzCXI4b4zZeSSwfchf/EjpOz/T9BOqlPIZtCSOuRa4vmUnlfWSCsmS6LiU3+fAvl/DDxvXhjX39yQjYeRQR2Xfdk+HEIiJai+sY+VY0U7xMH9kO16B300XGm/BjIfcQQs9aJD8CzbBPqVhmtpDgu2juYdyavyScvZBeBz6P7DVKzEmp5boiaPFfM9BFg7fR3zpxgU0Ok8wHWypQiFOaUhxJL5TTOX2h1Y8AnDAr76XmgWeeCkQzsg/V/l4luk8dL3H4jFoOCCdwLvr0NYKVM4D43E5vw+O1pg9Kg119kJsLnaaE4lm9/yVUJ92XSsGLtXNGytbNbvootyYjSPlJMHAxvmenHSFpYxcXHLVUY8MO9LGp0nhHFE7cc4+5/ptBn6zNc2ZjbwyhlhX+4A0OOaRxuboaWxmTbBqSY0xnWIuW62k7AsQKx6QGzkLM9JH5FLFlK0okGobJBe824wmRzRVcFqjai9ZMuR71G/najjWS2LHcNNz7P1M1OGdwiQ7i6u8DgCO3vYqeQcoiWTRWIRBSxkaDg8b441Txat5oBMoDsklYU8/2W66EEiSp7ZYVP/S/DDh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(8676002)(2906002)(316002)(5660300002)(66946007)(66476007)(4326008)(66556008)(8936002)(41300700001)(110136005)(54906003)(966005)(6486002)(6666004)(6506007)(6512007)(26005)(1076003)(36756003)(186003)(107886003)(2616005)(478600001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJPeFacipMGqonkT0Lf+IBlgqrsGlKgy/ZlgZU460UVCf8GCT1A30GIKg26g?=
 =?us-ascii?Q?i/vx7yG82Jkn42Qr9tbYIJrY+ya36SKDb6rZnC9RdWLSS8gDaK7vXKFd3Fq8?=
 =?us-ascii?Q?h3GNFycrb3n3v9VY9YIil+0WCXl9t6VKeVf1bUmalEz+6pHS/jXkzTP0OzxG?=
 =?us-ascii?Q?AnFqim8bvaUZwOu7YSKKs8ilbgOpmZMX8pyuj+iTKan+fS1bJP1Hc3W0k73U?=
 =?us-ascii?Q?aGGOV++QqwLsUednllhXb8ZII1MUj5NPZQMCyZA3EJVgrTdpFNN7hbTO4XnJ?=
 =?us-ascii?Q?FN2FDvrzMvVCzxRPaHPU2TlY6G+C6hSottdSVGv9oq6/Da3fs2dZIhMzFm9h?=
 =?us-ascii?Q?c56cn1hqoezJlwhwXP9iNy4QFYQyBH0+M82Xv2Eq7IQ0CjCrnM9zAnaORtwB?=
 =?us-ascii?Q?cIfiHwMRXfuh/j72WJQtLPeD3okZH74WTeCwMd2DYbjMv+sise+muUfg29ln?=
 =?us-ascii?Q?3BGB/Bd56rIWruzaG5jeHRIHaS7dwgRFTIKBChxjeBSv76cdK2kgZXvKFG+c?=
 =?us-ascii?Q?FPx/4qVJ66PyIkh6k6CebhWPcqNZ6I8mox06AmihTeEsYtbAxS3agFOY5zIE?=
 =?us-ascii?Q?I4C2dBAMWFR1d8R42A37+scj4l+2tyw1TFEw0MlhXc+JT148TTzvO+M88vmS?=
 =?us-ascii?Q?GuE6U2YlHVB1I/6wV2H9gQ5JDebPJI6ZpHiF4fhkreq/SXqd8uofuug4Izvc?=
 =?us-ascii?Q?2CllONS2B3Uhk78AkHGC+tCPNJ2lNeXIWtQJ+SwHNjegCMwPjf6PNzJ18Eau?=
 =?us-ascii?Q?fOvJZ/T4T7pCCwsv0nYMiG2U4r4/rzFFTNA82btut/aVQTwf+7Mlb0NbLaEg?=
 =?us-ascii?Q?ZjysVbKKE3XZwHpHThaOXyoZ2uTbYJCQWSLtHUFbYPsgEta7Bk1m+4TGw2FJ?=
 =?us-ascii?Q?H5pojq77X7l/XR7DtTQ0zvkyNJGvQE/aGuGcw+pIGohBnvRs4wsnDjQu7XYY?=
 =?us-ascii?Q?sNqvCOATBvnNEruBwjB6WD/3H/AO4gymkI71JhuHEmsCsLLUOlguTS0/log2?=
 =?us-ascii?Q?TTMB4im3v+m09j88gdjztGfpjzcbizpfTjBeHkTJnD21v1adxJ4fR+HaAdiN?=
 =?us-ascii?Q?BOuek+YHSYzXN4q82ER/z4zMS06R3YREK5/iuRboAa7hyxtpehGp/gcEtZc3?=
 =?us-ascii?Q?j4n3VjE3mPjUYAJPOS5aB/fTKcA8dREjIlpNv0Z+ExEW55w7d2goLsgokoaA?=
 =?us-ascii?Q?p3Av2F+S4m2xIAhfW3wSBhDx4JiZdjzMuO/cjGN5Yy6cPD3p9o2KcDdtcaKd?=
 =?us-ascii?Q?uSXwK0zfy4XG3z25P4LsyotBzHD+FTptnFdM/BUF4QJTBMAYagcuIU1vnh7a?=
 =?us-ascii?Q?IKuAn0INJm1jf4QQ/nsJsluAw5jBwFCi8zCk7UPH0vVXUsRhIzCy2OOLbTrZ?=
 =?us-ascii?Q?9AWsMIeh9MmyosUdtuGE75jwNB/O/QnVIeCr/eayGZwF6yI2ZI1sW8Z1RHec?=
 =?us-ascii?Q?sj0daIAVV7jIW5NfDK845dIfLVp9+v7nvW1jNw7aauHYJYaukyjCAtVvmiqx?=
 =?us-ascii?Q?Fh1M0TpqpRCwXo3gOkIPM4jv+fnC2vSVcPN8ztR6cA/9Zeo2oaQIgGU0NTcv?=
 =?us-ascii?Q?9caS1Q0hml30hQ36GojbBvJ5BhFhB80oCOb9LpaQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3ae444-b20a-4b1c-ccf9-08db682d8bec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:35:03.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt11iI5JhsuazY34VazZoTH1jUIBW5mO0Qb5Fro2yrCUrznq8T8g62UN3cOwUQbJ0Qevm8zMnfN4Y/tCPR4euQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

Changes:
  v3 -> v4:
     * Follow correct formatting rules for help section in drivers/hid/Kconfig.
     * Refactor configuration names to indicate Kconfig options are for NVIDIA
       devices.
  v2 -> v3:
     * Renamed drivers/hid/hid-shield.c -> drivers/hid/hid-nvidia-shield.c.
     * Added space between braces for terminating element in shield_devices
       array.
  v1 -> v2:
     * Declared thunderstrike_hostcmd_req_work_handler as static.
        Reported-by: kernel test robot <lkp@intel.com>
        Link: https://lore.kernel.org/oe-kbuild-all/202304011342.6Bh3cWhA-lkp@intel.com/
        Link: https://lore.kernel.org/oe-kbuild-all/202304020922.vsngJnBT-lkp@intel.com/

Rahul Rameshbabu (1):
  HID: nvidia-shield: Initial driver implementation with Thunderstrike
    support

 MAINTAINERS                     |   6 +
 drivers/hid/Kconfig             |  18 +
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-ids.h           |   3 +
 drivers/hid/hid-nvidia-shield.c | 587 ++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-nvidia-shield.c

Link: https://lore.kernel.org/linux-input/20230418203747.24000-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230417182909.33833-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230410170840.16119-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230401032150.7424-1-rrameshbabu@nvidia.com/
-- 
2.38.5

