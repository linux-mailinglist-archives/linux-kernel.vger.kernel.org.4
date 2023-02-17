Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6E69A98B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBQLAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBQK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:59:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483AB635A6;
        Fri, 17 Feb 2023 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676631583; x=1708167583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tO5Ah8HjETtB7eHDnWSBSMjx9jDSA+tLg1e+rhNFhgY=;
  b=aD0xMIuWGCcK1kMjHAQL1RQ52hNBfAkExm0Ltd+7C5soLlvlRxiE8ybj
   3h9BO5lsBZvzG1TQyqjUy4Vd2ASAN5G2hZM5HxrcwuWR4YCws1f6VK+JX
   h6g69jCoyx7r9aLwuqVimLW67otZqV9AX3BilFbJ+eYoNbOVJihgAAFTV
   CtzgUkd9lHnK/JrMxilE0cPnzLZYHIWz8SSKbfHkTLJQXyqUjM6PVnkMY
   KdEvooCJ266R+AZ+5sZCiXyy0Eu9wQ/2NafPkT6rcHzOvjn3/4nCIMUkV
   m0o/lwd75WWDzq0zeqktn6FNtJ9p8yw64m2PaZarZGSHfjrZTCa+fn9pJ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201433658"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 03:59:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 03:59:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 03:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCIr+cx0Bn2ItvcTM1012YR1KqdmJHeoiWZqNzmxrAkSPEVoBj+0I0VlpzmEr+eFsuWcjFvt51jXJmythc0zOLKwVbZeJP98OUP+oZJpGGtrgm4bmTzq4ZvFB+HTsK/+e0hFsemcm+c1FJ+t+zn+bN3BCyFjWGotrIJwqBj6GzpN3aU7kDVEVo/bzXEVzm+e3W/FKJvqAxh+bYJJdsNPrchQFLxj+1W+u05x6f/aNmWJOFu4do6pguv+iUz46xlbfhpUywPiM6ds8ZabJ1ghfPTF5W+2G6jrVw3CvFhqx22A5vqww0ooKkC+i8JIRaENfiKgV5u7lDRZM95d8Tih3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO5Ah8HjETtB7eHDnWSBSMjx9jDSA+tLg1e+rhNFhgY=;
 b=SkYLXERxxo1EtGksgvCF68YikbPAhxbtKQKJE9xBYcJMv8tDykQYC4V8Utr+l6UqhUNRo0/FgAJ6dbUPkEttVGEjvRLb2omuY/nez579V8c5GE8oYuUUt5cqEtuuhls1P4Z6/TB8szsDMTXSLS6KyVLl1Z5RcmL1vQQIneUGADx7fAhUm7zxHZYDozvsmJsNo1nOw0OC5vuc3V4Il95zfdlbWOJPmKEcFB1ww71uiUYfjut0vQPC+te8BVf7183KIooaLfT3D3C+NaOwH2xKywH1PNiDWwZdlQqIFReD9eq3SnuBGm4dy0LptQww46XlpGugz+bo98HWv/NgZVv7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO5Ah8HjETtB7eHDnWSBSMjx9jDSA+tLg1e+rhNFhgY=;
 b=bhFV9/VapGcBqSCQSQqY5TMssgAZN7gZrt6uPyA3gQVwCDt2pAvJ/2cerAUKkW8sJLFbWcoahN8uVmVrZjL8Wya+1XFZ05tWO43L89gZFuvW/KPP7Yr3zBsj5rFgJJF2o8F2eq0+sCe40iAZ33YZbQaiTYSCuPhyrgZSgyiUZZw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Fri, 17 Feb
 2023 10:59:37 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 10:59:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lars@metafoo.de>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Thread-Topic: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Thread-Index: AQHZQr7snmxOkJJ5jUmfLXfsZIvw9g==
Date:   Fri, 17 Feb 2023 10:59:37 +0000
Message-ID: <61ce577d-03d3-5437-52ce-ec823a7a89ca@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-2-claudiu.beznea@microchip.com>
 <b065e2bb-1f11-067a-b085-45d47626927e@metafoo.de>
 <Y+v8bbr4cNSOA1SF@sirena.org.uk>
 <4b109846-2019-219a-262e-46f5bb504c99@microchip.com>
 <b57b8fbe-c558-8d5d-5fb3-7540d2fa83ae@metafoo.de>
In-Reply-To: <b57b8fbe-c558-8d5d-5fb3-7540d2fa83ae@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5354:EE_
x-ms-office365-filtering-correlation-id: 881d1be7-09a8-4aef-b771-08db10d60f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVXWdNYllwnrX/xb5c6Dt3AqlSMdDTgsZJ6oOb0rBiJw2cWuvUjXNfS1hm+ivY6H8fmo9CXRS836tjzqpmv6I4y2F55kmOIcpD498gOwt8FQSvL9gqxMFZ3Z4c9z6ZuEGTrMja4UY6r1joLiHs3988ufvbjGCvO421aSyw9NWa6gDBtL8U9CtWzj0JeZttDAFB4GYcSAMF1nb+4wio6+c44DojoTSjRHJmFng9kfCTBBmHBR8I5+SPVTqABovQeBV5iuPPidqU6Q9Q9GrKY0OCFGVRWs2KCNGPM9/kkIFJ69Q5pHsLbS0hMPCB34uWgQtry/mnpg8wec+pT0VTx8YtpwT61hXp4aBV71SZfhPZ8YtkbRLxjTUtbiW7NDmu6XsP0rzd/DYj/GdOj8ufSevgVMFnGf1TWWP0XLgU9ZV4lI68CBoWMdMMzWUuZTpnQNK3OXeRWLcOPDTOkNuZPaSamLO18E0q7kGC//HUUvUTgFjn1rZ2o6rHr/+t/cU+wwJ4Y+biHGpk73DIuz6uHQbpJ6na+0jGxQQeZTOrht4/i8Fce3PwDSGhm/ot5X4vZDcWhIVWZAVkERqt1Dw90a0FANNZiC4fI81E+32kNEQEPW1H81ko69KKleYCupZIKtTAHuVk7kM1jKLF0KgFEVr86RS/uJNmiSxhc/0+FGeYTZmuasvjl2B9ZHxezBArw72ZSAwaJDRoe3kb9Q1IGfbziOnsoilmmO4bCcSlNGzjowRSEtL83tN+yWMzySmmJH+5bvdG+QAkQ+fVnIgufB/oECle3pQ0GDVAqozCue5ZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199018)(83380400001)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(316002)(4326008)(8936002)(7416002)(5660300002)(41300700001)(2616005)(6512007)(6506007)(53546011)(26005)(186003)(478600001)(54906003)(110136005)(6486002)(71200400001)(31696002)(36756003)(38070700005)(86362001)(2906002)(122000001)(38100700002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkNwQXZvR016VUVFVFBLaGdhMkViSVJDYlNHbHhWZ0hnMGFYM3hNZTM1TEhl?=
 =?utf-8?B?RXhyVnlTbGpzcmc2R1FENmdzZzdLSjlnWFFjYmxQdzdDbXByVmcySXBMcFlz?=
 =?utf-8?B?MTcxM20ycjJMdzAxcGZzbjIrQStUUjNlbVhMdUhVNzNRNjdYQ0FGT3VKcUpv?=
 =?utf-8?B?SElCbk82YVRxbEpCUk1lUmpCcEZQcmxabVZ0YUFyN3Fkc09EZDZYbkVNQXZi?=
 =?utf-8?B?cjVqVEM2LzZTNEx1Q1FHY0JtM01EM3AyK05QZGN3ZEIxTC9uekJaa2FtenVv?=
 =?utf-8?B?cER0WjlBMmtQTVhOVEdTK2tuWXdEd0JFTkwzMWN0OXRGemJCU0VJZmhkQjN2?=
 =?utf-8?B?d2lWYTE4V2RYL3N0bW01K3BMUmdVSTRXb1BSQWY1L2QyMjZ1YXdjYWZHZTFK?=
 =?utf-8?B?dmNHWkEzQ3RycFRwSjNTNGgzc1FzY3UvQXE0Wm9aZG0vSitpd0xCRDA4d3Zi?=
 =?utf-8?B?NjF4WEhobUNZUnNhdU1Lcm56Y3MyUDM5RFh4RDZKMkNqNElBc0lWZFpjVVdR?=
 =?utf-8?B?VE8zYlBCS1dZcVFkbStCUmYwbVFLa2tqeExzNlZvd0IzdGc0SUY4T1Zxd25T?=
 =?utf-8?B?T1lmZ3Z3T3lpWWFGclZ3T2x1WHZDcjhRTEJCQm1OWFV3bzV2anlvYWFSM1hU?=
 =?utf-8?B?b3Q0L0MzUS9WQ09XSzE5MlBMSUdLOUl3ZE1oS045VGx0TEZ0REtUVXdTWFE5?=
 =?utf-8?B?Zm04Z3RhcDMwRTVwdGk0OHF0dFlGOFRFTlBDbDFJazdFdWk1QnF4R3QyMUJB?=
 =?utf-8?B?empvYnF5am8vZTZmZkU1Qlo4Q25Mb2FsOHBoN3BsYkVqRXMrMUdxVFd2MEZv?=
 =?utf-8?B?bVFjMmJnZHI0bUZxcnFVcTZoQlI3TGVEeStDMDZlSUtJWTVKVmFEa2F3NCtk?=
 =?utf-8?B?QnZuNThRT1o1UWRQQk8vblBNMWJZVUh4aU5scDhOdElVNVY5SklxVEpRQXpl?=
 =?utf-8?B?TXo3S1hTVnM2MDA2U3JmdGdZVmJSa1JBTnR5aFpKbjdJUFRsOEpBZE5JdnJn?=
 =?utf-8?B?b2pmTUlFRm5WVG9jR01abCt4RXd3V2FacE40a3RQK1N4aWJrbHNJYk9STUFr?=
 =?utf-8?B?UWFFWWxXc3owc2hjWjBPaXF3TUFXaHcyZVZEUE5ja0pCUUU5Vm9RbnNUc01G?=
 =?utf-8?B?b21xeCtDUVo1aURROUNnZTRwLytXcW53S0JxV3duSVFvT25RTzZEc29yN1BF?=
 =?utf-8?B?dVZVbzVGbmhlNWszbG1HTVlKaWkwUUJiWnpMUEpkenNsbXpqZi84N3RVZ2Fr?=
 =?utf-8?B?UkhOZzdCZ3ZHbzBoSXFRQmo3Sk1wYjhna2x5UDVHMkorWmIxOUZQWXlUa2pR?=
 =?utf-8?B?cDVWNGFRelRkbWw4QVVicXh3elJsakwwSWNqdXVaYm1MLy9FUDNuTElOY3pX?=
 =?utf-8?B?cVZlK3RabHpjTFdCazR6TUw2VHNwb29vWmQ5ZFhnMjluL1RsWDFQWXEvN0h6?=
 =?utf-8?B?Z2tXTjArbjd3YjdCMmU3Z051eWhxbng4TzVDam56c2ZvNTRzNzh5MzFML2F3?=
 =?utf-8?B?a29CajVIUHExZTNxL0JheEp4bGRMeVY0QU53ZVFpeGMzZlp3NFB3WHVwVldL?=
 =?utf-8?B?RENyQi9lRjc4Yng4MGhwUkRDdVNZUnpjL29zaWdZYWNLUGFIRmFsUklXbjV0?=
 =?utf-8?B?TGN5R2JOek92UWNFZHpTTzZ5WTUrWXdHcVU5R1AySmFYTi9MSFF5d3RYUlRq?=
 =?utf-8?B?Rmx6S1YrM3JuMXFQNmF0bW1lbXRiQTBmUkYya0dNQlVZaWNTUWhqVHhvM0pj?=
 =?utf-8?B?cEFGNjQwbmM0ZGNjQVhOUGltY0QzSEUvSTJOaE1adDBXN0JjVDk4dmhzaUxz?=
 =?utf-8?B?UnoxQXV0UlVaUXhzWXdmTDdXaEtLN01DNWRSVUNMVnBtcFdYVEZyVU5lUEhG?=
 =?utf-8?B?QXU5c3llaXprWFJDS2VGdzRrc2NmWnVzcW5XaGNwbXlma1ZkMXhxN3dkbHZu?=
 =?utf-8?B?d3RhSk5pVUJrblhFMW02eExLVnFYM1plMEt2MGxuUGN3NkNSLzBCSVZidDEv?=
 =?utf-8?B?djFyUEk5K2p6T0NDb0hTRXl6a29OUkY3bjMwbmR0RHBwQWxDVHpTSytiK2pm?=
 =?utf-8?B?bklvQ0lRanlEdllmc2NvMTZqenJJcVJ5NCtDTGkyZkswY1N0MElCZHVOeFdD?=
 =?utf-8?B?dlJGTlFvK3lad2lhdE9QSmhlWnY5KzUvVU94cUtDU3VaVTdnS094cHJZSyt3?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E055AC11DB8269479A5AE24A6DFD2006@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881d1be7-09a8-4aef-b771-08db10d60f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 10:59:37.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2eR1JH2dPCqXsVwLPXOQUHTDvWysZ3jkyp9aZAI93vCkFas+UoJOdJTVWvwehuKbvu9nh9NXVnSuFTJlUZRWpWEqoOdVR6P6ToxbJa1N6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5354
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDIuMjAyMyAxNTo1MywgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIvMTYvMjMgMDE6NDksIENs
YXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAxNC4wMi4yMDIzIDIzOjI2
LCBNYXJrIEJyb3duIHdyb3RlOg0KPj4+IE9uIFR1ZSwgRmViIDE0LCAyMDIzIGF0IDEwOjE0OjI4
QU0gLTA4MDAsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToNCj4+Pj4gT24gMi8xNC8yMyAwODox
NCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+Pj4+PiBAQCAtNDUwLDYgKzQ1MCw4IEBAIGludCBz
bmRfZG1hZW5naW5lX3BjbV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZHJpdmVyID0gJmRtYWVuZ2luZV9wY21fY29tcG9uZW50Ow0KPj4+Pj4gK8KgIGRy
aXZlci0+c3RhcnRfZG1hX2xhc3QgPSBjb25maWctPnN0YXJ0X2RtYV9sYXN0Ow0KPj4+PiBUaGlz
IHdpbGwgYnJlYWsgaWYgeW91IGhhdmUgbXVsdGlwbGUgc291bmQgY2FyZHMgaW4gdGhlIHN5c3Rl
bS4NCj4+Pj4gZG1hZW5naW5lX3BjbV9jb21wb25lbnQgbXVzdCBzdGF5IGNvbnN0Lg0KPj4+IFJp
Z2h0LCBpZiB3ZSBuZWVkIHRvIG1vZGlmeSBpdCB3ZSBlaXRoZXIgbmVlZCB0byBzZWxlY3Qgd2hp
Y2ggb2YNCj4+PiBtdWx0aXBsZSBjb25zdCBzdHJ1Y3RzIHRvIHJlZ2lzdGVyIG9yIHRvIHRha2Ug
YSBjb3B5IGFuZCBtb2RpZnkNCj4+PiB0aGF0LsKgIEkndmUgbm90IGxvb2tlZCBhdCB0aGUgYWN0
dWFsIGNoYW5nZXMgeWV0Lg0KPj4gT0ssIEkgd2lsbCB0cnkgdGhhdCBhbmQgcmV0dXJuIHdpdGgg
YSBuZXcgcGF0Y2guDQo+Pg0KPj4gT24gdGhlIG90aGVyIGhhbmQgZG8geW91IHRoaW5rIHRoZSBv
dGhlciBzb2x1dGlvbiBwcmVzZW50ZWQgaW4gY292ZXIgbGV0dGVyDQo+PiB3b3VsZCBiZSBiZXR0
ZXI/IEZyb20gdGhlIGNvdmVyIGxldHRlcjoNCj4+DQo+PiAiVGhlIG90aGVyIHNvbHV0aW9uIHRo
YXQgd2FzIGlkZW50aWZpZWQgZm9yIHRoaXMgd2FzIHRvIGV4dGVuZCB0aGUgYWxyZWFkeQ0KPj4g
ZXhpc3RpbmcgbWVjaGFuaXNtIGFyb3VuZCBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluazo6c3RvcF9k
bWFfZmlyc3QuIFRoZQ0KPj4gZG93bnNpZGUNCj4+IG9mIHRoaXMgd2FzIHRoYXQgYSBwb3RlbnRp
YWwgc3RydWN0IHNuZF9zb2NfZGFpX2xpbms6OnN0YXJ0X2RtYV9sYXN0DQo+PiB3b3VsZCBoYXZl
IHRvIGJlIHBvcHVsYXRlZCBvbiBzb3VuZCBjYXJkIGRyaXZlciB0aHVzLCBoYWQgdG8gYmUgdGFr
ZW4NCj4+IGludG8gYWNjb3VudCBpbiBhbGwgc291bmQgY2FyZCBkcml2ZXJzLiBBdCB0aGUgbW9t
ZW50LCB0aGUgbWNocC1wZG1jIGlzDQo+PiB1c2VkIG9ubHkgd2l0aCBzaW1wbGUtYXVkaW8tY2Fy
ZC4gSW4gY2FzZSBvZiBzaW1wbGUtYXVkaW8tY2FyZCBhIG5ldyBEVA0KPj4gYmluZGluZyB3b3Vs
ZCBoYWQgdG8gYmUgaW50cm9kdWNlZCB0byBzcGVjaWZ5IHRoaXMgYWN0aW9uIG9uIGRhaS1saW5r
DQo+PiBkZXNjcmlwdGlvbnMgKGFzIG9mIG15IGludmVzdGlnYXRpb24pLiINCj4+DQo+IENhbid0
IHlvdSBqdXN0IHNldCBgc3RhcnRfZG1hX2xhc3RgIG9uIHRoZSBgbWNocF9wZG1jX2RhaV9jb21w
b25lbnRgPyBJbg0KPiB5b3VyIGNvZGUgeW91IGl0ZXJhdGUgb3ZlciBhbGwgdGhlIGNvbXBvbmVu
dHMgb2YgdGhlIGxpbmsgYW5kIGlmIGFueSBvZg0KPiB0aGVtIGhhcyBpdCBzZXQgdGhlIERNQSBp
cyBzdGFydGVkIGxhc3QuDQoNClllcywgdGhhdCBpcyBhbHNvIHdvcmtpbmcuDQoNCkluIHRoaXMg
cGF0Y2ggSSBjaG9zZSB0byBoYXZlIGl0IG9uIERNQSBjb21wb25lbnQgYXMgdGhlIG9wZXJhdGlv
biBpcw0Kc3BlY2lmaWMgdG8gRE1BLi4uIEl0IGxvb2tlZCBiZXR0ZXIgdG8gbWUgdGhpcyB3YXku
IEJ1dCBpcyB0cnVlIHRoYXQgaGF2aW5nDQppdCBvbiBtY2hwX3BkbWNfZGFpX2NvbXBvbmVudCB3
b3VsZG4ndCBhZmZlY3QgdGhlIGJlaGF2aW9yLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1DQoNCg==
