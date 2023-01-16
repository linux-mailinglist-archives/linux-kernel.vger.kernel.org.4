Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247A66B889
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjAPH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjAPH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:59:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7010430
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq6Hwhc6qONVEhVvNDLSF3S3bKQWPevo7esdvPJlWEBVEHgRX5zshz8Hly2DWNqd0T/Ivsprsr5A+L9OWMVKN74ifY9vWrmR9umPzbE3ijvZC14bKTCLo3lWfDeT9ffDCMnPc3XUh0ywCHUHNlYn3W3M9L2dZxM1xQawp/WV5EQa0td+VRgovUIpmjGlO66L0D+y1rsOzd0pbUZBvJRG6s9fU/FCwKDSirYYAM1IC0Z1mzrOH6VxFFx2iZctw0C+AkshjnZtn0fw6g0zp3vihbMAFFrdKeau2tGYFRA897Hk28me94ruSAZ4+oQQN7ZSXgw7b2mkieGancvK7sVEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bjlptJFs6ZXp8gMQNEH6RVEKd1sh4AU2H+U7Ijd+7w=;
 b=VYxDh+ER10IprCILIuJxC/EBi8kWdGeJa8+hTwU5TOzCXNbrCthIHd8NGaniWRxxNxz8JO7++bFqzVxn+hWylSYoi8bhm1US7HAVvp71igFr+u5Rv0YpiOzmQV7r4KqHka7tCcOZ8ycR9SBWi1bl3ef1+xwDyTQpVIvz1cSA9XXq9XNQBDzzKwZZGwBUotYZydCO5LSWjkbpZRpU4E1Dpev7mDit2FINOI2gUNgP8LDqTUBN8AkeHdf/zc+umOPiieQ5Uxa5EIRl2X+kar4kC0j0STTJkISl3roMmPs337ZZnv+utCVIbkX24AZnkI/JTl9V4PLS6pRqUoL5iqC3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bjlptJFs6ZXp8gMQNEH6RVEKd1sh4AU2H+U7Ijd+7w=;
 b=IEHwufGtokSd64zDQFR7sNrib+m64NfeOcoRF5/loFdTTrwsHKxa11OSSU/99lJQY0DdP2TtnxOVuEFxVClu5ds2Ib0E2dd/sf1fzsg2r6CYgHmfFKB577O6bYZkjtPDREYbGdw3YBKwcpMl+rraGJaebQIRfK+gQoKZNav3lsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 07:59:42 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:59:42 +0000
Message-ID: <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
Date:   Mon, 16 Jan 2023 13:32:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: c6562e2e-33ef-43c6-9eea-08daf797a024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcWLwNc710RKexaVfm617fSK+v8HCkDYdX58lnlMcT+bB++DLQ92U8tX92vhFoqlZh4cwlfX7Bq6GOx+fN80Zl0AdhxFKj33wrCZka7uqNQ3maaNuHm2BfELd7/ruZXU162d+azCJzO6Iq9KiadXS2kNdMJh5qkBqZreOPk8nkOSL9l7MHLQcLqh5HIVaKK68h4GLadUNwf4D7JBtsMvzE+5OHue/KifxXagIOkArvWf8M4WVI0uYE7lCafoOB5MBQc+QyJAg9VuDftVcJHB4h5USW/TzpAtrKVpagnvaDQDtFB8A5GCdMuJj170pv3dFm4vEXgwvPQV8NfNgRGJQIW3to/hN5Vwav99Qs8at3N+xS9fViezjAdmLc7QwIi6YcutUp9cNySM6dpp7NTSQaQYB0ghLfAfr3mWDxIMqRM8XApywtHdbYveeuQcybF7wSAXx4BUMtOmzTB9eAnq4giEZPid/VMA2JF1qB7EZhFbtzNEriL3V2NmH8I/UWHaitG/0K40G0Y1hCcBxMDZyKJPi+LfiqJKq+qyOkM3MH/FKag2GGgXT8v8fghV9u5Tnnd5HxMch8DpLvSQn78totdiYdi1skO4IMyLsHPhqGP3zytJjXVHbj9hAYf3qX6kDtfXr7ryWBAXeR47lbhJVoQ4SVkfM47ATKw3ZQDstOMG3ms+RudYQsvS0meunnmhkYRrhgrK64ptx3qsYd0hV8D4kunsFnQZ/M0I14ECUmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(54906003)(2616005)(186003)(66476007)(8676002)(4326008)(26005)(6512007)(66556008)(31686004)(66946007)(478600001)(8936002)(41300700001)(83380400001)(5660300002)(7416002)(2906002)(6666004)(53546011)(316002)(6506007)(38100700002)(31696002)(6486002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG8zY1VXbUZ3NE5uTkdpNW9EeTZMbkV6dTZaQ1NOU0hmUUlRUTZraGsyb3lL?=
 =?utf-8?B?TExEWTROcmgwanNsMG4zenJYWjRPY01DeERsR0xYcGhKTmlqT2xXbkNKaHlI?=
 =?utf-8?B?NHY5Ri9YZ2w3Slh3eDVPalowckZwZ0FpdENkbE1Wd1p0SWY2UXpWSmE2M2VB?=
 =?utf-8?B?TXJFYUpDeGpJSjRjTUhSMzlyaCt4bW1Oa2Jha3IrdnJxUWdxRDZTc2dnOERD?=
 =?utf-8?B?RHhjc2dTR1JKSkFCOThIUFMzTkttbE1ta3hFb3VmbGFSR3FDRGhLTkluMXhh?=
 =?utf-8?B?SU9ZUExHY3Y0WUFDdVBOVHl6OHkxN28rMTBqM3JVRFB5U0JPWUFKY250UWVQ?=
 =?utf-8?B?bTFGU1REOUl0QlhDWlkydm8rZXFCc1hSdHZBUDV0N0hhTXpmbHY1UlpyYjZE?=
 =?utf-8?B?ZkVseFVYeWRJbmF4L2dtQm5DYThKdko0emdHanJWckZFZEJCckpVUTgzMlc3?=
 =?utf-8?B?T2lMQ1d1eXh1ZW1hblEvNkNVd0cwOVVwN2JqbHh4RU5JLzJDZC9sVmNaY0FH?=
 =?utf-8?B?VmNFREQ1ejBoQXgycmhEcXowN3BoMklZSTZQaDNPcXFrTEFkRTE4d3RMSzk5?=
 =?utf-8?B?SWNOV1BzZFZlVDF2WHluTE1BRmhWTk9uZW1ZeGpvNlVaRlJVVVl6MEhFRVN6?=
 =?utf-8?B?NWlCVnkvS3JvdW5QMHQrcVJvYURFU2hObHhFQTFGMXZsbGRQT2VOb0FyZWhF?=
 =?utf-8?B?VXQzamxUUVRxZnRkK0ZoRktuclF0a3MzbkdxbUxMYUZjN0Voc0xrVW8wUWRx?=
 =?utf-8?B?WUJUaUFrZ3hzZDdsSE1ZMzgwN04rVW1OUDFyRGlzem05elE3M0JMbWpLZHN2?=
 =?utf-8?B?ZjhzeTlCM3g0NXFBcXJEVi9ibkRmQThmNUdQRTZZUXRyODFJVjBPdWYvTlQ2?=
 =?utf-8?B?c2RYeUFrdDZZU3dxUElSbzY2N2pJcVhLbXF1cnRSL1N6aTFNa0orb3kzb0Vp?=
 =?utf-8?B?MEt3NnpLMjVQZXFJc0ZKNlg2SGZlN2dyWlVtc2E2Q29Fa2pEZFFxQkZ0anMv?=
 =?utf-8?B?V2ZQcjEwS1BYOWhJeVFtZTcxMEhJaDZxcnFoRjhIeXF1dlo4RHdRRDlKaCsx?=
 =?utf-8?B?bTMzTmpuQWs2SWJBV3Q1TnpoMzRtT1VneFhndHIrWjRkWkNOSlBhbnFySkJ6?=
 =?utf-8?B?Z1YyM2ZnRlI1Lyt3UlAwcDJYbkc2d2hWNjFUdm5WU1ZKU3dleXQ0ZlN6Mmxp?=
 =?utf-8?B?Zi9TbGQzajRnYzZIOGMyK3VOekxzeG5MQ2o2cHk4eHFZRkUxOC85ZVVIVE04?=
 =?utf-8?B?Q3RKbllQTUhibGxSZUhSTUQ2SUlCZWc1K3h3cXBvRjJDdTU1alVRZHhoYW41?=
 =?utf-8?B?TjUrQjhQb3ZEbUNGTXAzYjAwcUdDTXE3WGcwK2h3Q2FxM1hibTJQOTNEQXBy?=
 =?utf-8?B?WDgxeHVQWllNK0NKNnUyS2RGa3hGVEdrUUNMbWFQSFN2RXFIMWViRmNDeFhM?=
 =?utf-8?B?VFZuakVwcDR4WTRHSnRKWGJHVWlRS1Q4TmtHVlk1ZmxnZmNjVjhxVVhsMEFT?=
 =?utf-8?B?TkxtVlpGWE1yOXBNSTc2dFUyRTdab3VRbHp5R2NWMnZKM3Bud05pRGRZZmgv?=
 =?utf-8?B?WGpTSEc1OFhoVVFmSWZyalpkRTVrYTFSUnUxenpDSU85T2toZkIwREE4MUdE?=
 =?utf-8?B?SmRDYmZSam5oOThOTWNWRU5Jb2E3aWFoUHRUUEZRNVErRklQazhEeFVkRHpJ?=
 =?utf-8?B?aEF0cW1PRFdXL1VQUnRLYlFoNG4ramNyYjEzc2IzODNNRnFVNzQrb1RLbita?=
 =?utf-8?B?TmFTdS9SN0VCWDZ0WUZVOVFsaVd3TFVZS2EvTEhpRHBEb2pVN1dONVVXVHVz?=
 =?utf-8?B?cEZ0d3grUDB6L01CT1hxR1Z5bnFobzVPV09QUExML2w2QTVHaVJ0L3VjSjRG?=
 =?utf-8?B?QTVxcEF2OEUyalVJZmFpT1RTenJuY3hyZzFMd09VQzYyVXVFaWVCUmtWRlAz?=
 =?utf-8?B?TVB2ckRKai9td0hNbzBFNnNZblNFOCtUNHAyVi9lcnB0OVVyb0dkVzJMMGlJ?=
 =?utf-8?B?RmxHYTRpRTdtdmpjSXh2ekJlVDdsc2Z3ckIvdTVrZ1QzbkVSR2o2Q0VSYnNu?=
 =?utf-8?B?Y1lXRFR3ajJybEhSclZiVkpoTlZwWmdhQnpkREdqaGZjeVJ5STlkR3R1a3BM?=
 =?utf-8?Q?OuPePMYWS/AVkO//CmKqKZfoU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6562e2e-33ef-43c6-9eea-08daf797a024
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 07:59:42.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+NBzKfAHN4052pgQgOpVs/doVYQdWFgTSmzQY/3nGCyCaB8+ElHr3MPl6/7S0ITb379xraVW9wycdmyoyEFvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/23 22:41, Pierre-Louis Bossart wrote:
>>>> +		if (is_dmic_dev && is_sdw_dev) {
>>>> +			switch (acp_data->sdw_master_count) {
>>>> +			case 1:
>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>>>> +				break;
>>>> +			case 2:
>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>>>> +				break;
>>> so the cover letter is indeed wrong and confuses two controllers for two
>>> managers.
>> ACP IP has two independent manager instances driven by separate controller
>> each which are connected in different power domains.
>>
>> we should create two separate ACPI companion devices for separate
>> manager instance.  Currently we have limitations with BIOS.
>> we are going with single ACPI companion device.
>> We will update the changes later.
> Humm, this is tricky. The BIOS interface isn't something that can be
> changed at will on the kernel side, you'd have to maintain two solutions
> with a means to detect which one to use.
>
> Or is this is a temporary issue on development devices, then that part
> should probably not be upstreamed.
It's a temporary issue on development devices.
We had discussion with Windows dev team and BIOS team.
They have agreed to modify ACPI companion device logic.
We will update the two companion devices logic for two manager
instances in V2 version.


