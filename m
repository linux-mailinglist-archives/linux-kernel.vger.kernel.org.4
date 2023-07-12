Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777674FDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGLDeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLDdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:33:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D11BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+u1WWGtEo//aRPvE3X7qSoJERW88S6WPP2BkogW4LgnV2euUuYuKSX/M0gX5tjqiacU5Pie50+iP1c7+FksF3hvYso120mYEA90c7381kFwNqiX7ZrbmR4pyNx8iKYcaMLoKYoNHNvk+3vcSBjTo6KLy1T4F7vD0LJHdXbXxgCRdNgAEumIpUsMdvLOMT/UzWWMdj8ssLayoRWpgD7YMjpOsSwgsjI5b5+sGWrU3RW4O4/g8muSiP9vFCEMXvBMDnIooicU+N1hOFVrlsnsJLiiJAmIwsistALYANNU6vTOv70EVKXhvB0Z1CzxU27AM2s7soN+8wlvIwHioc6Z+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go/Jb0wZEzaqJkzOYMb/inlxwpwLVQtWrb3aUaVT1xU=;
 b=g8dz5Da1orRG+agAaXf3s8R7tnjCs72FFYJk88K58Fk0uBiYVQjHwikoLZqnQ3GwGvENFqq/BkyPy8pu2TDY9cBb7mPk+lhr0fbqwpj8++U6WlmdYr6VkJgZUJjPO5e5KqSHJHTl5cqvpA4T1oC9woUaRxJT2pDqCAzrN7fGK4BB7gg/GSbGC6ep0p1i4zU0mqFv18gX/N760ayGB8pq7DT4WvJxOc2IsIJrKf3ExEfRxi31MgmoDHxCxOiwkuG5aXrx1+XAy4hQHbACZsNhJ3nlyfNPpdCJorZxziV27AjQKAzDFg3KPKHonwvBue+CHp2xyJAYYLWrpppJhZSchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go/Jb0wZEzaqJkzOYMb/inlxwpwLVQtWrb3aUaVT1xU=;
 b=0rTi5VsXuaTd9gTv64Zh66zqdG2aojHa/UP9iUWhYFDZfVbCZ4g8L7Ad8aNH0VJCIBE5QUeMTLDlnoihCtbDYiB0Svml5P5t+CQvch7F4QNtOJFyN/vAk5LOH6SIXvljWI4fbkzKTGwSvgG5Q1A3uYm/kqXGgRSbhsUzjfXCJMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 03:33:34 +0000
Received: from BYAPR12MB2823.namprd12.prod.outlook.com
 ([fe80::38c:a382:ef01:6a93]) by BYAPR12MB2823.namprd12.prod.outlook.com
 ([fe80::38c:a382:ef01:6a93%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 03:33:34 +0000
Message-ID: <ab3c2e81-b7f5-9527-7e32-d332259cdc87@amd.com>
Date:   Wed, 12 Jul 2023 09:03:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: (subset) [PATCH 1/2] ASoC: SOF: amd: add revision check for
 sending sha dma completion command
To:     Mark Brown <broonie@kernel.org>,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Arungopal.kondaveeti@amd.com,
        vsujithkumar.reddy@amd.com, venkataprasad.potturu@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
 <168814485881.50974.4096249135530047142.b4-ty@kernel.org>
 <cafff012-54ac-2d15-1e76-c5313c01f834@amd.com>
 <2adeaea7-e3ef-4a58-bdd2-18d3ca3e2519@sirena.org.uk>
Content-Language: en-US
From:   Mastan Katragadda <mastan.katragadda@amd.com>
In-Reply-To: <2adeaea7-e3ef-4a58-bdd2-18d3ca3e2519@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::17) To BYAPR12MB2823.namprd12.prod.outlook.com
 (2603:10b6:a03:96::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f652c8-3d8a-4465-4b82-08db8288c4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8RZ3I/wMFcy6vdyYVNiiqTeN6yz+YOMa74gsuzqdj4rkpNCaOZ3pnRVZPkWaCcv1h2jFZa/8uvvDWIxUJA4qU30lHlWivVtaTdGi54/55nMbHD+rZEtItcdStrIKaASWObNXApollAibqYS+HO9SZ3YBHPnhEoCN7drw/Nc1Rrkpht86vsZXMXNy/Tw/B4kQoLk2Kv8cieEZKbaFqpKnrjH+l7ORmnE6qKRmJkLVtHkTQ4QjQtoldCXH2nEhtClv69MgEO8Hm4C7gtuCQxBILjnDP4qzzUkwZWZIcPSaNzk1aEB9eubKaL13hSPuMOaY/VqyGSfKkHUk3EvDzw2fGTfHVFCsk27aAQrwbZx3NFik/cLVV6LOOIfmQ5p1jQT2gcb4UB0Qy4Udj2K+1J+j/MpwMo907ZwYGdGyqZjRLqiryNWRnfdicHMRKhnkY0mbHrxrmf6Jr5J5c/hX3aeDZoJfn024H65Gs55FYq0APeHUjZf9z4MWVvkfiSraBQo1IaK1ISdYoGj9pirB+fiAwN05A9ZBhod6ZaqUgubnLr7qUbNCs3lzh1WH6MfuzvbJj5VN33/FLi/IJpA1TJdRbu8QcuyX4Uphzl2OAB3mQ7RwVk7fchRSGVeR6eCyHOJN8w7PrPNoJZ6oNWaznt3UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(186003)(6506007)(26005)(53546011)(6512007)(2616005)(6636002)(316002)(4744005)(41300700001)(66476007)(2906002)(5660300002)(7416002)(44832011)(66556008)(8676002)(8936002)(478600001)(4326008)(66946007)(6486002)(110136005)(6666004)(54906003)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3hpVnE1cHo3KzdGSHZ2QjhzYlZhV2p5dlVrQWxzSk9YRWZ2MDZkaEpkZmRV?=
 =?utf-8?B?Nzg0M2FYMmx3TmhySVAwUzVhd0lQbW5IdWhWa0lYS1dwRm9weDF1SEdvTXI1?=
 =?utf-8?B?OVp5OFRpajdiVlhQWlpwNWk2QVRuTk84OHNHd1pGMVJheG5WKytBckczTEt3?=
 =?utf-8?B?c2NwK29SK3FhRmFpTjA2NVBURWtFaXoySG1ralNuZlhlM2NZenBrS2NIMDVx?=
 =?utf-8?B?UysxcGh3T01DZEQ0WC9wRUNScnM5R0M4dklCdGllV0tMeEluVXc2VUxRUEk5?=
 =?utf-8?B?M3dhenNySVZYZTNhYU9WcWZVbjlvSjMxb2JVckR5Q1VZb0lJeWxCVmg3d0oy?=
 =?utf-8?B?ZFNZSDhDeVlMcWc3TXBOSDB6NERySFMwL2tRbTdjVGExbEZIMUh5SndDRU14?=
 =?utf-8?B?VDNMNXZuak90TkwxYWdsOXd0OHRYQnZ3R0d1SHI4SDBwbzdCOXVYMGI5Vjk0?=
 =?utf-8?B?MHcxaHUxRm9SSlpNcXRxYWVMZ2N1SWg0WXNKK3Z3ZkM3Zk9HWkRUakJqOWxL?=
 =?utf-8?B?L1QzaUNZV28xMEdOMzJvSnBhT0tpYTY5MGo4Rk4rV2RiYjgwVkJwSlA1UVhx?=
 =?utf-8?B?VlU2ZnpNbUUzMHVqeThOa3JTWmxRVDE4N0RVTXF4eG5tdzB1djBObkI5NURH?=
 =?utf-8?B?UHcvckpad1lHSk1iUE5hQlRGNWtsaFhwdnJ6cjdRazhQMWdRUTg2UzRuaHBS?=
 =?utf-8?B?RXh2d0tqR3grdVFKa0YrRS9VYy9nSURZeFVROSswMWEvZWw4UktreUZrWGR6?=
 =?utf-8?B?Mk40V1o1dmNtS2xVNndpMzlSR2pNbEZRYzJwdWlYVXpZTml1ZUZLaTFVaVZv?=
 =?utf-8?B?QWNJaVhHdUNCNXJxNjRJdWd5cXVFQlE3YzAybndoa0xtYzJ2QU0wQjBXeUwr?=
 =?utf-8?B?b0F2WHRTa1JlL3I0SmRjMHQ1dnhJY2JtOStuMGhnZFUwelpVY0RNRW82S2Y1?=
 =?utf-8?B?MXZ0LzJldU1zYVRjWHR6a0VZRUE1SlZoSVY1cWlwSDQ0aEVWNFVOMnRmWG0z?=
 =?utf-8?B?aCtrOFJGMDN1ZS9oME5obk8wVTdka2Zvb1hEY2pwZFc1Mlc5dTFjMTk0QU40?=
 =?utf-8?B?cnlQRGpTSkZqc25CMEd2VUczbHVJN0JKeVhyL3NMWVUwZHNtOTJZOUhXYlgw?=
 =?utf-8?B?R01XZjBBSkcxNU1WRFZrbkNISGhVZ3F0dmIvaXNia09uTkVsazhkeXVqaDhV?=
 =?utf-8?B?Vk1zdTVzckVCYkRzUmI2cWRKQTJGVm9aWFNFTWZ5L3FrdXNnRHF5ZHl2alR0?=
 =?utf-8?B?T0VIaTlQcnZyZTRwUXJya1c0TlpEVGNJTmIxeXk5SDBBVkNVZWhCUTNpRWpQ?=
 =?utf-8?B?RzF3UGtERUJvcERnUG0wMlFsMGM3U0xPYStnNmFaWnlKdG42OUx4bVNuWkJZ?=
 =?utf-8?B?UE52d05XeEI2MW5ZZTBpRFlpais0S1MzQVA2b0V0MkhOZ0dzd2FPMG43cmFV?=
 =?utf-8?B?c3JTS0V2WkdyUU9za2hHM3pBWVZxSHJYekVmV2N4YzJydW1OTXZ4Y3Azc2Fq?=
 =?utf-8?B?bmZGZUU5Q1AybTRmc1JhS2dHL0I5bzNDYS9RZzdhTWpHRG5TQ2tzbkVIZDlI?=
 =?utf-8?B?N2V4M1YyZ240YkFSYndQRUlDdmVseFVxOUhzZU54bllIbHpYVlRuTVZwRUo3?=
 =?utf-8?B?aklieTd0N0kydjJvc2piS2R4dnluWWVxeWdmNThNdCtjVkxjNEJDNHhkUzRw?=
 =?utf-8?B?VWVqQmhiZ2ZvVDBPcytxdDVYOXZOK1lXSllNdlJxVEgrNFMvbW5ZYmlIcTg5?=
 =?utf-8?B?UkdOQWVrcklnT0xoQzgxdTNoUWhqMWdDY2Mrdm9yN2hxNXRBalR3Z2pSM0ZQ?=
 =?utf-8?B?Z0E0QVN2OWNNQVRoU3NvNWhyMWdjVnN6V1doWlBFV1NQZkVHc2JqZnQ0RUpW?=
 =?utf-8?B?a2NseUJJS0p2Y1VxZFpQaXg0RndKR1hGdDcxVTNTWkZqZjNNcGhjZ3hZV3Jr?=
 =?utf-8?B?bVFmY01LeHp2ck84YXMxYW1mSGIzWFpzdktkVHc0Q01TbzBHTlpJSmc5RmlZ?=
 =?utf-8?B?QVp2NHJmQ3l6VkN2YTRhTXYvR0k4ZlhwbVVqM3NVTmxTSlp2eENLOGIzdUpw?=
 =?utf-8?B?RFN3Y3lOQ3lTbXZYelo5YTh0RXRXRkZZdDlSRndCQ0pyQzVvUG9JYmhHRFdo?=
 =?utf-8?Q?hTcaJt+sTS2MzgqHSBB72xQ4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f652c8-3d8a-4465-4b82-08db8288c4e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 03:33:33.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqb61l1szb1xXSX3BUOA/q0gM5hribJp58Ul32JBl8IiVOgLJJVoWeCXMpRHSL7CGx0bsoxJV2HUkcZ/Q3HBUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/07/23 21:40, Mark Brown wrote:
> On Mon, Jul 03, 2023 at 08:58:17PM +0530, Mukunda,Vijendar wrote:
>> On 30/06/23 22:37, Mark Brown wrote:
>>> Thanks!
>>>
>>> [1/2] ASoC: SOF: amd: add revision check for sending sha dma completion command
>>>        commit: b1db244c716fe300e36428aeb0874913d2e0a91d
>> It looks like second patch didn't get merged in this series.
>> Do we need to resend the second patch?
> I don't know off hand what that second patch was.  If it wasn't a bug
> fix it'll just be waiting till after the merge window.
  Do I need to resend the second patch?
