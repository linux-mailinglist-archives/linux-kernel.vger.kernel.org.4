Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A241D5ECA36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiI0Q5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiI0Q5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:57:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDD17D41C;
        Tue, 27 Sep 2022 09:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDD5oAtkeNW+gnbFBc3DtI+/C9ybly2FhX7Yxs0I1/I00ED0Qf0ABqdCsQR+ZlTIvg+1lmc+tSBv6tSlz4dCqvXBdtAuMRgpmM6ghwkWxbel7yvrnEzIgis7GDCh3S34YGEcRWcidOd3+FdJ0MocQoGGO9By2G9i7WwYhJaLCSJLGaU3zrJwr0bQgr69eZFR6LIQEDPn7GkFLWaow63W0JWsVw3xSiGPnzyh8DGgP2xSWeEtPXEPPSZpAPjvmiCBGN+1lpgG6rvV/IgaNgz28rLHksuXGPLp10xmYwPz+fkRt0CJbYNC4/ZSds/zbyF40Bv1mfkAWVzQ29+pNmnvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awn968TBW5wYnEZYy3h9IKK38whAfpegAScWmTVFlDU=;
 b=dsnVdWtu0Je+IVK4j1rs7f5pDiQW8soZGOzBr/silxlr+wP5QUDgVtbU+ibNaQAwlp+ISMhSAI94g3z2m+HEXBFUj++MjQn2GNiI5zuumuHZRip5gWtdPeqCBYWYyDhUvPXVEyRRdOMu/Z5pD+kgL7lSOkNTuJiwdbaVejQfbSUR2BlD+cSDKiqKVAaz6k3zNP282Qst0mcrHnvtGpMDZmzNAP+iY+pTsBRaYSGlLaGSwlgM9Qk3aTIIwfB98S7vrfJs66RufXARsKrlYc/5ieDp98wWg8Ss5EOsAqJgRs0SKq0PBKett8u1Z8ti3r3q7gS944tMoDpf4pXJ1x20yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awn968TBW5wYnEZYy3h9IKK38whAfpegAScWmTVFlDU=;
 b=KBnPH+ZJ2YGk8IIsX5KS5wf8O2ov+vb+/uucpRHXkJuuiWFCdCyIqcmewByuJm/KSw0Ar2+R1/P7e32fV7f1YQFhdqp2o+9CoQHowqvRPq1dR1VNX9Fy1aya4CmSbV5qCMb1syEfcZwMFItwJIRDFwBIA6CJUDAePtYJ1eFTmc2AXkp7MBW1Ymys8FLY7vTyS7zl+Vey2Ih0PYQ8tyRCZYMpZA04NTyJwVFLWQXAQcC37xB26B0Y4ppHHx1Ih5Ik/SJehdgIaKMrmErb3tqu43d4ZOgrLYGc1Ff0SsSl9ZrYiAPFhv7B36NodV4mG40sgSVl3fGx9ecDI7aC9K0cVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:56:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 16:56:41 +0000
Date:   Tue, 27 Sep 2022 13:56:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzMrSIGMPSgJ94sG@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
 <YyxyMtKXyvgHt3Kp@nvidia.com>
 <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
 <YzGtQY+uw4ZzZoSH@nvidia.com>
 <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a10b5baedafb56335231ccbd585412bbb3a108c.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: cca024c5-b2d6-4d4f-bf73-08daa0a9405f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WG6P19L7/IYxY8sCM2ME0sx+VS2WMqAguc7eSkSZAGtRDkWrVnvQTudaQt34ccO+KGfna+fjWq19SeblzbkB3rxo20FO22BHw3oA+Rqf3C+UdU21/1ibQeZX44xrfHGq9OTbYMedCjHP0hR8dc+7mDiYJh7pN+dKIxZd5sr6lToGTZoAzUApxdaZvw3V3LepW/sKO6ZDDQrlUEJ6JOStNYHBJgwLTkegWgkgrJoaBfaUE0FtiodCr/zh5Q9Lp8b3vXSsSyMMlHqe/ZK/0p8XfmZtLAGYvnl3ZvAVHEJfkvabkgmxSC0xVZbLOrD+ci901+8CCia33sZig5KdNcGkWsYdpa7wn4IF+Klwp4hEGP85TOLv507c97zI/g3lSPbFj2qoRkhpxORNB1NK1aKlb7mJQ+gUDAX4FA6TLb8aXb0W6mWuQ99/xNLWYZnVGeTDA4dqY3ntzpvwwWGttnkcMPGPg98Vq05HrUg7eJsBIrGMcmtbO+2WMf5MyxMWob1Ii3vQniGwKAcSoQBmxJgTAigLgSTFS6zz1mjBsvsn02SUK1PWUoPne3s0HZPVELwWIPQnlOKo/zZ38k1GON6HCa0mnO5u3Awehcv93evCchlnBle+dDMv4xSEfMOlrLuQpBe1XJfuZc5I0keNoKxv2g+yT5HlrrTEMXnph8KtYrEQDVtVdEKgiKIYEvxX+20jJxMFIFsiY94/s1z7vigg7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(83380400001)(86362001)(38100700002)(66476007)(36756003)(66556008)(2906002)(4744005)(6512007)(8936002)(7416002)(66946007)(5660300002)(4326008)(8676002)(6506007)(316002)(2616005)(26005)(41300700001)(6916009)(54906003)(186003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUxPZH/s6hRfFD/ZkHg87h4EyKAonW+iDej/h3ji4wWcy1R05atvTTG6+t2u?=
 =?us-ascii?Q?pGmYTlV3cGTHm52xdW6S3/myezQMQD1ZqgyYyHlZn0fLCgIZIVhDp9E2jSlc?=
 =?us-ascii?Q?SocjfXX3Gv6lCpF18iUgmhVaWGBXfwJuwH7Jkyu3z2CmBk6uDH7CU/0WJjvd?=
 =?us-ascii?Q?U0i+Jhi0zheB47QP/ZiIruNE/wl0lkaGxiYeVYrgf+WUij9WusN51Ak34Y+I?=
 =?us-ascii?Q?MrH4Vb0EWrEf2SSoyjNaytV2RasJP5kB8if8jh7qg5PDsx3lHXkqM1TLZNb5?=
 =?us-ascii?Q?UfMfE2W5/ZAAhbkchRjiN+g3CMWNCDIoOJ3nfbBnhEVZna+fN9Ue4hcbzQ9e?=
 =?us-ascii?Q?12Czobe5jfJnjtxko0I4PtVOVUJSjn8zOfWxB91m21Oz6tKJ3EZTPbjbXPO2?=
 =?us-ascii?Q?jusWTrjIL6LkjN57/pema1EQupSwXGHR4IhQtuxE/y1hAQGlLyUnCI/A1xeb?=
 =?us-ascii?Q?vpbZeTDeGuH2L1aO4VYBBYU+BlgS65XS7ssEk3erpbyHVRv6R4Y8S5sOP5T9?=
 =?us-ascii?Q?s9rHRCm6Ch5R+uaUa5QiYPdeNen6cYsBPpIbSrhA4FvuJuArAAWTsX9srBy2?=
 =?us-ascii?Q?AL4NFS3FtEjVyQJbn+IlYYdkQ6VHkM5Rz4xcrQOMMu6AQUCDPgrv6duz84L3?=
 =?us-ascii?Q?203BF7GEsxHBvxQyrxSTaYpuupyv+UC/Ocu0erQHv0bqrfx0fgxt8cB/dfwH?=
 =?us-ascii?Q?j4patEKJJVjFErbMX5/Ui8KUovbeFxuFj4clDXC47lnm5GEgsjneouZ+6hCu?=
 =?us-ascii?Q?dgxLKL5xmlfYXxiqttZpz21BNcc6frB/qvRnOugse2PeECq3pndg7tuPUY3A?=
 =?us-ascii?Q?De7IqX+Cxa6uGlywBHv6mHei+BILPuikXzALkMAYXhKED+n/unb7SrR8gX/k?=
 =?us-ascii?Q?Wjq9l9BUaPjcbJP+M1ca4rKC+Y+c1Ts1qdEhzoQsrO4WHlFrBdiZVB9pO2eb?=
 =?us-ascii?Q?ylTGUDzAU7CjrD3b2WMYtWB/FpD4Fa36BJ+5aAguDkZLEfsoMe7cJIrg3ke8?=
 =?us-ascii?Q?zFst2rnvOMKl8HTrRQcxOvu0A31RzbkNq1OnQi0uFcRgmdcog1JCEwWWeZEY?=
 =?us-ascii?Q?hATS9CKgvEkOLjMuQJaLox9uHmbORHZc9h/FTGMHmesqCWq10uDb/seyxN/V?=
 =?us-ascii?Q?YgVDKTjTAvYduTcVol+wKXrcYFjlerdmt+hfz957UoEhAiwPY0oEge6fwo9E?=
 =?us-ascii?Q?DNqXsvmpcRG7ZvAba4wdhdfjDDhD5AUWZtNq3S5p47bxBbxJIOaZrDPVb+h3?=
 =?us-ascii?Q?HpMuPzzHsi5/rMV+Vr3gNmkLj//Y9JK4mx6X07NOaMP6V0Tnr+QK6dURbodF?=
 =?us-ascii?Q?mbuRO1DeSs5h8GT+0tKwF60tg96KWW4TFj8P+0MK/oMvZfVIyOO3H4SdGGiW?=
 =?us-ascii?Q?HzVJ7EH29vg2BPZQJYiLCPnK8OYy5z8GbxHCJH8Fm5FsR39KF/uCsYM8dcSY?=
 =?us-ascii?Q?0MiVSU2NVNtK5gdAwv8zKR9eYByU/MqtAw+cuxr5bc64sby5B10fkoSe0KcF?=
 =?us-ascii?Q?clh/PGcSonCAXmF+9i3J8oqcCpVExjwLagOKKAZEtj8FCjJaF2ztUcEbpwk3?=
 =?us-ascii?Q?YPT4ffy8djEE3dWIs2Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca024c5-b2d6-4d4f-bf73-08daa0a9405f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:56:41.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSQ0lNlvaUTW8LU5p9LbepNLLKWAjGzZ772Jx5dNcsURYfwtlhENSQivIhY4HLLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:33:48PM +0200, Niklas Schnelle wrote:
 
> Not sure what the non-MSI reservation is for? It does seem like x86_64
> also uses this for quite large ranges.

There are lots of things that are unsuitable for DMA on x86 platforms,
unfortunately.. But yeah, I'm not sure either.

> This is because I'm getting a map request for an IOVA in the reserved
> region.

How come? iova_reserve_iommu_regions() reads the reserved regions and
loads them as reserved into the iovad which should cause
iommu_dma_alloc_iova() and alloc_iova_fast() to not return values in
those ranges.

It all looks like it is supposed to work

Did something go wrong in the initialization order perhaps?

Jason
