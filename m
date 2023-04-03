Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328B6D43B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDCLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjDCLlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:41:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774955B9A;
        Mon,  3 Apr 2023 04:41:13 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3339K96S013765;
        Mon, 3 Apr 2023 07:40:39 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pqrh51pjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 07:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNw0AfoEkWekOogi8KvKmfKToxnKDOf2/zk2gss3tRaJZS3xO/L+JtfiW2fVu3ZdPgLi5T4UPfNopiUlSMYkIUvvCE1upffN1F1//NOUFjLuDQO8r4YcHtcW4s052CkTpcQAGJMzqYKsHQGSavN/J7/FvBzPa/vFc3rRuhydo3kPb+QNsM7Q148xBvpLYCRToRkx7Dx3kGzo8hTi58geXxrbNQ3yoVRto45oCMeKLWO+ccICFtkj0Cj4YxdzK9iL6Qw0ptJLpO9CCEtNpinD/enXBMtqSFlI26D2LdXVugWMtr0LCj7NbP6NIurg9+GVD7OExzQArKLWylaz1lhlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDzIQZ0BfWTjDN/ZqhElbUKu9J1nEyYiUQDXhqRTfhQ=;
 b=f58o76iDPC100pVJ/Ar1+otdjSQ+elv3RquwLWI3aV76Gub6rSg5gpe54jjwjm2ya4Zc24NC3mHgDY4BA1HR5qwvRFud1g7OkpPdSUpmpRP9V6B2hDEXDKSZaSM+v7Q6VujC7txOym3WZdgRmhZ/uOcP18vrFHMfrUa/EzFOgbsjNQcN05GCZUXZQHYqGiyVeavnInCiZwkA8zNCySmpaXNki2LI5DRI1m2r9lY9TNv3d8nW4djLQORXEVLBKL+EtC2172mSovUWSjSjJ4pr0pnNXygCUCRTeMnAFoFznLH1Ehdky8eY+KU7jMuu2YZGufOJ3JMMieL2I8CtABsfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDzIQZ0BfWTjDN/ZqhElbUKu9J1nEyYiUQDXhqRTfhQ=;
 b=a74e+xtsF285adn3kw6fOly5LB7osek7OXxKHEvjg2l9PM32sLN3dl7A1za2YO2no+3KieltHVXmExlhemsiN6lzi9DZ+5nEEt6rnl9eQz9O6viapj1rZE3JUFARXsDU5gzHwlgBXpf0Ed/exUbkvl1GzjuIhLyShlfwCxRNfyQ=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 11:40:36 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 11:40:36 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Lee Jones <lee@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Thread-Index: AQHZUOiqG6ZyiGxaUE6S5aTx5qv2Ta78K/mAgAAAKICAE8FVcIACCFqAgAdrk0A=
Date:   Mon, 3 Apr 2023 11:40:36 +0000
Message-ID: <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
In-Reply-To: <20230329143615.GS2673958@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRVMk56ZGtOelZtTFdReU1UUXRNVEZsWkMxaVpXSm1MVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3MU5qYzNaRGMyTVMxa01qRTBM?=
 =?utf-8?B?VEV4WldRdFltVmlaaTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJak0xTXpVaUlIUTlJakV6TXpJME9UazFOak15TURjME1EZzNNU0lnYUQw?=
 =?utf-8?B?aVpFZFhXa2hTT0VzNGVrdHlMMnR0VWxsTmRuRjBOMGhXU1c5UlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQlNHaDBWVmxKVjJKYVFXVjZOMUJXTkdsQ1Zt?=
 =?utf-8?B?TTJOMUJ6T1ZocFNVWldlbTlFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB5950:EE_
x-ms-office365-filtering-correlation-id: 7812f8e3-3637-4347-3d1c-08db34383e03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jk6auRTO5JKk5x82he5TlVYov8eXP7k/WGZNWkk2DiT1+tuyQMxnCZCoNuS76rRESlWF1p62AtXpP4PMLqZTGh0p7CLsc6n6F4ilRDsSSwXJ3yoLzUEiqKd71x43kH/P7EuajX7whPri1S3u+fo+KN/1sOSoRjs0bP0HLG9FxmxvncNhcj4zPQDMPfpnbsaWPDOet4uCY3TWdnY6ei9/e2rB+oKRTAqRuWc+s7XLiFR5dSYWGCBYgr9g+aQhx9Ae5qf0ivpnnpscWqPuAs9bCSamJuDmhHYBPkcl75IfJ0uJ2Wao1ptDKqKk2kCEEa6DHLiPtjej+VFFnwXk1pI2U5mmkzESKixN4D+9cAWDrNhgNY7Ag0dXQNy+zLI8SeueB3IyB81HOpyPFV4rkhliWBpxgxW4ov2XQRyFZhTx+pJS4VZ2RlP7KRXoimHn0L8hnj6BEXRRNCvtDwIsIwo+rCDvqfVgLoOsBnoZhxQ0YfzFD+qCd7Dp9vkkGd+37a3/xtlPjx/5i8hBIaafsRQbQV5F36qgyNi4NHoaoqLKy4KfFbgqqI1CnrfbnlC0Bvq8DxSdBbKX33xWozC/kMSlUKMj/WqcaG+bQ467e2rB+xNOqDp/JeaIFmWw3y93tcv/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(83380400001)(186003)(9686003)(6506007)(26005)(6916009)(4326008)(478600001)(76116006)(8676002)(66946007)(66476007)(66446008)(66556008)(64756008)(41300700001)(122000001)(5660300002)(7416002)(38100700002)(316002)(54906003)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtYbEFDMFdQSTJ3NDI3QnJuSnU5R1Q4UXNsYjByVyt5N3JiR3o1K3hYZy9X?=
 =?utf-8?B?NVVSR1VtV3ZFMHg2L0RudHNZbDdOZXU0TkUyZVRSSHpoSXZaeWczUFlDcVEy?=
 =?utf-8?B?SHIyVWRDSjdVdjFmekIrbTRHMWZZb2pQQlJhNzRuL1d6bG9uLzBmT0tRSTNY?=
 =?utf-8?B?M0s2b0JWN05aRWU3cnI1WTNObEsyU1VIMDZLdy9CVEtldENhZmRVc1YzTzJq?=
 =?utf-8?B?UDZTeGF3N3RlTDFBdzNKVm45VE1aUFNnTlNIMlI0Ylc1Sm9iaDFkWjNKd01j?=
 =?utf-8?B?ZHZtNkMrWUZpK1ArNVEyRkEvQXlsMlVLWWl6NS9rMkJQK1hKbldKWWFBc3JS?=
 =?utf-8?B?THcraXVhV1FFak5zN1JlZjVoUmZpamNUWmlUS1FoSFNBcHBRTmJkSTg3VFFW?=
 =?utf-8?B?alM0b0E5Y3Nzd1JPZUJ3VTZOR0ZiRDJ0Skdua1oyM3BNV2lQS0V2M0M0TDQv?=
 =?utf-8?B?Vjdpc1UxSWFzbkpmSEhzcVdUblZxV0hEa3N6OGZJUG53anA5aXNMVjlDbnJa?=
 =?utf-8?B?Q1c2T0RJMDkxSkJVelJ1OGxSSXdqYlJzYnZqWXpyTUV1bW9sQnIrcXI3NGhG?=
 =?utf-8?B?dGIvRFdXTUdPWDAvN25YN0FQUjZManZzL3Iwbk9ZbFVJU0U2bDQ5T09mREp6?=
 =?utf-8?B?bDZHQ1FsdlNpMGllQ0IvRWJtT2hoelV0S3RTTFUzRlZDOFRueTNlbEppM3lY?=
 =?utf-8?B?UTV3bS9YdWwrNHQ4MkI4ZEZKbXFwaUd4QmZZbVJyZnhvY2ZmQW52cGNSanNI?=
 =?utf-8?B?VGp4TlBuem8vYlRRTStjTVRwVkxwQ1piN1pvYUlXRTBEcWdhQS9TekZERGZS?=
 =?utf-8?B?NEppd3BLYmpBTDMzUDl0N2FGTzZGU005Vm1OUkhmam1BQm1tQ3hKclhZNGNW?=
 =?utf-8?B?dnpnbU9CaWdzSjRpVlpuWCtacU9SY1FpSTBFRUJNVlFWQjZyUnJSc29rc3Jy?=
 =?utf-8?B?NDB4aEpPY2xROFVzaUR2aHAwZkNjMXgzL0pIdzVoMlZDM0cxUzYrMWEwUkJm?=
 =?utf-8?B?SmRZNE41M0NTUHhDRnZJRXZqK0U0Qm1pMlRYOTlXY3NOU29hUWswdmhWSG1H?=
 =?utf-8?B?K3F2ZGlCb1FqMitiYTIwVVNja2pTUUoxSmloV255bVA1REtuWTZHRXQ5Q0d2?=
 =?utf-8?B?UU1tUEwwTkdKZWc4aHphYkd0NFFmTnhMQVVQMjEzbytaemJYZTExY0w5b28y?=
 =?utf-8?B?TEpzeUpta0ZQL2c2MGs5RXJwU2lMa3gycllUaFFHTzJvOEdQRGorR2JPZDdK?=
 =?utf-8?B?eWUvRjJoY09xOHJFNXEvR1dxZWp5dUt1UnpzQUVwT1RidGlWdS8vVS9EZVls?=
 =?utf-8?B?Y1Ztc2F6RXpLNmtOektHSjBkRmhuMTN5bHhuYllnRDZTQnJlOVdnNEpodGhH?=
 =?utf-8?B?bmd0dzNlOEh6TXVBcGdKR0RkcGR5SDFuRWhHZTZ2SGNrZXVZUnBPMUx4TmE2?=
 =?utf-8?B?SHVtNGFMTXVCaXBZdWsvNGZHK3dPVGFncFhFR3VBYnBOaTR2Qm9WTE5PS2F3?=
 =?utf-8?B?NUZORjZQSllGalNvanNsVVhYMWhFd0FNcTZhbHh0Rnhja01URHdtb2JXSHgw?=
 =?utf-8?B?V2FtYzNQRnpFVVBSbTEvME5HUWNHTXEwVUFEaUtiSlNjZjFteEgxZDNwOW55?=
 =?utf-8?B?K0w2TS9CRG1DSExGeVhYcnNhdVlET245TDM3S3BaOE95OXgxYnU0S3U4blVo?=
 =?utf-8?B?VTF4K2U2QklVbkRHMzl6RzJHbWJLSkI5eXpvb25nNkMxYXpyS2JwUUx6Wlkx?=
 =?utf-8?B?eCtjYWJxeDlpWnhGbkVKSm5tM05HaHlQSm1BamhEL1RhOHNTemdrOHdXdGtq?=
 =?utf-8?B?TkVmM2FWQTVHQmt3TXgwRmpkekpBQnRtWHk1RXFqT0VtVjVLNmNzbUp4ZDdY?=
 =?utf-8?B?ZzFoS3Fld1VUTWFwSm1zS1FOb1ExUWQ5MEZTTG5IU3FoaFRqeWZZZUZsOWJN?=
 =?utf-8?B?QTBtWFgwcEUzTnBQdU10TTZ0V3dwb0tucXFtOUdYUldUZDFOMHhxRy9zYUU0?=
 =?utf-8?B?NVVmWFU4QmxjdU1yZkdZam9zRDBiZHF5Y0tOdnFSUlppR2pnbWg2RlhDYUNW?=
 =?utf-8?B?VnltdkFoMW54QWRIbVZ5c1cxc3B0R0Ntc09UMjJkL0ptSjBQS2ZPVFp5Mkc0?=
 =?utf-8?Q?RskH+SLxK/i3sLZmgsFOqqAy6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7812f8e3-3637-4347-3d1c-08db34383e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 11:40:36.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gq3adEETle2sYcs3jXF/yyepeHWhTuTgNQf1d6Z7XBd7TL8JA2DNsned4F6xPQcPLNKANCvS10banOrE7pznPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5950
X-Proofpoint-ORIG-GUID: oHpFOVqkl6ZfvRQUFx6cyoA6Uj2HRMFP
X-Proofpoint-GUID: oHpFOVqkl6ZfvRQUFx6cyoA6Uj2HRMFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_08,2023-04-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030087
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFR1ZSwgMjggTWFyIDIwMjMsIFNhaGluLCBPa2FuIHdyb3RlOg0KPg0KPj4gPk9uIFdlZCwg
MTUgTWFyIDIwMjMsIExlZSBKb25lcyB3cm90ZToNCj4+ID4NCj4+ID4+IE9uIFR1ZSwgMDcgTWFy
IDIwMjMsIE9rYW4gU2FoaW4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gPiBNRkQgZHJpdmVyIGZvciBN
QVg3NzU0MS9NQVg3NzU0MCB0byBlbmFibGUgaXRzIHN1YiBkZXZpY2VzLg0KPj4gPj4gPg0KPj4g
Pj4gPiBUaGUgTUFYNzc1NDEgaXMgYSBtdWx0aS1mdW5jdGlvbiBkZXZpY2VzLiBJdCBpbmNsdWRl
cyBidWNrDQo+PiA+PiA+IGNvbnZlcnRlciBhbmQgQURDLg0KPj4gPj4gPg0KPj4gPj4gPiBUaGUg
TUFYNzc1NDAgaXMgYSBoaWdoLWVmZmljaWVuY3kgYnVjayBjb252ZXJ0ZXIgd2l0aCB0d28gM0EN
Cj4+ID4+ID4gc3dpdGNoaW5nIHBoYXNlcy4NCj4+ID4+ID4NCj4+ID4+ID4gVGhleSBoYXZlIHNh
bWUgcmVnbWFwIGV4Y2VwdCBmb3IgQURDIHBhcnQgb2YgTUFYNzc1NDEuDQo+PiA+PiA+DQo+PiA+
PiA+IFNpZ25lZC1vZmYtYnk6IE9rYW4gU2FoaW4gPG9rYW4uc2FoaW5AYW5hbG9nLmNvbT4NCj4+
ID4+ID4gLS0tDQo+PiA+PiA+ICBkcml2ZXJzL21mZC9LY29uZmlnICAgICAgICAgIHwgIDEzICsr
DQo+PiA+PiA+ICBkcml2ZXJzL21mZC9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4+ID4+ID4g
IGRyaXZlcnMvbWZkL21heDc3NTQxLmMgICAgICAgfCAyMjQNCj4+ID4rKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gPj4gPiAgaW5jbHVkZS9saW51eC9tZmQvbWF4Nzc1NDEu
aCB8ICA5NyArKysrKysrKysrKysrKysNCj4+ID4+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMzM1IGlu
c2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4gPj4gPiBkcml2ZXJzL21mZC9tYXg3
NzU0MS5jICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+ID4+ID4gaW5jbHVkZS9saW51eC9tZmQvbWF4
Nzc1NDEuaA0KPj4gPj4NCj4+ID4+IEZZSTogSSdtIG5vdCByZS1yZXZpZXdpbmcgdGhpcyBzaW5j
ZSB5b3UndmUgY2hvc2VuIHRvIGlnbm9yZSBzb21lDQo+PiA+PiBvZiBteSBwcmV2aW91cyByZXZp
ZXcgY29tbWVudHMuICBJc3N1ZXMgaGlnaGxpZ2h0ZWQgYnkgcmV2aWV3DQo+PiA+PiBjb21tZW50
cyBkb24ndCBqdXN0IGdvIGF3YXkgb24gcmVzdWJtaXNzaW9uLg0KPj4gPg0KPj4gPi4uLiBhbmQg
dGhlIHN1YmplY3QgaXMgbWFsZm9ybWVkLg0KPj4gPg0KPj4gPi0tDQo+PiA+TGVlIEpvbmVzIFvm
nY7nkLzmlq9dDQo+Pg0KPj4gSGkgTGVlLA0KPj4NCj4+IEkgYW0gc29ycnkgaWYgSSBtaXNzZWQg
eW91ciByZXZpZXcgY29tbWVudHMsIHRoaXMgd2FzIG5vdCBteSBpbnRlbnRpb24uIEkgd2FudA0K
PnRvIHRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24uIFlvdXIgZmVlZGJhY2tzIGFyZSB2
ZXJ5IHZhbHVhYmxlLCBhbmQgSSBhbQ0KPnRyeWluZyB0byB1bmRlcnN0YW5kIGFuZCBmaXggZWFj
aCBvbmUgYmVmb3JlIHNlbmRpbmcgdGhlIHBhdGNoLiBJbmRlZWQsIEkgc29ydGVkDQo+eW91ciBm
ZWVkYmFjayBvbiBwcmV2aW91cyBwYXRjaGVzLiBBcyBmYXIgYXMgSSBrbm93LCBJIGhhdmUgZml4
ZWQgYWxsIG9mIHRoZW0sIGlzDQo+dGhlcmUgYSBwcm9ibGVtIHdpdGggYW55IG9mIHRoZW0gdGhh
dCBJIGZpeGVkLCBvciBpcyB0aGVyZSBhbnkgbWlzc2luZyByZXZpZXc/DQo+RnJvbSB5b3UsIHRo
ZXJlIHdlcmUgc29tZSBjb21tZW50cyBsaWtlICJ3aHkgZGlkIHlvdSB1c2UgdGhpcz8iLCBJIHN1
cHBvc2UgSQ0KPm5lZWQgdG8gcmVzcG9uZCB0aGVtIGJlZm9yZSBzZW5kaW5nIGZvbGxvd2luZyBw
YXRjaGVzLiBJIHRob3VnaHQgSSBzaG91bGQgbm90DQo+Ym90aGVyIHRoZSBtYWludGFpbmVycyB1
bm5lY2Vzc2FyaWx5LiBJIGFtIHNvcnJ5IGZvciB0aGVtLg0KPg0KPlBsZWFzZSBhc2sgeW91ciBl
bWFpbCBjbGllbnQgdG8gbGluZS13cmFwLg0KPg0KPkhlcmUgaXMgdGhlIHBhcnQgb2YgdGhlIHJl
dmlldyB5b3UgaWdub3JlZDoNCj4NCj5bLi4uXQ0KPg0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
Y2hpcF9pbmZvIGNoaXBbXSA9IHsNCj4NCj5XaHkgZG8geW91IG5lZWQgdGhpcyByZXF1aXJlIHN1
Yi1zdHJ1Y3R1cmU/DQo+DQo+PiArCVtNQVg3NzU0MF0gPSB7DQo+PiArCQkuaWQgPSBNQVg3NzU0
MCwNCj4+ICsJCS5uX2RldnMgPSBBUlJBWV9TSVpFKG1heDc3NTQwX2RldnMpLA0KPj4gKwkJLmRl
dnMgPSBtYXg3NzU0MF9kZXZzLA0KPj4gKwl9LA0KPj4gKwlbTUFYNzc1NDFdID0gew0KPj4gKwkJ
LmlkID0gTUFYNzc1NDEsDQo+PiArCQkubl9kZXZzID0gQVJSQVlfU0laRShtYXg3NzU0MV9kZXZz
KSwNCj4+ICsJCS5kZXZzID0gbWF4Nzc1NDFfZGV2cywNCj4+ICsJfSwNCj4+ICt9Ow0KPg0KPlsu
Li5dDQo+DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWF4Nzc1NDFfb2Zf
aWRbXSA9IHsNCj4+ICsJew0KPj4gKwkJLmNvbXBhdGlibGUgPSAiYWRpLG1heDc3NTQwIiwNCj4+
ICsJCS5kYXRhID0gJmNoaXBbTUFYNzc1NDBdLA0KPj4gKwl9LA0KPj4gKwl7DQo+PiArCQkuY29t
cGF0aWJsZSA9ICJhZGksbWF4Nzc1NDEiLA0KPj4gKwkJLmRhdGEgPSAmY2hpcFtNQVg3NzU0MV0s
DQo+PiArCX0sDQo+PiArCXsgLyogc2VudGluZWwgKi8gIH0NCj4+ICt9Ow0KPj4gK01PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG1heDc3NTQxX29mX2lkKTsNCj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGkyY19kZXZpY2VfaWQgbWF4Nzc1NDFfaTJjX2lkW10gPSB7DQo+PiArCXsgIm1heDc3
NTQwIiwgKGtlcm5lbF91bG9uZ190KSZjaGlwW01BWDc3NTQwXSB9LA0KPj4gKwl7ICJtYXg3NzU0
MSIsIChrZXJuZWxfdWxvbmdfdCkmY2hpcFtNQVg3NzU0MV0gfSwNCj4NCj5KdXN0ICdNQVg3NzU0
MCcgaXMgZmluZS4NCj4NCj4+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+DQo+UmVtb3ZlIHRoZSBj
b21tZW50LCB3ZSBrbm93IGhvdyB0ZXJtaW5hdG9ycyB3b3JrLg0KPg0KPlNhbWUgY29tbWVudHMg
Zm9yIG1heDc3NTQxX29mX2lkLg0KPg0KPi0tDQo+TGVlIEpvbmVzIFvmnY7nkLzmlq9dDQoNCkhp
IExlZSwNCg0KSW4gZmFjdCwgb25lIG9mIHRoZSBtYWludGFpbmVycyBzdWdnZXN0ZWQgYXNzaWdu
aW5nIGNoaXBfaW5mbyB0byBkYXRhIGluc3RlYWQgb2YgZW51bWVyYXRpb24uIFRoZW4gSSBhZGRl
ZCBjaGlwX2luZm8gYW5kIHB1dCBkZXZpY2VzIGludG8gc3ViLXN0cnVjdHVyZSBhYm92ZS4gSSB3
aWxsIHJlcGxhY2UgY2hpcF9pbmZvIHdpdGggaWQgc3RydWN0dXJlIGluIG1heDc3NTQxIGRldmlj
ZSBzdHJ1Y3R1cmUsIHJpZ2h0PyBJIHdpbGwgdXNlIGVudW1lcmF0aW9uIGZvciBkYXRhIGFzIEkg
d2lsbCBhc3NpZ24gaXQgdG8gaWQsIGFuZCBkaXN0aW5ndWlzaCBkaWZmZXJlbnQgZGV2aWNlcy4N
Cg0KUmVnYXJkcw0KT2thbiBTYWhpbg0K
