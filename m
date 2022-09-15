Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF75B92F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIODOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIODN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:13:56 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013012.outbound.protection.outlook.com [52.101.64.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A7915C2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqJUmr5EveBuqxj4W8FolgkpbOuhFekfSAq7PuHvemCwAQCnMF1aKk8OqNnobE/ALtatZSf+pirQNmWtsknVeJVugJrwaNqX0EwD8yuqj0NwgmYbQuiL4kPDKSUBeCB0jjFV2XXZFiDs6ovIdzDm/TxgrmBAHJ9gCg7b47YaWjvBlZnbHgxTjvrreIhw/Xw7hm0YyA55jSYxZz0hX1EicSpW54ZpPSZe5DpTkJAzQ65LN7iZxmLnYa3RsN8O6okYz6skM2OvSjnEUEhKo1OGXh5hd7FtxlBWsBcgyABrQ2aZRUSLF08K79nJysttJFvvtc5CA1BCZt3vGhCdOZ4ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj62dkRHlvu8fsBaPBgI8dPDVvbwgRLdW/cC86DSn2s=;
 b=XLq4tdV1Kp4hEpMWxOhNzmVTl2KF29hZc1Vmy/B1Cv1X0bz12ZN2OCOX+Bdz2VGk6zX26ZkQMsZX+GyCrWv7my9g7ftU8bqJA5BJ+oilqfpe+hHXOoXutqt5qz3JsEvRkai1PtY8U0PgD6OdccLjRhH56zIMP6m3JBH1UVZeTmfstwtgQ5hN9O88SC7dK/p23DRm+JvaH7IVXhCr0Q7e0n32Ec71eBvkxGqOHQZcDihRvuSpRSDvVnQRrxIwNa761HXNhEiVZlvOYY0Cs+3ZS3rij5KRWvaKF4WwSfwBE8ToZHRSztoKStrM78DGeYaHgfDSUuz1ObbtOPKTE91zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj62dkRHlvu8fsBaPBgI8dPDVvbwgRLdW/cC86DSn2s=;
 b=eDym8w/W52nJBQNMwz6WBUZSkKmiVaPxc/o1xMaf1NAmIMAqb154i1estIyX1y258H7MQeLJf9dABLnavKIEkr4vM47RdOv0TpKRQCgWzQDTyhvShKTsk3Y6KpYYD9JdqSxGGbRJ0vdo9JhMF1/9J9q/B3NTDYQJFUOoB9skH/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BYAPR05MB5848.namprd05.prod.outlook.com (2603:10b6:a03:d1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4; Thu, 15 Sep
 2022 03:13:50 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::a8ee:57cf:b2f1:b818]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::a8ee:57cf:b2f1:b818%5]) with mapi id 15.20.5612.011; Thu, 15 Sep 2022
 03:13:50 +0000
From:   vdasa@vmware.com
To:     gregkh@linuxfoundation.org, Pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bryantan@vmware.com
Cc:     Vishnu Dasa <vdasa@vmware.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] MAINTAINERS: Add header files under VMWARE VMCI DRIVER
Date:   Wed, 14 Sep 2022 20:13:21 -0700
Message-Id: <20220915031321.1121-1-vdasa@vmware.com>
X-Mailer: git-send-email 2.35.1
Reply-To: vdasa@vmware.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To BYAPR05MB3960.namprd05.prod.outlook.com
 (2603:10b6:a02:88::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB3960:EE_|BYAPR05MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4f78c1-5831-4f80-e101-08da96c84f80
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zjmx9duK5lP6tcEcFIUBLFLamDTNWZ83jM4WgnkMx3nLUxLXImCDjLVrBX5e9zn3HaIIw1RSTEPY2rWD+RKUoqW+Eee5LlqeDyqRQl7o2x2M6WgVNA+2pr89M/FltjwYgPmV1XvlYktceiGMYEliqyBRwUhKAF0BiiPO+cmOsE6wtclX08Nr/Lg3k4GSrcXX49wXZdK0u/mXi5thaVlu/QVHPeWGU1JZOxqh/q5mUoOQgvX9Z1YgvxfTGFDkB4pceDM8ZFDdYbSL1uR17Dm+ZC9XnkT4O1J/BTV18K0H54Aa1gQ6hWw4SnxlnPfRCAeL2Iw07acBS2smNzvgTwLgDaSrZkMgt1A4VaBLt+X4YWl7SjG3KVrOZdS74wDP3k2wlCIXX9J+cpFD/wTrAG677ddXBxL+AscMy153Xb22JUub9R0HiPWkS6lXbC+Ois3o5chL3c1pZgly6iKmfzEQCavYEt43dH6vZnz5RXkUsEdfW6F+SQCUtQDUwQveKWrbUSEXYb+N4oflI2lFG4ziSzkvNbhBGbUXTr887lK8djwRclpuogNAZtk68SAcsceu8HRhnQAltHcXdC9z3wIBYtekiv0XJjntZ10YXwJYS1I/Bwne4R5yrw2oK0yr9Cq6m/GeEDmSKbPZZ7OnvijdZv2u7/qSrX6/MKZVD6dVqb4GOavFU4rk82CRaM/OizatAlkfN+CaNcUEBR7HvByCQBlVLXBvI2jWjiLGTm5bHTDf/QkZBZKY0H1hETYXcFLtlbc1Po71uW+JoaA3YmuFjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36756003)(1076003)(86362001)(2616005)(4744005)(38350700002)(38100700002)(2906002)(5660300002)(9686003)(26005)(6486002)(6666004)(8676002)(54906003)(316002)(186003)(52116002)(66946007)(478600001)(8936002)(66476007)(66556008)(4326008)(6512007)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4aSuA0hVXueaU6BRgf807wVE0pOdSBxfAoo71HkqJeg2rMRAe6WQ83Aj53u?=
 =?us-ascii?Q?KVsbBV1I3eHZnpvW49aKCRiwxD5pMuzmIIYPyBAEbWeSleoTv0/S/a9Yh7b1?=
 =?us-ascii?Q?oKCfqFHwhz+biS4aQ/rGmfs/3FXqDXFjW6mjGF5Ve0vGMskiFukSNtDlNrHw?=
 =?us-ascii?Q?p6aPvBu+nCXooAFxUBj3nWEibAGXibmNm64EjbNaJvSdoj7PKMjYUiI3jgpG?=
 =?us-ascii?Q?6sU9jLnLMQ6VTEbMgJujVmwKgi2YtDDyudQw6phVaiCOqSeB8m4LDWExeRNi?=
 =?us-ascii?Q?RZfCqb1q6w0F87bAYWY14NkFLpjQ4XVeEtZO54j8YZTiHIERTyBDQ2pINNYC?=
 =?us-ascii?Q?G5OPq+zxvcnoWHR4eGBIs6Zo3f1fzvvVzUU4Uae/8VzjaHdHy3wxdauFgywi?=
 =?us-ascii?Q?AAKtcZ6O1pBxW6shu62HlgQbndnyYNEmmX5n+FTHYz9HajyO1cHypf4sLSsk?=
 =?us-ascii?Q?3iNcD4JMY8OKfSYtDMJeDtnobjlYz1IUXKldoKXfq7rvfRHcJeoEn7gxy3eN?=
 =?us-ascii?Q?b7m3ZGZT8ur6Joaojfs4B1qyQXwmnmmnSYcWG07jfrO7cTZszZSf4GRglTJX?=
 =?us-ascii?Q?4fpEwqr5MMaeCf9dqTCm8vdsrNdsLHAQZRSIpLlkyBqbBo73JPumvgYe3eHn?=
 =?us-ascii?Q?BmTKKRKEs4x91SGp+6ZZ5eLA8m3Tu1hX4WbMSTV03y/8lMFUyyFxMfl8oyxh?=
 =?us-ascii?Q?BUx7JMeYsQ/50G8QBCfzqqeRKxPhLskwkXRDr+UG2r9egwdGQ/nSkBZVSiR6?=
 =?us-ascii?Q?AHrTDXr350yCeoQtLt7iCaVedGZ4IU86W14CNMT2x0CBXCxf/iCg3rYEWYQX?=
 =?us-ascii?Q?I9RauMtaqSE7CyjmR5gpVlZcL930YVu6pZhjky1ZelN5pBP7SkUjsb3bmS+x?=
 =?us-ascii?Q?UMkh0c+LeCyU/b3o47ZHiSwEh/4WjS6Tz3lc7OOwstJoBlQWqLEpk0VsdIhh?=
 =?us-ascii?Q?LkxVeuHQcnUTnt5ZP7kac3/KG7TrKuUUMjxuvB7EEKzlgqUH94nOyS12Dvtn?=
 =?us-ascii?Q?ml/LH6q8rG064PArcC/iTfAUQ5ePMPC/KVM3c8w2qoYTUDyD/locLzN1NPaN?=
 =?us-ascii?Q?kY54rKVUkF0JwMWlzU01Dyi0ygiaCz3Tw69SCAU9ewxTCdQmwRPuy+rGFwLk?=
 =?us-ascii?Q?DWyla/99Cc2QkCKrVWqRZ0CTq8uqJ1qKlG8YSeE99TJAdSfViqcvTq3bfbIf?=
 =?us-ascii?Q?giLAaCK+nXKlffOCo5lDYnatDUfBta+l9dKCazNpaAfdAnmSM4CI6RY3PY5j?=
 =?us-ascii?Q?oGSoT5ZwyXl+UKm2lzS+ElLiwADJ/XjwVRwFGqVtFP8mrhMs6XbX+5hsi2Xl?=
 =?us-ascii?Q?K9CW5dkVLCdoH1kv56y5hxamPsJf1YITfnGnUmWlHirKvzEAV8zx9LWDgt4T?=
 =?us-ascii?Q?HFDGwNd/B0QxyafYW9Zi/azA8PFxg2o36UrEaEslsPWpyTBk8FwrANCb6kdF?=
 =?us-ascii?Q?FO/htx3EkWA+1A4pxHdIBlYPANzDW4fP6VdRqbpmC7ZcJS3XpcVVhQpQytWm?=
 =?us-ascii?Q?bZiNNUmU5CozcgDV2/z5HaofYfTGtGtm614R40vFLQhS8OfMXwx/oru2wwWt?=
 =?us-ascii?Q?xKKmRStEmDEfA+5LAJH6rkqXZs3YJK6Vqat8rELZ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5848
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishnu Dasa <vdasa@vmware.com>

Add include/linux/vmw_vmci* files under VMWARE VMCI DRIVER.

Acked-by: Bryan Tan <bryantan@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9475aa701a3f..7c6f7fbba31a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21860,6 +21860,7 @@ R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/misc/vmw_vmci/
+F:	include/linux/vmw_vmci*
 
 VMWARE VMMOUSE SUBDRIVER
 M:	Zack Rusin <zackr@vmware.com>
-- 
2.35.1

