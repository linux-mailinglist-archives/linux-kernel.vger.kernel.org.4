Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE1615E90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiKBJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKBJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:00:24 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC93D27FC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:00:23 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A27NY1N004560;
        Wed, 2 Nov 2022 04:59:17 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kka3dbk2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 04:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuMq6pdwwo8Icbe/hdXYNWJb8REgiE78iK5yEEzqSWgHNLDnD/8ArpEFftGHLNkOCRZ7U+ARG8MUGdgPhlMLT9RYUnlI6OdWTs9eiZuszwPEwL5Mhc0aRoIeHt/dJIxAA+0LrOoVOUTDHh+QpLf6wo7Wz88W2MRXjDqSQKWpyiPvOAK0YRQIObtxekoQMLokWb7zCRQSZTdizvO/BXjpKarndLk3rvZLax2TNmxr0/hOs1WTw51hVt8YygMGthSq7+54kG59eOoFvUQ+38PMoLHCxPFbbscCpgFkv20RFKQbekrx79kipwn4eeT3yiVQBSBTK3WP3g8jRSIMf+9ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX9BpL7igwb4jTKfIHeOYD8Z66JchVrFmqGFVROLkzM=;
 b=Gq8d5815X2VhMalSZnUi+kOTLNQbilxgkgrsJzYTbvfVimpg8Eqb3F22nmbeJi08dG/hNWCqFdKq6ZvPBIbK6iZx/GfgftFmOXr1dCdkpvc45rk5UVWXjulU4M08HUC/Y45Wwa+1AFs+2KLDw1zjkTNWNG5AKPZz17qcEPNX+aTVND1Q2PH877bKHK4QDNuf1kkW0kmMmgUFYZu7xGjpwFxibRe0LfDJRkwFcfkdG0N4Ac7b4ER6IHW6CYW4fnlhurfnR5OZK6oDQBEOrRKudDnipq/I9IkG0tAkDPm4Db5XomlVGZuNthX3weWCLdl9Nxj+HgublgNVe7G7uTGLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX9BpL7igwb4jTKfIHeOYD8Z66JchVrFmqGFVROLkzM=;
 b=bIBingUNDY8WH6bQLaKKFtjuWCG9jmH/Tfc/Yy/IIaAD//NF/NuHJxORSZIIxhgNmYq7z2Ba3uM0cuZkHe72uHyRkuQyDG1I9XrOl7m7X/xCNyvqvygNDbyEmYuc05dvERD6ZN/8PTyyOXowKItUv5dGL9l7qFwfUgR/YWSpOyc=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by DM4PR03MB6909.namprd03.prod.outlook.com (2603:10b6:8:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 08:59:15 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%8]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 08:59:14 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] ASoC: adau1372: fix mclk
Thread-Topic: [PATCH 1/3] ASoC: adau1372: fix mclk
Thread-Index: AQHY6uG2O57QBw25i0+j33gkklPZ4a4oX71wgALu0ACAAA2U0A==
Date:   Wed, 2 Nov 2022 08:59:14 +0000
Message-ID: <SJ0PR03MB6778123B9A19A79BDDBBD7BA99399@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
 <20221028152626.109603-2-maarten.zanders@mind.be>
 <SJ0PR03MB6778A0EB0CD15A3A917BFE4A99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <5e62ea97-9a2e-b07d-375b-d029d941d520@mind.be>
In-Reply-To: <5e62ea97-9a2e-b07d-375b-d029d941d520@mind.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9XVTJPVGd6TldRdE5XRTRZeTB4TVdWa0xXSTJZbUV0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhEbGxOams0TXpWbUxUVmhPR010TVRGbFpDMWlO?=
 =?utf-8?B?bUpoTFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpT0Rneklp?=
 =?utf-8?B?QjBQU0l4TXpNeE1UZzFNekUxTWpnd056QTNNakFpSUdnOUlsaDZTak54ZFRk?=
 =?utf-8?B?cGRsbzVNbE0xYjJOQ1drYzBSbUozV1VOdVFUMGlJR2xrUFNJaUlHSnNQU0l3?=
 =?utf-8?B?SWlCaWJ6MGlNU0lnWTJrOUltTkJRVUZCUlZKSVZURlNVMUpWUms1RFoxVkJR?=
 =?utf-8?B?VVZ2UTBGQlFrRnNjMEpuYldVM1dVRlNkMDkyVDNSTGJGVnFkVWhCTmpnMk1I?=
 =?utf-8?B?RldVMDgwUkVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZJUVVG?=
 =?utf-8?B?QlFVUmhRVkZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZS?=
 =?utf-8?B?UVVKQlFVRkJXRFZzTWt0M1FVRkJRVUZCUVVGQlFVRkJRVUZCU2pSQlFVRkNh?=
 =?utf-8?B?RUZIVVVGaFVVSm1RVWhOUVZwUlFtcEJTRlZCWTJkQ2JFRkdPRUZqUVVKNVFV?=
 =?utf-8?B?YzRRV0ZuUW14QlIwMUJaRUZDZWtGR09FRmFaMEpvUVVkM1FXTjNRbXhCUmpo?=
 =?utf-8?B?QldtZENka0ZJVFVGaFVVSXdRVWRyUVdSblFteEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVG?=
 =?utf-8?B?QlFXNW5RVUZCUjBWQldrRkNjRUZHT0VGamQwSnNRVWROUVdSUlFubEJSMVZC?=
 =?utf-8?B?V0hkQ2QwRklTVUZpZDBKeFFVZFZRVmwzUWpCQlNFMUJXSGRDTUVGSGEwRmFV?=
 =?utf-8?B?VUo1UVVSRlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUTBGQlFVRkJRVU5sUVVGQlFWbFJRbXRCUjJ0QldIZENla0ZIVlVGWmQw?=
 =?utf-8?B?SXhRVWhKUVZwUlFtWkJTRUZCWTJkQ2RrRkhiMEZhVVVKcVFVaFJRV04zUW1a?=
 =?utf-8?B?QlNGRkJZVkZDYkVGSVNVRk5aMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?Q?CQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|DM4PR03MB6909:EE_
x-ms-office365-filtering-correlation-id: a648d54c-6a0b-4409-0626-08dabcb08477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+dg6TBai9JdQJK7Soqsfio0WbjiVM19lospDcMadu9rQvplpGU6QkDPFLN64I8DdW9/WhOSW8ycmLDtbcPDBLGWqcJlb5ZQtL6v6VkCZov7FG3VS/yuKycJ5lIvh4aP63An11/fkcX66IeJximS9uWoble94oav9srOwTKtEJu3ehhybM76Jj0ZEn+a7Y9pXs3SpqqMyfC0BMHKe9zKkeBsslMXKfD6gAu4hQJzk/4+owtEAcDlQyolPhbwnqX00qlhen9n0MUWVlpJeNGRaS2kL7LokGGEezx0F9eZJGV28odrN5fo1wHG9Ezp1umzgrwgQGU8+rEvJvJkoHplgktBVvtIVetZ0seJn509/ox1fXc8tTtgxQxTHb2Dyn5P6PfOE5i7c9uRPmFWF7PPTAk54hzrP4JxAIyc231GHy2Vdkl0hJmPr3HDpWJ8BIooW+94ltyXCIMNxMQ6Wy95t0Qtsq9dNRyF3t8UR//Kho+N5wIDEr68UKpNMirGQJ3xh8kneIONSj1d0/IX7i93uXbmbUGW5tETiS8IGrB6zQN88nJ27DyGbn4hUAQSuTOF12l60Jt/Gf3nwGlMOdhQAz9l8AVSzeJtK7zMQrFSAla4dTxMJA2pM4NU7lIkr1+fsvvf+3T6nRGVWkY/Ytg2kukycS0aJRKqbQWQjgQUPNtD3n5eU3cIbtXi09/65o+mf+jpJWxY7oo5GRGdzDqmWam93KLrjUJWSYy4JM9/AhdCQk1lf3uG6V/Ia+ziuCas0gv/qHV0GDvdD0VDlBJa4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(478600001)(122000001)(54906003)(316002)(110136005)(38100700002)(86362001)(33656002)(55016003)(53546011)(71200400001)(4326008)(64756008)(8676002)(66476007)(38070700005)(7696005)(66446008)(76116006)(6506007)(52536014)(66556008)(8936002)(5660300002)(4744005)(186003)(2906002)(9686003)(66946007)(41300700001)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWtPbWZZdXhqUVR4RmkwOWp1MURGYVF2T1YrNzFqWmlEeEZFcUFUbzc3MFMy?=
 =?utf-8?B?ZDJMMGhtK0o2VXpDdkx4czhzdnp5MWlackQvWWsrVk9wM3lsV1VGRExWUnM0?=
 =?utf-8?B?aTE1SUo3OXVjajRrYWMxMnRVb0lic3hwYjFXanAyVWFQOXlMNHk0M1pqWHdv?=
 =?utf-8?B?cW5tM0x4aWI0WDllOEUrbE9vNlRKcXZVZThzNnRXYTVwcUJSTm5SdzJCVEpH?=
 =?utf-8?B?T3dqc2t6cGxVYkNkeWQxVE9oK1JTUXlHV1NQUTJvOWNvOU12QjE2RGM0dVkx?=
 =?utf-8?B?dEZmak83bWQwYTVYcGFtVU9NUTJNZTlIRHFLYmtXUDVVUFBhRjdDQU1HWGFU?=
 =?utf-8?B?NEh0alVpT2c4OHhMbFRuRVpDZnNNc1RHQ2VRSHhISWdlenZNOXdZaUdqL2Fm?=
 =?utf-8?B?bU0zb3V5blk4dmowdWVGdXhxcmJrOHJzUCtIbVpjOUxPNjJkZ3BUWEtiNVhB?=
 =?utf-8?B?cWxMazNteUdHY0txKzNGRW50SXhRU2tCVU1BcFhJUjN6N2JTa1VMd2NVNTBR?=
 =?utf-8?B?blQ5TU1PYzg3VFVBYnFTcUFJaUlkcXRSaUt0M3hFeGZZRlFQNk5yOTgyWk8y?=
 =?utf-8?B?d0lCSFlWaHo4U1hqRXBOWGlDaTM2RWdyazQ0dVU0ZzB0dTRmWDdZamx1Y1FG?=
 =?utf-8?B?c0FTR2s0bG9rOWpMSnVadHBHSFpURHVJd1RBSlR0aEw1dEtqTmt4aU1xK201?=
 =?utf-8?B?SDA1blIyNnJkUEk1MUhiWTk3VUt0R3hSTm9MNHpzY2hpbnlJSy9wTERObk9s?=
 =?utf-8?B?Wm15a1lJaHFSeXduNUdGUm5zd1dXbzNIUVE3ZWQ0bEhBSUU3dExpV0pQU1FF?=
 =?utf-8?B?TGxEMEpNbnFvczF4ZXI3NEV4MllGQUZORjZNUmJlekwxZjhiTEZqY3NFQkM0?=
 =?utf-8?B?SnpJUWhzMEU0eXl0Y0R3blJsVWFLeE5qV0ZpUFVmem1lWk5pU2RDd3FSQSsr?=
 =?utf-8?B?QkdPSUJ0UmtENjJMMFUvc1pNaGwzb1lqMUhGR2UyQ1hTdzFOMWdLREdxbzBG?=
 =?utf-8?B?ZStIZGRLL0c3NUVYTTFvcmp0dTBhNzZCdUFsWnFpMVJaZnpWQWFjQTFZZmhZ?=
 =?utf-8?B?b05NTmZsc2dvcUR6VWxLUllESFNhUUxzLzJZZXJsWDAwdS9Hb2wrTWZTTXI0?=
 =?utf-8?B?SjRBd2VCbkN4TjBZSTdSY3JSK2tWSkNCTTRPdmdiVlltcE1YSU9LUUsvbHE5?=
 =?utf-8?B?Rzh2U2lHQVNiTEQrUTlERHBtS3BrWXEvQ0h6OVQ4QSt5eU9EbThBQjB6UEcz?=
 =?utf-8?B?Znc5bE9aTUhiMXpXeWZnL2lmbXFjODBUaXhBSmhrQWRCUm1IVDNsM3ZwUlZZ?=
 =?utf-8?B?eTFYbS9ZSjBXc1pVRmY2Zlo2bUZQellQd0hkSEE2UGFOWmREL2hUdzBKSWtn?=
 =?utf-8?B?bnpDSnB2VUJoRzJwSVlIZDlaRlZQSnJUOFBIejcvdGswaFVwYW4wT3FRalRR?=
 =?utf-8?B?SGI5NldiWWh6TjVIQVdGbTZNbGx1eDU1WWxSUWtJN1piREl3aGFYRDNOeEhN?=
 =?utf-8?B?TjIxWElCLy9JQ3pmUWpXa0x3bFlSakppbjNsdkg5amw3OVlzK2V6bng5aUl5?=
 =?utf-8?B?TmxNTlU0UEpnY0F2ZjhNK0Q3ZFFtNWU0SGNyZzlsdXExSm9YWW1RMnRmb0wz?=
 =?utf-8?B?Z2VNcUszZks1RXh3NFlNd0l5U2l5Y1c0SHprRzYzdk5ORjJ2R2ZTWnd6VXUr?=
 =?utf-8?B?QWQzMXc3dU9TcmQ4UytZbzJGYjZib1c3UHlyay9VL0NBcFFKM0hZZFkzRDBM?=
 =?utf-8?B?NVpaZWgwOTVZTkRyNmVpWi84dFpoUFB3QndEM0pjOWUrOEE4eUk2UFZGb3RW?=
 =?utf-8?B?TWlwWlJldlh5bm5haVdCM3pnUHp2alE0bXFMdkZVU29nSytPanRjSGdnSGdQ?=
 =?utf-8?B?Y21wWmtxeDQ2TlB3QndBVmQ4TWRJRTl6azdoVlUwSzlaaElBSGNSTSs4WDlz?=
 =?utf-8?B?UzY1OHpxNlE4QkV0NklDZ3pxNGtGU0JZU0VEeWh0TDJNMS8zM3hGdGo0WUpC?=
 =?utf-8?B?dE14WXJvMlNaRlcvcCsvK2JtU1lvNnc1a3lDWXpaRXplZzhwVzlueXpqNVgz?=
 =?utf-8?B?MURZK3Z6OUtyMGEvTlFoZERSTmhTQ3dLaGF5aFAwY1Y0OGorZGxqdHRSTFVM?=
 =?utf-8?Q?mfMe6tt5U5uzurFiKLgRn+6Sv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a648d54c-6a0b-4409-0626-08dabcb08477
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 08:59:14.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOuAGR/LedEbkCMqUctzsm/SeUocevGkvLA8WhTT87xjfD1x2sdR4NP1iMBEkdP4BRozZRvi/6LXPQvpMYlICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6909
X-Proofpoint-GUID: 8e_nimuzqgCbFYbGSwpyGM3QqPCnv6Jv
X-Proofpoint-ORIG-GUID: 8e_nimuzqgCbFYbGSwpyGM3QqPCnv6Jv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_05,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=796 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020053
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFhcnRlbiBaYW5kZXJz
IDxtYWFydGVuLnphbmRlcnNAbWluZC5iZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAy
LCAyMDIyIDk6MDggQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBMYXJz
LVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5kZT47IExpYW0gR2lyZHdvb2QgPGxnaXJk
d29vZEBnbWFpbC5jb20+OyBNYXJrIEJyb3duDQo+IDxicm9vbmllQGtlcm5lbC5vcmc+OyBKYXJv
c2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6PjsgVGFrYXNoaSBJd2FpDQo+IDx0aXdhaUBzdXNl
LmNvbT4NCj4gQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gQVNvQzogYWRhdTEzNzI6
IGZpeCBtY2xrDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDEwLzMxLzIy
IDEyOjIwLCBTYSwgTnVubyB3cm90ZToNCj4gPg0KPiA+IEkgZ3Vlc3MgdGhpcyBuZWVkcyBhIEZp
eGVzOiB0YWc/DQo+IA0KPiBZZXMsIHlvdSdyZSByaWdodC4gSSBmaWd1cmVkIGl0J2QgYmUgbGVz
cyByZWxldmFudCBzaW5jZSB3ZSdyZSBmaXhpbmcNCj4gdGhlIGluaXRpYWwgY29tbWl0LCBidXQg
dGhhdCB3YXMgd3JvbmcuDQo+IA0KPiBEaWQgeW91IGdldCBhIGNoYW5jZSB0byBsb29rIGF0IHRo
ZSBmaXggaXRzZWxmPw0KPiANCg0KWWVhaCwgdGhlIGZpeCBsb29rcyB2YWxpZCB0byBtZS4uLg0K
DQotIE51bm8gU8OhDQoNCg==
