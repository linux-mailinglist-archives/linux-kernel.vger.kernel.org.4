Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B812F6E232C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDNMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDNMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:25:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929BA5F6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2ecKNjB/trDX/PcSFC05e8yi+GAB3OLpkB+Tfld01L+hnCUjKNVsIkNsU8LIcSFl7y32gONhGkAulmjZNAmssrKOWDB3Rwa6Uf6nZV18TOhGpYjk4X5l6o/OXA4/7vE0DDu5Oqoftr9qyI3inUPFxmoqPcToCU52VUbBMzCfurDKjhlO17pyQ4WfsNzVYFJyg3vjPLZXOgT45IgU9zeXEKhqjyDcp3wY6PpiVxbCinLIUYrkM6lAzykKwAWTLKDa/coPPuG3Bln831QXV8QU8NC7Yva9fHsRoxZ65dEInr5KHMdtmdkiPYo9vg93O8GnDG/T4edbDpRGFdkSWnhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuTICPwuneTaxoYqDteN+j05EhlXC+fbq/tgoHFAVI8=;
 b=PatIKjNRll6MacqQjLhmC26FxF5DoA0Fd+9DnEBg4KVBQ2sbUyDxGWlca/qeZHRuC1KWZZCbtUeRYhz3S5X4X4n4aC1lGYAmVIJcA7oWTwTUpbYnOUQN6mm7dryPNn7UEFD2ULQvzTI4scuWG3+yLAP6ov8j5A+oczQdXV9kySaEj7FMG6itQeurVMu/36aAu0zSO5mFPr6lubWaw4GEWN4wfqxrY/80kjc8jtMxd5n1kjH37Iinw9IPTKdcdU6PDvAAd3PEyt+Qu/RwtoU+Udwd7xyZXNk8bTyau4nsjR6AokvUxAJBz8WbVaX+92TLSNpF3PnaL5U70HDMIBF0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuTICPwuneTaxoYqDteN+j05EhlXC+fbq/tgoHFAVI8=;
 b=Bel24Xkw/69zaC1/RtQv0nfgR9rc7XV15qHituetla7MC1u81bNJw+0eqYYJjAiw1dVmmmX3ziTTiMVQ7Q/KBfXITAT6zgl867azAp/IZjKnX3nr886Mem9WX9/fx1+EpMFihZ493YF36nOS4pvq8GCX20tWRqB+OPyEc/1+NHFK8c0LdOBoR4k06JxWAr5YDhyO7d2zupFk53Z32x+6V7Alx2jhGCCk9+SQ+jaP3Nz128PlcwqsAIknFyns7BgHwkE+xJPMy3HSkDrdNy4KZSwA6FycxeM/HSzC2AKPrmUljVmP3lrP28ERxO20epiLSqWtur/FLLbODLZmuKuqmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 12:25:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 12:25:34 +0000
Date:   Fri, 14 Apr 2023 09:25:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v10 5/5] vfio: update live migration device status
Message-ID: <ZDlGOlGqo2ZHDFm3@nvidia.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-6-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408074224.62608-6-liulongfang@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d94cc8c-0ca6-4efe-de37-08db3ce3580e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pyBODBBN4ay/Q2WObYiI+QIPsMCNfmqp8SDFPnh3tHoB4aNC8On74rzy7aKK+9dlLaVYeyWyyVPBJP6UGUu6rLINqF+o+lMfzGUl+w5UKAVMELS9KIeMaMgRHxYtp0KYTWp/P6+M/TTfr07h0XfpaWN7I8hcoTl5FpCPXCbehJBStmT60Z9lSqDW9VQ4zXZk9LGTuBSLnmOseHU/7puoURCrDLEgiAfWdjz7Lj0dtVRCCd6dgqhVQd2c+1yo6uHV64t4mDHzUWanE2+mdFZR1it/fhCZwor6crZvvXpTGUagQIRjPlusKq39MpdEeQryTVnZXMYqxYjkxAc2QttMvoXIFFM6ramcwMtM1BCms0nx6uuEJeVZTWGpdJP11HZ4qtpv1e70sdBV9S3+A8eiiu96J2ssIU/yh7xQ8uqF9+sXezucE24Kc85d1+8sIROLfYh0uH3k/UjpDRfS+e1EBofeMz3osRcMTSNK7pNv4hmdOXF21rWmcbGVSVfiLgqu4z29Ob0TpU0kL2Q1zsqEMusaN+a+hDdX0veb4c4wI8V68QTo0Fz92xGaVFcLA35
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(4326008)(66946007)(6916009)(316002)(66476007)(66556008)(2616005)(83380400001)(6486002)(478600001)(8676002)(8936002)(41300700001)(38100700002)(6666004)(5660300002)(4744005)(2906002)(6506007)(26005)(186003)(6512007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KPWKUHqL73sWVhfjH4juf89J8h0gqvpEl4ykqHE5/iplDJBn/VmRewQtI58K?=
 =?us-ascii?Q?Jz32lAi8JA+neqSQTzZtng1HpL7YSGLiaynFwZrJp9iMuXICqeH9HEmtCFuV?=
 =?us-ascii?Q?AKgPQkQzoxWA1rhmPxaum98cehdb/iSusaAPxZLTcOzBUdn1Y/Ekj9Dsrw1b?=
 =?us-ascii?Q?x7Lw2qqY1daugpevJxX1T7gRx+0hV019CQCTSE6AEVsLypJ2Lq6fy/Hw0g9L?=
 =?us-ascii?Q?JkIHFpHVD5XXcySyfBf13gOrl2WMo8zd1pIsBoTeP+XRHYY+i/9JhdwjF/hi?=
 =?us-ascii?Q?l0qHgiX0DUeSaro3hOGUTJeaTrWDPzD7qzmF4ecRinF8jr3ExnTc0YlDBDsO?=
 =?us-ascii?Q?5LO+BfaItUt3onDfOVRNe1R4HLFk1lZvKifJ2xAGgi5YsupfKJip3eAMmPOF?=
 =?us-ascii?Q?Zo4le/ct+/dBCN4YL6ag5x8t5chl8hQMWbz+P6E3lrhEjw1Qtzmm64oTp7Gc?=
 =?us-ascii?Q?zN13nSya+2Owvmo3FbvajILOrcIOWU+e9qwrvJpidF0wH3rml/x1JAdkEn28?=
 =?us-ascii?Q?YbGdhmgEP4jBDBzGaVGTnso3SdRtMYZaeJN9r5C+dKWZnMIUhFlwWkey4HeZ?=
 =?us-ascii?Q?XgxCKhsdNzRzjMJKEFjcOj7gNkgpYDGnOgv1Ycv+rK414yDmAMYtouqN94G6?=
 =?us-ascii?Q?nGAJsNAlC+R+71/lDWVdIjqDbgpM4ay2vY3gji6owBWWViVewipZE4j5FWrw?=
 =?us-ascii?Q?wju5H/9TGkxc6poCkHYTZzLY6Nx8xK92xOp8mvhHGZfNyD0UTYAadEqJu0fZ?=
 =?us-ascii?Q?J6jB0eYKLyncDeouBIQ8FlpgZz3nvZJuws8vUg8d9kxtX5VuM42VWCzw3gVy?=
 =?us-ascii?Q?jxccfiiTxwk6lf6+WA7d5hrOHIJ1yc5MXZF7kex3DkwyxxOUt92q/upMvt+s?=
 =?us-ascii?Q?pG8mP1NnR79tsm1hX6AAgrir+eqtdJVmDGPjGezk6iKbK6OAdb86hUQaqvNt?=
 =?us-ascii?Q?ayyB5CgxP5r9WDcmS67tNbkr75VrsMcrY7jEO3ROJlAw1p+RG/icDZY9v+yt?=
 =?us-ascii?Q?vJdLfgOPDHQGwUF3bjCl3pfROe5tDwbZ9bWgAXbhKir3cSZHsJV7BKVqTJq+?=
 =?us-ascii?Q?86thlNqrwxNP6cAmhlPQaBtdaylQYyjP49osrqN8HVsDyNxXci7lMAWUUvwO?=
 =?us-ascii?Q?2gqZNsG2PEewgJNHoLD6tuVvCfGJ8zPQc2+8CIORXmf0LrJfkvuAFFsJuQX+?=
 =?us-ascii?Q?NDtpjBtUET2LsRLvNqi4DKB39LbZKXVvLivwpkPX3kT+Z+38lV+X+yfYynha?=
 =?us-ascii?Q?nbQCHyfTXs5LHfUNgKBaEHnWy2BzhkWPEDbzbeESMmb8oLc58nd/SeMqaynD?=
 =?us-ascii?Q?IEkt3pPyQ34wtJJDttqul3k9NkWaNCHx3yNxveqFWlMrtggfr6UBEylSvOCm?=
 =?us-ascii?Q?MQQwhQBBaxq9kam8Y/WlXWi6fviMJ5M8UD4cNICOU9zciSV/JBHLy6O2zG1E?=
 =?us-ascii?Q?VozWT84u7vRsnon8PGeRgKpcexXVkT17nMmjzoS9nG5ilDD/qdyEr7/k5gHA?=
 =?us-ascii?Q?2YwvqXWrMmDrOgZPYpza+2FX9Hzezzj37XWop3mzlOPO5vXfrFnHYR9pc7ed?=
 =?us-ascii?Q?uzY+HZfvs9H/CAeodw0NUrjivXhs4RswgwQqgv2O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d94cc8c-0ca6-4efe-de37-08db3ce3580e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 12:25:33.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5uxfzhYW/x2Vyw22joJsND6UnSNaOsQ+EuATwVFVTLl/+ovlWl4Kp52tHUOs6qb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 03:42:24PM +0800, Longfang Liu wrote:
> migration debugfs needs to perform debug operations based on the
> status of the current device. If the device is not loaded or has
> stopped, debugfs does not allow operations.
> 
> so, after the live migration function is executed and the device is
> turned off, the device no longer needs to be accessed. At this time,
> the status of the device needs to be set to stop.

STOP means the devices isn't functioning

An idle device that has just been reset is RUNNING by definiton.

Jason
