Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACE6B3FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCJMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCJMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:55:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081BF30E0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:55:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id8Mf6VqI/22o9vfptQXND4PnmR+h1Te8pmHAcmZvJmIgBBk+aVTbKBxKdLJWRZpu85XdtoA0MGln/lzHByPtBMmv9ifVlksCrmdU+8ez4RcLi2yURmmLpcNIi4/OZPosBGruVHeRWYxa2lxUyEgPA7lzJ1MlqlM1RWcbNq1DbaQTAgGj+U5rdeVuJjXYCePmrdeqxkhxzwWAYH36oN5W7EmzHM9c3crBzUxVy1VLOpMptHqtQCzoTBEnXPr12C7oDEKCig+G8DKV4vI0XdKyZrjJB5crVzu4BiKDHSCCZtzZtPQcUzrKhs/w9Q+FUCs1QF039Of8qjMJqk9L9k4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiFNtSN97hhwOWYoqLoquUzHdP8BXWRDCL1e55AYBzo=;
 b=ETXRVNwvUQQk9UamzM3W1j49ScMAi688Jhtpc23FZmay+q/WEwdo92kPWAD84Ie0cFOto+OO0zK+HIRYwj0QRfjTmAoGLXTIX4HAvjDGY1wsba9a1UdTKraQpuXCTsX1ZWyU/+zD1PxaeLbRgF6KLVbBH6kuTLx3yBVMkoi40OyoLgQQ3uNKaHHrtEkV1mnmQfET3cxNCJhZpsj17AX6NyZjLCUhOuDN7EBQC3G7X7fy4tSxBX3yYE1bVM5u4DykK21GFFtudQOrcB/H8KHfv/Qj9aoIG7FA3MyzeQORBHCGkLc2QQLi8IF1LrcmrOzQJNg+UMivVKZiU0lZbMiqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiFNtSN97hhwOWYoqLoquUzHdP8BXWRDCL1e55AYBzo=;
 b=SFwYWEkKScWlaVCcH65DEA5dLjhlhOihlpEYKT5IwmnHXdZJTwA/utUrgUI57+5xamXlA8fchAw3eAgaSPqj7CK/SihByMIGNK3C08zOjtVimkNP9+iXQXCc7iUlNMZMp1IMkZQ7q31AroXMX1GyE8m0QhRx7jcmDVy7zy06x14H+gLXLc47NIaYcCdCE9vozgmv83miU67eac+nEVVdSKh0mv5wkE0SEal/k+qeW/pi8ZeLbft17X/4nRCpFnatlQjtNJKVzgZk2vk5C5Mx1k7q501C7vxyX9/Ma8UY4vEF5sUVarkQ9QSUgHZtf5SGoMektIGpUpAklZzkeIbqCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 12:55:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 12:55:21 +0000
Date:   Fri, 10 Mar 2023 08:55:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAsotUK6d4L2ULUq@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
 <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com>
 <ZAoCf9+kpMof6R+4@nvidia.com>
 <4c1f57adbe0c4d48849d585508595939@huawei.com>
 <ZAq/n4PNeow6wftN@Asurada-Nvidia>
 <ZArB0n0J3GW75WNz@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArB0n0J3GW75WNz@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbc8e6f-8b47-4373-7fcb-08db2166b50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Phk6AAg4WAxKRH70DFOq+IkRFVk2oxBbcRUJoR2wFdVmHEILwsebdZo97CpQGbmTaF8pa0lBP8Y0JEP45PxbIVBpkSZBnwqsFBjpaDEVxcWWC8b3djVObKYh9WuINenPyK1TCnqXnCnyNH3sNWxELYbQz0Sh6zibgPgPjKCA5WDzJmRqarHHfV5yWAp8ivLaBb6l5x9nZKTfHhg+R/jg+nTrbhmPKXVfIalFLuiRhPfXAbUsBOkOovCAWZiyKKB1LOYlQ4tXLc6VEr0w/ph9Yi+gHAzQDaa+UEmenZujIdxynCdl9oTQJzGYISLgjfLT0KkeJvOCZNhszB3HyQ6qc6gG+Opa2HntfvJjSMrNVSUG41mcdVHRGYldZnQLhEKsAhAf8/PVUi9zknARPGRvEsb2EBy+AjpdIaJfzubXSaWp7EOvTggmZaJwO64N8Tk7qHt87yXih5k2J18qcysqzsSDKYJOvgk2128oBIomENKmucGYNr3o9Vle+2U9hBreo2Am5fA9HEtDMJlBrHt21F8QRGe51gYwqU9KnYFdSZCZ3tufbgxTYsEdYXLHWye5H4bEhe2GfOZpsP5GWjqO/UGWGJMmm5ndvmRnoIPrbJDN4LdXw0o7PcOKyXlzaVnoPTyIf9tdY342i+dURgOPMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199018)(2616005)(86362001)(38100700002)(7416002)(37006003)(8676002)(4326008)(66946007)(66476007)(316002)(5660300002)(4744005)(2906002)(66556008)(8936002)(36756003)(41300700001)(6862004)(6666004)(26005)(6636002)(186003)(6512007)(6506007)(54906003)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhlWMmrtIl/rFr/AqvP6V7vDjiDSiVL9zOms8ErkEmalTZAWDPog4U5Lyb8G?=
 =?us-ascii?Q?IdVrZJTmFrOWRgcRGQR0/luoFGNvdJNrgJRjmHdeq83ljrFJW30atrWRMlfZ?=
 =?us-ascii?Q?EhKtDYqdbJjIA3oVgsMiP14F0jINkng/OBzGwsJ/wraKmrEiY/0+nHAovOCi?=
 =?us-ascii?Q?xExL/o6ynsJWJstkj6wFcZF+QCFYIA2wSDlPunklcmTZgNpe1O0QH3LoRHSK?=
 =?us-ascii?Q?S4K8RWbdRg01wTo6evjzm467q8OzMSMHe/rkrb/R2JJAak7MtCyiWLBI50Bx?=
 =?us-ascii?Q?VjoDME+OcnxxFuTqhYqJ/ZoBCjazcvzhWhS1a88ZF7tc57uDQpu1HZH2UwS5?=
 =?us-ascii?Q?H70W466sFj9WtNg+CAPsMd26pgfLqwvD36catBYKQ8nzy1xWYQXOi+BuXc0J?=
 =?us-ascii?Q?vrVmgl0CSQtd/OOh9S1mzqwQcJ1YSTVcT/ChsfwlnzdB/IvdPMEoXUBxJOAJ?=
 =?us-ascii?Q?8NrTg/9m7P5sH8Pyan4kriMPMihc8CiX6CgsEp2wskBuLeNQDRRYEQ7hgcSL?=
 =?us-ascii?Q?lBcMwR1cJaq3FhR+PpImhl9ZVClble/ibHeVwYvgtns0H5/X8W6k2ce63M2J?=
 =?us-ascii?Q?7wOBq/hloCemk1PSqeEgJy7EZ0hxkIwxdWlZzoSWn2n5qb3Q7D9BcVi4+In+?=
 =?us-ascii?Q?GBw68vL0KC28cs7P+PEQDdad/wlVN7PdIXa3J/QUFTxhS7eWfcpCj9Xb/zfB?=
 =?us-ascii?Q?Hc/4vUjqLraChLMXf2KmdSvzbLBT2Cfi4/NBK37P7LN/RRj6N5gLLAaXtfso?=
 =?us-ascii?Q?UvVVInh+ZUVP+G/BqvTtE9ZP1LbaqGvTs9XFOjYCQZmi4bTzERjtxpAZ/ld1?=
 =?us-ascii?Q?iOSyuGrGwtZRWKPmG06IGi/bRF+J9waAzVRC67QRe7PAaT5Eq39L8RtsMF5R?=
 =?us-ascii?Q?vX2z3hjwnq7idz1xcKjj0WFgvQGgCz4L6OmrygMymEA7IO/6flX+SwByihJJ?=
 =?us-ascii?Q?AqntEHI43ZVqkOxyKPsdSQ+GecR0gK7JipOwSkJG5oQRedCWHtjxX/AITCb+?=
 =?us-ascii?Q?8ezsDTBS7Q9fnn7UOEvl4llYP2H4LF/c8DnNnXEFv9Qz4wiJ44tnffz8FVcJ?=
 =?us-ascii?Q?ZWm8EVQK28FUX1aNRhPzBasqNg4DMi4rfjz+iQDnzYUGBspJzRMiVRih3mig?=
 =?us-ascii?Q?jHp1zKLtqJVLTRneFVMa7jCiXqqjAoNezc7TiaatOpIT0MvuaJSApP8EEJn6?=
 =?us-ascii?Q?BXevMZcYObiMMcKRoMSTa+RA72J8O+iH7gcuiHvksq1xKXLtRFlT8JRCcQFn?=
 =?us-ascii?Q?cz6B0HrzvTKfGYFWUEQA/Bj2SLkoCQ/aTl40WepXx3Grp8d2PX70AcokvZXB?=
 =?us-ascii?Q?0Dz3NRc5MzDsQVemqmzWfYuU9YlTjOUK+F+dniWa74eVocCEGZhmnYxVKtzC?=
 =?us-ascii?Q?TVaup5AHOE1gQBBQpKCs5tECa/qmUIjgZrZidHuneyt2nyTOR0msq71my26y?=
 =?us-ascii?Q?V8mivF9qgivDltt1MTR5wTq9uHCxDHxPLxLw+J6uli1dkgP3DXHLSDwr9BX1?=
 =?us-ascii?Q?aksjb5hxuXTIFmA/Sj/SQfM5s4IBfP+WD/DYz0nKZJHoAyKAphwmvwb5SN2n?=
 =?us-ascii?Q?M8d4iJyw4sO8kzFNf69i+aJ08DDE2nsmSFQGATPF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc8e6f-8b47-4373-7fcb-08db2166b50c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 12:55:21.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHuUmPd9ofZKTqLgKrs4G0GHxv/OXRyCVA3DwbOAucu3Cl1aAEdEtng7wStpkuYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 09:36:18PM -0800, Nicolin Chen wrote:
> > Yea, a vmid is only allocated in an S2 domain allocation. So,
> > a guest allocating only S1 domains always sets VMID=0. Yet, I
> > think that the hypervisor or some where in host kernel should
> > replace the VMID=0 with a unified VMID.
> 
> Ah, I just recall a conversation with Jason that a VM should only
> have one S2 domain. In that case, the VMID is already unified?

Not requried per-say, but yes, most likely qemu would run that way.

But you can't just re-use the VMID however you like. AFAIK the VMID is
the cache tag for the S2 IOPTEs, so every VMID must refer to the same
S2 translation.

You can't mix different S2's with the same VMID.

Thus you are stuck with the single S2 model in qemu if you want to use
a userspace CMDQ.

I suppose that suggests that if KVM supplies the VMID then it is
assigned to a singular S2 iommu_domain also.

Jason
