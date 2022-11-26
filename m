Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90F863940B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKZFwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:52:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931E4FF8D;
        Fri, 25 Nov 2022 21:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669441931; x=1700977931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NGvrDAMPuDtIFbYwzlnQCb6wiy+m5o6gx3U0rXv8Q+k=;
  b=ULipWivHdVHKA3Pb9raWLVrMOIpamU5tXxK0wURmxKUqjZpdlBQgT5kl
   c56VCExYqsOuEIHAthdzpfZZD85+4DoLRARE/4Wmw1EBR7JN7LnG2DINu
   HXLJ200cmOR3DU0tUG9ge05UHKwaYQakFDTocCPGnTm/eZ02CyWodyB7Y
   iQaY1HxFUFX2d3Sx4LAKRvnSx4qAoDL/JlFuyItwlrkNZNAMYYZ4H/bHz
   jx22Zl7FDBOVASDhJuN+bDCdjPRTAPIx2Njh0r9AZmI9a7Mj9QmDmen/B
   tSgwLH2zwp3v+U0dEuThldU8LU0wLTHLdEqU4az+mwPcoTlMQtKRol2z3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="294279256"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="294279256"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 21:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="767534563"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="767534563"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2022 21:52:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 25 Nov 2022 21:52:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 25 Nov 2022 21:52:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 25 Nov 2022 21:52:10 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 25 Nov 2022 21:52:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeIKnJzYtHowM+aNYhPlpHfiTxX9HKcX4uOglHEvQ0g3lZo4hD6SuOb34cusvBlC1vcuKwefa9zF6Ypo8YLCRILOj1Cdv/D4c4RXQi0WZKMFa1/nVGg5RCEnzIC0ZDquNeqef3+ZLfV3vfN/e7dpPBJgpcuDA86xFsyE2IsAIUj31G4+MJrnZ70N4Oo81JOCo9mqUturwVKvJPLPeTbqh/X6aZ+mtbTS9ZQx0398fcf1ag3WUknu5RhmgUSPTWttHcduyfiX24Z/jjuFbcEXSQqXQUqJEzuZpcUesCvHlx51xGacXz+WdCGxK0RD4lBUTZ3qj6Vf01biDxlDRBnVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGvrDAMPuDtIFbYwzlnQCb6wiy+m5o6gx3U0rXv8Q+k=;
 b=oIDjiLnIm94g1ky8ia3N01FGycD3cYhbEWUtfpnZRHEReiP9NI3Xn1FvBuBhDQVc7daj6MC/w5otIy0p2AO2mckw7G1ViUdWSfzyxC4OrANY1abaw7espuZ91jrujYR8Wz/qclhCub7CxApLYm8y7yNKs3lPzVAHmdh4VgjzYRNuJdPPMU0zn/Yl4xHTN2g/3wiSHAcWqv6qY8Grz6lMa1KVVvRBguwlf2hxQ6Qz5rVBEa9t6D9+kXeTand+nTu3oBjK2z0FD1daIgtpa0NTGiDufPARSmR4ztAuulnNWIoacQhIYH8ydwX0kJMBuqKJb2VWT3BUVMTT4Tgd8KykNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 05:52:08 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%5]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 05:52:07 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Thread-Topic: [PATCH] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZAOVqO+x1XL1ptUSqdc8Q343Nzq5Qq6MAgAABXYA=
Date:   Sat, 26 Nov 2022 05:52:07 +0000
Message-ID: <PH0PR11MB58804E24C3C14371F4397D68DA119@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221125155427.1381933-1-qiang1.zhang@intel.com>
 <cf3fad42-0ab5-dae7-7954-8d7af80d20ac@quicinc.com>
In-Reply-To: <cf3fad42-0ab5-dae7-7954-8d7af80d20ac@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MN0PR11MB6302:EE_
x-ms-office365-filtering-correlation-id: 277f1d1a-ad73-483d-7bfc-08dacf725a82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6NIZM8eZTYoDAD4Z05T0W30oPVtA5VUWH18siJ9MpAX5BCevcxs68JVtOPFbOIBjlvrE+wWi5Htgacy7EvAaF6Q3x/g03OeXA4Rrxw2NNBLBvaBAlyxEHmtmDnjNxtzydUUpt+o0nlQfzjrNktjU3Snq6qxNlbtE+3xXk4aoSVCA/itl81kv1zNlOexhflEsfNOGT2OYj0J5yRo8ZiRmyEAMQv47fVUNucFa+V/s85I5sBj1Z0LoDL9SiVADbo/NPOCY1sXQkKepaTRY31U8ZS4L9vCCbGX0gJaNbdL21sT0tzeeWzfy3a8C8qiDa45LmC2Rx1cjpyrOKYU8nIXVCnS7Y8x0ogU0Vl5C2Ivx0ac/GQjrWHlev9Zd/hDizj6J/ncdwx1HPr7N2lJ3OR5uHiZ6xvoY0PhYd0iE97Z95RhWTm6oYkBrv8wUONYkF8p2gjFYj+dyyagUARb/Al3IpXrnVNgDnHUNePIb80KDcB/OBx0prKTz1aSweph9lQhbpjvLYhLXAHHkipuLW59MYitw/Nbtp55ihTW+/tEnejwOHoSgAb9MouQ1f14WRnIHYvQ8Hd9KO5F3h2M1cu6z1BzH3+9YP1kMXqKGW6GVdwei4urXxFSXWQrr88ZNaCRXBNNW63XuPMVtw99XnilROxMogtCFZK+RJx9KTOPWG+/ZllLDVsIocCR1CMeLenBG50gMFqt0tg54i1lm6OZdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(86362001)(33656002)(8936002)(55016003)(2906002)(5660300002)(52536014)(7696005)(9686003)(6506007)(71200400001)(122000001)(26005)(83380400001)(186003)(316002)(54906003)(110136005)(8676002)(4326008)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBicVo5aU84MUd5b01wbEUvMzJwelc5cmREdHUxUFZHM0Y2TG1mWkFvakIx?=
 =?utf-8?B?QzliMFlsaGZwY1NTY2N1S1FnZERsajl5cVlranBKTzRWdjllTWlaVFNuOHlM?=
 =?utf-8?B?R3lvbjBCZ0w5azNaSXNyb25XSml2WERLQVBXTys3MVRjcDEwQURCL2hDVGo5?=
 =?utf-8?B?N044bC8rV1k1YS96RmR2NDQrSStPVHpBazM3eDBGNloway9Eai9vSVRmancv?=
 =?utf-8?B?U0JTbkxxQUd6dE8wMEF5U0dVRk92T3Z4bXJDRmU5V2hiMG5sa2ZaNW5nSlJY?=
 =?utf-8?B?cGRzNXBheDNpRG1nTWtXZnBNKy9vNjlWcTUxMDM0ZmlTZkM5aTBsZWFBUDd3?=
 =?utf-8?B?anMzb013VDFNd2E0eGJHRitlcElIdTF5UmhsczRWTzhXbytOWTZ4K1duVUJo?=
 =?utf-8?B?WmtPaVhuWFdpYTUwVkNNckc0RTFoMm4wNUx1NEJiWS9wcFhjVUR5M21lbDZM?=
 =?utf-8?B?Vk5XdENDRUNyQUJMMnpZVVpjTTRCa0NCdTJCdStmRzhGZFQza2ZZNWxPWHdo?=
 =?utf-8?B?cEt1OTZDQUtRSzBpbWtqQ0RscHFlSmJtK2VHc0Y5WXZVU3JNbC8zaStoT2Ix?=
 =?utf-8?B?Sm82MG9SWm9GdDhlNE1teVVkdWt3OEFwOWg3RytEdXdITjUvUElmVmUrTnZW?=
 =?utf-8?B?MXdpMjN6dVFsMGhTZ3BxUVQzUzBva0d4N0VEUVZwbkZkSmhzakNnaWlIdTBB?=
 =?utf-8?B?SWp2N2l5L2VtVCtoWXdkUDVzL1VDeTdsS0tUWGpSYkM0eFNwWlQ5MWxpM0JW?=
 =?utf-8?B?SzgyM2EzUmtRMWdmSm9HTFpENW1OZDk5U014OW9TbkZIQnJLQWNTTTE4bkEr?=
 =?utf-8?B?amVBeDdHelVDQWRCWVRsc1d3NXVGNVU3aUhJci9meU5jaDM1RDcvYXBScE1X?=
 =?utf-8?B?Wm9XS1NlMmRpZ2FCbGVPK25IazkvdGxwU2E3ZnBuMGNOYnUrNVpvWFhRQ2U0?=
 =?utf-8?B?MnA5RnAxWE5qOGlrSTQwNkQvL2FhM0ZUcWtxVkV5TDlqbE1Tb3F0blR2S2U4?=
 =?utf-8?B?dDE0eTQ5Z0xsTXNrbXhrVDhuUHJhT1Y1aWpXb3VERVdlUzNVdUF2SncramFY?=
 =?utf-8?B?RU1laTNSYlQ3VGtiRWFuSnpGbHh5aDR6UEFFUktRNVRhemphNEVLMkYzMW42?=
 =?utf-8?B?cFE2MHVkSHAwNEZzTnN5Ly9uUC9EQzdRdU5YREd0dUdaSU9meS9sMysydDlE?=
 =?utf-8?B?Ry9UWmg4bVpXUUZqekpkQ0hydVRNZE5tVnhmU0dlS21FM2JnUFNsRXpOV0hO?=
 =?utf-8?B?UExhb0psZk0wODdxZURiVXZCQ3Rtajh0UUlvWmJKMzF3RXBjNndlL2lEeWtF?=
 =?utf-8?B?QWhSL3d0S2c3MDVzZ0pOeUpETUF1SUo2N0hoN3oyeU1lS0d6bURjN05Ea0lq?=
 =?utf-8?B?SE11MWliM1lqZTFOeDk0VzhPZ0Q1dmp3U21iZWZRNTJzS1YwUkVYcnhGT3ZW?=
 =?utf-8?B?ZzAvT0JhWnVJUm5iaExsOC9ER3F4cDNwSlJBYjFQYTNiQ1pZL3dQc2tjZExH?=
 =?utf-8?B?S1BDVXhjaStXR05vYXFTeWZWbzlkRy9LZjNoMjBnMXJ4WEZ5QkFnUDlhd3Mx?=
 =?utf-8?B?WGUwVktuUGNVMG1CSFRIcEoxU015VkFPZ3FNeHZXdXU4RlNyZ3BnY0JwM08r?=
 =?utf-8?B?NllIaUlPMkVaRStwMHZUckd3YW1GQVhKV21iK3gxZ2xMbjRLRCt2R1BIRVZF?=
 =?utf-8?B?dlQxTVZvNlpUYnZYeXZTQXIxWmFTY2h1ZVc2M0s0MHd3OWRkY3M3YUR0WTJo?=
 =?utf-8?B?M0NXdnlRL0RJT1N6dG5PSDlySndGcXB0a2JXTllJbUZ3THkvVXVvUlp3RTB2?=
 =?utf-8?B?VnhJd1ZOT08xYllHUVM1V0lPc2krVmZyd010UTFqZGRxKzBjb012c1hldlRp?=
 =?utf-8?B?clF3aERITWc1YnRyNm5qSFdweVRGQzdKcnRtZ0I5QkMyKzNqY1NCOTdmOTBj?=
 =?utf-8?B?UWo2QUsrb040aUZHQXJuN2duV21CRXI2LzNabXJ4ZXY3cDhkbzZrU1dJazZo?=
 =?utf-8?B?UURvdGNQWFFzdFBEQ1ZhNGY5Kzd1K1ZVeUY3cWNoSjB2a0lNMjVMU1lXQVh2?=
 =?utf-8?B?enJDTDUrNmJ5RUw0L3o4UnBnSDlISmZodmVUS2VzZVpVWjdjU3pFUHRzZGFS?=
 =?utf-8?Q?Wya7GOoe0EXyTnDgBhXaNRU7o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277f1d1a-ad73-483d-7bfc-08dacf725a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 05:52:07.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OILaAo6FzLOnsnc+TknoMbDg4bcg1bHxegJe4h0+Ae34bROd69Mn37oMNBHgoukzNyfN6pNeZk8U9wgkj+9e3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpIFpxaWFuZywNCj4NCj5PbiAxMS8yNS8yMDIyIDk6MjQgUE0sIFpxaWFuZyB3cm90ZToNCj4g
Q3VycmVudGx5LCBmb3IgdGhlIGNhc2Ugb2YgbnVtX29ubGluZV9jcHVzKCkgPD0gMSwgcmV0dXJu
IGRpcmVjdGx5LA0KPiBpbmRpY2F0ZXMgdGhlIGVuZCBvZiBjdXJyZW50IGdyYWNlIHBlcmlvZCBh
bmQgdGhlbiByZWxlYXNlIG9sZCBkYXRhLg0KPiBpdCdzIG5vdCBhY2N1cmF0ZSwgZm9yIFNNUCBz
eXN0ZW0sIHdoZW4gbnVtX29ubGluZV9jcHVzKCkgaXMgZXF1YWwNCj4gb25lLCBtYXliZSBhbm90
aGVyIGNwdSB0aGF0IGluIG9mZmxpbmUgcHJvY2VzcyhhZnRlciBpbnZva2UNCj4gX19jcHVfZGlz
YWJsZSgpKSBpcyBzdGlsbCBpbiB0aGUgcnVkZSBSQ1UtVGFza3MgY3JpdGljYWwgc2VjdGlvbg0K
PiBob2xkaW5nIHRoZSBvbGQgZGF0YSwgdGhpcyBsZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uLg0K
PiANCj4NCj4NCj5XYXMgdGhpcyByYWNlIHNlZW4gaW4geW91ciB0ZXN0aW5nPyBGb3IgdGhlIG91
dGdvaW5nIENQVSwgb25jZSB0aGF0DQo+Q1BVIG1hcmtzIGl0c2VsZiBvZmZsaW5lIChhbmQgZGVj
cmVtZW50cyBfX251bV9vbmxpbmVfY3B1cyksIGRvIHdlDQo+aGF2ZSB0cmFjaW5nIGFjdGl2ZSBv
biB0aGF0IENQVSwgYW5kIHN5bmNocm9uaXplX3JjdV90YXNrc19ydWRlKCkNCj5ub3Qgd2FpdGlu
ZyBmb3IgaXQgY291bGQgcG90ZW50aWFsbHkgbGVhZCB0byBtZW1vcnkgY29ycnVwdGlvbj8NCg0K
SGkgTmVlcmFqDQoNCkluZGVlZCwgSSBkaWRuJ3Qgc2VlIHJhY2UgaW4gdGhlIGFjdHVhbCBwcm9k
dWN0aW9uIGVudmlyb25tZW50LA0KTWF5YmUgbXkgY29tbWl0IGluZm9ybWF0aW9uIGRlc2NyaXB0
aW9uIGlzIG5vdCBhY2N1cmF0ZSBlbm91Z2gsDQpsaWtlIHRoZSBzY2VuZSBJIGRlc2NyaWJlZCB3
aXRoIGpvZWwuDQoNCklmIGluIGNwdWhwX2ludm9rZV9jYWxsYmFjaywgc29tZSBjYWxsYmFjayBp
cyBpbiBydWRlIHJjdS10YXNrcyByZWFkIGN0cmljYWwgc2VjdGlvbiwNCmFuZCBzdGlsbCBob2xk
aW5nIG9sZCBkYXRhLCBidXQgaW4gdGhpcyB0aW1lLCBzeW5jaHJvbml6ZV9yY3VfdGFza3NfcnVk
ZSgpIG5vdCB3YWl0aW5nLA0KYW5kIHJlbGVhc2Ugb2xkIGRhdGEuDQoNClN1cHBvc2UgdGhlIHN5
c3RlbSBoYXMgdHdvIGNwdXMNCg0KCUNQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxDQoJCQkJCSAgICAgY3B1
X3N0b3BwZXJfdGhyZWFkDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFrZV9jcHVfZG93bg0K
CQkJCQkJICAgIF9fY3B1X2Rpc2FibGUNCgkJCQkJCQlkZWMgX19udW1fb25saW5lX2NwdXMgDQog
cmN1X3Rhc2tzX3J1ZGVfd2FpdF9ncCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1aHBfaW52b2tlX2NhbGxiYWNrICANCgludW1fb25saW5lX2NwdXMoKSA9PSAxDQoJCXJl
dHVybjsNCiAgICAgICAgDQp3aGVuIF9fbnVtX29ubGluZV9jcHVzID09IDEsIHRoZSBDUFUxIG5v
dCBjb21wbGV0ZWx5IG9mZmxpbmUuDQoNCg0KPg0KPkFzIHBlciBteSB1bmRlcnN0YW5kaW5nLCBn
aXZlbiB0aGF0IG91dGdvaW5nL2luY29taW5nIENQVSANCj5kZWNyZW1lbnRzL2luY3JlbWVudHMg
dGhlIF9fbnVtX29ubGluZV9jcHVzIHZhbHVlLCBhbmQgbnVtX29ubGluZV9jcHVzKCkNCj5pcyBh
IHBsYWluIHJlYWQsIHByb2JsZW0gY291bGQgaGFwcGVuIHdoZW4gdGhlIGluY29taW5nIENQVSB1
cGRhdGVzIHRoZQ0KPl9fbnVtX29ubGluZV9jcHVzICB2YWx1ZSwgaG93ZXZlciwgcmN1X3Rhc2tz
X3J1ZGVfd2FpdF9ncCgpJ3MgDQo+bnVtX29ubGluZV9jcHVzKCkgY2FsbCBkaWRuJ3Qgb2JzZXJ2
ZSB0aGUgaW5jcmVtZW50LiBTbywgDQo+Y3B1c19yZWFkX2xvY2svdW5sb2NrKCkgc2VlbXMgdG8g
YmUgcmVxdWlyZWQgdG8gaGFuZGxlIHRoaXMgY2FzZS4NCg0KWWVzLCB0aGUgc2FtZSBwcm9ibGVt
IHdpbGwgYmUgZW5jb3VudGVyZWQgd2hlbiBnb2luZyBvbmxpbmUsIGR1ZSB0bw0KYWNjZXNzICBf
X251bV9vbmxpbmVfY3B1cyAgdGhhdCBpcyBub3QgcHJvdGVjdGVkIGJ5IGNwdXNfcmVhZF9sb2Nr
L3VubG9jaygpIA0KaW4gcmN1X3Rhc2tzX3J1ZGVfd2FpdF9ncCgpLg0KDQpEbyBJIG5lZWQgdG8g
Y2hhbmdlIHRoZSBjb21taXQgaW5mb3JtYXRpb24gdG8gc2VuZCB2Mj8NCg0KVGhhbmtzDQpacWlh
bmcNCg0KPg0KPg0KPlRoYW5rcw0KPk5lZXJhag0KPg0KPiBUaGVyZWZvcmUsIHRoaXMgY29tbWl0
IGFkZCBjcHVzX3JlYWRfbG9jay91bmxvY2soKSBiZWZvcmUgZXhlY3V0aW5nDQo+IG51bV9vbmxp
bmVfY3B1cygpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50
ZWwuY29tPg0KPiAtLS0NCj4gICBrZXJuZWwvcmN1L3Rhc2tzLmggfCAyMCArKysrKysrKysrKysr
KysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdGFza3MuaCBiL2tlcm5lbC9yY3Uv
dGFza3MuaA0KPiBpbmRleCA0YTk5MTMxMWJlOWIuLjA4ZTcyYzY0NjJkOCAxMDA2NDQNCj4gLS0t
IGEva2VybmVsL3JjdS90YXNrcy5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdGFza3MuaA0KPiBAQCAt
MTAzMywxNCArMTAzMywzMCBAQCBzdGF0aWMgdm9pZCByY3VfdGFza3NfYmVfcnVkZShzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspDQo+ICAgew0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBERUZJTkVf
UEVSX0NQVShzdHJ1Y3Qgd29ya19zdHJ1Y3QsIHJ1ZGVfd29yayk7DQo+ICsNCj4gICAvLyBXYWl0
IGZvciBvbmUgcnVkZSBSQ1UtdGFza3MgZ3JhY2UgcGVyaW9kLg0KPiAgIHN0YXRpYyB2b2lkIHJj
dV90YXNrc19ydWRlX3dhaXRfZ3Aoc3RydWN0IHJjdV90YXNrcyAqcnRwKQ0KPiAgIHsNCj4gKwlp
bnQgY3B1Ow0KPiArCXN0cnVjdCB3b3JrX3N0cnVjdCAqd29yazsNCj4gKw0KPiArCWNwdXNfcmVh
ZF9sb2NrKCk7DQo+ICAgCWlmIChudW1fb25saW5lX2NwdXMoKSA8PSAxKQ0KPiAtCQlyZXR1cm47
CS8vIEZhc3RwYXRoIGZvciBvbmx5IG9uZSBDUFUuDQo+ICsJCWdvdG8gZW5kOy8vIEZhc3RwYXRo
IGZvciBvbmx5IG9uZSBDUFUuDQo+ICAgDQo+ICAgCXJ0cC0+bl9pcGlzICs9IGNwdW1hc2tfd2Vp
Z2h0KGNwdV9vbmxpbmVfbWFzaykgPiAtCXNjaGVkdWxlX29uX2VhY2hfY3B1KHJjdV90YXNrc19i
ZV9ydWRlKTsNCj4gKwlmb3JfZWFjaF9vbmxpbmVfY3B1KGNwdSkgew0KPiArCQl3b3JrID0gcGVy
X2NwdV9wdHIoJnJ1ZGVfd29yaywgY3B1KTsNCj4gKwkJSU5JVF9XT1JLKHdvcmssIHJjdV90YXNr
c19iZV9ydWRlKTsNCj4gKwkJc2NoZWR1bGVfd29ya19vbihjcHUsIHdvcmspOw0KPiArCX0NCj4g
Kw0KPiArCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQ0KPiArCQlmbHVzaF93b3JrKHBlcl9jcHVf
cHRyKCZydWRlX3dvcmssIGNwdSkpOw0KPiArDQo+ICtlbmQ6DQo+ICsJY3B1c19yZWFkX3VubG9j
aygpOw0KPiAgIH0NCj4gICANCj4gICB2b2lkIGNhbGxfcmN1X3Rhc2tzX3J1ZGUoc3RydWN0IHJj
dV9oZWFkICpyaHAsIHJjdV9jYWxsYmFja190IGZ1bmMpOw0K
