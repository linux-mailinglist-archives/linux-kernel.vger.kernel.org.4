Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3664883F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLISOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLISOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:14:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C445A4322;
        Fri,  9 Dec 2022 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670609673; x=1702145673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NniWrh4KpOoxNyIODDVolWLRUHX9nGWJ8oTajcy3xNw=;
  b=hNCMxzfKJUVxF1tjwbJBtTIjpO/snvJXMlmjOHgjOjnqf9xId0i/bzOP
   VgkjUXAnlJzcXn/P3TVWdDVw+KRUnJV97lud+7UHxDox3Ww51hLqoUKvj
   leugtLLs3xRGfIlSy6eFzXLmImN0eFbGZUq6LG4IirnOGeUJfVIs0Su+M
   nGopkA1HwIg5UkZXhHCmWXZwfFWEZUU4hG1PBFn/PRWbkCkMs6Chumpwd
   LPXCiewUqP+KLnjoC3zyKFUJbzo3UAVz62NlSgqaAnZu7qYhE4QkqILzv
   OFYiW0C0vHNqt2dt6GsBZPd3uel+tipXIenkKhYC3JnucK2zr91jh3Caz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="344558307"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="344558307"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 10:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="710974438"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="710974438"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2022 10:14:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 10:14:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 10:14:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 10:14:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 10:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzZKSolKmOi5fc+B0hU0ozx/KrgCRdbKVqXKu9C4ZVqayzYTKAUOsKXTWEz7N477JdrA0ven81tPUJx0MK8PxqH83NAUFsLwjaayAvlrqAOAhr3p3WllyYrFyaKFU+QaHDSfUp6lyToDgV1TVSojrDX301eKh5Pn1y3tWrrGGvyKoW8MwlgXFKUIrQO6Kzk3TkHYBcDY6BEHwWcy0cP93D7sF6D2qJPBjd9KIAHPMc8g2BCwRRjpxE/pKSwhpwHomH7kYOBkvP3Yw81mshhY6WbNpOD9H88ORUrhFlGZpBlFR4bY0qHyjoQH2lpAndkUeOIsvquDQd9QUjTiMKyHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdOIEAVpM4rhSuQ4fxx045joNURDhjL+elqZMGkf3Cw=;
 b=iJMyu8/NC8ZFKRozbYHVjANW7NdhUIGvbAEOYnd1yjupqyjR/9KR/LDQjZ/G2mI+NSCX7hKop8Io5QrPmvb5QepqlYOqDwre5UakuHEKVLh6QLxxZSIdAGTV/CHLZ6hMec2MPQ5pdWakMa68sPyVbIi0BT7WRNYr4ZNf23zGsmbSEtPPWTrJPZnEKbgva2XdUlH9NTId30hbmIhXhpwSkE6hPkdrp8fUV8BPeNtSRvVzUcvGr83xzcZPpYblkBLEpLjP0G6V1aCbi+Pt51Zc0MIrKZ0aAhy1/kRD7Har8ly4/N2V6+F3LC4/kZ/83iv18iRm4Q2jOLUhV5rOfwCSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5515.namprd11.prod.outlook.com
 (2603:10b6:408:104::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 18:14:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 18:14:24 +0000
Date:   Fri, 9 Dec 2022 10:14:21 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221209062919.1096779-1-mcgrof@kernel.org>
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN9PR11MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f4e530-5edf-4d99-6cc1-08dada113396
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2GnBc2fgHOy9ILwPj0+r2Q8zvHD3hSj3tSh7LyyeDZKqzxGYjtIneemlbk1BtoJvBYY17xht1B6AnNQEYp/Ka1c1vQuIMha5Nws4+SLE5QryAFYJPYGtqOCO+xYrYMDraWwkf0zmUDOe1HlDEqXihU4/UDEJKyhV1o34IIQ+XOvNAQ4x+CRni3y4oWuE2HEwANcnmHpSdsERAZ8Xt0IYL5Iu2S0/ZehTCjqYoPDEGTR12upRZ56J0zoFqX1/NqLBHJWm2JdyqmFlIitbwrywXHO1WuJqk2ETE4lI6tQFFuaYL0Rk8xEArZLov1m/HXlmVw/UQay7YuwN3tksrk92Cx2StbRL6FaZmv/IG7zRU6BZukOEsPSyvnAF0UFYchE+wZGm0tlzOmJPuFRzqZ/i0kGr/fjTgiZXEXdVFHKtKal3P5q0RraIR9OXhktOKxLBeSUyR8N4lBjVc9HdUZ71ZPzHiybIaZQl+AIpqycffRtl6v58iMuUcrWxW1HPFmW2Epr2E5eGEELHJgihFTz8Omt6jHz9eE/5hdUNUDVViTw9vN06YNmLwnK/vd05gr1tscwdlmlxXPlUN/ui9czr+YzU6Xz95ye5bsFGrEzqwq62cBs5BcsRWMwT0Tzy4b2Owp0gTibym6jhcxXCkowwtnEoyGCkSUuIDIzgBhcwxMJgchZoRO6vLd+DVXs3hpuU+sKqNWiddyyuilIp97C6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199015)(41300700001)(8676002)(4326008)(66476007)(83380400001)(5660300002)(66556008)(8936002)(38100700002)(966005)(6486002)(478600001)(82960400001)(186003)(316002)(86362001)(66946007)(45080400002)(6666004)(6506007)(26005)(9686003)(6512007)(84970400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKmzDPEuRn9vZ/wyBUfDqzFS50OSHCuXDQGl4O6J1j1RNeqdIKZbe6zb/7Ex?=
 =?us-ascii?Q?VmdLlu81KaUP0viiOwXWG2OB/ESvPI6ojaoZf0Iq9aWRkL2fJxpc6sAEinpT?=
 =?us-ascii?Q?xUObqeDCDMFcdwBR1B/Xht3wjF4LPm/um2SdfLrYouVaHP82b+ERq4e0nMra?=
 =?us-ascii?Q?Wa4ASP1myPDjFEUWMjFf7xWxUJuqGkoLZQEO/26DzqBhrTJMK5oSb/+SCanC?=
 =?us-ascii?Q?KYGamthj7cbBUHEA/JqVS6i3C28oaod3z7CLT6llXyevia2XjRke4fWAWbrY?=
 =?us-ascii?Q?iFX2grmZNzbAv9M5KLKp59n3KX7aNRH1NZUO92U2PlCJ82QkB9zCjtQC+T/H?=
 =?us-ascii?Q?Om7Ge9G3q+DgZCiZO14mNts/fRgLZQgtam87EPBK9OrOVLEU6jehtlA7tS7k?=
 =?us-ascii?Q?Jd7Vh9upFarVYuzuJGAWwBcthiQJAe7cN/+MesKfbzoVDWlIe9SXQfO92iGB?=
 =?us-ascii?Q?De/yFDsZNMEHf0RJbStmt/BRQMIRW8mw+ZQ6j8WhZ2jYhIWLl6R+Ev/kEAgC?=
 =?us-ascii?Q?cRcnq+akdBVct8/q4uzZRTGp/jrZc6bNr5DcH4f9fYu9Q36pNC5dYjzb5VeA?=
 =?us-ascii?Q?yeG9bL6jFu8fSXBaU7z9kFKL28F/FlHjiOchahi38+uhpDm5Qd0IcJRFlLT0?=
 =?us-ascii?Q?tu1D3eQY0pgBRcQb0TuVq0B2ITqkcEfjNDCOpRZ3ylPHC872vMWxBLTNfpUm?=
 =?us-ascii?Q?SFR24P574NrrSdySTWh7eZOuxGKDLN7sg+NE/pHWEoIcMwmNW1IXfVfFUPAr?=
 =?us-ascii?Q?0oeDDaLuFfw5qBTVUu4XSSX23UdcywVgfu0ViaVXOBirf2hZXQOG65JHiCSD?=
 =?us-ascii?Q?tpAUTwz+ENBBL/GAFJOc4DTJeQF5MSBElg1OhUsCDbXlyiUnE+I5qFJVOjrm?=
 =?us-ascii?Q?5kqytCYNz1F30k24pnWxdU1TcLFc8XfJXpKsE5cFHSx43O3NWko8znCXqAZ2?=
 =?us-ascii?Q?TT7PxfEYajI+F+22W28/JTcFsTvYl4X/0Tb5DfTAlyDfGNDSyv4Up4cXrd/x?=
 =?us-ascii?Q?8RXNIzwKV7O1weLjc0+3Go0bRlLQpRuCVFo+esgeWnanBHiA30tNqxR1k9/C?=
 =?us-ascii?Q?CAkQPRhldTDDamDsq8cXW+KW6PABi+dmF5SAsne1n/sw8F9AlACuoU1Sw33g?=
 =?us-ascii?Q?PVleDB5IjD2UHOnb2nImd/x6lOX1TMOVeesw9oDU80NYYPIDQpp1xJaCbFjl?=
 =?us-ascii?Q?ThPtpKfb4In/JUEF9tSJbjP8gWCg/FaSMKOYEF/ZXqMFgcZ3TrAnTAVaEF8Q?=
 =?us-ascii?Q?S7xVlIL/JtXi0RJrA5XP4hDIzENgnXCgw5EMZ3XCTTO1goptzjEmbo/m+CRY?=
 =?us-ascii?Q?p7m/PD+QhNPXe2vcAeiFBiJg4UUo88Ok9cYNa8EXqcBSAYqHW005IurlLTgr?=
 =?us-ascii?Q?+mV2vrFW6chgk13kTdmSnD+lBqP8qqkrevQNa6mFH4bUh7ZLhYLaUrN8hX5H?=
 =?us-ascii?Q?6jjV08nfcJLcdxFSgL3N0LlBkknCDbll63tBZGLNzn8A0leAC4wWNUnsRIC7?=
 =?us-ascii?Q?k9r4wJ+8MYuwBNjQSLNLzjqayGrLgXPWztlI1cfj5CD289bjobmtreF5eTlN?=
 =?us-ascii?Q?hDEUSs+NqTrP0Jt9J8mtmp/6m6juEa3eMKD5trASWY5GHZID2+xx4wej13T3?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f4e530-5edf-4d99-6cc1-08dada113396
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 18:14:24.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfUK7KfsIWFBjpageZ2rz2CX+fK4Ty98zE5lVTBtn0vXTq2lgY7kubf4wFloSi/nZHxDWQ2NBWu8CrZAdtFMJv7HCRPvTWe3pdxflUxD4ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> Simply loading cxl_test ends up triggering a null pointer dereference
> on next-20221207, and it happens because the fetched ACPI_COMPANION() can
> end up not correct / missing. As with other code which uses ACPI_COMPANION()
> (drivers/acpi/device_pm.c comes to mind) be defensive over the assumption
> the companion is always present and bail right away.
> 
> This can be easily reproduced with kdevops [0] with linux next-20221207 [1]
> and cxl enabled workflows:
> 
> make menuconfig      # enable cxl and linux-next
> make                 # sets up variables, builds qemu from source
> make linux           # builds and install next-20221207
> make cxl             # installs cxl tool
> make cxl-test-probe  # loads cxl_test
> 
> The oops:
> 
>  # modprobe cxl_test
> No TPM handle discovered.
> failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
> 
> [0] https://github.com/linux-kdevops/kdevops
> [1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20221207
> 
> cxl_mock: loading out-of-tree module taints kernel.
> cxl_mock: loading test module taints kernel.
> cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
> cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
> cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
> cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
> cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
> cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
> cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
> cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
> cxl_mem mem8: at cxl_root_port.4 no parent for dport: platform
> cxl_mem mem9: at cxl_root_port.4 no parent for dport: platform
> cxl_mem mem10: CXL port topology not found
> BUG: kernel NULL pointer dereference, address: 00000000000002c0
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 4 PID: 1644 Comm: systemd-udevd Kdump: loaded Tainted: G           O     N 6.1.0-rc8-next-20221207 #5
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:cxl_acpi_probe+0xeb/0x2f0 [cxl_acpi]
> Code: ff ff ff 48 c7 40 08 ff ff ff ff 48 c7 40 18 00 02 00 00 e8 57 29 fd ff 49 89 c7 41 89 c4 48 3d 00 f0 ff ff 0f 87 73 ff ff ff <49> 8b bd c0 02 00 00 48 c7 c1 c0 64 e4 c0 48 89 c2 31 f6 e8 bd f1
> RSP: 0018:ffffbe6d008b7c30 EFLAGS: 00010287
> RAX: ffff97a7c6e01000 RBX: ffff97a7c51fd810 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000ffffffff
> RBP: 0000000000000000 R08: ffff97a7c51fdaa8 R09: 0000000000000010
> R10: 0000000000000002 R11: 00000000000013c7 R12: 00000000c6e01000
> R13: 0000000000000000 R14: ffff97a7d9c653a8 R15: ffff97a7c6e01000
> FS:  00007f34b038ed00(0000) GS:ffff97a83bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002c0 CR3: 0000000102f7e005 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? kernfs_create_link+0x5d/0xa0
>  platform_probe+0x41/0x90
>  really_probe+0xdb/0x380
>  ? pm_runtime_barrier+0x50/0x90
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach+0xce/0x1c0
>  ? __pfx___driver_attach+0x10/0x10
>  bus_for_each_dev+0x73/0xc0
>  bus_add_driver+0x1ae/0x200
>  driver_register+0x89/0xe0
>  ? __pfx_init_module+0x10/0x10 [cxl_acpi]
>  do_one_initcall+0x43/0x220
>  ? kmalloc_trace+0x26/0x90
>  do_init_module+0x4a/0x1f0
>  __do_sys_init_module+0x17f/0x1b0
>  do_syscall_64+0x37/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7f34b061baaa
> Code: 48 8b 0d 59 83 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 83 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff6a198408 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> RAX: ffffffffffffffda RBX: 00005635afc7e5e0 RCX: 00007f34b061baaa
> RDX: 00007f34b07a5efd RSI: 0000000000060a29 RDI: 00005635afdd6510
> RBP: 00007f34b07a5efd R08: 000000000001f5b3 R09: 0000000000000000
> R10: 000000000000eb81 R11: 0000000000000246 R12: 00005635afdd6510
> R13: 0000000000000000 R14: 00005635afca6f40 R15: 00005635af874e50
>  </TASK>
> Modules linked in: cxl_acpi(+) cxl_pmem cxl_mem cxl_port cxl_mock_mem(ON) cxl_test(ON) cxl_mock(ON) cxl_core libnvdimm cbc encrypted_keys kvm_intel kvm 9p netfs irqbypass crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel crypto_simd cryptd cirrus drm_shmem_helper 9pnet_virtio virtio_balloon i6300esb drm_kms_helper joydev evdev button serio_raw drm configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev nvme virtio_pci_modern_dev crc32_pclmul nvme_core virtio crc32c_intel t10_pi virtio_ring crc64_rocksoft crc64
> 
> And gdb:
> 
> (gdb) l *(cxl_acpi_probe+0xeb)
> 0xa8b is in cxl_acpi_probe (tools/testing/cxl/../../../drivers/cxl/acpi.c:648).
> 643
> 644             root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> 645             if (IS_ERR(root_port))
> 646                     return PTR_ERR(root_port);
> 647
> 648             rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
> 649                                   add_host_bridge_dport);
> 650             if (rc < 0)
> 651                     return rc;
> 652
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Note: kdevops also suports now the target:
> 
>   make cxl-test-meson
> 
> But that does not *at least* crash the kernel although the tests fail too...
> This is likely a misconfiguration of some sort, but the same kernel
> works fine when I enable a Type 3 memory device (also supported on
> kdevops via CONFIG_QEMU_ENABLE_CXL_DEMO_TOPOLOGY_1). This test was run
> without that enabled, so a naked cxl system.
> 
> Even if it *was* a mis-configuration, such things should not crash the kernel.
> 
>  drivers/cxl/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ad0849af42d7..cf5d1a455efc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -633,6 +633,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> +	if (!adev)
> +		return -ENODEV;
> +

I can hear the static analysis bots sharpening their knives at the
thought that ACPI platform device drivers need to check the result of
ACPI_COMPANION(). This is clearly a cxl_test bug, not something the
cxl_acpi driver should ever worry about. If ACPI_COMPANION() is failing
for the mock platform device then there are bigger problems afoot and
this is just a band-aid until the next failure.

I'll try booting linux-next, because cxl_test is working for me just
testing the tip of cxl.git/next.
