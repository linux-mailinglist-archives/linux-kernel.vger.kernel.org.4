Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C72B6E198E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNBWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:22:29 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013022.outbound.protection.outlook.com [52.101.64.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1C3AAD;
        Thu, 13 Apr 2023 18:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9QWIgbXfHAi4vVqxWU/i9HSi1tT69DihWCzaPd84I6HzCiCN9EZTWAzAqSV7a/Z5rCpUSRky/4Vog20Vp6D+zrKaYlaKzMHNdC3wfn5nmLNrst6nU3wkK9YrDrNXcSmXkmyEZ6yG6HYqUwHhOxFsFD7MGUDV9Dj1bi7kEmjbTGSRZPINawzfHWmBl59/w2LccnO+yF83xcLia/fA6WhpL55J3iz1vER0sF8SfF94VjmwTOhAJVf/V4jpIH79RKoSWBLHvGI5QZxoF2OVUmh2evrk77E05GyDmB4H/UQ74un1Ij/EJrgX3sbhkUt/3lJzphVQASudOGOiMXvYAV/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA8UBRyiin6ZRu9BR0ABbjAD9vcB4CQA1mCX5+dguTk=;
 b=g2NkgNwurJNLFjswj8HbG7DNedkdDwMWR9BdRmr5TTAOhhDgLQNgyPqhM/VfKOcZWeGGVhP5PkcZUu54E8kFLDNdig74csfk53OUXy6OqZB9sY/cvuTaDBYXtmnYGrL2e0qrvU8l0mzKbBGUYJOJbiAGJHVBSL2wCxlvRaRxd82pzzFQzKMC0Gy1it1jNw9t5Jmoe0cLjQnhcBes8B3abmf9WSwucox2vJ4mBWjzW0LnPOzrBTm6VRHuLJyfTY93WCEDhfsV/9RQsdKkUSvnmkGh5/OdH/NMVQkadUzrbKDjELTeqGpaAbwTZIIS5sLgD108zQEN8DL5a3xqGdeKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA8UBRyiin6ZRu9BR0ABbjAD9vcB4CQA1mCX5+dguTk=;
 b=c0YX9I4FVhfEePYHyqiNp4JnjX97Ct6Z01LWYzEFaFxyENG9j7oLU+D9fendD6MruyzgHo0lGzej+rB3kshWYGPEzc23W33He6w7wGbK+c4PcqFaoEtPjsATKkF7RU0Ld5h2jUlxOtRT0FHdNBfStB4lyW6TGt3MALebsEX92zQ=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by IA1PR05MB8971.namprd05.prod.outlook.com
 (2603:10b6:208:3d5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 14 Apr
 2023 01:22:26 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::b4c3:9441:f0:efb8%6]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 01:22:25 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "zhouzongmin@kylinos.cn" <zhouzongmin@kylinos.cn>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: vmmouse - add macros to enable vmmouse relative
 mode
Thread-Topic: [PATCH] Input: vmmouse - add macros to enable vmmouse relative
 mode
Thread-Index: AQHZbeXmXmgoR9i+s0CzOvg0t2sCPa8qA1YA
Date:   Fri, 14 Apr 2023 01:22:25 +0000
Message-ID: <36d0b466c96b42f5fd364c2a80379d6d7be9cb48.camel@vmware.com>
References: <20230413085635.2515647-1-zhouzongmin@kylinos.cn>
In-Reply-To: <20230413085635.2515647-1-zhouzongmin@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|IA1PR05MB8971:EE_
x-ms-office365-filtering-correlation-id: 1d9770be-cfdd-44b4-67a5-08db3c86b4ba
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaX41E6AVf3Ksp5Kqt3NeA1v+NI2mwPo0I5QD3pKbCYPzkNGPdQhnSfGQ3HfOk3t6o7iL2pWi/W6L8BpF5+qdMV4OEBnMIzHcPGgW1TEYNa+eOxWU+KD3xQoC16FmEaFJEk4wZgXQ5LmOpmJt20q5oKDVsCPGiosNqLotcEuF9SuSCnUkipvJstLE2efnNnHkUSglHQczuHwOFjWnlvFtcsM7Pr7CQvA4Gq95iFvTIj82kbO4PhOksB5+/X1mezTy9K5TM0y7iRBeGtaSkoO5kkAybSbxSZL3DwSIENjPj4FOvfOld8cJDZpsm/gZB+0X4pdogSG+AzsWGyt58FjmRlJxsDLOGBcDiDK3etNKKY3ZKzlNgP4298DvgAV1baCxFJat0jfd9IExj7W3+b0Tg9Nq5jA1i9iLjgQVNaJjibefuET1AjHp/LSowk/txDb+EX5znFESdIEJZ4MJbYX0Dke5D/VQS7yQcHpsclPpXSD8hH8VRB6kXDy0iDfywwyoiIphmV5WhzYyx1mKTDQ8nD20jX2QzTMLB41MDzCV72OVIGUAN3lz6BPL+IibAOcXuzU3nnjeDQcSOVIE+4YijNvqPjFDY6ANBR6mN4zZEhYvkvD+XTTEUFKPAaD/U/w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(86362001)(36756003)(186003)(6512007)(26005)(6506007)(83380400001)(4744005)(2906002)(2616005)(54906003)(478600001)(66556008)(64756008)(8676002)(91956017)(316002)(66946007)(76116006)(4326008)(6636002)(110136005)(8936002)(6486002)(66446008)(41300700001)(66476007)(71200400001)(38070700005)(38100700002)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJmOGlUdmovTkNXc2ZyZVZEUDVaVVhSd2tBV0M0MERhNzg3Zm1SOWNwRDV6?=
 =?utf-8?B?UFM4MkdPSys5blE3OFk0aUFDazFnVTNYanlEUXVKazFyRVNsUzNpOEI4bmFU?=
 =?utf-8?B?RUlrZzBiZnJlSGJiL1J6NGNzZ055c3hwYUpZaEdJL2dWNjh5anJJRGd5U21G?=
 =?utf-8?B?eDk0Nk5zQWp5ZzdTaDJ0SkFSU1lqVytoYjdUK29YOHE0aFlmdUZUV3kvQ05B?=
 =?utf-8?B?MkJySnBxU0dScDBNRm5ZSHFtb1M2eklCTi9idFJNRnBZT21ZRloyT0tLUGJD?=
 =?utf-8?B?Z0JmUURVRlZiSXNOYlJXdGVIYzN2TEhMVVEzWlkvckNKcGFaWTEvck03NHZo?=
 =?utf-8?B?Y2pxb2oyNm5SVU5EZm5GTmNsYVlpUjFBWHljV05lMUlNSkovVjM3NDJFSUwz?=
 =?utf-8?B?RnNmc1QvblRTUm1GWm1tdWJ5ZEFGUmJ6ZXR0amh0ZVZmS0h2RU9ZWmdQN0kx?=
 =?utf-8?B?UGcvNHowSGtxRTZEcldXVHB1NkJlS0h2eWhsMDRHZXZLVklVYmY5SlN6dEZY?=
 =?utf-8?B?WWt0bmRuSDA5RjVXZDJKVUQ5LzZ2SFpPc0U5bHpxTjZJTVFqNEpMaWpldEF6?=
 =?utf-8?B?T0pQTndDL3dISFBrdDRjSzJEaTgwaUpMYjZmWHJxaHhCaEhITzFEN1lVUWx1?=
 =?utf-8?B?VHFJd0dZY2NZUzVvdUVrdjFBdzdVS2c4ODJ5NHZrRG5GWUgxY1FIbUdKT25O?=
 =?utf-8?B?Qklta0NIMkhWMGE0bEdOdit1bGJBQ0h2blpBNkZwSTFJVjY0alErenROYnRn?=
 =?utf-8?B?Sk9YdzBiSkpzTXQyM2wybytFWTEwdTYxWWFrYlpKMWlSTlFvdGFZMDVDUXZV?=
 =?utf-8?B?TVM3d0QxLzVoWDV4TkNjY1JrKzROZUV0eTk3a3J6NXgzOWIraTZVYUFOQ05v?=
 =?utf-8?B?NDdlb3R6c08vcEwrMUpqQXYwZkp2Y3NkQU1IcThDK2hzeFZuSmpXRmpyT09J?=
 =?utf-8?B?OVJ0WExZWkYxSGt6K0p1d0MyaFUvbnlURHlTU2lPR3Y3eEFldlF2cmpIY0hW?=
 =?utf-8?B?SEN5ZXpkVHZCWFY2SCtQV2haMUhES2JPNHZxZ2hteVZITnViN1VudlJLeWVJ?=
 =?utf-8?B?VVBpVktNSGd4Q0NqaHp3Q1I4dWhPVjZ0TWk0cWFZUkdiWU94L2d5U3pMc1JS?=
 =?utf-8?B?TTFOMUdGcndONjJPSGJtY0xWdW41Y2hwSGVSeE14M3h3ZVVWL2RPVnRkWFpP?=
 =?utf-8?B?QUVNcUFjM2JMdlY5MUJNREtQVEJ3YnhEeHlPM2xvUkNhT1NhdlhqbmZ1NGtJ?=
 =?utf-8?B?Z2VuZGQzT21JQ1VITUlxUER3V3JwZ1p0QlY3UzdualBQS2dPMXN3SzA0c2pF?=
 =?utf-8?B?NStIU1dKVzQ5WDZJV3pzY1FaS01OVzB1Mjk4T085QVh5VWlOczZDUWZlcnBM?=
 =?utf-8?B?U05XMS85MWxnWk45Qm5QZzJ0cU4weFVJK1d1TFRtVTFoOTlxQVA5U2QvSC83?=
 =?utf-8?B?M0dwYUhKYklmaWptMGpzMFIwejZ0YVZyVHRocXNrck96V0drUHBMS2VKU3I1?=
 =?utf-8?B?Ym5HWC9VNGlWdGxMaDFLZlBDV04xeDlZbWg3aUlZR3FvRlhUT0xHZ3NQNUpt?=
 =?utf-8?B?NzBQYkplY1cxYm9iNU5CTTRlUVk4WTVGUDVJSkpuWmQ3NUZReWRwclJQV3E5?=
 =?utf-8?B?b1A5THcyeTlnaDhVQVZwSlBEZ3pveTk1WEt2KzVsajJQQ1VqTmZmRHRNbEJJ?=
 =?utf-8?B?V2tENE1wdjdoc3F0Z2ZoNFdJZEh0MENvQjhBZENYUTVnOFBrcm1MSGxWdUhP?=
 =?utf-8?B?TmdxZUpzZStpUEYramoydTI1UmFGWjkxb2NvM25Dd2F3dUhxNklsMUdmS3JD?=
 =?utf-8?B?ekI1SDV0UnJEUkJnNTVXYlBBcEtMRmFNUW9WSHJGZTFzMzdNbS9hUlJ4SGFN?=
 =?utf-8?B?Y0szOXFwVkE4VFVOTXJjMmpVY0NmMGFCMWZiY3pCVDR3d2cyVDRFTGEwbXpR?=
 =?utf-8?B?SFBUTjBMVU1sYzUyN0ZTYzJ4VzVwamt4U1dFMm1UZWtLaVlLZHJjeEw1VFlq?=
 =?utf-8?B?VksyMXlRN01HNXo0VVRQTno0VHovWWJwMG9rY0pKTVlaZm5reVU0SHQwUXVO?=
 =?utf-8?B?MVRaWHZxYlZrdzFqVHRsWVE5b0YvQ0ZnYWFEclkrYklYeXBPM2lFL05naGtu?=
 =?utf-8?Q?6pq11eG/iiHFMs0+HO9fNTV8q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72942A86A490B340A8BE989E8D628E29@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9770be-cfdd-44b4-67a5-08db3c86b4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 01:22:25.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfJQoUGr739aguEvuuH6o7Qb5nK2A45MfUfJmqr/x3mUqMQip1zZqc2dpayo6ongTI6yM4iP8tBAdqNYbQB8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB8971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA0LTEzIGF0IDE2OjU2ICswODAwLCBab25nbWluIFpob3Ugd3JvdGU6DQo+
IEFkZCBtYWNyb3MgdG8gZW5hYmxlIHJlcXVlc3QgcmVsYXRpdmUgbW9kZS4NCj4gDQo+IENoYW5n
ZSB0aGUgUkVMX1kgdmFsdWUgcGFzc2VkIGJ5IGlucHV0X3JlcG9ydF9yZWwgZnVuY3Rpb24sDQo+
IHRvIG1hdGNoIHRoZSBkaXJlY3Rpb24gb2YgbW91c2UgbW92ZW1lbnQuDQoNClRoYW5rcyBmb3Ig
dGhlIHBhdGNoLCBidXQgaW4gaXRzIGN1cnJlbnQgZm9ybSBpdCdzIGEgbmFjay4gRmlyc3Qgb2Yg
YWxsIHdlIGRvbid0DQp3YW50IGFueSBkZWZpbmVzIGluIHRoZSBkcml2ZXIgY29kZSB0aGF0IGFm
ZmVjdCBjb21waWxhdGlvbiwgaXQncyBuZXZlciBnb2luZyB0byBiZQ0KdGVzdGVkIG9yIGNvbXBp
bGVkIGluLiBFaXRoZXIgYSBrY29uZmlnIG9yIGEgbW9kdWxlIHBhcmFtZXRlciB3b3VsZCBiZSBh
Y2NlcHRhYmxlDQpidXQgdGhhdCdzIG9ubHkgaWYgeW91IGNhbiBhY3R1YWxseSBleHBsYWluIHdo
YXQgaXQgaXMgdGhhdCB5b3UncmUgZml4aW5nLsKgVGhlDQpjdXJyZW50IHNpbmdsZSBsaW5lIGRl
c2NyaXB0aW9uIGp1c3QgbWVudGlvbnMgd2hhdCB0aGUgZWZmZWN0IGl0IGhhcyAobm90IGNvbXBs
ZXRlbHkNCmNvcnJlY3RseSBlaXRoZXIgYmVjYXVzZSBmb3IgbWVyZ2VkIHBhY2tldHMgYWJzb2x1
dGUgd2lsbCBzdGlsbCBiZSB4PXgsIHk9eSwgYnV0DQpyZWxhdGl2ZSB3aWxsIGJlIHggKz0gZHgs
IHkgLT0gZHkpIGJ1dCBub3Qgd2h5IGl0J3MgZG9uZSwgd2hhdCBpdCdzIGZpeGluZyBhbmQgaG93
DQp0byByZXByb2R1Y2UuDQoNCnoNCg0K
