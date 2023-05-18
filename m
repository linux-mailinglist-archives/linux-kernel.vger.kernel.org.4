Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5747708709
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjERRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjERRe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:34:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BF7E46;
        Thu, 18 May 2023 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684431296; x=1715967296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D7iAOI01Gi9wmLO0vTWTw5BNBSek5PUeMoj/auBHrTI=;
  b=lyWEBvn0ZDRPwi43qx0kmrFDf9X3lR9HhK/0GepdNTxkEP8rv4KmIDsC
   id8uZjyV8JQDbh1HXCy6HhhQV2fresJrD/K0IZ3AWN1mxmz525LAeDD6n
   X4l2DrCBEOLIr+WGttIuMyPITuRcKIvHr4I/EInxKRsX638FBKcTaSofV
   4gdXASGvdEhJdBy85UQDpGtB9vBW/7+Fz6sKDRbcBOK5QC9HjmbUIZqGZ
   05qD19vJgMjExOtVAEHheew08C1nYYMo1ef+TSvF2CVe631t61kZEbus8
   3+w2grJyFT7XZHYE6/3x/cV2+YC+Grtj3bkUT2ipDWhn34O00i/8mohhR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352158117"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="352158117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="679744042"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="679744042"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2023 10:33:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 10:33:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 10:33:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 10:33:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 10:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVaJ0eRcm8yY84xcbWKTupBigEuq+pxgGzC/hFXMqr5eEXGN+6ZBNap9twX7t/gh89igPy0ndXKHKLuMz1OtHkDrX0Bpo2gbcN56Py0k67PGXPtqsWDvdU/DdSpzblV4oIFgtQgTgxHV7j26XRRmljQOJTOm+TVPvZYdhxJrKFvTJgT/ZUCtEpLTlUf8Uo/k9lwa8UxRc8Ak//MsuGvu6kXdNLVfGEOoAYv5E6vFT7BB0+qOoL65gjT/9x78Mp8V7KfdR6GyBO7LgD/amz7RZt7RhtcO3DuC8nCJMV7cvkzwyqqdDLeTfcc7CpLXRLeK9yqgFw8+sPMeRLrO2FRDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIqkD97y5xxNCZTVbE0OFq/8LqKLSPRmQPgqXKIJ9XY=;
 b=WYMpn40hpwYgpxhq+5wge9nWYHEkbT0BwUodhHMf19l8ZEfj0Ch/h3khjE7qqYGDSWEg5wiPZPC3uTSTa9NKwJkBQDZPcFOkNElbSROqoQDzjGOtQqy59N4/mZGTpNAN/5WnlrFPldMfONl6XirZvbxrfhMI3mAYRaKO6jWb5DQT5EwYXwWURFBmYqVzLpE0HICSntxrSsRc/7tUe/bUg4I+RQS0ELnLnTqlkY8TCn1ndL8MUPVFBjeRuboOkM7ohRTz53GGY0dIXCz9UozPWdt/3+L+4lpsKD3BmRLzRkJYwPZJUemA3x0qh0MNcUGeIGle5PBEjgawip/zCOOcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) by
 IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 17:33:01 +0000
Received: from DS0PR11MB7684.namprd11.prod.outlook.com
 ([fe80::b9ce:e5b1:5475:77fa]) by DS0PR11MB7684.namprd11.prod.outlook.com
 ([fe80::b9ce:e5b1:5475:77fa%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 17:33:01 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
Subject: RE: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake
 SoC
Thread-Topic: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake
 SoC
Thread-Index: AQHZQTuU8aUWtcOEoUy+7lVVodX0X69VrrAAgAAezQCACvl9YA==
Date:   Thu, 18 May 2023 17:33:01 +0000
Message-ID: <DS0PR11MB76845B5BAD7EB99BF5A1349CBB7F9@DS0PR11MB7684.namprd11.prod.outlook.com>
References: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
 <28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com>
 <ZF0bosUa2moFCoOj@agluck-desk3.sc.intel.com>
In-Reply-To: <ZF0bosUa2moFCoOj@agluck-desk3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7684:EE_|IA1PR11MB6491:EE_
x-ms-office365-filtering-correlation-id: 5bfbbd55-787b-474d-4600-08db57c5edd8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axkaTvMP+fX5H9SO6a3dLUzb2car6EkkPNucgnFWm7iB2UnqGZcsJoXA2am7uyz9cn2GeUAR5GKkhDnjU2DgjpUwwCPI6FxCSB942we7XJK4f3CRsuiRYSrwq6gTMNkTZENyNzlmBVzbPJlTts5+2w/DeKsg6UTbvwbOaIjQKkaBtQijaHLPyIxg5fDDkF6lj2E/65te7HopnPzSca23qTr2xHMPtPcIzkU16LWsRk6tzQb1Jv7gQL+W7Ecb/LHC54iCJh9N3dIg8lb3hquEcT9ZHDRrDiFWCXy1B89p8tgKySW75wC9Kshikq8z17XZbea+gpi5iSqO7cknzQ7j8yOQVp4DrdgcvT5nCU1J5Z5BD4ig0aBSQ47bZZ93EH1aAxWpHunx/4DdXdPDC/+H5fTUBImZj4Y6xqXKbrfZLG1XJurCnUk7TEw7NIAc/lfES5I1SFylgUspzb6KEIegpTHBRVaKj1Z2nOiHi2AZfVpvwOD0Tpdoh7uyRtpiVXGQ50WhsQxrkl3FAHEDWfsFE+jC37W1QV2qsfsKrq6NqR3/suoxg1fbL4T/zx4P43GHwuOQ4sYHQZcaHZJS57GNjN3HCwbTiXJAMiVLo4DpoqPBKE50eNOiMIAG5VhnBXTU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7684.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(7696005)(83380400001)(186003)(110136005)(71200400001)(54906003)(66446008)(478600001)(6506007)(9686003)(26005)(53546011)(8936002)(8676002)(5660300002)(52536014)(6636002)(82960400001)(122000001)(33656002)(38100700002)(41300700001)(66556008)(66946007)(66476007)(76116006)(64756008)(55016003)(2906002)(4326008)(316002)(38070700005)(4744005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqnciLgU+7wq5vzsNMG/gcHU81lrGDQXzTHZ9vLGTflKAXUx3D1N1vPNR8a9?=
 =?us-ascii?Q?ME/5r+5F0H5wIY1uwTv4rNToyy0VDLgVsLgy9uyJy2b2O4Zgeralsl3v5Fpe?=
 =?us-ascii?Q?EmGzSE0+5ZQZCTGY2Ah+2NcUmOB3vATwUwdu9C6JbDiPi4m8+jhACs6Z6z5v?=
 =?us-ascii?Q?dvs1/c116hP5tQ3Ne4Q9Z2zg23MH0gjMqfQh+FaUR+DSRMR6A3OyW9/WoxDS?=
 =?us-ascii?Q?quI6l4lgZhOSy6IxJ8S3y0Kmizp5jgGOegCcohEC7NomKw8SccT3NAuRYYb0?=
 =?us-ascii?Q?rNN/hfRwum50Cu/42zVLuzYrz5pVZjZl9wGv3o2NBjX0j7r++g/fVJINbxKA?=
 =?us-ascii?Q?OA5QWXuBnk5R7VNYgfuzjAA/ZrLVu3QWRZJMwNpi0a8ze7wpNC9QbiG6XuRV?=
 =?us-ascii?Q?k+be8hIjzCmZVV2f7AwXSj4jIgNXtun7bi56ezEtwMhRQFQy3nsxDW3xjDUL?=
 =?us-ascii?Q?ENt+wK9Tex3E9BFUaqrDM/qAfYs6KkNPInfOzepNHoXaDXzNMRh315WcBIp8?=
 =?us-ascii?Q?SPOEnuwCuonX8/vohUw/zT4yRtaJSVGMwA6Sa2J2GsO1SvYUC+hPkMLiiA8f?=
 =?us-ascii?Q?x6c9TJl9DqZRhV388ETx/GFD1jzM09PyDr3r6J2r8AQbGTGgX7vyoohe3A3K?=
 =?us-ascii?Q?qmv+GIQJeIWvSrMjZYuKVG0CUhji9Ry47dlt9YySDXDmsrRVHHqPQ8NsbY7t?=
 =?us-ascii?Q?86jgIRCGFCsZ4Us1ZOzCLs2mIDsS3GT+NFtnHxuHQQV68K9Ls70wzcD8Nf/U?=
 =?us-ascii?Q?eqt7ZYWKoJlGcqL3i6IFPjzCDdV4jQfXF5YO2HxRRUUuLouvSR7NBsg7A+nY?=
 =?us-ascii?Q?59Thudtffk6Vf9U+gPRiuFBfkHRy9NzefRw+Oj23Yyt3Mu+rRTup35iptpqR?=
 =?us-ascii?Q?Vha4C7XSHp+iAhdQtsgxw6kLRMVbS98S82FrCBDKkQtlbNHY5gHIJWdicUDO?=
 =?us-ascii?Q?KXTicOkqlKYidWbgM8xnwuQDQcBRVprDT6bhpUUfdWld2H4giulPRULYXexK?=
 =?us-ascii?Q?i/PbTNA05gGAXeGbloo7wqKdLxDDyUXnk4uy85mtwrTdpzARbFx2RLneWfht?=
 =?us-ascii?Q?TgO/pWb/iqFJJWLIUvyqMJcp1ahoOkEst1ALCn92+1F95lFhYiNK8wINDa5l?=
 =?us-ascii?Q?wX2waLInIMpMhIQzt2pBWoZ12fawIU2vQoKUyZJhyYcS8k3nXdyPOL1Ckxvk?=
 =?us-ascii?Q?lgT3iF/9FWDPvCi7tagqCNzTFcuALmNgZ6KXhhs/z33dRvr0Nr/WUx8iFGne?=
 =?us-ascii?Q?HFqoUzr0N8EcvNUsTmQfpPZcu1NWMJ43euTAJ3C8iJheb5ctFDNeGvL/HdbV?=
 =?us-ascii?Q?Oj39di6KmQNMFnN2CWyzEQe1aqJ9wLPu7iGhuA2CeplI3UTHheKl065RafS8?=
 =?us-ascii?Q?qc/yUn8itwv3LmNXVogkFxdGPfmYFYMUprmQROWSpqIzM86hmgWa8Ja9gQdn?=
 =?us-ascii?Q?Xy1yW/e2l/dW0/Np4k4nXfruK4GdzmHDwIc5kye5zXePr/heW8viUqQIbCeY?=
 =?us-ascii?Q?SzLOx3/7b87Eqftzn40kAWqhgecKHlp5H1poV8VfWS7qh0hpYew/dHPQj196?=
 =?us-ascii?Q?yoXrs8S36f576uhQU1xiJu39O5nqVwofEicGHQkNr9Yd06wpFXWww8CYwPup?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfbbd55-787b-474d-4600-08db57c5edd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 17:33:01.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaoIPrNvCij9tBBdm80TCz8gPH511v6vh52E+MLTklOoAExiUI1oOYvAwucUGdMQk0rDVptLCX7YL28x4tf9IwDCHEn9qHdbaKBR+i9nkdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Thursday, May 11, 2023 10:15 PM
> To: Hansen, Dave <dave.hansen@intel.com>
> Cc: Pawnikar, Sumeet R <sumeet.r.pawnikar@intel.com>; rafael@kernel.org;
> srinivas.pandruvada@linux.intel.com; Zhang, Rui <rui.zhang@intel.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor
> Lake SoC
>=20
> On Thu, May 11, 2023 at 07:55:08AM -0700, Dave Hansen wrote:
> > Could you please fix this up?  As penance, you could even fix the _ANY
> > defines so that people can't do this accidentally any longer.
>=20
> See the X86_MATCH_INTEL_FAM6_MODEL() for how to do this right.
>=20

Thanks Dave and Tony for this information.=20
Let me check and submit the fix for this.=20

Regards,=20
Sumeet.=20

> -Tony
