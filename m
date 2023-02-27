Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D16A46AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjB0QDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjB0QDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:03:48 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BE19F2A;
        Mon, 27 Feb 2023 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677513826; x=1709049826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=InCirjh6TEETxZp9p3pXYtf23SzdHySsW3q3FqHlIp0=;
  b=QxuTmseeV9T942JTpSwVLj+dZjim2CTHDluus9m2xteLpZecfGNUnkg2
   O1pXiApKq0LZVA2NBEIypVyTPTVgmdCKPOEE5rDdAu74hDN0IV+ZGIkkY
   7mDpWiHmC+iub4BGNwYaQnZXy2l2psGxZCanUv5rxh/B46aheBAEUmSFE
   gqIKVexlHKTzqrmyMucMKXTmcNWyjxhlVENXSk/6Rkz6VCqIE+jNMKGht
   B+1CeufGTUPV73GoXWDQL4eJQ28pXJfsdcuQcZCLZuBix+g/zwmsv9148
   MpSqvl6b0gdn+qaJqnO9iS6hyg42MaZK0TmkyzjFxl1IC3o9TI30J+Lvu
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673884800"; 
   d="scan'208";a="229293498"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 00:03:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTpEl9gCwLqmKNNmhKvd1ZUDUWSedLn8gBBhlQkcPw2cRP8QNoskNbH87i1VN64rPG3TlZLFbsPTNCxPXl3jKV+VtUWcdr4nwfshCwDInZ9HmYfEDyELtESK1Wj43waPoSlfBkjdoj9OExUJIcF9+RSWRzojOcRUzufWsQyRtXx88BVfcayoGJsNdfKjXnlRrTrAJG2mnIV8kiaAYidM1eRFhNAR6rZURV1o7LWF5mT/JyQwSDzLLtm/h/JxjLGVK51fiSztYycL2u3Jlr7hSqbFQRrDT4HXOe2JbmwVPoDPfTa7shVnFyX5zY89+/bxY/+yLtXLf5iaLF9RmcoIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InCirjh6TEETxZp9p3pXYtf23SzdHySsW3q3FqHlIp0=;
 b=Kt7BB0ger+Hey3tL3okRuKhabEccSPtHqBSKOyRjyj4k58/V4FGhTBCOEBVLsZPe6JWvWMTJchEYcff1Qg9jXaXN3wOB2PfkEb1I8uw7+BTBo+MrHNCSFfSVeXecXyeUQk0iOHkJ0UD/4XOFCx8NSzGOK1/S0aoAjYRy1AfYd7bhtF8SpYVk5Rfwdsf1+3E7sAHnUcpLd+uegUw6KpFiQauV7l6T+MpprNpEa/mDLz4r+5EF8QXtr2F1jPKpKXcSAofc0m28m8vFFba6lH+S5K8WNvt4CAgAiAISwSaQIVRe/wzb4+DAGH/CAvM3RsOO6Fe2hjJkhV3SlilLqfbKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InCirjh6TEETxZp9p3pXYtf23SzdHySsW3q3FqHlIp0=;
 b=cjkW6TCkBMg7HEMgwlTZ/iObg30qJDLiqTJZA9bbB2mAL0vbPZDBDhXz38mUiBw/deVaDbseQNxwZypD82c4DZy0fYSmv626xtMn4InwdqKkBr0sx+iQYCAJkLaZduHp4w0z6Rqc6IdJauGOwWjNG3qUndX3WMLgqxr9CqlDymc=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by DM6PR04MB4057.namprd04.prod.outlook.com (2603:10b6:5:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 16:03:42 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1%2]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 16:03:42 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Topic: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Index: AQHZRtAnEVxdCbOh6UqEvS4KnyORTa7bFjkAgAfhZ3A=
Date:   Mon, 27 Feb 2023 16:03:42 +0000
Message-ID: <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
In-Reply-To: <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|DM6PR04MB4057:EE_
x-ms-office365-filtering-correlation-id: e69eb7aa-5d72-41b5-7dca-08db18dc3275
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RQEYskWx5t5n3oL7tYne1DTXvbPirn6sljCwoY4M73JKn4ejxsKXVuRjywvHrJNZnvIjq91iAoR67IPM6jB+MRikz0t/LM7FAukQfxJz5ISm2JeJy7omggN3totOBFGayiGD9dxdiZpxYKSYV7MyaLuzCu/Cg+oGX/X87FKoic8QaFAEh8jnqOFLxCpfnMzZ3JZLzZULh5ZVyZszUrBPfp13nG5H8day3a47OxDpc8ZBkm9xxL09qZRahXs5+lpGj3MOFEsJvxjRe7CCu9whRi4iwQ5pGNh1h84+wjb3SSwSxMoA/CVVWLwybQMPnos5kgwzNpGDCfEn7wMxbHTgqh2P7JC5a14xp1MhQWW5ArzUEmQzNoe9FQAkAJKV0Rlnd/Z3E5ja9qn7CJQXcX5lQUIm8JyjVQZsr6xmNRF4HG3h/lGif7yq4qFla+8KRwx6M7UMCVKF3hrj/2vVGZ04XguCVD6/e0fOa4mx6IzHPZ4CW9uUZ6xme7HJr7hvt4zR92s6zyTmuuakV/1Mfc6UjC0I1KCjK2pAIBoToK2ZmSO3HZx1QmEoBkTNY0h6lFrwdTc1uaKMX929zskNa26xyZMK363vsvmozgiHOW39JJbH56HcHLHDQYc4dyKsVrBhkVYpWQ1A3Bkcv8VIj5kYWUSNqrNtFYNYlrr40hezoF2PHvFh5rDC3+HJFm4LRYiUkYDp+WPoONr1MZZY6voSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(316002)(110136005)(33656002)(54906003)(55016003)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(83380400001)(53546011)(6506007)(26005)(186003)(9686003)(71200400001)(8936002)(2906002)(7696005)(52536014)(5660300002)(478600001)(4326008)(41300700001)(8676002)(66556008)(66476007)(66446008)(76116006)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUo1RFdKcjU3MUVCazdEVHZtNzF1dThwTW1JMnFRRWJCdVB2ZlJnRmIveGJ2?=
 =?utf-8?B?cnd6RzlRTk9yZWJjMFRVeTU2dTRDTnIzM2VlZEVxbDZQelBLN1R0NjFDK1JB?=
 =?utf-8?B?Sk91cUJEbnlkMzJvQ28zTDdaQy9mQ2VZeldYT3hsUTJKSnhmcjRXaW1vcFpC?=
 =?utf-8?B?R0p6eXdlTjRGZ2Z6a2NkdW5iY2g4RG1nRUh0OG8zS3JObU8yTVE5Rk1CRTk4?=
 =?utf-8?B?dXVJaUNnUnpXZDhQTlpEazF1eGMyREwzNEdFejhqbk1FbEVtRVI0dlQ4OENa?=
 =?utf-8?B?K0RreHFXakd3SzlqbkFscXlaUUV6eTl4bmhhSzAwTm5QMWhib1psQkpaYTFC?=
 =?utf-8?B?SHNIUmxxcEczRzRQOExxT2VsT0U3VlMrSURDOUh6aDJqRnNxdE5zU3l0cmYw?=
 =?utf-8?B?WUhiM09NMkR2N0l4NEkzVVpUTEFqamVaZ3VjRVdockNMb3NIdlZ3UnhHY01W?=
 =?utf-8?B?NjVBY05Mdyt3Uys5RjY3RGg1eGNiTnlaMzNRTFNXWXpFRFJVVXdPbVJWRGdu?=
 =?utf-8?B?Z0VEWnBHVURpeGlvekdlcXN3QlVyWEF4Y2JKR1g4cGNIaFZLSnp0RnhCaHFY?=
 =?utf-8?B?NUJzbGZjOTZNTDIvZ2ppY3ZMdEJMQzhIK1VhbklEZkREVG1nb0tud0R3TXNq?=
 =?utf-8?B?M096SU5IdEJnK09BN2t4cENybVZvMXphR0k4UUdRUUx3SWNVM214dXlGMmQ0?=
 =?utf-8?B?Sk5tMXRQQmxnQjVGVnRRUG5WaXkzeHdoeTBMN0pGSEIrNGxKNWFHVm5nMVZ1?=
 =?utf-8?B?Z2lwQ2ltK2pEdnp1bW4vMTMwY2hHM0I4OUxKeGVYUXNBak5rbEEvOU4wT1FT?=
 =?utf-8?B?K0ZsKzh1U042a1R2RHNGUTJFWEdLQWdGaW9oK0FoWVBiTWJZbEd6K3FzWjJO?=
 =?utf-8?B?K1ZtbkgySzlqRWdHZzZDTnNwWkQyNXpwRVprRHdMQitKNzFPbTViWEx5QVE1?=
 =?utf-8?B?c1l5ZlA1NHU4NVZkQTYzTjZ0VlBETXM5RmQxR09ZdzVpM3VzSUtXVGgvRndz?=
 =?utf-8?B?b0NrZGFwOTVMdkJwOEs3RGQzeElRVlJRSDYvVUF3dG1CbHVSUFpHYWc5dWZz?=
 =?utf-8?B?K2h4U0dnbnJvN2dGTFVNelBwNjZncHpvb1FqM0cvK1FnZ1crWDRTUDJ4UWZB?=
 =?utf-8?B?YWpuQTZ3VWFkVkhFTjVub29yemllaXh1Ykp6N2RiMS9nYWlNZEFVaGxqVDdw?=
 =?utf-8?B?NmxHSnQrM3hRS2tuWDdqRkM2SmxZayt3ejluUEhnT2lMTmRDd2NvTFNEZGJn?=
 =?utf-8?B?VUV0MmVRZFBpZEV2MldEalZTY0xYaDNmN0NwNHZHMlhCdnV5MDU5cVAvT0Yr?=
 =?utf-8?B?RWhzTDl6V2xVN2xLOUFvS3BPNGhscU1obWFGR2dkN3JEeFBKMTVBMU1lbzBa?=
 =?utf-8?B?bzRFd3ZvUTBZeG5uRGhiTUxyN2JiNWdBWmNBaHI3cUI4WU9YbGFsWUJsOGF3?=
 =?utf-8?B?dklHSFowcVZVSlBFYjNPN0FaQ2F3NUxMbmJYZEhkdGZwb1c4blJVS1ZjSlZK?=
 =?utf-8?B?MTJud0FQQXZjemxsTUZ4dCtSOTgyWHFKeFYyL3FvcVA3bjJjYnRPeFpSQWsz?=
 =?utf-8?B?aHp0S2huNkxtQ1c0UWF2UFhLUDN2WU1nU3BkVUU0aWhpU1hKTVpqcUpCMjdZ?=
 =?utf-8?B?N2xJYWJmTEJzVkpKTFpVZ2NXSnluSjkrYi93d1ZrSkhBbzgrdVcwalIxa0ZN?=
 =?utf-8?B?MTU1aTlqTGpWalhsWGpFc3ptOXRROHMwWHJPcXR3Yk9GWTRrZkU5TWhRN3dW?=
 =?utf-8?B?QkhLb0FxaS8zNURPejZqaDFpNzZ1ZEZ0dnJIM0Ztd25SQmE1SXoxWGhySENl?=
 =?utf-8?B?dVlGMUVReDRMam9PcDlOUzc2Q3FXY3ROTmw1ZUJCdEpLZ2Jjb3RZTm9wd004?=
 =?utf-8?B?cjYrV3V1UjFkYmFaVDVPb0YwK1dVNEtXeDBOT0c1Qk8ybm90QUo2TTZFTVdK?=
 =?utf-8?B?Vll0TEVoRFRxallTZW5CZ3l3cnphY1J0Tm1UQTNCQ1JhZ2J6ZVpZTi96bDNj?=
 =?utf-8?B?WGlFb3ZpM3hMLzhSdW9IZ0JuTWNsMXEvclBLWUdxUnRvZzhvbC9Xdzhvc2t1?=
 =?utf-8?B?R0NjTVYxa1dQY0NQL3dpUE1sKzROclR1VVozQ0pXd1lSMEJZS0k4SnFIb3lB?=
 =?utf-8?Q?8w9tFxK0zelSGID+4tDN9xY+U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bTggornY47yUwvny0XzVtSu5vjEC6oHw5wXIIxbbHj7weppISvDqWk95a8v7x6YKlLkV6VvFwZptDxEngGW3yIbe90gvEyVBWnW2TEGZgm62LWPhDLcUjmb7aTr+pwqPg/TXtMZrYi0+7rz+k0M2ceVnRuqrepD550aiMB5F/dv7o048mUQ6I+g8TDib3AX2OtXLpQ//yqvionVMtqF3HPNANqcih7XVHHKJ6ci4ECBwfEtavaC9TGAjXxOovOblYAInY66DdVlVNFZYeJCDCMzpWS7x5BQ4mCXO5wj+GuVVem57/in9O6WEwn7ma00/YE5wONCaTFhQeX2XlPZuo5MBMlM/aL/y0HdUyjDyKDT1rXLfLKIQp1bVDtGBJa1sZEYP3405HCxWY61tUWUWavUmydj27hGxxkcT3sUpd91u5tf+ToNfHzSyi5Axp6ZFq13QRKiyZGGILYtsprKQw5rB3Y9jNXvg8uwBiA6PItu47WGkoRg0dXbByOL5zeiffr0xit3Xs58aB5y+8bxJsWT5YTLgC9/toIG+MY6SG5zStbdNqiE2yFM2+4vvUYG8lQBCCYCARtfa4lYyGm9QBi6VpJiISu4tWE93s/DxyPFAL0mfTILkjAf6w6AEashf43S2lxJg8YGoe4fl9ctKqSp+pxiUI9eBSbrhSZ8W3DTBxr6LnoNGBI2Kq5DIaYazT6yMJqfH+KzwjIXtA5xTLBJlc+lxmbckLOZbFiSNDSH09uY31XnpkUIyFb07Ux3LCcoM6Drqtx62xrvnffiGwJAakZ0I4Ud5vlAXQXeXaFqVM1g9dkvB5JR3Do2pTXv2vTKiqLdfvc4tm1XOOPvz9Ncxg8oqqzichXl69ECPTTE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69eb7aa-5d72-41b5-7dca-08db18dc3275
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 16:03:42.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yq2YD1mjZJ6J4cOSm11LZWrOYBQVnsBkMBRturTFPi44zku1slBXlS6ow3btxHhzCyhuIAQSPzrXRb5clLYIfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4057
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydCwNCg0KPj4NCj4+ICAgKi8NCj4+ICBzdHJ1Y3QgdXRwX3VwaXVfcXVlcnkgew0KPj4g
IAlfX3U4IG9wY29kZTsNCj4+ICAJX191OCBpZG47DQo+PiAgCV9fdTggaW5kZXg7DQo+PiAgCV9f
dTggc2VsZWN0b3I7DQo+Pi0JX19iZTE2IHJlc2VydmVkX29zZjsNCj4+LQlfX2JlMTYgbGVuZ3Ro
Ow0KPj4tCV9fYmUzMiB2YWx1ZTsNCj4+LQlfX2JlMzIgcmVzZXJ2ZWRbMl07DQo+PisJX191OCBv
c2YzOw0KPj4rCV9fdTggb3NmNDsNCj4+KwlfX2JlMTYgb3NmNTsNCj4+KwlfX2JlMzIgb3NmNjsN
Cj4+KwlfX2JlMzIgb3NmNzsNCj4+ICB9Ow0KPkFsbCBjaGFuZ2VzIGluIFVBUEkgaGVhZGVycyBt
dXN0IGJlIGJhY2t3YXJkcyBjb21wYXRpYmxlLiBUaGUgYWJvdmUgZG9lc24ndCBsb29rIGxpa2Ug
YSBiYWNrd2FyZHMgY29tcGF0aWJsZSBjaGFuZ2UgdG8gbWUuDQo+DQo+QmFydC4NCg0KVGhpcyBB
UEkgd2FzIG9yaWdpbmFsbHkgaW52ZW50ZWQgdG8gc3VwcG9ydCB1ZnMtYnNnLg0KQUZBSUssIHVm
cy11dGlscyBpcyB0aGUgb25seSBhcHAgdGhhdCBtYWtlcyB1c2Ugb2YgdGhpcyBBUEksDQphbmQg
aXQgZG9lc24ndCBkaWcgaW50byBzdHJ1Y3QgdXRwX3VwaXVfcXVlcnkgaW5uZXIgZmllbGRzLg0K
DQpUaGFua3MsDQpBcnRodXINCg0KDQpSZWdhcmRzDQpBcnRodXINCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9y
Zz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyMiwgMjAyMyA1OjI2IFBNDQo+IFRvOiBB
cnRodXIgU2ltY2hhZXYgPEFydGh1ci5TaW1jaGFldkB3ZGMuY29tPjsNCj4gbWFydGluLnBldGVy
c2VuQG9yYWNsZS5jb20NCj4gQ2M6IGJlYW5odW9AbWljcm9uLmNvbTsgbGludXgtc2NzaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBpbmNsdWRlOiB1YXBpOiBzY3NpOiBDaGFuZ2UgdXRwX3VwaXVfcXVl
cnkgc3RydWN0DQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIG9mIFdlc3Rlcm4gRGlnaXRhbC4gRG8gbm90IGNsaWNrDQo+IG9uIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGF0
DQo+IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gMi8yMi8yMyAwNzoxMiwgQXJ0
aHVyIFNpbWNoYWV2IHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvc2NzaS9z
Y3NpX2JzZ191ZnMuaA0KPiBiL2luY2x1ZGUvdWFwaS9zY3NpL3Njc2lfYnNnX3Vmcy5oDQo+ID4g
aW5kZXggMjgwMWI2NS4uY2NjYzA3ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvc2Nz
aS9zY3NpX2JzZ191ZnMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9zY3NpL3Njc2lfYnNnX3Vm
cy5oDQo+ID4gQEAgLTU0LDIwICs1NCwyMSBAQCBzdHJ1Y3QgdXRwX3VwaXVfaGVhZGVyIHsNCj4g
PiAgICAqIEBpZG46IGEgdmFsdWUgdGhhdCBpbmRpY2F0ZXMgdGhlIHBhcnRpY3VsYXIgdHlwZSBv
ZiBkYXRhIEItMQ0KPiA+ICAgICogQGluZGV4OiBJbmRleCB0byBmdXJ0aGVyIGlkZW50aWZ5IGRh
dGEgQi0yDQo+ID4gICAgKiBAc2VsZWN0b3I6IEluZGV4IHRvIGZ1cnRoZXIgaWRlbnRpZnkgZGF0
YSBCLTMNCj4gPiAtICogQHJlc2VydmVkX29zZjogc3BlYyByZXNlcnZlZCBmaWVsZCBCLTQsNQ0K
PiA+IC0gKiBAbGVuZ3RoOiBudW1iZXIgb2YgZGVzY3JpcHRvciBieXRlcyB0byByZWFkL3dyaXRl
IEItNiw3DQo+ID4gLSAqIEB2YWx1ZTogQXR0cmlidXRlIHZhbHVlIHRvIGJlIHdyaXR0ZW4gRFct
NQ0KPiA+IC0gKiBAcmVzZXJ2ZWQ6IHNwZWMgcmVzZXJ2ZWQgRFctNiw3DQo+ID4gKyAqIEBvc2Y0
OiBzcGVjIGZpZWxkIEItNQ0KPiA+ICsgKiBAb3NmNTogc3BlYyBmaWVsZCBCIDYsNw0KPiA+ICsg
KiBAb3NmNjogc3BlYyBmaWVsZCBEVyA4LDkNCj4gPiArICogQG9zZjc6IHNwZWMgZmllbGQgRFcg
MTAsMTENCj4gPiAgICAqLw0KPiA+ICAgc3RydWN0IHV0cF91cGl1X3F1ZXJ5IHsNCj4gPiAgICAg
ICBfX3U4IG9wY29kZTsNCj4gPiAgICAgICBfX3U4IGlkbjsNCj4gPiAgICAgICBfX3U4IGluZGV4
Ow0KPiA+ICAgICAgIF9fdTggc2VsZWN0b3I7DQo+ID4gLSAgICAgX19iZTE2IHJlc2VydmVkX29z
ZjsNCj4gPiAtICAgICBfX2JlMTYgbGVuZ3RoOw0KPiA+IC0gICAgIF9fYmUzMiB2YWx1ZTsNCj4g
PiAtICAgICBfX2JlMzIgcmVzZXJ2ZWRbMl07DQo+ID4gKyAgICAgX191OCBvc2YzOw0KPiA+ICsg
ICAgIF9fdTggb3NmNDsNCj4gPiArICAgICBfX2JlMTYgb3NmNTsNCj4gPiArICAgICBfX2JlMzIg
b3NmNjsNCj4gPiArICAgICBfX2JlMzIgb3NmNzsNCj4gPiAgIH07DQo+IA0KPiBBbGwgY2hhbmdl
cyBpbiBVQVBJIGhlYWRlcnMgbXVzdCBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZS4gVGhlIGFib3Zl
DQo+IGRvZXNuJ3QgbG9vayBsaWtlIGEgYmFja3dhcmRzIGNvbXBhdGlibGUgY2hhbmdlIHRvIG1l
Lg0KPiANCj4gQmFydC4NCg0K
