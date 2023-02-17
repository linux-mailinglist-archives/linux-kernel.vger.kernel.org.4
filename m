Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33E69AAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBQLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:54:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB662FF7;
        Fri, 17 Feb 2023 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676634847; x=1708170847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RhlPHoqdf5xTKL+HitvW4HQBDj2+fpo7LbXkvtjyhQ8=;
  b=eRBqv+Jx58uWvqqHFPlhybSqArEq8KTU9F6F2uPNWVn0aDgpqaWu2AVg
   wlmwj7JkfhNzQn5p1fhx2FPAd2p1U1DVf4v1yR0Y/OMG5lj3/I40RVlYe
   A/lfcCVpFpA3ZBOLgZF9hqJU3ozs+5qyX2j3sjDUtt5K2uOqNJgKIma9j
   IedEhn8spdiW+Sa3NdkB23GIDXGMmWtjQT5HuJGUYwUK1jmNbsbLgUrqn
   vYCSalP2oCkydL3stuv67QNcTHyU0JvIszS8ftrtKkniQPwSsepEMlOTT
   O4neAlPXjjuQCaRUAGPZpodveepmqe/codVBF6EI/IVu5XPnyH1C68k6E
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="197489710"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 04:54:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 04:54:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 04:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVpA+73eqh2SjEjUIDNzZDwzzoTWeQzdJZOAg4TzZlv/4d9zv+hnUEgArN5zM3a7B72BtNGlg70jJrrIe/0GP9CLN+wvvDjXsdWDLmfTPbjfRMCMPeiR/0pLo2RReLZfHvwxP4uFDALf13ftHMsNWhZeDZ77qWrMKufXQg92XDKTONSi2ssceLuyJHiDmtSFQfJlxYWv6wRW8kIsZYL1/yh2iKOya2seefytGytYeV4YcGATpG3nYlxoB0BPfkjJL5YfIjHix9UZzMb/ZPPL1DY2OYrmdHfsTZB+PRDf0/ohEP61g95G5wjH6QLiEtKGbxr84fXtdDw7yZpgep3FoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhlPHoqdf5xTKL+HitvW4HQBDj2+fpo7LbXkvtjyhQ8=;
 b=jypxtugbJEPORKryHNa5Mp+eJjzC+CKvI2tnW8pr9R5JfLlBzijMNfID7FHhpPDv89o7AotLnNioZYOJfWDUoM6yA7u7X/e3VurjQc9MGWnlieUShkmRlr+RtGjVHQMEwEJjlcCvWMxNpktllInrB1+0bw70tqnaycRcTNwffrlAwLSk6TUF3ghBrK2631dzLtcqPSV+vQLgObZTP16MJjhtK8p77/K4iJIoxC5oT9cct56KPOLxQdnFjYJIqYVW/P5kb5KdKmOyABAXjlPlVlTNlAODHEbNEAyFlAw4AiZbhymaL9cwBcMqUwxEAUa61BC6p6jzNlAbFOYaMMIAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhlPHoqdf5xTKL+HitvW4HQBDj2+fpo7LbXkvtjyhQ8=;
 b=nKzeid7MHYwZqir2Wamm425JV+Vjgesh65vJ1rxy6/MFMzA1nCOluGj0Xt14H5lnDxIaTLH12LIkWLFpZh0EL1GjreYp/1HD4UDvdGbmPHV5iqfdSfNueE7sR6txn9wfOL7MwBaeQ1PMEDUE4aDtY2/55CEHX14qfOKLTY7au80=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Fri, 17 Feb 2023 11:54:02 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 11:54:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
Thread-Topic: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
Thread-Index: AQHZQsaHL0+0Y4EsEUiTwZ0L080LGg==
Date:   Fri, 17 Feb 2023 11:54:02 +0000
Message-ID: <be808124-f350-125c-9c74-5a3f87db32af@microchip.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
 <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: 3c46f22c-5be9-49ce-6658-08db10dda9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJL+LEvVci8EKwoWHjjLmISgLncsB4PvhF3Ccq714UwoBjtSbk8oz+7C2N1lBL5dhcvovvIu9q7FoIJZqQ0DoOS3n9FjF0CmZFzgWdHs1me3xm5EQXhTbmLsT9rULRBEkZL8CYv4mNQv13840vP/04KY72QhzdFH8S9HgSh87GYZtSbfNq3NFSnp/f0m5Lb5XHJ9hm+KVeD8e2mxMahPt1RA0DXVkYGUKle/8ZmHxLJu8BEY+m0yRlhFUoQVOJcBwaFjpoAq4KnchNwCBKMxgfB4L4sKuPm0jLJL47fxiamqK+vbDid2YVJHfC4uYS4PE5lsj9VtNb4fsSBNTeMwAieP0GbHDbCib1MA1FcaNRpYzr8KkZitIfbbKJ2JQ9luZS+1xJPt+PHP5U1lKQn21tG6snyzdhae0ERP6mtWKC4gIKDkW70Egki0T5iQZi8Bw1MpSlUysH2QbDtlj7Kitjc7ADq2mOYHC39m7me02asASh7nFLrmW3kbx9AAxtjYglDqtx0ZehHaw0zsdGWXvEG1HWtFZ0A6fSbIYuOBXgf81DGiqBIoOCUYXYR2agUHfuJbXFryPTCvUfgy0Wnd+vBQ9Ue8RGxbo8bp39isyz9IBj1sJsQDgB/JU83v67RJXqKRqr1erW921kwS82AkvK6QSPdshKVXxRVPzxh94OmB+5aIQfK5Pm2zDs1oyol2WsmZVlxcNLXUltnS1ZfQ2LmftJSflbNSXIkzaqYWaz/8n7qtGatRRqJsr4gvdMZ5N9NcjgxJoLYPWnGH6mm76A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(31686004)(41300700001)(31696002)(36756003)(86362001)(2906002)(4744005)(38070700005)(38100700002)(66556008)(122000001)(71200400001)(6486002)(91956017)(478600001)(26005)(5660300002)(66946007)(8676002)(186003)(4326008)(8936002)(110136005)(6512007)(53546011)(6506007)(66446008)(316002)(76116006)(64756008)(66476007)(54906003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVoxbFYvbjFEZkZSTlBCdG5iNE9hYW1PZjdiQ1ZocWt4Rit4Y3I5NmVlSXhN?=
 =?utf-8?B?UVcvSmIyUFFib0FnU2R1RVo2eEcrbVlzek1DYTNUWVdwN0YwNjJEdFMrZFB4?=
 =?utf-8?B?a3NmbWRMVVoxMldtditVUmdsRzNwNWNydjlmWTMrSHJtNm5Oa3N6MmFwU3RQ?=
 =?utf-8?B?VzV3MXJieFV2eXllWVh3eEo1eEZoSXROdkdlRlBwcTY3VG54ZC8rWXROdW5w?=
 =?utf-8?B?N2ZPYWtLd0YzQ0hOZEdIS1FHUk0ybThodlRLUTJ1YndRejdqc21JSEVZWlcw?=
 =?utf-8?B?aHM0MUkzRWtmQ2Y3MmQyWURQUUtIaWp3cFpjbTVRR09PT3JWS0l4SHZxYkdI?=
 =?utf-8?B?NXV3T3JkQlh5dUE5R2FMWTl6Nm5VeUJVTGhYK2daQkFZYUIzZkw2alczSDdt?=
 =?utf-8?B?QXpxdFhRY1lLVElndlBod1BpYmJiM2ZYR1plcGhvayt2Vm82QmthWE1adW5V?=
 =?utf-8?B?aXgrSjhQeE91blVZRWg3UjRoaFhwYkJlMWRxcXZwQ3BReS9Nb2ttYjZYZ05S?=
 =?utf-8?B?QnM3anBjSWlTQVVnWjdVM0VDSXVhODU5OXM0aDNlNHBsdTA3OE5Vc0w2a0Y1?=
 =?utf-8?B?dW5PMHdwaEczSklWbTNBQnZZaGxaK1VWOUo5UE0vY0d1REZabUY0RS9lVTZQ?=
 =?utf-8?B?MkZWeG96dXhFWDdJMVdXSmVhVnZXU3hpNzhZMDdheFl5eHFGb2hjS2M0N2ov?=
 =?utf-8?B?dUFXZ1NIWmVGSml3V1JCMFpPK1dhYnplNXJGRFlOaW1DaVdETnhGakx1MGVr?=
 =?utf-8?B?Vmd4RlpwbG16YXhzVW1jYUhaM0V1QVRqSmFaNmlwNFVzZ25RWTRoQmJ4bXRt?=
 =?utf-8?B?bUJ0WUxKMUlmWnhaa3RnOFRUZG5xdERGVUZoTGZRVU1PU1dpWHlaSHVTcDFV?=
 =?utf-8?B?d2VJZGhGWFhQcVF1emk5RGVraW00cDJFYkZsTWNveWRoUkRVbVJDeHRYb1kz?=
 =?utf-8?B?b0RMTXloTGlNWm5Mdms5N1I5TENZbXNnK0Z4QW85UnFTOGRiQThidktCSldm?=
 =?utf-8?B?bURqT2FLUUxNT3ptZnRZTnVlcDU2UUFSOVpJOFpCL1NVclhRZ1pjYzJWZklR?=
 =?utf-8?B?R1I5L0pSWFVmYnJGR0xKaUczdStFdDhGMEZGVFpVMGVQNFgwdEl6OUIwWVB1?=
 =?utf-8?B?T3dtazkvenBueEVmM3pFMGRBWUc4aHh2clZ0TW9Hd3J6L2hwTDdueFVuTm43?=
 =?utf-8?B?c2EwNlNub0ZYcUUyNWhLcEk1UUJ3OU9ucGlPQmJSNkZtUGRnWjY5V3I0WkhF?=
 =?utf-8?B?dGVleE5IN0wzaFluTnI0OHY2RGNjWW56R1U0bitaV1l3aEU2ckEwSDlKd1ZS?=
 =?utf-8?B?RUExWEhVcXJWVWNUN092aU55Z0l6RzRkd0hOYXU4aG1WUkZqSFlrckRDUWEv?=
 =?utf-8?B?SHM2YnlyY0NMNXJpa3dkMDBoRk1GRXRxbCszK3JVNXN2NEkzQXViZFJSTC9G?=
 =?utf-8?B?dS9UcEJ3YUlkRGNVSjVRTWE1NmZrSDU1aXVKZ2ttdXNiT3puYm92OHg4dVlD?=
 =?utf-8?B?ZFNDRkhzOHNiclRSZ0dtSEJCa1R3Y0dDemx5M09leG5RUFZuc1VFRlVJVVQv?=
 =?utf-8?B?NVRWNDBGKytWcStzYjFoYXdjOUVFQVlEMFVOeXhWbkRuUEVSUHp5TWNZN2l5?=
 =?utf-8?B?czRWUGhPTXVZLzRNekoxRTBDZFdXeVR3N3ZlNWxKdGJGWEN2Y2VGM2pmRE91?=
 =?utf-8?B?aUF1SjhQcWEvMm9rWmllODl0QitheTE0Z05QT2cvdTdGWHA3b05JS2YxQ0V5?=
 =?utf-8?B?c0pxdmZDZ1k4ajFUeVB5aVNqdy85ODNBRGl0cEp4L3NQT2Y0VVhtUEcrMUNW?=
 =?utf-8?B?K0xCVTY0YWZEdklDSUtaazVDNnRMOGc4cnYrRW56c2VIU1ArakFaWW42NFlz?=
 =?utf-8?B?eWtJVG1kZ2FrUFpKeVpYQUJRRFRIbDIxWGxrYXk3Mms1VEJJNmY5T3M5MW01?=
 =?utf-8?B?SGEzSnNkYU03TVdvU2JKeXp2aHNsUTR5UzRqK3U4V0FOK1JlRVZSQmY2bWUy?=
 =?utf-8?B?QTA5REFZWk9mSGJWRjVzVGkxdmZrcEI2MmVvMHFXWUhzZFN2Z3BpenAvQkp4?=
 =?utf-8?B?ZUFrZGN1UE1iVk10WW8vbllkL1o0eCt1U2tGWFVZV0pDRVF5NDFXOW95QjFh?=
 =?utf-8?B?OU5Rc3ZxbVQ1RXc5MFFRM2NyUkJRQVBzUTdrS01oT2RhNTE2dDltRXphR05V?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D6A4D78850944EB5D7033CAF92F763@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46f22c-5be9-49ce-6658-08db10dda9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 11:54:02.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRnQHcYKApQI8kVvoqrbOc5FhHqLWXOB2KdQPtDxHdUW70bb2TghJ12wtaqVlwrsG5ijyeDzK4nHsvdg9cOBCqJPMYbVYHSvZSCp/3lynzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDIuMjAyMyAxNTo0MiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBAQCAtMTc1OCw3
ICsxNzUwLDcgQEAgc3RhdGljIGludCBhdDkxX2dwaW9fb2ZfaXJxX3NldHVwKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAgICAgICAgaWYgKCFncGlvY2hpcF9wcmV2KSB7DQo+ICAg
ICAgICAgICAgICAgICBnaXJxLT5wYXJlbnRfaGFuZGxlciA9IGdwaW9faXJxX2hhbmRsZXI7DQo+
ICAgICAgICAgICAgICAgICBnaXJxLT5udW1fcGFyZW50cyA9IDE7DQo+IC0gICAgICAgICAgICAg
ICBnaXJxLT5wYXJlbnRzID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYsIDEsDQo+ICsgICAgICAg
ICAgICAgICBnaXJxLT5wYXJlbnRzID0gZGV2bV9rY2FsbG9jKGRldiwgZ2lycS0+bnVtX3BhcmVu
dHMsDQoNClRoZXJlIGlzIHN0aWxsIHRoZSBjaGFuZ2Ugb2YgdGhlIDJuZCBhcmd1bWVudCBvZiBk
ZXZtX2tjYWxsb2MoKSBmcm9tIDEgLT4NCmdpcnEtPm51bV9wYXJlbnRzIChubyBmdW5jdGlvbmFs
IGNoYW5nZSwgdGhvdWdoKSB3aGljaCBkb2Vzbid0IG1hdGNoIHRoZQ0KcHVycG9zZSBvZiB0aGUg
cGF0Y2ggYW5kIGlzIG5vdCBzcGVjaWZpZWQgYW55d2hlcmUuIE90aGVyIHRoYW4gdGhpczoNCg0K
UmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVv
ZigqZ2lycS0+cGFyZW50cyksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEdGUF9LRVJORUwpOw0KDQo=
