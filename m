Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE476EECBF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjDZDb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDZDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:31:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755CE1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682479880; x=1714015880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GursOFY7UQzFRnQGJT2H8O4+I/1pwFZ4WIMxXBwwvsg=;
  b=YwIfqUoZAuFdlO6ML6pnYgKgWk/jvKHc8jkDiRrLQp2ssK/XODGPqkl5
   BZlZpu88NsvZsGfeP2QmNaE/OO6XSkZCkgSW9YDGXyG4vpqhzcScz+S5W
   iwYBeX2Spa3mbocMmYIJ62Sn/oLq4cjIPzCqYf5loBIEysB6H0P33bXw+
   V4GFqF+WS9uikcBe75tkZI99FlZp339SIVylv117TXHXh0oBCqcCzc6Dc
   +TEXclQ74sXrqrJ+YJIJy3vC2APNgcTu9AfzrUBhm43Dubqp/MTYyHiH2
   UNCpsrJ2l+KzM43hYKRLdSknKdF9Y2S+8vdyWz6LqZ5JaDYSnj/V3rxn5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="331205779"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="331205779"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 20:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="758426383"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="758426383"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2023 20:31:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 20:31:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 20:31:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 25 Apr 2023 20:31:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 25 Apr 2023 20:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7rm/OpJG0IoIrpMw3GUVfvi0lzMshqNEUZMrwTSIK3rxygNX77yuIOFAKbYjV8CcKBoUL42plVzZ9TDHRf+27wvi+zh23VaHncxCNvqpzB2FZUcQbRzBYQjyQZ7UeAabkFCiBOogT80MAAAVZeMAdLtOlIPfSY8ZyAnAbDqLfNjE3eVaEauNyNJVrzjXHOrOxS4JarPySOSePQyDeyOtGee7eHNkYRYYuMZxvJlnJ/KG26wGHfAhOxSITe5WlNzdevOb9kmMTvGhy86TwcTLvQ5RINzJd2Z+IcG9JMbhfxSAe1OtHko3fPR97kESFK14O3SOg0b1wOEM1bpDSX0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iS1qMHxm4cs9emnzDAY/2GkMP9b3lM3H0sTgID89w4=;
 b=GHLh/u9a3LC5cFfGQaARtaKUD8FVlFLCe6Lzy0/Rc4DT8RmPtyMjOqXaYxAOZHbNb34fiksGIQIldZzEhIVU8BhElUOZhVVm1i19FnERdvnyMFerQmEu179CDxcSOY6b2hQM/nDwJVWMXDMKtvHGXvcbQmZIrhY+ox7aV8+jb9UNrhMDZSQCuaZhfW4/CAujD0aR9X0vkckKxKbEI3mSHcfrzda3a3DuWzgx/4UDao0D1QXb9kj2LvcvSL+2IoNMJEodHqLm3EwpbDbMi3z9Kq3TnGi/EnxiH0lAoRy1m+g6Gp8MgCn8zpQGLY4aGA77M35jRw++fi6Z7ypQrX2ikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 03:31:14 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%7]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 03:31:14 +0000
Date:   Wed, 26 Apr 2023 11:32:54 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <l.sanfilippo@kunbus.com>, <jarkko@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <dhowells@redhat.com>, <zohar@linux.ibm.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is "refcount bug in tpm_chip_unregister"
 in upstream patch "tpm_tis: startup chip before testing for interrupts"
Message-ID: <ZEibZgi8hjfVIBTE@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: ac55df47-8947-4651-e847-08db4606afee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRDPDB+i0WsANecNjp5fRQMSWR6NuMTqGevRMvpQ/SvQSkhzMbUxD5BZCjHtllOnMbH52XC1sUVhGV7+xWFX9Tz+90nxrEBTusIpp87mOQTa7xQjoG/8KnzCVPeQxAz1VRHbQqTfW1mpXQGZ965Zs9bY6mOuseUhxkFyGbTudTLyKmBM5Z8uBCePGXOJN3YnS4c84hglwjkEPbPkQiZTDGPIRDi0tA0KnTAcsN/f1/U53umprhU2PfvPTlaVKc32SkrtIHgLc2vYqhXcZOvMe3c++Cf79tk00E0KzL7XFuN4LdLOKT4UIotaUqw/i4KKiRnN8FLFjzZ+VcIrRrLTSDtc30MPEhEf5yFzbaHaEMWi0dZa0AN/2ZCNgFfHJhZOB16IUbtxGsQ9P+00cTlash/xWw26NJThxoANNDBp8bljsz96f+u2CRSjdY1B2qUEmLZYaYl2l8Ls09LfHp6Xwkh17aS1OVOtmjOz8KQVcC8xPpFkVMlKZkpRDtFfMG5uwQS83C4NhN0G1Jlrq+630JBktImadA2shyfgQ/yo5mHmlqzRVJQLOmDGJobR494Id/qfaOoWmHjjhfoFNYeyK4CT4b4lAIAA1wTIp8TZ9wItMKlSUs166o7vC+KP4hrNO4H4JWmPHeUvIEJlRH8ayQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(45080400002)(478600001)(82960400001)(4326008)(66476007)(316002)(66946007)(66556008)(44832011)(41300700001)(2906002)(8936002)(30864003)(8676002)(5660300002)(38100700002)(966005)(6512007)(26005)(6506007)(86362001)(186003)(107886003)(6666004)(83380400001)(6486002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYb1qLzHalgwrvRYaLCULCMY0iOpZ+7iO8QgkAsGZpyygWVEVSWvl+d7PaOy?=
 =?us-ascii?Q?Sx0fxkt5v0OjnvWofkRn6HVL+PM5m7fwCc07gCqb6jeuItNddo1hmEq0jh9G?=
 =?us-ascii?Q?mwqhJqk2HlISByyCdZ8K/HJyqwk1LUsViuVjPWN+tDhOv+Sqzekgby9zbkuY?=
 =?us-ascii?Q?heZFn6MImrc/iEsI/CYhUJGPyELQ8yjCNL2YMLMH1OkBKlNbiw7wgOJJ/Hrj?=
 =?us-ascii?Q?vINB99frgq/pBMtCq4D2WytU08lcuMmxXzMKCpVzoWsx0kMRiuo9Tb7cV53+?=
 =?us-ascii?Q?JJkgHm4Xjiv2jXDTv0TXvwGJBgwuQTLX5j0JJPrPneT2gprxHv8XTuwMCl07?=
 =?us-ascii?Q?FR1cz3YCNv+9DWwRSo9Md8torhJJ1cT+ScZqWL95kZfos1q6VQEcK4j5J/L/?=
 =?us-ascii?Q?BoOFZFdCEVepkFwhrGGz2jlNAZpjcRuqPH/ujI1j5M4BxfYW4HPf3EQkXfmC?=
 =?us-ascii?Q?+NXmwDC+eCRC4PP2J0V9NZDp7PcOa7jEii+/+Kh4IZvG57YIVbtINRhtZK3O?=
 =?us-ascii?Q?WWRe5jCVivXmsmXzZ4+ZHzCzB0fKaGnziVJpUY2816ykxuliEW4bY8xE7OJG?=
 =?us-ascii?Q?nQjIJJxYRrQ5CLUOuCksbDT4PAH9t2gsthWC/lhk7VGwJbmqhbOJtzuj2Mp4?=
 =?us-ascii?Q?Yi9Oh4E0qmTXrSLP4cICv0Wn2pn4kwDNRF0wpMBhIgEWgkPW6QPFEvsNJ3iH?=
 =?us-ascii?Q?pKBwXBtWXDQUqF/0aJ1cpMMNJ9wI4BaeD2WZ+T5GtWbLFqY0gpicDWmUaqho?=
 =?us-ascii?Q?bf+SPI3zoBabDVMFvFD/q1H4l126+9ga5SVjST/RnKhurbbDHU8qZxQMgQ3I?=
 =?us-ascii?Q?T26h6yKHfn2DZ4AdBQv20mwJAyQiwkOuz1NsrNoLF35i77ztlUIY6MPpcyVe?=
 =?us-ascii?Q?QKn9lMjdnOgS3Y1MdNXU4rYkup6F7odVD7wdUKKE3acZrUFmrtivqMiyYne1?=
 =?us-ascii?Q?nc10hjV2/PMU3dc9RgWSyXeytMTHCL3dd0DbvFT6gp6FNU8Zddd9KEkEueX3?=
 =?us-ascii?Q?JllxNJ/RCKSYjQ97oaZS8G0izW0E+Zn/1dH/Cq+HRylqDt5Jxovcv9DXsuQr?=
 =?us-ascii?Q?oyqIIlEST/cHZJ0f1MMw4EKZzYVT23QYYM4+aV8iYJbdcDVjeAL+2lGwdW8w?=
 =?us-ascii?Q?sbL8TWm97/953cTA/AmbiiG7YhkEkKRlHUisIld+3fS4Xb/7xqBhX1PJIH1W?=
 =?us-ascii?Q?fsmb/715Y89zRM0sVu153cS+2QWrORWUvyKb/Uo7jVPBS9f5gLjpCyHJdCna?=
 =?us-ascii?Q?yh3UDuvuubKkO+DkUa+gmEk3GtGnM29YcAI9vgJhLppGgo0OIipuighFsqRs?=
 =?us-ascii?Q?1CAg6SyM0D5FzUUwjHD+nLdpGV4qsBc4qjqBDCRl53cf5a5qPY9GZ0cUSbXM?=
 =?us-ascii?Q?KoXXx6MewcFNibRFFosfjnqTm0qdSveLBYOEdI+2kuNJ27/T/9Qjh0WK7dVK?=
 =?us-ascii?Q?iDUutz79hlrSUhoQCF8hg+sAsIZFTl6iJmr4hh/IUha0Fheqiz+sxuqBDw0e?=
 =?us-ascii?Q?XZRp38sr+gup3tU2y4SfnaQxL81lbFXcJptHzPRceilsAbbUUVDMulaOSObv?=
 =?us-ascii?Q?DMJEmrfNHEQHTIZ8jUdwIUEbdlU1w147T6tL3Nq8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55df47-8947-4651-e847-08db4606afee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 03:31:13.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNfBfk9VYwHxi7rCotDgYoBam15qdRC2fe7nf4PMOOfj67t/rBx+wFfQqOchpnITd9IAOhdzRYVr9XRUtm6DrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko and Lino Sanfilippo,

Greeting!

Platform: Raptor lake and so on x86 platforms

There is "refcount bug in tpm_chip_unregister" in upstream patch "tpm_tis:
startup chip before testing for interrupts":
https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org/
-> https://lore.kernel.org/linux-integrity/20221124135538.31020-14-LinoSanfilippo@gmx.de/

We tested the intel internal kernel and found that
"tpm_tis: startup chip before testing for interrupts" commit caused
the below issue, after reverted this commit on top of intel internal kernel.
This issue was gone.
And I checked that this commit was same as above link one.
It could be reproduced in 150s.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230425_154720_tpm_chip_unregister
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230425_154720_tpm_chip_unregister/repro.c
Syzkaller reproduced prog syscalls: https://github.com/xupengfe/syzkaller_logs/blob/main/230425_154720_tpm_chip_unregister/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/230425_154720_tpm_chip_unregister/repro.report
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230425_154720_tpm_chip_unregister/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230425_154720_tpm_chip_unregister/bisect_info.log

"
[   24.716504] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=331 'systemd'
[   28.304015] loop0: detected capacity change from 0 to 8192
[   28.319753]  loop0: p1 p2 p3 p4
[   28.319919] loop0: partition table partially beyond EOD, truncated
[   28.320692] loop0: p3 start 520097793 is beyond EOD, truncated
[   28.320919] loop0: p4 start 524032 is beyond EOD, truncated
[   28.322438]  loop0: p1 p2 p3 p4
[   28.322577] loop0: partition table partially beyond EOD, truncated
[   28.322581] tpm tpm0: Operation Canceled
[   28.323057] loop0: p3 start 520097793 is beyond EOD, truncated
[   28.323284] loop0: p4 start 524032 is beyond EOD, truncated
[   28.345542] loop0: detected capacity change from 0 to 8192
[   28.355853]  loop0: p1 p2 p3 p4
[   28.355997] loop0: partition table partially beyond EOD, truncated
[   28.356592] loop0: p3 start 520097793 is beyond EOD, truncated
[   28.356845] loop0: p4 start 524032 is beyond EOD, truncated
[   28.357902] ------------[ cut here ]------------
[   28.358110] refcount_t: addition on 0; use-after-free.
[   28.358394] WARNING: CPU: 1 PID: 536 at lib/refcount.c:25 refcount_warn_saturate+0xe6/0x1c0
[   28.358759] Modules linked in:
[   28.358894] CPU: 1 PID: 536 Comm: repro Not tainted 6.3.0-2023-04-24-intel-next-591f7c2026cb+ #1
[   28.359257] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   28.359779] RIP: 0010:refcount_warn_saturate+0xe6/0x1c0
[   28.360012] Code: 1d 99 79 26 02 31 ff 89 de e8 86 b1 55 ff 84 db 75 97 e8 1d b0 55 ff 48 c7 c7 78 a8 9e 83 c6 05 79 79 26 02 01 e8 3a a9 39 ff <0f> 0b e9 78 ff ff ff e8 fe af 55 ff 0f b6 1d 63 79 26 02 31 ff 89
[   28.360756] RSP: 0018:ffffc90000f2fcf8 EFLAGS: 00010282
[   28.360980] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8112384b
[   28.361275] RDX: 0000000000000000 RSI: ffff88800dfba340 RDI: 0000000000000002
[   28.361571] RBP: ffffc90000f2fd08 R08: 0000000000000000 R09: 0000000000000001
[   28.361866] R10: 0000000000000001 R11: ffffffff83d638d8 R12: ffff88800dfbc6a8
[   28.362161] R13: ffff88800dfbc6a8 R14: ffff88800d4a0ae0 R15: ffff88800708f660
[   28.362456] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   28.362789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.363031] CR2: 00007efc8ff36500 CR3: 000000000b788004 CR4: 0000000000770ee0
[   28.363332] PKRU: 55555554
[   28.363461] Call Trace:
[   28.363570]  <TASK>
[   28.363668]  kthread_stop+0x349/0x360
[   28.363840]  hwrng_unregister+0x182/0x210
[   28.364026]  tpm_chip_unregister+0x1cc/0x1f0
[   28.364216]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   28.364442]  vtpm_proxy_fops_release+0x8f/0xa0
[   28.364640]  __fput+0x11f/0x450
[   28.364794]  ____fput+0x1e/0x30
[   28.364941]  task_work_run+0xb6/0x120
[   28.365110]  do_exit+0x547/0x12b0
[   28.365263]  ? __this_cpu_preempt_check+0x20/0x30
[   28.365478]  ? lockdep_hardirqs_on+0x8a/0x110
[   28.365672]  do_group_exit+0x5e/0xf0
[   28.365836]  __x64_sys_exit_group+0x25/0x30
[   28.366020]  do_syscall_64+0x3b/0x90
[   28.366187]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   28.366411] RIP: 0033:0x7efc8fe2ccf6
[   28.366565] Code: Unable to access opcode bytes at 0x7efc8fe2cccc.
[   28.366815] RSP: 002b:00007fff8ff8a448 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   28.367123] RAX: ffffffffffffffda RBX: 00007efc8ff37490 RCX: 00007efc8fe2ccf6
[   28.367417] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   28.367711] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[   28.368003] R10: 0000000000000004 R11: 0000000000000246 R12: 00007efc8ff37490
[   28.368291] R13: 0000000000000001 R14: 00007efc8ff3ae88 R15: 0000000000000000
[   28.368587]  </TASK>
[   28.368682] irq event stamp: 19811
[   28.368826] hardirqs last  enabled at (19819): [<ffffffff811f0cb1>] __up_console_sem+0x91/0xb0
[   28.369184] hardirqs last disabled at (19826): [<ffffffff811f0c96>] __up_console_sem+0x76/0xb0
[   28.369539] softirqs last  enabled at (19488): [<ffffffff82fda6a9>] __do_softirq+0x2d9/0x3c3
[   28.369889] softirqs last disabled at (19427): [<ffffffff81132b14>] irq_exit_rcu+0xc4/0x100
[   28.370235] ---[ end trace 0000000000000000 ]---
[   28.370438] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   28.370727] #PF: supervisor write access in kernel mode
[   28.370942] #PF: error_code(0x0002) - not-present page
[   28.371151] PGD ded5067 P4D ded5067 PUD df78067 PMD 0 
[   28.371370] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   28.371554] CPU: 1 PID: 536 Comm: repro Tainted: G        W           6.3.0-2023-04-24-intel-next-591f7c2026cb+ #1
[   28.371975] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   28.372424] RIP: 0010:kthread_stop+0xd9/0x360
[   28.372610] Code: 44 8b 63 2c 31 ff 41 81 e4 00 00 20 00 44 89 e6 e8 1c 08 17 00 45 85 e4 0f 84 81 02 00 00 e8 2e 06 17 00 4c 8b a3 40 0a 00 00 <f0> 41 80 0c 24 02 48 89 df e8 f9 f1 ff ff f0 80 4b 02 02 48 89 df
[   28.373338] RSP: 0018:ffffc90000f2fd18 EFLAGS: 00010246
[   28.373553] RAX: 0000000000000000 RBX: ffff88800dfbc680 RCX: ffffffff81173814
[   28.373839] RDX: 0000000000000000 RSI: ffff88800dfba340 RDI: 0000000000000002
[   28.374127] RBP: ffffc90000f2fd38 R08: 0000000000000000 R09: 0000000000000001
[   28.374414] R10: 0000000000000001 R11: ffffffff83d638d8 R12: 0000000000000000
[   28.374702] R13: ffff88800dfbc6a8 R14: ffff88800d4a0ae0 R15: ffff88800708f660
[   28.374990] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   28.375317] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.375557] CR2: 0000000000000000 CR3: 000000000b788004 CR4: 0000000000770ee0
[   28.375855] PKRU: 55555554
[   28.375973] Call Trace:
[   28.376081]  <TASK>
[   28.376176]  hwrng_unregister+0x182/0x210
[   28.376359]  tpm_chip_unregister+0x1cc/0x1f0
[   28.376546]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   28.376769]  vtpm_proxy_fops_release+0x8f/0xa0
[   28.376965]  __fput+0x11f/0x450
[   28.377112]  ____fput+0x1e/0x30
[   28.377258]  task_work_run+0xb6/0x120
[   28.377423]  do_exit+0x547/0x12b0
[   28.377571]  ? __this_cpu_preempt_check+0x20/0x30
[   28.377778]  ? lockdep_hardirqs_on+0x8a/0x110
[   28.377970]  do_group_exit+0x5e/0xf0
[   28.378129]  __x64_sys_exit_group+0x25/0x30
[   28.378311]  do_syscall_64+0x3b/0x90
[   28.378476]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   28.378697] RIP: 0033:0x7efc8fe2ccf6
[   28.378852] Code: Unable to access opcode bytes at 0x7efc8fe2cccc.
[   28.379106] RSP: 002b:00007fff8ff8a448 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   28.379419] RAX: ffffffffffffffda RBX: 00007efc8ff37490 RCX: 00007efc8fe2ccf6
[   28.379712] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   28.380022] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[   28.380315] R10: 0000000000000004 R11: 0000000000000246 R12: 00007efc8ff37490
[   28.380614] R13: 0000000000000001 R14: 00007efc8ff3ae88 R15: 0000000000000000
[   28.380911]  </TASK>
[   28.381010] Modules linked in:
[   28.381145] CR2: 0000000000000000
[   28.381290] ---[ end trace 0000000000000000 ]---
"

And syzkaller reported another issue: "task hung in tpm_chip_unregister".
This another issue could be reproduced in 2100s.
After bisected and found it's same pach caused the another issue too, and reverted
this commit, this another issue was gone also.

All detailed info for another issue:
https://github.com/xupengfe/syzkaller_logs/tree/main/230425_154720_tpm_chip_unregister/0425_214338_tpm_chip_unregister_task_hang_same_commit_issue

I hope this info is helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.

Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
