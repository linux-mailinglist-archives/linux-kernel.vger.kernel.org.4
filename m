Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F556E0D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjDMLvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDMLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:51:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F972717
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681386704; x=1712922704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ULy20BY1rG+Hhq0X8foJ1bGjv7HP8b9NbOtUOpboVFs=;
  b=A/WVAgN4V7b6z03MvV/bNnCYv/Njaz7DMG+jUTIWG4C2w3HBsWAO0vHa
   tY+R8a0vLysO7aEDj8hckQAPadTMMJPVbJt33jSaQwzD2kqvQH6FR5aVL
   //PvItiDu07iZXtfIoI8u+j6f6cS+JYC7LggPk2A2hWpty8cdN20lba3I
   Q2CdTfb6c9AwrvNGcGOKdQQjlVJnqe4qHdAoMA82aM8xnhddWqNKwcn7r
   5UGJNFQDXSTm0CfZRYCaT75/ecox+LwL4tLAVISDYan2K8i7yLK7mAzZV
   hxZtvHyPw3WfkZuD6x079xvFFtf6VPgQI37STV5cB7hmxQknTZvUH/ZKX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332870199"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="332870199"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 04:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800789501"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="800789501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2023 04:51:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 04:51:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 04:51:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 04:51:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 04:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWwiNMiiey5vDpcBVmEzZpszc1iE09aWk76Nh9mk3r4BycJ720FVXpr7YLOFSGmcW36hXKQRp4XNUoucue3qDBKiuFMIQLmjI8IpwwN3nei+i7LudLDmUm0ay1rF9NSG8ZMhVPMl0xaOcVihpNnNF/nO4HvuZfom8EeZsGB+eXcbpNBgn0/WeOfQglo4wQpv70YnxljbX5sj6HNxpoAaSECaCAYPQeQ9uuUdpFoH+ZAZG7KZQTt0Z4VaDTWHCEwHJ5IVztulqzZjGyQtjiITmjF/jhFvkiV6Tj8T1XlcZmTj+oLCGRILP/Jh3zEBlCMId0noi6m1Zv1cEqsDbTjMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwWjUpp0DfrWcGHHXoW1wV5w06zvCS7rPaNtp6/P1xQ=;
 b=ocz7pwlKZy9Za9owdv9nBUdPXjBFTTEQWKZRXTaqjN+EH0yFil/jkgW4FliZMBFVBcaYiVO6fK9xSpNt9VTsSmA55+cGRyEN/yKtyubGYrgil17WqWWkFZzkHt0KkMnHjvahssj0JeUnQx9CQdjpYodTyrC69+Y1rE4z2LuHz7R8AwJFIHzfGlTJqLepGbx9zBvK3pmuvCsEH2uD54ZQYmz1aaY+hdqxXiyn76D+4To6m9c6laXOwqzk/w8vtvcTca1kXBzam7g4ye7ae0ptY+cU8mJ3s58NVHpogCw/GxjjqaUFP2xC8LzllYec6BqN9gT13BFe7eVbTEOTeNeDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB7432.namprd11.prod.outlook.com (2603:10b6:510:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 11:51:28 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 11:51:28 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>, Jens Axboe <axboe@kernel.dk>
CC:     "lihuafei1@huawei.com" <lihuafei1@huawei.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Su, Heng" <heng.su@intel.com>
Subject: RE: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Thread-Topic: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Thread-Index: AQHZVziOTn8pP4Zt5kGJFo0XB8eC968otZqAgACPfACAAAd0sA==
Date:   Thu, 13 Apr 2023 11:51:28 +0000
Message-ID: <PH0PR11MB588010215E1ACBDD1F9EF6B3DA989@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <ZDdsz+5/QehZ25hg@xpf.sh.intel.com> <ZDflLOCujdBNXl3D@lothringen>
In-Reply-To: <ZDflLOCujdBNXl3D@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB7432:EE_
x-ms-office365-filtering-correlation-id: cd64b786-109b-4e73-eb6d-08db3c156a76
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1s2O3kl1fHdZurhrUVy1lnSbBZlUhAb9ssmC8cfCDTQkWaQbJSbyKhrnGQWWbJNVA21by9+2Dke36+qZTvIfuBBSUaWXiUn8JK4wRGRtAUkX9zC46u8YbuilBd3kL39V4jzA/50yNVxLs1JK3WYw4RKc6phvY/DmgsOHizYwKY3f4/35bgewLbjBxO+OKyEje7y9sZp3l+nsnLqeiixeGzQEM57ZycA9LMWvoYsYiv0DZ68XswjR0LSAmnHpmZSveTTxAww0UjKNQYwdbogbiMaNWrjEwbFhT7fHbK08xaYG9tfyTw7KTEDEOg6pvMX0MC8rJG4CBgeSJdA2bqk96HCK3htOPz29dqcTe/CG7JcGDRpmJ/8wmTije1DSFTNmxF7022CuCMK694duZ0VjkpTvawGOmwBKMyGoJHC7XUbiVqbFTyZTSveKFAIrpFAvHimibbD/a24C31DqeH4mxrWTigoSX+SvdtqEokWq4lOWIdqmWLi3YMN+bcNPtvfdRBD2kzgTk5D0FpwuCaRhhST3d5f7MKT2wD3VtHcdHuYajmgJxAMVodaBrqEDQSXQ/t/MDpZmwwr0GLT+Gc7J0X6MW4M5oL+mkiTfFVbWiKQ7bpQ9lrGWyhMYXiXQ/nTuX57CImh2E6ngtn7Ferckg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(8676002)(76116006)(8936002)(5660300002)(52536014)(478600001)(41300700001)(33656002)(316002)(66946007)(64756008)(66476007)(83380400001)(66446008)(55016003)(82960400001)(66556008)(54906003)(110136005)(4326008)(71200400001)(7696005)(38070700005)(186003)(86362001)(966005)(38100700002)(6506007)(26005)(9686003)(122000001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0hCkTTJLX6ttEFn4w8vIdysvGyvtZgq/PMs3iTrvx0MTL9TBU/vdWvDBkmh?=
 =?us-ascii?Q?uv4NUciYTNE2rfnU+HCUKQBut7TyBIlm8NOoombyNULfRzeJs45dA655lJwp?=
 =?us-ascii?Q?bjtu+0P23ZiTBsGq46gGL1+cLn6ZWz3DihNyhNqrVVioP0u+zSpLYoziSe/I?=
 =?us-ascii?Q?POEK+UVmLx8XUuzCr1cN5i2zAtHDmwkRnFM7gABv9OmPs5lIxanc2k+jy2jx?=
 =?us-ascii?Q?JYBLj0zIObQqp6b45b8zQj4xAEPntKtx7mScFIAi/hLydFLf5JNMqm6Xq8c8?=
 =?us-ascii?Q?YhGEIK8aD7OvmKYlLyrkr389Vvx0FuvntqQl28dZZJ75MabGwr+3Z5pwU4n2?=
 =?us-ascii?Q?v+HSUxL2sNScPLpxAFiZiiPyfc4CfNl5/LXIdIK5eC87S1SKl8cL8wRzpWzb?=
 =?us-ascii?Q?24QUiQFktG1OhgnADT9bT4gNjwhocdGgQHjFAV6T3EbQXixgzqIKokCnwyr+?=
 =?us-ascii?Q?/IW4gu0/0AepLJkyytDELZ20QyeRlsRkr8/WB5+XSn7D6gO5VPOduldydTp1?=
 =?us-ascii?Q?SoTynF/nqF91d/ivrz7g89jDByPyyNAi/wXML7TJOqoKkJ0kUSVQ6XWsC66G?=
 =?us-ascii?Q?v/3ELdRIoTDjodq3QEr+80+yaLlC0r5Gf07tV/eY2gr19g9ggYJawxPPxaQm?=
 =?us-ascii?Q?o1Oj5ZfjlPNlyFpmSfhbWcEdK64BKrPtJElVXmwRrL6/l5TDNWMP3KkJxy7K?=
 =?us-ascii?Q?UI0eY2M1NSriNzLaQv5JwNIVEwnGTnIbSyF7pFT+S/8O5Kz2W1xK4UsURwQ0?=
 =?us-ascii?Q?qWbc0vXSMHFas2/x/I9zUCQ9qY9O+aXDHxhGal36D+iDU3hJuiNRMP+Gr46w?=
 =?us-ascii?Q?gNLo4CEV6DkvyY2ze5Q5ajnvfnmZFHM0M0Psqk8Yk7rEChFfty1kTv5avSnm?=
 =?us-ascii?Q?Ed0pLCNCs9HzzEWOm3RUHjWOS1pV20u4oDVf7jHs1WKHu4n7NbcNrJRtZuwW?=
 =?us-ascii?Q?zMm0qjfLWc1WoBS2JsktUO3MOhV26wpBcCFoCxhvKfjsLxrRuQkQpt7DkYXd?=
 =?us-ascii?Q?9OQFSx35iCLpmp9NqjmvN89NLHiVMeI6Zl535BeEf9gdiauhtIGqYjDERlPY?=
 =?us-ascii?Q?XfkeFJFgeLMCIn6v8i18UarDTAiuO0UjAxk9CLC0idkERggdC1t2399Bg7oG?=
 =?us-ascii?Q?pmIHzgZR3JOkXup8iBuu9ZTVqOHscqZzD3mUAr/uzcEICRqZv04qUuLXAPMo?=
 =?us-ascii?Q?IF80GsSkXq69qv0h7wnUMFVmDkRecTj/q+mbb8KlRDt8v7HxWqnzKoh8RtEr?=
 =?us-ascii?Q?OA+kCsiTeTPoOrn5cL7gF3YRhdWgqbs9HUOhzGRdWh0vgZjQ0/6WwGK/gaRs?=
 =?us-ascii?Q?L9AIPdvPZSy8/eMTfU6lRQB328jbwe/IVd4CsLwwsjjIkcvk1DI0xMEPxTWZ?=
 =?us-ascii?Q?4VO7WLswPmC/SqFP8jmtpB2SjfpMtpyZ1fdJWKqqbxmMZPetc4gi6kaju9z7?=
 =?us-ascii?Q?vmmH1b0itsgy+FXS1FsDWXpverM4WHQptkrFCE10ihOacALhgEpDPG4mcC8N?=
 =?us-ascii?Q?ut3lRTNJ+ITmEgATypElNCdaF0J7sMgUuNAv/klb7pXN5O+i3qb2WzHbuWBg?=
 =?us-ascii?Q?WPo6Mp1cKtRP3K1jeT0iWAWX20LmAQDrwxQVNDIz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd64b786-109b-4e73-eb6d-08db3c156a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 11:51:28.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4/yqeWQkrvxD3zttbKaRliROQM5v0xlAcOO18PxDTxWaPI+y5SAL0rdilXXjFZWPfhr+12d+KEnIxWqI/SoxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Huafei and kernel experts,
>=20
> It's a soft remind.
> This issue could be reproduced in v6.3-rc6 kernel.
> It could be reproduced on Alder lake, Raptor lake and so on x86 platforms=
.
> After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
> dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.
>=20
> New syzkaller reproduced code, repro.report, bisect_info.log and detailed=
 logs
> are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchr=
onize_rcu
>
>I just tested against v6.3-rc6 and again all I get is this io_ring related
>issue:
>

I also did not reproduce this synchronize_rcu_tasks() hung problem, but fro=
m this link:
https://github.com/xupengfe/syzkaller_logs/blob/main/230412_031722_synchron=
ize_rcu/02bf43c7b7f7a19aa59a75f5244f0a3408bace1a_dmesg.log

I find rcu-task stall

INFO: rcu_tasks detected stalls on tasks:
[ 1243.720952] 000000008aaceb95: .. nvcsw: 1/1 holdout: 1 idle_cpu: -1/0
[ 1243.721915] task:repro           state:R  running task     stack:0     p=
id:592   ppid:585    flags:0x00004004
[ 1243.723486] Call Trace:
[ 1243.723996]  <TASK>
[ 1243.725204]  __schedule+0x385/0xb00
[ 1243.726212]  ? __cond_resched+0x25/0x30
[ 1243.727108]  preempt_schedule_common+0x11/0x90
[ 1243.727964]  __cond_resched+0x25/0x30
[ 1243.729076]  mousedev_write+0xd2/0x3d0
[ 1243.730168]  vfs_write+0x1b6/0x780
[ 1243.730873]  ? mousedev_fasync+0x40/0x40
[ 1243.731864]  ? vfs_write+0x9/0x780
[ 1243.732874]  ? write_comp_data+0x2f/0x90
[ 1243.733926]  ksys_write+0x153/0x170
[ 1243.734929]  __x64_sys_write+0x27/0x30
[ 1243.735718]  do_syscall_64+0x3b/0x90
[ 1243.736760]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1243.737586] RIP: 0033:0x7f374119759d

Thanks
Zqiang


>
>[  448.290752] INFO: task kworker/u4:0:9 blocked for more than 294 seconds=
.
>[  448.293868]       Not tainted 6.3.0-rc6-kvm #1
>[  448.296019] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
>[  448.299592] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2  =
    flags:0x00004000
>[  448.303397] Workqueue: events_unbound io_ring_exit_work
>[  448.305884] Call Trace:
>[  448.307147]  <TASK>
>[  448.308166]  __schedule+0x422/0xc90
>[  448.309824]  ? wait_for_completion+0x77/0x170
>[  448.311870]  schedule+0x63/0xd0
>[  448.313346]  schedule_timeout+0x2fe/0x4c0
>[  448.315255]  ? __this_cpu_preempt_check+0x1c/0x30
>[  448.317360]  ? _raw_spin_unlock_irq+0x27/0x60
>[  448.319400]  ? lockdep_hardirqs_on+0x88/0x120
>[  448.321395]  ? wait_for_completion+0x77/0x170
>[  448.323462]  wait_for_completion+0x9e/0x170
>[  448.325356]  io_ring_exit_work+0x2b0/0x810
>[  448.327300]  ? __pfx_io_tctx_exit_cb+0x10/0x10
>[  448.329345]  ? _raw_spin_unlock_irq+0x27/0x60
>[  448.331397]  process_one_work+0x34e/0x720
>[  448.333212]  ? __pfx_io_ring_exit_work+0x10/0x10
>[  448.335377]  ? process_one_work+0x34e/0x720
>[  448.337295]  worker_thread+0x4e/0x530
>[  448.339079]  ? __pfx_worker_thread+0x10/0x10
>[  448.341008]  kthread+0x128/0x160
>[  448.342513]  ? __pfx_kthread+0x10/0x10
>[  448.344305]  ret_from_fork+0x2c/0x50
>[  448.346016]  </TASK>
>[  448.347176]=20
>[  448.347176] Showing all locks held in the system:
>[  448.349887] 2 locks held by kworker/u4:0/9:
>[  448.351829]  #0: ffff88807eb6dd38 ((wq_completion)events_unbound){+.+.}=
-{0:0}, at: process_one_work+0x2b4/0x720
>[  448.356362]  #1: ffffc9000005fe68 ((work_completion)(&ctx->exit_work)){=
+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
>[  448.361052] 1 lock held by rcu_tasks_kthre/11:
>[  448.363142]  #0: ffffffff83963450 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3=
}, at: rcu_tasks_one_gp+0x31/0x440
>[  448.367396] 1 lock held by rcu_tasks_rude_/12:
>[  448.369387]  #0: ffffffff839631d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}=
-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
>[  448.373808] 1 lock held by rcu_tasks_trace/13:
>[  448.375852]  #0: ffffffff83962f10 (rcu_tasks_trace.tasks_gp_mutex){+.+.=
}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
>[  448.380434] 1 lock held by khungtaskd/30:
>[  448.382219]  #0: ffffffff83963e60 (rcu_read_lock){....}-{1:2}, at: debu=
g_show_all_locks+0x17/0x1d0
>[  448.386291]=20
>[  448.387159] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>[  448.387159]=20
