Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5250B67CE83
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjAZOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:44:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911940D9;
        Thu, 26 Jan 2023 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674744243; x=1706280243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d2lIgGVmzfpDMw08aByIETM4iIng/QltyCkqC/yo8K4=;
  b=Xtbm+qSOQqZ3SJITkUeHPWiNgsL0NPDMxVOhEvNFInv7KQxbzoA1K0ZE
   6bNTVOQaiAQj6TWrALhfPXR28Bq8o30OqtZnmQflTaoghWWVC8I/Fqc55
   2XOouFr8GcsuTep+TXcPe9lo/2jipb/cc0MJyQdS2LbMwE2pcnA2h/xrP
   7ovx8Dy1DFgIW51ngWcnNVd3K02uwAeim01PtD1XXcNe/7jHv7tEJE/8e
   G+wRr57+aOcztFZO0/Gb1oLUGZZzg2yvquU/1ZFhSa0vl0AwjANLQYmmV
   FITPhwOuruIwjkxPvra0Gnx4thz40f7/glnRIlpU3qW0B/CQXNls1Nt1M
   g==;
X-IronPort-AV: E=Sophos;i="5.97,248,1669100400"; 
   d="scan'208";a="209379080"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jan 2023 07:44:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 07:44:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 26 Jan 2023 07:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/IMSPvrNstZPOfvbCNzbzxGfUBqM+R6VniNEKy0KlGdfxAgGpZgiLVEpJEMGoUtjXAMqL+XvG+rkLtsqSSfGvgfixLFLhi7Xb5AVr1pieoSd4nU6pPh5k5Cm1mMZ8GGf0zT/gw/QoBrreOP3Ipo1a5FovGzdxN1a05btrzumLoTS/ENHdBkWf5oobQTfnEQwEJJjhCM4hwLdeX6xHMcU71ESP+0Iy/QMP5cvK0PvhaBc0WnmhVeOaRO3OmUI08MAYUpttS85jVP64rVYA6kjZI0WHgk4eF289p2E7OHXitpg9iNkXGwFRZQAOB4zTzcPMIHjoHuNDAUwCJog0AnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2lIgGVmzfpDMw08aByIETM4iIng/QltyCkqC/yo8K4=;
 b=ToveVC9/4g8xwW4r6w6FnawqyvlXnxI1ctXF2owcFdrqsIwHljocd7pv1cmQWSznl2kJrsSG8jH5NBHRSujoc5l+9awUTwB+csNUNOKY9wfOkov57UHzjFJwZNwIPzSLTkVh6H5Cwz4FvfD6qG9AK3K7mbnmzeFKtthNJQ+CD6vybeKgNtz0eFRi2Da8a+BjZXkbuoMeXavqoICA+AD/qZqbKELAgxvWmS4SaeYVXrC1D4INb7JoaZiLsQEA68e4FGPf/4H7a3ULDp5z0C+Cj+M7udRdCNLfLmHNwP719MOLw6/NAKO+La7Q7PRQazQjloC+RHyYoMZ2VfoG2mM89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2lIgGVmzfpDMw08aByIETM4iIng/QltyCkqC/yo8K4=;
 b=RcKUnwXmxUxt3r2Xirqt8yyTl69Xx52vQTAA2/d6m2OXTXhTTp9PP0Uvp/47ZAj0btObp5DbpfsO8mG2fQgiI7LUbVB+BjWGNUEMhwXdiByDSr0b3kVi0fnSHTpnwTo/uVbrDCZbrJ3eaZ5MkxAQq81D18E9NXKVLa7V632qMjw=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Thu, 26 Jan
 2023 14:44:00 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::77ee:f28f:a941:2b8e]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::77ee:f28f:a941:2b8e%4]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 14:44:00 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <t.schramm@manjaro.org>
CC:     <ulf.hansson@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mmc: atmel-mci: fix race between stop command and
 start of next command
Thread-Topic: [PATCH 1/1] mmc: atmel-mci: fix race between stop command and
 start of next command
Thread-Index: AQHZHIcNyVoXsVB35EepqBgIJuxG5q6w8DGA
Date:   Thu, 26 Jan 2023 14:43:59 +0000
Message-ID: <54b0dcc0-5083-3ee9-6536-e58b8c01e96c@microchip.com>
References: <20221230194315.809903-1-t.schramm@manjaro.org>
 <20221230194315.809903-2-t.schramm@manjaro.org>
In-Reply-To: <20221230194315.809903-2-t.schramm@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CH0PR11MB8168:EE_
x-ms-office365-filtering-correlation-id: bcb5e06a-e767-4e08-34b9-08daffabc2d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XI7cvlCHWsocqYTDV0rmk/2NlcqpDSwJHql9ofomMW1dIKPHx2/ErLC4Uk85YX72vEZfbkorF8q7hgm5QfDhh0dyijArtTDRBrEbwVGY5u4ZZ9BnI5wl7GJbw9y1xCqvSXQWby0t59wBqHaQLj9bdrHEPGLP2hzgtPxcZ1j404HyRciJNEnNl68aRX0k84TnHPAcQrTqjZIbF1TRLOvENK5Bajp9S+ILW+ZDUC97GsPbS1kMQ1dA75E/IUBrPs+I9V0Hnv6EY8/eZphsE1E+IbNrX+7MORIcS3uN5Xy4vt0nqbfBLNQuNVWvQZplvkHN/u+NsovEAdjqtLs2dBjf6CoC32NVFKPD0ZDXe0DM94/nmFJoklVPzWC86vY/CUtagr9idN5ABtMGDWeuReyQyYEJd8cNq2s4PceHyOewq6EEJ8EqAkfESwqFkYCpdhyQCgmxpoV3cHBZX9puvSqmVD/IDEZQWzA7oO/itHE9tPdrPnq8FjR7N59YJqeRbY3io2dHBiF2bfFs8l1Lvdz93B9JvAsg36RHCByUbN+FKC3t8Rx03ZwTgKW1wzIU3Jz9PAm4tsIBwNkk6Vo+J5qoem7oJiEyN1Z6M6WN1fD6r0ay0p93ROhWyf/yoAD5zZarLxMBfXcBlpmGTxMMc8Tx1//IMee5XRswkINAO5zCsPlyUrZRnj9ErCoL+oxUv6HGXJKSQYB2SeuwDjwEY3Yss3wvxuZdyKLe5uQdNrz99NM6yGF2x+bmu5CrzuWHn8hZorM+WnT3JCXI1SwrnFjEQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(122000001)(86362001)(38100700002)(31696002)(36756003)(38070700005)(316002)(54906003)(478600001)(2906002)(76116006)(41300700001)(91956017)(8676002)(31686004)(66476007)(4326008)(66946007)(6916009)(66556008)(5660300002)(64756008)(8936002)(66446008)(6512007)(53546011)(2616005)(6486002)(186003)(83380400001)(6506007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTBTaU9FZXBMdTJld2lMb3ZJYVNDNytPaVZpUm5Wa0o1MmRiZVgyUFdlKzNt?=
 =?utf-8?B?S3NwMHBBVnZDS1Ezd0o1N255T1Q1MmNvdjhkL3FLbjZXeU5IYXhTS2h3enlH?=
 =?utf-8?B?dGFVWTV6emRqVXVwVWNNaWQ2ZUVTWExZMGtOTitQekRxQWw4bml5RzFhbDE3?=
 =?utf-8?B?WmNCN0hLb2ZyZlVaRG92L1lmU1RqcTlZT1JoU0VFSXJKamxqbE9FUGdPdmtL?=
 =?utf-8?B?dElBTkZ1QWlERmRlckdGRnBRNmpxbmE0b0IzUmtYZFVPZkp2eFZ3a2FDN2dE?=
 =?utf-8?B?OTlMaDNhemdRNFdMd1hnMnNNTXpwOEFwT21XRVBuMGlYOXdjRVRJYUpPSmJx?=
 =?utf-8?B?SEhKMnl3bTRjM3h6cHNHSVNJU0kwR3RqSklLd29iRzBVeHlMNDFSMnJMUEJ4?=
 =?utf-8?B?TVJRSnlVWG0zdDl2amgyNG1vTG5EVTJwQlcxNlFZMmRXWk54TWU1RjdXcFdT?=
 =?utf-8?B?RE44VzVOVEIzalZQKzE5UlpKWGRjeCtYeTVSdjE2ajJyV0lWZm5NNDNZTy83?=
 =?utf-8?B?NWIyT0MvSkJKSGN3eHhWZXlNNlgzVGxXV3pDVFhnRjhyTUNGWDdGYUpsK3F6?=
 =?utf-8?B?eUE1ZmdMYUNXd3NoWXJJTEpMMXpGMVlhZEQvYml4aDd3QzBYTXQzbkRvaWhz?=
 =?utf-8?B?S0x6T1d3MmJLUmIyVTJKUjA2MHNVcTBFd0dtZUJPUCtQSmIxVmEwNEtWbjVm?=
 =?utf-8?B?R1p0cTlZRURHZ1VpQXQ2aExCZW5TTVM4dFZOYmtZTkNmckFkWTl2ckZkbXJX?=
 =?utf-8?B?VjdmN2VHT2N3NDBMWDNvTFA4YU1QSVBDMjdoK0srNG8waUNNVGZKTE5DTXRr?=
 =?utf-8?B?SXdTMjNOVzNOL1lWYmdSVTFJTmduck1obVBYc0JyTnJqVmRHYjJlUUkreWVJ?=
 =?utf-8?B?UWIvWjFOVm9IaWZ3M2tzMXhoSVB4ZFhZbkNzaSsvSm8vYXZYdnhNWWRPVUlN?=
 =?utf-8?B?QkE3QUh4VTh3MXlZanVvTkdwclFjeDZBQ0NlWndvS0tEazVWSmlrY25jY0lh?=
 =?utf-8?B?a2NGK1pxK3QyeWl2OStLZXFSajN6MEZFTm8wcGRVTGt4dDVPMlQrdko4VEIy?=
 =?utf-8?B?dm1uY2UxUHMvZU9EV2NtVFFtS1h2QnlsaHZNNjlqamlpckt0cEJZYlZkeC8r?=
 =?utf-8?B?bWVBai9jMXJQaitscHRDUllNZjZiWldOSENESE5meUxabXFqNTViTUhWTkh5?=
 =?utf-8?B?TkVRYVV3b2ZPNHp3M0kwWERkK0dOR3g3R3pJVEpMQzJTdzJVdm8yNHhDd3Zo?=
 =?utf-8?B?cndmMkMzcC9iRGJhZE5sQW4yYThkeEN3VWhjM2YzamZCSk9ZLzFVdm9KNi83?=
 =?utf-8?B?VFcwQWxhb3lkQzVBZVBWZGdyRVZWa2pzL1lYaG1xOEhEeW1qVjZKR2hpeGN4?=
 =?utf-8?B?Z2l0U1NkOUhXVzJPZjVkVlpFQTRqTlRSb0dJQlc3cFllVUlYL012NUVKT3NK?=
 =?utf-8?B?VTRkVjYyNHZERmJwS3E1OTZyY3ZyRXVHTzNtYU9BZmJya1pJcnZ6T3NuRkUv?=
 =?utf-8?B?Unc3ekFhRTlNakFLZDBGNDZoQUdvTjdZVEp4aUdJb1NzbWJVbFUxblZ1MnRX?=
 =?utf-8?B?RVVZWVBNblhsR3VCc2VqVS9aWGQzdTFUMTNKeEhySFV4bldPS2w1b1MwWEJC?=
 =?utf-8?B?QU9wNFBwTjlyaVdMTzJ0d1c4TGp4YWRSc01DNEZaN2pMdHVsb1BUWDNjdmpO?=
 =?utf-8?B?NXR6bHI1VTFEUVdtbkZ0MTZQN1dOWndwaWRuYUptajFmN016ZXFNeUhPdkNk?=
 =?utf-8?B?UEhoNVVvUG13QTQyc20rSVdEMkt1c0JCS0RvbVVNOXVBbU5DU3hUaHBieER5?=
 =?utf-8?B?eHBQM1h2dGFJTDYvYk1HanMyNytHYW5iQ2dvWE9oOEVLWG5pdHhpYThvV29v?=
 =?utf-8?B?b2plSk5KRUFOcGUxQko2aG9JdkRDVENicHhNQmZETWNpMGNydFVLNjZLMTdk?=
 =?utf-8?B?ZVUrM25VWWxhSHpJR3dzSXJjMXNKeStPL0dlYmZkREtFcVJMMUlKU3IxMU5u?=
 =?utf-8?B?Z09YOU1oZFlBNXJrS0RIQjM1Sm9uQ2Z1ekNDWm0rQTJkczVTamg3K040Q1F5?=
 =?utf-8?B?TlN0K1dBVjZVZ2pWdFU2K3Z3ZVRiTm00MTB1Nk16Nzd4a0IwbG8zd1VROE9r?=
 =?utf-8?B?UkdjUEdFR1RTa0JtcU90ajFEaUVscE1GSkhYS0xzSXJ3aTV1d1o0eU9SVmpl?=
 =?utf-8?B?bEhRWXE4NVNTOGt4UkwwZlN4d3dhK3ZoeFQxWFZvNklnU0x1aTE2OGsxRitZ?=
 =?utf-8?B?d0N4YWZpVnpCTHNLdmxkYnZDSDB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1F14C777CC954DA67D110FFAAED5FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb5e06a-e767-4e08-34b9-08daffabc2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 14:43:59.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ut6Y3j9AUwOlxOYESfkHljkmzrudbhayrOGQiROD0/1SAU5Rr7vwGvmOSlRfI9aHZCc716ezL2UNEJs+uSf7Bq+iOxwajpYwI6naN7Mc7WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMTIvMjAyMiAyMDo0MywgVG9iaWFzIFNjaHJhbW0gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhpcyBjb21taXQgZml4ZXMgYSByYWNlIGJl
dHdlZW4gY29tcGxldGlvbiBvZiBzdG9wIGNvbW1hbmQgYW5kIHN0YXJ0IG9mIGENCj4gbmV3IGNv
bW1hbmQuDQo+IFByZXZpb3VzbHkgdGhlIGNvbW1hbmQgcmVhZHkgaW50ZXJydXB0IHdhcyBlbmFi
bGVkIGJlZm9yZSBzdG9wIGNvbW1hbmQNCj4gd2FzIHdyaXR0ZW4gdG8gdGhlIGNvbW1hbmQgcmVn
aXN0ZXIuIFRoaXMgY2F1c2VkIHRoZSBjb21tYW5kIHJlYWR5DQo+IGludGVycnVwdCB0byBmaXJl
IGltbWVkaWF0ZWx5IHNpbmNlIHRoZSBDTURSRFkgZmxhZyBpcyBhc3NlcnRlZCBjb25zdGFudGx5
DQo+IHdoaWxlIHRoZXJlIGlzIG5vIGNvbW1hbmQgaW4gcHJvZ3Jlc3MuDQo+IENvbnNlcXVlbnRs
eSB0aGUgY29tbWFuZCBzdGF0ZSBtYWNoaW5lIHdpbGwgaW1tZWRpYXRlbHkgYWR2YW5jZSB0byB0
aGUNCj4gbmV4dCBzdGF0ZSB3aGVuIHRoZSB0YXNrbGV0IGZ1bmN0aW9uIGlzIGV4ZWN1dGVkIGFn
YWluLCBubyBtYXR0ZXINCj4gYWN0dWFsIGNvbXBsZXRpb24gc3RhdGUgb2YgdGhlIHN0b3AgY29t
bWFuZC4NCj4gVGh1cyBhIG5ldyBjb21tYW5kIGNhbiB0aGVuIGJlIGRpc3BhdGNoZWQgaW1tZWRp
YXRlbHksIGludGVycnVwdGluZyBhbmQNCj4gY29ycnVwdGluZyB0aGUgc3RvcCBjb21tYW5kIG9u
IHRoZSBDTUQgbGluZS4NCj4gRml4IHRoYXQgYnkgZHJvcHBpbmcgdGhlIGNvbW1hbmQgcmVhZHkg
aW50ZXJydXB0IGVuYWJsZSBiZWZvcmUgY2FsbGluZw0KPiBhdG1jaV9zZW5kX3N0b3BfY21kLiBh
dG1jaV9zZW5kX3N0b3BfY21kIGRvZXMgYWxyZWFkeSBlbmFibGUgdGhlDQo+IGNvbW1hbmQgcmVh
ZHkgaW50ZXJydXB0LCBubyBmdXJ0aGVyIHdyaXRlcyB0byBBVE1DSV9JRVIgYXJlIG5lY2Vzc2Fy
eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRvYmlhcyBTY2hyYW1tIDx0LnNjaHJhbW1AbWFuamFy
by5vcmc+DQoNCkhpLA0KDQpJbiB0aGVvcnkgdGhpcyBjaGFuZ2VzIG1ha2Ugc2Vuc2UuIEknbSBh
bHdheXMgYWZyYWlkIHdoZW4gc29tZXRoaW5nIGlzIA0KY2hhbmdlZCBpbiB0aGlzIGRyaXZlciB3
aGljaCBoYW5kbGVzIG1hbnkgdmVyc2lvbiBvZiB0aGUgSVAuLi4NCg0KQXMgd2UgbmV2ZXIgZW5j
b3VudGVyZWQgdGhpcyBpc3N1ZSB1bnRpbCBub3csIEkgY2FuJ3QgcmVhbGx5IHRlc3QgdGhpcyAN
CmZpeC4gSSBjaGVja2VkIG9uIGFuIG9sZCBib2FyZCBhdDkxc2FtOW0xMGc0NS1layB0aGF0IG1t
YyBpcyBzdGlsbCANCndvcmtpbmcgYW5kIGl0J3Mgb2theS4NCg0KU28NCkFja2VkLWJ5OiBMdWRv
dmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4NCg0KUmVnYXJk
cywNCkx1ZG92aWMNCg0KPiAtLS0NCj4gICBkcml2ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5jIHwg
MyAtLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L2F0bWVsLW1jaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9hdG1l
bC1tY2kuYw0KPiBpbmRleCBiYjliYmYxYzkyN2IuLmRkMTg0NDBhOTBjNSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9hdG1lbC1tY2kuYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0
L2F0bWVsLW1jaS5jDQo+IEBAIC0xODE3LDcgKzE4MTcsNiBAQCBzdGF0aWMgdm9pZCBhdG1jaV90
YXNrbGV0X2Z1bmMoc3RydWN0IHRhc2tsZXRfc3RydWN0ICp0KQ0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhdG1jaV93cml0ZWwoaG9zdCwgQVRNQ0lfSUVSLCBBVE1DSV9OT1RC
VVNZKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdGUgPSBTVEFURV9X
QUlUSU5HX05PVEJVU1k7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGhv
c3QtPm1ycS0+c3RvcCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWNp
X3dyaXRlbChob3N0LCBBVE1DSV9JRVIsIEFUTUNJX0NNRFJEWSk7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGF0bWNpX3NlbmRfc3RvcF9jbWQoaG9zdCwgZGF0YSk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlID0gU1RBVEVfU0VORElOR19TVE9Q
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gQEAgLTE4NTAsOCArMTg0
OSw2IEBAIHN0YXRpYyB2b2lkIGF0bWNpX3Rhc2tsZXRfZnVuYyhzdHJ1Y3QgdGFza2xldF9zdHJ1
Y3QgKnQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIGNvbW1hbmQgdG8g
c2VuZC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChob3N0LT5tcnEtPnN0b3ApIHsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWNpX3dyaXRlbChob3N0LCBBVE1D
SV9JRVIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQVRNQ0lfQ01EUkRZKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhdG1jaV9zZW5kX3N0b3BfY21kKGhvc3QsIGRhdGEpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRlID0gU1RBVEVfU0VORElOR19TVE9QOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAtLQ0KPiAyLjMw
LjINCj4gDQoNCg==
