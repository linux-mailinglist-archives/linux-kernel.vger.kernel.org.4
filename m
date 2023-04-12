Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90E6DEA66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDLE2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLE2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:28:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A504EC5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681273680; x=1712809680;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bKsL0ysJBq75nIPy92UyFKA927KMGiUmjkMag7jhiiQ=;
  b=ZsX8TpgPCQNYyvuCcTok49GE7kn3L2SXkVrWqqKPCgilNAzyxfKkIn2i
   tblJ+5O29rLE2mLw4bQ37ze72t9dmNgIZHBcrLEL8+CrQip3tc3Uydl9Y
   TYl67E/oidwYl5pFVNegfGlx9ZHTf7mEhFYz35Pjq1qO0xsw4DhJoChVg
   EmPWvtek/aI4zqSrtbmzRk5JE8nbgV418zm2H2vhJPzk5fYBGGIENeqx9
   B+D5HJ7tIKoR45MenaADvHNKcxTbQrGo+ASPVy/xazF34F9jzk85MIQh8
   nK5+AK+O3F9XmRYnNB9DVDCr4/ScLML2E821FtZfH2eygs/nFAMf4OP1N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="430084317"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="430084317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 21:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688818183"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="688818183"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 21:27:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:27:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 21:27:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 21:27:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 21:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrk8lbsWmrC2aE+NUFcmWCW5k0vTFtAtNtPhbuJg92+yVQAePvWh9R2chYbemXqDCWTRoZJkyNlzV0mQZND39Qq189cd5uKxi+xiA+Sv4GQpkpELqkB3Ng0FDgfGvUEKOftIXMEjBTKoVdihz1dEHdJR06+t7+6RtHPAlLxY2LloXbSzRSguq9WZOwc9j5pKpvBme0iKzgXNyjbpoSJBMSNpbZoMiKbxx6IeX18W854miJ3uWiOP1RsriwNYwpvZrP9zRLELuuj7mcillFp8DsfC8JuRUp1EsLDXl6QD3B1PpiYWVch2tfOTjMd2+5Wo7MGPJKknS2PXXFv9mtsMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC56eX21I97CdldRX2prwIaE+Sn//7to0SgBtvGj4kQ=;
 b=kUZgEe82B85A5bV16lziD/o5kaCjv5bHD97gA80UyYyfJ04tF03jKP5YAB8aBE8xQxaP6sBLQaiRSaYoYxyMk4SD+qV6XnR712G35gvaQ6NZ5RduntPCb9sdGl/PIdLpuCBqZhXju+KN0l3eFbKmfWSDBZezlyOO+2dLAUDX9VFG45lAju8ZVsVBHNJjQROslUVf/X+FfknPGwGjVZMpwbXV9OgpduQTRgp4Ts25yMvxr7dwUFVDMxzZnBs8rP9Wvw0UEs5wYokyGjwhAQr+l7QKvs+DGDUI3LbQjCyPXHsHRFrqreBSTxH22l86xz08jbd3/cMdm7Xm1BRgX8DZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 04:27:57 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 04:27:57 +0000
Date:   Wed, 12 Apr 2023 12:27:47 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230412042747.GA10674@ziqianlu-desk2>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA2PR11MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f49b72-b111-40bf-caf4-08db3b0e4a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKynQ3y1mxirkMrh0OnxCjsJ3s3IBnG7MegD0WxtJv5PuR286UzxEkAd3MmGR9gQT19Q2tpNLVAMC8AkiVZKfkLmkkMxXdyIeSmqPaNpQKnyQrAxJDSyW5X9OkIdO3jz5dwlA4ixQoGHzwxQyeakNHXnN8l7paeLJMZcVSkGtyD+RW9//pLJEIQM0tpoSQXjwOjnvjeHuiG5IoQjgI+94U2qywbWf/rtRFJ+uu3cfyzY+8NSUlm5zYs7QY4TLOuobGIaqK5TouxY83MYkluemwPbRYqun6IU0XvrlTWbZ1VvWANPttSak7zYmNMKO46aqmbDaHbxz9+2tYcS6iYZXmboi+iiXD04iGJHhfM7tHej2DBkTSx+S6DtP0pX/QlD9fSTCushtSLh3CCOCqWSVfUfgCA0mq7aGT1docp772qTg22bwx+X18ra4MvWQO2oqW+cCWbI/jYArbO/Vz9GvTrto+yXVnHjuYf7gf0brsGN3DSFihvzh11mZQx3NMvk5Kz4ouP+yND4+6IQxspUBg7kpWUgv6Dch/dK8xZPmI6kbGFpPUqE88dHhwKKchYS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(6486002)(66556008)(54906003)(6916009)(4326008)(66476007)(316002)(478600001)(6666004)(66946007)(41300700001)(86362001)(33656002)(45080400002)(1076003)(26005)(6506007)(6512007)(9686003)(2906002)(44832011)(8936002)(5660300002)(8676002)(83380400001)(33716001)(38100700002)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zJUB0c6qjWWCZPZXgJkuBCIy32BpKvRw9fDT49gT+qwCSnlMWurnKw27Jbz?=
 =?us-ascii?Q?mY9971n1J2/J0EW2GPPIrxiKjEC+Q1fzvBMp/56ewypndaQeNYB/F6xpgyCw?=
 =?us-ascii?Q?wvlhBKpEAlz4DOXmB7/uCp0olB2QpvTSYHsKAigxNcZsxiuBsmp6Ehk1LI8I?=
 =?us-ascii?Q?8PP/Cr1yYOKMXvoWUu09up04UqGdKTAY7Wqk+eLMfwJ/2jJMiKhrrDQOR2Ye?=
 =?us-ascii?Q?98z43enFuv/FJZP/NgVH59VwDMHlyxZH4tgxzIjZ7L9oldnQB8Hy3oBOIBnk?=
 =?us-ascii?Q?1h1Y0DIR46AplJ93KoHeV1OxXOhCjXOgx0PlOBIHpynXDP9xoeS/rZUEhB8+?=
 =?us-ascii?Q?dVc53j9rJ7OmB87PcHP+xnJPZznN186QvD4pGYZ/DWD+dDZ4CJbGv3nJfr1y?=
 =?us-ascii?Q?g1uQNaky5VcUPI64veDx+yvTiToo9QPvtP/7ITzZCfrIuvMoR10abe2UwJS6?=
 =?us-ascii?Q?VXt9Fc9FZ+D+qS3dZFV7ZiTZ17/W+y1PD3fpx+rf1Sl0MAYptH+hUL7N6Gyv?=
 =?us-ascii?Q?rJRGTWAOO0CXDbqa220JBzWLOwCH07TtE3r9sMTittur0Wf48wdE3qse5bBS?=
 =?us-ascii?Q?nu6poVM3FWx2FGnS/Zz/TBN497yWlEhi2/NYVanIT4W0XLFtKo+ylkpucvTX?=
 =?us-ascii?Q?4h/GAwW23Zp+BxaaHTtwPtIUfBQrS4d2rMBO4aOMabZyL5jnlGgmI++98L14?=
 =?us-ascii?Q?52m3fZEHu/pQAwCPBfLHqktKvpRLmnnszckCDkzKquoCRw3ujDXN0iyVzEGm?=
 =?us-ascii?Q?2LQnkBUCDCh+dNOnRvnWrXfPDAcwMxF9ckAIFbW+t7fhRZktnVRS/dstm/9V?=
 =?us-ascii?Q?8hqE55Zl5O4eToOSvfHHqKKcoRTwIgLwYU+gVFjK2AmadSQdjN4UPQree228?=
 =?us-ascii?Q?u4EcxYm2Zd8lXIept482MdqGpmAFR/WoBglIAR0Es78/hZm/JZqjUItIa5vM?=
 =?us-ascii?Q?D3RPV8c47N+L1/LIjyylHnLIfoLYYw9uaLRsqv94cG0VHV9Hlb8PA3UeSEA9?=
 =?us-ascii?Q?BJwdxjo8Y1dGzW72nx5cpCNBH06unyATCsZMTTYCvpcFkEoF7E88+34zGtUV?=
 =?us-ascii?Q?1pzGWq+9T8boqn3aRE3K4888OMv/t4McLeHX+7aBT0gnfxgj1/FMwHInoakA?=
 =?us-ascii?Q?VJ6mDpTYYExaGxX/hM4chpYqpe2P2NbY1w3VzIU/89/fyg2wczc6XBvGxAyp?=
 =?us-ascii?Q?vNoPqZ80lNRmTar/Wf0IxFPf5ypJ2ahXMQGZ+3n5G7+wTEFsIZ8UKFt7rCPE?=
 =?us-ascii?Q?4KvAW85av0Xx+/b91+BR3GxoyubE8BSQyawcSb06mQOYkb7tW5zAxHgX1JCh?=
 =?us-ascii?Q?pqXg4FAPIS+NGL7AwoYylZgfLBk0i1A2pSTwlW9zF+lYhj2HLQARtJ3SaQxu?=
 =?us-ascii?Q?rmV08RUnSP7Fwj79YbC6iH552RgOgh3edvimTI6/6vKQMuY67BP35iHsKyfS?=
 =?us-ascii?Q?O7QUiSkX00BAz0ZcE0ACdhsctki8DKM9qvg0Azful/oe2MdnXSeES8lVGl7o?=
 =?us-ascii?Q?x+o3P+4E+/bOH/Qj0eMmiakBKUm/gsOP7WdfSpL9NdOy3ncW43Vs9WeZ+kYy?=
 =?us-ascii?Q?5DvQaKBd4Kv0KTele1i3WdM6CKFCHelTtofcUocS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f49b72-b111-40bf-caf4-08db3b0e4a3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 04:27:56.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vyItQrIY2tZNWImbNf2yWTDJrq1UWDxWHaLCGY378B2HsobLisH4DYdaBY6qcbAC8kx6K52vbwphCGIOVHYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed below warning in dmesg on v4, the warning is triggered by
WARN_ON_ONCE((int) mm_cid < 0); in rseq_update_cpu_node_id().

[ 1819.649803] ------------[ cut here ]------------
[ 1819.649813] WARNING: CPU: 188 PID: 29881 at kernel/rseq.c:95 __rseq_hand=
le_notify_resume+0x49b/0x590
[ 1819.649823] Modules linked in: veth tls xt_conntrack nft_chain_nat xt_MA=
SQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_=
ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables nfnetlink br_netf=
ilter bridge stp llc overlay intel_rapl_msr intel_rapl_common intel_uncore_=
frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_therma=
l intel_powerclamp coretemp kvm_intel binfmt_misc kvm nls_iso8859_1 rapl in=
tel_cstate mei_me isst_if_mbox_pci isst_if_mmio idxd input_leds joydev isst=
_if_common idxd_bus mei ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msgha=
ndler acpi_power_meter acpi_pad mac_hid sch_fq_codel dm_multipath scsi_dh_r=
dac scsi_dh_emc scsi_dh_alua msr ramoops pstore_blk reed_solomon pstore_zon=
e efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid45=
6 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq l=
ibcrc32c raid1 raid0 multipath linear hid_generic usbhid hid ast i2c_algo_b=
it drm_shmem_helper drm_kms_helper syscopyarea sysfillrect
[ 1819.649903]  sysimgblt crct10dif_pclmul crc32_pclmul ghash_clmulni_intel=
 sha512_ssse3 aesni_intel dax_hmem cxl_acpi crypto_simd nvme cryptd cxl_cor=
e nvme_core i2c_i801 xhci_pci i40e drm i2c_smbus xhci_pci_renesas i2c_ismt =
wmi pinctrl_emmitsburg
[ 1819.649924] CPU: 188 PID: 29881 Comm: hackbench Not tainted 6.3.0-rc6-00=
002-g1acfd6ae9afc #2
[ 1819.649927] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS=
 SE5C7411.86B.8901.D03.2210131232 10/13/2022
[ 1819.649929] RIP: 0010:__rseq_handle_notify_resume+0x49b/0x590
[ 1819.649934] Code: f0 ff ff ff ff ff 00 e9 00 fe ff ff 48 ba 00 f0 ff ff =
ff ff ff 00 e9 3a fe ff ff 48 ba 00 f0 ff ffff ff ff 00 e9 66 fe ff ff <0f>=
 0b e9 7d fc ff ff 0f 01 ca e9 a6 fc ff ff 48 8b 4c 24 30 48 8b
[ 1819.649936] RSP: 0018:ffa0000018b0fe60 EFLAGS: 00010286
[ 1819.649939] RAX: ff11007f73500000 RBX: 00007f81a7226fe0 RCX: 00000000000=
00000
[ 1819.649941] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: ffffffff828=
f9477
[ 1819.649943] RBP: ffa0000018b0fee8 R08: ff110040c192cc28 R09: ff1100408e2=
a3980
[ 1819.649944] R10: 0000000000000001 R11: 0000000000000000 R12: ff110040caa=
64000
[ 1819.649946] R13: 000000000002fa40 R14: 0000000000000000 R15: 00000000000=
000bc
[ 1819.649947] FS:  00007f81a7226640(0000) GS:ff11007f73500000(0000) knlGS:=
0000000000000000
[ 1819.649950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1819.649951] CR2: 00007fd8b00d5000 CR3: 00000040cf060001 CR4: 0000000000f=
71ee0
[ 1819.649953] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1819.649955] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 1819.649957] PKRU: 55555554
[ 1819.649958] Call Trace:
[ 1819.649960]  <TASK>
[ 1819.649964]  exit_to_user_mode_prepare+0x13b/0x1a0
[ 1819.649970]  syscall_exit_to_user_mode+0x2a/0x50
[ 1819.649976]  ? __x64_sys_read+0x1d/0x30
[ 1819.649980]  do_syscall_64+0x6d/0x90
[ 1819.649984]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1819.649990] RIP: 0033:0x7f81a77149cc
[ 1819.649996] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 =
c0 f7 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 ff c0 f7 ff 48
[ 1819.649998] RSP: 002b:00007f81a7225d70 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[ 1819.650004] RAX: 0000000000000064 RBX: 00007f81a7225da0 RCX: 00007f81a77=
149cc
[ 1819.650005] RDX: 0000000000000064 RSI: 00007f81a7225da0 RDI: 00000000000=
00135
[ 1819.650007] RBP: 00007f81a7225e50 R08: 0000000000000000 R09: 00000000000=
00000
[ 1819.650008] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000004=
a3c12
[ 1819.650009] R13: 00007f81a7225e10 R14: 0000000000000000 R15: 0000558df7a=
f6d00
[ 1819.650012]  </TASK>
[ 1819.650013] ---[ end trace 0000000000000000 ]---
