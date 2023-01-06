Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960F65FFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAFL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjAFL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:58:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB772880;
        Fri,  6 Jan 2023 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673006316; x=1704542316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=13xcj0gOi/IrOJ9IsIkgEHEdXP/XKonzvTUpyqLIQ1g=;
  b=D9cfVKAPpVmfSPCTC02IH02+lQQ1vR9iqV8jL1s3/3UbTPf7gDldpqbp
   JyO6lZO0sKy3FF4Qwflp3dgH1cu8fbL1XR+AbhArph02f1FPWkpJk1rB0
   JpmG9lv5MCGUxCLRCp97iRdj7bcipxvU0ePCakthxjoz0C82Ec+oVN5WD
   3wkT6F+vnp0qGbcX7gzTsjSiWj5QZhcKQtQZSp2IVevnLKiV5tTtnliT0
   0Y2O2Zu8LB82eBQBKMpbSG1JUnokKYC2lZm8btvx1K5l1NaqO/nVfE3Zi
   W1Zj/Yt+6j7gdcVrCM4fW4whldUh5ViAs11Va7mMrjmdfOOe0u1naRFm8
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="191065886"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2023 04:58:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 04:58:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 6 Jan 2023 04:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/etUd+sfRY/MNJ0rSqy9lz+wV2Xgka7sc+JA9GlnbCzQzyshAr9oe0WG9gvtJiXkdxxfeiwG28iyHJAB1EEci8ws37szqiQk20/5vcsTeLQwVX38qEeShEnKEBsTTiEnVXxX0BR7NjfXdNTzG67wry8lZooxV7nKJgNav/kUtUab+XiMeGAUh2OXGPmcr2w/BDX10AmRJQkFIHFlP5pHQ8jvEDK/tqnr/QhR8ik7FlvDpia/48BA6e+4FtH7eHam9NR8A/JNEomDBKdd8ZQJ/xxx+Gjd4U1qIfABHbANg5+FhRvkJdcIgOIUdsE2T/h/IxCZX93xhHnb75c9EMEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13xcj0gOi/IrOJ9IsIkgEHEdXP/XKonzvTUpyqLIQ1g=;
 b=QFfodAYLQfg6kE7kuvR6efrMkxKFsimNffKQEMJCuMTGp6POyNjppIliCZim//viLo3wNH/KIScjrgZhp7WGtUu/mtvkDxqnV/5AYXh+LeJnJDC+sT9S1eulSj6hWEKx9hDKvrAWdnZZU3r9cES7CYA75qJX1cyTzFQz8OZ6I9AzsqrUSVHnP6MEpTk8C/kh6nOtrpSWMzE+NOe2qxdQhn8W4VQRmB7/bexRuvjrr/s4yPKweJ4fFk8LVD5Mkv5I8SsDcZKoxAH0Nwk8eKBpnAQjuj3lnm8Bs5Xw/SilUGgEqgNQAzCM3BEMdbd699p+3VsIv/WEpHMFTIIeSNMhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13xcj0gOi/IrOJ9IsIkgEHEdXP/XKonzvTUpyqLIQ1g=;
 b=JMX1JV7vz0mFNyH+qLxrtqEsE2TaSSbhWMgmLwA9FYe62BxvuxiIhCTjMzs2acjKiromCSC993IffGT8L1dW1d44Z9SotiGkJjqGy3Xa7ld/6jn43ddfHnQloVnS5hj4zFloM2v/tgH6mQ6PGS2MusAz/1iinoERDRbOH0RB3DE=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 11:58:31 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6c3b:ab9d:2acb:c630]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6c3b:ab9d:2acb:c630%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 11:58:31 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <jacopo.mondi@ideasonboard.com>, <hverkuil@xs4all.nl>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/4] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
 __v4l2_ctrl_modify_range
Thread-Topic: [PATCH v8 1/4] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
 __v4l2_ctrl_modify_range
Thread-Index: AQHZIaCzhiKXtZQ4nkeCjUR+SFf7BK6RI/CAgAAjsfA=
Date:   Fri, 6 Jan 2023 11:58:30 +0000
Message-ID: <PH0PR11MB56110B87E3C7C6109E5310D681FB9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
 <20230106072931.2317597-2-shravan.chippa@microchip.com>
 <20230106094523.s2giohns4xgcvccy@uno.localdomain>
In-Reply-To: <20230106094523.s2giohns4xgcvccy@uno.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SA3PR11MB8003:EE_
x-ms-office365-filtering-correlation-id: 570b02d5-6efa-4844-156f-08daefdd5478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ud2JbtJFS3e8HNX4uWCs3AMBoqLMeRKz+/eJ1SBpRSKZFR40+v0S7CnabrLEcMtrRWsR8rAp0bl6/b+nTiM6Ky3U+Tyk42KLcaX1Bv/2H0gjQSWfUK0tIxsEJogtMpi8KZ8XiqdxfYUVhS6hBU01WWW54USbYTxA5Pir+kxUTasqMybwa6NAPo+/ZMyCDx/pdi7dcw8NZfKuZaGC9AZGb0Epz/3LvBOhjT0f0AsTU4dr5hPa4sauMRaEfi/eCqODNPxfGvU9xYCD2KQVoIuGijcGEaWg+yhomqxR/bL2ksYnd1IyF0Kt/Szy9tr557ITek9C1AvbYtVZmxFdvXLHfaOdT/ELfLPqMTYKvkSIjS6irfwrsMRrvUyW4c/lrTg4laKAITgKgQKrZBgrGJNP58jgzFEkSzr8EJBz4DeD6XlRfAKU0nVkQsQJgU+SbHkRr16F+OkUQeNhwdb7CVpm7jctAgx7B3ksBKbqe0jOHvBW/lQo1Ug+n/abDrx321Nwyb9bmEFpQouhDlVkeZoUWoC+LjYs6GFgTxwpjb/fp65Dm0PpUo3JQ9Tg5BXKLoBTalGlBEyc9scETt864/+cUh2qaNpxnjLGrTgnqtV4CzmcyXlQOsEvbZgiZWkGoyeQ3XeB8sU4WbgmN16Phd2hu0WHX4l9RkQI7V4XH8rrVU18uZPAzYL7W+UKX8Y7LTsJyyK4aB0YCX/OGlboUZzQJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(110136005)(54906003)(316002)(966005)(186003)(26005)(71200400001)(66476007)(66446008)(53546011)(64756008)(6506007)(478600001)(9686003)(76116006)(52536014)(41300700001)(8936002)(5660300002)(83380400001)(66946007)(66556008)(8676002)(4326008)(2906002)(55016003)(33656002)(38100700002)(122000001)(38070700005)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1NPaEVJWFM3NnI4V0MwYnBBTC9YK1dxSzIzb0FMNkNrVFExa0djZFA2ZVU2?=
 =?utf-8?B?WjBndlpCOHZFUU01aW1YTm5tUjZPWExYWGhKWXA3RDN3bTZxNWtrRFBaYjlr?=
 =?utf-8?B?M2RsVjRBRG1ncXMrWWdDckMzVkdldk9IZzFVQlp3ZE5Fc2lBdkFUTlRwSDQw?=
 =?utf-8?B?ZEZQYksrN2xCMTgrSk5WQ0M3blNyLzRpaFZJb1ZnNU1sN1hjM2d5UGRyWlFO?=
 =?utf-8?B?R0pONTFnanNiRjR0dTRJOUJXcVUvVW01eFd4TWhrMFNjSm5NVmtKblk4NGkz?=
 =?utf-8?B?N3ZVVHh2bFNoM05yck9zWEZ1UnVKTThoM3BMMUd3ZEFic21Cenl0cW9kV2Nx?=
 =?utf-8?B?Y0hTZkNSZ2twYm9xOFBpYzZtRmFGTnRqeGlPTlgwQTFORVpzV1ZVcjJwdEhK?=
 =?utf-8?B?RC9QQWpqZ0ZSdVFONVQyMXBmc3NocDloMFVWMHR2S2R4ZytXTE90R3h5S3ZL?=
 =?utf-8?B?cHFlSkE2UWFjZ0JrVVEyV2J2bzFnZW0wR203Z2hqbS9oSHo2OXNHSGsvR3FI?=
 =?utf-8?B?K2ljN2RqVU5ZMDN0Q0l0TGlKVDlNTUlJdVR4dGVvY3QxTlNYMmFIdENGa1Z5?=
 =?utf-8?B?a1VtZnZJeXB0RVl2MS9sVmNpOHFaWFlwSWthRzBFb0lDeStjNzBrOFBtWFVs?=
 =?utf-8?B?a3oxNGU4QXlyUWdCeUVqdGs2bTZaZEJZQ20zMDNrWnhrL3VlRG9vM1ZUU3Vr?=
 =?utf-8?B?dTU2cFNzZlVHK0hPRmd5UXk2ZW56RERXYkpObU1idW9DWXBhNXNOSlkyZkRm?=
 =?utf-8?B?VVQ3SkViclZEamJSaXNQeXRLdnFXZ0x1L2g5bVJyNzRwQjZPUWRlWmVIamNx?=
 =?utf-8?B?eE51SHdHUWJ1QTN4U3hvZVBvMjN2czVNQTRSbTJiYUhyLzVsOENUSGJ6WVVW?=
 =?utf-8?B?TU94NGhhbjRXWkxwUzhkWnhmVlRUZ0NwMlNPU3Ird3FFVTBCSFcyMlc3eVFR?=
 =?utf-8?B?ci9NcWZmeHJnQnN1T2dYQnRVLzBzSTJJbXFhVGdxaEk4OVM1dzVyQjlTNjVl?=
 =?utf-8?B?Ky9HUzBySEFzS0dxUithUHNpdmtJT3hsQmdzN0Z6SjBUbVZrcGRZMDVDUXNC?=
 =?utf-8?B?RFBXRmx1WkRIQlo0MDFSbWVFM1J5WndLTGtsVjZGT3pHNHQzTFNsejVXcjky?=
 =?utf-8?B?bUMwZjRvS0JiSkt5dm9rKy9DQ1BWOWh1ZHdpbldRR3pRQnN4RU8xakU3Y29Q?=
 =?utf-8?B?THVEVEVWNXpHU2ZIOGVJQ3RzMzlMRm9GZnZiNHc5SExBVzFieWdTSmwyUmhE?=
 =?utf-8?B?U0lEcWMrZms3VE5wQlFHTkMveDB0ZkY1cVNlcC81ZzBrSTF2cDhLTDJRZGdV?=
 =?utf-8?B?eHcxbzlnY282VFhJb1QyU1VzZSs3dHlmOGpXY0FTNmhMWGVVSmtCdmFMQk9T?=
 =?utf-8?B?ZEtXWmlLOVltdTFqREFYUVh6aVBNOTRibVNjSms4RnRzU3JaNTZOT0ZlVjVh?=
 =?utf-8?B?ei9JNDZWNjVDaWdaZGpmV0FlMkRhYXc0aEhaL1hqd3VsdXM2cVQ4L25aTjV4?=
 =?utf-8?B?VkRZd1ZqVll3dWZtN1UxVVJQRlZiaW5zQ3NReWxqdjg3a0FVTW1YSDB2RExK?=
 =?utf-8?B?R1hWelNIMENnUEliWUtvTHI3RFFjdE9Ga3dTcGNqYTNpdnlGd2pwWnJxZzdC?=
 =?utf-8?B?VU40SU02bkpzdTJXblVQRUFQdHN1MnhuZldydXNYOXFXRnFUZmF3ckpQeDNu?=
 =?utf-8?B?VHd2ajBnWWUxRTBLeWJvMW0yK3VWVkIvVU5HcVVaanFtN1NCKy9LTWlCNTVv?=
 =?utf-8?B?c3pqNUpOSWhKOFJXbDVQVURkcXdvMnFQYnUwOHI4TXhnZE5GWmpSUkV0UnNl?=
 =?utf-8?B?eUp3SUpXUW1QMVFiaS9HL094SkZhcnNWbzFoaUxIYXNOaWgvSEFiTFU0dnlB?=
 =?utf-8?B?bVhjdDlpNEVVUjU2SXlMeE1iMjBZc0NIM0dPK1ExaEo5N1N4SjJnK3hwb2hT?=
 =?utf-8?B?cTE0WXZjWkMrWngzbzkyVVRTWWE0bTk4Q3lEcjFDRWx3NzRVUG9PbWVCUTVQ?=
 =?utf-8?B?SHR6Z0dWZENFVjFWRlpaTWQzYzFXb1RhVTErM1pMQytrZ29qMHVZSHBSbldk?=
 =?utf-8?B?dUkrb1puQnlEUXIwNUhCYjBsb0JLSitNQUw1emx6c0VzSHFIcURSTHZvZ3l5?=
 =?utf-8?B?L3NzWm1PQkpnNmJVMC8rbUwwSWJiNWVGREx0WU1wNGU0bHpIME9FWWxjcTJp?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570b02d5-6efa-4844-156f-08daefdd5478
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 11:58:30.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arJibBk9LK46PLxujadjkgvGmwxy1RqY6NgYNgTy5fN2wX4c93VK0Ve5wTyEc+IJPW3Vcpf1QzGPpuj8ObhUldk2Er111R9knwP9uz7uaW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb3BvIE1vbmRpIDxq
YWNvcG8ubW9uZGlAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogMDYgSmFudWFyeSAyMDIzIDAz
OjE1IFBNDQo+IFRvOiBzaHJhdmFuIENoaXBwYSAtIEkzNTA4OCA8U2hyYXZhbi5DaGlwcGFAbWlj
cm9jaGlwLmNvbT47IEhhbnMgVmVya3VpbA0KPiA8aHZlcmt1aWxAeHM0YWxsLm5sPg0KPiBDYzog
cGF1bC5qLm11cnBoeUBpbnRlbC5jb207IGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb207
DQo+IG1jaGVoYWJAa2VybmVsLm9yZzsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEv
NF0gbWVkaWE6IGkyYzogaW14MzM0OiByZXBsYWNlIF9fdjRsMl9jdHJsX3NfY3RybCB0bw0KPiBf
X3Y0bDJfY3RybF9tb2RpZnlfcmFuZ2UNCj4gDQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWls
IGZyb20gamFjb3BvLm1vbmRpQGlkZWFzb25ib2FyZC5jb20uIExlYXJuDQo+IHdoeSB0aGlzIGlz
IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRp
b24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBI
aSBTaGFyYXZhbiwNCj4gDQo+IEknbSBhIGJpdCBjb25mdXNlZCBoZXJlDQo+IA0KPiBPbiBGcmks
IEphbiAwNiwgMjAyMyBhdCAxMjo1OToyOFBNICswNTMwLCBzaHJhdmFuIGt1bWFyIHdyb3RlOg0K
PiA+IEZyb206IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0K
PiA+DQo+ID4gRm9yIGV2cnkgbW9kZSB3ZSB3aWxsIGdldCBuZXcgc2V0IG9mIHZhbHVlcyBmb3Ig
aGJhbG5rIHNvIHVzZQ0KPiA+IF9fdjRsMl9jdHJsX21vZGlmeV9yYW5nZSgpIHRvIHN1cHBvcnQg
bXVsdGkgbW9kZXMgZm9yIGhibGFuay4NCj4gPg0KPiA+IFRoZSBoYmxhbmsgdmFsdWUgaXMgcmVh
ZG9ubHkgaW4gdGhlIGRyaXZlci4gYmVjYXVzZSBvZiB0aGlzIHRoZQ0KPiA+IGZ1bmN0aW9uIHJl
dHVybnMgZXJyb3IgaWYgd2UgdHJ5IHRvIGNoYW5nZS4gc28gYWRkZWQgZHVteSByZXR1cm4gY2Fz
ZQ0KPiA+IGluIGlteDMzNF9zZXRfY3RybCBmdW5jdGlvbg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5
OiBKYWNvcG8gTW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
cmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYyB8IDYgKysrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYyBiL2RyaXZlcnMvbWVkaWEvaTJjL2lteDMzNC5j
DQo+ID4gaW5kZXggN2IwYTkwODY0NDdkLi5lYmFjYmEzMDU5YjMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tZWRpYS9pMmMvaW14MzM0LmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9p
bXgzMzQuYw0KPiA+IEBAIC0zODIsNyArMzgyLDggQEAgc3RhdGljIGludCBpbXgzMzRfdXBkYXRl
X2NvbnRyb2xzKHN0cnVjdCBpbXgzMzQNCj4gKmlteDMzNCwNCj4gPiAgICAgICBpZiAocmV0KQ0K
PiA+ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgIHJldCA9IF9fdjRs
Ml9jdHJsX3NfY3RybChpbXgzMzQtPmhibGFua19jdHJsLCBtb2RlLT5oYmxhbmspOw0KPiA+ICsg
ICAgIHJldCA9IF9fdjRsMl9jdHJsX21vZGlmeV9yYW5nZShpbXgzMzQtPmhibGFua19jdHJsLCBt
b2RlLT5oYmxhbmssDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1v
ZGUtPmhibGFuaywgMSwgbW9kZS0+aGJsYW5rKTsNCj4gPiAgICAgICBpZiAocmV0KQ0KPiA+ICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+IEBAIC00ODAsNiArNDgxLDkgQEAgc3Rh
dGljIGludCBpbXgzMzRfc2V0X2N0cmwoc3RydWN0IHY0bDJfY3RybCAqY3RybCkNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgcG1fcnVudGltZV9wdXQoaW14MzM0LT5kZXYpOw0KPiA+DQo+ID4gKyAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIFY0TDJfQ0lEX0hCTEFOSzoNCj4gPiAr
ICAgICAgICAgICAgIHJldCA9IDA7DQo+IA0KPiBIYmxhbmsgaXMgc2FpZCB0byBiZSByZWFkLW9u
bHkNCg0KWWVzLCByZWFkLW9ubHkuDQo+IA0KPiAgICAgICAgIGlmIChpbXgzMzQtPmhibGFua19j
dHJsKQ0KPiAgICAgICAgICAgICAgICAgaW14MzM0LT5oYmxhbmtfY3RybC0+ZmxhZ3MgfD0gVjRM
Ml9DVFJMX0ZMQUdfUkVBRF9PTkxZOw0KPiANCj4gU28geW91IHNob3VsZG4ndCBuZWVkIHRoaXMg
c2FmZXR5IG1lYXN1cmUgaGVyZS4NCj4gDQo+IEhvd2V2ZXIgSSBzZWUgdGhhdCBfX3Y0bDJfY3Ry
bF9tb2RpZnlfcmFuZ2UoKSBjYW4gY2FsbCBzX2N0cmwoKSBpZiB0aGUgY3VycmVudA0KPiB2YWx1
ZSBoYXMgdG8gYmUgYWRqdXN0ZWQgdG8gdGhlIG5ldyBsaW1pdHMuDQo+IA0KPiBIYW5zLCBob3cg
ZG9lcyB0aGlzIHdvcmsgPyBEbyB3ZSBuZWVkIHRoZSBhYm92ZSBldmVuIGlmIHRoZSBjb250cm9s
IGlzIHNhaWQNCj4gdG8gYmUgUk8gPw0KPiANCj4gU2hhcmF2YW46IGhhdmUgeW91IGV4cGVyaWVu
Y2VkIGZhaWx1cmVzIGhlcmUsIG9yIGlzIHRoaXMganVzdCBmb3Igc2FmZXR5ID8NCg0KVGhlIHZh
bHVlIGlzIGNoYW5naW5nIGlmIHdlIGNoYW5nZSB0aGUgbW9kZS4gDQpXaGlsZSBjaGFuZ2luZyBt
b2RlLiBJIGhhdmUgZXhwZXJpZW5jZWQgZmFpbHVyZXMuDQoNClRoYW5rcywNClNocmF2YW4uDQoN
Cj4gDQo+IA0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgZGVmYXVsdDoNCj4g
PiAgICAgICAgICAgICAgIGRldl9lcnIoaW14MzM0LT5kZXYsICJJbnZhbGlkIGNvbnRyb2wgJWQi
LCBjdHJsLT5pZCk7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
