Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810A62DECB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiKQO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiKQO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:57:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4B7342E;
        Thu, 17 Nov 2022 06:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3cIuOayR/sJsPyafcTTwrUxPrDZ3hn+iylMbMh0hY/JFyKXLQeXsn+2HvTR1F4v+Ax7c4ZwHu1zwpx0x94O32PFKvwfC4f9iZZ7AlctKVDNgwyZIPoTtjJ5ooogj3pNDJihzFX2J47FxOLi4442TXrvqbWcLmdDS0DbyFRquwmUuR6UYZZcIdo5+JvyhewbWAbpLcjc4dNHti+COEFno8kVX+U/a0+2beYlKmnmCnvRzLTkNPJ/l8+KRZ6h3m4PBgjExEGakQBgdvhrSvLYbyMVrjSAT7fhniJuVZ9S/pllF48vAYbFZetkSjye+StpNQZ+/Ajqxeeead/5OflSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1SFnrRkMukS/8YUrcksy0CcvxRnIbK2qLMjo/fqD04=;
 b=iF+QxCG/6uNroVeWlDC7yow2SOCJkGIN8ZX9iueIYdiNWvXufHtFxyMSAea0BES1CU7ZBNCYVBpfaNWM4kl4/HghCfQtupjbzl/TEFtDZAmtlaxzmTeYIEijgpSLV3+jTCQLRHZlFwY9hkPhTNpepHp/HP3JbQRqwtdNZwyPk8zlfSH3btD1fYB03Rka8lcda04pFugM7DarbZgYt8kvejkEZIve7IiZAuDhBCoy1nOSg0HJl/vSX2JHaHYGXYuTiN7SPWlNksbQlmvoifdiH6cittDm4C4eeRjuj5OwO5nNYmnx7fcgBxjGq2+MWT8E/nRceWGHyfFchMjDStAsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1SFnrRkMukS/8YUrcksy0CcvxRnIbK2qLMjo/fqD04=;
 b=k8O/BcNCqVwLB+/1dEWMtj9KkKZYh/f/sA0vAJXlbc4n9gYndRE24j8FqtR9LQfrlQrNHwW2nDs7BhSFT77cNP3tTHk/Ff1bIojqjveyIMVa30UqYoW+5Kot7e22GLJc91z+0RSaus6YxzlPi+lDd5vTx5Fll7/qDmFVmo+m+NnlbTpZddh+DQXTT+nmeOmltSWGg6t3mSFtLSkvbulGFVmaKAGDBO56BMaSIb/Ajwpr1Cc4ytyxl49abb3g25cyFH4K7NoRxwx708HxZZPFC1Rg0Zekpi3M4BwZc6rrEkzSMc9fYRLfFHtGDKknWHP2VG2kgAUCzPvBIKqGIREZcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Thu, 17 Nov 2022 14:57:27 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 14:57:27 +0000
Message-ID: <bf577f21-6c3c-8fb3-9150-17e7500c4c7d@nvidia.com>
Date:   Thu, 17 Nov 2022 14:57:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [WAR] hwmon: (ina3221) Apply software WAR to offset shunt
 voltage
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Ninad Malwade <nmalwade@nvidia.com>
Cc:     treding@nvidia.com, jdelvare@suse.com, nicolinc@nvidia.com,
        rkasirajan@nvidia.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221117083226.20027-1-nmalwade@nvidia.com>
 <20221117144709.GD664755@roeck-us.net>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221117144709.GD664755@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::30) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 47033eb9-35b9-45c1-999b-08dac8ac0b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeUFg3VlKFisjo0MpxNzNxqkZNDbRRTPOcyUUGUxv5gkwJa1MRv1CFE9CJrBs0ne6P+IiQ90FZ7VN8Zb3Ww+K9hij3otB/U676xITp1MPaszr/7ma9GySJkyySJbzmxyrCwrgK/ZBKbJ6HRekp4Oj2SlypqXa/Lc5WPMYdEYgzyyAXpVbcBTUW5geUVsuTDrnBpQ+0E9fbtr/sTsQUSPDoLU4m+gkMhJwztTQGz695ZlDGtxhhZC2YCwPoCB96yQCQFMKqOqZCJ9Dzc1q+3QOIn0G24RN1OOQtYhDKOfItIfjvE4ymea1bO5Br/2KRQIHc+1uc2puzDRASLCjLKepqkfwDhaVjMDitncACjwXppksN6G1nCQ5dtui9cTDpn/d1BbvhFWXGgUpcRtuR5cZN4M2gWo2O6Z9EKpqZqcN9/ZuTWU6wc0RTSSP8QQ09R/GMFUO0GwHnDpbJhPABxvKV4ZBcSBFO5P8PlNvGN5bYJcGunrPshWpJvyfkzmfjEI3pdMWZtJBLq8U/e1lfpYx9Slw7JLX0no5eNSwQ58XtY+tDoAyJyLPwnJhCsxaLTY+yIRRUOKj1Pdr/D5RNoKGVm5Yz2AvK61U5GVI57Fu2Y+FMh1ULoUxV6d+8X0HUkGuzI6SwpEduv2aFeHjGB6DMvMH/rZUWGW2owjqIIOrNsEbYu6MdQdb5+OH8e0HLx0Wym171XkCvQfv67HHAg83scun7AmoHZLRpb6u2En6lGvOtCIfgST4vx6y/HFuN+WyvvfE8t3SbVqfCrt34o4HkPW3oD0Ct4UW95nDzTM5yMhAcU/fGaFf2Fndawsxf8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(4326008)(8676002)(86362001)(31696002)(66946007)(66556008)(66476007)(5660300002)(4744005)(41300700001)(8936002)(6512007)(26005)(2616005)(38100700002)(6486002)(186003)(478600001)(53546011)(55236004)(6506007)(36756003)(6666004)(316002)(6636002)(966005)(110136005)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hDMFk4RGp4K083Q1NSMVlrZWVlVUIxV21USGRodDBOZHU4SFlsSHQxNFVn?=
 =?utf-8?B?UkNDM2R2bzJLWkt1ZlplYkZBd1BvZURxT0k2Z29kODhZZVN4SHNQYmhmeVU4?=
 =?utf-8?B?OFRoT2NMQUREc2U2QUZsR3c3NVRuNWF4QlhmeU9IS1JYc1lweTVFdlZZQmZ2?=
 =?utf-8?B?RlJEZHdmei9qMzJQVk4zdmRYMFdvWm1BdVJwejVlWFV3Mko4MHV1dXQxZVh6?=
 =?utf-8?B?WElpaFBxUnNGV3RvVFlQY2hiam4zQWx2YXV3cDlVdUw5aEpRWmVyWjQ0RDJz?=
 =?utf-8?B?NHRwOUFpQ2p5SXBJU2grYWJrKy9FN3RPRUJRM0N6dWk4VUFOTk9jWDFHd3M5?=
 =?utf-8?B?ZkY5ams1dFVSNFdIS1M4NGl6YmJKcThJUEFLNUtUL2NmQlhKVjcrNlhnbDZt?=
 =?utf-8?B?VXB2SUhLQTJVVWtwUU56d2JyVmxNQ1d6U09wbWtHRVdxY3N6QVNRU2pBZHgw?=
 =?utf-8?B?aTVBRDVwUGdPYm9VblRmTXViNVpoT1FKanNxSkwrNXRBS21tWXI2WXBSNEE2?=
 =?utf-8?B?ZGRzVHVSMWt2czh5eTVQMDhBUXdMYWpDMlFOWVVZcWw5THEvTkdkVGs5SHJM?=
 =?utf-8?B?YTE3djUxdmNvRVBGSU1HRzBGNjZ5SDdMbmdLNlJNcThIWkV3SDd4Q1Z5SUd3?=
 =?utf-8?B?SU9JR0F3NlBnZ0FVUTI1RTBBanBzcXJ4eE9kcktRMkFwU1pKRnZFWktWaU9I?=
 =?utf-8?B?YkJFQnJGR0FjbnlydWNuT0lKdlBaaUFTOHhKbUp1VmFjUC9udFB0TmVDT1Ny?=
 =?utf-8?B?OXF2c3VIbmh0WXNTK2VrN20zVXlJUk9WS05PZ3lkd3hLWWdLbi9OYjZraEtk?=
 =?utf-8?B?b1JwUzRSamx3Ynp4SHp4ck52eU13VWZRNEpCc1FUZWhJRXV5SlIwVHpvdUdn?=
 =?utf-8?B?V04rdjlqZHQ1Q3hSblJlM2VGcFUvQzhCL2NiV2tpblJlVy9VWUJHeEM2aVJU?=
 =?utf-8?B?eWJyaHhrelk1VUN5RGViNXJXS3g4OVFHbU5yV2k1UEhjekpUbjNzekMvd1NB?=
 =?utf-8?B?SXpjQisvdi8rUzNKblJCLzhvZ0pDN0FPMTF2NUpYN3FDcUVQRVcyTUs5K1U2?=
 =?utf-8?B?SnJKeWZhdldhb2d4QUN2SjRDR3dYMEV1YkVIRUFHQ1FYaVI1M0JoTm1sOVFY?=
 =?utf-8?B?Qit3dk5pbE9CNy90Vm5DaUJ3a09KMXVHY2hTS3ZyQWwrZlB2dGE5SDFVckJr?=
 =?utf-8?B?UWN6RlZYOUo1RWJDTmJWc1BsVUk2UE5SSXdMREJtY21JVEpOaEZNTndLa2lT?=
 =?utf-8?B?UWt1OGNDV1ZYUXI4NFB6Y2I3WExHcHVrZ21XVSs0dDZsek1tL0F2bGdSem5z?=
 =?utf-8?B?YlZrNU1aS0hYM3g4ekZhazlpMmEyKzgwWWdWYjgwT0pMVW9WWWQ2YndicjUr?=
 =?utf-8?B?cHFvZlZQNFlQSWZlV01HMHpwRFBJOHdZMGFHeVpOSEE3Zy9ZdC90eEdkNWk4?=
 =?utf-8?B?eE5xaTBJaldGSllSYVZYa2JwMnNQeHVTQ0l6alBpNEM3eGdicmwwVVRBaFhG?=
 =?utf-8?B?eDJnQUt3SG4yUjcrS1F0bVJxT2kyUTl6SGtyUi9Zci9mWlVHMjM0dXA5NVdR?=
 =?utf-8?B?UmE0WHEvUXY0TDRHU3o5bHdUOXNHajJCa3V3VDhuU1dZSkxiM2NxNFpjTkhk?=
 =?utf-8?B?SVc5WEdzbTR4OTBiWXEzVFA4ckVoWnhhK2ZnV0l3dC85Mi9lNDUvU1RheGVs?=
 =?utf-8?B?TDdEOEx0Wk1pNFVCRGpJRGEwK3kwOEd0TTdSNnNGdGhJa0tUZmkvMTlKNzBU?=
 =?utf-8?B?b1VWUkUzR09VRHQxOC9BTHJodE9QZW9kdmZYZkFML3NEeXNUakRlMTY5Q29y?=
 =?utf-8?B?d1p6anhKdU4zWEVXRVY1K1BTQ25xeXlBRDZnRmEwcDZjcy9aaFJMQkFBeFBF?=
 =?utf-8?B?Sko0SGRweXpCZ3FKUWNuQzVIUy9seXBubkJhdTRXWU5kU1dhZUVYZXg4YzZm?=
 =?utf-8?B?TVlZUHFiS0g5emRuQy9XS29KWEpLZ1p0K2NSWWcwck53TUwwUzhwYWsxT0VM?=
 =?utf-8?B?U2VVZktyNWJmRWlxbDdTRWRYejNRQXVvbTFQbkl6ZU9iRWFvZFU1WjAwTkNz?=
 =?utf-8?B?SW01V3VOa3M1MjJCS3ZTWDdZQUd3Vm5JbFg3bURUcndWUHhFZ0QvQXRZRVE0?=
 =?utf-8?B?U0EwYXNwd3hwUVRaSUc0YzNETk5vcmIvYjg2WXNaQ1MyQ2JQV3E0amtCbHRs?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47033eb9-35b9-45c1-999b-08dac8ac0b20
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 14:57:27.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIr3iRlJDD7K41oR9XQpsaXeA4pc3cCcXsQF7bA8L6V+kssc8S5in8vH903TU6VSmudt6Lx3zSIYs6egwl4swg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/11/2022 14:47, Guenter Roeck wrote:
> On Thu, Nov 17, 2022 at 04:32:26PM +0800, Ninad Malwade wrote:
>> This is used as a software WAR to offset shunt voltage reading
> 
> What is a software WAR ? Or a WAR in the first place ?
> What is the relevance of the "[WAR]" tag in the subject ?
> 
> None of the definitions at https://acronyms.thefreedictionary.com/WAR
> seem to apply. I am sure it means something for you, and it seems to be
> important enough to use the term repeatedly, but please do not assume
> that others know what it means.

Indeed. I will work with Ninad to correct this.

>> from INA3221 to increase its accuracy. This patch implements a
>> previous downstream feature by reading the offset information
>> from DT and apply it to current readings.
>>
> 
> Where is the devicetree documentation ?

Yes that is also missing. Let me sync up with Ninad offline and get this 
re-worked properly.

Jon

-- 
nvpublic
