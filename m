Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10C26958B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBNFyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBNFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:54:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7093D4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 21:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOfjZtfcL34NSsXo4qZ2mff+hu2N58u1qQ4MOOJxne7zFMgMq5sfNxDB3NummRPUbaAVMVd02KZ1SzAcKwhPWodGW5S6ySYbHCuO5rNPm/PvPMI2yM16wTds6/MIjbi1Lj+PULsoyOmN2wvi1VtoToAvlApjrwhcwnawDUPxzJq8Hvkt4+okrhy6WUNKa8LIrrVy7EhUl/OUZZ8KSixZENz0soojC9pBbgb0WmdUc5sYMjmspqTFewcQijY3S7hO4aPMK3WpZ8WOlLVHYGmJFSUmXfX9YN6U/N2oM07j3BaK/CbjLx57Yb8Mh28GQOpYRpa379dc4ueM5Bz7pFLS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXKz/72GONtrXplI02w3UeyL8ulqawUyBz+y4BdsWik=;
 b=FRwc1ysYk4O0Ifr2+YBCGkCQlc/0AYBuaVRjDbD98ADVDY1oB0sk/AbjG/wRxCvz59YTDhUc6JDueV2W1pjoaLTnPL+VQBqM1j2SCvGnJCsjZbAkV+iMO6p0Y3WLwj6wNEyEqWzYKS7+e32CUZfT1rF94M30k77MbmF2MnfHaXv4Di2MImUA4CJgkQDGj491F/y5flV4Lvdqq2z/Q46dob9JlrPwMlu8mP46pJ8FnWEIR59DqALhoffpGA4fNqXXtNoVbJePrPtLXyrvO57UGsXp6DkALmlHxNGqiYb+9WPY2gFsXTzN9RcEii15gC8KUDJFYFtmcp+pwRqGlNYFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXKz/72GONtrXplI02w3UeyL8ulqawUyBz+y4BdsWik=;
 b=0o5RRy9yBYsdlhQvkIvhNt54fIO+qRPCmgNaqOwzLm95p2/29ZIbfCVTpiodpPNqLPwimLPGZG89ISEyEUfLIfoRm6sP64rIb4gYqL6QD2QUgmMTTs3Qw47045g9V5SxHlrjuyjXk5RuBByDzu2TA4wEi27dzlaJk0uLGhcM2AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:54:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:54:00 +0000
Message-ID: <2fc1191d-e57d-4b76-1c9c-088e33f2ad45@amd.com>
Date:   Tue, 14 Feb 2023 11:26:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 5/8] soundwire: amd: add soundwire manager interrupt
 handling
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-6-Vijendar.Mukunda@amd.com>
 <9505941e-73a1-249b-08c2-83b86e7ef5c6@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <9505941e-73a1-249b-08c2-83b86e7ef5c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 57acb544-0f3d-4ac1-2d06-08db0e4fde50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpBxV64QzaRG/LuDAia3g8x+eV+/kCB48rP9M+E94+YQKwQSaQMoANW4E4ELQOEs+Q+HzK6Tt88X/tfHTBzDzCT5eN+3TVyqR5ft7Y3//iZn+NhQZDMu39xBIGo0vA/+G4pT6TDmuJidPtZg7SR2V/ATIMG+QvtvWQ7Px+SLsI1WaJ9VrJIbRvMifAaUBP6iEH5shUhRjMTJ061Kap/pwMxJhOOaHRFn7prR5qjVIAdI+LLDCzx3Wr9Bqczp6GtmTO8Xd8m76E1p/Hz2T+gB0mfyfS23v7zM0zpp2E7WOo+ERt1L2UTBZCEf0YNHslY/t7cRlIQsBVnhaZ//+V2kp0906dLW3yUd9yzXieW0muPKe8NARuq0V8Wcb6WUkXB2QJURzSw9u3nAQj0J8DaUEKUm9jnRHh1cC5+3/dULbuQ66Lma/70+C/kdBcaLDU7mUIWFBA/kiPT2q6r4OaaL9SiO5pjUxlnTOGqkTIce+BKe/m1vRkBsteEhzYFoL/EC9pAwPBeyP4XVe+jvk3rSzaNSb0A+h8rISdi7hWiA2CjJIM0AumTTzVOIYdcO4R6mHgmx1t5wMIa7kZAnCC4+keF0s5r0W4Wjzt22xQ9tDKgr+Ioc/S5dzYeduTEEyVXxnRWGfYTC6laAHHgme5Qtv9cWHeA9IE1VywFgVLOTLrlKq1e6xYiKfrPENjmoHH98ipeG+BaLW5GtCRsLFSyKQsgZD3ZkLaI0jG13I7s4y1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(31686004)(5660300002)(6512007)(83380400001)(26005)(186003)(36756003)(2906002)(53546011)(6506007)(31696002)(86362001)(478600001)(6666004)(41300700001)(6486002)(2616005)(316002)(54906003)(66556008)(8936002)(66476007)(8676002)(4326008)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdaa3dzSjZ3bTlmYzhOQy9GQmE4MmhFRWtuRUNkbWM1a2w3MzFVVmxNMkU5?=
 =?utf-8?B?akF1ZGkvOU1IeVoyQ2diVFhCNkpCbFBLYnFuMXpGTFIxWWYrUm9PNktiSVV1?=
 =?utf-8?B?dGZKYUtIejBrMmh2YzQ1a3l3eHFPRTU2UkpqUEFhbm9WcDBySWpjZ3I1Z0tP?=
 =?utf-8?B?VDAwS21QMVBtdVRIdW5EQXpFYkRacitlbGdlTENBRzllOTNFL0s5amkvRzE4?=
 =?utf-8?B?YklXZWM0dW9MOEpLNUFkRlhKU0tRS1h2Q3RUaVB5SVJMRldVbFNueG9xNlQ4?=
 =?utf-8?B?R1RjbWU4VzFVWDhMck1hSVFoYkxGcDF4TmVuMm5ST1RlZGIrYjdDMXZpMnZ6?=
 =?utf-8?B?bXk2SlVZclZHQkZkZmRoRExDSzlZRHBNUTZZeHQvQ1lSRFZnMXM3N0RnTWNZ?=
 =?utf-8?B?dlZsSURHRHcvZGlTZi8wNEoyM3VvNnAxcVBlOEVjYXAyc1ZYNU95Wi81aVhw?=
 =?utf-8?B?NTZTRXQ5Qjd5dTBuU1l6MUNlWWVvR1BxNzllVmtjSi9OM3czck5pQ2dGazFW?=
 =?utf-8?B?U3lZTXQya0xBZjRRRzdyNDVlL3REWVNQZ3BSVUVkVGM4TThPMmFzSkM2dlY1?=
 =?utf-8?B?Y3E3UVcyc1NBb3hjalh4MEZFM0xFT2NId25KUDdaUGtTbXNlRy9RckZLVkhq?=
 =?utf-8?B?YUNOYlFGYlFHdEhMVHFCQS94UVZWNjFNeXRzMmZrRDBVZzdhMUdDeDJRVkNS?=
 =?utf-8?B?UThENlRwNXRWSkFPck54eU5yaVNhY01QM25GWFRjeW93M0dwS1dKNU4wMjYx?=
 =?utf-8?B?ZUxqN3l5OEk1cDJNaTgraXh0WC90S2FYWjk3cE9SR3J3UVZSa0hIV2c0VUhE?=
 =?utf-8?B?T09sdWRRdTkzOW9lWE44dUg2Y3hIQU13SGQ4Z2Y0Vlo0TTluc2hCK1dTeWZm?=
 =?utf-8?B?QTJNb205R1lKbXprSXVlRVg3d2tuODJzM3ZET0RJL09NR2VZMnp6L1ZmSEl6?=
 =?utf-8?B?RDc5cDh3SHBoVnF0aHB3TzRBQkxTSXBjb3ZkUG9zL1I1d2VLMVdLVk9qUFlO?=
 =?utf-8?B?eFNDZFA4WkdpK1M0OFk0MlN0c0ZicTVUUmdqVnQxdW5zN085VlZ2T0ZnWXhv?=
 =?utf-8?B?RDR6d0hTRFN6aC9NR2RHckxVK1ZSM3dPQ2RYTnU4MG9XYkdCSVJ0Wnl6QjRv?=
 =?utf-8?B?NUF3NnFUdFlCUnk0OStQYjhoYUNkVEc5TXd1Njl4UGllcEY4ek1kbktCcWpa?=
 =?utf-8?B?SHdHMzRqL0haM1NpZERQRG04YTFOVmYrS3djZzJjdEtoQkk4d0ZLTW9YZGpN?=
 =?utf-8?B?Y3hZTGR4bjZvcjBRcGhVMm5HcDJyeDd3SlB4RlllRXlaanc0cENma045RmJL?=
 =?utf-8?B?OHcwNjZGMDM0RjZnSi9Yd2x3RnJnSHh4WndjV1B4VU1OUVc0dW5BcTlmbGo3?=
 =?utf-8?B?UzN5SmFVRVdpQ1pnRkh4NHc3NWNnUm4rRm84dzZwSHRldnhJS0NKb1BxbzBP?=
 =?utf-8?B?RDlEeVl1QzBsT2JMS2k3SUpZakhnL0QxS3lhd2xpVVNRWWt3TlhrU2tPWnUw?=
 =?utf-8?B?OEpLU0hmK21YZ3dFTTFwdFh0TVJVRG9lZkdhRHg1VjQ0WXJYdVJ5VVpaOEVN?=
 =?utf-8?B?QnE3R09IUWE2K3QycnVKUlRzOEVXeUhQRlJGNHV2T2RRU2xKV1lNaS9oWHNY?=
 =?utf-8?B?UUdOUHI5UGNWa1U4RS9SazJKUFo0YWZja1E3dkVPN2dVbHdhem9tZlI5bWZN?=
 =?utf-8?B?NUloTHRzV0hFRlF1OTNaSTNLYmRob2Q4YS9zNmxzT0xEbmR2RDFjK2s3aE9E?=
 =?utf-8?B?YUFFVUFQMkRNZUlXZWdBN3BIdE16cFhXVnJaNERXbU10MnBhTENvSklpTUxx?=
 =?utf-8?B?OHNSeEZ5Z1JGb3VCVmJCOGV6Q2htK3BleWlEZVVCSUdBSXI2L010VWhmT05Z?=
 =?utf-8?B?bUU3QjYyc2FLMENOWHFCamR2b2JOWVNMTFZGTU1qZE9mMlZzclJxZWRIQUVN?=
 =?utf-8?B?N2p3TkRsWGNPcjMwMzM4NGtuS091bVNjUjZ5QUNtcVZuSGhOWEhuREJKdlVo?=
 =?utf-8?B?d2RDNE1mS2lvQkxmK3NMOVJNNGZFbll5bGpPTkhralN4VWx4eXo1T0x4UXRJ?=
 =?utf-8?B?TE1udkd5LzFuK3FHdXMzYWJsalFQcHQ1Ym9MNWhTdVg5NEw5aGZBVjNLbjRI?=
 =?utf-8?Q?9zhq66SEa4+N/YZAWSwhTCc/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57acb544-0f3d-4ac1-2d06-08db0e4fde50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 05:53:59.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dXYYt6jmfy+u+Ex4FpEyZVJfOoAVx37UK5UrWglHAxKaXeAUQyHk7J2u/WJjvH2UA3kyKFvKWRljvNx5J71aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/23 23:45, Pierre-Louis Bossart wrote:
>
> On 2/13/23 03:40, Vijendar Mukunda wrote:
>> Add support for handling soundwire manager interrupts.
> Try using the MIPI spelling: SoundWire
Will fix it.
>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.c   | 132 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   |   1 +
>>  include/linux/soundwire/sdw_amd.h |   7 ++
>>  3 files changed, 140 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 14c88b80ab6d..87f9a987d93a 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -417,6 +417,47 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
>>  	return SDW_CMD_OK;
>>  }
>>  
>> +static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 slave_stat = 0;
> useless init
will fix it.
>
>> +	u32 val = 0;
> useless init
will fix it.
>
>> +	u16 dev_index;
>> +
>> +	/* slave status response*/
> response */
will fix it.
>
>> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
>> +
>> +	dev_dbg(amd_manager->dev, "%s: slave_stat:0x%llx\n", __func__, slave_stat);
> newline?
will remove it.
>
>> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
>> +		dev_dbg(amd_manager->dev, "%s val:0x%x\n", __func__, val);
> you don't need __func__ in dev_dbg() logs, they can be added e.g. with
> the option dyndbg=+pmf
it's overlooked. we will modify it.
>
>> +		switch (val) {
>> +		case SDW_SLAVE_ATTACHED:
>> +			amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
>> +			break;
>> +		case SDW_SLAVE_UNATTACHED:
>> +			amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
>> +			break;
>> +		case SDW_SLAVE_ALERT:
>> +			amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
>> +			break;
>> +		default:
>> +			amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 response = 0;
> useless init
will fix it
>
>> +
>> +	mutex_lock(&amd_manager->bus.msg_lock);
>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
>> +	mutex_unlock(&amd_manager->bus.msg_lock);
>> +	amd_sdw_process_ping_status(response, amd_manager);
>> +}
>> +
>>  static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>>  {
>>  	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>> @@ -817,6 +858,95 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
>>  					       dais, num_dais);
>>  }
>>  
>> +static void amd_sdw_update_slave_status_work(struct work_struct *work)
>> +{
>> +	struct amd_sdw_manager *amd_manager =
>> +		container_of(work, struct amd_sdw_manager, amd_sdw_work);
>> +	int retry_count = 0;
>> +
>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	}
>> +
>> +update_status:
>> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>> +			goto update_status;
>> +		} else {
>> +			dev_err_ratelimited(amd_manager->dev,
>> +					    "Device0 detected after %d iterations\n",
>> +					    retry_count);
>> +		}
>> +	}
> this seems rather inspired by the Cadence code, but is there really a
> case where you need to re-check for devices? In the Cadence case, this
> was added because we have a logical OR and new devices would not be handled.
As mentioned in V1 set, we have corner cases during enumeration sequence.
We observed device alerts are missing during peripheral enumeration sequence
when multiple peripheral devices are connected over the same link.
This is not inspired by Intel code.

As per V1 version review comment, we have included retry_count logic to address
faulty case.

We forgot to include comment. we will fix it.
>> +}
>> +
>> +static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
>> +					struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 slave_stat = 0;
> useless init
will fix it.
>> +	u32 val = 0;
> useless init
will fix it.
>
>> +	int dev_index;
>> +
>> +	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
>> +		memset(amd_manager->status, 0, sizeof(amd_manager->status));
>> +	slave_stat = status_change_0to7;
>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
>> +	dev_dbg(amd_manager->dev, "%s: status_change_0to7:0x%x status_change_8to11:0x%x\n",
>> +		__func__, status_change_0to7, status_change_8to11);
>> +	if (slave_stat) {
>> +		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>> +			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
>> +				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
>> +				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
>> +				switch (val) {
>> +				case SDW_SLAVE_ATTACHED:
>> +					amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
>> +					break;
>> +				case SDW_SLAVE_UNATTACHED:
>> +					amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
>> +					break;
>> +				case SDW_SLAVE_ALERT:
>> +					amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
>> +					break;
>> +				default:
>> +					amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
>> +					break;
>> +				}
> the code seems identical to that in amd_sdw_process_ping_status(), is
> there a need for a helper function?
will use helper function for status update.
>
>> +			}
>> +		}
>> +	}
>> +}
>> +
>> +static void amd_sdw_irq_thread(struct work_struct *work)
>> +{
>> +	struct amd_sdw_manager *amd_manager =
>> +			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
>> +	u32 status_change_8to11;
>> +	u32 status_change_0to7;
>> +
>> +	status_change_8to11 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>> +	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>> +	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>> +		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
> remove __func__
will fix it.
>
>> +	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
>> +		amd_sdw_read_and_process_ping_status(amd_manager);
>> +	} else {
>> +		/* Check for the updated status on peripheral device */
>> +		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
>> +	}
>> +	if (status_change_8to11 || status_change_0to7)
>> +		schedule_work(&amd_manager->amd_sdw_work);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>> +}

