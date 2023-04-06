Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404736D9866
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjDFNiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDFNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:38:21 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2082.outbound.protection.outlook.com [40.107.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D4D61BD;
        Thu,  6 Apr 2023 06:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM/azoyrVbMOKqvo4esR2gXYqMKbeGSAPAMncq4Hnznp21A59zY6C5eJcuUNodQlAauXj6gukmqlbMnOz6tlDwUNkkpajhyP7Y5CvYRL/cNyzpBEH0UmFFLxv2MTSkzi6EoFPpu2o4n+SWbuDDn9TcpKrxaAK05LWSxj8wnU9NG0hbD48p+n59x6USBMTKk7+/hF4iRDO7KYnHwOsgHxCoptz/acFQy/sRVyqOJYa0ho5llHQrB9ugyH/ksH8iHaZk9SLWzyLMEDGzkvCmU794SF12CsHX3DU7ZzDgz0+xVCHrS1TcpZnO4W3Fg8+CfARlfsBkhJaoQ/d+RKqUW4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6EY0EqzlWSk0uv9TqfAPrV+OUk51JPCdHaf1I4ZOqk=;
 b=kkzzusezaPlc+2zrdobs0v3Rz5MRRS9m3wgPVaGK+Nw2Fi75ZktQ9LyfdGBfuXrnBS05TRnXJnO08zJQiVp3Wk9S8vsVtc84nBsfBjD7L9HNMavRSilN9vXUF1Oq9nFBF1IQGA3FgZ3AV+hP01Zmw0TwzkBH6H15wYf5BJ1GbUEOwakovwLcgzMRrnGF660g2z6KVvnQAYBB2NvAw+Dh03Say1Du0/3ELp/M3C9xuP4nHfXK14ymqCmhNZfF8XQGsqEThpJkQ4CjrAhjAoUDOKxgaE0Oa+jKIC6/UVgJejtroaqC2thY77lupaYhakOtD3lyzHwx8Bfxfr/gNH1sDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6EY0EqzlWSk0uv9TqfAPrV+OUk51JPCdHaf1I4ZOqk=;
 b=tEhuuMcJZIL/jYxFZTkJtSbcwwV6DZwWJ7EjYzJUh3GHUY9J6UgyWZCFdkWdAGWWjiLg51WKQskjvBsSyDf74KAqkyyydUo8H2pBrbhfJ5JlPZvze+QqxL5DeWAo+uM01n2efJnMguHdMmVVil9F8BB8/CKSe1ZcsHfaC6U3/C6Lzd3tgpN1GkWawnePKElnJGkW57TmzDgyk5rXtXMgQRWVxQSMzgB0unA3wEdv+YdcSMiHDOJuAfzZWkANiktM2mN7Fi62/cr/Udxjo6VBsjybMd5iEBwf02q9G7cCu1KcJBr05KPuZ3x/t/y8ah0xo0IWndZ7gOamWok5jtjPkA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3216.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 13:38:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25%6]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 13:38:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Luis Chamberlain' <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Topic: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Index: AQHZZ2YnjttKu0Rgqkqg9kuXelQ+nK8c1yMAgAAKqICAAAH7AIAAAz+AgAAIWQCAAQHVgIAAWgqA
Date:   Thu, 6 Apr 2023 13:38:07 +0000
Message-ID: <48f2c6f2-f776-be29-7d74-67f1b6cf5467@csgroup.eu>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
 <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
 <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
 <ZC2nbiarELlUVcSj@bombadil.infradead.org>
 <979c8cf9ab2d4fcba811adc0c563b8bb@AcuMS.aculab.com>
In-Reply-To: <979c8cf9ab2d4fcba811adc0c563b8bb@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3216:EE_
x-ms-office365-filtering-correlation-id: 80cf59fd-9c8b-4632-fe78-08db36a4283f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kxh3TJc6ja9pG+qlsdVPH6lXcjYHAXxrVON5yiqTRr1787BTphNclZru0OfSn2JxnjflLLEKlH9QOQn3wdfZharj3UMvjqF4hAI/IzukxgXXQfbsjruw78KBGC2QWiagehS5pjV9hSL79hziOxpa207WqibBnvHj+CEt1UinDzDL9hbG47AYDAZ7HeM9SkNVTDGKskBxUblXdLUZ4hfYlLA1pVZM9xC9UDQBm7qnHL7sCzoLw1jXgMOavm8JFjKS5Y13m7+2IVUiMiJyyAONbI7Twis1YWNIOLTAfVNVP3D3QyhyF5iDy+vYXHgXxk2OhZXhQXg9zNXq3UBTJU1vBxFiz2j/tT+IJ0CRwm/ka37zp4Z1phI/KMLIL+LI7L8kYkC/+d7yxPYKrh7AoYbsEE3Nn/N/6vAY6KMW2CkRzBi+Iv5R1F6AvVbDrlUyHXux6AISBccTkKhWk9DJ26b4PwQpd2Ajgw9j4OHvei1gCgzw49OsOWv/Jcii6/r6SfEoSw3NIFgPUY88JNCXg0M5RgecUyOgzEUTHA6ME9Va609ChMd0E2oVea2R/48YkTKSeZV+vA+Fo2RawzqiTSaNVYjganHOIZB5V72tXWUO1I4IWgquxa6Voy/5tS1hlP57IqZlYynnp4rRJGS7YqiyGUZfFx1geSfa4CLKhJfTtwUIBkSSt42qT6VEU3u3YFk6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39850400004)(376002)(451199021)(2616005)(83380400001)(66574015)(91956017)(6486002)(71200400001)(478600001)(316002)(6506007)(26005)(54906003)(186003)(53546011)(6512007)(110136005)(44832011)(7416002)(2906002)(4326008)(5660300002)(36756003)(38100700002)(64756008)(76116006)(66476007)(66446008)(122000001)(8676002)(66946007)(41300700001)(66556008)(86362001)(38070700005)(31696002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZxb0hMQWZJbS9kQjF6N1JxSGN5blgra0tzVGhxM0JpZUF3akluekorM3Jy?=
 =?utf-8?B?dlZuK2lPbHlCY0M0S1Q5U2MyY0VFdFM1bXpPOFFRbWZ3S3RCZEJ1WFRyanBk?=
 =?utf-8?B?d284dk5ZTWtKejZwNGRPcVRhMklISnZuSVhrdU8vKzlmVHdSaU1zT3IvYTNr?=
 =?utf-8?B?SEJtODhOd3dKZHc5Y3l4MnQybm9GalpJUmo0MWpLdXlzb0RmUXFXa1RZWklH?=
 =?utf-8?B?QnQ3VXlQR0JicmNmeW5ISmRXenkzWW14N1dLRUY5c1JSSmp4SGJmZTFMMEFl?=
 =?utf-8?B?N3Vhb1ZOaGd4Nys0aXJJNHFOTFJJRHFXc0RDTnNWV2owLzdxTkJMUk13Mm5M?=
 =?utf-8?B?cC9POXowOFBlZmREVXJpYWNwZm95T0h0YmlpRENoKzJ0NldaU2dpalprMWRy?=
 =?utf-8?B?SlVHZXEwMFYxU04yMk04c1h2b25Yb3ZyZURoUjZnOFA3YWF1amZjT3h0VjQz?=
 =?utf-8?B?R1pZYmx6UFplSUtxL0MreC9NaW1lMXdHUEdyd0tpT0hEczZlaWNtdTQzMnAx?=
 =?utf-8?B?N1VNKzg5V2NWSG5vNUZIMjhLcXJ2MVN2b3RJNzYyNGhmdWYvbFJacmhqVW1k?=
 =?utf-8?B?cFBHZVJTcFdvN2hNaEphMXVRakdpL3kxSU9TazgyQ29QbTFmSjE5bkhhUk1Z?=
 =?utf-8?B?VGVPb0F4S3dGRGNSUnpTZEdCWlJHdFpOMHRwQ1I3dXdnaWFzZjJGZGlyRXg3?=
 =?utf-8?B?MmJWejhIREw1NmdONUpsR2RRMm1FTm1vU1Z1RCtZTGY3WTE5Z240WHZaNDEy?=
 =?utf-8?B?R2lSOWRlRWJnUTNWU0lLTCttTWRxK1NHeTZiU2xIYWhXcDlkcGM1dC9qdVJ2?=
 =?utf-8?B?THJwUyt0T3NqeXpzb0JId0JZbXg1am45Qi9OMmJLdVF5Q3lHK3ovWjNNVVJW?=
 =?utf-8?B?MHFnc0NTaW5jTDZDUFJ5eXl0VmFiZ3hQVlUzMk54dWtYbjI5VlR2YTJhRzhO?=
 =?utf-8?B?R3pZSlRSbFNEK3hvRGxiaTZEcUZjbWtlMDdYeHhRWm5xRUpST1ZGcFc4VklD?=
 =?utf-8?B?dzdpckNhbEhjMzRzMWh6czB5ajkwYnFWMWllZ1ladHlLaUpheUYwSGpObGU5?=
 =?utf-8?B?UERpc3VCczBJb2JKL29aV0hIY3RxLzNEK2RVZTdYKzVpank2QzJ3M3J4M2Fw?=
 =?utf-8?B?d3FpNzFaNys1cU92QWdid3JiTEVTaXBYNy9rNi9SQUVWVVFxS2I1a1YvSFdm?=
 =?utf-8?B?OVcxVlpMaC82bW1oNlhzWjNpMm83UEh5RDFveXR5Z2pyUitrMGNTeWZGeGJF?=
 =?utf-8?B?MUsvZXRVTlFlRkhqV3ByTlVncjVwcHk0RjFOT2ZZelFEOWJhS0RmdjE0ajJB?=
 =?utf-8?B?S1BUQVF1RDBrbDJMNHlZV1FxdkJFelhOSk9WYVB6SFRtbFhsd2hzKzFsUkZJ?=
 =?utf-8?B?QUtyTmZobTJYUWs3aTZWZlhLUlJmNnF0dU1YUjY0QVVlQ1IyeUVKSzBsa0Nq?=
 =?utf-8?B?Ym5YWWpSYTFMLzFyOEZkZFAwenpnM2FKY3MycEtOUjZOQi9ody8vTFhGUGpw?=
 =?utf-8?B?bDJMakdVZUhlZU9SRkRhdnZOeG9wTldzVTZFbWtqRUdaeVVtcW9IK1lxRlNR?=
 =?utf-8?B?M0x5eDlpSG93V2szdkYwRlFPMlFCKzBPTEJ2Zytzb0p2TVRSdjl3eURvd0Jm?=
 =?utf-8?B?M2RnMUpNUVlhbDFrOXdMMDVBRjA1eVpCRFRYQXNqOGduVS9EUndLVEdnODFt?=
 =?utf-8?B?OGk0emFHbDhPS3luOGdFNUlGYzhDa1psdVpqVzQwNzBETFo5YjkwKzlHWmlu?=
 =?utf-8?B?elJuRzY5cndvcS9OOTRVMmpKUDNrODZsakY3QlJ4SWovOStGVWhVTG0vVC8z?=
 =?utf-8?B?MlYyL0Vic0pxWTdhQ2lTU2o4Z1dTTFViRlNHazVjTm0yd0dpa2w0NE5Bbytp?=
 =?utf-8?B?RzZKN1JwZzdtaFRZQW5HSGJJZmlYNjdvZGhrejhLWVNoRWRueUNuYnRpbkRJ?=
 =?utf-8?B?VmgrUFR0Ti9TNU91L0dSZ1doZ2Q4eHhVYWo3RksyejBxU3BPeGhSTXZ2bGhr?=
 =?utf-8?B?RWFLUHFQS291VlNwMGlxbkpwa0JaYmYvR0docGQvM1FTdEhjSG83MTI4cGFa?=
 =?utf-8?B?Q25HRXd5Uk9odUtOS3FKMWZYM3BZSDBvSzUvS2VhRndwWStLbjc3dFkvTXh2?=
 =?utf-8?Q?iLWM3rXaBM6Cbm5UvaE9APKcW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E7DC99046632C42B4A2ACAB7B55DC74@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf59fd-9c8b-4632-fe78-08db36a4283f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 13:38:08.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lroN569W4hiSbIBXowLuNCSK42nqk8YQaU2khQgi6Fwr8vqW4ruSoVo5+5hFU/pRIS8//aCE5ma5sTT/nLh/eGncKeruO/cRQ+4aqHPsXE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3216
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzA0LzIwMjMgw6AgMTA6MTUsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBMdWlzIENoYW1iZXJsYWluICBMdWlzIENoYW1iZXJsYWluDQo+PiBTZW50OiAwNSBBcHJp
bCAyMDIzIDE3OjUzDQo+Pg0KPj4gT24gV2VkLCBBcHIgMDUsIDIwMjMgYXQgMDk6MjM6MDlBTSAt
MDcwMCwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+Pj4gT24gV2VkLCBBcHIgNSwgMjAyMyBhdCA5
OjEx4oCvQU0gTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
Pg0KPj4+PiBPaCBidXQgSSBkb24ndCBnZXQgdGhlIGF0b21pYyBpbmNzLCBzbyB3ZSdkIG5lZWQg
ZGVidWdmc19jcmVhdGVfYXRvbWljX2xvbmdfdCgpLg0KPj4+DQo+Pj4gICAgZGVidWdmc19jcmVh
dGVfdWxvbmcoInRvdGFsX21vZF9zaXplIiwNCj4+PiAgICAgICAgIDA0MDAsIG1vZF9kZWJ1Z2Zz
X3Jvb3QsDQo+Pj4gICAgICAgICAmdG90YWxfbW9kX3NpemUuY291bnRlcik7DQo+Pj4NCj4+PiBi
dXQgSSBkaWRuJ3QgYWN0dWFsbHkgdHJ5IHRvIGNvbXBpbGUgdGhhdCBraW5kIG9mIHZlcnNpb24u
DQo+Pj4NCj4+PiAoSSB0aGluayAiY291bnRlciIgaXMgYWN0dWFsbHkgYSBfc2lnbmVkXyBsb25n
LCBzbyBtYXliZSB0aGUgdHlwZXMgZG9uJ3QgbWF0Y2gpLg0KPj4NCj4+IEkgc2VlIHllcywgc2Fk
bHkgd2UnZCBoYXZlIHRvIGNhc3QgdG8gKHVuc2lnbmVkIGxvbmcgKikgdG8gbWFrZSB0aGF0DQo+
PiB3b3JrIGFzIGF0b21pY19sb25nIGNvdW50ZXJzIGFyZSBsb25nIGxvbmcgaW50Og0KPj4NCj4+
ICAgICBkZWJ1Z2ZzX2NyZWF0ZV91bG9uZygidG90YWxfbW9kX3NpemUiLA0KPj4gICAgICAgICAg
MDQwMCwgbW9kX2RlYnVnZnNfcm9vdCwNCj4+IC0gICAgICAgICZ0b3RhbF9tb2Rfc2l6ZS5jb3Vu
dGVyKTsNCj4+ICsgICAgICAgICh1bnNpZ25lZCBsb25nICopJnRvdGFsX21vZF9zaXplLmNvdW50
ZXIpOw0KPj4NCj4+IFRoYXQnczoNCj4+DQo+PiB1bnNpZ25lZCBsb25nIG1pbiBiaXRzIDMyDQo+
PiBsb25nIGxvbmcgICAgIG1pbiBiaXRzIDY0DQo+Pg0KPj4gQnV0IHNpbmNlIHdlJ2QgYmUgZG9p
bmcgb3VyIGFjY291bnRpbmcgaW4gYXRvbWljX2xvbmcgYW5kIGp1c3QgdXNlDQo+PiBkZWJ1Z2Zz
IGZvciBwcmludHMgSSB0aGluayB0aGF0J3MgZmluZS4gSnVzdCBhIGJpdCB1Z2x5Lg0KPiANCj4g
VGhhdCBpc24ndCBnb2luZyB0byB3b3JrLg0KPiBJdCBpcyBwcmV0dHkgbXVjaCBuZXZlciByaWdo
dCB0byBkbyAqKGludGVnZXJfdHlwZSAqKSZpbnRlZ2VyX3ZhcmlhYmxlLg0KPiANCj4gQnV0IGFy
ZSB5b3UgcmVhbGx5IHN1cmUgJ2F0b21pY19sb25nJyBpcyAnbG9uZyBsb25nJw0KPiBkb2Vzbid0
IHNvdW5kIHJpZ2h0IGF0IGFsbC4NCj4gJ2xvbmcgbG9uZycgaXMgMTI4Yml0IG9uIDY0Yml0IGFu
ZCA2NGJpdCBvbiAzMmJpdCAtIHNvIGlzIGFsd2F5cw0KPiBhIGRvdWJsZS1yZWdpc3RlciBhY2Nl
c3MuDQo+IFRoaXMgaXMgd29yc2UgdGhhbiBhdG9taWNfdTY0Lg0KDQpPbiBwb3dlcnBjICdsb25n
IGxvbmcnIGlzIDY0IGJpdHMgb24gYm90aCBQUEMzMiBhbmQgUFBDNjQuDQoNCkNocmlzdG9waGUN
Cg0KDQo+IA0KPiBJIHNob3VsZCBwcm9iYWJseSB0cnkgdG8gbG9va3VwIGFuZC9vciBtZWFzdXJl
IHRoZSBwZXJmb3JtYW5jZQ0KPiBvZiBhdG9taWMgb3BlcmF0aW9ucyAoZXNwLiBjbXB4Y2hnKSBv
biB4ODYuDQo+IEhpc3RvcmljYWxseSB0aGV5IHdlcmUgYSBzZXBhcmF0ZSByZWFkIGFuZCB3cml0
ZSBidXMgY3ljbGVzIHdpdGgNCj4gdGhlICdsb2NrJyBzaWduYWwgYXNzZXJ0ZWQgKGFuZCBzdGls
bCBhcmUgaWYgdGhleSBjcm9zcyBjYWNoZQ0KPiBsaW5lIGJvdW5kYXJpZXMpLg0KPiBCdXQgaXQg
aXMgcG9zc2libGUgdGhhdCBhdCBsZWFzdCBzb21lIG9mIHRoZSBsb2NrZWQgb3BlcmF0aW9ucw0K
PiAoZXNwLiB0aGUgeGNoZyBvbmVzKSBhcmUgaW1wbGVtZW50ZWQgd2l0aGluIHRoZSBjYWNoZSBp
dHNlbGYNCj4gc28gYXJlIGp1c3QgYSBzaW5nbGUgY3B1IC0+IGNhY2hlIG9wZXJhdGlvbi4NCj4g
SWYgbm90IGl0IGlzIGFjdHVhbGx5IHBvc3NpYmxlIHRoYXQgdGhlIF9sb2NhbCB2YXJpYW50cyB0
aGF0DQo+IHNlZW0gdG8gaGF2ZSBiZWVuIGFkZGVkIHNob3VsZCBub3QgdXNlIHRoZSBsb2NrZWQg
aW5zdHJ1Y3Rpb25zIQ0KPiANCj4gCURhdmlkDQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KPiBSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
