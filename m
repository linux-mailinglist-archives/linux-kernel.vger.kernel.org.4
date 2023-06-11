Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78DA72B2D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFKQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFKQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:28:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181DE4F;
        Sun, 11 Jun 2023 09:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMMPwtGtKjDsozvFWgVbexszX+ihYOViVd/rJBJo0JmkFkAYHoqFuHhsNvCD5G/jP6Zy5WhCxqvkLZhrc+bvgixSHn1AsktQpLVGDkqmgyYW9xAMqTQ4saw4/G1+hjKYkt2A6gyZBE1H9rYQL/p9lFAKPCSSdH0t5I3kG+lRPgmbhxyJxCDGfivD05oLeK9NTUtK8r8AZdIPjnf0a6wJ2y/Pj4hi8ss1BwITVe/droFLSkhjEHIHMRfSCNDH4V2krsw5//S217IP08Dl1/84LTOuzNP3pLwyzH9sZikxlxVBcD4FbYFKWppAcHz40e6lbZi/hNErt9SXYEuMbYndIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lI5vw1JC1bXenaOyug9cXMy9rdm+NJy585SBe2S2wE=;
 b=KGzwtHI71El/Iw4+yxCRahp/lFhH6EStXkwhbA015UWkfeQXDs+OUUoCybH8W+jyTNLaDbWBSH7UMlZ0x6HUJmkcG09C4knlZWwxPNw3LCX6j6RfibLs0U/PX844I/ncPqAqQYLV2gh3CixkHsf0pcgg2ynXzd1k2rtQFq3lQGmhudhzDH2KD8gKWrNkM1COwXdHaCUOkA6jcHM4jRjni3uz3Ly2Cw/EnD0thP1ZwmtDecH1TbZKwShu+QX9Fu5ffINFMfMc0sCs1p4fjQC6me1qMDhsNoC0Y8X603KytVjpG6A4r6KCUcgQosNyQgzvMU6YzJLV6zZSO1PsPyK1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lI5vw1JC1bXenaOyug9cXMy9rdm+NJy585SBe2S2wE=;
 b=IWH7waIvfxpDCUbH7l4pjBg/Aquvx0MBcaNc1AyNwaUzMn63K2Kzdqtaf1wWi2e+9sVQrnQE9TSYRPom1kro4N4RNdQ6XldLWbzs/g5FKsVUDxx3SZ7DYRc9fZyEen8CLcGNEDBihi/0dI7gp4eZNKyxPFCbfGX+Svn28wbJQ4A32eMMTEYoOZ26+7UyUHqNpmolE4JZZRpu5+2Qig4VMumft4nhuPHSpWDiUpMEsKcnYe/eqcp3VBtRTaZApRYyjeuoCDpZRLoIz9CS+nctUTr3gp4ut8blsZhEOA7qJiolLjPVtZ+f88PT15i3ZHiUpG9nj9WTB2v3/XdbEs1oew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sun, 11 Jun
 2023 16:28:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Sun, 11 Jun 2023
 16:28:27 +0000
Message-ID: <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
Date:   Sun, 11 Jun 2023 18:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage via
 RTC_VL_BACKUP_LOW
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
 <202306111511569834cac2@mail.local>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <202306111511569834cac2@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 9109fe9e-212a-4403-39c1-08db6a98e252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nb10hbGIl6DKbBhRe/7DzYpqToMfix1ZrMEwcKtSFAfCAV9/iyo4qH0Fxn7UvcXd8dstG2qSr5XtP64j+RUiwK9/o3iPJhZmQOGX/A4SyQR7cZMT8ozO1kgkkPHYmcZrvcfJyW/K5VazW+mdQYFJijXVQgQrSbwJHcVqfxKILvPNEfJZiYbXFzVCaq4RFxCdpH49U0WBtbji8HhtAsU53oGVHbsFtx66oQyYR2juWvf10+KqRKWt72ltrEvSTaJMWEJ3ZNuL/C3GU5T+HDYNY++NGeYkMYm/RuKbXzmMjUNuyek47joAI7wCms9NDKPUHdAmdkUONCsGfVgM+10tlITUBJSXyzHd+IP044iE0ZHb+x4spqQNEcLifHmD3EfVeLf/wWVfiyjRr1TTzcKuYsnW0gvlgeVFf/3n+Ra+B5/Sg+L1pMigcZqLPMpPbpK9C2WNlR43FAF4/MviZWXYPf3dU3R/5k8gXvllji0yA3uQ6w1T5Ij4tU1PfHjcTuVcmhMd8Gf3p6bDe3r1C1B5wegV9pqaOgRBWXaIFgr51wr8vJk7Z1rF7HAu/JPiTQqkTPdR3U++xE55oDrwBkyj0YIBgqe7enHNm17FlglZ3mnuvpwkOLymtdc7S+Cassl5xX1rAlkt6GXnXdylx9vL6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(83380400001)(86362001)(8676002)(44832011)(82960400001)(38100700002)(66556008)(316002)(478600001)(6916009)(31696002)(66476007)(5660300002)(4326008)(66946007)(8936002)(41300700001)(6666004)(6486002)(54906003)(2906002)(36756003)(6512007)(53546011)(186003)(26005)(6506007)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJrUitqcGtDOHRJbWt5cmwxalorOU5vbFNJdnhQajlvazArK1RsQVg3b2hL?=
 =?utf-8?B?cXF5SkhBNGFSZFpTUlRkTUZsdDJNcFdSc3lqbzZoNVZmN1pDTU9VMjNMcmpJ?=
 =?utf-8?B?Q3NUeUZqSjB0YU9BZERsQ09ZZHJQaDBkTU5NSHBZcHBsbVlPczlBZndLL28z?=
 =?utf-8?B?YTcrR2tFSENYN1NvcEJwMjVzekp0VkhaZnlFc2tPS2FJSDVhMDdqOGFTKzZK?=
 =?utf-8?B?WDVqcVdsaTdvSGhsVlFiYzlxT1hRTTIyWHVPYzRNWWFFU3VyWGJwdDd0cUdl?=
 =?utf-8?B?UzdyZzh5dnp4VVZKc3l4WE1CRjBWUGZPN0tDMmNwUXpCK1U3OUpqRitkQ2Fp?=
 =?utf-8?B?WVM0R21GeElkdnBmMDJUZlJkS3U1ZDc4ZkREY1BnNEFBTnNySGRBSVlXOStp?=
 =?utf-8?B?VDJvbVNNbC9tcGFRejFZZkFsdDZ3d09TQ09EYnFDYzJMTkgraEZ3a2FCUG82?=
 =?utf-8?B?ZFFhVml3WEJwdi8wZ1NQbXVrT2pyWTZMQzRoazlCb0ZaYTRmZVZHVXF6ZzJ1?=
 =?utf-8?B?cW0yK1hIV280aW43cUMweUZySWNtNHdlYnZUdGxJTnJkK0ovZCtaRDdaY3VG?=
 =?utf-8?B?NmNzdlpCaFBicUNaUm1NV2JjRC9yMXNUNnVHcXdra0hMTVJZSWdMQ0ZJbzk5?=
 =?utf-8?B?MXZpWllWSEdEcjZWN0Q0bllrYU0zYUNEMzhySFkyTVBVR0pPMUxMUWJzcmhE?=
 =?utf-8?B?b3czV2xwa2M2U3h3V0pPS3F2bEhvN2N2RVZSaEo4TFBQY0lxdmJBRHE4Ynh0?=
 =?utf-8?B?bzRsRGFGc1JiSGxrKzFHd2FENDBQQ0VSTnZCMlhHVWlzekdYSjE5bUprMThW?=
 =?utf-8?B?Vzc2bzM4R0pzWjU2WW5kc2JpcjNoQ2VkOUhOK1RiYnNQMmE4NjFDblh5NnRi?=
 =?utf-8?B?Y2VpZHlwR3JFSFdzbnFWVGVIcXNXdEYvRks5cllTMmFFSzVQRXlnNlhTam9V?=
 =?utf-8?B?dEhrYUlPNTlJdXVVTWhab1FUT0FBVE9kdXdaaEFvdlhkL2tNckxYSkZYWkVC?=
 =?utf-8?B?V29EVUpXbUUwamZacFNOSzA1MWpZSnBGRFZZWlNjVkcxUUFLVFdCOHFoNnRw?=
 =?utf-8?B?blB1WVcwTkFyWlpoMDZ4RzVZWWZDVXIvZnBCbnZUR1kzZkFOSXREVHVoVlNj?=
 =?utf-8?B?M3VMT0ZZY2h0MXlla3hmN2lWb3R6UG0zZjdFU0M1b2p6bzRtSC8waVZKUnNM?=
 =?utf-8?B?aGo4ZCtpU1dESk1uNjJZQy96S1I4N0ZiOSsvcmxXcDltejhlU1FNeDROT2NL?=
 =?utf-8?B?TU9UamFWUEhYUFlwamFGSkFUK0ZKTVdqUjJaOEdRNjZUQUw1cHRVNDRiMnd6?=
 =?utf-8?B?K3pZRTFLSVBkcWgwRG5aZzA3NW8wWUxMK3hWbnZ4eEMvWnpiZDlFRkdBSXNW?=
 =?utf-8?B?UXhranJ2NVJiT2JHeWFQRHJIVVFDV1pLUjJIOWM0a3R0SVUxSlg5b21zTTFL?=
 =?utf-8?B?MVl0TlFMMG41TmRJdFdkQXA0M3BacUF2bFo0enE0YXpXZnR3Y2FLL0hoWThx?=
 =?utf-8?B?SVFXODBXdUZJYzNrc242YkhtSExGcjEyNlkxMDdCMit4aitxY3JVRlV3QnAw?=
 =?utf-8?B?ZTZXc0ZTcUpwenFjR2ExTEJIdGV5aEZDNE9wZ1cyMDJtQ2lPRXE2Z1FXclJO?=
 =?utf-8?B?YTNraktWV2dPMGgyU2lvTnBKdlhFVzhBd1J6M1d6MnBXdnJqRTFrL01CRkd3?=
 =?utf-8?B?K2YwbGJPcFZpM0U3RzJxZFMwNkRGWk9FcDVXTTNIZ1FtczYrZ2pvOCtnUnpS?=
 =?utf-8?B?Rzk2MUVXajBrdlNGTFpLMmhZNGY2V2ZMMC9uVEhsOG41SWxOS2RMOXFMSWRo?=
 =?utf-8?B?aTdFZ3d3TlIvLzkxbitjVXhRUjAxMjJKUHZPZ2FRMlRuWDBveWFTT0xyVlNN?=
 =?utf-8?B?TWZRYmRBSklVUFpSSUJuQ1BXMkdPMzNLL1JIT3VHVWQ2UU52NzJzcWlQajla?=
 =?utf-8?B?aVdSSk9uSUdLU0dFUkltdk9BeFBNRTk1Q3g1S1NIK3NHcklpbmlzampBT0gy?=
 =?utf-8?B?dlZJWkJQUzVtbVI4WHBnU0JwRlBDVG5TdytRaFJIaGVCdEZWL1ZnSmJOUU5U?=
 =?utf-8?B?eStLcWVFNXNNaTl5VTJpcEF0UVMvTGI2Wm1tSzdZelo0enJBRUJXU3grWkJR?=
 =?utf-8?Q?bBAO55DK5Xjg+AtjtAXrCAL6+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9109fe9e-212a-4403-39c1-08db6a98e252
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 16:28:27.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQGqhFW9XbR4uD+W7Bx7KNOudn+m8cOkD/aw1eIFhaBSbPOtHmGKLpP29QWlXrOpZBW5S1j7U0lzyyzroE0nDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6326
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.23 17:11, Alexandre Belloni wrote:
> On 11/06/2023 15:38:04+0200, Jan Kiszka wrote:
>> On 10.06.23 10:31, Alexandre Belloni wrote:
>>> Hello Jan,
>>>
>>> On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The VL bit in the seconds register remains set only until seconds are
>>>> written under main power. As this often happens during boot-up after
>>>> picking up a network time, make sure to preserve the low battery state
>>>> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
>>>>
>>>> To permit userspace clearing this state during runtime, also implement
>>>> RTC_VL_CLR that works against the cached state.
>>>>
>>>> This is emulating RTCs which have a battery voltage check that works
>>>> under main power as well.
>>>>
>>>
>>> Emulating doesn't work well and I deliberately chose to not implement
>>> it. For example, in your scenario, if you boot twice without using
>>> VL_READ, you anyway have lost the information. This makes emulating
>>> unreliabl. The fix you need is in userspace where you have to ensure you
>>> read the status before setting the time.
>>
>> Then let's make sure the bit is also set in the hardware register. Then
>> also the reboot issue (which is practically a minor one) is solved. The
>> current situation is far from optimal.
> 
> This doesn't work because then the time will be considered invalid. I'm
> not sure why you don't want to fix your userspace.
> 

Nope, that could be easily avoided in software. The actual problem is
that the VL bit is not settable (clear-on-write). And that means we
can't do anything about losing the low battery information across
reboots - but that's no difference to the situation with the existing
driver.

There is no "fix" for userspace as there is no standard framework to
read-out the status early and retrieve it from there when the user asks
for it. That's best done in the kernel.

In that light, I still believe my patch is an improvement over the
current situation without making anything worse.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

