Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E19695927
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjBNGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjBNGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:25:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752C1CF48;
        Mon, 13 Feb 2023 22:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676355942; x=1707891942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wzwmc74yoGmUjjnRSqisY629wA8pPcFXq6N5TX2pIVs=;
  b=VqDDHNuAAO0xEr8PKcBrO1arJdt9D4W7UBWEPqFRkOpz6DSAhgjGsTtg
   Hemcrps+gqFAlf7PYpUJqtkvkM84gt2G06CRLhQu+qPfrBiHC00xA08Rr
   hnSDuZrG0ovKBpE6QSCc2kuDDpjO1kIe3DZ84LNHdqLo1h+ztOisAfQmm
   lmWEyro224NJZpTd6fps/Znegkw7Spq9uIIUEWa2XkI8xBu9QMVLthmIT
   /JhnH3gVSDu3vnHhJjiQk9BWEzyyx5y64FPs+Cyn74QU97Ymg+XF9CHkA
   XcPCvVMBuXRKeitBwoTelvLEWuXU5c9Jxp9fB5mC9ZsH4oSdTVQNNhDsb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333227675"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333227675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="737786207"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="737786207"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2023 22:25:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:25:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:25:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 22:25:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 22:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDaiB/bUzmGUP3+ZTIQisg8/fPvSgFrxzTU3KmYi4uugJiAVtH+covnw500pRqkOMxUfsP5rAh4wtxysm6BCrZlSqb/HMI/eNSszmMiqhQy8xEVv5sZlpk5aLRhnSzobNEfwBaQCSilwUTB6H0AswJVZWJkC3Ay+tYg/ogTgRVvcWYsI8COJdNUs2LzObZCoovl+lrJVb4SORE9NU9EzwiGPz0TrljmcOLYME+HboTeFT4ItPhQdALK1A5M6TY3glsF9ZBZR3Bsws81WLUXZV20v3WlqvJBJYRGgidhBWK0n4cHsZhRzVQI9bjjic0KaXDgwRV1QM/2T39SX6lWikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Zrohok51f2lG01F9QfO0pduvRY6HiEasSYE4dVwX8=;
 b=PdvHA1SiQclU/qb9sXimvqp2C9O49zB7yh1YgBBSHZGkRhdZ1LbohDQza7Ls/gscQvqSIWixXTi8m+UFEIYAFdi0nz12nPJZfIHri5A3w/BVnw+qB/OkVPzUL8t+q/PEXAe7Xkt6XlkK8j0csLXs8xYENV1NT+8AZ71tg32coH4W5Q80kmibbovOcjlYSaF8AvIWf9QaPDtohQvE1UYQMt1YQNu0J4UQzGL3djZMO1BlrMjNRqgoMaz9b44jp4GrCX8CQIsAhsNRz3iHShGKBS74DXoeCK215jckNSd0ixH86ZrH4URomDgMgFvAZtDICH8qwrDNyl0WAi99A8XqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 06:25:35 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::4166:eaf4:4a68:ee3c%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:25:35 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Topic: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Index: AQHZP1HqpZLwLlRt00ml9e7fRXtKOq7MO6AAgAG4EjA=
Date:   Tue, 14 Feb 2023 06:25:35 +0000
Message-ID: <DM6PR11MB4316408448DC0A07D347ED188DA29@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213034202.2926-1-hdanton@sina.com>
In-Reply-To: <20230213034202.2926-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|DS0PR11MB6423:EE_
x-ms-office365-filtering-correlation-id: 9bb6ccf6-d40d-447f-1d21-08db0e544864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OK3OjJKLzOlmRQqZma8wmPeBKXw8/gJ8LgOxfsYo/7BlzJyZ53wUPyvQtnhuESKiippL4B01Fkjv2lUk6/pwy0ovGIgqH7fTS5c6jeLJkGW9gc5zTgbLP1yPN6oVacl0aMarxJhfZIKUiaBYBX3K0SCxGWApvLGh1eKCVz3jTatGwAenOJlp6SzwuA0VjwoQUF6jtVyBTAK+RXhI5dp/e4SJF3fs2sRyuc7+8dkg/UAy5o7CRk97YXJtkgdSRYS2jWzIAbKrTF8Eo+5yOYb1XDz8ENm+d5k6OIXKzHHLCH50ki3BjrzWUBdgjHh9yCH7loFWf+v2PYS+0uDn0k5fijKn+KztcFnKsceYuoO9B2D81NXupm9u20XDhINxKdQWAnzT8bv9XGdhOlRy6GSvDKW+wvcKManFo9RimUSrMP4c62jOq7/uOJp3foVLb+v7Nka7qTy9pPC8jABCvVGaOAU04Se6MCovpddnrwt7lb+RfApAgJOpYagY0b1drFhYjLqvKVGf56kcfabsJlXCIa/+YeKZvcjJkQJXBiBTRvukEnvog3AdPSD6Hf/ZK4ALu7C/b1EmmGVLGj+r8SxPq67lRWs5Yh5fraZ4pS6gvaKiv8rrTPgmEsLS+dE1Qz7zQIb/bO7SCbM5+zXRYMx6jo7mTwBka3vFXnb1zL9PEK4rahPrRpxivR1VwY7LQxxJsNDupxm+t2KjyLJFfGd6CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(316002)(33656002)(38070700005)(83380400001)(66476007)(76116006)(6916009)(66556008)(4326008)(64756008)(66446008)(66946007)(55016003)(71200400001)(8676002)(8936002)(7696005)(52536014)(38100700002)(2906002)(82960400001)(478600001)(5660300002)(6506007)(54906003)(41300700001)(26005)(86362001)(186003)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0RwX1JhC0LRAnaeSDR9rXCXOgHBg66o18YcbMdsv6yavJwWRJt+0TOYLEVak?=
 =?us-ascii?Q?RuwcJP6Cz/NUDDay3MHDkBOxhmG/zn84XAayncUwtI20UH4jkNd7AVTFtc97?=
 =?us-ascii?Q?xpOSH31yjPlMvc/mR428HLvmVKuiTVhNcd092HPohpcqkhPgQkq+hVCL24Vr?=
 =?us-ascii?Q?//ANz+xkmsOikKgjTjexFSA9Doiz8gJ9hNeZSYrpmO2rlYsSGYC9CbN6FQRV?=
 =?us-ascii?Q?oY1HRtbjO/zQDMi8hbx40mW5e6xAYoBDuASNBVTfvtXXicwmC+y54lr4WEIx?=
 =?us-ascii?Q?O0ey7AQIog+Pbk2qxOJrsuJcCtxGJkU4Q5haw3yCChLKH2cSWPGFR1nFjQYj?=
 =?us-ascii?Q?mZCBcWJaj6d4PF/er0nPgvr4yn929d0x+WLbO3zZuk8j6/v3FhLWpmAHQeDY?=
 =?us-ascii?Q?2vClY1Hm/rHVxYoP2x8OLpEuIBTKLAiObCB7kdrtZy5YXBzqq2fQaEDmao6A?=
 =?us-ascii?Q?LJ6TsE5G4bvwaiIvxqs5ePyzai+a0V5SJ0+QtS/Pu7Ks7q1eesn/0F3jrGOu?=
 =?us-ascii?Q?Mloyl1tL9WU+0kHfzXa13lti6+2CI2bg17YEuh0gouVMTHv6QUhQXEuoDSr6?=
 =?us-ascii?Q?X+GSm8hp7KbXxS6/S+ni92Ntua/s0avm1FnBY72O4iB9K06X+FLjqyLzGH1q?=
 =?us-ascii?Q?OIG/Uv53bBqcKrrxNp4TNHI75qcQFCYCpo2KoAEaOLdXiU8Yj/GvAr9O2Gsc?=
 =?us-ascii?Q?ImH53MQNNSNHrzEX8h+3MBpsu/WRkjgouVkXgzam1SuCTLlF3CoJkyH9W0n0?=
 =?us-ascii?Q?8iouGmOVI9n9+gRTt0WSCc9Krn6IxGO76uaxR6sCNYN2SDa5OdilHRG5Qkdp?=
 =?us-ascii?Q?lTDSbhF1cD1Oii1mxOHls5gKmg4S/gGypC6aMqc6WW5OpkioVDoOdh3/bTu3?=
 =?us-ascii?Q?XlcpAFBXuZhWSmLoa7SehHpari3GpPiYi7KRijjrNF+0R+B6FAz6z9yKi6QV?=
 =?us-ascii?Q?7/qS6L0d+nkFQHnprcKfzd/JIp3sc+vcQIoIudcv8xluzjD9Cwfg1HmiiuGI?=
 =?us-ascii?Q?yjjRxunHoNcRZk3GC0UHxznvuEAutEMOR2gGgHb/aTvTjAUvOmMaBoaSojWG?=
 =?us-ascii?Q?RqtxYyuhzlx6oj1XkMrIDv2zfHSTzcnaIQVIimcKFxj7aCUXhDbXPEdhREnk?=
 =?us-ascii?Q?LvqQPTglkXgsZTDenFsZLLavDci37sfJSuo9/5hp5dnBzHEZEGwSh3siw6Q9?=
 =?us-ascii?Q?/AlY5dYGggaaKMJ6Ho2ONBHmStiZABaLU891F+IjGRmXNrYDmRedHhFYcgNQ?=
 =?us-ascii?Q?QA2dpP5KJSuRu7E6TBshyNNQNwUxVGGrMT3E+wRjMGV7l4nYZX8M4zS+RbUd?=
 =?us-ascii?Q?wvKcLH06sf11GI+nRLEYtcQcJI+3TNdLSQxopjJCqaXJ3uB70dEB2IPWEgTT?=
 =?us-ascii?Q?Vr03Pra8TwnQDctgvs+gjwwRNW3D+WMsf2hKMbqT9AU4OOrhGP8qjQYmmHox?=
 =?us-ascii?Q?2mUwMOUwMifHahwyP6fm4PTKJLajFRDL+IuSnj6KjCEfuyKfIzBvtT2gSIA9?=
 =?us-ascii?Q?X4qf321Mv2MT3B56JNbOZmlhncQCcBcBOWVLE6ciEaECI6sG9SSiV9PCzRHC?=
 =?us-ascii?Q?rwmx/VQ1vCt18FLNzhsv0sMd5dYc1N72OPaNkj8N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb6ccf6-d40d-447f-1d21-08db0e544864
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:25:35.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFjv1PJ96WpTYSDYUtBHL595QaeoYiC3qBr6gFTAzkJ24Yaf79sOl5cBzHHjAq4pR32lnstaD+MJm4mt5HyDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hillf Danton,

Thanks for your review

> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Monday, February 13, 2023 11:42 AM
>=20
> On Mon, 13 Feb 2023 10:23:45 +0800 Wentong Wu <wentong.wu@intel.com>
> > +
> > +/* send a command to firmware and mutex must be held by caller */
> > +static int mei_csi_send(u8 *buf, size_t len) {
> > +	struct csi_cmd *cmd =3D (struct csi_cmd *)buf;
> > +	int ret;
> > +
> > +	reinit_completion(&csi->cmd_completion);
>=20
> Could you specify why reinit is needed here?

This allows new command(e.g. 'get status' command to check current firmware=
 status) to be downloaded to firmware for debugging purpose in case no resp=
onse for current command though I have never saw this happen. =20

> What is hurt without it?

No hurt for current implementation. I can remove it.

>=20
> Same question for the reinit in 2/3.

same ack for 2/3

>=20
> > +
> > +	ret =3D mei_cldev_send(csi->cldev, buf, len);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret =3D wait_for_completion_killable_timeout(&csi->cmd_completion,
> > +						   CSI_CMD_TIMEOUT);
> > +	if (ret < 0) {
> > +		goto out;
> > +	} else if (!ret) {
> > +		ret =3D -ETIMEDOUT;
> > +		goto out;
> > +	}
