Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6DC66720F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjALMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjALMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:23:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03913D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKIPuNZVYL8ftSD3Cc09TFBxxjybrknKJvmQMU2lSfvIFbg0MH3WGdS6wXbsREjhRZoCLZ8//pwpdX76hAjWZKzPf/NsqLEzdXShVewSe+wl/jI26YK9h+PY24yEqGouClNaVv6KCALtDjNO0DmLQXm7pNdKjnSTKNrpTTS+k+kr4WO0yJ+CAA8W0w8DXLFfqxVTVK4QyCWP+4QTbT+E0owQzaB9Jjx+XF9wVfrLHz/GLA7PvQr65xtHJkeDbUlxEF/psfsEimj2sCbhgAeHpxa9olTm1f414RVU9LKcpeS98KeorWwhCL38SD9c6K0UWrgoIry4iXsOcrkjB2cJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JFupKDH6xiDD5X2dFmeVc/Js+yOBJshw7LWveNIWVo=;
 b=mL48rdn90TdMOWQOkY6wpn1nmxmxNkan86C6aytB+k94jacit5SpwhvrLvje5Bv0ZencQHtxvAs2u3qDz0YxqSvvZMpZEopXrv2ShXYWiSKRI0u/8L4hbX7rptcwc63Rmh+ZCruqBe5cOt6DzswH0C/5tafAakKRhzrBbOHIwjXeSZUWjndZo6j8tNp9fQBosZPcaMvyy/r1T23NWoB0oYLGY1vN+a76HnOBXe9UL9wHHf7e/clmeCJ5/GalOWJf8FU+/YTDIc455RbQ/lrY+T6oBxBt70+AYtmakSmJehgIusTePnmMiEFYZES8YCmPKQKUHVJzbE0StcuJqmvn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JFupKDH6xiDD5X2dFmeVc/Js+yOBJshw7LWveNIWVo=;
 b=L8Ecul2H5qRJbr4aHPf+tbkve6j8b7FEpAjNFynFp8bcFIqQo418ub2R57t+bEgPk3skdL1cuFop5/Ja5z68JoHU8xqriED0iJp+y6QvVjWXuOjXZmE9srionGDJ+NmrwAFjEeCbilTDYAdUOCLx9ZYWjpfydLbWmukRj5Hqc/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 12:23:51 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::9afd:79c5:9fa7:be19]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::9afd:79c5:9fa7:be19%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 12:23:51 +0000
Message-ID: <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
Date:   Thu, 12 Jan 2023 12:23:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <Y53BputYK+3djDME@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::9) To BYAPR12MB3398.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b9bd5a-c8b4-4ac3-70e6-08daf497dcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDiq48mVJs65SsotnVqG058KTWchTcWWF2d+NDR4xrManrXk1H79xRRLHRGlULP4qj+OxdbO3Ou+0VMPvnzS5RKBNSn2+YH/yzvay8ykzZ2DOln6RCFYIu01lkWyUJRX7YBTlrQ3K4NF2R8Em+Fc655iqi7pifNc45wXDyrrpFDwHE74k/4TNynZsBz/iioix7vcIPBaliDB+Ak6lKktBtSDYLIl2rF+v2UzEBo7pBy1mMQDZ77EAKdKuyyP3Ypd8Woy39eoaOq6mFhBqcWBCf93g7QBphvm4FVUVM09A/fR2SAtdDz5QDjP2NlvjIMO2RyZrbTFAfV5CJ8TKJw2HVGtuP79e3bGTU5tfLtI4hEtmd8Ew1RdVlwTIOUPsNG/zpWQ62pCi2NVUJjUYKOtje5avFx3uXpeG3owuVPpM49232lq6JPVt6gBImRtE/vy3zsmPig/GKc3f+BAvRcDQYOZKid5RuUBA5oI2mFIFka3MeOUWDpOS8+yQghPk57OGqneFRUq2RsuVM8MaS+Y/JxQCr11djNuvrWlgt3ZmEtJ0/QMzXEHCNl0TbOpzopvRZ2jMxan9ihOqN+rXIkCb8593749oOpUT/bWacqrfnZi/bnq7rsGh2VXzidbAuEy/V9g+qtWn+RjVYEK8YLVq6PS2pPZMeScghU0XVrZvXoeZz8VvrZeREchSL1JHjdF446JIUrNPfAirMy5TfkTF+rb0iamgp/3bjp7YRxw7dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(41300700001)(4744005)(6506007)(44832011)(8936002)(5660300002)(31686004)(6666004)(2906002)(83380400001)(66556008)(66946007)(8676002)(6916009)(4326008)(36756003)(38100700002)(316002)(54906003)(66476007)(478600001)(6486002)(2616005)(86362001)(186003)(31696002)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVlMk5ITmxzOWE1NDFmczdNSzFmeE1kQWdvMU5wZDJqa3hqb3NObGFDekZp?=
 =?utf-8?B?ZElXUTRDR0kreDdLdEJZYUNXamtHQjgvMjNKcWkzR2VidXU1dGZKb3FJZHlo?=
 =?utf-8?B?M0hhT1FseldJYkFuWVFmWGFlbnlraXRpZllTdUYwSDZMTEY4MTYrUzJlWDNz?=
 =?utf-8?B?Mm1BNHpwUjdHVng5UDY0ekNlN1hndzIvWUJhUGkySFpIVGRMMmkzWVp1SXdo?=
 =?utf-8?B?Z1RkTDFrUUh4TzZuOHBoYW1RRk9zQ3diTjhZTzV1UEx0aGJBUGpYKzVMZEdR?=
 =?utf-8?B?bjB2VXVJMmVPL0pGeGVMUXpIck52eFgwWU5ieFIrOWFGdzJUQ21hSVliT1FF?=
 =?utf-8?B?SFpMbFpkeHRNUGx5QVBhRkY3MTd2bnl4bTZieVBhOHdJMkFianJTYTU5Ukx5?=
 =?utf-8?B?ZFkvYkQvZlpmSnc3Zk11ZE1waHpFSkRKY21JbHpKa1d6d29lbnJNdEhRb0wr?=
 =?utf-8?B?NEc0ZzU3RisxZDM1eTY1STFyRGVzWENvUzlKaFpUSnRJNWZsS0JWU0UxTExj?=
 =?utf-8?B?ZzhqemJzS1J1ZktHU3FjOTBuMmpleElLeG13YzNhSU05SDZlRlFyLzk0aXNa?=
 =?utf-8?B?ek1ITmFudSt6Z1lsMVpLYlU0YXN2WG1ndzhCa0VkYzRoNFQ2a2VCWGJ4NTdn?=
 =?utf-8?B?dlorN0FFSXh1eU0zRFJ4T3VDWmljNWdyVVVFN3ZWYkNhenhzQ2lyTUNTWFRX?=
 =?utf-8?B?bE1GeVZIUHYyRW8zU0duYzB5VVlkYzlub0tmSkYzbURGTlJwTXZVUVJ1OEN4?=
 =?utf-8?B?TXRMUnAwSVdXV2RvSFRwQkxXZk0rbkZkaTd2eW1lUmZsVDVya3RyQXNzbEN6?=
 =?utf-8?B?RHZRa3p6WjZQbkcxcTlXTXIzT1BqTk94a1hsaHYxZDFTNFd4WWw1Zmw0MDVX?=
 =?utf-8?B?RTNTVEwybU9uRlhOalA2Yi9EQ1YvSmVmb3ppdXp0bENEdWdCa0NBM1dWTGlx?=
 =?utf-8?B?NzgxU0VlV2V4SXFCenZyT2RWVENNV1JGaHRuU1NnZ3RyOVJhWFc2VUNqOGlo?=
 =?utf-8?B?OGVoM0s2YzZudU9NZnJVTVExYUdLTzR6VkxsOUJIaTluc0R4SG9GaUliL2dR?=
 =?utf-8?B?M1I4UEthaXZodGRtOWFjY2xDdjJ6Q3U1WUwvUmlmVnZaR2tiZEhkWW9OM0Vl?=
 =?utf-8?B?bjJ4dmJkUVEyYkFydU5uTll0UHpycjZseFZSMnNQVnZEbndSZndHVEliam9G?=
 =?utf-8?B?TEt3NFpnV09qWUJ1bml4dFp6NEFYR2FrUnliM0dwNDJLbUx4NFE1d3hubk1S?=
 =?utf-8?B?TCsyNndpUTdQYVNHR3VQNWJnL0RDbXgxL1ZNZDIxUjNNdG1Tc2FGeFBYVUNo?=
 =?utf-8?B?UzZUcFk5ajZ0Q0RvdGs2YlFDUUZpN2lqbEVweEZFNXVLUCttdzhXSldMKzJ1?=
 =?utf-8?B?MmNpREFZN0RYUVY3OGZsYTF1R1VTUVg4U0c0bUJFc3I5ZXM3WFlTWmdLTnVR?=
 =?utf-8?B?UkFDa0RhR0JCYjhhTTFMYkdoemJnSkxDdkM0aUVXNTdFVkViL0RwYm9Xa2JE?=
 =?utf-8?B?UjY1cDBZZHZ0ZU8yS2NJWmdOL2dqM1V4MTc0NWt3OWxNNDFwWlVTM0J0TzBF?=
 =?utf-8?B?Qkx0TXAyV21vUHNpQ3c4aEZocDJFUjdnL0dQSkVLampuTWc1UGFiUlp6amhO?=
 =?utf-8?B?Y0dFbmNScjhKYkU5VkJsTUdqR29tTHU1QXlYamViYmEvTTA1VE94V29rMzFy?=
 =?utf-8?B?TG8xMW5FdnZOdlMvN0w3QVF6d1RnVVJTdm8vZjBnVlM0S1dKTGZlWklhRWdw?=
 =?utf-8?B?UTlWWk5HcEQ0b0NIV2UrMEJHVnRwTUZrSngzRS92Vm90bzAvWTFzdkMvMVJu?=
 =?utf-8?B?VXNnWFV1QVdFVzRqTTFQcXhLSXFzS0xEUzQyeDdjNW1zMHFIWWFVTEVJSVgr?=
 =?utf-8?B?Q1BuUm9BVUdZTExVRE1lNXJESHpCSStPNFdqRzF5TGx3aFhqT0Z0MnJXeDl4?=
 =?utf-8?B?WHU5cHRaTDh1ZW5aSTNweFFEY2pWa0dHVDFLZHNuM0ZsS0VBUmxuVmpUcGp0?=
 =?utf-8?B?ZUFaTTVacFBSakhSdy9yK01heHRaNStNcnRNbnd1OWtudnVveW14WmNEQTBw?=
 =?utf-8?B?d0xLVjlrRHhQVUVNSFVTWHh5ajJqeVVQVjJZUnEyRGVQd1U3R0xTNG5McnY0?=
 =?utf-8?Q?PfIE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b9bd5a-c8b4-4ac3-70e6-08daf497dcff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 12:23:51.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjBnCMwR8hhm/aPa+Wm2vYaYo0RXdZ2VxmTl860Y96+yGKi7q4IsyolmAwvbpfzm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> You tell me please.  How has your testing gone for 6.1 so far?  Does it
> work properly for you?  Are you and/or your company willing to test out
> the -rc releases and provide feedback if it works or not for your
> systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
> anything missing in it that you feel needs to be addressed with a newer
> kernel instead?

We have been integrating and testing 6.1 on the Microblaze, ARM32 and
ARM64-bit architectures over the past few weeks.  These builds have
been successful and we are able to run our regression tests on hardware
targeting our FPGA SoC devices.

We're continuing our tests as new updates to the 6.1 kernel series
appear.

Hope that information is of use.
Kris Chaplin - Xilinx/AMD

