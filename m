Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8854744301
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF3T5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3T5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:57:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395111BF3;
        Fri, 30 Jun 2023 12:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3DCeFKAMFey4ptZQoCrsu6k88Xns4s7+YWW/xES9nu1DOzmKfSsutjnHuOsuX9rknwcK8ugQ+z6eoC+70WdQHRagZ81GQ4jYQc/QlnVj19tXl/ZbYCK1NUHivzBGDN5crCXeDeFpg9tBhWRUKH6EOOt8eN/fTRPTJuXWTFgQXQ7rarwe3VA5I+hQtUNXKq0faAvusyk2yRHczRIaVhaKB9sPH5c+muX4tHNaiYa59jA50QTk/xaIvN3xnwuX472zgq6TwiPQInT2sQ6geUvy6F85sr+N6HEToWWjKQbnoIaBOZrr3quIHab2uGgl853Yep/julyRJVzlS/zwzBmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkkjjd8doiF6gK5dPlRqd2NQ/GRGGZAk4NfeT/BXYIU=;
 b=U/n+MMf0fJGAAJAu8dC10p/xrNHigfyrxiETHIMoCUYLc7dIB6PzSTaAYwPAOO0Y6liG5Wt1lHMpHB9gxP0qw2H2V5pEeefggE9XumZFwNePFaOxLF+FzjdlwqXhckLF3CHhJrs3EV1AfnDSifjBl0yUtFZRq+QITl/FINHEcEYkGNfl6oXEQPo+U+1mxyNR2YfC9GAd92lqw0kLqBSYKMU8s5rQbiy73s2EayyXcbbB1dEbiWz0xZb/WYip2jZVMGMO1Wj2RmGBGdj0BvwHR6AkG97Qns7ZsUcKgFjCrONYhaMjAxv5RriGqW4ZNa/+RZnFN3SFCDujkfU7LjqOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkkjjd8doiF6gK5dPlRqd2NQ/GRGGZAk4NfeT/BXYIU=;
 b=BVkvYqMZGsD/bMWy700eQ1bFDPS3mtM7mKkH0/DFFBa9pZtOdXztLnNIXLfL6eBI9kSHvttYe53CoEjhjoERXlZeQrN4pBoAxoj7EQ7Rvj1oKofvGpFkWL9xX010jLVl6Jf548XC4IW0iPM9TuemNjI4bNXPx3tc7JoOZveDITs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 19:57:15 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9f62:7548:e693:1d3b%4]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 19:57:15 +0000
Date:   Fri, 30 Jun 2023 21:56:44 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component
 Register mappings in struct cxl_dev_state
Message-ID: <ZJ8zfDmw+xFvSN1G@rric.localdomain>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-17-terry.bowman@amd.com>
 <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0b1d3a-886a-410f-1df4-08db79a433d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2j6H9CZtxEEpV+lgKRYXONk2u1InXwagdvn5XUtzQCRtVSJ/yaoaaTiefvF1bQjHItdyBdhpOufyLtzP7c4adGEl7G9obS2FRGb6fHqgyRCr//IYcmV1OFsIzuxhvY2KHr75sQu2SMqD9pVMSmnxhXadNwZozvOWlW6vagtDvJ1WwY/e+83WevbTOcQBIgunfHdA9J69xklw/S4bZ0+NvOxhL/cDOSUg8h0Ygl56LQBr273GqTmgg1Qu2UW3aoUJIEm9IEPGe1L8EZcDTcf83zNC7OB6SQIZmSROZtRgX4e6aJVO1ZqmXmKXs0I3XF14ckPI3yufl6E4MX37t4TVlseVxFRjRwlJQmnSlwjPgNs+SX5bGvqXjldIy9mFiMsySvzsfTyFT3PEK3z9U8GUvne0UJqfWvXiUsZI/VMzPuxIuGMNeEdPzk/MfeEETdSFtS59te1t838kDF8gHRlsiAQ5bJ6IN7BP8emT3XqvVQdPs7CRBzEWM83X78Ks3Hge/ohvQ3j3kIG5leLGD4JLLa+ZXnGbq+2ph/nRkZA9Flg6Cosx/nBRKjOxtYeGbmE+v7LJvRU2ECOSg3fsj766WWxC+IeAiS1gxi7dzxRJd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(8936002)(8676002)(5660300002)(110136005)(7416002)(26005)(9686003)(6506007)(53546011)(6486002)(478600001)(66946007)(66556008)(66476007)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2906002)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFMkpFLsne/4SUykjq06X5p1Axmdo0PM8uHbRy59HAmMTMWtMAlQ9beKexCJ?=
 =?us-ascii?Q?sf6BFOKMo27QcnwmKRwa9DelG64zmM0Mp5uKuBtEhvaPq5HEev2jYpylRZCA?=
 =?us-ascii?Q?TXtA7hpqqYbNZWzHFyBzx80hxcE+qfIaIk2Gao19nVZxUhW9+Ad47KVJW298?=
 =?us-ascii?Q?r0IDYf2Kz18q70BaxTpceUT9ehYudLBslMuboUJXi6hkMTW1nP3gGK70Dbog?=
 =?us-ascii?Q?ax0neWA1oL4A4875PTR29drEEr16LN3oZSAMwaMon/04F+1iShxowORfS65i?=
 =?us-ascii?Q?btQYF+TayQa7HKGwCpYTVCFJpaA++itxReyPLSuw/AsNGfT51jsAX9Cp8n8d?=
 =?us-ascii?Q?0UzJ49FRH6gMDlLD9nr3q/o2gtbnL1AXCYDbNMw1+j57+ruUAQQhwqoHddh4?=
 =?us-ascii?Q?SacB2JJzJU/ao/2E/2PVe7UKlU44p7F7eu3qnA6iAgyYFxB1+gMAyIrRtI/T?=
 =?us-ascii?Q?Ddfk2omhqMQh/PAHHxdC+dCBReKqoseT/j6lBLXMWAvgxqGH85FfQ6cDZyu4?=
 =?us-ascii?Q?9yFU+XiNSbBggm3TNjwDFNhu3UkA/GSLOCJyR7WTLNVV8Eb10z75PsL1OS4/?=
 =?us-ascii?Q?jE8FFFyacLLDdsI/tUfBAN7mL8mInDfGPAut1lRRetSQZRbN25TKjh2mzhLk?=
 =?us-ascii?Q?nY4Bq3xm4Vk0PyJy76DQNF6b6eEa0envRd1UZGgOkONXZVquHQKSBDBNbdfL?=
 =?us-ascii?Q?SSPtNSFO3uiPNKT+8yU6e/FCiVUXlPW10uOR3VuSfcp1uxVri9TfZH1j9b0j?=
 =?us-ascii?Q?n7Nt7YK4G7fggBo/Loiv1a45bYk3PuZ8B0PfCH/3QvimquiI9ZaRbiMykrD2?=
 =?us-ascii?Q?veX1n5JAJURHmfSdfowyhzbZ4HL+zNXsx+Hxa1al4WmBkPiQwMqzWSlk/fne?=
 =?us-ascii?Q?mMwwtkO0XZ8m/Dmp/VUwTl0cblLRMDE0fE5IKZ62SPHtKW1D9U6hM+uDxic2?=
 =?us-ascii?Q?yUzSx7AGVIhrXKW6fUckMHYxQMowDS4DDs0YzIFArfiWUhC1HYjA1fVkPEX7?=
 =?us-ascii?Q?ukmWBR/sTNTRIq2vTBuLywaRc/Vg/now4E5s1/aN8n92rKvMTtNqY18EFcyZ?=
 =?us-ascii?Q?/7HHd2P43Hx7861rxiMiXdPvqPUpfUx9cRjjxkOqikkau7rGFioVsgRGWvfk?=
 =?us-ascii?Q?sDKPpg5kJ2dHEmDdmTQfRo3a39yT5hTgzE27Vc+gyaxRkylvhdej8IJIujzx?=
 =?us-ascii?Q?bzi4ctjAxVayQCE1QWaNgflxOL7A6SU0TjrDhTGSP+eB2q6xrE8TTEqK1UkM?=
 =?us-ascii?Q?h5mX5gqJDc3CKCiUt3QWCz5U6jbUtupFLiQHp67PEnneW3aPKTRQrHmcgH+5?=
 =?us-ascii?Q?y+NgmVdgVYmYJhxi+NsRrFc/zFBQHkxfhAK3dXMW+dGuHO3fbAy+y+UHZvdX?=
 =?us-ascii?Q?IY7LBgxK0jJKN7TW6trspKcEuDH2UpUUs9Lvd7AvBECuFLozGBphHTlAnGx1?=
 =?us-ascii?Q?vjgHnKk3YnCClmA6BB2rbnbYk2pnaJrKLKHBetssKoNaShoMFK/Om/qlW0ha?=
 =?us-ascii?Q?cVhOjZ7eXqGGIl9EFDMLgpVT7WOGuUaLJaOKGw/ah02FAsZ6VkBrqfEaU3B+?=
 =?us-ascii?Q?Q/IDEwUJrGVsOm9D7io=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0b1d3a-886a-410f-1df4-08db79a433d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:57:15.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qu+8747qxpRdcPfBdhuGF1xSexqdgqsKHbG+9F4smEoyGFHXxxQuIdQ4ZmQFSG7W1LLlzgZWUQB5zS8qH6jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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

(resending without logs attached to make vger.kernel.org happy)

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
