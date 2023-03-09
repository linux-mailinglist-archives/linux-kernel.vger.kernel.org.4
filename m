Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C646B27CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjCIOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjCIOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:51:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B2F5A90;
        Thu,  9 Mar 2023 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678373415; x=1709909415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1SlxO9D+OpFY7zBxvUyXinWVuZH5e9eC/2ro9tagE+Y=;
  b=mC9ozvEtqEBBg9F9nWQ64uIKMEjot/A1vBP9PJ7HVcmHNeTyjQ2nZ++n
   1IQ52oVixJBnATkEQExAKn9GkzI+A/nGDhQq5IWyjJgz97gErCs3lZv8h
   V892fngaXYuefl77lzpH/2G/25ZJi4PwzJvuM2eAAP1ThhEq8/E188clf
   F8AHf0eJYnDIe3kksI/CxRW4hMOLc+KeSGbI3RvS3m2Mztk/jkWh5PfQ1
   DG82yDLydVOpg8+QVI/6FKwjvvk7BHb/iGHaWao5CnMNaO4qVVWx5Yf+r
   RTeQL9yQUMCtqYu6ZT03PevjSZkxitEsKmw9L92EfWDiamAVfdLFWgxxd
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673938800"; 
   d="scan'208";a="204035571"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2023 07:49:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Mar 2023 07:49:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Mar 2023 07:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyovkmwxgHGKZQHdRz8a0rZq5JGR4PanwPOnrOmOe3SbRamAhro6oa5us27GDLnjvzyZfxYCmoZQ4No6h+dD5g9D9TaQiTFGJRbGnXwbMas39Q3g/JuP9+cc+qI3AP/PHULBB69Q7Thv//Wsl0QbEeZuYwEVlP6Qokucr5FojeGESPUh1mbzqizQOKdlgULlcm58ApSLpKCkIHs4jcI6gRJtwhBwTw0Q/CsaAVglUkdKoNsi2iuVrNaE8UFjVTYmdKrlUqau7+VkPkom8mAh+/P6c4Wk975RUt6wJlL/MjSbdIbXUtM/nAkFNZti009MASOHTfC/zRoDC6+JSFligw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SlxO9D+OpFY7zBxvUyXinWVuZH5e9eC/2ro9tagE+Y=;
 b=Itu29tRVc/daa6RE/gDqdAh+Y9NFuy4p8asNqMWzfQAdOlqjqc0+l+cRo3Z+FN+72SyzseZSuElNzn9JpU+dEZbmYC+1xoV0Whe4c35xnu8qXy1tzUBy1wQmwMvN25ucWm4lMZ1O23F7RVZqHxeHcMMxwzlv/A/UFmItvRbJlBkRj3SrSowmiyAz0WOkwS1c5LhQXwsVOpa8ZmlmG5W1AgAO/waG0MIp7Vc/eFOzoCNfEW8FZtLuIeVNQMcBd3X5bQtmBkWGLCXDc13nIF7kQNfTuRu7UEArk0rRXPYIi/Eu9v0bHh0uwweXtY4KnvJsUI6nlMOxOGjjk7wJBYbveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SlxO9D+OpFY7zBxvUyXinWVuZH5e9eC/2ro9tagE+Y=;
 b=KRdJV4gR9XeenroKmuIc0evowIQJ3M18ykuoFr39A0U/m9FrGvFIr0umnAxu9FMTKfCsnEkRNqMr8uszSxB1EPtzP+G4haPifEu07GjMmkvwiKHoQ0QUtGitdI0HAWUmhnWCRNFCKdfatXdsYpM+nq+kedemVUOi3fWREq/xaxQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB6874.namprd11.prod.outlook.com (2603:10b6:806:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 14:49:51 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 14:49:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] pinctrl: at91-pio4: few cleanups
Thread-Topic: [PATCH 0/4] pinctrl: at91-pio4: few cleanups
Thread-Index: AQHZUpZmNMtSVP+SiUuls4L6LEPXOg==
Date:   Thu, 9 Mar 2023 14:49:50 +0000
Message-ID: <77c861d3-796b-e94b-08d4-a9c4e5980dbc@microchip.com>
References: <20230302110116.342486-1-claudiu.beznea@microchip.com>
 <CACRpkda+D-U37LXBd_326gfJhUs+5meOcRH55PsCOEfmFVhBhg@mail.gmail.com>
In-Reply-To: <CACRpkda+D-U37LXBd_326gfJhUs+5meOcRH55PsCOEfmFVhBhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB6874:EE_
x-ms-office365-filtering-correlation-id: e66de716-27a7-4525-989d-08db20ad8924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJkz4wkgOh/La4gtDEiFnyCHQ1ogxfs0T0fKQjFNzZcDGV7JfFgChVtyYVJn7+tSVebuHLdn0z1XGSL8OjfKj8NtTwG6BS1nWXY2Lh5cl5vYiEJEHOYgtUlIhIzuqQ4h29CrozqTwzglEtvdg5N0B/rIhdKF/gRjLLsVe8ytAmelBQOSwEvO+nrcq1OK0lMPkXhVswMfA0Vba7xht0KHtNN9ux/3Yhoa9mYpH1Abk2vYYj+38ZHb4Tz4DE7Cp8W9gdep7dOhtPhpwBpn4ChY3E4biIiSghZJOFSy1lLE4kNZKQpTi9hDOdjr7xH6/YGIG8+WTjqF5c74DJuN+KqdDCdqd0TjmrmjhAYxqa1lA6DiVwanAAeknUin7D7tfEzN1y0+WZJGOwZQ7Ij7Y5ktt3Bl9eCxudiQESDOVdoD/NLCLTQamr5/YT4vj3TR0dBO2w8NWokWkeTp8grhaiMkDBArynH95brUsglr0bNNv0m8CrQ6aiXJDxaapICWHnziQl1Sd5fcUaIbk0AP01hS5fx+OM7l/CTQgvH6RtB6NuaSyp8zYUhngEG9hMnnkrxofItGur+PQsFiX1VbsyDhbCd0lDWrK0oaMefSMHuzfJ/Qi+G9G9dZa2ZKKXw2i/MUKQ2H1pgn+eakRUs0nqwHSWdOSUjf58/ihgb00dU5DtCfs1iaRQGIEHl3ctjM29uVOgPHejqfEZzLLcOwXjmL42t8gkNLdrR45GdFsjiaoN4st2yY7C82u8eDGNXcJSawMw3tD+1XzwsR8CZB0+wexg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(31686004)(6486002)(122000001)(36756003)(76116006)(5660300002)(66476007)(6916009)(8936002)(41300700001)(4326008)(66446008)(2906002)(4744005)(64756008)(66946007)(66556008)(8676002)(31696002)(86362001)(38100700002)(38070700005)(478600001)(71200400001)(91956017)(6506007)(54906003)(6512007)(316002)(2616005)(186003)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE1IN2RWUEVIeGRocG04TnhnQkZXMCtQT0VZU0hYWThPN2EvTW5OTjliU0dl?=
 =?utf-8?B?VnJYTGRpN3JZSmRMeFcrc3FNUS9oKytYL3lsd3BTWmwvaHluY3dlMnhvT25I?=
 =?utf-8?B?SG1hYThpZldWbHVxbW1MUXNIWEhTd21pWndjRUZzcHV6UU1tOXRiMUNSQURZ?=
 =?utf-8?B?amdIY1VuQ21JZXpUYnZXMHdNUTJ0R0dOaFcxQk5mdkJtMTluVURJZHhkTEVT?=
 =?utf-8?B?SllDOTNuc1pxY1RBZFlKajJmUjEwZEwwanh2QXluWmUrTlVmTUxTK0g3blZh?=
 =?utf-8?B?cldHdU8rS1d1THdKVGgyU3F6cEF0QmlpV09oam85Z3VMd3o1VzhETW1tYlM4?=
 =?utf-8?B?VjBEUm9iRDFJYXRrZVdLalZaZjlZNWdkaUwycUhZS0VWSktLSkRxSEU1ak9C?=
 =?utf-8?B?V3h2cGVRTkZjVjl6amdwN2E5Zmgyc0s2ck9Cb3M2Ymo0ZHduSSsySVArK2Fj?=
 =?utf-8?B?UU9rQWU0NlhHTmgzU2RRRnZma3BkSklyN2ppZlR6eDN4cXY5dGRaWG9OY1lH?=
 =?utf-8?B?Wm4wSE9JSDFUK2oyYjA2TWcrTjZ5NlVGUUxnOE12Yks3dGF1Q2dKbXpublRL?=
 =?utf-8?B?bmhJN21TOERzOCtDSGVOL25helhYd3BkSy8vdng3WWx0YUtaazVHWldmaFhW?=
 =?utf-8?B?RFFRMU5DV1BIU2k0NXQxVm5Yb1g1RzR1QjhnSzIzcXpXeDhldzYxdUN1TUZm?=
 =?utf-8?B?ZXl6blZ2L0hZYWtaZEppeTRkY1NLamsvYmlUcGk4a2F1dTFkRFZiNFprSGV3?=
 =?utf-8?B?d3ljZUd1VmZBYXZwQnFkTHVPVFE0ZWF5VzRzM05XT2lZME5qYjNWZUVCb1NQ?=
 =?utf-8?B?NlVGOWpaaVJsRi9CTzJuUVVveDI1OXdmSU16M2t6QlZMRmlBaW0xdUs1NmM2?=
 =?utf-8?B?NDNtT3Zxd1l2L01jOEkrRmNWcHVVaUsvOEtlV1dVMThWYjNXblpuQ1g0UmYv?=
 =?utf-8?B?bU44djdzK0hDUzJBNC9rZkRPU1o3aExDWEZZN0tEUU52VGd1MWZxUUNGL0t3?=
 =?utf-8?B?MVc4NmZUSGVKNXFuRkhIY3RscTkwVkJ6QTBmdzFZaFQveVBjb1RrUjZJUmMz?=
 =?utf-8?B?T0l3SmNIdURsdDUyRW5URW5ZZHh5UGx5MlRHRG1pZldpOXcvVmNhdXpmVElF?=
 =?utf-8?B?QzVJMkNkVVNtajlpRUs4YnN4dEE5enBKTW5WeVhKOVdLMmVxR0k4Rno5RUZG?=
 =?utf-8?B?T1J5cEYvanV6bHVXeXdmS2FwYklmdlJHQXlReG5HaUxjVkVycHJjMnBGK1F5?=
 =?utf-8?B?ZDMzMWUxSHAzMU8yWW9rVDRhaU9hMkFLQURMYmpsV09IUXk3OXFJZ0dOTjhT?=
 =?utf-8?B?bTdwS2ZlRDh2cExEVG9JYU95cjJDR2o3ZUtlS0UzWlZHajBoZ2tnZ2tFcjZS?=
 =?utf-8?B?QUtKU1lKdkt4aEdzd3djV0owRnhsZ3NFME1MWjRxZkZzNkIxb3Ira0IyWG9S?=
 =?utf-8?B?S1Vzc2N0QWk0VGp1QWM0UFowT3dpQjRPWmExZGl4UWFObUJ3RU5GdVFQZEhr?=
 =?utf-8?B?YzJ5Nk54UmwyTG9RWXVlTm0rZk1CaWhoblUxazFVUGNQS042Q1hkTVRZendB?=
 =?utf-8?B?M2xvSXQrQWY4RWYyOXo0aWFJejlEOHZnSlNrYkFDcXJSZFFxeWk1c3FKSUhw?=
 =?utf-8?B?OWpHekR1NHlucDVoVG00VEZucDN0UW1jTUF6RkVDWGM5TEVRRHpEak9GRlh6?=
 =?utf-8?B?Nll4N01OWThtZngvZ0ZzTERQSDFUdlZNeWdMRkgyRU9aWW1XdkRwRkdNenBF?=
 =?utf-8?B?MTFteFpJNThTUlVqbVV4YlZyOGNqZFVONG1Ub2dSdWk2KzAzOE9sT21aUzM5?=
 =?utf-8?B?akQ3eExzdXhaNDFPeERUVUJDUlJ2UlRJaWRrdjdtSnh1c3ZMeitDc1NGamZQ?=
 =?utf-8?B?WDF6L3Bjb1dEZnZlUXdsUTVsZkVvN2hPek8zdE9tZEdjNW05aG5wRFhhdkMr?=
 =?utf-8?B?WmtwYUZNZmIyRzB1QlBsWmI4MW53aWxncXg2R0RRVlJ6MTRmMmlKbmxVUVB0?=
 =?utf-8?B?YzN1RTRqWXFOd3ZhWFdQdDh5ZlE4aTVOWkxVMFRRUlVnaitHVEJBSjVWOXla?=
 =?utf-8?B?TXpnM3BiTjR5dDFWZmtZQ2p6bkl3V3ZlNnk2RW84LzhnSDFpdzR6eUxjWjVQ?=
 =?utf-8?B?cGo1TFNSUTRMYndyVUN3cW1nbFp3MUt5cXZyME9qWExnTmg4ZndJaEZsMlRK?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F41EABA14F14CA40AFDE87D43F35AA4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66de716-27a7-4525-989d-08db20ad8924
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:49:50.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU97a8bksXpmtGM+Or9G67o0sMHxeGn2j/cC7bOaTAvc8DoaKCt86zt88f5cQuYCZ1W7TFtyE4LB4q2lDsjh5l6C+ypeVwk3eHGG3llEoJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMyAxNToxNCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDEyOjAx
IFBNIENsYXVkaXUgQmV6bmVhDQo+IDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPiB3cm90
ZToNCj4gDQo+PiBTZXJpZXMgY29udGFpbnMgZmV3IGNsZWFudXBzIGZvciBwaW5jdHItYXQ5MS1w
aW80IGRyaXZlci4NCj4gDQo+IFBhdGNoZXMgYXBwbGllZCwgdGhhbmsgeW91IENhbHVkaXUhDQo+
IEkgaGFkIHRvIG1hbnVhbGx5IHJlYmFzZSBwYXRjaCA0IHNvIGNoZWNrIHRoZSByZXN1bHQuDQoN
Ckxvb2tzIGdvb2QhIFRoYW5rIHlvdSwgTGludXMhDQoNCkNsYXVkaXUNCg0KPiANCj4gWW91cnMs
DQo+IExpbnVzIFdhbGxlaWoNCg0K
