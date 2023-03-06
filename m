Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170AB6AC226
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCFOEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:04:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70871F931;
        Mon,  6 Mar 2023 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678111435; x=1709647435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/qS11NqLScqIekH9WyDUQdYFiTHuBw0gng4S8xP12dU=;
  b=JydN5C0koOIIyw7E1hQeu8QTLi3dAmxaDD1ZzTPRt19NF6mWaCxFcfnG
   HYT6iYjiTDaJykt0SgGHqY9IByVmEmX56qQGuRcXkvkYbHOKv6+payGQR
   v8hUsmX3M/MxleMtHbcmSj4ciXVvf4CXIsJVWPw5nyLK8N1DU2Td6OGn7
   gNn1fA3WqTHJWorLCNTDnQVjdiqWEzdwGgNQF7vJUBFsctLRlVzwifNFF
   lALGPVuVSxbxv1K7cKL5wWeB1DX6mHzGCRXXWL11gnnaPSNQmx8FfERtt
   20aUFzeK9XC5Nz4V+az7/Yoq4ow7U1zugw01hxKCgMICEm3EimZnaywJb
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673938800"; 
   d="scan'208";a="203488567"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 07:03:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 07:03:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 07:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzI9tCeqgNe3W0HhOIrw04Zznj7D+ZSXwiZ/aGOu5cNeXqYs9hSHkMzcfqybe+Qx5apV5J/uW8sfilpBS9dEJBQHcoIZt3h3o6MmTYvywJL/1x14Oejv3H2Qk0j9+xk64wO3VOjUm9vrfhTnOhrIqsvdlnQz0B0yaTmTIH3gG5nVKBEV1p1lPOvwWcYDQgDeeXWcWWPEoT1K5fhDdwxeX/JGeWZZRiZIcUFA7p2ze7+00GvQYRoE6LPoBzqC1DM68hY9lQB1dnXX8rHKEzvlNKO/vBCwU5S7TKEb/LnEBlk9qoIhxbW6iG3ZQ5dtPIPAqbeXgPm77iXzJ1PIdNDZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qS11NqLScqIekH9WyDUQdYFiTHuBw0gng4S8xP12dU=;
 b=RMRfKFZNNhBzWjqofijO57gi24Klsuag97QVFour12WZMbIsj5fXTpxZ/+5tM5xdTOB2cBKnXnQfxCEimv9vPJiWg60NNFlaQkFc9FfMTIP6WiZ3/7/sMt3u/qZ5yQL/lHhvMo8GtCsD23YF9ZqSz2k9vAeep1kfN34h8DKuyp20OCFdodMwQVvxwWY4Jp8yQpVZrPnZYEqJrEPNkh8T+7bJTwJFdW8J+0guCDr6mgDesdaEtt39r5hF09KsskQRSJz5xLLKLYIhGXcWjnXNYmQLU7rWepKWhosu108UiT1+iwbJJHly3dG8AeOgg4tUJaTcOCTT64kAHrWYpRCiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qS11NqLScqIekH9WyDUQdYFiTHuBw0gng4S8xP12dU=;
 b=X3EUrhKQ1XeHF1v+2u3rNQbQE3w5/Pg1A2wY2Bff6FUEjnWRnL5nTMm/8crTgX/u35Eqo4+LZi9djMUJvMtHmgp7AcFAa8+WoUp15+Hhm4FiinssxBhp9Q0lNg24QWmJ/pcD+8/COnl1qI5ejU5Kv/BHLIBe6cYd0Pt4L001jo4=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 14:03:52 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 14:03:52 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] adding support for Microchip PAC193X Power Monitor
Thread-Topic: [PATCH v1 0/2] adding support for Microchip PAC193X Power
 Monitor
Thread-Index: AQHZRSd0ZaVNlxnpE0qSVU21b9Of767f7iOAgA3wg4A=
Date:   Mon, 6 Mar 2023 14:03:52 +0000
Message-ID: <178ee962c5fc7ee7806475cb38527b8bdbfa8d09.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
         <20230225171139.65238b62@jic23-huawei>
In-Reply-To: <20230225171139.65238b62@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: 388ea05b-9997-480b-a9d8-08db1e4b9df8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuVSb2jTeXkKvS5ELlnHrF7j9rsip8SxttWt/82VC0EhJU/5RiYB3Y0n63/QuPvi5/nN0iGH/zVuJm6RlNOEphdCGgna6uqdLW6/SKANC465BT/xZEOl3CjfYpe5m5NzIpLY65rRBdMIHPrlCoOyOWQDp/a+pwAv6VaRR7XXLSngMfrmUgVz8NL3lpJCnaXggaEQyXSW0mdwKtwFebwOUdUig1734EffajPEPVY6ZlwzrOx5Hsz4jeossqDLTWDxTPYbLCVJvBbVbSj40jJoWA0mH26VK7mT1n8rofcW2tk4X6nRHHSNB7lodBILPgxDQVObip0q/6OWpPehLZibEXQfKOPgEgS4cHwNuu/Y0DUdyboUc1bFeQQluDLd2t08Vv9MooLpDIZf3UCbnYq5KbJa1mOvE9n4SD6lddMuL4t4ihY6kavQAqTdvQYZP/HXxwEE3LepsQfNTbcv77uyXJ2+WO8+45wm6xErpFy37FHJSGVkZXo62gnsh3gKymyWRBc+ZJ0MfDgY3Kvjc+Ecp38flgjkv8HTG5hUylWtzDViQb/pIL4ykat+GR2ZqG6GZipTyLa7ToQJudkd312cWTEc5Tioc8qD5DVQtUCZ5LvT5QHkQjdsiEzb3LM91RZP6hRricG/dVSTzBtYRzS4OdRP+NiCNjkLtHZbVVEgzhekCEOfZRRZcwpeddt/du/pCb4gPeM/hLeb5tqPDd7eyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(6486002)(6512007)(6506007)(36756003)(38070700005)(83380400001)(122000001)(86362001)(38100700002)(186003)(26005)(2616005)(41300700001)(66476007)(91956017)(66946007)(66556008)(64756008)(8676002)(4326008)(6916009)(2906002)(66446008)(76116006)(8936002)(5660300002)(478600001)(71200400001)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDNET2xBekhqTTFYMFBHSnBOUjRtcytnU21CNXdlMzdhQWlsZkdSaDc2WWJm?=
 =?utf-8?B?NE5EclcrLzU3NnNlcEt5NE4xZ29ZQ3BtU3B1YTVjRUh1NXN3OXFOZjJ0U1FE?=
 =?utf-8?B?MW9KWVRVS0l0V1ZWejBFdTk2aDh0VEZ4UHJsSU50cHQ0Tk4yR1hLc21CQUJl?=
 =?utf-8?B?TWkxRTc0NjljVHkyRzEveWI5WkR3TVEyL0sxZ0xXVW92QTNDTGZhNExJNW11?=
 =?utf-8?B?N1dxaDM1QzZpU20zVTlkNWIxSlVBeWhqVSsvelAvQWVPMnpuV0RWUnFjeldo?=
 =?utf-8?B?b0ZYQXQ2Zk1qNGtTbDFqUTJPeTBNalFKaDIyTmtmdmdLR080bkJ1Ziszbzcv?=
 =?utf-8?B?MHFldU9NYkIrZjIzRDBUQUdQcUJCSWJXWDNBMXF6a1dhOEZQdGIyZ3RIWjND?=
 =?utf-8?B?TjdKMWo4ajl6V3BnWk42NWtXVW5mdXNkZGdpWUlBdFpTSjFraFU1Yi9VcUtE?=
 =?utf-8?B?RldCU2N0UXBtRzlWQTNhQ09EQnBQUGZFS3pKeWxpY0dBWUJsSE9zMGFzZjNh?=
 =?utf-8?B?c25SWWVUMkZ2cXVaZlFkMjZlTVJmV004cUsrKy8wWWFDNHNZWUtUMVg4WElO?=
 =?utf-8?B?azNILzF6cWxodEhqWHFxVU5td2lDQ2NyNDk1Z1VmT0tuZEVlUVpiV2NObEt1?=
 =?utf-8?B?RjM5Tk1rRFpNdXBuL0txQUg2OEl4UURNbXROYzljcklnb3ROUzZOS0xRUkFx?=
 =?utf-8?B?Rk9qMTN3TzlnZDY0TUZpYlk0QXBZOUorTk04ekJ4Q0ErUWZjWDFWMGZ6L0o3?=
 =?utf-8?B?dG90bEJLb1F5T0tJMFNqZW5oMDVqY3MxREhQNnUzOTY4ODZlWkdKK0lmVTFE?=
 =?utf-8?B?Rmw4RTh1eUtha01SdUl6UmVvRlR0dU1jRlVEV0U0VzFIL2FIRHcrdzY1UllP?=
 =?utf-8?B?MmtyamViWlF6ejQxNFJhN25GR01RRy9GalRvYW9RdjhBZEkrZVo3MjFJODZB?=
 =?utf-8?B?dGFiN3NKTWlyYUJFNHZSdmFqWXc0bWlOdnZDYkpaSGpuQWJmRUtGaTZUTVJv?=
 =?utf-8?B?YjZyOVVXYXZXZ1ppdHlOZzY1KzRhWGVJcXFrQXdZRjVZS015ejZycmJObE44?=
 =?utf-8?B?Z2ZMQlk5K05KR0xWaGhmV2RPay9EVmRmdmZZUkNUd1NTb1J0c0J2ZjVtMzFH?=
 =?utf-8?B?MWtxRHZyQysrdGlYb21JVEg3QTNmRUptZzBBRlpoeTczVW4xK3B2K2duTVVr?=
 =?utf-8?B?MUFlU2JNeXdISkc1dHlLNCtMN3hhMlZzL1pqWmlvRW56YmJLQ2VYcVNVS294?=
 =?utf-8?B?MzB3ZzNqRHYrTVY5eHhJQ3F6Z1FlUFkxRXJMNTdaWTRsU2g5cjMyYmE5cldG?=
 =?utf-8?B?dW83OTdCaGowYi9XNEUwTGRyVmdlMUhPd00zcEVEQklVTitaTHFheXhnalJj?=
 =?utf-8?B?anUzSjZ4UE42blNGU2liTE5KK1REcmRxTjdvMmhPc3hoaW5wN1RMMVpaOHRt?=
 =?utf-8?B?YzBRUmZXZ0lGeHlGSkl5NGliYkM0SzdUbmVQY1JBa1lDZS96R2N6VkwxK0di?=
 =?utf-8?B?cjVVUWE2aGFiQVN2bTI4SnhEdjUwbWJFamd6b2VYZmk5RmZ6ZjZNTXArRDRL?=
 =?utf-8?B?cFk2OVRHbUs2VjczWkdHUlFueWdQR3VoejluUFlFT1RHSUhaWHdDdVVjVDVW?=
 =?utf-8?B?UXBFMEJIaWdocko5Um1EenF2R2JVSno0dVZHbkNlSTRxQlo1WWJseERkQmZq?=
 =?utf-8?B?ZGJZZXYxcFRLMmtxTFRKWk9Zd1VhMlY0blpwOEwrdU5iQkNzN1NyMll2R0l2?=
 =?utf-8?B?ZERYemtWNThLM2l5WVVDdGI4cHlJSlJ2aGVRUmxtYUhBZkJ6WTNjenBvdWtF?=
 =?utf-8?B?OEJVUDZnb1JHcWt3a09QYUc5cGVkVzBXYmM4MXJkUFVCZzNpOGJYZ2krUEl3?=
 =?utf-8?B?YnJ0TFdSbm5pNHFkUWVkQ25sbFJDTWszWUZFWWpxS3NWOU43dm1LU0U2b2ZP?=
 =?utf-8?B?Q0lyamFhL3daNDIrT2hibzI0d1ZxaUNQalBCK01ib0RucTh4WHJ6eVgyb0Z0?=
 =?utf-8?B?MlhaV0NVNDlGU0dxdHFnRjRMdXZVUDVINDZGNzFSdXY0bFhxNU5RQ1VwQkN5?=
 =?utf-8?B?aEtnVFp0RFBMWmdjWVZSK1h5YTk0Z3JnbHFBZlhyRHVONlAyNmZJU0xvZVgv?=
 =?utf-8?B?YmxuTkhBSUpvdHhSUE13eExta1JwRk1IZjY0K3BRdEhUU1crc21xNGxVa3Uy?=
 =?utf-8?Q?i5vm6wtP+VFZ10/9RMzvXUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8D51E43ACFFD41A0F74C2E722E6904@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ea05b-9997-480b-a9d8-08db1e4b9df8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 14:03:52.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSkBJ9FXX95qTUQXPOPIODbU4gbVjSzZMg8Hjvc/up9QwmQS6kjDIVFgZfR7Tbk9Fyhj3PmentNHNuIC8p8zxEo7epJpws2IFCVFOVAzuTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKb25hdGhhbiwNCg0KICBQbGVhc2UsIHNlZSBteSBjb21tZW50cyBiZWxvdy4uLg0KDQoN
Ck9uIFNhdCwgMjAyMy0wMi0yNSBhdCAxNzoxMSArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24s
IDIwIEZlYiAyMDIzIDE0OjMyOjMwICswMjAwDQo+IDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAu
Y29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVh
QG1pY3JvY2hpcC5jb20+DQo+ID4gDQo+ID4gQWRkaW5nIHN1cHBvcnQgZm9yIE1pY3JvY2hpcCBQ
QUMxOTNYIHNlcmllcyBvZiBQb3dlciBNb25pdG9yIHdpdGgNCj4gPiBBY2N1bXVsYXRvciBjaGlw
IGZhbWlseS4NCj4gDQo+IFRoaXMgZGV2aWNlIGlzIGF0IHRoZSBtZXNzeSBib3VuZGFyeSBiZXR3
ZWVuIElJTyBhbmQgSFdNT04uIFBlcmhhcHMNCj4gY2FsbCBvdXQNCj4gdGhlIHJlYXNvbnMgeW91
IHRoaW5rIElJTyBpcyBtb3JlIGFwcHJvcHJpYXRlIGluIHRoaXMgY292ZXIgbGV0dGVyLg0KPiAr
IE9mdGVuIGEgZ29vZCBpZGVhIGZvciB0aGVzZSBib3JkZXJsaW5lIHBhcnRzIHRvIGNjIGJvdGgg
bWFpbGluZw0KPiBsaXN0cyBhbmQNCj4gbWFpbnRhaW5lcnMuDQo+IA0KPiBPZnRlbiB0aGUgY29u
Y2x1c2lvbiBpcyB0aGF0IGl0IGlzIGZpbmUgdG8gaGF2ZSB0aGVzZSBpbiBJSU8gYmVjYXVzZQ0K
PiB3ZSBjYW4NCj4gYnJpZGdlIHRvIGh3bW9uIGFueXdheSB3aXRoIHRoZSBpaW8taHdtb24gZHJp
dmVyLg0KPiANCg0KSW5kZWVkIHRoZSBkcml2ZXIgKHRoZSBkZXZpY2UpIGlzIGF0IHRoZSBib3Vu
ZGFyeSBiZXR3ZWVuIElJTyBhbmQNCkhXTU9OLiBJIHdhcyB0aGlua2luZyB0byBzdGFydCB3aXRo
IGEgc2ltcGxlIGRyaXZlciAodGhpcyBvbmUgdGhhdCBpcw0KbW9yZSBhcHJvcGlhdGUgdG8gYmUg
YSBIV01PTikgYW5kIGFkZCBtb3JlIGZ1bmN0aW9uYWxpdHkgbGF0ZXIgKGxpa2UNCmRhdGEgYnVm
ZmVyaW5nIHRoYXQgaXMgcXVpdGUgaW1wb3J0YW50IGZvciBleGFtcGxlIGlmIHNvbWVvbmUgd2Fu
dHMgdG8NCnByb2ZpbGUgcG93ZXIgY29uc3VtdGlvbiBvZiB0aGUgcHJvY2Vzb3IgaXRzZWxmLCBv
ciBhIHBoZXJpcGVyaWMsIG9yIGENCmJhdHRlcnkpDQoNCg0KPiA+IA0KPiA+IERpZmZlcmVuY2Vz
IHJlbGF0ZWQgdG8gcHJldmlvdXMgcGF0Y2g6DQo+ID4gDQo+ID4gdjE6DQo+ID4gLSBmaXJzdCB2
ZXJzaW9uIGNvbWl0dGVkIHRvIHJldmlldw0KPiA+IA0KPiA+IA0KPiA+IE1hcml1cyBDcmlzdGVh
ICgyKToNCj4gPiDCoCBkdC1iaW5kaW5nczogaWlvOiBhZGM6IGFkZGluZyBkdC1iaW5kaW5ncyBm
b3IgUEFDMTkzWA0KPiA+IMKgIGlpbzogYWRjOiBhZGRpbmcgc3VwcG9ydCBmb3IgcGFjMTkzeA0K
PiA+IA0KPiA+IMKgLi4uL2JpbmRpbmdzL2lpby9hZGMvbWljcm9jaGlwLHBhYzE5M3gueWFtbMKg
wqAgfMKgIDEyMiArDQo+ID4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNyArDQo+
ID4gwqBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEyICsNCj4gPiDCoGRyaXZlcnMvaWlvL2FkYy9NYWtlZmls
ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0K
PiA+IMKgZHJpdmVycy9paW8vYWRjL3BhYzE5M3guY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyMDcyDQo+ID4gKysrKysrKysrKysrKysrKysNCj4gPiDCoDUgZmls
ZXMgY2hhbmdlZCwgMjIxNCBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9taWNyb2NoaXAs
cGFjMTkzeC55YW1sDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vYWRjL3Bh
YzE5M3guYw0KPiA+IA0KPiANCg0KVGhhbmtzLA0KTWFyaXVzDQoNCg==
