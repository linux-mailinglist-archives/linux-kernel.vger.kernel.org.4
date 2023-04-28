Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88846F111F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjD1EuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjD1EuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:50:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C722728;
        Thu, 27 Apr 2023 21:50:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33S4XRQg022029;
        Fri, 28 Apr 2023 04:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=psoiK0mrx+h7p0AnEBEfviAWnJY6l0syWClWYWimmr0=;
 b=XZSn6/NH+J/evxWZhwjPtLzSiOa5jyYwIOYF+pCeukvaThlkLXR5tzS/9V1mAfak/CTf
 5ttI8mgcnkbJ4XUOLjLcryoE4dgKq+hZbH4sPwbzybpJtQAKIPM1jskMMzDBdw+7mUyh
 F21CA8CcD2q84FETJwhO9GkO2XEj1yZsUIHE+uGzi7GYcAvPEDHwmOhl/nU/5lxlRXVJ
 gMjBTvIjQMVRwM/MN8QNx3jsScZa/vycY5eQOVj8ZIDUcu/egs8J3DqdDrOyRowMlImF
 v0yd11oXNBvvJjkoaJZVJDAaYQHjX69ZBmUDhfd3IgO0EkRwztAEqz/9ly2FuvvrpTvJ +Q== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7xdy8xpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 04:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiB3HI+jXOO1TgGvtAC7M7qb+jPQldJBzWBwdf0UDADMRo0n5UWrc4KhGDM0HjZZyes5C5nCb7BGJXiXy7xhk/ujHQhYQ1EIfrc7JkeESSLBzDo1VYav/V2fA8C5Tab+l6HscNvsNaOl+USOJBFLnrJvoldAtE78hNRdn/m9CWD5sda3Z7fjObMBvoCchEp00WocoMxGuZ0Ls2YJ2mUKr4m5J8MTd73WWGtGnBlX5sCivgfbrZdT/qPw7BLYbyYv3vXgnV4cKw88qsm2J91X5HqT0Rgb4mr2aqfbG7JT/KHbHrnm+CX59ZnzvAUw/itqvTb+4QCqa2lOnXCB6L5KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psoiK0mrx+h7p0AnEBEfviAWnJY6l0syWClWYWimmr0=;
 b=jqFfc/lpTfasEf8V0hD6mUF6gm/iCKUCv23+QUAvVlF5CpSGZkptfGCV4hjturQyxVaFxs7SXtTsiyyyICqi2UeOUKuLbqJnIkef4rTDGCoYLv+D6K8uFz8/jkRbDEqUCTPv+V5lAPO0tGJ8gO707IpdoDifZpnHToR8xJE8pt7i779DzWPhJx+M3ZxnwuCCrKWL6Q1DernFTNZnxrubgqUI52VoEtkvrmNO6NsN8jGL14pyPfcVmoU5WytKRkowMpaSTuZKt7dCnCEKVN4Lu2FD+ACHAwSL7bAZx3qEDTKhZAcDO5snCUWPIOvBqHcYi2/WLRsXxnnJ5cCS/knGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5)
 by SN4PR0201MB8821.namprd02.prod.outlook.com (2603:10b6:806:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 04:49:59 +0000
Received: from PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de]) by PH0PR02MB7542.namprd02.prod.outlook.com
 ([fe80::d3f2:f4c:2782:1de%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 04:49:58 +0000
From:   "Sampath Nimmala (Temp)" <sampnimm@qti.qualcomm.com>
To:     Josh Boyer <jwboyer@kernel.org>,
        "Sampath Nimmala (Temp) (QUIC)" <quic_sampnimm@quicinc.com>
CC:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-bluethooth@vger.kernel.org" <linux-bluethooth@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "Atul Dhudase (QUIC)" <quic_adhudase@quicinc.com>
Subject: RE: QCA: Update firmware files for BT chip WCN6750
Thread-Topic: QCA: Update firmware files for BT chip WCN6750
Thread-Index: AdlrhqwquThZG/j1RNyFxNupIEGPrQGZj9AAACb089AADjr8gAAfOOjAAXLJOAAAIMlxAA==
Date:   Fri, 28 Apr 2023 04:49:58 +0000
Message-ID: <PH0PR02MB7542E13B576B8E2EAA4B0CBDFA6B9@PH0PR02MB7542.namprd02.prod.outlook.com>
References: <PH0PR02MB75428BF5CB96C4533A0ECD79FA959@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA7mh3mFp28oxVxJa=DbKehhgX0Sxxtz8YBWSsU_7iWkiQ@mail.gmail.com>
 <PH0PR02MB75421FE9F55AAEC9C5D9AF3EFA629@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA6Z3mDq4wwWTsPVT0REV1M8LSa=WYV9Jm=MFpj1DdVmvg@mail.gmail.com>
 <PH0PR02MB7542B8433C51D3DD7941510FFA639@PH0PR02MB7542.namprd02.prod.outlook.com>
 <CA+5PVA6pj+40j=Sdd5Jn+yMymWZwtqWfNGeOKDBZhFKmckCwZA@mail.gmail.com>
In-Reply-To: <CA+5PVA6pj+40j=Sdd5Jn+yMymWZwtqWfNGeOKDBZhFKmckCwZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7542:EE_|SN4PR0201MB8821:EE_
x-ms-office365-filtering-correlation-id: fddd791b-dfd6-4d10-cc3e-08db47a404b1
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P83oB4QzTdArw0/cRdRa0VwC1XpmNwjfXkcqswMZApVZx98QZ5W3gyioYHAwPUPa00lzeb78tmmIYonhxQ3LuG6kWGi8oEg5J44SoN496oJEn4+gNJaz02CKIp63kW1Yp6A+pAeiPL/PxdcHseBZiyVV0g4FNhung37/9xBkNC+tAA1nycSrkFtlxRZPOcL2zf+C8Ls8Guhl97OKKNy8faErV/peLzn6DKXZ4PkJ/yDkALLCzDBZAjtzpnYwJpIvVrlz7M7cnSVY2FDKQWZr2sCrtALIv0SK2TfQ/qIOBRXDcf/JYekmHnSrgXd3zpwyztp5DrhQsL3sskNt0TkYDpGf6YSAnvo5vrUGQeOIdrQVc9DdYRXL9VG9BVjWYzlnNxBqMlFhXSkImZB0A5VAs7Xnh9Kv7al1ruskI8/AO0R06zS33u5bDMkBzj1V3Q6uZIGXE8athT45TPX6Wzxck0G8Uyfb9/TKrSSj6FM6Xo/Q9ODTY1JVW6RNhOe0g5v9lriXSO6mVSafJVqW0M4iECHlV+cExhJ1JeYWESlObX+dviAUlnzIgY0gP0z/GHKCiI1kk/WCRyyyepOmmpnhTbIL5GhouQH+KIkP19ehyfIk7qmegcp6afPfgD5+fiFitG8CwKjy6rYpiuA9BxzUww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7542.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(38070700005)(2906002)(107886003)(6506007)(53546011)(7696005)(83380400001)(86362001)(15650500001)(966005)(66574015)(38100700002)(122000001)(9686003)(186003)(26005)(55016003)(76116006)(4326008)(66946007)(66446008)(54906003)(66476007)(66556008)(64756008)(71200400001)(110136005)(8936002)(52536014)(478600001)(5660300002)(8676002)(33656002)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFTZVcyVTZUWWxHcW9OQzZyekVuei9zV2NuSzJGMXlaMHlyNVZsYTlXQ3Fk?=
 =?utf-8?B?VnhNaURxZ1F0Q0xaZHJMK2VmbFFDQTV5REJFcEFzQTEyMjVWaDJhamxpTk52?=
 =?utf-8?B?TE9JcUNpVWhSUEhjTzROMGJaTlh1eUdmNnltR040blBvVWJVcnVIakNROHJo?=
 =?utf-8?B?NnQwSzU1M0JjYWF1MktncU9rRVRZbStIYXdtOTdyb0c1RnFUNmtvTXJwbktJ?=
 =?utf-8?B?U3U2L0MycjF4dFU2OWZlUzFWNWVIZGx2aXZRZUdHMXNZTWh4UHkrOWhQTmt4?=
 =?utf-8?B?U2FXNlUvRUowZ1VFWWRtejV1V2ovK1BKRHBQUzRBSkMwaGE4VVFQRXIxMnMr?=
 =?utf-8?B?NE4yRlRoMmIxclNEMU9EWU1vem9NdTBUbG0xaUVpTDd5UUtRbDNzeS9xczB3?=
 =?utf-8?B?M2FTeFVpUXVtRGRuMzJSTCtQa3ZIOEdXbmgzajNqNVU3cXFQQjhaUkNWVmpk?=
 =?utf-8?B?T0JzN0lIRDRMNVI0eHIxejRQRzBzUnFrWEVlY2RtSzUvenA5Qlc0MzZQUVVD?=
 =?utf-8?B?SnJHNjF3VmxjeTZ2Q2ZVNW1GY3pMSHJVU2x1bDJOTVpUUEYyakRLNUo5eDcv?=
 =?utf-8?B?SlhtcCtLWTM1dmswcHhWL2pYV29tU3dOWi9TR2MrSU9aUlFoNmt5ejNVKy9T?=
 =?utf-8?B?bVA4ZmorbG1rQllJN2pMaHdHSUhRendtdGZFQmk3YW1jUWJONFNodys4d2No?=
 =?utf-8?B?ek5ZbTB6WC9CTkFJMWtsaEVNY3BnRWM4elFxdWpSa3ExRzZNeUZkUXk2WHp1?=
 =?utf-8?B?R2hINVRMSnZEa2JCRTJ0dVVXNHRrQ05DcXJZbjhSTFdNbUFKQnpCYW9Yakc0?=
 =?utf-8?B?U1BocitvUzRiTHhIajZKc245bm1kcFRwbEFZSEZyVm1SSU80K0tqeGY3c3l2?=
 =?utf-8?B?ZnVNU1ltNnlBSisxbkFRR1ZxNUN4UnUvZFRPWWcvUTA4WmxYdHNROXRMVWZ6?=
 =?utf-8?B?eHVEckhuU3Bib2wvdVl0Q2xHcUlvTmxBUFd4YjVLRldRM1MwM0xtNzg2RlZU?=
 =?utf-8?B?RUVqWFp1UzZKTWxaZkUxQVJDb3cvaGRnbUV1TnlSMmJVSHRRaC80Uk1Cdk1p?=
 =?utf-8?B?N0tSSGZyWE4rTktvQlpZTjkrWGs5ZTZlSDhDbWJOSFc1Qm5yQitLeERZRjFt?=
 =?utf-8?B?VmxDMVBDTncvQy83YXRaYTlaZ1ZpcUtGVkVpMzhNaGhocG1WT2R4RE5RcXh4?=
 =?utf-8?B?N3hua2lCSllJMHV4TXNuOWIxMDZjcFBTVStxQkIrL3JqL3BPeDE2S0xiWURY?=
 =?utf-8?B?eStNYi9rVHdoNkZUZEYwdVlQd2FMOHBpRzFYTUttcjAyTDE1WHdTTGF2aUdw?=
 =?utf-8?B?S3VOSjlpeWFVNThZYmhrd29XcEZPTGswemNmYklJamNCUTRncEZ3cUVwa3J6?=
 =?utf-8?B?Vi9JbXpVSkgwaDRhV1BwODNySkcwR0c3eWVwNnR5N2t0N3hiZ3FNVmVHcXdz?=
 =?utf-8?B?NTFGakdqbjlaSlpycmVkZW5DUm5OZTYvQ1h2bDRqNkFJd2QrQjd2OGdXMDh5?=
 =?utf-8?B?clROeGtRSkdnNCtLQnMxVVpkSDFUaXg1dEJJazRiUWlrSGUwR1h1ZlA3VzJY?=
 =?utf-8?B?bFp0S2x3R3Q0VkhhaWs2M1FMWFUrTnV1NWpYRldZaHhhVkZZWG9ROWthTmxx?=
 =?utf-8?B?VlA1bTNOVXhzaWk4Z1A2SS9KRmtLOWFPMFJuMjV5N1ZFOU8veE9lYll0b1hZ?=
 =?utf-8?B?WGw2Q1U3VUhLd3lhK1UwQVVzdGx5NjVWdlJpYWpBU3FQM3VKVjNpcE5vcFRR?=
 =?utf-8?B?K1hpQXJVL3lUV2h4SUNFS1hHVnNQU21OVkE2cFdrSmtmeXV2Um9wWHRETmtK?=
 =?utf-8?B?Q1hhdVRiRHA4UE9lYWVsYUxuanh0M0hDcVRDMFJYaFB0K283dHFPbGxaK2dN?=
 =?utf-8?B?RWp3YUZFMDFhL3BlYjA4aG1BNnV3Z2tGdmpYRGc5VjFRWm9EQkVVOEUwRHU0?=
 =?utf-8?B?UDJlQjlMeW1Sa0kyeTBBTmkxUVFrR1lzdm9OTS9qMTJ5dThFM1BvRWo5VkFE?=
 =?utf-8?B?M2RoVGpJSS96YXRWZGt4M2J0TExKUnVJVGJkTnlETjl3U2tFbzhVN0JVdkRr?=
 =?utf-8?B?eUhPRndkeWtYUTVwYkg2MnRpZ0JwQ05LQTRZaHpqZkt1U3dTOHozbHR0SGRH?=
 =?utf-8?Q?FvRuEFoFCJdGfYmYfTKkGLEUB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HAGhXGP/7gMtmuOvxeq/gOLbBoU5iu+aGSo4Rv8lNn1JmqM2q4mgF1XJmGemj1J5CyJqRppZLQaqnBVdVZFykYMlDWNbhMxxq3dCe3QP8b0ptAdTVhxMgYxVdov3fpR7kNllHi+hD6/IsJnuhacbBLgSuhQ4bwSEDFkrF15yBzkOa8lowL7QQcZ/VSs3/VJZfbKlZK86hUTkLzFd5tM8bT/qr+u6l7vvlpkfbi9o9ZA3PG29YZ6GQ+Pfv3EnnbHwfu32Xo1Qil1nvKZd192/BFocn0bIorFUlSCjFQPNIYZK9kP44ChJqc9iHaanJhBkkWBgBvijBWJEvxcIZwgyqCieVbUQ9C4dEsQnQuisaLECMDSu+qzTnQacWWyDwGayvvHB6YQptpPhLRGBBuuyCfyr1i97b33lV4ZGP8iYB+sqIzCGmiqjCF3dkaZ5OufKS+/5+dcU4vY1NCXH5b/uKkLihkUVu2V54Q7BhZS1yVZAWO3XIaxmCYRFc7AE8dQzWs/B1DJ+3M47AS8Yfa6ZS4rFJ4krjZ1MHwOqkhQS6P9ReDujJsAQaK9IciuUZw1nrl2GRDWCPnVj0B/buELov+SeY1IZkyBEpY+PSHjHt1u1QvMh1XDgoMdJW2P5MZJslJRZiydsG/9AmbxwBhSV9DHpNKTORzSKq2dqNs83BU2qLo92pGMFM6rJCfMRY45fLKu1vAlUYLEzaI1l9ANu4n+926RzWu04NPsNIpkL0gg44sglXf4Ec6OX/ZcVn6Gkz88sgSaFy4rShABwtpcIKdnqGleH0SiirqO/cOCuSOzhnaCSH5FwUoLVdzhue0AmcflE+sHUIpGly+FZ4/kCSg==
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7542.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddd791b-dfd6-4d10-cc3e-08db47a404b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:49:58.1893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gLwzlzgOi3UFaPSWAsRgnnMEEm6JnaCqyP4WZ8eieJ3KOeMdTNK31IA0z72aK5wF+ZgHLTPbRfmZy6AMPkonOOJG5HW7TShDgtYARJg9P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8821
X-Proofpoint-GUID: uPxaFdMMM0qmQBnI0w5R9zGNEsZqSYYw
X-Proofpoint-ORIG-GUID: uPxaFdMMM0qmQBnI0w5R9zGNEsZqSYYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280038
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91Li4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvc2ggQm95
ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMjcsIDIwMjMg
Njo0MSBQTQ0KVG86IFNhbXBhdGggTmltbWFsYSAoVGVtcCkgKFFVSUMpIDxxdWljX3NhbXBuaW1t
QHF1aWNpbmMuY29tPg0KQ2M6IGxpbnV4LWZpcm13YXJlQGtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0
aG9vdGhAdmdlci5rZXJuZWwub3JnOyBta2FAY2hyb21pdW0ub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZzsgQmFsYWtyaXNobmEg
R29kYXZhcnRoaSAoUVVJQykgPHF1aWNfYmdvZGF2YXJAcXVpY2luYy5jb20+OyBTYWkgVGVqYSBB
bHV2YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FsdXZhbGFAcXVpY2luYy5jb20+OyBBdHVsIERo
dWRhc2UgKFFVSUMpIDxxdWljX2FkaHVkYXNlQHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFFD
QTogVXBkYXRlIGZpcm13YXJlIGZpbGVzIGZvciBCVCBjaGlwIFdDTjY3NTANCg0KV0FSTklORzog
VGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJl
IHdhcnkgb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNy
b3MuDQoNCk9uIFRodSwgQXByIDIwLCAyMDIzIGF0IDEyOjE34oCvQU0gU2FtcGF0aCBOaW1tYWxh
IChUZW1wKSAoUVVJQykgPHF1aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+IHdyb3RlOg0KPg0KPiBE
cm9wcGVkIC5wYXRjaCBmcm9tIGNvbW1pdC4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0t
LS0tLS0tLSBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IA0KPiA4NDUxYzJiMWQ1
MjlkYzFhNDkzMjhhYzkyMzVkM2NmNWJiOGE4ZmNiOg0KPg0KPiAgIG10NzZ4eDogTW92ZSB0aGUg
b2xkIE1lZGlhdGVrIFdpRmkgZmlybXdhcmUgdG8gbWVkaWF0ZWsgKDIwMjMtMDQtMTggDQo+IDA4
OjE0OjA4IC0wNDAwKQ0KPg0KPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoNCj4NCj4gICBnaXRAZ2l0aHViLmNvbTpzYW1wYXRobmltbW1hbGEvYnRfZmlybXdhcmUuZ2l0
IG1haW4NCg0KUHVsbGVkIGFuZCBwdXNoZWQgb3V0LiAgVGhhbmsgeW91Lg0KDQpqb3NoDQoNCj4N
Cj4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDJjNmJlMWE0ZjBkMGZhZGIxMDNiNzJh
ZjIyNDJmZDM3MzIzMzdkNmY6DQo+DQo+ICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9y
IEJUIGNoaXAgV0NONjc1MCAoMjAyMy0wNC0yMCAwOTo0Mjo0MyANCj4gKzA1MzApDQo+DQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gc2FtcG5pbW0gKDEpOg0KPiAgICAgICBxY2E6IFVwZGF0ZSBmaXJtd2FyZSBmaWxl
cyBmb3IgQlQgY2hpcCBXQ042NzUwDQo+DQo+ICBXSEVOQ0UgICAgICAgICAgIHwgICAyICsrDQo+
ICBxY2EvbXNidGZ3MTEubWJuIHwgQmluIDE2NjgzNiAtPiAxNjc1NTIgYnl0ZXMgIHFjYS9tc2J0
ZncxMS50bHYgfCBCaW4gDQo+IDE1NDYyNCAtPiAxNTUzNDAgYnl0ZXMNCj4gIHFjYS9tc252MTEu
YjA5ICAgfCBCaW4gMCAtPiA1ODQ3IGJ5dGVzDQo+ICBxY2EvbXNudjExLmIwYSAgIHwgQmluIDAg
LT4gNTg0NyBieXRlcw0KPiAgcWNhL21zbnYxMS5iaW4gICB8IEJpbiA1ODQ3IC0+IDU4NDcgYnl0
ZXMNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAx
MDA3NTUgcWNhL21zbnYxMS5iMDkNCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSBxY2EvbXNudjExLmIw
YQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gVGhh
bmtzLA0KPiBTYW1wYXRoDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEpvc2ggQm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJp
bCAxOSwgMjAyMyA2OjUwIFBNDQo+IFRvOiBTYW1wYXRoIE5pbW1hbGEgKFRlbXApIChRVUlDKSA8
cXVpY19zYW1wbmltbUBxdWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LWZpcm13YXJlQGtlcm5lbC5v
cmc7IGxpbnV4LWJsdWV0aG9vdGhAdmdlci5rZXJuZWwub3JnOyANCj4gbWthQGNocm9taXVtLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgDQo+IGxpbnV4LWFybS1tc21Admdlci5r
ZXJuZWwub3JnOyBCYWxha3Jpc2huYSBHb2RhdmFydGhpIChRVUlDKSANCj4gPHF1aWNfYmdvZGF2
YXJAcXVpY2luYy5jb20+OyBTYWkgVGVqYSBBbHV2YWxhIChUZW1wKSAoUVVJQykgDQo+IDxxdWlj
X3NhbHV2YWxhQHF1aWNpbmMuY29tPjsgQXR1bCBEaHVkYXNlIChRVUlDKSANCj4gPHF1aWNfYWRo
dWRhc2VAcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBRQ0E6IFVwZGF0ZSBmaXJtd2FyZSBm
aWxlcyBmb3IgQlQgY2hpcCBXQ042NzUwDQo+DQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2lu
YXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5r
cyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPg0KPiBPbiBXZWQs
IEFwciAxOSwgMjAyMyBhdCAyOjM14oCvQU0gU2FtcGF0aCBOaW1tYWxhIChUZW1wKSAoUVVJQykg
PHF1aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkZWQgY2hhbmdl
cyB0byBXSEVOQ0UsIHBsZWFzZSBmaW5kIGJlbG93IHNjcmVlbnNob3QgZm9yIHB1bGwgcmVxdWVz
dC4NCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0NCj4gPiAtLS0tLS0gVGhlIGZvbGxvd2lu
ZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiA+IDg0NTFjMmIxZDUyOWRjMWE0OTMyOGFjOTIzNWQz
Y2Y1YmI4YThmY2I6DQo+ID4NCj4gPiAgIG10NzZ4eDogTW92ZSB0aGUgb2xkIE1lZGlhdGVrIFdp
RmkgZmlybXdhcmUgdG8gbWVkaWF0ZWsgDQo+ID4gKDIwMjMtMDQtMTgNCj4gPiAwODoxNDowOCAt
MDQwMCkNCj4gPg0KPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
PiA+DQo+ID4gICBnaXRAZ2l0aHViLmNvbTpzYW1wYXRobmltbW1hbGEvYnRfZmlybXdhcmUuZ2l0
IG1haW4NCj4NCj4gWW91IHNvbWVob3cgY29tbWl0dGVkIGFuIGFjdHVhbCAucGF0Y2ggZmlsZToN
Cj4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3NhbXBhdGhuaW1tbWFsYS9idF9maXJtd2FyZS9jb21t
aXQvYTA1ODg4M2JlYWM4NGM2Yg0KPiAyMDliZDRlNGVjMmJkNWQyYzFhYTU0MDMNCj4NCj4gQ2Fu
IHlvdSBwbGVhc2UgZHJvcCB0aGF0Pw0KPg0KPiBqb3NoDQo+DQo+ID4NCj4gPiBmb3IgeW91IHRv
IGZldGNoIGNoYW5nZXMgdXAgdG8gNjFiZTcxYThkMWJmMDVkMGRmOGUwNzcyNDQ5NDY1ZTQzMGRl
ZWI1ZjoNCj4gPg0KPiA+ICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAg
V0NONjc1MCAoMjAyMy0wNC0xOSANCj4gPiAxMTo1OTo0OQ0KPiA+ICswNTMwKQ0KPiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiBzYW1wbmltbSAoMSk6DQo+ID4gICAgICAgcWNhOiBVcGRhdGUgZmlybXdhcmUgZmls
ZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KPiA+DQo+ID4gIHFjYS9tc2J0ZncxMS5tYm4gfCBCaW4g
MTY2ODM2IC0+IDE2NzU1MiBieXRlcyAgcWNhL21zYnRmdzExLnRsdiB8IA0KPiA+IEJpbg0KPiA+
IDE1NDYyNCAtPiAxNTUzNDAgYnl0ZXMNCj4gPiAgcWNhL21zbnYxMS5iMDkgICB8IEJpbiAwIC0+
IDU4NDcgYnl0ZXMNCj4gPiAgcWNhL21zbnYxMS5iMGEgICB8IEJpbiAwIC0+IDU4NDcgYnl0ZXMN
Cj4gPiAgcWNhL21zbnYxMS5iaW4gICB8IEJpbiA1ODQ3IC0+IDU4NDcgYnl0ZXMNCj4gPiAgNSBm
aWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9k
ZSANCj4gPiAxMDA3NTUNCj4gPiBxY2EvbXNudjExLmIwOSAgY3JlYXRlIG1vZGUgMTAwNzU1IHFj
YS9tc252MTEuYjBhDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBTYW1w
YXRoDQo+ID4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEpvc2gg
Qm95ZXIgPGp3Ym95ZXJAa2VybmVsLm9yZz4NCj4gPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxOCwg
MjAyMyA1OjI3IFBNDQo+ID4gVG86IFNhbXBhdGggTmltbWFsYSAoVGVtcCkgKFFVSUMpIDxxdWlj
X3NhbXBuaW1tQHF1aWNpbmMuY29tPg0KPiA+IENjOiBsaW51eC1maXJtd2FyZUBrZXJuZWwub3Jn
OyBsaW51eC1ibHVldGhvb3RoQHZnZXIua2VybmVsLm9yZzsgDQo+ID4gbWthQGNocm9taXVtLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgDQo+ID4gbGludXgtYXJtLW1zbUB2Z2Vy
Lmtlcm5lbC5vcmc7IEJhbGFrcmlzaG5hIEdvZGF2YXJ0aGkgKFFVSUMpIA0KPiA+IDxxdWljX2Jn
b2RhdmFyQHF1aWNpbmMuY29tPjsgU2FpIFRlamEgQWx1dmFsYSAoVGVtcCkgKFFVSUMpIA0KPiA+
IDxxdWljX3NhbHV2YWxhQHF1aWNpbmMuY29tPjsgQXR1bCBEaHVkYXNlIChRVUlDKSANCj4gPiA8
cXVpY19hZGh1ZGFzZUBxdWljaW5jLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogUUNBOiBVcGRhdGUg
ZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MA0KPiA+DQo+ID4gV0FSTklORzogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdh
cnkgb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3Mu
DQo+ID4NCj4gPiBPbiBNb24sIEFwciAxMCwgMjAyMyBhdCA0OjMx4oCvQU0gU2FtcGF0aCBOaW1t
YWxhIChUZW1wKSAoUVVJQykgPHF1aWNfc2FtcG5pbW1AcXVpY2luYy5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IEhpIFRlYW0sDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGluY2x1ZGUgZmlybXdhcmUg
YmlucyBmb3IgV0NONjc1MC4NCj4gPiA+DQo+ID4gPiBNYWpvciBjb250cmlidXRpb25zIDogQnVn
IEZpeGVzLg0KPiA+ID4NCj4gPiA+IFNuYXBzaG90IG9mIHB1bGwgcmVxdWVzdCBpcyBhcyBiZWxv
dywgbGV0IG1lIGtub3cgaWYgYW55dGhpbmcgaXMgbWlzc2luZy4NCj4gPiA+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+ID4gLS0NCj4gPiA+IC0tDQo+ID4gPiAtLS0tLS0tLS0tLSBUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0DQo+ID4gPiA4NmRhMmFjOWI0ZTU3ZTlhODhmOGJmY2I1YTE2M2E0MDZm
NWMwMGUxOg0KPiA+ID4NCj4gPiA+ICAgTWVyZ2UgaHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9s
aW51eC1maXJtd2FyZSAoMjAyMy0wNC0wNg0KPiA+ID4gMDc6MzA6MzENCj4gPiA+IC0wNDAwKQ0K
PiA+ID4NCj4gPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiA+
ID4NCj4gPiA+ICAgZ2l0QGdpdGh1Yi5jb206c2FtcGF0aG5pbW1tYWxhL0JsdWV0b290aF9GVy5n
aXQgbWFpbg0KPiA+ID4NCj4gPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAxNjdh
Yjg4NTNiYzE1ZjhlYzU4ZTZiNzZmOThlZTUwMDc3NzBkOTA3Og0KPiA+ID4NCj4gPiA+ICAgcWNh
OiBVcGRhdGUgZmlybXdhcmUgZmlsZXMgZm9yIEJUIGNoaXAgV0NONjc1MCAoMjAyMy0wNC0xMA0K
PiA+ID4gMTM6NTU6MzgNCj4gPiA+ICswNTMwKQ0KPiA+ID4NCj4gPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+
IHNhbXBuaW1tICgxKToNCj4gPiA+ICAgICAgIHFjYTogVXBkYXRlIGZpcm13YXJlIGZpbGVzIGZv
ciBCVCBjaGlwIFdDTjY3NTANCj4gPiA+DQo+ID4gPiBxY2EvbXNidGZ3MTEubWJuIHwgQmluIDE2
NjgzNiAtPiAxNjc1NTIgYnl0ZXMgcWNhL21zYnRmdzExLnRsdiB8IA0KPiA+ID4gQmluDQo+ID4g
PiAxNTQ2MjQgLT4gMTU1MzQwIGJ5dGVzDQo+ID4gPiBxY2EvbXNudjExLmIwOSAgIHwgQmluIDAg
LT4gNTg0NyBieXRlcw0KPiA+ID4gcWNhL21zbnYxMS5iMGEgICB8IEJpbiAwIC0+IDU4NDcgYnl0
ZXMNCj4gPg0KPiA+IFRoZXNlIGZpbGUgYWRkaXRpb25zIG5lZWQgdG8gYmUgYWRkZWQgdG8gV0hF
TkNFIG9yIGNoZWNrX3doZW5jZS5weSBmYWlsczoNCj4gPg0KPiA+IFtqd2JveWVyQHZhZGVyIGxp
bnV4LWZpcm13YXJlXSQgLi9jaGVja193aGVuY2UucHkNCj4gPiBFOiBxY2EvbXNudjExLmIwOSBu
b3QgbGlzdGVkIGluIFdIRU5DRQ0KPiA+IEU6IHFjYS9tc252MTEuYjBhIG5vdCBsaXN0ZWQgaW4g
V0hFTkNFIFtqd2JveWVyQHZhZGVyIA0KPiA+IGxpbnV4LWZpcm13YXJlXSQNCj4gPg0KPiA+IENh
biB5b3UgYWRqdXN0IHBsZWFzZT8NCj4gPg0KPiA+IGpvc2gNCj4gPg0KPiA+ID4gcWNhL21zbnYx
MS5iaW4gICB8IEJpbiA1ODQ3IC0+IDU4NDcgYnl0ZXMNCj4gPiA+IDUgZmlsZXMgY2hhbmdlZCwg
MCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKSBtb2RlIGNoYW5nZSANCj4gPiA+IDEwMDY0
NCA9Pg0KPiA+ID4gMTAwNzU1IHFjYS9tc2J0ZncxMS5tYm4gbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+
IDEwMDc1NSANCj4gPiA+IHFjYS9tc2J0ZncxMS50bHYgY3JlYXRlIG1vZGUgMTAwNzU1IHFjYS9t
c252MTEuYjA5IGNyZWF0ZSBtb2RlDQo+ID4gPiAxMDA3NTUgcWNhL21zbnYxMS5iMGEgbW9kZSBj
aGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSBxY2EvbXNudjExLmJpbg0KPiA+ID4NCj4gPiA+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ID4gLS0NCj4gPiA+IC0tDQo+ID4gPiAtLS0tLS0tLS0tLQ0KPiA+ID4NCj4gPiA+
DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4gPiA+IFNhbXBhdGgNCj4gPiA+DQo+ID4g
Pg0K
