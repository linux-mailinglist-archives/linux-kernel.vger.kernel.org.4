Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF98E63B9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiK2GZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiK2GZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:25:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A984349B5C;
        Mon, 28 Nov 2022 22:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669703107; x=1701239107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B8uN5waWzgtteXyp+E9lDchM7YK2AayYKeDcvo7UC+8=;
  b=htsM9DOmqCP0Gs89sCk+zKcgMNH5Qx0aK/3qpPurBmFdDQKE0aeEA+jU
   FGdzDTMc7ZiUtx8etL8CYBwIHYwc1hsOjpxwEJIMBU4mRQISkr813a13+
   DDRavtoR3KRGGUDW849Mxm2qPJ45hMt4cPTEu7EszJ0EKVSzIS8iSMXCw
   mKNRKhLd0mztgeeq++yqSSVYYrJ4OTXNax+/BsW/OoN1ohrqv4SQMYVRp
   R2ypy66CmKPh4R9W5iyyo7rqbQqq3FeSWR7jd/KIfLyvOtrpfjHQHjcX1
   Nix2iD/GADmMEFSl7km7emwxWX8j6/mM/V8rtlkA/dytWiOdU9/EPBaXz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294725082"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="294725082"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="707087519"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="707087519"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2022 22:25:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 22:25:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 22:25:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 22:25:06 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 22:25:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjbhc19NbHDRA1RZWZj/mK6QNTF9ESvINH9IEpU+7kee7s9oycSfsR3JDraKifC3M1gSC94cJXc9jZHLfUgb2gze3LkRK9+n+xwm6ytV/QjbbrZ8un4UK2lvR9RsB81uetHGBXB2pWF2ki/+rm0Bl0rqa78NHGokFwwSYyGsh8oLLluZ4YlXc3EqrwA/tD/6qkIVgFOOYEA1S6PFPizRT3uIdPkRWyTg9xetKSAW6QNmS2fa+Z2j4pwSMjHGwGB8F10LI6GJgr8hBQFl+EzRNeJsWHE0d1HEA/cj77LYkplyZB+wnY1ybgOb4M8OJPQwZoTLGbRhfj+HITVVBNtVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8uN5waWzgtteXyp+E9lDchM7YK2AayYKeDcvo7UC+8=;
 b=Ph6sByI5phxPK7VkKbS2xZIS6B+Mo6ylNfP/CkA+Pih9lqI9ox6nDLLYvaYzV5clXyLUHkgAWWxu8CIyNtxRzFnvvxiHlfNJFFrdJ9FVaix13240VND40G3jbKyHBI5T6NcJantTvzl6f3EngiHCw2Md7ujc7JIfZ3VXGA7j3t58XMaFSOR1ILe1rwKigcAv1t6CDp1Bh64IyZm4uA3Oc1M6TGS//oSsZ17qgWnoFm4UBuc2NCbG0Z9nQM2vHjCCuBXsCT75R9+qKqa2akEAMDSKyvO2XLTb6anV85tlF4im6qlWV3b+LqfNtsSHgEeNyipWrPFJWFrQdk8Jz9DIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Tue, 29 Nov
 2022 06:25:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:25:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAzXSKOjuTzu2RUKeoTlESXbs8q5VFkkAgAAryDCAACcSgIAAA3vQ
Date:   Tue, 29 Nov 2022 06:25:04 +0000
Message-ID: <PH0PR11MB58801BEDCA0F6600F01486FEDA129@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB588001E6982A9DC32F93FD7ADA129@PH0PR11MB5880.namprd11.prod.outlook.com>
 <24EC376D-B542-4E3C-BC10-3E81F2F2F49C@joelfernandes.org>
In-Reply-To: <24EC376D-B542-4E3C-BC10-3E81F2F2F49C@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: 19e9fe8a-f464-49e8-5e8c-08dad1d273c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7zoMZp0bbhe+AlUZMXNrBuvSKdwEBR8Kc8tgsYgvbwuwNYzIHqvShESnNxebnzUGyNNiCMfxWbC/O/8TziUTYn0ySbIc8QKxu9ZwdK1fQmfTkB/ft/X5wBDwHEdjwbmiS3N4i7c3JTfkOcvITahVS6QMEJQiSDIQtvD+s/42MVe/3ONI9Ne0Vd/34rl7wSh6Pc6led7HM20mITDfTv7iHkvuk+cXcm6UbcBD/mQEWBI0OKBiM+WZjfyZptlrHUUg7bw70kts7Xu1SvCD2PBmqokKRuqH4MoKH0XirgRJehbngoAAJeJqb0x49E4lyzGfRWpaUNyk5+JNr3Pah7gtGsmtQk2mz0VZ3vY477h1stGKneBiBBDWL+oGuuIdltPc89IjT7JGE8BTykEGbITBHXaH5fjykDHyFM3ZdrAqdsuzwTIUkzKOM5hAbHERguvFPHZRhxTvEv9LGxMCOS77nG/a4sd7z3n6Zg3A4Q/33RvpimlpmMCr6Z4vyx4BFKkJmejmzweXKEt98pNDdazBEluRJNLBqyxWHVcqMW7/g5ZX082PHe/zf/XozWaBhkLMCamgQ6agreprZJ9RlqbV7Knatd05s3o0BdfQ45wS0F/g8FUAXouV4rCPRlbwWMbsICYgWwsrDSp61BDBi9pXeo99lN69miRO7ZWsVzJlnIAbP5JLq3a6Q9XlVWVRh3kOBHUZ3wtFwIkDCo+1PtX+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(5660300002)(52536014)(8936002)(66446008)(64756008)(66476007)(8676002)(4326008)(66556008)(41300700001)(54906003)(6916009)(71200400001)(76116006)(478600001)(316002)(66946007)(2906002)(86362001)(9686003)(7696005)(53546011)(6506007)(26005)(33656002)(186003)(38070700005)(83380400001)(38100700002)(82960400001)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFVUdXM2ZWVSc2ZxRDIrcDA0eWNoNDV3UmJMREJ4M0Y2OWtsQlRNdzBUcjNy?=
 =?utf-8?B?TUhDL3dMZG8vY0JUalRzRGZtOGV0VTdOVnBoakhXYWZ3L0gwVCtjUEwySEg1?=
 =?utf-8?B?VlRrM0tOMm9jVVRLWU9hbXA4bDhQa1hqaHI0dEhnTzZjUVVYMDU3WTZYNERT?=
 =?utf-8?B?WHJLOW1sRVkrbWt4eVJLQjB4UW9VZlRWWVZBbUtxakZUeVJqN1l3Tjl1QWgz?=
 =?utf-8?B?Nit0dlZaRjJrRkpSNmV6WkJjbzBxS2VXaFdDMTRxMWRyRnBNaHBNUHhUU01w?=
 =?utf-8?B?cmxtTVR2b3owcmVJVEw3cnIxMENWS0dFUTU0QUd5VFdIV0lCWmxUcWpCRjZl?=
 =?utf-8?B?ZjEweUtQcEFTWlBaVHNzMVI4SHN3THNLdHdOUnV0ZHJJZE5LQjMxWjR6bDg4?=
 =?utf-8?B?N0lNR1A4L3V1YUhaNWhQb1d6Rm9xYk1aTDZDRGxVcUlJQ3p4QTB0bnB2RGN5?=
 =?utf-8?B?SEdXNUd5OU9FQ0wwblRiYThpK0dkZTI3Qk9qQ2tJbkJrVUJld0kyUytSdTlD?=
 =?utf-8?B?dHNwdEVrcnRHKytPWmV5SWt3TUErSWp1Q2QwdDU5QVZlUGF4cHlzZ2Nrb2dF?=
 =?utf-8?B?V0dDemFOT254ZWhRT0tZUEJwRlozYVA3VGxLQkJWQ2w4cjNjUDh0MW1WZUVB?=
 =?utf-8?B?Z3pmUWVVS3dFNCtZSE91cjFYYUw1M3NUVEY0NXFpT2l2UHJ2OTJERVUvcWd3?=
 =?utf-8?B?ODFMN0lQK0xhcjQ2OXk0ckh4NG9UY003cU5HUlZjWjhZVjI2bWZmbXlUV3Nm?=
 =?utf-8?B?a1VtcndBbkY2S1k2UVpKeGN0QUMyanpQVGZKQVlVVHVRRHV6dkxzNzZ3YWdm?=
 =?utf-8?B?Wmk3UFlLVXlSZmVaY1ZUWlZBRzdSZll1M3lBditaWGw4VVlJUE51QjNDbm54?=
 =?utf-8?B?dTY0RGMvd082ejNCZ1ZRdjdvbUgvVjRXWVUyZGxoVVo3cE5Ra1ZaakJleHZ5?=
 =?utf-8?B?cnhEUDBlMWdHUE9oWFlGenBmQWR2REpybE0xTHRtSFZ2dUtMMk81MVFTSkw0?=
 =?utf-8?B?N09WTkVGSGFwL3o3azBSUjJQU0xGYlFqL3ZleFVEYVlBbUUzdXZIRTdqeGhz?=
 =?utf-8?B?RkMwNlNTdFJjQmUxOHg1Sk95K1I1RkJkZmxEcEl3VTdjQkNtSkRNV05vYm9X?=
 =?utf-8?B?d0YzUDluNGpQdS83QkN1OXRvb2l0VnpoWmZWUDB5Sk53ZHRnR0tIYkVEa1l3?=
 =?utf-8?B?dFNIdTV5N2g0N1YvQkRDdysvWk5pYVEybmhWOEpDVU1zSS9qUXdmRkJqZU9D?=
 =?utf-8?B?UWRBS1hRa3dLKzV4QW9tN1BiSWpwakw3NEVoRFJXK09pb3g3bVBzdENTM3pj?=
 =?utf-8?B?RXZZeDJBK1pGZjYva0tZUDFmbmNQR1pibWZIUkt2bWFHSHB2dGxEcHZJYTNu?=
 =?utf-8?B?WnpyL2VqVHE0REFsbHlNa1lrVkNWM1g4TlJxdlhVblZvNGdONWhXcEg3bGZs?=
 =?utf-8?B?dUFlVW9RVVpMeGxKUlJ3NCtXWE8yc0xZTVpKSnFabEwvSDJQSHJaZWYwSngx?=
 =?utf-8?B?akVRNHFsZHNFUmd3VVA2Z2ZMd3FoSU9iNWF3ekFRT3JaUExzZU10ZnhhZXJI?=
 =?utf-8?B?S0FRTVp3TzIzS0dvZTFSK1lBSjFzWUdPbmJ6VDgyMzU5OTc2RHpyV1dzNlBT?=
 =?utf-8?B?emdYZ0RCaXNmcjJnbE94cCsreTY2cVlZbCtnUnNnRlExVnZUcHE5VmZKZXQy?=
 =?utf-8?B?MFVLVndxeGY4UmtYcXZ5YzhaZG1TOUQvNWFCZjhkY3ZSTDNGc05FWDVkZWV3?=
 =?utf-8?B?REpMalhhYkUvdElicGFoMW4wUkFMMkdjclZzelIvL0hOOVFMclpqOXlSQVM5?=
 =?utf-8?B?SmttTEJkc1F1UXNjODRYNFdxSHJTRDRPZjBKeDRnVHlnUzdNQmVtUnIrUW9R?=
 =?utf-8?B?TEJ5R0hUK2J4YzJoNFpwZFI0Yk5yTDByTjRaeGJ0L1JFbFFueHprK2RibTlp?=
 =?utf-8?B?ZHVNTU5oajdYMEJVVjhjd3diQ2ZZbjVjR3B6NXZNV2hrOGd5Um9hRFJEeGc1?=
 =?utf-8?B?Njl6ZXZ0bnBtUmJnYVc1eVBCdlZsL3F3eGRzV2N1V25kYmExTjl2NFJuQlFM?=
 =?utf-8?B?V1h0QWlnekxPVnJTTWxMYnUzc0FJVlFBZDJCQmdoTFFyRVZ2dUJSTDdhY2RX?=
 =?utf-8?Q?NXyjXOznk5oqtAKKwbTDsCUCJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9fe8a-f464-49e8-5e8c-08dad1d273c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 06:25:04.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvLIRXBZjxePcCdsmS2FM4tDHR7y+DUP0NOdTIxzhl+jCz+hFOLlzsxQtpYcH9c649Nk50HvCk1nmFQd3IsQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjgsIDIwMjIsIGF0IDExOjU0IFBNLCBaaGFuZywgUWlhbmcxIDxxaWFuZzEuemhh
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDEw
OjM0OjI4UE0gKzA4MDAsIFpxaWFuZyB3cm90ZToNCj4+IEN1cnJlbnRseSwgaW52b2tlIHJjdV90
YXNrc19ydWRlX3dhaXRfZ3AoKSB0byB3YWl0IG9uZSBydWRlDQo+PiBSQ1UtdGFza3MgZ3JhY2Ug
cGVyaW9kLCBpZiBfX251bV9vbmxpbmVfY3B1cyA9PSAxLCB3aWxsIHJldHVybg0KPj4gZGlyZWN0
bHksIGluZGljYXRlcyB0aGUgZW5kIG9mIHRoZSBydWRlIFJDVS10YXNrIGdyYWNlIHBlcmlvZC4N
Cj4+IHN1cHBvc2UgdGhlIHN5c3RlbSBoYXMgdHdvIGNwdXMsIGNvbnNpZGVyIHRoZSBmb2xsb3dp
bmcgc2NlbmFyaW86DQo+PiANCj4+ICAgIENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIENQVTEgKGdvaW5nIG9mZmxpbmUpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
bWlncmF0aW9uLzEgdGFzazoNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjcHVfc3RvcHBlcl90aHJlYWQNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLT4gdGFrZV9jcHVfZG93bg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtPiBfY3B1X2Rpc2FibGUNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChkZWMgX19udW1fb25saW5lX2NwdXMpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0+Y3B1aHBfaW52b2tlX2NhbGxiYWNrDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICBhY2Nlc3Mgb2xkX2RhdGEwDQo+PiAgICAgICAgICAgdGFzazEN
Cj4+IGRlbCBvbGRfZGF0YTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLi4N
Cj4+IHN5bmNocm9uaXplX3JjdV90YXNrc19ydWRlKCkNCj4+IHRhc2sxIHNjaGVkdWxlIG91dA0K
Pj4gLi4uLg0KPj4gdGFzazIgc2NoZWR1bGUgaW4NCj4+IHJjdV90YXNrc19ydWRlX3dhaXRfZ3Ao
KQ0KPj4gICAgIC0+X19udW1fb25saW5lX2NwdXMgPT0gMQ0KPj4gICAgICAgLT5yZXR1cm4NCj4+
IC4uLi4NCj4+IHRhc2sxIHNjaGVkdWxlIGluDQo+PiAtPmZyZWUgb2xkX2RhdGEwDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByZWVtcHRfZW5hYmxl
DQo+PiANCj4+IHdoZW4gQ1BVMSBkZWMgX19udW1fb25saW5lX2NwdXMgYW5kIF9fbnVtX29ubGlu
ZV9jcHVzIGlzIGVxdWFsIG9uZSwNCj4+IHRoZSBDUFUxIGhhcyBub3QgZmluaXNoZWQgb2ZmbGlu
ZSwgc3RvcF9tYWNoaW5lIHRhc2sobWlncmF0aW9uLzEpDQo+PiBzdGlsbCBydW5uaW5nIG9uIENQ
VTEsIG1heWJlIHN0aWxsIGFjY2Vzc2luZyAnb2xkX2RhdGEwJywgYnV0IHRoZQ0KPj4gJ29sZF9k
YXRhMCcgaGFzIGZyZWVkIG9uIENQVTAuDQo+PiANCj4+IFRoaXMgY29tbWl0IGFkZCBjcHVzX3Jl
YWRfbG9jay91bmxvY2soKSBwcm90ZWN0aW9uIGJlZm9yZSBhY2Nlc3NpbmcNCj4+IF9fbnVtX29u
bGluZV9jcHVzIHZhcmlhYmxlcywgdG8gZW5zdXJlIHRoYXQgdGhlIENQVSBpbiB0aGUgb2ZmbGlu
ZQ0KPj4gcHJvY2VzcyBoYXMgYmVlbiBjb21wbGV0ZWQgb2ZmbGluZS4NCj4+IA0KPj4gU2lnbmVk
LW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPj4gDQo+PiBGaXJzdCwg
Z29vZCBleWVzIGFuZCBnb29kIGNhdGNoISEhDQo+PiANCj4+IFRoZSBwdXJwb3NlIG9mIHRoYXQg
Y2hlY2sgZm9yIG51bV9vbmxpbmVfY3B1cygpIGlzIG5vdCBwZXJmb3JtYW5jZQ0KPj4gb24gc2lu
Z2xlLUNQVSBzeXN0ZW1zLCBidXQgcmF0aGVyIGNvcnJlY3Qgb3BlcmF0aW9uIGR1cmluZyBlYXJs
eSBib290Lg0KPj4gU28gYSBzaW1wbGVyIHdheSB0byBtYWtlIHRoYXQgd29yayBpcyB0byBjaGVj
ayBmb3IgUkNVX1NDSEVEVUxFUl9SVU5OSU5HLA0KPj4gZm9yIGV4YW1wbGUsIGFzIGZvbGxvd3M6
DQo+PiANCj4+ICAgIGlmIChyY3Vfc2NoZWR1bGVyX2FjdGl2ZSAhPSBSQ1VfU0NIRURVTEVSX1JV
Tk5JTkcgJiYNCj4+ICAgICAgICBudW1fb25saW5lX2NwdXMoKSA8PSAxKQ0KPj4gICAgICAgIHJl
dHVybjsgICAgLy8gRWFybHkgYm9vdCBmYXN0cGF0aCBmb3Igb25seSBvbmUgQ1BVLg0KPiANCj4g
SGkgUGF1bA0KPiANCj4gRHVyaW5nIHN5c3RlbSBzdGFydHVwLCBiZWNhdXNlIHRoZSBSQ1VfU0NI
RURVTEVSX1JVTk5JTkcgaXMgc2V0IGFmdGVyIHN0YXJ0aW5nIG90aGVyIENQVXMsIA0KPiANCj4g
ICAgICAgICAgICAgIENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTEgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiANCj4gaWYgKHJj
dV9zY2hlZHVsZXJfYWN0aXZlICE9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
DQo+ICAgIFJDVV9TQ0hFRFVMRVJfUlVOTklORyAmJg0KPiAgICAgICAgICAgX19udW1fb25saW5l
X2NwdXMgID09IDEpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICANCj4gICAgcmV0dXJuOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmMgIF9fbnVtX29ubGluZV9jcHVzDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChfX251bV9vbmxpbmVfY3B1cyA9PSAyKQ0KPiAN
Cj4gQ1BVMCBkaWRuJ3Qgbm90aWNlIHRoZSB1cGRhdGUgb2YgdGhlIF9fbnVtX29ubGluZV9jcHVz
IHZhcmlhYmxlIGJ5IENQVTEgaW4gdGltZQ0KPiBDYW4gd2UgbW92ZSByY3Vfc2V0X3J1bnRpbWVf
bW9kZSgpIGJlZm9yZSBzbXBfaW5pdCgpDQo+IGFueSB0aG91Z2h0cz8NCj4NCj5JcyBhbnlvbmUg
ZXhwZWN0ZWQgdG8gZG8gcmN1LXRhc2tzIG9wZXJhdGlvbiBiZWZvcmUgdGhlIHNjaGVkdWxlciBp
cyBydW5uaW5nPyANCg0KTm90IHN1cmUgaWYgc3VjaCBhIHNjZW5hcmlvIGV4aXN0cy4NCg0KPlR5
cGljYWxseSB0aGlzIHJlcXVpcmVzIHRoZSB0YXNrcyB0byBjb250ZXh0IHN3aXRjaCB3aGljaCBp
cyBhIHNjaGVkdWxlciBvcGVyYXRpb24uDQo+DQo+SWYgdGhlIHNjaGVkdWxlciBpcyBub3QgeWV0
IHJ1bm5pbmcsIHRoZW4gSSBkb27igJl0IHRoaW5rIG1pc3NpbmcgYW4gdXBkYXRlIHRoZSBfX251
bV9vbmxpbmVfY3B1cyBtYXR0ZXJzIHNpbmNlIG5vIG9uZSBkb2VzIGEgdGFza3MtUkNVIHN5bmNo
cm9uaXplLg0KDQpIaSBKb2VsDQoNCkFmdGVyIHRoZSBrZXJuZWxfaW5pdCB0YXNrIHJ1bnMsIGJl
Zm9yZSBjYWxsaW5nIHNtcF9pbml0KCkgdG8gc3RhcnRpbmcgb3RoZXIgQ1BVcywgDQp0aGUgc2No
ZWR1bGVyIGhhdmVuIGJlZW4gaW5pdGlhbGl6YXRpb24sIHRhc2sgY29udGV4dCBzd2l0Y2hpbmcg
Y2FuIG9jY3VyLg0KDQpUaGFua3MNClpxaWFuZw0KDQo+DQo+T3IgZGlkIEkgbWlzcyBzb21ldGhp
bmc/DQo+DQo+VGhhbmtzLg0KPg0KPg0KPg0KPiANCj4gVGhhbmtzDQo+IFpxaWFuZw0KPiANCj4+
IA0KPj4gVGhpcyB3b3JrcyBiZWNhdXNlIHJjdV9zY2hlZHVsZXJfYWN0aXZlIGlzIHNldCB0byBS
Q1VfU0NIRURVTEVSX1JVTk5JTkcNCj4+IGxvbmcgYmVmb3JlIGl0IGlzIHBvc3NpYmxlIHRvIG9m
ZmxpbmUgQ1BVcy4NCj4+IA0KPj4gWWVzLCBzY2hlZHVsZV9vbl9lYWNoX2NwdSgpIGRvZXMgZG8g
Y3B1c19yZWFkX2xvY2soKSwgYWdhaW4sIGdvb2QgZXllcywNCj4+IGFuZCBpdCBhbHNvIHVubmVj
ZXNzYXJpbHkgZG9lcyB0aGUgc2NoZWR1bGVfd29ya19vbigpIHRoZSBjdXJyZW50IENQVSwNCj4+
IGJ1dCB0aGUgY29kZSBjYWxsaW5nIHN5bmNocm9uaXplX3JjdV90YXNrc19ydWRlKCkgaXMgb24g
aGlnaC1vdmVyaGVhZA0KPj4gY29kZSBwYXRocywgc28gdGhpcyBvdmVyaGVhZCBpcyBkb3duIGlu
IHRoZSBub2lzZS4NCj4+IA0KPj4gVW50aWwgZnVydGhlciBub3RpY2UsIGFueXdheS4NCj4+IA0K
Pj4gU28gc2ltcGxpY2l0eSBpcyBtdWNoIG1vcmUgaW1wb3J0YW50IHRoYW4gcGVyZm9ybWFuY2Ug
aW4gdGhpcyBjb2RlLg0KPj4gU28ganVzdCBhZGRpbmcgdGhlIGNoZWNrIGZvciBSQ1VfU0NIRURV
TEVSX1JVTk5JTkcgc2hvdWxkIGZpeCB0aGlzLA0KPj4gdW5sZXNzIEkgYW0gbWlzc2luZyBzb21l
dGhpbmcgKGFsd2F5cyBwb3NzaWJsZSEpLg0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBUaGFueCwgUGF1bA0KPj4gDQo+PiAtLS0NCj4+IGtlcm5lbC9yY3UvdGFza3MuaCB8IDIw
ICsrKysrKysrKysrKysrKysrKy0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdGFza3Mu
aCBiL2tlcm5lbC9yY3UvdGFza3MuaA0KPj4gaW5kZXggNGE5OTEzMTFiZTliLi4wOGU3MmM2NDYy
ZDggMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvcmN1L3Rhc2tzLmgNCj4+ICsrKyBiL2tlcm5lbC9y
Y3UvdGFza3MuaA0KPj4gQEAgLTEwMzMsMTQgKzEwMzMsMzAgQEAgc3RhdGljIHZvaWQgcmN1X3Rh
c2tzX2JlX3J1ZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4gew0KPj4gfQ0KPj4gDQo+
PiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCB3b3JrX3N0cnVjdCwgcnVkZV93b3JrKTsN
Cj4+ICsNCj4+IC8vIFdhaXQgZm9yIG9uZSBydWRlIFJDVS10YXNrcyBncmFjZSBwZXJpb2QuDQo+
PiBzdGF0aWMgdm9pZCByY3VfdGFza3NfcnVkZV93YWl0X2dwKHN0cnVjdCByY3VfdGFza3MgKnJ0
cCkNCj4+IHsNCj4+ICsgICAgaW50IGNwdTsNCj4+ICsgICAgc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrOw0KPj4gKw0KPj4gKyAgICBjcHVzX3JlYWRfbG9jaygpOw0KPj4gICAgaWYgKG51bV9vbmxp
bmVfY3B1cygpIDw9IDEpDQo+PiAtICAgICAgICByZXR1cm47ICAgIC8vIEZhc3RwYXRoIGZvciBv
bmx5IG9uZSBDUFUuDQo+PiArICAgICAgICBnb3RvIGVuZDsvLyBGYXN0cGF0aCBmb3Igb25seSBv
bmUgQ1BVLg0KPj4gDQo+PiAgICBydHAtPm5faXBpcyArPSBjcHVtYXNrX3dlaWdodChjcHVfb25s
aW5lX21hc2spOw0KPj4gLSAgICBzY2hlZHVsZV9vbl9lYWNoX2NwdShyY3VfdGFza3NfYmVfcnVk
ZSk7DQo+PiArICAgIGZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7DQo+PiArICAgICAgICB3b3Jr
ID0gcGVyX2NwdV9wdHIoJnJ1ZGVfd29yaywgY3B1KTsNCj4+ICsgICAgICAgIElOSVRfV09SSyh3
b3JrLCByY3VfdGFza3NfYmVfcnVkZSk7DQo+PiArICAgICAgICBzY2hlZHVsZV93b3JrX29uKGNw
dSwgd29yayk7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZm9yX2VhY2hfb25saW5lX2NwdShj
cHUpDQo+PiArICAgICAgICBmbHVzaF93b3JrKHBlcl9jcHVfcHRyKCZydWRlX3dvcmssIGNwdSkp
Ow0KPj4gKw0KPj4gK2VuZDoNCj4+ICsgICAgY3B1c19yZWFkX3VubG9jaygpOw0KPj4gfQ0KPj4g
DQo+PiB2b2lkIGNhbGxfcmN1X3Rhc2tzX3J1ZGUoc3RydWN0IHJjdV9oZWFkICpyaHAsIHJjdV9j
YWxsYmFja190IGZ1bmMpOw0KPj4gLS0gDQo+PiAyLjI1LjENCj4+IA0K
