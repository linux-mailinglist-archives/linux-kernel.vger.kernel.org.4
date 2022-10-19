Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F9604510
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiJSMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiJSMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:19:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFF2D758;
        Wed, 19 Oct 2022 04:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoT6ZMYXf3ZRgE/dc4i5oQ+tZUE7v5EU0XcrPPRhUD2CihthYDnBSRfwdHKeYQTDG/9IuIU7scKqgIR+s7Jz7slyLP39M02+zbxgQYCx8Wg8FFZCXHRfoOruQcIfZHIJ6/71aLwXmw8EPSMJY6MZGJF9cabjMtTYlDm5UYg5PLleTc05xgJmdKba5F396sBTy9I8SQ7s4XZ5Q3IzWAp1o2e48C4MoQzbnzR8XVo0z/IEnMD0G6H3wzFM/Fe3S/OGJXaOBToOqgR9dHGjrpdqmrp3Sg6oMI4G4zT63B8f2YAWT4M/o8yzaLOXGy35ryl+wzlVFr17Am1h6SS7Zvbncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAIkjoKxC3pIOdcBlF9pfDE6MXcc9DZZ7LqpjGGjYnE=;
 b=FIwOdfUGTmdzvz6Y43C71vPBM96tN5aeeUCfyV+Kng4W+y3KY3SRIoEURDk3gBYDT8Z0fF3nH2sRj6kvHwrHHw2dMzqV/pG2kfQb6rTJuHPKJ96i2pJwbmZVcuQCwd10HPZ9d8HxRf652DCG1DcJm4RgcgUgMB/4EJmjvtMBunkjCOSNRAU7S2s3Ryw2vV4/YSTEKfCLv1wyc2udHD3zG0nrXoRk9LYq00iPEg4SHrdxqSjfD1h4P22+mMzVc1iSp5j085x3AZ1Y7SVU1h+LxOphL0LZEdapdER7jCmjYTK6fucvZBQiUcOXk6nByjnPtQEQqEQ1mb5m2ZsX1I5QrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAIkjoKxC3pIOdcBlF9pfDE6MXcc9DZZ7LqpjGGjYnE=;
 b=P8CWsR5jIRgwpKAduJWiA7bxZhnQfAbxDH0rhC7kXnRnvZG1ELImYPnhyT248aTdb2rlr5nGOnteYPD9ax0gKUhtWci+B3m0/9AMs3KDiK3uYZjRUdV30DUvgGt3aGuB8YsahCO6JeM7kfDWKEKa74wTKQZrTgkTO89o0NXHBxtVsiyTC+bDYvMFOSq/JZU0vb8O179nKAM7sz1fsvkYc7Zcgbunh6V3HeizT2C+9QPstR3aw5m1558xhBEeEb3Xgywskbxqow2Y1N4TyAulyjlQze9YF6K9TT1koguf6nlZtOgWQ4l3zJg34K27j//XotcDq2F0e/AZLN8TSOPi5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 11:53:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 11:53:22 +0000
Date:   Wed, 19 Oct 2022 08:53:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y0/lMCQ8oeXJ2HTg@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-4-schnelle@linux.ibm.com>
 <Y07Dz/NROAMI0Hku@nvidia.com>
 <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 4077c7ec-a773-41d1-cacd-08dab1c8857e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6k5EotypyWymwBB42MEVvltT87grqPDUCU9ohgIOou8iEt33qGFb86+hE9Xe7Ua7P8x5bRlh5NgVW5c604jRtHux34N6aGVP2mISk++H9mJPhiPIy579b2yocrPdf3xX8gnbQzE/C2EcupNxfQ0YfIojyOn/Sh7oVEJlS++TrW0x1xMQiDOjdkgWGW9RBxEqczsSCtK9gdLhrICyV1AnjhOlkVk1NU4amCa8PtoEaA4hshjUrNTD9geb7jtLYIKXaQJxvtOlTKALnJwzmVoldz0JkGzMKk98UihVPxkACpshs6KD36ZqZ6ShLl9T69FnDNd2qM19QMvhQke3thcx64YScVQqlddAqYvWrCGNOVq1nNt69ImAgG8fTlalbwYKnMX3P4jL5laMtwuU/JfAk2y9QW6/WDn+/eH8W0gb4K6Fy/V/yZnCPVWzThfZAfD5KuS5QPHbpFPFjYWaRt/PGUWhuCVww2Y4JVRSaCRyZTFi11TeiSeKeHbl7tmY6ssx0A731UTof5TtEbileGfGUuW4SAlxyUz+r/Rf2dOkubIOnS0UbFhOce83ia9M92M7p2Diw8ZN3H3lHyNiVSxNIjMUoFhD3POSQ4Fvow/D820qmjil+EquIgmtcA12nUZ6sMaqM8GUqRfYrnFtxWjUBtb57PA4TVtfi5qInvOSn7zOIRTvFVOovTNNW8frSC6CCgx7vkJEFK7ICv1eGaYzug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(38100700002)(86362001)(41300700001)(6506007)(316002)(6512007)(6916009)(26005)(54906003)(5660300002)(8936002)(4326008)(6486002)(478600001)(7416002)(36756003)(66946007)(66476007)(8676002)(83380400001)(66556008)(4001150100001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZgqiUD5hM+Axckl6sQ2yBizFLCEzXXNEVcMjgaTyYCn7zICWNsBppoxg3G1Z?=
 =?us-ascii?Q?XYdc8Rh/wGSi9HFKPq1tagGmtRNPHWfQ0i0krKu2ok5UHRPpwJKuEyo/WBUa?=
 =?us-ascii?Q?wh4xdPX/Th64gMjP1CTvx3pIbhsufZLiaSv4a4nxRLkyPqdnd7w3GLo6unG0?=
 =?us-ascii?Q?WYyHzHDYQU+5liKHY4nIhFk2aTmCPz3/ngikRg2fd/OBZtCqIQNlc6Le86gd?=
 =?us-ascii?Q?jGXvIwS2Np27acFFitxC6TSXY1mU24zk7IN4E5JCcfYwsQq3cHVmRodqtqrR?=
 =?us-ascii?Q?/y5A9HmmILrXoZgiwqRQWZUslv0+G2i5EDElOW/BJwgNCmVtiHWnz5+hzJXD?=
 =?us-ascii?Q?MUoPzLbtzo74+F1G0J3S2bxMQ/4ik7HyS3zWXcIYFYpZ1fjp3g9k490FJOhA?=
 =?us-ascii?Q?izediWHx1MBZGpskZ7sCiBu1hHPaTaIMSexp8Z9NS1Q0WNuqjXqjmq1OQFe5?=
 =?us-ascii?Q?FbuQiqFo1NwLuXYt4eM3UrhL/8Hxi87eHG24sPlmv3yDFf4TGDrWblTASKXV?=
 =?us-ascii?Q?dKLwwCtuTCICn8UaDjSKT3qESwYTq09VUSK/b7xRTJIh5e2WmT4ae6pGpcvZ?=
 =?us-ascii?Q?ZDhS3cuhZVK3n7DLvwwr9MEM/PluxkxN0UcW4xbAN3f5atWg/P2tAjRE6EAr?=
 =?us-ascii?Q?VM3jjAVzCqMKIEYlfCK4qXPt0Cae+6osQOFcpd1mM0AiXXiIYXUSudixp79s?=
 =?us-ascii?Q?9LcbaZaI31Bzr+xXjjqLOK8DQ9JXSPXYjjXD3kcjgaF5A7IPOg6zG6uFUMni?=
 =?us-ascii?Q?TgFi7rjAEFN37Oc8n7gga5E0WA96GTw90nZ+GPNZgixw+dq446nlqKV0YIQQ?=
 =?us-ascii?Q?yV8gnjpSdGPvNsq0KfvuHr5U9CvX5qUnvlzDUBwzCsEqlFhnhNypAB80xe/g?=
 =?us-ascii?Q?MWT3QefZ3n17EHb7ucmHA3P2epiAI87BhpVIXOG/o2muDhP+s53sQMOJTzhS?=
 =?us-ascii?Q?+kXV884DmGRaybJI2E9SYTwVPHqnDhSuG+8lzQVS8xzoLtzPlEyiEWkYqhVZ?=
 =?us-ascii?Q?8XAwcMTNyYJlZWmDbyq+2CHrHBKGE+FogblqGZXVYCEXo04RR/U/1lWIeKXk?=
 =?us-ascii?Q?kbVCkS0fl4Pg1TKTl1r7iYosE6nkMLeE1Y8SOxo809uwdC8uEo0MMKIjBV/G?=
 =?us-ascii?Q?Kl0UvYeW8lqfyqFC2XJa609iP6g7j+o0lunfoRhUPwLS0yD2Aj54d28Vhagh?=
 =?us-ascii?Q?MGENjfkIDPCvozGMUQbj4wVTFcohFrGkXMXa7CenQQ91LXMyGrtUWiqN59Eu?=
 =?us-ascii?Q?Ib8AXTyer+w3aoWz8o5faovnuoctkpQT8wvFAcikNf6tJpqrshixy7uL52aM?=
 =?us-ascii?Q?xBjeWaRFbNFk1Iyzguacmw+BgzQYaqyrV6pTPEBiEBn8LvBZujzopN7waBtu?=
 =?us-ascii?Q?k35ysnqbQxK8MZXnar87sv4CK3aCW6EGMpJ5Na16Z5jUFVxKJVOEKOIupmZC?=
 =?us-ascii?Q?Ax47xcwEB196WbFvsmlRT6V2Jm6AHZXyXimQ7ULsJNwOhAnVK8pfzJDrpuaI?=
 =?us-ascii?Q?jmnFlEiysDIelc6PZnlqF0OoOzWLUeCgP4xZgTdpTarDzQJGvnN52cD3OFZB?=
 =?us-ascii?Q?VbnmVOmWyc6PbNLmM1U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4077c7ec-a773-41d1-cacd-08dab1c8857e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 11:53:21.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lPcJ1aETTxaQo4UnF+9Kjbv+JEE2/LWmml/+gy3x9QKMD++6brib8kK0ymsFnEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:31:21AM +0200, Niklas Schnelle wrote:
> On Tue, 2022-10-18 at 12:18 -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 18, 2022 at 04:51:30PM +0200, Niklas Schnelle wrote:
> > 
> > > @@ -84,7 +88,7 @@ static void __s390_iommu_detach_device(struct zpci_dev *zdev)
> > >  		return;
> > >  
> > >  	spin_lock_irqsave(&s390_domain->list_lock, flags);
> > > -	list_del_init(&zdev->iommu_list);
> > > +	list_del_rcu(&zdev->iommu_list);
> > >  	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> > 
> > This doesn't seem obviously OK, the next steps remove the translation
> > while we can still have concurrent RCU protected flushes going on.
> > 
> > Is it OK to call the flushes when after the zpci_dma_exit_device()/etc?
> > 
> > Jason
> 
> Interesting point. So for the flushes themselves this should be fine,
> once the zpci_unregister_ioat() is executed all subsequent and ongoing
> IOTLB flushes should return an error code without further adverse
> effects. Though I think we do still have an issue in the IOTLB ops for
> this case as that error would skip the IOTLB flushes of other attached
> devices.

That sounds bad


> The bigger question and that seems independent from RCU is how/if
> detach is supposed to work if there are still DMAs ongoing. Once we do
> the zpci_unregister_ioat() any DMA request coming from the PCI device
> will be blocked and will lead to the PCI device being isolated (put
> into an error state) for attempting an invalid DMA. So I had expected
> that calls of detach/attach would happen without expected ongoing DMAs
> and thus IOTLB flushes? 

"ongoing DMA" from this device shouuld be stopped, it doesn't mean
that the other devices attached to the same domain are not also still
operating and also still having flushes. So now that it is RCU a flush
triggered by a different device will continue to see this now disabled
device and try to flush it until the grace period.

Jason
