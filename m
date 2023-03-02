Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E026A828A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:45:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BD11155;
        Thu,  2 Mar 2023 04:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677761155; x=1709297155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j59+6sqLB/+/vUwAnQ03oQLx5KrILS+gAsVNCxHOGWI=;
  b=I6HeZSwAIJl/SoRK4wBca4Ccd7w+mh2+0W6rzwKlPInS+GFIVg3NF5Eb
   B8WSyw5NC9UF9Gj3q9EWYIHNM5dMxDGIQ/ctwJVSq9tcB4OppxnBnDbLC
   gFCy/S3oFrBguwrj5C4aA/xbO7sOX7n+HyF8niratRc/yplELYswUeTKj
   ivXEXQRcnCgRVJhV+vV8z+QqcG8rZhBRynZ92nObSV7dxE5hfjOZlIhZC
   itYqmer7EtJRkrbQ7VMQjIHgrZsZAykMxJpJvHx2QDAJqPojHplJL7OAS
   xpiHiywO4Xe3hFgKmFY8O2LCTk+bfWQz5BDpA17B4Zfw0iEbKLTum1gZ+
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673938800"; 
   d="scan'208";a="203261986"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 05:45:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 05:45:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Mar 2023 05:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTSL6Gp6n4bmILSHEQQo59F4GpVGDwVURjOvUIH6vSJQmQe68OR4dXfw4mLqX0OIgKxC1qrLo/a5KbPdsf8tGJttM+GxlTLMuiToq6CctwNw7p9Wi0q8Jw0QTs9T8rTeMh5HF8RLBtmnsJE4nrGseIJYBx6GL6vnoenuL+dXEkoU/0Am8r5rNTQ9jQ95g5kOK7Ob5oIe0ZrM75W7zq7ArItSD8DZLw96uXtvOIHgse8HAbNkdW/ZClllaEsEhGbmDYY1purjFpRE7bIhvmIem9SmIV+ylgpGayage3JEeZDR5DHcfF7/qV7V9O+mVsVvi922l2tdmleGzurgbHH1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j59+6sqLB/+/vUwAnQ03oQLx5KrILS+gAsVNCxHOGWI=;
 b=eXs7R5gNsdmGPpI/SjpRvYD1QVA97rIQxcbMm4XpL4cxxLirpL2mO6JJn8TY9opBs1B00q/Tp/iRupDWxlGJBA1ROd7r7laIhOYg+tvo3qVHKuoqUelNI2b1Qn8f0vLhit6Z+LOxNsvFXnthVlRwK6gJP0RopQdskBHijk6xteVVZKMp4YRmb6YoSciO4Dby4ZRdoEctyQYIpqKGNCQEvumtQ3xZnOOYS4neKOYbDTypaPrDTQpIS1pOIRxH3t4KKfxmn8IO7c3pBaBZN3LG+l0C3BVKAQQiabSKDeTkE7nddTOvQ0cnu04Qr21U3K0FbDNkZKb5gFujH6yqZIUmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j59+6sqLB/+/vUwAnQ03oQLx5KrILS+gAsVNCxHOGWI=;
 b=lZVMLA5wVCQH39xrvtRQ308X63CZKu0VEWD2tlN91TIYoyhy1w2cwWHCNi7D6lzf/tcIrIdikIyewtQ2m3AgFQMKhNUx2LXnGqtncqleKlu/UTs5XsMkqR6ekuU81qAiXJB8KqddtCAFywg5D9AGgiktwGOUAL1EkTIzxCow3Go=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB6874.namprd11.prod.outlook.com (2603:10b6:806:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Thu, 2 Mar
 2023 12:45:51 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 12:45:51 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>, <richard.leitner@linux.dev>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <ladis@linux-mips.org>,
        <tiwai@suse.com>, <benjamin.bara@skidata.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <richard.leitner@skidata.com>
Subject: Re: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Thread-Topic: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Thread-Index: AQHZTQTrCMUx0MhkUUWxxABrlAhVWQ==
Date:   Thu, 2 Mar 2023 12:45:50 +0000
Message-ID: <61e4485b-9211-fa38-5061-f5861292ddd1@microchip.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
 <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
In-Reply-To: <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
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
x-ms-office365-filtering-correlation-id: 63fdfcf3-8c5e-43b5-ed8d-08db1b1c0dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5F2aDdC/ViFc5duTp0rPy7/hEttaofAfU0Ba0Z55oPh7XWCeeie7mAiSbLCVil2weiniio6OA6MbJZd3TyUVT8rIg8qlkA7riuQvuAxc8ZfCW3Kd0PR22J4BZiZNQJ6kvbqF3MGvluTKot0lOiBpgyNuSQ7ALgsPSjNDLfe0CU/G3HSqlKaequAocAVVJsJKenzJD+PjcyAsPwg0ImfrCuFkZJQKKxsoi3t9itNEbV4LvoeBVkl0XwhUuprT0xLY3QFhrKtJecx5s4G5ub1lYVOKag8YD1bfUKxM0n2XyFjAaqPih+QBKWLF8IWSjapdCwepV+PMPYppx0kZLo7w9M2CCMo5o/BdfSySuDyV5fVhXR8yKM10KeI8UUI82pIpcsjdplq1KAhBmOQ58jdsyHxfvpFok2yPrFmam1sNJnxfvVkLZ2hBFzs71orck1llObfQzCwSnsmnjRxK9DNMZ+iH3GzhULANtAbPAHTi17URuVF1qkjWtpaZYNbb7oKodwJYMoTeSHQD9yysJKRVImyBJ0tKLTSec8N9MEnTyMog0JoXCVkhEouF4SIMBnJ5VNcaVb0ijssOsJSdYrLiYvPOug1fyhiGfbiG+P5ikqyBIa7Z6Ci/nSzknfFhjVYF8G7iHNCCKsSha+lHmTuC0EaB73FAWqR19NJcmV8EOQX9iAZLshCD4W2p5qBLnehYHk+4MmMm1GpYlmJSmPpE4c+04EI8rTMNq5lQWiRtIloMR8WSTC0sZWqNSIgNdoet
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199018)(38100700002)(2906002)(31686004)(4744005)(7416002)(122000001)(5660300002)(83380400001)(8936002)(2616005)(64756008)(66556008)(86362001)(91956017)(6486002)(66476007)(316002)(66946007)(38070700005)(26005)(8676002)(6506007)(186003)(6512007)(53546011)(478600001)(31696002)(4326008)(71200400001)(54906003)(110136005)(76116006)(36756003)(66446008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW5TQWxCckUrSFo5ODM5RjRwYUFCYjJ3UGMvVndTSFI0bG1MNEdDZlI5YUlC?=
 =?utf-8?B?c0hxVU1YTU1aMFBZRTRvSm1EZUM0WnA5VXI1UTdpRzUvMi9idWpaM0UzRHR0?=
 =?utf-8?B?cXNCdkV2MDluaVdsQ0duRUpZb0tRODdEaW4wa3R1dWVrQXJ5dVpwYWUvenJx?=
 =?utf-8?B?M0VJaEliMjNiRjdtWVFxVUpDVGxsQnNJNFZBQmdUWThUSzNHWUczNzU0ZSs5?=
 =?utf-8?B?SUhpZTRqUUthWEpaTmE2bjFLcDZQQkxHMDVWTm9acGkyQ2MrdVp4cm5abEwz?=
 =?utf-8?B?QmpOc1hXdEtyYVdibUdOeElKTkRER2tyZ1R6ZU56N1l0MWVBZFAxUk9RRVlo?=
 =?utf-8?B?bkxhSkJUZ0lNNDN1b2l1QVZmVy9hbDJkMDYyZHFTNWh4NUJ3TUZoNHhhWkFj?=
 =?utf-8?B?NnJqaWh4Q0dqL1g4aHRyYTJqM3ozbnlpem82cjVjK1JFU3ZuWU5DbTFvWWsz?=
 =?utf-8?B?QTNLVFd3dFpERGN3L1Uza0lTT1NIaTZpbVlyV0RheVlTa2ZMSTI5cGZhSVZh?=
 =?utf-8?B?QytHL3dMeCs0OXFiTWZZWXBkc0JnUkJqMkpZWlVYSmZRR0pZcCs2VGNySHVU?=
 =?utf-8?B?d3lGVWw5bGNIa0d2UmZxb2dLT3VoN204NzZJYVVtUVMyNmxrMmZVZm5XN2Ji?=
 =?utf-8?B?QzVVNjZaMW84Z2NXQ0hEeXlXdUs3aUo3aGgrOEdlaTN6OWZxbU5VejJWT1FK?=
 =?utf-8?B?VmdNSU02REhFK1FWWVVYdFZBUGN3RGNjbldLanh4YkVFZ0VzV2JmcklGVE9D?=
 =?utf-8?B?bmduUmFTeE9IZ2g2aHhyY3NiVEVadUljY3Q1ZmZOZStBVlNZMTlxTGdqejI5?=
 =?utf-8?B?ckZMWTRvV2gxTllJMlJIQUZ5ZWE4M1dYS2U1UjFzVkVZQmovQ05hU3lrTEVZ?=
 =?utf-8?B?RE1OR1Y2UnRuVG1YZzBKYXprbjQwZXZKeEFDSTZibVJjcHhCYjZUaUZsakJK?=
 =?utf-8?B?WnJ1aHh2V0QzY2FnNnBKZW5rd280eWVzR3VwTUc4bCsxSnB2Si8rbWg0ellk?=
 =?utf-8?B?aEZjS3M1YmpRUXJ5QW5GM0pja093VWptM1loTklucDdvZlY2aGViQkgzWFE0?=
 =?utf-8?B?WG55N1FweGdoMFFPcDFHMk5mdzJwTUlzdEVTYVpoZ0pQYWZaN0JRWTdhZzls?=
 =?utf-8?B?MG5RMzk0VzdEcHVLN1NxdDJ1dU1rZFZWR0lxNGpZVkFZOUttREhHTmtvc2Z4?=
 =?utf-8?B?SFk0NTh3bmVETmxtV1ZUdnp0dlhMNElwUjNUVHVNN3RUU2pDbXpkb3lhOUZ5?=
 =?utf-8?B?RytxTXAvTWJUUzI5VjdMMXdDUWNabXVZeG5WNlQ0Wm1VaEM0RThqNmRLTmpz?=
 =?utf-8?B?aUZrNE9NbnRpWjdLVWJleHdLbU5Ec0dFOG1ndDRRclZxakFxN2g5MEJYdWVl?=
 =?utf-8?B?WXpGMXQvUFhhZEFXYWxaSlZ0RmRsUHdlSzZwT2xMbG8xMHpKajVHMUlXRlJj?=
 =?utf-8?B?UWg1c0xBSDlPdC9HdFgwWEJFUVFuTUFsR25NQ2p5aTdzVHRFVVhNQzNYYUZP?=
 =?utf-8?B?Um9zWXVuUHIvRHQ5cEZMekMyek56d0RjaEFlaUtDemVXc01obGNoNEtKRlpp?=
 =?utf-8?B?d2RSK0JOcTBKWFBRUVd3TTRDREpNK0EvZGpuOXJxbWx2eUwrdzlCWHh1RDJH?=
 =?utf-8?B?a2tqa3hkS1dYSFArVUVuYlBYcEN6NklpejcxUWd4a1hFMmwxRFFUZFFycC9E?=
 =?utf-8?B?YVZrNXYvZkFsWFc4b1ViR0Nhd2NIa3cvVFY3WjkrYXJ1aVRUYlRhNVg5TU8v?=
 =?utf-8?B?WG03YWl3Z3dHVHgvS2U2Q001RTMzL2ZwdXVGbzBGMnd3U2NGcW5HU3pZY2V1?=
 =?utf-8?B?aUJ3alY1UFpHR1U2QnBlSHIwMmtLd010ejViT1g2YllCWndOSURETnN1VHJY?=
 =?utf-8?B?TEk0QmZHRDFKVXdleHZTek5jcmJPTFhCUkgvd3BabWZmcmVwV1A0a0JZV1ZR?=
 =?utf-8?B?YW5Hd2JodnRxOXNGZTd1ZUVOM0NQSklpNWVzbUFIbWtma0lyTDVZWGtxS0FM?=
 =?utf-8?B?SW5PekZWSWs3MDJYeWlyUkFNUDZlZDBZQkU2QWtkZXZCeVlXZlg4WFZ2UUZW?=
 =?utf-8?B?dnIwWG9zTGZiOTBXOUR5NXRnMy8xMkxEVzFkZXZGVExPK3BPb0RIaXRUK1lP?=
 =?utf-8?B?azlpNDJkWllJM2taOU5Wb3FQU0hMbCtRRVZRSm1nVENZVU0rYXNDNHdxdnNh?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <857399D97F3CA641AF6F7671C90B2373@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fdfcf3-8c5e-43b5-ed8d-08db1b1c0dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 12:45:50.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK4v2mOOiUDpQWiE1rDvF4RODY/FIPG30U+Pcu1ZV2astY+DO4si4qlARUlh4/IadIYcqP6zmUMtfgsl8/gj/y432kH1Tnn7qoDegsXCE+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDMuMjAyMyAxNDoyMCwgTWFyayBCcm93biB3cm90ZToNCj4+ICsJbWF4OTg2Ny0+bWNs
ayA9IGRldm1fY2xrX2dldCgmaTJjLT5kZXYsICJtY2xrIik7DQo+PiArCWlmIChJU19FUlIobWF4
OTg2Ny0+bWNsaykpDQo+PiArCQlyZXR1cm4gUFRSX0VSUihtYXg5ODY3LT5tY2xrKTsNCj4+ICsJ
cmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKG1heDk4NjctPm1jbGspOw0KPj4gKwlpZiAocmV0IDwg
MCkNCj4+ICsJCWRldl9lcnIoJmkyYy0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBNQ0xLOiAlZFxu
IiwgcmV0KTsNCj4+ICsNCj4gTm90aGluZyBldmVyIGRpc2FibGVzIHRoZSBjbG9jayAtIHdlIG5l
ZWQgYSBkaXNhYmxlIGluIHRoZSByZW1vdmUgcGF0aA0KPiBhdCBsZWFzdC4NCg0KSSBkb24ndCBo
YXZlIHRoZSBmdWxsIGNvbnRleHQgb2YgdGhpcyBwYXRjaCBidXQgdGhpcyBkaWZmIHNlZW1zIGEg
Z29vZA0KY2FuZGlkYXRlIGZvciBkZXZtX2Nsa19nZXRfZW5hYmxlZCgpLg0K
