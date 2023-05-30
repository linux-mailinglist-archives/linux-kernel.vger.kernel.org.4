Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9D7162C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjE3N6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjE3N6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:58:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9978EC;
        Tue, 30 May 2023 06:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxO4UMgcOLjk050mPUQhay6fOLmsBkGSsDwk/HAG652KzC37/Sx+W8dKapgc4TAtx/Y1vt2TgynKOZ+HCSk/0wqgHHheSxduqCTfhUaoGZUXy+Ur/e6NixTcfW9gNq9mtzLUsDLgjwPvAbiIYJdlPEhg9CNqrKMlvj0bJ6Y/S7XDpy/SPf6qMOBCHq58OZV9Fbw9xo+8Ry+o+4EKGsCimyySb4R8JAMzGH5qkQoG1iNgCQFHpGu1aZSu+R5SZNpzLq0/ymQgr/ZWhNM46XnKtN0geXNAox5v1USXTbXJciRrxsplJRtS5puATsjJHkMqUpg6fQ19abRFwG94Grlo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZN+4IQbcpu4hokTBEuLcpuyGJevCYRM7v+j7M2BGLs=;
 b=OnnANaY6HnuQSh7pi+p4fUV0GNOzW5CsH+aY6mab7HEHN99cql+D9fhc+beUghC0jbXzyFsiqJw+re0tgAj7vTwMnOHhXeJIbD9iw2hq/N4/eJLcJ/jvpgA66GwqRydm8fJAt7WKtoAgWCtw7R7rGn/1U1XPJo+v4w095KiPJ71nHqgQsTVvsVtYRxGbvRwCQP7PQKQQp/AQ7wrKa+aYO6YxlCNDKSQH/2BiRYXT/NafB7SyZxGTtMtFQmvPSSMXsGvUwwMOBDFclHeSKmg8U6Y+7LJp5sNWxlHs5/PR77rz79IYxoltXIJPYWduLMq5koT8Mh+1b1wLv0P/O+XKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZN+4IQbcpu4hokTBEuLcpuyGJevCYRM7v+j7M2BGLs=;
 b=Ub82OC0knU9VrS8pEk/OkR1R638LyfTl6k5nGDVgz5yid/EIpKDzxW286X3jkNcnE6lSOykAH6BFb2NAKkTzOt9WCeYn48crYIZ0IlPrpYxXgwEv1yfvXSjWSlM5Ciwlzmw8gHBHGJ4uEudhp6f3rMV1v4AeUKMnOP93CiHNkr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2039.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.21; Tue, 30 May
 2023 13:58:04 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 13:58:03 +0000
Message-ID: <95bf627c-8bb4-bc11-79fd-f299e21f1530@kunbus.com>
Date:   Tue, 30 May 2023 15:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Wrong/strange TPM patches was Re: [PATCH 6.1 000/119] 6.1.31-rc1
 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        jarkko@kernel.org, Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <20230528190835.386670951@linuxfoundation.org>
 <ZHXUGdFMIcB5HL8s@duo.ucw.cz> <2023053014-sanctuary-attractor-13ed@gregkh>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <2023053014-sanctuary-attractor-13ed@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::20) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7619b5e1-a5fb-4901-6e52-08db6115e307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDmnSPRNS78LQ8e62KAivBRWPBFDMipJaLK210a1qD5QhSsipZ8vo91QW6xc4+vRDCaYr5V0NeYlhJ9lFZYFEkMqQjT39nuhrk6k8dSmkvCLMLuePZX6USmyI+1866d0kBEz2XRs6DVsWH1PYPjL+0icHjpCYPXDYZ3XmRU4G1uOkZilWhf06oa4kA8lO5to7nz9qlH3MtKroAPLif8noYPe7USB1GixeCRFS15Vstsg+Gysr1FYpKX9LqmBY1o9TJ4gmaaY2dG5X9sBS4znWXGLaT7pMtkYBiPXaVp9Ntgno6w9uMpn0f31UC/wv86NPER8FSf+awOxmq4hyCl+WVX+71HKunhPOZI7qeJ17ep2KmJMEgB7A9buzO2LfQ7Hp+vYYUwqyOXT20J+O3st6D0upFtfiv7AaWIXlT6fKwSzfYL91ANW9apTkdbvnNQjonsYpK4ZbkiI+/ug1wjOdPIrqNR8V53+IKUQ5OuKk6VONqYOR8BLM4LuYV1s3B9iLqJfEraDJMsZREl3gLb57d+xEo+4bYm+sMXMuZ45DkbvJMU1DHCs/8RY7x20B7gTPq+2hQhM0T2J20pIC2j0hSjn/tc08HT/2CmxPKlKtsSPSnmNR7CQUGl9xGK1hNiAeKXcd26vO3kjXtscW2GG/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(451199021)(2906002)(53546011)(31686004)(186003)(6506007)(6512007)(54906003)(2616005)(110136005)(478600001)(83380400001)(6486002)(52116002)(8676002)(38100700002)(8936002)(31696002)(41300700001)(316002)(66946007)(36756003)(66476007)(66556008)(5660300002)(86362001)(107886003)(7416002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJUZytkN05obnpBeEdVYm1jVjBQS0Z3LzV2MnVIcDZpL0NLWUxyakVockRP?=
 =?utf-8?B?Ynd5MGlabGVhT1VDbVArcnFKUkw4MXh5TTJhcDQvRXAyM1pXNUZRc01HdGh6?=
 =?utf-8?B?YWtkd1BUSUZFV2I2VmJ2SklzelV5NzJNdHhoMElWTGZJenZmR2Q4Z1FHRXNQ?=
 =?utf-8?B?aUlqbloyaU1DVFZVVmUwN1l4YVpuM1dkR1dHRVBxTmxqeVQvSmdSRWVUSURW?=
 =?utf-8?B?ek1jMldxVWNXUmM4THdaY2VaUDF2MU5sSldQYWxaNlFOaEsrSVl6YnlGWnR0?=
 =?utf-8?B?bW9IMUoxY1pYbHg1OXBzTzRnTDlxL0dhRW5zMW55NnhzTzBZNFllNjRyK2NH?=
 =?utf-8?B?UjhDam9hUnRERms1WGE3c1hlT0RHVHM5MjdUK3R3THJOR1RDS3lYREk3VHV6?=
 =?utf-8?B?YlJYWXpYNWJWYnJZKzVKQjcvVGlyQUxWY1B6N2htMDdPODlzUWg3K1JTaTlT?=
 =?utf-8?B?cExZSjlKcDROSk84YVV3clZ3SGhrK2dMMEVrT2FJWGh1dTFTc1ROVWp1RGdZ?=
 =?utf-8?B?VXdYLy9Ea0NWL0dyREJmbUpYWWQvdHhlZXROM2dBWllxdS94bXZqd0x0UnU0?=
 =?utf-8?B?TEg4NDNUa1RWNW1QbUdvc3REWW9iQm5Fb1NPOHJBTy9Fc0V2L0I2ZEJSQ2Yr?=
 =?utf-8?B?SzhONDRQdmZnTEg2QlhOb2ltcTUxVWs5VWI4cGxCWHJlYlVYOW5ZRitRaXZ4?=
 =?utf-8?B?eTA4ak1BZlQrc3RQemNiT0I2RTdKZmtVdVAxN2xRYzRBSDVXZWF0RzZDUFQx?=
 =?utf-8?B?U2ovNTBlN245SVZLQTBBbVIvL3hyZTRpSW5XRFpqTWo1d3E5ZXFkbVBDWjRB?=
 =?utf-8?B?L2VsUkd5WWlmY1lMdnNxWkQybWVUdjNnTk1TK1VObCtuSm1nbWo4R3VrVXhu?=
 =?utf-8?B?bTYrWWlpWk1YWVdzaDE5UEJBcHkxUU0rbWVsUVlrYTZJU0NMRnBVMHduVHBP?=
 =?utf-8?B?OGhnT0FyRjNoRmpIYkZZRGRYMFk4WHI3eE9HMkJZb1lyaEtRWG5oZVFFZFdV?=
 =?utf-8?B?Z01VVGNWYTkyc0tTZyt5ZUJ0VUJha0R0UngvcGZTL0d6THZiMmpUVUw4R1F3?=
 =?utf-8?B?NzJGMXZrcHBHa2swZ1d5eFQ3aGxlSi9pRUxVYVFSMkdUWHd1U0QwTjlsWVBO?=
 =?utf-8?B?YjNyZzNJVVIwOE50bnA5eUJ1bHVwMFVsdTNXbTc3aDBaSGlxVUhLaXA5YlhB?=
 =?utf-8?B?R3dDb0NMN2FkSFlQRk5rcVZyV2dJUkdqdWpWR2hKVWtXdjg3ODVkakNBdFBE?=
 =?utf-8?B?RGp1T2RMbXUzRnJ3emhKdDVCZzhxQmdLeTdOM2Q0Zlk4OFAxTWQ1NlFFcXNa?=
 =?utf-8?B?UGFHeWNSVjAxT0Z3N1o0eGZPNkt2QzFsQW1NbEpHWmxITERXbmNMYXlnK1Az?=
 =?utf-8?B?Szc3dlc5c2NmWHpUY2J6Y1kzb3J6U3kwNlhoNkg0MkFVVWJTcUk0TURLU3N1?=
 =?utf-8?B?OW1taGloeVJpSThhWXVDRHlYVE5mSk1zc3pIK0NCY2wwb1dzR1dKL2Y2dVNP?=
 =?utf-8?B?SmF5aU9POW01TFgwOEtoMG5vTWZNdlVPOGR0Z1hNdHNDczl3NFJrQkJDbGVR?=
 =?utf-8?B?OHV2clFlcjd6UFQ4OHhTdWVjczQ4bUlMdVpFbWRjM0VPUThXVm1lRFRlTU1O?=
 =?utf-8?B?MnM3RHJPYlg1ZGQrMVBZMTd6SHkwVGVOVzM3a1lZSVlFUlFuODU0UlhvRHFK?=
 =?utf-8?B?UlRXamtoeG5NMklNbzVrdFhqY3lmT3VucnZ0emdNcXBPdHB4VnhvSlBRSWoy?=
 =?utf-8?B?RmxqVWUvd1FPK0loU1oxZGNPTkJrb25vNEJwVkh6RDQ2R1V0UnhnMzQ4cXdT?=
 =?utf-8?B?Q3JDT2FCM0w2MmUzRzljbHVaUGhWamwyeCtHdjRNWDNHbE1ZUk1ha2RoREN3?=
 =?utf-8?B?Q3NPWUJ6bzBXMmIwTFFzNEw4TlpuMm9YTVpXbi83Zkdsazh0MnF1cWNSUHNW?=
 =?utf-8?B?dEpWMHJEc1BpMlVYWDNWeUFzTUphVWYrcjBITk1JUkVyeVhWdU96TmJrU1NN?=
 =?utf-8?B?U09vUFRaZjFJTHNCOUtScDBjM2lCZHI4RGhJOHJDV290dDMyanhSem45cWZy?=
 =?utf-8?B?WTVIK3Yza2phQk55Um9BbEpSVHBZaFRmM3l4VE9hb1N4SkNQWkJ5cEwycHIr?=
 =?utf-8?B?SmRzUnlKNHpIWW9JNENjZUtzdklCTzMzcWgvMUxvYzk0VzI4bE1RbE9VcDFU?=
 =?utf-8?B?TXhxQWZvOGNOQ09oZnV3OFJwWC9aaSs1RElBVVEvcHZveUEwQjBVdDRMbE04?=
 =?utf-8?B?T1ArR2lXMzkxMHRUQXkyOXV3QmJ3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7619b5e1-a5fb-4901-6e52-08db6115e307
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:58:03.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dxhPz3QUDAh5CwIbkZ8qvQP/dx9GW22BJyK4f7HMqlLW3ueyzm9pC/a7ZipJdlQ0gBupODD1LAi29WnvYdoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2039
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


On 30.05.23 15:02, Greg Kroah-Hartman wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Tue, May 30, 2023 at 12:46:49PM +0200, Pavel Machek wrote:
>> Hi!
>>
>>> This is the start of the stable review cycle for the 6.1.31 release.
>>> There are 119 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>
>>> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>     tpm, tpm_tis: Avoid cache incoherency in test for interrupts
>>
>> Description on this one is wrong/confused. There's no cache problem in
>> the code. Plus test_bit and friend already use bit number, so
>>
>> -       bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>> +       bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>>
>> @@ -87,6 +87,7 @@ enum tpm_tis_flags {
>>         TPM_TIS_ITPM_WORKAROUND         = BIT(0),
>>         TPM_TIS_INVALID_STATUS          = BIT(1),
>>         TPM_TIS_DEFAULT_CANCELLATION    = BIT(2),
>> +       TPM_TIS_IRQ_TESTED              = BIT(3),
>>  };
>>
>> this enum needs to go from BIT() to raw numbers.
>>
>> You can just do return tpm_pm_resume();
>>
>>> Jarkko Sakkinen <jarkko@kernel.org>
>>>     tpm: Prevent hwrng from activating during resume
>>
>> @@ -429,6 +431,14 @@ int tpm_pm_resume(struct device *dev)
>>         if (chip == NULL)
>>                 return -ENODEV;
>>
>> +       chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>> +
>> +       /*
>> +        * Guarantee that SUSPENDED is written last, so that hwrng does not
>> +        * activate before the chip has been fully resumed.
>> +        */
>> +       wmb();
>> +
>>         return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tpm_pm_resume);
>>
>> This code is confused. First, either you don't need memory barriers
>> here, or you need real locking. Second, if you want to guarantee flags
>> are written last, you need to put the barrier before the
>> assignment. (But ... get rid of that confusion, first).
> 
> Care to submit patches to resolve this?  It's this way in Linus's tree
> now from what I can tell, and these changes were needed for another
> stable-marked change, so I'll leave them in for now.
> 

First, thanks for the review Pavel and for spotting this.
I will send a patch to fix the enums.

Regards,
Lino


