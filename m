Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1DB6DF222
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDLKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDLKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:45:15 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F091A558B;
        Wed, 12 Apr 2023 03:45:13 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CAgWx3002898;
        Wed, 12 Apr 2023 06:44:41 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu248xu1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 06:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhWYNcnV06IP+KJIYvLzlYxD61AgdN5DUaFoiD+nmWM7mIkGmx/Ihct5QucJ5SEPmUzAzL1lNo06YQdDi6mC4+zjewed3WvKaSeHUJyGRHNFoEcBYhVuDiYEFUslZjCb7TPlPUhPtK59kB+CwTWUvlolzYK+ZRHUs+qQpuOPsvjOtOaiQSEFTBP+dY8UzDSQU+3oTZxmMbLoDZBD2aAU6Fnu4j69FCtZAuq15dIfW1h5ipUqc21If/7KIOEE7+4Lf0wTB56yitfM5DdPNRZC6hbC/pHvOXoITSyUodQEsXSuHCUOxZR54qvTwqAB4UY9kceJf8TRg3b8j7P2O+dzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxlWGOlxBzu5TairbO62aAKsJDcrk3gOEX9RVpY/auc=;
 b=iSQaMYgsly5OYiyefUGCJNOH/MpKiQvPpvB627cJXC1Jb2Q3USCCVACDpTNcGs5V2Tu+co/3uP+gGGDNKvPdqWH/WkayX0Cg9qD1mZgOIOtw3QSTqqj4NPFJvhFSdJtqolC+F1mh1ZP3SWA7KBQMAlWhN/z3PDlomkt83BQc2muEY27fBus8aUNdIM/xpPRNiIbjHfUd3vFS2076/HBRW/db3P2JZx6qalOpRMAfhI68Jdflp7RLdBwpNlOmEW1a62i9Rz49DHZ0lAdr9wY/1hEoJeZ2duySr4+PB54aS+pblyCS3BIBBvdSvjBzLgtktedRE37u0X3LXr1+3dgNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxlWGOlxBzu5TairbO62aAKsJDcrk3gOEX9RVpY/auc=;
 b=MNHwgp1OjtUKPgePdouTkBGKZVxV6qg/BHK7nl2ZDIBwqKyGQz+CAEX5dUe1a5cnn54ZHOoGMsO7DHs2P0xjW4+j6097tI+x8AyRBquupbdoaluZTDOIqifkMHodzjmK7l21ClNPyv1rn0LT8M3hHkIpdMUVVtRApxOwB3CKGr4=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 10:44:38 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 10:44:38 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Lee Jones <lee@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Topic: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Index: AQHZUOiqG6ZyiGxaUE6S5aTx5qv2Ta78K/mAgAAAKICAE8FVcIACCFqAgAdrk0CAAGi0AIACx3qAgABUvwCABnhK0IAES9GAgAAK2pA=
Date:   Wed, 12 Apr 2023 10:44:37 +0000
Message-ID: <MN2PR03MB51681A3425C38EAE5DE986CBE79B9@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230403140950.GF548901@google.com> <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
 <20230405133938.GD8371@google.com>
 <MN2PR03MB51681CCFD911F63CE32E914AE7949@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230412100407.GA8371@google.com>
In-Reply-To: <20230412100407.GA8371@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFdabU4yTm1NMll5TFdRNU1XVXRNVEZsWkMxaVpXTTNMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ4bVpqZGpaak5tTkMxa09URmxM?=
 =?utf-8?B?VEV4WldRdFltVmpOeTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJak0yTVRRaUlIUTlJakV6TXpJMU56WTVPRFk0TnpVd09UVTFOU0lnYUQw?=
 =?utf-8?B?aWVWWkZjbU4wTDIxcWFTOVFSbEE1Y0ZKaVZWWk5kVXh4V0haQlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQmVqVk9ja0pMTWpOYVFXSlVkRVZCUVdNeFQx?=
 =?utf-8?B?azRkRTh3VVVGQ2VsVTFhbmRFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlJaR2xyTlZGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVFOVBTSXZQand2?=
 =?utf-8?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|CH2PR03MB5192:EE_
x-ms-office365-filtering-correlation-id: eb47947a-c36a-4747-ef60-08db3b42e9e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOk50CqQI/BCLQtqrPK7dTkHnT0ANixsW5JAcOPrXoGFwK+aPhqVKfw1v/M58IVmNxC+HU7OSZLO9G98mBBbVVmjHLeT/Zcy85lEseZpWsPdk+yF9MjGooqE+OhhGVASBG2ORoD6kWEPdWB+tNSXBFol94611hxf1cLfAumUKs6ArDiGAJocdW5x40NSEs3/xL1Viqcre2rMT6uCqomLZ7NKMsqeflgXRx7SRu6A0dLjESIz5mYngFgUdk1Y7OippvY6ZZKus5f1t5afFYQYCRC4bqyLxtassoksZw/Jgo+UlC2mFV6e9dCXbgnt9zrzL03Z1CCMAPnP3DntVV/2thsHF5UF/OkR5ZBw6BY5uvQiNEEi55FCWUKWVwSeSdUWsoXtBk3YBo7K5qlIs+86ZywffMRqZOMah8rOan8RCzFWfsA0fuILoQPydphmNOz81/MMjZRd6R1yoNKGdqlEKKTAfMDy8NxYXB/kT5qe/+0h3j6gP1vutrmIQNSwM2iue6Q+EqRoupWK2BMCfQpeXF0nX+Fq9KK7SE4fKeuwlmvkSqi/ol4TpuJRdgVrmTkLz0ZlG50qW9/TA0VW8GK//5oPM2cpaUM5adrAkZTLxD9PifHXv1BmxCpo3B9vWV7p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(38070700005)(26005)(66556008)(66476007)(64756008)(4326008)(66946007)(76116006)(55016003)(66446008)(6506007)(9686003)(71200400001)(2906002)(83380400001)(7696005)(186003)(6916009)(54906003)(7416002)(86362001)(52536014)(5660300002)(122000001)(8936002)(8676002)(38100700002)(33656002)(478600001)(41300700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVQzMzg1Y2ViMFNTV1BJb05nc0pXWmc5aHFVemFtMHptcHA3R0dUc3NJRkpB?=
 =?utf-8?B?WDFmV2hHcTBIQ0lxQ2VlZi9JTHJEMGpNbmRhTW5RWWFMcXpPSUNZRmFrZ1VN?=
 =?utf-8?B?dWtST2RTQk1OU01UbHVxblhxS09iYXZZSUc4RlJmSGQyMDVPd1dYZFNKcVh4?=
 =?utf-8?B?M3BsRkEwNURlLzZyUUlyNWY1Z0hYR0hVc1lWUlhNL0tRZWtWZ2ZCZ1VGTkNR?=
 =?utf-8?B?VFVoMTFlL0xaSFN0ZFJDSmlFN25DUUN2aS9veW9NWlk3S3BOa1VRNVBud3Zs?=
 =?utf-8?B?TjlCMTU0MzlVaWt1Q3cwaTQ4NHRoQVltV01LUlVMZ1Zia3kyWVYzaHJrWUtt?=
 =?utf-8?B?VGxrUXgwd3psaEtCekpuS1VVcDlSUzJqYTV0RmRzVXA2dlQwUmJ2MGUyRWNo?=
 =?utf-8?B?QitQR2d0cTVqWVRZWlMzZnRRRWZxWlhuR3JJT0lhNGU4ZFJFc251SG90aksx?=
 =?utf-8?B?NFpESWlEeGpPYUVnRkt2ZXM2eUJ5TW40Z05QckZRSnZ0czNNWW9UVUw3aWhB?=
 =?utf-8?B?YnRwWnJIR3BzWDRyUXlncmRVUkw0STJMWS9yc0lqUWtDVVZqVy9mTGx6Qktj?=
 =?utf-8?B?SWJWUFd4N3FNS045bCtFT1B3UHpWdnJ2Q2pkcENkRGRwY3QxQUZTQlJnV0Mx?=
 =?utf-8?B?VjY2ZU5GTUpNV09MMDI5a3lVeU1McjlyZFhRYnVQdlkzNWt3dC9iUk5WTm5Q?=
 =?utf-8?B?MGx0K2pPa2J2SWJLZHNmbUcwKzZzeThGNGZac2pGZUkzNjJyWkhVZUY4Qlls?=
 =?utf-8?B?a09UeWxXRGtZbnp2SndrTUpEUC9ZUEpON1VmUk4xeDA1cEptQWFKbGJGVEpM?=
 =?utf-8?B?NUFocnhwVFJMMTcvWDZYT2g0Z25ZeG1aeVAvWHh2ckxwckI1RWRsSkVkaG0v?=
 =?utf-8?B?dmZybjdQNG5pN0R0VGd3VDFPOUVLZlJoNG9PZklSUEVTOXU3VTV0V1BQa25j?=
 =?utf-8?B?bnEwSUE3MlN5Tjc3Q2grNm1MVEtTWm5VdmRBKzFzTXFnbk9Ec2R5TldEdTJR?=
 =?utf-8?B?MHRHTWk4cU40azBzVGUxZ0NCZGt2Sys4Ri9VeG5QdTdYa3ByK3VMdXBEd1pi?=
 =?utf-8?B?eVk2enNYODUrMExKQUtmVVF3WUp0dDFjVVRNT3pQTWIxU1ZwdWxPVE1wZGN2?=
 =?utf-8?B?UFE3VVJVak9CSFI3VGsyenhHcGFyMXU0VXBZdkRJY2xCV25BbDZNSG0vdElJ?=
 =?utf-8?B?aFlJYTJqR0dOVXZxaWVVMmFZeE5GTXIxYjBZWVZxSFpIc3h5LytUR1MyVWlj?=
 =?utf-8?B?MlQzblBVRFBMYlkwUzVMQ3BCbE5uanpSamhTS3pkY0RhNjU1dzNJZ25uenlV?=
 =?utf-8?B?RTZpZmszYXJ4NDI1UmVmL0JaSlZFdWF0SGFFcy9lelRXcGMzRzBQTUpkUkRB?=
 =?utf-8?B?OWdsanFILzBCRGxLWTRlWTJ2aGlOUnJFVkNMZVRXVFRDVnA4WDFzVWpwRDdS?=
 =?utf-8?B?NnVqc053QzBqbXpRS2JwMnRFeE41NnJndWtTM3c5Myt2SDFSeDJiS3hEMlU1?=
 =?utf-8?B?cysxd2VVNU9vYmx5RElTRUxCNngyYVluVmI3ZzM0VitxcGNtQm40Y3VBN0ZT?=
 =?utf-8?B?SE95cS9CTGtOMmZzWDRwZ1dTbjZ5TmNpRkFKMzE2cmRJTWxUZERmLzAremsv?=
 =?utf-8?B?NFhsSE5Da0Y5YW5nZ2tIT1NKdUFNVjYyVTRIbDZaVzNERmRUZkZ5WVAxN3Yw?=
 =?utf-8?B?TWZveHpFWTQxMEZOd0xnY2JBb3M4VWFneXJLUGdhcUx6enIxa2wxamdob1hV?=
 =?utf-8?B?amhlUDlXL2ZZR3dnUy9UZnNiTzZOeHMzaGpEazVzMmRWdy9QdUVlWlEvd0d5?=
 =?utf-8?B?d1c3aE9ndGloaG9VVksyeHZTRGJMVy9qVVd5cXRiM1g1NGRKNzlkTTBGQ1NB?=
 =?utf-8?B?eU9iWDhaeE1LOC9MSXlGdUM1YmQ5VEV1YlU0ZlVtMzJhN285Smgwb084c0dn?=
 =?utf-8?B?YzhVSytXWEJOb1JVRnBmbnlKSVlDaHFZSXM1VnBraWlBNmU1UFB2eVRSa3E5?=
 =?utf-8?B?TjZFUmZJaHA3aW9Fa2k5R0ZRQVYrV0ZlemJxOG9uYi9qaDZRdlQ2UGhneWhq?=
 =?utf-8?B?OXp2WldueFdRWENrMGZ1dlo2QWlYdWV2Wk8zYXQwSW1Xa0I5Slg5UmMvTllw?=
 =?utf-8?Q?u9FNHWgY+Zr23B/jUtvjiJxRS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47947a-c36a-4747-ef60-08db3b42e9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 10:44:38.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdKjYb6RIlnIPxKDHIy+zn56bD1kS0aVRrLhhWtBM4U/CcLQFOVRtVDVvm1zRGCxc1At6vqpdwSvCrMjkkiP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5192
X-Proofpoint-ORIG-GUID: lMv3VmD0ytr63TcF8Mie_ETJ8WDyy9_R
X-Proofpoint-GUID: lMv3VmD0ytr63TcF8Mie_ETJ8WDyy9_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120097
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFN1biwgMDkgQXByIDIwMjMsIFNhaGluLCBPa2FuIHdyb3RlOg0KPg0KPj4gPk9uIFdlZCwg
MDUgQXByIDIwMjMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+ID4NCj4+ID4+IE9uIE1vbiwg
QXByIDAzLCAyMDIzIGF0IDAzOjA5OjUwUE0gKzAxMDAsIExlZSBKb25lcyB3cm90ZToNCj4+ID4+
ID4gT24gTW9uLCAwMyBBcHIgMjAyMywgU2FoaW4sIE9rYW4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4g
Li4uDQo+PiA+Pg0KPj4gPj4NCj4+ID4+ID4gPiBJbiBmYWN0LCBvbmUgb2YgdGhlIG1haW50YWlu
ZXJzIHN1Z2dlc3RlZCBhc3NpZ25pbmcgY2hpcF9pbmZvIHRvIGRhdGENCj4+ID4+ID4gPiBpbnN0
ZWFkIG9mIGVudW1lcmF0aW9uLiBUaGVuIEkgYWRkZWQgY2hpcF9pbmZvIGFuZCBwdXQgZGV2aWNl
cyBpbnRvDQo+PiA+PiA+ID4gc3ViLXN0cnVjdHVyZSBhYm92ZS4gSSB3aWxsIHJlcGxhY2UgY2hp
cF9pbmZvIHdpdGggaWQgc3RydWN0dXJlIGluIG1heDc3NTQxDQo+PiA+PiA+ID4gZGV2aWNlIHN0
cnVjdHVyZSwgcmlnaHQ/IEkgd2lsbCB1c2UgZW51bWVyYXRpb24gZm9yIGRhdGEgYXMgSSB3aWxs
IGFzc2lnbg0KPj4gPj4gPiA+IGl0IHRvIGlkLCBhbmQgZGlzdGluZ3Vpc2ggZGlmZmVyZW50IGRl
dmljZXMuDQo+PiA+PiA+DQo+PiA+PiA+IFllcywgdGhhdCdzIGNvcnJlY3QuICBQbGVhc2UgcmVt
b3ZlIGNoaXBfaW5mbyBhbHRvZ2V0aGVyLg0KPj4gPj4NCj4+ID4+IFRoZW4gaXQgd2lsbCBwcm92
b2tlIGNhc3RpbmcgaW4gdGhlIE9GIElEIHRhYmxlIHdoaWNoIEkgYmVsaWV2ZSBpcyBub3Qgd2hh
dA0KPj4gPj4gd2Ugd2FudC4gSSB3b3VsZCBhZ3JlZSBvbiB5b3VyIGZpcnN0IHN1Z2dlc3Rpb24g
dG8gaGF2ZSBhIHBsYWluIG51bWJlciBpbiBJwrJDDQo+PiA+PiBJRCB0YWJsZSwgYnV0IEknbSBh
Z2FpbnN0IGl0IGluIE9GIGFuZC9vciBBQ1BJIElEIHRhYmxlLg0KPj4gPg0KPj4gPkFuZCBJJ20g
YWdhaW5zdCBwYXNzaW5nIE1GRCBpbmZvcm1hdGlvbiB0aHJvdWdoIHRoZSBPRi9BQ1BJIEFQSXMu
DQo+PiA+DQo+PiA+WW91IGNhbiBwdXQgdGhyb3VnaCByYXcgcGxhdGZvcm0gZGF0YSBvciBhIGRl
dmljZSBkZXNjcmlwdG9yLg0KPj4gPg0KPj4gPlJlZjogZ2l0IGdyZXAgLUE1ICJzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkLip7IiAtLSBkcml2ZXJzL21mZA0KPj4gPg0KPj4gPi0tDQo+PiA+TGVlIEpvbmVz
IFvmnY7nkLzmlq9dDQo+Pg0KPj4gSGkgTGVlLA0KPj4NCj4+IFJpZ2h0IG5vdywgYXMgeW91IHN1
Z2dlc3RlZCBJIHJld3JvdGUgY29kZSBsaWtlIGJlbG93DQo+PiBGb3Igb2ZfZGV2aWNlX2lkLA0K
Pj4gCS4gZGF0YSA9ICh2b2lkICopTUFYNzc1NDAsDQo+PiAJLmRhdGEgPSAodm9pZCAqKU1BWDc3
NTQxLA0KPj4gRm9yIGkyY19kZXZpY2VfaWQsDQo+PiAJLmRhdGEgID0gTUFYNzc1NDAsDQo+PiAJ
LmRhdGEgPSBNQVg3NzU0MQ0KPj4gSSBhbHNvIHJld3JvdGUgb3RoZXIgcGFydCBhcyBjaGlwX2lu
Zm8gaXMgZXhjbHVkZWQuIEkgd2FudCB0byBiZSBzdXJlIGJlZm9yZQ0KPj4gc2VuZGluZyBuZXcg
cGF0Y2guDQo+Pg0KPj4gRG9lcyBpdCBzZWVtIGNvcnJlY3Q/DQo+DQo+VGhpcyBpcyBvbmUgc3Vp
dGFibGUgbWV0aG9kLCB5ZXMuDQo+DQo+LS0NCj5MZWUgSm9uZXMgW+adjueQvOaWr10NCg0KSGkg
TGVlLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgc3VwcG9ydC4NCg0KUmVnYXJkcywNCk9rYW4gU2Fo
aW4NCg==
