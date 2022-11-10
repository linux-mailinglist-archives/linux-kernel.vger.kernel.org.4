Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CF6243CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKJOCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKJOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:02:22 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6DF03B;
        Thu, 10 Nov 2022 06:02:20 -0800 (PST)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AACw4US018273;
        Thu, 10 Nov 2022 14:01:38 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3krwuahayp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 14:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpVZXygECvpWyqvxhKJNnGrkTBh+J+kNteE6rKJ1kAZeTlpQTxgTuZZe0jhCm572qJME9G2aRwCJo9/BoYnh89HfMLVM0zKr/XYtgxnw7Q1P2bI7DomB1Hn97nz/cCrlJPwjyGueh/WQqO/4OtanK0dsgLd3NFlkszkz7ccHA3tsmpvJQJrG3EKJahajQi9jNpInZ5DnPjfZ+8n857dZk2Rfjs2OudGrQDjh101hqlAcuykXDkeuBFG6ekS4ZGEeBeeDhJYzLKpRlLWfZIFY4vh9yLuFlA/Jn522ah5RGI0d8tS0uVGskuW9WcTUFy2sHSvpVAQV49J9/HU231Jpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98XbiGM33YjXwe8WHCI5GWVj6fysLi2vMkhJ48ICGis=;
 b=JZm+8brQOC6rU2GUZyLqr10NRL7t0nDSIwar4yAlR6b5/htKY0IUNr7XBCNFGwpMMab/t/Pm5uKn9u6J26N6NRKwM85TNoREcSZ0jGLTKZkkjHbLGDNWGoYI12uz4Ky8LOspgfqQgge+d4IWEVhHvVaWVjc6WbDafypmtYyd/GoWQGHt7H2RGeR7kD8fJgeYSS4IlX8+dyqu3Fdms6Eg2bPz/N47FSg0dKgyxpg7ZlF71YbFtwEU4i51H3hKHpBEYkpDBDJh/3Dpe5soMoVGdUh1TEHhT/lklfTD9eJLBQWflmX1PWz85GPcMY0cj5HW08M3/pSDLIx1KvO5cEW1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98XbiGM33YjXwe8WHCI5GWVj6fysLi2vMkhJ48ICGis=;
 b=SfR0rW2i9wctx6gVfoy/le2TOGTlRxGbC3pLgtQDG8z9sfIiWu/bLjGnyyZ3BtKrPhCDtjYDRQXmDwtB/l6DLNEc9HRzraKXfrtMLqRF3JnzAECw6VCKxo/V992i5siZXRJvk663I7Y+X/qeO4BAvW63IaV18Q5VFgjsiLZzgDZOMlxxhAHY3rNS+QM4751wixNfO44kIbcpqQn7JVtHxiYkVVpJr3Nx1aoWdQqQKMrTDIcV+bJLx1s4nJdBmZbobv2o4Rc5PyllU3SwGYkRsIW8U0Q0L1koZiK6s8VMcW9JMZuDmpQ6KRJx1SfNxHkBdhlsHR2ZSKVBPzDMFi/3SQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DU0PR03MB9730.eurprd03.prod.outlook.com (2603:10a6:10:44e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 14:01:35 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::cc80:5238:61b7:43c4%5]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 14:01:35 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v6 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHY9Qzx465EusnZoEuoMRMmkj2iWA==
Date:   Thu, 10 Nov 2022 14:01:34 +0000
Message-ID: <0c0a82bb-18ae-d057-562b-21201bfe4fca@epam.com>
References: <cover.1668070216.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1668070216.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU0PR03MB9730:EE_
x-ms-office365-filtering-correlation-id: 8134a050-b73b-46bc-76f1-08dac324140f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXqSnE4PJuJxAyCE0gOEQeJlGGIiYrzOEm6TGIMltj4bI7IQd1z56vbdGrwa2HDNlKU+Bql4T7xvSS2izJUTTv4fgqKA7FxQ5mZM1IG34yfzHsQ1VDnkE7Yt2bK8h6x7XGzwEKZsVJ1hPNCd1QOdKV6pvd/MhTVNqFCnok5cO+dm7D/iD3DDE9N3TUIHtzZankjZ4wlc5DMDCgMxV0osUURXwDdvB/VWx0akCQ/ihzBBn9sSx/kdymdfinNDhRW8Drhms0wR9PaRPHrqgaxmfpOm1Kp8/zG6r8EDivTKTT1lLPp22XhPtPSUzJxbzZUAtgeoIgKouZIbTkj+EzVS8qH8FSvWWWVj0RSI4YUbVdDmEV1GW6TAsA6ufipuBPH/9vW9F80zW+fUDA/wuwD5aZthwChgON5s8k9qLPE6liIfsz/NW6xtQS6XtmpZIav2tOWURQIjAO4XHEAcq9TmhUdP0Zv/8gXv4knT3GPuBlAbIot4YWVMAR51tPGPnnOX5pOdsnAKWy9gf8emcy97/2Z/OAH4lMLqbscN7m34QpK24pe4zmM88KvPSFTuBZpmmrijE9KY/TRGJB86QbhfpyFT2Qc+ph2Zm9SBYTS7stR5EIBBIKW9Hir6uH9Ob55Fj6d3sNvasQD6L8I9hc6pspJunpH4cW/3M3i7b0jjllZ9xSRUgLIAD32TQFvFW+xOWakMcRLwnCTilEAnYJUiQe6JN1irTVv7fE1AWpcHSOvdntmAIblRiNFaEhG/31X4JrvdAc9LTpFLguABXMlTX2BtVv4pPYdigFJWSDfEaRdanv7fwADSCe36CawJBetqut1v2LPxvYYQGQfiOmJ4gMgfrh8DHSYgjEhordeyV4+yvRvMhveTfit3pfbQfhcb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(54906003)(38100700002)(38070700005)(71200400001)(122000001)(31686004)(316002)(86362001)(83380400001)(2616005)(36756003)(2906002)(41300700001)(966005)(6486002)(66446008)(66476007)(31696002)(66556008)(66946007)(64756008)(8676002)(91956017)(186003)(4326008)(6512007)(76116006)(6506007)(26005)(55236004)(53546011)(7416002)(5660300002)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWp5T3RFV3lDQ1o4ZnAyaFJ6eFFlUm9adll6djJqbkUxZU5lWUdPLzRYM2xR?=
 =?utf-8?B?eUtnQTNMalFZR3NwUUhTLy9NNUNqYU9WMDJGbnhucTRHNGJHQi9XakdZT3ZI?=
 =?utf-8?B?NldJVVNhcFJzMlJrcDlaRFBWSDRZclRZOGV5Y1huL0wrM2JZa3pFN1NKbzZh?=
 =?utf-8?B?ckdZZDM1UENZanp3YnBGOFJvOTNQMm00WmdDMEFHWElxcTRnajdYNHZZbGxs?=
 =?utf-8?B?T2NwMHZPSnhkMEorZE5aeGI3V0ZSNDZzNEs3MVJsMEVkUmhQM2o2akFQUU1E?=
 =?utf-8?B?RmNzRzVuVUlmbVYxc25xRWFoZURoQmMxV3BOb2FIcGtRMUVrTXVMOEZlUUFT?=
 =?utf-8?B?TlFZaDRTZyt0T0pGYm1PTEdXMmNiRlF6SGJ3a2hOcnBMeWpnbHpBTW9xVUVI?=
 =?utf-8?B?c0VESGNlalFVeGdmSE1RbDVvbWY3MDkrK0RDd09zbU9oZmwwaHpLakpuZUhH?=
 =?utf-8?B?L25rNXpaSmtCN05jV0V6WG51QzUvZlErNnVEcnd4UTY4enkwb1BxYWhZOXNB?=
 =?utf-8?B?STAvOVhFbHd2OVk1S0RRckdTcDVLL0t6Rzh4U0cxRytTQ3NFN3dtVjhUVit5?=
 =?utf-8?B?cGFKL2NzUmliTXJKd1ZpV2d4L1lUNG5kUDVjUk9aS0h3NHkwd0c2bnhTSGI2?=
 =?utf-8?B?aUdRbFhNbGhoT1liZDBTV210NU1FeXhEMklHaGMyZ09DeUJoL2dzb2FXQ08z?=
 =?utf-8?B?aHo4bmJuS00rNFVrSS9sYitFUy8vTWFyblpULzgvNy92V0EzVUh5bVFNUGpY?=
 =?utf-8?B?YWY4N0JWb1QxZU5yekw4TlNpY3E2NHh0Ykp3d2FPSWVwYjRVT3hmVkZQV1dy?=
 =?utf-8?B?WTEzL3dxektwaG8wSlNtdUExRVkyYVFLWkhySDBHbWE5UDJMM1BJRnl6SWQr?=
 =?utf-8?B?OEVUUFZJV3lUM3VHRGI3YlA1QjVOb3lCSkw2T0ZLVHh1M2hickhKdHhWcWNU?=
 =?utf-8?B?MThEZ1AzU3dDMnRiSTVNOEhiMlJVd294dlQ3aFRaakk0UlhJYTFxQTBubkE3?=
 =?utf-8?B?dkZETzQwcGE3UFBwQmNpNEtKL1B4YnVLUyttcFgvUjhFKzRoejViL2pRRitt?=
 =?utf-8?B?M0ZlVklpM0s5VzNXSlRyRjI4bmhYYTN3ZEpiT01kQTl3YWI2QnNYdGNhRXhm?=
 =?utf-8?B?YXM4bkd6bVNVVmRXK0ZEN2J6MTl0ZWIvdDdzVlBKK3pDRElJYTVCQ0YvYTFy?=
 =?utf-8?B?SjhqMVNYV3MrYld2NUhTUDZOQTlycUtFckpvbzZ5Zjd0dktzWGdjcDN3OWRU?=
 =?utf-8?B?VmNkZTF5ZFZmUjl6QlpiZjZ6cm9RRTdCUDI2ZVRCMGFhdHpDRHQvUUhDcDY2?=
 =?utf-8?B?R3d0OGtDblg1SytXd3ZTMUNGWHgvbG9EQ3o3MjYya0NWK1RoUy9DRStlbWNU?=
 =?utf-8?B?bDVQNFlXRmlOWkhqZDZGWHkwVGZ6Q0h5cVdwekp3cGtwcko3dzJJNGVpbm55?=
 =?utf-8?B?UTFmTkpqaXVPbjAzVXJVWlNZNEFROXBqY2d1MzRaVllDdWh6YUNMVTBLa2oy?=
 =?utf-8?B?Qk9rbzhSdktidnMzam83Z1JYT3ZIeDZPaGdkdE1DSGZNMGo4bGNwTGd1YzlJ?=
 =?utf-8?B?K01MR0srQjk1TktvNHI3NXpMVU13RG4rSUVQdkRPN29rSVpzQWZGVUx3ZG5m?=
 =?utf-8?B?N0hEWHpoeFQ1UFNmOWpzZXpHTXo1eHdpT2V6UEQ5NGI3VWlFMGpIanhxR291?=
 =?utf-8?B?Mit3eVgvOG1rMmFIdjhCUnVKekJLblZPRG1GZFJqdHZFeEhZMXQxZk1Ba0Yr?=
 =?utf-8?B?eW5sQmtHcGxBSzYwTHIzTG50Z3BWNzBKZ1VjOHQ4NFovN0Z6czFubjgzbVpw?=
 =?utf-8?B?cXA5RXdacHlDS255dU9SaG5WTWNieVhaMENVTUhIQWFYYlVPUXg4Yll5ZU9h?=
 =?utf-8?B?TVgzOXpyYnhLNmtmd1hJZk5JeU91ekRyVjRQWTJPa2E5V3NNRlhGNG1TdmNU?=
 =?utf-8?B?VUoya2tTVk02U3JnVTVEZ081d3RVYWcwcHpMcTArUkF2OFpjZ1BlU0RDMFk2?=
 =?utf-8?B?N21TSmxhaG11NzBNejQxVlhpQnczd3pIM1Bhb09VNE9DOE1DZ1RqQTFRWnE2?=
 =?utf-8?B?Q21FYldadE1ZS2wxc0NIcFlQL0VKUmtCdlVETFJVbWxQY1hZZ2h5VjdxTnZv?=
 =?utf-8?B?RlRrWUZBQXVqRmVoTHE0UG9nV3hibW5IcHFZWmgwQS8xdng1LzBBckJTUTRw?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0110B9228E28FB4491F4BC8F5411DDDA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8134a050-b73b-46bc-76f1-08dac324140f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 14:01:34.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI9Rt+dmE8xegzbVW2U3z4wePgjrPe5Of9sqJH5tXAuDByokLKf6VsiMNKnNavB8pBo4qoyFPhlycb3skW3GWye6uzonXcoxae58Pb3QFlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9730
X-Proofpoint-GUID: 2-ua2JCdJs3i9Mob3UT2ba9lhKW3YAIq
X-Proofpoint-ORIG-GUID: 2-ua2JCdJs3i9Mob3UT2ba9lhKW3YAIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_08,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClRoZXJlIHdlcmUgdHlwbyBpbiB0aGUgY292ZXIgbGV0dGVyIHN1YmplY3QuIFBh
dGNoIHNlcmllcyBhcmUgcmVsYXRlZCB0byANCnY2LCBub3QgdjQuIEkndmUgZml4ZWQgU3ViamVj
dCBpbiB0aGlzIGxldHRlci4NCkknbSBzb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2UuDQoNClRo
YW5rcywNCk9sZWtzaWkuDQoNCk9uIDEwLjExLjIyIDEwOjU3LCBPbGVrc2lpIE1vaXNpZWlldiB3
cm90ZToNCj4gSW50cm9kdWNpbmcgdGhlIGZlYXR1cmUgZG9tYWluIGNvbnRyb2xsZXIgcHJvdmlk
ZXIvY29uc3VtZW5yIGJpbmRuZ3Mgd2hpY2gNCj4gYWxsb3cgdG8gZGl2aWRlZCBzeXN0ZW0gb24g
Y2hpcCBpbnRvIG11bHRpcGxlIGZlYXR1cmUgZG9tYWlucyB0aGF0DQo+IGNhbiBiZSB1c2VkIHRv
IHNlbGVjdCBieSB3aG8gaGFyZHdhcmUgYmxvY2tzIGNvdWxkIGJlIGFjY2Vzc2VkLg0KPiBBIGZl
YXR1cmUtZG9tYWluIGNvdWxkIGJlIGEgY2x1c3RlciBvZiBDUFVzLCBhIGdyb3VwIG9mIGhhcmR3
YXJlIGJsb2NrcyBvcg0KPiB0aGUgc2V0IG9mIGRldmljZXMsIHBhc3NlZC10aHJvdWdoIHRvIHRo
ZSBHdWVzdCBpbiB0aGUgdmlydHVhbGl6ZWQgc3lzdGVtcy4NCj4gDQo+IEZlYXR1cmUgZG9tYWlu
cyBjb250cm9sbGVycyBhcmUgdHlwaWNhbGx5IHVzZWQgdG8gc2V0IHRoZSBwZXJtaXNzaW9ucyBv
Zg0KPiB0aGUgaGFyZHdhcmUgYmxvY2suIFRoZSBjb250ZW50cyBvZiB0aGUgZmVhdHVyZSBkb21h
aW4gY29uZmlndXJhdGlvbg0KPiBwcm9wZXJ0aWVzIGFyZSBkZWZpbmVkIGJ5IHRoZSBiaW5kaW5n
IGZvciB0aGUgaW5kaXZpZHVhbA0KPiBmZWF0dXJlIGRvbWFpbiBjb250cm9sbGVyIGRldmljZS4N
Cj4gDQo+IFRoZSBmZWF0dXJlIGRldmljZSBjb250cm9sbGVyIGNvbmNlcHRpb24gaW4gdGhlIHZp
cnR1YWxpemVkIHN5c3RlbXMgaXMgdG8NCj4gc2V0IHRoZSBkZXZpY2UgY29uZmlndXJhdGlvbiBm
b3IgU0NNSSAoU3lzdGVtIENvbnRyb2wgYW5kIE1hbmFnZW1lbnQNCj4gSW50ZXJmYWNlKSB3aGlj
aCBjb250cm9scyBjbG9ja3MvcG93ZXItZG9tYWlucy9yZXNldHMgZXRjIGZyb20gdGhlDQo+IEZp
cm13YXJlLiBUaGlzIGNvbmZpZ3VyYXRpbyBzZXRzIHRoZSBkZXZpY2VfaWQgdG8gc2V0IHRoZSBk
ZXZpY2UNCj4gcGVybWlzc2lvbnMgZm9yIHRoZSBGaXJtd2FyZSB1c2luZyBCQVNFX1NFVF9ERVZJ
Q0VfUEVSTUlTU0lPTlMNCj4gbWVzc2FnZSAoc2VlIDQuMi4yLjEwIG9mIFswXSkuDQo+IFRoZXJl
IGlzIG5vIEJBU0VfR0VUX0RFVklDRV9QRVJNSVNTSU9OUyBjYWxsIGluIFNDTUkgYW5kIHRoZSB3
YXkgdG8NCj4gZGV0ZXJtaW5lIGRldmljZV9pZCBpcyBub3QgY292ZXJlZCBieSB0aGUgc3BlY2lm
aWNhdGlvbi4NCj4gRGV2aWNlIHBlcm1pc3Npb25zIG1hbmFnZW1lbnQgZGVzY3JpYmVkIGluIERF
TiAwMDU2LCBTZWN0aW9uIDQuMi4yLjEwIFswXS4NCj4gR2l2ZW4gcGFyYW1ldGVyIHNob3VsZCBz
ZXQgdGhlIGRldmljZV9pZCwgbmVlZGVkIHRvIHNldCBkZXZpY2UNCj4gcGVybWlzc2lvbnMgaW4g
dGhlIEZpcm13YXJlLg0KPiBUaGlzIHByb3BlcnR5IGlzIHVzZWQgYnkgdHJ1c3RlZCBBZ2VudCAo
d2hpY2ggaXMgaHlwZXJ2aXNvciBpbiBvdXIgY2FzZSkNCj4gdG8gc2V0IHBlcm1pc3Npb25zIGZv
ciB0aGUgZGV2aWNlcywgcGFzc2VkLXRocm91Z2ggdG8gdGhlIG5vbi10cnVzdGVkDQo+IEFnZW50
cy4gVHJ1c3RlZCBBZ2VudCB3aWxsIHVzZSBkZXZpY2UtcGVybXMgdG8gc2V0IHRoZSBEZXZpY2UN
Cj4gcGVybWlzc2lvbnMgZm9yIHRoZSBGaXJtd2FyZSAoU2VlIFNlY3Rpb24gNC4yLjIuMTAgWzBd
IGZvciBkZXRhaWxzKS4NCj4gQWdlbnRzIGNvbmNlcHQgaXMgZGVzY3JpYmVkIGluIFNlY3Rpb24g
NC4yLjEgWzBdLg0KPiANCj4gRmVhdHVyZS1Eb21haW5zIGluIERldmljZS10cmVlIG5vZGUgZXhh
bXBsZToNCj4gdXNiQGU2NTkwMDAwDQo+IHsNCj4gICAgICBmZWF0dXJlLWRvbWFpbnMgPSA8JnNj
bWkgMTk+OyAvL1NldCBkb21haW4gaWQgMTkgdG8gdXNiIG5vZGUNCj4gICAgICBmZWF0dXJlLWRv
bWFpbi1uYW1lcyA9ICJzY21pIjsNCj4gICAgICBjbG9ja3MgPSA8JnNjbWlfY2xvY2sgMz4sIDwm
c2NtaV9jbG9jayAyPjsNCj4gICAgICByZXNldHMgPSA8JnNjbWlfcmVzZXQgMTA+LCA8JnNjbWlf
cmVzZXQgOT47DQo+ICAgICAgcG93ZXItZG9tYWlucyA9IDwmc2NtaV9wb3dlciAwPjsNCj4gfTsN
Cj4gDQo+ICZzY21pIHsNCj4gICAgICBmZWF0dXJlLWRvbWFpbi1jb250cm9sbGVyOw0KPiAgICAg
ICNmZWF0dXJlLWRvbWFpbi1jZWxscyA9IDwxPjsNCj4gfQ0KPiANCj4gQWxsIG1lbnRpb25lZCBi
aW5kaW5ncyBhcmUgZ29pbmcgdG8gYmUgcHJvY2Vzc2VkIGJ5IFhFTiBTQ01JIG1lZGlhdG9yDQo+
IGZlYXR1cmUsIHdoaWNoIGlzIHJlc3BvbnNpYmxlIHRvIHJlZGlyZWN0IFNDTUkgY2FsbHMgZnJv
bSBndWVzdHMgdG8gdGhlDQo+IGZpcm13YXJlLCBhbmQgbm90IGdvaW5nIGJlIHBhc3NlZCB0byB0
aGUgZ3Vlc3RzLg0KPiANCj4gRmVhdHVyZS1kb21haW4tY29udHJvbGxlciBwcm92aWRlci9jb25z
dW1lbnIgY29uY2VwdCB3YXMgdGFrZW4gZnJvbSB0aGUgYnVzDQo+IGNvbnRyb2xsZXIgZnJhbWV3
b3JrIHBhdGNoIHNlcmllcywgcHJvdmlkZWQgaW4gdGhlIGZvbGxvd2luZyB0aHJlYWQ6DQo+IFsx
XS4NCj4gDQo+IEkgdGhpbmsgd2UgY2FuIGNvb3BlcmF0ZSB3aXRoIHRoZSBidXMgY29udHJvbGxl
ciBmcmFtZXdvcmsgZGV2ZWxvcGVycw0KPiBhbmQgcHJvZHVjZSB0aGUgY29tbW9uIGJpbmRpbmcs
IHdoaWNoIHdpbGwgZml0IHRoZSByZXF1aXJlbWVudHMgb2YgYm90aA0KPiBmZWF0dXJlcw0KPiAN
Cj4gQWxzbywgSSB0aGluayB0aGF0IGJpbmRpbmcgY2FuIGFsc28gYmUgdXNlZCBmb3IgU1RNMzIg
RVRaUEMgYnVzDQo+IGNvbnRyb2xsZXIgZmVhdHVyZSwgcHJvcG9zZWQgaW4gdGhlIGZvbGxvd2lu
ZyB0aHJlYWQ6IFsyXS4NCj4gDQo+IExvb2tpbmcgZm9yd2FyZCBmb3IgeW91ciB0aG91Z2h0cyBh
bmQgaWRlYXMuDQo+IA0KPiBbMF0gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0
aW9uL2RlbjAwNTYvbGF0ZXN0DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAx
OTAzMTgxMDA2MDUuMjkxMjAtMS1iZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20vDQo+IFsyXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDA3MDExMzI1MjMuMzI1MzMtMS1iZW5qYW1pbi5n
YWlnbmFyZEBzdC5jb20vDQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyB2MSAtPiBWMjoNCj4gICAgIC0g
dXBkYXRlIHBhcmFtZXRlciBuYW1lLCBtYWRlIGl0IHhlbi1zcGVjaWZpYw0KPiAgICAgLSBhZGQg
eGVuIHZlbmRvciBiaW5kaW5ncw0KPiANCj4gQ2hhbmdlcyBWMiAtPiBWMzoNCj4gICAgIC0gdXBk
YXRlIHBhcmFtZXRlciBuYW1lLCBtYWtlIGl0IGdlbmVyaWMNCj4gICAgIC0gdXBkYXRlIHBhcmFt
ZXRlciBmb3JtYXQsIGFkZCBsaW5rIHRvIGNvbnRyb2xsZXINCj4gICAgIC0gZG8gbm90IGluY2x1
ZGUgeGVuIHZlbmRvciBiaW5kaW5ncyBhcyBhbHJlYWR5IHVwc3RyZWFtZWQNCj4gDQo+IENoYW5n
ZXMgVjMgLT4gVjQ6DQo+ICAgICAtIGludHJvZHVjZSBkb21haW4gY29udHJvbGxlciBwcm92aWRl
ci9jb25zdW1lciBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KPiAgICAgLSBtYWtpbmcgc2NtaSBub2Rl
IHRvIGFjdCBhcyBkb21haW4gY29udHJvbGxlciBwcm92aWRlciB3aGVuIHRoZQ0KPiAgICAgICBk
ZXZpY2UgcGVybWlzc2lvbnMgc2hvdWxkIGJlIGNvbmZpZ3VyZWQNCj4gDQo+IENoYW5nZXMgVjQg
LT4gVjU6DQo+ICAgICAtIHJlbmFtZSBkb21haW4tY29udHJvbGxlciB0byBmZWF0dXJlLWRvbWFp
bi1jb250cm9sbGVyDQo+ICAgICAtIGZlYXR1cmUtZG9tYWlucyBmb3JtYXQgZml4ZXMNCj4gDQo+
IENoYW5nZXMgVjUgLT4gVjY6DQo+ICAgICAtIGZvcm1hdHRpbmcgZml4ZXMNCj4gDQo+IE9sZWtz
aWkgTW9pc2llaWV2ICgyKToNCj4gICAgZHQtYmluZGluZ3M6IFVwZGF0ZSBzY21pIG5vZGUgZGVz
Y3JpcHRpb24NCj4gICAgZHQtYmluZGluZ3M6IERvY3VtZW50IGNvbW1vbiBkZXZpY2UgY29udHJv
bGxlciBiaW5kaW5ncw0KPiANCj4gICAuLi4vZmVhdHVyZS1kb21haW4tY29udHJvbGxlci55YW1s
ICAgICAgICAgICAgfCA4NCArKysrKysrKysrKysrKysrKysrDQo+ICAgLi4uL2JpbmRpbmdzL2Zp
cm13YXJlL2FybSxzY21pLnlhbWwgICAgICAgICAgIHwgMjggKysrKysrKw0KPiAgIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmVhdHVyZS1jb250cm9sbGVycy9mZWF0dXJl
LWRvbWFpbi1jb250cm9sbGVyLnlhbWwNCj4g
