Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93393715741
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjE3HnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE3Hm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:42:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FA1B3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685432547; x=1716968547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v1E2p4yNljiDqds+UUbei6x9aXJmM4Qeppl6jw2NtTA=;
  b=yOh+kwEqguTTphtZYprB9MVpH3aV6oOUhOJSIgKOlFAKFpINGqyd7NK8
   nn9vKfdd1/2/jcVqG4T5BE+mKBMKQlejzAbuXpW4bk82XN1rwMLJ5tfDr
   TDUiv10hgRA2HYvMZ4FHi/ozwfxuunW6U8FjuXUx5oekBwU6tKbHVHu/v
   pehXkwS0M8jEcjDGDJ8DxNj2U91NYvd8WbIEorWjw8vVmenWNYuxHDrHq
   iLRb/6rK4DX+YwZu941LnP6O1V78PruJJh7PMZAQnEinW0wRRZjyHvPiG
   gAFbdqnBsi/aYw6FqtiQq9aDo1Y9sqHzmJGeVlLBM4rfYJANyWInvYeHd
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="215396367"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 00:39:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 00:39:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 00:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq/ZrklN/CSQ3hEYD8AF1eLmfYmIVzU7mmgUYc6glC9MWNR/yhvaEh41s9mxU+ukJHGDwVxPXgGd/eWWvNRK7ZzZQ1vQD9cUUfB2+al2CQk0zMYlWvWSRgIb5jLZHt9F7+YJq3Q1VHMyAV/kOQWHcW7iaAVNy2Q8JJOWb/MU3QOxs5REu0mddDJBN/1ZBEaQMPt5foToTfK6qwgyI9gwf5kaSWFUOGSKHB4LCgu1JUmVNP1RMwU468CA72a8hFr7qBiRBB0S5TDtkzUBukSCIteRmGkNtnpZKluxMNlMkW1B6ddhqGDXGCMNhSQm5R8tsBSnGHY8KD35pAiJDUsFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1E2p4yNljiDqds+UUbei6x9aXJmM4Qeppl6jw2NtTA=;
 b=jW9hePSAKVikFpFOgqsoCvEIQAmRyoK9M/sDHjuoPW020Mkx618sIHiBbJJ45nJkz0d5SWX6qIPPl2G2d4XJIt6I/jFwje7eOG/k9LeS2BQ+fODzj34V4i7F8zgS5oRwzUtozmV1O55QJJZgKLKyWwsPXEiEA6/pZ4g+3wkvrK/h+BmFCrl3U7ZwkAROpyQn1Vve7EeY0HR8O7UjY+oCUR8ug/gyWCQWLTq1DleMskdeCPEEQ775/HfeggvKAwAVCNOg7ZmoNPJkO+ghVpsKEDIejR6omDwMbvgSpKQP0KMATuy9+CKCEFFef2btXn8FHsl9Hxd9fDPF2+h9PgIXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1E2p4yNljiDqds+UUbei6x9aXJmM4Qeppl6jw2NtTA=;
 b=IkJqKnZEFggz+98q/+WQzjOInQKMZhHwXs/eYoBEOi/YGHJBb7s1Fnux79g54SqDDICox1xZcKGftVow7qSL8UnHeju6r2azlG3xZkMu9G8T4Vln0xFiSGmDRMYf7wuMP8l+1fd8JCWX83cbCWcQxyVmAmgzcp6hk7fOzPAICKI=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:39:06 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 07:39:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <rf@opensource.cirrus.com>, <tiwai@suse.com>, <broonie@kernel.org>,
        <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <simont@opensource.cirrus.com>
Subject: Re: [PATCH v3 12/12] ALSA: hda/cs35l56: Add driver for Cirrus Logic
 CS35L56 amplifier
Thread-Topic: [PATCH v3 12/12] ALSA: hda/cs35l56: Add driver for Cirrus Logic
 CS35L56 amplifier
Thread-Index: AQHZksnOgD/jBxxEzUO0Oamd5Rm3Lw==
Date:   Tue, 30 May 2023 07:39:04 +0000
Message-ID: <4ec68c42-dbab-5006-c6a5-0be147a7d0f1@microchip.com>
References: <20230526122852.4552-1-rf@opensource.cirrus.com>
 <20230526122852.4552-13-rf@opensource.cirrus.com>
In-Reply-To: <20230526122852.4552-13-rf@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|BL3PR11MB6433:EE_
x-ms-office365-filtering-correlation-id: 9c0dd858-4813-4dd6-d834-08db60e0f170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /dFuMLtETqNdJzL3XEPr81YH2mA7yPeuuDfNY36B2u9zM+/Cltb7wo3PJiS51xfOw37Ifo7o46i3vvU4E9QvnWSuB6QePQVso+KrXY86DtU5sKEzKpp0gjZTRlcI0IXRdfv7j3ZKxYwfy0K+N19etI7QOijgs0Vl8uzu52k7WwsjSgsVHmuck3a+dzou02p2Vk5bZBb2tXoRFYtKwcxmmcvloy0T20PjELmozjz3vhK3nvGtehNXHHfqNGhH8Tqww8vTNuWo7Rwa+VbZgi/e0Uzv+zeZVUWk0Qm0oTiDGPUedTgSCGYx5k+j/llDyvRjkooU2/G1/oB/mB0vD3lcqvybLFDE5JurtzRejqQErHQLehhU88LlE7ZjmVDbuP38KK+lnp9hIoD/xw4B3qzKtVN2B7Q/NFhGvhiV5AvKsPQovZ4mCz6UrC+NA2zKCwL4TKlFqdE7anR11pUtQoCUVmSFJH5YY2zTpUQqb81gmeiUBgxvzQEmX1fvQxzm0FJRSU5M7tAhHDAwhjpduBL47Gqgc2M/RDH9ABRSe/dvo5PZiwufm/7G/LpNjhV9nXe5lP8pGt+fyXVjqrDbhYiL0sojjSsx+8o6RrZH3DgS09DLz0WvVYoSYmRTupJ4kW2tvu9C4fLMcLNZ7zaODBnSzDybNVWCtPrLrFMKui0rrymgk332zS1e33eoX1T6R5OO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8676002)(8936002)(5660300002)(36756003)(38070700005)(2906002)(86362001)(31696002)(66556008)(66946007)(66446008)(76116006)(4326008)(66476007)(122000001)(64756008)(91956017)(316002)(38100700002)(41300700001)(26005)(31686004)(83380400001)(186003)(6512007)(6506007)(53546011)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9XZHdJNERuMmpjcUNpaFNIS3d5ZkRJeFpHdkx4S0pyd29VbHpxSm9wSUl4?=
 =?utf-8?B?dnR4bWlNYU03aWlUWUcrQVdNblh4SUlmNFhHQTV5ZWFtTjA3aDBYVE42cmhq?=
 =?utf-8?B?NTJkcmx4OUJtWnpOSGJoaldJcjFQMm1BZlFBTHdFc3dseVFxRlVLOWowZElY?=
 =?utf-8?B?V1J3K3ZxUXRJeXIwd1dqeWUrdU41aURTL3c4V2I4YmROa2ZRZ285TncyWlh0?=
 =?utf-8?B?L0J2WHl6cC9TYUNFR2xBZTF1cU90WmFsNmZoNkdFWko4OFJ6c3pXVjV0UnQr?=
 =?utf-8?B?cDltcFlDSTlKRmdZSFptdUticXhMVHllWEtjend1ZUJDTGdYcnZmMU5BZWJY?=
 =?utf-8?B?N29mOU12T2dtOUpwTmdUcTk3Um1UMWl6QUFYRFQwN0FTNUVCalZLalU2UHIr?=
 =?utf-8?B?ajdsYTdwZXlIS3NyTVl1QUF0MExxMTNVV3B4OHI3R3c5Qlo4VFkwSTZuQ3VI?=
 =?utf-8?B?eTR6V3Y2ZzVOZEVhRk9QaXI0TVRlbWRRbkNKOFBHTzJjeHAvUXBnQjdrMFFy?=
 =?utf-8?B?aEtYQ21EYnovemVTMEdyZUNDSXprTWZ5dWpuOWg5VTQvZFAxSVhxclZaV1Q1?=
 =?utf-8?B?U1I4Mi9xRnpxZzFiaWoxZ0dCRW1TN1hRVnJFcmR6cjNGbFlwVkNOVkhndDZh?=
 =?utf-8?B?N1REWk5RTzhhR1M4Y3cwYVdadHlBTVhhdWFnL1krZCszcStlcExVdFE4dElT?=
 =?utf-8?B?TExNSkJkR1p2R3JmZjdiNEpqU1h6UGg2dnQvYm1MMTF3bWx5K0dieGxJNmRQ?=
 =?utf-8?B?ZlN5c2NMU1VVVUpaU3diZVM0QS8wQlZBaW04VWxQb1l5K2RxQ2NHY1FjSjJ1?=
 =?utf-8?B?TDQzVUI3Tnd4QjFVeHlRaHVOVHV3eFdRZmgzdkFNK0RERldrNWZ3N0VDYWVh?=
 =?utf-8?B?RDJBME9ZS0ZvR3l6R0dwQ3NiL2lCeEsyVm0vblpGYzNqRUU0WTZPSmoxcmh3?=
 =?utf-8?B?bHJ0aVppWlQrMHcyMUkycWV4a1lyTjZsNFBrakV5Ny9vSHdaVjFmQjVFSDdG?=
 =?utf-8?B?SWJpTjRrMllCbUVubUZqRUErTFc2NGpFSkhFa1d6Z01admRJTHh4dmROaUJ0?=
 =?utf-8?B?YWQyb3VXQVJEcmxYSXBuWHRoZ21tdlVGeWN1bnVoSXptY0tpUXB1VzJPSUo5?=
 =?utf-8?B?dTI5Y3lsd0pxakNBU1NScFdSSWpwaktVK21OUXc3amVPOHBoK04xZ1REbTl2?=
 =?utf-8?B?Rml5V0gxc1BLRkZCTXJ3SFpuTjl0SDk5TU5ZcmhabEZMdldlTU1SNkhaSFUw?=
 =?utf-8?B?UTlFcTN0UzhTS3RoNFdlQThXbVFmYnU1aXdISjl5QUFyVnlFcG1Bb0tWUXdk?=
 =?utf-8?B?eEd1aUNidFE2U0VPOVFyQytYTzUzRndoVXdleStpZUhhSkthdEVIU080b3pk?=
 =?utf-8?B?aE9YTFo0aU5KN2hxOG5GWXd6cUZGYlo2cHk0VDdUMElObEIxYmNWaFhVaVRJ?=
 =?utf-8?B?bDhIdzk4eUhZMDJ3a29PMGtyZkdaT3Z5em1GcmlEeWdqUjJXMGFpMXRhMmdK?=
 =?utf-8?B?UVp2WUMvRXZ2dVJiQ2IxQmRGV2dJYkFBZS9WN25aVmkzS3JPQndzUWNaMzF3?=
 =?utf-8?B?U0dTU0YySnZNR2RsUDRRRGgyb3VsQ0RBZWZsVkwrY2xsSTJqOVlVVFcxNnZw?=
 =?utf-8?B?VkNEbW9JUnprczJSZWVnbGJLNWR3TEw1ZUszUDY5TUhXQVhlMlFCbnp2Ymsw?=
 =?utf-8?B?a2lvUEFpTjdHYjYvTHowYXY1K25DclA4cGU4R2FvcCsxZXhjcld1WmczcUFu?=
 =?utf-8?B?a2RydVZsd1oyNGFmTHRNdjhxTkxwNi9CTTc0bEV5SlAyL3VLY09QUUxPSXNz?=
 =?utf-8?B?NEtuUlZmQm55MjBhbzNiSC9LVTRtbHRkNGJpOTQxMFlHSE9LNXBWU2hBU1RI?=
 =?utf-8?B?TFNma2VnZ1RtVjNyRmFvNW80VlNaeUZORUcyc0dEM2ErWmtHTlFkakpBNkVy?=
 =?utf-8?B?Tm8rcTBuZHM4Z3FaSXd0OVUraWRGOFFHZnlVV0E5bDJDbkU5OFg1a3lycjN0?=
 =?utf-8?B?UDNiRVZRR2VkdnRraGNZZ2tNWHY5RWFFUDBXZ0YxWWZSZXdrNVRLSTQ1bCtu?=
 =?utf-8?B?QjhlZDNPS3RIWHRxL1ArajJuelZCcFliQzYvU1JxYXVTR3owbUk3YlVRZFAv?=
 =?utf-8?B?b25LY01vbWY0dG10eElTYUQyY3krZWZFTFdtVHlDZ21qYmpweHlXY3RmSWJt?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B8A80EBBA4EEE4C8A114AD0ADC1B0F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0dd858-4813-4dd6-d834-08db60e0f170
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 07:39:04.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4NV/LHtHikCFYuAfnT8jbpUwUxzfRQve6AljmgH2cLv7qULfZSSZIMISsRwxSaISf776n/t8qfm6C5PmgDdURMcnQezabx6OfRzxF4vG5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDUuMjAyMyAxNToyOCwgUmljaGFyZCBGaXR6Z2VyYWxkIHdyb3RlOg0KPiArc3RhdGlj
IGludCBjczM1bDU2X2hkYV9yZXF1ZXN0X2Zpcm13YXJlX2ZpbGUoc3RydWN0IGNzMzVsNTZfaGRh
ICpjczM1bDU2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3QgZmlybXdhcmUgKipmaXJtd2FyZSwgY2hhciAqKmZpbGVuYW1lLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpk
aXIsIGNvbnN0IGNoYXIgKnN5c3RlbV9uYW1lLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICphbXBfbmFtZSwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZmlsZXR5cGUpDQo+
ICt7DQo+ICsgICAgICAgY2hhciAqcywgYzsNCj4gKyAgICAgICBpbnQgcmV0ID0gMDsNCj4gKw0K
PiArICAgICAgIGlmIChzeXN0ZW1fbmFtZSAmJiBhbXBfbmFtZSkNCj4gKyAgICAgICAgICAgICAg
ICpmaWxlbmFtZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiJXNjczM1bDU2JXMtJTAyeC1kc3Ax
LW1pc2MtJXMtJXMuJXMiLCBkaXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY3MzNWw1Ni0+YmFzZS5zZWN1cmVkID8gInMiIDogIiIsIGNzMzVsNTYtPmJhc2UucmV2
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5c3RlbV9uYW1lLCBh
bXBfbmFtZSwgZmlsZXR5cGUpOw0KPiArICAgICAgIGVsc2UgaWYgKHN5c3RlbV9uYW1lKQ0KPiAr
ICAgICAgICAgICAgICAgKmZpbGVuYW1lID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIlc2NzMzVs
NTYlcy0lMDJ4LWRzcDEtbWlzYy0lcy4lcyIsIGRpciwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjczM1bDU2LT5iYXNlLnNlY3VyZWQgPyAicyIgOiAiIiwgY3MzNWw1
Ni0+YmFzZS5yZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3lz
dGVtX25hbWUsIGZpbGV0eXBlKTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAq
ZmlsZW5hbWUgPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIiVzY3MzNWw1NiVzLSUwMngtZHNwMS1t
aXNjLiVzIiwgZGlyLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNz
MzVsNTYtPmJhc2Uuc2VjdXJlZCA/ICJzIiA6ICIiLCBjczM1bDU2LT5iYXNlLnJldiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWxldHlwZSk7DQo+ICsNCj4gKyAg
ICAgICBpZiAoISpmaWxlbmFtZSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0K
PiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBNYWtlIHN1cmUgdGhhdCBmaWxlbmFtZSBp
cyBsb3dlci1jYXNlIGFuZCBhbnkgbm9uIGFscGhhLW51bWVyaWMNCj4gKyAgICAgICAgKiBjaGFy
YWN0ZXJzIGV4Y2VwdCBmdWxsIHN0b3AgYW5kIGZvcndhcmQgc2xhc2ggYXJlIHJlcGxhY2VkIHdp
dGgNCj4gKyAgICAgICAgKiBoeXBoZW5zLg0KPiArICAgICAgICAqLw0KPiArICAgICAgIHMgPSAq
ZmlsZW5hbWU7DQo+ICsgICAgICAgd2hpbGUgKCpzKSB7DQo+ICsgICAgICAgICAgICAgICBjID0g
KnM7DQo+ICsgICAgICAgICAgICAgICBpZiAoaXNhbG51bShjKSkNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgKnMgPSB0b2xvd2VyKGMpOw0KPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoYyAh
PSAnLicgJiYgYyAhPSAnLycpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICpzID0gJy0nOw0K
PiArICAgICAgICAgICAgICAgcysrOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldCA9
IGZpcm13YXJlX3JlcXVlc3Rfbm93YXJuKGZpcm13YXJlLCAqZmlsZW5hbWUsIGNzMzVsNTYtPmJh
c2UuZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZGJn
KGNzMzVsNTYtPmJhc2UuZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgJyVzJ1xuIiwgKmZpbGVuYW1l
KTsNCj4gKyAgICAgICAgICAgICAgIGtmcmVlKCpmaWxlbmFtZSk7DQo+ICsgICAgICAgICAgICAg
ICAqZmlsZW5hbWUgPSBOVUxMOw0KPiArICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAg
ICBkZXZfZGJnKGNzMzVsNTYtPmJhc2UuZGV2LCAiRm91bmQgJyVzJ1xuIiwgKmZpbGVuYW1lKTsN
Cg0KSSBtYXkgYmUgd3JvbmcgYnV0ICpmaWxlbmFtZSBzZWVtcyBsZWFrZWQgdG8gbWUgb24gdGhp
cyBwYXRoLiBJIG5vdGljZWQgaXQNCmlzIGNvdWxkIGJlIGR1cGxpY2F0ZWQgb24gY3NfZHNwX2Rl
YnVnZnNfc2F2ZV93bWZ3bmFtZSgpIGJ1dCB0aGUgb3JpZ2luYWwNCmNvcHkgc2VlbXMgbGVmdCBh
c2lkZS4NCg0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQoN
Cg==
