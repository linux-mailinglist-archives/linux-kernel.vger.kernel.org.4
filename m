Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0AE73B3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjFWJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:42:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7091A3;
        Fri, 23 Jun 2023 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687513358; x=1719049358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VsEVViVyNFUPenRNPj2Bao+MlJTyl1Eg3+yOiev/wfw=;
  b=l1+TprcaUzcM1BNe5AM2vvFRb5A4i011lD1kFmYQ/YpiqeixKJimWitY
   nSXipK/fCIL2QXqdSMb1rSYAcrlLyaXlXUgsx32t3HPsDEp5tK0JK/jb3
   TEjPnHgbtscDRZI/56T0T7H4aAQ0UwIFL3h9BhkWetQXFBja/nvMx29d9
   nT0KuEB1rpL8CAs1I+M6bxHlQ0911Lsm8+7Yhz1XB7NU/ovEgzgY5HA8h
   QGrKLTJLGZ/B0FdPEvdEfbVs20SVD9wmY1uqS9VrzR9jIWpIOCvjP7TM/
   YHMuJM7o39+h8MMHhL1FMcr9HG9HYR0ewBjdV8n7Vef5V6HbGD+tEBWdE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="341065344"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="341065344"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 02:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889415510"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="889415510"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2023 02:42:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 02:42:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 02:42:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 02:42:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 02:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuzPtMwLVS39arXCd/XSDzS18lL0uhdXT8LcdLzMmejlJFXe/29XwVK6HeLyoHBx9W/mMO8L0S5zBQpO29mQFse3GSle+G0q0XyPOzj4Q5y07mdN8DkAKTdEpPjDR7rDk4qLqkd4h8rn46NY0GDEb7UQ39ufGlPnBlH+vIYukuuSPpKktSWSTdrnlfyj1cNrawMzDdb4m0+haayF/WIcwFjfXNX0SQsuum9hwSTgYQ2MEJRFOOHeyx4YeTgFn/NeJjrU0oMNYG2qiYoxPcjITT7SZJGJkPs7s0gYcBfbO2IaiZIqPetmCFI+47SESsJL1eir8p5YleklGfQ3uTB2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsEVViVyNFUPenRNPj2Bao+MlJTyl1Eg3+yOiev/wfw=;
 b=Fb2g7WtFyX2yVJRpwciRnT2ypQKNAwluYvvxp+CREWB+NL/fqu6KQpc+i6sQPP5xoIaghac1k5hP9wMIBBZXjUM7GNKYnHh7FDwfGOtBMEY/q9J/hTN5SmxDAoUa6JHPsSht+2nTZKRTVMmBkkTmeSuTb8blhYDnisjYyUn3ZuEL67OuDbApI7aT/zawx96xP0Lf1SSxG4zOgy2I5xlo9PD3TXdu0UlcPtaY1Fog7VnrUEmKknVBHoIt7kSB4YtDKHZGELVOFoF2w0elzbGEb0SvA/0V3QrPZn+5xr9tYuWV2P2Z3FoZ+NDOGXjcuf/Gr/dH91lFYEPMNiVxzFIdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by BL1PR11MB5430.namprd11.prod.outlook.com (2603:10b6:208:31e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 09:42:30 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 09:42:30 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Topic: [PATCH v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Index: AQHZpQYX5LhGqUR0c0CN2skh+0CNC6+WylQAgAFZBmA=
Date:   Fri, 23 Jun 2023 09:42:30 +0000
Message-ID: <PH0PR11MB56730E97D182D413C9B555E1CB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230622123432.593548-1-kah.jing.lee@intel.com>
 <ee1779cc-fe9e-d529-3188-4feef8f27b98@web.de>
In-Reply-To: <ee1779cc-fe9e-d529-3188-4feef8f27b98@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|BL1PR11MB5430:EE_
x-ms-office365-filtering-correlation-id: b8b3c622-a528-486f-eea0-08db73ce299b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqefW7qR0fOtBHoai+QrHxAnOmJHLje/vA3kg66E4bG8EDdY8HQhbf5o9y4WSYZ1sA+HxkNnTMOpVWyt2KPAt0gedzN97fkpv3iJLyKtBsn2u2FsAdBZZ1ycWOqydJ5nsmTkOBGzs70LSWe3fKIh7EmDpu61aYgvlg9czJPHyte2ta2Nax/E2fZeNSHP64IawTNNQhV+u85plIF5YITb0/v0zqa6grdd4slWxgm0L6QNEjAHPJyfxXNgwLDknuDfeIY9a73EHY4gLjxPcaP4zWW0iTbpHm4cpfhUiPyzZUQi/lOJNgo0RwQS8oAxO3+7GKaPgVqaRoV7XbPIuotyuL/a09B4UKsVipU4/HFX1bI1A1N/JAuRkzxg5U4Q+XdW7kcswZ58P/71fJo9D1XPk86y0j3fwPGYf2xcW4aoerJUONtQ+s0jMXoOhVaisz/10gCJi/zrnXPRtFi665ES2w2PRDyQrmvcsLj8B/ygLIZE+DNsgb1GzGOs+sPwoaOebFGsMzJk5zn9weTv/W3jDNurr1DeO2alDM9vWU41jqCR5pP6q4etpC5cxClyvWQwc5tQ2Al3fTiC1BsiB4z14RrQCHK1EyG16zGc7drnLnPHz+E3PlFW7ujA/OEr+hdG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199021)(478600001)(71200400001)(966005)(7696005)(53546011)(6506007)(5660300002)(15650500001)(52536014)(110136005)(83380400001)(54906003)(4326008)(76116006)(66946007)(64756008)(66446008)(8936002)(66476007)(66556008)(8676002)(41300700001)(7416002)(33656002)(2906002)(26005)(186003)(9686003)(38100700002)(122000001)(921005)(38070700005)(82960400001)(316002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE8rOUVjaVpRRm4xV2svOExKcGRqZWlHRGRkODBMZXRld0o2RTJEN1EraGxT?=
 =?utf-8?B?WkZSMjFDR1o4RTlaYmRYbFFaV2V1NE93YUtSRjJObDZVbExJRWtCUSt2OUpq?=
 =?utf-8?B?b2F0TFdiTGdTbEtyNGM4ejBpOXZYOG43NHBhSlJpcUFkM3dDWnlBakpFazEr?=
 =?utf-8?B?NmdBQkFJdFhab1NlbDBOYkYyNE92dEJlL3VYSkhTU09zRTIwaVYyUkcvZStJ?=
 =?utf-8?B?YWt4MTBDWW1QRkZ6S09LOTB0OGllbHFudzBWM0VEOGpBNkpLRG80Z1l4blpP?=
 =?utf-8?B?bWZRNE1jQnpmOWROL0ZkcTVuY3g4WUdxRDhtUUd1anNFS081UnBEcTNLTzh3?=
 =?utf-8?B?YUJXcDZsWmpBamFPbE80WUh6b3gwOHJLRm16WE96d21qRitkbnNIdXc3WVFN?=
 =?utf-8?B?eTMwbkN3alJzU2NKMVlvQjYzeEgrZ1dRKytFaHorR1MyYUhUQVVHK3o3VU5p?=
 =?utf-8?B?dEpHWXhZWHlMN1R5MEttbjZrR1ZiNHhia2V5MkdwUHlTRFVwZ2NYdU9wZ1FX?=
 =?utf-8?B?ZHNqVmwxcmV1SlVyRkxIaFk2Vk1nZnk1cDNieFVEOEhsb2ZuRlAwK1JtbFZh?=
 =?utf-8?B?cFhHSWplWjBOM0RRa1l6NUtuZEl0Q1NuM1o1M245bk9NeE9pckVYaWJOcWVJ?=
 =?utf-8?B?cSs1MnVyc29KcVJOKzhSNWFyUkpuc3VXODMxcjIzZ2RVNi8wZTVtWjZPc09t?=
 =?utf-8?B?SjZyL0U4MENxS2R3VUgzbnZWbUpSK00zOEI0MVVkUkM2WHlPaFd3UGlVdTU0?=
 =?utf-8?B?VU1yQ0xLZG5hbnRwSkI4akNUMS9tWm1VeDR1MjVqWXo3VXNPTnhpU09vTVlh?=
 =?utf-8?B?MXFiaGtpaDVLZnRWejhYWVdXdytoNmEzbmJ6U2FPcWJjK2hDalorZ3JwNHdM?=
 =?utf-8?B?VlhicnArdlJxNlhPd2MySFNsbFQ1Q2xiR2ErcXlXcUVyTjB5bytJVVRnVUhN?=
 =?utf-8?B?YmF3bkFYc2sxbWxOSFQvKzRQbTlRZFVrbHJEM1BuZ0ZOSjJIUjJSWE1HU2Q5?=
 =?utf-8?B?VWV0S3ZMQy9iOXJFUk5ZcHBHeXVTV3FDY25IbVF0VGZIWXNXUXFPb0E3Q25w?=
 =?utf-8?B?bW01dXVzeld0c2FtVDh1dmJobk1JZmJLdW83UHZRZ2RJajNZcStnbTd0RTQ0?=
 =?utf-8?B?UExtQjV6aWx6V2c2b1k4bzRvaFVIVVJMOVhyTnV2Qkc0SDJlWWlqb2JsSGhT?=
 =?utf-8?B?WUVucHJjU3N1ZTI2d2NDZkptamh1M1RINmNERHQrRk5rZksreC9KS2l5SE9J?=
 =?utf-8?B?YVZFTWVzTWhoL2JJTUNDWHhPOTFwNGFEeHJkUlMrWExrcjJYamZiS01YT0FQ?=
 =?utf-8?B?b2lwcVREWVR1eUZnSEFjaldoMzRMczRJR3MyQ2s2VHhSYWhleDZETW5DeDBK?=
 =?utf-8?B?bHJ1MFR2MGhTVzlyWFJLNk11U0ZjOVROOWdLQko2VnlJT2pFZVFySEsrZkd4?=
 =?utf-8?B?YnZOY3JPNjVwTlVPck9lcUN2VUJtdjZnWHhmeUlTMzNKeldCSXY0ZmpQdmJo?=
 =?utf-8?B?Q1IzeWZqbFUwUzk0ZTBYVkhGNllCak5TQkRzd3pwcFY4ek9kZVIxWEpVVUJG?=
 =?utf-8?B?OWxtZkk2YlR1MkZrYkFCTVJROTRBckUvMHVTZVF4bzNFMjdxMzZJVjlvZXB0?=
 =?utf-8?B?NlhBUi92VElnZWliRmdHOFhaZEVRdnBFWnhqYmg5RjgxZmVGbWI2K2ZNS2hC?=
 =?utf-8?B?QmVLa3pVWEdUMTBQaHhlS3NxQzQ3TUxkclNRZEE2SjZ0Q3VFSFlobjRmTDRF?=
 =?utf-8?B?WnU4a1B3UlUzNTF2ay9PSXBpSTNDcGFiN1Rwb3dyU2NGVytub05BSUJDaDd6?=
 =?utf-8?B?U2JuWkhROVRCZkpIN05SUGdNYkFuZlJQYVp2SXkrdENJMEhDc3NNbTYySm54?=
 =?utf-8?B?a0ZrcytzdWFuZ2p6cFFLM3UzcW5IRXRQVUdLVkFWK1gwNjlXSTZWZk42eXZx?=
 =?utf-8?B?d0VydStYRkg4WXhaelFpZEUzUHZQYkpocVl0aVllYlpoWnBBUFVxZUFCb3lE?=
 =?utf-8?B?RmZHYVZ6REZDd0tJamxhVkV1Tmk0TGlOK0l0VFRZSWpqenp2SElhWUg2UHNn?=
 =?utf-8?B?QUlFaEYvcnprakZGU0QrMCt6UDJrQlI0U01YZUhsMDhtbTUyZk1WclBURDJo?=
 =?utf-8?Q?hwYowdOI+T+f/QJFRpqR1gFHL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b3c622-a528-486f-eea0-08db73ce299b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 09:42:30.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZMSATO534edFj+S+xZSn8a/+Q02VcMlP/H9pvBCaVUGu0hE+PfjPnP0h3LK7y4rzAEM68ez6diYpwIZYn0c+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5430
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgMjIgSnVuZSwgMjAyMyA5OjA1
IFBNDQo+IFRvOiBZdXNsYWltaSwgQWxpZiBaYWt1YW4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGlu
dGVsLmNvbT47IExlZSwgS2FoIEppbmcNCj4gPGthaC5qaW5nLmxlZUBpbnRlbC5jb20+OyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsga2VybmVsLQ0KPiBqYW5pdG9yc0B2Z2VyLmtlcm5lbC5v
cmc7IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+Ow0KPiBDb25vciBE
b29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBEaW5oIE5ndXllbg0KPiA8ZGluZ3V5ZW5Aa2Vy
bmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4g
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBXaWxsIERlYWNv
bg0KPiA8d2lsbEBrZXJuZWwub3JnPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47IGNvY2NpQGlucmlhLmZyDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBh
cm02NDogZHRzOiBhZ2lsZXgvc3RyYXRpeDEwOiBVcGRhdGVkIFFTUEkgRmxhc2gNCj4gbGF5b3V0
IGZvciBVQklGUw0KPiANCj4gPiBUaGlzIHBhdGNoIGlzIHRvIHVwZGF0ZSB0aGUgUVNQSSBmbGFz
aCBsYXlvdXQgdG8gc3VwcG9ydCBVQklGUyBpbiBtdGQNCj4gPiByb290IHBhcnRpdGlvbi4NCj4g
DQo+IFBsZWFzZSByZXBsYWNlIHRoaXMgc2VudGVuY2UgYnkgYW4gaW1wZXJhdGl2ZSBjaGFuZ2Ug
c3VnZ2VzdGlvbi4NCj4gDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1DQo+IG1l
bnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni40LXJjNyNuOTQNCj4g
DQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQpVcGRhdGVkIGluIHYzIC0gQ29tbWl0IG1lc3NhZ2U6
IA0KVXBkYXRlIHRoZSBRU1BJIGZsYXNoIGxheW91dCB0byBzdXBwb3J0IFVCSUZTIGluIG10ZCBy
b290IHBhcnRpdGlvbi4NCkZsYXNoIGxheW91dCBpcyB1cGRhdGVkIGluIG9yZGVyIHRvIHN0b3Jl
IG5vbi1VQklGUyByZWxhdGVkIGJvb3QgYW5kIGZwZ2EgZGF0YSBpbiBxc3BpX2Jvb3QobXRkMCkg
DQp3aGlsZSBrZWVwIHRoZSByb290ZnMgd2l0aCBVQklGUyBpbiB0aGUgcm9vdCBwYXJ0aXRpb24o
bXRkMSkuDQoNClRoYW5rcy4gDQoNClJlZ2FyZHMsIA0KS2FoIEppbmcNCg==
