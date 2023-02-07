Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0868D340
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBGJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBGJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:51:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2112.outbound.protection.outlook.com [40.107.101.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCED2FCFB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCQkmq0BxlFB+EyKNMqxpRJwaYTItYIeGJkZmxKw711je+dy/teto8Ie94MaKcifFQzzYBvP9MLrvsgP34JinOnUDEESAjMODszFIcAkGWSqGzVhcM6o31sNG5uKm69WxfKppVkqSW5izQ66W7/DADOZO2cbq9+e/y7XOK/T/XyH9G/QLFVckOeeXZ/u34jpyIvkaMQOWCCE3QDIxZjVRP5ZpAOHbsydZKkQsUHzimTEzGAUJowvgY3ezOyCQFAy5O3rAFo/voQ87NuRZ0B3BpzP8KqpMjY3WLEVqNB9UcoPs+oDfGxeMwZUbDQGpcH2Atrx1gVckSrML+UNL7KkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfdCMVF2jx0BllTBJovsxJgCUeL/HuJDTHW4aFS+iak=;
 b=TUANULcmy8QVzI0r77nmHyofuRYeKqsuFqiHnXhzeAQVfdDvdGAZN6gSPemOVCT/TA56j15pwED6I5j1ngGr90hAMcqHv98KBNFxGKbXZIfu7PmqTr0NfonrLo13wIx1h8iNXf6SKX2zJGMBt69eRlE7KRrCPotR2xxUxVFud/kJiLS17c2X5KCZWaY9if9cMhE38GMKM//0HxOEcMzoO6zkpS/tL5lfCfq3dNZBLSuRbQX4CA/BMXIJ8Tv66vecXcmeIR6ENqthR3iOMMd7WqOor6JCHVQh62H4i4DUBbbf0pVVk7G0Ovyec4gJyvT9spuscb04oZcx7oqLCPc/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfdCMVF2jx0BllTBJovsxJgCUeL/HuJDTHW4aFS+iak=;
 b=pg46aqLbpIC6JGiklpoH/jovGF3zol5PNbNi0vjL2Lb1+Tg0ozbGPesEYLaxvcxooiWCVFqvo1YaLIxTH9wr4OO3K0/sscXwPI6zEOHnara4BH37wY3HhgyyRrAfr+PM0p7LMGpX09/pubE5EBVeGYRs0WnfBHML7ekPVpPbOA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB3930.prod.exchangelabs.com (2603:10b6:5:84::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Tue, 7 Feb 2023 09:51:06 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%3]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 09:51:06 +0000
Message-ID: <2bffb6ca-e5f5-1a24-a47a-b0238e184ad6@os.amperecomputing.com>
Date:   Tue, 7 Feb 2023 15:20:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <Y9z3UG+wEBn4i3G2@myrica>
 <3a681b82-d840-6ef1-40dd-358f34c8be9c@os.amperecomputing.com>
 <Y+FYwbWgOaWyHySj@myrica>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <Y+FYwbWgOaWyHySj@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:610:74::21) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|DM6PR01MB3930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7f889d-8f81-4a15-e3d0-08db08f0d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ne7UwCXeh+QJYWIkQLne2ch4J7qsLPG17kuY/gjLnaF3j61oV7gEK2qzKIgtQAxC2O/j0bqcqK8U7z5quIWLXgWgBaHG7HjFOFXabgbhB7HvfeBuqSZvPR7GDexXZpTSgFE6YUWDKTTarjHaoXseZCCn86Hb7VxX8rE+UYNPewQsV6pXYY9zyOzPgO78NQXmi8Dg+jOB9DOBoNTTAhR4ypWTx3YxxmnkPSgRSpc7srzYyKrHIDiXogswnO8U5+TnPs6B+ZBVN8D5BSPOO7H1FRk+TxZKTecKHNyW2zy8TBwpzqLo7IHHYQrD/Gj/CWl4nxXUnRdrYznk9hGcXaEQ84bGfijowRvrdviaNXJvxymIIjud+slH+0Xp0VBOLKQgGxZwPxkzePvqJrhu9PrnqZSOeMPQy0kc5CnU4OigM3pFOm+bn7VFA278DKS9dPahW74YDvOAqgspXVko1US17vTM8sj1DeYuWu/OtYXd1fn/DxMAIpq5BbhWyL6J64WWnlJU/R2+XD27Ef1iLKq0STzEW0iv2gcpq+GhPm23hqcFs6VuRpb+HELOGZKXOSGv3TU2jy4mEnELXINEuCSquBdDNeGWnViLBS8uLPaafxsn8l2t5u+E7KJZ9wCZFSWo6xxljwU3ZTVDsjX8hVB0D2/TKcNDpLsQ46K/TMFX1kF0bhQ6iwYlREsSGyU/LJZW1FUo0cfeYm0re90LXpvscbh9pHWTLRuj5FrYH39LCFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(136003)(346002)(396003)(366004)(451199018)(31686004)(86362001)(38100700002)(31696002)(6512007)(26005)(478600001)(2616005)(83380400001)(186003)(6486002)(6506007)(41300700001)(966005)(8676002)(4326008)(8936002)(107886003)(6666004)(316002)(66946007)(6916009)(53546011)(66476007)(2906002)(66556008)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURPYmZQbUw0MWFwUEhPd0xyVEIxMUZLRFZlU3dyMkY2dG5PV2gxV0VRWmgy?=
 =?utf-8?B?bzVEQ0tGL2hkWHVZYThLOUd5Wk5OTkQyazZwVWF1dnI0am5IV2kwTisxVElO?=
 =?utf-8?B?ejgzUzUvc3B2U1FWR1NwTFdmajAzUHBXQjUrbndyNWN2R1FtWkZDa284Rzgx?=
 =?utf-8?B?bHNyMG4rUFhaVGpaZHdXbURvSnBSTWE2Qm9rOWVpKzQxRE1jOEFVdXFjMzht?=
 =?utf-8?B?aGlTUzcvY2ZyRktNNDFUVE9YU2g2clduMU9YN0p6SnNLRHhQYXBZM2NtYUlv?=
 =?utf-8?B?dk1OMG82amFTanBmK3F2OUZMOUsyK210c3pONnArQUFBSFpBK1lKVkRUTDFj?=
 =?utf-8?B?N3gva3FZVkpENFB0eW5yOXN3aHNDN1l3WjNGQmZyaURwMk5hMHB5bTIrNVRH?=
 =?utf-8?B?Y01peWpZdXZJRzlXMFlvc3FVS1F2eGdVWStONUMxWExzMDkwNXFVOTRDSFNr?=
 =?utf-8?B?djN0Y3RQaVZ4b2hEZm9NZUxVeXlpNHBER1NnMkFDSEZSeFhvTkhmVzFyOExY?=
 =?utf-8?B?c2RVOGp4TzF5OURGbFpEdWRhSTZjU3VKV1RQMTdWb3VZdXhXNlNSUk1sVHda?=
 =?utf-8?B?aS9IRVI2ZitKQ0ZkMXJta0tadG9TT25ROTVIZnY0T3NHTFd1THArN2JxOTh4?=
 =?utf-8?B?MytwQmI4R3k5NFEzeFJodytqaXA2MmszcWFyaTVEM2hEQkRmV3o4RXJEYUg0?=
 =?utf-8?B?cHFZb25JQjZZYklmTlorWkk2NytqbVVyVTh4SVJZMVJYaUk4UDZWdloyc0ls?=
 =?utf-8?B?UTVQWHZ4bTNLWkhnT25KeVphbUhNRHhhREtEMTZaZkdPengyRExDWlpaTDFJ?=
 =?utf-8?B?TFAwRk5jbk9QRXdkTHM1eXlzZlJ3OFh3REx4c2N2Tm84NFByQVljZjJNb05I?=
 =?utf-8?B?WnVRTmJnTmx0VnZENnEyZ1JXUmF2QjMwaUtpaS9ldWY0ZkYwYzJXRXBOZjcw?=
 =?utf-8?B?TG84eDVyemRpeVhkV2Y4MnZTMlRGTkF4OEN0QzF3ZytXNDErNUU0eE5xWGVT?=
 =?utf-8?B?aVNDL0d3WTcwQ2dVcm9ZTTIyMlhBZWVaeDZldWY2UGtXY0dJSjc1akc5U1Jt?=
 =?utf-8?B?amZVNy9nWmUxRWlmY3Fud2x5d3oyUllXWXlBVGpZZll6S0NsbzVFWlJHVWlS?=
 =?utf-8?B?eUhxRlZXK0lrN2J5ZzJxTThCakVULzdRZHNHT2lkWXRyMWc3OS8rNXZYZUV1?=
 =?utf-8?B?V0pBRWk3VVp5N2lXS0hja09peUkrRytlSFBGT0tlQ0p4RCtjM2w1NEl4Yy80?=
 =?utf-8?B?NlpxZEI2WHV0OXhxeW9GSGhHSGZ1blF2MWp6cVVXZ012RktyWU1JOTZFQkxo?=
 =?utf-8?B?R2grYWxxdDJvdjJxOHZ5bm0zbXFvemZsMUtreDJwS2tyNWxEbVBXODMzYkdH?=
 =?utf-8?B?dFZ1bGcyWnp1NTArQ1ppang2Mm0vaVpVWHY1a1RjWlNxcTFNUG1kaHZSTith?=
 =?utf-8?B?RjhsNVZERkx1eGFBMWJHMUZvR01NbFNaUFptQnhBOVJjdFl4bUhtVjI0em5h?=
 =?utf-8?B?RjA2cFEwSmV3dE1pWUpIZTU4dW1KMWpoeCtReVdYVlFkVklta2RaTXdjK0Fw?=
 =?utf-8?B?aHN2R2UrSlluaitVZ291azBFdnVqUElyRUlJcGtCMVpOVTNQaDl5dnM4S1Z1?=
 =?utf-8?B?bEJkdHFaOVJZVHB0U3ZkUkR6OUhiVytWNFBtNk1yNVNodW9VbDlld2ROaXJi?=
 =?utf-8?B?dGtkSkVZQ2ZmNXZ3TW1GVUJnOHNjaDMxVlBCRWxuMENlMHp5bTJjajFnU3hG?=
 =?utf-8?B?QjYrWGw3VjBwd2ZUemZIalU3Tk9Zc0pNK0FtWFYzVHg1ZVljT3FCYk5Nd0pN?=
 =?utf-8?B?OGozOU1MWTdPYndRdFNYbkJmQXc5MjNSS3lnaVQvMDhOdWtCQVIzbjJGemJo?=
 =?utf-8?B?RDU0U0JjVk1qc01ma2dVL2xKR2MzZk1xcDhkVzFZWlhvTURkWndnWGdqaHln?=
 =?utf-8?B?d1Z6Vk9sK1FYbHdHazRhUHhldHByRisybE5TelVNdHF5M3lrYTdNK1cydzd3?=
 =?utf-8?B?M1FRc1FmVnFSbzhyVVNRQ0xPTWx0NkxHK1RNS25Hc2dNMUhxTU1XNXZDa3Zk?=
 =?utf-8?B?T3FVMVBCYjMwKzkzTTY4Y2RyeGZ3SEprQm85NWpGN01MbTBSei9SdHZCZnpI?=
 =?utf-8?B?VllXOVVnM3UvSWF3UkR0dFcxaHhIeHkzR1dNejgvVG9EM3ZjcTRZSUt3d1pl?=
 =?utf-8?Q?Dm7arYHcVV+mrVDC/TDIDa2SjrHhKgy2GRPC9SKCGi51?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7f889d-8f81-4a15-e3d0-08db08f0d4cd
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 09:51:06.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbwIfi5l/MiZQMv7dI0ZWNMYd7ayR0exatSnerCXMy7Ilxr06i2S1b0nyrPzUZSS6tc6CIrAVGp3YhngB4vvPS50Nh7DU+UFaAkDqi5uxiEpF+Cx6o1lb1ILY1gyjj1i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3930
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-02-2023 01:15 am, Jean-Philippe Brucker wrote:
> On Mon, Feb 06, 2023 at 10:50:00PM +0530, Ganapatrao Kulkarni wrote:
>>
>>
>> On 03-02-2023 05:30 pm, Jean-Philippe Brucker wrote:
>>> On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
>>>> The current smmu-v3 driver does not enable PCI ATS for physical functions
>>>> of ATS capable End Points when booted in smmu bypass mode
>>>> (iommu.passthrough=1). This will not allow virtual functions to enable
>>>> ATS(even though EP supports it) while they are attached to a VM using
>>>> VFIO driver.
>>>>
>>>> This patch adds changes to enable ATS support for physical functions
>>>> in passthrough/bypass mode as well.
>>> [...]
>>>> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>>>    	master->domain = smmu_domain;
>>>> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>>>> -		master->ats_enabled = arm_smmu_ats_supported(master);
>>>> +	master->ats_enabled = arm_smmu_ats_supported(master);
>>>
>>> I should have added a comment for this. Only found the reason in an old
>>> cover letter [1]:
>>>
>>> "When no translation stages are enabled (0b100), ATS Translation Requests
>>> (and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
>>> EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
>>> Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
>>> F_TRANSL_FORBIDDEN."
>>>
>>> (See 3.9.1.1 "Responses to ATS Translation Requests and Translated
>>> transactions" and 5.2 "Stream Table Entry")
>>>
>>> So I don't think we can enable ATS for bypass domains :/ The PF needs to
>>> be in translated mode in that case.
>>
>> Are you intending to say smmu-v3 driver/spec will not support ATS to a VF,
>> if it's PF is in bypass?
> 
> What I meant was that if, in order to enable the VF ATS capability, the
> PCIe device requires to first enable the PF ATS capability, then given
> that the SMMU does not allow enabling ATS for streams in bypass, we need
> to enable translation on both PF and VF SMMU configurations.
> 
> But reading the PCIe spec, it looks like the capabilities are not
> necessarily tied together:
> 
>   "The ATS Capabilities in VFs and their associated PFs are permitted to be
>   enabled independently." 10.5.1 ATS Extended Capability
> 
> That wording doesn't indicate that all implementations must allow enabling
> the caps independently, only that they are allowed to do so. If a device
> provides independent capabilities, then I don't think you need to enable
> ATS in the PF.
Yes makes sense, thanks.
> 
> Then the ATS Control Register seems to contradict this with the STU field:
> 
>   "For VFs, this field must be hardwired to Zero. The associated PF's value
>   applies." 10.5.1.3 ATS Control Register (Offset 06h)
> 
> So pci_enable_ats() requires that pdev->ats_stu is set in order to enable
> ATS on the VF:
> 
>          /*
>           * Note that enabling ATS on a VF fails unless it's already enabled
>           * with the same STU on the PF.
>           */

This comment was misleading!
>          ...
>          if (dev->is_virtfn) {
>                  pdev = pci_physfn(dev);
>                  if (pdev->ats_stu != ps)
>                          return -EINVAL;
> 
> But I suspect it's done this way only because it's easier to implement.
> The spec doesn't require the PF ATS capability to be enabled, it just says
> that the PF's STU value counts as the VF's one. It looks like we're
> allowed to enable ATS on the VF without enabling it on the PF, right?

OK thanks, as per spec ATS enable on VF and PF are independent. only STU 
and Capability are hardwired to be same.

> If you rework the PCI driver to only write the PF's STU without enabling
> the capability, then you could enable it in the VF.

Makes sense, It should be feasible to write to STU of a PF without 
enabling it.

Below diff is more appropriate fix for this case.

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..f064c2be8593 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -74,6 +74,15 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
         ctrl = PCI_ATS_CTRL_ENABLE;
         if (dev->is_virtfn) {
                 pdev = pci_physfn(dev);
+
+               if (!pdev->ats_enabled) {
+                       u16 ctrl2;
+
+                       pdev->ats_stu = ps;
+                       ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - 
PCI_ATS_MIN_STU);
+                       pci_write_config_word(pdev, pdev->ats_cap + 
PCI_ATS_CTRL, ctrl2);
+               }
+
                 if (pdev->ats_stu != ps)
                         return -EINVAL;
         } else {


Thanks,
Ganapat


> 
> Thanks,
> Jean
> 
>>
>>>
>>> I can send a patch adding the comment next cycle.
>>
>> I am more keen to know, how we enable ATS to a VF of ATS capable EP when
>> it's PF is in bypass?
>> or it is mandatory to have a PF also translated? then that should be
>> captured somewhere in documentation.
>>
>>
>>>
>>> Thanks,
>>> Jean
>>>
>>> [1] https://lore.kernel.org/linux-iommu/20190409165245.26500-1-jean-philippe.brucker@arm.com/
>>>
>>
>> Thanks,
>> Ganapat
