Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C83D6F5529
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjECJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjECJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:46:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD1F59EA;
        Wed,  3 May 2023 02:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpeYVm/ZUy0WyTwgbImrvWG3xYZbB3LrMsGVZC6VKKLoqejPIq7nCRBcLi4aW6enxLylFrxNR6Z/Sqqj/ATe/iecWYJIFSQF79mBJ3YoUx2/qZo8cd3aiMbM5TjeDfxUm+SaCYauCvFcbovPkC88smZdukudNqV5ruNSoc6uGtJia1K4ltpe8B3ltDaSF4enPRZzwUgiWljqVqieOAe4j6haxxJC/jLNuwXXePq6EfEY2Bvi9W8QaywFrzfghZpFRP+S+FdAmYH5nQRCPE0/s5Sv11t+Rty/705ALM2FMeUSSFLEWmdh3vvPY8aQAgVfEsH8PkTT/pw5q552hdaN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZg4EMJM0HXdH+HXDTznUtzu/zA5shwbaQCAiSxsf8I=;
 b=PTRgXcF4YJCoUS0r6RjqtfQ+kdvdsENYGK/W+vhswWO1uvoIXjhT6/4hta+qOrGCF04AFRq8VUkk0YeDx+OGJ77dYCqINRCM9MKSbePTE7JW2gMngZvEPpgk/C+Y8pZE8hKQyCPNQ5gPbNhwxVXxUyU2UlWUTo3lZSAwrnnvO79NhHV75y2KsM1zxM5YQFJMmIauVDhfXHTBjyE2pNw7FVYlbpHanh1CdhDJ0Y1Fece5K2YlGMR8inG//gJ5tA8cGqemKXKOjKUQ9Pna9Y5WL1/CocJOe00pIz3Dxz/q9qpmNxxqNMiHGkCoWuivpzUjMshnmHeOPNmR3GPM8D0k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZg4EMJM0HXdH+HXDTznUtzu/zA5shwbaQCAiSxsf8I=;
 b=EW2tPvQf606RetyKAK5ldL2Uadm+UNnh7Q42A8lPHCe8sEhyQArYrrr6TD5+XC+wozFk5hDrh3k1NWWu+KgWkhK0+GDiU1qQEhYZ6vSXYEruy3VJnaRxbz9St3hNMJBjAbx07lgX4P7Vn1M6Rn+DapkJ+vvoWr0iHDKyKDDQ3wFw5MqwZD3BsccvWXpd9LN6bn7OpXwc29boWBcypNGXzlo/qVZfrMeTPJ/GWfJwera1A+ntMcW+RG009tSfSCzfVIZ+gxdtLaHcKuB08AlqCD9z5OWiFylFdK+8o2IIZZi5+LFeGRUwzVp/InP93J8ZhF7ls1uK4DAo0UfoVmZWIg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:45:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:45:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 12/12] nvme: Make the number iterations
 configurable
Thread-Topic: [PATCH blktests v3 12/12] nvme: Make the number iterations
 configurable
Thread-Index: AQHZfZW5saXSLg448E+7qxy2BnXLVa9ITLeA
Date:   Wed, 3 May 2023 09:45:07 +0000
Message-ID: <4f7504a5-51cc-0309-0139-89c0a4c05fb3@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-13-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-13-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5737:EE_
x-ms-office365-filtering-correlation-id: a23e3cf2-4b14-48bb-e689-08db4bbb146a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DeOdXIkxw6kI9djQEylTQ+ynfqhJSjaSc1/NNZfUAGT0+jdZHFj527ZX0vtXuR+MJoPGwgSOeyB97mtTqZJ2HkOmc+E3Pab+UqoSUbBUN5nVSMubl3+24qHM6oy4hqjYATrWlgSwipv+T3NvSCg4z5CgWpBplgePJjhAMoIvIPvbOV7jMvEWy+EwywHxeL3XLtV0Pzwfh8wnFKVBPNUMgAMMiIHUx+joIQ9RUjeQbVPugoRbyddUrzVHHfZ9WnfCTgPOtGwonadkj/DleZjMQFhPuXRO0u1xf574ISOhSIu6oE0hUtd4EtnZk4hcNS+WUVcU6Z+ZNJLGGUY2ICnhzdRCDtgMq5ehYbrRPv4hO10S9ew0Zvk9Vk8VyCx8gzuk21v/i0xkTe/H9d9OZ/mUphxI9ntwYegSudIrw4C8eE5YeTQ27cKAHmB6toNZo22VeNm53f/oXwCQRahpNXvXVEshmRR5nc2Mi/RGEkVpClvLLtsM2obZz5nGHSH/WR+PNtyEISw5LIkuPIGCRRXIfcF8LtpEzc9VfdKn0amKg7/oM2qTUaiS6BeNNZVub7PVaUs1KyrGv7xQK+l2+nLTYKJQr9lH1uvz0EdSQ1Dl8Q7R5xauPDUMw36Alvv/1odprzpzIXcNS9t70OS/l1If+JEQyjE8yNbcKTivmJp8WMw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(31686004)(54906003)(38100700002)(122000001)(186003)(41300700001)(110136005)(86362001)(2616005)(6512007)(6506007)(53546011)(31696002)(5660300002)(8676002)(8936002)(478600001)(2906002)(4744005)(38070700005)(36756003)(316002)(4326008)(6486002)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXNrR2tCSmtXTDIwZzFIeUs0aDRPN2VyNXpFY0ZKUDNobjVUWFlCWU90WUto?=
 =?utf-8?B?bUxIWnEvTWJjSW9yMkxBaG9MM0p0WnJsa3JCWWhPSVFiUDY1TEh4MUtiR09O?=
 =?utf-8?B?TldZcVl6QVZLbnFFbjJ5RmFZNkROVnRtdmk0VFFMcFczN3pVMUdFcy93WjlH?=
 =?utf-8?B?YkJOeVJSS3NIUnorOHhQK2Jvc1gzVi9YV2ZSY0llKzJqN2JYRnNDa1NxT2lD?=
 =?utf-8?B?OU9CbStUcDBPaU5NdGhIR1gyYkczcVNkV0Q5MkV2Q1llUWVOSlF2M0QwbXdh?=
 =?utf-8?B?cmNJTlFrMlh5aThZc1BXekpFcVZHN215eXBHNDJGQmVsTit6cHpGMHEvQ1Vk?=
 =?utf-8?B?NTJYWkU3MUtoQ1VDd2lBOTIvTjNmSUQ2NE9LcjU0YnpPRUFOL3YrZDFaVjUv?=
 =?utf-8?B?ZXJCcEI2dUhuUkFoKzhUM09jSlo2N2FPeVlZN0UzL25XNHc4T0hJSTRhdnJD?=
 =?utf-8?B?MDh1amlFVHlLUmg3d01DRHV6Tzd4V0QyZ1c2WERWczh6VDN1U2hFUTZsZlpS?=
 =?utf-8?B?akFhNEt3b3IvbmRqQ3ROWHMyalMxcm5vU1J3MUxoUHNObFlSdGFVeitmdlVG?=
 =?utf-8?B?eE91VlpFQkpPcGFIa3lmNFF3VG5PUWtCVkJTbnFPSmpIUk1MNU10OFhITmVw?=
 =?utf-8?B?VFBWQ2NOWlM5UXpUVitMQUhZdWJvUzZEcmhIUjZaNEQzVjl6SDZLZWg3bk8v?=
 =?utf-8?B?QlJRbklwYUxCbTBMMDd5UXh2eHJhRUNnTkRBcFI4OWFtaURLMDg0UWZZV2Q4?=
 =?utf-8?B?MHJ4V0hzVWp4cXV1bkNqMW50bEsvQ2oxUStjbVVoQ3cwT3NKOVRzYzZ2cnpY?=
 =?utf-8?B?SDhLcWpKblB5eXB1UjQ4eGJmTmFyNVFtaWsvbm9HV1ZJVUwralRNdzlGSldw?=
 =?utf-8?B?bUEvQmluSldlcExMNjM1Wi8xbWpHd0dJay9mL0FrOUREcXVDcWVkNjlmQ1E0?=
 =?utf-8?B?U1d1WDcyd0QzNlpJbWxMdmU3ZndYa05Qd2k1Yk1SYisrWExRYzdWcWVhellD?=
 =?utf-8?B?M1lGTU45K2FUMGNQcThoYy8wZlIwSEsvUjFabjFrMnFtSmcxbnJzRFZtSHRD?=
 =?utf-8?B?T1RFcmVUOGlBSkt3MEV3VEFPNFpZY21oRWh4aktiY1ZqbzVJdFdvRUZOU01m?=
 =?utf-8?B?S1ZXQ084TllpZGdCN3ZrcXdPb2Q1YUpWbWdIWC9pZ2tJQmkwQTZvYW1XTnda?=
 =?utf-8?B?NW90cVc1bGxLNmFuc3dQQ0V6QnJydUt6M2xWaWRMOXA0bDk4c3p5eE9WNDY4?=
 =?utf-8?B?bktudnVjOS9VSkpoWWgvdm9GZEhidDUyZFVRRk02bXR1V1o0VW5EWmlNT21N?=
 =?utf-8?B?OEJMVGtHTStPcTZ6Wjh4alY5dk9VQ0srVUNjaHk0aXV2cFltWC92T3Q2Znls?=
 =?utf-8?B?aGh6cHVqQUJrZS8xQVhOR2hQRk5KMjBpZGxTWkpYbW03SmJGK3FGQURpdHNw?=
 =?utf-8?B?TWt4NXZJRTlWaVpKeWp0M0U4ZjJ4OGRna1NGWHJub0F3aXk5Q1lOQzNXZXhs?=
 =?utf-8?B?c2NiOFlVY2REN2dzSGNaYWQ1ZVBvclgvUWNIbDNlUEhKSzJ0TWVWSTIrVko4?=
 =?utf-8?B?dDVhYUpySU13djRTZnJNQVZHMTU2YXlKOUNlZ3krUU1OY3FLL3lnK0ZhUTR0?=
 =?utf-8?B?OU5neUphaG1jVzJyaU5JZUtiMzdSTENjcHU5NE5NRlRQWDVUNEZSbEhwbUpG?=
 =?utf-8?B?Znp6WmsydHNGOEVhd1IzTXg3WnNzb3ZybFhyN281dXVObjgzeWdBN3k3WTky?=
 =?utf-8?B?dHQ3NE9ob2s1VHVoYmRaeS8vblRoeTdXeTdkZUk5S2d1YSswcTdFenBJRkhO?=
 =?utf-8?B?dEdDWmxnakRlaDRzandPNm9pa2k5aE8zWGRKbytYN1d6L3czWllkSDZmMkpv?=
 =?utf-8?B?MDFjYkxtNUhNanp0M1NuV05HeE5VbzZzMXZGeUlXZG1NSjkvNElMWXZnSVZL?=
 =?utf-8?B?bnQyOURGVHIvS1VHUE9LNGZxeWp5T0tYdzVMaVdIY1NFQUZFQ2c3U3o1dHZB?=
 =?utf-8?B?WWtjSnhtVjBVTi80NXNRU2NKTVhTMXhtN1VzTk1IRmo5blFaZ3hXQ2R2cU9j?=
 =?utf-8?B?Sk1RRWRYL2FwVFhKUXZXVlVCaGZlblc0UEpIYndXNWtlUTAydUwrK1hTUDVk?=
 =?utf-8?B?ZS9xWjdyNnV2bzRFVVQvSFYrQ3d0dHhpWjcvTmx5Q2piOGF5ZHJYeDIrMkNW?=
 =?utf-8?Q?Iu5BnQDP9KeaACQX6D3jNWnbcxEs5O5kuBtIalUjR6wu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8909FB7111158342811FB7C3FAB698AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e3cf2-4b14-48bb-e689-08db4bbb146a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:45:07.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfjGOJH+YtuI7YVxrGeXqzv2gmMu5sZSpUnYeFxGy/6bvPQVvpYwP9Xje6T76v0pOelpYw0bEW8fnjdeClW/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBTb21lIHRlc3RzIGhhcmQg
Y29kZSBoaWdoIHZhbHVlcyBvZiBpdGVyYXRpb25zLiBUaGlzIG1ha2VzIHRoZW0gcnVuDQo+IHJl
bGF0aXZlbHkgbG9uZyBjb21wYXJlZCB0byB0aGUgb3RoZXIgdGVzdHMuIEludHJvZHVjZSBhIG5l
dyBlbnZpcm9ubWVudA0KPiB2YXJpYWJsZSBudm1lX251bV9pdGVyIHRvIGFsbG93IHR1bmUgdGhl
IHJ1bnRpbWUuDQo+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAt
LS0NCj4gICBEDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
