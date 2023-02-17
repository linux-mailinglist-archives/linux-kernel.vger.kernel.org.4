Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A869A823
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBQJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:30:54 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A660A63;
        Fri, 17 Feb 2023 01:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBNFkOOuM8J7ttPfaCq482JHjI2YSYWzt8HfrGTbv4vOw4nDa8iwmERZa1jB+R/ytFHu7dX2sfymHGcYN8K/SxIoRLKeGiIScxOJI/Y1OelNMqVyLISzSG0fKKJdwtcAPEHCQGn0ST0fAffmpKjV9p0qaY8B381tbqCWm6XajlNqN6SXfI3XQbOKHiqPUxXdOLAhyBMXg51EmoScPbOHR8ult8VKIb7PSqqE4LH2nZVM4Ewe50OMmE9+Hy6Too70AHXmJIyEgkHMF6+VmGi6GFUTrFkwAhhdq1thq0xc/sjQd8Tc6hcaYSQbIepx4cUGvxsaLVOMPdOeMNEfPt0imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dscn1Qebj18hxDcCHA8rANNejYb96ndU3e5O8OB3zSc=;
 b=OQt6YJakC/NrfWusjfufDKKghzc3Ih4wNnBiPeTJM+Ekev8q8J90Ltin4J2IeEyaQHy+D5GwQ+hj3auq5ryhELSYJnL1ZY0PUzHc15F2Z/OIWLSoRcM5gh+OJbzJOMUaybvM5RzASMdmxakilmxSD5nKtIrD/JXU50siw5lQw6d0K0kz21d8D7uZZ7y6BYplqh8EAa26HVS5gTfNHPBtbMNGeroQrrlpZcfJyHy+JkbStfuEKaxn+w4SUWGfdxv1BNhkXvEQF6RDt7qZJu0XGqB3e+TV/V4dJ8cXLZFVzyCU7mMhkGK6bkELcnQb57sE9mAL9ZvUreES55UaNq19iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dscn1Qebj18hxDcCHA8rANNejYb96ndU3e5O8OB3zSc=;
 b=ElonmQNmznTq8H+PhkThx9BqQS9h8Fx6owewHz8wPDJmsQEKwWH3YcgnUbuyal9yVuFmtli5F37jq35jP5sMfDh16MgDtPnzoradLtM+88mBoyk4ilt8IsGptOkIIlUULC48tsz2LugulPra/dODW+leiELaL5GIaq2T3I3k4wvWbLKzx3YGSs7OYAANsk6AF/skDW1YX/Bld7iEJczJWcMMPwJJ64tDkvwTlUavtf7MKtg+LyiziKf0E69RFgYBe+pPVzzpWoqJguTB0H5ED1b5Dl2X/D0RSno87GAhhlCWhsDA7Hcgq5tqkR/lOu0bf07/otvCLbUGKXsnlkeWtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 09:30:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%8]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 09:30:50 +0000
Message-ID: <f1b1c2df-b88d-e668-fade-ca0ef74e7b07@nvidia.com>
Date:   Fri, 17 Feb 2023 09:30:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch] [tegra] Remove unneeded version.h includes pointed out by
 'make versioncheck'
Content-Language: en-US
To:     Jesper Juhl <jesperjuhl76@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <8611b610-a21b-6037-52ad-9439c4f44995@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <8611b610-a21b-6037-52ad-9439c4f44995@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdf199a-e617-4421-1db4-08db10c9a80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny2ph6xjiPW0ufk6XxE1k9gKaFZFqkaZ+QrfT9RumsGpa7ohxMRWsA3fJEZrL1eIpaJ7FoOH7GU5LU1xpSAg6FNN8ntg6duXBgfehgqs5wDorG076bzEQSslk111pnIrIgEpNCQRShMu0ReyHZHyBzshfe8JFDf05D3BYY5pw7raGS3YOSMwULLpvWlKbxIiVLupvxeY9ywUAPmczhUIR1otkpgQs0DhWL7Uh7g4HSLHeSmc7+eoCFIxsgJ8CDcQp3etr4ZVbWXzQ7ZHPgMcotfIaot520UsbMEQ7szU7lvF5Ttib/5tJaE3X/0fBHJOOMO3ZMy+Xv7QUxoXT3/UpINO7OUA0d6a54KkZ66EbvWPRBu18HNov4bJBv9BBF/etLPEZp9qHMiQH8K8CcPCrRsDVKO7UPqc6WtDFrxvQ1fGMnNPqUovVrFXZmVoEnm7nkBqXj+tBdmCQWK2DQ/KN7vPd4b3JqZ1Z6ZWlZ1Aqz1H2ONVrIidraF76Ti5L8gZWwNJ2+JcBPCZdVemAYKpzLwTGNzkvf1Sne1wP3VoO40H8ON48yortlDwQw74OsS12TH5WeOvo9rCos+UXX/DIvZONiEW9jGbYwakyWhSBfS9t9kygxsWxyWn4SMGcPCTv+bQw+d6qNl4B8wK5TeEBEcLBdLjw9yaxRQydsZ2N6PSKyM/nO5UYhwFeGO9b0V5gwSwp341V0KmWobMDYiq5RAFjRXGzBA9m2JkUa7pxlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(66476007)(41300700001)(66556008)(8676002)(4326008)(66946007)(316002)(31696002)(36756003)(86362001)(5660300002)(2906002)(8936002)(4744005)(6506007)(6666004)(6512007)(186003)(53546011)(31686004)(2616005)(6486002)(38100700002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a056bmtvekJtWXk5QWh2OEUzakdydVlzTGF4UmJlS21vNk5mbEkxVkYvOFBt?=
 =?utf-8?B?c3Z2eDhZSGZSbVpOMTY1emRRWkVNUENJcmF5Q2VXbTJmY0FnYkJ2ZjZLSVdL?=
 =?utf-8?B?dC9PK3dtZG9hbi85dlFJQlJqV05OeFhOZ0VvK05FRWFtOEtZMU8xckRRaGY1?=
 =?utf-8?B?SHBYK29CeDV3V2xxczhrakdjR0t1aFlEVElLRnhJcjFIK1gwSDlpcDVJanBE?=
 =?utf-8?B?N3pSaG9XRzZ1cWJZMGlUaFplYVdHQi9xaGZuME1wWmhsTzJzV3FhV0wxRHBx?=
 =?utf-8?B?S0o3TXlCVDJsQzhNM2hEcnYzaDdkRTIzTTNLYTRxR3RuWTA3M2pZTDZReWlk?=
 =?utf-8?B?cS9hdVRmUFFvM2ZGUmhIMkNCVkNVb2dOYkszWmNRazFSU1J0RzQvbzZ6WDJp?=
 =?utf-8?B?aXZ4WnpPUU9yOStramhlN0I5WGxacW03Qi9uSmtJdVFlQkZMV1hkdWZNK1Zl?=
 =?utf-8?B?NEZEbmpDMVRFczlSdU9mcFM1dnIrZ0l2Q1VGWW15ako1UUhqb0FXR1ZTWmZy?=
 =?utf-8?B?Y20wV0NLQzgxdXFma09ISktqU0JEb0tqaHJyQUJBa0ZtV3BJQ1pZbGdGRmNo?=
 =?utf-8?B?NGJFclFXdVZDa0xTZFlLQmxyT280eERUZWJEYnE5U0FPeHlPdnJiL2t4dnI4?=
 =?utf-8?B?djlBRm5iRWJYa21acEhuM3JpZ2NkNkpwVjB0M1FSK1l0b2YvQ2J0bXpCbmlm?=
 =?utf-8?B?dFh5RnB5ZlA2TW5hbG8rd01qSCtLMnhna0E4VDhJUFBsbnU0OWVrVW84K3hy?=
 =?utf-8?B?YWZYYkJTZjhOV0xPeHRFcGh1YW5melVnR1RFbXY1RWw3YVhadnh0ZUpMREZM?=
 =?utf-8?B?TUFEZjYzTjhzaEY1MERNY040YjlyZjVHSDBpdFZkbU9rVWRwSWRxcEJudnIr?=
 =?utf-8?B?TTloek0vVW5MM0V6Y3pUdVd4U3JNZCtEMEZ3V2c0KzlCakdwU0xuRTNDY05F?=
 =?utf-8?B?VmR3d2dLNGlVNHRkWkRuN0xqYnF6eCtuWS9nbzVlaTFQRkRLd3ZCMGlCSVBz?=
 =?utf-8?B?SzFVOG1FcEFtRUZxKzFDZGsrTlg4RDJGUlE3Zk9xbDVlZ1o0UVdoS0QreVZx?=
 =?utf-8?B?NDZsRUI1QzhvUHlZcWZNT2FIWUZyMVRsOVRKY1JOdk9md2tieHhsZnZ2RzU3?=
 =?utf-8?B?dk5vUUFtalcrRTJWQkxRRDhpNW10VW9DOWQwWnFBK1JRNWcwaXlvNjJEUXRp?=
 =?utf-8?B?cjJTOENadXliTXpLWngzckdITFFna1lTS0YvckRSbW9TSW5rbnpVY2svWXVF?=
 =?utf-8?B?MGFvRzBBUnBWWFBxRnQwOUdIWWEzWDNOZ3lhUzJtdWk5cVprVjRnMFhSNUZj?=
 =?utf-8?B?RU5iZUl2OUcvcWpTRTdsWkV2aVd0UW80aE1wQ00vMVloVEEwNktWTUtFbkZM?=
 =?utf-8?B?RXdYN3M3anVRS1psL1ZWTTFQU3pSVk85ay9xSmNtOEt1cjBVdmdybFRhUTlB?=
 =?utf-8?B?NGFRT2c0cHNZZU9OUG55OUkxOHIvRUhBZWxVL3IzNDhpQnhRdGZaaVV1bUtP?=
 =?utf-8?B?RHJ1ZkdQV1M2T0sxeEp2cUZmaEE1Yy92bE1uajhYdVZwU3pvclpwTmpXRHZU?=
 =?utf-8?B?VmRoVXk3NmxIWkQ1ZVZTTDBwZ2MvdXZmNjVHekJUNkNiQUJuRnQ0QzJSTlY3?=
 =?utf-8?B?ZjZ0bE11cTdSR2ZCVXR3dEI0NkZqNXQyUjlENmJOQ2t5Q0k2eUFxOGFCOHFn?=
 =?utf-8?B?eHpsOVQ0YmNFLzZsNERIMndla3R1QVlUeGx1cGdoZUNHazBnWUhsVndwQys0?=
 =?utf-8?B?clRYc0V2Q1FLSDRWK1NsditXUDZxYmdHRXU1Mm1OSVUyVEsrNUl0QkQ0S0tN?=
 =?utf-8?B?WFkrRTQxOUh5blhWclR5eWlHbDVuWmZqU01PMWt4aW84SmRkcXBlemw0VFNn?=
 =?utf-8?B?L2d5U2lENG8vdEtyZWpDV0laOVd1R2t3TFdTaXFQQUJRV2E5VnJuWjh6RVJm?=
 =?utf-8?B?VW40enEvd0tYS3RwSXEwcUNyblVFU3NYZlBxUGZla1FNcGhIWlUwZW5ZWmIy?=
 =?utf-8?B?dm9tTzU2Ky81SDlTUkRFRWx2bmd5ZE41SDhLbEU1dFg0eEFIaTgxUnBNSmxI?=
 =?utf-8?B?b2VlNmZmSjdTNUo2QzVoWnRUU1p3QkkveG9ITHZCZVI0ZzR6dzZWY0pLZkRx?=
 =?utf-8?B?emZXMHlMVmc1UEMxUkE0b1RKWExjWjlWZmhlT3VaK2k5VmYwcjNkK1o0amVD?=
 =?utf-8?B?b2oyWXpLeWdmNE1TL1Foc3BkWmFnT0hVTmRMRncwS2kvdFR3WkMybk5XVWVL?=
 =?utf-8?B?YmV1c2FOcWxHMUpmWUplWjZteWhBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdf199a-e617-4421-1db4-08db10c9a80b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 09:30:50.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0MX7E4n35Acpuc1TBPZjiCEZvmPPlmSAKj3ZjIB59MnPulAfdkyr4UQ37Ij1ca4DDwYDCkhzlCAd/cg8uDUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/02/2023 00:53, Jesper Juhl wrote:
>  From 7264ec7d00ece4b56fe9fafa3237d4870cbe6785 Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Mon, 13 Feb 2023 02:49:50 +0100
> Subject: [PATCH 04/12] [tegra] Remove unneeded version.h includes 
> pointed out
>   by 'make versioncheck'
> 
> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>


The patch looks correct, but there is no commit message and I am not 
sure why the header is in the body of the message. Make sure you use git 
send-email to send patches.

Jon

-- 
nvpublic
