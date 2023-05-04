Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4796F7953
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 00:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjEDWqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 18:46:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325812120
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcDfxPm5dim6j5irFTLIP0ZLYyKqo7HG5rQHqSw9vh9TOEmDcY1qDOnK1G3hTTr60gXMK/corGWJA0uq89v2a09YbbDySIWTFxzW25OrkLbyghMhbvTloTGWPrcehjy6vO1WlZko4+7irohEajPuWfizfRhwKt0j88BYrN/c/0Si5a8uZWqrsf+I3R+JF1hYn4UiJUYQz1VB+YEKyLGal4NzHlDUqsai7UPCABfO/9v/fYhxKxD3VIevPaKWqUN/hLhqK6NFw2f2TRBuqNyHy8yDzwLUuIp3FEE7zs773EnY4Z0PO7NtH2R3WgBqmdKlyb9B9O8EDdFKOIIx7ZyPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fm906uJbhFc+0K591CiFBBljjtvzsgXZ38uLKsre8s=;
 b=OJdCQiIVJv6KnFhJgoOrnbZmNh5V1e+TxTVFIjZBX1ex4mwV7GgN3+bcjDrvyLnhG8mhYFSbB92Y7o1XGFCHlr75f+BbjDo+CXeXwTpwEcPVcpF1VZecNOR6MCijGMsQSuxTPiu6Oq3cRmPKyvdAiRbsqx7gsYPO43b1yuAw6FvZ3LnyoR4pdELGCR81mrTTe8gz7DB2hMFdBRpnoprSfgQ/vixRXmGOoEkkWOb6QyyRC1GFC546Yt0M18YdqaYwFnRNaub/DI4EF/O4HbRSy8n11cRa0CKQP5ZCCKjbV18uByafXG0DhgtdKGhKbdmRoWQMbKxk0eqDvhDurdu6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fm906uJbhFc+0K591CiFBBljjtvzsgXZ38uLKsre8s=;
 b=df35U/oFtErwbUgxoo78H/MMWE17jSiYpPr5YftGrUZpQJYbOosFxkYG/0Qr1S+FUtt4TQTZebLcLHMdiovPO7bvJ607rbIRCNfUnUXTE2v/dXpA5mr+y0NyewcDMidd9hU+1AQcfBSz0sTwlE3fLpz9Ralyd0fFSvUkS6LjRwP2Ae3mJY0RM1olBHoKkQ3HD3RcZSkSU4UdynnV2pD4jUbIgW5BOa+OCs+4+UUmse4vupTHc9Sc3txQspm4+lCfGhlC84u5aw1RfedjhppQgPYQbJ2d9owAZzdUkmSBHIfOUgdQNEMCmCB6yoJ9x4JhPXvLa9vxVD71TunjvYh6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 22:46:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 22:46:43 +0000
Date:   Thu, 4 May 2023 19:46:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, schnelle@linux.ibm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <ZFQ10XczJ3zQNHje@nvidia.com>
References: <cover.1683233867.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683233867.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 170efa84-f244-4db3-0746-08db4cf16ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlgGSs6R5pLo+5PLmHG9BPwR8ZLUFVUIQhniH+c+BDP50sAjY1ixJ51wPCxovcFqHsJSRDaS3aLYH+Ua8esUgmv5GIWx5q8IZBN474mjHXsSxH9r3pI3Fo/14ID7yLnxOgj66sgXfE7DdpeO2ttU0FN27sehItlKrt0OHqU+HMjZvEnWRtNpOIBkwYhp8jybCWXINDIHUUafPhyEtTbifFC32eEQ6KtL4a2G/4G0iBhnYLHuF8zcMM2j9YJFBdQ6+0zLkarWZpBhNv7TI4QTqzWvGoKKNx2C/R/9m8Pr4k0YNpl63Ak1pcoQ3Sdj8G9TTUTGk5Dro/343z/nVHHRhMjpSUHmruWWbBDPMNbTtwPdH0hMYC+rpcYciy/8p7X6MbieObLToGxPS1VgKbaPtmUVtFdMC0DbswK0p5zTQDUKp6QbdnUHKp9CLSuIjS98SH1E+3lBESc1IRxP3hVmUE0JSC8CX+nHooLAnWMnABAdrrOCp1WxrTEBxnfRRp21OUqWo+zX55S7qbZazkJngluvrTsIo6QGmkKYSdcZwNlA9d88zrV8qwcZAZ6IioHM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(36756003)(86362001)(316002)(6916009)(4326008)(66556008)(66476007)(66946007)(6486002)(478600001)(41300700001)(4744005)(5660300002)(8676002)(8936002)(2906002)(38100700002)(186003)(2616005)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaFCadJeQlhaK+ysXiGFcwUvLdLMuUdkrn0ofh3pUPNvP6qrsM0ygK2GZZCL?=
 =?us-ascii?Q?QxvDa027XEvBqebyhTErzP2hM4gR3E2KXzzIsTwYJMl9cdxsTUOFYeOoUdVy?=
 =?us-ascii?Q?GwtzM/Lbe2Bo3E49uAxnreDv7oOl+QYaBArF6qvne+qv5QzEFeTuP0vQDNOe?=
 =?us-ascii?Q?fAs9fmNdQWOOBo5N3mkIcsN2Z7KQ4WAwUm/6s7epsV9y2kteXsuK1xRQ/8C5?=
 =?us-ascii?Q?net3SDkSML2HnyI6QNe+/soPToifFFm8J27efY+aEAchqISEQwXR1Ib460gg?=
 =?us-ascii?Q?Y76Sc4uff76N0GxTJd7whN2xhwz3sg+qozwpunWkffXM9Qb13A+KPEM7kWzH?=
 =?us-ascii?Q?VotbpLyxI0p4g6QiWsWXiN/MAE5OZT4l4pvpZVVFAX9xWaGR2/UJUWv14CGB?=
 =?us-ascii?Q?+IoXyXkJ87qdwXOMmmRF8PlOSsLvBlWkP8sXR/qxsY/PqlHjOjYvjeNZuHON?=
 =?us-ascii?Q?18tVug0tYueGr+UU+19Di7I+USRGT0pyu1ZwoS13pbdl2r35/SRZ9uoXFSHd?=
 =?us-ascii?Q?BxboUCQqfRKDEi3dbnuMBYkL8WMcU4j/fJPkvZ9pnNkGgQ6YCGbkcHIupZm8?=
 =?us-ascii?Q?/UVE6t8+8ydCdiJja02bnK/rR8hU9T+LfkexKNNRf+oqGjluFqJ7JwoVfZjV?=
 =?us-ascii?Q?eIV2g8CAn3ra+TDeH8h9e/nDH38g/4ERGe9d+ypXat2vghe+54FgULmeDivq?=
 =?us-ascii?Q?V/MBArrPHVlLBzc3uh01RD0JJDNPA0fkx+YnzGJtmNN01P52jK+GG2U6rqL+?=
 =?us-ascii?Q?0GGtajOLP9e9N/Ah4E3xjad0X5tt6OOUzIPtHDeBQYuhxqm9Hh9oXMcmTpvG?=
 =?us-ascii?Q?eQgAhevWO+JNanJROzhKJPaA09uC2z6KTAIgUuehLDOd02/8xpI3HCEAIjz4?=
 =?us-ascii?Q?f7ECUMe8us3Kc2ZL8aMin6WctNmdVpiUwHa3bXuUnmJ5nKV36UOnfCrCc8QR?=
 =?us-ascii?Q?OZ+q41M5ZA9Yf8uZPe9OvvOZFGHPTU17OsukL/T6cd5m4U39PRsRhZ+GuQ4L?=
 =?us-ascii?Q?HDk2eUiKaUIHFkBYXIxylCUqBkMfSF0XiiJKpKnvYKGKMeBn1ms+GdwWn4xo?=
 =?us-ascii?Q?frSCuDR6kBQ7754k0L93dL9tcPcP9PFUnJglmhDrohxgijTDHoYWwpZZdDgI?=
 =?us-ascii?Q?RIIugvEYyzWUeKW8Z3lYEDyHr3oQIEbG9bJPumQ8o1Bpa1by8DxoD4iwr32L?=
 =?us-ascii?Q?eVQkPJcFMd3N6ziVjYb2p24WZdk22RC/0vm6eqP6D4/ygt0wjoN1xDmDxsxR?=
 =?us-ascii?Q?bYKzHfNc3Poz7IY/XhrJfAIcJ9IGGhqMAx3miogSdbsUHuoEDw0KYaZJmPq4?=
 =?us-ascii?Q?piSxqmLrHZY7hTCf2K5/vFf5HB3D6yoVJY0Sq6Xgq2WsTlEjlFI+Bcr6MJK/?=
 =?us-ascii?Q?1M5jgyjw3OHFlyZqy3Cg7BAM1gQMIca95AbBt0QNZEAYwfPrK9zlJwOQOOXa?=
 =?us-ascii?Q?4L7LvubIlfKVkv6QHDiDm0oVv1WIV7kPSCGVEv9gE4X0USdwcOPP8Ixw+Jb4?=
 =?us-ascii?Q?dr0GJ69JUWKNP2ax0fbPIbWOVrnqGTsf0UgSru7TlhTegsS0h7V8o4vucgXq?=
 =?us-ascii?Q?RJdyAHD3UCWaMzdaXqMxjfWfGjSC33Mm+WIIyv+K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170efa84-f244-4db3-0746-08db4cf16ebc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:46:43.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: un4PslmkWoR98I9COQtzZAE++BM59F2btZWmVetmFeN1ohv5w/maA36T0z1Dm5rS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Since it came up in discussion on the default domain series, it seemed
> pertinent to dig this idea up, whcih I started a while ago, and finish
> it off.

I was using a flag in the ops since no driver need to make a dynamic
decision in code, but this works well enough too.

It is a good step forward, so

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
