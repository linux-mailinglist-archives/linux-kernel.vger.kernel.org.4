Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB95F795F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJGOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJGOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:01:46 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32ECF183
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:01:45 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297C3MBd025463;
        Fri, 7 Oct 2022 14:00:39 GMT
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3k20nb4anx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 14:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFivTvUKWHqpavf7j1zPUPqkhbO0qX+rqnB/JUy6Wh8qNgZOd0TP0Aj4DfXNsHYEvqdf49Mbm6S1tt5qTzAOMrzcvWPv4VW6SQxBPpTHeB49T3MAzA+0RpHykbxDhdtjZYZLdb1ThLbcfPdzwm6DCxSd/xVlQntLcpwIE/9blSNazQNDzOa95744Fv0rOXXgBkySdiUAr1LEUq9K3mwt4GwNk+N561Lz6665nM709BOFs4BKGWMmWiZk1rvX01/qlpIn2XtTBmJ5mUBAaCROrvTgnKwdsHw1kRNbIElQ/GlQHK3Ec0aCrr2UrTFpLmsvEzS36fqQqLQwokDvza6TIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ags55PeKbSsqNlzYypdKeg9SP0GNzJO8cTuoFQ5Jz3E=;
 b=T7lrcQqshKqsbhXEtG4nE8u8H6V8OeaJ3bKJasUPa5wuXliYHcu7vBaTRmNkCEU5otr36+MTzn2s7KmPgQG7ao7+mS9MRCvWFKZU97noQ9V4IxMudQPMwXfA9MjsUfPsh5SBBdgrM9f1C0vC/9yXGQLtBnSM98hM1cz9ceWgHHlWpLdliMuJW1vXoFcMCzQWXaba+U/gcZ6f610U7pvl6XMVoPgYX4i1ekhhES9aox+nWRbJ58uRqHLseRiStR4FUjE700Lt7m44c2UJbSxiRCrG7A9pbHiK2pxTHdy5slyzJZpx464xLmg03Rw8PMrRd0uKUn1AuotcB6LxDXfrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ags55PeKbSsqNlzYypdKeg9SP0GNzJO8cTuoFQ5Jz3E=;
 b=KgeAQ0FAy2KQC/AdCNQT3tRnyTbl3y9T+EgG4KXuSTfkrG4zMavReVQaW1The9/OYKubhZvMqNCpmFNS4wdS5Co/vIwSnsLAHfJpv/dWmEALubeTjkkYsvKwLom+h/xeOHcYdkD9w4homEyW2gq7yCYCqcPHqGFLIfr3qBjrff9ZwRGguftCDABhZBVchCqenG9EL/UAjkL56VymkCAQL738Kk/XmO0IJsLfhuCMSvJfZZZ4OMunqjgFeOiYPmhJAkcI7DELHZQ4nsI5EAvfFgDm+UjtlXutdbbscaPuAvq49iRU8iQQrX4oo1hufmrmDI3hW5xzPx96bbw72Y8jfA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by DB9PR03MB7386.eurprd03.prod.outlook.com (2603:10a6:10:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 14:00:35 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 14:00:35 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 3/3] xen/virtio: enable grant based virtio on x86
Thread-Topic: [PATCH v2 3/3] xen/virtio: enable grant based virtio on x86
Thread-Index: AQHY2hfsYkIZ8bm8YEiah662d3CFb64C9ieA
Date:   Fri, 7 Oct 2022 14:00:35 +0000
Message-ID: <67c9ec7d-a67d-ca28-4354-68e38aa27e13@epam.com>
References: <20221007064143.10049-1-jgross@suse.com>
 <20221007064143.10049-4-jgross@suse.com>
In-Reply-To: <20221007064143.10049-4-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|DB9PR03MB7386:EE_
x-ms-office365-filtering-correlation-id: fd3cf473-7856-4072-15dc-08daa86c4e9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOmahMLWpEB/f3fv1bgVVZhnrk2/ZNPjbkTZmKmmEJSULFq0rQoOA6sJ414inwYRhoRxDEkzEbiYUJGHmHjf/WmYpMvAq2tRh0kqDQffTjfZW+boVXrIS9kwf4Bz0CRhGzcl4klZK73z6Gp2V92fdogEqqiSniHw5YANAQzoNlp0x2m3Sx+3VMaHwetdjvvz2X+8JvNVLzvdHnGrVHFiHKIceOURX/FA8AG5yapgfnk0MMTlcXua6uaKCESPcc0yZ7uvST1ziXTGx63Y6xJTuqaU80ihooP0gIw8ZbdS9j8w1Lo2SZeqCV7dmgPsdUA76ZJskoeAazDp42BpdJJOIue2wFCoYzatYwktkg6vV5El0x2Pltih2S01kVFeggKkrseg0ZSAztEEXzA3IoCJ9TXOg3LDhZSYFDKPhI1gGtz+JCoSNjttdJ/ujrjMM0Mxf3Dv4oNRrWVlU/QCxbhVzMHHD4MKt8CX9IQyjp3aMGselbDSNuC9hX9zexGGoZ8IQ7l9FAz7bT4oXjNtLjoysq4iorD7d8qtYGPoUFU2OcmPMF6GYJLnV4RDsXqrPS429WJ0vp+pslQCS8Ya4vkBBfVMVAcW+tDF44Wg8zOwqZlK6r4CSrnKpXcUkFr3zBoDjRbLb8UGkKEneD8yqJE9mQE80qkmkOtoZZGmuuCA8qgzyH+AcNKFqr0f0gEyvs+inGIeahYDUE4xNmINFLm/G3hNlI16eG6LIIWKKXX2yMLEZZiofyUNlAmnpPiJc2SoYanQqM05JGuvP2Wh4Etjb73X7bJwO9Bd5k9lDNM/eiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(38070700005)(4326008)(478600001)(122000001)(66446008)(91956017)(316002)(186003)(8676002)(38100700002)(76116006)(6486002)(64756008)(6506007)(66556008)(66476007)(66946007)(53546011)(55236004)(31696002)(36756003)(6512007)(2616005)(110136005)(86362001)(71200400001)(83380400001)(31686004)(8936002)(54906003)(5660300002)(26005)(41300700001)(7416002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjY4VWR1M2J2ek1IMUtRa0lpUkxjdDBTK3hhUnB1aWRCYlBXUVFCVWg2RHJU?=
 =?utf-8?B?NFVxSGthaEtkeWJkcnRqUXJ6MkZBKzJ5dVNLdEYwdCtuMlA0eDR1amV4bitH?=
 =?utf-8?B?MndCbEZJbkZRV1JiQ1M4cFprQVFjVlROcHNYUUloYzBBdHpxL05DZVNuTFda?=
 =?utf-8?B?QzgxdnNkQnMzbi84NitNMXRGdWRmWFdEdER1ZDZMMmtzZ0tIcVVnL1lRd0ZL?=
 =?utf-8?B?L3ExanRzV0c5YnlqNk52K3hFYjliYjV2NW53OHlGZjErNXdabnBsNU9UWjhS?=
 =?utf-8?B?elMwM2Q5ZG1mZm9zYzVTMThuOTRkU3k0WnhneWw0NGcrSDU2aVRmSWNja3lz?=
 =?utf-8?B?emppKzZxWS91cEdNWWl4QXRyaWdaaTJDdkZlTkZsOE5tVFJKRmpLS05aTjUx?=
 =?utf-8?B?UFo4TXd0dnJCUFk0SlpDelJVVklQazV2dm9Dek12Mmwzb2hYOXNMQk9GQnNZ?=
 =?utf-8?B?M3EyYVRhRzFLdHZVS2hHaGx6Sld2alY4U2p1eEk1aWRKQlZlU2w1Tk5vWElC?=
 =?utf-8?B?dG13SmtFSGd3VHNYQ1lHUiswNEN2ZytDYmlVbzAvVENGRzg1OXUwVXAvS2o0?=
 =?utf-8?B?RzF1UVBKclBYcFc0SklRdjVDV0Q1MklPOXdlbURHSDJtZVB2eXRGYkZYeEZP?=
 =?utf-8?B?dzZVNGQrQ0VXMnZZZHRCY0F5OWVUbzVyQW1WenVPNFc2eHZ2NkRjMTJ5ekFU?=
 =?utf-8?B?aTFWUjNsSXlLQUM3Um00aTdqeFZuTEZacWw4SU1tdVFGcTIyNmlzazRQam8v?=
 =?utf-8?B?dmpZSXZVSzB3bXU5M0lwNXAwSUVKY1dRbk9wV3N0VE9iTTEvQ3hXaytNZnZL?=
 =?utf-8?B?cTRoc0VicENzb2JpR1RNN0o0WEtDb2kvR29jbHgycVkzTWkyUFMwVjlpQll3?=
 =?utf-8?B?SGpOSklZWVpYdEhISklZL3E4MnFPbkQwWEV3Rzc3Z2dBUG1aMW5iU05mM0NE?=
 =?utf-8?B?YkhhTjB2cjl4ajZHLytNcnF0Q0cwc0pDMjg3S0RxcWNJaWRZbWpMaU8zZmRT?=
 =?utf-8?B?UUNoY2RCN29vQW5FV0h3dkdHcisxNTZZSHRJK2FwZUUva250ZkNHTWlpTmp2?=
 =?utf-8?B?RVRCN210Ylk2YkdDQkVKcmpiMENsVzk2STJyVUIzUGJ5eU9reHdOTHA2NTJF?=
 =?utf-8?B?SlJJUXFoTjdjSVU3QlZWMUpudzJ1THpmdFRDTUtYYXY0ZmZaZ2ZUb1AxL0ZH?=
 =?utf-8?B?d2VKN21FQXZLYUhOVnRxdUZnNWZ3Zm5xUmhoTFhPZkw2ZlRqT2UxYjQ2Tndi?=
 =?utf-8?B?dVdTdWhjY3hpRkh4aDNWOE84REEwL2VHUkE3L1FZZTRFYzlvd2NWV1VoOE94?=
 =?utf-8?B?NEU4eG03WXU1Tkc5K2FBbzhnVDhKY2thOU9ZYzlKT1Q1T3JPYWF3M3BVWUhw?=
 =?utf-8?B?SlpqSDZVVkhXdVM0UG82aURGWmZsYUpWaE1QODFMTWpkMllhUkFIa3MrOTVq?=
 =?utf-8?B?MkQ0UFlrcnR6UTI0RXY4SE9lMmU4OGtFbWx1N1VmMkFaMU9GSFVqc2s0U3NQ?=
 =?utf-8?B?UzRjdkRFWGl5dk1KU3dPVWRSTHJPR3JCT3NnRVZzeFNXdzJXelBYTG5xQ0w0?=
 =?utf-8?B?VXJRVEE2MlNLeVJ2VCtZZ1BRbTJ4aExGamJsdFV3NExiM3lpOGJ3YjVxNVZa?=
 =?utf-8?B?TVNFUXZSVG9nYVE1Y0xsOVJ5ZXN1S05MTFVxZjU4VkFDUVRQN3hXRy9iZHhB?=
 =?utf-8?B?SFpkbjNqS3Jtc3VwRHVETzJWWXNicVA0b2NFemdXYWpuRUhuOHhDU0oxSk0r?=
 =?utf-8?B?dy94VElsOUpSSUVKZDNyUEJLa1JoTWY4VTJMVnkwdVNFTkdMSmpnTTlhM3Zw?=
 =?utf-8?B?K2dmZmhvRWF1MDJ2K1RSQ0NQK3FZNmFJQUZQSkdCNE9MNkFNcWxBME9sUVdj?=
 =?utf-8?B?bEMySHhQS1dkRlVvdVdoSS8vWk5uYmp4M2wrZEIrcVlQTTNJUzcvOWZOM0tn?=
 =?utf-8?B?RlhYZ1EwbVQ4RStpL1c5S0JhSlA1MlBqT256TkY2cFVKVmovWlRVTUx4YVZC?=
 =?utf-8?B?Y2xxTjdaR1phanBGUEN6NmxRYTZZN3prZ2YvVTRVdkZzZjdvK2s4MWh5REdE?=
 =?utf-8?B?bkhDbllHMXg0WmlEYjUwZ0JSRFlqd2pQMTVXU0xEa0VSODd4c21Samh4Y3Za?=
 =?utf-8?B?RDdHWHJKWUNSUXhvMmFXdCtsbnc0R29uVFc2L2pIdWlRWXZvT2ZZMmNqQUdS?=
 =?utf-8?Q?VScg2nC91d485m0db2Vim1w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <179546D82EEDFE43A30ADD7CEF10892C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3cf473-7856-4072-15dc-08daa86c4e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 14:00:35.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXuw4QY6RBOcJrykcB4bMI9R6O5xCxotnGXkfGUPzYKt592BlO9B8oamTMlKEoOSjxxxEFlMANyS6LK/PRojeyrTvcDKvJKnqHQJLYQ+LOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7386
X-Proofpoint-ORIG-GUID: FdgSj0ecZl9EDy2LzbyinQOvrftmdvjm
X-Proofpoint-GUID: FdgSj0ecZl9EDy2LzbyinQOvrftmdvjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNy4xMC4yMiAwOTo0MSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCg0KSGVsbG8gSnVlcmdl
bg0KDQo+IFVzZSBhbiB4ODYtc3BlY2lmaWMgdmlydGlvX2NoZWNrX21lbV9hY2NfY2IoKSBmb3Ig
WGVuIGluIG9yZGVyIHRvIHNldHVwDQo+IHRoZSBjb3JyZWN0IERNQSBvcHMuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gLS0tDQo+IFYyOg0K
PiAtIGFkZCBtaXNzaW5nIFBWIGNoZWNrIGluIHhlbl92aXJ0aW9fbWVtX2FjYygpIChPbGVrc2Fu
ZHIgVHlzaGNoZW5rbykNCj4gLSBhZGQgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2MoKSBz
dHViIChPbGVrc2FuZHIgVHlzaGNoZW5rbykNCg0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5
c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPiAjIA0KY29tbW9uIGNvZGUN
Cg0KDQo+IC0tLQ0KPiAgIGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMgfCAgMiArLQ0KPiAg
IGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyAgfCAgMiArLQ0KPiAgIGRyaXZlcnMveGVuL2dy
YW50LWRtYS1vcHMuYyAgfCAxMiArKysrKysrKysrKy0NCj4gICBpbmNsdWRlL3hlbi94ZW4tb3Bz
LmggICAgICAgIHwgIDYgKysrKysrDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGln
aHRlbl9odm0uYyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5faHZtLmMNCj4gaW5kZXggMWMxYWM0
MTg0ODRiLi5jMWNkMjhlOTE1YTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0
ZW5faHZtLmMNCj4gKysrIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9odm0uYw0KPiBAQCAtMjEy
LDcgKzIxMiw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB4ZW5faHZtX2d1ZXN0X2luaXQodm9pZCkN
Cj4gICAJCXJldHVybjsNCj4gICANCj4gICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJU
SU9fRk9SQ0VfR1JBTlQpKQ0KPiAtCQl2aXJ0aW9fc2V0X21lbV9hY2NfY2IodmlydGlvX3JlcXVp
cmVfcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gKwkJdmlydGlvX3NldF9tZW1fYWNjX2NiKHhlbl92
aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gICANCj4gICAJaW5pdF9odm1fcHZfaW5mbygp
Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jIGIvYXJj
aC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+IGluZGV4IDliMWE1OGRkYTkzNS4uNDViMjRjMWI2
NDZhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMNCj4gKysrIGIv
YXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jDQo+IEBAIC0xMTIsNyArMTEyLDcgQEAgc3RhdGlj
IHZvaWQgX19pbml0IHhlbl9wdl9pbml0X3BsYXRmb3JtKHZvaWQpDQo+ICAgew0KPiAgIAkvKiBQ
ViBndWVzdHMgY2FuJ3Qgb3BlcmF0ZSB2aXJ0aW8gZGV2aWNlcyB3aXRob3V0IGdyYW50cy4gKi8N
Cj4gICAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU8pKQ0KPiAtCQl2aXJ0aW9fc2V0
X21lbV9hY2NfY2IodmlydGlvX3JlcXVpcmVfcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gKwkJdmly
dGlvX3NldF9tZW1fYWNjX2NiKHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKTsNCj4gICAN
Cj4gICAJcG9wdWxhdGVfZXh0cmFfcHRlKGZpeF90b192aXJ0KEZJWF9QQVJBVklSVF9CT09UTUFQ
KSk7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgYi9k
cml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gaW5kZXggYzcwM2I3N2IzM2M5Li42M2MzZjBk
YWMwNjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiArKysg
Yi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gQEAgLTI5Nyw3ICsyOTcsNyBAQCBib29s
IHhlbl9pc19ncmFudF9kbWFfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICANCj4gICBi
b29sIHhlbl92aXJ0aW9fbWVtX2FjYyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQ0KPiAgIHsN
Cj4gLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCkpDQo+ICsJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpIHx8IHhlbl9wdl9k
b21haW4oKSkNCj4gICAJCXJldHVybiB0cnVlOw0KPiAgIA0KPiAgIAlyZXR1cm4geGVuX2lzX2dy
YW50X2RtYV9kZXZpY2UoZGV2LT5kZXYucGFyZW50KTsNCj4gQEAgLTM3Miw2ICszNzIsMTYgQEAg
dm9pZCB4ZW5fZ3JhbnRfc2V0dXBfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCWRl
dl9lcnIoZGV2LCAiQ2Fubm90IHNldCB1cCBYZW4gZ3JhbnQgRE1BIG9wcywgcmV0YWluIHBsYXRm
b3JtIERNQSBvcHNcbiIpOw0KPiAgIH0NCj4gICANCj4gK2Jvb2wgeGVuX3ZpcnRpb19yZXN0cmlj
dGVkX21lbV9hY2Moc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldikNCj4gK3sNCj4gKwlib29sIHJl
dCA9IHhlbl92aXJ0aW9fbWVtX2FjYyhkZXYpOw0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJeGVu
X2dyYW50X3NldHVwX2RtYV9vcHMoZGV2LT5kZXYucGFyZW50KTsNCj4gKw0KPiArCXJldHVybiBy
ZXQ7DQo+ICt9DQo+ICsNCj4gICBNT0RVTEVfREVTQ1JJUFRJT04oIlhlbiBncmFudCBETUEtbWFw
cGluZyBsYXllciIpOw0KPiAgIE1PRFVMRV9BVVRIT1IoIkp1ZXJnZW4gR3Jvc3MgPGpncm9zc0Bz
dXNlLmNvbT4iKTsNCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3hlbi94ZW4tb3BzLmggYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gaW5kZXggZGFl
MGYzNTBjNjc4Li5hMzRmNDI3MWEyZTkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUveGVuL3hlbi1v
cHMuaA0KPiArKysgYi9pbmNsdWRlL3hlbi94ZW4tb3BzLmgNCj4gQEAgLTIxOSw2ICsyMTksNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgeGVuX3ByZWVtcHRpYmxlX2hjYWxsX2VuZCh2b2lkKSB7IH0N
Cj4gICB2b2lkIHhlbl9ncmFudF9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+
ICAgYm9vbCB4ZW5faXNfZ3JhbnRfZG1hX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
IGJvb2wgeGVuX3ZpcnRpb19tZW1fYWNjKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOw0KPiAr
Ym9vbCB4ZW5fdmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2FjYyhzdHJ1Y3QgdmlydGlvX2RldmljZSAq
ZGV2KTsNCj4gICAjZWxzZQ0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fZ3JhbnRfc2V0dXBf
ZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgew0KPiBAQCAtMjM0LDYgKzIzNSwxMSBA
QCBzdGF0aWMgaW5saW5lIGJvb2wgeGVuX3ZpcnRpb19tZW1fYWNjKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICpkZXYpDQo+ICAgew0KPiAgIAlyZXR1cm4gZmFsc2U7DQo+ICAgfQ0KPiArDQo+ICtzdGF0
aWMgaW5saW5lIGJvb2wgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2Moc3RydWN0IHZpcnRp
b19kZXZpY2UgKmRldikNCj4gK3sNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICAgI2VuZGlm
IC8qIENPTkZJR19YRU5fR1JBTlRfRE1BX09QUyAqLw0KPiAgIA0KPiAgICNlbmRpZiAvKiBJTkNM
VURFX1hFTl9PUFNfSCAqLw0KDQotLSANClJlZ2FyZHMsDQoNCk9sZWtzYW5kciBUeXNoY2hlbmtv
DQo=
