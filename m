Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9056E47BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDQMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDQMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:30:14 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4A46A0;
        Mon, 17 Apr 2023 05:30:12 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H8vlIY001229;
        Mon, 17 Apr 2023 06:13:12 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pynpb0jx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHmtDUOXGriKCnYah2qz1mduJNk3k3mSO7vGBIrw1Vn6k/0x/v2EQQO9CR37pLOYqt4s4r9mCM8M1AA5AqY945matAwUKQnrzEHffbK/qX8tNYqEDhM4qFqKQJ8YZqRBLrhF/Q51ZEj7diJ7HZguhktFY9ampnCZJKzANRwjiPLuRN/Bn7VWA7q+Cm+Dl1myfgoPPXBVaN1jQupNzZyGbxeXH3MN80av2nAtBOpkHTRROm6byI135T7bGT3UejNs+kSOmEcMnf4c7IcEC4PB2DIXYt3Na+bn3IalXhnwk/9Z2syMPaqPOdHcQt1ACF9f8LiXw/qwjt4Nqo+qD+g8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ip8QcYZcUG7q3wLckD14vPM62k+9ZjMIlkDEc2CT05w=;
 b=cJAo44+JdCRr+AkPtZajavfBKfK8Romc0Jk4PoVgG924/QH5dtkmCblI6OTIPRRRfNc1GYsnxnP6FPBWwRGg6O7Cu0sdHTQ4DK2/I/ghEDMJdPeYUo9C8PzNsfBMMeuyeCI9X07lOlDxft0cecpTSpqO0QA8BwE8RPy18BvNznBluhYqDMUqwqd5JykDZvGv78HQHJgAzMfiPE6+ZRTl5kTC6fiUlDKFO1RTWMBrj26o7F7Gv8Il6vY0ZBhKHoN1cmz9s4APCh8LNBecbvaaR0p28Pe1Nzt061H4iCLQdOfHv9omXuvOPBmqJWkBjWPGsro5oaPDN1u+ADXDA7yWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip8QcYZcUG7q3wLckD14vPM62k+9ZjMIlkDEc2CT05w=;
 b=tBKUwIP9Wx2UkWOZijKuFyWqzTV5gGy20X0FYOL1oPvqG3Rz5y5yZBHC0JRDOcwx+r4Vl52wnGiyBHgOSM7R+5sUkk3MbCRpFjquuYBh2jM5rEseSMsdnFugOqlaze/8A3gGK0J7/moHnNzzMPyhGQi7a5lJyOJYwQcMyLpV5AM=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by BLAPR03MB5460.namprd03.prod.outlook.com (2603:10b6:208:292::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 10:12:53 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c9df:9ae8:8919:f81b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c9df:9ae8:8919:f81b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 10:12:53 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Bolucu, Nurettin" <Nurettin.Bolucu@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH v2 3/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Thread-Topic: [PATCH v2 3/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Thread-Index: AQHZXINBpYIKSrmsekqSOMUTNj5ufa8GdxGAgCjy5OA=
Date:   Mon, 17 Apr 2023 10:12:53 +0000
Message-ID: <MN2PR03MB5197C779B675729DD39666D38B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-4-Zeynep.Arslanbenzer@analog.com>
 <a44e363c-c8c3-341d-d794-df2bc1a3d20d@linaro.org>
In-Reply-To: <a44e363c-c8c3-341d-d794-df2bc1a3d20d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRZNE5qQTRaVE13TFdSa01EZ3RNVEZs?=
 =?utf-8?B?WkMxaVpqUXhMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ3Mk9EWXdP?=
 =?utf-8?B?R1V6TWkxa1pEQTRMVEV4WldRdFltWTBNUzAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJalEwT1RBaUlIUTlJakV6TXpJMk1UazVPVGN3T1RJ?=
 =?utf-8?B?M056ZzRPU0lnYUQwaWExZG5ibXRLZDBJNWNVeG9hMUZYUkN0bFYyeExXalpG?=
 =?utf-8?B?TmpSRlBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGRVFucHliM0ZHV0VoYVFW?=
 =?utf-8?B?WlNOMWxSWVRKVFpHRkdWa2gwYUVKeVdrb3hiMVZFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|BLAPR03MB5460:EE_
x-ms-office365-filtering-correlation-id: f0fbe4e3-8262-4b05-a0dc-08db3f2c4ed4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ummoLrt+GOlgr/MXbNynLNQ8L5+rOmGbREAJkcEx9j4i9Gmcr1gD8fkeTlgbY/JMYxronKotSaEpqcxCkI0skkFBs6dlD71KU1dLqN4pJ7tNGXaqJ8FL8tBsaBiROpM+00ngyV9FaJhNGV8GBCSsMYvaXJRDjYppI+cf56HI1AsDWSgLNdn2h/5xA02Jtua+JI1GF+0VbQhqjrgU9qfKAM4bWf7tH7rDCUZfxXMaexQL9xku1D73dq56jyaWm9ARMKRlCJaYlam1SIE7XSNg21ThIdvtn7VCMp5DEkDlxr68OXF2+k5zZ0IWlrVyQFIsGv/idTlo3Db1T7fauU+bgdc2L9BTUStrvabnPjkvUfYZvJbW1HC98yzx1gB/XX/SpHklXsawsvlIqOtYOxDTMr8GN9Hfy85Wjtl8pd4fHkPT/5DVKQwQY8oPDrWyk6Ru5wy6gWrUzdkF/oXjT+rPhc3sXGcY/sFDiofBo6+DzJx5FfYP14PH1yGtfSAlKG8+LSLEncGZRSXmyilf9t9oWOhCHxtklDTmNjZZenXciaUCBBV2iK6LuyTCeR7HVhjMpgjRaCksmvRM2QLj3qYs9rSwlv9DUEiQOyFsYpHE1SzOE9ncSfW86/0P1wiDSfVboyuM3YuZ3qnBw8LuCCQAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(8676002)(8936002)(41300700001)(7416002)(52536014)(316002)(76116006)(6916009)(4326008)(66946007)(66446008)(66556008)(66476007)(64756008)(2906002)(54906003)(478600001)(86362001)(7696005)(38070700005)(38100700002)(6506007)(186003)(9686003)(122000001)(71200400001)(55016003)(83380400001)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE54b0Q2RlFQZW4yTnJuclpxR0lrNGNQVmpsRUc5T003Z2RWbnZuQklNbHNS?=
 =?utf-8?B?Z1lWb2ZvSHRURHZ5UVJiQVJFMFIvR2NiRHFxMVNXMDNqaTdLZVk2eUdhanpk?=
 =?utf-8?B?ZmdteE9URmVZNGZPTWsybGhTVkJTZmZnNVlqMTBIdmpZMnpXNUVDVitISXh1?=
 =?utf-8?B?UmZjVkN1MlNPcFZaTTNlSHVicTV5MVQzL05LdUhKcm1ZRVJGc3hqNGd2a05Z?=
 =?utf-8?B?bEZKR090Y1F2UW4zS2FyalhWRGl1d3J0b3RVMU1aTXpyelNNMDhwU29TcnZK?=
 =?utf-8?B?WXErS0lERDZRSndRZkNveU1XQ01CVmRQU05aQ3dVeHR4M0Z6UVM4NjNpVVJ0?=
 =?utf-8?B?NW1LUUhmUzJmcldhYWVaZGR5WHZWaXJpNEhXbDNEdHhWa3k5NFNxcWlZeGJ1?=
 =?utf-8?B?YzdLb2tFeGN6R1lPMFRVYVRtTXNXL084RXYxQUIzMXhDZTgwN3lJTDhpSTlv?=
 =?utf-8?B?RUlQOVlENlVUVFR0aE9uK0h2WCs2Q2cweXdiRUhFU0dxYW9EOHpwOUN3Y2Rl?=
 =?utf-8?B?emRxS3ZpVzBodUdrbkhpeUpST0tQU0R6VUhMTGpzbnJ0OUdjZ0lXM0lGdzN3?=
 =?utf-8?B?aktwSnVET0lDbzR6WUZCL3JOWjc1SjFtMFZjTjNQQ2l1YVlyM3JqMzM0V0Jv?=
 =?utf-8?B?WGovd05GSzBpQjFQK0FHOWZoVllWZDc4aVlQbDZZYzFNTCtQTlgzM2tDTUVO?=
 =?utf-8?B?Z2F2SmNWUkpiakhiQ2dlSDlDTjZ5RHIxVk5UdzZqZVBocVZ2UEc3eG5CeE02?=
 =?utf-8?B?T2xHUHhkbVdrWllhRG1tQ2tPNEV0bCt5emxBc1BwOFVrc3lvNkNsMkZ0OUVM?=
 =?utf-8?B?WHNyYSt1b1NDSDBRek5pRU05bytka0VxYVR4RW9xWHB4VUNLN3hNVUhocGE3?=
 =?utf-8?B?WFRSNjgzd3JQcUFOUGtjdm9iVDE3UUt2L1EwY0V6VWJ1UWd2aFR6K0VkbVV0?=
 =?utf-8?B?bitkdXMrZ0NSb1lyVGNlZU9Nd1BVNlVaVEc2bE8yWllxZjl3cjhpcUpFTGNq?=
 =?utf-8?B?YkRGZkg1SEtCZDdCSjRiTnZsd3ZOb0VOMW11THc2R0lnaExMbWYxU3hiVGNL?=
 =?utf-8?B?SVBtSG5FSVBXQ0NwY0hrbGxsdDhGcnB2MmVOSGpaZlV6LzNxbmt0VkFvTCsy?=
 =?utf-8?B?M01iV1FQNWprQnY5VktJUXUzNGNUeVF4ZnQrUXJLZjJDSk53YldkT2gxaFpv?=
 =?utf-8?B?azhodVZGZzM3UzVZVkdrSnlyOVNFdTFBRmdJME14aC9oelRkdllWQUIrMUhY?=
 =?utf-8?B?ODVxcEdSYzAwL2NkZzZsTVY1aFFBRnZtZHVPdVRjN2I0RGxDdzREYVRKbElm?=
 =?utf-8?B?Skpjbi9uWHJvcTFmV3U0WkxITXdxM0lxT0hsSFlGdW92M0xqckJUMWZCWjdG?=
 =?utf-8?B?MFRGdGJncENZbnA3c1Fjci83eDJicVB0SWgvYmxzeGp6V2lSWHZJZDdQWGVK?=
 =?utf-8?B?cTFVY0tkekJ0Y2ZHUE9oRGpKTWdiT2d2czlqUnBkV0V5eGlZM3hQakljcTNK?=
 =?utf-8?B?OUpLUzNnSmUvMTFza2NHdHkrcklzTHJIalpyZnF0bzh4SmhvajQzaG9LOEFp?=
 =?utf-8?B?cnRzU3dINjFEaHJVdkVUYjh6OWhVaGtCTURrTy9PbFkwT0JWYlJWK2tpbnd4?=
 =?utf-8?B?NDljR29tN25YR0txZVRMVmdEVC8wTGJVZzMzMmNxSWJoOWlhdnNFOTMwb0x1?=
 =?utf-8?B?UVE4ejA1V0d4M0toYTFXU3IxTzdFWXgxUk8wazczRXVybGhhQXpzR0ZNVDIx?=
 =?utf-8?B?Ky92MEkxY1UvY1lXenRkemN0bTlYVk5XUXZBYjIyaTQzS0xGbGFwN2VNWXJ6?=
 =?utf-8?B?eXJlRGxRMmhvcnJPYnFtekM4cmh4RVRlWmx0bFh5UkQxQ044VWcwTk5ZNk1S?=
 =?utf-8?B?S1krVXVPTjJxRjJKMkhmanEyS3FzK055Qk5VT2FFNkd6U3BsSDVpdFNUUnFV?=
 =?utf-8?B?RmJITFNuSUdLc3ZmR0xmSlRCTXNhTEZjR1pEaEpVVzBFZmhYNnIzNWpSb01S?=
 =?utf-8?B?REFUZjhtaWs3SVdNaFBPL1dmS3ZuOStOVTZSajd2R1FHTVJTbUo1SGVCc1d0?=
 =?utf-8?B?dUlVb2JzRkRZK0c0YTA5dFkwdHFhQlhsaE1IRGRxT3hBWGFFZnBjbXZSUTJD?=
 =?utf-8?B?N2hIM2NQSTFqcjFSMVI4aXNTYXJZc3FLcnNoM0tRK0tJOWI5SHc1dGxNaWZl?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fbe4e3-8262-4b05-a0dc-08db3f2c4ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 10:12:53.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VE9pXX86wiLlYu97mMZwf6Ymn9QgXwAaBY8wAxpdDkWeEZ43fUrua24WMXttwQVMBvslhRa2C1hKsXFF4ZXX3MpTjVpz3UwazWkVUYUZ3SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5460
X-Proofpoint-ORIG-GUID: bn7odZkmbFUnyzCAtj5ycr2Ur76QypUE
X-Proofpoint-GUID: bn7odZkmbFUnyzCAtj5ycr2Ur76QypUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+T24gMjIvMDMvMjAyMyAwNjo1NiwgWmV5bmVwIEFyc2xhbmJlbnplciB3cm90ZToNCj4+IEFk
ZCBBREkgTUFYNzc2NTQvTUFYNzc2NTgvTUFYNzc2NTkgcG93ZXIgc3VwcGx5IGRldmljZXRyZWUg
ZG9jdW1lbnQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE51cmV0dGluIEJvbHVjdSA8TnVyZXR0
aW4uQm9sdWN1QGFuYWxvZy5jb20+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmV5bmVwIEFyc2xhbmJl
bnplciA8WmV5bmVwLkFyc2xhbmJlbnplckBhbmFsb2cuY29tPj4NCj4+IC0tLQ0KPj4gIC4uLi9w
b3dlci9zdXBwbHkvYWRpLG1heDc3NjU4LWNoYXJnZXIueWFtbCAgICB8IDY1ICsrKysrKysrKysr
KysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCANCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dl
ci9zdXBwbHkvYWRpLG1heDc3NjU4LWNoYXJnZXIueWENCj4+IG1sDQo+PiANCj4+IGRpZmYgLS1n
aXQgDQo+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkv
YWRpLG1heDc3NjU4LWNoYXJnZXIuDQo+PiB5YW1sIA0KPj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L2FkaSxtYXg3NzY1OC1jaGFyZ2VyLg0KPj4geWFt
bA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjE0MGFi
YWI5NjljDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L2FkaSxtYXg3NzY1OC1jaGFyDQo+PiArKysgZ2VyLnlh
bWwNCj4+IEBAIC0wLDAgKzEsNjUgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDog
DQo+PiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL3Bvd2VyL3N1cHBsDQo+PiAreS9hZGksbWF4Nzc2NTgtY2hhcmdlci55YW1sKl9fO0l3
ISFBM05pOENTMHkyWSE2LXh6UmVNSDBXZTJIdjg3S09fSEJRDQo+PiArYlAwSWRkZnVsbXZ6V096
U3N4bUE2VHFWX1YyTW82S3lKNUg2aEFxWkdGZUdPRTRVVUl5OUR2LVpOVW9uNlZKUjNJVFR3DQo+
PiArT0xtTm51T2ItJA0KPj4gKyRzY2hlbWE6IA0KPj4gK2h0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueQ0KPj4gK2FtbCpf
XztJdyEhQTNOaThDUzB5MlkhNi14elJlTUgwV2UySHY4N0tPX0hCUWJQMElkZGZ1bG12eldPelNz
eG1BNlRxVg0KPj4gK19WMk1vNkt5SjVINmhBcVpHRmVHT0U0VVVJeTlEdi1aTlVvbjZWSlIzSVRU
d09Mazhtb3o4OSQNCj4+ICsNCj4+ICt0aXRsZTogQmF0dGVyeSBjaGFyZ2VyIGZvciBNQVg3NzY1
OCBQTUlDcyBmYW1pbHkgZnJvbSBBREkuDQo+DQo+VGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVy
IGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQo+DQo+SXQgc2VlbXMgbXkgcHJldmlvdXMgY29t
bWVudHMgd2VyZSBub3QgZnVsbHkgYWRkcmVzc2VkLiBBY3R1YWxseSB5b3UgaWdub3JlZCBhbGwg
b2YgdGhlbS4gTWF5YmUgbXkgZmVlZGJhY2sgZ290IGxvc3QgYmV0d2VlbiB0aGUgcXVvdGVzLCBt
YXliZSB5b3UganVzdCBmb3Jnb3QgdG8gPmFwcGx5IGl0LiBQbGVhc2UgZ28gYmFjayB0byB0aGUg
cHJldmlvdXMgZGlzY3Vzc2lvbiBhbmQgZWl0aGVyIGltcGxlbWVudCBhbGwgcmVxdWVzdGVkIGNo
YW5nZXMgb3Iga2VlcCBkaXNjdXNzaW5nIHRoZW0uDQo+DQo+VGhhbmsgeW91Lg0KPg0KPkJlc3Qg
cmVnYXJkcywNCj5Lcnp5c3p0b2YNCg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgcmV2aWV3LiBJIGFjdHVhbGx5IHRyaWVkIHRvIGNvbXBsZXRlIG1vc3Qgb2YgdGhlbSBidXQg
SSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kIHNvbWUgb2YgdGhlbS4gSSdtIHNvcnJ5IGFib3V0IHRo
YXQuIEkgd2lsbCBiZSBtb3JlIGNhcmVmdWwgaW4gZnV0dXJlIHZlcnNpb25zLg0KDQpCZXN0IHJl
Z2FyZHMsDQpaZXluZXANCg==
