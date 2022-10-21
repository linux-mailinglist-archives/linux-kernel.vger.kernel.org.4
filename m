Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3260778E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJUNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJUNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:06:11 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D770126B4AD;
        Fri, 21 Oct 2022 06:06:10 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LC7kTk002899;
        Fri, 21 Oct 2022 09:05:47 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kb2161yv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 09:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGeQfJyQlIrCRBNpcwFmlcrWi6K0bCNDfRgQfs2moOdvwW+GcV8Z+x4Gys4WHoWY/VOW8bDkfG6fkPy+Zs4m9JlMnMmXze/mOTFI6dNWgirSpgTKPTtyqGMp+iG+xaQXg9PoLLYlyZ0WVQcVg6irWufTLY6YUfLuFLugTZZr2IYqr6742iY9r2wimGSp/wJSpjqc2uS/xGxMOd4k+L6TU2fg3DCEcz/jSem6O17q7wqxgoJGCSCCvyVp0vazcRCpVxTAH/5bjlxNyCufM3JnihjYNTBMvo+bOkYLtTLMLgKMv12DNULl1F4oT1u5BAQ9mqCA54pUtE9rpQdsraBYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re3DlnTifZKk9bm2O74Xja5dsqGx8vRbP6raG1K9KfE=;
 b=css68LH6yS1d/+9LYzlKtPxm0DYanERNJoEI5lVRdI5f0e+4NJgc38GJ2fH9Gs9QVS7moGMzGGG2kaTB9X8wJjOeZ8rov8HtvzJK1BJnidVeHxIEeXpF4qoSUOEvBtzJTBLtRiRH5UBiX0JL/cPAxd6SFV1YZ5nDdEXn0g6bgY7/4mB0M5ENWdRex4hCLfV9J/4SOcoKMBAL7SxTQjMXxP8MphlpYCp9qOK1Sc3QozJ9kKdtRzdbosbSw3NebK/LrsddjgNMMEyAKCicG9BPx4jUk6V0V4uwmyAssfrYN4wiPWcQQFJyfg7qRkImRhDFGgCZWEHAZdIlPQSN8dZeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re3DlnTifZKk9bm2O74Xja5dsqGx8vRbP6raG1K9KfE=;
 b=oltg0VZzDsmDhXwGpqVsJbk+J964ay8r5qyC7//PJzsQooHC8yPPzmrpowwVacNVDZba45GlZgK8K4HiXOqp/UrXljWlqn8TCmPAQlCcH3UURFSoDUOI4XU71sxGyws8Yc1pxNk6BOlRW/X+/UbTZGZTL01BjZG228E14e/RZRQ=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 SJ0PR03MB5598.namprd03.prod.outlook.com (2603:10b6:a03:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 13:05:44 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 13:05:44 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Topic: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Index: AQHY48BZbMpT/SjNa0SzYqltq8qQ864XyjkAgADySLCAAA2cAIAACL6g
Date:   Fri, 21 Oct 2022 13:05:44 +0000
Message-ID: <DM8PR03MB6247691C7AD890FA486A5955962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com> <Y1G6FIvS6WD57GXW@mail.local>
 <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
 <Y1KQvPAwh7NC0wbA@mail.local>
In-Reply-To: <Y1KQvPAwh7NC0wbA@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTBmNDlmOTVkLTUxNDEtMTFlZC04ZTYz?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFwwZjQ5Zjk1ZS01MTQxLTExZWQtOGU2?=
 =?us-ascii?Q?My03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjIwMDQiIHQ9IjEzMzEwODMx?=
 =?us-ascii?Q?MTQwMjcyMzkxOSIgaD0iZjcyRlpnOTQwdXd3OFhITklNam1mNGZVTVZjPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFCUHVzL1JUZVhZQWVZdWJpTGlEdGNZNWk1dUl1SU8xeGdEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFYNWwyS3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|SJ0PR03MB5598:EE_
x-ms-office365-filtering-correlation-id: 2fb04e91-5376-4b8a-fc3b-08dab364f6aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWt0irWnxtllk6rZ8VVwaZhGLjZPPMd8+N4XnChp7p3wkFqMv9RO6yWZYu/LoOqD3C5Mu8xinGlnJknXoxte8cb6JwTUGfbyQhjw1mcFNFZ4q84IAxeofG5yza2mLS4N9Va4klPoK+x9i+LgHLpSWyVh1EI8N+0CbMqtzvdZ9+4qVTF//ztjhozp+6Xloy4R/jQWQonUdx7lWkcIiS7xs+3zcRO2MFvTTrOOEsiT46+eRYedG/QTVWT9JnoE+iVONPqxh6gnFfT26Mqa93LXpXymmAel7mF9CgBJ9QeK4cPjwhUpUdQLD81aZjOKeyi6ZAFhZ7761Ne7pKiGGM/Hn2nMIFa2fM3rt1joSrEDqwdZre8THXmUS+L/XR5+xZpnZCoYKYW99Gn6g0jOlyKzROKnsJi9n8onCxsHJLfoX9lGxnLufW3F1VCmEtnLJU1E5wL9cVss1xcZvV6KwkAi04Yyf+NITzAMjpTM1Co5casStuaD5WTzbvCd/+NZ92H0kdE2yKvRBV/TgNqvqhxB6FHbmTel6ywcE0HsDSm494KKjBo7w74g68gPd4GUArKX1OiC1sgPxBgdRG9EZHqGY5W/mnGpJOEaJACgg1dOBEpskq95/vKjPdpdOcIPWo9sZZ5nI3blMEbG4Naq6GWflslUeQ7lvhSF+2LUiNIkxFZHP+1su6dI+SYve2s8WLoN8U6EbRwphtR1jU/kCc0hkI/RmeVrUFkVR5WYLoS4FtVBr0kOp9shZtzKfmMToJYiSNMX7zN/ylYcuj/nkuiX/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(5660300002)(66946007)(64756008)(38070700005)(83380400001)(52536014)(122000001)(86362001)(33656002)(38100700002)(41300700001)(66446008)(66476007)(66556008)(6916009)(4326008)(8676002)(7416002)(316002)(55016003)(71200400001)(54906003)(9686003)(8936002)(26005)(76116006)(186003)(6506007)(2906002)(107886003)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rY30AfFhThKZSj7Xr4iHFZOVRXBlv22S8VwO86mCbT6x9CA7zBEOVGbRCf23?=
 =?us-ascii?Q?W1T2+mUMiwUY3O1dFa7uACslkjtmuUhJENMahk8NeqtUkaF8jnoz9Nu9TIjo?=
 =?us-ascii?Q?bDGl9rducFt8gzJoPLxjnY4T2biqQ9HvGmsOUxRSuC9X0+LVlffeNXpwTLEi?=
 =?us-ascii?Q?r92Jw9djspx8URBgCFWWqS34DCL/pZb3RmAacXkn5zDo96Jk49HU5SvrEuc9?=
 =?us-ascii?Q?/BqzKrB3AKveJiaPuQq7QltHdbMfjlDGUb1MH2YabZb+ZNj8KfkT5auZRklG?=
 =?us-ascii?Q?dYbSIxXKp0uV506BXjlRUXhPW32in71RxrXfFXcUYrDD2j0eLCpzubyVti4V?=
 =?us-ascii?Q?Woot4PtOUFukjxBoDLYgK6pyrZ3T62DNDnk0amCyBc9/UxdbwSMdTO4cmafn?=
 =?us-ascii?Q?jnayt5IG1KrfIupmBCkHhOtk3VRVLxTag7JVB8VCwvK0Hn+6lKJaSJcdnBzX?=
 =?us-ascii?Q?wcmDrN6AVj1bTe8YIucSwJMWcXZeadC2L87VRYgTxCdEoGy2EiebBI3XhmKV?=
 =?us-ascii?Q?8SGRYOPZWKnWH1eIHyI6VAYX/tBEVtHIIRMrmMgSgEwRO50AxJfjeNeestIo?=
 =?us-ascii?Q?2oa56tFJZTdIU4c/EwHV+rBlvPQTNCStktUV+IXZ7YUUwHFqhiddQWg23OHt?=
 =?us-ascii?Q?fOHsbWAPSL9Q9ZbLmVgH7GpUjEdL5OlxtKhEwrpZpWojz735HMvjmDdImrnE?=
 =?us-ascii?Q?VNQLhw/sTB6pPyx5q/hnkbrMlbBoFDtzkqMtTOOZifXCmLN9sql1YH0GdBhA?=
 =?us-ascii?Q?UmEcGNO3KxC/4t7Ncbihr8aABdyJdROl9yK9FnJoonJ3h5MJu4jXtNu6BAUD?=
 =?us-ascii?Q?LgWFB3StcJvaPMueDTPmQ2BdX87+Sujbku9/NU95YFqJuoKa7xzTQEojgCxJ?=
 =?us-ascii?Q?xaT/XxdhvjoSDD3zUsTIQuCHgO2RtEulsGmbt2A2NKXRKRBU+8F6Ko03OaPI?=
 =?us-ascii?Q?obeVjnaL6NqfaJ2jOcTRIc59NyZosvtlTuN3JP9mbse/q6gRhAYLJjV0GdzY?=
 =?us-ascii?Q?aGi4/t2Xvnz2sDhwnAtzM+q88p57K3lVAij76+DaexjaF/pD6R4DOGI8k39z?=
 =?us-ascii?Q?d9ya2/6UbAMLFxgsnuX9qIzDAlSRFOcSPCQqMNMFKKTQwQlJ40pEJ2xj+IIB?=
 =?us-ascii?Q?v3OPjPdOZBEOmYZqnan6gLOlLacBnZDAqinXZkWZSL+mdHbuC9RPDIsHyy+b?=
 =?us-ascii?Q?ExwuSqWL+TYE37ezFsSSzcMFKANMpWpFundR9DKZIAjgGuP+McbjZlNnd1GI?=
 =?us-ascii?Q?d5t0RU+ruq6nq3q1HEAIeTm6Zjqw9iRnPd57KEpbbfN64kU5cnk4dAIpatXl?=
 =?us-ascii?Q?N67KARHyL58L4uYZigJu7s7cJc7WKWdVY0BAQgQMOwZsTB2iIMMakDxuhK9s?=
 =?us-ascii?Q?6mFw1Bx21ltVPR74kuHyDeVLYNcDDTubMy0yrPQ6FRQ50IR/mBJTsy4uv8vI?=
 =?us-ascii?Q?isVJmZlcYRqc6rR3m3+B2pEmXRTTFbf/TWgt6t3rz95VI7VHy85XpWTiCd1g?=
 =?us-ascii?Q?2ru2MCwRMb9lFfsluKTHo3RDHhxS7wPiI5gN4ocJ9OQFkp4D9UrNiEfkuwIR?=
 =?us-ascii?Q?lniSlIzH9hNCz4MAturqjBJvlPJZKuCVT5IRPLRh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb04e91-5376-4b8a-fc3b-08dab364f6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 13:05:44.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwbDKiYjrKGDENRmiav/q7WTLtcMc8J2ZOKSxEh9h++NuNIMITKCO3VNvVEBK+i91RKbYwGjrlm9Ra5Cm0zBlAm+8yYL849hr7Qgd3ST0PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5598
X-Proofpoint-GUID: -rnlGM5ZSuD7N9AjFPZamTG0_984jlCd
X-Proofpoint-ORIG-GUID: -rnlGM5ZSuD7N9AjFPZamTG0_984jlCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=892 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210078
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 21/10/2022 11:44:12+0000, Tilki, Ibrahim wrote:
> > > > +  interrupt-names:
> > > > +    description: |
> > > > +      Name of the interrupt pin of the RTC used for IRQ. Not requi=
red for
> > > > +      RTCs that only have single interrupt pin available. Some of =
the RTCs
> > > > +      share interrupt pins with clock input/output pins.
> > > > +    minItems: 1
> > > > +    items:
> > > > +      - enum: [INTA, INTB]
> > > > +      - enum: [INTA, INTB]
> > > > +
> > >=20
> > > I don't think this is right, what this is doing is essentially pinmux=
ing
> > > interrupts versus clocks. What happens if you want INTB but this goes
> > > directly to a PMIC instead of the SoC?
> > > It is not something you can express with your current bindings.
> > >=20
> >=20
> > Why would a user want INTB when it is not connected to SoC?
> > User can specify none, either one or both of the interrupt pins.
> > I don't see what the problem here is.
> >=20
>=20
> the interrupt pin may be connected to a PMIC that is able to start or
> wake up the platform. In that case, the user would not have any
> interrupt-names and your driver will fail to mux the interrupt on INTB.
> Please fix.

Interrupt muxing depends on the clock configuration, not the interrupt-name=
s property.
Devices don't support muxing the alarm interrupt independently.

For example in the case of max31329, alarm interrupt is muxed into INTA by =
default.
Alarm interrupt is muxed into INTB pin if and only if clkin is enabled.

This means that if a user wants the alarm interrupt on INTB pin, they have =
to
provide a clock input through "clocks" property. If that is the case, they =
can provide
an interrupt for INTB pin, otherwise the alarm feature of the rtc gets disa=
bled.

Side note: Some devices have 2 Alarms but Alarm2 does not have a register f=
or
matching "seconds" so only Alarm1 is used by the driver.

Ibrahim
