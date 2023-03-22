Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D066B6C5193
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCVRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCVRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:02:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC76544D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeuqoM3UW4GUmEhW0wy3dmxvBKKfPwyqjVDCC2lKdJSf6q4dxftIcIu5ReIxWieOVL5fc6rpKRsHX84ERbLroMfPo5IHQ9DM1kO1M6NAvMbQTvtGKjbJmQqUlwevJJwgLGgRQSqARZZHiEarf15saWqe/NRZFpOtV7Kw8vssil89HaTgT+AyQZBbnCRN9F+Ae8P5dKaVyaYvmxU89O5hpQ0tc9oK5K1yAGb+X9ObpbfmbCyqe3O7oku7d8dRtQM/gBaSKzHm47YZHd5JBqd2oLtMHlasUYf9FjOIKo/7VkP/PVOirDXJiY9jQAlhvrmVQBkDoeoUUz1ik2g2AMohXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzmbwWItkRxbtEAXgf4A3aVTYQGOAHfzkx7PnhS/sW0=;
 b=ffADbHl/bnkNHRmczBZ0De4a39j9aZxf5Wcib63l5hUK7UzT/3pZae3TNciN+ZCBXIpVAJhrCjLZ/5rnt+wrY4+7oP/q8hWZaZFDF4s85HyD4ZJI9UEAziYJLI0/OaGfWTIx+3KQKZV9k+1iqiKlMc4bAUiRPSlnYQ18gfBpDNeXATkLaMuzZkEjhLIQsWl6VnDUgsGkstwGLSw3+ijUdc8S9QCIsnLSQg6b0RYYKHdjU8WGdonJJrYRgQ7Jp7vPEj2DD1xdHu9LkXBSYEk6woB+uxW72m7qgimSNO2do1uZfQXHK3BnepHtvPkv2zFx1M2kw0M3yMnh+P4E462fGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzmbwWItkRxbtEAXgf4A3aVTYQGOAHfzkx7PnhS/sW0=;
 b=DILNy56syiydq8Uv3CzrklQexKgAUWNvKd7s/mRdUhXNTyZ+hWlAzvEl9EurFP9jrf/Ws9QuMwqq33c9QIGecTKwJvC8YD2dAEZ+8M4hLEytC2NfK/8ravRYiE3Z8bAWPHlD2TfAIHedqO5AwBIltXOyZJ8Y5nhsjQ3PnPsSuMqmP3cAbXr3vODJ96q49yLsRUMJCI1hoQywLzFtRuJU50GnEm/YxVvp5p392VjJx5m0kAe8tZ9M6hNgEjfeWt7O9rxxhut9kqU52FQIvDWCpvi4xwaNiZ/lIz6/Y/JhqDBkRc1C8dvdVqluJBHuyjs2JESE+YmkfZw9h8r/f/54ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 17:02:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:02:03 +0000
Date:   Wed, 22 Mar 2023 14:02:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBs0ifAVwWvOt2b5@nvidia.com>
References: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com>
 <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com>
 <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
 <ZAti8wy9wXwtIqLT@nvidia.com>
 <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75259e4-94f8-2276-05f8-a0351ea110dd@redhat.com>
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: c03cef41-d115-42ba-0dc6-08db2af728a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lF8YuRlDgcIjhtG1dnJUt/M9r+4mWn6i1Zpys/ACGfyKpIIWHBjxiXi7djv9srumKyM/0WvGYekBU5rC8HBnnD8JbLUxeaFqLeL1maw6Loowihlm1JR6ETA+xaOeHff4IkhVsxqiT3XHBha6y2ylwefn7Ea+rr+qgh7e/TuMdEkqdLVdhZEBXmZuIce4nPsTOAS7g/GHysWvCA4UxKpMkSgVbzF32o1Xu2f8Td0FON0f2gEsU2QN3d5XZb27QDxcy4ALBSYJPJJTuE/oZP6VKjiRAgvgkVT/ULyI7mAx5Zt2UIBroR9Olyt/iHCvesXx76BVt3hLkpZN1BSbOZGTlYE0+88XSrYIjPQZIMZNxwq4shJ1eeeJDCQWeXgwRFWBK0zi8r8uY55wULQtR17/SBGIljqymsw90UN0c9TvZk53DqFCPhrGBkU40wVNcGWVb4o8O74Z52BErgLe1PBg6HAuDITpIKa9mH82NOFcRJj+KbUSJHjziBuTFl5iUXeS8I82S2oHv26iQAsOij12B1xs5ywFhUs+VzJfIj9sg7zFq8gZw8w9NaS5iiEcp41gp2/FKLsRQq8hEndDR8EUljPDBa1J6XPk2gPlZbTbliYg+z69CvV98HXo2QGNdHWwcYovMsHicEOznZiM69vQSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(6506007)(6512007)(6486002)(26005)(2616005)(478600001)(316002)(186003)(54906003)(83380400001)(7416002)(86362001)(5660300002)(66946007)(66556008)(36756003)(66476007)(8676002)(41300700001)(4326008)(8936002)(38100700002)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYNeaVx5RmCMhv5zRBUBClyvCMIGGTqnrimeZVN7LgxaeJ3bznMbspP9ffVl?=
 =?us-ascii?Q?uhgDO+fW+48B9YYj7qgXLExzqwpUPBky2mWueIfniLageks+lF50bdK/8yEi?=
 =?us-ascii?Q?75X0lopRwklAe2R9AXf2pkoWoa/qEIaOZdD8ZLETCwrA9xLrrEcXiV8vxb91?=
 =?us-ascii?Q?r+P2YK0SpMvkTV7zmLfk34f1xeI8x+bgc51iMWPgeb0X7RMBCWSGlgYg+D2E?=
 =?us-ascii?Q?sql53Q21PvoH4ByCDcq2VSzjYIh/RE1QJVX4ju5imyUEMBMcSuM7ckRqpJry?=
 =?us-ascii?Q?8ZB2Q6lWQ9bjLPMcaeeFd8sVd9MFQsLsKrtfpCmiBl5tn/gtvJ7tItNna5dl?=
 =?us-ascii?Q?BIkaInvvMgQuoHtvLxE3nLfxrApT8yh62wSJ8cER+9M+KXKk90pLMdrDjfRp?=
 =?us-ascii?Q?UlmO/YvJUWc25e1PiIVB82T2R4HmXOLEBRoCDWimKIEtTNTC7xPrQv5LHOJg?=
 =?us-ascii?Q?7jA0s+GtYvXFoycEyQzwbydtAn+dDCu+3w+gkJ6nyjtwY6E1kA89Af16GUxp?=
 =?us-ascii?Q?h89DzhdlbmknkgNjJFjE7TSqD6i5H29ULGch3kxanrYU4cQO9gerSPVkVAtS?=
 =?us-ascii?Q?AkKdkEfSFvWsNscYNakNeP8dYr2GR0Azv81DOcJDkG0w9NruWwgqHus0lF89?=
 =?us-ascii?Q?tPXS2IN3/UQ5qE0cVlI+WGjkGP6C4qXxK/tTo/pkt+OwmGaIfI1DouANH+KA?=
 =?us-ascii?Q?DxFEZBE1twFYI8mbkr+3eOGMB7KjTKHuAkSWp58oaJ0UuqKYOFzn4qMRs6th?=
 =?us-ascii?Q?NWVezdgyhMB0YOkXRvstrK72huKIrrY4JNQ4fdzNtE9U8pkKEJm+OXjMg704?=
 =?us-ascii?Q?wyashOebO9EshZfn6jRORbsRC0XJpjoRD5W2pt6GxhMXRamMQSrV+SjAo3KO?=
 =?us-ascii?Q?NSz5hVq26G6NfNNl2sK4pl73H74PK25LDQknozQlK7t1yUqJ7HnshP5B3TbI?=
 =?us-ascii?Q?3j/gYQqUMtRzA0ejOZdKITEiLAYQkKFS9P5FEovYur6BN0RSh5w6RnELs+DT?=
 =?us-ascii?Q?/dVfle9KhSRQsFe2WNHdQPckpomWTEprzAi9y196CVWxguRPxyrJTL3eWAxp?=
 =?us-ascii?Q?FuBF2j4CuGF1IpcFxZ6BHofvH/nzGmFR4/gkVp3NlwE7oYHAfQ7rBG+aBYex?=
 =?us-ascii?Q?IqDuTVDiD73OJiRmAXBtjW62puYelYcpJT5nChpdtcgi4xXRpDNTvofQ74Wr?=
 =?us-ascii?Q?SJHjT8KzE7S4sSu5cerB2J+tqZypXOAAu0ahjKsItQ4GsJjv9IhbAhVz7fKE?=
 =?us-ascii?Q?eD/8uCFrFc/kDaQVRyJYGHOuq2aLMBMXq8Td4HSSBXZyVOL+Zcg1FZWzOoBD?=
 =?us-ascii?Q?lBznE1j/pXWRYJyRGx2nPSRtUucAgXnqtP7VqqKAkOgBCWakJmMwdSMW+cP8?=
 =?us-ascii?Q?WEq+WFRr4hhBGxSC8UiZ4dLGqPby5tKZGX2UUsAvzbXpfS9O/1sbuEJ64BpH?=
 =?us-ascii?Q?ehtDdKoqa187L9utyG3Ab6FIA+G5kdBxvHyHaa/Hp99vfwqog6Hzd+4z4TCr?=
 =?us-ascii?Q?FPh05oeJaMP1JwgkVa6t2/e7iUdwNrLTww/uzljxxq5llNkNd3Zf6KUHgl+r?=
 =?us-ascii?Q?Q1cTOuj9Vow9B+wvDrUEtaip/R04uMAdHtE/mYrT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03cef41-d115-42ba-0dc6-08db2af728a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:02:03.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8bCoBkLHx7VlHZh8z4kG0qM0sMs994dJzaJVLq/XS0Orjp8gi+o09AGa4FYwnDS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:07:39PM +0100, Eric Auger wrote:

> > It seems like Eric's issue is overly broad if we just want to block
> > RID reassignment that doesn't impact MMIO layout.
> IORT spec says
> 
> "
> If reserved memory regions are present, the OS must preserve PCIe
> configuration performed by the boot
> firmware. This preservation is required to ensure functional continuity
> of the endpoints that are using the reserved
> memory regions. Therefore, RMR nodes must be supported by the inclusion
> of the PCI Firmware defined _DSM
> for ignoring PCI boot configuration, Function 5, in the ACPI device
> object of the PCIe host bridge in ACPI
> namespace. The _DSM method should return a value of 0 to indicate that
> the OS must honour the PCI
> configuration that the firmware has done at boot time. See [PCIFW] for
> more details on this _DSM method.
> "

I would say this spec language is overly broad. If the FW knows the
reserved memory regions it creates are not sensitive to PCI layout
then it should not be forced to set this flag.

> > But, still, why do we care about this?
> >
> > The vIOMMU should virtualize the vSIDs right? So why does qemu give a
> > vSID list to the guest anyhow? Shouldn't the guest use an algorithmic
> > calculation from the vRID so that qemu can reverse it to the correct
> > vPCI device and thus the correct vfio_device and then dev id in the
> > iommu_domain?
> I don't understand how this changes the above picture?

We are forced to use RMR because of the hacky GIC ITS stuff.

ITS placement is not sensitive to PCI layout.

ITS is not sensitive to bus numbers/etc.

vSID to dev_id should also be taken care of by QEMU even if bus
numbers change and doesn't need to be fixed.

So let's have a reason why we need to do all this weird stuff beyond
the spec says so.

If there is no actual functional issue we should not restrict the
guest and provide RMR without the DSM method. Someone should go and
update the spec if this offends them :)

Jason
