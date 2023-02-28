Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1E6A5086
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjB1BLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB1BLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:11:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826B18A91;
        Mon, 27 Feb 2023 17:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677546661; x=1709082661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jho94pcRZpREXiTPutcC9c0TrnTpeusc2XWFBUEQ5eI=;
  b=CX9GMuD7ICMCrfATYb/YSIp5uJchr5ZEpq4Mn7/neL+Bv6mUaM9UrnDy
   CATZf5NtcObVHNdRXocz4v1MuiE14zLpekR9/c4yRLTuLZQRKLyzATFS+
   7TL5ee4jyfvP98Ck6ysdnPFCqshJ4ueY2Hji8YZDzSB00rQzRQukj5UqW
   4fM/InaFTBZsowoUNsowBCXn71mpgs/HT0tRH8KuBxQlF/7PqB1hY/kyb
   +4ebZ5qOXVOSjM55Ct1OWprwPkeY8hwmaEhGCTX99kef+It5Akf3SJsfz
   wUZdG6vZXK+flxVLs6E34iv36feuQjEKbe+Uk3T9n4GH0z71f5GHyMDS1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="398792332"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="398792332"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="667267196"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="667267196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2023 17:11:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 17:10:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 17:10:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 17:10:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 17:10:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8qrU56Vtb+1GCT/jrRzuhy6c6WrW6oZtFKNiWkKbwRYhInf8gE5FwvfO8WOQ/TUGQN18b/QdGAHTbkDLFrMz2YzbUVMoTe17h1b8nHhre13bfFlsSBFJB3HXiOATyowAmtsH/sSSplRGaKokYaXsl0/LvN4D6tPNGlWlcvcfeMsyFMNEwmifE9rpHtbmEkchdUGTiNPGSGQEpGn5ObMo4rjwsJ2jBH0qraTwhKzp3nOP6DRxqDvjoXX/uuexgSvF26J1pP+jNzLRVxqiYTpDvB7ltYABCYIXNfkxwbnP4TeEkJU67NN+Mjp3OxGDUL3+4Yx3v0fez0pjf258bp93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvWJVq0xBcEjTIod/F40rdbeDPuDtcIpRdwYZGZVYQQ=;
 b=oGgk9Ygb72nl2B/8INDdLq/aH/kgmx+Bhq7R4GWbtlGaSg/m5jR4O4w3HKORGfi3hjbk+AYR3snRoV4tWxD8JsN8U9nA8Z6mZbujYDoXOj4oL99V/jPfPYWOFnlqo0mAgtGruxUw4kvZpK1U2AUs08bp6jje1pgJ9JtR/K9/Qk5J/Ou1W7JFHzVVupKHBwj8eDNsIglIV7GNXyqjOKI7GXcK1cWv9EZ6vCgG+80fZIsWEv1y23kedBQEldlYtmyzCFCTsQeGhIUp7hsRWANkwqeMVnK1LBNcH44N7j1bdRJVnDMcMnfVOK/gOpb3Gzs5UyWvPYhu1VPvB2rCP2zpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS7PR11MB6151.namprd11.prod.outlook.com (2603:10b6:8:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Tue, 28 Feb
 2023 01:10:57 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%8]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 01:10:57 +0000
Date:   Tue, 28 Feb 2023 09:12:11 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Helge Deller <deller@gmx.de>,
        linux-xfs <linux-xfs@vger.kernel.org>, <asml.silence@gmail.com>,
        <geert@linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in
 v6.2 in guest
Message-ID: <Y/1U6wX1i1CisiDl@xpf.sh.intel.com>
References: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
 <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
 <20230226223403.GU360264@dread.disaster.area>
 <Y/xbyABFGZEeKduv@xpf.sh.intel.com>
 <20230227214607.GB360264@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230227214607.GB360264@dread.disaster.area>
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS7PR11MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: b3097420-84e0-42c9-beba-08db1928a55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDt7EeXURVo4sp9miU3sdNwSNEy1s4qNeuA5hUEr9Z8TKncoZvfpKQxn+i6mvPJ4HCG5J+ftLkHzvg/ELNC0OAt+ie2wmKPKUx2phdStNo5YzjU9XyRS5IvPShZp41QuyGQqJdc1qNcTuLbE4ew9iZzRuMTrzpqINSxv/zPml6/21dTUXimzyvdROJWzOJeaeHVz3/StjX3D+J+f3U7bS5M/RA4q2K8JBz582EelWNnoH6JSi3MOBWdtOX+P+C/fKb53Ti8PEsKrn81s/ZqLxrTeNzOuAAFbFc28M5Hd5bV1UDThyKdM9dWkx+40Tly+CYU59NuvLLfi/XNXvnMzz03NAk8jLWN0YHNdEG5N96ogZPH3aUyvfhcySUW8eBoKS7CnZYmcrwCQblArTrRXhOrRflkETpBNse2lzt0zhP4KGafsjOS7F+Mykxma56DkyWOu0E7/OilEKxT69JcjJRrPmFfjwYpa7bzuk1j17ywcPr665W9LG7PJwN3apIkK7w5QqxxlXlBQS8VOdkbOEwL5SrcAgKu0ggxOOEuHanHmV4tIIbSHDFFKDU+xzQ0BppbiJ7gQssDAqZ/YU3dYaJUrprlgOx0ud0LgJlXjPLs4WejW+BF1gHJDVI5vwF2bhaLePyiG+3gSlTFRiObWVVuuEwbTSRj7DwskuXiApJIr6xty5fCIi4KfQ3xG4pobuHhnghfVXnLWt5EgKY69YmxfipO8vhpVCHgYjyV5/lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(186003)(2906002)(82960400001)(38100700002)(83380400001)(316002)(66946007)(6512007)(66476007)(8936002)(6506007)(66556008)(107886003)(6916009)(5660300002)(8676002)(41300700001)(44832011)(4326008)(45080400002)(53546011)(6666004)(26005)(478600001)(966005)(86362001)(54906003)(6486002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VvD1fcyrAcJOxjRP8g18l7aqaUkRGiXoXpR5lSH7Eq8EK+nuEcuhO40rGtl5?=
 =?us-ascii?Q?jHIS646NuL42Y9C62hcco/O6aHmQd6yiUsbTka5unRaEFuNFQzEDTt4v9Bf4?=
 =?us-ascii?Q?3p/9snueEEW6ddCHhNIDra5xSnObbyQeUOyHMcVstaNiTUFkle6Fwtx1vIKr?=
 =?us-ascii?Q?Wyo03JkbcRbSwKI7c8bfujnEZvmogj+og10UiHVE1uIkPfZ/NURrwD7mSi+i?=
 =?us-ascii?Q?GG/tuVF2v05YXhAP5UXNZ/MO4n39Ona8paUkSn3mRiQKeeQN3Zz7S4sqKaA6?=
 =?us-ascii?Q?a2iTDMKip4VMZ5FbLGUkhs7jLBiDKlxiU0O7SpMmX17oO1eRQXiqYsCUou1T?=
 =?us-ascii?Q?Ctadcd2bQK6YaGSkAYFtfIbfsbGAPxmRAeuip/Z+w456l6F48WoapMf+eNvH?=
 =?us-ascii?Q?wYGrEZdH5yhLSE7Ku+W9w8mvUWMlFyVNN6U9uswVF+9jchZkdhHx6I0c+Wsv?=
 =?us-ascii?Q?7qPv7FxI+hR0n883KGFR+A0IL3XcN+jh6NYSHOR5EgKVtj0igsAQAENcJH4h?=
 =?us-ascii?Q?6xLO03UoektTeRGjdA7uZa8BgCpKcOLD7XkWSNZecdYkfooj96kgAXiU5HDT?=
 =?us-ascii?Q?m3PTSDT2k0lijtCQcRh27olPcQO1AxA2UMkIxOxdvHhzD5kGCI5R2Vlio0ST?=
 =?us-ascii?Q?1EeOQPanPHAaAvffIkQjQ//KBKpxypUm95Qycvj4yXzQvaNWQBBeGEScsuER?=
 =?us-ascii?Q?lEGftG8RNw2esJdXBkD3V3F6cbwN6H86CUowP/S/FZnozKBdc54mXAO47lNG?=
 =?us-ascii?Q?F6dg7GSSWhxv70q6bdsQzr4fkuB/Yr8T834ANBAD6IjnAcIkeY9RrPtr/THR?=
 =?us-ascii?Q?8Y43rfmkcU70ugN6MdatV6oQ2YCEzMu5pfLvaOZfSSoB4IyO+AnfxolDetyG?=
 =?us-ascii?Q?4lM7rMf9XNIJdaxAJqS55WTX1+NmMU7Q7Ja2Cwb8yR+YtjJ6Lny6FWF8Kt5N?=
 =?us-ascii?Q?p83b2E5zflZiQV0WgPZDlqsGdEEbAHmHXqEiCLc6LNUBXYpakm4WYBQOkr0j?=
 =?us-ascii?Q?dR+Irl7CjZ0AEYY0eunffDYdiodmCty1xFQMGYN6zL5/mmdVpYoPv01TbVIA?=
 =?us-ascii?Q?hzmoYwhrkJtdiXn8fpLpDZ2i+G59Fbtkhh7tH6TUgSU5mVzgk/dshmJGPrqu?=
 =?us-ascii?Q?5hscU9woLbYD9hPtfnY+jwJ/xTR8EIuqFyE8fqy6KceOD/tZOgwWdrqrkfjw?=
 =?us-ascii?Q?N0n855hKHUKrwZ0+kWFLsHJCJkR1zXwGlEK3eXT11yFLgcpudU7aSrLbNrEt?=
 =?us-ascii?Q?pkuB7zrwdMDWF0M8iQuVIZofsiNs5HwELW1kJzZSaPN7zMB5zl6hInFDEBlg?=
 =?us-ascii?Q?Mtc+4NVnAbkh/IfbkTBzYZznj6nfkD6Ahfx1LZX/CRNR3zKI6Fm8V71LK8fk?=
 =?us-ascii?Q?l6JCZjGq886ssOTmIbRskdrF048GYfcPxtkgm5n2HUca2lOQzdG/RIxvxcEK?=
 =?us-ascii?Q?AXtm5hc3hSOqeOgbcyortht1fjyUmKKYZOq++RWXBN247Mo50oRDY0qPWJCY?=
 =?us-ascii?Q?/m2V/1rbL26lvU+D1q1BCiIZd31SkIcF9XQTlFoS5m72BceM3TqVav5vC6f2?=
 =?us-ascii?Q?eqQrDIM1LYjbYpOCDa50jZb6UdQwv4116EIlXdlONKrth7aDL3jIXmAWhl5W?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3097420-84e0-42c9-beba-08db1928a55d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:10:57.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAdaPMIjVKXZdDPRjC5lYZul/hZqc5fbzoZvYh2PpTcWoWmzNsZrC11162R+7K6NK9Q/bf6jmXIgpZ/CXRavfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2023-02-28 at 08:46:07 +1100, Dave Chinner wrote:
> On Mon, Feb 27, 2023 at 03:29:12PM +0800, Pengfei Xu wrote:
> > Hi Dave and Helge Deller,
> > 
> > Thanks Helge Deller to add the xfs mailing list!
> > 
> > On 2023-02-27 at 09:34:03 +1100, Dave Chinner wrote:
> > > On Sat, Feb 25, 2023 at 08:58:25PM +0100, Helge Deller wrote:
> > > > Looping in xfs mailing list as this seems to be a XFS problem...
> > > > On 2/24/23 05:39, Pengfei Xu wrote:
> > > > > [   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
> > > > > [   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
> > > > > [   71.227591] BUG: kernel NULL pointer dereference, address: 00000000000002a8
> > > > > [   71.227873] #PF: supervisor read access in kernel mode
> > > > > [   71.228077] #PF: error_code(0x0000) - not-present page
> > > > > [   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0
> > > > > [   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > > [   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
> > > > > [   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > > > [   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
> > > > > [   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> > > > > [   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00 <f7> b1 a8 02 2
> > > > > [   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
> > > > > [   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 0000000000000000
> > > > > [   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880093c9ad8
> > > > > [   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 0000000000000000
> > > > > [   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 0000000000000009
> > > > > [   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 0000000000000004
> > > > > [   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > > > > [   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 0000000000770ef0
> > > > > [   71.232949] PKRU: 55555554
> > > > > [   71.233061] Call Trace:
> > > > > [   71.233162]  <TASK>
> > > > > [   71.233254]  xfs_qm_dqread+0x46/0x440
> > > > > [   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
> > > > > [   71.233596]  xfs_qm_dqget_inode+0x154/0x500
> > > > > [   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
> > > > > [   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
> > > > > [   71.234149]  xfs_qm_dqattach+0x52/0x80
> > > > > [   71.234307]  xfs_inactive+0x186/0x340
> > > > > [   71.234461]  xfs_inodegc_worker+0xd3/0x430
> > > > > [   71.234630]  process_one_work+0x3b1/0x960
> > > > > [   71.234802]  worker_thread+0x52/0x660
> > > > > [   71.234957]  ? __pfx_worker_thread+0x10/0x10
> > > > > [   71.235136]  kthread+0x161/0x1a0
> > > > > [   71.235279]  ? __pfx_kthread+0x10/0x10
> > > > > [   71.235442]  ret_from_fork+0x29/0x50
> > > > > [   71.235602]  </TASK>
> > > > > [   71.235696] Modules linked in:
> > > > > [   71.235826] CR2: 00000000000002a8
> > > > > [   71.235964] ---[ end trace 0000000000000000 ]---
> > > 
> > > Looks like a quota disable race with background inode inactivation
> > > reading in dquots.
> > > 
> > > Can you test the patch below?
> > > 
> > Thanks for your fixed patch in short time!
> > I installed below patch on top of v6.2 kernel.
> > And there was no any BUG dmesg anyway, so the fixed patch worked.
> > 
> > And left some "Internal error xfs_iunlink_remove_inode" related Call Trace.
> > I'm new to xfs, could you help to check if it is some other issue or we
> > could ignore it.
> 
> I'm guessing this the filesystem detecting a corruption and shutting
> down. That's normal behaviour when tools like syzkaller through
> random crap at the filesystem and expect it to like it.
> 
> > I put the dmesg in bugzilla attachment as follow:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217078 ->
> > https://bugzilla.kernel.org/attachment.cgi?id=303793
> 
> I am not authorised to access bug 217078, so I can't read any of
> this. Just cut out and attach the relevant dmesg output to the email.
> 
Thanks for your check! Yes, there was "XFS (loop6): Corruption detected.
Unmount and run xfs_repair" found at the end of Call Trace info.

Sorry for unaccess link, I put the related dmesg output as follow:
And I put the whole dmesg in github:
https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230222_152458_xfs_dquot_alloc_bug/xfs_fixed_BUG_issue_in_v6.2.log

[  198.601079] XFS (loop2): Ending clean mount
[  198.601338] XFS (loop6): Quotacheck needed: Please wait.
[  198.602067] XFS (loop2): Quotacheck needed: Please wait.
[  198.607537] 00000000: 58 41 47 49 00 00 00 01 00 00 00 00 00 00 80 00  XAGI............
[  198.607902] 00000010: 00 00 00 40 00 00 00 06 00 00 00 01 00 00 00 37  ...@...........7
[  198.608223] 00000020: 00 00 00 20 ff ff ff ff ff ff ff ff ff ff ff ff  ... ............
[  198.608553] 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.608875] 00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.609195] 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.609514] 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.609833] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.610153] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.610473] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.610793] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.611123] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.611443] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.611763] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.612082] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.612402] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.612733] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.613052] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
[  198.613371] 00000120: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
[  198.613690] 00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  198.614009] 00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[  198.614328] 00000150: 00 00 00 00 00 00 00 00                          ........
[  198.614621] XFS (loop6): Internal error xfs_iunlink_remove_inode at line 2013 of file fs/xfs/xfs_inode.c.  Caller xfs_ifree+0xed/0x9e0
[  198.615112] CPU: 0 PID: 291 Comm: kworker/0:6 Not tainted 6.2.0-kvmxfs+ #19
[  198.615394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  198.615844] Workqueue: xfs-inodegc/loop6 xfs_inodegc_worker
[  198.616074] Call Trace:
[  198.616179]  <TASK>
[  198.616274]  dump_stack_lvl+0xa7/0xdb
[  198.616441]  dump_stack+0x19/0x1f
[  198.616587]  xfs_corruption_error+0xd7/0xe0
[  198.616771]  ? xfs_ifree+0xed/0x9e0
[  198.616925]  xfs_iunlink_remove+0x32e/0x590
[  198.617108]  ? xfs_ifree+0xed/0x9e0
[  198.617265]  xfs_ifree+0xed/0x9e0
[  198.617410]  ? write_comp_data+0x2f/0x90
[  198.617580]  ? xfs_trans_ijoin+0x47/0x70
[  198.617750]  ? __sanitizer_cov_trace_pc+0x25/0x60
[  198.617950]  ? xfs_trans_add_item+0x79/0x1c0
[  198.618139]  xfs_inactive_ifree+0xf8/0x2a0
[  198.618316]  xfs_inactive+0x226/0x340
[  198.618475]  xfs_inodegc_worker+0xd3/0x430
[  198.618651]  process_one_work+0x3b1/0x960
[  198.618832]  worker_thread+0x52/0x660
[  198.618993]  ? __pfx_worker_thread+0x10/0x10
[  198.619179]  kthread+0x161/0x1a0
[  198.619326]  ? __pfx_kthread+0x10/0x10
[  198.619495]  ret_from_fork+0x29/0x50
[  198.619666]  </TASK>
[  198.619768] XFS (loop6): Corruption detected. Unmount and run xfs_repair
[  198.620038] XFS (loop6): xfs_inactive_ifree: xfs_ifree returned error -117
[  198.657300] kworker/0:6: attempt to access beyond end of device
[  198.657300] loop6: rw=432129, sector=65535, nr_sectors = 16 limit=65536
[  198.657940] XFS (loop6): log I/O error -5
[  198.658295] loop4: detected capacity change from 0 to 65536
[  198.658706] XFS: ikeep mount option is deprecated.
[  198.659850] XFS (loop6): Metadata I/O Error (0x1) detected at xfs_inactive_ifree+0x232/0x2a0 (fs/xfs/xfs_inode.c:1612).  Shutting down filesystem.
[  198.660387] XFS (loop6): Please unmount the filesystem and rectify the problem(s)
[  198.660739] XFS (loop6): Quotacheck: Unsuccessful (Error -5): Disabling quotas.


Thanks!
BR.
-Pengfei.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
