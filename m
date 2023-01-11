Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A25665ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjAKPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjAKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:58:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA613D64
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDPxxtxHD0IssB8qmlrkTObVEEU0P3hu2GSKTvNJS5TX4GBhIiB+P49fbOFAc6WJk+VyY020QihIO/u4h+71dCJfUXOaQ/r7E8V5axftLJwf5J/Ymsi5LmhQ5F1x9nIYTD2lDvhlY2E/J1sr705Coki2BsLdaD5uTQDKS4piP5zgTmA/UY0sYmrkNA1mZ/86Wvd/b3fs2V2jeuzkRi7SeDZ+qUUCQrhb8kJY+IBK4Gc03T4oR2/ut+MOtHi7s+1ial3T564FDW/+NKBz0dYgb6jBfzgeNCYtie+OeLFbymBmdCkvhZkYXX3PB3tp2BwWiPF7ga7LaYziLv1rjpvaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6/MSaiaWdr0GSQOBo0EG8IkmD1+jhOW2KwlBeAcWTA=;
 b=Nkggk59hTi2BQFh5SWIFDxUQtlqyBB3qSbtzpsWzlzvhiaFlukQRq7V1PrggkEsYDKCjKHxoDLhvZJuKa4UAwYEliv2+0zJ3AwIySE+SZpe/N4j4Klc1GRIgtqUpeX4qIha/MX9OmAzhGdPr2FEbvt+vOkIR93Z7ixtpM4xgA4Cf2O4oHvX7CY+GDjceMccZljLhi2QbNuih+SEP+pcQiAZjRzOTSMgTYZHZr7Ea3rHa+dpv9y6715ZgoWXn6gty/5woFasCIzCcreFq39NqUoiA/16IDCyQPIozt7qlAoZD0EASHmAKMUV2F5NW0BMYVzeNk0TIZ5swZNITgk+Tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/MSaiaWdr0GSQOBo0EG8IkmD1+jhOW2KwlBeAcWTA=;
 b=QHS4WTXhU6oQEeBbGi2BRJjTMkjYUX1QhcruYUnGXam6YEAk9DamV23UExfrkHKdw50CRca6qHHLRt95OLmAYoexVHIPdrHBXi+AVNQ1asCl33Vpbe4A/DO6GlIslPqH9NoUsh9pql2IKbuo3bDBPIK/Y5IrY7YIU3xYNlB/VKrjSVdF6vXPkkFtSjacHayrn+mC77G5hP8pSIs1LwyA5boX05/wX3UjSRQVtcaeQp5r/rPC2uvUHiM2SvleeT5gMLgCzZlNswLUkoDrGwo5reZlMOFsT1+GJq9NBSJ8rLYL7Oi9FocZhvcR8dW2tt0qI1BSzEXgrAroiIztesUzVg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 14:58:21 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:58:21 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 1/5] virtio_ring: per virtqueue dma device
Thread-Topic: [PATCH 1/5] virtio_ring: per virtqueue dma device
Thread-Index: AQHZJYXp/exib+Y5JEShlN8ZA2yzKK6ZNvrwgAAF4wCAAA5B8IAAAweAgAAAr8A=
Date:   Wed, 11 Jan 2023 14:58:21 +0000
Message-ID: <DM8PR12MB54005A89EB05BF46AD7D2DFEABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111085210-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111095358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230111095358-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 2cfc007c-80ea-4bd5-23ce-08daf3e44800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEO17YPrmg4BUASDhVixj2785WsFLQNs3hvIufWz/7VNRRv1+XeWfw2Pxc/ej6uIYcaALoPAcANIaaQGQk3WRg77kkONHneFR7MKFrRx6B+ZXspNDVYvKAsI5bHvtcgYCjQjeHA9nCQAGLmZCMgs/H+U6uY3hqAtq5HQLqwSP5nrRW5/wMRy3C6Rs75+TdGFyJm1jGZRc1SdgoyoOU29vhOlOMveg38KhyPIPhhubKHJHJZg+N1HKHob4TjWopdLbEtESmLBam8WoUZFLx9qpQTrTg3e4W1vF8gsjQvqKtTPwDozcn2wFCfVlTu7cdsPgjbcouzKwSL0+Y0O1tgtXRGzRUf3/f7ZBl4fxVQjmUyTXwKqxM/5F+NTuLcFjWgc/sRXBAoBCwjVIwGxhSR/SLwTdaV54OD+/EfHe0CVG3xuPjje7drNPvPHRKQBgpFbi0zyzycUgBpzW10AzfGBcZCYCVxl1RLk4zx97nF583zZhhL/13U1ldrMA4Hc3rC9oPQkmK8DxoxAtD9b0JDGpiGeV1juzBPdk61wBWTDszzPa86RL1SyhPi30K6dd5lkrgXFf24IcV8m9w33sLNqr3GTYGUCR3nUn2j4r7y+UB8YyA8OsgAwWU+Bvc5d/Xvz0zkJTZSBiOy3Li5M3g8SuK/Qcla+fO4IcmIeiAK1gURuOlE+OyZ6DLvd7dbZ1944wPPwRW7Ibcj6jlvbn2+uVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(6506007)(26005)(478600001)(9686003)(55016003)(33656002)(186003)(6916009)(66476007)(76116006)(71200400001)(64756008)(8676002)(41300700001)(66946007)(66446008)(54906003)(53546011)(7696005)(316002)(4326008)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(52536014)(66556008)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWllUE4rUWp2MEIwL2FPNGZ1SDhiM0dxWjlSMU42aVN6dkFMYWZ2cWFjTnAr?=
 =?utf-8?B?MlVWTjVEQXhKWDNNV1ZLUHlVMHA3R3FxRVBDTWFCNmZ5b1B0L0tvS2FtWlU3?=
 =?utf-8?B?MTEyOUtlenlRQ1FqUGtQb0YwbzVpWGpCOHY0dVRXdGtlbjN5Zk91c3c2dDY0?=
 =?utf-8?B?NWdvL2cwVlE4QTlmZFVIdVdnZUg1Z2lzZjlEc3FtQlJMZUg1Tm1TMkxJU3Uw?=
 =?utf-8?B?dzNpeUg3akY2eVFKMXpHZEVMeXNYR0VnQzRyV1hLaElEQ2lSUk5YcUVnYVdq?=
 =?utf-8?B?ajdHY0lOdlhEYkh3TkUzd3BGWmw0c21pZnVwdktSREdzK3ZkV0U5TytVZHp2?=
 =?utf-8?B?dnJqMWJtNzBiT25xVmtqZmF4OWk5MGtlc2NUMzBha2ZsTnpvaVhrbjREVUZO?=
 =?utf-8?B?Smx0UzV2RWNEODNCMi9FcERrR1IzVXR5b1JoZGdsbEFheTNqZW9ENE9aN3hO?=
 =?utf-8?B?L2drRFAwSkxISFhRVUIwTjI5eHpaeXdJMnVMNjFLNnlWOWhqR1ovZDlkUWFq?=
 =?utf-8?B?akdMaXFDRlFjeVJUdkdvbTVkQUg5eENITzE2QTQ5Y2FidTc3Ui9CZVVnWUFJ?=
 =?utf-8?B?Mjl0T3BjRXdMZ1h5ZDVHUzBpRmRjM2xkRHl3VVZ6Njk0RUtVTnFPc2pSVlVp?=
 =?utf-8?B?MGRWUUtQWWw1elRUSjgvSExHTzd6TmJrUXpsUGFQMmRHNFU4QnBjckJ0SDFG?=
 =?utf-8?B?M0o1amxXUm44UE5NWWtwa0d4MWJhTUVaNllYeHBxU3h1Zk5vbURiZzMyckg0?=
 =?utf-8?B?ZjlsRldaaU5qUkl0VFhab3hub1JYVzlKR2tVTlI5QjIzMm4yeFRwcUVhQVU1?=
 =?utf-8?B?OWZ5MDRBcmRTMlIyYWdVWkZvWTkrNDJ1cjlVNWMvclVWQVhWbnR0YXU5Z3Er?=
 =?utf-8?B?QzFkRlp6aWl5K05iNFBEWHViZHIwTDN2NXoyMjJ6OWtCV3ZlVG9SZmZGWGZ4?=
 =?utf-8?B?eDVHWWVQNlVQaWpQMUZ6NFpCSTQza3RmR1lscEtqNEhsc0tWK2JudkdRRXEw?=
 =?utf-8?B?bFRaMXloWnZPNHM4MGtabFl1TXpXSXZwK3ZadDgwYzI2ZE5ma3RjT0R0dmpC?=
 =?utf-8?B?Umk2MUVyeTE5czBQNitJalVwckcxVVhEK29KaXJlQzBLTU1mTDlsY3JUeVk0?=
 =?utf-8?B?ZkV6Z1h6R0lma3NEMTdTUWt0WWpjMDcxWExucGxleDh0WnBuUDJHZUFoVzRm?=
 =?utf-8?B?TExBV2lRcEF4Ri9QNExYTi9RWFFjNjNtOGkxV0xBalFKYm81R3BRTDJPb09W?=
 =?utf-8?B?NVgvOENtYmRNekdtcE8xNW1RbkRYNEJSKzhFREI0MTlUb201OWIrenZXMFVM?=
 =?utf-8?B?allhS0REdTVSK0lXUVpRR1dac09pS0pKSWoycFZjR0toUHZ5eGpla0JzQVpB?=
 =?utf-8?B?MTBXZWQ4VjRRRXdhMDlob1NmeVZCMlRod2V5Z3lUSjhXdzNTdTJISFNVQmEz?=
 =?utf-8?B?TzEzZi92SWFhWk1RY2VOdHdwR1lJMmwwV2lVK3hDamxZYzJSZU9BK0FoTFU3?=
 =?utf-8?B?ZzhrUzdVZEtaWUVuYTNZVzQ0dTZTR2VnMDBQUHRra1YwSXFtWTNMNlhTb0VU?=
 =?utf-8?B?c3Z0ellYRUFIVXhPWXhmZDJveHZaOXpFdGJhMmFNeVc4REFqby9sUGN0eTJQ?=
 =?utf-8?B?UzJ3MXVnQVVGamlDZ3lzWnd6VlRXL2x6bXQ1QUF6UHQrVHV3RWVublhVUkNk?=
 =?utf-8?B?cXFBQW1BMlZYRGw5ZjYwNS9MSk02YlkxSGw0ZFp5N05MSzFhUnlyS3ArazVD?=
 =?utf-8?B?amNlMURZbUM0aERwVWRPaUwrRjdtNnphZGNhRWFPSm9HOWtOMXc0SG1HUnlU?=
 =?utf-8?B?bWtZWEg0WlVJS1NGNWFPUC9FNDhiVVJJZ1lLRnVmZ0ZqTkdtQkFrN0I1cERj?=
 =?utf-8?B?ODk0QkcxcHRLaWZiT2MwZnhqZ2pCMktidDdzaTVMdW1uV0p5Qy9iNnpuSWRi?=
 =?utf-8?B?Wko1eDlZdHFlckZ6WjhwUzNuNVhaUG5xcW1kM0FNYWFkM3BrYUsyMEkrc1NV?=
 =?utf-8?B?WnZGVXZsbG03SHRYV01hanIwWm1WRURhYXV0R2JrT1BJUFdoelRRQVVMRmZ5?=
 =?utf-8?B?WnFNY0RjOG5zcmtlTkFNNGJmZzVUTEJXWGMxNDA4N1NRQWJVYmZXZEZxV1c2?=
 =?utf-8?Q?RjSU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfc007c-80ea-4bd5-23ce-08daf3e44800
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 14:58:21.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJpr5mUFKMKuCEZ25MPq9SxheB2aAHCKKaUJ/qnaX7YL29sCmI/2TJjsYzGuirNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDExIEphbnVhcnkgMjAyMyAxNjo1
NA0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+IENjOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPjsgZ2Rhd2FyQGFtZC5jb207DQo+IHZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiB0YW51ai5rYW1kZUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81XSB2aXJ0aW9f
cmluZzogcGVyIHZpcnRxdWV1ZSBkbWEgZGV2aWNlDQo+IA0KPiBPbiBXZWQsIEphbiAxMSwgMjAy
MyBhdCAwMjo0NjoyMFBNICswMDAwLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCAx
MSBKYW51YXJ5IDIwMjMgMTU6NTMNCj4gPiA+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4NCj4gPiA+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgZ2Rhd2FyQGFt
ZC5jb207DQo+ID4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IHRhbnVqLmthbWRlQGFtZC5jb20N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81XSB2aXJ0aW9fcmluZzogcGVyIHZpcnRxdWV1
ZSBkbWEgZGV2aWNlDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBKYW4gMTEsIDIwMjMgYXQgMDE6MzI6
MjBQTSArMDAwMCwgRWxpIENvaGVuIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCAxMSBKYW51
YXJ5IDIwMjMgODoyOA0KPiA+ID4gPiA+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVk
aGF0LmNvbQ0KPiA+ID4gPiA+IENjOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT47IGdkYXdh
ckBhbWQuY29tOw0KPiA+ID4gPiA+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IHRhbnVqLmth
bWRlQGFtZC5jb20NCj4gPiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMS81XSB2aXJ0aW9fcmluZzog
cGVyIHZpcnRxdWV1ZSBkbWEgZGV2aWNlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNo
IGludHJvZHVjZXMgYSBwZXIgdmlydHF1ZXVlIGRtYSBkZXZpY2UuIFRoaXMgd2lsbCBiZSB1c2Vk
DQo+ID4gPiA+ID4gZm9yIHZpcnRpbyBkZXZpY2VzIHdob3NlIHZpcnRxdWV1ZSBhcmUgYmFja2Vk
IGJ5IGRpZmZlcmVudCB1bmRlcmxheWVyDQo+ID4gPiA+ID4gZGV2aWNlcy4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IE9uZSBleGFtcGxlIGlzIHRoZSB2RFBBIHRoYXQgd2hlcmUgdGhlIGNvbnRyb2wg
dmlydHF1ZXVlIGNvdWxkIGJlDQo+ID4gPiA+ID4gaW1wbGVtZW50ZWQgdGhyb3VnaCBzb2Z0d2Fy
ZSBtZWRpYXRpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTb21lIG9mIHRoZSB3b3JrIGFyZSBh
Y3R1YWxseSBkb25lIGJlZm9yZSBzaW5jZSB0aGUgaGVscGVyIGxpa2UNCj4gPiA+ID4gPiB2cmlu
Z19kbWFfZGV2aWNlKCkuIFRoaXMgd29yayBsZWZ0IGFyZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IC0gTGV0IHZyaW5nX2RtYV9kZXZpY2UoKSByZXR1cm4gdGhlIHBlciB2aXJ0cXVldWUgZG1hIGRl
dmljZSBpbnN0ZWFkDQo+ID4gPiA+ID4gICBvZiB0aGUgdmRldidzIHBhcmVudC4NCj4gPiA+ID4g
PiAtIEFsbG93IHBhc3NpbmcgYSBkbWFfZGV2aWNlIHdoZW4gY3JlYXRpbmcgdGhlIHZpcnRxdWV1
ZSB0aHJvdWdoIGENCj4gbmV3DQo+ID4gPiA+ID4gICBoZWxwZXIsIG9sZCB2cmluZyBjcmVhdGlv
biBoZWxwZXIgd2lsbCBrZWVwIHVzaW5nIHZkZXYncyBwYXJlbnQuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTMz
ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gIGluY2x1ZGUv
bGludXgvdmlydGlvX3JpbmcuaCAgfCAgMTYgKysrKysNCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAxMDkgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMNCj4gPiA+ID4gPiBpbmRleCA3MjNjNGUyOWUxZDMuLjQxMTQ0
YjUyNDZhOCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiA+ID4g
PiA+IEBAIC0yMDIsNiArMjAyLDkgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7DQo+ID4gPiA+
ID4gIAkvKiBETUEsIGFsbG9jYXRpb24sIGFuZCBzaXplIGluZm9ybWF0aW9uICovDQo+ID4gPiA+
ID4gIAlib29sIHdlX293bl9yaW5nOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKwkvKiBEZXZpY2Ug
dXNlZCBmb3IgZG9pbmcgRE1BICovDQo+ID4gPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAgI2lmZGVmIERFQlVHDQo+ID4gPiA+ID4gIAkvKiBU
aGV5J3JlIHN1cHBvc2VkIHRvIGxvY2sgZm9yIHVzLiAqLw0KPiA+ID4gPiA+ICAJdW5zaWduZWQg
aW50IGluX3VzZTsNCj4gPiA+ID4gPiBAQCAtMjE5LDcgKzIyMiw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
dmlydHF1ZXVlDQo+ID4gPiA+ID4gKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQg
aW5kZXgsDQo+ID4gPiA+ID4gIAkJCQkJICAgICAgIGJvb2wgY29udGV4dCwNCj4gPiA+ID4gPiAg
CQkJCQkgICAgICAgYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwNCj4gPiA+ID4g
PiAgCQkJCQkgICAgICAgdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlDQo+ID4gPiA+
ID4gKiksDQo+ID4gPiA+ID4gLQkJCQkJICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpOw0KPiA+ID4g
PiA+ICsJCQkJCSAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gPiA+ICsJCQkJCSAgICAg
ICBzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2KTsNCj4gPiA+ID4gPiAgc3RhdGljIHN0cnVjdCB2cmlu
Z19kZXNjX2V4dHJhICp2cmluZ19hbGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludA0KPiBudW0p
Ow0KPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92
cSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBAQCAtMjk3LDEwICszMDEsMTEgQEAgc2l6ZV90IHZp
cnRpb19tYXhfZG1hX3NpemUoc3RydWN0DQo+IHZpcnRpb19kZXZpY2UNCj4gPiA+ID4gPiAqdmRl
dikNCj4gPiA+ID4gPiAgRVhQT1JUX1NZTUJPTF9HUEwodmlydGlvX21heF9kbWFfc2l6ZSk7DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiAgc3RhdGljIHZvaWQgKnZyaW5nX2FsbG9jX3F1ZXVlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBzaXplX3Qgc2l6ZSwNCj4gPiA+ID4gPiAtCQkJICAgICAg
ZG1hX2FkZHJfdCAqZG1hX2hhbmRsZSwgZ2ZwX3QgZmxhZykNCj4gPiA+ID4gPiArCQkJICAgICAg
IGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsIGdmcF90IGZsYWcsDQo+ID4gPiA+ID4gKwkJCSAgICAg
ICBzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2KQ0KPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gIAlpZiAo
dnJpbmdfdXNlX2RtYV9hcGkodmRldikpIHsNCj4gPiA+ID4gPiAtCQlyZXR1cm4gZG1hX2FsbG9j
X2NvaGVyZW50KHZkZXYtPmRldi5wYXJlbnQsIHNpemUsDQo+ID4gPiA+ID4gKwkJcmV0dXJuIGRt
YV9hbGxvY19jb2hlcmVudChkbWFfZGV2LCBzaXplLA0KPiA+ID4gPiA+ICAJCQkJCSAgZG1hX2hh
bmRsZSwgZmxhZyk7DQo+ID4gPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gPiA+ICAJCXZvaWQgKnF1
ZXVlID0gYWxsb2NfcGFnZXNfZXhhY3QoUEFHRV9BTElHTihzaXplKSwgZmxhZyk7DQo+ID4gPiA+
ID4gQEAgLTMzMCwxMCArMzM1LDExIEBAIHN0YXRpYyB2b2lkICp2cmluZ19hbGxvY19xdWV1ZShz
dHJ1Y3QNCj4gPiA+IHZpcnRpb19kZXZpY2UNCj4gPiA+ID4gPiAqdmRldiwgc2l6ZV90IHNpemUs
DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCB2cmluZ19m
cmVlX3F1ZXVlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBzaXplX3Qgc2l6ZSwNCj4gPiA+
ID4gPiAtCQkJICAgICB2b2lkICpxdWV1ZSwgZG1hX2FkZHJfdCBkbWFfaGFuZGxlKQ0KPiA+ID4g
PiA+ICsJCQkgICAgIHZvaWQgKnF1ZXVlLCBkbWFfYWRkcl90IGRtYV9oYW5kbGUsDQo+ID4gPiA+
ID4gKwkJCSAgICAgc3RydWN0IGRldmljZSAqZG1hX2RldikNCj4gPiA+ID4gPiAgew0KPiA+ID4g
PiA+ICAJaWYgKHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYpKQ0KPiA+ID4gPiA+IC0JCWRtYV9mcmVl
X2NvaGVyZW50KHZkZXYtPmRldi5wYXJlbnQsIHNpemUsIHF1ZXVlLA0KPiA+ID4gPiA+IGRtYV9o
YW5kbGUpOw0KPiA+ID4gPiA+ICsJCWRtYV9mcmVlX2NvaGVyZW50KGRtYV9kZXYsIHNpemUsIHF1
ZXVlLA0KPiBkbWFfaGFuZGxlKTsNCj4gPiA+ID4gPiAgCWVsc2UNCj4gPiA+ID4gPiAgCQlmcmVl
X3BhZ2VzX2V4YWN0KHF1ZXVlLCBQQUdFX0FMSUdOKHNpemUpKTsNCj4gPiA+ID4gPiAgfQ0KPiA+
ID4gPiA+IEBAIC0zNDEsMTEgKzM0NywxMSBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVlX3F1ZXVl
KHN0cnVjdA0KPiA+ID4gdmlydGlvX2RldmljZQ0KPiA+ID4gPiA+ICp2ZGV2LCBzaXplX3Qgc2l6
ZSwNCj4gPiA+ID4gPiAgLyoNCj4gPiA+ID4gPiAgICogVGhlIERNQSBvcHMgb24gdmFyaW91cyBh
cmNoZXMgYXJlIHJhdGhlciBnbmFybHkgcmlnaHQgbm93LCBhbmQNCj4gPiA+ID4gPiAgICogbWFr
aW5nIGFsbCBvZiB0aGUgYXJjaCBETUEgb3BzIHdvcmsgb24gdGhlIHZyaW5nIGRldmljZSBpdHNl
bGYNCj4gPiA+ID4gPiAtICogaXMgYSBtZXNzLiAgRm9yIG5vdywgd2UgdXNlIHRoZSBwYXJlbnQg
ZGV2aWNlIGZvciBETUEgb3BzLg0KPiA+ID4gPiA+ICsgKiBpcyBhIG1lc3MuDQo+ID4gPiA+ID4g
ICAqLw0KPiA+ID4gPiA+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2UgKnZyaW5nX2RtYV9k
ZXYoY29uc3Qgc3RydWN0DQo+IHZyaW5nX3ZpcnRxdWV1ZQ0KPiA+ID4gKnZxKQ0KPiA+ID4gPiA+
ICB7DQo+ID4gPiA+ID4gLQlyZXR1cm4gdnEtPnZxLnZkZXYtPmRldi5wYXJlbnQ7DQo+ID4gPiA+
ID4gKwlyZXR1cm4gdnEtPmRtYV9kZXY7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4g
SG93IGFib3V0IGdldHRpbmcgcmlkIG9mIHRoaXMgZnVuY3Rpb24gYW5kIGp1c3QgdXNlIHZxLT5k
bWFfZGV2Pw0KPiA+ID4NCj4gPiA+IFdpbGwgbWFrZSB0aGUgcGF0Y2ggZXZlbiBiaWdnZXIgdGhh
biBpdCBpcy4NCj4gPg0KPiA+IEkgY2FuJ3Qgc2VlIGhvdyB0aGlzIGNhbiBoYXBwZW4uIFlvdSBn
ZXQgcmlkIG9mIHRoZSBmdW5jdGlvbiBhbmQgeW91IGxvc2UNCj4gb3ZlcmFsbCAxMCBsaW5lcy4g
V2hhdCBhbSBJIG1pc3Npbmc/DQo+IA0KPiBUaGlzIGlzIGFuIGV4aXN0aW5nIGZ1bmN0aW9uLCBp
ZiB5b3UgZHJvcCBpdCB5b3UgbmVlZCB0byByZWZhY3Rvcg0KPiBtb3JlIG9mIHRoZSBleGlzdGlu
ZyBjb2RlLiBObz8NCkl0J3Mgc3RhdGljIGZ1bmN0aW9uIGluIHRoZSBmaWxlIHRoYXQgaXMgdXNl
ZCB3aGVuZXZlciB5b3UgbmVlZCB0aGUgZG1hIGRldmljZS4NCj4gDQo+ID4gPiBJZiB5b3UgZG8g
cGF0Y2ggb24gdG9wIHBscy4NCj4gPg0KDQo=
