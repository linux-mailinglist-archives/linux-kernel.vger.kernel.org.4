Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34653676721
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAUP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAUP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:28:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79C2BF2F
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:28:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYIE+KWjW91x4WD+WfEiKkvrQD3zAO1ilz+At5CGKyybAtew/cyIYfg2yf4wI7/I9I8VxkbZwki8OzUy2J3imj5TnV/ETlXp4GNLktfV54RVP9CBTnFjwvVS9X/C92HDe00cVX58Llu++wd+/PesYP+bNQbFVWaKLb0TOZCoYcs5XaFzzeeIAJ5NBETJXu0pptiTfm/RV+/VCPg6xqrHbUSajdSn87ThvPIT0oi+ZSiTA85psEeFEA4B+66ULibBSDyLe1lDcSn5FfyloWHeugRkxtfD85NHm93ttzxp09PgmuZEOFBryjflyNh5SE16gLmWy1VgWCpFR2kP/pX6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmNd72rmJuGRAgWmxXV7bUbvQ5oB1ewDHCzYuVXbEC8=;
 b=MdirNRkne9O98TIQQ1qXv44MLrToV+uT1nxeaqufYsvLo8+uumSQji/bgBZ+7dRUhk7R1JUG9+xv6QgnH0oEO5L2vfUvam3gFjre03EcxPxmkW1vlE6NnFsOSQj2nOKaKrsNhi0039h1qwJ4ojPC5EXUETDl9A/cOhd6QSvIfNqdsRUv95osNI/iqy7cFOq4X7Bk7jyItD4bC5aUWQCn4cp8IVOzQ3yrwEp9hBmVoX7vPMzfBNIbo/TPUGGq7aYyjdNCZpf8qmnOKt5N3Z6M+qK8ftnDkIxNqKwxStb7/9SCxWrOIY7OCFt5WRnCSqI5cxh1ltKThCq0wdtd3YN6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmNd72rmJuGRAgWmxXV7bUbvQ5oB1ewDHCzYuVXbEC8=;
 b=A9+2/AiaY7NeAsUdooFSWSnj/NFzDhgq6gjeEGd+uLTCvFUy1WFmYe/o6IyW4gZqy/chYqTbJpqoAc+5zMDZeMOHPkH+cPnn0XnRWgNXErv39ZUIGNisNb6XkhYXMP4Zn/9gcX46Vjc7DNHGBNi1As2ve8gXiBHMuVAQ8+xn9MXy0oI44lB5mD6N8W5uY1YOZg/JEuoz6It6SfwsNBfyBqmK1dXO+2+e2cuu3NnrevMlFQcHG8d6Av/UzjqwnY2tsMDAJfx4b85eycavz+q139wZqxfcxibd12Z26XdixLuJPgm9wWEeEyAPHWnSCQVX7D1wuu3cFUuWN/ip5ft/Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 15:28:50 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216%9]) with mapi id 15.20.6002.028; Sat, 21 Jan 2023
 15:28:50 +0000
Message-ID: <29a33dfb-e70e-9ebf-ed60-ce04670dfe83@nvidia.com>
Date:   Sat, 21 Jan 2023 09:28:47 -0600
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
X-ClientProxiedBy: SN7PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:806:127::18) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 485559b3-4ca0-4df4-8c24-08dafbc43205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJtRcGT1NPCmtxTiUz5m5NI1Jp/Rx1QDSP+12m5f+KphrDG46FwTf3Cr+YazV7JU4NdUhpA/037IfauCG0FOclb9DG2owUlD2AjB3yMrplbNdXXaRV4ZOH+uB8hQ/Tl2NR1PpAAo1ApsSHR5oNWTbFJLcRQdz871mz34LnxTE4UprlfJr4QdPezK0LmVUI35VNJyEgDwWNfr8EYSVIdVlx0V/qEyku4jIgaYX/EXnlQm6xQ/A5q0Imk4wygiSudMNvNxc4u1PQ9mV2EeGYReQYTw/6PVCHUV27iX2FgpXJpi0pxeczTYfKDxywq4iyTFmSyOqfWinLkoUD+rOxCeDXZn16iiEI+R6LuE47ue8+U5Pa4h5jqmHiWzX5wc2FCYiDvGa5nbKdOClhB8LcbsY5o52P1NmOKplz7Eh+4+Eksi+by8jeCY+rKD6qdl8BkadiWwJaBVMDNieytNaeugvzUwA4vXvQ5brooI02wA5jLbJS9hIvr8IGFdNm2+K9XHsGOgfDy2LSd1fbDMFtJfi1WLZ7Gbr+rqO1PhW8i0NIKOev5V9HItCRWq8BQb+z06DNMDMMCYmK631ZqdVOsyD9fvDC5Cm2n0rZZD8rDjS7UAdabyeQEiKfESgJ5stf9yni/7uhlV+AVRSrox6VYNvdT21LzYrQLd/6C4OEXtLCwUEWxVtHBOEb80Eu1N8zsliExAQNAWQASuFY90OR0UqrvmdXLSJAmIV9rPQEc8PyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(86362001)(31696002)(2906002)(66476007)(186003)(26005)(6512007)(4326008)(66946007)(41300700001)(6916009)(8676002)(66556008)(2616005)(478600001)(6486002)(316002)(6506007)(53546011)(6666004)(54906003)(5660300002)(38100700002)(8936002)(7416002)(83380400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citvV2crbWRwdC9HZ3JybURxYjQ2dXVJUFp4dE02MmhhcENqWEFqL0JSTFd6?=
 =?utf-8?B?VVNwSHNMY210OVNIYkhneUIvY1pyY3FvbUhHYUYzRTg2bmQyTURqZFJqYVFr?=
 =?utf-8?B?TXlnTHE4MnI4dzhsT1lTY0NYMnIwMGxlWlRBWFZSVFFKaGo4UzNlcmdKazNp?=
 =?utf-8?B?RWtSd0VoZVRXWEY2MmZKN2toOVJDSlhXb082VHEyVkd0d29wRkZ3TkQvZThy?=
 =?utf-8?B?a0Y1TDRmL2FJenJnYlRBK2gwWFluaUp1ZENmZzk4ZWl4d2psa0owYmw4Y3E5?=
 =?utf-8?B?bDE3TUJmeTNzdGRLUjBjRXRDd0ZXa0tBUTVscmFUVkNKVzdTTHRKakk3NEdW?=
 =?utf-8?B?RjJUeGxLdmhrWnN1bForL0pTWVlPNno2N3RnK1BFWUlrRnU0VUVRU2hKcVl3?=
 =?utf-8?B?c1dBRmlkbGtkanZiOHp5ci81VHpIaWxmQTAwNERwaHRWVkJadWRQMmhOWXFN?=
 =?utf-8?B?WWtxb1IwdTdZN2pEYzdrMXhmVzZib0lHa2F4WTY0RXVUVGVmL0lxRjF1T0s4?=
 =?utf-8?B?MEFHaER2bFQ5RjFnb3RWZ3hySHdSUXVXcVd0T29QVURYWkY4b1dQR1pJV3kx?=
 =?utf-8?B?bUwxbmFMMzF0VGl6UUNGOUJNN29ROFYrMExiZ0hRSEUydUZsSDA1MkZ0OERp?=
 =?utf-8?B?UWVSTUs3dDQ1azhLREdGWStaSGhFamR2cTRSbkRNUlhRVUh1OHU4WlVUTjBz?=
 =?utf-8?B?ZU95YVJZQk9VWVlyOHc3VkRsVzM3dCtqQ1N0WmFLd0QzcFl2SmVpOTY3VjBE?=
 =?utf-8?B?VVUvVW1XRWtMd0Zrd09qRVhaNVdJMWUwRTZTSHRNWXVQSjlvVDltRUphUjU1?=
 =?utf-8?B?THJENUhqTnkzRHZnYisxWWEvWGlxZUFBR001cFVoY01qandjRlhwOVRYR3Q5?=
 =?utf-8?B?MkxmcGZ4c0ttRE14eHN2UkVveFJpV1dtWXZnT2pHeERjR3IvTW1URzB4Zi9t?=
 =?utf-8?B?bHFkamZYYjlTb2RzMVVLeitJZGJLQk1TTFB1WHdRUHd2cjNHNTNQVDNHcXRT?=
 =?utf-8?B?Ym1KbTN3MHFXL2xWQllNZmpJbTZ4N1BaOWluWWE3a0FHUGVEdGhRamgxOE84?=
 =?utf-8?B?c21xRXg1bmV2UHBsaFJIeENleEF1TWp1MXRuZkh2TzV5YVdUT3k3UU5ocURP?=
 =?utf-8?B?RVlPSzM1WmdiYTArbUs3M2RnRVhScW5VdmM3M1c5eklhZnFBbFlZL3ZLT0g0?=
 =?utf-8?B?Q2xwWGk3Z1M2SmRKWk5ZS29BdU5sVXZUb29vbS9ZekRIeVJYa2ZoaE9iaENw?=
 =?utf-8?B?STZoTjV6YU9Xc3d5OG5RVVFsMmNSWUJQTi92M1VKMzhJU3VYYU5CR0tNdlJ6?=
 =?utf-8?B?ckhoamVSc01XSkM0a0VMRWhSMFV5Q0QvV1MrQTF1U21UZFVteGJiKzVzNTlh?=
 =?utf-8?B?RXFQeDhTNStuNTNlWHNTZFRRbXFtSStVcUpwT0NLMUJ5OEYzWHM3c0U0V2d4?=
 =?utf-8?B?aDZWRTI3Qk44bGhkalF1bllBMmNqWmg3VWl2Slo4Yms0K1ZQOVZ4eStSM28w?=
 =?utf-8?B?eVZZUDV0akZvbmV4Ry9Ub3ZEemhHLzN2YnV4UWVmZUFSOXJ3bzRGRXBlMzVW?=
 =?utf-8?B?NjlFV3o5TXNDTElTbVN1akZzZjFhZGZpTFFCNjEwd09kZjNpTkNlMTUzeFhJ?=
 =?utf-8?B?ZW03RGtVSEprZ3pROVNCWjcrZFZ3YWpRM0Z0NlZEeHp5S3dTeFkvc0I2R1ds?=
 =?utf-8?B?d0RiOGhqOTNsZlpoMW9uUU1CNllldVorMjdkYmpQdm5TYzJwc0F6aW9yS2JC?=
 =?utf-8?B?WmN3aTNncVkzZWxFeDJoODJEZGQ3cTFqQzJDcHQ3bnNlR2tueXpRblFaOFZH?=
 =?utf-8?B?dkg2NXBWZW1mTTk5enhmS2V4NGx4OVpEQXRkbXpCRVh3TW0vbDViWFdZYVlj?=
 =?utf-8?B?SDFldEY4Z1IybGRoQzJuM09QcVduZkdKdE5IVjV5TTRndDk4dzhQTkR5aXpr?=
 =?utf-8?B?TG5acjdwdGVjaG13UnA1UVNaWVFjQzBEYldYN2xkc2swSnhuemNTbWpTR1JO?=
 =?utf-8?B?R0k2SThZTndaSElMMjFMeW5LR2p5dE5ZRVB5eU5Gd0hUc0QvQk1ldW5FWUpv?=
 =?utf-8?B?Y0J0QVMxaW5HNjYweGVPajRSamJ1YnVaTXpRNGFPSFRub2NyZE1nYlliajJl?=
 =?utf-8?B?NkpMVXZNUlZrQjlyMlFVUk5XeTl1NlhzUTJLVHBtUzdCZ3MrUjdHWlJsbmZo?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485559b3-4ca0-4df4-8c24-08dafbc43205
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 15:28:49.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPbIVzQq9yF+zeAL2Rm62uYokzKP0S1zqDJd8EOtzc6PgANXScwhotBtmxPIPGLov526aP8mOeE5OxXxAQ5q4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
