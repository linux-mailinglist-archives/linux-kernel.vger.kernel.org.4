Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26F688C66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBCBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBCBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:20:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10B474A54;
        Thu,  2 Feb 2023 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675387223; x=1706923223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aoSkM4TwQ923H6kX/0QMlzJjm6qAKoHvPVzjdMSZnO0=;
  b=CDK+1ZhybgMqNLf3cmTI02VvLeemW9b+3+uCMTAjD4rvrzUWBaU4tT4c
   UJYNKACLOSKBobYtjwxVnTMogkbKR7y59zjhd/xYJpzU3858xF1Bk4Kc/
   D08ZqLDgnrZ+ct8jIHpw+GhznzSuUi8yZAY+MzBolLZ977aU/5tlG2Jap
   Uj9zzO/+MpkuFo6YXAn2AB6rreVRCr44yoaP0BCFBaXJBtVbgdY7cW9+S
   VXkmx5Kz61Pb/FJdyM0A+X3mWxK+JZxL+uCcKwpuokH4se5PwNszAL2rJ
   0B2zUOHNPjLYD3Di/W49WRlGmqUpaRmiHpJ4o+nlkY72JIQ45P8C/L48h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330755963"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="330755963"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="667491971"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="667491971"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2023 17:20:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 17:20:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 17:20:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 17:20:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 17:20:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJQt5yMoN4mZ4YClFWOfNa6xMGNiH1IuGUFj1Z4cU21LnQt6KAi4HKMZYr0YdM/mfzsR/EQ0snbB2uK7IyJM1ieXuK/uutN4fODPeM3eVp0wAmZHuIGFsH4GgRu3HP/m0bQcl1aLASx7TQ6RDHXSnOOTW9EXAcKL5vXDK5GcRMIzMO1nIyddrS/MxTFYThZRVkaWeSr144aM9JU1VM47HACS30AmKOtfdqqLSVTGqk5QrZqS57zNrM5Xy3W49oPSlNzgUuhmp6Xp84EWB9629hREh22VHXMQ+rfTUnqf3IaVvTkocZnWeLePx+WsC+V8ReTisQhJOTGCRJQ4bJI1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoSkM4TwQ923H6kX/0QMlzJjm6qAKoHvPVzjdMSZnO0=;
 b=TcEIcEIP2sdA+Z/t7e1o+idsbr3mBehM6THup8qp1g2B//jTxAl7itX3zDfjafrviUYXre+Oj3H+cBtnqXGM5mXPuuKveQEPE7qa1278Salk5Os9dvRFiU1RXfsyerJxSiyYr2pJfnZ+ZZK04PscrVvfuBJo/Ay9kjgO0vrkcBZb2EZenq0BjFwwLanjYsSoKzPHdunB7RlrfQ8b/GGQ/vgANbxJqOiIWSTNkDJEMBfXr1Vy9rNUbl9+SRLDvZmBbFpgDVjlq1KQQZdRvsMPkMicNSe9xCwXtywwTWOt5wDade8yc1wFDyb2khp5qbXObDK0TrHgkGeMCZlK46VFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 01:20:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 01:20:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Topic: [PATCH v2] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Index: AQHZNtOvEEHhGCrEsUyuR7d5liKV4a67xByAgABlZZCAAA+DgIAAL+2Q
Date:   Fri, 3 Feb 2023 01:20:16 +0000
Message-ID: <PH0PR11MB58801CC64A8D2B8AEA37377EDAD79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230202070245.3311951-1-qiang1.zhang@intel.com>
 <7959A7ED-A47F-4472-9278-8582F1CCC6A9@joelfernandes.org>
 <PH0PR11MB5880DF541BB1D75E0DFC02FEDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YRSEu=O7FW=T5fOAWcRbejQUXVN+RoGcTN+xkd7xmJepA@mail.gmail.com>
In-Reply-To: <CAEXW_YRSEu=O7FW=T5fOAWcRbejQUXVN+RoGcTN+xkd7xmJepA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CY5PR11MB6161:EE_
x-ms-office365-filtering-correlation-id: 139190ed-582a-422d-05da-08db0584cea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m9CxE5celpQerOyiG/MkiOihFsmc2iETgr9lu1uHz6559ruPW7ZJWzE47O601JNKSsIzrdhHdTT6drwmpY7fr8RnpMlFaemFbhv59ksz72io13YIrh7O2YNbhAituddSByzt1peGQzpDymweYyOrvL6JxElQR0aPTrLtrF7/KIf9NieQQ8ZBUqjS+qyDcROFEE0CNK9NRYbts5X8+R18kG0wwtL8ll5Ad2nH7ixXdGkjvqaBKAB7vJDAwUGGkc8i9qJb5GoSS0bUl6Dq3pmuWCJHc2U3s2tOUkUPRMS5BhvFxz1bP6IiDKSPfCw91L3pfPTGGLLPKTSdk/PwaNVtmNtbCBnJRdc40jOluGuhdpd/NJjLV46V5MHalWiu+3yGXFekOuTz2fOSH7aapSm8Z0rRtX0NcbkQgwfiryatW2quQpDJc20b2WhEaQ8Fbo0aAqoRuvoYRr7dzXmxayDctK6Kd7pcRbiZUIVSWvWneOvUqGBwo0STFGze7CppcXF4Wzh65LByXqu7nPJId3Ww1ZFKmxOjPWresVaF7vuWJU112ThL+g8dd1hzNCzXS243Aso4aFvqCj/mD+MsrqXI4dY4/K7lFMpTCRmMn8EGEx0I9ycd3gzw1PURjoEQzpkP1h+j5eDZxECi08H9VEsfyb3srfz0svtRS4SFXEBAfN+OSmUSHfnD9CekiyZAH21q1RxvrZy33w3u3neNsUNtew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(478600001)(9686003)(83380400001)(38070700005)(33656002)(86362001)(55016003)(122000001)(38100700002)(6506007)(82960400001)(53546011)(26005)(186003)(8936002)(52536014)(41300700001)(2906002)(5660300002)(54906003)(8676002)(71200400001)(7696005)(76116006)(6916009)(4326008)(66556008)(66946007)(66476007)(64756008)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzFnWUNyNjdxOHJTOForM1JydE5ibytjSUd0OStjeDQwK01NSURBWVE5TVB6?=
 =?utf-8?B?TlZSYlhFNDU5RllNYmFTdUthcWpLVmxsblhaQVJoU3NyUlE4QXdEMUcyTXdN?=
 =?utf-8?B?T1B5SGp5NStzVXZYMGdmdjZGdVBnbXk4ZEh6cGQyMFZBc3VsZ2xNd2VDeHU2?=
 =?utf-8?B?ZzRwRVhxVVBMS3RZeGZEQlM4Z1lONlFZcVg3OTFYbEZYbCtpT0ZqUTFzZEZK?=
 =?utf-8?B?N3JOQldrUzBLZ3diSDU3VzVpMlRKVTdtUTlpZ0VtUmkyTFFlbGtDTlhkbXBL?=
 =?utf-8?B?TVRSVHcyUHR0SHpjWkxjWDRHL2hxS3F6SkNSTUVwTkFUVmZSbldvaldMZm4w?=
 =?utf-8?B?N2crOFBLNElneTltTmYvdGZic1FmeHZ2cGVZQ2ZGV05sTW9Md3hnV0p3bWRz?=
 =?utf-8?B?dGdrdCtkSEYyK24xOFdtOCtaQ3hNQ3ZvNklCQnRlZm1VSGl6bmRWck5iekUz?=
 =?utf-8?B?T1JSbjV4d2hDKzdnMFRuTmttc0JVUnUzZGluYW8xNSthenAvclVvUlRGUXEr?=
 =?utf-8?B?ODlnZzlERUxKOE42QjM3aGo4aGNiRDQ3QW90Z1dqeGVUcXBDZ21lTG14Nlc5?=
 =?utf-8?B?NjU3NG1hTUNRdnUzNXpTREt3K1RoTHEzUU5FTXdTQWVJb3dvNVBETm8xTWJX?=
 =?utf-8?B?SFhHOWIranIzZDBVcDk3WVhuR24vWWFxOFZ2WW1NK3hMQnRZL2dtSys2Tnlm?=
 =?utf-8?B?K3JRK1JCZmN4OThPRUkwK2lkOHpOS3hOQ2JXdXlOT1hGY3dXRzM0WlJROHR0?=
 =?utf-8?B?cjBSM2pLUC9TY3MwRjRHNnV2M3I1VE9CNUxHTWhLQndZRHl4ZnU0R0J2NEFj?=
 =?utf-8?B?aUIxOC9Zc1R2ellGejdWL21JdXQ1WnhsSzhhWEVFbU5qMHFYWWkwOHFZSjF6?=
 =?utf-8?B?bzFMZHhOYUNoeVZQUTlJVDdhR0V2RnNOR296WmZScWdnYVJWSlVZNEN6OERp?=
 =?utf-8?B?VzI2MGhKS25NWHJRZDROUTc0N0tpMzlkcHlGdTZ6V0E4a3NsNUxyWDVKeE00?=
 =?utf-8?B?OGRUeW5RMDJiOUQ5dkxCeENrSEVBblV6WENNODBxMitna3R2WG5kV1hIMXJG?=
 =?utf-8?B?c1BvWnVwa3p2ZE5kaGQ5N2p2RU9YTnk3ajVwdWlwRDBCaWlKUENkZTdmNm5M?=
 =?utf-8?B?WEozbkgxaFdqcXVIdnVhYUhvNEYzWEZSS2RIY0ZwVUZ3UXJtVDBUUUVZbHlm?=
 =?utf-8?B?ZDJ1aWtMUko1bm1FclF1MGlYWGpYZ0ZSQnJtUDZSSjI2SkY1RGxkMVVzcnhQ?=
 =?utf-8?B?ZU9wVTlFTS9nOXRQdm1lelpaa1RjdEVPaGF5UmEvdHduUVl6SzVnYXM0ZDVY?=
 =?utf-8?B?ZkE4RDlEZGV2ak9sNnRkbmZsRVdtSnNXcFVtSVpwOXRkb0pjS21XS0ZIYVpw?=
 =?utf-8?B?QWord2M2UFlPMzJGUUdzajh2RG92VWIyQXJxUEwrOFp2ZU15RXErcW9ldlpU?=
 =?utf-8?B?R1k0eVVBKzRsSWpES1QxR1BuQzlCTHU0RVVnS1pXM1ZTZUYwV0hLL1BxUVpS?=
 =?utf-8?B?S21CbmF3a2IvVGVLL1ZXSnR5cWVvV3RPcWZUbkhaNDBsRlltV3F2Nis4WldJ?=
 =?utf-8?B?SnA0eXhqSjY2dU45NWQyLzZ4NmZGbVJqSDVtY1FCcHBJWVRQZDhiSU1UWkYy?=
 =?utf-8?B?SmFKbFFpamF6K1NFalBYYlJkU3NhRitYWDBXNG02VUJQUFRtL04vZ2ZyYmhX?=
 =?utf-8?B?ZTJIU1FLSXo2ZDMwMmtXaGJuS0t1RmFKaVU2SGdwVThid3hXdTEvZEp1cVZ6?=
 =?utf-8?B?OXkrTFVSUUdwajR5VHd2dm03S2Rwa01ZRDkwSGRpaitMdGo3aXFDRi8xbjZi?=
 =?utf-8?B?RGNkc2NSNnhOdjlWN1pzcDc3Yk1Zdnh0Z3JLSjlhSDU5Z3VWYzQvVURBYWdy?=
 =?utf-8?B?bDdON0FkVXVsNDNUdXQwNXJZVEpCQ05jaEw5R0pRSFZsNFZuTEhrdmN1TUhY?=
 =?utf-8?B?bDlBMFZKa1hoQnZoOTU4YzhEWWw3Q1dlcmxaZVFFMzBDV3dqYWdhTmZ4Z0RY?=
 =?utf-8?B?REtFbDVlUkE0QmZIeFpvQTh4L0xuZ1FBMWplSDBnY3EvZURPak5kUVFPa0pj?=
 =?utf-8?B?NVQ3Z20veWFSSStvVE15YkE3aFM5Ym5TN005WllJVk1wMDZXMUNnQ0E1ZnJI?=
 =?utf-8?Q?ktFpt51KHJqLW73yYmJdDfbB7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139190ed-582a-422d-05da-08db0584cea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 01:20:16.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KyS0nMpTcnmOam57LH0tcDi2ozkmYm/3MXWbPJ17YtzPdmYxHJBdP0NyLPbF4NXTFaztZDhG6LvIzwrreJj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+DQo+DQo+ID4gT24gRmViIDIsIDIwMjMsIGF0IDE6NTcgQU0sIFpxaWFuZyA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiDvu79XaGVuIHNldHRpbmcgbm9jYnNfbnRo
cmVhZHMgdG8gc3RhcnQgcmN1dG9ydHVyZSB0ZXN0IHdpdGggYSBub24temVybyB2YWx1ZSwNCj4g
PiB0aGUgbm9jYiB0YXNrcyB3aWxsIGJlIGNyZWF0ZWQgYW5kIGludm9rZSByY3Vfbm9jYl9jcHVf
b2ZmbG9hZC9kZW9mZmxvYWQoKQ0KPiA+IHRvIHRvZ2dsZSBDUFUncyBjYWxsYmFjay1vZmZsb2Fk
IHN0YXRlLCBidXQgZm9yIENPTkZJR19SQ1VfTk9DQl9DUFU9bg0KPiA+IGtlcm5lbCwgdGhlIHJj
dV9ub2NiX2NwdV9vZmZsb2FkL2Rlb2ZmbG9hZCgpIGlzIGEgbm8tb3AgYW5kIHRoaXMgaXMgYWxz
bw0KPiA+IG1lYW5pbmdsZXNzIGZvciB0b3J0dXJlX3R5cGUgaXMgbm9uLXJjdS4NCj4gPg0KPiA+
IFRoaXMgY29tbWl0IHRoZXJlZm9yZSBhZGQgbWVtYmVyIGNhbl9ub2Nic190b2dnbGUgdG8gcmN1
X3RvcnR1cmVfb3BzDQo+ID4gc3RydWN0dXJlIHRvIGF2b2lkIHVubmVjZXNzYXJ5IG5vY2IgdGFz
a3MgY3JlYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFu
Z0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4ga2VybmVsL3JjdS9yY3V0b3J0dXJlLmMgfCAxMCAr
KysrKysrKy0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+U29ycnkgaWYgSSBhbSBtaXNzaW5nIHNvbWV0aGluZyBidXQgd2hhdCBp
cyB0aGUgcG9pbnQgb2YgYWRkaW5nIG1vcmUgbGluZXMgb2YgY29kZSBhbmQgY29tcGxleGl0eSB0
byBoYW5kbGUgdGhpcz8gRG9lcyBpdCBpbXByb3ZlIHRoZSB0ZXN0IGNvdmVyYWdlIG9yIHJlZHVj
ZSBvdmVyaGVhZD8NCj4gPg0KPiA+VGhpcyBpcyB0ZXN0IGNvZGUuIEkgc2VlIG5vIHByb2JsZW0g
d2l0aCBjb3N0IG9mIGFuIGV4dHJhIHVudXNlZCB0YXNrIHdpdGggcG9zaXRpdmUgdHJhZGUgb2Zm
IG9mIGtlZXBpbmcgdGhlIGNvZGUgc2ltcGxl4oCmDQo+DQo+IEZvciBub2Nic19udGhyZWFkcyBp
cyBub24temVybyBhbmQgQ09ORklHX1JDVV9OT0NCX0NQVT1uIGtlcm5lbHMsDQo+IHRoZSByY3Vf
bm9jYl9jcHVfb2ZmbG9hZC9kZW9mZmxvYWQoKSBpcyBhIG5vLW9wLCAgd2UgY3JlYXRlIG5vY2Jz
X250aHJlYWRzDQo+IGt0aHJlYWRzIGFuZCBwZXJmb3JtIG5vY2IgdG9nZ2xlIHRlc3RzIHBlcmlv
ZGljYWxseSwgd2hpY2ggaXMgbWVhbmluZ2xlc3MgYW5kDQo+IHdpbGwgdGFrZSBleHRyYSBjcHUg
dGltZS4NCj4NCj5BaCwgb2suIEkgc2VlIHdoYXQgeW91IGRpZCBub3csIGNvdWxkIHlvdSBhZGQg
dGhlc2UgZGV0YWlscyB0byB0aGUNCj5jaGFuZ2Vsb2cuIE9uZSBjb21tZW50IGJlbG93Og0KPg0K
PlsuLi5dDQo+ID4gQEAgLTU2OSw2ICs1NzAsNyBAQCBzdGF0aWMgc3RydWN0IHJjdV90b3J0dXJl
X29wcyByY3Vfb3BzID0gew0KPiA+ICAgIC5zdGFsbF9kdXIgICAgICAgID0gcmN1X2ppZmZpZXNf
dGlsbF9zdGFsbF9jaGVjaywNCj4gPiAgICAuaXJxX2NhcGFibGUgICAgICAgID0gMSwNCj4gPiAg
ICAuY2FuX2Jvb3N0ICAgICAgICA9IElTX0VOQUJMRUQoQ09ORklHX1JDVV9CT09TVCksDQo+ID4g
KyAgICAuY2FuX25vY2JzX3RvZ2dsZSAgICA9IElTX0VOQUJMRUQoQ09ORklHX1JDVV9OT0NCX0NQ
VSksDQo+ID4gICAgLmV4dGVuZGFibGVzICAgICAgICA9IFJDVVRPUlRVUkVfTUFYX0VYVEVORCwN
Cj4gPiAgICAubmFtZSAgICAgICAgICAgID0gInJjdSINCj4gPiB9Ow0KPiA+IEBAIC0yMzU2LDcg
KzIzNTgsNyBAQCByY3VfdG9ydHVyZV9wcmludF9tb2R1bGVfcGFybXMoc3RydWN0IHJjdV90b3J0
dXJlX29wcyAqY3VyX29wcywgY29uc3QgY2hhciAqdGFnKQ0KPiA+ICAgICAgICAgIm5fYmFycmll
cl9jYnM9JWQgIg0KPiA+ICAgICAgICAgIm9ub2ZmX2ludGVydmFsPSVkIG9ub2ZmX2hvbGRvZmY9
JWQgIg0KPiA+ICAgICAgICAgInJlYWRfZXhpdF9kZWxheT0lZCByZWFkX2V4aXRfYnVyc3Q9JWQg
Ig0KPiA+IC0gICAgICAgICAibm9jYnNfbnRocmVhZHM9JWQgbm9jYnNfdG9nZ2xlPSVkICINCj4g
PiArICAgICAgICAgIm5vY2JzX250aHJlYWRzPSVkLyVkIG5vY2JzX3RvZ2dsZT0lZCAiDQo+ID4g
ICAgICAgICAidGVzdF9ubWlzPSVkXG4iLA0KPiA+ICAgICAgICAgdG9ydHVyZV90eXBlLCB0YWcs
IG5yZWFscmVhZGVycywgbmZha2V3cml0ZXJzLA0KPiA+ICAgICAgICAgc3RhdF9pbnRlcnZhbCwg
dmVyYm9zZSwgdGVzdF9ub19pZGxlX2h6LCBzaHVmZmxlX2ludGVydmFsLA0KPiA+IEBAIC0yMzY4
LDcgKzIzNzAsNyBAQCByY3VfdG9ydHVyZV9wcmludF9tb2R1bGVfcGFybXMoc3RydWN0IHJjdV90
b3J0dXJlX29wcyAqY3VyX29wcywgY29uc3QgY2hhciAqdGFnKQ0KPiA+ICAgICAgICAgbl9iYXJy
aWVyX2NicywNCj4gPiAgICAgICAgIG9ub2ZmX2ludGVydmFsLCBvbm9mZl9ob2xkb2ZmLA0KPiA+
ICAgICAgICAgcmVhZF9leGl0X2RlbGF5LCByZWFkX2V4aXRfYnVyc3QsDQo+ID4gLSAgICAgICAg
IG5vY2JzX250aHJlYWRzLCBub2Nic190b2dnbGUsDQo+ID4gKyAgICAgICAgIG5vY2JzX250aHJl
YWRzLCBjdXJfb3BzLT5jYW5fbm9jYnNfdG9nZ2xlLCBub2Nic190b2dnbGUsDQo+ID4gICAgICAg
ICB0ZXN0X25taXMpOw0KPiA+IH0NCj4gPg0KPiA+IEBAIC0zNzA4LDYgKzM3MTAsMTAgQEAgcmN1
X3RvcnR1cmVfaW5pdCh2b2lkKQ0KPiA+ICAgICAgICBwcl9hbGVydCgicmN1LXRvcnR1cmU6IC0+
ZnFzIE5VTEwgYW5kIG5vbi16ZXJvIGZxc19kdXJhdGlvbiwgZnFzIGRpc2FibGVkLlxuIik7DQo+
ID4gICAgICAgIGZxc19kdXJhdGlvbiA9IDA7DQo+ID4gICAgfQ0KPiA+ICsgICAgaWYgKCFjdXJf
b3BzLT5jYW5fbm9jYnNfdG9nZ2xlICYmIG5vY2JzX250aHJlYWRzICE9IDApIHsNCj4gPiArICAg
ICAgICBwcl9hbGVydCgicmN1LXRvcnR1cmU6IC0+Y2FuX25vY2JzX3RvZ2dsZSBmYWxzZSBhbmQg
bm9uLXplcm8gbm9jYnNfbnRocmVhZHMsIG5vY2JzX3RvZ2dsZSBkaXNhYmxlZC5cbiIpOw0KPiA+
ICsgICAgICAgIG5vY2JzX250aHJlYWRzID0gMDsNCj4gPiArICAgIH0NCg0KPkluc3RlYWQgb2Yg
YWRkaW5nIGEgaG9vaywgd2h5IG5vdCBjaGVjayBmb3IgQ09ORklHX1JDVV9OT0NCX0NQVSBoZXJl
Pw0KPg0KPnNvIGxpa2U6DQo+IGlmIChjdXJfb3BzICE9ICZyY3Vfb3BzIHx8ICFJU19FTkFCTEVE
KENPTkZJR19SQ1VfTk9DQl9DUFUpKQ0KPiAgIG5vY2JzX250aHJlYWRzID0gMDsNCg0KQ29uY2lz
ZSBhcHByb2FjaCwgSSB3aWxsIHJlc2VuZC4NCg0KVGhhbmtzDQpacWlhbmcNCg0KPg0KPk9yIHdp
bGwgdGhhdCBub3Qgd29yayBmb3Igc29tZSByZWFzb24/IEp1c3QgMiBsaW5lIGNoYW5nZSBhbmQg
bm8gdWdseSBob29rcyA9KQ0KPg0KPi0gSm9lbA0K
