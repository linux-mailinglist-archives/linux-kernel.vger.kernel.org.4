Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725774672D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGDCNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDCNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:13:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F844136;
        Mon,  3 Jul 2023 19:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh8S4F6svWE5rENxKMniPiteuWzYuYWSf8MInig4Wq4AQ0z1nDSRpuP/drlvLTPU4l2ay2Kmeilvkfd9A/jhpjOfHzpLSRCn7m+DWac6stAQ7BE8dCCKOBLqFR3Haywv0ZMpDroJaF0OLv8AKP4Kyz5ggseDnYhuFoepLxhnTon2sHm3P2X2uiMhp/SWlXKWbGSxfGVcf8ZlCAmAgUz68z10cHmJyaZ66v08+6ZBmKYCRP8cOpZIg3hn54pH/aTIPERbr3cSAK0RMFvKY4nhq8LoHfvEmK1v0kRYxDxFmAMpybnpa7jubPRv/xTmZW2o9aO4dSYzqcn7Knvr8SR1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za0TqwrSo3XFwWl3/SZkEf/b5/OMYTmRuXsLIs4ykF0=;
 b=GE2E6+noDbVNCj8xB/HQjfCtsnFwwTpXmnOdybcFoc4+8eTE/UyOaynCOAYAc+wNNvoYVQt9NDyq2eGvPTR/OJZ3rayRPzyvVYvA47pi0mU74OUNZJ83I4W+NMteVdGaBe0uUPaQAcQ1peNb6n2jgkp5I7S5hoOcVnAq032B87MOrvIJ0S45NyWxqSUKfzJSUWyqGeHeMbEMd9W5hDQvB1UQuIrkzBC91EujVspMr7pWwq58zV8WMN7Hcq97IuUP54hlfJvNC/Sol10+V7Hymyx2vtIvJWjUyDvYKAt3XDaO303zpyzOB9I5O8MlKDkiYbVxF76rAhdDPvDA9ULvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za0TqwrSo3XFwWl3/SZkEf/b5/OMYTmRuXsLIs4ykF0=;
 b=LucvA9s8fSHeqDwsyMWA4E75bgFh7YqnzkhNC6g9eNbUxjsksOLU4S0yMMRg90uc6260p1HMfcNLdBGYmkNHdy48BZtkPPNR+B+uTLWZEKsTNhh1a5Wj/oKoXbHmpImhEJY5rPvqkU/YUVrQ1QMnSFP/JQ9YgVV/wnaGAuTY9s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:13:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:13:12 +0000
Message-ID: <1149e5fe-2106-9b8d-d104-6668339d30cf@amd.com>
Date:   Mon, 3 Jul 2023 21:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] pinctrl: amd: Drop pull up select configuration
Content-Language: en-US
To:     andy.shevchenko@gmail.com,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>
Cc:     linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-3-mario.limonciello@amd.com>
 <ZKM-U3aXGcXEgPLZ@surfacebook>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZKM-U3aXGcXEgPLZ@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:8:2f::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 59124eb0-b4f9-44d4-db3e-08db7c34380b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +15kn2i0vf5TS13WkwqtSSIZpkMo/Z8YVCyyNMbNcKo8K3ByksEhk4XHNrJNUCDywKTLX3hf9IFySvSPN7lh/Ges3UIQ7jRsqkRYiTLijJyY6bsHB7CRLwScn+CGetHvYIvmSZS+232xCIE1w8IumzTbe5OyRJ8hW4Yd+FcETkRD/YwuTv3bm8AVFwBtAyUhfHYtED1U89JnCdBSdF4inOfD0fkFQTnV3pABPTiQb2RttcC4b8ByrBjuAk/KM0vwrj/UzpgpjX+vDfNDKHkUhajyR9Wbth6qbP0HugdvCH9XeTMmEAO6LwcX/bNERCBI3cx2cEbOQUql/HMZ+++ol0UdF5gpog0mQeO9Zv4xe+HHB+l1YPB43tLvoHioD+5Dloa0hmkYtrImO7SASFoL8kepEe5MwC5CRICxlZw9r8DvROQmOvcVuqCFqnExKt8RELA/hvyeD5At1qJuqBhWRRMX8CgKH1h7fG6O1n29e4qK+ZYF8Ai6V39tVQvWi95QFlk4xyNlSGXGK4e2N1RGKc8xwy/SLhsLXXiyB1v7qLZQDvenKQuj9ELsrrOrvChRBKEkp2fdCu0w+iIbr4m+YGKYEmbZFsf62mzsygmVEKKXVZiTESSW5VveFFhUutc0Sz2+KL27tSRTEW8tEhOYMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(2906002)(41300700001)(8936002)(5660300002)(8676002)(44832011)(36756003)(31696002)(86362001)(186003)(2616005)(478600001)(6506007)(6512007)(6666004)(31686004)(6486002)(53546011)(316002)(66476007)(6636002)(4326008)(66946007)(66556008)(38100700002)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHpKL2s4WnJnT3BvZlpUWWhLK1FRVFJCZWFnaHFobFZLOWxQUXNuNUtQbk42?=
 =?utf-8?B?RDIwdnhWK0RIM1BqaDdyckJDQkpCdXAyZE9HeXBRaHlJd1hPOHJtM0RHK2ZL?=
 =?utf-8?B?emJRQkxrM0FXcWF0c0swQ1lGOXZheEdLQ2wzTkdiODNkK2lxTzJRSUZ5VWxj?=
 =?utf-8?B?a3pIcnFUTW1FYmtINFFYeUdTSnpRY0FWTisreittb2pMaTVhTnIwVVU1L00y?=
 =?utf-8?B?aGg1NGtJSGdBbExob3AzdzU2MWNRT3NYV2hybDZWODRtQmxTT240cE9rZVhZ?=
 =?utf-8?B?aHY3VTVERndFemlkUUZXUWx5WWhVUUtkMjE4dTdJenVCODU4Qms5TmI5a0Z2?=
 =?utf-8?B?a1BzUU16NEpuTGRqblNXenZJT2dpeHFteXhxUkdzM2I0TGNKMnA0YTRiOFgz?=
 =?utf-8?B?TW5HY3pjY1ZzNGlKZlEwZ1llWlMvbXBuMCsxYk90UlBuTXc0K05zSVEyOCtX?=
 =?utf-8?B?OVhiek5nRVFuOHdnTmF6NWtWeEpjOWZRSGRFTk9pZ2IwL2V1NW05SVQ1ZkRZ?=
 =?utf-8?B?SURmMUI1Mmt3QUtPYlF4Ujh5R3VhdnV4ZVFESGlzamJpMUduT2xLQ0RxL2hm?=
 =?utf-8?B?TnpEYUsyY095TUk4cENtTmFMeGVqTC95ZUc2K2s3L2diSVA3OEh4cnQvSC8y?=
 =?utf-8?B?OHBkTW4vMFlzNnlVRXBwNGU0Z1YzWmpyNmp5aUovbFJHcnBuaGZpZzZHZ3NH?=
 =?utf-8?B?WHpON3dhaXRWYk9ySzZQMEZFTlQ4RllsRXBoaUFkSkFYVVpKR29sQzVzcUkv?=
 =?utf-8?B?ZUprbEFxUG9LZEtGYTl0YkZBZzFPSjZ0bnIya082bG5IMXQwdHFUaWxscFF4?=
 =?utf-8?B?RVdQWElGOVFuL05GRXUrMXFuNTdnb2lobGZGNTRtNEV1OTRLTkN3YS9pZnRZ?=
 =?utf-8?B?Mk9OWFNxRUdMUnlpcXd6a3QvMGNTeFp0K3NCSFMwLzRXaHJENklTY1N6bmtT?=
 =?utf-8?B?a1BZN3BKVllZRitWWHBsbi9kYlpBelBnczJrZFFla091c2JWQ1hCYTR6VExa?=
 =?utf-8?B?NTNLbzZIUWNMWExpbzhoQlFpN2xPOGxkMzRvRlhjQ0s5T1kzZVdrVGZPamdG?=
 =?utf-8?B?bHl3bmpqZllWdHlLdFFUVXAvUlZJQXhQQitzSWdqM0lseTI0SmIwbHFwZGNq?=
 =?utf-8?B?RFB5UUppVENoZTdtbkNRaE9qdmY3WHJEWFFwYlEyMzZDek03VFV3eU1JWmtv?=
 =?utf-8?B?L3Bob3NWaEo4cmtLUys3eitrMEVVZ1dsMkxGMjcyOXgyQUNTUFhueE9lRjNW?=
 =?utf-8?B?MkJOYmxBOEltbzRlUVdCUVI3Qmx5cUU3OGJnV0pHNFJBc2lTSk9BTmx2WG83?=
 =?utf-8?B?OWpBc0JvR1BMRmZYcVlKNkZ5SnRrREY1ZEk1c1Q3dVdqSkx3cFFXZVlJOFAx?=
 =?utf-8?B?UUtlMmVYcnNCVVdLWCtpcktPaWdNQjBqQ1R1NWdaMzNuTkw5Rlk2RTlKV2lz?=
 =?utf-8?B?TytKbkgrQXJYbnI1UUhGN2tYOUljUFJhRTJ6SHBZL2lpcDVwMmlTQjhqUm43?=
 =?utf-8?B?TlhtaTNSMTlyMWNoZGYyRXZEQzFwdFIzdUUxbnhEUnpXQ1I1SFRyOTk4elEy?=
 =?utf-8?B?MzRoS2drSzlRQUpZNnY0M1JsZVpMQUh2b2hXbkNWOVV3dGl6M3RYMCtHYWJl?=
 =?utf-8?B?V1BwSmFTQWx4TDJYV3J4WmU0VjhpbEFLdHE2T2NnTUNDRmNFRk1oZS9tUlVM?=
 =?utf-8?B?aE9iZTdvWllVcXRVNUhGNmdzK1o1SWRJWXF0LytlSmxqWjY4ZE04QzQ3VXgr?=
 =?utf-8?B?aFB6RXFqK1lOaW42WWlYWTJTS2Rjem1aQUVnaXdhVnJNdTV1TjRLV1Znc2ow?=
 =?utf-8?B?WllyMk5HUmhIM2hNUCtBQ3lvdkh2T0lLcTl5U2NHNXZGT3hicDBKQnhCc3lI?=
 =?utf-8?B?dmVHWmVMV25aZ3RUUElsOW84bmZpcjNDeGhycVlRNWdIc3Jyc0hFWEUrS0Jz?=
 =?utf-8?B?MUNML3F0T0UxZWt1blU4dG1tR1hXaHk2RjBkVlFwVExRMUxhM3l0RVVSM1dt?=
 =?utf-8?B?RFI3eGpIYmN6YlY2UGpHc05BaDJ1ZkJpb1NTTi9JSzhVVGc3Y1BYVUsrMWUx?=
 =?utf-8?B?NXNMd1lLcUJOSmlDUmFRS2FpTWpIYVQ0WHpWU3RGQTBkWmhiZHE3UmtyL1J6?=
 =?utf-8?B?MENGK0xRYVpwSlN3enk0eGJBK2lnS3Z1WmtHZEhuYXJvVkVqU1dUdkhpNHhW?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59124eb0-b4f9-44d4-db3e-08db7c34380b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:13:12.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSUigBPgx5woiR6p80U8ao/2AEopiizVoUXKT8kFlzNKixqySLT9d1dYF0xN4Ltfe7YyspSfB4TX47JZ/AdZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 16:32, andy.shevchenko@gmail.com wrote:
> Fri, Jun 30, 2023 at 02:47:14PM -0500, Mario Limonciello kirjoitti:
>> pinctrl-amd currently tries to program bit 19 of all GPIOs to select
>> either a 4kΩ or 8hΩ pull up, but this isn't what bit 19 does.  Bit
>> 19 is marked as reserved, even in the latest platforms documentation.
>>
>> Drop this programming functionality.
> 
> Can it be that documentation is not (yet) updated?
> 

No; I double checked documentation across products from last few years 
as well as products to be coming out in the next few years and this bit 
is consistently marked "Reserved".

> Where, btw, did the original code come from? Perhaps it may shed some light
> on this.
> 

It's from the *very beginning* of the driver.

dbad75dd1f25 ("pinctrl: add AMD GPIO driver support.")

Original author isn't at AMD anymore, so I can't ask them.
I would guess that it was something that was discussed to be supported 
but never actually was.

Maybe Shyam and Basavaraj have some other thoughts on this bit.
