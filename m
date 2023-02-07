Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328F468D33C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjBGJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjBGJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:50:08 -0500
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFD2F7A1;
        Tue,  7 Feb 2023 01:50:06 -0800 (PST)
Received: from pps.filterd (m0094031.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317632M2011001;
        Tue, 7 Feb 2023 04:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=7vDd2TwpcwS1FsCqG25EIjWl6meyqPVHL3KzMrIjnlA=;
 b=tJNM9/7/Kl8SWzEQycgnEc4FFjWfxrbnMXVLGSp3bfLIMosQ9H6WkewhrBGVuoevyXIa
 dqcS//xJ/IBt4MZhMumqU5AbpVkOqbzpZN/KNwZWi3UqZj1JkJjPJaUEs3te4ZMF4R+V
 Kk/Iupx1y7A4KeSXm+StWRu9ZVZB7sbE6voFpW+OS8eu98xsFNYYJLmkR7CRqBWEWPh1
 8qta+ie4h61TpydTaV7s23mycDM69+AeHBh4LMfMpEDklyO1gKxzgMX+gv9931MOYISM
 /l3SH15u+FBBW1QERVKO8H2R1yvo9rWIJYXKeWmil2eJ1EVHGrxV/J+7xcEC+wo4IGJ6 FQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3nkh1m19rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 04:49:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTkycKwXBm2W6dflQG13j8cuPoh9tuoW5IvT+Bbu6A8n4iVas1kzSP5pCBvx7U3CEyLe4MS3aOhPN8+1GSDHEZZOO3aOvlI4052qkQ84AzMooVwOOxA6OnD2szf3pYfntn7gREVUJPAWLlS9MHQ3LHxxQfzkN7aBC7YJU4CucmDS0k+txjI1OvgBl/5TbjjlRHZPGboOjt6Ns19GNJELIiN3F3na8plibtj/ZNtWZhPdUfGOGsisNLkZOScOGnUDWVbgCBT+OrsDwEDAlqMplP09wtwP6i85i2lABiD3ewTKEtm+68wPVqSyrXaEBVHgEk3iuPYoAdSx+BD2Yhe4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vDd2TwpcwS1FsCqG25EIjWl6meyqPVHL3KzMrIjnlA=;
 b=AEs2k/w5RQs7yJsdjZBtqat+Bwzy1Nt5aNQA0uylKfrdO5pBlToOO9qGxfAfEBz9yxSrcDMqMHNb3AcwMgcAcx3aa19/dPx+Ah8di+Ka2exrr2I8i+f2XA2/rNF9lkDTx04l2J5a3TXDf4j3VfR/5v+KiGvjKRcfrU3CA2BMhTCgCykx3fjchK4awrk0maW3pkbmpTmE8c/kaZxdnbE5oOrDRR80LcCQdYhEF3kPUdzemjZR7i8mSxqWKeO84ZU7KoNSgZjmD6xfdvgfUpSDV6Mib/Qd8d8JXzizNjHH9CUj23q6OaZoAKSyyKEnx6+DdEHgD7jQ7BsIlPQg+kW9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by DM4PR15MB6226.namprd15.prod.outlook.com (2603:10b6:8:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 09:49:54 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 09:49:54 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: improve wb,mbl-gpio binding
 documentation.
Thread-Topic: [PATCH v2 1/2] dt-bindings: improve wb,mbl-gpio binding
 documentation.
Thread-Index: AQHZNhb7DuWpvF2uhky7Ck0Dr/cknq7DRuKA
Date:   Tue, 7 Feb 2023 09:49:53 +0000
Message-ID: <1aa27ad3-d6a3-6ef1-5e56-36697583988c@ncr.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
 <20230126-gpio-mmio-fix-v2-1-38397aace340@ncr.com>
 <4df3ec7a-e4af-89bc-9eda-21150395a935@linaro.org>
In-Reply-To: <4df3ec7a-e4af-89bc-9eda-21150395a935@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|DM4PR15MB6226:EE_
x-ms-office365-filtering-correlation-id: 0c7935b5-7fde-4618-2e38-08db08f0aa06
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EgJj63vHB2U43tZvvYhXZwfo2QRGrW2GQlWPb/9wZOmrbxJxn6QaReRz895yg9s8P+N5QegAnIwGGxBWV4iQl6fRmaoSLCJqF8y5+tG6S+1wQ5AfVtc8R2paLbADH2CIrAM5f/iG8A9q1LH2Li11KWAoDR7E4T6odgmmBn0Hlix5QoRLjCcY1Q+Qwpv9qzjn/oXYjUzGLs0HWFDCHu5mgew8FOgfGnCb0FlGeKI7iXB003txxYoskSDa+dCm443EPpAc+dcod0S92VmHsrSgxkE35VbcwnJNaQQ+THIvx1Qb4VOTzKBpeMqTpn2Ej6dQz796Ce7GicRaa+tU75SM6oTtcdg7tekZf5OWHUsmBH0mQJmFuW5jlS6ghGYzHGR/mjRd8dEC5x3GMJ1bEeVZZF7H52/ryzcbDHyz1y7REPcZgwHuXtNco5CjY14WcMJnivvtugKOYCPwMN8Qnek/xQ59Ok4j/mkdIlfpZmh1qJuKGkTGRiUd5h2vLBH5VF9rqdPJu66g7pqgpEcaYAS7x3EO4BSeeztNnWTdVf+CIFa+qlg+MTLOTAkH5e7BL1lf5lLulw8DKoxqRlEelUwaYHjuG+tG/ycU5x3Clx311+NAeIUEgN+3SXniPm2J+M6eQrFzfuD5m//WHp/NG5BDQe0494rEGyWfWpXtgf8yqJQQHqGo2bIEoZhaK1xX1oiJMaB4KC56Q9z2m6M5bOvW2naVaPIQ8GNuoNKOgRJcGdkY+ptijM1iCFN/K19aAju8Of66S8ioOwxK648fd/m6AK4KZACo2B7Qq8z4PZqH81k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199018)(6512007)(186003)(966005)(6506007)(36756003)(53546011)(26005)(478600001)(38070700005)(55236004)(122000001)(38100700002)(82960400001)(54906003)(110136005)(316002)(71200400001)(41300700001)(8936002)(2906002)(5660300002)(66446008)(66556008)(64756008)(83380400001)(66946007)(91956017)(31696002)(66476007)(2616005)(6486002)(8676002)(76116006)(4326008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azZiNFU5RWs4WWNDOWR3c0J4bkpHcVhjNHhIZ3pTMUQrWmN1eFRvbnZUY0Ri?=
 =?utf-8?B?a0hVb2VMMVNqbC9tQUFSQUhyaDV5dkxrV3lTRHl2OUlVdjV5TzhkeFozSjFI?=
 =?utf-8?B?TEk2Ull3b1k3VE5HUmJHMmY3dzVvRi9UNUltZHRKVDFMaFh6Y1o3RUJ3TmRJ?=
 =?utf-8?B?YVVwYThFQVJvbEtSSkhQbVhLbHh4Nnc5eVVjclNyRC82MFJEbFc5OHdDQXVK?=
 =?utf-8?B?Qy9RMHFTWHhHeTBYSFNPRjlpd3RySkh3KzdQa3RFUGkyNEpmTzNhQUEvaHRP?=
 =?utf-8?B?UGZ2Q1dhREQ2cXloTXY5TmdHMUdycFRyU0dRQ2huZjhzSXJGUWhianBublFv?=
 =?utf-8?B?ZTJCQmdGZndqVy9IZGdRK2NFWmQyTEpSQTJkSGZENUpWSEhBZ2JWbGozSXM2?=
 =?utf-8?B?Sld5M0EyMEdrZDVEZ2tSdXVXOUtIWTZnTE4zUXNtUnYyTWphaWhENVg3ZVFH?=
 =?utf-8?B?dEJBWVJOVGtIajdXVEl2eE0vZ1RSdi8vUGd3QTFRWFVXUTYwRzh4T0tFaEhp?=
 =?utf-8?B?S3h0TkdMMGZlbGQ1OHFrVGZhdG10OVlqeGExVG1Cc29INUV3TTN0OVlrajU4?=
 =?utf-8?B?TkY4ME9hbUF3eW9kZnlaVVVGWXFuZEZ3V2E2QUlINU8zR1V3TTU0MFNFNTAv?=
 =?utf-8?B?aWFpY3Rad2NHRG1kdjdNc0NMeEVOdG0zeHV2Z0dpUFZQTVRNd0dtQlpLVTla?=
 =?utf-8?B?cnNLSU4vcUIyYS9leHVoSFEzMmE5S1lDR3RFZklzcHNIY2x2WkNoR21PNnVD?=
 =?utf-8?B?Q1ArbW9nR0I1Nm5RN1RQTFQ2dEt6amFSdlF1eXNsMUxjdTQySkp1aWQ4dC9x?=
 =?utf-8?B?czVYM3FTNTVIWWlzdmtkY3Q0MEljRHBqbitvVW1XT1MyQjh6V0NpazUrYTJZ?=
 =?utf-8?B?UXBldTNPN0lrYWt3TGZQVUhSdG9taTZidjZlcVJadUMwTkNtZDg4NUxFWlVP?=
 =?utf-8?B?TTM0cE9Dek9WR2hrRkwvMHUrM2FsZFpUZk54bjdJNzd5b3NGdDdVdCtkRkVH?=
 =?utf-8?B?N3VqSTU5RXh5YklBK0RIeWNQajNONlFrMm80ZHRpdFVJRHpTWW95aVhKbUNW?=
 =?utf-8?B?Mk9pNTZ0SXRoRTdKa0FQSndCM1FFN1F3ZllmUnpncVhwYkgxb1VTUGdsQ2Vo?=
 =?utf-8?B?dmFNTGVNVGpVQ2YxZ2p0Rnd2VFhWbkJZa3ltQkVWRUJlMEZGSndjdTRaUnda?=
 =?utf-8?B?UHJMSGNYOU5paDA1a01vNlYyQzhoWDFRbW13QjZvcUFJcVFEcUY2d2pTcHY4?=
 =?utf-8?B?cjVycXBYK1FtUVZQamltMmJnWnRPdkZQZTErSGVRZXJ2OTcxSEx6ZGJSWllh?=
 =?utf-8?B?THhXQVpWVlBhcEozcUJsM1g4RFVvUzNKbjBVRXR4b05UWFF3SGg5VWJiUkx0?=
 =?utf-8?B?MXZPUnp1WGovQ1IybnQwZ3IzaDNsNm9DVmkvRTRxcW9pajJoNFFMejJaRHBX?=
 =?utf-8?B?WVRYMWVmU0x1QkhYTWZBNXlaaG5uOFd4OHlSRnlRcndVenYzaXVDU0VxU0pY?=
 =?utf-8?B?dmNaQ3FxN1hPYnNYTitrdzN1K1dicGY3WG5oWElYRWZwUGxKaCtQYWFCLzdw?=
 =?utf-8?B?RTEwTXZHOUlhTDZpTHpMQ000Q0plck9QRGVTTUZ0amRJQUVwM3ptTGNvd2lw?=
 =?utf-8?B?U2o4M3VHWDdCalRIN1R1QnM4NHZNcGNzWnpxeEZoemczUWtHVkRyeDBrY3JY?=
 =?utf-8?B?cDR1SFk2aEFiYXVXc2Q5aGNUeUZtZ2tPejRjeFcvOG51MXlEUEVxQlJSdjVL?=
 =?utf-8?B?TnZTNmtKSXdFUmxTcHNEd1NpQWgyR3NUaVpnYThSVkR5QUVHd1d4LzFRMXpR?=
 =?utf-8?B?ZUo3MloyS0d2VjRmQ3FRS2U2QTFDeW84dlRFVWhlOTk4Ym1pL3p6UVZpZ08v?=
 =?utf-8?B?SmE3K3FXeW5JYmFCOEVmNTRUS1I2Qll6cTdaNzhiTjBwdTBSM3V6YWhjRWF4?=
 =?utf-8?B?ZjQzeTdGVmhid0Q3MkJzRmRJeWVVcGpwd0dycHBjU2VwQ1BoZURiS0pacXhs?=
 =?utf-8?B?Y2NZbldJcXNwdGRjNXRIdXdOTGFkMjFZRlJZSWd1UjdVMnNMVFByMHNibmZk?=
 =?utf-8?B?cDMzTTBXOURrY0ROQTFZZ1p0dFZQL3JXeGs4NHAwS29hcXAvRENnNnRFTzdv?=
 =?utf-8?Q?qMz0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2015D2932A27124EB724085557D88A96@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s1U7KTSxQa2h6C2+p9IbE8iNrya+j9hqn56A0O1Zo/YYLH9y9Yqtc5dOYgmf4IZhOUCXuIiO0Hm5uhEqetZN9hviB1OJY6T5mAI5tS2U9CUqDf8VmxsvKamlGJmc0K/Dr6tkxMVAmMblNtlhhcu1p1NfvWjBjLQyV2XTaGhb1qAKHMftT4rfxbJFBCLXI7a5gOGB0O2oCtVwDr/vkkKg1W0WPPuJHUEHHQoyGMYKneA+ZsIaMMY+P1VdlJQcadKasqL7u//km38riGsZmaw/qwtAyV0Vgs7USftP4lONfu8Jv/sQSmZ6FEV+ZzcQo+Iee0EbgFAk0/c8xLkuskAb0KeZaUTXP5XbTbzX03SqW6hqZ0H4FAQUD153DPSXa3iplf27RKK315jUnqrbsh8uUCGYc7BD0LJasZTSQL/yXLtxnTapa9ZY5YmQ20pYe1wGH1BUnjYx8lCOGr5n6ECEgcL6rxHVBeiH7CvDbtgsHu7Ml/HYPMn73iRZL+j085aag61TMLrsh3oDAkw5BiWt/mf7W0/oQNKZ6B7oT+7+BpjVi1fgp/+K2u0ilioQiEX6exLU+C3UTdDAP9qCfAaqQ+tbb90lU64Hz6fgtI9wKpJEi8B625Twzq0EI3Jw2imO7NvzhvkKgBDNL1d0QB7SKSSanpL4B1QygXfqFT4AIwAbgLRoUhgOkKZDkAPVIKiQl8IUhC5Kw6XRGUVdvbXQ6/jXknNhdM0vYjE/bTdJj36H8fF4MZGqgwQmdFM2fgB92bP5DLOk3MvSvvpqnFG73a2zyXhTmKTXhJYBhzNm23+HWgDMKW3Q8O4C3Tzt+m1BYSqHjcNB1VaQNt7Fxi4IL2RnMIYfuYS0r+jfFz9NOa8=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7935b5-7fde-4618-2e38-08db08f0aa06
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 09:49:54.0136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/ZO3Hq9Qi6RXgdJKb8sji2pfrnQeMS1sCdAc0DfQ4UwZh9crx+AyMnV8NCJNKvehW71AuRTv2RkJfOq2AxxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6226
X-Proofpoint-GUID: Fcs3aalCWZ3_bxBJquDCJEHTrXAWdjom
X-Proofpoint-ORIG-GUID: Fcs3aalCWZ3_bxBJquDCJEHTrXAWdjom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_02,2023-02-06_03,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDIvMjAyMyAwODoyNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gKkV4dGVy
bmFsIE1lc3NhZ2UqIC0gVXNlIGNhdXRpb24gYmVmb3JlIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IE9uIDMxLzAxLzIwMjMgMTQ6NDksIE5pYWxsIExlb25hcmQgdmlhIEI0IFN1
Ym1pc3Npb24gRW5kcG9pbnQgd3JvdGU6DQo+PiBGcm9tOiBOaWFsbCBMZW9uYXJkIDxubDI1MDA2
MEBuY3IuY29tPg0KPj4NCj4+IENvbnZlcnQgZXhpc3Rpbmcgd2QsbWJsLWdwaW8gYmluZGluZyBk
b2N1bWVudGF0aW9uIHRvIFlBTUwgYW5kIGFkZA0KPj4gbmV3IG9wdGlvbmFsIHByb3BlcnkgIm5v
LWlucHV0Ii4NCj4gDQo+IFN1YmplY3Q6IGRyb3AgZnVsbCBzdG9wDQo+IA0KPiBVc2Ugc3ViamVj
dCBwcmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtICh3aGljaCB5b3UgY2FuIGdldCBmb3IN
Cj4gZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAg
b24gdGhlIGRpcmVjdG9yeQ0KPiB5b3VyIHBhdGNoIGlzIHRvdWNoaW5nKS4NCj4gDQo+IFN1Ympl
Y3Q6IGltcHJvdmUgaXMgdmFndWUuIEluc3RlYWQ6IGNvbnZlcnQgdG8gRFQgc2NoZW1hDQo+IA0K
PiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWFsbCBMZW9uYXJkIDxubDI1MDA2MEBuY3IuY29t
Pg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8u
dHh0ICAgICAgIHwgMzggLS0tLS0tLS0tLS0NCj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
Z3Bpby93ZCxtYmwtZ3Bpby55YW1sICAgICAgfCA3OCArKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlv
L3dkLG1ibC1ncGlvLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlv
L3dkLG1ibC1ncGlvLnR4dA0KPj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAw
MzhjM2E2YTFmNGQuLjAwMDAwMDAwMDAwMA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8udHh0DQo+PiArKysgL2Rldi9udWxsDQo+PiBA
QCAtMSwzOCArMCwwIEBADQo+PiAtQmluZGluZ3MgZm9yIHRoZSBXZXN0ZXJuIERpZ2l0YWwncyBN
eUJvb2sgTGl2ZSBtZW1vcnktbWFwcGVkIEdQSU8gY29udHJvbGxlcnMuDQo+PiAtDQo+PiAtVGhl
IFdlc3Rlcm4gRGlnaXRhbCBNeUJvb2sgTGl2ZSBoYXMgdHdvIG1lbW9yeS1tYXBwZWQgR1BJTyBj
b250cm9sbGVycy4NCj4+IC1Cb3RoIEdQSU8gY29udHJvbGxlciBvbmx5IGhhdmUgYSBzaW5nbGUg
OC1iaXQgZGF0YSByZWdpc3Rlciwgd2hlcmUgR1BJTw0KPj4gLXN0YXRlIGNhbiBiZSByZWFkIGFu
ZC9vciB3cml0dGVuLg0KPj4gLQ0KPj4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAtCS0gY29t
cGF0aWJsZTogc2hvdWxkIGJlICJ3ZCxtYmwtZ3BpbyINCj4+IC0JLSByZWctbmFtZXM6IG11c3Qg
Y29udGFpbg0KPj4gLQkJImRhdCIgLSBkYXRhIHJlZ2lzdGVyDQo+PiAtCS0gcmVnOiBhZGRyZXNz
ICsgc2l6ZSBwYWlycyBkZXNjcmliaW5nIHRoZSBHUElPIHJlZ2lzdGVyIHNldHM7DQo+PiAtCQlv
cmRlciBtdXN0IGNvcnJlc3BvbmQgd2l0aCB0aGUgb3JkZXIgb2YgZW50cmllcyBpbiByZWctbmFt
ZXMNCj4+IC0JLSAjZ3Bpby1jZWxsczogbXVzdCBiZSBzZXQgdG8gMi4gVGhlIGZpcnN0IGNlbGwg
aXMgdGhlIHBpbiBudW1iZXIgYW5kDQo+PiAtCQkJdGhlIHNlY29uZCBjZWxsIGlzIHVzZWQgdG8g
c3BlY2lmeSB0aGUgZ3BpbyBwb2xhcml0eToNCj4+IC0JCQkwID0gYWN0aXZlIGhpZ2gNCj4+IC0J
CQkxID0gYWN0aXZlIGxvdw0KPj4gLQktIGdwaW8tY29udHJvbGxlcjogTWFya3MgdGhlIGRldmlj
ZSBub2RlIGFzIGEgZ3BpbyBjb250cm9sbGVyLg0KPj4gLQ0KPj4gLU9wdGlvbmFsIHByb3BlcnRp
ZXM6DQo+PiAtCS0gbm8tb3V0cHV0OiBHUElPcyBhcmUgcmVhZC1vbmx5Lg0KPj4gLQ0KPj4gLUV4
YW1wbGVzOg0KPj4gLQlncGlvMDogZ3BpbzBAZTAwMDAwMDAgew0KPj4gLQkJY29tcGF0aWJsZSA9
ICJ3ZCxtYmwtZ3BpbyI7DQo+PiAtCQlyZWctbmFtZXMgPSAiZGF0IjsNCj4+IC0JCXJlZyA9IDww
eGUwMDAwMDAwIDB4MT47DQo+PiAtCQkjZ3Bpby1jZWxscyA9IDwyPjsNCj4+IC0JCWdwaW8tY29u
dHJvbGxlcjsNCj4+IC0JfTsNCj4+IC0NCj4+IC0JZ3BpbzE6IGdwaW8xQGUwMTAwMDAwIHsNCj4+
IC0JCWNvbXBhdGlibGUgPSAid2QsbWJsLWdwaW8iOw0KPj4gLQkJcmVnLW5hbWVzID0gImRhdCI7
DQo+PiAtCQlyZWcgPSA8MHhlMDEwMDAwMCAweDE+Ow0KPj4gLQkJI2dwaW8tY2VsbHMgPSA8Mj47
DQo+PiAtCQlncGlvLWNvbnRyb2xsZXI7DQo+PiAtCQluby1vdXRwdXQ7DQo+PiAtCX07DQo+PiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJs
LWdwaW8ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL3dkLG1i
bC1ncGlvLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAw
MDAuLmQxYzcyYTQyYzViYw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vd2QsbWJsLWdwaW8ueWFtbA0KPj4gQEAgLTAsMCAr
MSw3OCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBC
U0QtMi1DbGF1c2UNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9ncGlvL3dkLG1i
bC1ncGlvLnlhbWwqX187SXchIUluNFFsdyFxQmE3TjBjY1ByTlFtak1lVTlIaS1BbzNLeFk0Rmoy
ZlhRdXRjTm1wR3hsWEY3R0x5N3FqUms3azJBQmszeU43b2k3dGlvNlBvWnlZLWxzT1RUcmVJYUN4
cC1oSSQNCj4+ICskc2NoZW1hOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUluNFFsdyFxQmE3TjBj
Y1ByTlFtak1lVTlIaS1BbzNLeFk0RmoyZlhRdXRjTm1wR3hsWEY3R0x5N3FqUms3azJBQmszeU43
b2k3dGlvNlBvWnlZLWxzT1RUcmVJYlQyVHpCVCQNCj4+ICsNCj4+ICt0aXRsZTogV2VzdGVybiBE
aWdpdGFsJ3MgTXlCb29rIExpdmUgbWVtb3J5LW1hcHBlZCBHUElPIGNvbnRyb2xsZXJzLg0KPiAN
Cj4gRHJvcCBmdWxsIHN0b3AuDQo+IA0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBO
aWFsbCBMZW9uYXJkIDxubDI1MDA2MEBuY3IuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOiB8
Kw0KPj4gKyAgQmluZGluZ3MgZm9yIHRoZSBXZXN0ZXJuIERpZ2l0YWwncyBNeUJvb2sgTGl2ZSBt
ZW1vcnktbWFwcGVkIEdQSU8gY29udHJvbGxlcnMuDQo+IA0KPiBEcm9wICJCaW5kaW5ncyBmb3Ii
LiBBY3R1YWxseSBkcm9wIGVudGlyZSBsaW5lIC0gaXQncyByZWR1bmRhbnQsIHlvdQ0KPiByZXBl
YXQgdGhlIHRpdGxlLg0KPiANCj4+ICsNCj4+ICsgIFRoZSBXZXN0ZXJuIERpZ2l0YWwgTXlCb29r
IExpdmUgaGFzIHR3byBtZW1vcnktbWFwcGVkIEdQSU8gY29udHJvbGxlcnMuDQo+PiArICBCb3Ro
IEdQSU8gY29udHJvbGxlciBvbmx5IGhhdmUgYSBzaW5nbGUgOC1iaXQgZGF0YSByZWdpc3Rlciwg
d2hlcmUgR1BJTw0KPj4gKyAgc3RhdGUgY2FuIGJlIHJlYWQgYW5kL29yIHdyaXR0ZW4uDQo+PiAr
DQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiAr
ICAgICAgLSB3ZCxtYmwtZ3Bpbw0KPj4gKw0KPj4gKyAgcmVnLW5hbWVzOg0KPj4gKyAgICBpdGVt
czoNCj4+ICsgICAgICAtIGNvbnN0OiBkYXQNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4
SXRlbXM6IDENCj4+ICsNCj4+ICsgICIjZ3Bpby1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAyDQo+
PiArDQo+PiArICBncGlvLWNvbnRyb2xsZXI6IHRydWUNCj4+ICsNCj4+ICsgIG5vLW91dHB1dDoN
Cj4+ICsgICAgZGVzY3JpcHRpb246IEdQSU9zIGFyZSByZWFkLW9ubHkuDQo+PiArDQo+PiArICBu
by1pbnB1dDoNCj4+ICsgICAgZGVzY3JpcHRpb246IEdQSU9zIGFyZSB3cml0ZS1vbmx5Lg0KPiAN
Cj4gDQo+IFNwbGl0IGFkZGluZyBuZXcgcHJvcGVydHkgaW50byBzZXBhcmF0ZSBwYXRjaC4gRWFj
aCBwYXRjaCBzaG91bGQgZG8gb25lDQo+IGxvZ2ljYWwgY2hhbmdlLiBOZXcgZmVhdHVyZSBpcyBh
bm90aGVyIGxvZ2ljYWwgY2hhbmdlLiBDb252ZXJzaW9uIGlzDQo+IHRoYXQgbG9naWNhbCBjaGFu
Z2UgKHdpdGggYW55IGZpeGVzIG5lZWRlZCBmb3Igc3VjY2Vzc2Z1bCBjb252ZXJzaW9uLA0KPiBi
dXQgbm90IHdpdGggbmV3IGZlYXR1cmVzKS4NCj4gDQo+IA0KPj4gKw0KPj4gK3JlcXVpcmVkOg0K
Pj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZy1uYW1lcw0KPj4gKyAgLSByZWcNCj4+ICsg
IC0gJyNncGlvLWNlbGxzJw0KPiANCj4gVXNlIGNvbnNpc3RlbnQgcXVvdGVzIC0gZWl0aGVyICcg
b3IgIg0KPiANCj4+ICsgIC0gZ3Bpby1jb250cm9sbGVyDQo+PiArDQo+PiArYWRkaXRpb25hbFBy
b3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAg
Z3BpbzA6IGdwaW8wQGUwMDAwMDAwIHsNCj4gDQo+IGdwaW9ADQo+IA0KPiAoMCBpcyBub3QgY29y
cmVjdCBuYW1lIG9mIG5vZGUpDQo+IA0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJ3ZCxtYmwt
Z3BpbyI7DQo+PiArICAgICAgICByZWctbmFtZXMgPSAiZGF0IjsNCj4+ICsgICAgICAgIHJlZyA9
IDwweGUwMDAwMDAwIDB4MT47DQo+PiArICAgICAgICAjZ3Bpby1jZWxscyA9IDwyPjsNCj4+ICsg
ICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4+ICsgICAgfTsNCj4+ICsNCj4+ICsgICAgZ3BpbzE6
IGdwaW8xQGUwMTAwMDAwIHsNCj4gDQo+IGdwaW9ADQo+IA0KPj4gKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJ3ZCxtYmwtZ3BpbyI7DQo+PiArICAgICAgICByZWctbmFtZXMgPSAiZGF0IjsNCj4+ICsg
ICAgICAgIHJlZyA9IDwweGUwMTAwMDAwIDB4MT47DQo+PiArICAgICAgICAjZ3Bpby1jZWxscyA9
IDwyPjsNCj4+ICsgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4+ICsgICAgICAgIG5vLW91dHB1
dDsNCj4+ICsgICAgfTsNCj4+ICsNCj4gDQo+IERyb3AgYWxsIGV4YW1wbGVzIGJlbG93LCB0aGV5
IGFyZSBub3QgbmVlZGVkLiBBY3R1YWxseSBldmVuIHRoZXNlIHR3bw0KPiBhYm92ZSBjb3VsZCBi
ZSBjb21iaW5lZCBhcyB0aGV5IGRpZmZlciB3aXRoIG9ubHkgb25lIHByb3BlcnR5Lg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpUaGFua3MgZm9yIHJldmlld2luZy4gSSds
bCBtYWtlIHRoZSBzdWdnZXN0ZWQgY2hhbmdlcy4NCg0KWW91IG1pZ2h0IG5vdGUgdGhhdCBJIGFk
ZGVkIG15c2VsZiBhcyBtYWludGFpbmVyIG9mIHRoaXMgZmlsZSAoYXMgaXQgDQp3b3VsZG4ndCBw
YXNzIHRoZSBkdCBjaGVja3Mgb3RoZXJ3aXNlKSBidXQgdGhhdCBjYW4ndCByZWFsbHkgYmUgdGhl
IGNhc2UgDQpnb2luZyBmb3J3YXJkcy4gSSBoYXZlIG9ubHkgY29udmVydGVkIGl0IGZyb20gdHh0
IHRvIHlhbWwuIFdobyBzaG91bGQgYmUgDQp0aGUgbWFpbnRhaW5lciA/IFRoZXJlIHdhcyBuby1v
bmUgbGlzdGVkIGFzIG1haW50YWluZXIgcHJldmlvdXNseSA/DQoNClJlZ2FyZHMsDQpOaWFsbC4N
Cg==
