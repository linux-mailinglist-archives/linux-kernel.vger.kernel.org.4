Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044C46E6D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjDRUiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDRUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:38:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD96D9750;
        Tue, 18 Apr 2023 13:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n31LGTLI1HI7aQ3WePvB485p6DbP/yH6HGsdqnUNEC5vpksQPkK1R5XwNDw+p3N7umy8k0haJ7yH1gMRZN9TlgaiMJ6ucbgnr4ibJUU92k6Mu/EHOk3Sr8nusLL8rbAukkH4wmWSoPyJ43+uiBFxPg9iM5CqtKTBSk8TJ6jEItZxOGyx7TOzSacP9IC7rOiZGfwWx3fO5L+PXMKMNDYdZkGod6ZKegYCcAB4aEYm4nAfFYA+eMGIRfa3pQ9cQuS3wT3TeZWPg64vzTOcbdmYRTEeOt9vn8AEaovds1nvLiF+8sAhklxNe/qtBR/aGspgaLt4uDKex2+vJ8oTf1TSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1IV+630uA8ZmyLZgSNxBXpg99Ftvy/6cWq5+DRYkfg=;
 b=ajJBzWdjTzlltFzL9zWfWBfRIpdJcZltn2Sg2f3a0b9Va4eelGo9OMnc80OisKK+FTINvVq4FaU+Wyy9uKaxnE+KuaBXXpw/DG7FWREeHdeF82Xa1oRedTut8AMvMhIBxjmDDBeMNHY6xfegi0C35+2PrnBkm9kw15wZDRhALi/52FhX1EVijxv27I4sNbvATlbRClaeb3INO8h/pImT9KfcLKpu6Q/OgAF1m7mkEybG9Z2H8eJSMAalaEy0y3CXovfc3MF14q37ll01CebR16Pp7bmHCNH56mw4kCR2VXmY4JA4Xexej4AWCWQD9g3W9ld9F7xg7fPz/UhWedQIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1IV+630uA8ZmyLZgSNxBXpg99Ftvy/6cWq5+DRYkfg=;
 b=U9N7BiDW1DT9fQ+nA1mpxAta80e7AXxC7U3JiGtV6zKmf6TWq18Mh07Vqz8xWBUBGUTtb8FE3O4jSjfWOkFNc7vyLMI0BYDfYZ6+oWfSzv1hPgpVBjmn5pxgt38aWXIs3A/kLJcqjLFr2JRyfM5Rrb5E2oV8ypTyuRXco9Tsx6wndb9Qf4jQwx2CcyHHGAoUF0K6mP7YUXJKX8zAiyNbSBMvBh9FdhF4TMNDKYROpxKPV2xPPTnF8rTw0Q6egaUxIobGkq1+ZplqgW2HMKn2Jy288jQpalsgZOjf+Wc2D+7vQQE0fwzq5QFu4f5Xfh4sV6ya3191SZeDE/E2mO879Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 20:37:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 20:37:58 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v4 0/1] HID: nvidia-shield
Date:   Tue, 18 Apr 2023 13:37:46 -0700
Message-Id: <20230418203747.24000-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc61667-a920-4407-6e37-08db404ccbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rs3MCluNTc7okDYuwx6wA6xmoo/XdAB3DwAFOlFuvoSG7v+8df3kFlCRndj9aCTR7bC2kU/pquuL9gVjTz83nVH7JqKeZt7te/9ezrUOe/d4wHGh5ZaFxHLTk/aEsNT9uVTWayeq6MNeTeknbzT/RHE+RGUzt1Xh1Iew7RFY55aoY+uMBMYkU/90fadsULuGf4JwEzqzY9qEcYfRz91RYABf08LAf88KTp4dNPIElHPFTKxtIG7ZL0kXJlRspKpbPEA+dSpgThskH+8pAbNP7vsVOcDMDCnXIcZHS56Wk/OEeMAryUNUNkBkFeCwy6PF0eM73T6DVHh/Ju7UXZbU1dQXlz1WHUk6gYOp5LUmuseL+iREao+SXiZFqeVYIGSf4CaMC8PFOiONjPaTce6A+lXPJYwoFQe/7qnCWRwtGx37ylEQrLYUUWdmBksYhicermcqJcmQNZ8HJiXh5iPDUstV1gEhjh1gJwwFywSlCshyZTK2ePT3v6Q/Rkx2Xmyd6rLXnbF7i8OUsO8d81itOQRzntDyM2TfABio8/qGActFWF0d9nVnyOzJgDMnYYlxLt1RtoNQjiFa292l5wSd+e+5OWHSfT0sqf19h41ZpOpqluhiOEkSRAnNZAHtjpma
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(36756003)(86362001)(2906002)(6486002)(2616005)(6666004)(186003)(107886003)(6512007)(26005)(6506007)(966005)(1076003)(316002)(4326008)(66946007)(478600001)(66556008)(66476007)(41300700001)(38100700002)(110136005)(54906003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgvZVzg16O4EOrD45r/jcGuQnKvjSoaoXpsmvU9fMND9DwDMdV6POlyMa2h6?=
 =?us-ascii?Q?Cw76+oKVwZqVTgCScRHH4q6jwlLvukIrDM6C8hOhdICq+ffThGwWUN5MNQ9/?=
 =?us-ascii?Q?PgFGn2WvgqMk/7UnNh/y84K+M1WBJ0K/rADE4VmwG+/CW6eekxiRXl9k2dZK?=
 =?us-ascii?Q?KfeDqA27W6svPjG1QlDQublHfCB3QOOmAcYGYuWZBoCfgVEqZ8a5nuSayLku?=
 =?us-ascii?Q?IZdkpcCUAA7sK6sBm1ICVAeGhmHHOw3/0XJ6a8TR6q+IYL1RF+qUdDiIDHOJ?=
 =?us-ascii?Q?Tslee+HJd3BfEbUu9AMddXA0+QE0K3qg0I0D69/ZkSg1ukT3WGPyXOw/DwXw?=
 =?us-ascii?Q?m+5XeXLnmVg21gyBAVAFnxlMg3iyJiMM7gOdFm9Pup6CvK+lWdiTc4AjbUu0?=
 =?us-ascii?Q?OChCKw9lmWtlEebNi163fA+IP06HITbX8cggFVDaeqTb+gFWrptb9D7051Gb?=
 =?us-ascii?Q?MbAXMogWq+vp9PzJ1PCgtX06w1Xss46b8/XpbA1j7fS6jRmWv831AygV+MfD?=
 =?us-ascii?Q?pVFMEIu69dFj5t3dFjL6spx5Dc6QRNVyj2b/0jHz0varsKF/QzGiHblvYzYz?=
 =?us-ascii?Q?D8Ui/uMQqiAWHjnnsWS3Ocz70Xw3hufZl+otoN6jMpWgXxGcKIZ3A0MdfiNk?=
 =?us-ascii?Q?ZBALi+AlcTazscQA/Ye1iB2SVPzo1TOhMIDm0/7B1ivpGa8CsF7t1gX7CZjv?=
 =?us-ascii?Q?TTkMoPX3p+8mxRE8ysqNK9Vam9A1+z12HZ14TW48i/ZYzhOgl5xKszbtg/ve?=
 =?us-ascii?Q?TIDqSWgeVUZSBGml5TGdAJZVhvBuORTltj4OURCEQ68oYmqnkoV0R4qefale?=
 =?us-ascii?Q?hfwRA9oOxeRKbE83mrnwxhdiU8Gf9zlofQQJ30syKvpBPdjwvjw59FVyCZNu?=
 =?us-ascii?Q?YYsGSmfNeqfnaAQ3sarY8Wod8kT/7jbhPIJ2bmD5JgCg1kO/YtGcNA/cCEX4?=
 =?us-ascii?Q?FUDfm7hH5bLTDsZ5r0MM2iZXX+gM0O60r+DpRcDDNq4jIGW5j8QH5RisXZVL?=
 =?us-ascii?Q?ZTWWd4e/n2RvVgODwkbpfmq/mm2mN2UoT598gOKSR3TuC1WIJZje3viqLoeG?=
 =?us-ascii?Q?eeRfDVum92P4DoOTuBA2VsIHQ2WCgQval/MxoMkpXHUbNAsROMwi9q19ELmu?=
 =?us-ascii?Q?SKMmqALTJtT3TM7nT/q7jaAEi1cToE6nZB6sDmujH9EyLpA6F5H6lkaqT7Av?=
 =?us-ascii?Q?Ckxu79+SJ57aDktxuit8mqvqmW/ahgARS7pcddfzxLMiU1UtsOL3uVmbqXXy?=
 =?us-ascii?Q?peCDQGnIQqAn2HBqXoldvck/t3RM5qnpH6OPjPGKL4veIZC0+05x947kcMot?=
 =?us-ascii?Q?mT1V2M8Uk0ic+1b82mDsTJ+PVWM3j4qTqt+0NaKhEEmbjbNW5B7MeK8K2kiS?=
 =?us-ascii?Q?3dnz+BGPXsERrJUYU0WQh+O4X1GrmC/EyL5yPfjRvPu+4mivfxtR/31mA3I4?=
 =?us-ascii?Q?XX/VjlE5kjCCKILZnRaaynnzhWH1gGY/fde2lk+eAf78d8hVdVRnS54J962k?=
 =?us-ascii?Q?bJV/rgUaaIuB6VrEKLU54Ve+6tA0eWx9A3vqNReaUhXkT1dNgTi9EpLDr+C+?=
 =?us-ascii?Q?1Fv4Z4JNC05vksDYsVEeHPGsDn4IWfGdZooiOh8E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc61667-a920-4407-6e37-08db404ccbd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 20:37:58.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKdZEle9qzkLbTkvcktKg6Sdh+Btcptjz9/2eilactLeHVO9uj2tyEpLou9I1NJN4XH6yIzIv8Zj0mMkSVk6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Link: https://lore.kernel.org/linux-input/20230417182909.33833-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230410170840.16119-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/linux-input/20230401032150.7424-1-rrameshbabu@nvidia.com/
-- 
2.38.4

