Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963EC6D6DED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjDDUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjDDUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:20:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500830DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlBUdRuSNDbQdj8bSKQXicY8jC63NSo43tRzmxUzQasSR3E+Uxj97KkJXOk0DNT9oE0FWnsjr6hAKR6xOxIZYdgQwszxMgRrMQvzw+RDxdTLgbR8JpBTpvDTP2rmENwTByKcJy40xDULEyA3ifK2oCbvt4riDyEVjOZ/iVKAA38Vo4LvM5PWIRRWVsl83PnnbQxx67ZIOnXeksZ1Io6VQNIxAai6hBWpr7C91bA4RcIwqXtBMfs3XNZL8k3KvWhAwYaopMCWFht6VokSxdsOmMB4kK6/dFBcywpEoeChKO3ZupSiSzYoTVdFvFFLyC5+e8bBy8sE1zWpcGz2H1PY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20UgPcU2pb/xx5Vo094FQqjsQo/3nnhP2XZNvlo3bsI=;
 b=RQhtzo0Rm1oGG7TfE1h0lFJsdsqjKVUDqdwDkrb7YV+cnT3ikSts9jO0pp2Z/X+EYx5XREplIf3H4VilF2JykbyYsACQcvtkkGWhRLBsk/Bwh/u5b5QA/W8T95cSJPK2rvXz1bxTKFZEoe1GG8pyJxgYJZlWLrE09t4Z+3KFqU8nGHXOeuXPoIqL5cyNLdOfkLXSKNYsRSdV/ttrquKVWfCK1Bamwz3MhL0DqJtSrBV1aapMNX0hqvXtdx5Y9bAN3KqVoIApO6ize0C/Q7E+f4iXhcWEGYT3Rxl5+ZxQ0v9uanUnzHOg+piAOyj95U9HtPwZskm5sE0GVt1BEQ1W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20UgPcU2pb/xx5Vo094FQqjsQo/3nnhP2XZNvlo3bsI=;
 b=Y5+7SHMaBvtCYJypD5CPTYuJa009T4R1BwXPQhg2u8/uLuxhavHSrrvNl0tfr+NL/Mz1j+XVP0rsVrQayL2iv/7OB5D2bbWjXLNRnVCPC/Gg5FqftTL88ikblycWmNfpedgbV3NRHXXJN/nSfX/JzHtbMVMU33Utle/fcacNOBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 20:20:27 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 20:20:27 +0000
Message-ID: <4731f789-9753-287b-0d31-00ae90ea8ee3@amd.com>
Date:   Tue, 4 Apr 2023 15:20:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/2] SEV-*: Cleanups
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230328201712.25852-1-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230328201712.25852-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:610:57::36) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4c4cd9-8fb8-48da-6b17-08db354a0749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZBnIBmvvys1Pz97FVom1PP5FteN8PARAdAOANPeTVk+cwWUfrGRo1Piv7Eu9ZorzL6lqrjnMlqMXNegHWrjcUS3aSoy7Q9M52TJ5CufdCbf0x7mFO/2MUZXLws8CKOS72NABN7ChJ8EA1Gg7r+ndvS+hdEhmNPpL+tASwxso247swRrf0amOj0GgD0hAwGeCIwuUVWwarZbInfEpKdVlfiyyAOiUUNB59EtoFF7+ECgC1l7XSghwN7oeVBgZIPsxzRmjmzorG1/cRd+JxSjVQDs9rrNdNSpa5207UQCGlu9SlC+X5PeVdjDHo9S9B0qrMuzuqxvFYzRl5Kr/g1woZsDp2kUMudyQZj37m/348ZNjX6XfQq9c8zJAcqJUY0nqdceuEDOLm4NdfIX5c6ObILdMQTMNJcUVbFp7vg8L8rfZKDwVgjKfvURrRnM9gughdqn0XHr1QqQDqZSLvhqXbxMM5dBzTuJyIXiB2H/sqx8NNbNf7B/mYiUqQfGBaiFAdftCEbXWi3/OdYZWBdn4h3xz8IGKtIKw+6m5U1d/ahikrCx1w+oFxiEuTTDTX4mfQ8elPxTCix0VY3ZlBU65etfjT1vs0o+Pylo9gRM805jJRb/yztBHhNjf8bX+opwE6n8CmKwh9SVhLQiFNLIiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(2616005)(86362001)(31696002)(36756003)(2906002)(31686004)(966005)(53546011)(6486002)(186003)(83380400001)(6512007)(6506007)(26005)(4326008)(66946007)(8676002)(478600001)(66476007)(66556008)(54906003)(38100700002)(41300700001)(5660300002)(110136005)(4744005)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JtTlRGR25XMzZnOW82ZytLVkJVSlU3azZrK2VHZDdRR2ZJYnNpbVBLWUVO?=
 =?utf-8?B?anI0d21HUkJ4clJWdHdCK0VRWjJmMDZmOXU3T2hkeTJQN1M0YVZiU0oveUhI?=
 =?utf-8?B?UDhpa0lSN2xCVDFaeExhdDdsTDdHVkszU3VCKzF1bjh0dTgvUEF2c0ZRWllu?=
 =?utf-8?B?Y3V3dzNPT25JY0RQL0JxaURHYTlvUy9OR2NvU3BrRHZFellnRjZGaHF4K3Vo?=
 =?utf-8?B?bjdTaUNwWG5GRktHZVhieTdDMUdNNTlPOVhtbS9DQ1QyRDk2UnN3RjZCQlJ0?=
 =?utf-8?B?bmsvQjF4VE9aTVRRTDh0azd4OGMxeUJISGJZSExTYVZjZXRXWDY3R3dnQThl?=
 =?utf-8?B?c1NHMXpiNmlaRFpOSytHTFZLNzRrT0tJWXpDZC9VREwrWDMvNy96MjVoMVpC?=
 =?utf-8?B?M1VhaDJ3bS9yemhJY3BMTWNOZ2I2bVdCLytvdGRLTXZhZmV3bjlQWkp5aGY5?=
 =?utf-8?B?MElSbDBBOVdDc1B4VUNLUVJrczd6NU13UHJvRnRrNWhVTS8yb0JGdkJYbHRn?=
 =?utf-8?B?Z1NUemMySG5yNWVnM1hHcnpZZ1hjbXJxVGJQQW1MaFpRakpyL3EwODhadUF1?=
 =?utf-8?B?Zm03aHRYMzdvdkYyTTBTQ3ZkeEhMWFBuK0RFZmtkT1ZJOGpjcndHaUFZY1Z5?=
 =?utf-8?B?TDJHZnVmWnBGRmtiZ3pEcU1MdVNaeWdNeDdzcmJPNjhjWVoybjU0UFNzK3BL?=
 =?utf-8?B?emR3R054cGN0TWJYSVQwTXJlZ1A1SlNiMnRaQTNJaU5PRWJJVEJMZmM4TU5u?=
 =?utf-8?B?UHIyQkpQaDZEOFlvQ3UycEhFRE5ESmhhY2laYUxMYi9FTHNVZmJuclJtN3BW?=
 =?utf-8?B?cGNhelVyeS9QZU5oN3VwUGI4MGVRU0ZKN2xLOXphVFVUNUlCU280QTFCSCsz?=
 =?utf-8?B?R1Bxb2hWaTI4TTdvUmxkZ3BZWnBBR3hOK3ErQXY4VTIvV28ya2gydzVrVkxM?=
 =?utf-8?B?d1FWMDBCNGdIbW9PSnduWWJEaUJtOVU4VEJqMVVTVXRTdlprbDM0RGNXZFRl?=
 =?utf-8?B?MmQwMlJqUWN5UGJ3U01pdWF4KytTN09mWlJQejVEV3ZTM0JxUkU5V08vSGJp?=
 =?utf-8?B?V3pNSnlJd2tFS0lUeFhzcjJhbTlUejFkY2l1Kys2anNQZWc4WjB2QWFzV1pP?=
 =?utf-8?B?MG9UbjE0ZzNhWTQvcSt6K0RrT05BNC8rY2NwL2VlMkRBSE81dFpxU2p1bFkz?=
 =?utf-8?B?TWcxajhJSlg1aE9ZSnhKZHlmcHgraWxrc0xOTjFRQ2c0eGE1S0FCNmN0aHkr?=
 =?utf-8?B?REozbVB1RjNvT21lOWdEN24zWXFyN2F1SGR3UGFPOEFnT0hNMFNlcXd3OWZI?=
 =?utf-8?B?QXFVRkxNL213MGhxTGViWGVqSWJOZVNJSHlyMDZrd1lnZjFnbGhMbXFVUVY2?=
 =?utf-8?B?NGZEOThpbWtTWm5VNFZ1NnNjSm1OVkJyNlhhRVJ2dEJiMFBzdzc5KzhhQjhp?=
 =?utf-8?B?N2U1VWNNa09zS2ZVUCtqQXJiVjNCNnd5SnVIbmhsT29WQ0xKYWFNS1hTOU5w?=
 =?utf-8?B?RGJlZEYwNEhYUWxkYzRXOWFiK1ZhWVdwUkVCdXVEVmM3dHRCbUR6TVE3WjdT?=
 =?utf-8?B?NVhGakRINjl0ZmEyTmdQakZvSXEvdnRNRHE5TzBDM3AxQVB3SjF6cDE0QlNE?=
 =?utf-8?B?ckNrZmZsWUhYbm9HZDg5NTZwOVpjb1YvYklha2l0c3lCYWNFd0N2WmR0cFdr?=
 =?utf-8?B?RkkxM21BOWhHOXlLK3oxMU84U04xUHYrbUxzWFFXMnptdS80VlRPSlV2Mk9L?=
 =?utf-8?B?eHVWU1FrbGlCQy9DZlRUVkJSK3djUkR0OVNISXlCbmlGWWRRbjN6b25CZ0lX?=
 =?utf-8?B?Y1B0QXZTMHp4RWlucnNaNE9DQzQ3VUgwWlVsZGtJcUY5dHhmd0JlZUkzNnlB?=
 =?utf-8?B?SGNkSjVhanZnRTJJRjN1cjR1Rm9UK0RJdllBcEQxNlRrbHdzeFgzNFlXN3J0?=
 =?utf-8?B?UGxtemlud0pBbnVOZ0U0MjRjS0kzYzZlWXhtWldlZi9objJwTGpDK2dTQklQ?=
 =?utf-8?B?UHVoRk1mN0VOOHZBMHoxdmsycHNtUWdFNkREelVqeDl2ZS81YVQ4cHRLRHZR?=
 =?utf-8?B?ai9oT2pyTzFDUElrWEJpVHV3enpjMVVFK0cvc1NjUmhSZ293SGMxaXV3VS9H?=
 =?utf-8?Q?/XkshApGrjrmnDyG49VG1Cyic?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c4cd9-8fb8-48da-6b17-08db354a0749
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 20:20:27.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaUegIKQw0KMeMGj12SncGeJfkLa5LL1PEVI4IIai4IzIRRHEK7loAc3k3c7+hrFM+jRiWg/XpRCHrVJzCs6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 15:17, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi,
> 
> here's v2.
> 
> tglx says it is better for cc_platform_has() and descendants to be
> noinstr vs inlining it as the whole code is a bit bigger for that.
> 
> I've queued the export of cc_vendor already so that the parallel CPU
> bringup stuff can use it:
> 
> https://git.kernel.org/tip/5ae57743f578725a5dadb6f31d7798ee55e6e967
> 
> Thx.

For the series:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> Borislav Petkov (AMD) (2):
>    x86/coco: Mark cc_platform_has() and descendants noinstr
>    x86/sev: Get rid of special sev_es_enable_key
> 
>   arch/x86/coco/core.c       |  8 ++++----
>   arch/x86/include/asm/sev.h | 11 +++++++----
>   arch/x86/kernel/sev.c      |  5 -----
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 
