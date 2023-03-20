Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1226C1D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCTRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCTRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:12:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C829167;
        Mon, 20 Mar 2023 10:07:37 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEmRdI024070;
        Mon, 20 Mar 2023 16:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=KCGY3P53TH2PbHXN8UO+LVUhDXbDWmvWnk2wCE1Hrck=;
 b=CWHQe1hDJx4aNM3vC2Ne2ZnUTdalYEDSZwxlahH0oqWFcHqzY0LDKq46ECRXzaXoh879
 3Otgw/RUwuIBF0AoaB4IPRP5rt1Ma9xROb16Afb33uLFyKPplRb9nGY+zHq3t0euDAcx
 UT8HkSXDmXuvSwQPrE1PhKMesdG6vAkREl/rbh50jvQl19ILz8mgGz/VFnsy+gcevk91
 w8iGbiEBbqqHGthLqkbZQM0RhfXWAIttwqxFisvc8RTFz0i9yO6tKzQDWIOwdFr7gp3K
 WeOcMe6+YveXjepIfY2PZ57caBdq+VmXWO9O8mlII3zD/gPVGPFwyivWCZ469YayHtiP Mw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3per7dp1uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebvIfBPCfZEuUP/5knzAvviutMx9Ftnq2m6E9KJWnHVoGoUeCq3I0Hy817YFmHG7y4OV0wSvw6iitJJuUu6iZNsKvyLhCJw4QxkoJJq8sWNZkyhcq8Bqb2fCiWWBZf91TL2PNBVM9Ty26P2MYWl05FnayXBej3G6Syu9mrzaTP+RQKlQqYGvd4otbTTR6wb2vpv8L6c1pNQsQTQS0muVK3teaQFxV84HY05ZPlUMPgF615ssPn4TUU9JjZw0U6bP9sqz4ja7V6skXzkHPspOMb+1/asP1eBxEq0C+yraYHlNA3K+Ip8cFxXnPHIFEnddY3ChU2cMPbHQlCmICfMfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCGY3P53TH2PbHXN8UO+LVUhDXbDWmvWnk2wCE1Hrck=;
 b=U5bv1r7MfjXCH9YQmA6QUX7GnnLmx0ABr13Kd29D794zShbRyRYsd9znsXjXEOKFxtATN0MwmoHPZTxA5l+j3Ylhlg1SgkvcNLtSQ31Yfz6YFWpm2XoIgL87abkLyei7sDYOWl1OJNHMXb/e2AWRw08dXfq7R8Sun1AOHSkCt2vzy13fw944xYKxZ1frwXQfvoPuDRKrJ6qFTpnxtm0lufDA0u29FFUJJNzggWgND0oukwTU3ad4HfwXhwZkge5IA5K+kCCZXKI4KHskuOlFGKr5dy138qiPUMHi+rw+58xvRyXEfnBKQ/R0EMZjgZhtPmvSxNbDmL1e8nP7VlU7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by IA1PR15MB6031.namprd15.prod.outlook.com (2603:10b6:208:448::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:48:30 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:48:25 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] dt-bindings: trivial-devices: Add
 acbel,crps
Thread-Index: AQHZW0JRqQvyIHDCM0ewnvSIUD+Dfq8D29qA//+xaIA=
Date:   Mon, 20 Mar 2023 16:48:25 +0000
Message-ID: <74BE497C-3649-436E-ACF7-CAEB44D2DB24@us.ibm.com>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
 <20230320154019.1943770-3-lakshmiy@us.ibm.com>
 <cd1eace0-7c0b-e6e3-ec56-18a88e974bc0@linaro.org>
In-Reply-To: <cd1eace0-7c0b-e6e3-ec56-18a88e974bc0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|IA1PR15MB6031:EE_
x-ms-office365-filtering-correlation-id: 3b9f3adf-797b-4b61-4d22-08db2962ecb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3I1kHqGmN584hSKzY6LalFSH1b+mBlXWZsO2EZ7Ge7efOFOZXNlHqI9u/r3dzCd8+JoFASZMuXFwf9UpybU34FnuAhgZhJpZI76O4PbbQ1h9OgzZz2rcR7SSic/UduekpjkmVNs7zHYiHGWbD+jpdB4Uo2yxwcvOl7my/pyEco03gcQaFPW41jVh62tZ9ZAvWEK6ELJmTZ/d266BnL8B2KFPRGrzfVWaOamsQTkm3ck8CJ5fsyvxMIQwUWYWnr2b3Jd03YU45tipG8o6Jsb+sYnYuPXUvCg1yWbKUN29YRMg8oP7vzVcPv+ukOzaiOavcwcGrSXh+fFFXivXee0NgoVjYFmh6EZ+BJ0lo9LnNtxifTMRHvy+lS+pL5QmGBeJjNioySQWBZN9UrFKNZNjg/MFjao9zl/YFx9/6cR9lyO8DYacxHB0F4TVDZ8BQAkLc6YbEBqroF4IPw9YAFqhnLSN4pq9l2vfOuxyFaCEpPWCGr8wXfVyogR3xh0RlDT10oxTbR6QFdqzG7g2M9H8AoaXP2ZzHquZYyDzqWvOUhdLk/Z5sYeEE3gwrBnIXfRHYaJCqTRlbgfQ6fedThjEnDNbulaV1jandih98M7lFxbyjwsueJL7zXjadnZLtZBr4+YXN0N0/0c4MBB59jSIDEqbzHMqaW0JGUjg7U9Fd15YGTNmsDQGAztupt2zew7/i8RoMh0kft3FX8I8hvIbZNwyU1lLr/7B2ZJ5VLVWySY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(316002)(478600001)(71200400001)(38070700005)(110136005)(54906003)(6506007)(6512007)(53546011)(8676002)(91956017)(76116006)(6486002)(4326008)(66556008)(66946007)(66476007)(64756008)(66446008)(4744005)(83380400001)(86362001)(2906002)(122000001)(2616005)(41300700001)(7416002)(186003)(5660300002)(38100700002)(33656002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE10dXltQkIxUzVuM3pXektOc0V4cnh1SGc0UmpDNXVQbHpucmtBdnFQZDU5?=
 =?utf-8?B?Z21pTWY4cDJ4Q2dhbXIzOGp1NnBkKzg1WnBKVFpEWmRSU0ZraTVqb3E1VGdD?=
 =?utf-8?B?RmZVRVl5cHdNRDQ2ZDlIUU9SQzNDNElJcFRoSHQ3dVA2bGVmS2kyeGxiVS9J?=
 =?utf-8?B?R3RjMEUxMUJhajhPcjFIU1YxVDNzUnJ3eVdyTXdyNXhtWkRaK2RDSVZ0L1ho?=
 =?utf-8?B?YW1TNWFmdkxLSENRVEJEL0Y1ZFZtU1JDTU54VHFnTFY2VkczQ2RuZXNoVXQ3?=
 =?utf-8?B?cTBwRjNic3JMRlVhRHpsZFVlbVVnc0doMzNVbUY5MTNhZkZKSE5nQ0N5R0Jt?=
 =?utf-8?B?YjVYSzZ4Q280NnNSanlEamlXWXBSeDdIelg4QjlFUFlXY3VKRGZqRzFQeFlV?=
 =?utf-8?B?elpvaHFwNmpMa3RFbSsrNzRXaEZ4dlN3bjBQbmtBbzBwUEQ3NXltMC8wdW40?=
 =?utf-8?B?WnU3TzAyN2dDR2pqWmwvVTEvNEN0ckc0NzhqR0JUQ3ljVWlidzgxdjBPY2xM?=
 =?utf-8?B?WEd1c0xabTQvbXhmbDgxSmVSczdQWDFPaDd0THdyeDl4WUFJZERpOTJ4UUFE?=
 =?utf-8?B?UytDbEg4VHJIU0pzRlBZZHZzVDNpcUNGQU9MQUVxV1MvSkJFRUVxckhiOUtj?=
 =?utf-8?B?UitSdDY1TmdIcGxmZFArOXV5TVczMDlTTFJKN3BkVkpnSGl5VTdwTEM0clJp?=
 =?utf-8?B?TDlIRFp0anlKWWdGUzM0dmpHR0s5Z2lvRkVyN0N2d2Y2ZUcvMjRzR29CSXJ5?=
 =?utf-8?B?YkJxSks5Lzg5a3BkMmRyMzJraEE0V1F4bUd0MnI0eitUVmRMbVpqbDhuRFdm?=
 =?utf-8?B?NkZnNU0xN1E4alpOc3FHSStVK2NBNGF3YjdyTUV4Y2JTak1rSyt3VDRVL3ky?=
 =?utf-8?B?aW9ZZkJ6NEhQN016NVhQY0ZPNHZwT3NtZ2x0RXNySkplTnNERXZEbFNPdUtj?=
 =?utf-8?B?OHNTc0VieW81UTBUQVM5SEdudVdRajdlOEpQS0JHZHpQL1BqNVFuMk91QzEz?=
 =?utf-8?B?bXJiU0hSRW5aUFNRS3dGMm0yUVhiVitSTTVmVURxUXc0bFNBbTlVbjkyZG5U?=
 =?utf-8?B?YkR2RHM4NEowZDJrNFBqZ3FPQlQ5THBTVGFGWFVrbGNITXJ6c0NwdW10UkN3?=
 =?utf-8?B?MDl4RGxFd2doa2lCSDh5M0JjbWIvYk5uSEFwenpZS2hLNmpsS3MvUWx6Q2tv?=
 =?utf-8?B?SnJJMEVuM05URDNkMUVWbUM4WlAydHV5K1NuTmdHeEZSUEhMZHFsQWd1bmNn?=
 =?utf-8?B?U0VlYmY2NG8vRjZtY3h3MmVQRHNYYWZUSVp4RjVjOUV3LzY5TjdrSmd0bHpt?=
 =?utf-8?B?aTJaUmtjZTVlMTlQUDdWSktaa24zby9OVGtXY3lYU2lFMUdqZzFUTnZJUjRD?=
 =?utf-8?B?bXdkSVVkSllkM1czSkhhcmo1bTJ5cklHYzNlTnk3eHNhMVY2aEFBUGM3cHVx?=
 =?utf-8?B?QVoxak9OeVBjYWpzcVVBM1hJQy9sWjRLMlIxZzVBdDJ4clJkZ0FjK0d1ZVdK?=
 =?utf-8?B?VE1xNllYRWtpUVBrUXE5UG1DYlNmc09JMGlRa2NLV0k0UzRWNDBSYVIxUVFU?=
 =?utf-8?B?OEZ4aVFZbjUwSDd0cCtHUExsVThmaGNVa0NtUkNvZHlvMUEyK2E3TEZzT1lR?=
 =?utf-8?B?R0FGbG9idUN3U1JIbXNFUzdKWXFrYkR0dG5qd1FZYm50RGVqNHdLL0RUeVlN?=
 =?utf-8?B?RlltNHRoZ0RuOFBYeGlTMlRvcEFDY0ZYOFFXVTlvcEJpTDRCMUJMZjhlR1ds?=
 =?utf-8?B?MDlIRVFJQi9VMmJ3REJrUlNleG1GQlNlcURTVzVvKy9HRlhSVXhzYVJsZ21E?=
 =?utf-8?B?V1RBTzI1d3hWalZ5SDdTK2NYUVowM3R1UmRBQXJ0RHVOelJ0Y0J3YnJRSWRx?=
 =?utf-8?B?akZsUk1PcDhFSUt2My9HVjRudkNtT25HcDJPazNDdjV1MzFsRXRBNkpEMCtS?=
 =?utf-8?B?UklURnEyejgxdW5nWEJtdUphOGMvQkFIMEExTkpDdG1PT0xmRmRVUmtYcWs2?=
 =?utf-8?B?dFZmSjQ3bDJGUVNsMUlCZTNuWFNMZzBxZmp0UzUzempaRzVWZi9VeVRzNlJI?=
 =?utf-8?B?QnYwdzUwMlJNNVE0a0xDSUl4enBwS01IN2QyajlYVWxTZGRvRDM3ejBGQWdR?=
 =?utf-8?B?R012SzVYem4yTW1FSjhZOFExVCsyeHY1S0NJZVlFSDRsNkl2Mmx0VjFqWDBl?=
 =?utf-8?B?ZEdSaXJ2U29iY05sWUowMGNuRUJLYjd4QWczMTR5OVdNOVk4MThFUStrcU1w?=
 =?utf-8?B?VkdWZU4yMUtOWnlHSWhLYjZnR3NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A083A9ADC4CEF47A39FEBC83CD1D49A@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9f3adf-797b-4b61-4d22-08db2962ecb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 16:48:25.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT6UDTP0jTPFIbUvYRuZvjnXlh4ZAWUvi1M+/SVU+moBsObLh6Vqx+UR8dHQN0N8+3S6aoXi7ae7QRLRBKFjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6031
X-Proofpoint-GUID: 0_2XipL8cw3Y_NpfSONaPz2O0kH1Dn-3
X-Proofpoint-ORIG-GUID: 0_2XipL8cw3Y_NpfSONaPz2O0kH1Dn-3
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v2 2/5] dt-bindings: trivial-devices: Add acbel,crps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=885
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMjAvMjMsIDExOjI5IEFNLCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyenlz
enRvZi5rb3psb3dza2lAbGluYXJvLm9yZyA8bWFpbHRvOmtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4+IHdyb3RlOg0KDQoNCk9uIDIwLzAzLzIwMjMgMTY6NDAsIExha3NobWkgWWFkbGFw
YXRpIHdyb3RlOg0KPiBBZGQgQWNiZWwgQ1JQUyBTZXJpZXMgcG93ZXIgc3VwcGx5IHRvIHRyaXZp
YWwgZGV2aWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExha3NobWkgWWFkbGFwYXRpIDxsYWtz
aG1peUB1cy5pYm0uY29tIDxtYWlsdG86bGFrc2htaXlAdXMuaWJtLmNvbT4+DQo+IC0tLQ0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwgfCAy
ICsrDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwN
Cj4gaW5kZXggNmY0ODJhMjU0YTFkLi5hZTJjZjQ0MTFiMzkgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90cml2aWFsLWRldmljZXMueWFtbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwN
Cj4gQEAgLTMwLDYgKzMwLDggQEAgcHJvcGVydGllczoNCj4gaXRlbXM6DQo+IC0gZW51bToNCj4g
IyBTTUJ1cy9JMkMgRGlnaXRhbCBUZW1wZXJhdHVyZSBTZW5zb3IgaW4gNi1QaW4gU09UIHdpdGgg
U01CdXMgQWxlcnQgYW5kIE92ZXIgVGVtcGVyYXR1cmUgUGluDQo+ICsgLSBhY2JlbCxjcnBzDQo+
ICsgIyBBY2JlbCBDUlBTIFNlcmllcyBwb3dlciBzdXBwbHkNCg0KDQpXcm9uZyBwbGFjZW1lbnRz
IG9mIGNvbW1lbnRzLiBUaGlzIGlzIEFELCBub3QgQWNiZWwuDQoNCkkgd2lsbCBmaXggaXQuIFRo
eA0KDQoNCj4gLSBhZCxhZDc0MTQNCj4gIyBBRE05MjQwOiBDb21wbGV0ZSBTeXN0ZW0gSGFyZHdh
cmUgTW9uaXRvciBmb3IgdVByb2Nlc3Nvci1CYXNlZCBTeXN0ZW1zDQo+IC0gYWQsYWRtOTI0MA0K
DQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQoNCg0KDQoNCg==
