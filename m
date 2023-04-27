Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13D6F0191
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbjD0HV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbjD0HVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:21:13 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71FA4225;
        Thu, 27 Apr 2023 00:20:40 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 33R48spq028208;
        Thu, 27 Apr 2023 07:19:35 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3q7hry8e3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTEx7j5Wp34d+uf30XKThdDvpryT8f3OkysaJI36G2u4z3zir9nrpIvBAagpfPpm3E1EDXc02ZwMhEYmNZFYSkGmks7zN3GoJrdqVO0BDDMEs5e/vP1rNx4WX39DTSc1K3437KV4grhBFeZVpN7HameCCUAM4OvQx//OwUKiKseN0qfcdk6GADghgceHL6lF5OAgATZmRJNerelRut5ZYJH+pOsWwJ4ELHdeQy1iN188mTuU8QePPvGc4X7mxmQbEHR60uCUqpWI+90I9CqEuld9E+C8Zly6RkHWjs4ll/9soSnOANLHlHD0O3hTPOdF3Fo4i1zwvJzJyZsus68D3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GiCvNZLmFulu4NNhhKyp8Sy7gQx4ijnHVTbUUSBC7Y=;
 b=hrqkpJ8+Bk1HDSwm8wQXd7gmDCjiZNx2RNrNZvYHyZp+nkLgGhTRI/vlWUtXh67UfoOQgXG8X99f6M7RuwW1+1EBcfOzsH9MYD0giKtlGm41uJGCotUTpgebh2kQptsisA/vQKiTGxezVbessPTceyXMw++4MWMDzFq/PAaTyWpVdoQ4wr01ouo/jO5eJjegpAVooVnx89S5IoYS07w0XkERC3CrXReufEXR65zaqKJikNByQK39pNyjgejBRTnVO0PqyaMRL2yTic6PzVXnilFyelOI2ysz+9ow9hjTVAHRE8SYisclngz9znZLG2I6tVw91JXHbb3zWG/WNZV7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GiCvNZLmFulu4NNhhKyp8Sy7gQx4ijnHVTbUUSBC7Y=;
 b=JQHHE/Rik0kvRuhMFVRK9WiLs1+m/aUnAoSwHyXqHV2S0V1X5r2ybxfSc0yzSBWoeITigFm2WuaAwPTDEeDxfPXueoLsZcswFq5XhncNCKoTmlTeGhPZwtadZuTp1ys7YEa+fHMXGyTjwscK5mBT66obD13gZ9QqyeO61Q3vC4FvcrgzvfR0z6otLSil/fcYTC8E3ebvNqfgidw7SqktG70xZwDeTR3LnAnRo0c0Rxu1PsU1xjK+RqfmVM+Aq8d43bqaH+dsGJoTSifXO4jOezweDsF0XkIBo+bwUseseARlfVlflWGCTtVvydoG/kC5/+7/zzbcyL7TnKr7O69d5g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PR3PR03MB6683.eurprd03.prod.outlook.com (2603:10a6:102:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 07:19:32 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 07:19:32 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Michal Simek <michal.simek@amd.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Topic: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Thread-Index: AQHZeEK6qDUGtqz4K06E9chyDcKW7q8+vUsAgAADZ4A=
Date:   Thu, 27 Apr 2023 07:19:32 +0000
Message-ID: <bac79ffe-7859-e51f-c959-64b942c3e99b@epam.com>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
 <5bf0e975-d314-171f-b6a8-c1c1c7198cd3@amd.com>
In-Reply-To: <5bf0e975-d314-171f-b6a8-c1c1c7198cd3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PR3PR03MB6683:EE_
x-ms-office365-filtering-correlation-id: bbd7e6bd-eb98-4df9-70c3-08db46efbf29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+pN8M2gYX0GQ84xRT/b8J5vMZvAOhj79OZZyL/OfQOyhuoiQF9hm/8w1j8UN/0QAVZgyUcVb80qdnhSy8YuQr+gdch1rPApaqwZMW5ByFMYiU+coaYvGqmyFg975uVcdXZWttA4+nEqwWcp8qrI6hBohYiKH7Gb1E0MV6FJLjOl91ORI3j/H3sooWMcR59MNOEb7lLLrJJNQEznZbXcuEu/ilPwTxy2wclcmcDxLDj6mTFEATTExWnQ2nrQGB6w+Il/xN203VQYWTB0Lv/y+mIofnatvvHY2004jclMZwbZ+yX2rtvUZjH5QokkrNJr/nSELahW8w1qY+bc9eY3dE0Zjmt5+7M43MB6f3GVAzfgN/xQUFVjQN951YE4XpUAemvpWTd0dDViYJGAYC32YWN8cPRy9K5g3siyKyrjUfXHz0IHRZ/aQReW/f4RHCsNMpgqy/8rxY9NvvDMpT+JPyrtbYbcoaBluyOEqrNp5PCsLLgHKsLMdcqml6DK/eTYffU/UrG5U82WIP9/g1qmjvg/7roMq+5HgZB2FB2MVU/bgNqkqPxN00kxsmQqbSh1nW9HolARLMD1uKJCihOOQteZV3B0W7SKJKqBsNdL3zr9/r7ICQ6ICsEwb4AHwb/9bPlg17bSj4iPK3IiFtOHRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(6486002)(36756003)(71200400001)(2906002)(6506007)(186003)(53546011)(6512007)(26005)(54906003)(110136005)(2616005)(31686004)(478600001)(8676002)(316002)(86362001)(4326008)(41300700001)(5660300002)(38100700002)(122000001)(66556008)(66446008)(66476007)(8936002)(64756008)(91956017)(76116006)(66946007)(31696002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGg5V2NCaGJDTG1HRStXQ1h6ckFqYTU1UVhLbkVvL1ZUMFAvU2NTdWpPUUVk?=
 =?utf-8?B?ZWhnaytpR0VmcmVmeUgvSjF3ckllZjhNcVVGK2p1ZldoOHUvWE50MVhaaGhx?=
 =?utf-8?B?STR1K3pvOU5Uckh4OXNyMjhRY3RBUURjQi90VTdwS3VVSVNJdUxMRWJRUE5n?=
 =?utf-8?B?ZWh4V0lMOVB5bU8wM0FVK1hCbG05clArdUhpYkZ6SnY4TXcrRURuT2NuN01B?=
 =?utf-8?B?OHNaNmI5Z09mVjlvMXJjMitaTDMxd3dDVWt0RC9XaVV5OWlUaG10UmNGU2xm?=
 =?utf-8?B?Z1UrU3pVRHUrT3BubWRocjEvZ2NCVkw0NndNRUM4dld1T091TEdCNENJNFFJ?=
 =?utf-8?B?d2YxSGo3QnNsYlY3RjB1YnR0VE9YLzdTbFkyZjhBUWxOMWxxV1oxVUVacHN6?=
 =?utf-8?B?U2VlZDFBT0tXZWZzdjVsWFg0cUF6ZW1WNDBQZmpnZzJtUWhZSTZLY2J5ajBy?=
 =?utf-8?B?cmlOT1JrVEZNQmZVcnFCVEtUT2dVd1M2cXUrcjZlSFY4RTVhd3JQRUU2bmZH?=
 =?utf-8?B?R2loM0lTdHREQjJSMDVSUDV0T25mbXRBZiszd3ZGdHVKYnJJMU8rSGNDQ043?=
 =?utf-8?B?anRUS2lJODFObnJPSXJrNkVKZUdYbzBCNExreHZGZlNlV0xGOGJiRU92UUlj?=
 =?utf-8?B?K08rSU9OYkJ5K3NaV1dkRHpJdjBVSlh4NWZsL1hoL0dScWs3NXRsUFUzN1B1?=
 =?utf-8?B?RHcvVi9iSTg2SmJZOGxVeXVLUzRJL0c5ajlOMTdONC8rSEJjajl2TnhEeWdj?=
 =?utf-8?B?RFA0ZjBwaUg4cnZwMjVQQmx1elZrbVN2NEphUEU2dFppTXZ1MFFiMnpCUnZN?=
 =?utf-8?B?ZWJGR3RlcGhkWExkMzcwcXBwVFF4Um9lbml4dURTMjVkdlo2TFN6TklCaS8r?=
 =?utf-8?B?Z3JyYTUrUHJBRTNBT2szR2xucWltbWJpL2hGdlNhUjRVQkFsT0RoVU9vWDB0?=
 =?utf-8?B?UFpUUWRXQWUwS004QUl6SkY0cElRTUVNZEZndk9iRS93N0wvQ1pObWZsaGVa?=
 =?utf-8?B?Y09LYkhpMm5BRlRWZkU0NmNPdWl0UnBuY0gxaS9oV1V3dnBXZldLdGNMVmxh?=
 =?utf-8?B?M3A2bHVCaHpiZjZ5VFVodlk5RHpUZjFDWUxGc1NVNUZ4S2RBaCtHR0p0QXhv?=
 =?utf-8?B?SnVKZTNHcGNNRFBUSVBFdDdHdTc3RkYxK0FtMlEwWTlEZHNaNDlZc25PMWxQ?=
 =?utf-8?B?ZG1SenlkT0pLbzlSN1dLbGdHU0k5L0FpYytkaURyU09CbzF3b2xoazMxQlFJ?=
 =?utf-8?B?VEZXNTQrOXl4bnF5dVNVdENPNlVoNGNmWkF6Q05uTjJNYmsrTlN1SVJLTzJK?=
 =?utf-8?B?OGhUSlBIK3pLZ3huc3Q3K0dSSzlUR3BrTm5EQlUvRjZGZjBKSWJlTG1BRTJp?=
 =?utf-8?B?ekl6TmRPMUZqNVpEWDVWVkZnZEFvOStnUVNxKzU2OWRJTmc2VFh1MTZWMWZB?=
 =?utf-8?B?ejg0bjlYVUd0VXhlSDBRVGswK0NzY0VtT1dtTkRnVXVQUWZFZTZLaTVqYTBZ?=
 =?utf-8?B?NzFmYmQ5NlBwRzM5aWZOWXZXazROTFp0WFB1d3JGekt6MUlCeGZudzFUYVgv?=
 =?utf-8?B?K3M3WjRPOEN1a1Yva3JiQjZYUVJwS3MzblhValA1cHo3anF4Rk9Nck5KQmFw?=
 =?utf-8?B?dnZJbmVpT25hLytUNjBHSUMrb2VzOWl0anlCNXlBbksvbTVXd240RkJrSENP?=
 =?utf-8?B?dFdYMUl4bitxalpETCtJcUxtZGFzVTBvZDk0Y3cvdytJQllEMkxycWM3a3hX?=
 =?utf-8?B?aFBseHdtbVlYU2U3ZCs1cndXRU5QbnhGMGN5dzdWRm5zdnhIVEtFTjEySW9U?=
 =?utf-8?B?RllLK1g0bEVIbS8rMG5SRDRxRGNtQmk2aWdhZHJ4QU1QbHNJZkRhd1M4cWlB?=
 =?utf-8?B?czhyQkJkZE4rcjJxZFp4U2tMMUJkNWFEaCtQNS9ueDNVVmY5R0hoTTlsVW1V?=
 =?utf-8?B?RER2bTZzRGhaZVFxNFNPdTRSMGtsSXhQN3hBZTB6M21ia25uUERKWGNEdCt3?=
 =?utf-8?B?MVFOMDNDdCtNekgwZkdmZERtS2VUUUsrbnJFOEMrOXFabFM1R29BdEJ2SFNG?=
 =?utf-8?B?RS9mWUVYNENkSHpwWElFenZORUZETk9CZ1RTT2RiVThJTU5pQzVoK25LU1FO?=
 =?utf-8?B?YzZNdStsbG1EdWpkL0h4anlnSDZoZjBLZnl4VGZyOHJsdnU0TGpOY1dZMUFN?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0BF56B4D2782D44B3754C38DA2EED60@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd7e6bd-eb98-4df9-70c3-08db46efbf29
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 07:19:32.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2doB9+R0+mVFjx3JUhpBPeE7mg/Eihz4qV6JmkEQmEcvJ1rdQ/iKBMsSGeEbOQ5t/2laeiQuRz5TbHxfe8LAD9QP8sh+LAh6JtdLK2cIirE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6683
X-Proofpoint-ORIG-GUID: rlshG_4fLhVZAgiJ_ZVn769TbeXRlGay
X-Proofpoint-GUID: rlshG_4fLhVZAgiJ_ZVn769TbeXRlGay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI3LjA0LjIzIDEwOjA3LCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+IA0KPiANCj4gT24g
NC8yNi8yMyAxNToyNiwgT2xla3NpaSBNb2lzaWVpZXYgd3JvdGU6DQo+PiBBZGQgbmV3IFNDTUkg
djMuMiBwaW5jdHJsIHByb3RvY29sIGJpbmRpbmdzIGRlZmluaXRpb25zIGFuZCBleGFtcGxlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWkgTW9pc2llaWV2IDxvbGVrc2lpX21vaXNpZWll
dkBlcGFtLmNvbT4NCj4+IC0tLQ0KPj4gwqAgLi4uL2JpbmRpbmdzL2Zpcm13YXJlL2FybSxzY21p
LnlhbWzCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDc3ICsrKysrKysrKysrKysrKysrKysNCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS9hcm0sc2NtaS55YW1sIA0K
Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvYXJtLHNjbWku
eWFtbA0KPj4gaW5kZXggMmY3YzUxYzc1ZTg1Li40MWJhNWI4ZDgxNTEgMTAwNjQ0DQo+PiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUvYXJtLHNjbWkueWFt
bA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zpcm13YXJlL2Fy
bSxzY21pLnlhbWwNCj4+IEBAIC0yMTIsNiArMjEyLDYzIEBAIHByb3BlcnRpZXM6DQo+PiDCoMKg
wqDCoMKgwqDCoCByZWc6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Q6IDB4MTgNCj4+ICvC
oCBwcm90b2NvbEAxOToNCj4+ICvCoMKgwqAgJHJlZjogJyMvJGRlZnMvcHJvdG9jb2wtbm9kZScN
Cj4+ICsNCj4+ICvCoMKgwqAgcHJvcGVydGllczoNCj4+ICvCoMKgwqDCoMKgIHJlZzoNCj4+ICvC
oMKgwqDCoMKgwqDCoCBjb25zdDogMHgxOQ0KPj4gKw0KPj4gK8KgwqDCoMKgwqAgJyNwaW5jdHJs
LWNlbGxzJzoNCj4+ICvCoMKgwqDCoMKgwqDCoCBjb25zdDogMA0KPj4gKw0KPiANCj4gQXMgSSBz
YWlkLiBwaW5jdHJsIGhhcyBhbHNvIGdwaW8gcGFydCBhbmQgYmFzZWQgb24gZGlzY3Vzc2lvbiB3
aXRoIFNDTUkgDQo+IGd1eXMgdGhpcyBwcm90b2NvbCBjYW4gYmUgYWxzbyB1c2VkIGZvciBzaW1w
bGUgZ3Bpby4gVGhhdCdzIHdoeSBoZXJlIA0KPiBzaG91bGQgYmUgYWxzbyBsaXN0ZWQgI2dwaW8t
Y2VsbHMgdG8gYmUgYWJsZSB0byB1c2UgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gQW5kIGZv
ciBjb21wbGV0ZSBpbXBsZW1lbnRhdGlvbiBpdCBzaG91bGQgYmUgYWxzbyBhZGRlZCB0byBkcml2
ZXIgaXQgYnV0IA0KPiBvZiBjb3Vyc2UgdGhpcyBjYW4gYmUgYWRkZWQgbGF0ZXIgYnkgc2VwYXJh
dGUgcGF0Y2guDQo+IA0KPiBUaGFua3MsDQo+IE1pY2hhbA0KPiANCg0KSGkgTWljaGFsLA0KDQpU
aGUgcGxhbiBpcyB0byBhZGQgZ3BpbyBzdXBwb3J0IGFzIHRoZSBzZXBhcmF0ZSBwYXRjaCBvbiB0
b3Agb2YgdGhpcyANCnBhdGNoIHNlcmllcy4NCg0KT2xla3NpaS4=
