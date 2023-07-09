Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0C74C159
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGIGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:55:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C918194;
        Sat,  8 Jul 2023 23:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idY14xEhjcipGa7mjtjvvZhszCDLD5EQESB4/SjLgV1CzDFJnU0h7VSIoc1ySObnErAsCf+uIAYtKk94WmvhdfAOWrKAFu53JJXD6XmrEn835Z3c4pumqzERi7e9LUyqvzsvC251854qQNyMfdc0rYa/Hza0r24MY2oxedlqUrgcxcZ2Y4aTGjVYI4BWHe/IaUut2t+4wyYryzjVDiBW9t1P2nvdnDypoW4fIRJ4aqotM9J7vcoAcGgBQK59yimXHU5kY9SctVKYVdx+Pgs6BcefTqPZOA1zXOMX5H2tD7fSPZW9+HmM1RD8b2ihePjrWhDQrqH0pOrfdBUsx6DshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gulbSHJqQkGk63iPT/OtrA8Zsa/TWfB7F5qJzoy+M5M=;
 b=n9r0a/3yopOsD+Hlj887XE1+rx2GNwj57iW6xUjZm4BLRzgGoxrKjX+4Y16yBPXcyvNv/Sck16SaBqsRGBp+RXK/ovVhv3WnqWZMhklrSwGNovIZB6WuIr+e/8FZTyGSFNbxf7zTF//QM3eHSpd4YjqR5IXXn/iw38COVXWuRQ7l12qN4Q1BctNURsaa767bauEhFSbv08jUlTrnOixRqulOK2GLOYYB+g1Dw3j34oW04lBQu1e3pghkyz7xKo5XyK3iNHMcgZuRE7eF4FJt8uy4A3BnuaPKQyREzEE6XfQQtequLesmCVXYvr718RdF9dAJrePYFB6TK0UKWujI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gulbSHJqQkGk63iPT/OtrA8Zsa/TWfB7F5qJzoy+M5M=;
 b=muzKiztD/USXYz+Sq18h4nmQ9sQhefkvdtS4L8qdSKXUCtIdBKkZ082rzM77TCSmGilG+4jL/YmUqNJWVmi7Zmdy2DhVQGZj/sDmzc21U99QxFDrrybQafxhPmP27jd7xys56mWihtC0yxOdAJL+n+r/k85nd7dZZCgVTVIIM457Jz+KGcgB0inVIHFk9epKf+1kiWKFF4fbegHrAYIXtAjQm7ah4/d74/nh948dxaVoADg8MVsW6k6XOlElhJT7LuAlklwmsNwac2hRf6uknzdsRDE1rW6QYsaPPoM4N6MMJ0+fOJMifun+rLkJmOJIYI8x2oIeEOVxDtl3xwSi9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Sun, 9 Jul 2023 06:55:26 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 06:55:25 +0000
Message-ID: <550ff93d-72bb-06d5-2a2f-92d3d37c83af@nvidia.com>
Date:   Sun, 9 Jul 2023 09:55:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <20230629123559.GA12573@debian>
 <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
 <20230630153923.GA18237@debian>
 <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
 <50181937-19ea-ccca-057c-eb6931f4b2da@nvidia.com>
 <20230703142314.GA27131@debian> <20230707123147.GB17845@debian>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230707123147.GB17845@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a53ad2-0d64-449d-fc3d-08db804978d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD1JqJZxwOVW52q5pjZ3Sfse58miBgmOnkXSdwZyUL0JBnnFq05JVvMZVAIPXqfYENnX2reTcdN8IkcePucZWCyrUKqidzlMKLldTDPETn5bHVR6kFsYGQ2DUgKy+uDGFVnoJi7E2zwGesCiflH1ZnrFlNrlBMvgtYZJI2Q5HFZI5IgyDL+QYbkzrPzitNskkteqIiS3xZzY49hKpqHXzvLGc5ZduoJpwifgH8h61lAJgf3KGs7JatMZ3VejOK9pQnhGx0Yf+It/5WDP7+kUo2EvxMEvph032zgD3Up5/FrByqJ1nr1+k3VD4niGGpGXOMbbo6CqJCCBM6WSkIYTlZ8vC7UMBWzebAm48TW5DnfB9XigYrTmuTJ0G8XOhTU81r7Ah2/CiTdsDuNwwoRJHqRepIQZxBQoU8iGiB5pHxiFqYZJ4/+U5pRW5oP0l5MyguuxIBLLtg32HKpMkWGZc777oRAXSiHorUlFoEkfg4FTrivQ9Rh0Zk4DKl819+42w0zuG05cgAivFseWz7dab0zXxbgvKziHpreAqyNC17hZfwVA2gTqlhRBjEO5bOM0hALGKBLtmeUNT3v9U5A/y7FN1z1e8dG2iAo0u5rZ5/v2zLMICpyPqj3Npa+MHMTqjZw4HeB4LF8l4Y+pY5Tiu09FGQHorXV6gpKqywOnCaxFmXJTKhrxvL+N56Ckmk5A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(31686004)(6666004)(478600001)(6486002)(83380400001)(2616005)(86362001)(36756003)(31696002)(4744005)(2906002)(186003)(6506007)(26005)(6512007)(966005)(38100700002)(66556008)(66476007)(4326008)(8936002)(41300700001)(7416002)(316002)(66946007)(8676002)(5660300002)(53546011)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXc2SVJYQXg1OUMyWjlXdzk5ZmhNTGQxcUtrbkJFbDJUMThxamovbTBYMXVU?=
 =?utf-8?B?b2lpNFlYVzF5VHgzZlFpSjZRZXNTTGNmYkRpQ3Y0UUFpdjludE5ldUtkMVpD?=
 =?utf-8?B?NHJrMWxVS3VCNVJQbDhKTGFxd2xydGhPYzVvL3lhcEdvOUYzYlJGSVU1bXJh?=
 =?utf-8?B?VngxenBQMFBZNDZmY0tteEsyMUdRNmp0cGZ1Y1pReUM3NzF5dzM0VERBNXFu?=
 =?utf-8?B?VkxBeW5HeUNRRmlWb0JNSmZpVTVZdkYrUU1lcjlxTVluM3NaMldteTBhak5P?=
 =?utf-8?B?YTZvNkV5LzZRMnUxRTlsNStIdExqY09uSkdacFFESHIvUkc3eFRic0J0aCtY?=
 =?utf-8?B?ZU1sUHRiL3kyVHR0MXlSN3VUY1E2MjJHYkZEc3ZYU216TklOMUpCRU55NHFu?=
 =?utf-8?B?YzNYdFEyM0lWWHdwY0NvTmNYVllKTmhqSDRscmdhZldZbGZsdktrQm45LytM?=
 =?utf-8?B?bEd3Vkx5THg1REo3WU5SVHlxdkFnZC9aLy9aaVF0Zm92bHFvNHRnVEp3ZGVN?=
 =?utf-8?B?S2psamk2d08zQUt6WFJ0TFAzdjM1dkFwR1hjejZBWDU0YTJvZWd4aEFqWkJW?=
 =?utf-8?B?aVFDQ05ab0lPays4VXkwRWdrVjB2UnZ2MlJVVm1JbFo5M1pJWjk1V243NUhT?=
 =?utf-8?B?am1FVllhM1Vneno4KzZNeGFBb1RxbXZUeDJ6Ris5cktGcUJaeDZlWnk5YmxU?=
 =?utf-8?B?c004czVyeDl2bXNDYlFIdVhaMUM0RCtrR2VVZUV0c1ZLVFRvMEx0d2loUUdw?=
 =?utf-8?B?QXJuaVVBcjZVRkN3aDQzZ0FIR0FkTks3REtIeE45cHZmamN6OE8rT256Qnha?=
 =?utf-8?B?d2lGWS9QR2FYRFJ3REcyY3h0cG5NdVJHMVJNdDZGRGNvV1VFdFd4VWI1V0xX?=
 =?utf-8?B?N1cvbFMrajVzRDBxbWxOQ1JxMGh2b2xVZnRJaUlXNy82RndwNitHbTM1R1hS?=
 =?utf-8?B?QlRGbmhiRUhuM3lvZGIrM3EyVU5NUmRrTklpVnN4bFNnQWhiZmJoMGJ1SmpS?=
 =?utf-8?B?MnArZkIzUGM2U0NSdlFSclYydUtBUVRYMFpUdXQ0aU5sL2h0MnZBWHd3VkhC?=
 =?utf-8?B?VG9rd2c1Umt6d3lYWnZsQTVpUWhBSEVuVkxzN0tzSnRFWmRzenJHTE1mSzdK?=
 =?utf-8?B?ejJwVS95MnN2L3hXZ3lYRkkrcDNIRTV3ZnVMRHdnR2VBMU1QbGQvaDBrN1ps?=
 =?utf-8?B?V25taE9KQ0phM1FLM3A4OUVlcm5HMWFVcWlKUURDaTdodzZuTXI1cUJmek9h?=
 =?utf-8?B?NzJSQnF0a1djWU1KOFpzb1BBMkJPMDlRTW1XcGdKcm1yb2Zybi9zUzN3Qlg0?=
 =?utf-8?B?QlM3Q2hlcHJtWjJzSVp2QWlqZ0ZtQlliNThmeGxUak15LzdQakszTjI2aUV5?=
 =?utf-8?B?eW5KcDgwY0tYUGxNZUVwd0JzNkNDOGNoREd3ZjVXa1FlYnFQU2NxNVNiY2k1?=
 =?utf-8?B?MFlteGhIeEl1NDJQbXFkdUtiU0NNcVVIdXVJUnpaU2ZJQWw5MUZOeFM1UFUv?=
 =?utf-8?B?OHQvbm11aS9MMVJITm5meTVJbmZ6Y1E5T1d0aXpMNFhMRTEzRjNEUm1OWTR4?=
 =?utf-8?B?WEllU1lmMUJhT0pBdHBLZHBwMUVoRlMrdjRpSi9wcUdBcVBqV2hTNlk4K2d0?=
 =?utf-8?B?WFhjTWZQTFZ6Q3p1aXgxcUIxK1l2SkM0eXdKSXZhYzBicC9TTjVhc1YzM29a?=
 =?utf-8?B?MTdVNzlqVzd1bWF0cXd3S0N0RFBJRTZjYkM3b2g5K1A3QVllKytPa3FRdnpS?=
 =?utf-8?B?VFZUalJjVHhrK2YwL05xVGlOMmh3eGwySmw1R0RROE5KeUdhek11Z3dycngw?=
 =?utf-8?B?eHVmZEdaWTcvZXlwcFBSVmRzbitTbmVWcFdFb2QyV2RqUGVEYkV5dk81d3lZ?=
 =?utf-8?B?ZlFPcUovQ2ZlajA1WHJNcExxREdBK3Y2d052TkszbDNGQXdrd3ZIaGtRTXUw?=
 =?utf-8?B?bkxSZVhZVUdiRXk3R0NvRVdLTnBROFF5S0kycUhrV0tYbDhPWHBvRDZCUWtt?=
 =?utf-8?B?WDZGQnltaWJ6dGRrdjVxVlZOVDhFOTlweXNTL2RlK1hBZEFMQ01aQ21UWERk?=
 =?utf-8?B?bFZCallEa0VRWUcweG03VEdEUGx6SjUrRHBZa2JKMUdHazFrUnBMc1BqcFUr?=
 =?utf-8?Q?+gNfC1Y3EL8Q3O/ytBWJB4Kvl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a53ad2-0d64-449d-fc3d-08db804978d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 06:55:25.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUiHtsdAGCRryapnuWoXNmFRWO7TTHBWN0gTDT3zmzr01uls9XZqKFFhrGIUpD3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 15:31, Richard Gobert wrote:
> I managed to reproduce it and found the bug that explains the problem
> you're experiencing.
> I submitted a bugfix here: https://lore.kernel.org/netdev/20230707121650.GA17677@debian/
> Thanks!

Thanks Richard!
Will test it and update.

BTW, did you manage to reproduce the issue with veth?
