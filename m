Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7415BA085
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIORv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIORvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:51:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2112.outbound.protection.outlook.com [104.47.23.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9497804A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n48ewNpZmQZOKqyKdN5l9av7eaaupxlKVAO6dEfsEXHfCp2W9po5omS96/0C5m5656cyPb635L90/N2rhNjKuTJZUt9egK5Qvtdn7TJRUVI4KdYzksfw5DQQ8F61BnM7olwA/uixkXC8rKVGpC84ZTh7XUITlq7j1in+Jmtb5kkbCugm/nmMaSVQyaR8jKXWw/iiHccTDcBbwapHxEor08rCW551WJtXiz5ym+dF/LJ6PERX6HX7Fr0P1c3Y110GvOVeWfZAXB4xbLyjAdytmFiCk0z+UUnv2BvKBntaKY8PdzpPNHcG74nVoya0r3sXEb1C/j1ZQEIZY4xBjazr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx0L39GU1XiH8sHFJ2VLb+V9IkP0ZR+UwF88lV4qOko=;
 b=k4tMfGShLbLMfc/URO5vOx7nY4Uw1ZkAcSiRXpptqVSYM5ycY9OXhcG1Jk2xnTajO90tuk9pvE4HHKQbPebNGSYaNlzEC27/N7LO7TZS8fnrwNxP4XG/nHBANiMkP/jS0CDX1pHtQZFh9X9I83cRV+YwNRM6JFpo9a3Pmk9u+XKthrD4kBebzuX7b+mG9PyROr8F7oYkMCUnAeCI06A67s93iZAcFvKIiW4R3OkWkUhI/9nKgnNGQG0GgcHyp7kIOa/85RtFS5QdK5q28xAulpy8O44zBKeXcd6yg71vZX9i27Xrgo5BbWuI3SuT1DiEJ46auUyo0jL6zf1nTM4CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx0L39GU1XiH8sHFJ2VLb+V9IkP0ZR+UwF88lV4qOko=;
 b=fKhJ9gTPZGFPB5Ov0X0S1Od1KMA/bubTwK0RXjLrHXPJ2yx/uPhDTpoptJRaSEp8cBzLWvQqA10XqxoXuvb5H0/rho0UwMiNNGc/lABJ9Z9VJuBwxtkHfjgbDse6c2GtiW2zK8iltKm/VYqZVWWGJW3px4QrEA2GR525zIj4M7wvZdXKJOm4VJAdHF8+y7tHo+OzxREf6dyQN7dsJ3zdP8bcW3xaDSML0rELBdNr5F9cZVIk/K8flUkE1A/z2p94JQhzH00+wcpuCFdUJ+GnYyJTpW50IbOx3LyK/ESxnvj/R24+TtM1yv8OYGEzgXQOeVoK3YJHNGJj3lRNe2qvTg==
Received: from TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:df::12)
 by OS3P286MB2474.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 17:51:18 +0000
Received: from TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f465:91a:8bb0:290b]) by TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f465:91a:8bb0:290b%8]) with mapi id 15.20.5632.016; Thu, 15 Sep 2022
 17:51:18 +0000
Message-ID: <TYYP286MB1439CAC807931442B4C1B05EC6499@TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 16 Sep 2022 01:51:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/2] riscv: Allow PROT_WRITE-only mmap()
Content-Language: en-US
To:     Conor.Dooley@microchip.com, abrestic@rivosinc.com
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        coelacanthus@outlook.com, c141028@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        atishp@rivosinc.com, dramforever@live.com
References: <20220909212731.1373355-1-abrestic@rivosinc.com>
 <20220909212731.1373355-2-abrestic@rivosinc.com>
 <d46d6340-b985-49b2-babb-0082f1759c7b@microchip.com>
 <CALE4mHrBC-ni3HunRzxRzM8QJDHb=FuJquccum6OcnB4jZ6KbQ@mail.gmail.com>
 <aba1be51-6951-6251-0802-9db573ea2aef@microchip.com>
From:   Vivian Wang <dramforever@live.com>
In-Reply-To: <aba1be51-6951-6251-0802-9db573ea2aef@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [3TWVOqcbMTLaB7Ym1pyCUT4ReEVOYUOp]
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:df::12)
X-Microsoft-Original-Message-ID: <c78e0256-76c4-6413-dfad-4434a1985f5f@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1439:EE_|OS3P286MB2474:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f215265-b6a7-4a55-7bfa-08da9742e49b
X-MS-Exchange-SLBlob-MailProps: 0YULWdH+7mAoL+hWxShIl9HGKVrF6AK4ZFTLc5EDs+LV3ismLNvGViJIjfRjdyC7DoF8cTn4SubhvBNnqzwNLnP1ftuGS20KOpbUfIoLTMpc6JVSZaRsX2k3GVFnfK1ujRvJh2jA1UXDE6BtGGvcVRDj/8cnJ08QPrrEfLdRWPm3SmPPsJY2pxqXEhf4AqBTXXoomWlii8ZVcc+epfTKTYQmnZdxXG2vIXAFikNCCgZ2DzIAV/xnaAhHi8iH+pGtVat+JY56a+IaGJuWPuZuLMgbHZfggLM94Cte/i52WlobFmiIh9nhUPMdT0713v9mSD6G7Uwn4uKwnUDvFvz2pMRlIiMkO2PWAjH8ZdwCPHCNwDYi5/BjwKA6+IxO1FX3Bu151gDlrQoCd21JwEpft+nmOwRCXSHJ6SzZYROfyUu6HDZbJ/kgiPjUHWf09NtYJ5GL6/PW+EPmuH80NFXhbaA5sKRU208KrK1Tc8msfCj1SaUz6ozHfhh/ZmBrSxAz/iB+btn7Gx8K/bSi7K7IvLtL4JqxlTehe/WuQhrwuZpNGDfIjGd7VMwSTj8d4WIxoRXbkvUIrGjuKlqE4ekWHNF9XYOuhtfYvFnOFvkmo+OM6QsavlLkmHtw6hPWmiX3g8R2uT7Fkhm//36K779+RU5I53+eWsYdqXkGNxgqp3ZWzVXH72pWL5gcNycSKJD8AJFXr0SHNu5/Mnkadvsc59M51pURwyvV8o3EQdC53XHDsAHduClovSZm37xohBf2HFaS85UILf7kg2VEY23gfcmSPZlthbLYpK5bkAKq7llc/9nELG8uPqTp6uy++LVwkhuLW11HTTNtzWrwR/9FJX6QDGu/tFjo3TlFkqY7eU/cYtGJCfwKMQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2dLA40meiavK44IZHTFEqrp1p1+8uiL7hECEFzwWAJod/jT09lzvEjEilXb4sAcbYCzkANR1j2gHA+bgO+zmTDY96jDnr/IwFmCn0XYUIljjaAEN/bBOHRNT60jSRM7SMmMdWgMRO5fGUE+Ib1H1yv+BJ7YIk5RS3QiWg03LxbKoyNTXqIQW7C0A72JmAmYjkOOSy/KdU1V+dRXd0zUSUOk2BesXEuvjhre+AyTv31llC25SenHMeNrWmePT8uA838fZlK4J3JHff4OYGvUpJaiNuY/0Nu5E0gkrf1Z1dI9g06zLywh5geXNAZcGC7MbFpLnYGEBIC0IWl963Gf889KySu27ojlBJUWuRVzONUTRXpl3YEvqLJ4uHTafk/O88c4yjwIedZdxrqt3baxFAZfbJOtaYAtnT/SViMyL1PXjW/YTze8B62x2GBkrHx2FQEBYQPMBWeeRGGL/Y8UQLUIgq0X1gPj5htjRfY/IaDybXbpnmezVlYRsEccZlE+RQjOzupvi0GSIU0my3aQ9cTNgo4TRuCbfBLVIeePDLKXJxxOkCaXHknkCO2ly/Rq98cFLj5AhHOcK98HsOC3ywN/k5UtfYS3IzPSiOuJDWsPEQNouJLNxIMEPYcihCA+Tz3RNl9BghsKtz/6CSlHnxTYwsz6Fg30PueP/I3pxs0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elBJbjFvZjBnV0xBaUxXc0JIWWhsWkdYc2tWZEx0d09MY09ZWDViUCsyOTlt?=
 =?utf-8?B?K1p3eXMxeHdDVUJFRFFLS0o3ZkNjOUxvZEhXYm5TOTZNQWNhRlIzTnpXdVox?=
 =?utf-8?B?R0JGcjQvc3h4eFJaVEppdGJaRTEzWmhKcTEzR0Exc2x1eVhGTnZVNjNiR1Rz?=
 =?utf-8?B?YmxxZDF6L1FYMnFPZWJqKzNHeFI1ZGdoNzlBTjFTYmFEN3JUUUJtbTFBZUVt?=
 =?utf-8?B?WFB3d29IcUxlTlJZZ2JNUEJHbXB2MlBtU3ZDQzFvMzdNYS9ZN3FzSFlrNGV5?=
 =?utf-8?B?R3M2QUkrb09YTjlFRXJnb0p3MHZSeS84dTlpNGNZR2ZKQUZaNi9iZnRJak5v?=
 =?utf-8?B?QjJuSzAzbk9LdzJxSmxNajJFakFNT01XUTZOb1o4cTNTMW05eStKU2NoRGxl?=
 =?utf-8?B?c3hFakpGanI0WlhyUDdJNUhraWdmaHUzV2tTcW56NFhYMG1kTjU4WVNCbE92?=
 =?utf-8?B?QittcmQ4aGM4NGpPVTk4YkhvL2hxaldmSk5uYkFjaW9mQ2M5MlJXTFBUVzQx?=
 =?utf-8?B?SXhRU2lmSkhDeEJWcXFJRm9LR0tqcFdIdVNhQmJrTU9lY3pubm8zMVFseUdN?=
 =?utf-8?B?em90aGpOcnVVNitmRS9TRmtIRzc5YjFUbnFHdUlLSDY5bGlwSDVYTUdEdko4?=
 =?utf-8?B?Vk9TbXgwZUJPVThycVlyelpQeWRrN2JGY1o2bzN5QmhKeWJtTEJpQjUrNUc2?=
 =?utf-8?B?QVIxeGtRVWxqZllHaGhrYzBHd0hTWXhTaUVPMlY3YVpyOGZzb0tVYzBzZFZh?=
 =?utf-8?B?TkRQa1lzNFFNeGZFRjRmVGJ2UmV6WldhdkNCclh5K21ISTVxUFZ4QmRTdHJ1?=
 =?utf-8?B?SUduY2c2SkNybnkwZ0pQallzTXBXRk5zdHdhYmJWdXFnQ0p4T3FUQlFpbC9h?=
 =?utf-8?B?OEVJT0FhMytoY28rLzlPeVJsMTJuTW1IN0RrNldROGkycVBlYjhJazk3UGo0?=
 =?utf-8?B?SU9hVkZaK0s1dnhVQ0lIWk9iajlVZjBsSWxJZ0NPcHFkenVjdTl5R1NOL2Fi?=
 =?utf-8?B?bHBVb1h1UGQyd1QrQm9BWURIbGE5VGNjTzVwR295WTcrSG5SN2NQM3lpR0Fw?=
 =?utf-8?B?eWJoeFRxd2pDaWRkOVVuMUZLb1lxemc1ekxZQm95TXRIZ0paK1dKMlRBZVlS?=
 =?utf-8?B?YmJOWW5iQklxemkvNzFqM1I1SWpyUGJyQkZId0IvTmI1eTRUQVBtdXRjNTVP?=
 =?utf-8?B?QjlOb1NldTBjK0NDT1QwKzg2aWRKOWtyYklnemhYY2VieEJVcG0zak5LdzN3?=
 =?utf-8?B?MDNUeUNZTUFOYm0ySHpDUHZuRWhvS05rQThlMnd1R2tXSE15OHJvWWpqcE9W?=
 =?utf-8?B?SXVBU2M1U1NCMHpkYVdFUmRvQ04zWmxFNysyMUc2VURUMElRaDNyVVV2QXJT?=
 =?utf-8?B?VjRYVkZwdjcwZ0lXbVlQOGVUNnhXamFLNTA2TWlHMnZ3dEtJeHBLSG5FZkk1?=
 =?utf-8?B?VnNuVWVQcC9RUTMybW13Ujgya0dTWjdvMFRFbXBSQWlvYXp0TXpXb1dmZDNw?=
 =?utf-8?B?YVhyUzBBcWVCK2lLdGxXemt4eTh1d1pTbU5CTm1pTFVETlE5YmZhT0UzeFZr?=
 =?utf-8?B?MDFxSkh1RUdIT20xYjcrRFN5djk1YThFajBnNVlnTDREZm1peVQxQ3RkckVJ?=
 =?utf-8?B?RHVQR3BxT0VMSmQ3eHB5dlBHMHlBZ1hSQ2tCWW40QzlvTGVFYzJYaGhaTXE2?=
 =?utf-8?B?Wno5Umd2QXlyTHJKcktFbjdFaFo5UHJaeE9GbDVZWnNQS1d0RE1yT3pRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f215265-b6a7-4a55-7bfa-08da9742e49b
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1439.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:51:18.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2474
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 01:40, Conor.Dooley@microchip.com wrote:
> On 15/09/2022 18:27, Andrew Bresticker wrote:
>> On Thu, Sep 15, 2022 at 12:56 PM <Conor.Dooley@microchip.com> wrote:
>>> On 09/09/2022 22:27, Andrew Bresticker wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
>>>> invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
>>>> PROT_READ with the justification that a write-only PTE is considered a
>>>> reserved PTE permission bit pattern in the privileged spec. This check
>>>> is unnecessary since we let VM_WRITE imply VM_READ on RISC-V, and it is
>>>> inconsistent with other architectures that don't support write-only PTEs,
>>>> creating a potential software portability issue. Just remove the check
>>>> altogether and let PROT_WRITE imply PROT_READ as is the case on other
>>>> architectures.
>>>>
>>>> Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
>>>> disallowed prior to the aforementioned commit; PROT_READ is implied in
>>>> such mappings as well.
>>>>
>>>> Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
>>> For the naive members of the audience such as myself, this patch
>>> came after a non-fixes patch in the series. What is the dependence
>>> of this patch on the other one (if any)?
>> This patch is dependent on the first. Happy to re-spin with a "Fixes"
>> tag on the first patch (or maybe Palmer can add when applying).
> If it is a fix, then it should have a fixes tag. If it's cosmetic reorg
> to make the fix easier then no & it should be moved after the fix. If
> it is neither then you should prob mention it in the cover or under the
> --- /shrug

Basically what happens fixes-wise is that patch 1 fixes the original
problem in a different way, and patch 2 undoes the previous patch (with
small additional fixes). IMO this needs a cover to explain what's going
on to those who missed the v1 and v2 discussion thread.

v1 here: https://lore.kernel.org/all/20220908170133.1159747-1-abrestic@rivosinc.com

Thanks,
dram

> Thanks,
> Conor.
>
>>>> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>>>> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
>>>> ---
>>>> v1 -> v2: Update access_error() to account for write-implies-read
>>>> v2 -> v3: Separate into two commits
>>>> ---
>>>>  arch/riscv/kernel/sys_riscv.c | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>>>> index 571556bb9261..5d3f2fbeb33c 100644
>>>> --- a/arch/riscv/kernel/sys_riscv.c
>>>> +++ b/arch/riscv/kernel/sys_riscv.c
>>>> @@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>>>         if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>>>>                 return -EINVAL;
>>>>
>>>> -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>>>> -               return -EINVAL;
>>>> -
>>>>         return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>>>>                                offset >> (PAGE_SHIFT - page_shift_offset));
>>>>  }
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
