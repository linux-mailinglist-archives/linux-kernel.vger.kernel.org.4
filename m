Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9636D1360
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjC3XjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjC3XjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:39:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B044A27A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680219555; x=1711755555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ehZiZ4O6QZGqNCZjzt4OgyucO1/ZNToih4TIstkYlU=;
  b=VXliehuRieRMweCHoOh7AZSYC+3hCSOXhV0mVA0zzurS7UGFEca+bw7X
   +frEdLsgvOLGB9pG6PGBFCGNGZFKhCT5M5lGYXS1vt18WSONA3/w3ZJmo
   ivmYyjOlFqWuotBep+5lJEFAq/PTt9F/oAWR8duQrvNqjSotTmYqDqKac
   ECzB5tnShprRSQZPusVQ6LIpJIOsh6xEm05Wnwy/rx/YmK/v+d2RTPXy+
   fUSc1+3HO+1JhSLgSkNIZ9EI5IwjYHsIcxUroK1t/bdOxxzp7wT0N7HGQ
   75ak4cNytRgKc33s1LxHK9zy6qx3RgeqKx9N+1rVzxEegen6Apck4+GU3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320965534"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="320965534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="749400797"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="749400797"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 16:39:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 16:39:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 16:39:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 16:39:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 16:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpfHsbcpB3n5Swp4G+JUN0T8Iroby//lWA1kBJujMsFptC07T5d9aMrwJoEzOYaO207+hc/cZopdFjWZykmU/DuSwlbs0xEFFzv10lIC27XfkwYRB969DNuN/Qx3dhUBR81yRMVA9CZk33nUZLiuch6VlsxroWTxvwiXk8FxhMJ9QSRYHizbP9+XY0sWRU5aB241AvNlyW4BcB88Wpc+UHWNCDFmuoHkUjhPNHvbcGJaOAH2gS0akJLXsY0CN2KOwDPLcMV1aAIq1b4wH7ZDcCo2V+l3lNfajWGcAQb9Cp2wlYkcuU2AiomupV5BxvnZHzvyCahtEXPcPqJJx71YrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ehZiZ4O6QZGqNCZjzt4OgyucO1/ZNToih4TIstkYlU=;
 b=SBnB7pFlTvHSOINSG9CREE7vCPOmN42d/JAV/xFEn5I+WKpUxnZu/6ctvjPPRAdWQGsR/GjQqzpkfIgm0NwdE60p99r8LK6kNpQ18EbZoHHXWJ2hpwQnCYsFCqczwVCV/S7bWUPHDGCAxQutDyWY1rra1lhjkLuJfDr6bxCk7wjqqZ+pTePaNbu8Slu3TYsf0Q3GGZFsxFYaOeeEnyTAXudfJYm3KeCv5BmoVSumFRMQvFeE16x2PGvr0aw2V9rl6V7TK7foGlJyHoYzAQLHw4xOJk7qgUL/AmayeV7om7OW00OP9iQwm79LNEoDZ8GOintn8dwQOyNu/0l6aiXZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 23:39:12 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::aa54:8eec:9759:6285]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::aa54:8eec:9759:6285%5]) with mapi id 15.20.6222.028; Thu, 30 Mar 2023
 23:39:12 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "zev@bewilderbeest.net" <zev@bewilderbeest.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] peci: Constify struct peci_controller_ops
Thread-Topic: [PATCH] peci: Constify struct peci_controller_ops
Thread-Index: AQHZYP3/K2BuhXp/0k65UfwobU5pvK8T/6oA
Date:   Thu, 30 Mar 2023 23:39:12 +0000
Message-ID: <f86178f9c276fe2d242d7f99b31c94459d65ed1f.camel@intel.com>
References: <20230327224315.11135-1-zev@bewilderbeest.net>
In-Reply-To: <20230327224315.11135-1-zev@bewilderbeest.net>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|SA2PR11MB4859:EE_
x-ms-office365-filtering-correlation-id: ab693784-902d-4e7b-e284-08db3177f741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MDi77eJ2uelLgel3rO9SMXWfNtTgZ/jEhDbKoZoSxL6SOR7AhR9US2OsdJbkgKi624/ZsRy4IWkDgwQfWE+iQU1Yw4GW3lX3sVt/aUboxyRj2Vvd4MGwIfMm8RywUrgzSFc/fKTpaeeOU/5z7oV0Aj/s0UKH4Uw87MlIVKWHcPFIaBP3/F7kFws9McHMczOQb4yEbCnfG9tN0Y3LYqPE10ZAsfj6lx0jLo0n5dB2ZNpGjgxoTa+Cwzrw1WKCQx6JZ9/czo3KjQ44Ndw5EAh7Q9Gql4xlsyBTbH3WekjxFgLzpGI+JQhzadrR6JJB9SbLgDKH1/+nojuG2utuW8noe2vbmPQKkoKVZzVDw7H4ZeACpqVXuHpo3AxjcJKtdZ+L6zkk+fAIKE2mF4YAj9FjswHQr3cwuEXV1RQ5w3xuLXbUL0IcdQrYC4CWtI/tQRC9vOhiR66DtnLrc0Oa/RDdXprusefolsnHHb23QLh3CU4PVIurPik4Byw4nlnSY7/Loi3L2KQbohaYk+Axuwf/YmoTdLBm/utQoSVAkfHhQsSgRmRbzUOiT0jrKGWBIlQC3uHwQ2pLFeYqs5m8yEWnLaaji5lAozrRg1LcOR1eYGAR3ST/Mzz5oa7g0XYznVnR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(83380400001)(122000001)(82960400001)(26005)(66446008)(54906003)(316002)(64756008)(66556008)(71200400001)(36756003)(76116006)(66476007)(66946007)(8676002)(38100700002)(4326008)(41300700001)(6512007)(91956017)(86362001)(6916009)(38070700005)(478600001)(6486002)(6506007)(4744005)(8936002)(2616005)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blVOR3E4Zi96cEltUWx1YkZmVXAxOW0vQ3M4WkNxTGNXa0V2NXdpOUJTbkdm?=
 =?utf-8?B?aXdhWXVDV3NmZ0h1SjRxTWRyS2hCRE1hN08vZURLYTU5a3VCNjRsbkE1aWpo?=
 =?utf-8?B?aDRIZGJzeE5JdEtUTTF0cktpMDAwakFUZUpBRVBJQjQ4N3FHM1dtdTlWT3FH?=
 =?utf-8?B?dDdGelZ0MEdhbElGSDJwWnZEOUkwVVpqOFhVWUdWdEtmMDdjUUllOWdqMGJF?=
 =?utf-8?B?NVF1WlVWMGZPdWZwY3B1aWkwTVpTZEgrNVNDZ2RDQUpMSXQwN1pFc0UwY2wy?=
 =?utf-8?B?NUhKOUxDbFptZWJOV2tZZTQrY3dWQWtGYmJlNGcycWxHRFZNdUdPaFc0UFhJ?=
 =?utf-8?B?eG0rTzU2cjlIWkZ4eVpENHh4aGQ0MlQrZ2diNG04S0hPZTEzZURSR205Rko1?=
 =?utf-8?B?YU1iVERQN3ZNVFI5YU54S0ZQYW9ZRW9IRVJWODQzcXJoVUg1d2dXOGlERTZF?=
 =?utf-8?B?VkI4d2RnL1hRWUJyMHMwcHlzWkFIb3ZsWUd5RlJoZ3JHbGNtbmFweFpKMVBV?=
 =?utf-8?B?OCtGRWw2ZDJJbURZN1dQSzZUQ2kwMFJmL0JiWVgzcW9VZFhJOU5DWjlWNzdC?=
 =?utf-8?B?TmdTb0hXUXNIbml3NEVTUWsrSE01YmJzWFk3U0J3SEpBaStDNWliUGMrVEFE?=
 =?utf-8?B?YUtCMHhoL0VaT3BrUEdGTWRjQ3d2eE9NVUdSaG1wR3dVc2JxS2R4ZWFOMVli?=
 =?utf-8?B?YmU3Y3B6bnpLY1lMZVhCdXV3dERqS2VEbjZNd1FoTkRvWllHTGpRem1oQk1U?=
 =?utf-8?B?dmV6UC9ZZktJUWM2aHgzbk5YWDh5ck5TdDdXWmVlRjRmZXJPWU02TzUzMG96?=
 =?utf-8?B?NUY0aXBqK1hqUkc1dEpXcnJKbGx5T0RtSitlZFptTTAyYlUxSDFHdDNUc2FE?=
 =?utf-8?B?ZHBFRUF2elRUYllXQWU0eTFRWXR3TkxxV3kxcHdobmxOQXBPYjljK1pjei9T?=
 =?utf-8?B?dnpSeUJnT3F5ODVmMjhRa1RIRGs1cjIvRUZCSEZkK1ZaaHl6eHBpNWFvR3Fi?=
 =?utf-8?B?ZzM5Ujg3ZW1pRXRaRFBTOEdjWER4MXljY0xnZ0x3Y2pZUTBBMGJuQUJNR1ZP?=
 =?utf-8?B?WVdNVWF2R0t4aGVOSEc3cTN3UjZJU2hjTzIrRXA4eGlXcm1vcFVxQ3RXcW5J?=
 =?utf-8?B?Z2ZBVkZ6WWlXK0o2aUxvSXZGM0hoVmJkTEVaWXM1YUI3VW9hWk9RNFdQN2hE?=
 =?utf-8?B?VEJ2cnhjL2J5cDh4ZXNzeGovS1FmZHNoRExwRkV3RCtvM0Jvb1NhUVhFOHdk?=
 =?utf-8?B?dHcwSE5XSEJVaWYxYVhLaFY3dll2SjdHQlhuT3NFcDI4MDFIeHNrV1BKdjdk?=
 =?utf-8?B?UkJ4QTFEQ2VyV0hwbEplY1lmN2c3Unp0RjdoWm8xWEd3aTY2ZWU1OHMzQXZh?=
 =?utf-8?B?SFhWRytpQ2psQm5GQXdSbDRDQzhnQ1ZsRkdTMHFhSlNsK293eE5EWk1FRk5W?=
 =?utf-8?B?czNrc1VEeU9NUHNEQWFERzVrOW1ZR09iai8wQWJaTGw5VUZyOUdKd1YrdzlP?=
 =?utf-8?B?aGd6SVdvaHJqRDNTYk1RbWxwTnRSL1R1cm5RZkRvN0lNUlFlVXJMSmxSaWF5?=
 =?utf-8?B?d3BoSmw5Y1FHN1RhSitQRlhoYytiQXhrQzViekw4RzNlUjdxNURreGJhUmt1?=
 =?utf-8?B?RjUzaEpSekhxUlBQMit4dlBXRlY1VndUY1JrZ0VRZFpBR1FuVWZ1OHQ1MkhF?=
 =?utf-8?B?ZThlcittd1pkY1MwclR5WFlCRzhkMHRSYWdGZE1Bdk9nN20yTGVsdEsxZWF5?=
 =?utf-8?B?WXl1U2M0TDJlNzVHM0Jzd0haYVhrMktlSTVEdEdpZW1ONDNqUTdieDloV1RF?=
 =?utf-8?B?ODNZc2JScnV2R1R0MnVHd0VDRlBUSSs2RTdzRGxrWGxVYnhEMGF2VnR4Rk9i?=
 =?utf-8?B?SHlua2xjQzd6Nm9pTmd0QVEvd2ZLOTduYWxwQ3doVDVvQ0dNSWhqbWZucEFx?=
 =?utf-8?B?UXVRc3JqQ0E2OER6NUdLREF0cHoxWDFrWWdpRWpQVnYyTmNTSHVTbHlHSFdL?=
 =?utf-8?B?S2VmWEZxZG1KZHhvOENLQnZobTB3VGZOMUkzNmFSVmp4aWRZYlJZMzIxMXZU?=
 =?utf-8?B?SVByR2RtczhxOVRsQmJUK01CdU9PYkp0YWlySWNuRm5FOTlwL2NIVmplSTlr?=
 =?utf-8?B?UjZIbzl1SEJsMXBxSUd5cmZzYzdqelRxL2ZjenU2RCtTUEl5NFRNY1JUc0ZP?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93EE3D73519C9D42B8342E6642737769@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab693784-902d-4e7b-e284-08db3177f741
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 23:39:12.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Du+51FAqqOlynxWQBVIQjawpLuAJdLt4fQ3UBMVOSxEnu8hhDE4tgfPCR1PS4uFZP7UcylE1u9nmtkUP0ghVWUoDecRynSp/MmjmoK2vIKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTI3IGF0IDE1OjQzIC0wNzAwLCBaZXYgV2Vpc3Mgd3JvdGU6DQo+IEFz
IHdpdGggbW9zdCBvcHMgc3RydWN0cywgd2UgbmV2ZXIgbW9kaWZ5IGl0IGF0IHJ1bnRpbWUsIGFu
ZCBrZWVwaW5nDQo+IGZ1bmN0aW9uIHBvaW50ZXJzIGluIHJlYWQtb25seSBtZW1vcnkgaXMgZ2Vu
ZXJhbGx5IGEgZ29vZCB0aGluZw0KPiBzZWN1cml0eS13aXNlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWmV2IFdlaXNzIDx6ZXZAYmV3aWxkZXJiZWVzdC5uZXQ+DQoNClJldmlld2VkLWJ5OiBJd29u
YSBXaW5pYXJza2EgPGl3b25hLndpbmlhcnNrYUBpbnRlbC5jb20+DQoNClRoYW5rcw0KLUl3b25h
DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9wZWNpL2NvbnRyb2xsZXIvcGVjaS1hc3BlZWQuYyB8IDIg
Ky0NCj4gwqBkcml2ZXJzL3BlY2kvY29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgNCArKy0tDQo+IMKgaW5jbHVkZS9saW51eC9wZWNpLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgNCArKy0tDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo=
