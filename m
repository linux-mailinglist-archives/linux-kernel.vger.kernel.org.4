Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAF6D67AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjDDPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbjDDPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:40:56 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354C59C3;
        Tue,  4 Apr 2023 08:40:31 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DcQSe002723;
        Tue, 4 Apr 2023 11:40:05 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pph89pwnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 11:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5CZiEw8WVwcV0xh+O+KpLssMR+lu3O8V/CFEUam87Us3gt7+1gZ3GB3gmP2ChKCGEFS8PCudHfQxbny5Es9NpUx+aTDurJ0nUKw+SOOD4grLZNGis3meJef/m2pBjaODePLTFmEGzp7pxPY+7cd2MIJpZeBoa20dc5tPzRUQ35rupu73MuE5SNOxdTA2FtqHonSbFoNA4u4zUGHrB3ZuJ+u7FUjtnrD5dXO/+pHwipTJI/ixLlPAzo2ZtavTH/gLcwDU3+yIb2eOO0C5HJuFYNM5uOGISNlY/kQN5JSHtOuVSoOYNQlaR8idbtlW0mfKqwJfAYGPXOOA7plEdLUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBiV9JreEBezxL0AWBZVo/wugzeBzpbtUYgHy5G6Zy4=;
 b=dNieylWcg/8BF9O3AfZFOt4QlGIPtGb8bQ3euIXdblghl6YoOxY71zMh3zPeIiAA9s0O9iTl3H1XGd/ve/mL1wJK6xmDgs3G24W5+EwgvbzXU4OdihcMQkIpkiAKmOWs1nEbM7RRIkqii/KEMnncoaEyf1sSwFkWNeInpXHAqrOmQ2SfZPhTOIrd1wgOiRHHNK6a9OtH0Mj2NjCFIRihXs/F+kof6WeTUcJo+mKdhYMDkNFGogIFWAtAP6o03JMkOV1bx6Q/BEL0TB/AGqh07nJTHmWprVsvf2J8Bk0OGjJ7/5lu5oCbnXZ4eoY1ccI5fxNPGz5qoW1+nXWVaU8Tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBiV9JreEBezxL0AWBZVo/wugzeBzpbtUYgHy5G6Zy4=;
 b=DSonIQ0pOgTxpHle+52hPtOug83OOY3EYcEX3x8g1En56zuKsxVe1e8GCrR0kLt7tOOmdsqqBTmh6kNvlnVK8auasrYwGyb+R6jHdm82bZr6Pz0HUdHvfhd+T4KtKEdhSOCNcBRwDDc/klE+eAOhR++4KenBqT+Wm5bEabErEfI=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by BN9PR03MB6138.namprd03.prod.outlook.com (2603:10b6:408:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 15:40:01 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 15:40:00 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHZZkM1/0NcmmhHVE+7c9BLHmZIxK8bIRQAgAAnSbA=
Date:   Tue, 4 Apr 2023 15:40:00 +0000
Message-ID: <CY4PR03MB2488D9CED963C26DB7D9709B96939@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <7d5c4407-3198-c39a-2c30-fbaeb5c53b08@linaro.org>
In-Reply-To: <7d5c4407-3198-c39a-2c30-fbaeb5c53b08@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxXWXpaalV4TnpkbUxXUXlabVV0TVRGbFpDMDRaVGd3?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGeG1NMlkxTVRjNE1DMWtN?=
 =?utf-8?B?bVpsTFRFeFpXUXRPR1U0TUMwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpJeU5qVWlJSFE5SWpFek16STFNRGsyTXprNE5qWXdNamc0TWlJ?=
 =?utf-8?B?Z2FEMGlWRmR0VVZkWksySllaREZPVTB4R1FuUXZRMkpZUTFRNFRWcGpQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkRRMWN5WVRKRE1tWmFRV1YzVEU5SFJr?=
 =?utf-8?B?WnhlQ3RqTjBGek5GbFZWM0pJTlhkRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZSWkdsck5WRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|BN9PR03MB6138:EE_
x-ms-office365-filtering-correlation-id: b79cec03-cbac-462c-a2ce-08db3522da38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLOue+PjlhNsUCjCdKBZQZK2ajPMc6dp9ZAEgYuLNyld3yhavXIw3jngSjuab2bI2yDBmJQbk79li22P4e1K+qNiQa4RDBoKq6geYHZyXvyA9Ni3eIgAxqGXMFJc4/901WiJwmokPwKAaL5UXPcm4S9yy1khRoZr8gPfBDuo1bCUdNsg3EqoY/s8Vbyah2wHD3eqd8TdN1/AOS8NW/lSOq1eLY54t0N9gd6YJIEU1S0Ga+c9aFlGJ9SEFag/D9gEeZekgaLNrHBRzSp4ntIGB/NQ5swhkYFNVW7+qqY+2KAQ0ZUFvKq4QL3i5Eavi2txWXCkw9anE9qo44TuPvw3i6tpmNmv93dtIgRY8s0KZrZ3RA4SUtnbjYP1jJ3dHu9SJ714rd29bzcPNuOFL+HVkBCcqiUSVw3AvYKRNXUzYNm2+/N1pj1dmVAS2Q77+WWfskeFsZFjD0iaPcbsnFkm2p56xbtVZNnhgqaX931pH7pMRA+wXdWq/fkcTdsKGlWmuXDT9B1hONu+/z2iCbLjilhCvWypHfU2BLIQj0ffkgHE5CLPKTl+/Ea4jKI/64Y3UOwvvbZP5xW/kwmo+GmHahQyYctMI84CZBXPGlOIGWNF241P69+FTrmDUOQNk3DU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(110136005)(54906003)(316002)(478600001)(66946007)(66556008)(8676002)(66476007)(66446008)(76116006)(64756008)(7696005)(107886003)(71200400001)(4326008)(2906002)(5660300002)(41300700001)(8936002)(7416002)(38100700002)(122000001)(52536014)(86362001)(33656002)(38070700005)(186003)(26005)(9686003)(6506007)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T01WbkE5OTNyUTg4Y1RpZWlRbjJKM0xid3l0T1lJZTliR3B1d3dTM29rajQr?=
 =?utf-8?B?R3ROZjdTdXROeXowY0Q2Nm9DandCWk1VQW92TVdlZ05FZWY5YnlSOWM3Zk4w?=
 =?utf-8?B?Tm51RVZpWHM5R2tYdDAvcEZMTUQvYm5xRyt0ekd1Y0VsU3RpMjJNRmhXbGxv?=
 =?utf-8?B?UHcrMzVBR1dNYytiRHB5VEdDaVJaTzZFWWtBdjAxOTM2cTlwd3RITzBGckNP?=
 =?utf-8?B?Q2V6eVdMM3FxV0UyVm8zYnlUVmhIVVgwUU1YZ2ZvcjJ4WkpCcTFGdUpvSzMv?=
 =?utf-8?B?NXNOdDFZczFzU1F6S0FnNHZDYklTMitVK0hFZ2Y3cTJIYUFmeUxmeUpTb3Zq?=
 =?utf-8?B?YXVEV3hEWjhCUURDSjJPYVpRbEdza2N4aUVZQmpBTkk4TkVnLzloR252SHJn?=
 =?utf-8?B?L09zalIvSFBoTEp0TlNIZkpHTFJBa0RKQmhFbzA3MGp3MWJBbkFsVzNIWUMz?=
 =?utf-8?B?MlRyZ3ViTlFhbUt1RnVnU3Y5Y1lucXpNdVhrRFVzQXpuRHEzRUlzWVpVWVhT?=
 =?utf-8?B?a0RQenJEMVNhbG4wZTRsR1k2VnRtT1RVZUJEcStIenRqSnpYbG9LOVFZOFUv?=
 =?utf-8?B?azUrOEVHZG5TU1REajFZVzBFNG5XaFdSRzZyMS9ha2RNL3Z5b01ZcGNWTW9s?=
 =?utf-8?B?d3Y5SEREQlhMVzF2aElxZ3o0Rld4TDRkVTlHRzY3MHBiQjBkTzJ3cTl1UXVa?=
 =?utf-8?B?SXFwL1ZydW9TRFFHME5jVHh0eXkxNkJuckc0YVR5L0hqZUc0UGNna0RkZ0Yw?=
 =?utf-8?B?RXBEMUJreXdBT0ZWQ0lpZzJWcXBlUlVNdExSSjdzVGFPNFFlSUhteUdVaUt5?=
 =?utf-8?B?Rlh2WlN2TFd5VUJrcU5iRkRtYVhTMUlSaS9uVFkrd1FLcW1SK2NJWTRBOFVr?=
 =?utf-8?B?MUZHYnF5dDI1UUZ3N3NRYjNKbGxEeGNyNjRHZHVNTERiNVFmaHJKK2tZbjVk?=
 =?utf-8?B?d3lZdmExcEhlcmx2eWFyUXd4MGppMHYyOXYrbWppOXdzM1NQbU5LSXNuR0lM?=
 =?utf-8?B?OXY0dXlMdHQzR2xEdStFUkdUYkNTWVo2OHZqU1ZyRWx2TFo0OG5pWGFMbFFy?=
 =?utf-8?B?cERNZXBXWjA4VUp2Zm9oekwxVFJmZ0xHVmRxZ3drZUJLSVBtTkJqV2t1Mklq?=
 =?utf-8?B?YU5JZDNiMlpFSi9ZSzl6NnI0ajAxK2ZPVVorUHFIN09lS2wzUUhnU1duVUNG?=
 =?utf-8?B?SDRoZHZ2Zi96bnJUV0MwS0tReng4ZUhZdEVTUXBpWUZHZXhEampLSC91NEpJ?=
 =?utf-8?B?RnlMMm0wMnhyVUl5Z3JDbGRiS1hqL3ZLTnZHVEtTTitvenJVRVhIdG5pb1Z1?=
 =?utf-8?B?NDByeFpWVVdBc2gydGxDWDl5TmZabE5YWXV5cHVoRWJXTGd1K25HMUFKL0FG?=
 =?utf-8?B?c1FDdjY4ZWNSMVVSeEdodW9weUxKVzRwUzF5a0R2K0JoNHB0TGNkRm43Wmpl?=
 =?utf-8?B?TkFrbHdZUGJFdTlVS3IwdURBRXZpQVlPbzhRa0N6QW5NQlVlelVGdmJxZ2l5?=
 =?utf-8?B?OXd2cjczWXJLOE9JTVJtQVQ2SWxYdUVzZzFyYUR5YWlCZXJUdUVuY2xYR1p6?=
 =?utf-8?B?S2l1Ri9xRkRCVzR0OHNDSmQ0MDV3Z1JPd1FBTThINUtST2kzcEU5VTVUbW1x?=
 =?utf-8?B?T0xDRklKTVZ2a3VIM1lDSWlXN29BRXhLdGVFZmJPTHJDZnFDdzRDUzl2cnRN?=
 =?utf-8?B?WndleVdyLzN2ODZNVnNGUEYyakZoOWE2ajVBcndLWEVJeUMzWnRUK0tXbjFy?=
 =?utf-8?B?cDBHc2I1dkpqRnIvZGliNTFUbUd4Z1B2TVVRZGkxRTUrY1BNWVVUb3Jod2Jk?=
 =?utf-8?B?VWxPVWJTVzNKS25FZHVJNHJTWmh5QkpUeHRnNGdDcWdRZlNIQTA0cE9xSUdT?=
 =?utf-8?B?ejNHUko4ZVlkemdpRUxmSzJTQ3lxZGt4TERkZ0JhVTRrbHF0d1h3blliWGI4?=
 =?utf-8?B?TDRaZ1NyTGtJWW9xTENXaUtuN1czZ21jMHkrVHhlTnVHVTZzWEphQkRVZ2xM?=
 =?utf-8?B?bGtXbWl2aE51azl0dDBDWFJXK0J3blhJdk5Ta0ZSUFJJeCtFTlpqSm93N1BH?=
 =?utf-8?B?U1BjZHZudkZVZmp3WXk1d2prcXE3Rk1EV1FuV3MzR3NDQVZqK2ozSm9uMXdq?=
 =?utf-8?Q?uBCWVSBi1o5GuUoO1ChgkcAjs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79cec03-cbac-462c-a2ce-08db3522da38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 15:40:00.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRLFxx/w/dxYAwY0hv86a41W2uaHlw9WhYxkHzbebl5Q7YK8F4bbV0Vph4poDwXQlGzllOj8YzBwYfmz44LI7yk15haTSznp3gHQzk9JG58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6138
X-Proofpoint-ORIG-GUID: Cigw194nBrLxdbIRylqeyFtCDZvYAugm
X-Proofpoint-GUID: Cigw194nBrLxdbIRylqeyFtCDZvYAugm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_07,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=340 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040145
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBB
bGFybTEgaW50ZXJydXB0IGxpbmUgb2YgdGhlIFJUQy4gU29tZSBvZiB0aGUgUlRDcyBoYXZlIHR3
byBpbnRlcnJ1cHQNCj4gPiArICAgICAgbGluZXMgYW5kIGFsYXJtMSBpbnRlcnJ1cHQgbXV4aW5n
IGRlcGVuZHMgb24gdGhlIGNsb2NraW4vY2xvY2tvdXQNCj4gPiArICAgICAgY29uZmlndXJhdGlv
bi4NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgICIjY2xvY2stY2VsbHMiOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgUlRDIGNhbiBiZSB1c2VkIGFzIGEg
Y2xvY2sgc291cmNlIHRocm91Z2ggaXRzIGNsb2NrIG91dHB1dCBwaW4gd2hlbg0KPiA+ICsgICAg
ICBzdXBwbGllZC4NCj4gDQo+IFRoaXMgcGFydCBpcyBjb3JyZWN0LCBidXQgeW91ciBpbXBsZW1l
bnRhdGlvbiBpcyBub3QuIEkgZG9uJ3QgdGhpbmsgeW91DQo+IGNhbiBkaXNhYmxlIG9yIGVuYWJs
ZSBpbnRlcnJ1cHRzLCBiYXNlZCBvbiB1c2FnZSBvZiBjbG9jay4gRWl0aGVyIHRoaXMNCj4gaXMg
Y2xvY2sgKGdhdGVkIG9yIG5vdCkgb3IgaW50ZXJydXB0LCBub3QgYm90aC4NCj4gDQoNClRoZSBk
cml2ZXIgZG9lc24ndCBlbmFibGUgb3IgZGlzYWJsZSBpbnRlcnJ1cHRzIGJhc2VkIG9uIGNsb2Nr
IHVzYWdlLiBJdCBjaGVja3MNCndoZXRoZXIgdGhlIElSUSBpcyBwb3NzaWJsZSBvciBub3QuIEVu
YWJsZW1lbnQgb2YgaW50ZXJydXB0IGRlcGVuZHMgb24gdGhlIA0KImludGVycnVwdHMiIHByb3Bl
cnR5LiBUaGUgdHJpY2t5IHBhcnQgaXMgdGhhdCBpbnRlcnJ1cHQgbXV4aW5nIGRlcGVuZHMgb24N
CmNsb2NrIGNvbmZpZ3VyYXRpb24uDQoNCkxldCBtZSBicmllZmx5IGV4cGxhaW4gdGhlIGJlaGF2
aW9yIG9mIFJUQ3MgYW5kIHRoZSBkcml2ZXJbdjRdDQoNCk1BWDMxMzI4Og0KICAtIEhhcyBhIHNp
bmdsZSBwaW4gd2hpY2ggaXMgZWl0aGVyIHVzZWQgYXMgSVJRIG9yIGNsb2NrIG91dHB1dC4NCiAg
LSBEcml2ZXIgYWJvcnRzIHByb2JlIHdpdGggIi1FT1BOT1RTVVBQIiB3aGVuIHVzZXIgcmVxdWVz
dHMgaXJxIGFuZCBjbG9ja291dA0KICAgIGF0IHRoZSBzYW1lIHRpbWUuIEluIG90aGVyIHdvcmRz
LCB3aGVuIGJvdGggImludGVycnVwdHMiIGFuZCAiI2Nsb2NrLWNlbGxzIg0KICAgIHByb3BlcnRp
ZXMgYXJlIHByZXNlbnQuIE90aGVyd2lzZSwgd2UgYXJlIGZpbmUuDQoNCk1BWDMxMzMxOg0KTUFY
MzEzMzQ6DQogIC0gSGFzIHR3byBwaW5zOiBJTlRBIGFuZCBJTlRCL0NMT0NLT1VULiBJTlRBIHBp
biBpcyBkZWRpY2F0ZWQgZm9yIGludGVycnVwdC4NCiAgICBJTlRCIHBpbiBpcyB1c2VkIGFzIGVp
dGhlciBpbnRlcnJ1cHQgb3IgY2xvY2tvdXQuIFRoZSBBbGFybTEgaW50ZXJydXB0IGlzDQogICAg
bXV4ZWQgaW50byBJTlRCIGJ5IGRlZmF1bHQuIElmIHRoZSBDTE9DS09VVCBpcyBlbmFibGVkLCBB
bGFybTEgaXJxIGlzIG11eGVkDQogICAgaW50byBJTlRBLiBXZSBkb24ndCBoYXZlIGZ1cnRoZXIg
Y29udHJvbCBvdmVyIGludGVycnVwdCBtdXhpbmcuDQogIC0gRHJpdmVyIGNoZWNrcyBmb3IgIiNj
bG9jay1jZWxscyIuIElmIGl0IGlzIHByZXNlbnQsIGl0IGVuYWJsZXMgdGhlIGNsb2Nrb3V0DQog
ICAgc28gdGhhdCB3ZSBjYW4gZ2V0IGludGVycnVwdCBmcm9tIElOVEEuDQoNClRoZSBSZXN0Og0K
ICAtIEhhcyB0d28gcGluczogSU5UQS9DTEtJTiBhbmQgSU5UQi9DTE9DS09VVC4gQWxhcm0xIGlu
dGVycnVwdCBpcyBtdXhlZCBpbnRvDQogICAgSU5UQSBieSBkZWZhdWx0LCBtdXhlZCBpbnRvIElO
VEIgaWYgYW5kIG9ubHkgaWYgd2UgZW5hYmxlIENMS0lOLg0KICAtIERyaXZlciBhYm9ydHMgcHJv
YmUgd2l0aCAtRU9QTk9UU1VQUCB3aGVuIHVzZXIgcmVxdWVzdHMgaW50ZXJydXB0LCBjbG9ja2lu
DQogICAgYW5kIGNsb2Nrb3V0IGF0IHRoZSBzYW1lIHRpbWUuIFdlIGNhbid0IGhhdmUgYWxsIHRo
cmVlIHdpdGggdHdvIHBpbnMuDQoJDQoNClVuZm9ydHVuYXRlbHkgd2UgZG9uJ3QgaGF2ZSBjb250
cm9sIG92ZXIgdGhlIGludGVycnVwdCBtdXhpbmcgb3RoZXIgdGhhbiBjbG9jaw0KY29uZmlndXJh
dGlvbi4gSG93IHNob3VsZCB0aGUgZHJpdmVyIGFwcHJvYWNoIHRoaXM/DQoNCkJlc3QgcmVnYXJk
cywNCklicmFoaW0NCg0K
