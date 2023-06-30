Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0282C7442F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjF3Tvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjF3Tvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:51:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878173AAF;
        Fri, 30 Jun 2023 12:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiJRRLFbjo1NkMzqJxdWioA/aW2FEd4/wt2FJUGOBwMK2vaeObFPUnY9kvWW1cojwOjyb+trvAqVIt2k8j4ac9iJnV4TlzADd90myQ7+iy/phcZsaAI92PYyOfxMVJRLDt/fHdVvuWJcgD75XtJJSZWGokGSV2nsULbrXYasF9vEoq8oYa2w6UB1yr+CkJXhT9NEvdCthCSzgiJN3JSgVezc5O1p2wCyDMfV8xOUYMrndYZc5AXS5Db9d0poWyfDKQ3FctHrJZ+ilCKaWdRdjzdqq/0whQmtMLkEtlLzBQQJNCNUiE57UvnO87HKXKhLE0CIHH6Z/TJ5je1yvPR8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5aoTnQLhDsGSVzQshI5fUoLObMXiHZkXIUD+Vqcl8A=;
 b=H6msGWIC2ZqVwoDCpPTTNZDyCTDxduaKKdeOO8tR2Z959M+tt9riGzbp+/gox1hdrDJ41l3JHV2EVsCHyZhy6iFJo7jAUbRlAeCOe7aW5wHg4iYqqTH5XhAg0s6rIdn7S+jCthDrC2P9rB3QTujTo+VzMWrVsFAviDGJzQv4X0VMAWIYM2s2bJliboX58JJRBbEOtwliwKZGyeBPNkf9RlLH3KXgCLYhcMqrDXYvFnlyYOpr6llO1ryj2xE70DJy5ms+9jX3FvWx+e4DiZaCyTnwlOF3f2Jq6gNswE2vKQ24wcn4vBRuV+mVs9zbpV6F+oW1X8DkPDW87lv/v5dExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5aoTnQLhDsGSVzQshI5fUoLObMXiHZkXIUD+Vqcl8A=;
 b=Ptgy26Cl2BxGw25ok5Diqkt3KkJF0JiQ9L18TXM62cCqIHAkjNzh4zQSYQKZIYCYynAdf+dI0MAWKEOWGBWHjR3ah0VUi/gRB//k/tRF2Vrbna+YhP0FpPXgy0gBIwrQ93HuucKtthTetcdyXwChQYxCC6fbV5OUOlw3G5e33ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:51:38 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b%4]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 19:51:38 +0000
Date:   Fri, 30 Jun 2023 21:51:05 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component
 Register mappings in struct cxl_dev_state
Message-ID: <ZJ8yKV2DkxbhAg+D@rric.localdomain>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-17-terry.bowman@amd.com>
 <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: multipart/mixed; boundary="/4PC/FtqKEXOGDQt"
Content-Disposition: inline
In-Reply-To: <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e8c6d7-4901-44fa-492d-08db79a36a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC2LXpOmiI9llxAjfy0Ze996ZmdjS9kgGy9gZazZof1U0GtDWWwPI+MIzwczNHZj87XUbdKDV7eiBE87MfsCNJy255B2J9zGmbpXwXerlVpWZ1upThshURfEYZcryCUlEc61MLCecLS7QfUM2Q3qisv0VEBEDZAZfcOp7BGehkdDupkADSQD9KYUBezQbdE011Wh07m/0tOgJEH2j6C2tCFWXFRBzGFaJOXSu5XiLC6TDAxFwhoM9DYoWA6tkbzKzsMm4W7LlywHVMVPv0pXKKWDgE/SCz3T4e25VT/lNLXJj7NDS0ZriLtIZ9V2UGzg5uP5hMnywB8AqdHxUhrd/PTQ5/5rOWwBq0916wDOiG8djiMAGnkdwnED0RODBM9h7BsTfbzC3KxHlvfYUI+tQJ4CFMkiNudTQe17W3n72M/cwD/OjqW5ySHp3eIa3iWH/Hfxv4gzw1HpOX+LJ0LNuX7jxcw2B7vq+tNjTlUE8YX/QFrJr5ZsouwaBt5XQMsSCF8N9tV752E9ot+kTxzlg3ALr4cdkKDnrqC+B87sPYSr25ET/vGyiShCLfWo7bX0CrqvoW0Z1riPHCu6De9rhjm2xumhI9zeMfVZvqE/XCZh8woIPwN0ztAI/1dz4zrLg3NdN4KHmTR+6sAV8YF7Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(66946007)(110136005)(66556008)(66476007)(7416002)(2906002)(8936002)(316002)(38100700002)(41300700001)(4326008)(478600001)(83380400001)(6486002)(44144004)(6666004)(5660300002)(235185007)(6512007)(8676002)(6506007)(26005)(186003)(53546011)(9686003)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S0GGHqTAejturOMYr9XZC5zWUBNGSWLvl9dZLi83rU0fW+xOcX+yVXOXbfo/?=
 =?us-ascii?Q?sm8S7lsQnhqrcS5drh+EapC/4FKWxRFr3HoG9oLebnB2+rSMSoj4xSvgnKR5?=
 =?us-ascii?Q?BqPHVggPVlIDEVwUCrrTNaAoXBwI4tm5rfCeghiorg91OheyPbLBN+gYmTUx?=
 =?us-ascii?Q?gkZ2Ue6WL9UlrLwd80PCE8X9h7/WEzobVkGtPAK3x0qv1QZjoPOV93o4Wctq?=
 =?us-ascii?Q?bDErDLitQBSZVR/CchAMP7UY4/9dAPNhnvnQ7jn68p1TOAvz+ZbcpVHjhlPk?=
 =?us-ascii?Q?v0oGYrmMSSHF0ts1ZSaou2kcSzkNPKJQTOcdDJaDdo9O+CUC9nYrmkArZV4a?=
 =?us-ascii?Q?ccHbjXasMautt4HF9frMAJT4WRrzTDa4khmx7o8ssChS+FhqZxWUBUeAYkWE?=
 =?us-ascii?Q?maNsTfIiZXtjjhYN943nZujNZepaKacxFUeKfpX031y71TX2/tDvq1rB3hvm?=
 =?us-ascii?Q?5h0UJRqSlFNs/ZQO0EJcZBfJy3P/aUky577oApeFw5oAZNouQlVx0G5u2F+T?=
 =?us-ascii?Q?HecgyJnc3IO0W+T+peFDOoKySSoWHzdnvW8Mu3ly9ir4z2SYtxFk/RkanePW?=
 =?us-ascii?Q?uavda67RN2zZVrXQcqiPkBMoaYH24l94UJsuhSsl0THPiBS6ZFquEcTkKlpF?=
 =?us-ascii?Q?vKcjBKNhaq6qV5SXLRoR6cqaevw3Qd7ZzJTyB1A/1BEsUEGs6ZiFzMphPHwe?=
 =?us-ascii?Q?k9+qE0zFTMPnZrgVeEwVcKSSN5rQDVC0dTz7Ulu+WwG6CjlfjkBsFhWfxqNy?=
 =?us-ascii?Q?yQwdgCDuUCduqQ7M+13u0oBFa7obQ2GKScaI4zq5HEvG7w8+4T0oGPeIzc76?=
 =?us-ascii?Q?zFkJKxLA8Jc15f5kNWjpTQSy+TaH9APZ57yN3rrdxKg/UpSr4aB2QTzunCwb?=
 =?us-ascii?Q?jcrZoWAUGsmCF1u66k20PHoKmvZItM3B0BfkHWJn//6kJTo+NdAGlSInbwXl?=
 =?us-ascii?Q?hCzQAXBtoYeXdmjZ7LGY4Mu5TSJmXF7PqPkiVTHDxV+O69pGIerp0scPtveO?=
 =?us-ascii?Q?i7BmcVlt3uWm/zGuemqWL5kjJe/fS+SuGT1A62zx/lAe3yuKqhtCp3XmgIlF?=
 =?us-ascii?Q?UtzTgk23blvnTlFBPAewAW3lrUVvkI4f9gFdfa3Nae5shXixvwmtLIn6/fr9?=
 =?us-ascii?Q?a2e/L7zGfd2x9K1wC/lbkLl2Tro2Mhj8HyCYRCu6CjG4zom1qfvMqPs3R+Fa?=
 =?us-ascii?Q?J6O0ePF5s/jpGC5Rlb+nAEfDL++LAyX+YKtKi9DtG7zzv61w4uGkiVAASRx0?=
 =?us-ascii?Q?KvdI+yZpOPQbu/TQDIBmBOemRAclEYjZKpmI2bgq77kqZp1Eygl/tkRVz1Ka?=
 =?us-ascii?Q?4PUPWHiDeXlKAl7UQRMHC+8KMlnsfS/58KNHKfXcqAvT62izodPOipD/H9yg?=
 =?us-ascii?Q?jam2icpF2AFThIQmLzFdDqtOj5pyd1H2HSRbjgFvpV5UPV7pZRok9la9snDV?=
 =?us-ascii?Q?rRy9voWsnGYrZcUXg4j34QjWgiAy5wG+lKafbGDx5JCYTIRQfiFJIGLWX6Rn?=
 =?us-ascii?Q?l+S0E7uC7KTRnJEr0eDowMegLhENaQs8x0gWVYjHKzXQZiAU5buo4fKATCg7?=
 =?us-ascii?Q?uwZymnDYVJCW3HTjLKg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e8c6d7-4901-44fa-492d-08db79a36a74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:51:38.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoFLmgCi7xzAN9aIz/U6/2+aMgsHcQHioj3xcw+AKXO9PPnUPCjycSnz/PiOBkZBz8MOkaoGyWHCkWUh6nQotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/4PC/FtqKEXOGDQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dan, Jonathan,

On 25.06.23 10:38:26, Dan Williams wrote:
> Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > Same as for ports and dports, also store the endpoint's Component
> > Register mappings, use struct cxl_dev_state for that.
> > 
> > The Component Register base address @component_reg_phys is no longer
> > used after the rework of the Component Register setup which now uses
> > struct member @comp_map instead. Remove the base address.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I could fix the HDM initialization failure. The check in "cxl/hdm: Use
stored Component Register mappings to map HDM decoder capability" was
too strict and did not return -ENODEV as the previous implementation.

We will send an updated version of the remaining patches.

However, while analyzing this I found the following:

> 
> Starting with this patch my QEMU cxl configuration fails to probe the
> device:
> 
> # cxl list -Miu
> {
>   "memdev":"mem0",
>   "pmem_size":"512.00 MiB (536.87 MB)",
>   "serial":"0",
>   "host":"0000:35:00.0",
>   "state":"disabled"
> }

I have looked into this and it looks to me that the qemu model is
wrong. I am referring esp. to those sections in the CXL 3.0 spec (Aug
1, 2022):

 Figure 9-14. CXL Link/Protocol Register Mapping in a CXL VH
 Figure 9-15. CXL Link/Protocol Registers in a CXL Switch
 Table 8-22. CXL_Capability_ID Assignment

In short, the CXL capabilities are wrongly assigned to the various
component registers (component abbr. taken from Table 8-22):

ACPI CHBCR (RC): 
 * includes RAS cap, misses HDM cap
 * expected: no RAS cap, includes HDM cap

RAS cap does not make sense here and is unused.

logs:

> [  468.239319] cxl port1: found RAS capability (0x80)
> [  468.240186] cxl port1: Unknown CM cap ID: 4 (0xd8)
> [  468.241083] cxl port1: Unknown CM cap ID: 0 (0x110)
> [  468.241974] cxl port1: Unknown CM cap ID: 6 (0x260)
> [  468.242876] cxl port1: Unknown CM cap ID: 8 (0xa84)

CXL root port (R):
 * includes RAS and HDM cap
 * expected: includes RAS cap, misses HDM cap

This causes the HDM for the root ports being not properly initialized,
kernel switching to fallback mode.

logs:

> [  468.250182] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
> [  468.250258] pcieport 0000:34:00.0: found RAS capability (0x80)
> [  468.250371] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
> [  468.250413] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
> [  468.256022] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
> [  468.256058] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)

CXL 2.0 device (D2)
 * includes RAS and HDM cap
 * works as expected

logs:

> [ 1396.813184] cxl_pci 0000:35:00.0: found RAS capability (0x80)
> [ 1396.814133] cxl_pci 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
> [ 1396.815081] cxl_pci 0000:35:00.0: found HDM decoder capability (0x110)

No issues here.

Details below.

Kernel:

version: 0c0df63177e3 Merge branch 'for-6.5/cxl-rch-eh' into for-6.5/cxl
cmdline: 
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3 root=UUID=8b447531-798d-41cb-a3df-ae1d9bb1eaf9 ro debug ignore_loglevel "dyndbg=file drivers/cxl/* +p" systemd.log_target=journal

Qemu:

version: QEMU emulator version 8.0.50 (v6.2.0-12087-g62c0c95799)
cmdline:
/usr/local/bin/qemu-system-x86_64 -smp 6 -machine type=q35,accel=kvm,nvdimm=on,cxl=on -hda debian.img -m 4096 -enable-kvm -object memory-backend-file,id=cxl-mem1,share=on,mem-path=cxl-window1,size=512M -object memory-backend-file,id=cxl-label1,share=on,mem-path=cxl-label1,size=512M -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,port=0 -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-label1 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G -vnc :0 -nic none

Annotated qemu kernel boot log after loading the cxl_acpi module
(including deps):

> [  468.229977] cxl_acpi ACPI0017:00: root0 added (root port)

root0 added.

> [  468.231055] acpi ACPI0016:00: UID found: 52
> [  468.231959]  pci0000:34: dport added to root0

add_host_bridge_dport() found the CXL host bridge and added it as
dport to root0..

> [  468.232867] Unknown target node for memory at 0x190000000, assuming node 0
> [  468.233901] cxl_acpi ACPI0017:00: add: decoder0.0 node: 0 range [0x190000000 - 0x28fffffff]
> [  468.235394] acpi ACPI0016:00: UID found: 52
> [  468.236171] acpi ACPI0016:00: CHBCR found for UID 52: 0x0000000180000000
> [  468.237193]  pci0000:34: host-bridge: pci0000:34
> [  468.238132] cxl port1: Mapped CXL Memory Device resource 0x0000000180000000

CHBCR for the host bridge was found at 0x0000000180000000.

In this kernel version it is bound to port1 (not the dport), some
comments on this later.

Component registers and capabilities are extracted from the CHBCR:

> [  468.239319] cxl port1: found RAS capability (0x80)
> [  468.240186] cxl port1: Unknown CM cap ID: 4 (0xd8)
> [  468.241083] cxl port1: Unknown CM cap ID: 0 (0x110)
> [  468.241974] cxl port1: Unknown CM cap ID: 6 (0x260)
> [  468.242876] cxl port1: Unknown CM cap ID: 8 (0xa84)

The CHBCR does not contain the HDM registers for the root ports.

It (wrongly) contains the RAS caps.

I would expect HDM here instead.

> [  468.243767] cxl port1: Set up component registers
> [  468.244959]  pci0000:34: port1 added to root0

port1 added to root0 with the component regs from the CHBCR bound.

> [  468.245807]  pci0000:34: host supports CXL
> [  468.246711] cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
> [  468.247792] CXL bus rescan result: 0

port 1 added to the cxl bus which triggers cxl_port_probe:

Running cxl_switch_port_probe() for port1 here:

> [  468.250149] pcieport 0000:34:00.0: Component Registers found for dport: 0x00000000fea00000

The CXL root port was found by devm_cxl_port_enumerate_dports().

Its component regs are extracted:

> [  468.250182] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
> [  468.250258] pcieport 0000:34:00.0: found RAS capability (0x80)
> [  468.250371] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
> [  468.250413] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
> [  468.256022] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
> [  468.256058] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)

The CXL root port's comp regs contain the RAS caps but also (wrongly)
the HDM caps.

> [  468.256065] pcieport 0000:34:00.0: Set up component registers
> [  468.256089] pcieport 0000:34:00.0: dport added to port1

CXL root port added as dport to port1.

devm_cxl_setup_hdm() is run for port1:

> [  468.256157] cxl_port port1: found RAS capability (0x80)
> [  468.260800] cxl_port port1: Unknown CM cap ID: 4 (0xd8)
> [  468.260833] cxl_port port1: Unknown CM cap ID: 0 (0x110)
> [  468.260865] cxl_port port1: Unknown CM cap ID: 6 (0x260)
> [  468.260898] cxl_port port1: Unknown CM cap ID: 8 (0xa84)

port1's comp regs from above extracted again for HDM setup, but...

> [  468.260904] cxl_port port1: HDM decoder registers not implemented

... the HDM decoder could not be found. map_hdm_decoder_regs() returns
a -ENODEV.

> [  468.260915] cxl_port port1: Fallback to passthrough decoder

cxl_switch_port_probe() continues with
devm_cxl_add_passthrough_decoder() as there was only one dport found.

> [  468.261024] cxl decoder1.0: Added to port port1
> [  468.267186] cxl_port port1: probe: 0

Probe success.

> [  468.298485] nd_bus ndbus0: START: nd_bus.probe(ndbus0)
> [  468.299859] nd_bus ndbus0: END: nd_bus.probe(ndbus0) = 0
> [  468.300840] cxl_nvdimm_bridge nvdimm-bridge0: probe: 0

End of log. Full log attached.

Loading the cxl_pci driver later succeeds, cxl list shows:

[
  {
    "memdev":"mem0",
    "pmem_size":536870912,
    "serial":0,
    "host":"0000:35:00.0"
  }
]

I am not sure if the issue is a qemu config or implementation issue.

Please take a look. Am I missing something here?

Thanks,

-Robert

--/4PC/FtqKEXOGDQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename*0="dmesg-6.4.0-rc6-rric-00055-g0c0df63177e3-202306301034-plus-cx";
	filename*1=l_pci

[    0.000000] Linux version 6.4.0-rc6-rric-00055-g0c0df63177e3 (robert@hanna) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Wed Jun 28 14:06:16 CEST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3 root=UUID=8b447531-798d-41cb-a3df-ae1d9bb1eaf9 ro debug ignore_loglevel "dyndbg=file drivers/cxl/* +p" systemd.log_target=journal
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] signal: max sigframe size: 1440
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdefff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffdf000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001] kvm-clock: using sched offset of 13835895434 cycles
[    0.000003] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000007] tsc: Detected 2709.020 MHz processor
[    0.000806] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000808] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000814] last_pfn = 0x180000 max_arch_pfn = 0x400000000
[    0.000848] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000899] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
[    0.002695] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.003630] RAMDISK: [mem 0x35357000-0x369a2fff]
[    0.003646] ACPI: Early table checksum verification disabled
[    0.003655] ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
[    0.003661] ACPI: RSDT 0x000000007FFE2995 000040 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003668] ACPI: FACP 0x000000007FFE2441 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003674] ACPI: DSDT 0x000000007FFE0040 002401 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003677] ACPI: FACS 0x000000007FFE0000 000040
[    0.003679] ACPI: SSDT 0x000000007FFE2535 0002B8 (v01 BOCHS  PXB      00000001 BXPC 00000001)
[    0.003682] ACPI: APIC 0x000000007FFE27ED 0000A0 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003685] ACPI: HPET 0x000000007FFE288D 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003688] ACPI: MCFG 0x000000007FFE28C5 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003690] ACPI: CEDT 0x000000007FFE2901 00006C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003693] ACPI: WAET 0x000000007FFE296D 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.003695] ACPI: Reserving FACP table memory at [mem 0x7ffe2441-0x7ffe2534]
[    0.003697] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe2440]
[    0.003698] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.003699] ACPI: Reserving SSDT table memory at [mem 0x7ffe2535-0x7ffe27ec]
[    0.003700] ACPI: Reserving APIC table memory at [mem 0x7ffe27ed-0x7ffe288c]
[    0.003701] ACPI: Reserving HPET table memory at [mem 0x7ffe288d-0x7ffe28c4]
[    0.003702] ACPI: Reserving MCFG table memory at [mem 0x7ffe28c5-0x7ffe2900]
[    0.003703] ACPI: Reserving CEDT table memory at [mem 0x7ffe2901-0x7ffe296c]
[    0.003704] ACPI: Reserving WAET table memory at [mem 0x7ffe296d-0x7ffe2994]
[    0.003758] ACPI: Unknown target node for memory at 0x190000000, assuming node 0
[    0.003918] No NUMA configuration found
[    0.003919] Faking a node at [mem 0x0000000000000000-0x000000017fffffff]
[    0.003923] NODE_DATA(0) allocated [mem 0x17fffb000-0x17fffefff]
[    0.003943] Zone ranges:
[    0.003944]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.003946]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.003947]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.003949] Movable zone start for each node
[    0.003949] Early memory node ranges
[    0.003950]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.003951]   node   0: [mem 0x0000000000100000-0x000000007ffdefff]
[    0.003953]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
[    0.003954] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
[    0.004608] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.004626] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.031833] On node 0, zone Normal: 33 pages in unavailable ranges
[    0.032080] ACPI: PM-Timer IO Port: 0x608
[    0.032092] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.032128] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.032131] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.032133] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.032135] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.032136] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.032137] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.032142] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.032143] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.032150] smpboot: Allowing 6 CPUs, 0 hotplug CPUs
[    0.032175] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.032177] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.032178] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.032179] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.032180] PM: hibernation: Registered nosave memory: [mem 0x7ffdf000-0x7fffffff]
[    0.032181] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xafffffff]
[    0.032182] PM: hibernation: Registered nosave memory: [mem 0xb0000000-0xbfffffff]
[    0.032182] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfed1bfff]
[    0.032183] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.032184] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfeffbfff]
[    0.032185] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.032186] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.032186] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.032188] [mem 0xc0000000-0xfed1bfff] available for PCI devices
[    0.032189] Booting paravirtualized kernel on KVM
[    0.032191] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.039181] setup_percpu: NR_CPUS:512 nr_cpumask_bits:6 nr_cpu_ids:6 nr_node_ids:1
[    0.040273] percpu: Embedded 54 pages/cpu s183592 r8192 d29400 u262144
[    0.040281] pcpu-alloc: s183592 r8192 d29400 u262144 alloc=1*2097152
[    0.040284] pcpu-alloc: [0] 0 1 2 3 4 5 - - 
[    0.040309] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3 root=UUID=8b447531-798d-41cb-a3df-ae1d9bb1eaf9 ro debug ignore_loglevel "dyndbg=file drivers/cxl/* +p" systemd.log_target=journal
[    0.040381] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3", will be passed to user space.
[    0.042044] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.042873] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.042931] Fallback order for Node 0: 0 
[    0.042936] Built 1 zonelists, mobility grouping on.  Total pages: 1031903
[    0.042937] Policy zone: Normal
[    0.042939] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.042944] software IO TLB: area num 8.
[    0.093140] Memory: 3989636K/4193780K available (18432K kernel code, 3028K rwdata, 7200K rodata, 2724K init, 2984K bss, 203884K reserved, 0K cma-reserved)
[    0.093187] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.093958] Dynamic Preempt: voluntary
[    0.094671] rcu: Preemptible hierarchical RCU implementation.
[    0.094672] rcu: 	RCU event tracing is enabled.
[    0.094673] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=6.
[    0.094674] 	Trampoline variant of Tasks RCU enabled.
[    0.094675] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.094676] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.096769] NR_IRQS: 33024, nr_irqs: 472, preallocated irqs: 16
[    0.096982] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.104052] Console: colour VGA+ 80x25
[    0.104055] printk: console [tty0] enabled
[    0.141408] ACPI: Core revision 20230331
[    0.141720] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.143351] APIC: Switch to symmetric I/O mode setup
[    0.143849] x2apic enabled
[    0.144301] Switched APIC routing to physical x2apic.
[    0.145742] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.146003] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.146240] Calibrating delay loop (skipped) preset value.. 5418.04 BogoMIPS (lpj=2709020)
[    0.147237] pid_max: default: 32768 minimum: 301
[    0.147465] LSM: initializing lsm=capability,selinux,integrity
[    0.147761] SELinux:  Initializing.
[    0.148292] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.148661] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.149577] process: using AMD E400 aware idle routine
[    0.150243] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.150473] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.150718] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.151238] Spectre V2 : Mitigation: Retpolines
[    0.151443] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.151855] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.167462] Freeing SMP alternatives memory: 48K
[    0.266843] APIC calibration not consistent with PM-Timer: 96ms instead of 100ms
[    0.267235] APIC delta adjusted to PM-Timer: 6478501 (6249861)
[    0.267275] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.267838] cblist_init_generic: Setting adjustable number of callback queues.
[    0.268163] cblist_init_generic: Setting shift to 3 and lim to 1.
[    0.268255] Performance Events: AMD PMU driver.
[    0.268469] ... version:                0
[    0.268657] ... bit width:              48
[    0.268849] ... generic registers:      4
[    0.269038] ... value mask:             0000ffffffffffff
[    0.269237] ... max period:             00007fffffffffff
[    0.269465] ... fixed-purpose events:   0
[    0.269652] ... event mask:             000000000000000f
[    0.270001] rcu: Hierarchical SRCU implementation.
[    0.270237] rcu: 	Max phase no-delay instances is 400.
[    0.271012] smp: Bringing up secondary CPUs ...
[    0.271361] x86: Booting SMP configuration:
[    0.271560] .... node  #0, CPUs:      #1 #2 #3 #4 #5
[    0.283372] smp: Brought up 1 node, 6 CPUs
[    0.283876] smpboot: Max logical packages: 1
[    0.284107] smpboot: Total of 6 processors activated (32508.24 BogoMIPS)
[    0.297626] devtmpfs: initialized
[    0.298482] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.299248] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.300392] PM: RTC time: 08:11:16, date: 2023-06-30
[    0.301100] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.301636] audit: initializing netlink subsys (disabled)
[    0.301956] audit: type=2000 audit(1688112677.003:1): state=initialized audit_enabled=0 res=1
[    0.301956] thermal_sys: Registered thermal governor 'step_wise'
[    0.302237] thermal_sys: Registered thermal governor 'user_space'
[    0.302537] cpuidle: using governor menu
[    0.303788] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000-0xbfffffff] (base 0xb0000000)
[    0.304240] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved as E820 entry
[    0.304565] PCI: Using configuration type 1 for base access
[    0.305074] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.305388] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.306238] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.306569] ACPI: Added _OSI(Module Device)
[    0.307238] ACPI: Added _OSI(Processor Device)
[    0.307457] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.307696] ACPI: Added _OSI(Processor Aggregator Device)
[    0.309997] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.523155] ACPI: Interpreter enabled
[    0.523155] ACPI: PM: (supports S0 S3 S4 S5)
[    0.523155] ACPI: Using IOAPIC for interrupt routing
[    0.523214] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.524237] PCI: Using E820 reservations for host bridge windows
[    0.524679] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.527088] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-33])
[    0.528243] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.529323] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR]
[    0.529813] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    0.530341] PCI host bridge to bus 0000:00
[    0.530581] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.530871] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.531237] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.531612] pci_bus 0000:00: root bus resource [mem 0x80000000-0xafffffff window]
[    0.531978] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfdffffff window]
[    0.532237] pci_bus 0000:00: root bus resource [mem 0xfe200000-0xfe7fffff window]
[    0.532639] pci_bus 0000:00: root bus resource [mem 0x2c0000000-0xabfffffff window]
[    0.533019] pci_bus 0000:00: root bus resource [bus 00-33]
[    0.533292] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
[    0.533974] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000
[    0.537251] pci 0000:00:01.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.543271] pci 0000:00:01.0: reg 0x18: [mem 0xfea30000-0xfea30fff]
[    0.560252] pci 0000:00:01.0: reg 0x30: [mem 0xfea20000-0xfea2ffff pref]
[    0.560636] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.560636] pci 0000:00:02.0: [1b36:000b] type 00 class 0x060000
[    0.561141] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
[    0.562615] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    0.562615] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    0.572241] pci 0000:00:1f.2: reg 0x20: [io  0xc040-0xc05f]
[    0.572884] pci 0000:00:1f.2: reg 0x24: [mem 0xfea31000-0xfea31fff]
[    0.575333] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    0.582928] pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
[    0.584272] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.584671] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.585055] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.586341] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.586736] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
[    0.587114] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
[    0.587341] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.587723] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.588043] ACPI: PCI: Interrupt link GSIA configured for IRQ 16
[    0.588250] ACPI: PCI: Interrupt link GSIB configured for IRQ 17
[    0.588547] ACPI: PCI: Interrupt link GSIC configured for IRQ 18
[    0.588835] ACPI: PCI: Interrupt link GSID configured for IRQ 19
[    0.589250] ACPI: PCI: Interrupt link GSIE configured for IRQ 20
[    0.589540] ACPI: PCI: Interrupt link GSIF configured for IRQ 21
[    0.589831] ACPI: PCI: Interrupt link GSIG configured for IRQ 22
[    0.590122] ACPI: PCI: Interrupt link GSIH configured for IRQ 23
[    0.590772] ACPI: PCI Root Bridge [CL34] (domain 0000 [bus 34-35])
[    0.591246] acpi ACPI0016:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.592238] acpi ACPI0016:00: _OSC: OS supports [CXL11PortRegAccess CXL20PortDevRegAccess CXLProtocolErrorReporting CXLNativeHot]
[    0.592841] acpi ACPI0016:00: _OSC: platform does not support [LTR]
[    0.593426] acpi ACPI0016:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.593821] acpi ACPI0016:00: _OSC: OS now controls [CXLMemErrorReporting]
[    0.593821] PCI host bridge to bus 0000:34
[    0.593821] pci_bus 0000:34: root bus resource [mem 0xfe000000-0xfe1fffff window]
[    0.593920] pci_bus 0000:34: root bus resource [mem 0xfe800000-0xfea1ffff window]
[    0.594237] pci_bus 0000:34: root bus resource [bus 34-35]
[    0.594623] pci 0000:34:00.0: [8086:7075] type 01 class 0x060400
[    0.597964] pci 0000:34:00.0: reg 0x10: [mem 0xfea00000-0xfea1ffff 64bit]
[    0.602417] pci 0000:35:00.0: [8086:0d93] type 00 class 0x050210
[    0.604121] pci 0000:35:00.0: reg 0x10: [mem 0xfe840000-0xfe84ffff 64bit]
[    0.606215] pci 0000:35:00.0: reg 0x18: [mem 0xfe800000-0xfe83ffff 64bit]
[    0.609240] pci 0000:35:00.0: reg 0x20: [mem 0xfe850000-0xfe850fff]
[    0.642134] pci 0000:34:00.0: PCI bridge to [bus 35]
[    0.643291] pci 0000:34:00.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    0.643291] pci 0000:34:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
[    0.647618] iommu: Default domain type: Translated 
[    0.648241] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.648375] SCSI subsystem initialized
[    0.653286] libata version 3.00 loaded.
[    0.655338] ACPI: bus type USB registered
[    0.656261] usbcore: registered new interface driver usbfs
[    0.656780] usbcore: registered new interface driver hub
[    0.657253] usbcore: registered new device driver usb
[    0.657764] pps_core: LinuxPPS API ver. 1 registered
[    0.658239] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.659243] PTP clock support registered
[    0.659709] EDAC MC: Ver: 3.0.0
[    0.660522] Advanced Linux Sound Architecture Driver Initialized.
[    0.661566] NetLabel: Initializing
[    0.661984] NetLabel:  domain hash size = 128
[    0.662238] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.662776] NetLabel:  unlabeled traffic allowed by default
[    0.663302] PCI: Using ACPI for IRQ routing
[    0.739290] PCI: pci_cache_line_size set to 64 bytes
[    0.739579] pci 0000:00:01.0: can't claim BAR 2 [mem 0xfea30000-0xfea30fff]: no compatible bridge window
[    0.740032] pci 0000:00:1f.2: can't claim BAR 5 [mem 0xfea31000-0xfea31fff]: no compatible bridge window
[    0.741311] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.741563] e820: reserve RAM buffer [mem 0x7ffdf000-0x7fffffff]
[    0.741873] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    0.741873] pci 0000:00:01.0: vgaarb: bridge control possible
[    0.741873] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.742240] vgaarb: loaded
[    0.742315] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.742594] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.742849] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.772286] clocksource: Switched to clocksource kvm-clock
[    0.772649] VFS: Disk quotas dquot_6.6.0
[    0.772891] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.773284] pnp: PnP ACPI init
[    0.773719] system 00:05: [mem 0xb0000000-0xbfffffff window] has been reserved
[    0.774425] pnp: PnP ACPI: found 6 devices
[    0.788354] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.788808] NET: Registered PF_INET protocol family
[    0.789915] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.791149] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.794560] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.794905] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.795306] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.795914] TCP: Hash tables configured (established 32768 bind 32768)
[    0.796250] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.797339] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.797732] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.798669] RPC: Registered named UNIX socket transport module.
[    0.799239] RPC: Registered udp transport module.
[    0.799731] RPC: Registered tcp transport module.
[    0.800191] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.801767] pci 0000:00:01.0: BAR 2: assigned [mem 0x80000000-0x80000fff]
[    0.805142] pci 0000:00:1f.2: BAR 5: assigned [mem 0x80001000-0x80001fff]
[    0.807421] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.807972] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.808547] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.809115] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff window]
[    0.809708] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfdffffff window]
[    0.810292] pci_bus 0000:00: resource 9 [mem 0xfe200000-0xfe7fffff window]
[    0.810854] pci_bus 0000:00: resource 10 [mem 0x2c0000000-0xabfffffff window]
[    0.811486] pci 0000:34:00.0: bridge window [io  0x1000-0x0fff] to [bus 35] add_size 1000
[    0.812267] pci 0000:34:00.0: BAR 7: no space for [io  size 0x1000]
[    0.812683] pci 0000:34:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.813081] pci 0000:34:00.0: BAR 7: no space for [io  size 0x1000]
[    0.813475] pci 0000:34:00.0: BAR 7: failed to assign [io  size 0x1000]
[    0.813861] pci 0000:34:00.0: PCI bridge to [bus 35]
[    0.816227] pci 0000:34:00.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    0.817989] pci 0000:34:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
[    0.820909] pci_bus 0000:34: resource 4 [mem 0xfe000000-0xfe1fffff window]
[    0.821166] pci_bus 0000:34: resource 5 [mem 0xfe800000-0xfea1ffff window]
[    0.821425] pci_bus 0000:35: resource 1 [mem 0xfe800000-0xfe9fffff]
[    0.821659] pci_bus 0000:35: resource 2 [mem 0xfe000000-0xfe1fffff 64bit pref]
[    0.822033] PCI: CLS 0 bytes, default 64
[    0.822239] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.822490] Unpacking initramfs...
[    0.827730] software IO TLB: mapped [mem 0x000000007bfdf000-0x000000007ffdf000] (64MB)
[    0.827800] kvm_intel: VMX not supported by CPU 2
[    0.830410] kvm_amd: SVM not supported by CPU 2, svm not available
[    0.841399] Initialise system trusted keyrings
[    0.842081] workingset: timestamp_bits=56 max_order=20 bucket_order=0
[    0.842859] NFS: Registering the id_resolver key type
[    0.843421] Key type id_resolver registered
[    0.843874] Key type id_legacy registered
[    0.844471] 9p: Installing v9fs 9p2000 file system support
[    0.865338] Key type asymmetric registered
[    0.865599] Asymmetric key parser 'x509' registered
[    0.865893] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.866266] io scheduler mq-deadline registered
[    0.866521] io scheduler kyber registered
[    0.891953] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[    0.895679] pcieport 0000:34:00.0: PME: Signaling with IRQ 24
[    0.898788] pcieport 0000:34:00.0: AER: enabled with IRQ 24
[    0.899165] pcieport 0000:34:00.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep- (with Cmd Compl erratum)
[    0.901147] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.901741] ACPI: button: Power Button [PWRF]
[    0.902932] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.903399] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.904916] Non-volatile memory driver v1.3
[    0.905161] Linux agpgart interface v0.103
[    0.905457] ACPI: bus type drm_connector registered
[    0.912155] loop: module loaded
[    0.913592] ahci 0000:00:1f.2: version 3.0
[    0.914138] ACPI: \_SB_.GSIA: Enabled at IRQ 16
[    0.914885] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    0.915233] ahci 0000:00:1f.2: flags: 64bit ncq only 
[    0.916967] scsi host0: ahci
[    0.918334] scsi host1: ahci
[    0.919785] scsi host2: ahci
[    0.921519] scsi host3: ahci
[    0.926136] scsi host4: ahci
[    0.927839] scsi host5: ahci
[    0.929785] ata1: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001100 irq 25
[    0.931241] ata2: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001180 irq 25
[    0.932607] ata3: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001200 irq 25
[    0.933902] ata4: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001280 irq 25
[    0.935190] ata5: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001300 irq 25
[    0.936537] ata6: SATA max UDMA/133 abar m4096@0x80001000 port 0x80001380 irq 25
[    0.938611] e100: Intel(R) PRO/100 Network Driver
[    0.939490] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.940491] e1000: Intel(R) PRO/1000 Network Driver
[    0.941338] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.942249] e1000e: Intel(R) PRO/1000 Network Driver
[    0.943106] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.944074] sky2: driver version 1.30
[    0.945302] usbcore: registered new interface driver usblp
[    0.946207] usbcore: registered new interface driver usb-storage
[    0.947277] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.950647] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.951531] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.953178] rtc_cmos 00:04: RTC can wake from S4
[    0.959138] rtc_cmos 00:04: registered as rtc0
[    0.960311] rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    0.961008] hid: raw HID events driver (C) Jiri Kosina
[    0.961423] usbcore: registered new interface driver usbhid
[    0.961690] usbhid: USB HID core driver
[    0.963818] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.964630] Initializing XFRM netlink socket
[    0.964639] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    0.965204] NET: Registered PF_INET6 protocol family
[    0.967540] Segment Routing with IPv6
[    0.968028] In-situ OAM (IOAM) with IPv6
[    0.968181] i2c i2c-0: 1/1 memory slots populated (from DMI)
[    0.968566] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.969574] i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
[    0.970383] NET: Registered PF_PACKET protocol family
[    0.971881] 9pnet: Installing 9P2000 support
[    0.972427] Key type dns_resolver registered
[    0.974801] IPI shorthand broadcast: enabled
[    0.982569] sched_clock: Marking stable (935045115, 47245671)->(1053069709, -70778923)
[    0.983769] registered taskstats version 1
[    0.984254] Loading compiled-in X.509 certificates
[    0.988939] PM:   Magic number: 11:717:170
[    0.990011] printk: console [netcon0] enabled
[    0.990357] netconsole: network logging started
[    0.990778] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.175745] Freeing initrd memory: 22832K
[    1.183679] modprobe (94) used greatest stack depth: 13600 bytes left
[    1.192765] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.194419] ALSA device list:
[    1.195195]   No soundcards found.
[    1.196464] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
[    1.252980] ata5: SATA link down (SStatus 0 SControl 300)
[    1.259710] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.264818] ata4: SATA link down (SStatus 0 SControl 300)
[    1.265920] ata3.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.267905] ata3.00: applying bridge limits
[    1.269075] ata6: SATA link down (SStatus 0 SControl 300)
[    1.270010] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.271865] ata2: SATA link down (SStatus 0 SControl 300)
[    1.273440] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    1.274418] ata1.00: 134217728 sectors, multi 16: LBA48 NCQ (depth 32)
[    1.275405] ata1.00: applying bridge limits
[    1.276276] ata3.00: configured for UDMA/100
[    1.278028] ata1.00: configured for UDMA/100
[    1.279671] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    1.283178] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.283316] sd 0:0:0:0: [sda] 134217728 512-byte logical blocks: (68.7 GB/64.0 GiB)
[    1.285660] sd 0:0:0:0: [sda] Write Protect is off
[    1.285772] scsi 2:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.286518] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.286564] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.290639] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.294098] sr 2:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.294575]  sda: sda1
[    1.295376] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.297563] sr 2:0:0:0: [sr0] Hmm, seems the drive doesn't support multisession CD's
[    1.297907] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.303734] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.305166] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.320042] Freeing unused kernel image (initmem) memory: 2724K
[    1.321127] Write protecting the kernel read-only data: 26624k
[    1.323505] Freeing unused kernel image (rodata/data gap) memory: 992K
[    1.415903] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.416166] Run /init as init process
[    1.416360]   with arguments:
[    1.416532]     /init
[    1.416688]   with environment:
[    1.416858]     HOME=/
[    1.417016]     TERM=linux
[    1.417177]     BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc6-rric-00055-g0c0df63177e3
[    1.498175] systemd-udevd (122) used greatest stack depth: 13384 bytes left
[    1.603262] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    1.736968] EXT4-fs (sda1): mounted filesystem 8b447531-798d-41cb-a3df-ae1d9bb1eaf9 ro with ordered data mode. Quota mode: none.
[    2.540117] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    2.610468] EXT4-fs (sda1): re-mounted 8b447531-798d-41cb-a3df-ae1d9bb1eaf9 r/w. Quota mode: none.
[    2.784211] random: crng init done
[    3.152833] e2scrub_all (269) used greatest stack depth: 12872 bytes left
[    3.190906] cxl_acpi ACPI0017:00: root0 added (root port)
[    3.191241] acpi ACPI0016:00: UID found: 52
[    3.191505]  pci0000:34: dport added to root0
[    3.191767] Unknown target node for memory at 0x190000000, assuming node 0
[    3.192063] cxl_acpi ACPI0017:00: add: decoder0.0 node: 0 range [0x190000000 - 0x28fffffff]
[    3.192503] acpi ACPI0016:00: UID found: 52
[    3.192737] acpi ACPI0016:00: CHBCR found for UID 52: 0x0000000180000000
[    3.193036]  pci0000:34: host-bridge: pci0000:34
[    3.193304] cxl port1: Mapped CXL Memory Device resource 0x0000000180000000
[    3.193629] cxl port1: found RAS capability (0x80)
[    3.193890] cxl port1: Unknown CM cap ID: 4 (0xd8)
[    3.194149] cxl port1: Unknown CM cap ID: 0 (0x110)
[    3.194438] cxl port1: Unknown CM cap ID: 6 (0x260)
[    3.194695] cxl port1: Unknown CM cap ID: 8 (0xa84)
[    3.194945] cxl port1: Set up component registers
[    3.195343]  pci0000:34: port1 added to root0
[    3.195584]  pci0000:34: host supports CXL
[    3.195943] cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
[    3.196313] CXL bus rescan result: 0
[    3.235334] cxl_pci 0000:35:00.0: Mapped CXL Memory Device resource 0x00000000fe800000
[    3.235760] cxl_pci 0000:35:00.0: found Status capability (0x80)
[    3.236047] cxl_pci 0000:35:00.0: found Mailbox capability (0x88)
[    3.236391] cxl_pci 0000:35:00.0: found Memory Device capability (0x8a8)
[    3.236682] cxl_pci 0000:35:00.0: Probing device registers...
[    3.236996] cxl_pci 0000:35:00.0: Mapped CXL Memory Device resource 0x00000000fe840000
[    3.238573] cxl_pci 0000:35:00.0: found RAS capability (0x80)
[    3.238854] cxl_pci 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
[    3.239130] cxl_pci 0000:35:00.0: found HDM decoder capability (0x110)
[    3.239955] cxl_pci 0000:35:00.0: Set up component registers
[    3.240928] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.241186] cxl_pci 0000:35:00.0: Mailbox payload sized 2048
[    3.241558] cxl_pci 0000:35:00.0: Sending command: 0x0400
[    3.241830] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.242118] cxl_pci 0000:35:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 68
[    3.242575] cxl_pci 0000:35:00.0: Sending command: 0x0401
[    3.242847] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.243156] cxl_pci 0000:35:00.0: Opcode 0x0100 unsupported by driver
[    3.243453] cxl_pci 0000:35:00.0: Opcode 0x0101 unsupported by driver
[    3.243739] cxl_pci 0000:35:00.0: Opcode 0x0102 unsupported by driver
[    3.244019] cxl_pci 0000:35:00.0: Opcode 0x0103 unsupported by driver
[    3.244323] cxl_pci 0000:35:00.0: Opcode 0x0200 enabled
[    3.244576] cxl_pci 0000:35:00.0: Opcode 0x0300 unsupported by driver
[    3.244856] cxl_pci 0000:35:00.0: Opcode 0x0301 unsupported by driver
[    3.245120] cxl_pci 0000:35:00.0: Opcode 0x0400 enabled
[    3.245373] cxl_pci 0000:35:00.0: Opcode 0x0401 enabled
[    3.245630] cxl_pci 0000:35:00.0: Opcode 0x4000 enabled
[    3.245858] cxl_pci 0000:35:00.0: Opcode 0x4100 enabled
[    3.246070] cxl_pci 0000:35:00.0: Opcode 0x4102 enabled
[    3.246292] cxl_pci 0000:35:00.0: Opcode 0x4103 enabled
[    3.246564] cxl_pci 0000:35:00.0: Opcode 0x4300 enabled
[    3.246802] cxl_pci 0000:35:00.0: Opcode 0x4301 enabled
[    3.247013] cxl_pci 0000:35:00.0: Opcode 0x4302 enabled
[    3.247225] cxl_pci 0000:35:00.0: Opcode 0x4400 unsupported by driver
[    3.247533] cxl_pci 0000:35:00.0: Sending command: 0x0301
[    3.247806] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.248040] cxl_pci 0000:35:00.0: Sending command: 0x4000
[    3.248322] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.248647] cxl_pci 0000:35:00.0: DPA(ram): no capacity
[    3.248907] cxl_pci 0000:35:00.0: DPA(pmem): [mem 0x00000000-0x1fffffff flags 0x200]
[    3.249806] cxl_pci 0000:35:00.0: Sending command: 0x0102
[    3.250033] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.250271] cxl_pci 0000:35:00.0: Sending command: 0x0103
[    3.250565] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.250841] cxl_pci 0000:35:00.0: Sending command: 0x0102
[    3.251086] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.251848] cxl_pci 0000:35:00.0: Reading event logs: f
[    3.252134] cxl_pci 0000:35:00.0: Sending command: 0x0100
[    3.252425] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.252728] cxl_pci 0000:35:00.0: Sending command: 0x0100
[    3.252975] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.253231] cxl_pci 0000:35:00.0: Sending command: 0x0100
[    3.253497] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.253780] cxl_pci 0000:35:00.0: Sending command: 0x0100
[    3.254006] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.254271] cxl_pci 0000:35:00.0: Uncorrectable RAS Errors Mask: 0x1cfff -> 0x0
[    3.254666] cxl_pci 0000:35:00.0: Correctable RAS Errors Mask: 0x7f -> 0x0
[    3.326758] pcieport 0000:34:00.0: Component Registers found for dport: 0x00000000fea00000
[    3.326777] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
[    3.326802] pcieport 0000:34:00.0: found RAS capability (0x80)
[    3.326812] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
[    3.326823] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
[    3.326833] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
[    3.326844] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)
[    3.326845] pcieport 0000:34:00.0: Set up component registers
[    3.326859] pcieport 0000:34:00.0: dport added to port1
[    3.326881] cxl_port port1: found RAS capability (0x80)
[    3.326891] cxl_port port1: Unknown CM cap ID: 4 (0xd8)
[    3.326901] cxl_port port1: Unknown CM cap ID: 0 (0x110)
[    3.326911] cxl_port port1: Unknown CM cap ID: 6 (0x260)
[    3.326921] cxl_port port1: Unknown CM cap ID: 8 (0xa84)
[    3.326923] cxl_port port1: HDM decoder registers not implemented
[    3.326926] cxl_port port1: Fallback to passthrough decoder
[    3.326969] cxl decoder1.0: Added to port port1
[    3.326971] cxl_port port1: probe: 0
[    3.328945] cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:34:00.0 parent: pci0000:34
[    3.328953] cxl_mem mem0: found already registered port port1:pci0000:34
[    3.328961] cxl_mem mem0: host-bridge: pci0000:34
[    3.328976] cxl endpoint2: Mapped CXL Memory Device resource 0x00000000fe840000
[    3.329007] cxl endpoint2: found RAS capability (0x80)
[    3.329054] cxl endpoint2: Unknown CM cap ID: 4 (0xd8)
[    3.329065] cxl endpoint2: found HDM decoder capability (0x110)
[    3.329067] cxl endpoint2: Set up component registers
[    3.329159] cxl_port endpoint2: found RAS capability (0x80)
[    3.329170] cxl_port endpoint2: Unknown CM cap ID: 4 (0xd8)
[    3.329180] cxl_port endpoint2: found HDM decoder capability (0x110)
[    3.329927] cxl_port endpoint2: CDAT length 160
[    3.332686] cxl_pmu pmu_mem0.0: probe: 0
[    3.333595] cxl_pmu pmu_mem0.1: probe: 0
[    3.355367] cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[    3.355856] cxl decoder2.0: Added to port endpoint2
[    3.356162] cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[    3.356619] cxl decoder2.1: Added to port endpoint2
[    3.356907] cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[    3.357334] cxl decoder2.2: Added to port endpoint2
[    3.357626] cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[    3.358051] cxl decoder2.3: Added to port endpoint2
[    3.358320] cxl_port endpoint2: probe: 0
[    3.358587] cxl_mem mem0: endpoint2 added to port1
[    3.358605] cxl_mem mem0: register pmem0
[    3.359094] cxl_mem mem0: probe: 0
[    3.364575] nd_bus ndbus0: START: nd_bus.probe(ndbus0)
[    3.364922] nd_bus ndbus0: END: nd_bus.probe(ndbus0) = 0
[    3.365205] cxl_nvdimm_bridge nvdimm-bridge0: probe: 0
[    3.365538] cxl_pci 0000:35:00.0: Sending command: 0x4500
[    3.365812] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.366078] cxl_pci 0000:35:00.0: Mailbox operation had an error: cmd is not supported
[    3.366495] cxl_pci 0000:35:00.0: Sending command: 0x4500
[    3.366753] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.366976] cxl_pci 0000:35:00.0: Mailbox operation had an error: cmd is not supported
[    3.367429] nd_bus ndbus0: START: nvdimm.probe(nmem0)
[    3.585502] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.587972] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.589356] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.589588] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.590839] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.591066] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.592344] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.592618] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.593884] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.594120] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.595365] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.595590] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.596920] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.597150] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.598406] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.598632] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.599874] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.600104] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.601442] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.601672] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.602900] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.603126] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.604397] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.604669] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.605918] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.606148] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.607388] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.607614] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.608951] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.609181] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.610435] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.610661] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.614754] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.614986] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.616244] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.616534] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.617889] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.618116] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.619463] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.619727] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.621057] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.621299] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.622716] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.622983] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.624453] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.624725] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.626058] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.626301] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.627660] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.627889] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.629216] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.629492] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.630779] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.631004] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.632259] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.632543] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.633824] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.634049] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.635304] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.635535] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.636877] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.637108] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.638425] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.638693] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.639949] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.640176] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.641504] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.641734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.642978] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.643205] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.644501] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.644771] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.646024] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.646265] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.647493] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.647719] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.649048] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.649299] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.650603] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.650830] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.655567] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.655805] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.658318] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.658598] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.660155] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.660451] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.661914] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.662183] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.663660] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.663934] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.665428] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.665697] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.667160] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.667443] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.668903] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.669134] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.670375] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.670601] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.671836] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.672068] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.673405] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.673632] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.674870] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.675096] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.676369] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.676643] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.677893] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.678120] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.679361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.679588] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.680892] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.681125] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.682370] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.682598] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.683829] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.684059] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.685387] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.685619] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.686852] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.687079] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.688338] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.688612] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.689864] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.690092] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.691331] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.691558] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.692863] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.693094] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.694336] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.694565] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.695799] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.696025] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.697340] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.697572] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.698806] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.699034] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.700282] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.700568] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.701831] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.702062] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.703303] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.703530] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.704837] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.705069] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.706312] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.706540] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.707778] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.708005] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.709324] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.709556] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.710798] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.711025] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.712273] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.712550] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.713814] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.714046] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.715297] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.715526] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.716841] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.717072] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.718316] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.718550] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.719789] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.720018] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.721344] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.721574] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.722827] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.723056] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.724329] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.727153] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.729114] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.729412] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.730777] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.731046] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.732340] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.732609] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.733869] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.734100] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.735347] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.735574] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.736905] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.737136] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.738386] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.738617] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.739862] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.740089] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.741413] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.741645] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.742884] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.743111] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.744395] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.744665] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.745920] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.746151] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.747396] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.747623] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.748946] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.749175] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.750416] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.750648] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.751883] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.752121] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.753441] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.753673] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.754912] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.755145] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.756434] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.756707] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.757999] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.758231] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.759486] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.759714] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.767988] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.768295] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.769695] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.769969] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.771400] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.771669] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.773044] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.773328] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.774690] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.774918] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.776158] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.776426] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.777723] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.777954] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.779195] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.779431] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.780767] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.781040] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.782298] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.782529] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.783775] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.784003] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.785256] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.785487] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.786734] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.786965] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.788207] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.788493] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.789757] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.789988] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.791235] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.791470] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.792786] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.793013] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.799329] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.799974] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.802848] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.803387] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.805656] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.806024] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.808019] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.808415] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.810390] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.810752] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.812678] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.812922] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.814159] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.814397] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.815680] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.815922] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.817230] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.817469] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.818711] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.818951] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.820260] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.820546] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.821810] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.822042] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.823281] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.823554] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.824918] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.825149] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.829048] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.829749] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.831203] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.831456] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.832852] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.833083] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.834328] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.834556] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.835783] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.836009] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.837341] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.837571] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.838810] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.839038] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.840361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.840630] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.841888] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.842118] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.843366] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.843593] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.844919] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.845149] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.846393] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.846624] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.847854] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.848081] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.849411] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.849642] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.850871] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.851099] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.852355] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.852624] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.853869] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.854099] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.855344] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.855571] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.856883] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.857167] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.861070] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.861943] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.864823] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.865360] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.868178] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.868647] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.870629] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.870995] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.872992] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.873374] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.875340] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.875706] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.877305] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.877533] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.878778] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.879005] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.880265] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.880567] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.881848] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.882075] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.883329] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.883556] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.884886] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.885117] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.886412] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.886640] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.887912] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.888144] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.889496] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.889754] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.894078] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.894374] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.895675] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.895905] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.897844] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.898614] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.903325] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.903714] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.905119] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.905376] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.906727] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.906956] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.908285] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.908561] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.909899] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.910130] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.911458] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.911727] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.913061] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.913311] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.914660] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.914890] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.916215] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.916499] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.917849] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.918081] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.919417] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.919688] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.921027] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.921264] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.925688] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.925971] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.927260] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.927489] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.928843] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.929113] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.930373] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.930604] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.931850] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.932077] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.933415] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.933646] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.934891] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.935121] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.936395] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.936663] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.937923] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.938153] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.939401] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.939627] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.943730] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.943971] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.945296] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.945527] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.946769] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.946996] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.948239] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.948527] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.949790] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.950017] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.951267] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.951493] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.952816] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.953046] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.954278] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.957053] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.962624] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.963574] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.966736] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.967261] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.969618] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.969981] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.971980] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.972371] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.974364] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.974731] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.976681] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.976923] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.978174] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.978421] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.979727] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.979954] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.981295] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.981564] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.982900] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.983131] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.984416] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.984684] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.985929] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.986156] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.992648] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.993188] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.996018] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.996487] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    3.998440] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    3.998806] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.000782] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.001148] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.003113] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.003486] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.005146] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.005392] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.006670] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.006896] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.008128] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.008394] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.009677] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.009907] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.011132] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.011366] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.012653] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.012925] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.014173] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.014410] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.015639] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.015875] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.017186] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.017434] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.018716] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.018946] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.023276] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.023562] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.026083] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.026427] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.027908] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.028178] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.029779] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.030077] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.031554] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.031824] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.033304] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.033560] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.034817] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.035048] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.036312] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.036586] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.037886] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.038114] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.039340] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.039571] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.040892] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.041123] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.042415] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.042642] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.043868] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.044099] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.045418] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.045688] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.046923] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.047149] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.048419] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.048691] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.049978] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.050205] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.051434] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.051665] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.055926] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.056212] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.057848] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.058120] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.059395] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.059627] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.060947] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.061175] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.062477] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.062705] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.063940] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.064172] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.065526] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.065792] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.067025] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.067252] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.068551] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.068810] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.070103] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.070338] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.071569] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.071801] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.073112] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.073353] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.074641] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.074877] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.076109] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.076381] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.077719] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.077955] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.079184] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.079420] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.080727] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.080958] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.082263] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.082492] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.083730] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.083958] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.088313] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.088638] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.090096] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.090351] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.091651] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.091882] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.093218] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.093476] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.094761] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.094989] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.096233] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.096526] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.097862] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.098090] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.099334] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.099562] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.100877] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.101109] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.102431] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.102701] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.103947] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.104174] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.105536] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.105805] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.107038] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.107272] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.108556] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.108811] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.110096] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.110333] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.111556] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.111783] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.113089] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.113327] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.114622] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.114849] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.123281] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.123623] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.125141] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.125413] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.126895] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.127218] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.128869] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.129111] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.130351] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.130578] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.131855] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.132082] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.133412] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.133685] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.134926] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.135162] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.136504] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.136764] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.137996] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.138226] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.139551] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.139809] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.141115] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.141353] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.142587] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.142817] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.144101] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.144363] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.145646] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.145876] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.147112] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.147347] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.151702] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.151980] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.154299] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.154636] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.156355] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.156676] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.158166] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.158490] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.159979] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.160254] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.161737] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.161965] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.163270] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.163544] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.164885] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.165116] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.166354] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.166620] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.167875] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.168106] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.169447] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.169717] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.171014] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.171242] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.172538] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.172796] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.174037] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.174272] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.175572] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.175800] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.177121] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.177360] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.178638] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.178907] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.180169] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.180442] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.184700] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.184985] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.186501] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.186780] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.188036] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.188276] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.189609] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.189837] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.191137] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.191373] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.192699] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.192984] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.194224] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.194475] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.195754] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.195981] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.197295] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.197567] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.198885] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.199111] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.200457] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.200733] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.201973] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.202204] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.203507] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.203734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.205044] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.205282] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.206546] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.206805] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.208042] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.208277] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.209600] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.209830] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.211126] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.211370] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.212736] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.213005] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.217364] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.217709] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.219118] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.219371] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.220729] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.220961] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.222204] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.222475] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.223753] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.223981] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.225291] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.225522] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.226807] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.227034] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.228270] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.228550] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.229812] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.230042] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.231330] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.231557] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.232869] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.233099] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.234410] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.234687] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.235936] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.236163] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.237482] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.237712] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.238998] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.239228] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.240507] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.240766] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.241997] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.242227] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.243523] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.243751] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.245054] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.245313] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.249469] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.250463] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.252215] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.252554] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.253988] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.254266] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.255856] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.256143] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.257745] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.258018] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.259280] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.259538] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.260905] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.261137] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.262380] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.262607] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.263919] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.264149] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.265488] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.265716] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.266962] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.267190] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.268554] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.268809] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.270063] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.270309] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.271647] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.271921] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.273270] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.273547] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.274814] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.275041] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.276392] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.276669] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.280979] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.281275] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.287036] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.287377] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.288932] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.289198] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.290519] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.290784] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.292022] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.292252] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.293587] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.293814] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.295101] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.295337] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.296644] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.296919] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.298179] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.298443] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.299728] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.299956] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.301275] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.301506] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.302799] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.303067] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.304341] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.304614] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.305873] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.306104] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.307407] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.307648] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.308965] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.309196] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.313165] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.313764] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.315424] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.315727] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.317103] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.317358] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.318667] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.318894] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.320198] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.320475] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.321765] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.321996] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.323254] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.323502] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.324861] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.325091] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.326343] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.326573] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.327870] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.328098] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.329437] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.329710] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.330965] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.331194] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.332554] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.332805] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.334054] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.334298] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.335646] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.335917] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.337263] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.337491] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.338739] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.338971] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.340277] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.340559] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.341838] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.342070] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.346479] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.346785] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.348217] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.348506] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.349783] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.350014] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.351269] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.351497] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.352813] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.353042] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.354367] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.354598] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.355842] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.356070] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.357410] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.357637] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.358927] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.359158] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.360440] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.360710] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.361961] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.362192] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.363443] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.363682] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.364998] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.365225] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.366540] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.366771] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.368018] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.368246] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.369578] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.369806] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.371053] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.371302] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.372665] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.372934] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.374191] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.377067] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.379075] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.379362] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.380818] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.381089] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.382358] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.382631] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.383887] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.384118] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.385466] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.385694] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.386943] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.387174] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.388460] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.388729] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.389974] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.390202] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.391503] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.391734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.393056] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.393292] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.394539] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.394808] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.396059] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.396320] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.397625] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.397852] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.399092] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.399334] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.400674] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.400952] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.402328] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.402600] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.404004] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.404237] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.405620] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.405857] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.410234] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.410543] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.412117] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.412457] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.413738] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.413965] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.415268] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.415539] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.416871] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.417101] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.418340] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.418603] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.419860] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.420102] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.421422] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.421652] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.422938] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.423164] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.424431] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.424707] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.425940] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.426168] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.427468] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.427695] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.429006] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.429237] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.430496] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.430767] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.432006] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.432232] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.433554] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.433783] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.435080] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.435322] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.436691] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.436921] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.438164] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.441016] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.446115] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.446380] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.447664] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.447895] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.449213] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.449467] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.450748] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.450979] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.452227] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.452516] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.453847] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.454075] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.455325] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.455556] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.456869] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.457097] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.458464] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.458734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.459985] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.460216] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.461575] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.461834] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.463082] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.463332] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.464713] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.464987] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.466309] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.466540] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.467784] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.468015] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.469346] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.469615] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.473932] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.474210] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.475807] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.476119] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.477472] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.477700] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.478928] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.479164] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.480516] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.480781] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.482010] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.482237] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.483487] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.483762] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.485067] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.485308] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.486534] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.486761] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.488048] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.488304] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.489604] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.489835] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.491056] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.491290] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.492647] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.492889] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.494119] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.494353] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.495610] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.495863] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.497162] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.497403] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.498635] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.498863] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.500148] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.500419] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.501708] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.501939] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.506302] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.506616] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.508075] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.508337] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.509637] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.509865] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.511101] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.511337] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.512717] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.512949] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.514180] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.514416] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.515697] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.515937] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.517267] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.517499] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.518733] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.518960] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.520255] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.520537] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.521806] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.522038] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.523272] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.523523] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.524878] cxl_pci 0000:35:00.0: Sending command: 0x4102
[    4.525109] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[    4.526339] nvdimm nmem0: nsindex0 signature invalid
[    4.526550] nvdimm nmem0: nsindex1 signature invalid
[    4.526759] nvdimm nmem0: nsindex0 signature invalid
[    4.526967] nvdimm nmem0: nsindex1 signature invalid
[    4.527179] nvdimm nmem0: config data size: 536870912
[    4.527401] nd_bus ndbus0: END: nvdimm.probe(nmem0) = 0
[    4.527713] cxl_nvdimm pmem0: probe: 0
[    7.614015] (udev-worker) (249) used greatest stack depth: 12824 bytes left
[    9.076633] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=335 'systemd'
[  444.541450] nvdimm nmem0: trace
[  444.586381] nd_bus ndbus0: nvdimm.remove(nmem0)
[  444.587792] nd_bus ndbus0: nd_bus.remove(ndbus0)
[  444.654166] cxl_mem mem0: disconnect mem0 from port1
[  468.229977] cxl_acpi ACPI0017:00: root0 added (root port)
[  468.231055] acpi ACPI0016:00: UID found: 52
[  468.231959]  pci0000:34: dport added to root0
[  468.232867] Unknown target node for memory at 0x190000000, assuming node 0
[  468.233901] cxl_acpi ACPI0017:00: add: decoder0.0 node: 0 range [0x190000000 - 0x28fffffff]
[  468.235394] acpi ACPI0016:00: UID found: 52
[  468.236171] acpi ACPI0016:00: CHBCR found for UID 52: 0x0000000180000000
[  468.237193]  pci0000:34: host-bridge: pci0000:34
[  468.238132] cxl port1: Mapped CXL Memory Device resource 0x0000000180000000
[  468.239319] cxl port1: found RAS capability (0x80)
[  468.240186] cxl port1: Unknown CM cap ID: 4 (0xd8)
[  468.241083] cxl port1: Unknown CM cap ID: 0 (0x110)
[  468.241974] cxl port1: Unknown CM cap ID: 6 (0x260)
[  468.242876] cxl port1: Unknown CM cap ID: 8 (0xa84)
[  468.243767] cxl port1: Set up component registers
[  468.244959]  pci0000:34: port1 added to root0
[  468.245807]  pci0000:34: host supports CXL
[  468.246711] cxl_acpi ACPI0017:00: root0: add: nvdimm-bridge0
[  468.247792] CXL bus rescan result: 0
[  468.250149] pcieport 0000:34:00.0: Component Registers found for dport: 0x00000000fea00000
[  468.250182] pcieport 0000:34:00.0: Mapped CXL Memory Device resource 0x00000000fea00000
[  468.250258] pcieport 0000:34:00.0: found RAS capability (0x80)
[  468.250371] pcieport 0000:34:00.0: Unknown CM cap ID: 4 (0xd8)
[  468.250413] pcieport 0000:34:00.0: found HDM decoder capability (0x110)
[  468.256022] pcieport 0000:34:00.0: Unknown CM cap ID: 6 (0x260)
[  468.256058] pcieport 0000:34:00.0: Unknown CM cap ID: 8 (0xa84)
[  468.256065] pcieport 0000:34:00.0: Set up component registers
[  468.256089] pcieport 0000:34:00.0: dport added to port1
[  468.256157] cxl_port port1: found RAS capability (0x80)
[  468.260800] cxl_port port1: Unknown CM cap ID: 4 (0xd8)
[  468.260833] cxl_port port1: Unknown CM cap ID: 0 (0x110)
[  468.260865] cxl_port port1: Unknown CM cap ID: 6 (0x260)
[  468.260898] cxl_port port1: Unknown CM cap ID: 8 (0xa84)
[  468.260904] cxl_port port1: HDM decoder registers not implemented
[  468.260915] cxl_port port1: Fallback to passthrough decoder
[  468.261024] cxl decoder1.0: Added to port port1
[  468.267186] cxl_port port1: probe: 0
[  468.298485] nd_bus ndbus0: START: nd_bus.probe(ndbus0)
[  468.299859] nd_bus ndbus0: END: nd_bus.probe(ndbus0) = 0
[  468.300840] cxl_nvdimm_bridge nvdimm-bridge0: probe: 0
[ 1396.806148] cxl_pci 0000:35:00.0: Mapped CXL Memory Device resource 0x00000000fe800000
[ 1396.807600] cxl_pci 0000:35:00.0: found Status capability (0x80)
[ 1396.808604] cxl_pci 0000:35:00.0: found Mailbox capability (0x88)
[ 1396.809640] cxl_pci 0000:35:00.0: found Memory Device capability (0x8a8)
[ 1396.810631] cxl_pci 0000:35:00.0: Probing device registers...
[ 1396.811761] cxl_pci 0000:35:00.0: Mapped CXL Memory Device resource 0x00000000fe840000
[ 1396.813184] cxl_pci 0000:35:00.0: found RAS capability (0x80)
[ 1396.814133] cxl_pci 0000:35:00.0: Unknown CM cap ID: 4 (0xd8)
[ 1396.815081] cxl_pci 0000:35:00.0: found HDM decoder capability (0x110)
[ 1396.816086] cxl_pci 0000:35:00.0: Set up component registers
[ 1396.818692] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.819592] cxl_pci 0000:35:00.0: Mailbox payload sized 2048
[ 1396.820733] cxl_pci 0000:35:00.0: Sending command: 0x0400
[ 1396.821693] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.822675] cxl_pci 0000:35:00.0: Found LOG type 0da9c0b5-bf41-4b78-8f79-96b1623b3f17 of size 68
[ 1396.824216] cxl_pci 0000:35:00.0: Sending command: 0x0401
[ 1396.828791] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.829942] cxl_pci 0000:35:00.0: Opcode 0x0100 unsupported by driver
[ 1396.832284] cxl_pci 0000:35:00.0: Opcode 0x0101 unsupported by driver
[ 1396.833341] cxl_pci 0000:35:00.0: Opcode 0x0102 unsupported by driver
[ 1396.834355] cxl_pci 0000:35:00.0: Opcode 0x0103 unsupported by driver
[ 1396.835561] cxl_pci 0000:35:00.0: Opcode 0x0200 enabled
[ 1396.836488] cxl_pci 0000:35:00.0: Opcode 0x0300 unsupported by driver
[ 1396.837533] cxl_pci 0000:35:00.0: Opcode 0x0301 unsupported by driver
[ 1396.838519] cxl_pci 0000:35:00.0: Opcode 0x0400 enabled
[ 1396.839398] cxl_pci 0000:35:00.0: Opcode 0x0401 enabled
[ 1396.840236] cxl_pci 0000:35:00.0: Opcode 0x4000 enabled
[ 1396.841146] cxl_pci 0000:35:00.0: Opcode 0x4100 enabled
[ 1396.842038] cxl_pci 0000:35:00.0: Opcode 0x4102 enabled
[ 1396.842920] cxl_pci 0000:35:00.0: Opcode 0x4103 enabled
[ 1396.843801] cxl_pci 0000:35:00.0: Opcode 0x4300 enabled
[ 1396.844690] cxl_pci 0000:35:00.0: Opcode 0x4301 enabled
[ 1396.845602] cxl_pci 0000:35:00.0: Opcode 0x4302 enabled
[ 1396.846506] cxl_pci 0000:35:00.0: Opcode 0x4400 unsupported by driver
[ 1396.847580] cxl_pci 0000:35:00.0: Sending command: 0x0301
[ 1396.848532] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.849508] cxl_pci 0000:35:00.0: Sending command: 0x4000
[ 1396.850456] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.851534] cxl_pci 0000:35:00.0: DPA(ram): no capacity
[ 1396.852449] cxl_pci 0000:35:00.0: DPA(pmem): [mem 0x00000000-0x1fffffff flags 0x200]
[ 1396.855702] cxl_pci 0000:35:00.0: Sending command: 0x0102
[ 1396.857332] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.857731] cxl_pci 0000:35:00.0: Sending command: 0x0103
[ 1396.861722] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.863506] cxl_pci 0000:35:00.0: Sending command: 0x0102
[ 1396.863782] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.864863] cxl_pci 0000:35:00.0: Reading event logs: f
[ 1396.865202] cxl_pci 0000:35:00.0: Sending command: 0x0100
[ 1396.865510] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.865820] cxl_pci 0000:35:00.0: Sending command: 0x0100
[ 1396.866019] cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:34:00.0 parent: pci0000:34
[ 1396.866089] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.867535] cxl_mem mem0: found already registered port port1:pci0000:34
[ 1396.867813] cxl_pci 0000:35:00.0: Sending command: 0x0100
[ 1396.868908] cxl_mem mem0: host-bridge: pci0000:34
[ 1396.869095] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.870032] cxl endpoint2: Mapped CXL Memory Device resource 0x00000000fe840000
[ 1396.870243] cxl_pci 0000:35:00.0: Sending command: 0x0100
[ 1396.871567] cxl endpoint2: found RAS capability (0x80)
[ 1396.871734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.872657] cxl endpoint2: Unknown CM cap ID: 4 (0xd8)
[ 1396.872968] cxl_pci 0000:35:00.0: Uncorrectable RAS Errors Mask: 0x0 -> 0x0
[ 1396.873957] cxl endpoint2: found HDM decoder capability (0x110)
[ 1396.874192] cxl_pci 0000:35:00.0: Correctable RAS Errors Mask: 0x0 -> 0x0
[ 1396.875144] cxl endpoint2: Set up component registers
[ 1396.876718] cxl_port endpoint2: found RAS capability (0x80)
[ 1396.877419] cxl_pmu pmu_mem0.0: probe: 0
[ 1396.877737] cxl_port endpoint2: Unknown CM cap ID: 4 (0xd8)
[ 1396.879542] cxl_port endpoint2: found HDM decoder capability (0x110)
[ 1396.880442] cxl_port endpoint2: CDAT length 160
[ 1396.880740] cxl_pmu pmu_mem0.1: probe: 0
[ 1396.907371] cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 1396.908917] cxl decoder2.0: Added to port endpoint2
[ 1396.909922] cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 1396.911367] cxl decoder2.1: Added to port endpoint2
[ 1396.912273] cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 1396.913781] cxl decoder2.2: Added to port endpoint2
[ 1396.914732] cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 1396.916146] cxl decoder2.3: Added to port endpoint2
[ 1396.917018] cxl_port endpoint2: probe: 0
[ 1396.917909] cxl_mem mem0: endpoint2 added to port1
[ 1396.918935] cxl_pci 0000:35:00.0: Sending command: 0x4500
[ 1396.919872] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.920783] cxl_pci 0000:35:00.0: Mailbox operation had an error: cmd is not supported
[ 1396.922191] cxl_pci 0000:35:00.0: Sending command: 0x4500
[ 1396.923127] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1396.924051] cxl_pci 0000:35:00.0: Mailbox operation had an error: cmd is not supported
[ 1396.929359] nd_bus ndbus0: START: nvdimm.probe(nmem0)
[ 1397.071938] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.072185] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.073510] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.073775] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.075045] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.075281] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.076527] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.076750] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.078013] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.078240] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.079495] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.079720] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.080972] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.081207] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.082467] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.082694] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.083954] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.084179] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.085461] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.085688] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.086951] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.087178] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.088438] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.088662] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.089933] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.090157] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.091416] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.091642] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.092891] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.093125] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.094387] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.094614] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.095964] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.096193] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.097471] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.097695] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.098953] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.099181] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.103911] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.104190] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.106793] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.107066] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.108537] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.108804] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.110461] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.110733] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.112128] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.112410] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.113901] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.114169] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.115592] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.115857] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.117276] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.117548] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.118972] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.119199] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.120442] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.120666] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.122024] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.122251] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.123498] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.123721] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.124958] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.125215] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.126500] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.126725] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.127970] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.128193] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.129535] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.129794] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.133847] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.134072] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.135322] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.135548] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.136789] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.137016] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.138361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.138585] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.139826] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.140053] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.141361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.141608] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.142845] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.143072] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.147435] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.148428] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.149838] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.150136] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.151630] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.151894] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.153327] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.153594] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.155011] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.155289] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.156657] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.156880] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.158213] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.158457] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.159710] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.159933] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.161212] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.161494] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.162742] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.162968] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.164206] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.164441] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.165727] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.165954] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.167194] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.167435] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.168676] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.168898] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.170222] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.170466] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.171710] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.171933] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.173183] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.173417] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.174661] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.174888] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.179200] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.179494] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.181684] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.181960] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.183531] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.183800] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.185223] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.185505] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.186940] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.187208] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.188650] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.188917] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.190320] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.190543] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.191791] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.192018] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.193331] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.193599] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.194886] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.195110] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.196367] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.196594] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.197949] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.198173] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.199428] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.199654] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.200906] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.201168] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.202520] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.202743] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.203995] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.204221] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.205575] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.205840] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.207113] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.207350] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.208620] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.208847] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.213327] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.213603] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.215025] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.215249] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.216507] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.216733] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.218063] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.218300] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.219550] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.219778] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.221027] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.221322] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.222604] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.222828] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.224078] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.224317] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.225683] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.225948] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.227216] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.227452] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.228706] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.228933] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.230269] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.230524] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.231777] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.232001] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.233273] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.233505] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.234763] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.234986] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.236232] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.236470] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.237724] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.237950] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.239203] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.239438] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.240688] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.240916] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.245378] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.245651] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.246963] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.247189] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.248450] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.248678] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.250043] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.250276] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.251525] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.251749] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.252991] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.253273] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.254549] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.254773] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.256021] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.256247] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.257674] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.257937] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.259186] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.259420] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.260662] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.260888] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.262220] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.262458] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.263700] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.263924] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.265201] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.265482] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.266735] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.266963] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.268211] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.268446] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.269781] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.270009] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.271260] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.271487] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.272733] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.272960] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.277435] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.278482] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.279887] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.280152] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.281667] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.281935] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.283365] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.283629] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.284949] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.285232] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.286647] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.286875] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.288125] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.288365] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.289708] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.289932] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.294008] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.294232] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.295538] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.295763] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.297013] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.297302] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.298580] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.298804] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.300044] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.300275] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.301630] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.301899] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.303172] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.303406] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.304660] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.304887] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.309220] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.309518] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.311645] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.311918] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.313501] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.313771] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.315098] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.315376] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.316854] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.317131] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.318557] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.318827] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.320156] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.320390] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.321737] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.321960] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.323209] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.323450] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.324699] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.324923] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.326244] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.326481] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.327740] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.327966] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.329260] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.329522] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.330769] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.330995] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.332236] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.332471] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.333808] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.334031] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.335276] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.335509] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.336763] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.336987] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.338311] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.338535] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.343064] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.343654] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.346516] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.347038] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.349657] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.350025] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.352020] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.352401] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.354050] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.354290] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.355523] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.355755] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.357001] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.357295] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.358570] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.358797] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.360046] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.360307] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.361709] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.361978] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.363234] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.363471] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.364720] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.364951] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.366270] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.366498] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.367743] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.367975] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.369266] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.369541] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.370803] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.371031] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.375399] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.376471] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.377891] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.378250] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.379740] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.380009] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.381468] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.381741] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.383062] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.383341] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.384781] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.385011] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.386354] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.386586] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.387833] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.388062] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.389415] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.389682] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.390927] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.391157] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.392410] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.392639] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.393999] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.394231] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.395613] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.395885] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.397172] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.397453] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.398737] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.398969] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.400224] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.400464] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.401821] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.402053] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.403311] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.403544] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.407897] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.408134] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.410328] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.410610] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.412115] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.412400] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.413875] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.414147] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.415578] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.415852] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.417276] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.417546] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.418809] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.419037] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.420280] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.420522] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.421897] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.422125] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.423374] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.423604] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.424854] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.425108] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.426780] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.427013] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.428272] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.428503] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.429848] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.430072] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.431323] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.431546] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.432787] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.433015] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.434359] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.434591] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.435831] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.436055] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.439962] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.440566] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.442079] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.442358] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.443643] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.443870] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.445132] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.445414] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.446668] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.446891] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.448131] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.448369] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.449691] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.449913] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.451151] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.451390] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.452636] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.452863] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.454192] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.454426] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.455666] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.455890] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.459923] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.460151] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.461508] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.461764] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.463026] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.463308] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.464575] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.464799] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.466111] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.466346] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.467594] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.467821] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.469074] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.471756] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.473708] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.473984] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.475436] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.475662] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.476911] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.477169] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.478465] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.478692] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.479951] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.480174] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.481513] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.481745] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.482996] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.483224] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.484482] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.484706] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.486032] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.486264] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.487507] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.487734] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.488983] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.489269] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.490551] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.490778] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.492032] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.492265] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.493590] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.493813] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.495061] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.495342] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.496656] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.496879] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.498214] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.498450] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.499708] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.499935] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.503775] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.504472] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.506009] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.506289] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.507667] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.507894] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.509165] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.509444] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.510691] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.510919] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.512157] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.512394] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.513719] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.513943] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.515182] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.515429] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.516674] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.516897] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.518211] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.518446] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.519693] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.519920] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.521193] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.521469] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.522705] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.522929] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.524172] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.524410] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.525763] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.525987] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.527224] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.527467] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.528712] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.528939] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.530178] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.530413] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.531651] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.531878] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.535661] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.535933] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.537719] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.537990] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.539315] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.539544] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.540788] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.541013] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.542354] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.542578] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.543833] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.544061] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.545375] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.545622] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.546870] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.547097] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.548361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.548588] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.549915] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.550139] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.551401] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.551629] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.552882] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.553134] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.554439] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.554662] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.555916] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.556142] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.557479] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.557703] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.558941] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.559163] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.560411] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.560638] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.561986] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.562210] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.563457] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.563684] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.564929] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.567762] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.569760] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.570034] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.571453] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.571680] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.572927] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.573205] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.574532] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.574756] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.576010] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.576236] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.577585] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.577841] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.579085] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.579320] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.580565] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.580791] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.582122] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.582357] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.583598] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.583825] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.585088] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.585367] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.586629] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.586852] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.588100] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.588343] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.589709] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.589977] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.591236] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.591472] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.592714] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.592940] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.594309] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.594531] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.595816] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.596041] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.599906] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.600609] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.602136] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.602417] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.603777] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.604004] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.605314] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.605569] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.606813] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.607037] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.608281] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.608511] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.609839] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.610062] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.611314] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.611540] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.615564] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.615792] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.617028] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.617312] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.618582] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.618808] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.620053] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.620289] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.621628] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.621893] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.623153] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.623397] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.624638] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.624862] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.626178] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.626416] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.627657] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.627884] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.631663] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.631935] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.633755] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.634029] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.635361] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.635591] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.636840] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.637086] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.638412] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.638641] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.639921] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.640145] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.641479] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.641712] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.642971] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.643199] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.644461] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.644684] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.646013] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.646237] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.647501] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.647728] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.648985] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.649256] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.650548] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.650775] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.652036] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.652271] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.653635] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.653901] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.655173] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.655414] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.656674] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.656898] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.658230] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.658466] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.659731] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.659959] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.663786] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.664421] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.665946] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.666216] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.667518] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.667746] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.668998] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.669283] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.670563] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.670792] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.672049] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.672288] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.673642] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.673908] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.675175] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.675418] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.676676] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.676900] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.678225] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.678467] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.679711] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.679938] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.681217] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.681495] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.682736] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.682962] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.684209] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.684449] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.685806] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.686029] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.687267] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.687525] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.688772] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.688999] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.690317] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.690541] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.691790] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.692016] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.695817] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.696333] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.697864] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.698130] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.699446] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.699674] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.700921] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.701186] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.702480] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.702707] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.703958] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.704185] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.705518] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.705742] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.706985] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.707212] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.708467] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.708691] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.710043] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.710275] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.711524] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.711750] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.713000] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.713284] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.714563] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.714787] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.716035] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.716271] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.717611] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.717878] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.719138] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.719380] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.720630] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.720858] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.722103] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.722340] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.723587] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.723815] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.725080] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.727786] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.729758] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.730030] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.731460] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.731687] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.732946] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.733208] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.734508] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.734731] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.735998] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.736225] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.737580] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.737804] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.739062] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.739301] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.740571] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.740797] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.742137] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.742371] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.743633] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.743859] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.745140] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.745421] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.746688] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.746912] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.748175] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.748416] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.749776] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.749998] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.751253] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.751483] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.752740] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.752967] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.754300] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.754524] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.755785] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.756010] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.759852] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.760554] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.762060] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.762339] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.763757] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.763983] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.765276] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.765532] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.766781] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.767004] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.771061] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.771303] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.772560] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.772784] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.774114] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.774353] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.775610] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.775835] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.777106] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.777381] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.778651] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.778878] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.780134] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.780370] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.781739] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.782003] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.783266] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.783500] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.784748] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.784972] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.786296] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.786524] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.787778] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.788005] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.791784] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.792402] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.793939] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.794211] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.795586] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.795809] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.797055] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.797352] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.798626] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.798853] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.800110] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.800366] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.801698] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.801921] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.803170] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.803429] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.804678] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.804901] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.806231] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.806470] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.807720] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.807946] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.809228] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.809502] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.810749] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.810975] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.812230] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.812465] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.813718] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.813943] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.815193] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.815437] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.816687] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.816912] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.818232] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.818468] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.819725] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.819953] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.823711] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.824362] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.825904] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.826174] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.827562] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.827789] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.829041] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.829335] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.830609] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.830835] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.832089] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.832323] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.833652] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.833876] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.835129] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.835366] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.836628] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.836851] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.838189] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.838424] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.839676] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.839904] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.841179] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.841460] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.842705] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.842931] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.844186] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.844424] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.845674] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.845898] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.847143] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.847381] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.848644] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.848869] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.850191] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.850426] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.851681] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.851910] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.855702] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.855975] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.857868] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.858136] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.859493] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.859720] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.860978] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.861250] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.862547] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.862774] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.864040] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.864276] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.865610] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.865833] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.867076] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.867315] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.868566] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.868789] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.870128] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.870391] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.871688] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.871956] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.873262] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.873525] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.874770] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.874993] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.876255] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.876486] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.877738] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.877964] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.879200] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.879440] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.880693] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.880920] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.882236] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.882470] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.883720] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.883946] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.887721] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.888386] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.889929] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.890195] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.891571] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.891799] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.893057] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.893353] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.894629] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.894856] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.896157] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.896397] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.897771] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.898036] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.899300] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.899530] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.900786] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.901015] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.902342] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.902566] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.903801] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.904029] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.905311] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.905548] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.906779] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.907003] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.908238] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.908475] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.909784] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.910008] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.911245] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.911485] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.912728] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.912955] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.914246] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.914477] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.915718] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.915945] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.919691] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.920357] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.921904] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.922170] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.926314] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.926544] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.927793] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.928017] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.929308] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.929565] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.930802] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.931029] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.932268] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.932492] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.933811] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.934039] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.935273] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.935523] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.936757] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.936982] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.938303] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.938532] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.939777] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.940002] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.941286] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.941531] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.942771] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.942999] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.944237] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.944470] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.945725] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.945954] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.947198] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.947439] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.948678] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.948903] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.951540] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.952482] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.953981] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.954246] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.955821] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.956068] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.957470] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.957698] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.958935] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.959158] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.960409] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.960637] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.961956] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.962182] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.963428] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.963651] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.964884] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.965136] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.966435] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.966659] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.967899] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.968122] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.969376] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.969602] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.970838] cxl_pci 0000:35:00.0: Sending command: 0x4102
[ 1397.971061] cxl_pci 0000:35:00.0: Doorbell wait took 0ms
[ 1397.972299] nvdimm nmem0: nsindex0 signature invalid
[ 1397.972508] nvdimm nmem0: nsindex1 signature invalid
[ 1397.972717] nvdimm nmem0: nsindex0 signature invalid
[ 1397.972926] nvdimm nmem0: nsindex1 signature invalid
[ 1397.973164] nvdimm nmem0: config data size: 536870912
[ 1397.973420] nd_bus ndbus0: END: nvdimm.probe(nmem0) = 0
[ 1397.973693] cxl_nvdimm pmem0: probe: 0
[ 1397.973930] cxl_mem mem0: register pmem0
[ 1397.974156] cxl_mem mem0: probe: 0
[ 1401.169496] (udev-worker) (418) used greatest stack depth: 12200 bytes left

--/4PC/FtqKEXOGDQt--
