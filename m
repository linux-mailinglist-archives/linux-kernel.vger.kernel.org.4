Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28119676728
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAUPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:35:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6728D1C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG8TAdsl6E5k3GGQ6baB0StK007PJy9k92xEBM5dsrk9N8Qlsa2aFergZOEaX3w/x+fSxnAofAaIFEvzoATls2xqBjuiB5MvJYdp26BWTS/7lDHnu+1bo27eNityo4gPSBS6DIh+/hNbs2LAvkBU5JiM0IoBpGbhfkbNqEBP9DUNu7r+o1ZU6y5H/O5NPA0Qd9RAyLqMx6zkWn+M7KBviACoTEhd1q7WWnDhI5+0iQ7L+TlPVD44lgIdMd7hlElj6fRipogBx2pm+XOK0T5S5yldwMIu8hrtpPyQjVedCcbMuYBT5xWGMDyv7hL/ikFDhdsbxe28OjO/p2FZ8Y3sDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmNd72rmJuGRAgWmxXV7bUbvQ5oB1ewDHCzYuVXbEC8=;
 b=L2BcUhZ+HFUTh1BjE3GuDS8zXS8JAHRJKwCQZe7nr5aOL+j1hpi1PAMCXNTDylKwCFv7y7yWccy7LU/ZlB6BuRxIJ/ZF0o0foM1wFdkDBEcCVd6Ezf9B3HIy0F4vxuZRRSIMp+DwgIoQ9KWGRPR8Y+C8iXQ8b5Wo9som960Oh45hi1FiSrcBWkRmHmV+Yh8I2p5FiL5fFxW/pE10F1hoUEUVEQfxudkVcW3rRbu9syKuKxmwI8XqGlA67QckeiLs/uDto5C2DJWI82ZNZpCn3gONfD6RddJA9lKkJUEJ0L67kixhpBXHxvA6eFcfG9ve8oFuwdLV7SPD3fjYot+/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmNd72rmJuGRAgWmxXV7bUbvQ5oB1ewDHCzYuVXbEC8=;
 b=maCaYhS1GKsnTXPonhBDy6IsKBwOAq0CtlnN9aRCcRuM9obT1CgzQf5rdbG/r0woenzUk3Ar5Hy1OfvXb8kbK7CenJXgYo+VcbShwM/fVHLpCV3pn0kiryuNdFYeASfXvM3TmzqyERb8NqiFCWTeAVjySd4fMHHoFhFqCXrmhP5bRjhDV88Ny41zWxT+SYhUi2//1H3Ks6q+ip/klLSg2PCjKWdeUwEqrEE8FrszYNbsmD41kxKhj21h+O4BLq/zQtsFYiDwOBe+sKiEjNm/vJtvyKJOPNaqqJtI8r2EzT+wVVQ5LU5agmD9xGC2DR1tKAU9JpHjfkk0c4wGE3C3qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 15:35:50 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216%9]) with mapi id 15.20.6002.028; Sat, 21 Jan 2023
 15:35:50 +0000
Message-ID: <c0fccfce-17f8-e25c-ca21-41ce1ffd54dd@nvidia.com>
Date:   Sat, 21 Jan 2023 09:35:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] KVM: arm64: vgic: Fix soft lockup during VM teardown
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230118022348.4137094-1-sdonthineni@nvidia.com>
 <863588njmt.wl-maz@kernel.org>
 <28061ceb-a7ce-0aca-a97d-8227dcfe6800@nvidia.com>
 <87bkmvdmna.wl-maz@kernel.org>
 <2e0c971a-0199-ff0d-c13c-d007d9f03122@nvidia.com>
 <86wn5imxm9.wl-maz@kernel.org>
 <b3bf3a46-410b-a756-dfd9-ee74d5dc31e0@nvidia.com>
 <86r0vpmn5q.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <86r0vpmn5q.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d73a813-1621-4283-4836-08dafbc52cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A5p39EIpJCafkBrab6F2xlyGeLZE0vkzUNythDxAhcEeUzpFxgMMLGsFN3SV8jN1PF07aBKNr2LWPcCOopeemZKdy1OUpqDJncmeO8npUbydv4THbAz19Y2jZcR22VPFKbhIA2B/guONi49WNgxj+sYEcsigEfm1uHan/5HibA5V9RaBOkoF1S/KaLFPZWK4TsRng8WK7rPFaIAy1fgwSHS7csjVyKN2HRwJe2M3ZDIMzqCros88sgA0CDakZqs+eWpJmVVcssCF0iDrHSwrYt/WvLuPQTVb2NRaqvcI6/03pBVIcay5zQQivSdW7jKbkMTucBLlu3uZ0YxJDNpC6PZTSuRbIvuyo8H8fyGuDs16HxW4z95q4v5qWMSAtu+UyUx4WVbTQPkatz/ce038uOE2aTwAmTqsMnR7s2yCQilK1shmauZ8kyDeymQI1PSko3NoItQ5UK273hWRWfH7vMRaGeovFT+Y+mCsSEHB10OM3+ryUWznVKCZGQM8Q+rmkDo7MyXxfZUVJ7FZKB7zd3CsqkOlEKltR9SUWRrEmmB672jB0Ji9OrzubowZQk9jF1NV9q4WXjr8OCkSW+jqdZjKBBflXnFmMSRNa0RBLeIhxfG9jNnMeIksZRbetLuaCkO1j3B+1Kbf5WDnF4y/fZpBMqqI0SbLgzxaCMdJQ0YVworkr1O5Z7LrB1Ot2Sk4YQpFcC/fZECX9/c1o7nLvl6yRGfs9kTx4D1yg4n25U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(26005)(8936002)(86362001)(5660300002)(186003)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(6506007)(2906002)(2616005)(7416002)(478600001)(6486002)(53546011)(38100700002)(31696002)(54906003)(36756003)(316002)(83380400001)(41300700001)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBPN3hTeVlpSFdmeHY2bVNnQXJKYmk3WDE5dUdFZU5DWDhuTlBSb0hSdFMw?=
 =?utf-8?B?R0hXSXV4WUVkYlNVVitoejlxUllORkpLYThjS3pwZE0rMnJuZGZNVHJkWkhh?=
 =?utf-8?B?S2tvS252Rklwbms3MngwalRUMlE1ZHlIcWNubDBEVFI0MDE1MDc5WkVtdDFP?=
 =?utf-8?B?MEpiZUtlU0ozbjRMdGdLM1hBbHJkd0VXUjQxUU9YZys1V3QvZ3JQbnpQTDBC?=
 =?utf-8?B?Y2YvM0hCcW1PM3JKM3FWYnBjeGRETjQzSUcvT29mVkVpdk1VaUdVeiszQ1Iz?=
 =?utf-8?B?TDJnTzhnb2V5L1BKOS9OWE1WaFJyZGhDVUZZYUxYcVR3WVpRUi9TTGpHa2R1?=
 =?utf-8?B?SUlnK25jZi9KcWprOWtvemdQWDVKV0drNzBPd0pNeVV1bERhdGtFeEI4UEgy?=
 =?utf-8?B?Y0g3aG5UcUxvdHBoME4xeWFDcHgxMnNpT3lmcDFnVng3eksxU1NicUNmd2RV?=
 =?utf-8?B?SmVFQWNvaW85WllURXR6UUYwUWtTeUxtdmVGMzVISlAzVm5GV0VpTUJMSWVH?=
 =?utf-8?B?ZlVhSlJEdHFMNS9rNFhKVXVpaHUza0pQU3FIUnpKa0xVMHVNTXFNSG16Z2hi?=
 =?utf-8?B?VlBIWlZ1MWtBVE1rNEswTUcxS0FCSVdxNldvZjZKQlhKUzdHNmpmUUlRdjl2?=
 =?utf-8?B?RUFGN2xXbEhCaWlnR3BuQ2FpemxYSEptakZZb1FGWXFzZmE2bm5SaVh2QVBO?=
 =?utf-8?B?bG0vSVY1eGxibFF1bTJwQ3V4MFkxdnoxdjlsRzF3S0NJU2EvdmJwUE1DV2NM?=
 =?utf-8?B?bXhQbWZUTEYvSHJNUmJiek5JSW1iQ1RmUDR4TzBOT1pTazc2U2FSa1FBc0la?=
 =?utf-8?B?bTZSWWtlajViaXJzYm9sRWdOREFwWExIMUR4YmYwT1RIc3NITmR6ZExqajdn?=
 =?utf-8?B?T3hKcDR6dmxQa2VsTU9DQTdIdUtSRDFGb1pFdVNNOXV6UkM0a3FRb1ArVEZk?=
 =?utf-8?B?OXBJOEpHMlV4S2MwSmV5K0gxTUJIMjNiNEtYN2F3RjR1RWVSbnNncXRJclFp?=
 =?utf-8?B?TUZMTE1jVnZEYUVpdmpqWGUwWk5mS2dwbDQ4QjFGWm5MdGJMTEVJZ0NQKy9G?=
 =?utf-8?B?NHAxcVhLR3Z6THJpWmdxTGpSK1NJdEFaMDlVZkdtODhuMWV0MFdNbW01Yk14?=
 =?utf-8?B?U0lGSjJwNzdqbXlmclkvdzNadkhhZldaNE9SSUM5UVRtcm1DWFo1QVVkYTJO?=
 =?utf-8?B?RU54NUtkVHBDQ0Jyd1ppa0tLQy9OTUlmdjZucGc1Tnd5d1dEUzhrTnpZQmpt?=
 =?utf-8?B?VmpLTU1NOUFtSll5WGIwaWVrZXdTRGJqeXBNMFVmSElSZWRVSzZPVC92YW9J?=
 =?utf-8?B?c0wvWlVrWUNSL1hJc0NwZE9rQjJJLzdaQWh0QWwxUmRtcHZTT0U3aUZwZUcw?=
 =?utf-8?B?ejYzekRITU9XdTN3ZGFkZG5jZG96N0tCaXFtZkdIMENxZkh4WGMxTXFDaEFL?=
 =?utf-8?B?bDcvWml2V3ZSNDRUTTlaK0lHUDZzVUJNbE9lOEx4VDF5MXVXK1BvZVJ2WFhU?=
 =?utf-8?B?dmdkeGxxMzZiRmhQT3M0VTVuaVVZWmpRRmtpMDlDNXVVcXhzaDlNQTdndFI1?=
 =?utf-8?B?WncrZld1MnVGZ0tJTFQ1eG5MSnpaRW85YWNFU0JCZndkT0Z3M2hOOTZOTEJH?=
 =?utf-8?B?a3E2VngyL291L1c0UGZvNnZPa01PcGtwSDNDRUZ3WHpEamI4TW5XRlRnaVJP?=
 =?utf-8?B?WHV0MjlUMllGcER3SUc1eUg3eHBEOEFyaDBaZjQwczJsQmI3M1hKK2ZybFVX?=
 =?utf-8?B?MllXSkNxdDFUVXQ4bjZhOHhJWlBmN1NDOGZuYmhhSDFCTGhXN3BsejFwa3RK?=
 =?utf-8?B?SnZrNkxVbS9Db1pRWTFDVVBYcmtVb1UxeU5NNDBid1dHeU5wUWthaEVadTdh?=
 =?utf-8?B?SThzVjBGMXV1TDZFSm9DK2lzNkViSG91cDQwbFNvNXlySGVTUGhENmVxVlcr?=
 =?utf-8?B?MFpQOTFqZWJsQlNnNzNxZzh5bVROdEJxdVlacHYrOEZyRkllWnMvU01BK2lm?=
 =?utf-8?B?THk3bEZDbGF3eVpKNlFiRHNud3hDYmYvVm05akVVMjNxc1NqcGJ3VGhkdUda?=
 =?utf-8?B?NktpRlBVcEE5aDBUUHlkTnN1blJUY0xkTVcvdGNkVG54VW5iOVRwc2h6VFpX?=
 =?utf-8?B?YzNxNzRuUmJQMExaLzV4RU4ybEZFczlrSk5PV3MzM3FSRlZUVytncWN0Rk8v?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d73a813-1621-4283-4836-08dafbc52cd6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 15:35:50.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYP94+cU3OHmwjWR0hJdPqlsSONegCu5olTRlZaFXdhNUMII5Y3mzkO8JztWskUf0zqLZd+uuYD6jMtRMDMZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/23 06:00, Marc Zyngier wrote:
> What I am asking agin is: is there any overlap between any vgic ioctl
> and the teardown of the VM? Do you ever see kvm_vm_release() being
> called before kvm_device_release()?
> 
> Because that's the overlap I've been talking all along.

I've not observed overlap of kvm_vm_release() with ioctls kvm_device_ioctl(),
kvm_vcpu_ioctl() and kvm_vm_ioctl() for 3hrs. Test created hundreds of VMs and
teardowns.


Debug code:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4f26b244f6d0..9c8409a894f5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -800,7 +800,7 @@ struct kvm {
         bool dirty_ring_with_bitmap;
         bool vm_bugged;
         bool vm_dead;
-
+       atomic_t checkoverlap;
  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
         struct notifier_block pm_notifier;
  #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9c60384b5ae0..a5a9071aeb19 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1370,9 +1370,13 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
  {
         struct kvm *kvm = filp->private_data;

+       atomic_inc(&kvm->checkoverlap);
+       pr_err("%s(%d) start kvm=%px\n",__func__,__LINE__, kvm);
+
         kvm_irqfd_release(kvm);

         kvm_put_kvm(kvm);
+       pr_err("%s(%d) end kvm=%px\n",__func__,__LINE__, kvm);
         return 0;
  }

@@ -4073,6 +4077,8 @@ static long kvm_vcpu_ioctl(struct file *filp,
         if (unlikely(_IOC_TYPE(ioctl) != KVMIO))
                 return -EINVAL;

+if (atomic_read(&vcpu->kvm->checkoverlap)) pr_err("%s(%d) overlap kvm=%px\n", __func__, __LINE__, vcpu->kvm);
+
         /*
          * Some architectures have vcpu ioctls that are asynchronous to vcpu
          * execution; mutex_lock() would break them.
@@ -4346,6 +4352,8 @@ static long kvm_device_ioctl(struct file *filp, unsigned int ioctl,
         if (dev->kvm->mm != current->mm || dev->kvm->vm_dead)
                 return -EIO;

+       if (atomic_read(&dev->kvm->checkoverlap)) pr_err("%s(%d) overlap kvm=%px\n", __func__, __LINE__, dev->kvm);
+
         switch (ioctl) {
         case KVM_SET_DEVICE_ATTR:
                 return kvm_device_ioctl_attr(dev, dev->ops->set_attr, arg);
@@ -4731,6 +4739,8 @@ static long kvm_vm_ioctl(struct file *filp,

         if (kvm->mm != current->mm || kvm->vm_dead)
                 return -EIO;
+if (atomic_read(&kvm->checkoverlap)) pr_err("%s(%d) overlap kvm=%px\n", __func__, __LINE__, kvm);
+
         switch (ioctl) {
         case KVM_CREATE_VCPU:
                 r = kvm_vm_ioctl_create_vcpu(kvm, arg);
