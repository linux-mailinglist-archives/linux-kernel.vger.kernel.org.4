Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2764F73F94D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF0J4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjF0J4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:56:12 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2049.outbound.protection.outlook.com [40.107.9.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7E2D53;
        Tue, 27 Jun 2023 02:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTmuxcLOejjkOOagZpLXHiB7vp9sNG3oXY+EYgp23g3ucnsIx2IZij7WtxoCmRmAbrsY9DbKAtX2+1CINo50wS2T0Vs1UR6Q98O1Z5k9OKCvLQrVhwCuptov2fsK7bnHZC7Le8GtHNnPh42uEq+lzzVBqdKUuFk1sbpYLrEkklYAZw3JZZM7qYbeRQsH+1JlNlIMUyEg0sbSEKpCXH1o4eYZCslwviC4UNrpciXFO4BtpVX293oP10l9rA/428DAhqii02NuyT3ZbJOhwXvIHkneRLPmP18Ru12QrJ3AR5hXge2VX/aDn0UNfcK0cSfICBP1kTfvR0bzsj1FaooxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPhpLmEQKT4VmRUofnBggjhQFsLJ9sjTsIi/ItQno24=;
 b=lHc9GV2luE3ZPF5ARcBZl9jeiX3eBC9iNzsWEWxVNLeI5uzfzi4RDBEk+Bs4iqf9kXjsZ7X9wBWFf49i99JSI2SjG6efDsYtv9aSx/pJuDSJDnb+K3GzoPktNYqiCv3v14aYImiyoaLM123Xza7GGcE/F4jghaL6PrGhQoZg/eR5aZuPTkFA4vtKDE/lbNQbp/0rJgtbPCm0E1oRixY5m+FDG5uJyVLE9Fcn9tREAj/IZ7v3+L6VtKNaS3FY7Zm5C3+xIQTlel55rc4seRhHv7FILX3HzPvI1g0rEZUyPgvTzcx04tm5yCMGGfDHh/HrAeUgZc7fK3ppCAA3wpt4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPhpLmEQKT4VmRUofnBggjhQFsLJ9sjTsIi/ItQno24=;
 b=Zfv3h+zqIohbvNl42AFL0ROFnAEfF0a0/pAj+jye8zlQFQB6X0TnGUF8b2ppXM1cIkODzeJpYiPTegEtMN5sdqnM3UyKanyoj6J29efo440kN5OnfySob2praLxpdNoXmwPXwyb7mg4ys94KvoqmA7PycusftbqD+nFD80WUGl8dnbPi+cUEeUgSDhPlw5NnFRDRETftZhM7WziimwlsIMnFg6RNK8epGfPf+G3soC/vJyv5Hy9wOrMOBYOulyCq5RD16nkVIlHsysUeHA1yH9kiR0kZLTNbbMEBZMHjSqzTVJFtoODikpMcoZ0drlijMZ3VwSgsA+FaeP8ROE5EtA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:55:19 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:55:19 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 04/13] iio: consumer.h: Fix raw values documentation
 notes
Thread-Topic: [PATCH v6 04/13] iio: consumer.h: Fix raw values documentation
 notes
Thread-Index: AQHZpbDt2EGVhnvaAkenjYCtiSZeRK+eb5MA
Date:   Tue, 27 Jun 2023 09:55:19 +0000
Message-ID: <ae318459-43a2-386b-5fce-7a07fd7c6f99@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-5-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-5-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2423:EE_
x-ms-office365-filtering-correlation-id: 229ac6af-b7ca-4b19-d2fb-08db76f49dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jEOsR2theZjQAwih++fv1Iuy4mCoNWjmJqT3R9iy/KMZSFtWK0yQLpXLnEj+SnW5DmsAmX924Xie6SOpwhmLaBd/Oa42bP3UMBTo6e535ZoFgYer3HuRg9N3/jbkwLKDoJt91hVP1vvfBns5dWXb7NGFrK5iKljRkJcjhu7/cO6YAuNr7N3e8yX9dO9dfIIzNYy6JgcsMdyKyZ4Pb9q5Bfn/VR2hm7ixg759ge9o5xlWXpqAgi6xF+Z3PJPfot+APcaetzne3Jd8JbB0rrpDS7ju/0OJRo1AnzGm+EgNAx4bDCpmp/0olE9Kw8m8eYZ7MqSPLMw35MCKJrOLvtz+vtLBLBWkU5QwcMWWN8fYQeSw/i5CSbna8FXllJ6HykH45/2NZiNhVEUwdsZYt5HC9KGprdptY17/ZJ8WYtTkFPaVgiSifrIByaFNigAbKwuTCL9loxFRNFT02OQ8iZpDzK5tJkAWo8iGHA5JZJdbKRvdZ/v9qEgRrgwwODqjQqcu5t2uCZERg5CTpNZGJUbXbVMvUSDwhCraCH8PSG4YQ1RnW7H9UbtMoJYZeqajiQf5by8usk49blnVwiB+7rQG+CFR7bH1vheOHMAJNKUrd5ggcfkCNubaOTciNVAGCH86Rk+DKCXVIBkre4GZqYmc+3EWELm1oGP3zy0xVt0xQL/nxT8233kuZvpU+/3q2C6QC8hG+7cwiC+0Ie7um4gLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(26005)(186003)(2906002)(66574015)(38070700005)(921005)(38100700002)(71200400001)(122000001)(6512007)(6506007)(8936002)(5660300002)(64756008)(83380400001)(44832011)(91956017)(76116006)(66446008)(66946007)(66556008)(8676002)(36756003)(7416002)(2616005)(110136005)(6486002)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emlHZjdhazdIWjAvbUE1cXVqT2Jvazh3UllNdnFiOTkrUG1WWXlCT3liOXZs?=
 =?utf-8?B?bE9xc3g5cGU1bFMrK2xoZ1NES1llTk5OZElpN3lRSWpjNHZkN0dXS2NaV01X?=
 =?utf-8?B?UmhNcXZjNkxmMkNYdElQeUJoSndYUHdnNlBlbXl3d2RxdkwvcHdYdkJGYXcz?=
 =?utf-8?B?enU5clNuN0hlVXR6ZDg2djlvS3FyZ01xVjNhNTV5QTZzdTkrNnl3dzNqV2xQ?=
 =?utf-8?B?N1VSMDlqUSswMWpJY3V1clJQK3lPaTdLWm1LdnhxdVR2bnpkZURrVG5QQzhl?=
 =?utf-8?B?ZldIT2NoTVp0MlJkVUsyb0ZjMDJxa01OSG93dlBhVmtNQW9rUkUyRWhKN1I0?=
 =?utf-8?B?MjcrZnYwRjJxMW84QVpvdDY0NGM3Qnl5SUVqYUlRODR4S0poWm9uZzNHWTQ4?=
 =?utf-8?B?aHhpU21vN0dlY0NCUEtwZjZMNXhCYTJxRHI2QmJPRHJLYklEUkt3My9QdTRs?=
 =?utf-8?B?ZS9UWU9YSFM3bDgvTXVXK21DaStmTVA1K2ZKNWxBNndLUFMyRmFYNmRqcytO?=
 =?utf-8?B?K1hHa09SUHV2eEZWaXl4UmN5UjY4ZFVRSkdCY3FKU1U4SFdJU0hIN2gzMkpT?=
 =?utf-8?B?am1Da2dqb0lwQ0dmZTkvV2dMVmJYdjQrRWNuRCt4dTM5R1AyV3RHTTV3Y0d4?=
 =?utf-8?B?L3lVVUZGSFFOS3VETEtzQXpjWDBzVHFsL0tvNUF0bjgyZmhqWjdzREtOeGI2?=
 =?utf-8?B?KzZLTFBNSHJRSGxQdHlHQ1RaaW5aenUzc3liK0w4bXhYMXdkby81OEZUZk5I?=
 =?utf-8?B?czBqVUdDekRZUTM1OHdXMFJ0N1ZBZS9WU0hpSnZwbXRac3AxdzhKWXIyNzRU?=
 =?utf-8?B?cWtSZndsRk10RFBWSFpQa0dQVWdFN1NiMmRkWkw1SzBEeS85T2prMTdEaWxK?=
 =?utf-8?B?Q25FeU1jTHZnNnNKUTdUczlPRUk4aVBGc0RoeERhU1YwbGFFL2FlQnk0SWFY?=
 =?utf-8?B?eXE5T2RhUlh4YjlEeS9KQTFaOGZKVGJwUFpQRkpzcVpWSFduTW9IMXdkMDlz?=
 =?utf-8?B?cWhmb21aa0NuQXpUdFA0ejMrT2VLa2Q1M2lnK0tSYm11alhYeEZqYTloVm1O?=
 =?utf-8?B?cnFHcDZzRWxKd25kcklzSFhOdEpXSnBVL1RqcFhscW9tOTM3TTZETnR5aG9z?=
 =?utf-8?B?ZjlIcTZKanNlSVB3MG9IcWllTmN3bmpUaEJWVEpXWk1FUElpVHJoVWpvVFdY?=
 =?utf-8?B?dFJVVzc0RVM2dTl1Zk1aYnliRVN6N1BNc1daR0x4eW1pdlZHbDk1RTZuc0g5?=
 =?utf-8?B?VHJyYVJqcUFDUHQwNnhiSEpleTY5enNlRjVMQ0pWYVM4MXVXV2tkU0k4MFND?=
 =?utf-8?B?WjJIZ2xNNXl3RUR0bm5kZ1VuSm1MSFhqMWs2Uzd0aFg0YzQxZkQ0OTZsa0ZH?=
 =?utf-8?B?WmZSNmZPNnZGYUIyejRpc3o4cVhuM1JwY24rNkdadS8ycGZEc1h5VGhRckJX?=
 =?utf-8?B?bGVScTZiUzVxZnd5cFJLLzFYQjFkb3liZGFDNktvckdZUFk1alBJTFRZZTkr?=
 =?utf-8?B?bGMxbWtraE5PV3dqdTVYYytxMG9xVXQ0bVBSZnA1ckszbVZTcm02cnNVUzJ5?=
 =?utf-8?B?UTY4c3VqMkdvV283Rmx4NER1UVFra2ZlTnE3WEF4aVk3bld4YXlmRjVHV1ZQ?=
 =?utf-8?B?OTl6ZUFXS0NtSDdOK0twQjJiNVpqTytEeCtwU0hMWm1iRFV6RkljR21tazFj?=
 =?utf-8?B?VWIyZ0VJZDVsa2F1ZGpRY1F2MjAvZnA4OWtIRitsakRCNnNqU2oxTlEzS0dw?=
 =?utf-8?B?Y0QxUGEvNXhvN0NMeGloLzZ5L3V3dFM4VnNyRVhTQ21oM3c3UzErQk93SDNJ?=
 =?utf-8?B?Mm4ybHhiY3ZmamxxQ1VwOUM5WEt1REJGR0MzYVNxcnJZUXVPZnpzMHAwZ0k5?=
 =?utf-8?B?ZkhJZFVNVzBXUS9SN2pQMmZkTHFZT1NtTDB0RTFPQmE0M3FqcnUwa2I5ZGI2?=
 =?utf-8?B?dnhDU2ZvRTl5ZGFlaHIwYUZNZ1AyZ1QrenB2NmxrMC9LbGpUT1BhdlRyR3BL?=
 =?utf-8?B?cnN5c2ppSEdvL0JuUXJCdWt3cVJFdEZoZkExOW9UanRYRVdxb3hQWVFXUlJr?=
 =?utf-8?B?RmFGWVlrNStEM1JQUDhQeGdKaWdzVVhRK2U4eW1qZXFjMXIva0xBMk9OTE5J?=
 =?utf-8?Q?iJFp1LzEkPHhjNZQmFce1s27r?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66C69CE6A85DE74CAAD200ADEE31F69B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 229ac6af-b7ca-4b19-d2fb-08db76f49dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:55:19.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2K6a2jTgUyHBvTLRnZWJC8gDcMKaGvmsC4QhzJKGqcCyWi7Wl5cNwjrDLVqRfeQvCe2/Z0Gp19nF1w05TdFtCtITQyNtzOTCVQ3K4ZlhVWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2423
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBU
aGUgcmF3IHZhbHVlcyBub3RlcyBtZW50aW9uICdBREMgY291bnRzJyBhbmQgYXJlIG5vdCBmdWxs
eSBhY2N1cmF0ZS4NCj4gDQo+IFJld29yZCB0aGUgbm90ZXMgaW4gb3JkZXIgdG8gcmVtb3ZlIHRo
ZSAnQURDIGNvdW50cycgYW5kIGRlc2NyaWJlIHRoZQ0KPiBjb252ZXJzaW9uIG5lZWRlZCBiZXR3
ZWVuIGEgcmF3IHZhbHVlIGFuZCBhIHZhbHVlIGluIHRoZSBzdGFuZGFyZCB1bml0cy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3RsaW4uY29tPg0K
PiBBY2tlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29t
Pg0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBj
c2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmggfCAy
NSArKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvaWlvL2NvbnN1bWVyLmggYi9pbmNsdWRlL2xpbnV4L2lpby9jb25zdW1lci5oDQo+IGluZGV4
IDY4MDI1OTZiMDE3Yy4uZjUzNjgyMGI5Y2YyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2lpby9jb25zdW1lci5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvaWlvL2NvbnN1bWVyLmgNCj4g
QEAgLTIwMSw4ICsyMDEsOSBAQCBzdHJ1Y3QgaWlvX2Rldg0KPiAgICAqIEBjaGFuOgkJVGhlIGNo
YW5uZWwgYmVpbmcgcXVlcmllZC4NCj4gICAgKiBAdmFsOgkJVmFsdWUgcmVhZCBiYWNrLg0KPiAg
ICAqDQo+IC0gKiBOb3RlIHJhdyByZWFkcyBmcm9tIGlpbyBjaGFubmVscyBhcmUgaW4gYWRjIGNv
dW50cyBhbmQgaGVuY2UNCj4gLSAqIHNjYWxlIHdpbGwgbmVlZCB0byBiZSBhcHBsaWVkIGlmIHN0
YW5kYXJkIHVuaXRzIHJlcXVpcmVkLg0KPiArICogTm90ZSwgaWYgc3RhbmRhcmQgdW5pdHMgYXJl
IHJlcXVpcmVkLCByYXcgcmVhZHMgZnJvbSBpaW8gY2hhbm5lbHMNCj4gKyAqIG5lZWQgdGhlIG9m
ZnNldCAoZGVmYXVsdCAwKSBhbmQgc2NhbGUgKGRlZmF1bHQgMSkgdG8gYmUgYXBwbGllZA0KPiAr
ICogYXMgKHJhdyArIG9mZnNldCkgKiBzY2FsZS4NCj4gICAgKi8NCj4gICBpbnQgaWlvX3JlYWRf
Y2hhbm5lbF9yYXcoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLA0KPiAgIAkJCSBpbnQgKnZhbCk7
DQo+IEBAIC0yMTIsOCArMjEzLDkgQEAgaW50IGlpb19yZWFkX2NoYW5uZWxfcmF3KHN0cnVjdCBp
aW9fY2hhbm5lbCAqY2hhbiwNCj4gICAgKiBAY2hhbjoJCVRoZSBjaGFubmVsIGJlaW5nIHF1ZXJp
ZWQuDQo+ICAgICogQHZhbDoJCVZhbHVlIHJlYWQgYmFjay4NCj4gICAgKg0KPiAtICogTm90ZSBy
YXcgcmVhZHMgZnJvbSBpaW8gY2hhbm5lbHMgYXJlIGluIGFkYyBjb3VudHMgYW5kIGhlbmNlDQo+
IC0gKiBzY2FsZSB3aWxsIG5lZWQgdG8gYmUgYXBwbGllZCBpZiBzdGFuZGFyZCB1bml0cyByZXF1
aXJlZC4NCj4gKyAqIE5vdGUsIGlmIHN0YW5kYXJkIHVuaXRzIGFyZSByZXF1aXJlZCwgcmF3IHJl
YWRzIGZyb20gaWlvIGNoYW5uZWxzDQo+ICsgKiBuZWVkIHRoZSBvZmZzZXQgKGRlZmF1bHQgMCkg
YW5kIHNjYWxlIChkZWZhdWx0IDEpIHRvIGJlIGFwcGxpZWQNCj4gKyAqIGFzIChyYXcgKyBvZmZz
ZXQpICogc2NhbGUuDQo+ICAgICoNCj4gICAgKiBJbiBvcHBvc2l0IHRvIHRoZSBub3JtYWwgaWlv
X3JlYWRfY2hhbm5lbF9yYXcgdGhpcyBmdW5jdGlvbg0KPiAgICAqIHJldHVybnMgdGhlIGF2ZXJh
Z2Ugb2YgbXVsdGlwbGUgcmVhZHMuDQo+IEBAIC0yODEsOCArMjgzLDkgQEAgaW50IGlpb19yZWFk
X2NoYW5uZWxfYXR0cmlidXRlKHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwgaW50ICp2YWwsDQo+
ICAgICogQGNoYW46CQlUaGUgY2hhbm5lbCBiZWluZyBxdWVyaWVkLg0KPiAgICAqIEB2YWw6CQlW
YWx1ZSBiZWluZyB3cml0dGVuLg0KPiAgICAqDQo+IC0gKiBOb3RlIHJhdyB3cml0ZXMgdG8gaWlv
IGNoYW5uZWxzIGFyZSBpbiBkYWMgY291bnRzIGFuZCBoZW5jZQ0KPiAtICogc2NhbGUgd2lsbCBu
ZWVkIHRvIGJlIGFwcGxpZWQgaWYgc3RhbmRhcmQgdW5pdHMgcmVxdWlyZWQuDQo+ICsgKiBOb3Rl
IHRoYXQgZm9yIHJhdyB3cml0ZXMgdG8gaWlvIGNoYW5uZWxzLCBpZiB0aGUgdmFsdWUgcHJvdmlk
ZWQgaXMNCj4gKyAqIGluIHN0YW5kYXJkIHVuaXRzLCB0aGUgYWZmZWN0IG9mIHRoZSBzY2FsZSBh
bmQgb2Zmc2V0IG11c3QgYmUgcmVtb3ZlZA0KPiArICogYXMgKHZhbHVlIC8gc2NhbGUpIC0gb2Zm
c2V0Lg0KPiAgICAqLw0KPiAgIGludCBpaW9fd3JpdGVfY2hhbm5lbF9yYXcoc3RydWN0IGlpb19j
aGFubmVsICpjaGFuLCBpbnQgdmFsKTsNCj4gICANCj4gQEAgLTI5Miw4ICsyOTUsOSBAQCBpbnQg
aWlvX3dyaXRlX2NoYW5uZWxfcmF3KHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwgaW50IHZhbCk7
DQo+ICAgICogQGNoYW46CQlUaGUgY2hhbm5lbCBiZWluZyBxdWVyaWVkLg0KPiAgICAqIEB2YWw6
CQlWYWx1ZSByZWFkIGJhY2suDQo+ICAgICoNCj4gLSAqIE5vdGUgcmF3IHJlYWRzIGZyb20gaWlv
IGNoYW5uZWxzIGFyZSBpbiBhZGMgY291bnRzIGFuZCBoZW5jZQ0KPiAtICogc2NhbGUgd2lsbCBu
ZWVkIHRvIGJlIGFwcGxpZWQgaWYgc3RhbmRhcmQgdW5pdHMgYXJlIHJlcXVpcmVkLg0KPiArICog
Tm90ZSwgaWYgc3RhbmRhcmQgdW5pdHMgYXJlIHJlcXVpcmVkLCByYXcgcmVhZHMgZnJvbSBpaW8g
Y2hhbm5lbHMNCj4gKyAqIG5lZWQgdGhlIG9mZnNldCAoZGVmYXVsdCAwKSBhbmQgc2NhbGUgKGRl
ZmF1bHQgMSkgdG8gYmUgYXBwbGllZA0KPiArICogYXMgKHJhdyArIG9mZnNldCkgKiBzY2FsZS4N
Cj4gICAgKi8NCj4gICBpbnQgaWlvX3JlYWRfbWF4X2NoYW5uZWxfcmF3KHN0cnVjdCBpaW9fY2hh
bm5lbCAqY2hhbiwgaW50ICp2YWwpOw0KPiAgIA0KPiBAQCAtMzA4LDggKzMxMiw5IEBAIGludCBp
aW9fcmVhZF9tYXhfY2hhbm5lbF9yYXcoc3RydWN0IGlpb19jaGFubmVsICpjaGFuLCBpbnQgKnZh
bCk7DQo+ICAgICogRm9yIHJhbmdlcywgdGhyZWUgdmFscyBhcmUgYWx3YXlzIHJldHVybmVkOyBt
aW4sIHN0ZXAgYW5kIG1heC4NCj4gICAgKiBGb3IgbGlzdHMsIGFsbCB0aGUgcG9zc2libGUgdmFs
dWVzIGFyZSBlbnVtZXJhdGVkLg0KPiAgICAqDQo+IC0gKiBOb3RlIHJhdyBhdmFpbGFibGUgdmFs
dWVzIGZyb20gaWlvIGNoYW5uZWxzIGFyZSBpbiBhZGMgY291bnRzIGFuZA0KPiAtICogaGVuY2Ug
c2NhbGUgd2lsbCBuZWVkIHRvIGJlIGFwcGxpZWQgaWYgc3RhbmRhcmQgdW5pdHMgYXJlIHJlcXVp
cmVkLg0KPiArICogTm90ZSwgaWYgc3RhbmRhcmQgdW5pdHMgYXJlIHJlcXVpcmVkLCByYXcgYXZh
aWxhYmxlIHZhbHVlcyBmcm9tIGlpbw0KPiArICogY2hhbm5lbHMgbmVlZCB0aGUgb2Zmc2V0IChk
ZWZhdWx0IDApIGFuZCBzY2FsZSAoZGVmYXVsdCAxKSB0byBiZSBhcHBsaWVkDQo+ICsgKiBhcyAo
cmF3ICsgb2Zmc2V0KSAqIHNjYWxlLg0KPiAgICAqLw0KPiAgIGludCBpaW9fcmVhZF9hdmFpbF9j
aGFubmVsX3JhdyhzdHJ1Y3QgaWlvX2NoYW5uZWwgKmNoYW4sDQo+ICAgCQkJICAgICAgIGNvbnN0
IGludCAqKnZhbHMsIGludCAqbGVuZ3RoKTsNCg==
