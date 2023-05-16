Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3AC704F58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjEPNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjEPNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:30:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D910DA;
        Tue, 16 May 2023 06:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5csEKnwxQGopgukBqhDu4xS71SkdcLLCXck9ndo0Hsi1hbJ9n/1QhkxAZdi5w3Z7a0HUm3jEM8c5lmbf4aKANVKz6QuAgIZE1VdRiLiTpZc4KKkwKjmK008BFNYpM/6XYEhnAwL4lZiXGsewIMQlg5DSh5Kl9H8ilORfG+DtMkTvRMDOTErW06vKGOCOZh8j/z8JsvJpcbNFnrSYuQJCiuxb+5w8IlXwfdi9C01uqNCfyJs5WZZ3uNS0K+FzdXP5zHCCzNqmwbIBFqHlddKYcZqq8qCgS/E9Kwq9TVg6NCiGbv9er4NGBD8tEVpvvr3gUX2+ETdUfHa1w96u6x9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW7ilCaS2lGByfpNnDQv1pkOz+K6slP2dfKrX+h34B0=;
 b=ldYZPfF5GIkhhwSUbNluNJyb8OC1cdROInoOn8sRer5qfIk3EsMyy6Psqw4umYrQrn+oxh+Vqknqt8hyd2rrCbDC4xWTsQfwza2G+PaNBLrR44rvbaTrmXzhQlYxTOZkx3e8fHxq9QJIvsvxraDjHUJzWgrg9FP8sVuyxbuNNgyQ4EAMxQmu9xjGfmsTXPm6nDPq0lcXMVW3pfVDR+ZTfaGyHcBDEFZS/chAbZROlY9drEKxoxcIEtXZP98TPbMQJvGYeUJTdRCYyTKtlugjN2naPBmnO+u769uhDPFNzBg3x9porRJIiRpyXuHEOkQQKtenx6/gjcyASQZMX1XfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW7ilCaS2lGByfpNnDQv1pkOz+K6slP2dfKrX+h34B0=;
 b=hPIzrm3nxAj/mMhu5jYw8veokdNq1/1fFeIUw7OvXkLM/Ld980qF18e5pl2UMZb0TxRPg/3WkXqq2fntMt8zK2sEGZoJ6oXp1vdKOQvZginStDfYzPPbzg4kwJYJBMJxQ0cbVHKj54A5KLEpMNinEKSMowHTk4FHV1UG9hxMLJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:30:42 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 13:30:42 +0000
Message-ID: <7d034b9e-e4e6-5d72-8b37-78e25918aa59@amd.com>
Date:   Tue, 16 May 2023 15:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <1b2914e5e6010b174c14603f92626ac3b11a2263.1683034376.git.michal.simek@amd.com>
 <20230510065421.GB11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/23] arm64: zynqmp: Fix usb node drive strength and slew
 rate
In-Reply-To: <20230510065421.GB11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dba3ec-3dbc-4214-d9f9-08db5611bf18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnlUfsZC8lKx12n8w6AfmxwIcAPUmgiIOkkG6e5DSlL29wgJ3m2+5mf0M3Q4b7g9owfbhgpE7c7XN2eO7pvcYW56QjWczSUwj61x/pCKd6ePuwR17OgRHeW855C5bKWMlWCuvDVsz0o+3rP8zPgHhzQZx2s5jpwjRKttsHbrXRMDXEVMSjWhT5Vai0tfpMotrRt2lfiSPbBBppU7hINko8yaXaUHKHk/xcDU6gNPhEEARG2/koQQkzEg9uzcQJgnumBFy2GbkpKNsiA1ZzNt5sLD/63fP1SMSU5XjG6EdgfGyTalo2Zk0p8KdRHG2uMd1UTv+wBbc3d/EheDNkuGzmGq+TLvznmI4FsAZqLhH7/q5NbcRmpXYP/LfQtzMwCEI1VNJnXpWBLIwdQy9bU/9jMV84BCDk3Y67x/qdvk59IMO2sqir8/sORdmnrBTUsIfgQdnpnLN1qsqkQ4nl6pajLYiruYVK0ei8cndVort2ZYWzwYhOnpAefP03AfluiuwQr6SOozQrLEjFmYVQTliWqjRSiLwn2N710AE2pHnNh0Ns7LD7lpZESwIJzZaOJIbIg9xeK9AZKebceQdulzLcGAoy+5JGr7qpg6mrMxsULyvHw40bkLnbx4AbIP8WZUB8bHl5anNWwM0MUo8O5AFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(186003)(6512007)(53546011)(6506007)(26005)(8676002)(7416002)(83380400001)(8936002)(38100700002)(2616005)(4744005)(2906002)(6486002)(6666004)(66946007)(66556008)(66476007)(6916009)(4326008)(54906003)(478600001)(31686004)(316002)(31696002)(36756003)(41300700001)(44832011)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlpLRUNHcUZrVEgyMHdGQ09aNVUxMkp0cm94V2JLTEdrSkNmT3p5ZUlvdDZi?=
 =?utf-8?B?dzZvVUVOeVlzMTZNanFVZW9KSkhNZWwyUVVPS3pkckM5NEMzRlRpUk80Tmxr?=
 =?utf-8?B?RU42UWtobjY4TjJsTVoxTm1IOGZBTmwwS0hIUm5nK2VzWVRzSmRFZnJhN0w5?=
 =?utf-8?B?TVJvc3ZDcCs4MElFYi96cEZzZ1JIYUlDV0hlR0NESUdhUjZhUG9ZNTE3WlZa?=
 =?utf-8?B?aUlsQVJyZzF3WDg1UkdIejhjUU1JR1dDUVNwRGhrNk5lcWpmbUwrcUR0bitr?=
 =?utf-8?B?ekhRU1lhQzZwaDdsYW5rTzJCcko5TndTTllqQ1RGZEN2Ui8vTEErMEdFeU1E?=
 =?utf-8?B?ZDdxbEpXNGRsdlh1K2ozY3Ftd1FPS1RONU03U2hiay9WT0FheWVoYjNGQWdy?=
 =?utf-8?B?VEF1TERXU3h6RkYxMzdtNGNDMkFqOU0wTlVKdi9QNTZXeS9QSk43RUhVMzZw?=
 =?utf-8?B?NHlQaDNUbTdJSDNUZjBXSEpqWGJiUEphQ0xqM2haVDdjbHJ6V25ENEZlZmhU?=
 =?utf-8?B?T0lJVjFvOXBRVlVCUFdZUnVGNTR4UXZXWUpWVTVXdlByY05tWFBzT3ZrcmJa?=
 =?utf-8?B?Z0NkVE5lQ2hjSXdrY3RheGdyeDVvT0FHQWNTanJnWmtiSDRKeVIweDVQVVQv?=
 =?utf-8?B?a2JTczJvN3Z2dUZLUmZQNUdtOXJzWGE0YVArN3JqcWhHWEg3NEJ2Y1EvNk9s?=
 =?utf-8?B?L093UWNCaW8wRkFUNldUMmJ2d3lUZkQxa08xam5PQUludStMM3J6QTJCV1N1?=
 =?utf-8?B?NjIwSUFrMW9kMTh5WjVselNmM2kxY1JCRjNDOFgwSGM3Zk43Q3g0NzJBYWZR?=
 =?utf-8?B?elQ3UVk1ZHIwSGdWZnZxN1MwOFR1b3dMbUpGbEdXdklRcGxFT0Q4Szc5bnM0?=
 =?utf-8?B?UDhSREh3WUNQMFVNWUs5RW85dUcrSXgzc3lZRFhXMDhKTHIrTDNSNVU5b2VZ?=
 =?utf-8?B?S3RzVG1FQWZDUXd4SHFiWkszditoOFEzME9IcUhza25EVzZCbHR3ZXloaGhm?=
 =?utf-8?B?STdybEFTQitzTEJtbmFQUWsrdEl4L2hXelZBUVV5TVgwWmNMNlJ1MUVGS2Uw?=
 =?utf-8?B?QWpENzA0dHVwTTR0K0oweXpEYVV6SllLaW9ZQXdGbmhPWGpwVm5kOFlsNndv?=
 =?utf-8?B?QitoL1Y3bFB6Rk9wbi9zZ1pHMFpyMVdDWXNlN2ZDU0N1Z2prRXhiM0Y1QnBV?=
 =?utf-8?B?cEk5NGhwdElCaVdrQk0xdnZXcXplUGNaVWRtSVZqMVFlQWtQeWJqblRVbXV5?=
 =?utf-8?B?Rnh0ZHhweXJjNXp1RVhNaWM2b3lOb0pmVVNldFcrYXI3R3N1QllpV3R0Titu?=
 =?utf-8?B?ZmJsUzlWbXVZZThjZmRjS0ZxSTYrTWpLd1RXcXBtNXN1Wk9qWGxBZGIzTG1l?=
 =?utf-8?B?bVNVMlNoWmlHQjl6WWlXOENTeTQ1enQ1R3V0bjhuUFVQelI5RytmT3ljSUhI?=
 =?utf-8?B?UmZ3QnZqNVpFWTlhY05JRkc5aGFIcUNvZHlnMzBLc3hKYVhTVnRzM2VoSlZt?=
 =?utf-8?B?Q2FKY3JqUjRVK2xZMlpzcGcxMkpwUnhTZjVpMFdFZ1VKWVB2T2Z1QytFRlRk?=
 =?utf-8?B?YjB5UnZiZHl4K1lHelRzdGI1OVpsSFZQTElZYld1RzkrRTlkS05hVld0YWJl?=
 =?utf-8?B?b0Y5aVYrZ0p1RWtOVHlRdXAxejNwczZZOVpzQXZUY0Y4bUNGMWRFWWl0R2Z0?=
 =?utf-8?B?QzV2eGt3NGFSb0F1RmZrRytkNXg1NktyNU0vMExqMG0xaVYzdlVXR001b0FU?=
 =?utf-8?B?MVZNeDNEbTU2WlJrOHFUOUlnalowbHN0aTI1Q3JnK0FlNnhBMklvVVFGWUdR?=
 =?utf-8?B?RlhGL21ENXR0Zk01Q2N1ZjlBUlcyckovSVR6TVpEU1RITllGYks1dXVvM09W?=
 =?utf-8?B?bXF5OUI3TGhuMWZUNjhJV2NDMHNESVp0TlZ0S0k3cWlCZVlmREJKdlBhOEU0?=
 =?utf-8?B?bzB5aHZKWTBCWmlvTjg1dHBNNGVZZk9LZmhSYWRrU0swTXNZMWpRYWVlL283?=
 =?utf-8?B?aWdBVVhLMnVNS04vQ1AyYmZpTzR3bnVVUUt6L3A3cW9FeDFGZmRkcWJDNVA3?=
 =?utf-8?B?WGJwSHdKemVRSUpGazhJUWJHQ29QV3Y1VWw5SHZYSjZvTmpIMVEzdGVnQU9o?=
 =?utf-8?Q?1hDDj0qDijhrYryz8VW1wY711?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dba3ec-3dbc-4214-d9f9-08db5611bf18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:30:42.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2hL/DKx3ooEW33TNFuus2JEcZpoiySL4t5qTguy5rwR+FCx7UvPGT0B7UV5HraH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On 5/10/23 08:54, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:30PM +0200, Michal Simek wrote:
>> From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
>>
>> As per design, all input/rx pins should have fast slew rate and 12mA
>> drive strength.
> 
> Why does the slow rate and drive strength matter for input pins ?

In design tools all inputs pins are setup like described by default.
That's why it could suggest that there is no need to describe default 
configuration in DT.
But all MIOs can be used as GPIOs where pinctrl can change their default values 
to something else. That's why setting up default values is to be safe even for 
input pins. I don't know HW details to that extend but that values can also 
change input behavior that's why having default is not a bad idea.

Maybe make sense to extend commit message to describe it better.

Thanks,
Michal

