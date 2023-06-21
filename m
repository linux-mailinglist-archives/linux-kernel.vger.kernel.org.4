Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F66738DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFUR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFUR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:59:24 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026A1739
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:59:00 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LH2m6i003245;
        Wed, 21 Jun 2023 17:58:27 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rby2xab6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 17:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRUkiU/MbKXYhsENFn98NKUpYNBxZxF+dzKgd9wS0iyp5VRwzUGOwfw9szAJX4Z0a+Dm6OjGrvm5BNq2eElbwO0wJdpwL8xBhHOWKc2OgDrOOQXOG4MlwGLyNFlfIrb/Xgd1jKVTPC5oGx3zWwIk30CJiF7LvGbumrhSgwN/OcNSBa7CpEmiDYKV56iTHecuoxj3FewvIKRK9pomP8QxTnlE7SI2X2annsqsmD8DkRkdsL8qitEAnNLCxyhJxDn0xGD6CGkTyJ5y2VxN74+ZqotaYKQugBUOx+fJMOmQU20iJgBbuPI3LIhQ4Vts2ObChbGa9CQrxGrsUX4FxD0XOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksdhZVX1lhsy6HEKQH1gkC3rfFD5Y/h4oL0FgzSDIPU=;
 b=EDJbp5k46cUmm/AZncb0pp0UiYgURd7nNeyc1R68OeoRVuYa9oQddnxgaBvNqwgvbK17QO+/F3+aWsgQA81MMxAFSqipcp6728AbPKh9KC9XnVrB1X9K8CKQkHj0IiNAvssesas8hlbq2MUri5ZmfrFabNavDu0xMxjtWOhOzsxTNEXbgjahpdWOwyoVgTehEKFGvoWFDqbm89+8eB9YL2LrIAZBruJeDzhcFA6oSDv89hJNpQ//tOL59naljlVkvg/YPFnGb5vkQP3fuQj3k5+OreP3f1gWyKvs7rv6tabhyIBt7ZjgoTwrdMD9EJsLM+Ln6dlErKNyofzoS5sEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksdhZVX1lhsy6HEKQH1gkC3rfFD5Y/h4oL0FgzSDIPU=;
 b=HTqGmMMgDLqL+cg9LNxX3m8Oxk+3PerdC3nPHJ8kcF6C0l0CqgeoN7pNR71BGKjNcRQsdN3u4aWmJ7+7zhi5vmBAmzJhdXfsB1fAI6UIiKmjeW2CDDha4nOQq5Uwi0cizbgNbBg5OzNWopOW5DN0xYDh2BMLboqo1Af4OFkeHXHBvZd5wfdbEh0SZ91qXGwOyy66maSOepbwAZdMmj1OEJ5UoIPjd7O/bOq0F401SM9bTO3wqb4tjsLb4OU6iEHE3BMKqm5iuFyw0zFV0sXQ9wLusbMH9CEhq6IEUAIhQqyJWMA8k4Tv09ti2dg559Hni1tWfgkt+6d6nQl0eIISAQ==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB6690.eurprd03.prod.outlook.com (2603:10a6:20b:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:58:21 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:58:21 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Thread-Topic: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Thread-Index: AQHZpEL/jQILjif4TEa2QZqecjVVUK+Vi2cA
Date:   Wed, 21 Jun 2023 17:58:20 +0000
Message-ID: <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
In-Reply-To: <20230621131214.9398-3-petr.pavlu@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB6690:EE_
x-ms-office365-filtering-correlation-id: d5e2ead4-a9eb-4a12-152f-08db728119aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xar95FYntu0xD6rX1wdZTWbHF8Lrd/VCmg8FqZNH64JvbrNWSnmGb2RwvUOCowo7IXD4LNMrlnOywjAzqxoXEz/Qaz3ET77peRvWzGIQqrWprI3gU3h9y6PvX6HJlGoVYdutVOkEr/YkyTTWHECP+l6WUQjd1Fk39KZSJo0ZdpqdrvfNVe9sNxkk1Pb2pl6qVxELHDPOGJGc6bIsLG+fGVASnVLT2PccaTJXcBs26E9C6ScR7qx8vM6j68R9NosUyn4gHBbWpPuW8e+GZIXFUvrtsNM7CCQWFOm1qfWXjYOPAoqvhciAs7/wYaMQFSOtfW9xMOnEoDElA3XYnF29OSDlkL2jwvHRvr7/UiCbYlnzAIWLyh5o3V8JdThcWpnv2ymYdUZKAF1rkLgqarOqTNEbeiZ47rGaRhTrDL4WSqd57+Q4ao3RlPoguPHn+9z5JE8/a4qxmvhKI9leYDb9gHeewD501qGmDrLcXtw5lZ+6VZb1qpKkKueKyCq8pPBv0wWZfq8xyso2xsY4bk0mGtVPt1qcsTRV8y7HJOKsZuEnamcdfnG0LvcS55v09StwEswLGubGkpLpFJNFhXvPGP/QacHL6Dj6eNRJzcn0UhlXcVfrwMJuo2aMWvaj4WOhRZdbOYVuJgQwiIRQA0dVTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(31686004)(2906002)(71200400001)(8676002)(41300700001)(5660300002)(8936002)(316002)(66446008)(64756008)(6916009)(66476007)(66556008)(66946007)(76116006)(91956017)(54906003)(6486002)(478600001)(38070700005)(86362001)(38100700002)(53546011)(122000001)(36756003)(4326008)(2616005)(186003)(6512007)(31696002)(83380400001)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0tqU0I3UUVDZlFOcTF4aEFmdU5UUUoxMmZmNml0K1FyUmhQSllkdzVtM1h1?=
 =?utf-8?B?alo5d3JDTkVRN0FONHNkdFZmMTM4Sll2WWJFdVFqMS9kV2o5Mk1QTFNFNWZv?=
 =?utf-8?B?b1Axem5qa1NJYVN3L244NnRQZzVxYm5yY3hCb1orQTMrdytvRGtuWm10QmpZ?=
 =?utf-8?B?VWdLbHd4bEpyY09ETjh6Q1ZzN3JoMmVZR21MelVBVTcxOUlycDhNamFMaWhX?=
 =?utf-8?B?aDBjZnByZm5nMG1tQ3dpK1B1SnFSUldiZStmdGFqOWFYejZ6WERYMFpSU3FT?=
 =?utf-8?B?SThBblBseXRBOHpnNDRnL0c2c1ZCR01jWXBOeTdjYnNxTXZjdklDaU9xY0Ri?=
 =?utf-8?B?RzhZSzU4UWZITnprMWRqdFUySXVXd1dDY0NES1dkS2NpcjR2L1Q2NWUzOHp0?=
 =?utf-8?B?cDFoYjJsNGg3ME5JakhCNnI4Mk1ibHBaMWU3SEQyMnVVWmIrOVJDc3FqL1BJ?=
 =?utf-8?B?Y1Q0aVk0cXRUMUdnSjIzc1pZVXloa28vSnN3eEQ1YUpaank3aVNWL3IxaUhr?=
 =?utf-8?B?cS9DK1dKWkxQRU9KWW5UeVZXLzdINk9xZkxWNll5OGUvUVhWM0lyNVU0U21j?=
 =?utf-8?B?TXg5YlF2Z0FhQVRpWVc3anNPbjJkYWlmQzkzT1ZpbVowWDNtQ1MzMFpxWHVR?=
 =?utf-8?B?L2RTNEhCZXMwUVJDWTN2YVM1S2hwRStZZWdQa2RwTk8yZmlpcFBFL0NEMHNJ?=
 =?utf-8?B?SFZNZ29IMlorM1k3OHl6dStaWXVqRm9wL1JaNExPVDllYUcvUmVvZDRKWnVu?=
 =?utf-8?B?MTRGVGZQamx0R2ZsWjBheDh4aExTQ0hvclpEaVcwWFZSTHQ3bVpFZGZGNUNz?=
 =?utf-8?B?ZjByUlFwM2NqZ2kyRXgycjRTQ0xnOXo1Y0lpVVBBNlFucHlnRlFCYmxhK2I2?=
 =?utf-8?B?OHlud0J0elRGc1RhR0dXUGUxbWtJQmRscDVZWTBMMjVUZjRPbWFxczRWQXhP?=
 =?utf-8?B?c01PMlpjTnMrbGQ0dDkzOFVOdldSL2JBM0FuaFVWajVhTXN4QmNtRHhMTjkw?=
 =?utf-8?B?SVVuMjB1c2hDTzZoalQxNENsSEJZazZ1bDNlZ2tGMjhuUmFEYmRFNzE5UW5t?=
 =?utf-8?B?bnJwakE4T096THFkWHhLNnFZa290T0RMV1pzQ3pXRmdJRnJpd0crc0VRMzRG?=
 =?utf-8?B?c3g5ZzQ4bUpwbHcveWNiSVAwdEZaY0lwN2dZU1BTTzB2SzNVUjl0ZTI2REZn?=
 =?utf-8?B?MFFOQ2ErazMyLzhublQ3RVdWc3Q5YjhaaUVPMWFrQnYrSVZWUkFPaFhXdnFx?=
 =?utf-8?B?c05XdmpqeHFzU0FYV2RoQ2ZNRk9kRFJSTG5ETk9qcGdQWkQycnVMRlpQUE5q?=
 =?utf-8?B?c2ovNnNiSkM2OVpGWVQ4U21zRStaZUF5ZU5YR3lMNjlrTEhiL2tBcGFJakVO?=
 =?utf-8?B?MU5EeUtKUjR6ZjJyUW5HWVpHWFBMK1BUZEwwTEkvRk1DeGdFQVh3Qk4xR0hU?=
 =?utf-8?B?emhnWnJQWWVtV2Evc3EvOXVhZWl4WDJlWTlsMy9iMm1NYW9BVmlNTlliTENo?=
 =?utf-8?B?MmNzbzlZaFJYNTdNNkUxZkhhZ2szZmt5ZTMvWlhaS1d4U1pkMkdWVVhkSkpT?=
 =?utf-8?B?Skw3dFlFbGUweXdBbDgyei81WGxhTi9zVTZTNmhUTFVJbEVFRXhRWlNPWkRz?=
 =?utf-8?B?T2JoUzN1YmtLWVh0VzhJSVZqWmpQaWYrbzJTbUx4TytXTXVaaW1WWEdXN08y?=
 =?utf-8?B?OUpJN3VQa2RPZmlIeWlPajcvRkdTMUVkT3hiT1BzcS9kMkUxMnFTTzluM05Z?=
 =?utf-8?B?S3YrVzBmSXJyQVF2UWJWTmhqWXhTQ3VyaXhoNzlUdjVuMFBST3lCVTBhWm5M?=
 =?utf-8?B?N1AzVE1UN2lOWTltSEFmMFAyeUMxc3dPM04vbEt0cDdnaHUzVC9ycEk5WmRn?=
 =?utf-8?B?S2NRN1JOdXo1VTdYWjJrVnhjdU5tNWpKbG5SMnIzcXJOMG1OQUYvYndMUmJQ?=
 =?utf-8?B?ekRqZVlHSk9ReEdQTHg1Nzh6VERJMm9sdkxBVHB1TnZJajE1VTAwSkRKcy9P?=
 =?utf-8?B?djJMUU1Pd2FEMmZFNHlDN0ppZDRBZWY2Q1FoaXMvMk9QcXBJbGFuNC8zRFM2?=
 =?utf-8?B?aXBWTFJzenpJUTZNZWIrZ1d5d21WL2JmNXRJcjA5aWhDR1U3Q2I5cHA1OVJS?=
 =?utf-8?B?eE1ZdG9NbmxNRENhNWcxaUlxNDJEWnJZMnIyYXQySG90MlF4ZGprTDMzU205?=
 =?utf-8?Q?zS7NvQgaLAgshhR2CWQ8PoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41EAD9BCAFB6C445AF1C093382B077C0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e2ead4-a9eb-4a12-152f-08db728119aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 17:58:20.9680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rieMYvWM74IPfJWloHt/pGnpLYUtDXh/GCzHzB+FhsMIrDH3nvIUgrClFSx8H2VOK9r4seRa1NSTjG5t3c8YNUQpoPDLyRjOsCE+hV1EAhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6690
X-Proofpoint-ORIG-GUID: fOGSM90nZb7_aeiXaYMNW4yZ34Rwghbt
X-Proofpoint-GUID: fOGSM90nZb7_aeiXaYMNW4yZ34Rwghbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjA2LjIzIDE2OjEyLCBQZXRyIFBhdmx1IHdyb3RlOg0KDQoNCkhlbGxvIFBldHIN
Cg0KDQo+IFdoZW4gYXR0ZW1wdGluZyB0byBydW4gWGVuIG9uIGEgUUVNVS9LVk0gdmlydHVhbCBt
YWNoaW5lIHdpdGggdmlydGlvDQo+IGRldmljZXMgKGFsbCB4ODZfNjQpLCBkb20wIHRyaWVzIHRv
IGVzdGFibGlzaCBhIGdyYW50IGZvciBpdHNlbGYgd2hpY2gNCj4gZXZlbnR1YWxseSByZXN1bHRz
IGluIGEgaGFuZyBkdXJpbmcgdGhlIGJvb3QuDQo+IA0KPiBUaGUgYmFja3RyYWNlIGxvb2tzIGFz
IGZvbGxvd3MsIHRoZSB3aGlsZSBsb29wIGluIF9fc2VuZF9jb250cm9sX21zZygpDQo+IG1ha2Vz
IG5vIHByb2dyZXNzOg0KPiANCj4gICAgIzAgIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eCAoX3ZxPV92
cUBlbnRyeT0weGZmZmY4ODgwMDc0YTg0MDAsIGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEz
Yzk0LCBjdHg9Y3R4QGVudHJ5PTB4MCA8Zml4ZWRfcGVyY3B1X2RhdGE+KSBhdCAuLi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jOjIzMjYNCj4gICAgIzEgIDB4ZmZmZmZmZmY4MTcwODZiNyBp
biB2aXJ0cXVldWVfZ2V0X2J1ZiAoX3ZxPV92cUBlbnRyeT0weGZmZmY4ODgwMDc0YTg0MDAsIGxl
bj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0KSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jOjIzMzMNCj4gICAgIzIgIDB4ZmZmZmZmZmY4MTc1ZjZiMiBpbiBfX3NlbmRfY29u
dHJvbF9tc2cgKHBvcnRkZXY9PG9wdGltaXplZCBvdXQ+LCBwb3J0X2lkPTB4ZmZmZmZmZmYsIGV2
ZW50PTB4MCwgdmFsdWU9MHgxKSBhdCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYzo1
NjINCj4gICAgIzMgIDB4ZmZmZmZmZmY4MTc1ZjZlZSBpbiBfX3NlbmRfY29udHJvbF9tc2cgKHBv
cnRkZXY9PG9wdGltaXplZCBvdXQ+LCBwb3J0X2lkPTxvcHRpbWl6ZWQgb3V0PiwgZXZlbnQ9PG9w
dGltaXplZCBvdXQ+LCB2YWx1ZT08b3B0aW1pemVkIG91dD4pIGF0IC4uL2RyaXZlcnMvY2hhci92
aXJ0aW9fY29uc29sZS5jOjU2OQ0KPiAgICAjNCAgMHhmZmZmZmZmZjgxNzYxOGIxIGluIHZpcnRj
b25zX3Byb2JlICh2ZGV2PTB4ZmZmZjg4ODAwNTg1ZTgwMCkgYXQgLi4vZHJpdmVycy9jaGFyL3Zp
cnRpb19jb25zb2xlLmM6MjA5OA0KPiAgICAjNSAgMHhmZmZmZmZmZjgxNzA3MTE3IGluIHZpcnRp
b19kZXZfcHJvYmUgKF9kPTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVycy92aXJ0aW8v
dmlydGlvLmM6MzA1DQo+ICAgICM2ICAweGZmZmZmZmZmODE5OGUzNDggaW4gY2FsbF9kcml2ZXJf
cHJvYmUgKGRydj0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwgZHJ2PTB4ZmZm
ZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkZXY9MHhmZmZmODg4MDA1ODVlODEwKSBh
dCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo1NzkNCj4gICAgIzcgIHJlYWxseV9wcm9iZSAoZGV2PWRl
dkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTAsIGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0
MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjY1OA0KPiAgICAj
OCAgMHhmZmZmZmZmZjgxOThlNThmIGluIF9fZHJpdmVyX3Byb2JlX2RldmljZSAoZHJ2PWRydkBl
bnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwgZGV2PWRldkBlbnRyeT0w
eGZmZmY4ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjgwMA0KPiAgICAjOSAg
MHhmZmZmZmZmZjgxOThlNjVhIGluIGRyaXZlcl9wcm9iZV9kZXZpY2UgKGRydj1kcnZAZW50cnk9
MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sIGRldj1kZXZAZW50cnk9MHhmZmZm
ODg4MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo4MzANCj4gICAgIzEwIDB4ZmZm
ZmZmZmY4MTk4ZTgzMiBpbiBfX2RyaXZlcl9hdHRhY2ggKGRldj0weGZmZmY4ODgwMDU4NWU4MTAs
IGRhdGE9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZlcnMv
YmFzZS9kZC5jOjEyMTYNCj4gICAgIzExIDB4ZmZmZmZmZmY4MTk4YmZiMiBpbiBidXNfZm9yX2Vh
Y2hfZGV2IChidXM9PG9wdGltaXplZCBvdXQ+LCBzdGFydD1zdGFydEBlbnRyeT0weDAgPGZpeGVk
X3BlcmNwdV9kYXRhPiwgZGF0YT1kYXRhQGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlv
X2NvbnNvbGU+LA0KPiAgICAgICAgZm49Zm5AZW50cnk9MHhmZmZmZmZmZjgxOThlN2IwIDxfX2Ry
aXZlcl9hdHRhY2g+KSBhdCAuLi9kcml2ZXJzL2Jhc2UvYnVzLmM6MzY4DQo+ICAgICMxMiAweGZm
ZmZmZmZmODE5OGRiNjUgaW4gZHJpdmVyX2F0dGFjaCAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZm
ODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIzMw0K
PiAgICAjMTMgMHhmZmZmZmZmZjgxOThkMjA3IGluIGJ1c19hZGRfZHJpdmVyIChkcnY9ZHJ2QGVu
dHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL2Jh
c2UvYnVzLmM6NjczDQo+ICAgICMxNCAweGZmZmZmZmZmODE5OGY1NTAgaW4gZHJpdmVyX3JlZ2lz
dGVyIChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBh
dCAuLi9kcml2ZXJzL2Jhc2UvZHJpdmVyLmM6MjQ2DQo+ICAgICMxNSAweGZmZmZmZmZmODE3MDZi
NDcgaW4gcmVnaXN0ZXJfdmlydGlvX2RyaXZlciAoZHJpdmVyPWRyaXZlckBlbnRyeT0weGZmZmZm
ZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQgLi4vZHJpdmVycy92aXJ0aW8vdmlydGlv
LmM6MzU3DQo+ICAgICMxNiAweGZmZmZmZmZmODMyY2QzNGIgaW4gdmlydGlvX2NvbnNvbGVfaW5p
dCAoKSBhdCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYzoyMjU4DQo+ICAgICMxNyAw
eGZmZmZmZmZmODEwMDEwNWMgaW4gZG9fb25lX2luaXRjYWxsIChmbj0weGZmZmZmZmZmODMyY2Qy
ZTAgPHZpcnRpb19jb25zb2xlX2luaXQ+KSBhdCAuLi9pbml0L21haW4uYzoxMjQ2DQo+ICAgICMx
OCAweGZmZmZmZmZmODMyNzcyOTMgaW4gZG9faW5pdGNhbGxfbGV2ZWwgKGNvbW1hbmRfbGluZT0w
eGZmZmY4ODgwMDNlMmY5MDAgInJvb3QiLCBsZXZlbD0weDYpIGF0IC4uL2luaXQvbWFpbi5jOjEz
MTkNCj4gICAgIzE5IGRvX2luaXRjYWxscyAoKSBhdCAuLi9pbml0L21haW4uYzoxMzM1DQo+ICAg
ICMyMCBkb19iYXNpY19zZXR1cCAoKSBhdCAuLi9pbml0L21haW4uYzoxMzU0DQo+ICAgICMyMSBr
ZXJuZWxfaW5pdF9mcmVlYWJsZSAoKSBhdCAuLi9pbml0L21haW4uYzoxNTcxDQo+ICAgICMyMiAw
eGZmZmZmZmZmODFmNjRiZTEgaW4ga2VybmVsX2luaXQgKHVudXNlZD08b3B0aW1pemVkIG91dD4p
IGF0IC4uL2luaXQvbWFpbi5jOjE0NjINCj4gICAgIzIzIDB4ZmZmZmZmZmY4MTAwMWY0OSBpbiBy
ZXRfZnJvbV9mb3JrICgpIGF0IC4uL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MzA4DQo+ICAg
ICMyNCAweDAwMDAwMDAwMDAwMDAwMDAgaW4gPz8gKCkNCj4gDQo+IEZpeCB0aGUgcHJvYmxlbSBi
eSBwcmV2ZW50aW5nIHhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoKSBmcm9tDQo+IHNldHRp
bmcgZG9tMCBhcyBhIGJhY2tlbmQgd2hlbiBydW5uaW5nIGluIGRvbTAuDQo+IA0KPiBGaXhlczog
MDM1ZTNhNDMyMWY3ICgieGVuL3ZpcnRpbzogT3B0aW1pemUgdGhlIHNldHVwIG9mICJ4ZW4tZ3Jh
bnQtZG1hIiBkZXZpY2VzIikNCg0KDQpJIGFtIG5vdCAxMDAlIHN1cmUgd2hldGhlciB0aGUgRml4
ZXMgdGFnIHBvaW50cyB0byBwcmVjaXNlIGNvbW1pdC4gSWYgSSANCmFtIG5vdCBtaXN0YWtlbiwg
dGhlIHNhaWQgY29tbWl0IGp1c3QgbW92ZXMgdGhlIGNvZGUgaW4gdGhlIGNvbnRleHQgDQp3aXRo
b3V0IGNoYW5naW5nIHRoZSBsb2dpYyBvZiBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCwg
dGhpcyB3YXMgDQppbnRyb2R1Y2VkIGJlZm9yZS4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFBldHIg
UGF2bHUgPHBldHIucGF2bHVAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ncmFudC1kbWEt
b3BzLmMgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gaW5kZXggNzZmNmYyNjI2NWEz
Li4yOWVkMjdhYzQ1MGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMu
Yw0KPiArKysgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4gQEAgLTM2Miw3ICszNjIs
OSBAQCBzdGF0aWMgaW50IHhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiAgIAlpZiAobnApIHsNCj4gICAJCXJldCA9IHhlbl9kdF9ncmFudF9pbml0X2Jh
Y2tlbmRfZG9taWQoZGV2LCBucCwgYmFja2VuZF9kb21pZCk7DQo+ICAgCQlvZl9ub2RlX3B1dChu
cCk7DQo+IC0JfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dS
QU5UKSB8fCB4ZW5fcHZfZG9tYWluKCkpIHsNCj4gKwl9IGVsc2UgaWYgKChJU19FTkFCTEVEKENP
TkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5UKSB8fA0KPiArCQkgICAgeGVuX3B2X2RvbWFpbigp
KSAmJg0KPiArCQkgICAheGVuX2luaXRpYWxfZG9tYWluKCkpIHsNCg0KVGhlIGNvbW1pdCBsZ3Rt
LCBqdXN0IG9uZSBub3RlOg0KDQoNCkkgd291bGQgZXZlbiBiYWlsIG91dCBlYXJseSBpbiB4ZW5f
dmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2FjYygpIGluc3RlYWQsDQphcyBJIGFzc3VtZSB0aGUgc2Ft
ZSBpc3N1ZSBjb3VsZCBoYXBwZW4gb24gQXJtIHdpdGggRFQgKGFsdGhvdWdoIHRoZXJlIA0Kd2Ug
ZG9uJ3QgZ3Vlc3MgdGhlIGJhY2tlbmQncyBkb21pZCwgd2UgcmVhZCBpdCBmcm9tIERUIGFuZCBx
dWl0ZSANCnVubGlrZWx5IHdlIGdldCBEb20wIGJlaW5nIGluIERvbTAgd2l0aCBjb3JyZWN0IERU
KS4NCg0KU29tZXRoaW5nIGxpa2U6DQoNCkBAIC00MTYsNiArNDIxLDEwIEBAIGJvb2wgeGVuX3Zp
cnRpb19yZXN0cmljdGVkX21lbV9hY2Moc3RydWN0IA0KdmlydGlvX2RldmljZSAqZGV2KQ0KICB7
DQogICAgICAgICBkb21pZF90IGJhY2tlbmRfZG9taWQ7DQoNCisgICAgICAgLyogWGVuIGdyYW50
IERNQSBvcHMgYXJlIG5vdCB1c2VkIHdoZW4gcnVubmluZyBhcyBpbml0aWFsIGRvbWFpbiAqLw0K
KyAgICAgICBpZiAoeGVuX2luaXRpYWxfZG9tYWluKCkpDQorICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KKw0KICAgICAgICAgaWYgKCF4ZW5fZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKGRl
di0+ZGV2LnBhcmVudCwgDQomYmFja2VuZF9kb21pZCkpIHsNCiAgICAgICAgICAgICAgICAgeGVu
X2dyYW50X3NldHVwX2RtYV9vcHMoZGV2LT5kZXYucGFyZW50LCBiYWNrZW5kX2RvbWlkKTsNCiAg
ICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQooRU5EKQ0KDQoNCg0KSWYgc28sIHRoYXQgY29t
bWl0IHN1YmplY3Qgd291bGQgbmVlZCB0byBiZSB1cGRhdGVkIGFjY29yZGluZ2x5Lg0KDQpMZXQn
cyBzZWUgd2hhdCBvdGhlciByZXZpZXdlcnMgd2lsbCBzYXkuDQoNCg0KDQoNCg0KPiAgIAkJZGV2
X2luZm8oZGV2LCAiVXNpbmcgZG9tMCBhcyBiYWNrZW5kXG4iKTsNCj4gICAJCSpiYWNrZW5kX2Rv
bWlkID0gMDsNCj4gICAJCXJldCA9IDA7
