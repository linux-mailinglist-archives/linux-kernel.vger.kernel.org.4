Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A833613384
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJaKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJaKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:24:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C12DE3;
        Mon, 31 Oct 2022 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667211840; x=1698747840;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0xEgCIui9eJsyvnNQB7cAuHV3KC6f47uamTshgdQTPQ=;
  b=2aRLCHpotgmKwHXyNPLDKfllX/W8ukAdAp1H8jtcmD6HfvSKP0yk7JaU
   YZ8EoDQ/IuJdez5yXyGCe3oMb6DWDO6NWzWIaBnPT/qqrXWsKMi6U3aXK
   hu39g/UymcuEFsm7wwFxI35+g0sgHYUH7ZhVJpC5DpwZW7Pcnz1oEGB19
   wJHwaUmpNJgZqlyaV8+5ymixc90HO3YhLLs4Bn48COJCbTqwfMB/5HTPb
   Mo//aaBd3zW4bf9GRInCYQbHElXDoCFBL3MdGDiLZqe/t5xgxq2zQdRrB
   sosYui6oz9v28Nq9nHuxYV8wAhFa09lVhtdiXEDgHuDxERxLm3+8JhYXH
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="121061654"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 03:23:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 03:23:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 31 Oct 2022 03:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbvJTNbUl1X2dYH+fitbw1Ks+5UBRVEwAtZCRIVVkZwBW4r0dSjiIlZLfkDOxuYUaI5vR6UW3Jmhb8XdK2qcKOseBZ6C7MK2Ft4qu986EdryS+rmez2P7vk9Fw2b945PeK9QzAnbKQ6gf3a1IkH8pB8pthPfImcuCMjCzZOoKlmPlXuKU+cCZACxHQ1TPdO47g/TwUtDegclL4ICBKG+ZJyStKEcjSk3THY/QgJBXyM2fiIt5F1YPTKlXLjTBUcGjFUaZUrri0/iRKcktcFklJg+5wV2g4jgI790YgazZh032IVs0SGp6+Fj2hXmAm9ogrIjlR+e1VCx8JP7eKpnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xEgCIui9eJsyvnNQB7cAuHV3KC6f47uamTshgdQTPQ=;
 b=g/XCQS0ryTTd0UptgPN16PoyNEIRuSIbsXbbKnf9Xloqi2Vrc7lm1IHHkkub1+KZZ4EqSWhosoMn9BvzyDSWOoIk+Z+3UlnpcVTXzuscnDyx6aJVF2Qjazo06isbSycOn7+xy/ZgAcAUXVOSMsb/2TaZpC08KdJ0rHeKgtq4tkW9V0CxZJIQZe7KbVI185293dV0cBDJD+wf1CYbEJ5PDESuTSV+gT9hYyMNbxILBZAwHNsyPo7YHLX1retOTA98mOAKAwcye/kBUQkPnMKhXEh5VbxaqAQxVZxyviJFCkncDXutVAs/mk7pRl/eYU3HiH6afw2ikGQLwNoiq40rQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xEgCIui9eJsyvnNQB7cAuHV3KC6f47uamTshgdQTPQ=;
 b=pVpeW6jpFnRQY6v6bwMxpRIYuXqaYac2xHpDcWtzPTYwXXrJPhac2j5+z0i1dYe6oLdeLlRkQslyuZq9abB+a/O/fjGSVlr7I6xdBnuT9bBl9dmbF75cQ54Z5nrTgylOUyS5BscFSDDlYC2CdtoNiyPyRgB672DhIf63WvauYvM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 10:23:55 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:23:54 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 2/8] ARM: dts: at91: sam9x60: remove flexcom definitions
Thread-Topic: [PATCHv1 2/8] ARM: dts: at91: sam9x60: remove flexcom
 definitions
Thread-Index: AQHY7RLg5yJuvyVbzUGipeocnKNR5g==
Date:   Mon, 31 Oct 2022 10:23:54 +0000
Message-ID: <51b5b965-bd5e-25f5-4bdc-1f3fc9e21168@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <20221031033653.43269-3-durai.manickamkr@microchip.com>
In-Reply-To: <20221031033653.43269-3-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5506:EE_
x-ms-office365-filtering-correlation-id: a627ee28-6596-494c-48b0-08dabb2a037d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dhiGLJDmY7zCGbQGdLTahWMSh4KK+h4NQHQ2DkjzAnA91dlokAaNBuhS8lNnmZ3UDKb9m2+SPOgdl/OCXcA7NghCI9n43zJjcYuk/wjviwQx9gCrA8r7swo987+bO3ZnHArxm3quVcljnd+sP5+85A0xz3zYnVlfOi1G9Jlw+4oSf7ASQdXDl63hF5m5rMXKgYyRcus/UERvcPfFeWjdwxryyAToASlbK33XICi1LfavEEF7HOtjZq2Dko3V7Hv52YxPBGRsDPlw9MO4OpTVe74qS44kjywuD5z4norPRCf3x4VSJyAo867A9QSZPsh7XKAvNAHAENZ8HfB86dUj6Hwn/e1RZlEgdXn5TMNt5k7t2/rA7rXXdjFYgAWIBByIyMnR2CAxR4M43Srqt6D8KYtbvYh0ZHviGJLnBwovdR6H5SBUflhdaRFlun0+kGc3rqEVpjMNJn7k+JXuIfTqncThiM0FSyfMXB9AbWzjThzeSaOVoClnuyFnoyWYqY+sXHycr7RhZ2l/YnOmAXjg4+Oo84d/h6vfgycV/5ZDz2UimI7pgLubQzJvf4j7D0V9u5LvPP/CQCRgFqSR4SmhgyLCRZn0E1gy4CVWlSX73qBQimfRzInGnBmSngLWW0GOQOZa/p+PgTzOg9H8cx8O8Tc1teiEN0v6yIGOkpR3EihXc67AGYqns3wwqyHvze/120iUoog9pz78OEqBicrGnjjS1Bth8J6Q0DFKo6WbvnizrGMV6ISw6sTa6aeHvY0MrbXZVLoyt6yBgwZnWDRdmdj3+wfRugMiXTifTc8rf4mC+vnAiPtaWwhiF2pEZBFiw+hSlFzUTs0HXFSocJAn75DR2wyXwFPpA0MzjbBi14=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(921005)(38070700005)(31696002)(86362001)(36756003)(41300700001)(6512007)(26005)(53546011)(8676002)(6506007)(64756008)(2616005)(8936002)(5660300002)(66556008)(66476007)(66446008)(6486002)(186003)(71200400001)(478600001)(66946007)(6636002)(91956017)(76116006)(316002)(110136005)(122000001)(38100700002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVlMREZrRjF5bWlzT1NBa3JJMERWbDVBZC9YSDgwVHdISnpDK1crR0I5Q0c2?=
 =?utf-8?B?aUkwRzVxZmJITEtmWVQ4NnkxN2phODdQd082YUJnV3hBU250VkpGMmc3b0R3?=
 =?utf-8?B?QmtGWGVuM1JBNzBQSUtreCtXaTlJald0TEh5SmpnRDJZcWJYTVpSekxnY0cz?=
 =?utf-8?B?TTlYSUZoTTVhRmhmNXdYcndDMjF6MGp0S3VNbFVpN3ZPdUJJUm5xbEYxRWV1?=
 =?utf-8?B?Q2RaVDZEeElneEc3ZzVJZkhGaGx2V2dnWUF5b2k2VkJWb3Y3VlZ5a29teEdU?=
 =?utf-8?B?RmR2d3dXQXF5N3NwajM3TUo4WmF1dzVaSW01bXd2V3FVZTFFbFQ0NUl6UzN2?=
 =?utf-8?B?WFFCcmQxRVJVUDArRk1jWUtFVDBNNDZLUi93V0YxMXFVVE1oYnBUVEs0QW96?=
 =?utf-8?B?dWZ5TXhkamZqUi9GZ2VmYVlJc2pLM2VCanpjbSt6Tldsb0Y2RCtpMlZtZ3JO?=
 =?utf-8?B?aE1sMkcrVXh2bjNxbnZCRjVMZkFzZUJPRVE4QjlLVmlyY1FDcXlPOU1iZzQv?=
 =?utf-8?B?SlNKRFVISW1oN01vL1R1TkYremU4SEU1U0R2Y2FoblczR2xyVzlXWFVmc1VJ?=
 =?utf-8?B?RU9SOE9vNGpmdVRvZVNpN1JWY0F5WitzazkzalVOSE5oU1ZWZ1lDWm9SMGRq?=
 =?utf-8?B?RzhZWUltT1orcUxPZlArYWJ1TmFEVDlxNDV4VlpkY0xxdzlTYnQ1K1RQVDhr?=
 =?utf-8?B?bFQ5enZDZ3FNNDNjSkg0Z2ZPSGI2TDlMb1RUeEdmdDNvZk93elk2SUFjRFVq?=
 =?utf-8?B?Qk51TkdKY3ZkN1JLbmpLQTE2TFh0dWt4S2FFMkllUmFoZHB2ZzZCenpXNFdj?=
 =?utf-8?B?aHdsMGxBcTAvNXVUeTMyWXBRWjVxdDN0c0pJdVRZdXh2c0wwVCtPNEY1WjdH?=
 =?utf-8?B?L3NtMStwdGUzTGFHcjNQaEdhaWZQWXJ2KzVDZkcySG91MUFWVDVhbFFpQ2NI?=
 =?utf-8?B?WERBc05jYldaM2Zoa3RWQzIrZUVSblJWZjRMZGNrVnhQZVhTZUVGcFpTQjdW?=
 =?utf-8?B?cFM2Uk8xZUMyZXFIemRVNU9MU1czOVdFSXAxNlExdE5kcVREblpsN3REeFBI?=
 =?utf-8?B?OVpCbyt0US9sdnY0TDlodGpNVHo3RktScms4T1Y0MUpEdkNTYjdhcFZUNjZT?=
 =?utf-8?B?M3RyS0ExNDFNMDhZQkg5ZlRTRnVNYzVtcTVUK1lEaGxwaVVwclViak1tc0Q1?=
 =?utf-8?B?OWVZNGJ6ZE5pZ1VtZnZjY29hTU83RmorSEIyTEFJWE9oc1Urb3hPZjF1TWVJ?=
 =?utf-8?B?NlBkVEo2UmtVUU1EWm9wRkZ6U2xxSHFybEFadFJCY2xtNHAxbHNuSmZ4bWQz?=
 =?utf-8?B?aFhKblVMaWphS0FVOEJuanVQSlNVVXg4TnMyRHp3TnRZZVlYUTN2SG9rNHBh?=
 =?utf-8?B?RlRqOG1qTkFvZjVleWw4aXQ4YnU1bDlWcjJqcTU3RjFjMUFkMFVJMlRtSURE?=
 =?utf-8?B?TFNhNy9jK0diN2FMVHZJeE5GVTNBVUtTRWVCWDhKT2RYT1Bha0NBdjBuQVJE?=
 =?utf-8?B?WE5ML2hVNVc4SGlRNllRQ2xQd1Q4OUY4VHBuWWhySXV1NVg3NTRUMmNvVXlj?=
 =?utf-8?B?NnJOcFI2YzJ6YUxPVzFoL0Q5cmplUENTNFBuNjRqOU5Nd1k2RDRDc2FINEpv?=
 =?utf-8?B?WnJHSnJVZ3lUVW44UWcvTSt2WHByU3NCM3YrWml1WlhwR0lCbzhiWUxoOWNn?=
 =?utf-8?B?WFFTTGk1aDZjbUVnZEFXOFpRaDlpUHo5dzJadWxGaXdSbW5idVpYNmpoV1kr?=
 =?utf-8?B?M1RreEZyTnhnemx0NXdpL3ZJb1lIditIS0M0TE1UVER5OWprcVp4MlZ5elNK?=
 =?utf-8?B?NGZTb2d4b0ZFQ2VtNFE4ak02MjQ4MTFxU2JUTHpYcG9KNmJybTJvcDcwWTJl?=
 =?utf-8?B?V0tFN0lKRGgwVlBMT0hnMTFhUnZnQS9CdEdoNlFRK1RmNXJoL25ibDllTnBC?=
 =?utf-8?B?UW1DeVFLWnhEZTBqK3VJSE5OZEUrN0J6dHZLenVmRVgrTnBMQ1F5WXRxZld5?=
 =?utf-8?B?L3pWVzZJbFUyelJTVGZ4U3RpdjBZd3oyNEtSajFKOXZ1aHN2czBISHZlUXE1?=
 =?utf-8?B?Y0lqcnhFTkk5aG9hdjNOcThZdnU3cG5CbWN5YU9lR0ZOY1dUWm1paHJaYlJy?=
 =?utf-8?B?M1p1cklRWnJFT3BvQVZLN2RaRzJlNVBOa1RXRnpiTkhqZVVYRTlLbHQ1Nmc3?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5F87CC027DF8646935E5B799A36FB2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a627ee28-6596-494c-48b0-08dabb2a037d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:23:54.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t13uwJOboIgiUuVJtCtqgFQ69r8c1bwcHzWa3yVSh87HG//CgOo9eMLFBj/ryvx+LqycZvSBetp12OgzTSK3W9AAmz4sgwgCLSnVlfZ/E7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMTAuMjAyMiAwNTozNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IFJlbW92ZSB0
aGUgZmxleGNvbSBkZWZpbml0aW9ucyBpbiB0aGUgYm9hcmQgc3BlY2lmaWMgRFRTIGZpbGUgb2Yg
c2FtOXg2MGVrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFp
Lm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9h
dDkxLXNhbTl4NjBlay5kdHMgfCAzNSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDM0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cw0KPiBpbmRleCAyNjU5Nzg1MTRkY2YuLjlkOWU1
MGM3Nzc5NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsu
ZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cw0KPiBAQCAt
MjExLDE1ICsyMTEsMTAgQEAgJmZseDAgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAg
CWkyYzA6IGkyY0A2MDAgew0KPiAtCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWky
YyI7DQo+IC0JCXJlZyA9IDwweDYwMCAweDIwMD47DQo+IC0JCWludGVycnVwdHMgPSA8NSBJUlFf
VFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3Np
emUtY2VsbHMgPSA8MD47DQo+IC0JCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwg
NT47DQo+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwm
cGluY3RybF9mbHgwX2RlZmF1bHQ+Ow0KPiAtCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAg
CQlpMmMtYW5hbG9nLWZpbHRlcjsNCj4gIAkJaTJjLWRpZ2l0YWwtZmlsdGVyOw0KPiAgCQlpMmMt
ZGlnaXRhbC1maWx0ZXItd2lkdGgtbnMgPSA8MzU+Ow0KPiBAQCAtMjM5LDE2ICsyMzQsOCBAQCAm
Zmx4NCB7DQo+ICAJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIA0KPiAgCXNwaTQ6IHNwaUA0MDAg
ew0KPiAtCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXNwaSIsICJhdG1lbCxhdDkx
cm05MjAwLXNwaSI7DQo+IC0JCXJlZyA9IDwweDQwMCAweDIwMD47DQo+IC0JCWludGVycnVwdHMg
PSA8MTMgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gLQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZ
UEVfUEVSSVBIRVJBTCAxMz47DQo+IC0JCWNsb2NrLW5hbWVzID0gInNwaV9jbGsiOw0KPiAgCQlw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4
NF9kZWZhdWx0PjsNCj4gLQkJYXRtZWwsZmlmby1zaXplID0gPDE2PjsNCg0KQXMgbWVudGlvbiBp
biB0aGUgcHJldmlvdXMgdmVyc2lvbiwgdGhpcyBzdGFydGluZyBoZXJlDQoNCj4gLQkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+IC0JCSNzaXplLWNlbGxzID0gPDA+Ow0KDQplbmRpbmcgaGVyZSBp
cyBub3QgbW92ZWQgdG8gZHRzaSBidXQgd2FzIGp1c3QgZGVsZXRlZC4gUGxlYXNlIGluY2x1ZGUg
aXQgaW4NCmFub3RoZXIgcGF0Y2guDQoNCkFsc28sIHlvdSB3aWxsIGhhdmUgdG8gbWVyZ2UgdGhp
cyBwYXRjaCB3aXRoIHRoZSBuZXh0IHRvIGhhdmUgdGhlDQpjb21wb25lbnRzIHJlbW92ZWQgaGVy
ZSBzdGlsbCB3b3JraW5nIGluIHRoaXMgcGF0Y2guDQoNCj4gIAkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gIAl9Ow0KPiAgfTsNCj4gQEAgLTI1OCwyMyArMjQ1LDggQEAgJmZseDUgew0KPiAgCXN0
YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAgCXVhcnQ1OiBzZXJpYWxAMjAwIHsNCj4gLQkJY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1kYmd1IiwgIm1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0
IiwgImF0bWVsLGF0OTFzYW05MjYwLWRiZ3UiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0K
PiAtCQlyZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiAtCQlhdG1lbCx1c2FydC1tb2RlID0gPEFUOTFf
VVNBUlRfTU9ERV9TRVJJQUw+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDE0IElSUV9UWVBFX0xFVkVM
X0hJR0ggNz47DQo+IC0JCWRtYXMgPSA8JmRtYTANCj4gLQkJCShBVDkxX1hETUFDX0RUX01FTV9J
RigwKSB8IEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gLQkJCSBBVDkxX1hETUFDX0RUX1BF
UklEKDEwKSk+LA0KPiAtCQkgICAgICAgPCZkbWEwDQo+IC0JCQkoQVQ5MV9YRE1BQ19EVF9NRU1f
SUYoMCkgfCBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+IC0JCQkgQVQ5MV9YRE1BQ19EVF9Q
RVJJRCgxMSkpPjsNCj4gLQkJZG1hLW5hbWVzID0gInR4IiwgInJ4IjsNCj4gLQkJY2xvY2tzID0g
PCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxND47DQo+IC0JCWNsb2NrLW5hbWVzID0gInVzYXJ0
IjsNCj4gLQkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDVfZGVmYXVsdD47DQo+ICAJCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IC0JCWF0bWVsLHVzZS1kbWEtcng7DQo+IC0JCWF0bWVs
LHVzZS1kbWEtdHg7DQo+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbHg1X2RlZmF1bHQ+Ow0K
PiAgCQlzdGF0dXMgPSAib2theSI7DQo+ICAJfTsNCj4gIH07DQo+IEBAIC0yODQsMTUgKzI1Niwx
MCBAQCAmZmx4NiB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgDQo+ICAJaTJjNjogaTJjQDYw
MCB7DQo+IC0JCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtaTJjIjsNCj4gLQkJcmVn
ID0gPDB4NjAwIDB4MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDw5IElSUV9UWVBFX0xFVkVMX0hJ
R0ggNz47DQo+ICAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkjc2l6ZS1jZWxscyA9IDww
PjsNCj4gLQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA5PjsNCj4gIAkJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDZf
ZGVmYXVsdD47DQo+IC0JCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCWkyYy1hbmFsb2ct
ZmlsdGVyOw0KPiAgCQlpMmMtZGlnaXRhbC1maWx0ZXI7DQo+ICAJCWkyYy1kaWdpdGFsLWZpbHRl
ci13aWR0aC1ucyA9IDwzNT47DQoNCg==
