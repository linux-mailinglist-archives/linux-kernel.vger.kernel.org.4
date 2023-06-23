Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5573B1C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFWHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:35:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064F195
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687505742; x=1719041742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RYOqxLXDBjdWypAjfbMfgcH49sUcvTmsjUTBdzsx4ec=;
  b=MKU1HAP+xZlExSOKcSnxJo+psku7EDynRLxhBT4e3ZELCpELHo0iK0QM
   3zuB2uLQptxfyKu9DMpX083SFOQaut2djDN2NI/yPxLO5eVeOgNXkg3rh
   ErGJVpj/ZSlihUzCdEv+qedywSBVikOuQTsFsIXSyyVhfN4z1MeN9ZBlG
   Y9Uv6Fi5hMtAAd1Br3P8dfH3DXDEkxboX5Pw9wycqLPJc3/iyR/VQaSM5
   xXy+Om3GMzAr69ZdoRpL4OS/LWE+m9n0HZ76dHExLO9un9AGyfjMIM03K
   9sb9PxNUhMF+u15PNPMRrVoS+GookkAfZTRmQRmMVJbiN5XVGBi64z2HE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447087093"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447087093"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 00:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="780540903"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="780540903"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2023 00:35:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 00:35:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 00:35:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 00:35:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 00:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaGr0ZDnlZZ+7tifmN67FpTF1Z2frJVXaBxTK42q0HhKmaLoqpJgO0duu//BvN3ZadvkMyQ3muVXTeyMRda8oAGxJrhGVYX4hjh724mr+rDIgCFxYo73hIHqfV9FbnckeOByCzoP+YdRJsz/iuCTg6doA0Lc9jZj7JWzw+Wy7t+x3fyGDJU9a3moZll7U6QHyukpx40oKVhnVq6xRawytXxfJiUWqHrbhaKlqHZj4kfxHgmeZ2/QGFktc0aix4DUIVDjvlfapHzKyeu8VHDfMV9QrlaNLIs2tjC6tbNAZsQc0A6wZQxgWFy9s/oP0VsXObbu+ftzhbtFo8eD8gU/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYOqxLXDBjdWypAjfbMfgcH49sUcvTmsjUTBdzsx4ec=;
 b=d8YuCd+Sa7cQOfnfMwddjetak46Jh+QEH2iHq2ZSZCQP94z9GQXNBYwI/UfWTECE93LIUXUlHDjooDev8Z7ft133q0oQKGHlOGbrpPb0FDn4266AFC/IETvSXmlOmGjwn4u06rq4UMd3FLohJnx1tPjGhMjOxiDuNXFc5a2kgQxujKaH2EHd/myvqp8mtn+Djky5+HeLJU+drKDQUkmoPk02bwVdHhKHDHIf/56mEJrH90Bip+kU9zo6f+671Of1AKXg7WtCQzecRk2H33JPBJCzVSdufWMsJUrSJ7UiGZvGGUGlFanYxLQklu8+jueC3wxvHrQF08HDj9ZNuU46kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5735.namprd11.prod.outlook.com (2603:10b6:8:10::7) by
 PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 07:35:38 +0000
Received: from DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00]) by DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00%3]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:35:38 +0000
From:   "Ang, Tien Sung" <tien.sung.ang@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/12] New Crypto service commands
Thread-Topic: [PATCH 00/12] New Crypto service commands
Thread-Index: AQHZpYHIEU1cOtkr0k+DpImlToupqK+X3l6AgAAUbJCAAAvKAIAAAHaQ
Date:   Fri, 23 Jun 2023 07:35:38 +0000
Message-ID: <DM8PR11MB57351C38071E9960A6B5FECCBE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
 <239e7171-1d29-0208-ca6c-abc85ccbe0e9@kernel.org>
 <DM8PR11MB5735AB9B7112E33B173C4251BE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
 <e65cd698-3ac5-4eb7-a65c-2647c77af78f@kernel.org>
In-Reply-To: <e65cd698-3ac5-4eb7-a65c-2647c77af78f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5735:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: 5ba50948-84ff-4e66-56e0-08db73bc7094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IF1HyNxYnO5e9BjxafKhm59WLnJtrNUkLuU63dhtO5wWFGMiKzGpT2e8i2Nq/109TFjA5LuJAdfOS+c6gFvhHoCuY8ZaOi4FhcpGYrx839f8OqOTWhuT57Zo9UAwPI1OFpCXsERQzWbzQf2xp9LJ5YwvjadMIQi7lkreq0BgZ14M4xp5NZppjjvdYJEjkG4W3o7FCHMNfp3H/wQLZzsSngupCP3BktT47SToopserQIM3U5Jgqu8q7RwvXKClmEejEitOCm1XE2VuRarjZ+qvwpMrhjp4OI2i5PJx5/S7SKo5ad1iO7N8XpryQJJJ2wFk64CTmkZ3lf0qRstBHO69GCSSxDqM44WEYR4Y0ZhdsTGxqBqmOsUHxn0THzSzCe8/zkh+59QD93v42njPKTVFcpV+evRl9LmxcglinCDbktdoTL21fzz1fJ3+r7Nz0gxRveKxdEu8arz0n93FNk+UTX+/u9PQSdSxjlYujyam0sUbgyn9zn5Uph7d9TVs7qgeCRjEpaucFlIgxmfX+n7V3y+IY5QDUQfRIRjkcA/Pdr5WLoKQZXHzzhn5B8eqjw7yPIbHlWW+AWHKL22Q2ycRlEojurS2GZqSpmUapfeJtRRGFWoXSS0uJzbNcvm7bn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6506007)(52536014)(8676002)(76116006)(66946007)(6916009)(4326008)(66556008)(66446008)(64756008)(66476007)(478600001)(316002)(5660300002)(33656002)(8936002)(2906002)(41300700001)(38070700005)(86362001)(7696005)(9686003)(38100700002)(55016003)(186003)(53546011)(71200400001)(82960400001)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHZHVU9PU0ZxT0VnaUx6M0lBOXdNSzczVDVtZk1CdGhwd1BYVHZ5TmdwOGUy?=
 =?utf-8?B?V0FweGJ3VS9XcUFhS010NTRFUlRrRVZZSG1KMjd2MjIvQmpjMkZlV1JndmRN?=
 =?utf-8?B?UE56NXhRNjBQK0RjSDFMZ2Y0RGNMS3RnaUd6QWJIT2VzZVpiNWJtUGI0Skdk?=
 =?utf-8?B?cDBORnVnSnB4MjdYdXBXcVF2U2RGM0VBMTczRmkrWDlSWFFtclBqcDYrQWsx?=
 =?utf-8?B?UmZmS1FqZHM1d2xpMkloU0ozNE9qNWM2V3hOeTFUZkVodDBQdXJlUmVsenFY?=
 =?utf-8?B?K2k5TWhMMnFqWis3TnpXTEcrV2U1SzFrUzNlMStxWEx2dkFENjRLSmNydlNZ?=
 =?utf-8?B?MTBwTWdoSTV4Q1lRQmZKdkJ0NE5ydHAwOENRVDl5L1pQNWx2a21PSGxXcUtE?=
 =?utf-8?B?aHZLOWZXVmI3b3kzS2RvUkE4WUFSOFFvYzFTa0o2RURIc0NJY0hSLzhpZ1ps?=
 =?utf-8?B?aVBtOVlCMWxwdkJWTElHdzZKQ2VkTk5PMEV6VG93L2RTbUZVckVwZk96MU91?=
 =?utf-8?B?MjcvYnc5NjZqczdxN1FxNFo5OWl6RjRyTi9xckxxbWZJeE9KanEveWsveitN?=
 =?utf-8?B?TTZSZFpXQlFpMGF4OGh6ek9wbmFIcHRFeTV0amdSNXhYOGt0SFBnci81Umh0?=
 =?utf-8?B?b01LbXM4L2NNS3NLbXp0ZWQ5Q0ovd2NtRE9nSTRCMkFiL21PNitVbXN1YUov?=
 =?utf-8?B?b1ZiUnpIZWpyRE52dkdyK3hnWS85L1pVTFkyblZaUEN6VjJtdGVNYStPa3VX?=
 =?utf-8?B?ZDArRHBZL3dWb3ZxVVcydVBxSVdLUkU5elNTUHk3Q25vazdOeDcxclhqNjdj?=
 =?utf-8?B?U1ppSTdWMU4wamRySjd0a1RBTERnVkZGY2FFYlhWYTV1RDlZQUt0dmNDR2hq?=
 =?utf-8?B?SUJLTWNpaG1aTjB0Y2x2N25YT2w2VGd3c2R2ejdEWlR6QjZxZTZmeXcyelZw?=
 =?utf-8?B?UlF2YXMwR1h4emNYR0wrc2lDT2lmQmsyK2trSWFoWk4rYW5NUERhMnNSbzNN?=
 =?utf-8?B?U2RUeWxkY0oxNm1pMVZwSVBhSDFtNUpzWklWSFprVTcvY0s0VnY3aHNnQ2U1?=
 =?utf-8?B?N1ZLNzVCM0dRUlNNQjJNbU4vZWRVeUsxRkRYcVFtWE5JTi9KN2VIejFRUTVE?=
 =?utf-8?B?RnJJTDZtUHUrQUFwd1ZpZkVYb2ZUempsUGE5OVM1dVpiRjFHMytDbjFMbi9J?=
 =?utf-8?B?TlNHWFdkdThJOXB0d0E1bHhtY054VEpQVFpyNG1UbnhTMnkraVRyOE1TMkJk?=
 =?utf-8?B?cThVS2pieTg4L3dnWDVUWGZCMkZqWnREeGpBTENCYkpOb0VUL1BiOSs4SERj?=
 =?utf-8?B?NjErbDk1NWJlKzlkbUdPRTRrZEluUWtzUFhHVVR2cGdXYlFVb2RGN1MzTFJJ?=
 =?utf-8?B?RnVxakJqQi9DM2tjKzNWS01ZMXFIT2c0ejc2cXZhS0prNW9Ec2pKRVNta1Fi?=
 =?utf-8?B?UStQY3BsT2NpMWI2LzhtbXhsMzF3WDJRS3hSaWY2UE82ZFdIRmxTNjF4WEtZ?=
 =?utf-8?B?bmxrdkV3dkY5d2I5UVM5enozVlNYa2hxSnRZQ2ttOUJoUHBMZUFzUlJkb0hs?=
 =?utf-8?B?RGQ4Z2hId0FVTTg0RnRQS1pYRkJaY0NIc0FlUC9LdEp1UWRsWCsxZTZqNU81?=
 =?utf-8?B?VU1hQzlWSG1TMDVZelMxRWdhamRNbEdCZGswazF0cis4Z3AvUmprWlh5SzJ2?=
 =?utf-8?B?ckd0Sjd6QjlUejNldW0vNE1rcXUzU0JGLzh6SEFxSE1oOUQyTkhXbkQxRkln?=
 =?utf-8?B?elZ2TnZKK2duK0pzR3ZSOFVVN3ZmWXVGbkVvNWdIYVBGL3BINlBRbTcwWVYy?=
 =?utf-8?B?d2hVUkgwdjF4dVFvM2VpTUxEOUVPTnBsQjlBK0hHMjlQVHVpTlY2MkNsSUdh?=
 =?utf-8?B?cGhNMzBaaWU0RnNOYlNTYU9PUkZ2ZWNvN3pscjJkMjVSS2U3dlp2OG1kYldL?=
 =?utf-8?B?QUdtS0NTU0F4YVVTLzBZeCtVSWMranZhUm1rZlVYakY3Um1nUGRCQXUxRzgy?=
 =?utf-8?B?a3FmSnpleTA1NUtmaVFPdlFPME1rM1RlZnUybVYyWkh3VFllNS8raDFkRkVj?=
 =?utf-8?B?SDZvY1JPN25FWUI3WVNxZXhHeVV0QTFLcnlTM25uK3NCa3dvWk53VDV1MFl6?=
 =?utf-8?Q?Vl0E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba50948-84ff-4e66-56e0-08db73bc7094
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 07:35:38.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPxkdcegzOGFQ2ibWro+Mv7z5p9UIoF6NMYLRr6zP5RLQS6MWPnLZAzr/04iGI4g7jadLyoGwL16x8O/aM0xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluaCBOZ3V5ZW4gPGRp
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgMjMgSnVuZSwgMjAyMyAzOjMyIFBN
DQo+IFRvOiBBbmcsIFRpZW4gU3VuZyA8dGllbi5zdW5nLmFuZ0BpbnRlbC5jb20+DQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTJd
IE5ldyBDcnlwdG8gc2VydmljZSBjb21tYW5kcw0KPiANCj4gDQo+IA0KPiBPbiA2LzIzLzIzIDAx
OjUzLCBBbmcsIFRpZW4gU3VuZyB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IERpbmggTmd1eWVuIDxkaW5ndXllbkBrZXJuZWwub3Jn
Pg0KPiA+PiBTZW50OiBGcmlkYXksIDIzIEp1bmUsIDIwMjMgMTozNyBQTQ0KPiA+PiBUbzogQW5n
LCBUaWVuIFN1bmcgPHRpZW4uc3VuZy5hbmdAaW50ZWwuY29tPg0KPiA+PiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEyXSBOZXcg
Q3J5cHRvIHNlcnZpY2UgY29tbWFuZHMNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24gNi8yMi8y
MyAyMjoyMCwgdGllbi5zdW5nLmFuZ0BpbnRlbC5jb20gd3JvdGU6DQo+ID4+PiBGcm9tOiBBbmcg
VGllbiBTdW5nIDx0aWVuLnN1bmcuYW5nQGludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBoaSwNCj4g
Pj4+IFRoaXMgcGF0Y2ggc2V0IGNvbXByaXNlcyB1cGRhdGVzIHRvIHRoZSBzdmMgZHJpdmVyIHRv
IGFkZCBuZXcgY3J5cHRvDQo+ID4+PiBzZXJ2aWNlcyBmb3IgQUVTIGVuY3J5cHRpb24vZGVjcnlw
dGlvbiwgU0hBMiBkaWdlc3QgZ2VuZXJhdGlvbiwgU0hBMg0KPiA+Pj4gTUFDIHZlcmlmaWNhdGlv
biwgRUNEU0EgaGFzaCBzaWduaW5nLCBFQ0RTQSBTSEEyIGRhdGEgc2lnbmluZywgRUNEU0ENCj4g
Pj4+IGhhc2ggc2lnbmF0dXJlIHZlcmlmaWNhdGlvbiwgRUNEU0EgU0hBMiBkYXRhIHNpZ25hdHVy
ZSB2ZXJpZmljYXRpb24NCj4gPj4+IGNyeXB0byBrZXkgbWFuYWdlbWVudCBhbmQgbGFzdGx5IEVD
RFNBIHB1YmxpYyBrZXkgcmV0cmlldmFsLg0KPiA+Pj4gVGhlIGFkZGl0aW9ucyBvZiB0aGUgY29t
bWFuZHMgYXJlIGFsbCBzdGFuZGFyZCBlbnRyaWVzIHRvIHN2YyBkcml2ZXINCj4gPj4+IHdpdGgg
bWluaW1hbCBsb2dpYy4NCj4gPj4+DQo+ID4+DQo+ID4+IEkgZ3Vlc3MgSSdsbCBhc2sgdGhlIHNh
bWUgcXVlc3Rpb24sIHdobydzIHRoZSBjb25zdW1lciBmb3IgdGhlc2U/DQo+ID4+DQo+ID4+DQo+
ID4gVGhpcyBjb21tYW5kcyB3aWxsIGJlIHVzZWQgYnkgdGhlIGZ1dHVyZSBhbmQgY3VycmVudCBk
b3duc3RyZWFtIGNyeXB0bw0KPiA+IGRyaXZlciB0aGF0IGlzIHVuZGVyIHJlZGVzaWduLg0KPiA+
IFRoZSBzdmMgZHJpdmVyIGlzIG1lcmVseSBhIGZpcm13YXJlIG1lc3NlbmdlciB0aGF0IGlzIHVz
ZWQgdG8gc2VuZA0KPiA+IE1haWxib3ggY29tbWFuZHMgdG8gdGhlIFNETSBmaXJtd2FyZS4NCj4g
PiBJdCBpcyBlc3NlbnRpYWwgZm9yIHVzIHRvIGJlZ2luIGRvaW5nIHRoaXMgZmlyc3QuIFRoYW5r
cw0KPiA+DQo+IA0KPiBJIHRoaW5rIHdoYXQgeW91J3JlIGdvaW5nIHRvIGZpbmQgb3V0IHF1aWNr
bHkgd2hlbiB5b3UgdXBzdHJlYW0gbW9yZSBpcyB0aGF0DQo+IHRoZSBjb21tdW5pdHkgd2lsbCBu
b3QgY2FyZSBhYm91dCB5b3VyIGRvd25zdHJlYW0gc3R1ZmYuIFRoZSBwcm9ibGVtIEkNCj4gaGF2
ZSB3aXRoIHRoaXMgcGF0Y2ggaXMgdGhhdCB5b3UncmUgYWRkaW5nIGNvZGUgdGhhdCBuby1vbmUg
aXMgdXNpbmcgYXQgdGhlDQo+IG1vbWVudCBhbmQgd2l0aCB0aGUgY3J5cHRvIGRyaXZlciBiZWlu
ZyByZWRlc2lnbmVkLCB0aGlzIGNvZGUgbWF5IG9yIG1heQ0KPiBub3QgZ2V0IHVzZWQsIHJpZ2h0
PyBMZXQncyBmb2N1cyBvbiB0aGUgZ2V0dGluZyB0aGUgY3J5cHRvIGRyaXZlciBmaXJzdC4NCj4g
DQo+IERpbmgNCkkgZGlzYWdyZWUuIE91ciBjdXN0b21lcnMgd2FudCB0aGUgU1ZDIGRyaXZlciB0
byBiZSB1cGRhdGVkLiBUaGV5IHdpbGwgdXNlIGEgDQpjb21iaW5hdGlvbiBvZiBkb3duLXN0cmVh
bSBzb3VyY2VzIGFuZCB1cHN0cmVhbSBzb3VyY2VzLiBUaGUgY3J5cHRvIGRyaXZlciANCmRldmVs
b3BtZW50IGlzIGFub3RoZXIgbWF0dGVyLiBXZSBzaG91bGQgZm9jdXMgb24gZW5zdXJpbmcgdGhl
IFNWQyBkcml2ZXIgaXMgDQpmdWxseSB1cHN0cmVhbSB3aWxsIGFsbCBmZWF0dXJlcy4gSG9wZSB5
b3UgdW5kZXJzdGFuZC4gTGV0IHVzIGdldCB0aGVyZS4NCg0K
