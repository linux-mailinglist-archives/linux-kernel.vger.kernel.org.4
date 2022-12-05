Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63164225F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLEEtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiLEEtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:49:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30678BE15;
        Sun,  4 Dec 2022 20:48:54 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B54mmVV014237;
        Mon, 5 Dec 2022 04:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=ut1khAtyohkM0M/Iv/6XDmL6Ac7zavjkIRra9LUxGoE=;
 b=p1dYu//E5NEESmBTF/SI+PPaMGrztUVHk4yAFrB04GucurF4LHiJ/ggHeF3DjzBuMxiB
 E2tfdiheYR7lewXaVeodZ4nDrNYF4+cpt3whskVwoIy9O9949Q8Mg/UYM8hSo6OJIVvT
 zq+8qJEIZMMHAqUDK16UGOtzop8QQU3xfeFsGV5EEi3MrgzFPnMM1fj1HcOTi7od4AcS
 A0R9qqkVmPDCvOVnUqr/B1cW+ZuODkHVVD5G9tGE4/Am3FdwFeyBBlWeMjB8UpzbtvRf
 hNtfXe9NY/GkccSWkO09EQz2vzXmMBS8vS1HDADMCVim/e33mPrO/t2Q2Tgj6tb3XaVt 9g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7wdxu844-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 04:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv3OfSmVPIiHzOpxImghnVcqNb74Q9CfWA9aHh6gzv1ge2vBeUowqTgUe+URA61zQ1Xn/pYznccuYAFJQdPm3K0sqsda5Dn60qvc8aBbD0L+qSXGXBI0fQtJ2sDy6C9guPlyDdVJSfS1Tulc3/uerVtflu1qQ8I86xEV3Sm6VLNX4yT3dk1i8xXuwubU545gu1wEfsmyFiiNffumBOc+41MYSr52Datp4BoOmbNLNv6Fx+jwTmeD+mt7ROASjSLqfjh3dXlkNjzF39DTkpyH+Kq/gDvVG+WYONWYE62qTtNtYS0uk0rDtLnxcun+kuYKYHuoBlMIOQMXPZQsgLIANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut1khAtyohkM0M/Iv/6XDmL6Ac7zavjkIRra9LUxGoE=;
 b=YTmCmqMQOFqOCAeg5C7l1k3MnPEuA0RH0KTymjq93JugwzpFrADXCOpBseVaEne36QBQyqreF/Hkc0DCn+NotPw/WxF521WlsIcrSQb7TowqQZEdl/auE/FDjC0fCcDmJMUyfte4YWu0i7TAqccrbfFRinO8a8eBHUqP6NpURgdMaNBbquePpRyOKAfvB6GsJ1+WNcdbMLhhcr7YRRzWNaHNoMojtMgRsN5v9SlMZgPvasZn84Z5JgsRqybkJYUbRzymbFCHaO0WP8TwXbRzVAB5ruI3atWffHMDh1Z75mdcuNPEpDvvPw+zpnx7XTZXfr3I7giBf/weqyOR29q2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com (2603:10b6:a03:3dc::5)
 by PH0PR02MB7622.namprd02.prod.outlook.com (2603:10b6:510:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 04:48:44 +0000
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::5ec8:dcaf:77e5:efcf]) by SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::5ec8:dcaf:77e5:efcf%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 04:48:44 +0000
From:   "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>
To:     Nathan Hebert <nhebert@chromium.org>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>
CC:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: RE: [PATCH 1/1] venus : Fix for H265 decoding failure.
Thread-Topic: [PATCH 1/1] venus : Fix for H265 decoding failure.
Thread-Index: AQHY+OtBYQsDqxSGHkG+vgRZethujq5Z06EAgAFIq4CAA7tJkA==
Date:   Mon, 5 Dec 2022 04:48:44 +0000
Message-ID: <SJ0PR02MB8848C9CC1ED0DBA89D56CF7D85189@SJ0PR02MB8848.namprd02.prod.outlook.com>
References: <20221115121004.28197-1-quic_vboma@quicinc.com>
 <20221115121004.28197-2-quic_vboma@quicinc.com>
 <CANHAJhEH7qTjaVaMWk3MeuhYMnwt1qTUSKxAZ_XTfxPJObC=nQ@mail.gmail.com>
 <CANHAJhENA5ssFBBDeqfDyC8v_CwZhpiJC93B1HZnL4K+N3N35A@mail.gmail.com>
In-Reply-To: <CANHAJhENA5ssFBBDeqfDyC8v_CwZhpiJC93B1HZnL4K+N3N35A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8848:EE_|PH0PR02MB7622:EE_
x-ms-office365-filtering-correlation-id: c7f4d262-b54c-4d03-d082-08dad67bfd5f
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyk26F8Laes7zwvqnU3fzWkSv9PXAOvYDDkcbyP0xKpEE8Zh2pXI+gRm8KAKlUhDwaEIBmrF+PaXxGb58dsS76jg/ml8ers4C6x86O3SdBRWjplucLugyDHpqWD7+jnOJJm6nFsusg48fvofn46dOeSE4az2TSK8qDREthVEQv0g0nqPcxOEDcjtVPwaw7M9UMr/+keqo8lJaMmm8zrtM6rotmcUnNGG1cGsVkdki8TuqbwIckPYzaehQJpXp+0L5R4O+sLLiaB4Y68FDTdGSHjtVEilBV2cCsLeZUuaIn02qWFQxxjP+8J3yPsyeaYeRdMdhVJYqSirzr2Jebzjwyf0LC2LeBuXAAaNzBijEwdz1w8JdUy+XuqqSFCBu+kWHwy93sMxaxevMQId8cIPgiHgcGdhRwy0VKuc5FLUKWp8+X5eh/l5wl+zraiN3ZAFmRx+V04pyI78/FhtQO/ZMXg+JufP3Xh9pThVj99/JsVNKERtyf71zGqHkKd4tsm7kLwXXzLQQqpz7skT79vVUJmt6iFXZyep40PYqSYfwOzjbSnUZenkooV4FeHfFepwSCBt/5S8ZF/A3BVZBKWayL9EsvExQ0cdfwgCTcNh/BpfAq5i6/o2PFRKwWhaq2J/dHQxbLyqRrEp3y47FgMdJ0SaFlYlDU4/BwqCtPniWtr8K2978t+lj8C0KP15sCnmz6B0R6Mdn6rvB1fF27F0l5QKrjlOzyE9aV5wijxSApQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8848.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(2906002)(83380400001)(186003)(41300700001)(66946007)(76116006)(55016003)(33656002)(86362001)(38100700002)(122000001)(26005)(110136005)(9686003)(38070700005)(52536014)(5660300002)(4326008)(66556008)(66476007)(64756008)(8676002)(66446008)(8936002)(316002)(107886003)(478600001)(53546011)(966005)(71200400001)(54906003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2srMmw4L3hxZTMwNDdIQ1hZYUJSdVhySnhtbFRGYmxFQUJGalFjVFZkcHps?=
 =?utf-8?B?SDgwZ2gvTkRjR2tzRys4YU14N0pOSXVKOExKQUEzUVRkU2RBaVNsQjR6L3Vn?=
 =?utf-8?B?OUludU1kaDZSUloxSUwxcm5iWm8ydkdjcDJmekEwZlR6OVhsZHpoV0RDck9k?=
 =?utf-8?B?YUNSZDhiRmpoNk1GQWl1N2VIY2p2VS90MnJxK094QmFCSG5RYjR4K25HcStl?=
 =?utf-8?B?RWZySXc1UENNMkZMM1Eyd3lITTFLaE1CbE10K0d2MDB4ek1tMGNhUHFUaGt0?=
 =?utf-8?B?T3dzN3dZOGFNVHdMSW5pbFE1aG1Tc1huZnZsWW5BV0tHMmFLcjh6RkRmeHlz?=
 =?utf-8?B?Um16alNOZlpEZGZWS3JIby9zV1dmSlBoeTRmN2VEemkyNi8xZ1U4b05tQ05u?=
 =?utf-8?B?bXR6eU5NSWVtZTZkMFdwT1JYN3l2WSt1UXpMSzNoTGYwck5wUXNvbGY5SWt3?=
 =?utf-8?B?QXh6dVgxQmRHMy9mUUxpMnlKTXBDdkFJYnhiQmJlanY4dXJiY2V6VDlmK29L?=
 =?utf-8?B?dTlWUy9Pb0kyVVBQa29KQ1pnb2JlWnVRZEZ5RkhxS1RMeVhJMSs1ODgzcXV6?=
 =?utf-8?B?R3B2SllPMHJhZ2RIMURxWkJBb0kyWUFtSi9ua3RWU0ZNMFFaK0pPM2N6V0h0?=
 =?utf-8?B?KytYRWV4TFNDZFYxVWRMSXY5cFl2TnN6VHdHalp3c3hHV3U2OVdqaDMyTkFW?=
 =?utf-8?B?SmlsdVE0Sml5SHcydkV4bW5mYWQ2QWo1TkdGUTlsSUJHai9NZzdzdkJpaGVI?=
 =?utf-8?B?UmJ3VDhpaXhwWTZDZG4wQStjQ0ZSVFJNOVZaMjBTWE04aTBkWmVwMG5xdzlC?=
 =?utf-8?B?NFdTVmVYRHRrTTZPYTI0RFpKaUF3aWNFTGhsRnZUOEpDeGREQkgxcitmMWJs?=
 =?utf-8?B?T0V3WmRiVVVMb0JWM083MkhBWTBIL3Btc2lNdHIzb0RMKzBvZ09wSjZnMk1W?=
 =?utf-8?B?M3BkS3kxOGFDSklyZWk5NlNQTEJiNU13dStlUDBLcXlYRE12djBaTzNKVUVh?=
 =?utf-8?B?S2hNZGNJTVhTUDcvOWl6dUlPMHdPdEFiUVo1NlNtYnpYRUFnN1lvSTd5RFNJ?=
 =?utf-8?B?aXllQlh4akltdUpYVk5JMnc5WHg0b3RFa0VaNk5XeTVPRnVkR01rQWlyT0l5?=
 =?utf-8?B?Ky9BN3pLUzNvRTNWUFI0bEdvU1lob3FEQUYzUU5EMmNmcllWc1RheGZyL2Ni?=
 =?utf-8?B?WDFMK3RGcGlkL08zR0NvWEFyZ0FjL0ljam4xcGFiR0V5ZzNKL0dCYlJGbk9a?=
 =?utf-8?B?OUJPMEdseWI3V2RDcDl6VkJZcjBTMHZzZXR4aFMrYURrY0wxVldSNXM5YmxG?=
 =?utf-8?B?cWJLSDFsbVZkVzRvdEh5THIzZEZRWXlkVU1wQmhTSlV3TFJ3bE5XREFjZlE1?=
 =?utf-8?B?ZjBYV0I1czh2SUFpNXZyd2Fac2w2RUdIQnE5eG1ITlgvTG5aMi9INnhRQzVu?=
 =?utf-8?B?S2MwaUhyR2pkcjRvRmM1TDQ3aTBuNU05bkZjWDZqeUo1eE5YRU02QWtQQ25M?=
 =?utf-8?B?cWJsR3RoSDhBR2RTU0VvTDh2UUFNc0pnUzZPbmdmQUVzZU5pMU1sMkxUa2Zm?=
 =?utf-8?B?Ym1QTXErU1Q3bEkvRjNSQklzaUx5K1NNZ0xFZTYrdlNaeUdZV0FlSERXc3dE?=
 =?utf-8?B?Z0hmTkt6Sld0TzhhVllrb3d2M0tJNzNZYm9vQzYzc01tNExLaDdMYVRZaGp6?=
 =?utf-8?B?SXZyWVZQZHJ3aTYzSUlKdmQxWVBBcFRvVGtscTl1ZFIzeGtDK01XOUxFRFV6?=
 =?utf-8?B?SzJsSkZJUWhZSjRKbHZvVndxdGlFWEdmeEN5UUpZY2xsWkgwQWhKcEJ3ZXNG?=
 =?utf-8?B?TGRERUNEUEpvY2RublZxU0I3UzB3enN4TldnbUE0OWE1R0tjOVJQbzN4OWI4?=
 =?utf-8?B?SzVPQUM4UEJvdVN1a1RxeHZ5dmdaMWhaQ2VHdTc5VEsvUjVKYUNLMkpJWG1G?=
 =?utf-8?B?SGFwNEhWUFRPM1FPZ1ZLeFJINzhtUGxEUDV6aGFmNi9HYXhrdm5YcXc4bUN0?=
 =?utf-8?B?TWNGSzZ5T252MURWQVhXNXJ0cGFkMGtJeTZxMHFtV29zbkRMNUNZK2wrMFVq?=
 =?utf-8?B?MFFVdVAzc203KzdORnN4TGJ3dHpxbTkzcDhMZ1ZjbjZPNzhDRkkrdGdmZzdw?=
 =?utf-8?Q?ySDQfPLRdYRl42CZFh9uRDGhN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RW5ZWlZkb2VaZVZhTXoyeUMzY1FJeVpKbnJidXVXamNyczVOMUhFZUZERU9U?=
 =?utf-8?B?N21VR3J0UUQ5WHJHcWdMd0VCd1RDZ1B2dEtTcjlUWDJSR210aVJhYit6OFIx?=
 =?utf-8?B?R0xWUHAwNVY3bXZrRXB3ekgra3FVWE43aUhWSzJpbFp2N0hQZ0NSbjNqRVg5?=
 =?utf-8?B?aGs4LzRYZ0w1d3dWWDFpeGxwcEVTUlgvTzlEczArT0NQWThzRkdwcUVtb2Jl?=
 =?utf-8?B?WUp3THdRcy9NVjBqUXRiR1JGeGZDSW0rL1BQQmtodFZlQnNUNUpWa3NkdzNi?=
 =?utf-8?B?ZWpVaGZBaHFFNTJ5emlmS1RkcE4vdUE3bWF4bzR0bE5tS3dtb0pRaHVHMjlK?=
 =?utf-8?B?R1NjOFU4YnczMVFSektNeWFGVVJ4aE01Qlo1MjZKVy83elROTDNOOEpYV25y?=
 =?utf-8?B?RVB3dnY0YUpaZVZIcFprdGJiOWJaUlBtRS9FOHF1aENWdlQ2QjlPZWd6US9h?=
 =?utf-8?B?b2ZYQ09sdzVtNXl4Zld1eDR4akJFQ05VQmFBSWpDRTU5R2VQZFFWUCtIaUZp?=
 =?utf-8?B?MTdIMUlndmhnaENKbURNUEN4YSsxdDkwZVNJV1Rhd3VDVFJRSmJoNnRQR0dk?=
 =?utf-8?B?OHJ5TXVVd0hDUkVZWHNvRUpmRGhObStMYkRZaCsyKzVHWFBFT2l3TjQ4U1Jq?=
 =?utf-8?B?SWZ0akxaVmsyU0ZFWlBab2llbHRhdXB0M2o0M2FmWmx2allQQm9VcnRvaVUz?=
 =?utf-8?B?OVpmVVRwMlpEdjZDTkJUUklsdkhseUZYbVhhU1Z2RjhUUXBSdGZSZk9tcGsv?=
 =?utf-8?B?bXZnbUZ4U3hncmlRSElCdDlRczNqWFFrdFJ2cTRGZ0FPdVNYVkppcWdKQXlu?=
 =?utf-8?B?clpzM21xenhKYnMrcko1SUpuTjlTelB1QjYrWEc0Sit6ZEVmdXBjOXRMOTZU?=
 =?utf-8?B?WmRvcWFqaVBBeEY0emdHT3psQTdxMXlrSEptMndlbEE2V3BiQ3c3eW5iSHcz?=
 =?utf-8?B?ZSs0UElKT0pNOU1SdmJtNHgzQ2JNV3FJR01TSXRUNkJtcjhmd1lGUjZSSThV?=
 =?utf-8?B?OFRYeU5qU25vbmwzVTYxQ1BjQ3FybjIrVjRrOGRPNlRZRURQUUtsMGRnSW9C?=
 =?utf-8?B?UmdkYmtjaTFBeUFwcW9pODZjdHVacTJrUUhFNnAxZWYvMEI5L1AydHplcGl4?=
 =?utf-8?B?TVE4bk5JY1BtNTBQNDFLd2NLZ1ZDRml4ZmpjWFBNMHVDamxZTFY0NG1oQUd3?=
 =?utf-8?B?U0VSa2gxNWhHbjliMFJRczRpQ0ZudG9WYWhZcWJaMEVoTklxSElmK25MenFq?=
 =?utf-8?B?cERYQi9vWVBqMlJneDhncFNiS0V2UEs1eWNRVnExMlU2ZC9WcTZ6S2N4Wkt3?=
 =?utf-8?B?UUIzOUhjOEYyV3FNZEhQYWhRbWoyTXRVeWFJQVJFT1JTVDRubE5uZUd2TVNi?=
 =?utf-8?B?cEkzZ3o0WGc3NXc9PQ==?=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8848.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4d262-b54c-4d03-d082-08dad67bfd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 04:48:44.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYQiGTWJKjUqSOUCeOrcLMO0wzzOHv8MW8J+CfNt2Yd5ebW19Q1Nu7C2AbehqZnO+VBiFDCLLwrgBDI/FLHDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7622
X-Proofpoint-GUID: H2BQ1A089BPH0oTYRD79IAigUvJHgf-C
X-Proofpoint-ORIG-GUID: H2BQ1A089BPH0oTYRD79IAigUvJHgf-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBOYXRoYW4gSGViZXJ0IDxuaGVi
ZXJ0QGNocm9taXVtLm9yZz4gDQpTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMywgMjAyMiAxOjE5
IEFNDQpUbzogVmlzd2FuYXRoIEJvbWEgKFRlbXApIChRVUlDKSA8cXVpY192Ym9tYUBxdWljaW5j
LmNvbT4NCkNjOiBzdGFuaW1pci52YXJiYW5vdkBsaW5hcm8ub3JnOyBBbmR5IEdyb3NzIDxhZ3Jv
c3NAa2VybmVsLm9yZz47IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBNYXVybyBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFZpa2FzaCBHYXJvZGlhIDx2Z2Fyb2RpYUBxdGkucXVhbGNvbW0uY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCAxLzFdIHZlbnVzIDogRml4IGZvciBIMjY1IGRlY29kaW5nIGZhaWx1cmUu
DQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNv
bW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5v
dCBlbmFibGUgbWFjcm9zLg0KDQpPbiBUaHUsIERlYyAxLCAyMDIyIGF0IDQ6MTIgUE0gTmF0aGFu
IEhlYmVydCA8bmhlYmVydEBjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPg0KPiBPbiBUdWUsIE5vdiAx
NSwgMjAyMiBhdCA0OjEwIEFNIDxxdWljX3Zib21hQHF1aWNpbmMuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IFZpc3dhbmF0aCBCb21hIDxxdWljX3Zib21hQHF1aWNpbmMuY29tPg0KPiA+DQo+
ID4gQWxpZ25lZCB0aGUgbWlzbWF0Y2ggb2YgcGVyc2lzdDEgYW5kIHNjcmF0Y2gxIGJ1ZmZlciBj
YWxjdWxhdGlvbiwgYXMgDQo+ID4gcGVyIHRoZSBmaXJtd2FyZSByZXF1aXJlbWVudHMgLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlrYXNoIEdhcm9kaWEgPHZnYXJvZGlhQHF0aS5xdWFsY29t
bS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlzd2FuYXRoIEJvbWEgPHF1aWNfdmJvbWFAcXVp
Y2luYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51
cy9oZmlfcGxhdF9idWZzX3Y2LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvaGZpX3BsYXRfYnVmc192Ni5jIA0KPiA+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9xY29tL3ZlbnVzL2hmaV9wbGF0X2J1ZnNfdjYuYw0KPiA+IGlu
ZGV4IGVhMjVjNDUxMjIyYi4uYTliZTMxZWM2OTI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy9oZmlfcGxhdF9idWZzX3Y2LmMNCj4gPiArKysgYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvaGZpX3BsYXRfYnVmc192Ni5jDQo+ID4g
QEAgLTkzLDcgKzkzLDcgQEANCj4gPiAgI2RlZmluZSBMQ1VfTUlOX1NJWkVfUEVMUyAgICAgICAg
ICAgICAgMTYNCj4gPiAgI2RlZmluZSBTSVpFX1NFSV9VU0VSREFUQSAgICAgICAgICAgICAgNDA5
Ng0KPiA+DQo+ID4gLSNkZWZpbmUgSDI2NURfTUFYX1NMSUNFICAgICAgICAgICAgICAgICAgICAg
ICAgNjAwDQo+ID4gKyNkZWZpbmUgSDI2NURfTUFYX1NMSUNFICAgICAgICAgICAgICAgICAgICAg
ICAgMzYwMA0KPiA+ICAjZGVmaW5lIFNJWkVfSDI2NURfSFdfUElDX1QgICAgICAgICAgICBTSVpF
X0gyNjREX0hXX1BJQ19UDQo+ID4gICNkZWZpbmUgU0laRV9IMjY1RF9CU0VfQ01EX1BFUl9CVUYg
ICAgICgxNiAqIHNpemVvZih1MzIpKQ0KPiA+ICAjZGVmaW5lIFNJWkVfSDI2NURfVlBQX0NNRF9Q
RVJfQlVGICAgICAyNTYNCj4gPiBAQCAtMTAyMSw3ICsxMDIxLDcgQEAgc3RhdGljIHUzMiBoMjY0
ZF9wZXJzaXN0MV9zaXplKHZvaWQpICBzdGF0aWMgDQo+ID4gdTMyIGgyNjVkX3BlcnNpc3QxX3Np
emUodm9pZCkgIHsNCj4gPiAgICAgICAgIHJldHVybiBBTElHTigoU0laRV9TTElTVF9CVUZfSDI2
NSAqIE5VTV9TTElTVF9CVUZfSDI2NSArIEgyNjVfTlVNX1RJTEUNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAqIHNpemVvZih1MzIpKSwgSEZJX0RNQV9BTElHTk1FTlQpOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICogc2l6ZW9mKHUzMikgKyBOVU1fSFdfUElDX0JVRiAqIA0KPiA+
ICsgU0laRV9TRUlfVVNFUkRBVEEpLCBIRklfRE1BX0FMSUdOTUVOVCk7DQo+ID4gIH0NCj4gPg0K
PiA+ICBzdGF0aWMgdTMyIHZwOGRfcGVyc2lzdDFfc2l6ZSh2b2lkKQ0KPiA+IC0tDQo+ID4gMi4x
Ny4xDQo+ID4NCj4gSGkgVmlzd2FuYXRoLiBJIHRlc3RlZCB0aGlzIHBhdGNoIG9uIENocm9taXVt
T1MncyBkb3duc3RyZWFtIA0KPiA1LjE1LWJhc2VkIGZvcmsuIFVzaW5nIElUVS1UIEhFVkMgdGVz
dCB2ZWN0b3JzIFswXSBJIGFtIHNlZWluZyANCj4gZmlybXdhcmUgZXJyb3JzICJxY29tLXZlbnVz
LWRlY29kZXIgYWEwMDAwMC52aWRlby1jb2RlYzp2aWRlby1kZWNvZGVyOg0KPiBWZW51c01lZCA6
IGV2ZW50IG5vdCBzdWZmaWNpZW50IHJlc291cmNlcyIuIERvZXMgdGhpcyBjaGFuZ2UgZml4IEhF
VkMgDQo+IGRlY29kaW5nIGZvciB5b3U/DQo+DQoNCkhpIFZpc3dhbmF0aC4gVGhhbmtzIGZvciBs
b29raW5nIGF0IHRoZSBsb2dzIG9mZmxpbmUuIEkgcmUtdGVzdGVkIGFmdGVyIGFkZGluZyBRMDhD
IChVQldDKSBzdXBwb3J0IHRvIG15IGRlY29kZXIgY2xpZW50LCBhbmQgaXQgZml4ZWQgdGhlIGVy
cm9yIHRoYXQgSSB3YXMgc2VlaW5nLiBNeSBtaXN0YWtlLiBFYWNoIG9mIHRoZSBtYWluIHByb2Zp
bGUgdGVzdCB2ZWN0b3JzIG5vdyBkZWNvZGVzIGNvcnJlY3RseSBhZnRlciBhcHBseWluZyB5b3Vy
IHBhdGNoIQ0KW3Zib21hXSBUaGFuayB5b3UgTmF0aGFuIGZvciB0aGUgdXBkYXRlIC4NCg0KVGVz
dGVkLWJ5OiBOYXRoYW4gSGViZXJ0IDxuaGViZXJ0QGNocm9taXVtLm9yZz4NCg0KPiBbMF06IA0K
PiBodHRwczovL3d3dy5pdHUuaW50L3dmdHAzL2F2LWFyY2gvamN0dmMtc2l0ZS9iaXRzdHJlYW1f
ZXhjaGFuZ2UvZHJhZnRfDQo+IGNvbmZvcm1hbmNlL0hFVkNfdjEvDQo+DQo+IEJlc3QgcmVnYXJk
cywNCj4gTmF0aGFuIEhlYmVydA0K
