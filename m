Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5D695979
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBNGxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjBNGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:53:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344514EAF;
        Mon, 13 Feb 2023 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676357582; x=1707893582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z2VJQVCHq7rRVwHf9yI2Gpe/4xkLdX/1w38sUuQyLDA=;
  b=gDAdZcVeOIFvgNvF9CwUmbk1F4+r1+HTUJG/h4bGe87RHuqN8/D7fNUh
   E0DPuFpfSdKdU5ehuKWzxpGu0aqPkIAX0AdboliSh/HAZ9IFVOAUJTi79
   79kMO49iP/GcrBLjpVAUAf7AFLyUUbp/8F3+8Ra41LPFvefQX7QblPpgC
   d8Zf8sF8GjBlMYjy/yc86adeG/X6oaRGA1HSCOILiWkLGZKpA7PTf0OLk
   Mukbo6Fpsm08+ky4ruTh63TrdFgKTGvH40YTLgtZMrH5cJFZnK3GJV72p
   AN6Ov1aMbI5D5DdmVZOZ3bt/qprAMGBtAOX1BdEnMcIJU1tVZgTKdC4Bk
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669100400"; 
   d="scan'208";a="196790688"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2023 23:53:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 23:52:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 23:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf6SMOb5jISrAkcDZ2FgrcVjMQQLm73hXejoNkYbvC7D9hrQVh1pTZ9JBde2JstB7cHDPzE1SKC/n4YpKyuEK2mN8v+Go1D73utweS/fqkW6rQah9YZGMxDz2EYWGwvWhd8qKjMj4Q66AHtWiQ3Ap8s0mjQDAihKi8/vO0c27EmwSwIC/06x2F3CmuwpoYLnuMKtXMcJUdrB2x20amovwFgoYTJcr5eKUu5XmapahsC14aSU7oaA/qUD+lXJTzMyZLXZQKemii1xdBAZ0NPRV1S7e2qMzW4L2fzdEi97mtKE6QAQW8UeMMdWe11wfFib6+V/GsnW4PK3L9FCha8qRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2VJQVCHq7rRVwHf9yI2Gpe/4xkLdX/1w38sUuQyLDA=;
 b=daxx3XutDgiC6CcSg9WjpIvbpVZLZH9z630KTLwLF/Zagsc5nO8Tl/TXcam3Gp3jeMbs4dO+22LQWDp4UReMMzc0P0CHLK+wRIvYfRNPQjS/LR/IIBLgEY+3OpxF0b9K0GIm/fWOsXa3vT70DeYkMwfcHY/5h2Gg+yaRQKil/4xnnIElLstbJlToQrG228shtuPLS1hu2zrU0OjyfKqyuNxP8w/es6nX/SsJXSd6nI7FVSZDgIWc7OZlycC3PmCCgown58ESW87qeV5y0jCNKKP4IVU4BDo6nQqfdzExmWKu2AwmyCAB1NsQy/IU2Sj28iXmSu169DrvmdMM0tj97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2VJQVCHq7rRVwHf9yI2Gpe/4xkLdX/1w38sUuQyLDA=;
 b=bdlgQqc3V9SV8WcoMGF279ZjPU6rDL3zA1Cjls4ui2UnRu92HtOKSB5CHKIeXJoTjfoWem3SJ98X/EFD9mtoohmLkuuF9qtokcVufQ++O6rJ2wJeUcVVEopD12V/0JxdeLEY6FX8OyWbPjeGxxagGoB8dxAZmDW+A4Eqv674bTc=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by BL1PR11MB5431.namprd11.prod.outlook.com (2603:10b6:208:315::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:52:56 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:52:56 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <linux-kernel@vger.kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5D8pOvjRSE0idcTrTWegJHq7K86uAgAMLz3CAAAT1QA==
Date:   Tue, 14 Feb 2023 06:52:56 +0000
Message-ID: <PH7PR11MB5958E626F5FA9BAB2B9FA2F39BA29@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <99b3f6a9-ab7d-b3dd-2a54-3fcd72607ec6@wanadoo.fr>
 <PH7PR11MB59584043A6EF64BC4C7291C89BA29@PH7PR11MB5958.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB59584043A6EF64BC4C7291C89BA29@PH7PR11MB5958.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|BL1PR11MB5431:EE_
x-ms-office365-filtering-correlation-id: fb99b379-e427-412b-c1c1-08db0e581a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppeEYePFGksnzABrTVZt9mBHP7IBRUnm7dAFrrUg7+z2mxxjO4BoTPChacTGJmZuZ1a1lMYP90kWMZioKqZImBJ4IjKwphsvgQQonv3Dpmb1QsghnaoIilzR9QBa1IEku2aY5HEcI8o19FuEW7qFtHvYAm/RJsskSr8cSS3c9nK5rpwrmHIv5VxtYReCrJ9leQFQBDDLgyd/DLyIU/f3enib/cLJi9oae9K4tz5iF5lfhB9UaPI9cUOO344r+Jj1dgQe+vDryiURCcioEtOc2yx/NMzgJ974M8zEZ0rmyWk+dX3D2f5Jj6l0HTWQpUJwdx9FqPRF/dKLrQrW6TWFU09+LMF5PPbjWs+VaeZc9k0SsKYgQ3Ufsio5cu1p8TzRL9eiKHHuWJpRHbKDD/fgGp4ItBterx6iTwo0hHn8oHu6eZokgRsHBqA6I7abP/lSsmRlk5aRtouYPFcx5m/VCBCnY3jBwBg4niFuBoMfDWZ6t3Q1H9e1LWq4iVV8eZkuZ2pFppWNlGvrx9IC/4oeL3Zyzj0UI8vdXTAgKhliq3FcvEnPznOGk13Bl5BKhZ3Yd9o7VfQ3RVZY52Avn99vPOamPqi+he9gfSp0qoDIKyTKJvDDin0GbS9ZSCxzIk7fi2JX9teL7cgG8NfNKatb1GhBW1a7NfhTuKWJXFHakwJY9FyrAoYfBIeStUMYGMmCnBadxrkkXbjXp5J+sCJcEyYKjaKjDMqfZSxMasG+YuB+otCrdQ1uQ/ZjO/LktUgP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39840400004)(366004)(376002)(396003)(346002)(451199018)(76116006)(66946007)(4326008)(110136005)(8676002)(9686003)(122000001)(316002)(71200400001)(54906003)(86362001)(33656002)(186003)(2940100002)(26005)(53546011)(38100700002)(6506007)(38070700005)(55016003)(83380400001)(107886003)(4744005)(41300700001)(66476007)(478600001)(7696005)(2906002)(66446008)(66556008)(64756008)(52536014)(8936002)(5660300002)(32563001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzNOc2EzZUsrMEk3UEI1M3djeS8zbUJZNm12TWtWY1VBRW16azB3NTNZT2tk?=
 =?utf-8?B?ZGFkdndPb1JYbkF0M3JYcjZneWZVbjdZUFFYUVFaWG5UeDloeDlSeDNkL0RW?=
 =?utf-8?B?MitpT2N0dWk1RWU4ajZZOTIzK0hzRmk4dm0vU0Q4UVVOVzVCdzVUM3JUc2gy?=
 =?utf-8?B?dndkMXRtVi9XZTlULzVxUVA0YTdqSWNQcUdBN3NCVDYxVzB0QVQ3WXBFSEQz?=
 =?utf-8?B?Smhnb3h0c2RLdDBKN2QrZGRFL0haejR1RDBLYk91cGQyV3hZQlVscEtLZGRE?=
 =?utf-8?B?M0htRXhlYXU3b1RocGI5K3lSYnZHSGFJeHZLdnpzRW8xTTFZREc0M1pQUWRM?=
 =?utf-8?B?MXl3ei9GVWJSSzVFQ2hNV1BqcXJMZUhQZkxKNnlnUjN5WUNqZ2tKa2R4WTAw?=
 =?utf-8?B?eStiSEhjMU4vY25tQ2xOY0pxZ0FzcEFLc0dwb1FLbDh5Vm4vV3doWlRGelpk?=
 =?utf-8?B?UCtMNE92S3ZMdWY4aXRzNzBPRGhhOUc2WEIxSUFmekg2eVdjTTZiZXU0aVZG?=
 =?utf-8?B?NFEvcEUwRTN3MFBTbDE3ME5YNkhURHZKdEZITFp1VjczeldlZjdyOUxZUERJ?=
 =?utf-8?B?RmVuaDlmNnErK1hPWFlXckxHV29ETDZKRXZWMWI4alA2amxpekVpYmpiWUto?=
 =?utf-8?B?M1ZmWjZiNjhYRStvaUxRRFg5TEJWdFJ0ZzVoRzNTT1RBaCt5UmhaZU53Yjhw?=
 =?utf-8?B?eFQ4TklZMHhPK0VLTEJLdGUvUlhxN2hwTFJRVzFsQkZYREFTc1dmVDRpd2pB?=
 =?utf-8?B?Z0dkcjltd2hBMDFNZ3BLcmhkRnF0TjY0cCtQT0d1V2JONXVMYVRqT1JQVFEr?=
 =?utf-8?B?KzhyRExuQlRkNndJWjJmZ1UwQVYzWDR1QmxMdUQ5WFhMQmZUUzVnc1FNajZX?=
 =?utf-8?B?S2hrRXhDK3pHTEFrdzdVMklLWEc4aDFoK2Vod1FxSGdvRmVIYVZSUXdsSmNn?=
 =?utf-8?B?VkpwL0dmUHZhN0UrbzF3VFFqQm1veC9IUXpaeU5ldDB0WmRwd1NTUU1kVlM4?=
 =?utf-8?B?WFg0TnpCY2RQMGVHZzZobVNhSFkrdlBiZ2FEdVZEaTBhL0tLNDBTS2FEZWZL?=
 =?utf-8?B?c05qMDNVWUpIc0Z0ekMva3VUT2U1ZDJjbFVFSGxuTjE5VEdMeDBGQ25iZHRT?=
 =?utf-8?B?S1hJOGNPZ1BVbUNyYnRIWUhsbVAwc0dCZTlsSytFQmVhWWZnbC9kSUZwWWpI?=
 =?utf-8?B?L1NXN1NSWktmREcwVEhxd3p4UUR0bmQ5UWpSa3V3NDRxWmlsR0tGb3haSzB1?=
 =?utf-8?B?S0hzZHJMTHpZNzV3azhYb2E4QkZEbUJzbWsrUUl4M05RWmZmNURIZ3p6ekU2?=
 =?utf-8?B?UTR3bis3a1h5cXRnUHNrcnBNWVhqRitkM2JNbHFYek9FQk80YkR1Q2N1YzJz?=
 =?utf-8?B?ZTJjN2VDbFg1SktEZmloc0FRWlRzTTFlWThPeWZQZlpEbFhNVGFEaW9oWGZy?=
 =?utf-8?B?QUhmTUgwVnV4a2czTDd5eUNGbC8rQVI2dkgxYVlnRTVNMHJHWTYvSWlXcDJh?=
 =?utf-8?B?SlFzTVJyWCtSRS80WkhXK3BxMDZTYWRCRWxkeFdlM3QxeEJtYVFhZmxCcFQ4?=
 =?utf-8?B?WTlVL0JraDEvbUtraERzeWxpV2lrUDNCcThNeW1VWVNwSUFlM05oWlpCT29Q?=
 =?utf-8?B?Q21PdDZ2U0I0SHhvSExnbnVqU3pWME5nbm42emxXNElLbWM0em1OU05NOGFE?=
 =?utf-8?B?UGNiSXBGbDlQK3I1NDBSWTg4SW5MWXZHZEpYaGJHaHlPOFc1YmJKeE51TTV1?=
 =?utf-8?B?T082VFRvM2NiekJFalhxZ1ByaVQ3NUhNVmxDeCtwc3ozdmNhTS9seTZHZjdH?=
 =?utf-8?B?UXNnbHlSalQ5b1BtL3puVGhub01ST3B5UG1jdjJFR1dDNnRUMXdFbk9YQVhB?=
 =?utf-8?B?eVN0ZGsrNVZhR1l4OEYvbkYvOTFuZnhhS3c0a0dxTjhCTVNINUI0NFUwZGI5?=
 =?utf-8?B?cGdKcmM0Y2ZmeVRiY0NaUW1ta2RrTDZFZUdlNWE1eWhTcmZSK3RaRHZoZlFR?=
 =?utf-8?B?dlBCb2RtdVVVdEROZnRid1dBdEtzclBLWTBxdFJvakQ3dEFVVytBVHR1TVVP?=
 =?utf-8?B?dDRaUVhXRlNFRi9PT0EyZWhIcWxRWktRRmczY3JncDB2VG5tK0lVSnF3YmhR?=
 =?utf-8?B?ejhSQmJQbHJ5S295Tkh6aDhVUXpMSGl5SHNPa0NpWGZjdDBmaW1QVUhlNXVk?=
 =?utf-8?Q?TJszs8Yas4ks41dbkCuPjcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb99b379-e427-412b-c1c1-08db0e581a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:52:56.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oewiQfIbAdkSKSSPYgTNIsaq4+6RpRsRNr8S6T8rkQRwGG0Xe0VPY9ZPZ1DUGVj9BxLC2dgiypVbFsuCJbUcN8p+pn6hqD8WQYjGxnkLIaJy5ANuAM6XT9ddT74xu4m1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5431
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBUaGFydW5rdW1hciBQYXN1bWFydGhpIC0gSTY3ODIxDQo+IFNlbnQ6IFR1ZXNkYXks
IEZlYnJ1YXJ5IDE0LCAyMDIzIDEyOjA4IFBNDQo+IFRvOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNo
cmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gSGkgQ2hyaXN0b3BoZSwNCj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiAN
Cj4gSW4gdGhlIGVhcmxpZXIgdmVyc2lvbiBvZiBwYXRjaCwgYXV4aWxpYXJ5X2RyaXZlcl91bnJl
Z2lzdGVyIHdhcyBkb25lIGJlZm9yZQ0KPiB1bnJlZ2lzdGVyX2Jsa2Rldi4NCj4gQnV0IEdyZWcg
c3VnZ2VzdGVkIHRvIGNoYW5nZSBpdCB0aGlzIHdheSAtICJZb3UgbmVlZCB0byB1bnJlZ2lzdGVy
IHlvdXIgYmxvY2sNCj4gZGV2aWNlIF9CRUZPUkVfIHRoZSBhdXggZGV2aWNlIGdvZXMgYXdheSB1
bmRlcm5lYXRoIGl0Ii4gSGVuY2UgZm9sbG93ZWQNCj4gdGhpcyBvcmRlci4NCg0KU2luY2UgYmxv
Y2sgZGV2aWNlIGlzIGEgY2hpbGQgb2YgdGhlIGF1eCBkZXZpY2UsIGl0IG1ha2VzIHNlbnNlIHRv
IHJlbW92ZSBibG9jayBkZXZpY2UgYmVmb3JlIHJlbW92aW5nIHRoZSBhdXhfZGV2aWNlLg0KU28g
dGhhdCB1bndpbmRpbmcgb2YgdGhlIGRldmljZSBzdGFjayBpcyBkb25lIGluIHRoZSByZXZlcnNl
IG9yZGVyIG9mIGNyZWF0aW9uLg0KDQpUaGFua3MsDQpUaGFydW4gS3VtYXIgUA0K
