Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDA73B0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFWGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFWGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:53:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B01FFD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687503209; x=1719039209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wrNlcof7bQZLc8ikEW4wD99v9fcedY75aVqhUleLhuU=;
  b=YW+HZsn1W4O4K5yff7nt/DWGv2JGyfrNe0iHUPnZE1eW5aPPc8pHLC/H
   OrKRzOcyGzOXYJ9wHVMKds17sKt8VdYFoHOh58OpBHQwSTS7lRATMlomO
   45Nv/4gFr0if7XeenVx4LdqUDo6qFqQcK++HdcU1tKuBBASjM7DeYKLqJ
   eKndHMs32181pZGKBBKB2iAtIRiMnD3Tc3XmrRyyTLwL2OM30ykm4xX24
   kE1tbYPGn7EYvmBFqkIML0Jf8OBibrShNzWVoAiCLvepfI956EIUXYjXk
   /UdnH8S3Tp2HS4vf40ANKCAkvX+3xy1+oyrXCpy7G1Kw7mftuvNaC1aTZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424385549"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="424385549"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 23:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="1045536817"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="1045536817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 23:53:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 23:53:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 22 Jun 2023 23:53:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 22 Jun 2023 23:53:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 23:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsMtiWK6O8KsI7iTUsXIKh29hbXFYRTcjnUW+XROPhYYTP8O08Xq8U0S0qFwsA/IKTBjdudY/vz4+3ZDcuM0A2oVEf0oMAXMUR8nSpHN4vqaSipP8dFG7xOGjjX169fKXweQv5iI2xwZ994Qem0cbsyh/4hu9XkdE+SceMo8nEAwRIjmb/PtV5pwo6QEjDacSn+QJb/d5E7y6shls6TOh90/pa1vULwKwPy1cZNogC7ph8O0V0yKxCJzx9y9g9q27PP/eX6a1vFXQvkU8lf1mZIen3IP/kts2Pc6deZeEl0Rj4nGkk15tKORI0YUUn6LrGeIyAUcpuoPWnGxgHGdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrNlcof7bQZLc8ikEW4wD99v9fcedY75aVqhUleLhuU=;
 b=R1yvlnKBJ/w4nF9S9/DlLydQIh6mNvYY03EYX2IoAVxPHJd1VRfwW2VLW2g0LgR39qSntdnbzWZizvbihdjkCgiZVwJX3jhIixUAHl/BLCnRiCHq8jx17XifEW1Xue8q2ya/es4Ncae+UTqQrCxmjQx48tuMS9GN15MVwomOZqeAq5oX+4o/NMRhbjM3iZUhsPLqZPiRrX0KN7i1pamoPJgpBlsJ/Ugk5BQzTPJvBurYfXO5/ropEzsKbo896Q1O/Yq9yS9RPV5R4xX0u4P5jEgusIYCdkSnYA3oWyX2sheBlU+1ziM6NctYpqfYVMXWBWrQw44lnqvsr3G1gwqV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5735.namprd11.prod.outlook.com (2603:10b6:8:10::7) by
 MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 06:53:25 +0000
Received: from DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00]) by DM8PR11MB5735.namprd11.prod.outlook.com
 ([fe80::4a7c:427d:69dc:ec00%3]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 06:53:24 +0000
From:   "Ang, Tien Sung" <tien.sung.ang@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/12] New Crypto service commands
Thread-Topic: [PATCH 00/12] New Crypto service commands
Thread-Index: AQHZpYHIEU1cOtkr0k+DpImlToupqK+X3l6AgAAUbJA=
Date:   Fri, 23 Jun 2023 06:53:24 +0000
Message-ID: <DM8PR11MB5735AB9B7112E33B173C4251BE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
 <239e7171-1d29-0208-ca6c-abc85ccbe0e9@kernel.org>
In-Reply-To: <239e7171-1d29-0208-ca6c-abc85ccbe0e9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5735:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: 89a6d56b-253e-4836-fb06-08db73b68a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K17bWksCS8gBuAGx3FBa0xbVhYw/t9f7baLPd5obHx80rMZmuQLfGR/u6O/IBVuKO0FX8SE7foB+VIrrRUyieYrjdLOWrvd6ACRmagZH5n00lL+2xmWc2iUop//qaaWBQKQPRtpYTTCZfvSgB7Q6VHOU/kd0s9Xia7EVlc+HMrB9oJFE2UoSHztMge8gDFWxnhXmFwB8eX4bfGBH31ObTBQDvhxZSZZvF1NtEPkXfpUldqgUvxIp6zvtu2mWXykSH7i2AIiJ2nkr6g5t5tjU3NFs9rKKCR7fljqOVguBN8gw7J4j434nyiuRTR4tpcxM9AAI7shLMyHNNdrEsCF9h4hb232LtYPx23ypVETiT91wwRi4TwpQzD46gv+0amnkvW30+ZQnSXFFRLLslIWeQ1RJ+HzhdaXqkleUvPLdsHjI+jiZmW6PS5vx+mrKHm3r60DLqOgau503+Mj7chfUS4HS+dhLWbhNgy67KtdlXlkuku36h3DvdHYW3596dZ4UtgqGWCSZ2JihVBzcIalBaT1jgMvxNZjiS9/SLWDW2MkCDt0Zh6DxQtgvGW/40fqjEpj2tVlbErHFvkn5sXzj3CNPlRWcsxhgc9SEx2bItPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(38070700005)(86362001)(8676002)(38100700002)(8936002)(6916009)(66946007)(64756008)(66556008)(66446008)(66476007)(316002)(41300700001)(83380400001)(55016003)(7696005)(5660300002)(52536014)(478600001)(6506007)(53546011)(76116006)(4326008)(186003)(9686003)(82960400001)(122000001)(2906002)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0ZLcmsrYmpsTDA1OEZlMlhSbkhBN1EzZFg2TTA2d0NvaC9IbTZLUDVwNnZK?=
 =?utf-8?B?RE5BYld2TDg5dmEvTS9Vby93MjJVNWM0eXZ1dXZrL3hKQjhTVzhxNWZ0dnhN?=
 =?utf-8?B?NWVSWWlZL29NRHZoWThyVmIzNElYZVNEbWdGczJzam1LTmpnb0RhUjRWeGll?=
 =?utf-8?B?bWhYY2o5TVJQUDRDZC9QdkJKNk0xcUc2aE0zYlBsMTU3aDZSQng0YWEvQU5v?=
 =?utf-8?B?RUlGMG1WUWg0K0tBQS9PMTQ5c3Vmc2dUOHNaSm9QQ0svRGRKK0lnSWhaRnVW?=
 =?utf-8?B?Y2NTbFozTWw0WGdHajNhZ1lraVd3bzkyY3p1dUk1S0p4RkM1dHdLTXlrSXox?=
 =?utf-8?B?bDBDa2c5UXVXMWQwRGtqaFRaZ0FMc0pWWDFrQVNyeDgwSUptbmo1SEF4V24r?=
 =?utf-8?B?Um1vaElyWVJVbVN4NG5zRm96RVc1Q252ZmxjbUtTdEhHaldiRXNRVmJ1L3Jm?=
 =?utf-8?B?ejlVcXpXRVFobkVvZm92SGFZUmJqbGxiandMY0w0ellhMzJEWXZVd3FtazVt?=
 =?utf-8?B?WVZNak9pczErRFc1VHJWZDBPY2NMZk1PVWxMcmI5VTBJaWpaMmJ2SUorcXdK?=
 =?utf-8?B?Wm5xMU5ONjFVeUZUc1hGcllCNFFFQ0Z4d3JSM09uVzRBY01FWWNteFRTUE1N?=
 =?utf-8?B?a0FXakc4TFUyTS8zVmhuZDVlbVk3UFNycHJWOXZrYmRyUEpUV0lsRjFLd3pl?=
 =?utf-8?B?OU5rSC93WGd2V2EyMkd5b2JsRUJuK2hBcUl6OWc1NXRia0h4dlhHVkJrbE4x?=
 =?utf-8?B?ZGJQa29kZUdhQWZYOU5QQ29MUkxYdlEwNTlxci94M205aEdFYWIwS2JSYkhY?=
 =?utf-8?B?Y1dTUzV4d0k2RzR6Vmx4clYrVDZGcDRDZktCdEFIMVAyY0twbys4K3FxS0lO?=
 =?utf-8?B?VEc3eXdHc1pHUmpWUExUNVdic0ZEWlNNMENOSkFuZ1VhcHRWQmtrcTRoR2g3?=
 =?utf-8?B?TUlTNjZBUzh3c29IbFowT0RKQTV5Tm1yMW5KZ0N3Mk5Wem5zb0tUUURxQW9m?=
 =?utf-8?B?RHpwcXVqSUtqc0pjc21xNWpTaEhvT1AwRzZSbEoxWmh6bU9rUDFrTko2dW5X?=
 =?utf-8?B?K2ViSytiTW5Za1FnQ3ZNVDQySFFUMUcraHpza0lHRzBVT1VlNFE2Z2JCRGZm?=
 =?utf-8?B?TEpwZ1k2ZHpxR3BBbUR6dkY2TTJGcFFBeXBzM1hSWm1PUmdJSzRXckllUmI0?=
 =?utf-8?B?enVpbW12SGpqcHpZWVVsWHN2ZHRyYkxpSmZCVVdrTjdTZWMwTkh4K3ZFdWRr?=
 =?utf-8?B?YnNQSVhZSlF4a2plUnQrakpPbjhjdGxvOFJ2Mmp2cFA4RExDNEhodzBxeGJv?=
 =?utf-8?B?c2JpUVpkNXRPQkRYWjJwUVZ3bU1pQWkwNWNUZElpc1JLNVFCZ1MvVWJWSytK?=
 =?utf-8?B?K0pCeDhrbkpqSnhDRGFiZHJSRnBmV2o2R3hOQzZVNzZ6NVRLNjdJK3BlaWx2?=
 =?utf-8?B?S2lKa2pQTVR5cldDcDc1VmJDcmJLa0Z5UUZxeXNIdWlBTSs2QXdLclY5YlB0?=
 =?utf-8?B?anZjd2p6Yi9hRTVUMFZHa1FoWGJDdzZycXNVUDk2VitHOGhHWDdibWRmZDA0?=
 =?utf-8?B?dSs2YUN0VnA2OFhUalNueDBrRFVUUk0yV2htUHFLdHQ5bk5icmJEWHVCczVx?=
 =?utf-8?B?eURzcVl6amxUK0pTdGgwTVBkQ2JGWjVvTkV2SGp6bk9UMzYyTTdOdmFDTnpZ?=
 =?utf-8?B?UHNGbk1TVlREdmk3Y0sveWd0aGJhWU5CMVdQQXB5Q1R1ZXZFNU9PQmtnTkJP?=
 =?utf-8?B?c2c3b2ZadFRNNUQ3Y1lkWWdiaVZIdHBlSEtHRHFzMDB6cHpYL2JaQm9MdnJL?=
 =?utf-8?B?eG5TbjFvT0ZNMDFjczlTVUIyV2pvMTUvamFKamtTaHNhSnFsVzFSRHZPWEdj?=
 =?utf-8?B?aW5SUElYbm5kUzhVQmd1Qm5DNHNEK3ZOTWl6SFJEM21tVnc3Sk1rdTAvWWts?=
 =?utf-8?B?Vm1sdGRabEpySFVhOW5CSVcybkxsbHlkSjBJa1JXNDN6YkluMTJaVTFSaTB6?=
 =?utf-8?B?ckI1VkFTOXRPMklDVHY3dURLOWJhYmthdDZYR29yemdONE4wOEJCc3VuNGpN?=
 =?utf-8?B?bmhCUUhXenhnU240QzgzSmpzNkNBL2Z0eTBPUUVMN0ozRzRxZWNHWlZwVUg3?=
 =?utf-8?Q?goho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6d56b-253e-4836-fb06-08db73b68a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 06:53:24.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcuEG1ZZyrhEm1uEFXqRFZ85rYEb2tEkXTv21sSNp9ge8t7ul5+frlNvt4EcPEvyl0RtN3nyO+EXmWF24xzrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
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
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgMjMgSnVuZSwgMjAyMyAxOjM3IFBN
DQo+IFRvOiBBbmcsIFRpZW4gU3VuZyA8dGllbi5zdW5nLmFuZ0BpbnRlbC5jb20+DQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTJd
IE5ldyBDcnlwdG8gc2VydmljZSBjb21tYW5kcw0KPiANCj4gDQo+IA0KPiBPbiA2LzIyLzIzIDIy
OjIwLCB0aWVuLnN1bmcuYW5nQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbmcgVGllbiBT
dW5nIDx0aWVuLnN1bmcuYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IGhpLA0KPiA+IFRoaXMgcGF0
Y2ggc2V0IGNvbXByaXNlcyB1cGRhdGVzIHRvIHRoZSBzdmMgZHJpdmVyIHRvIGFkZCBuZXcgY3J5
cHRvDQo+ID4gc2VydmljZXMgZm9yIEFFUyBlbmNyeXB0aW9uL2RlY3J5cHRpb24sIFNIQTIgZGln
ZXN0IGdlbmVyYXRpb24sIFNIQTINCj4gPiBNQUMgdmVyaWZpY2F0aW9uLCBFQ0RTQSBoYXNoIHNp
Z25pbmcsIEVDRFNBIFNIQTIgZGF0YSBzaWduaW5nLCBFQ0RTQQ0KPiA+IGhhc2ggc2lnbmF0dXJl
IHZlcmlmaWNhdGlvbiwgRUNEU0EgU0hBMiBkYXRhIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24NCj4g
PiBjcnlwdG8ga2V5IG1hbmFnZW1lbnQgYW5kIGxhc3RseSBFQ0RTQSBwdWJsaWMga2V5IHJldHJp
ZXZhbC4NCj4gPiBUaGUgYWRkaXRpb25zIG9mIHRoZSBjb21tYW5kcyBhcmUgYWxsIHN0YW5kYXJk
IGVudHJpZXMgdG8gc3ZjIGRyaXZlcg0KPiA+IHdpdGggbWluaW1hbCBsb2dpYy4NCj4gPg0KPiAN
Cj4gSSBndWVzcyBJJ2xsIGFzayB0aGUgc2FtZSBxdWVzdGlvbiwgd2hvJ3MgdGhlIGNvbnN1bWVy
IGZvciB0aGVzZT8NCj4gDQo+IA0KVGhpcyBjb21tYW5kcyB3aWxsIGJlIHVzZWQgYnkgdGhlIGZ1
dHVyZSBhbmQgY3VycmVudA0KZG93bnN0cmVhbSBjcnlwdG8gZHJpdmVyIHRoYXQgaXMgdW5kZXIg
cmVkZXNpZ24uDQpUaGUgc3ZjIGRyaXZlciBpcyBtZXJlbHkgYSBmaXJtd2FyZSBtZXNzZW5nZXIg
dGhhdCBpcw0KdXNlZCB0byBzZW5kIE1haWxib3ggY29tbWFuZHMgdG8gdGhlIFNETSBmaXJtd2Fy
ZS4gDQpJdCBpcyBlc3NlbnRpYWwgZm9yIHVzIHRvIGJlZ2luIGRvaW5nIHRoaXMgZmlyc3QuIFRo
YW5rcw0KDQo+ID4gQW5nIFRpZW4gU3VuZyAoMTIpOg0KPiA+ICAgIGZpcm13YXJlOiBzdHJhdGl4
MTAtc3ZjOiBzdXBwb3J0IG9wZW4gJiBjbG9zZSBjcnlwdG8gc2Vzc2lvbg0KPiA+ICAgIGZpcm13
YXJlOiBzdHJhdGl4MTAtc3ZjOiBjcnlwdG8ga2V5IG1hbmFnZW1lbnQNCj4gPiAgICBmaXJtd2Fy
ZTogc3RyYXRpeDEwLXN2YzogQUVTIGVuY3J5cHQgYW5kIGRlY3J5cHQNCj4gPiAgICBmaXJtd2Fy
ZTogc3RyYXRpeDEwLXN2YzogaW5jcmVhc2UgbXNnIGFyZyBzaXplDQo+ID4gICAgZmlybXdhcmU6
IHN0cmF0aXgxMC1zdmM6IFNIQS0yIGRpZ2VzdA0KPiA+ICAgIGZpcm13YXJlOiBzdHJhdGl4MTAt
c3ZjOiBITUFDIFNIQTIgdmVyaWZ5DQo+ID4gICAgZmlybXdhcmU6IHN0cmF0aXgxMC1zdmM6IEVD
RFNBIEhhc2ggc2lnbmluZw0KPiA+ICAgIGZpcm13YXJlOiBzdHJhdGl4MTAtc3ZjOiBFQ0RTQSBT
SEEyIGRhdGEgc2lnbmluZw0KPiA+ICAgIGZpcm13YXJlOiBzdHJhdGl4MTAtc3ZjOiBoYXNoIHNp
Z25hdHVyZSB2ZXJpZmljYXRpb24NCj4gPiAgICBmaXJtd2FyZTogc3RyYXRpeDEwLXN2YzogU0hB
MiBzaWduYXR1cmUgdmVyaWZpY2F0aW9uDQo+ID4gICAgZmlybXdhcmU6IHN0cmF0aXgxMC1zdmM6
IHB1YmxpYyBrZXkgcmVxdWVzdA0KPiA+ICAgIGZpcm13YXJlOiBzdHJhdGl4MTAtc3ZjOiBFQ0RI
IHJlcXVlc3QNCj4gPg0KPiA+ICAgZHJpdmVycy9maXJtd2FyZS9zdHJhdGl4MTAtc3ZjLmMgICAg
ICAgICAgICAgIHwgMzA5ICsrKysrKystDQo+ID4gICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lu
dGVsL3N0cmF0aXgxMC1zbWMuaCAgfCA3MDggKysrKysrKysrKysrKysrKysrDQo+ID4gICAuLi4v
ZmlybXdhcmUvaW50ZWwvc3RyYXRpeDEwLXN2Yy1jbGllbnQuaCAgICAgfCAgODYgKystDQo+ID4g
ICAzIGZpbGVzIGNoYW5nZWQsIDExMDAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0K
