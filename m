Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985D66E503
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjAQRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAQR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:29:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C74C0E0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:27:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng4XcYWHa51vb4A9KxfsU0wk9I87uyLmHO4ujV5w4hFhbuppLcDjyMe2+zd6PIiLrVEZK6xehYabqF2p5rcvUtLv5JvvwXHukB70vvlqoyFG7oxGsrg/LfwRgI753GqOg0DfnzYNOTBZc2+Acxk2YyBfEZgaeAjgqAFAv3yLALzgBx5ONDv5dlhVgU7TPQMD4OVP+iD7s5h48cVBLLRIy3KJETlqph0lhmgA656Nu2mjHcJiECyevv7nC1qUPe0St6bF9nwYrtg4ZhNmiQwGmLEb7Y9ZSVYpN2hvEByU4nE8q0u49eO7pdKxDOAjZ5A7X6st9k8Hb+qxsluueAmLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkM29EBIUJuOZ0wG8+39xQ0ddoL5/cguBi44GLRhV4Y=;
 b=OMBetqyqlmd9k0R6PDnJN9dOgqt8odBu4TNsVSRbUmZ6fq4usY59GPNbToDHAy3dbEjFyE3w4214nu7nxEJj171M1mfo3UVTCL+rHu6dDOWnwaoxcP5CPY61/jkfcLSRTx/405UFjVo0S3xFXNhGjND/SX/HdplTIMLD8GWKfAUoXCO4MBhmMaHn28kyOhI45/oslNRqJnoarpv08fCNjmN7+7dhuId+zZwA7De7mVie8o25Qs+J0v3tmFwsgW4HALBn6re7hlhS5JT0cZmf6XevjOIMxDZtO3TcPs7zTXAWVm1lyoWEqwq+8KSy48nRowaJkAwt0H2Ld5XWrqXf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkM29EBIUJuOZ0wG8+39xQ0ddoL5/cguBi44GLRhV4Y=;
 b=QmjOoSxQGuirCdVMDFjAg/SijU+HcFMG0LR/t4jYG/UHW7kGRPhoqTVpGzGqfPRamlZmsHNE4b7YaqzhDbnJSlQPJveVvpLhKjFUn8tYIbYouJRXMXQQhu8mkpv7TxociYsVuN6vlQfgiqN9608Qe2UxKkeFfdoMpfGRymph9g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:27:45 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 17:27:45 +0000
Message-ID: <f32a336d-57bb-7b0a-6adf-be731cdfb684@amd.com>
Date:   Tue, 17 Jan 2023 11:27:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] virt: sevguest: add CONFIG_CRYPTO dependency
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
References: <20230117171416.2715125-1-arnd@kernel.org>
 <bce8c402-edbe-4ba2-9cde-1a9485255c02@amd.com>
In-Reply-To: <bce8c402-edbe-4ba2-9cde-1a9485255c02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:610:52::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6e4130-b1af-482e-4c84-08daf8b0253b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCpsbTd77mSvCDny2vzUGXRUsOjEBbsAwHHMvMtAtvmeij+vCZOcYeGNQmoTLu29pX1qtM1STg15Iv+1PPkluWyebUWZTq2FYBH+m/+k6Wn+LvTk4Ww2tV7danGJJXCcazu3uroUtjWMQuUQTtXRjIxbalSg+VwxnyeCqn7m+M/J8bXWDwi3Q7xIXohVLlr+JYEysc2KvieyWiHSyIdOyCOJZmD+h5Zz2+kSSveHNVg7hbXh93RNbVomPoFBZTntzRR8yClBo2xLokjVBMGDSi1i4VbO8OqNoeswkStimd3SEqr+X1ZVzDm5J6/5npZMSsiHzBeP9TjzpCIWbtXXcN0DyVoda/zc3Io0AELbjHVaE+Fa8HP+ksxxpXsEYExgpSANoFbVouCej7bf0MWa9jRL9e4EXkFhUFyGCDuFyCtCHztxOBQ7KWTEtdXAASvznN5eH0EAX+2XcyzUHKuB44EMiLhJL/czMtLKv3lTjCI4PywKrqJVCwDAjM67lqZq8OgqZs2oux3tG+ULyGUE5pRtL5z6FwGtdtLEAVQBLqBfI3UfBpixsgilsxut8c77YAPLtH4Wilt/p26URw2IyUJOssW24q7/hWbmXeCDjEaxNc6VKg3eB5SLZnYqOCOuI72yFNbLd1zKlTj0T2FFoeZKhwRhcjreFZg4Tjv7za4GUfo8SwWyb0x1BUncXf+HXaA/ZTKM6b9Ur6Z/EAEnWlu3umy9RE5QpaiR7mbrTIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(31686004)(36756003)(38100700002)(31696002)(86362001)(8676002)(66556008)(66476007)(2906002)(4326008)(66946007)(5660300002)(8936002)(83380400001)(478600001)(54906003)(6486002)(316002)(110136005)(41300700001)(2616005)(6512007)(26005)(53546011)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGh5WDdYamNESE1GTWJhMUtCNzE2OEswQ29ySSs1UXhjNW9uYjkyRDA1Q1lK?=
 =?utf-8?B?Mzl5TGNKeXJNNXdCTi9aUys4QVovV2kyZGk3Nm5acFZkTkNQUnRtb244YkVu?=
 =?utf-8?B?SFJacFJQSzEyS0xyLytHQXBzc0JPcHpiL1VvSmtSQi9ad0lJNkZNZHhYTk4v?=
 =?utf-8?B?Zys2bVpwWUVqd0xIT2xuVnJReTFBNlQ3MDlPUk1kTHdzdldqODhwOTVLaTUx?=
 =?utf-8?B?elY2VTh6T2g5R3VxUkYySzhqUEUvRmtjYi9ZNzAwM1hEcGg0bW42M2lqWk5s?=
 =?utf-8?B?eDFZMHM5RXQzQzJ5QXdrc28rQitpZ2tqTWRFS3hQTmt0c2VHWU1IcWxDYTFy?=
 =?utf-8?B?d3RTNUtyaVJ4MGNBYmxmQXlKM0xiMmNpUElTWU92YTRsTU1SR3ZPTjZEU1Zw?=
 =?utf-8?B?SEE4L0VvbXp1NHdPM0RPRTVxckZWR3F5Z3A0RGJHL3liOWtQZk1qSFZrL1hN?=
 =?utf-8?B?YXZOdXZWOVVqM1dialJzcTVpU2J2ZGE5cHR2eU1xS2pZcWtUQlQ0Q1FrRDJs?=
 =?utf-8?B?UFhPbVFzQmF1ZWNuTEFQQTdjRTF5bXptWkREd3hjTGJtMGkzWC9ENjY3MnZW?=
 =?utf-8?B?VXNKUEtoVnlHQ3FraGp6ZXkwK1FkeHFMbzBkZU9MOHFaajNCbzZFWFI2YXNu?=
 =?utf-8?B?MDR3blBNTTZTbVlkVjVOUVVjNklsVURUVWhQOTNmR1owcElPVFM4THZzcjlV?=
 =?utf-8?B?THg0TlRqb0tMTzN4ampGTEZzaVUwWk55TU9paE00M1NDL3ZyemVrTzRmSUdF?=
 =?utf-8?B?Z1NsOUpOUFByb0U0ek82RlVLVE1KQzFvN2NMb2c0bDFCOWhPbXlFN2xXSDJ1?=
 =?utf-8?B?VTFyNTlsbW5wbWVtUG1CUDlHdW4zQWx3VHVNN1hsSi9teXpSVDlvaFZIaUNk?=
 =?utf-8?B?QUVZK0V0MGVpMTFLc2FsV282SnoxYmorZ3ZTS3RLOUZ0enhJcDdCZUZEaWdI?=
 =?utf-8?B?NUpTSUNxODRtU0ZoNTI3MlM5dHhoMXRja3BTa2RCZDkvNHdKa09RbUY2Q2xL?=
 =?utf-8?B?eTBnMFdZSGd0NFN1eXVndkg4Wm1sN3gwcDR6SnkrQ2Uwc3VDZVhTUGMyMnAz?=
 =?utf-8?B?WE1ZMFZhdHV4a1ovRkt1K2d4OEZnNW42U0U4YWhBcHdtOUtyNGl0UTV5RVA0?=
 =?utf-8?B?a1RyblIxNEsvazI5ZW55VDhKa0J5QldtV2RJRkd1ZnBrN0dEN3UzbENQSmVj?=
 =?utf-8?B?dnRRU0ozZWgwMjRsRlVBN3Y5cTZDTHBJRFJ6eFQ1aHlmUUFwMnlrZVIyZWFJ?=
 =?utf-8?B?OXF1dndGQlNhL2ppVEttU1BZYWNaUy9aVERQd3p0YUtlMUU4czZKQTZjNGdU?=
 =?utf-8?B?RC96bTZZTzJOcGViK2pKb2JKd2IwSEFTSVdWSk95OC9rN1ZhNFRwdzlvR2VY?=
 =?utf-8?B?UGJVNnZHcHBuZEdKdW40N1Y3aWZGR082M2dSSkVrRkxlcVd2NkpHekF0SFA2?=
 =?utf-8?B?a2puNTF5RElTUFVnNTZSYjdUcTFqVEc3MHh4dW5XcURIem95ckdQTFk5V1Zl?=
 =?utf-8?B?QUo5M2ZJQitHN2NLSHJyL3RDemRZbUhHajlZZzJTSU1WMExuZUIzdWI5MWNx?=
 =?utf-8?B?VDFKajQ4RmR2d0VtQi9vcGlYdGxBYVhDUnNOUDk5ekkyY0RnVEo5cjRVcjQv?=
 =?utf-8?B?WS9yMURDeVMzV2hGTkh6ZkhGVStuNjhRNkFxV0hlMDJCeVJLME5sOGI1R0J0?=
 =?utf-8?B?NG9va0dQbWErNDdlZ2RjNDBESXpINzNSQ1ZUbXdVTnkvUEN2NHB4WTRoKzIy?=
 =?utf-8?B?bWt0cVRGSE9IcEdnaE5PcklCeWF3N0FZZUtaTS9pZkp2TDJuUEJ6QTVOQzRI?=
 =?utf-8?B?NWtCaGNRakZqaGhIUFhUZW9IM0NRM01TcGpteGhYM0k1SlpmN3hGcnh0M28r?=
 =?utf-8?B?bTJYN3JJOXI4TmZnNG8ydDV6OTR4cXM2cVJmUmNLVm9TRVVMR05BWjcrMW04?=
 =?utf-8?B?bkFtVm1xZEtVeDUxUjVqQVJYczZMM3NYVTNHSnk5aTlUQTlkQUsxTy9IZTBV?=
 =?utf-8?B?NVdCREhaSFdXZWFSN25oZ0UzWjRCNjA4dVFFaHNmOGZJVURDZDBIeUJ0Zk92?=
 =?utf-8?B?bFlCYm9KMkw0cXc0Y2s2V0w4Vnh1ZGtaZWxQc1hkTllCUzR4WEFJZ09ZeG5S?=
 =?utf-8?Q?mpJb7sqpQDFhKem97CyF7Wu/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e4130-b1af-482e-4c84-08daf8b0253b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:27:45.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rooWO02pJC4tMSo68INSR1TCV6vSxP/AbbiYFUwbJd+YizcslpIjvIMopr/UhOE5amSXV18aKTdb3Ykn4o7tsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating email for Boris.

On 1/17/23 11:26, Tom Lendacky wrote:
> On 1/17/23 11:13, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This driver fails to link when CRYPTO is disabled, or in a loadable module:
>>
>> WARNING: unmet direct dependencies detected for CRYPTO_GCM
>> WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
>>    Depends on [m]: CRYPTO [=m]
>>    Selected by [y]:
>>    - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]
>>
>> x86_64-linux-ld: crypto/aead.o: in function `crypto_register_aeads':
>>
>> Fixes: d63670d23e60 ("virt: sevguest: Rename the sevguest dir and files 
>> to sev-guest")
> 
> This has been present from when the driver was first added, so I think the 
> correct Fixes: tag should be:
> 
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> 
> Correct?
> 
> Thanks,
> Tom
> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/virt/coco/sev-guest/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/virt/coco/sev-guest/Kconfig 
>> b/drivers/virt/coco/sev-guest/Kconfig
>> index f9db0799ae67..da2d7ca531f0 100644
>> --- a/drivers/virt/coco/sev-guest/Kconfig
>> +++ b/drivers/virt/coco/sev-guest/Kconfig
>> @@ -2,6 +2,7 @@ config SEV_GUEST
>>       tristate "AMD SEV Guest driver"
>>       default m
>>       depends on AMD_MEM_ENCRYPT
>> +    select CRYPTO
>>       select CRYPTO_AEAD2
>>       select CRYPTO_GCM
>>       help
