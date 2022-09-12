Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC75B557F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiILHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiILHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:45:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA413F93;
        Mon, 12 Sep 2022 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662968718; x=1694504718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/JaOIXqfjyzDywa4QvC8OOAMgCRUkbXglrWSJXAM0yo=;
  b=nxa+MmTxXfOAM/PVMOptmU1uI3X8fAOcLPlMhwmux2aQtwRqUZY3yFB0
   hMgF6Mr4Srf/M9umuCFwJ8bdjqkNAAcBsmquA3KsatUgLjt2gdKkmzSoN
   xK9YLa/lbbDLy0UZauLb0/VKDI4YEE0ZtfqH1tZID/P7eftpd/G64z+o3
   MPpKXwrgADkJaZ+0nnWPHw95wLTle0uAzvzev2UEPccS4pziV9i35n1OU
   H2gadnLtOr8NgOeKEsxaOboVu51EOWmUepHJ39qtifb3c4vxu8OaEQWBP
   hApfteFVl0ETrVIkJ+Ac/E6VKYDLdA6fqp4L/jXGmCBMgLZ8LUePaUOa6
   A==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="190403966"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2022 00:45:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 12 Sep 2022 00:45:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 12 Sep 2022 00:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh8BiwfuXqarfKM/1F2tDOSJdsrO2SB8w+DFFg+u2oj7XlvO0q6lR8UapAf16oKM1Y8aaFCcNrP4rUPAgRWwQrtbTz/+nVSe/CABsXPV39KSPMEu7VRRjWgMpaaUKAES4fcbsKK+YKYFUhD1AAkjUgS+uT9pNFMzTZ3WVfi36W7oIyWYPFDj34uScb9W/OfbIHVykLSZjtiFx1vSf3cs7CuvrJ4ixqvlOz7fd3ukhnZa0caUTrk8QkkNgFm+w16fGtGpaBmbfkO5DM1G6LHyhOdnDGxw73jqVgJGNttOjQxDkrQRSyeXOtQjP9rqzikVzEmLHnnpZhNn5cad6lFsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JaOIXqfjyzDywa4QvC8OOAMgCRUkbXglrWSJXAM0yo=;
 b=fqwsGy1krBapSVubO7yGL0QgwoDh30dcJAiEwS52MHTZLfP/N8nBf85mdBe7ojGTNpvlhzOlcmCedCtQ7PcYQ/e3+cK8eCPnoFhU/kUfnyuYqD8kkC66iYJ2lTyIUpTtqFtWQa2EZ1gyDsyZJhdqdq82NlAbeKo7ruEtxfBDMc1kno0slXaAyKNNfpuOL6LnWs/ctEqvXQa2sAHk3WESTPmgRtyyBncZguUcvapaRczDLoe3aAybFq48PgxWO77dIps24KeCz0aGSZy5GSWYk57mfFN6r38FZk+HN9OBrv4xXv1K6AiJAG32uBat2QWvQMqhftDCUmmlo147a4PqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JaOIXqfjyzDywa4QvC8OOAMgCRUkbXglrWSJXAM0yo=;
 b=hZitEKcLVGTwYQdSew6gw1giUdWRapl+MDNdKeRJrytbzJN5Hv/4PhP+ln2COqrLnCdev8zRJgzpkDK3m9LXqwjyb5phks7mqOzxiPlh/wjevdVrQqQFZrjaxCz5D5bYTxowzePY4Ji3dsW4Jkg/t1A2VbHSUNEepU1dWhSMUNk=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA2PR11MB4841.namprd11.prod.outlook.com (2603:10b6:806:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 07:45:13 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:45:12 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <robh@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Topic: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Thread-Index: AQHYwfjCQbG755VmlEGUqK2TrhMH7a3VeaSAgAAuKICAAK1+AIAFHfCA
Date:   Mon, 12 Sep 2022 07:45:11 +0000
Message-ID: <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
In-Reply-To: <20220909013644.GA3731620-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|SA2PR11MB4841:EE_
x-ms-office365-filtering-correlation-id: ab9891c9-5298-45d6-7aa6-08da9492b91b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyaIk7xeESbY2iV89k14GosoKYegsvvk2d8bqbrnLDOsHWytpAR7p84b0j3H0gGaE/x8kRd+wmRSp+EX6MiZ3cWHIuPGZVXyLAh/cHwZWhk8U32ew3wJY6teJWqV9eRWILlq36JLuK8n4zbvy21RbLFXKSPEqj3Fpw605hSj+Y14FrPv7H0b49U54gN2/XGOvvlMgc1pO2VG2kQSJphsMOnT/L+F9jfZDSM9HAGPM+lKzlTc2UTVMcHV+r1j89ahxw1M044932y58koGNk+nTcnIjZ9GpX3Jx18WGSZLcOyW68dJZ1U1QDDKruMl0geV5c6L/mk+3VvcWUOzDaynTrrU+q78OGsFahdl2+KSZ+IJFB4WlDz1XKZveBrsfdQw2tRkNEMrXFSQx6k/Nn6QMd7ZVRJBI6yzjNvyO4ZxQiR4nO7eu9ZhjkrNKt38/QiC+xJczSCBSEP/Ah53NedC63R/U6VqxblgOgXYAwGEDwc7De7xJyj5unVzxr2BQpaE29aIfnBPok+YoCW1vbvxZQjtygP9gCbGjoAA7R0hBggKkoEDyEmGVnsnKcWeKt+eWk49hrh67OiYdMPfzvy28XR63i88wgrCcK2NN4RaVp7L+Hzj5eT3sTegK8SOQeewn5HMTAoOACGScOP1enRSJgA4HOEhC7g4Yp0D24yeMSsGiOPWSVjnOPIh8Ymlr3xTvIpxNp48d84JMz59fcXTGooJ7NzgKM8Un4ZPUC+wAulGBYgoHa/dSunvVt1eyS6gKjS3KtyhuAWaRYvHc3HGnPsi4SFdvJnrbgdAUD+0cJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(366004)(39860400002)(376002)(86362001)(31686004)(83380400001)(38070700005)(31696002)(186003)(2616005)(26005)(6512007)(66556008)(71200400001)(64756008)(66446008)(66476007)(7416002)(6506007)(53546011)(2906002)(122000001)(478600001)(4326008)(8936002)(38100700002)(66946007)(5660300002)(6486002)(8676002)(36756003)(76116006)(6916009)(91956017)(54906003)(316002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXpGNmh4NDZ5Z3R5UG1kY3NlMERCZFNTeGs5cW1jRFIrckZTSlJ4NVd5cmVn?=
 =?utf-8?B?cFgrZzEvck9sTEc5RlFXQ3BheG51WTNBenpjQWp0c1o3RWt2ZmNhUHdvdVkv?=
 =?utf-8?B?NWhWRnFOMkd1YUk3b2ZjVVRzK3dicUdnUzdXMG42WllJNVNBcnIxd21KQkhx?=
 =?utf-8?B?RnpkU3pvVWxnVGNkVUR5cG1KY2NldWlFeXpua0REU0EzZGxEL3BHUS96dFBD?=
 =?utf-8?B?Z05ZNllSbkVWZkk0MVh1bmNYRU1CL2djUFozcGVHYXRUL2tyOHk5NmFvTk8v?=
 =?utf-8?B?NFdud25ldnZEbUtPOCtWN2VrNitiMk02MWVQSi83dG4wNk1LMzJ4ODBvQWFM?=
 =?utf-8?B?SlJNdnpqb1RwY0ZycG9FYzBkeVMyRmV1YzI0YVNsQmlnMzRsekgrRkVLRG54?=
 =?utf-8?B?TG81SkdqRnpzaTlJN0QvQjVubW1BWDV5UjdpRVBjM3prN3lFbnBhS1JvWDYx?=
 =?utf-8?B?UFlYZGV6SW9yZEJPUmUrQXUzSTVzNTBUU2Vab2JZTjZmRG1jQnFNQlozTlp6?=
 =?utf-8?B?S1NlN0NnOVRuQjdXaTQvazhEM2hTcUliZ0dUM0h5Vnh3bWZYS3REL2xkMWNY?=
 =?utf-8?B?dEpIQVBpaTZxNjdwMWMzNGJ6RW51eWJVcGtmK2pUQmoyS293TE1RT2xQTHJE?=
 =?utf-8?B?eGE3ZStnMTgvYmFpSGdVRitnVkJTVkNSRWk0QlRDODlDb3dPVk9OTXlEcndY?=
 =?utf-8?B?eGs1QjFBSDlZSnNsWkl0TEVBSWhCVmkyMk5XdzZhTjVyK2xBYWo1MkZSQThS?=
 =?utf-8?B?RzBZeGVNbjJwdEQ5b3JjT05nZEVWRDJsenpPQnJOTi91Vm9vN0RPbi9hYmN0?=
 =?utf-8?B?Umc3bENrS2RzVEY0SFlxbGdTZlpZSlRFMnc5THFDNEtISEJyVmM5VThrOHV2?=
 =?utf-8?B?RUZGRE43Mk9CNWJjK3g0dGlzc0htelZGelNKV25LQUx2eUxUdnpCRGVTYmRM?=
 =?utf-8?B?blVZTU5USVdwVndNUnRZeXlyelRnemp2S2t6ZkdMUkV1Rit6eXJ5MW1VOElo?=
 =?utf-8?B?UHFYUHc0anB6ejNGU1RtbDRBUFY3UVFOend0Y1JkU1RKNit3OTIzcmxOSGZ6?=
 =?utf-8?B?Vy9vOVVnNDhTV21GWGdKcTRDUndqbGdCbmthaVY3NjJja1UvOXRXKytTZWRk?=
 =?utf-8?B?RmRuYXR6MldzamVSdE02VVBQWldYZ01BRGpBT1h4UlZWTTRIWmptTzZjVTJI?=
 =?utf-8?B?aWRUNDZwc2xLcW5qTjI2blRIZTdaK21VQzUzaEJQby9kYUo4bzNnbWRYQU5i?=
 =?utf-8?B?QnBFNjdBdXJxWlI0RGhiaHltVWRXcFBuZll3Qk1Day9vZTlIRWdXU0NlejFO?=
 =?utf-8?B?SW54ZDlPWFByODVSSFp3dW8yQUI5SDdWalUzTVZsQlI1SEFnek9sOTNoa2NG?=
 =?utf-8?B?TjZFNlNuNWhCV1I2TldtTkV5ZXpic2dtTjFCZmU3RTlsdVc2WExoSWhuMitu?=
 =?utf-8?B?WnVxalBJVlN2M0orMU5qUm5xUVdEWVZjV3NoenRHOHY4UDY4VTN3ZXRDZDBj?=
 =?utf-8?B?ODBkMDZRMkJLMUlKVGRMeXNHY3U2emVubzJ4eGlRSVVhcXJicEZacXZwNW5Q?=
 =?utf-8?B?SVBhWWtOdFptWGNhemdXSlV1TjNRcWJVa21UbkM3djdnRGZYQk4zMVhnMk9G?=
 =?utf-8?B?UTVKT09PQ1FRUFVpNTIwc1BtVnRjaE5LclNJUVg1YjdxeHRHYU1KNWxWSW9h?=
 =?utf-8?B?V1JGUHFhdDR3K2xmRnZ0dzNYTGh3NkY2VHczMWxBY0NtWGEzTWVIdzJzVE00?=
 =?utf-8?B?eWtPYTBDRUNjZFRYRHpYLzRtZWNKb09PdU9zNTQ5TXo3MmxXa3U3bkJLTkdr?=
 =?utf-8?B?OGtSa1pKUFZFQVVobGlHdy94c3BxS3oraHVvRkhneTdXY1pRQUJJMUNnUEVT?=
 =?utf-8?B?VzRUeE9BMmg4eVQzL0NRNjJMa2lzbmdQNTNQM0hYdW4vSXRrcktyVGs0ZzFB?=
 =?utf-8?B?M0Y0a1VqblZzQWxxMGJDSWpKMjVwZENrMUdMeHQzaUtPWmNjR2p3RHoraE8v?=
 =?utf-8?B?MGFUUy9XSUxYQnFQdzNCNkpTNjhKeXRnR2RIUGJORnBWWjE4OFdOdENUT2xt?=
 =?utf-8?B?UHNQSGJGVThiTnlNM2EyMU1JZUo5azI4cjNkVkVDS2gyb2x4Uk9tcDVRTW9I?=
 =?utf-8?Q?Gb2wA4Xj2Sd8LycApvAeQRd1t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C254C9EAECF81C45B2044E7AE748BD84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9891c9-5298-45d6-7aa6-08da9492b91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:45:11.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pybVfKTAk1B0ZB/RdESducGKKt2Grn3XHJs3oqVgm7eGsODaSH3VBeDpcWIf0CxxyQ5RjvVkqah4YSCesMeOEPYoi1m0PURl9hGgvuM8LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4841
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDkuMjAyMiAwNDozNiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFRodSwgU2VwIDA4
LCAyMDIyIGF0IDAzOjE1OjQ0UE0gKzAwMDAsIFNlcmdpdS5Nb2dhQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiBPbiAwOC4wOS4yMDIyIDE1OjMwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
Pj4+IE9uIDA2LzA5LzIwMjIgMTU6NTUsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPj4+PiBBZGQgdGhl
IEFUOTFTQU05MjYwIHNlcmlhbCBjb21wYXRpYmxlcyB0byB0aGUgbGlzdCBvZiBTQU05WDYwIGNv
bXBhdGlibGVzDQo+Pj4+IGluIG9yZGVyIHRvIGhpZ2hsaWdodCB0aGUgaW5jcmVtZW50YWwgY2hh
cmFjdGVyaXN0aWNzIG9mIHRoZSBTQU05WDYwDQo+Pj4+IHNlcmlhbCBJUC4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQo+
Pj4+IC0tLQ0KPj4+Pg0KPj4+Pg0KPj4+PiB2MSAtPiB2MjoNCj4+Pj4gLSBOb3RoaW5nLCB0aGlz
IHBhdGNoIHdhcyBub3QgaGVyZSBiZWZvcmUNCj4+Pj4NCj4+Pj4NCj4+Pj4gICAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwgfCAy
ICsrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRt
ZWwsYXQ5MS11c2FydC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nl
cmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+Pj4gaW5kZXggYjI1NTM1YjdhNGQyLi40ZDgw
MDA2OTYzYzcgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+
IEBAIC0yNiw2ICsyNiw4IEBAIHByb3BlcnRpZXM6DQo+Pj4+ICAgICAgICAgIC0gaXRlbXM6DQo+
Pj4+ICAgICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1DQo+Pj4+ICAg
ICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4+PiArICAgICAg
ICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLWRiZ3UNCj4+Pj4gKyAgICAgICAgICAtIGNv
bnN0OiBhdG1lbCxhdDkxc2FtOTI2MC11c2FydA0KPj4+DQo+Pj4gVGhpcyBpcyB3ZWlyZC4gWW91
IHNheSBpbiBjb21taXQgbXNnIHRvICJoaWdobGlnaHQgdGhlIGluY3JlbWVudGFsDQo+Pj4gY2hh
cmFjdGVyaXN0aWNzIiBidXQgeW91IGJhc2ljYWxseSBjaGFuZ2UgaGVyZSBleGlzdGluZyBjb21w
YXRpYmxlcy4NCj4+DQo+Pg0KPj4gRG9lcyAic2hvdyB0aGF0IHRoZXkgYXJlIGluY3JlbWVudGFs
IElQJ3MiIHNvdW5kIGJldHRlciB0aGVuPw0KPj4NCj4+DQo+Pj4gVGhpcyBpcyBub3QgZW51bSwg
YnV0IGEgbGlzdC4NCj4+Pg0KPj4NCj4+DQo+PiBXaGF0IGRvIHlvdSBtZWFuIGJ5IHRoaXM/IEkg
a25vdyBpdCBpcyBhIGxpc3QsIEkgc3BlY2lmaWVkIHNvIGluIHRoZQ0KPj4gY29tbWl0IG1lc3Nh
Z2UuDQo+IA0KPiBZb3UgYXJlIHNheWluZyB0aGF0IGNvbXBhdGlibGUgbXVzdCBiZSBleGFjdGx5
IHRoZSA0IHN0cmluZ3MgYWJvdmUgaW4NCj4gdGhlIG9yZGVyIGxpc3RlZC4gWW91IG5lZWQgYW5v
dGhlciBlbnRyeSB3aXRoIGFub3RoZXIgJ2l0ZW1zJyBsaXN0Lg0KPiANCj4gUm9iDQoNCg0KVGhh
dCBpcyB3aGF0IHdhcyBpbnRlbmRlZCB0aG91Z2g6IGEgbGlzdCBvZiB0aGUgNCBjb21wYXRpYmxl
cyBpbiB0aGF0IA0KZXhhY3Qgb3JkZXIuIFRoZSA0dGggcGF0Y2ggb2YgdGhpcyBzZXJpZXMgYWxz
byBlbnN1cmVzIHRoYXQgYWxsIDl4NjAgDQpub2RlcyBoYXZlIHRoYXQgZXhhY3QgbGlzdCBvZiA0
IGNvbXBhdGlibGVzLg0KDQpSZWdhcmRzLA0KCVNlcmdpdQ0K
