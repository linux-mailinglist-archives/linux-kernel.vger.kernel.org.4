Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA16BB65F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjCOOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCOOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:44:12 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F61305EA;
        Wed, 15 Mar 2023 07:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5CiISJOr8dRe1uCR6X02hTrFwrPG6G6x73CNYwVV93u9spdRicSP6ugWBns8xGys9skXauXKtvhAocUBQdxRAeoSOXZuQ1LOYRUEqJil6MEqBkZBdVCVEuhJ4RYznkWlmMGrm+hJn/Y3varXfypAuB+zvsIa7KqtE2xRo7rEkHrlqY/C+ajacguo4T4Kw0qFgnIplEejAh5UdZ0v7mtbmNefd+tQV5BhvAU2Uh933Tox80N+kmvPTaQiFrmvxmpN34YELbLSWyXNCud0aT8zudxl+mN3tzlvE3dGP/FC/sT9XFgeky6Jqe611xslfdzVW9tOXzytJeHWvq7P5NJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw/O7G3vr86lmK7Rht1WsHlEP9j1hh2kZdVYD6+kwrg=;
 b=espzktzU1wthaqfmeiHMWTqQRQW0nwkS18+QZfxBQlGeMeAyhtvuGwL9N8C9uw53n6ra8c9/2MgJtRaR62ivdua+TtFG3q5rV1dvz4qXUJtDngsh4aUoHMTZB8PgqHGlp6DfpLeMxo/5TYq9ttZZ20WE4ztOnlvvFWjItsT25b7K377cEbbJj2xcDfCPSq4h4+xBYKoly0NUnHr6Pgw2N4qE4SwyTydTTvrMWxBjp/zuWIYZnzXPUc6yADaGfgtfQajwHKtfygj8d3bag7LtqCpf+1x9fqvSQThiq9sGDD/+pQcSlTXf9KAceUpp40yEo+T6Y8z2BmHoICaC5D1Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw/O7G3vr86lmK7Rht1WsHlEP9j1hh2kZdVYD6+kwrg=;
 b=VHa6B7cKjP1qsRALnNnQRBapbJnZPPAg7xiHn8e/KFMdgejmaVDWulrvSw1Tm3C4PkvrQk+UY5b27eiFwFeNycOrgm4TYZntVXefUmCeQPRafsIQe8ksK9hMnbxS+9PyKL5rZA+uxYL5VKmx9u30SqKdNFUxqDEFfNnS+rRhFx2zsRCXp7haOE01zvnrGPq4YvDMDsDV0QJArtzK380iJSwxNSoA9IySsV/LG1XnFVdN/BpCv8dxxfZAlKKKN6zG5z3l8FTGPAbDYOC4JhvVLHACDviqkoZBk1Dak0sp579a1qC8bf9CJT88RmPwQo6KEi45OvkZwD9Pewf2xkpliA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DB9PR04MB8282.eurprd04.prod.outlook.com
 (2603:10a6:10:24a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 14:43:57 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 14:43:56 +0000
Message-ID: <18363c7d-ddec-df1a-8a8e-dd5321499545@suse.com>
Date:   Wed, 15 Mar 2023 15:43:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 12/12] module: use aliases to find module on
 find_module_all()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, pmladek@suse.com, david@redhat.com,
        prarit@redhat.com
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <20230311051712.4095040-13-mcgrof@kernel.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230311051712.4095040-13-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DB9PR04MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: cd541198-e6b5-4351-82d1-08db2563b463
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APrMxr/R80d5dr5I/qw7BHLWN6d6yMyq0b9pgc6vpN3/QNIBfE0lyN8RBcisbcxbF9VShdyIDTssPSluS2zOpyUxeRvhGHrUXPHGXOm4vCSqwLfsFaYmPw9nmB9xx8hvrNiGSC1tLtv6663rNisiW9DusHbbKbaZQ7LcM5TPAwgZrw/1mcF01EiRbtaR/5nu2zsY4+/uGfixv5wYIUCiDryqV/RnKit8Zm0YVUgPgd7E2XLSPBUYa17vzDLK3ztKw88SQB+GZNhPoslSPHVpUBP9bmZorQI1C2+1Yat8p99Xo5M0FACghQkJ7OXsVE+TxeAshyC8Q0kG3OuQ+aw299H4ahISlG8LMrvRdxr4xLtY7/p0DxRTBPUJokHBAOCx2E6LE1gIgYOY9+qPHXOAPdkqNSRQLwZw792QgT7m7LCKqqZShDiMVOhTD34Zx3kaOk56S8idMrz4bQJn+A+wypu8j9lH24raOklYpJPYcCyLHv2dnWOvWu9psMuQvEYWRgasNToucIG68cjq0S/YJcLxi6h9FPUlkR/KjJshEDmwrMe3zQN1fEpPUfw1NdHVpj9anWKFlk81+cUBzoz4vtSe9s64WKDLz0trNAHU11bqTuoSll50249C6+eBbn0viJBx3zngLsU6VQugsMgtEmUKLQ2Tj/XmWhEoR/xuItmyjpe/tYgAFIr5Tk6l1rbxrrcAYeqMJGodiU9TodgJw8ww/pyi+t/BTuIzWwDzhpp8BGbG1KLs1rNAxTCYP1I4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199018)(478600001)(4326008)(36756003)(6916009)(66946007)(66556008)(66476007)(8676002)(38100700002)(83380400001)(44832011)(2616005)(6486002)(41300700001)(2906002)(86362001)(186003)(5660300002)(8936002)(31696002)(26005)(6512007)(6506007)(53546011)(55236004)(31686004)(316002)(37363002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVhYWtZK2I0MTFpNG85aXNPRDdVUTFNcWFaK3oxZHdSK1FQWHJ0b3ZSUytu?=
 =?utf-8?B?NDVlNlJ3Y3QvTnRPMnBmVnp1N20rbjJQNTJuTlM5dlNVU0cwY2ZGMFNYVFJY?=
 =?utf-8?B?RWNrYjVWOFkwSkpqS3VZN2NGRGJTUGVLUjl4d2kwdTcveW43YUlYNXBIYjk3?=
 =?utf-8?B?V1Z1TkpHaGthZ0x3bjNCVGZNbVA5dUVkQnN3WnFxcWFnbEVYaG1JelBqa2lZ?=
 =?utf-8?B?NEhhOGtQMnAvQTN6S0JTY0R6SGdXY1hkM0JLeEluaGovcWsyYmR2eld5MkVp?=
 =?utf-8?B?M2xPdWVvVzd3a2hhOUhnbS80dXRWNjNSU2k5a1FXVTlVeFVNRGpLOVJHMXU2?=
 =?utf-8?B?Vml1UGo4SnVIbzUweDcyMjBEWDc5MCtqbDU1ZmpCbWFmZGRiUVZRZFBKKzd1?=
 =?utf-8?B?UmszeXl6aWc4UW9MMTFSVXBQcGFzWnJwa0UwZlphR0poanVWM3ZrM0kyNnps?=
 =?utf-8?B?NkVrdDNXcWpKODJCTmpoMFNEMkU2K1gzQWw4YUpjQytVZHRMamx4OHcxOHhQ?=
 =?utf-8?B?NkpHTmd5U3N1YWFIZWtsOUF1OG84Q3Z6NFJvbDRnMDhTSUNvQTFzMHA0Mm1t?=
 =?utf-8?B?ZlVmU0tuTXowL2p0dGFQSmxoa0FvcCtmRU5XUGRXcWxLNVZpZWxBa3NuRUZk?=
 =?utf-8?B?endxWlNZQVhVeEw5cGtUc3c2akloU1Fka1JyaVE3R2ZhenF5cTBMOXdVY0Zu?=
 =?utf-8?B?WHY5T3FPeXI5ZkpqbHYrbDQvMjgwMTRyT05ENnJNNXlJS2ZId29lOXc1anpJ?=
 =?utf-8?B?cG9OcVhCS1pLSXU2MENmMUdhcm1HTThsQ25MaXJmYjMrVHdIMitGd1lFOHEw?=
 =?utf-8?B?djFPV2hTNmxYVzYwMGtIWlNETExTWmI4OHRIYjlQTmRkbnlRcGdiZnlieFRY?=
 =?utf-8?B?cVBlZFdXRzhSUDZjaG5FUWRNMHk5TnVsMEdZSGNBSHBPS1c1UW55c1dyWUdT?=
 =?utf-8?B?aThFU1hOa05xcWxLT0JrazI2YnA1eHh4enVEbU5uczEzVHE1U2l2NmZuc2JP?=
 =?utf-8?B?dTBpUFRITjliWHpJOFFVdStCbVQ0SGNUQlkyRk10bkh5YzRiSDNCeFlXNE5P?=
 =?utf-8?B?UjQ5SzZmQzRsOTdlVmpVWWJhZklQVjh3eHVJbXlVanhXb3dkWVMzaFpaOTRt?=
 =?utf-8?B?QUhHemgwZXVPWW1ZNW11N2xBdFpQcmNUeU5SM0FHTzlHOVdCZHBLQ2k2aVZG?=
 =?utf-8?B?bDFnU3JUejM0Y2cwT3ZHSjlZN2twU01ScWVoQ2JyRGk1Y01CN2k1b2hWdVZH?=
 =?utf-8?B?NWFuVmU5L01OZ0l6WGZVdjBINVc1RENpUU51bkZoK0dlT0E5Q2RMTVpPV2hW?=
 =?utf-8?B?dG4xb3N5Ull0THgwWEFCdERXRklRTnBCTWV3YXFVMUtQeU5odXFDRjlRd3Nv?=
 =?utf-8?B?ZE05WXhuRGdGeEY5VTBIYWZ2T1FDd09HVTdnYTB5Mk5mSFJNMWxkMTlqU0F3?=
 =?utf-8?B?aXE2akVpTE1wR2dGZUwyODNNQWhwdFJmWFFhVXZNUURZMEluOThYNnU5T0ZM?=
 =?utf-8?B?T2lpUE8xM0RYMWhtbFdiOTIxNEg4aThRZmVuMHNqdFJ6NlY2ejVKVUVDeW9X?=
 =?utf-8?B?UHovNzZyRllvUzZONUZKY2RuVXJDS0ZZL0lGR3ljOWZOUHZvczVOWVVCY0Rt?=
 =?utf-8?B?NnZtSHp4QWMvWVZvZlF6aXpZaUp5Y1lyQUZVcFVJbDJUZUVDdWE1K2NoNmNv?=
 =?utf-8?B?YUJaWUtOM2wzTWJqRnI0ZVI3dUVlNzVWTXZnaUlOa2RtRWlwRkZqbmVrdzB5?=
 =?utf-8?B?WnF0TFI3SzNOc1UyQjN5VVhJZWxZTXQxWHRMVjNkWVRhYXo3S0JEK1kvSkJC?=
 =?utf-8?B?cHN1MWFDQ1RSZUYzWjhKMWpRUTcycDVBVWdPQzQ2WkZja3FRZkJWYTlJSmpV?=
 =?utf-8?B?bmJ1NzJ6RWs0NGx2K2dyempOS2h2MHJzOEV4SDg3WjlNVnQwTTE1bHZ5SlBn?=
 =?utf-8?B?UCtLUENlTExMa1dZTW9GZHdFcEdOOFoyc2JpTGpkNjJxUmJLRHZxaWhBV2w2?=
 =?utf-8?B?UnlYaU44WDduTXBXWmNPOURsbmhWTFI3NHExK0phNDZ4USsrRktPY01WOEdH?=
 =?utf-8?B?K00veEJOOVJzU3c2Z3d0c294NDlmVy9HeVZIT3RuS2ZQeVV2SUNjSFc0d0hO?=
 =?utf-8?Q?6lA3Du/yVHYXOeSQeoJzG1Uf3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd541198-e6b5-4351-82d1-08db2563b463
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 14:43:56.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2//nq6yocW++NC+O2J9Pmoh05b7JNT83aDh3zFm2WieQgV9X8DCEQ5QtLwzmhlnYu+0l7Zr19ZtemsotDzAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 06:17, Luis Chamberlain wrote:
> Modules can have a series of aliases, but we don't currently use
> them to check if a module is already loaded. Part of this is because
> load_module() will stick to checking for already loaded modules using
> the actual module name, not an alias. Its however desriable to also
> check for aliases on find_module_all() for existing callers and future
> callers. The curent gain to using aliases on find_module_all() will
> simply be to be able to support unloading modules using the alias using
> the delete_module() syscall.

Different modules can have same aliases. Running
'sort modules.alias | cut -d' ' -f2 | uniq -dc' shows a list of them.
When a modprobe load of such an alias is requested, my reading is that this
new find_module_all() logic (if enabled) causes that only the first matched
module is inserted and others get recognized as duplicates, which doesn't look
right to me.

In general, I'm not sure that I understand motivation to keep track of these
aliases in the kernel. Do you have links to previous discussions that I could
perhaps read?

Thanks,
Petr

