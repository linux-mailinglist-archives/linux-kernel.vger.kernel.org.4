Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940CB63D781
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK3OEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiK3OEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:04:35 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC526AF1;
        Wed, 30 Nov 2022 06:04:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdldvpGjFbklYpN/DtX9jph9saKxY3Ze5mQdeRtwmidqfEme97tpP5ivq9RKPvvHhhAPZdvNShswpUQ6NeqCMb131JwH2Yp0uGWCDdmk7miCyl68YAsT587lP2ylxKnM4jDeIC0dz+KY3BEjYiLHGSU5n6kCpBi9eRosvlf3KKEdTPWhELhwMwbxsSGKZ5uD4A96ErWQMpctAc28RUKGLv9aWmB7Mar3Njvkooub8AWCtt1UF/Hy2cUc7lxwDAC8Kr4J6sbvkl04KZT36yu9LldZbXcTXAYJEb++gBGVdhoTnIcfXvpK+hGjQus2l2sGtUfUvy1fw5kkArguf3P84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAK3unjVkAjDmecceteatQu0VLrGAaZL3crEFwq2HUg=;
 b=bzP3BTa52XhrY69Yc4BqHd8KnVE6bVyv+6RDvRTE843bzt6kWGerCTSSG4BwBYnczISbPYtOJnZlwJw5rbpFgfsNTOAjixXf4CR2S/Lvg/qAodrvJZMOLIFqZ87gHRwVAwJs/uc5gzdWQ6buTZxWIlRj4mLZcuRE6yY/7Dnt/wICrZmEBwF7oBLwaskr7AdffyUNUXKdPnQ0QAOX/J6v/kIJDd2ug0lA2u4VstLSxrofydECWnWAPIvAVYBqzTZf5gnPD5s6FTU78gIbuJHpctsbE+ytw7aeZUq4o8fraaPgz1dv6izYBFPKaY4BxTyqT9oZBWQY3tTyr5tDPK6v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAK3unjVkAjDmecceteatQu0VLrGAaZL3crEFwq2HUg=;
 b=QoqYARd6jRIusquSXfYZ6djq2/WMNxRhv9m4uHSDDZsqb/Ivm138wD6oVvSDwUB+9buRTEkMwo7izZfeuHufaOq1FK25KiOs90u7khX0Nr6xOs3qzL5vqYvu7/cyBAChYIOBDfwRz9Zjv48HgY+qfOXeltlwz1tMVTJTuaSBxi/9+SqUbaDnjNoMgkhIAoyvTFuGg1aSVVkj5z5bCsC1erVDfBnMB6lg0EGnJXcrRTxWR6rcSJSBRvnAjB3oNvaVknNFnOrq8gOxceEGqQizeGt3Vfh5z1goOjA//gT+6DDXEIq28LEL4ghKNrkVQ3ZbFWvQJo2KDzUXr4Yk47I0vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB7773.eurprd04.prod.outlook.com (2603:10a6:102:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Wed, 30 Nov
 2022 14:04:30 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 14:04:30 +0000
Message-ID: <8f220084-6f2c-f7d2-7bb6-3051c28c019c@suse.com>
Date:   Wed, 30 Nov 2022 15:04:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v1] hack: suspend: usb: option: add reset_resume callback
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221130121552.1560379-1-martin.kepplinger@puri.sm>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221130121552.1560379-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de14fe1-1962-484e-0891-08dad2dbccf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iBuxV7McC1APb0weMHheq9iVbncyvyJKIzqbCo+maZ0/f2o+k99BAtE5fkC7NFxm1i0gjRHR7lL8cno99HmlkfmYazf7OlpqIdIBERT3lMnCJ8WHBuoPpQs8a8RIaO13ae2066xGtpgpMyj7mgFnAEnY3MD7JPbaFXRVTBjDS2XVcT85fkm78l2Ni+liT3/Quwp4V1pmLrRGxlBOuVXlkVAQEzpQofl2hHqHuaodiROJMZ7J2KjXMRwgcpMb/+O7o0IvmJ72PXNvTZFA5WPXk/+82JUncurum3r6e28CQO22PsJXrl8TCu5SDQCZ+v10lP1uZl3BvlhFKiL6fJ4aylGiDIY8/qGVCg0QQEPHwvHzE0h92fuyBfi4EF3K0eo8UtNeLHaGhACUOSDZmxNTD8rN2Sdo4u0g0Q+01K9WiMGiTSZ2awVeRKithRT66oyQotYPZ8ppDTtqoDC8zJNmFm3smHLvJoP5Gk/1z8VkcH4aZWlC26MsWt+86g7GGj11PTMacVApWUjPzDnSoZ+pP7rhqSZ4msec1JP3OYdsU22BQUndMVl9NS3cBlpf/MJJKeUEJkcQ9Nqpk+CTgRhb0EV0822bY/FrVi9IjrHu3Kf6JwGyms1VWkE26sjLbt9mNzW7cTbibB/WYL6HVNt51YtdzxhgCzUP5NV9ShTj4WZSeQ+uVxWsnoAmmT++KzmSnw2nLdfH9FivVd/hMjUxmtvoqJb2HrYO0FXtYaffLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(66946007)(4744005)(66556008)(5660300002)(41300700001)(36756003)(31696002)(86362001)(66476007)(8936002)(316002)(53546011)(6512007)(2616005)(6506007)(186003)(4326008)(6486002)(8676002)(478600001)(38100700002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBMRStkNEJPTlpSSmpYbitWc3RnYWtUdjd0NXZkZzRSSDhRWkFCZUJaWkJt?=
 =?utf-8?B?RlhkTzNHalhrbnl6MEQ3QjFIMlFNdEthL2RpVDBERXZNT1dnR1JoSVQxdDNz?=
 =?utf-8?B?dW96dUlGS053RG9wMHd3Zm1zMGdFbDl1b1A4czA4UE9JRVMvOHF3NGJiOGpp?=
 =?utf-8?B?YVR1Q1B5cG16UGtNL2gyVDgxa0xKelIzTnp0akZTcmY4Y0F1Rk5HbjE4N0N0?=
 =?utf-8?B?YXFhRStBWE4zQ05ZTkZKSzE5WXZqdUgyTnpXWlZVazJCZXFxNTZLS1FNL2JC?=
 =?utf-8?B?VVprMUxwREdDaWhLN3h2N0hnSGtkSlZQalhVcUhjd0dxQXZYcG9YbHJkZDFG?=
 =?utf-8?B?ckFDbVZCV3BockRJYjJHaXN4K2xzOUM3RGRwdDZFeUtRNXIwOGxxUTJNTjk1?=
 =?utf-8?B?QkJjVkIwVG1vUFpuZGc3ZlBPT0krNitRUllCMG1FOFJseHozUnhndm1qNW1w?=
 =?utf-8?B?RlQwSTFXL2lLcFkyOXJSK0JSZVdVNDc2bXB2YmhDRjhmaktvQ253SkJvbmRS?=
 =?utf-8?B?N0ZLZHlDV1VDR1BUKzZWaVJ5OG1SMkxJcCt1aGhEcjdCZUg0VnlWamlRV2tQ?=
 =?utf-8?B?akxlZDBHeGVxelhOdGhiWWJEZ2dOYThyRG03citIaHR2TENKdU9rS1NLUWFL?=
 =?utf-8?B?NXJCZnJmd3ZObzdZS2xvR2NHWEdBWm41ZGpqdDJXTzkzTUJCUnN2RG04aUhW?=
 =?utf-8?B?Y1ZYOFptdm5GNllVMUpmSnI4RVJaL0FETVVNY0hSUEhRbEVxMWZlTjI1VjVE?=
 =?utf-8?B?UjRVWlhqL25WY3lVay9SZytUN2tORy9XOS9HZVB6bWJKNitEcjdYSFRGZ25E?=
 =?utf-8?B?UjVBbmhjd2VkQXZ3RmZ3L20rbzd4ZFhERVR5bmhPTFBQTFJscHFyZmxjWTFq?=
 =?utf-8?B?S1pQMGVUUTcrL2czU2VqN0Y3dm9NRkFmempmRlYyMUxyRGswTE1RQjI2TytW?=
 =?utf-8?B?UWFNd2dIdUorbmtIUFloVll1VVBZYzVlaHRkc2w1WUpqM2QyTVpINDdzb1Ev?=
 =?utf-8?B?d0gxUFArWkxINjFHc3hka1JmNnM4T3drbXgycmlEaU9uZGhPZlpjVGo3bnZs?=
 =?utf-8?B?cGFxT0l3QlJ1N01KZ2s4OC9UK2RxQzVXbE9ycEFxbVBRT0duTFFVazRtc29Y?=
 =?utf-8?B?bzBjdjBGY1FZOHZUWHRYZkhIZWszcXhXckthY1hSMW9WL0QvdlhMd0w1TGpK?=
 =?utf-8?B?bVNmSVB6RnRzZCtOb2VPRWJZeGkveTl0OHJmYUFnbUF0MVB2dHNzKzYzVE50?=
 =?utf-8?B?b04zbEI5TDM3YjdLdi9wcGxCYk5MWTE5Q3Z3U3hMQzRablFJOWpPU1dveVcx?=
 =?utf-8?B?NkszcDZEQ0RSZWY5NTJuUVFQbGR3Q2Fja0U1dXJhZlZDRVc0Y3pla0dKaThi?=
 =?utf-8?B?dngwQUNiWlJCUDR4Z3V0cFpjcHdhMVhUSmxRWWsyb2tPbXA3U1NwRlZuT1A5?=
 =?utf-8?B?NDZ6L28rVXZ1dzAxT3pZNW8zREplL0JEd2Zybk1HRElPc1FjQlZLeWlzTnVj?=
 =?utf-8?B?RWppMnIwSXFudytwUndqZU83eURibE1oS2xDc3phMGh6M1dRVGNSL0tDb1lz?=
 =?utf-8?B?UHptOFE0d1NUbWt4MVJvY1FVcUJIWVk1b1RKcDdsZ2FnamdCUnV2UmhJZnJm?=
 =?utf-8?B?MjVQKzBZMGtTaTBCYXZMcGVNbm1IZGtZUVZkbEhCNzM5VVE0cFdmc0JibFk4?=
 =?utf-8?B?T3R5YkQ4b2dXeC9IVkJ5RlcxbDE3U1hMbm5nTVUzankzb25oTW5UM1pleEdN?=
 =?utf-8?B?dEhJN1JMWkVYWVNIMFBLaUhqTDh0NzlXQlh5enF4RTZDdUhCZWRUbkJIcHl6?=
 =?utf-8?B?YjJVREdaZkloS3FDbDgvL0YzeDlzaVNhdzFERnF0VysrNVVtaHMxYktHKzIy?=
 =?utf-8?B?bE9xeWhSc0NuRVRlWUhQVnd4bjI2ZTJKcEJwZExXbnIxbi9oQTRvVVRwVldN?=
 =?utf-8?B?M1ZHNWtobEJwdHpQdWVnQjAxQzRrRllmWUd6K0I1ZW54N0dlYmRnS1NCZEMz?=
 =?utf-8?B?T1hoMzUyS1ZTZ1pQZmVWdDYzbHdPQ29ycFRucHdua0dIeDRRQXlENjk4Mzg5?=
 =?utf-8?B?ZU8vN2s0UEpqZVNBdmp0Sk9oZlFBQk8wY2tPWXN2YU9IL0FTMlgwNVZRc1h4?=
 =?utf-8?B?eDIxSkN1U0tSRk5uYVRiRUNpTGNvWGFXbkxtL1lXWFpiVU11d1RXNW9ka2tU?=
 =?utf-8?Q?m+7YxJHmAUyizmldbv+bMF7QTMiBP7IxG8PZVZHQYKoH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de14fe1-1962-484e-0891-08dad2dbccf6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:04:30.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGZvKJfoIjYVIqwy9IMRZwftKPQLjca8WO8keKKRSpxQk865aKuWYSkd5Oa9DggB9BoXEKBfK5qOzSURtDmXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7773
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.22 13:15, Martin Kepplinger wrote:
> Currently to be the same as resume(). This will just avoid re-enumeration
> of the modem device on every system resume.
> 
> This exists only because the usb core will re-enumerate *any* device
> whos' driver doesn't have reset_resume() implemented. A call trace:

Hi,

this is deeply problematic. Strictly speaking it introduces a bug.
By implementing reset_resume() you are telling the rest of the system
that all settings have survived the hibernation. That is likely wrong in
your case.

	Regards
		Oliver

