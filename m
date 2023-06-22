Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C573A7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjFVSCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjFVSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:02:41 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6B1FED;
        Thu, 22 Jun 2023 11:02:40 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MH7EU3009050;
        Thu, 22 Jun 2023 14:02:05 -0400
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2239.outbound.protection.outlook.com [104.47.75.239])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3r99r3uj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:02:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka32A+b9Rjkcr/RR+wXlCDNbVHD7q4rsAYxgKKmxkBOnHmbIsXW+O+b8yRIF4u7arj/W5R1CaGP+2bUrxlDT/XR2goJQRToHgznXMIWPu+2d0U0XygIk/qKhYzRWfwlr6i/4f4wNuAKICpcyusP4cJ6elsMB6umX/lFw7RqhlnsKmgVMfJKsEytmObmqiaXHfEdyWY2JeU0y72rfSOkOaaGn0SR9zdzXua90LBHdrakn8a87U/LClpSr8q40NNi1L9aeoitbxT0NvWB1iW7kffwZxJvOrDASu1I19yl+X7r5NlK6yearI9TNZCIc9Y4XmhHZFKCGSd/569S8uqrqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wYh2nT0c72oNf1mSwLs/B6TWW18oyR4gZYhsg1kez4=;
 b=jbRji070vX+TKk/491zXUgvhNgH9SIVkyv7tSsRCp4l11TKHw92qt5U9bi29FTG1zPftRWo/2Y4dof2AnRCZd+P823fLXWqOrADMPbeyOf0zhSDuIJXsgRpuuegERckwxeTenUgc98ft76OllDvefs+RYGmBMgdnvyi/jZQaaSWLoNmiqqkSier9uHs57xuWLvGXRhXzPDN+AFFIHtru8IQAFLw3a76LjU5RN6isLy6bsaP7PGURwRKVsSAeBiniSXz0/myzQu27mG10nIk5KM0NTETZSw4TcgoJKkVSKlHeVfBW1xe2G+Mph5NvDIvJm8+omXzAPTYATz6zf0gzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wYh2nT0c72oNf1mSwLs/B6TWW18oyR4gZYhsg1kez4=;
 b=U1jIG8zJnZ66t5KjMIDh9t9pWpN9iMHvCya4K8Lx/F5FVTVeDDIwRJi11TRPOIXYmyiFYT3TNm0EO06DDKCkb9GTRIXLbfrM7OASP9EnlAQOT2T7iNU3aI1PHAxbUlGTwUFe4UsRLuM4SgkxjMgBwCs5bsgQnX/nE6hJnD6PeI0=
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YQBPR0101MB8270.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:02:03 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d38f:77f6:a:b41b]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d38f:77f6:a:b41b%2]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 18:02:03 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "fido_max@inbox.ru" <fido_max@inbox.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "radhey.shyam.pandey@amd.com" <radhey.shyam.pandey@amd.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Thread-Topic: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Thread-Index: AQHZpTJII7Rju1QbfkW03UDGnFkuEK+XHOYA
Date:   Thu, 22 Jun 2023 18:02:03 +0000
Message-ID: <e57290b0f995bb05d07d48e0df3a77c526242168.camel@calian.com>
References: <20230622175200.74033-1-fido_max@inbox.ru>
In-Reply-To: <20230622175200.74033-1-fido_max@inbox.ru>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB8838:EE_|YQBPR0101MB8270:EE_
x-ms-office365-filtering-correlation-id: 563d505f-8609-4d9c-ebaa-08db734ac880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAZ1aN2Ezg2KGbwX7KHmpfMD5p+xeAVVqCGN7vbjJZRAqaCes2oKbi3r+Q3TqJvxwL94rdB5mDRxMgd5aBxcrSkolvtsL0FuOaESyBWPhYYXfMZ9xEwMMLrTfCJ529mGHsYG5Pj3S9G/z1X47TxqZmbBZwFctOyzNUYJbith0gPrf2S84Ubtfku4+d0J3GDfyxpgrQ8oJb8Whp/iSL855HUfEv09HiIN+X65mFCrR80aqNpNThQ1qvaxHMVd9rsBGeg4HswIcGOdw4BdCazBzPWdU6DlVLWPRVmSR+6zUET8rPGwj7XQn5NjbaJHnkcPHu2qmHbVFtwvG/++/zuty3OCqk/06Owm/eP6dlelJRnTWjq2bdJfY8J1mT++EABSnwNoxK3qJCZr3UOKnUpL+IMDnOTpIkf1n5fxSo4AAaDdmLPY2ws855VTB5wi8j0LhOzrETsH2umyxC225yIoJaBkv58qEaDjOXlOw6hBWf0rA+yBcCrcuWxKWLwVLCiSqaGDrfsjEwy/yE9yj0mcdi7wk8sOB7ql2tIcVZD+wUsTnLCpycAw6YglCzBdnfePlyj8/bMrl7hSlA8meNPfGE0hSsyBzRdxQLCYHtG/jU/AjTkOQGImNl3xTmMGRmT3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(478600001)(71200400001)(91956017)(54906003)(110136005)(4326008)(76116006)(83380400001)(86362001)(38070700005)(36756003)(2616005)(38100700002)(2906002)(186003)(6512007)(6486002)(6506007)(122000001)(64756008)(41300700001)(8676002)(8936002)(66556008)(66446008)(66476007)(7416002)(66946007)(316002)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVd1OGN5bW5aNVZyc2JWOTZTOTdHM0F3VFNjMWZTYXpoT2p3ZDZqdWVNSS9a?=
 =?utf-8?B?WWhHSEY0Q1Q3UXVSVi80UEhLcllyL0crLzREM0xSa2xSTGJIV0RvTklIKzZB?=
 =?utf-8?B?bkRPQ3l2WnNyMUg5cGpLY2E3Y2NxSmdrZ2JrWGtYTmRmSlhuUVZsaXgwSlBp?=
 =?utf-8?B?aFhiRy9CT2NHdjFSRHBrRzVLUFc1UVg0N3ZHTTArY1RISm02VGhtWHNHakFU?=
 =?utf-8?B?NHJpM2JLc0JTUWNWajZoeVc2T3UydjIzZVhzaGlOQWFrbWROMmh0aEJKMG5p?=
 =?utf-8?B?NnRlL2NzTG1MZU1wa2l4VksyOE1UOGpNaTZkSGlXNXMxMi9TVVcwR2RBR1ZU?=
 =?utf-8?B?UklKc0JleDd3VlJMNVhMWURmZ1Z0RnNmM2ZNK3RhbDFaZVFBRUpodUZ4bFdU?=
 =?utf-8?B?NDdsQ3c4cXUrTWtteGFkTm8wbHh3eUd2NXphUXRBejJkc3p6OFNxTVFZYlR1?=
 =?utf-8?B?d1BrMDc2bFY3T0NTaWhRUjNnVTlGVW9CMXNWNWcrbzBLSWc4eWdFaXprVDNo?=
 =?utf-8?B?eHlOaTA0UmRsa0VGTUdEZDdQWTRJa1cyYWFqUWRjSHJtRllFenhNZ3AzcGsw?=
 =?utf-8?B?c2Z1ekd3cGYyQXQ4Q0RlRVV5eTNXMjZPbTFtSVQzSkxaYlVUR3FkUTk5aTBF?=
 =?utf-8?B?aUpPRzM5dGVnQlVhYzNVNnRIdHlEZTVmeWx6THNzS1cybVM5M2U3dW42SVRM?=
 =?utf-8?B?aGhnR2Z2RC8xODgxL3VweTM0USswcW9JeHZzZzl4MXRNaHVpTndscnVueisx?=
 =?utf-8?B?QVpzeHp4T1ZKZ0IxNmxBbHJjRjZibWU3QmoyUEhiTHhYZWRwUlZyMWtjU1pX?=
 =?utf-8?B?ZStmeVh2TGU2RENPdis3NG5QcXord1JxMGExYzJtdVkxdDgxMjFqWm14YUtr?=
 =?utf-8?B?U24xSlQrbFV2TXU5Sk94bjRyaEFzZThGRnVoeVVKVjJycW1qUjRYTnl4Umc4?=
 =?utf-8?B?OTFNU3BIZ3BGbWZOWU1nRDdjaTk4aHJkaU5hdWl4UkpROWFOSFI5NG52SlpZ?=
 =?utf-8?B?M0Rod2pOc3NMYjVwbWZMejRTWUE0N1NjQnhpNWRGY0lDdUdGOExSSWtyNk54?=
 =?utf-8?B?cG5EcjIyMGo1MFFicGhMcWV4YjdadDVnemxhdHJVaWg3VVlobGYydDdNQkwx?=
 =?utf-8?B?M3hQLzQyY20wUW96REJ4cVNSRk5ySSs5L0RRYlJkSlVzMzN1N2c1UzlkM3RU?=
 =?utf-8?B?YkJZMVJYSFp5OURaUUpFOStZTzlidi9FWEpzTXNUNk5xbTZkRU0wWU13Myt0?=
 =?utf-8?B?MnlNMWZ1NXVubGtrWW83b01PWjBVV1M3dHQ5RGdDQkdFdlQ4cVhQbmUxNjll?=
 =?utf-8?B?Q2ZHSmtJcUVQNitjSzBORE5QNnp2eEZYeWMyUmIzNVdZUnR3bTUxVTVRL093?=
 =?utf-8?B?OG5ZYjFYbzVKekVKSElmWUdscEhFZis5akV5WlRpTnNNMXEyMjRyK0lkS2Fs?=
 =?utf-8?B?d09oVTEvU2grMURJMllhTjJNM1FSbnJVN0Z6NGZJSHhOZHVNUkwrWXJWS2ZE?=
 =?utf-8?B?aVowN0FjZGJKQ0pBQTVFak1sR1c0dDJ2dGJ6K1g1dldJcFlBM21ReXUrbVdn?=
 =?utf-8?B?NkNMZlVxTU4zZmdTWDNQQmQvT0FZUW0zN2ZkRVJWcy8vTUdMY0d1SGsranNX?=
 =?utf-8?B?VHVJTGRYQ2NCRGp2L2Vad0N0QjhaMlFBWEJGeURvSlBidmg1eFpNaS9GT3h2?=
 =?utf-8?B?QVJrL2FvR2ViNVZQSmlzT3JZTDYvNnk0cG9hSDlWQWFQcGVwNG5xRmtxamRt?=
 =?utf-8?B?WlY0eDVSL0h0UmV2RVhmUXAvaHlCYkZDTzZjdDJKOVcwODZiRjFHbGMyYzFH?=
 =?utf-8?B?MFcrclMyN0dKVFJIZDl0S25BZE5yT1ltQkxNb0pib004SDl5dUtDdXJTbmhY?=
 =?utf-8?B?eXRYN2dWaWg2Z2llQXlzYUhPTjQ3RG80VURkSDFYL2h3Uk92V0gzaVUxZS9j?=
 =?utf-8?B?MFhTcHZSR1dqRHc0SDgvKzJFUkZ1emNrM2krRjFwT2o3RjZldUJRTGZjdUI4?=
 =?utf-8?B?V3loaXNzZG56OUx1K05KTlhIVjJJbU83Snc4ZFBjYk1rYTJaT25KN2lMUUt5?=
 =?utf-8?B?ZWFTRWpJNDhLaFRJUTBvaGpMcWpPYnk2UWwvNnVUQncrYWowSHBDakI0MUNR?=
 =?utf-8?B?ZnllRFJ5UU5EeHdHZHc4TFZjL1AxZDhhY3ZJdUNpZGVyVzl0dEdFZHZCclJM?=
 =?utf-8?B?R3g5YkdKTEQycnlzem5ycmpLdTA0KzMrSkVjVmhZZDR5UEFlZjREM2g3NWlm?=
 =?utf-8?B?L3JsenNkNkhmdStyMmNIMjZaUXVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE10328D22DB404883D0FAAA30AEF923@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QkxQTlBhVVJ5SzErYVdmZmhIbU9xMkVMRUZxUHVMQ0hWQ3Nlb05NTEVzYjRW?=
 =?utf-8?B?ZTFZQWlMTUE1ajh1V21UdENoWkdCN1FaVHorL1VoZEQ1VmdkbmF2aEpMVUsw?=
 =?utf-8?B?Z1U1Y1E1SGlzd3VCbmVnTUVEbmtXdmMrNTRheGpVUUVWMDBCejN3Y3JtS0dO?=
 =?utf-8?B?WUxGQ21WczVISjc4L1dUUkJpZG50TUVFUkt6M2hRbWRKcjVUKzkwUUlVa0hT?=
 =?utf-8?B?S2RQc1FiSDR0NHdCeU1ENHYreFdxOFYxeWN2OW5XT09iNUZRSkNFcVd0cGhE?=
 =?utf-8?B?ODZnZUdSQzVxWUtrY0pjRkVFQ2ZkQVZsUFdYZCt2RUxjSDVSM0lTaFAyWnVD?=
 =?utf-8?B?azNVeDNIVWFUY1NpOWZzVzJuL0VaeUFSVjF6OS9XODRwN2d3OVpTdWRHdjhI?=
 =?utf-8?B?UXBBMnh1TXVTc1Z3S1FBaUdKQ1NURGUrYzVGRG10SElpUFJQYmV6d0s5clYw?=
 =?utf-8?B?c0wrYlVJMGI1RE9zRW9IS1NiQkRKcW85UEY5S0Z0anloVzBrc0d6dWJkOEVM?=
 =?utf-8?B?dXJvTUpCRWwvTVRQazdvZ2lLVmEwRko5c3dlcXNGMWJ2S3o4K3IwVW1ucld3?=
 =?utf-8?B?MkN0RHFtM2NWS2ttQTltQnVNWG5OYlY4T0pHTHliQlVyaW14OFkwYmdFQ3Ny?=
 =?utf-8?B?cSs3MldEVk1VbWFwOHFSVW93dytYY0VIYWVqMFJ6NWxtUUtYUDYrUk83N1lC?=
 =?utf-8?B?VjZhd0dhaGhUOTJIaVYwTlNKcXV3MDY1K0FFTlRBNVV2eXpRMVlpVDlONnZ2?=
 =?utf-8?B?ODdld2VyMncvSno5Mm9nWEhJQVlrc3NROUIrL3M4VzJyUVNBczR1K1FCRFB1?=
 =?utf-8?B?RkNLaVFsV0xRUVVwanFydENuYksySlpjTDY4VVQ5RjdtS01PdXFKYWJvbER6?=
 =?utf-8?B?TmtiSnJ6VElrcTZQalVSVi9ENW1JTVhkTjA2QXkwM2JyRzlHTnNBZGYxOFQ4?=
 =?utf-8?B?ZXhaZEFWSzRqSHY1VldJTzcyQ25qWkNxOVpwSXVxdTBMZTJBZEVwbE83ckF1?=
 =?utf-8?B?cFd6N3FtUEJmZVltYWVxWUVJZlBYRzdLS3BmMnZZY1VIcW1wNXFEQjhPWVhW?=
 =?utf-8?B?eStMK2xMaUxja3JGdGRhY21JZnZHanpzVUZUMEtHUEZyWjdkdS92YmE4RXBj?=
 =?utf-8?B?bkw4L3BpTERpNVZsdWJiQmJLODgxd25RaGlBUElHK21RMmRiVDQxWHN5NVRK?=
 =?utf-8?B?RzJpUnM5eU1QOVRydWtoNythYzNhbU1ac3cxS0RuZGRTQm43VFBIZng5TU5F?=
 =?utf-8?B?TE5lWUkzTHlpY09yS1FlT2ZyeHE3V09IMnVacnpuOTNVZjdBc1hxZXllYndx?=
 =?utf-8?B?TzVxaUJMa3RPZ0tmOEJLK3pTRzc3Um5PdjFTdm9ESDZSVXhLb3hTakN0WTRo?=
 =?utf-8?B?RVc4STVBdUV6SEE9PQ==?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 563d505f-8609-4d9c-ebaa-08db734ac880
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:02:03.1661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HE76eiX9Yd3nsun2hKmWPSGZ2UAYSKisDcm+s4R1YG9s0G773iTLlssdjUrbVBw+Lg5a9ysLJ81XvBxP5VgJKoH6xYVWeyWKdlxpPzNksc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8270
X-Proofpoint-GUID: 8ehX6U7f2yDFQSOAJjhuVEj7EEHABdf1
X-Proofpoint-ORIG-GUID: 8ehX6U7f2yDFQSOAJjhuVEj7EEHABdf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_13,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=808 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306220153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDIwOjUyICswMzAwLCBNYXhpbSBLb2NoZXRrb3Ygd3JvdGU6
DQo+IERNQSBkZXRlY3Rpb24gd2lsbCBmYWlsIGlmIGF4aW5ldCB3YXMgc3RhcnRlZCBiZWZvcmUg
KGJ5IGJvb3QgbG9hZGVyLA0KPiBib290IFJPTSwgZXRjKS4gSW4gdGhpcyBzdGF0ZSBheGluZXQg
d2lsbCBub3Qgc3RhcnQgcHJvcGVybHkuDQo+IFhBWElETUFfVFhfQ0RFU0NfT0ZGU0VUICsgNCBy
ZWdpc3RlciAoTU0yU19DVVJERVNDX01TQikgaXMgdXNlZCB0bw0KPiBkZXRlY3QNCj4gNjQgRE1B
IGNhcGFiaWxpdHkgaGVyZS4gQnV0IGRhdGFzaGVldCBzYXlzOiBXaGVuIERNQUNSLlJTIGlzIDEN
Cj4gKGF4aW5ldCBpcyBpbiBlbmFibGVkIHN0YXRlKSwgQ1VSREVTQ19QVFIgYmVjb21lcyBSZWFk
IE9ubHkgKFJPKSBhbmQNCj4gaXMgdXNlZCB0byBmZXRjaCB0aGUgZmlyc3QgZGVzY3JpcHRvci4g
U28gaW93cml0ZTMyKCkvaW9yZWFkMzIoKQ0KPiB0cmljaw0KPiB0byB0aGlzIHJlZ2lzdGVyIHRv
IGRldGVjdCBETUEgd2lsbCBub3Qgd29yay4NCj4gU28gbW92ZSBheGluZXQgcmVzZXQgYmVmb3Jl
IERNQSBkZXRlY3Rpb24uDQo+IA0KPiBGaXhlczogMDRjYzJkYTM5Njk4ICgibmV0OiBheGllbmV0
OiByZXNldCBjb3JlIG9uIGluaXRpYWxpemF0aW9uDQo+IHByaW9yIHRvIE1ESU8gYWNjZXNzIikN
Cj4gU2lnbmVkLW9mZi1ieTogTWF4aW0gS29jaGV0a292IDxmaWRvX21heEBpbmJveC5ydT4NCj4g
DQoNClJldmlld2VkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNv
bT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC9ldGhlcm5ldC94aWxpbngveGlsaW54X2F4aWVu
ZXRfbWFpbi5jIHwgMTAgKysrKystLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3hpbGlueC94aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4gaW5kZXggM2UzMTBiNTViY2UyLi43
MzQ4MjIzMjFlMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3hpbGlueC94
aWxpbnhfYXhpZW5ldF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54
L3hpbGlueF9heGllbmV0X21haW4uYw0KPiBAQCAtMjA0Miw2ICsyMDQyLDExIEBAIHN0YXRpYyBp
bnQgYXhpZW5ldF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwX2NsazsNCj4gwqDCoMKgwqDC
oMKgwqAgfQ0KPiANCj4gK8KgwqDCoMKgwqDCoCAvKiBSZXNldCBjb3JlIG5vdyB0aGF0IGNsb2Nr
cyBhcmUgZW5hYmxlZCwgcHJpb3IgdG8gYWNjZXNzaW5nDQo+IE1ESU8gKi8NCj4gK8KgwqDCoMKg
wqDCoCByZXQgPSBfX2F4aWVuZXRfZGV2aWNlX3Jlc2V0KGxwKTsNCj4gK8KgwqDCoMKgwqDCoCBp
ZiAocmV0KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfY2xr
Ow0KPiArDQo+IMKgwqDCoMKgwqDCoMKgIC8qIEF1dG9kZXRlY3QgdGhlIG5lZWQgZm9yIDY0LWJp
dCBETUEgcG9pbnRlcnMuDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBXaGVuIHRoZSBJUCBpcyBjb25m
aWd1cmVkIGZvciBhIGJ1cyB3aWR0aCBiaWdnZXIgdGhhbiAzMg0KPiBiaXRzLA0KPiDCoMKgwqDC
oMKgwqDCoMKgICogd3JpdGluZyB0aGUgTVNCIHJlZ2lzdGVycyBpcyBtYW5kYXRvcnksIGV2ZW4g
aWYgdGhleSBhcmUNCj4gYWxsIDAuDQo+IEBAIC0yMDk2LDExICsyMTAxLDYgQEAgc3RhdGljIGlu
dCBheGllbmV0X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IMKgwqDC
oMKgwqDCoMKgIGxwLT5jb2FsZXNjZV9jb3VudF90eCA9IFhBWElETUFfREZUX1RYX1RIUkVTSE9M
RDsNCj4gwqDCoMKgwqDCoMKgwqAgbHAtPmNvYWxlc2NlX3VzZWNfdHggPSBYQVhJRE1BX0RGVF9U
WF9VU0VDOw0KPiANCj4gLcKgwqDCoMKgwqDCoCAvKiBSZXNldCBjb3JlIG5vdyB0aGF0IGNsb2Nr
cyBhcmUgZW5hYmxlZCwgcHJpb3IgdG8gYWNjZXNzaW5nDQo+IE1ESU8gKi8NCj4gLcKgwqDCoMKg
wqDCoCByZXQgPSBfX2F4aWVuZXRfZGV2aWNlX3Jlc2V0KGxwKTsNCj4gLcKgwqDCoMKgwqDCoCBp
ZiAocmV0KQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXBfY2xr
Ow0KPiAtDQo+IMKgwqDCoMKgwqDCoMKgIHJldCA9IGF4aWVuZXRfbWRpb19zZXR1cChscCk7DQo+
IMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfd2FybigmcGRldi0+ZGV2LA0KPiAtLQ0KPiAyLjQwLjENCj4gDQoNCg==
