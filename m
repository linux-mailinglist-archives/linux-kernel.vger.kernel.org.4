Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DF718FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFABDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFABDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:03:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58D124;
        Wed, 31 May 2023 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685581428; x=1717117428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FcpEhhHKf3wMwSQp7s1CHb/lh7gNq+Jw/cYiVpJ82ns=;
  b=jSffbDBICCl2Hv4Pg0tY9Y85ulSgWGsArIC3VocgnvF6WSyDhlE3SSpI
   eCQhx6UwMvOGxUoWyznvdxhfnWtJoSHEwYediUvUIYKhCQjECx9KZpfLR
   JaqK+rTYwMu71k2HqEciZCp6U0RvM7P6mmvd0JZHENz1p6eeFCuXuET9S
   aRJq8cD6JtFg13ws61Y4xWNkzGEdnw2hheEGI05DTHrpGf506gCSbRX8f
   Zj0jwsL3lo4YtJ0+YPFpauk9T9XGQyfnIaSPda2WD/tFrAQmh55hmu6u1
   bJ0gMuHMvpRwbkkiGDPZYVDrDyVny/SgMv7uPdtl5Oa221pj0e01jNOx8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335762250"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="335762250"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 18:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037265142"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="1037265142"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 18:02:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 18:02:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 18:02:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 18:02:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 18:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDA+8ZubCFEPACSxlZZWRnvynC6g6HYJ9rwgBi9cMzerIUGKZgH+MACFu9Vom7nmKUVfxrVE6SlJY7Ef+oXuPD7obPB78WSeHxHMcjgHWd0+PKKmUCDJNFPaj8mcp2FvwTYebdvbW1/s227k9k5VT9f29nwbKomaQsE0WII2rYWO3fZ7Kz7+Leu0547Kg7mzRoGoFQiswFiydwtWf9K6qOpNgnIu9z2rCfanpGKvJt89QvIZJZ9p1IQ+P5ZZn6x8GyoE12u1QxS9Z0E4n+1z4H7PRmSdIo4EyPHCZHwUV2o2kYRnasJvUyFLCsKNyFUwTvbUCcPqMcJLm5HFkwYD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcpEhhHKf3wMwSQp7s1CHb/lh7gNq+Jw/cYiVpJ82ns=;
 b=Kp/doZ5IN7F1T+1mVr83cstXKQIzANMmBjkWvakaVlfsGV7YEGMckI8MxCqYRvHIfEIjEjsZ3Plz5XzMiJrMMub5Sr8hvjIDSc927dCZfnwaoc90yW6vgOQKWps7gc63y7TNY2Hg1GVl7743/liFL34R5D8VS7itkwwGWLMg1OMHyd30W0yVZ1pvVbwicW9AwjWExCn/KnQWWb/HxsG5hrRmPNh1y5oUPLaQkCVu6F2E2nDcSF5ZqB6/GyPuSwNZEr0lBZEP0iE5fAMCtz3SGjHuisOfyMIrdokJTrWQ7WY9x0H5NuN4B9ZF0AXS4ZbbVqtm/e4jPHOxrII3Rl9s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8)
 by IA1PR11MB6467.namprd11.prod.outlook.com (2603:10b6:208:3a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Thu, 1 Jun
 2023 01:02:40 +0000
Received: from SN7PR11MB6850.namprd11.prod.outlook.com
 ([fe80::8dbf:b38f:fad2:69e0]) by SN7PR11MB6850.namprd11.prod.outlook.com
 ([fe80::8dbf:b38f:fad2:69e0%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 01:02:39 +0000
From:   "Zhu, Bing" <bing.zhu@intel.com>
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>
CC:     "code@tyhicks.com" <code@tyhicks.com>,
        "Matti.Moell@opensynergy.com" <Matti.Moell@opensynergy.com>,
        "arnd@linaro.org" <arnd@linaro.org>,
        "hmo@opensynergy.com" <hmo@opensynergy.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "maxim.uvarov@linaro.org" <maxim.uvarov@linaro.org>,
        "ruchika.gupta@linaro.org" <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Huang, Yang" <yang.huang@intel.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: RE: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Thread-Topic: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Thread-Index: AQHZk/OXR3LF1Hi7pkCJXle1/5bkgq91H0hw
Date:   Thu, 1 Jun 2023 01:02:39 +0000
Message-ID: <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20230531191007.13460-1-shyamsaini@linux.microsoft.com>
In-Reply-To: <20230531191007.13460-1-shyamsaini@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6850:EE_|IA1PR11MB6467:EE_
x-ms-office365-filtering-correlation-id: a2f83758-78e0-4f6d-6e7b-08db623be554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMvce1IfUvGVz2qO9Li5LWGEbaTW9gJNb0YFNqTR3Ang2x6H8vfXyRp/adm/gwya7ayca9Tf2VoWcDv+UpZydhe9k04qBxcays87Ai9mz8GeqNWmEX8PIu2bDKBfCCRhAMdLw4qzXvs8fT2HLp7P3tbs4WCXEryMD7lSAbbnAOUmTmwqxL91TxS+O/ceXzTcVGAdCTUgwh0OhUhQMCvOsV5w21ZKwLzPBjNudf4aSKslnvp78Z5LCcwNDOc10YuYclnSOxkF2AvGi2H/D2XRJrrcNu05Hne1i4mpWKEaGlEc8mDPVZ52M3rKFxjC+3Tw9uiygsv0+C4y9YJMsJkz6DGdaO9WiDnqusD0NWaXdiVsDcL7ZnAF25hseZWDnFxnU7QHn1ek1cOtuqEqKzC+cT3yjf3gLLuaUi1WXMApUuhgyLsxh4WS1Rl1iC1q4NbR/Ul6sx7hIyVCmKw58P11BCeYriWSX8ZCd2VclCFC2vuCk08lcOPA7M5l+CcaKhaG1eFqpIDUrqXCXkExK6YscbNEYjQ2AeFe5gO83wdOfkRFcLyrQYyrvLDnu9jnwY2eqfXNi+tumo7NiyBMXAzRFEjDaWFnh14F/qwF40Q2UkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6850.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(26005)(186003)(33656002)(7696005)(53546011)(9686003)(6506007)(316002)(2906002)(71200400001)(55016003)(52536014)(5660300002)(8676002)(41300700001)(7416002)(8936002)(966005)(86362001)(82960400001)(122000001)(38100700002)(110136005)(54906003)(4326008)(64756008)(38070700005)(66446008)(478600001)(83380400001)(66946007)(66556008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?JBzANlImPn5ijNfiQATZ5S7CjBFjFNveNY15arzcv4ktxRcRUWM0Q/Vr?=
 =?Windows-1252?Q?CO7Z/zC1bpIBK+6+hHOvyCDnVXbAIHybl4dMe9SGgxnDLytmIGTyX9oB?=
 =?Windows-1252?Q?3lxPzf/XzXqSfOZNNLczldsIfWNWHHPH1YC2abGHqrBAw2V0LebTfZLJ?=
 =?Windows-1252?Q?c17+j+GsbLteI/rai9CFRwQU84/ahOBnuOrF2FPtw4mkJtYMHS5XfDX3?=
 =?Windows-1252?Q?JwaF0YnG3AfPT2Xx2omLDCUKwJrVjiOP1XdA4jyFNoDEAZ6a7Pb8GLdK?=
 =?Windows-1252?Q?zpm3CCzmV0qswHlK76F6Lbeqzk0epGJKanND0jKUEyZyZ5llHkEK7pUH?=
 =?Windows-1252?Q?uKmmQxMtS25oVO0VwIpEp/TNP/xZb3SeXK2bXZmoKGSiGPse4jfRy+l6?=
 =?Windows-1252?Q?7ZZ8S0gW/FXx5HuQMp8vOjdHBsCqPZDt6gqetX/CPEtSSoJfKN7Buuzj?=
 =?Windows-1252?Q?K262Z4FSXRZwpqeUfT5SE9dJGf8VZ952UnRaS5GBCWg/3kpJBsKztbN8?=
 =?Windows-1252?Q?7UjokExf5Dy0heKfOOicQbinYDgkhAw/Xrq7iAvtnaiphJdoVdK0BT3b?=
 =?Windows-1252?Q?czcUugLGZNK7xY1drM4pcerXhQnkqVtti0rpOMxA39JD0fnguCDHD2zI?=
 =?Windows-1252?Q?DPUHgovDQOCeWLJPLnQVvJ8tm/eUG4c7d7N3xn03JF4S5kyzNvYE1+Nj?=
 =?Windows-1252?Q?HvjJnsHHObOARq8LUt9XQnRRZCAL3ZfkBCMyOvNugyKg1HZoy/0YIBzz?=
 =?Windows-1252?Q?XnDt6N8h2RaOTeIewhEMtuP1xeKav6AOgnnX0C6xEV+VqYXVUzjo0QIH?=
 =?Windows-1252?Q?o9RwaLmwQ+LMWx7VSAxuJQvNpfadFUtTXfCT78njkbkC+VXGEv4AqOnH?=
 =?Windows-1252?Q?dh2K7t748k+JsMwjmKqdF9Sw6TYBxHl8/KnusqWIufuVY2fhPONtH+A8?=
 =?Windows-1252?Q?16avY94VjV3qKeVp/A9j1JwttAi3dkAuJrHlpYD+UrUYhSmlBO8R4zIn?=
 =?Windows-1252?Q?EPekrkpaBsfsqoHyoqjXxpyi83uX3+is/4lU0jQA5bqIdfJClmt44MAH?=
 =?Windows-1252?Q?aqryrNBUuVnRdKLb5F6HqyC45M6/Vk7HPG1lWksA0ZJFlcT92pJFzi0b?=
 =?Windows-1252?Q?V0Iu7F+IRFfNUGN+XbKv64vLli8R1LGIUWhKMOl54Q9FNrWNJKCrROSB?=
 =?Windows-1252?Q?ux8prAbk5nDbzOaWm1zWZZ/g50vttOjff6J/TuQGHEFvxnXDBagPAe8e?=
 =?Windows-1252?Q?fXJaRR94A5LGBE/PDXJNWxXeKEqVF09yTYQYfurB1w+ap1Ukr+eFsJ+2?=
 =?Windows-1252?Q?qYSk38oZPQoyPCt6zG5R7deKvXTjM/9O3RbRB7VIOuRyUEdUxfXcBMET?=
 =?Windows-1252?Q?Zs1jThpGotnAzPxytfFOh3O19f/smDmsvk3tZAiT0bDnO9g6YgnZ1UZ1?=
 =?Windows-1252?Q?ZZOl+95LMoH4ymez+i8lguhV2ohii+h/cNlXH6dRp5JMoQXahcothOav?=
 =?Windows-1252?Q?T/9I1oVxDhS9BgoSlIPzI6pai7r4S16J/XnJ7VOVZtRxnWjH/A/3OFvS?=
 =?Windows-1252?Q?cylKAlYyg7wv4UYzL0LfEat2kU3NU8Pfe0V36MYA+LQiz+0Uz1ZgnL7b?=
 =?Windows-1252?Q?hF60gjNJWK/LTJPUDvkeTXa9l2c9I6VaNzzQZ6dWlozke+isDoy8laEv?=
 =?Windows-1252?Q?ZuLYeAIxd9o=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6850.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f83758-78e0-4f6d-6e7b-08db623be554
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 01:02:39.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEtomgawvgQ++GZ+OU2lJuHTIGbXoqStc5bwH4lXiPrxc2PZ6jfsgqn7lr21RmkrTSIMSGM3Tv2mP9UgMW3EOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an alternative, Is it possible to change ftpm design not to depend on RP=
MB access at the earlier/boot stage? Because to my understanding, typically=
 PCRs don't require persistent/NV storage (for example, before RPMB or tee-=
supplicant is ready, use TEE memory instead as temporary storage)

Bing

IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc7-=
bb2f-442c1b17af26)
System Software Engineering
Software and Advanced Technology Group
Zizhu Science Park, Shanghai, China

-----Original Message-----
From: Shyam Saini <shyamsaini@linux.microsoft.com>=20
Sent: Thursday, June 1, 2023 3:10 AM
To: alex.bennee@linaro.org
Cc: code@tyhicks.com; Matti.Moell@opensynergy.com; arnd@linaro.org; Zhu, Bi=
ng <bing.zhu@intel.com>; hmo@opensynergy.com; ilias.apalodimas@linaro.org; =
joakim.bech@linaro.org; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel=
.org; linux-scsi@vger.kernel.org; maxim.uvarov@linaro.org; ruchika.gupta@li=
naro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.hansson@linaro.org;=
 Huang, Yang <yang.huang@intel.com>; sumit.garg@linaro.org; jens.wiklander@=
linaro.org; op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver

Hi Alex,

[ Resending, Sorry for the noise ]
=20
Are you still working on it or planning to resubmit it ?

[1] The current optee tee kernel driver implementation doesn't work when IM=
A is used with optee implemented ftpm.

The ftpm has dependency on tee-supplicant which comes once the user space i=
s up and running and IMA attestation happens at boot time and it requires t=
o extend ftpm PCRs.=20

But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can=
 only access RPMB via tee-supplicant(user space). So, there should be a fas=
t path to allow optee os to access the RPMB parititon without waiting for u=
ser-space tee supplicant.

To achieve this fast path linux optee driver and mmc driver needs some work=
 and finally it will need RPMB driver which you posted.
=20
Please let me know what's your plan on this.
=20
[1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html

Best Regards,
Shyam
