Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E95BF5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIUFv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:51:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8137E81D;
        Tue, 20 Sep 2022 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663739481; x=1695275481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tnp71Mfhxsla/6quw0FkWDbCVSclOpIWm9Kc6zK9uts=;
  b=mVvMEsFElXp7GwgbpH2M55fjuw2WaoR9+ig/bNy4XKiOW7MpZsADzrGW
   8HEnzdWwPd3taWc3yTDEEgpngUzoQDDOMWKA37/zjZtTUqDVaH8dYo3rN
   6rCAGXwnrtrs37QbqWpfWO8xlSUXWY8B/LCzPn7Q1LEV3QvReD1dugLen
   X8J7URM+As4VcfXDUwGxIMhVRQf1vvQd7ckSuDBWiVWoV/PG9GHFYZIs3
   +kqYzERYL82RbPQOuBBoMa17TJ5Q8DeLwqon8Xid/ZbITSPJKBrUEzIly
   MgF4pw/q/uFKnqzNxSwYceWKSZkJBFUo5oY8IOMAqf11RzftTfn9Erht+
   w==;
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="181265715"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2022 22:51:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 20 Sep 2022 22:51:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 20 Sep 2022 22:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1jUiuNgTRn6h0x2BRvh2Kxz3Ly+rqkprFBozK3TWukhVMvEEQ2I3+fYTXPwEblEPdEzKm4qM1AJuaYhI3xtqS8FsQ/rkrf8oZP7yx/95OctytkzAVJqIGDzxKZFzdF+kFOQVBXyuzKyM59utWq4ea2n7xNYHh/5RFq6UzMe6Yp/wC1ffqKnWj7ZNvoiGJnDUM/8rgHBqIInDjRJU8WBZkHBe1xRCNdMWyzrEZKzaO85ctcYygzhGbQ9TQ+HZ3Y5pKrUfxS11uwk6ZLkzZODs/f1aQgdxaLydu0jM9yCkaTI0InLYY0myvxBc4KBPn5XxLsGuBdxrc2ke3k49WGo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tnp71Mfhxsla/6quw0FkWDbCVSclOpIWm9Kc6zK9uts=;
 b=kHF5MvinmGfgz/PwNNkKocJIpJ//oh/zLH3o/oEHRp8+V2yCdbTUSCdNtShPHNnt9SDUYXAqR++/AHLnYLllmZKyesP3GTTHwFCJiYcFRaEvugvFEM9OZYIMUmXCo/SlSe+WKQ8PV6GcjvwZAUoYLxvV5L7mun7TcpL/yqwsq6jUa0uy5KFpmBaDP8qV7ABhVQUt+kUqsVlgM9kvIbcMoBghgu9lG6ho5ydPJpt7e2PEdieeDCUSQmo2fUniUp0R1LYMdDN2M8M325wsInFLajLPTzRSuSADr+5e6Hys38e3VyETvOi+J2X3PoRjmOtbRGSAXhzJHa6xzvtqfiwgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tnp71Mfhxsla/6quw0FkWDbCVSclOpIWm9Kc6zK9uts=;
 b=WaP6HdFyt4KGTJpo2sOoP4E04wYOpSn8gQGx6V+BA4PVX7her03TbcWIJPYrMkOC+ssaxGriA6gd/Km1cLKfj9eIMZWxYHQdlgnZB+07ZMZxxpnsgLSRd/tMH1rdzrj2GmsvKBTTPqvLGHQcio9J6nFAPUyVdyiSTp7x3DrmK6c=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 05:51:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5654.016; Wed, 21 Sep
 2022 05:51:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH v4 9/9] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHYzX4orIW/D8J/FEGjyCLG2o41rw==
Date:   Wed, 21 Sep 2022 05:51:13 +0000
Message-ID: <342f5733-25df-9409-2a15-47b3f801a4a7@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
 <20220919150846.1148783-10-sergiu.moga@microchip.com>
In-Reply-To: <20220919150846.1148783-10-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|LV2PR11MB5976:EE_
x-ms-office365-filtering-correlation-id: 4c45b138-5a0e-42e1-1477-08da9b954ad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qS46j2qJgjOswtd3H/hlT7+imRtfwXzbWOsuEG1ZS3X68QyXbkIub+1+0c+6WELG22mcWb5/J7MSnkl5Jmjn+AqO5waZ61YzkU1R5KA8TZOQDGQmSFCYFJUQFCJMiGm/tua5qGSpGQZ537hCsyTH+lHTyzBOnYyO0/zUXM3PF0IcYPUcsaGajh6LEti8tSsLCz5689Uclg30O0mUulx6/orpeCB4fEzxzbmq3wt0EBWBvZa0BKWkF9oRtGLWEDTmBpq+rHqUhuuPXkAd3QLvYC7olD/t+9LZL2KsmOJdrVvgfgxzD0Gd+YZTThCOftgI8/Fc6dzj0ztz/SKBB6UBTknWL6tgWqx9RD2KmeiPjER/eC0qGTCUF6OnDkyVqsTtFY4tSA1HCzPOz9tblYBk4q209O/RazyeeCjGnAUyWkjRXEy4V5FDI75fu9jH3wnZSGHjlIZ1aVUcOEMKexoM8TEn+B3MBvIMFyUqj6z81TDfDW8rXa3dsI/zAHTEw3WWag/UCsq/kxOEu8fDuzCjSKWqmt/pPlwUXgjYKRhD9O8kDgq+K8Q0M5/z7Hr2Un/hrr/r1mfheOWX1yFn4BVvlLt2YZLKbBqikE4F9JwXtWbUJ4TGnxc/rw63rHsVd1Bc48R2Iim6eUNXmVc3mtmbgwYGtGL57Jqi+2D27lTbn5iYcwWRV0D6AwBHYalusOq/HJXFUkzo/lGfHn24u4UJL/Ib4sMo+/DMuu6/qTszbcV5MxxzsfM13rM/CuXrMKZNaN66N9eCCCDMyixmGpfutDonn5h0EuKB9AIsIzUrQUQn6wZ8iYyFyiLrb++0dHLyCc+gE2vkNRQup0OWkx9hhTILIxHRQrkIp5OhZpXnXVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(31696002)(5660300002)(8936002)(6636002)(7416002)(86362001)(64756008)(76116006)(316002)(110136005)(8676002)(91956017)(66946007)(66476007)(66446008)(66556008)(4326008)(122000001)(38100700002)(54906003)(478600001)(83380400001)(41300700001)(6506007)(53546011)(71200400001)(6486002)(2616005)(186003)(921005)(26005)(6512007)(38070700005)(36756003)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9xSm13QW5KZWRrYVNnM21tb3luVTFIaGJJSFBFWU1YZmlXc3pBWEVNQ1NZ?=
 =?utf-8?B?bldxejV0RjhWMGdZc3B0SDNROFBKMUowallieCtWWit0cHVKeWwydlNOUFVJ?=
 =?utf-8?B?TS9DcFVBcCtpSEdBSmk4WSs3TUVyVitlRWVDZ0lTZkhkd1I4blhlSmswTzZW?=
 =?utf-8?B?RXlGTGVjZEw5RU9BM0FQNXBRWDN0WUxnZmlzQy9FS282bFRZSE9JYUJBdnpx?=
 =?utf-8?B?QXNaU091TEhMamJQNFA0cGo1QmpFWmczYkZsNGt3R0M3UUFNdm9BZGtCQ2Q5?=
 =?utf-8?B?ODdCcklJZk00bXpJSVJ3TlhPQTJHRmJmTHdSWmFFdGxFZ25OenJQWDFWSjlo?=
 =?utf-8?B?UlBLaVhvbHI3cSs4REZaTVRLNzhpRU8rdGdtek9hUXlubGZjVGJLanFFQUcv?=
 =?utf-8?B?cmRMMUV1WWNTNHFFWmZjaUxobEg0QXFpdlhZQWtsemd4cllhVC9CRFcxL0RE?=
 =?utf-8?B?UTFaREgydUR3ZDJ0UW1PRktFbmo3N2o2ejdaR3RPbWV6SW9UQmZkL25qSWwz?=
 =?utf-8?B?Z0wwL2dHUjdHSTRQRVV0MEdyMzdwUWlrdXVnVzREL1o2YTlha3JlQ1JQN3A3?=
 =?utf-8?B?RGpMM2laUkJmOS85K2lVQ0tVNTdhc3FtSUwvRXd5Mm5aSDhPZkNJM0Fmbk1x?=
 =?utf-8?B?UER6VXZpcUt5MVpjWkpzSW41WDBHVXZON1oxc3JtQnlUcnorWlFsQi9Cd2NK?=
 =?utf-8?B?ZVd4S3dnRkFsS2RXUTRJWTQwcGpFS3dwNGxtSFNJMUdPZElpL0QzTThFaXZU?=
 =?utf-8?B?Uks2Zk9wc1JMZFdYR2ZpVUx2WWF5MnIyNXBiL014MWJiRjIrSUFiUmF5SWE2?=
 =?utf-8?B?dytsSmJVTEhzYXZ6d3E3aDNDTFZZa1IrTTRLaGo4MEwwaUtsS2gzUkIwcWlz?=
 =?utf-8?B?MHltSXQ4eEtxbkMzamVROEdCYjdmaEpXcUtUT043Mmo4K01kYTkrM3RtTHBH?=
 =?utf-8?B?c2xUZGNxUi8yZXhhZ2RqdnMyeUZ4WDBGSHFjSDVUeTFvck45L0hQSnk1NkVr?=
 =?utf-8?B?VnJXcmM0QmlxcVBrRWFRcko2MHVIbksrV2RwRWVFM1pwUEVUSUJadFBUcmYr?=
 =?utf-8?B?MWJlWi85bEMwalFUMWRKL3NrMHNrWlNYc2x3eVJ4YnJpcmlPUmpwODBTZU5q?=
 =?utf-8?B?djE4UDg0WlVsTWl1b3U1NUpBRjFiZG92aEc3ZlEreXpRbXRWdFBZeTBPTjFP?=
 =?utf-8?B?Y3kzaUt6VU5DQktvcVhibFpLR3R3U2JLQ3NwRTRSUVkxUG82dlVIazFvaWdL?=
 =?utf-8?B?N001UFBkOUlXSGFhL1ZGZVdOK3dPTHg5d05iTERDWmdXRjdwMXJZQ3R4N3NU?=
 =?utf-8?B?Z3hQMjhsY010aHV4VWU2ZWE1T3VZWmR2TU9zY2t3T2VrZXJGdzBpbWhzcWtT?=
 =?utf-8?B?SnI2SEdVNUpOVUpFR3RQS1ErK1BXNGxtd3drRkUyR3NZOFdTdGR5bUpBUEpo?=
 =?utf-8?B?R3ZtdG9xTTRZQmdGVzNUN3VUV054aXpUMEROdHFOT2l0Qm0zQmZSc3NUcTN2?=
 =?utf-8?B?Z09aMk5JdWF2SnR3eXBDZmVTQVhQMzdKNE9jckV5a25uOGN4d2J4cFBRSlp2?=
 =?utf-8?B?V2NjQ1dJV1dSQlBRVTNjbEpUMGFJSzFTSEdsa2JMVDZ0bnJFSlRHaThMRnly?=
 =?utf-8?B?bjJHMDlWUk9qdlliL1ZCdDh3Z2lDeXNHazF0eXh6bkdZdlZ2emttTHlmcDB5?=
 =?utf-8?B?U2duSGZnMHhTTE1XZy9FMEllbkNvdG5TWjQzUHpMUENHL0ZLNC9FODY3Ymh2?=
 =?utf-8?B?THlrcDdSOTlObkVlZ3NlbHJsM2xLbGh5R2Z5QU45Nlp1VDkwNmdtcWxEL1dk?=
 =?utf-8?B?Z2psbTJCUCt1RXF3TGdsRmxBVVpWbzl4L3YvYm5ZczVQeXhnYzdtZVBrS3Jx?=
 =?utf-8?B?WmpkcGlZOG5kRk02eWJmYXpCdHF4YjF6Zm9PU2xjWS8wbnVqL0ZDdHNONTVJ?=
 =?utf-8?B?ZERlenpGMW1lQWxReXhDaHhBbHdDRnpJZEtsbWdkTHZ2Y2N4b2Y3TEZPZGp3?=
 =?utf-8?B?M2VLb3hrMlIweXhrSmw5QkgzOFFBSDdYcXE5NjNKK3FoenRCaVdISXRlR2Zs?=
 =?utf-8?B?NUIxR2txY3F4bnNoT25pOTVRN1NRWHZjTlVXaEVOd1BBZzBKL0M5NXNWbFgv?=
 =?utf-8?B?VVBpMHhIYmtuS0ovSU1GZ2kzWkhvaFN0NWNJUWZ0V204Tkx4Wi92VjdGSUJL?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A62C02855A3A47A96FEDB96E7E2228@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c45b138-5a0e-42e1-1477-08da9b954ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 05:51:13.3919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoXfvAVnUujtbH80XaFyWQDxONmwohoGXqCckh7G7JWE9IBpO6/0IAwiaGEuEb9/DHiGGECJHp6BBWLuU1ZnsvY3G4/CE3CNy0CU0Y154bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDkuMjAyMiAxODowOCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFByZXZpb3VzbHksIHRo
ZSBhdG1lbCBzZXJpYWwgZHJpdmVyIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+IHBv
c3NpYmlsaXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFz
IGl0cw0KPiBiYXVkcmF0ZSBnZW5lcmF0b3IuIFVubGVzcyB0aGVyZSBpcyBhIEZyYWN0aW9uYWwg
UGFydCBhdmFpbGFibGUgdG8NCj4gaW5jcmVhc2UgYWNjdXJhY3ksIHRoZXJlIGlzIGEgaGlnaCBj
aGFuY2UgdGhhdCB3ZSBtYXkgYmUgYWJsZSB0bw0KPiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3Nl
ciB0byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+IGNsb2NrIHNv
dXJjZS4gTm93LCBkZXBlbmRpbmcgb24gdGhlIGVycm9yIHJhdGUgYmV0d2Vlbg0KPiB0aGUgZGVz
aXJlZCBiYXVkcmF0ZSBhbmQgdGhlIGFjdHVhbCBiYXVkcmF0ZSwgdGhlIHNlcmlhbCBkcml2ZXIg
d2lsbA0KPiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sg
bXVzdCBiZSBwcm92aWRlZA0KPiBpbiB0aGUgRFQgbm9kZSBvZiB0aGUgc2VyaWFsIHRoYXQgbWF5
IG5lZWQgYSBtb3JlIGZsZXhpYmxlIGNsb2NrIHNvdXJjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0N
Cj4gDQo+IA0KPiB2MSAtPiB2MjoNCj4gLSB0YWtlIGludG8gYWNjb3VudCB0aGUgZGlmZmVyZW50
IHBsYWNlbWVudCBvZiB0aGUgYmF1ZHJhdGUgY2xvY2sgc291cmNlDQo+IGludG8gdGhlIElQJ3Mg
TW9kZSBSZWdpc3RlciAoVVNBUlQgdnMgVUFSVCkNCj4gLSBkb24ndCBjaGVjayBmb3IgYXRtZWxf
cG9ydC0+Z2NsayAhPSBOVUxMDQo+IC0gdXNlIGNsa19yb3VuZF9yYXRlIGluc3RlYWQgb2YgY2xr
X3NldF9yYXRlICsgY2xrX2dldF9yYXRlDQo+IC0gcmVtb3ZlIGNsa19kaXNhYmxlX3VucHJlcGFy
ZSBmcm9tIHRoZSBlbmQgb2YgdGhlIHByb2JlIG1ldGhvZA0KPiANCj4gDQo+IA0KPiB2MiAtPiB2
MzoNCj4gLSBhZGQgdGhlIGVycm9yIHJhdGUgY2FsY3VsYXRpb24gZnVuY3Rpb24gYXMgYW4gaW5s
aW5lIGZ1bmN0aW9uIGluc3RlYWQgb2YNCj4gYSBtYWNybyBkZWZpbml0aW9uDQo+IC0gYWRkIGBn
Y2xrX2ZhaWxgIGdvdG8NCj4gLSByZXBsYWNlIGBnb3RvIGVycmAgd2l0aCBgZ290byBlcnJfY2xr
X2Rpc2FibGVfdW5wcmVwYXJlO2ANCj4gDQo+IA0KPiANCj4gdjMgLT4gdjQ6DQo+IC0gTm90aGlu
ZywgdGhpcyB3YXMgcHJldmlvdXNseSBbUEFUQ0ggMTRdDQo+IA0KPiANCj4gIGRyaXZlcnMvdHR5
L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IGluZGV4IGM5ODM3OThhNGFiMi4uNDI2
ZjlkNGY5YTVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IEBAIC0xNSw2
ICsxNSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3NlcmlhbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2Nsay1wcm92aWRlci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9zeXNycS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R0eV9mbGlwLmg+DQo+IEBA
IC0xMTAsNiArMTExLDcgQEAgc3RydWN0IGF0bWVsX3VhcnRfY2hhciB7DQo+ICBzdHJ1Y3QgYXRt
ZWxfdWFydF9wb3J0IHsNCj4gIAlzdHJ1Y3QgdWFydF9wb3J0CXVhcnQ7CQkvKiB1YXJ0ICovDQo+
ICAJc3RydWN0IGNsawkJKmNsazsJCS8qIHVhcnQgY2xvY2sgKi8NCj4gKwlzdHJ1Y3QgY2xrCQkq
Z2NsazsJCS8qIHVhcnQgZ2VuZXJpYyBjbG9jayAqLw0KPiAgCWludAkJCW1heV93YWtldXA7CS8q
IGNhY2hlZCB2YWx1ZSBvZiBkZXZpY2VfbWF5X3dha2V1cCBmb3IgdGltZXMgd2UgbmVlZCB0byBk
aXNhYmxlIGl0ICovDQo+ICAJdTMyCQkJYmFja3VwX2ltcjsJLyogSU1SIHNhdmVkIGR1cmluZyBz
dXNwZW5kICovDQo+ICAJaW50CQkJYnJlYWtfYWN0aXZlOwkvKiBicmVhayBiZWluZyByZWNlaXZl
ZCAqLw0KPiBAQCAtMjI5LDYgKzIzMSwxMSBAQCBzdGF0aWMgaW5saW5lIGludCBhdG1lbF91YXJ0
X2lzX2hhbGZfZHVwbGV4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+ICAJCShwb3J0LT5pc283
ODE2LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBp
bmxpbmUgaW50IGF0bWVsX2Vycm9yX3JhdGUoaW50IGRlc2lyZWRfdmFsdWUsIGludCBhY3R1YWxf
dmFsdWUpDQo+ICt7DQo+ICsJcmV0dXJuIDEwMCAtIChkZXNpcmVkX3ZhbHVlICogMTAwKSAvIGFj
dHVhbF92YWx1ZTsNCj4gK30NCj4gKw0KPiAgI2lmZGVmIENPTkZJR19TRVJJQUxfQVRNRUxfUERD
DQo+ICBzdGF0aWMgYm9vbCBhdG1lbF91c2VfcGRjX3J4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQp
DQo+ICB7DQo+IEBAIC0yMTE3LDYgKzIxMjQsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zZXJpYWxf
cG0oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgdW5zaWduZWQgaW50IHN0YXRlLA0KPiAgCQkgKiBU
aGlzIGlzIGNhbGxlZCBvbiB1YXJ0X2Nsb3NlKCkgb3IgYSBzdXNwZW5kIGV2ZW50Lg0KPiAgCQkg
Ki8NCj4gIAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGF0bWVsX3BvcnQtPmNsayk7DQo+ICsJCWlm
IChfX2Nsa19pc19lbmFibGVkKGF0bWVsX3BvcnQtPmdjbGspKQ0KPiArCQkJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGF0bWVsX3BvcnQtPmdjbGspOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0K
PiAgCQlkZXZfZXJyKHBvcnQtPmRldiwgImF0bWVsX3NlcmlhbDogdW5rbm93biBwbSAlZFxuIiwg
c3RhdGUpOw0KPiBAQCAtMjEzMiw3ICsyMTQxLDkgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0X3Rl
cm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwNCj4gIHsNCj4gIAlzdHJ1Y3QgYXRtZWxfdWFy
dF9wb3J0ICphdG1lbF9wb3J0ID0gdG9fYXRtZWxfdWFydF9wb3J0KHBvcnQpOw0KPiAgCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQo+IC0JdW5zaWduZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1
b3QsIGJhdWQsIGRpdiwgY2QsIGZwID0gMDsNCj4gKwl1bnNpZ25lZCBpbnQgb2xkX21vZGUsIG1v
ZGUsIGltciwgcXVvdCwgZGl2LCBjZCwgZnAgPSAwOw0KPiArCXVuc2lnbmVkIGludCBiYXVkLCBh
Y3R1YWxfYmF1ZCwgZ2Nsa19yYXRlOw0KPiArCWludCByZXQ7DQo+ICANCj4gIAkvKiBzYXZlIHRo
ZSBjdXJyZW50IG1vZGUgcmVnaXN0ZXIgKi8NCj4gIAltb2RlID0gb2xkX21vZGUgPSBhdG1lbF91
YXJ0X3JlYWRsKHBvcnQsIEFUTUVMX1VTX01SKTsNCj4gQEAgLTIzMDIsNiArMjMxMyw0NiBAQCBz
dGF0aWMgdm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LA0KPiAg
CQljZCA9IG1pbl90KHVuc2lnbmVkIGludCwgY2QsIEFUTUVMX1VTX0NEKTsNCj4gIAl9DQo+ICAN
Cj4gKwkvKg0KPiArCSAqIElmIHRoZXJlIGlzIG5vIEZyYWN0aW9uYWwgUGFydCwgdGhlcmUgaXMg
YSBoaWdoIGNoYW5jZSB0aGF0DQo+ICsJICogd2UgbWF5IGJlIGFibGUgdG8gZ2VuZXJhdGUgYSBi
YXVkcmF0ZSBjbG9zZXIgdG8gdGhlIGRlc2lyZWQgb25lDQo+ICsJICogaWYgd2UgdXNlIHRoZSBH
Q0xLIGFzIHRoZSBjbG9jayBzb3VyY2UgZHJpdmluZyB0aGUgYmF1ZHJhdGUNCj4gKwkgKiBnZW5l
cmF0b3IuDQo+ICsJICovDQo+ICsJaWYgKCFhdG1lbF9wb3J0LT5oYXNfZnJhY19iYXVkcmF0ZSkg
ew0KPiArCQlpZiAoX19jbGtfaXNfZW5hYmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCj4gKwkJCWNs
a19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCj4gKwkJZ2Nsa19yYXRlID0g
Y2xrX3JvdW5kX3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywgMTYgKiBiYXVkKTsNCj4gKwkJYWN0dWFs
X2JhdWQgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcG9ydC0+Y2xrKSAvICgxNiAqIGNkKTsNCj4gKwkJ
aWYgKGdjbGtfcmF0ZSAmJiBhYnMoYXRtZWxfZXJyb3JfcmF0ZShiYXVkLCBhY3R1YWxfYmF1ZCkp
ID4NCj4gKwkJICAgIGFicyhhdG1lbF9lcnJvcl9yYXRlKGJhdWQsIGdjbGtfcmF0ZSAvIDE2KSkp
IHsNCj4gKwkJCWNsa19zZXRfcmF0ZShhdG1lbF9wb3J0LT5nY2xrLCAxNiAqIGJhdWQpOw0KPiAr
CQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmdjbGspOw0KPiArCQkJaWYg
KHJldCkNCj4gKwkJCQlnb3RvIGdjbGtfZmFpbDsNCj4gKw0KPiArCQkJaWYgKGF0bWVsX3BvcnQt
PmlzX3VzYXJ0KSB7DQo+ICsJCQkJbW9kZSAmPSB+QVRNRUxfVVNfVVNDTEtTOw0KPiArCQkJCW1v
ZGUgfD0gQVRNRUxfVVNfVVNDTEtTX0dDTEs7DQo+ICsJCQl9IGVsc2Ugew0KPiArCQkJCW1vZGUg
Jj0gfkFUTUVMX1VBX0JSU1JDQ0s7DQo+ICsJCQkJbW9kZSB8PSBBVE1FTF9VQV9CUlNSQ0NLX0dD
TEs7DQo+ICsJCQl9DQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBTZXQgdGhlIENsb2NrIERpdmlz
b3IgZm9yIEdDTEsgdG8gMS4NCj4gKwkJCSAqIFNpbmNlIHdlIHdlcmUgYWJsZSB0byBnZW5lcmF0
ZSB0aGUgc21hbGxlc3QNCj4gKwkJCSAqIG11bHRpcGxlIG9mIHRoZSBkZXNpcmVkIGJhdWRyYXRl
IHRpbWVzIDE2LA0KPiArCQkJICogdGhlbiB3ZSBzdXJlbHkgY2FuIGdlbmVyYXRlIGEgYmlnZ2Vy
IG11bHRpcGxlDQo+ICsJCQkgKiB3aXRoIHRoZSBleGFjdCBlcnJvciByYXRlIGZvciBhbiBlcXVh
bGx5IGluY3JlYXNlZA0KPiArCQkJICogQ0QuIFRodXMgbm8gbmVlZCB0byB0YWtlIGludG8gYWNj
b3VudA0KPiArCQkJICogYSBoaWdoZXIgdmFsdWUgZm9yIENELg0KPiArCQkJICovDQo+ICsJCQlj
ZCA9IDE7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gK2djbGtfZmFpbDoNCj4gIAlxdW90ID0gY2Qg
fCBmcCA8PCBBVE1FTF9VU19GUF9PRkZTRVQ7DQo+ICANCj4gIAlpZiAoIShwb3J0LT5pc283ODE2
LmZsYWdzICYgU0VSX0lTTzc4MTZfRU5BQkxFRCkpDQo+IEBAIC0yODk3LDYgKzI5NDgsMTIgQEAg
c3RhdGljIGludCBhdG1lbF9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycjsNCj4gIA0KPiArCWF0bWVsX3BvcnQtPmdj
bGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImdjbGsiKTsNCj4gKwlpZiAo
SVNfRVJSKGF0bWVsX3BvcnQtPmdjbGspKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoYXRtZWxfcG9y
dC0+Z2Nsayk7DQo+ICsJCWdvdG8gZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4gKwl9DQo+
ICsNCj4gIAlyZXQgPSBhdG1lbF9pbml0X3BvcnQoYXRtZWxfcG9ydCwgcGRldik7DQo+ICAJaWYg
KHJldCkNCj4gIAkJZ290byBlcnJfY2xrX2Rpc2FibGVfdW5wcmVwYXJlOw0KDQo=
