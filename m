Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052960207D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJRBhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJRBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:37:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327582D2C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666057055; x=1697593055;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=85f5j8LqhSxxTr2yBo82h0/cMJ4tENYiBJ4cSnKUUxw=;
  b=VvlxV3hQ9U0bMR8oBWJh23IkOI+Qaoa/hM+nRLT8yOhclJsfKSIQrIq4
   he30FXZGOA4/1Uy4tZ4CfHYPXi7zQE3Ddfk7Be+oVEdjUvBqfBTpVUNC6
   f358YHWiSDnSduHvUdGV/f4uZwi+PGfCwyVaByoRfs/z18ZMmt9aqv9X3
   ZNPb4fjsae4c62k9vhf8bPKW1jnlGrKyYdylfk1EC8ScmeeaJouEiNqi/
   e3PwoUt4XKxQrmqssGUJcN6zpFzgRImcEXUPdc69S36xw5TMEywQkN4Tp
   P05MFAie8z5YJtJ5UmhvhD00YxsIK+lqdbNp7W4g9PO1/TNzJm/Ucv9Gj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="286357309"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="286357309"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="697278734"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="697278734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2022 18:37:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:37:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:37:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 18:37:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 18:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVvjQghnn8mPngWiXedeqyLaGisQzhv1ev1zjJ6L+TQxMxHUNkgZCfm9N6kWgJDs5eHZbjf99+PiR+tP7T2y/5JzfDysS1DOH3Wz/MhpUmSEOznWbbgBZAk3PrSBBscrVajtjt8c2dK/p0XH6/eUDjgnPTOupLvxLDSQU6jn6ggl1+1ahPlNVP0tB5wmoeMThDSGQ5ZMGpPQ0Y8iNtm0Sf1BBpMOBfiSu9fWNtiqhMKto9Mj+F4czbkemUhsZ79FWpMZpY3xBZyLLZQ5kRTk1Pyfs+AIKP98h4G22nG+3xrzMvbn2BCBAGDR9bxKzT2cWPH4wJF8k/FbNkkdvyeqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ111fm9idwTbcxAiF8bitlq8fFfWo3mhqJwft/gT2I=;
 b=QjLsgDmVhYDcm8od9iVBOxpe8dzh4r7qcittXncdplWq9mnYXZo6zbTuqS5NhZr+KbY6uApGU8uknEeUhujY91nkMPleWMnxoHAzfV/pL+aScgn21VbNkEVFg1G3duQltp5IQLaVa1yqPWhEYUX16t1+Iow+oznaixTbBeMFs9htAvFxTf4cBysw2B9WTafNDVxChSyFQyoZ4S8hEZY7HAh3BakPLrUwgy7H30kfP3O01BQHxsdiCNJLhGu+jL2pi4PX3fCdNn7GBKD/dNvqfCxhmufvVNYOc/o6tY0K5wnc90HD/azKGo/AYccEfzArVlbDZQgAGVQB46b/yVO5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 01:37:30 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 01:37:30 +0000
Date:   Tue, 18 Oct 2022 09:37:33 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <linux-kernel@vger.kernel.org>, <mszeredi@redhat.com>
CC:     <heng.su@intel.com>
Subject: Re: [Syzkaller] INFO: task hung in fuse_lookup with v6.0 kernel in
 guest
Message-ID: <Y04DXT9JbwpeRDex@xpf.sh.intel.com>
References: <Y00b31dX1mIfgnBP@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y00b31dX1mIfgnBP@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 338a8ddf-f784-4850-eb9e-08dab0a95279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmtTwlLwGll1Ud6sxQxJ8cxpX22RKBs6bMgf8w7zA7j4boMBJ/rS2C6mB1fGUjvSU1LtQnlksz6pawDJAEUQ9GOSudcdiCDYMD7h0mw14bYW3vC6fQ1bt7Ywo9ejdiiC7TylKHW3t0/sroRL4qGBrqtJzTSRvO2Jyw5SUXnsgH2j4utAub7JVXuglM4IGrld+uySW5NWjc+rOei8R9v/k/xUG16HpgTvQrztK8BkWL43WgovNAcx3k2R0kIdGJaZYsIP3PTCrxgwOHOGflGSmQLiog5jDrfxBxdJBdknEOEj6T7qRUb2QbngIPz8Rzb5L5dTUIS2Hj+OITaCQjG9YFgz0/DMH/hHGrpqfAjBtc6LCi3WyEIxEueJSj5H44bDmWPasxurkszQzQ37kslJ2aMsSwkP5kXIbdHQAn+XISFhHBe9M569grpj/Fs1e054iqEh3njEUnOGf8CoZoxRboogKALsaKRNqcgHISFh83K//neaukXCm9WSlSohQXtgbhhMmrG9KQiT4i15T4lCmX4A7vVo1JhL/DKNFAnlkVxXYkWxs30jpIENDV2MGWQ2Ky4/QedVSE38yZBFd/AfoqgliJCl2/T9jVdmjYcXryJl45IZ1dcvuGV7RcPXn20XGl0+DZeIKhZ0kFjnjvDL1CeZNnUeRp3e6wjigfS1cEWOqhQQswOl3O+TEW//hELQ1T+2to6PAE2zmU4Va7KRif20TNjmMZn6aRsV9ChB6l0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(4326008)(2906002)(4001150100001)(4744005)(5660300002)(8676002)(66556008)(8936002)(316002)(66476007)(66946007)(107886003)(966005)(6486002)(41300700001)(478600001)(83380400001)(44832011)(6506007)(6512007)(26005)(38100700002)(86362001)(82960400001)(186003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyrvjq7XLMQGuRFUXJTQ41hhE2AtO24ZLLyAfWNb2FtslsRbFhFsEyx80kXE?=
 =?us-ascii?Q?1R+i+oCwibDdEvIKPfWk/fX0xq5f+wmEmVJxUrrANmIjcrLoVFtuDC7Op6YO?=
 =?us-ascii?Q?JfLyFmAhnNOMPMY0QVzbQ6sKRLJVnirt7doj+315V7NQ46U1SdpVpBVQYlDF?=
 =?us-ascii?Q?WaaHdgDJ3ADft/4F5n5u/WO4+GSbipb6+QPhw/dQ4Y9hs2LVMJrYaGxmk05R?=
 =?us-ascii?Q?15Ms5Q+QGEZ2lm3x8WrJLp0j46bANwuxyt6huR+AuSagCCQAI9Pg6QQk3vm7?=
 =?us-ascii?Q?3kuYT+/cxJeFciLtVmHva6wRp8BdFI8WftsWQO09/OQ72m32z9qlc4MQheMs?=
 =?us-ascii?Q?cyYT80aVHi6tzIwPiKyKn63OjivH85fXtxj/sBJy68L9U1tl0dVL9R46wDpA?=
 =?us-ascii?Q?E9lr09rw4CpQYvzE0BKZCoPR2dR/LYuONCmgws7jTo3i2NUYNi89nCUKRx+K?=
 =?us-ascii?Q?9Nxq2JHpCMHhFEuP1s9w9yt4zs22aLelN+/YY1t8AnamZBTIxnufLHtVWlI8?=
 =?us-ascii?Q?mC8zsMyPyNKg0uSLYwXG8m6xD/wPdrQRRuAoOCPS7gFS+g8dXD9po9z5b3GS?=
 =?us-ascii?Q?er1y+mydlSOq/tXA3BSBbDgtvzq3gTimGJ3N3COpOHtX4y4jQykfhNeEtCKS?=
 =?us-ascii?Q?VW8KNlZ3Lj0na6j6OW1/JD5e9RmmzzNjrMgqMzODRYQEHSkmAWwCR1M/MH1r?=
 =?us-ascii?Q?LKHUj/7kcy3Ez++uLx00F9+v4nrcTxh5lFkOMIxG8vi2cAVAFfgzQmfbUP0K?=
 =?us-ascii?Q?NqnppcK8NegTcOqzdhnJGOGoC6hXjUE7/blm6rE0tVqydC8AWIYCdT/52N6J?=
 =?us-ascii?Q?TmtVjeI93WwK83h3v0f0dMcWpZT9gDHD8/ltckHz9HwmbBY5tk0jn6k5jYL/?=
 =?us-ascii?Q?5L3T+7lqgyIBVgGr2C2+gDDwalsDqKwjfXMOw7Iz6X6JeDyGKF36/gCMDnty?=
 =?us-ascii?Q?UOhhHokMl3MRQQfSlWims/2KfEzyavfOWo5MRbDp9icI6f+LvwNfpZP9kPdI?=
 =?us-ascii?Q?nDuDGHqAtLoH8wdtIQYj2g+H2WdAX6O+IUw7vmAm6UMtGoL+8z5AzK16ie3/?=
 =?us-ascii?Q?+ompcErtT7pVxZL9AFmNtIeEYubI3ztweQhUxSI/Iud7XWAiefOr9/Hkdl4x?=
 =?us-ascii?Q?f3fqr+uPl4Bvh2VYDIhq2/8sTY2+6xRgg9iBw2cBQGZM5t/7DKMTIJPmsfEC?=
 =?us-ascii?Q?XB6Mvxi4olwnxgYJeojP0v2hm/H6+XqrVRQnIBE/jSQdvXAGKZMoTNZfNkKy?=
 =?us-ascii?Q?FXx3Y1uPMyDpG2ATYpr001mZAbzfPswFsACtmdQ2yqHU2Yhugva7687MtNKl?=
 =?us-ascii?Q?p/1eIVwjwEzS94+CLurtvFd0gZ1LHIROf+bdWo6QJzbUd0FbF3X8tc3J2bhP?=
 =?us-ascii?Q?ZvkpHXxYeDGGXMzlSi9RGLclSRv4NHkb/Dru6xTNfcL3KbGDwN55q3xvp4/q?=
 =?us-ascii?Q?U7QRzJXlh2DIrmaK+4i3jcMFr1Cxzn/s+Kcf2vdRNTzwBypj0pQYZep0n3Uo?=
 =?us-ascii?Q?Y2+aAtoQlbAaa3x2DKl8LL2YqVKq839+Q7QzSv7wUAsfOIS+HXOpsVWDU/9k?=
 =?us-ascii?Q?U1Rxz9nE4RS7MyzXCSD3p4iExc9sQaj7nId3Wpvd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 338a8ddf-f784-4850-eb9e-08dab0a95279
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 01:37:30.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiuMkQCnr6Z0+Np6FIIScecs1b1/BkdG9aI6Q4UbxlvX5yMCrdgq3ElaHF56e2bsDn049hpaeL1rUAzJtoLe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received the email that:"BOUNCE linux-kernel@vger.kernel.org: Message too
long (>6000000 chars)".

To avoid missing the attached log, I put all the info in below link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221017_task_hung_in_fuse_lookup

It's reproduced in v6.0 mainline guest on TGL-H platform.
The dmesg that reproduces the issue with the v6.0 kernel in the guest is also
in the link above.

Thanks!
BR.


On 2022-10-17 at 17:09:51 +0800, Pengfei Xu wrote:
> Hi Miklos,
> 
> Greeting!
> 
> Platform: Tiger lake CPU platform.
> 
> We found 1 "task hung in fuse_lookup" issue by syzkaller with v6.0 mainline
> kernel in guest.
> 
> Bisected and found the bad commit:
> "
> commit:  62dd1fc8cc6b22e3e568be46ebdb817e66f5d6a5
> fuse: move fget() to fuse_get_tree()
> "
> 
> Reproduced code generated by syzkaller, binary, bisect log and all the dmesg
> info are in attached package.
> 
> Hope it's helpful.
> 
> Thanks!
> BR.

