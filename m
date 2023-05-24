Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9DA70EEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjEXG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbjEXG5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:57:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6119C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOezrzHQExg2CYy62yg8D93Jv4dmmOR/edC/x/ZcvPuxCKRN6Upid8VlA/c15orDdxVJ3KuUOZv7ULEiEV+qBoqomezX2ZlIjLcfLP0dYw7+GAaCSVxqhzDNO2zmjLAYsLV97ccvwQ6iZN3EQ4Y8mg0s/YBjV+Fo557asrHKcXyBcThjvqkci6XwrxRRMUwmQyT4EfhXBEJgFPojzwb2UHjnrwkdUgHsLUkVheDlBuz6NN6KEGtaCOll5gN28ZtGJZXmEsKWlYjESIxUuu4EcM6eZJrQq4gXHtiD5b5gpjJmRw0L278jQMBrE+vgj30AkUiRLqhAEpLWLeOQhNIqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tejfq308aDZnypst1Gl4kb1jlLj051pF+gIZ1ryDEU0=;
 b=QmJS6VOogqPvVHJKw3qYNATLSpvH9NcDC5HFZmbikftbA+gbJaMhdcp03SwBhWtskNlR71a5uPD0pYFdBg/gQzHc70hmCWxVxvHNvtqTGLl9yIfBoMez8Sr+1U9acsbTG+Br1k9p0ETCoPcYrfVm8ZOJLtBSbZI7orlTvoFIRI5ZSuaSkD3/sDDm7kfm7HPRsLUbSjU8Ed2/T3lECzp4xW5py8knW56C84vfwKe6IxW0FJ/p9UL/nv3M8jwL22lns4KkfZ3qEof8gM8NZySLvvL0aGBEub2wcQEwFV4iFxQtq41yQW+USuDByAZI4Pt1n6RkWsdRdToXp9t9X4oL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tejfq308aDZnypst1Gl4kb1jlLj051pF+gIZ1ryDEU0=;
 b=OGg5L+X6bW019L/gPxlxu/BtkHBv2Lz0y5+kFrY+zhNCtsFs+mcDyGcWFsRU5PbQWn+LqYuEv6t94cpVkVZplAMt4PVVN/aCTk2BkO3BS61KyIzjaoaJqnZO8JjAJmOhQ494d5StfwJYi49WMyZylj6HP2a2Khq7ytME19+3lLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 06:56:31 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 06:56:30 +0000
Message-ID: <9d24f5ae-75e6-2358-f9bc-72414c5f250f@amd.com>
Date:   Wed, 24 May 2023 12:31:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 2/9] ASoC: amd: ps: handle SoundWire interrupts in acp
 pci driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-3-Vijendar.Mukunda@amd.com>
 <134a2efd-648a-fb4b-4b61-154173b97f04@linux.intel.com>
 <2e8d3af4-7d54-becf-1084-c9b07a3436d0@amd.com>
 <d1baccf7-c689-fc40-d616-855c253021fc@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <d1baccf7-c689-fc40-d616-855c253021fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b829b39-d941-4521-8585-08db5c24002b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ojmUxq/V8+XVASQ42QjfDjNKX3i3qeX1KY5WT6HOllUtJcLylqfVO3HpDSe5Su/rQMPn+5fkSGG5t6lJOSstPF8Otgfv9jBuSlm5Owb0GaaPw2REbrLnM4V9NNhjisy+B03IfztDK3rObLoP6pns8VEUzg9WaSz9Nv8SIuo3OFPQbRQ9PAq68mFB/qmjcdN2yEy5pB7l+wcs5W1z+VI+/tCjKPA2jzaxXNl0rq8cWIzt/GCP3Z0mxsJ59XdI0Ddmc0kmAuD9QL9awK36S1MUfmZ+Q111oDkWV2LmMhIIYAuLUW2K+rKDk9dOX5k5acXpIkDiiXmsjkrIA696DGtJx7+HTPxS0Tjzc2Z7/tPUWLDL3RFQUTz+5XAHJezfdVfGJ4SutRDvKLGqoTcCr7NninhAOpbdd44AOGxKGbRs3bsWAgee0HtoQVZIGGdr0q3c2NX3LT1WRp2xm2+d+iJiHvKyhIF6WydPkVZDX9utRr8zwphZ97FgUmdpc2CXxixXI5ZWu3IAnq/L/vbDwXwPDepKVgpxmTuNoYKR2Xc3dw5Aq9HPEFDZVDDNm4pUDffrupGayO5cR2Xo2XebUwtJTnNE3QTvi7C/IGLEtSIDCusGN6kUEmjveAf+huteQ+IgyyjSpXU5/R1pTQwDPKu4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(31686004)(54906003)(2906002)(5660300002)(8676002)(8936002)(41300700001)(66946007)(66476007)(66556008)(478600001)(316002)(4326008)(36756003)(6666004)(6486002)(26005)(53546011)(6506007)(6512007)(38100700002)(86362001)(31696002)(2616005)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJ0VWxvWEFJRERDOHkzUHNlNFF2Z0hvOUdsMWNrODlmTG11Y3ZkbEVMb043?=
 =?utf-8?B?d0NTb3EwSXlja3NaQW1DZ0xyV0pqTXdSMHRWNGpZc1V1WkFxV0lsdjlhL2g5?=
 =?utf-8?B?NWlBbGNDeGo0a0NFYnJxRWxZZnlINS9Hbjc4blBhQnV3ZXVVc2VTSmNSSUtH?=
 =?utf-8?B?WHB6a21jaVo4aVFpaUxTZWRaN0k4bkpHTjc0QUJDdXlHZ1hTazF3OTZsR3hH?=
 =?utf-8?B?UFhjZk9uSXV0OWRRMkdTMUJtRlZrVWlyb0g0enFoVWViNlNIU3BWQm1CeUxX?=
 =?utf-8?B?dXZTeE9TRCtTTFFLSUVtYkN5d3haa0lJbUhKRDlrL1dKUTdPcGJqSE9qR0lq?=
 =?utf-8?B?cldpWXVqdnRObGlhVlRZcUZCb1lLWkFldHh6dFo0c0V3RlpyZ1J0Tm4ydWVr?=
 =?utf-8?B?OXhuY3hOc3d5bEM3aytvTndkc1Y0N0NJR21iRVpsQW44Rm1FSmNSNnUzNytq?=
 =?utf-8?B?TFhNN2RUZ0ZjRFl5MGoxTEhYQjlwQm9lWnFsTkZYcFA5UnJhOTBJL1hUWEU0?=
 =?utf-8?B?VnRJM3gvM2dVMVRBTkExQzVMclVnTGkySzh0L1lXNVZyVVVSODYrdDNSclBR?=
 =?utf-8?B?RjBEbVZMV1ZvVUtHQXJJTzVUQS9LZnpVUXV3cTEwSTZqS2V5RUk2bmlYNlBI?=
 =?utf-8?B?eG5Lc2ZxR3VsU0VHYlh4VWtJcVh2S1VaUmRpRFZoTW5NZTVVRU0vVXhUcDNr?=
 =?utf-8?B?OW1lMUVIOXJOaWRURi9SbXlqT0gxZ2ZRZTJ6Y2RYc3FUL3dVUE9oZGdZalBS?=
 =?utf-8?B?MGVpNXowT1dwbzFOd1dtZStzT25JUmhmMkhhZy9HbTB1V0JCSlIwdHowQyti?=
 =?utf-8?B?dHQvOWVMWUlSREpRaGQ5bkRnUWRRVk8wQXBabVFWM0hwYWdoUnEvNHJpNjRx?=
 =?utf-8?B?NTA1K2VkMUt1L0ZQaGN3clBFY1MvclBNcWpYTW90cDdjYzNtQ2I4V0M1Ty9j?=
 =?utf-8?B?M2g5VktUbFRTU2tJNDd6OEY5bllVZXVIWjdFN0tlWE5EbVBZc0hVZEs1ZU14?=
 =?utf-8?B?clhQbjdQU0k1eXJSaVJ0Mm5waEg4eXRmeWl1cGZTOFJnWkxnZGx4U2hKb1VR?=
 =?utf-8?B?eHREQmJNSjFWY1NMbmgrVUFEa0VKaDg2VSt0Y1lHNWxmUWZsd2NTZ3I4Vjgx?=
 =?utf-8?B?ZGpQcHhaQ3pnazZ3ZnlsaFhKYmhMNmVORGsxVFhkUkhHc1RINkRPMytPSlJs?=
 =?utf-8?B?MGx6c2RSS3dhWkx6SG5IVEJIbzBaRFVBWFppcVRiS1JyRDE5WjNRMm1ab1VU?=
 =?utf-8?B?L2kwM2JiWWNEU01PV2FpQnJobDgyd1E2MHJXd3FBVGhKRVpsOXh0YVBRRlBz?=
 =?utf-8?B?eERrV3NwRTk4MkNwVXhaMXlxSERlc25MdlRSK1g0allyOGgrMGNWWmRKQ051?=
 =?utf-8?B?QjVaQWdoTkd2bjVXZktUVlY3M0FsY1BmTksxRVdaT0xhY3BpNzhRZzhFaHBn?=
 =?utf-8?B?TWNnSkdsNTBDUFp3WmpTOWRRRmkwRDd2a1liam9tcEZtN2hIRXgwSDVoL2Y1?=
 =?utf-8?B?M3VZODFlTC85ckVTUkxHRWp3eThndmNGdENhczM3SUZSa0JTM0hocjVMNDQw?=
 =?utf-8?B?dVRwQ3lrbDdCalJEdnBPeXAzQ05qTEJNZGNlQjZHSnNVWGFIR2hjWFJockpB?=
 =?utf-8?B?a1NnbTlpNk5FRzZSb0JieGVIVktqUlc2ckhKZE9xVzVrd210OTBnOTJFKzZK?=
 =?utf-8?B?a0pCMVhWdm1ST1AvQ2JsWFFaRWIwK1FkWmI3NVNHZWVHZlFyOGxQZnRFNy9V?=
 =?utf-8?B?dXZXNzd1VmJsNVI1TXk1VVk5RmRLSjVuNDlhYkd1OEZQeCtVK1UzVk85aDRC?=
 =?utf-8?B?aXJkK1g3bkJwZlJsUFpNbnY3bm9ieDd1YXExMTN3RVRMbE5URE9LWXlCaTIx?=
 =?utf-8?B?YWRmY2hLb2R1d2lNOWxVcXpEcjRtYmxvT0JlSTd2OTcrejZydGNIV1p3R0tY?=
 =?utf-8?B?YUZwNTQyb2JvY1pIZG4weTJkbXpGSUlUOHhVOXBrWE04MWowRW5lMnoraTNE?=
 =?utf-8?B?V1NoU2k5VXY1eCtZUDR2ZFFubGx5YnF4Qmw4bGNuRnliMVlYWlVNb3orSlJ6?=
 =?utf-8?B?VkN4NkR1UjhPd0k5TzQxZWxNUWdZY1R4LysrMHJ0dG95U204b3h5ZG1DQnd3?=
 =?utf-8?Q?6MD7qgGOzNVrx8xlv93qSqQsP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b829b39-d941-4521-8585-08db5c24002b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 06:56:30.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYTLffRFd/balhthZWXxmZpiW88U5KKKsqR6rJhhKANFp977E8BaQ4nsjbvZiiPbVQ5QuijdvQreJvPKv0wVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 20:04, Pierre-Louis Bossart wrote:
>
>>>>  static void acp63_disable_interrupts(void __iomem *acp_base)
>>>> @@ -102,23 +103,55 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
>>>>  {
>>>>  	struct acp63_dev_data *adata;
>>>>  	struct pdm_dev_data *ps_pdm_data;
>>>> -	u32 val;
>>>> +	struct amd_sdw_manager *amd_manager;
>>>> +	u32 ext_intr_stat, ext_intr_stat1;
>>>> +	u16 irq_flag = 0;
>>>>  	u16 pdev_index;
>>>>  
>>>>  	adata = dev_id;
>>>>  	if (!adata)
>>>>  		return IRQ_NONE;
>>>> +	ext_intr_stat = readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>>> +	if (ext_intr_stat & ACP_SDW0_STAT) {
>>>> +		writel(ACP_SDW0_STAT, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>> [1]
>>>
>>> this is confusing, if this is w1c, should this be:
>>>
>>> writel(ext_intr_stat, adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
>>>
>>> Otherwise you may be clearing fields that have not been set?
>> As per our register spec, writing zero to register fields doesn't
>> have any effect. Only writing 1 to register bit will clear that
>> interrupt.
>> We are handling bit by bit irq check and clearing the irq mask
>> based on irq bit and take an action related to that particular irq
>> bit.
> Right, maybe an explanation in the commit message would help.
will update the commit message.

