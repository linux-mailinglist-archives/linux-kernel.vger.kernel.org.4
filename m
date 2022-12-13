Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109D64B0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiLMIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:23:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B8CB4B4;
        Tue, 13 Dec 2022 00:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670919810; x=1702455810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bi6zSaKN2RlQK9PjBT/8Ho895a16nVw/ZtgOy0M33Hs=;
  b=jukxreXKkOOmYpcUyDTm4AOiq06Q0O+V2nbvBzyJSV7Uij+508C8jX1G
   5Kd8EcXS4BIv3BH6gQkM6VPCH3efVvYcZKuJvc2uXG6UER2GqF0URA/G8
   Xs0bYkMnJkRM4O8n02w1R956+YFp7dKGUnPyLg3FlvQSRx50Ol2ZfoUso
   tJL9xUFdR2Y6V3OVrB35TmF88a33YqewBXCaQtZfjDxkrRvD5LsZn8ED/
   iGdZHPdODQIl8JIj6IQ6YVCpWkwshH6YYHXKz7SKITIDQrLdfJt2T8gsK
   gavr4OGQYlefU2qXHlWYs2Y0zZqrkMqxjLKDgLk8yywWKyJI03zvIUlAJ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="192819741"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2022 01:23:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 01:23:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 01:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRStstNXZ+8k9NoWeGVnUKSUCsFHU+2dx500g+5aixyFlGpbc9HzipiXR1AkZ36ew51gJyMzXs0CIVpz7rpJp89deNlL6AP5TYz5bMh5O6BuJ1VQyCGYPF00/gfPu8rdsypOUVm727E736puug1dN8uGeIUntUce6V6frrX0YGlxzBJzIZmGgmS290keXUUasaAKjUqcy5PLmQUvEfaKO5+nbeJUIEZ0FqRwwzjykGutEvlSg4BQ8bx9lb/3hIKgC+c/cYim4kK3m0acxH2osmS5FIb+2sazpF9uFfTEx8dgpQn9FOgonKlTm+hci8udZfFcDdIRjhaxt1azQRU93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi6zSaKN2RlQK9PjBT/8Ho895a16nVw/ZtgOy0M33Hs=;
 b=OS0BKJV40xoyzKmJP71g2zoXJs9T1ivaZNU4kUSrw4NgVQyTEBSuyYUWblWE1bu91l1/PR2lGb1LkHEK8ZLQ25tW13q9LYmUe2T1N52M/xU0DYRN6XyRrMb6idqRHqdkJi0+0jVWlaOj2cAd2WdO8erVEygFUZPS/YAlDSQcygjjH6LdCuVfnNPHKSZojjbP2Yyc229DAAAsAF+tpwBQLfH6feh9XN+N0XcuXbxIJ1L0RL/JxS6II0OV6IkwzijkYT61qLDDj+3IFR6S4aCOsI76YXjJARZC5iW+1VHE5AiMFnmwZ9emOohUvR3txcwINn19LGxz3fHzvsnqa+aojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi6zSaKN2RlQK9PjBT/8Ho895a16nVw/ZtgOy0M33Hs=;
 b=lIuHMQM4mQiQQWlXmc1mTJkuuC9w84nD103OJ1dtuf+MFv9kn9h8me5Gn7t9PKcylE/0s54ozmRk5IaX4hB51+ovfHvL/mULExyFW55x1es6vcAwPxzdXYH0HxtZ+zuspx/Y5RRgmr08WUOva/YPqMrr7Jh/7NFMmDErM/PXopE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 08:23:23 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5880.019; Tue, 13 Dec
 2022 08:23:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: microchip: use proper naming
 syntax
Thread-Topic: [PATCH v2 1/4] ASoC: dt-bindings: microchip: use proper naming
 syntax
Thread-Index: AQHZDswq063COPGIUkSPOg8UFXydSQ==
Date:   Tue, 13 Dec 2022 08:23:23 +0000
Message-ID: <da11ec93-0d66-85f7-739d-ca48103d27ab@microchip.com>
References: <20221212164153.78677-1-claudiu.beznea@microchip.com>
 <20221212164153.78677-2-claudiu.beznea@microchip.com>
 <20221212173245.GA1171311-robh@kernel.org>
In-Reply-To: <20221212173245.GA1171311-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA2PR11MB5067:EE_
x-ms-office365-filtering-correlation-id: f3037064-6e8f-489a-e93e-08dadce34d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RlFRmEd0gAEAu6Mw9fY0M6P1N895ce7mnqTBdik3/ePl/0Ucono9S1CbZkQ0m88nmApzAk+6Y6h2mhM2lC6nswY5i5HTjB+AvloX6HTcM03a46Z+uxNDPFIU8gTk70RaZimif1DqnbU2o6ZBM+klge9vGswJP+w02Lv/p8OluOw8nF+ZS1CEY+bFv7eKfgq1f1ehQfAtpWUbOchjg7lDz8BXY77X8nesqC2QVXLtGDhU6PFC5+dn6uo5PCQJSsO5InALQXlAa4Vbb2DHwqTsFkQp145n5imOHG0obBlcaD+YmvK5iO+vrC8nSjv88s8CuCbstCDuykuW4RVdfuXEYQ19JAQp5/4FfB3Mpyr4xweK6RORSpMBZLsbhTs4D80G7adiHeL0XutBsRShV7h5NcwFAj2uh5E6lSwnobB0BLcWMnt4ryfbHlFH9yYLK8mgl2IOH3SITZsK+Zh6v2qdurP/4a/Fm/8aBM2Znw5xAb4bj0Ld+hoQnB8WuIhcVueYR/JBfK2InedhIJlDd16BtfI1ysrddFg6T7aW6FlCMrD1IE08f6YX9kxdwgOL7BpnbXcVYhMHTCXPCzNIwkyvhYUcmt1jGHB536kjhQskl+i9xzKBhhYkwsKV/QFVPi8uq7tjxHhGSG843Hsf7T1xCsUT1wKIfH1idJvbVMlSX3C5Zx+WQ4o988V8lC7lrY2PjI0JE0AY5Ut1DQcVrkJ9zqIxjbqWOwebAuJWmz9Sl33xugyXIoxqZKIf009foTg4wm3OjhsuCfmZY7KO58srg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(122000001)(31686004)(2906002)(6486002)(186003)(478600001)(83380400001)(38070700005)(316002)(7416002)(5660300002)(86362001)(66556008)(31696002)(41300700001)(8936002)(53546011)(66946007)(66476007)(66446008)(64756008)(91956017)(38100700002)(76116006)(54906003)(6916009)(36756003)(6506007)(6512007)(26005)(8676002)(71200400001)(2616005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGR1QTZBVVZXTm9hdG5BU0Q4VXZZZHhaTTd6ZFVmNUd0M2J0R1RlVUJ6eDJD?=
 =?utf-8?B?c2VJMEZMaUVzM2FpVlFMUnBkdlY5K2gwdTZJZjZVNXJyODZLeUZ5bHNhTXBz?=
 =?utf-8?B?b1BNdzhNVkxPZzJXOExVZFduNzB4eTl4bVlKUml0UWNXVHVVczVCZHZ5anJP?=
 =?utf-8?B?SXdZWi90ZjhiSGlHeWZtLzhpM1ByOHc2WkRwQTllWXJ6OFZwZ2NsM3NLL2xj?=
 =?utf-8?B?ME1POWFRdFNhdStlelB6S3UyaGVrYWg2VEpvZXA1UmY0V0ZDK2pTWFZpakE3?=
 =?utf-8?B?S3BKZGZDU3UwcE5XTVpVaUJhaFZpSlYzc3dlSXpucVFwQ25DT0Z5NFgramRJ?=
 =?utf-8?B?OHJjT2E4MXlqNk1EejFaZ1JncThkdDBNMG1CU0YxNWNleStLY2pwVFQrZXJs?=
 =?utf-8?B?anR2ZWxxa2hRbC9tMUNQQ3BPMEgvSE5ZY0VYb0xYVjd5VEFBRUZQakU1NFM2?=
 =?utf-8?B?OHozSVNIOGNsSUpEUVo0NFZudkNDS2RaTGtydStaWHhkaVFpbTdKRDRTSjlJ?=
 =?utf-8?B?Z1FjbGpFSE5rUU1wS3p1MzAxTjlLN2VMVjZrY211cTNNS2hDVGlDQjlSdmRV?=
 =?utf-8?B?N2hnYUxJSUZLQms3N08veGEyNDlvaHMvV2Q3SUlES2tNNk12VDVLbDZQbWRz?=
 =?utf-8?B?VG9mSnBQTFZRbHkwMTM1QWovdVlVL3ZsYVFZbWNqeitlTm95cDNDNlhxYmxC?=
 =?utf-8?B?TXdjMS91YmpZZXNiNlJvdGlXdi9jUXpqaEVkQUZzZ0NlSTVNN084Sjk0M1BK?=
 =?utf-8?B?bWpSZEFGaVkvRUNXdEV6aDdEVitXRmIxMjV6RDR3SmNXZ3ZHQTdNUWNZaXlu?=
 =?utf-8?B?ejZOaFoxNW1RZ2NMWWJHRFNxQVVneGpoY3RzckNJY0kvVzAzank4U3NSbC9i?=
 =?utf-8?B?LzFsU1B4WDZVS1JMdXlhdzNWbko4aWlHd2dPKzBtVXk1Nis2T3AxVzRQR1ZE?=
 =?utf-8?B?amF1RWlsYUFYcVllMk12dDhJL01RdzQ1YzZkZTRHdjd3S0hteUZCTGlyWDZI?=
 =?utf-8?B?S3JnSy9qcXFMeWJVRXFaRndLVDd1QlZVRTZpRUxBZEU1bHlSbGhONnVNVDVk?=
 =?utf-8?B?MW9LOWV6Q3ZuN0ZCd1plcUt0UGExQTdsNVNLZlhwNGFFVXBxMHZvcGEzQ3E0?=
 =?utf-8?B?K3hxallmaWZISTgvTGxpNURKR01MbXFDN2I3VDUxdFg2RVJYUE1OVmdNY3Fk?=
 =?utf-8?B?azJwc1duRFh6TDhJWkZOSWx3R21UZ0wvTWtwbm01elNmR2RjQkREZGxQc0l1?=
 =?utf-8?B?bjVQZE0zMWEvazFVV1FVeGpEOHFrcDBGMjJubFM3L2NSQ05sM0ZhanUzMWdC?=
 =?utf-8?B?WHRDN2Nva3NZMWZDZFN6UWYrLzA3dE1GZW1GTnV0NkI0aGx4ci9mYndIR0hr?=
 =?utf-8?B?UjVTZFRybWVBV0JJU1BQYUtKdWpWOHVaUUwvazFpUjdpSzM1NFQxQ3pJMjhu?=
 =?utf-8?B?bnJpQU1BakM1NFJTT1pwaHN2L1QrZGE2Z1dxUEoxNUpoYlRIaE50em5DWjJh?=
 =?utf-8?B?MUUrd1ozWjZkSEpNQ3NhZG95MjdIVjNPYXd4VVhNTW8yc3NLRUxTUjFSTVAy?=
 =?utf-8?B?OFowWjhkQld1a0FZV1pkZTh6NExXZTFBQVlCaStuQUNQL0JWQStVcStyRVJl?=
 =?utf-8?B?UWFGMWZJM2Rxb2dxdDVmd0pkQWJ3cTFpZ1F3S2NwcVpZaXdLNjNZZUVodkFL?=
 =?utf-8?B?WlB2ME9NN2lpU0krZ1RIWUJCbTVBamhVam1qaEE4MzBlbXl2bmtTQ3RXTGJV?=
 =?utf-8?B?MjlkY25USnBtaGxSVnVYWGFXd2MvamgydlpJdFJvTlN4RlozYUQrU3NQTjM1?=
 =?utf-8?B?d293Q2tOOUtZdFI2YXRyLzZRUXF2WEl3T1Y5SlRSNnEyM014ZVFBUFhsM1RQ?=
 =?utf-8?B?dTAxcEd5ZFgyNldMNjFzWjduY2JndmhRYVZQbnYxdTVLU25FdFdNaEhlbkly?=
 =?utf-8?B?bjVMcFZEbzZWSDNCRW9xbkltYXU5eU5YUm5jMFFPRitld1lHaWZpL2JmWUVB?=
 =?utf-8?B?dkJwanVsRG1neDhSd1dZMnVSSzZPVWVQUm5Ua1BwdzdCY1JUdStESlVWbnVQ?=
 =?utf-8?B?UUxhSHBLdkw1L08yWkVLVjFlY2VMQXlLdXorZmJDMUs1b0RVUWhCT0M2dnB0?=
 =?utf-8?B?N3lkem54bmhKcHlGTW8rSzY2L3ZQcm9Na0pmVjVJcjFCdCsrVy82THhoaCtl?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1168DA9687D254C8F5ED72C1F4EED2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3037064-6e8f-489a-e93e-08dadce34d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 08:23:23.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Yk55FOABhxrk6Efn6cZV0I1m1OwVHr4ch/QOQDSKkBWIopvhYl1k2Lm3XehWFcy7bxmrUbzWeuM7Z4eEwRQLp1lDTTwrgF1I9DKAMvf7vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMTIuMjAyMiAxOTozMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBEZWMgMTIsIDIwMjIgYXQgMDY6NDE6
NTBQTSArMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBVc2UgdGhlIGZvbGxvd2luZyBz
eW50YXggZm9yIE1pY3JvY2hpcCBBU29DIFlBTUwgZmlsZXM6DQo+PiB2ZW5kb3IsZGV2aWNlLnlh
bWwNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9zb3VuZC9tY2hwLGkycy1t
Y2MueWFtbCAgICAgICAgICB8IDEwOCAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IERlbGV0aW5n
PyBXaHk/IFRoYXQncyBub3Qgd2hhdCB0aGUgY29tbWl0IG1lc3NhZ2Ugc2F5cy4NCg0KQWgsIEkg
bWVzc2VkIGl0IHVwIGluIHYyLi4uIFdpbGwgc2VuZCB2My4NCg0KPiANCj4+ICAuLi4scGRtYy55
YW1sID0+IG1pY3JvY2hpcCxzYW1hN2c1LXBkbWMueWFtbH0gfCAgIDANCj4+ICAuLi5yeC55YW1s
ID0+IG1pY3JvY2hpcCxzYW1hN2c1LXNwZGlmcngueWFtbH0gfCAgIDANCj4+ICAuLi50eC55YW1s
ID0+IG1pY3JvY2hpcCxzYW1hN2c1LXNwZGlmdHgueWFtbH0gfCAgIDANCj4+ICA0IGZpbGVzIGNo
YW5nZWQsIDEwOCBkZWxldGlvbnMoLSkNCj4+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21jaHAsaTJzLW1jYy55YW1sDQo+PiAgcmVu
YW1lIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC97bWljcm9jaGlwLHBk
bWMueWFtbCA9PiBtaWNyb2NoaXAsc2FtYTdnNS1wZG1jLnlhbWx9ICgxMDAlKQ0KPj4gIHJlbmFt
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQve21jaHAsc3BkaWZyeC55
YW1sID0+IG1pY3JvY2hpcCxzYW1hN2c1LXNwZGlmcngueWFtbH0gKDEwMCUpDQo+PiAgcmVuYW1l
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC97bWNocCxzcGRpZnR4Lnlh
bWwgPT4gbWljcm9jaGlwLHNhbWE3ZzUtc3BkaWZ0eC55YW1sfSAoMTAwJSkNCj4gDQo+IFRoZXNl
IHdpbGwgYWxsIGZhaWwgYmluZGluZyBjaGVja3MuIFlvdSBuZWVkIHRvIHVwZGF0ZSB0aGUgJGlk
IHZhbHVlcy4NCj4gDQo+IFJvYg0KDQo=
