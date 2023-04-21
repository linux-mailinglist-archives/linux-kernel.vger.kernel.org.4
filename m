Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F66EA2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 06:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjDUEwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 00:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDUEwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 00:52:03 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF863C07;
        Thu, 20 Apr 2023 21:52:01 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KNKVYU022863;
        Thu, 20 Apr 2023 21:51:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=hMPw4cZsDtE6K5XpmYQn6p+sYcZj0EbOSFCbEbE18MI=;
 b=PhN8r7ZeXgNv3KrbRTpfUj/5GFAsOHJoosspdkZOV0w0KvPTC0iEiYLTPqwp1npSR+Kk
 GbmlCX9GR+1NMDI/hgrDpcZSC7TqkVLuKAXso2/AcH9OZopeGMqn04aktRUDotuq8ahu
 Dp7kLVFz4TGl9CzgCg/UgEPpCfkDreWnyw81Z1RFME8Lu0c9jv/oyH1JqfvQX7F5AXNc
 OLEBf7GPKxCc11HgnKzmMnHOsLmbcrpRlA+XL8tC7zw+kURmOjf4a4pETTyEvZlH7DzC
 Hj3XspbyF4nWQ3JnQxcnZ4fdJTx+o699z2dn3fBV4nfGpNrbX2yIt+maQ2T8vdm/ZcId dQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pytjfmw0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 21:51:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682052689; bh=hMPw4cZsDtE6K5XpmYQn6p+sYcZj0EbOSFCbEbE18MI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LuqLRhT4Cv8m1UWjDk0drJKL/dSmTSGDcMTImcQ8xar+MbhC6DsHymS1dbjd1iPHQ
         ptl0Y2ds0DCqSURSW40DGVhAwkK1VYo4/6OJ66Fbitoh2LG2o8Q6GWEWkKyAotUeyY
         8YinViooj26EDftxym5Hig+UDYJSfsbdXXl1hb7voWQnV4vK6q0scXtlqZ3fT0LSUF
         GDrgsk23xM0T0+4lzjbAgZ8x0/EBrfZaY87vG6MQ2XogKeRBe0NpBefL2IVT+EypM1
         M1rvjk9dY7ZhJBIEGFHbwJ75+M3i5M5L5mVo5nP7PiW1SH+a6Vq9iiERkm90XMvY5p
         /NJ7ahJLJin8Q==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 367E140707;
        Fri, 21 Apr 2023 04:51:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8A77FA0062;
        Fri, 21 Apr 2023 04:51:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Iv7Jbhhf;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 72A444045F;
        Fri, 21 Apr 2023 04:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/My7INSlc2w28tbY5a7NXBrYCMzujwuNAoNzP9fraU9eFXRvnYVMTsrUTTq9iMKbSIy3xiFew433tlHX+6oOcgUkQvD1N6fcIhTYttMNpGl9IesGsbrNxcb6M+aDOKv+S8lvzYhjiNq6lDZz/q6knq1deioYahH/z3SZ7GY+0H6EVrZaCI0QE3P3aECbwESbXRpYmHc+adyn7BvAJhVOaKdFUsnQCzs0LQgAgUOiPbh6mGR+ye9v/pTjJ3eLDUOgpZakZhklkRS+nRnGE93zaiB4aXK1MxwP0/zP5qB1xFyoVdVJAO3N4Ww6rpd9HWpbjHLd8JAWUmoSGZkSpGn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMPw4cZsDtE6K5XpmYQn6p+sYcZj0EbOSFCbEbE18MI=;
 b=GwfHGD6PmAsAw73F6f3+a4PRgasNSHKjgCkFgECpf509AL1UjH2yqfep3ejfMeJc3L7GSgmzcKVv/ocODIhbKB7ouQ4no/w6lSFp7C43ezbyPIYCwo1j/DDn+d8WgJ8Rc8lFsSAq9mRGEe/hxloF5WpE0Y0PGrDVbKw8iAG1Qkjt7pxMHX4mFsR7uZqTRL/8Z+WanU16a9600I34fmvDbspZZ3yl5kFrVaPYdNLLVrSDv3adleBGU3fRr1QuEbbknHbpUpMMeNZxUqJmVfc492TUQENSTDER8+FJ5eKCmNPD9vbbFI3Me4w0/pCqITU/od0InUqtP2DwX2GRTRBG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMPw4cZsDtE6K5XpmYQn6p+sYcZj0EbOSFCbEbE18MI=;
 b=Iv7JbhhfJf+gHSmPiBwNljQWZ5BL2lTMN/b91Fsi1l+NEbF6oLNdLqL6+uajiKTr0aHUWOHcSXM7EGGCPiUCK2VTEVxyMVgWbvorJX+LqOc7d8SW93odK093TCKVad2dDquUChDVrxKc8Ao+eQ3IdZJkyyaSIAWtokKEqYq1E/k=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Fri, 21 Apr 2023 04:51:07 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 04:51:07 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "yue.wang@amlogic.com" <yue.wang@amlogic.com>,
        "hanjie.lin@amlogic.com" <hanjie.lin@amlogic.com>,
        "kernel@sberdevices.ru" <kernel@sberdevices.ru>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] usb: dwc2: support dwc2 IP for Amlogic A1 SoC
 family
Thread-Topic: [PATCH v2 2/5] usb: dwc2: support dwc2 IP for Amlogic A1 SoC
 family
Thread-Index: AQHZcec6852sRcCeZkW0BqTORJeXs681NfOA
Date:   Fri, 21 Apr 2023 04:51:06 +0000
Message-ID: <8fdc2299-1c81-3472-b1ce-2187886b4568@synopsys.com>
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
 <20230418111612.19479-3-ddrokosov@sberdevices.ru>
In-Reply-To: <20230418111612.19479-3-ddrokosov@sberdevices.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|DM4PR12MB6135:EE_
x-ms-office365-filtering-correlation-id: a09ec5c9-5f2e-45b2-6f00-08db42240490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CyWd4OgmTTxyrgljHAdvdjEG6/AKuzLyQ9RzSiNxx2w/UFP8+zg1mX5U4AsIPhIYz4HaL7jh3tdBHWF9zlxoO4W2hDaoxUoF7uIp3mdfk0VIOInPHrGidGbRG+nQpkU/6X9gPDG7ctB24vqN52MXpHLV1c5yNuG5mCsbACwyV3pfcf+Wb36b6vy0iEclCTnqRmb3z6sEjU/U4y0dFAz4wusefUzyxmyF+u0W+A5WKWfdEPEYLKT6WbUNN4Glo4N+MUA0+YKpMRbnXnLIZJjUd/36v3jxheRrx26ycB53DHAEjnXL0znndSFwJOynM6iCeHGBHVia/kHDCQRgnf38fjzC/YkSP4Ig4n/tQjgI5SZa+5LCLMC4U1dXkWUseX+6+nDz15v0AK0uMOMFL2ePljBnpqhkqVh/k/K7eAKj9TmTm/hgW/TsBB2z5H2QpxpHkvTsGk4UN3Lbu/i9P6Od1dnCfU/tnhgWYQQglo6jbsMe9YmON8XhvgPdIxP2DfUn+t2ybzRlfgBHJtHf6RQFWta88wE7JH4hblVQGwRrsL7GVTzX0wU3PDbz0nQYzmQZ1HjRcUXXwEk+T7rBpYL3dY5kPt/a7bmTm32B85xhwMTLdX0Ck8ZQ8V+x1eSo7ZFMZVjUtFhTUdCHg2yioQu4B0tuICmcSlx6azxmeqM8BwdB3MGEonGUOYwlQhdPpc2An5t4bWf/IFXFYfz7EPpXXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(6636002)(66476007)(478600001)(71200400001)(8936002)(8676002)(316002)(66446008)(41300700001)(91956017)(4326008)(66946007)(66556008)(76116006)(54906003)(122000001)(110136005)(38100700002)(921005)(186003)(53546011)(2906002)(38070700005)(6512007)(26005)(36756003)(64756008)(83380400001)(6506007)(31696002)(31686004)(5660300002)(86362001)(2616005)(6486002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2d1Z1preUEyTlAvSUlEY3NueFdYWlZCWnByRlB4Szh2azZub1IyKzZWQkJo?=
 =?utf-8?B?SWVWYVVHS3Bjem1ka3NSTzVEOWVlQ0JWeldKT1FCYmIzbWVFMVpoSUNaUnJX?=
 =?utf-8?B?cGg2cE1IekRadHBNcENaWEpxeGlrVXl3R1phTVB2UlNIZVY3SDZnUWQzdlZG?=
 =?utf-8?B?b21YNkk5ZjZvVXZ6eW82cEtIZm5vaHZyT1ZvYkM5YjVXZ2NkT3hkbS9sS0pl?=
 =?utf-8?B?S2pxZWhJU0xHaTFmdnpxR0lKUGZSYUFyaW9XNTdrL2lHYXIwOE16VXhxSnZJ?=
 =?utf-8?B?Nlp2WEMvaUswbi80TDkxcEVnSzZ5b1ZhOU4vcFg5Ri90cFBLa3NNRjlrKzdY?=
 =?utf-8?B?TDkzRXFoNFh6MERoelZqNTRIdDdhN3NNeklaeGdwZCs1eVdOa002Ykk4NHlw?=
 =?utf-8?B?QUhwY3RqV1BsYzd3dUZkVWJHdmdmMVlicmE4a2hMdTBQeXFoR2JjWk91SDdK?=
 =?utf-8?B?aUhlR0NNZ3Q0d3dGdFJqVk5HZTFrWGJ3ZjM5UVgwUHZ6ckRkKy8vdmsrcFlD?=
 =?utf-8?B?bWNXcVJSL2hjdDlaU3RXTnE1cHZnalRhVHpocmRkV0tWS3FzZjlSY1VRK2Z0?=
 =?utf-8?B?NzgrSFpReTBVYTVSYlJRV1FadGtFWTEzMU5ia3l2TXhGR0YwcU1YRjNFSmhi?=
 =?utf-8?B?SDhRb1o3azJ5NlFFKzBRM3FMWlRlazhnbmROQTZYZjNLeGR5Vk4zcmsrOFMv?=
 =?utf-8?B?VzhGeWN5TzliUlcwUzFxZVV5WkJyYnU3UTcxNDFpRk5UNjZuaXJZTVQrK1J0?=
 =?utf-8?B?WlBnMFBCVTJZZjRKNmtOY1dDdC90ZEtOZllsaUNpMXc4RCtBZHExd3N3SjBZ?=
 =?utf-8?B?RVgxcnpaejF0bkxmUjlad3FqazJFc0hSWlNGNEg4Wks3R3VJRDVHYnl2ZUUy?=
 =?utf-8?B?SUQrSS82MHRESnJ5Q2pzV29sNDNWb3NoTWU0ZFZYWGtwVUx1bTh6S0RPZjQw?=
 =?utf-8?B?VjlLNVdHWm1kN0JXazN2NkZVZVNwNnlRcm9vNVJFSlcrQUZud2grdm80cXQw?=
 =?utf-8?B?ZnRpb2tIRWErM0lRT2VhS3R6NHdQL0xUeEV6aEJubTFoQUhEcTJVVmV1Rlk4?=
 =?utf-8?B?ZGllUzFlNkRXMlM2YmhUOVQxbS9ObkFsUDJaZXpibWcxZVlyVk81Ync3RGNW?=
 =?utf-8?B?N3NRZlZ1UzhKT3RxZUdOSHM0aEVxY1ZPMHdISzBuTXdFTUhlR3ZIN1lLbVhD?=
 =?utf-8?B?SGtkNi93UFR1ZFQzMlBvQjNvNHJyU0REL1ZRQTlKak1CVENOV20yNEpCc3kv?=
 =?utf-8?B?QTNCRjBoUVBTTzU4b09jcklNbXRaOGhTSFBOWFBFYUpBem9TeVcwS2JyanVn?=
 =?utf-8?B?ajNmUEtHcjJ5MmtKNy9XeGd2OWtkbXZNalg0bmpVZXZ0cWxsZHBCKy9ha3l1?=
 =?utf-8?B?RjZKZGhjdlk3RHg2cnZGdTMxYnYwTyt0UFFodndERXdEc1JsajhZNm5mbEJY?=
 =?utf-8?B?OXpzTDZmL0lLRnZJcEpEeC83clBqK1BWdHkwQTZzeC8zU3dmOWdmUk0xZkU2?=
 =?utf-8?B?TVkrR0g1Qk5ZV0UvNUJjU2tBMHVEK1VqcXg1OUJVbVFRT2J0Nkt1eGMwTVBO?=
 =?utf-8?B?RWtTSlROV2ozWlhqd29jclNwNW9DSXY3Y3JvUExtdUEwc20zUE96MDRySDd6?=
 =?utf-8?B?WTJGSWRHMkJKSzM0eHVRaFY0TnlaY2RCQUhIeHpHZEt3eWNGYVZCTEo2VmhK?=
 =?utf-8?B?NFhEeWFqbHdUMXdoQk90cmppelFpbkdKWElKdGpOOGdaQVBsNXpacXNRa2xM?=
 =?utf-8?B?N2VvL1J4aktkcU0vL2wzM0c3K3dKalFYWUNXeE9UL1FvQjEyR1VDZ1N3WXhO?=
 =?utf-8?B?ZklvL05SaXljOVBUOEg4dm9FOVJ1ZTg5WXFNaTBSVDYwYTJPdTdwRG4rZWQ1?=
 =?utf-8?B?V1dYaGllbnp2YWVURnVVRU1TWURkejJWSVZyM0FTREdPdTF5dzRFQnhSc1E1?=
 =?utf-8?B?MzdlSkFVdDYrWGlyU2lUS09aL0FDcUNJUFlzV2xSZ2FLWWNtTk5TU2k0YkE4?=
 =?utf-8?B?YzlZNENia2dQV0tsU002SUxzVHlqdGdaQVl4SmV3Z05kdHlJWkJvaGw5N1Ro?=
 =?utf-8?B?cHluOSt4cEFlQmREM2s3ZEY2VzEvUlJZS1g1RTRxTjNxT2k1OEs4c2dIUmtt?=
 =?utf-8?Q?Gon/ySvO8Ulr+nGicK3eb427C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A78C73E76B72D84A949C438C639A8666@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QlA1QUNqN2ZsUWE5OUV0K3FHV2JHK1BGdlJJcTNTQ1dkazQ1dWlQNGl3R0ln?=
 =?utf-8?B?QzlBSys2bDBVaEdzaVdiR0pxWUNBMGo2WW85UU4wTGtBRnJkWnJNK3lTQWRZ?=
 =?utf-8?B?N25tSHhweUF1dDBVTkw0VVlOOGl2d0dHVnFKS29rL0dzNS9BcUNWUkZpUzNh?=
 =?utf-8?B?RTNGMjZDMnBmZ2hLYldHbFV6LzB3bDhIQ2lnZS8wejY5azhGQWtub0I4NHBL?=
 =?utf-8?B?bGU1Qkw0ZHo3Y0tsQm9Nc2pQRlBnSDBYOEpqVVpHZE5aM09kRWNqL1VVWlNU?=
 =?utf-8?B?bFMwT1pDUHE2K05KSDE1QUtWdHJrRGdtbGZEOHJBejNDa2tjL0NaczF4d1dp?=
 =?utf-8?B?U1QzMTZkSUhPTlAvVm54N1RMOVNLVGxLV2RmUEF6akJFQjhKcUxXZUVWWkM0?=
 =?utf-8?B?QUVBbHlGQ3l2RDI3RG1wQ3hkczRrT1VWdHpxZDlFL0dTbkpkVzJRZVBIUWpk?=
 =?utf-8?B?NkhYNXlPeC9jN1dnZnlkTXBmUXpFWXJQa2N3NUVjZnpuUVJ1WmdnSVhsN0RT?=
 =?utf-8?B?ckxZd0NaZkI2SjY3RWY1M0xPbk1wSXN0OURNREFYcEQ2bWtkMjRScFhIbDJT?=
 =?utf-8?B?U29sTVNHNUNEcHlHWmVQWm9BVzNUb0MzMXRpMGVGNmpjd0tkR0pOWmREc1pl?=
 =?utf-8?B?R2c3Q1gxaGVObStvRUo4SlZyUWM5SWcvVURvM1MyUWpLUlg1SG14aTROd3Rs?=
 =?utf-8?B?QkJsRk9WR25qMGUvMFhTOTgwalZkRFpTUENUdjR3TnM3OC96c1hFcXRwdGVQ?=
 =?utf-8?B?UlVpUmdobzZWVXRFWHIyRjJnRDc2OEVQbWhHQjB4SWRUSDBpMDVDY1FTS2pY?=
 =?utf-8?B?Q1lpdlU4ODJpdTJZK0FxT1lOaEN4QWk0TUNzdHRpSmg4Uk9leCtXN2kwTURi?=
 =?utf-8?B?RjM0em15WlhSc2tKY1ZYYTJZMWptbUVjSy9LY0V4Qlg3R2l4WnlJZlRUQS9n?=
 =?utf-8?B?TEZBTFhjckZsMWhyNGFxSHdnOXE0YU5GOFAyVnpnbDc1QTZReTF0SWdFR1J2?=
 =?utf-8?B?ZDZtU081czVOUDA3VWJpdFZodTU4bkVha2F3ajJVMkFaOGtUVjZzVFpVdnZy?=
 =?utf-8?B?dExyaER3Qi9IdXlEdzlWQUQvY3FBM20xYWRkS3A4VnA5WGVZWGhYdkVZT04y?=
 =?utf-8?B?RXJENmI3NVM0SU5uRnBibWZHbUVLU01ETmFwdFNQcWdsOUdEeGE3bDRPNG0w?=
 =?utf-8?B?U3krUWNEbW1MQ0d2ZkJ6QVcxQ0kyYlpJUm5rbVFTN3g5UERBWWpZQ3BZUThL?=
 =?utf-8?B?dFgxUisyNlVnSlZsbGlrSWxtYnNhVlNVbGZFVlRQOFJKcXRtNXlsd2hic1JQ?=
 =?utf-8?B?RUxOUFJMUmQ1WUx4eTFRQnZsU1hVSjBYWjFLSnhxbHlVTlpnd2xuSk9VT0d6?=
 =?utf-8?B?bklkNDAxUWgxS3dTNnNTdHF1Z1kyaDdkZkRDQjU2MXorZXJFdXdHS0V1VUJv?=
 =?utf-8?B?dENwYmFPWlpRdjJhd0I4eDA1RFNpTGx1aWJ2ZEdlNG5vVG5GTzRseDNEUWJt?=
 =?utf-8?B?Snl6NHhPZGZIdm5aVHFtVmpBbDMxbmFXQUZCaEVJNkR0U1dybUZvUS9leGpD?=
 =?utf-8?B?V0d0UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09ec5c9-5f2e-45b2-6f00-08db42240490
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 04:51:06.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zctRZA8VO0xvG/GLayKx/M2IcoPWuLev3FiUg49pWSLRIQs5fCR5Yjy6qFE5m5u/I7OVuR5YALlRFUd6DrBJdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
X-Proofpoint-GUID: K9pWL7GVBWI4Nv3yjsSLrF2KWVJIZF3g
X-Proofpoint-ORIG-GUID: K9pWL7GVBWI4Nv3yjsSLrF2KWVJIZF3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_17,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304210039
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOC8yMyAxNToxNiwgRG1pdHJ5IFJva29zb3Ygd3JvdGU6DQo+IFRoZSBBbWxvZ2ljIEEx
IHVzZXMgZHdjMiBTeW5vcHN5cyBJUCBhcyBpdHMgVVNCIHBlcmlwaGVyYWwgKGdhZGdldCkNCj4g
ZW5kcG9pbnQsIHdpdGggZGlmZmVyZW50IERXQzIgcGFyYW1ldGVycyB3aGVuIGNvbXBhcmVkIHRv
IHByZXZpb3VzDQo+IEFtbG9naWMgU29Dcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBS
b2tvc292IDxkZHJva29zb3ZAc2JlcmRldmljZXMucnU+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1
dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMi9wYXJhbXMuYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gaW5k
ZXggOWVkOWZkOTU2OTQwLi4wOThmYmZjNzc0YWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzIvcGFyYW1zLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0KPiBAQCAt
MTYxLDYgKzE2MSwyNSBAQCBzdGF0aWMgdm9pZCBkd2MyX3NldF9hbWxvZ2ljX2cxMmFfcGFyYW1z
KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4gICAJcC0+aGlyZF90aHJlc2hvbGRfZW4gPSBm
YWxzZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBkd2MyX3NldF9hbWxvZ2ljX2ExX3Bh
cmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICt7DQo+ICsJc3RydWN0IGR3YzJfY29y
ZV9wYXJhbXMgKnAgPSAmaHNvdGctPnBhcmFtczsNCj4gKw0KPiArCXAtPm90Z19jYXBzLmhucF9z
dXBwb3J0ID0gZmFsc2U7DQo+ICsJcC0+b3RnX2NhcHMuc3JwX3N1cHBvcnQgPSBmYWxzZTsNCj4g
KwlwLT5zcGVlZCA9IERXQzJfU1BFRURfUEFSQU1fSElHSDsNCj4gKwlwLT5ob3N0X3J4X2ZpZm9f
c2l6ZSA9IDE5MjsNCj4gKwlwLT5ob3N0X25wZXJpb190eF9maWZvX3NpemUgPSAxMjg7DQo+ICsJ
cC0+aG9zdF9wZXJpb190eF9maWZvX3NpemUgPSAxMjg7DQo+ICsJcC0+cGh5X3R5cGUgPSBEV0My
X1BIWV9UWVBFX1BBUkFNX1VUTUk7DQo+ICsJcC0+cGh5X3V0bWlfd2lkdGggPSA4Ow0KPiArCXAt
PmFoYmNmZyA9IEdBSEJDRkdfSEJTVExFTl9JTkNSOCA8PCBHQUhCQ0ZHX0hCU1RMRU5fU0hJRlQ7
DQo+ICsJcC0+bHBtID0gZmFsc2U7DQo+ICsJcC0+bHBtX2Nsb2NrX2dhdGluZyA9IGZhbHNlOw0K
PiArCXAtPmJlc2wgPSBmYWxzZTsNCj4gKwlwLT5oaXJkX3RocmVzaG9sZF9lbiA9IGZhbHNlOw0K
PiArfQ0KPiArDQo+ICAgc3RhdGljIHZvaWQgZHdjMl9zZXRfYW1jY19wYXJhbXMoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIHsNCj4gICAJc3RydWN0IGR3YzJfY29yZV9wYXJhbXMgKnAg
PSAmaHNvdGctPnBhcmFtczsNCj4gQEAgLTI1OCw2ICsyNzcsOCBAQCBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGR3YzJfb2ZfbWF0Y2hfdGFibGVbXSA9IHsNCj4gICAJICAuZGF0YSA9IGR3YzJf
c2V0X2FtbG9naWNfcGFyYW1zIH0sDQo+ICAgCXsgLmNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNv
bi1nMTJhLXVzYiIsDQo+ICAgCSAgLmRhdGEgPSBkd2MyX3NldF9hbWxvZ2ljX2cxMmFfcGFyYW1z
IH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhbWxvZ2ljLG1lc29uLWExLXVzYiIsDQo+ICsJICAu
ZGF0YSA9IGR3YzJfc2V0X2FtbG9naWNfYTFfcGFyYW1zIH0sDQo+ICAgCXsgLmNvbXBhdGlibGUg
PSAiYW1jYyxkd2Mtb3RnIiwgLmRhdGEgPSBkd2MyX3NldF9hbWNjX3BhcmFtcyB9LA0KPiAgIAl7
IC5jb21wYXRpYmxlID0gImFwbSxhcG04MjE4MS1kd2Mtb3RnIiwgLmRhdGEgPSBkd2MyX3NldF9h
bWNjX3BhcmFtcyB9LA0KPiAgIAl7IC5jb21wYXRpYmxlID0gInN0LHN0bTMyZjR4OS1mc290ZyIs
