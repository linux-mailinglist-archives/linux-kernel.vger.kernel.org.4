Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27EA6763E7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjAUFBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUFBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:01:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B86F8BD;
        Fri, 20 Jan 2023 21:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674277280; x=1705813280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DKeyRRLG6yPrO98hHK64o84HAFl+pgpzuJJ+8xpsQmo=;
  b=mhQRmjlxv6zP9Um6Dbkm9QK4qxD1VIdw0tgh8gbRchT0DSarvMuErwDN
   b51QUlphad2ymvQKlr5c24d8ZrgLl2kvbVlDQsOBRjVO6VkRp3fOmSJ72
   jYSC728o7fJv7Cjtbjio6IbVweL8f01MGO+4ZdhcoNzcSh7cgYrPDQ9BH
   zAAMhWiGaCtPa5VaC3Dzu3U+7xFazFRI+6RRQgpc908h/BtPx+WfrhMNZ
   1m6In1pvSewxH9e9ihfLpiAg6qsRZo0XCBc3EaFEuaaNVkTG+MFs20szg
   DOOQ6lAcgKJH9hCfarOd5SSLiBUmvoq9qsiTXHjQlRNpf0dzwD/JIw7SD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="323447288"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="323447288"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 21:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="749591200"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="749591200"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 21:01:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 21:01:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 21:01:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 21:01:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 21:01:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K925ffd55sxyDac0Zorg8funkVeghXPnk9jdwkKwdt0whWBYl0QdnC8TfP1fE0LMdWymGedSTj5bIqHJTa0nzbsv1yuK3EH674BR6CwhC7QRoA1lLqpxziXHxa4fL7ZjWNT6X9Mqub+hO/E5D9iMnVfOr1inmAprDK9EsFWFYV89AE9S/FxpSacEu+esjPhq+PM2L5HGWXjMFjg6rFMFxBuATSr2WAMQf/Gyn7JSnktIILQeJ4wthQkvRoXqWwRw7Xn4vvLs6x9LzuKmsvk+EN5jaKOh6o9C/XJyKoeymtV7PLkgaoFRRuhoEM3GhHjBce+O19OxG1bXKd0uKoTgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKeyRRLG6yPrO98hHK64o84HAFl+pgpzuJJ+8xpsQmo=;
 b=jHNFki+STlwbptqXvgn/XoogSdrhw7Yc+PlmlmQSS7hFzGD4v75dp/gZcfqmAlzDEEIFfcJJHEP2gaJHuUZwnTR6q98VNmJTJgcOmAR4aWIYfZ6vc7IsL5JEgK8oErmq7uwNz2X+EZQkQHZsc38+gKdEg0CC5mJBTWuFbO3B8G17KxZsBh2y74y2Kjni1T1rclOylYU8FgfFFtw9v3RkzfOKKWkt3bHyZ46zoceLSpV9oQkkxfXFAv13O1gpvTGDIdsuW94yH46TOEzNgojm64+SWxKY/uqhDuNog6S00kebLE+oB7ew2tDhXMZD/YABBNfzJXaOYnd5x/5osqa/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 05:01:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Sat, 21 Jan 2023
 05:01:17 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tim@linux4.de" <tim@linux4.de>
CC:     "tushar.n.dave@intel.com" <tushar.n.dave@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: intel: pch: Add support for Wellsburg PCH
Thread-Topic: [PATCH] thermal: intel: pch: Add support for Wellsburg PCH
Thread-Index: AQHZIs4BrWTy+V1D70+MYBUDBIqxka6nlhcAgAATt4CAALtbAA==
Date:   Sat, 21 Jan 2023 05:01:16 +0000
Message-ID: <498ed05c0c4fcd9d1459313279aa4105ff514650.camel@intel.com>
References: <20230107192513.118172-1-tim@linux4.de>
         <CAJZ5v0jYUmDHn6ati=zOU6JyYYAuc6CUtV2eomPWWa2aBoKdSA@mail.gmail.com>
         <5b145975c781b9a8165acea037192f38f9a6d87b.camel@linux.intel.com>
In-Reply-To: <5b145975c781b9a8165acea037192f38f9a6d87b.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB6899:EE_
x-ms-office365-filtering-correlation-id: ba0d9658-206a-4b91-757b-08dafb6c873c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dsJ8UtlgLyzcA0Gb8E0BSHoKyFNgcRIIDIBP2rjfcl+1xc9XVt8oYW/lNyLZzIYQaUAxpY9a0DjeDmaMtVasX0K9JF8E/kc/+OMYTTxTECqZSsWV3ndhdRpQbxmvwaaHGTZ3fmRGVaHaTurwHd3pWqJQRR8W0xhqUsELrIE+45Nz81guu77pJVK9OUxbOQEAOvSJPAUIgXH+jFiXDFHSZ8/W3QhNH1hgZ9Fw/+kh43RbJjviMEgsil7Jsa8k9yMj/3JGOHkD3mhlbmP2s9CyYO8Sl2hZzJRS/ajCkIczVapizc10VdjIa2siKQkQ2UPVqDrvTmm/hg5lwMdoKUWIvY0uKnXQOJ2p8xNpkGOXsIk87j7NVsRalj7XLl/PnVZd10otWM1auMQQFRSni5Els8h6qPkFtFNT85Qzi2/IFTaHPx835le9gjMRovRalqu3x+eXQziGrXO7K0tLXap60hxVovqLUxZBhRjvGJDHdQLrjwZwLnK8qpggvUeiGQDD+QvviHC5apxoLiOarhb/7Zw+hKKZvPaYxqwWSHHkounAYQapR2DCXtbb00oJAMN0QudHHgp32clFMw/jF7EkvKnqbssLEVKkANZcbsxq5/k7g6uKyb/EAV9XU5weX0Dd94HfFHglNHlxpRBQNv4gYMwZpecTGNttjfOkNXAS1oHt8yLx97n3vNYwVwcjh5Qsi4m6hTNfu2F9IWDZ3wvbrSmNFYC1TGkWr9FBHpnziw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(36756003)(38070700005)(2906002)(122000001)(38100700002)(82960400001)(86362001)(5660300002)(8936002)(41300700001)(71200400001)(316002)(54906003)(110136005)(53546011)(6486002)(6506007)(76116006)(66446008)(91956017)(66946007)(64756008)(66476007)(4326008)(478600001)(66556008)(8676002)(6512007)(26005)(2616005)(186003)(226253002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkpWOXFwUEs5bmcyeVZmSy9CazFPWEdYR1ZiUzA2RTYya2lzcy9wNjdsSi9l?=
 =?utf-8?B?ZzB2WGdWTSt3Z3BRV2FEU21UdGpVc09NMWZMVVQ4WFV6elREY3p2MDlWT0JZ?=
 =?utf-8?B?YTJDTU9UczcyNmQwN3pmM21PMS9NZ29iNllTY09lNVJlTTU5VWFCcGVBM05N?=
 =?utf-8?B?cWhhbG4ySmwxaGg3cTVMM1AxUE5BcUk1dmtZYng3WFR6V3pSb2tKMS96SEJG?=
 =?utf-8?B?NU9QUW1kaWQ3WUxGY0JScXFVeURtNFR2OUJySTN6Z3VIUEZqeWhMV1BxYWtP?=
 =?utf-8?B?UGMrZ0U2eVN5dFZWM09zQWFMcVhhbXF4WTE4ejlPaEtEaXhoOEVkd0prbG4w?=
 =?utf-8?B?dnNyUTdZYTFoM1hjWGdKTWFOYmdqclZyQXNvTzZqSTNXNzk0Q3hITlFLbEQx?=
 =?utf-8?B?L2xGb1NBWGxIbmdLYXJGRW1GanFOUmtwOUhlOU91YmpsaEFHYXpnWk9CNHRu?=
 =?utf-8?B?RENjLzdWSHZ3R0FaUVMwTWpMQVRsdDN5QW5MWDF0dHR6ZkE2ZDF0RXk4dVBq?=
 =?utf-8?B?ekRkSkc4UTJRQXpqdEoySmRxVG1LOHgrNVNBU1Byb2tsdmlKM2ZEczJsOHh1?=
 =?utf-8?B?d0pBKzFzMVlNYmVNWUFSajVxaXM3U1IvZEw0TklmL1hPM29WSjJ1TTlHVzRx?=
 =?utf-8?B?RitLMVJaWTRqQ01JS3FMTjNlMzAzYjJzTTNCWGQvUmx2UTl3RVY3ekUyU2Fs?=
 =?utf-8?B?b2N3OWZVMVpVVUpZQ2R5alpMckFWR1c2RjdzcXNSVXRuWmg0MjBNYmRzOWlL?=
 =?utf-8?B?V1JjRU11Wks2T2R3RmNySWZQSUY2T3pBeTZRRzhSVWliUllUWUNGY3RVQU1r?=
 =?utf-8?B?NjJzWnE1ME1GemR0UHdzd2dPMjNuSklsSGQ2M2tVY2dHZHB5N1gxMGdmRzNn?=
 =?utf-8?B?S21qY0Jjem5tYk1yN3hUNXhMSlRteHNrRG1BdjVRMWRieFBEcEMyaUJFR0lt?=
 =?utf-8?B?SWJ2ZW5GU0RSbGVIdjczTFhiN0g5RHNKR3BlSUNKYWpCWkhQbXdFcG8yU01F?=
 =?utf-8?B?aXd1SllxNmtkRTl3ZkhkT2RsZVpRbnNHQVZ5UjlVMExGZFpqYXdNNy9SQmUx?=
 =?utf-8?B?c2ZMVWZUSlhsanZpZ1J4OFcweU1VOWZleGhIQ3lFekdGS1BsRzcvcElxWk8w?=
 =?utf-8?B?N1E4azllRWQ0Rk5BZkY4dU92NHdFS1hrVGl6U2UxOUJRcVNubER3bG4yL21O?=
 =?utf-8?B?L2RLSmUxbzhONG1XbG1LcUhtR2NNTE5vRCszQVVPUU8zaCtXbGRVaVFDWXBp?=
 =?utf-8?B?L2wwc0duNDZGY1VRblRtMlEyVVJ1TXIyMCtSbXc4ZThPTThHN1hFVVZsZ2pZ?=
 =?utf-8?B?YU42TWM3VDFYRU1qak9tbU01WE1GdjlYNzNTV0doUmZ0MElMTHpGTmt4M1dN?=
 =?utf-8?B?eHNSbUROUXUreXQ5ZElISStyKzFnQk9HcVFvUkhjRjg1SnIyTC9YZGNHckpa?=
 =?utf-8?B?OFZmM0taenppekNYUDM3VHJtYnMyMmVVU1BmV1l1bjE3bWJoV3gvbklUUWNl?=
 =?utf-8?B?a0hEMk5nNm5RTXc1ZDYyVnFuMTU4NnpRaTF3UXJiSEdDTW91SFdVRk5UZS9F?=
 =?utf-8?B?dlI1ZXF4WDBjMFk1dHVFQkJNYkpXc0s0T3B3eW53TS9XS1ZaakRnUUtrdFkx?=
 =?utf-8?B?QVhwTTRZMDhkd2pmWmFkT0YxY3Q4TUs2THExTm1vc1E0dUlmT3BEdElnLy85?=
 =?utf-8?B?djgzRHg4ajVzbzlrR000VDVhMGJLOUkxYVRuQU1IaEt2NFUzcUthbFNmb0JZ?=
 =?utf-8?B?R3VDaUljTWlIV29GcStOcTAwaGdjeUxjZTBvM1kwU3p2MjJZcnozRzZQa2pG?=
 =?utf-8?B?K3lheTBrZUFFZTkzTHF3NlZ1dUtKdUJKbjRFOHBROUVlZENZYml5aWw4ZWZm?=
 =?utf-8?B?WHp4QWJXYXpFVU5KTXNwQUh6eDFaMEJoQmlmSnJ2VXM2czk2ZWFCemJ1WU1Z?=
 =?utf-8?B?YWpSNEMwTlNsTTFBMVRZQURkNXVuc2RJTnE3emlNTXpxaEZHNjlmZkw5L0Qv?=
 =?utf-8?B?a0xLUGU5MEtVdnQveFc3TlVoM2FJWWhINk8yRE90OVFOZjdBNjRFY1dzek9C?=
 =?utf-8?B?SWhuOTlvSTFnUUtXSndvUzAyOHNIOGZHZnk3VTBTQUFpcC93dTBjc2kwUjJB?=
 =?utf-8?Q?er1IDJB4m+dxR3H0l4aX6Jj+S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59AF9FA17371044F93ECA267EB56A253@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0d9658-206a-4b91-757b-08dafb6c873c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 05:01:17.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2GbBl0QSmeW0F0mpR6MD49Xsi+WiKWFvhgkSu+G8eJBWXPFQnzfRl4sPJ9x3Qv24CRNDlT7bQQPg29n2VtGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTIwIGF0IDA5OjUwIC0wODAwLCBzcmluaXZhcyBwYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBGcmksIDIwMjMtMDEtMjAgYXQgMTc6NDAgKzAxMDAsIFJhZmFlbCBKLiBXeXNv
Y2tpIHdyb3RlOg0KPiA+IE9uIFNhdCwgSmFuIDcsIDIwMjMgYXQgODo0MiBQTSBUaW0gWmltbWVy
bWFubiA8dGltQGxpbnV4NC5kZT4NCj4gPiB3cm90ZToNCj4gPiA+IFRoaXMgYWRkcyB0aGUgUENJ
IElEIGZvciB0aGUgV2VsbHNidXJnIEM2MTAgc2VyaWVzIGNoaXBzZXQgUENILg0KPiA+ID4gVGhl
DQo+ID4gPiBkcml2ZXIgY2FuIHJlYWQgdGhlIHRlbXBlcmF0dXJlIGZyb20gdGhlIFdlbGxzYnVy
ZyBQQ0ggd2l0aCBvbmx5DQo+ID4gPiB0aGUgUENJDQo+ID4gPiBJRCBhZGRlZCBhbmQgbm8gb3Ro
ZXIgbW9kaWZpY2F0aW9ucy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGltIFppbW1l
cm1hbm4gPHRpbUBsaW51eDQuZGU+DQo+ID4gDQo+ID4gUnVpLCBTcmluaXZhcywgYW55IG9iamVj
dGlvbnMgdG8gdGhpcyBvbmU/DQo+IE5vIG9iamVjdGlvbi4NCj4gDQpBbmQgbm8gb2JqZWN0aW9u
cyBmcm9tIG1lLg0KDQp0aGFua3MsDQpydWkNCg0KPiBUaGFua3MsDQo+IFNyaW5pdmFzDQo+IA0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFs
LmMgfCA4ICsrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3Bj
aF90aGVybWFsLmMNCj4gPiA+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVy
bWFsLmMNCj4gPiA+IGluZGV4IGRhYmYxMWE2ODdhMS4uOWUyN2Y0MzBlMDM0IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFsLmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5jDQo+ID4gPiBA
QCAtMjksNiArMjksNyBAQA0KPiA+ID4gICNkZWZpbmUgUENIX1RIRVJNQUxfRElEX0NOTF9MUCAw
eDAyRjkgLyogQ05MLUxQIFBDSCAqLw0KPiA+ID4gICNkZWZpbmUgUENIX1RIRVJNQUxfRElEX0NN
TF9IICAwWDA2RjkgLyogQ01MLUggUENIICovDQo+ID4gPiAgI2RlZmluZSBQQ0hfVEhFUk1BTF9E
SURfTFdCICAgIDB4QTFCMSAvKiBMZXdpc2J1cmcgUENIICovDQo+ID4gPiArI2RlZmluZSBQQ0hf
VEhFUk1BTF9ESURfV0JHICAgIDB4OEQyNCAvKiBXZWxsc2J1cmcgUENIICovDQo+ID4gPiANCj4g
PiA+ICAvKiBXaWxkY2F0IFBvaW50LUxQICBQQ0ggVGhlcm1hbCByZWdpc3RlcnMgKi8NCj4gPiA+
ICAjZGVmaW5lIFdQVF9URU1QICAgICAgIDB4MDAwMCAgLyogVGVtcGVyYXR1cmUgKi8NCj4gPiA+
IEBAIC0zNTAsNiArMzUxLDcgQEAgZW51bSBib2FyZF9pZHMgew0KPiA+ID4gICAgICAgICBib2Fy
ZF9jbmwsDQo+ID4gPiAgICAgICAgIGJvYXJkX2NtbCwNCj4gPiA+ICAgICAgICAgYm9hcmRfbHdi
LA0KPiA+ID4gKyAgICAgICBib2FyZF93YmcsDQo+ID4gPiAgfTsNCj4gPiA+IA0KPiA+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYm9hcmRfaW5mbyB7DQo+ID4gPiBAQCAtMzgwLDYgKzM4MiwxMCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGJvYXJkX2luZm8gew0KPiA+ID4gICAgICAgICAgICAgICAg
IC5uYW1lID0gInBjaF9sZXdpc2J1cmciLA0KPiA+ID4gICAgICAgICAgICAgICAgIC5vcHMgPSAm
cGNoX2Rldl9vcHNfd3B0LA0KPiA+ID4gICAgICAgICB9LA0KPiA+ID4gKyAgICAgICBbYm9hcmRf
d2JnXSA9IHsNCj4gPiA+ICsgICAgICAgICAgICAgICAubmFtZSA9ICJwY2hfd2VsbHNidXJnIiwN
Cj4gPiA+ICsgICAgICAgICAgICAgICAub3BzID0gJnBjaF9kZXZfb3BzX3dwdCwNCj4gPiA+ICsg
ICAgICAgfSwNCj4gPiA+ICB9Ow0KPiA+ID4gDQo+ID4gPiAgc3RhdGljIGludCBpbnRlbF9wY2hf
dGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gPiA+IEBAIC00OTUsNiArNTAx
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkDQo+ID4gPiBpbnRlbF9wY2hf
dGhlcm1hbF9pZFtdID0gew0KPiA+ID4gICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IGJv
YXJkX2NtbCwgfSwNCj4gPiA+ICAgICAgICAgeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5U
RUwsIFBDSF9USEVSTUFMX0RJRF9MV0IpLA0KPiA+ID4gICAgICAgICAgICAgICAgIC5kcml2ZXJf
ZGF0YSA9IGJvYXJkX2x3YiwgfSwNCj4gPiA+ICsgICAgICAgeyBQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfSU5URUwsIFBDSF9USEVSTUFMX0RJRF9XQkcpLA0KPiA+ID4gKyAgICAgICAgICAgICAg
IC5kcml2ZXJfZGF0YSA9IGJvYXJkX3diZywgfSwNCj4gPiA+ICAgICAgICAgeyAwLCB9LA0KPiA+
ID4gIH07DQo+ID4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGludGVsX3BjaF90aGVybWFs
X2lkKTsNCj4gPiA+IC0tDQo+ID4gPiAyLjM5LjANCj4gPiA+IA0K
