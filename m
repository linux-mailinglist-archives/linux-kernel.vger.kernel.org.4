Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E756A9602
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCCLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCCLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:23:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA9F4DBE6;
        Fri,  3 Mar 2023 03:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677842622; x=1709378622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iMFmFkycoMvdiugOm3l9bRfBrN0TnlYxnmizKQg7Bk0=;
  b=iSJlnjWEAyPM2noaXNJbr3IFqpMl9CN/cLegzM7i6eWES5KnbqL2e+hi
   zu1UyyraqYA7L7LO/5TwEcsaECb17B/qRfKtnRUSm8mmbp2cOmsxeTCr/
   btqG64JDUu29aIpm7zL3w+Fj/hKgkevRfoomyArTYV3Yd1HEEe9gcPsND
   g9KyVTsN30uMtHJkpPMgpUCmjZ3lSmlCr+oFmQ9EXvDzsc60YvMsCurff
   Nr91h2/H5C87BD10coCISiKosUt3wkCeBBVSD48cD25oA8cAV51dnMuua
   mClE/vMiGfAGrNIQ7lYFNo9qM13JuXcl92o+ppOOHbRI+aK8P9aW5WsEr
   A==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673938800"; 
   d="scan'208";a="203463407"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2023 04:23:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Mar 2023 04:23:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 3 Mar 2023 04:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc8O9cnzXI6uwRRGPU2zdSP6F1dlGJh1PLzrONH9eyzQpkz/vCh5k3l95deEI7/vQuyKaObX5cGlJ2pjeo9+cTS+oZDTEOEVz9r6tdXgrQS1mVhNXRrEHoMH/+EZGXtjcjaziqNxuS1jneLk5cXWA6CuSUTWKj6BDifWeZo+t1NithW2su7QYGYpxQ8iyVkxc9Beed/WNHlZfn/U1YVQYPWv0pLhlFA6QfpD9geMOrxA+YJXtNrEe2TI2Mug/9d2XFSFdPPvgJmgfNmwWB9YEjjTFza9gwPty/s9jLy8pG2XMt5V459qZMDvgRpETfj1yEPNLADV6BUj8MF2Aiya0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMFmFkycoMvdiugOm3l9bRfBrN0TnlYxnmizKQg7Bk0=;
 b=jtO+JvCK6hjiDWcuofnhYTrdntVtP8nv9y4zmYAalGG/AnpZH6cBYdwTPL2ETlDnIP5fZh4oJBwRnLhnMbWlwUozUtV75VdWq8fgcI5qzKXbOHstVCZ+KWmtA/qiy8ug/uy+B2ZvcqdXVeLf2kqiYaEh6YMT2HagCZ/82+jVRmh7dypwepHcGyUOrqzYsBKPZsM+SoTYNVRKJGpSwRwpbweIXaa/9njzU/668wz4JVCJNlkK4OngGpi6MC4trVaPFa+JoQoHjx4AvwfiTcNfeOd7+EfY26SrjH1oSO191TI08kqnhDD1JbqYxbUXdvrin4Zjpb9LBM57kkS+j0GYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMFmFkycoMvdiugOm3l9bRfBrN0TnlYxnmizKQg7Bk0=;
 b=I7JvDhVUU5j/2EHh+4kRiIi0egnUJwq9wCLmNY3SlKwkqWLvrE4rKEpbxZzq520PYOnjS/NsWHrVhl5YTnVlFOXjIAYHouU9puj2S/I3urxcm3AultPYdXtaX5IqSXbPfjT0JBHNkEHh5Db5eLpIxdCeJ1Bo5mn/N30zjPRZoCA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 11:23:31 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 11:23:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <nick.alcock@oracle.com>, <mcgrof@kernel.org>
CC:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hasegawa-hitomi@fujitsu.com>, <tglx@linutronix.de>,
        <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 19/27] irqchip/mchp-eic: remove MODULE_LICENSE in
 non-modules
Thread-Topic: [PATCH 19/27] irqchip/mchp-eic: remove MODULE_LICENSE in
 non-modules
Thread-Index: AQHZTcKVl4OU8yQehkCyN2rKrs93YA==
Date:   Fri, 3 Mar 2023 11:23:31 +0000
Message-ID: <fec2bf49-c770-5356-bb18-4e6f5e1331be@microchip.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-20-nick.alcock@oracle.com>
In-Reply-To: <20230224150811.80316-20-nick.alcock@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA3PR11MB7413:EE_
x-ms-office365-filtering-correlation-id: 3a0db84e-2c8a-4c91-eccd-08db1bd9b830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4taD1QJjiBnZWW1hV0zRBULk7AOLt61rKR+HgHPs0j1CFUu8myj2wHAKmZPE4uOcrhIlQcuBWyZj921ay1HRDf4ziwDDQBn4W+PTaRAZRZI1jk6APAXMTDqXN+fmji6dl96Rf61KsEt+rBrxUdlUDL2IpKoQMaDyUB6X+f5oyNe+XuQOaXYAsOTktZ480qnAwGVjv6m6L6QblXfOgy5odpMqhETj6LBr9jdJVyjBjQiOJh1H+v1BWMzspS4GwniPn6W2JonCA2vMxJTBpGCWNjqa+PR7TpBmtR3JWJ2/ZicxECk071YZQXn0rM/+TtwjrB3/nmUSJpZ3sqRpGj2M9Ivh9bChfuEKYXOFRs/o1+V6q9E/D9iKHZPlmgcgkh5KlPDcaqfqLa2T3IRaT0ljEZI8XWh+TvfT65Jt1XnlT6fDo12WRulwpwIOBm6mbm2ogfFzmMP5b8BEWQzHVLiNzTcTam8Qab+dCbd5Z2Lx/6JMzQyr/dugxOhLLqLoQ4U/VRlGhJ3ZT9aQBzgncU36LBIV1sQCvVd6tam8PmqoPvQHVw7TX1rRL+idDDUFzxVrUvuoIZZiHsQ/oLe0YlrN3YntCaaDr3hmlVhPf5FwO3NN0HFvtl5W5upCQQmNTuieX8yeC1ZY5uPQe5AE9UTJmfrAUcSoev/EqssU3DZK1XWvAVwD3ENHlwtfaZj4pjfT4S12M4OWE9WBefmoti8drgpsxptesa6AyVlMLW13sdxRpEcwdawfEpPZ3E9pWbd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(5660300002)(2616005)(8936002)(31686004)(41300700001)(83380400001)(316002)(66946007)(64756008)(4326008)(36756003)(76116006)(91956017)(66476007)(66556008)(110136005)(66446008)(54906003)(8676002)(2906002)(38100700002)(6506007)(478600001)(53546011)(71200400001)(6512007)(26005)(6486002)(122000001)(86362001)(186003)(31696002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmpsR3NQRnZ5MHZCM2dyMDl4Ui9DNU1uSjhDREFwUEFkdElITG9DMk1YSnhM?=
 =?utf-8?B?ZFh4Wk80RXFFYlBRN2o3QWY1SVY2T3pJb3VJb1ZCRmtaL3BkNDdwZENVQ29q?=
 =?utf-8?B?VGdpUCtBdU4vV0EwU2R6WU00alVRMUtpRTUrYjJaNjBtNVF6UThNdVBRUEd4?=
 =?utf-8?B?dnNyTk5xeG8yZE12ZjNDVk5LVHp1NkRFeTBxeVZnd3ZyaW12cklwTFYxNTNs?=
 =?utf-8?B?Q0Z4c1lNbENONVpnMTlsNkRmT28rK0QrZE5rQ1F6RGpVZGMya0gyd0g4bmJX?=
 =?utf-8?B?eDVZd1FZWjdXTk9rNGhNUTBKMDBQY0VYVmZ4WVJlMDJjNG5NU1B5Y2ZZbHpV?=
 =?utf-8?B?VDFRQnZWY2hiVGFhem9RUXBZb3g4cmNkeU1XWUliR1I3QU5NaWNoT0phbk5E?=
 =?utf-8?B?LzkyODZ5djNIRGExeTUwQnBvbE1VOXBneGhHYjJNL3dNV1VNc0d6UFJ6djFz?=
 =?utf-8?B?WGNwOEJSeGxiSkN6YWF6b281NGg1QkFCVU5ocVFYaFIzZkpOWGF0QklVWUt5?=
 =?utf-8?B?Y1ZPWWNOdjZGNDFidE1mT1hrbXRmQUhLVGdLeGxMZ0xIYTdSY0RqNkd5ckd5?=
 =?utf-8?B?NklYU2dHZzdMZ1FydmhsRStmZXVXM1gxdTZQTGhSSVMyVThUM1paTzdWdGdh?=
 =?utf-8?B?K3QxWEszVDZneDdCczBMVGpyR0RKUjNDTWJKVEo1d0J1dmhoTlFjR3Iyejhj?=
 =?utf-8?B?bFUxVVdLREtGa1JQd0plT3piTnJWZ0lzaUx0bnNBbUVoOElRdmQrYzJaSVQy?=
 =?utf-8?B?SDhhaFJ5SGZxK2szOThFaitzK2drSng3a1dUcGVKRXFFZ3F3bjJIbkdWeTBM?=
 =?utf-8?B?NldVQkoraDR1Nis5NzFucmFNMmF5dlQ2UmwrZDdUejNtSUF2MjdUb0dsTW9S?=
 =?utf-8?B?NUdZQXFwNFhTSkgwbVpRQ3k0OThCd0ZjVDA4c09udklzd2RsQURva1orcTlD?=
 =?utf-8?B?SlpGMUxRVUlhZ2hrOHBpMTZyUXhTMHJneGlWQUlMNlFXTFg1QTc1UmI4VlBZ?=
 =?utf-8?B?L1lEYnVrWFlxMy9mcGVxRkdrRiswVU50NERoWVVSWDVaWjJWdThoMWx1NTJR?=
 =?utf-8?B?RGh1V3Y1T0oyZXNwUmFoYm83SS9xaW5tVjFtZG9ETVdhUW9vR3ZwR1BMaGtn?=
 =?utf-8?B?eHVoSDBzVklxUldJS2h5dGJwS0k1RTV0c2pnNjRMY2p2OUlGbTdjZ3plQzc0?=
 =?utf-8?B?QXM4ZHJleEcydzJCb1MrTTNlNzIvdmYrL2RLRURYemZjNjJxZmNrUVVLbUJv?=
 =?utf-8?B?S2lJbURHc3dSd2d3N3lkdUthTTd4ME5pV2h2QU8wRWR2WXd5UWdPaHlRYlc2?=
 =?utf-8?B?L2xXdkd6UHBsZjNxWWc2ZzZJbXJGenJPaWtJb2FGNmpoTm1SbFUvNnNROWlV?=
 =?utf-8?B?Ums3KzNNWkFHTFpkcmpiRXcwZll1S0FQbmR5K3hETUp4NnRkemZSZGlRcmRm?=
 =?utf-8?B?QTNOelM5QWhYYUk2VTZtM29NQnZENjRBSWZsaHBCa3hhZEUvWDlJZXBvTklV?=
 =?utf-8?B?dDJ2WGlhcFA5VTlKMjVNbjh4eC8zbkdWdzMydDVCaWQrZjlCRE1naTVWNFBL?=
 =?utf-8?B?SG9UR2FTeWI0SytjVFFSRTlRei82RkwrK3k2VHR5OE5KeURZK1RGR2NId1ZX?=
 =?utf-8?B?OGhvSzArenF5cWlZTUl1QzNCVWhqY1QzbUtCN25sYk9TdjdnRXRlM2tQc0RB?=
 =?utf-8?B?NENBSzMzbGE1QXp6d2NQemcxQnJrQXdxenJNeEVPSVkvOG41VzkrOXJ5S2Rn?=
 =?utf-8?B?VVFiQWN4aUZKL25zQVR2TytvbG5pMEpRR2RWOEFmejVGYWs3aXcyLzl3N2w2?=
 =?utf-8?B?MW1qM1h5TDFLYnJjNXljMVk5RDF0ZU5QRUpLd1NHeWRCZWxQRStPLytoRWRG?=
 =?utf-8?B?bGc1ZmhBcGNZdVdwNkR2cG1FcjRQZkMzWGZ3TkZwMUY0bDduQ2xKMkl6TU1S?=
 =?utf-8?B?TkJySmpaVklqaFpEc01hR1J2cjFKRVZEbU0wcy9xaU56N2dWK0VscEVsRk5C?=
 =?utf-8?B?N0QwTkRpYk4xU1FTZjQrWjNQdmEwc2lOZ2JtQWNNM1Q2VmlDZjl1RnZPWElJ?=
 =?utf-8?B?NUZ1S0lQNGdKelFaTGRzUzlPZzNKcGgvUzBIbmVIdzM1TGZYNHIxbVI5VGt6?=
 =?utf-8?B?NVZRZ2tXRUwxY0tQWGI3bEJWSkNhN08yL3gwRWY1bk02MTBpd3VuUEU1RWJP?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D6211839151BC4CAB3DF0FDAB4DD93F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0db84e-2c8a-4c91-eccd-08db1bd9b830
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 11:23:31.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UsbLo+6ClVAKbDspUvc67fovu2PkJzc4H6uCxvgZpKcnsWDq+D5rLgC4FMGsPTWLImbcE1TDchFb/SRX/Jboq6+fG3Nn94kvls+ejqYToU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQuMDIuMjAyMyAxNzowOCwgTmljayBBbGNvY2sgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU2luY2UgY29tbWl0IDhiNDFmYzQ0NTRlICgia2J1
aWxkOiBjcmVhdGUgbW9kdWxlcy5idWlsdGluIHdpdGhvdXQNCj4gTWFrZWZpbGUubW9kYnVpbHRp
biBvciB0cmlzdGF0ZS5jb25mIiksIE1PRFVMRV9MSUNFTlNFIGRlY2xhcmF0aW9ucw0KPiBhcmUg
dXNlZCB0byBpZGVudGlmeSBtb2R1bGVzLiBBcyBhIGNvbnNlcXVlbmNlLCB1c2VzIG9mIHRoZSBt
YWNybw0KPiBpbiBub24tbW9kdWxlcyB3aWxsIGNhdXNlIG1vZHByb2JlIHRvIG1pc2lkZW50aWZ5
IHRoZWlyIGNvbnRhaW5pbmcNCj4gb2JqZWN0IGZpbGUgYXMgYSBtb2R1bGUgd2hlbiBpdCBpcyBu
b3QgKGZhbHNlIHBvc2l0aXZlcyksIGFuZCBtb2Rwcm9iZQ0KPiBtaWdodCBzdWNjZWVkIHJhdGhl
ciB0aGFuIGZhaWxpbmcgd2l0aCBhIHN1aXRhYmxlIGVycm9yIG1lc3NhZ2UuDQo+IA0KPiBTbyBy
ZW1vdmUgaXQgaW4gdGhlIGZpbGVzIGluIHRoaXMgY29tbWl0LCBub25lIG9mIHdoaWNoIGNhbiBi
ZSBidWlsdCBhcw0KPiBtb2R1bGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljayBBbGNvY2sg
PG5pY2suYWxjb2NrQG9yYWNsZS5jb20+DQo+IFN1Z2dlc3RlZC1ieTogTHVpcyBDaGFtYmVybGFp
biA8bWNncm9mQGtlcm5lbC5vcmc+DQo+IENjOiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2Vy
bmVsLm9yZz4NCj4gQ2M6IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBIaXRvbWkgSGFzZWdhd2EgPGhhc2VnYXdh
LWhpdG9taUBmdWppdHN1LmNvbT4NCj4gQ2M6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUBtaWNyb2NoaXAuY29tPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+DQo+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9p
cnFjaGlwL2lycS1tY2hwLWVpYy5jIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtbWNocC1laWMuYyBi
L2RyaXZlcnMvaXJxY2hpcC9pcnEtbWNocC1laWMuYw0KPiBpbmRleCBjNzI2YTE5ODM3ZDIuLjVk
Y2Q5NGMwMDBhMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1tY2hwLWVpYy5j
DQo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtbWNocC1laWMuYw0KPiBAQCAtMjc2LDUgKzI3
Niw0IEBAIElSUUNISVBfTUFUQ0goIm1pY3JvY2hpcCxzYW1hN2c1LWVpYyIsIG1jaHBfZWljX2lu
aXQpDQo+ICBJUlFDSElQX1BMQVRGT1JNX0RSSVZFUl9FTkQobWNocF9laWMpDQo+IA0KPiAgTU9E
VUxFX0RFU0NSSVBUSU9OKCJNaWNyb2NoaXAgRXh0ZXJuYWwgSW50ZXJydXB0IENvbnRyb2xsZXIi
KTsNCj4gLU1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gIE1PRFVMRV9BVVRIT1IoIkNsYXVk
aXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPiIpOw0KPiAtLQ0KPiAyLjM5
LjEuMjY4Lmc5ZGUyZjlhMzAzDQo+IA0KDQo=
