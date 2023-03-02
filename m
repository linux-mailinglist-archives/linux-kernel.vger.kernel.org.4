Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4846A7B45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCBGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCBGSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:18:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6632D4228
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677737919; x=1709273919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eE+8qekunU/tU3+e6NHS3RTdnvZvTjceAwGd+mMrffI=;
  b=deQJv2zVsDoIqxxZBdOCIglkWUoUWzv51Oq+mhTLr1x+fW6lBI3F0UkH
   GbuTuKti7xD/1eQs2QN2PrFGe1OudZh9+Q0D74EqFr1DOm8H+ZXW/y1Wn
   MFHA8VvxHd/3tuqeABq4t86ZsMmp9NNuS0rS/TxoPcCT5ESfHVXJPY1+Z
   N0YEgWLXcWIQYrrYdFETt8/KBjZgKIPW+4k11vwkoKTt+mddZnf8inWk1
   IJDQIq4F+6CbG2o3jAVNfIeyIgekd0Xi+4QsDuGywox5vJFe7hC2/0Rok
   36ajrSe/MAuX1QWrnN0ObgdRwNGq7U1XfpoSp9lyz6I1p1N2IRvsFPy6f
   A==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673938800"; 
   d="scan'208";a="199522018"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 23:18:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 23:18:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 23:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNZz9CTn/6ADtuiU6giQJ3W4zCCN6+6Jnqgn973OYJ+8SV2ALTw3E8uHqLAvyDYkQjrfhQ8ZcfqI/MgAD1pj9bMAIiretmBUK1Piq68IeoI6FNccmbBqt3u/UMalKtVU1mkCVakN1or6JTbYlkR5xPqhgQWBvQLhpKiRuC9AYtmm/EsZd64+sH3b4YWLzZPWLhS2jCQkcikzwNAiHDYRC1rKl+CybhXU0v6Os5VAz+21gqz8/zPZFeGF45t+vT/DEO1h//tggBibjZSY40S3O3qNUCi6BGvocpR33T8hBCh+SfKc+UPbmoHofmuCnT7bEOrtA3ro1iTngZ8IdNJLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE+8qekunU/tU3+e6NHS3RTdnvZvTjceAwGd+mMrffI=;
 b=NyQhjSLZvah7ujSpmIfuFJ4N593sWvk9ttanFxdwEGbFr5IgGmdMmpiOWXdNZ/8ywRSWSgV0d8AwExc/6eBlNEsq77mTmbIdAvvHJctolaZJI+wzgPyHYfsOf0TvOU8E8xyc+DCALSGAadhdbxYCA17pZCal4nGHR3q869q+Y6NfNXyVVaY4VDf6xYywN1xa4F2qO165Z0Vo0dg92zrbZ49/YoJ9cCBWe3pjafCACe2NEwU5+XNwmd7o9RRHQjyMT1pQApcx5RzFM8nJiydEKit1mYhFD2JWyjckE79CXz/l2o0oUPCY/yoU/hHCF9JJmmIE7fi4kABlgLc9N+OQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE+8qekunU/tU3+e6NHS3RTdnvZvTjceAwGd+mMrffI=;
 b=Gq4AXUGbwnCoH9vWZD0jyt+ANgQp3TjHPzilB35B4kUZI3jt3PBJHfI4xhc00F5AU/4HqPOkWwPFWlCDjTgw3ZpKO40o69fukRSOeyv0EAc/sdnjxWVx7l+S7ue38KKM7wce3mWGQolM3HhF7SukhegTdoNNpM1qb6Zm9Jfyuew=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SJ0PR11MB6814.namprd11.prod.outlook.com (2603:10b6:a03:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:18:33 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 06:18:33 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <VaibhaavRam.TL@microchip.com>, <arnd@arndb.de>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: RE: [PATCH v6 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v6 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZS580gTd3A7U7/UKCHQDer1oh/a7nA34w
Date:   Thu, 2 Mar 2023 06:18:33 +0000
Message-ID: <BN8PR11MB36689A85AE21AA78FDA79991E9B29@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230228180426.1857-1-vaibhaavram.tl@microchip.com>
In-Reply-To: <20230228180426.1857-1-vaibhaavram.tl@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|SJ0PR11MB6814:EE_
x-ms-office365-filtering-correlation-id: 8d40fea6-3bd5-4896-d345-08db1ae5f36b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 05jI38XKXteI0iPxx31Vd28ja6PYuMq/KBc/lqTp3nzIz/UAWIqhP3aDFVJrr6hKoLYvuRfWDvmlAse0D4//Rmlztn2K+8I8nBnYBqFuoAUqrAkaI9dOoeVDTjoA6W7DAmKFIkIwl9OObfyMA0QCuM63eI6DTdGIL7kWJ89ltnsBEnyf5OFpgCS6XE+v/2AAbSto/T+eNuGeab3XYH01qKeAnJrf2vOX3zo7mlD5ElXXbbM8q8bWzvNSvIgcdev880aPT/k1APaBpnv6VismgS9IGLcdftaCIcSCY8Bj97tB9NIyrrR43lsI7vFh22bHi8pX3OG//lbsnjfXwGCCTsMFR7P1e58O+34IGPUxDfMdp0ULFbo6ERfX+o5qyjqS5TK2y42EKUoKtH19EehxieTq48D/DOgZC+h1PEUPFsqGu6Fic/FUf8iHpbABLoeXezSHifjw2jiFI4qwTHDP+1Xly4hxDG03wmfd/OFUoHHLx9YORh7K9U3yOq7C87Wch0zyRuXOq8liRlQRr15gdlj6jPDFladTR0NksU5hs4aOIFYUksjS6TvhTzLJKpgvyuIQVIacDX1Q3V6JZvuVqJEkn2sAWevEzUXYk4cBcwR/raWHRDQSNNjKNfzs3oCOkL0bUnZgelmgCStGejX6D7W1TePw6qRP0DLaWRGRqq1xFbRJiUnjG6NtRjjkkNW+6KuBkMBAsrbLlA6K4kO3LprEPlF3IxUZOdV9byNXb1raKxCeXkg+gNQgSNTW2gV7dL91WVWl+tkyLJDA5Yo/cIpy+Gt+fD+GnZeNqt6vkNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(9686003)(186003)(107886003)(38070700005)(71200400001)(38100700002)(54906003)(2906002)(110136005)(478600001)(52536014)(86362001)(316002)(122000001)(7696005)(55016003)(33656002)(6506007)(26005)(4326008)(8676002)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(8936002)(83380400001)(5660300002)(41300700001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3BtSzB2WGJYZkVSMC9UWnhEUDJHcWZCZ0pDSEdjU1NwRTBacEIyd2VsRUsz?=
 =?utf-8?B?UGhyeHc4NVNoVWlMSmc3NmJKSW01aExRY0NNRWJ3MHFtVkh3aElBN3VsekQ5?=
 =?utf-8?B?UmxtbkJaWnY3MVNDdk1ra1RoeDVSMkNYcC9SMkJFeTVQTVovS3E2c3ZhZTFr?=
 =?utf-8?B?MkY3YzArQUVGZ29oUmxsWG02enpOTDVXK04yMWJISnI5V0o2aWErelBXWWdk?=
 =?utf-8?B?RWtUNlhlejBvV1JGOXNoelM3TXAySmhlejhseHhoL3U0aEtlRG90NXlEQzlM?=
 =?utf-8?B?RldnZU9BV3pESkVHWTAyb1kzbDR2R3JhSk1GdkY0RUlIS2pmbUtDVlJCVkpP?=
 =?utf-8?B?MTdpUjJhUXdxemNmZ1ZxMnJlRWdrLzFaN1k2ZGlVZU5SNWtYTFJXTjBrWDk1?=
 =?utf-8?B?anNQdURCUnZkV3ZWWE9qVWRLVjlQcmQ4UDErWSsvRWRnNjVXeUVBa3Vnc2tr?=
 =?utf-8?B?YVRCWDArKzFQU0x1TW01MXNFUnZScW40UCtjOHp1WlZ2bnpMUzJnSGpjdHJD?=
 =?utf-8?B?WEplVjRBa1FlTWM2ZlBwNWUvVWxLQTNCc1RnQzgwNFlFc0lsOG8zOG1iK2xw?=
 =?utf-8?B?K3UreEoyL0lpWG5LeCtDV3VhSW5GMkhOdzZRcm9hLzJiai9GRlZzcjc3eDBJ?=
 =?utf-8?B?ZXovbk1yVmNyMmF4aVFxWGtzMmNINEZ5WUp1cHE1d295NkhtT21zOWs4Rk9N?=
 =?utf-8?B?T1UreSsxek92S2VxQjdDa2FDUGduelZXTWx5elhNUWVWWUVjV1phTjI2RGFj?=
 =?utf-8?B?SXc1dzNJdVpaaDlweTFxd2V0UnJGUmFFRzhYSVMvTjVmYU93dXlxNm9LUUZS?=
 =?utf-8?B?M2ZHZXJNRTFSaWJDMXdtK040MjgxeHM1NXNHUTBWQzlFbkJjZ2FCcjMxL2VM?=
 =?utf-8?B?YUx0L0YwSEJKcE9CdnB4bis0cGtQMkkxSXlOQk1lU0x4bVR6RUJLNHRDSjJC?=
 =?utf-8?B?ODRLZTZJUEVDSGZxYjBGdjNINUNjbWZ5MTh6YXgwaTRtby94bUNwUkR5UlZU?=
 =?utf-8?B?Z2hHeVZlZTRUZjdWRUlvcUlZVksvMXFjNXIzNTVHdTVGSEVubmJPRW01ZHFP?=
 =?utf-8?B?dnBSWHRWZzJjMDJlVXMvU0xNdnZvT2NJVTBDSmVaL2sySkpVWU8ydnNEaFJS?=
 =?utf-8?B?S0s0QUN0V1F4Z0VUenZET1BMMHB1Q1RDYjYzQWFUSzdLcHRBR3pSSjkxelhv?=
 =?utf-8?B?RXlBQTZGbVI5TzBiMysyMGkwQmJWSEtJU3Z5VUxjRUdPdmhFR0JROU1zRURM?=
 =?utf-8?B?cDJuYzBjRU1BcGFCNm1jckhLanYxNm5mR1hFbFZNS282c2JTakJsL0pzN3VS?=
 =?utf-8?B?VExtbVlCZmhGN0Q2YXlXaGk0QUpjL0NNUnNLazBlVU1IWmFlRitleFBXckVz?=
 =?utf-8?B?SG1lQmR0SXJUZit1eVJxV1N1QTltcDJQUWM4NDlKVGRsN0JnY2JSUDUrTmph?=
 =?utf-8?B?Zzg3RXdoWDQyS25LbENGQWxkdEM2NURjUS9MeWpaMHJ0bWVOWmZTeUNGdGJs?=
 =?utf-8?B?Z2daOVVVaDMxT3RRdUJENDF3NmZDaU5ZY2ZuMGlTYjVvYWJCT1NIaVdja2d4?=
 =?utf-8?B?MUhZdytkcWUraFlLU3UzSWdGVHdhT2pWaXNaNllQVGFzRllFYVNCdkRZZ2Yz?=
 =?utf-8?B?dDF3UjROeWsvbmt3dUlMOUh3QktFcVFNQ2J5U210WVVZWWJxT2ZwYkkzYmF3?=
 =?utf-8?B?Nm45UDhkVmxaTlVwWEZZY0cwRExONS82VW1ITld4WGRxdkszR3hDblM0ekEz?=
 =?utf-8?B?OFlTMjhOL3J6K21SdG0xOFYyeHJ6SWE0OENyOUtFL3pMaW95TlhOVjg5cmsw?=
 =?utf-8?B?clYzejhJNFR2dGoxL3RGL293WVhVSWFETjEzVFZRRk4wbTI0OE82d2kvOWxs?=
 =?utf-8?B?WDZTdnNFTks5RzVoQTJtNk8vMUFKTzQrNlVDVVd0TG9kYlBlekRXT21FZWVv?=
 =?utf-8?B?RWM2clFnZHp0SnZITjRyQXcwb0IxV1YvSys0ZkV4OTF3WVVueXlBN1JRandB?=
 =?utf-8?B?TnJXMVlQMkkrQ01BMkx5Y2RlRUw3OWlEbDUyZytwdHYxalJZaWNjSUtzbnNY?=
 =?utf-8?B?OHlRWUNGV1JqbnQ1emMzYlNxdXpLQ3djNnkwb0QwbnpYVVRpR0xVT01oNWJm?=
 =?utf-8?B?MWViRlBpTmJpdDBWbCttOStKM1BiUXE1VGtnbytacTFzNk9oQW5BS3RzTVQw?=
 =?utf-8?Q?S8BXNmqgfz6R+2Z35PRMTq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40fea6-3bd5-4896-d345-08db1ae5f36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 06:18:33.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRptnBdLiyzVuVI8VxaoPMt9/Kb8hNWyzV5ZsEctdlPQKF3wp+kve+CBsw7OjoaYWZZOGZw3MxRSKnbgKtb/TQ+05uuDgxUtl/1cm1NlFrY6rfqiWfAVaxy04HwuxNUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6814
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWliaGFhdiBSYW0gVC5MIDx2
YWliaGFhdnJhbS50bEBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAy
OCwgMjAyMyAxMTozNCBQTQ0KPiBNaWNyb2NoaXAncyBwY2kxeHh4eCBpcyBhbiB1bm1hbmFnZWQg
UENJZTMuMWEgc3dpdGNoIGZvciBjb25zdW1lciwNCj4gaW5kdXN0cmlhbCwgYW5kIGF1dG9tb3Rp
dmUgYXBwbGljYXRpb25zLiBUaGlzIHN3aXRjaCBpbnRlZ3JhdGVzIE9UUCBhbmQNCj4gRUVQUk9N
IHRvIGVuYWJsZSBjdXN0b21pemF0aW9uIG9mIHRoZSBwYXJ0IGluIHRoZSBmaWVsZC4gVGhpcyBw
YXRjaCBwcm92aWRlcw0KPiB0aGUgT1RQL0VFUFJPTSBkcml2ZXIgdG8gc3VwcG9ydCB0aGUgc2Ft
ZS4NCj4gDQo+ICtzdGF0aWMgaW50IG90cF9lZXByb21fY3JlYXRlX2RldmljZShzdHJ1Y3QgYXV4
aWxpYXJ5X2RldmljZSAqYXV4X2Rldikgew0KPiArCXN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlX3dy
YXBwZXIgKmF1eF9kZXZfd3JhcHBlcjsNCj4gKwlzdHJ1Y3QgcGNpMXh4eHhfb3RwX2VlcHJvbV9k
ZXZpY2UgKnByaXY7DQo+ICsJc3RydWN0IGdwX2F1eF9kYXRhX3R5cGUgKnBkYXRhOw0KPiArCWlu
dCByZXQ7DQo+ICsNCj4gKwlhdXhfZGV2X3dyYXBwZXIgPSBjb250YWluZXJfb2YoYXV4X2Rldiwg
c3RydWN0DQo+IGF1eGlsaWFyeV9kZXZpY2Vfd3JhcHBlciwNCj4gKwkJCQkgICAgICAgYXV4X2Rl
dik7DQo+ICsJcGRhdGEgPSAmYXV4X2Rldl93cmFwcGVyLT5ncF9hdXhfZGF0YTsNCj4gKwlpZiAo
IXBkYXRhKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmYXV4X2Rldi0+ZGV2LCAtRUlOVkFM
LA0KPiArCQkJCSAgICAgIkludmFsaWQgZGF0YSBpbiBhdXhfZGV2X3dyYXBwZXItDQo+ID5ncF9h
dXhfZGF0YVxuIik7DQo+ICsNCj4gKwlwcml2ID0gZGV2bV9remFsbG9jKCZhdXhfZGV2LT5kZXYs
IHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiArCWlmICghcHJpdikNCj4gKwkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoJmF1eF9kZXYtPmRldiwgLUVOT01FTSwNCj4gKwkJCQkgICAgICJNZW1v
cnkgQWxsb2NhdGlvbiBGYWlsZWRcbiIpOw0KPiArDQo+ICsJcHJpdi0+cGRldiA9IGF1eF9kZXY7
DQo+ICsJZGV2X3NldF9kcnZkYXRhKCZhdXhfZGV2LT5kZXYsIHByaXYpOw0KPiArDQo+ICsJaWYg
KCFkZXZtX3JlcXVlc3RfbWVtX3JlZ2lvbigmYXV4X2Rldi0+ZGV2LCBwZGF0YS0NCj4gPnJlZ2lv
bl9zdGFydCArDQo+ICsJCQkJICAgICBQRVJJX1BGM19TWVNURU1fUkVHX0FERFJfQkFTRSwNCj4g
KwkJCQkgICAgIFBFUklfUEYzX1NZU1RFTV9SRUdfTEVOR1RILA0KPiArCQkJCSAgICAgYXV4X2Rl
di0+bmFtZSkpDQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZhdXhfZGV2LT5kZXYsIC1FTk9N
RU0sDQo+ICsJCQkJICAgICAiY2FuJ3QgcmVxdWVzdCBvdHBlZXByb20gcmVnaW9uXG4iKTsNCj4g
Kw0KPiArCXByaXYtPnJlZ19iYXNlID0gZGV2bV9pb3JlbWFwKCZhdXhfZGV2LT5kZXYsIHBkYXRh
LQ0KPiA+cmVnaW9uX3N0YXJ0ICsNCj4gKwkJCQkgICAgICBQRVJJX1BGM19TWVNURU1fUkVHX0FE
RFJfQkFTRSwNCj4gKwkJCQkgICAgICBQRVJJX1BGM19TWVNURU1fUkVHX0xFTkdUSCk7DQo+ICsJ
aWYgKCFwcml2LT5yZWdfYmFzZSkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJmF1eF9kZXYt
PmRldiwgLUVOT01FTSwNCj4gImlvcmVtYXAgZmFpbGVkXG4iKTsNCj4gKw0KPiArCXJldCA9IHN5
c2ZzX2NyZWF0ZV9iaW5fZmlsZSgmYXV4X2Rldi0+ZGV2LmtvYmosDQo+ICZwY2kxeHh4eF9lZXBy
b21fYXR0cik7DQpDaGVjayB3aGV0aGVyIEVFUFJPTSBpcyBwcmVzZW50IGFuZCBhY2Nlc3NpYmxl
IGFzIGV4cGVjdGVkIGJlZm9yZSBlbnVtZXJhdGluZy4NCkVudW1lcmF0ZSBPVFAgZmlyc3QgYXMg
aXQgaXMgYWx3YXlzIHByZXNlbnQgYmVmb3JlIGNoZWNraW5nIGZvciBFRVBST00uDQo+ICsJaWYg
KHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJmF1eF9kZXYtPmRldiwgcmV0LA0KPiAr
CQkJCSAgICAgInN5c2ZzX2NyZWF0ZV9iaW5fZmlsZSBlZXByb20gZmFpbGVkXG4iKTsNCj4gKw0K
PiArCXJldCA9IHN5c2ZzX2NyZWF0ZV9iaW5fZmlsZSgmYXV4X2Rldi0+ZGV2LmtvYmosDQo+ICZw
Y2kxeHh4eF9vdHBfYXR0cik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoJmF1eF9kZXYtPmRldiwgcmV0LA0KPiArCQkJCSAgICAgInN5c2ZzX2NyZWF0ZV9iaW5fZmls
ZSBvdHAgZmFpbGVkXG4iKTsNClRlc3QgdGhlIGVycm9yIGhhbmRsaW5nIC0gaWYgdGhlIGZ1bmN0
aW9uIGZhaWxzIGhlcmUgd2hhdCBoYXBwZW5zIHRvIHRoZSBwcmV2aW91c2x5IGNyZWF0ZWQNClN5
c2ZzIGZpbGUuDQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KDQpUaGFuayBZb3UuDQoNClJl
Z2FyZHMsDQpLdW1hcg0K
