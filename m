Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83D6BD690
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCPRBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCPRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:01:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C620694
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/e0d88mbtfHByKLdjGxzxw2GVkxVaypkR+ZePP1qWL+jO9UCWLGqsMV0gAM6/WSbJbZXEs+eaHUc8wZ/uHk5FT8WzbHZwKzX6XBqF92ki8eE5JgCNA966NoQa/dxUl1A+jJI46C8sN/q6z6eDAx5BD44O494vCN4uBSvsgp4VHjJBnNJzHejOvw1IK20SmUKkq9u71X6WzJ5IBXcPXlfIR873ObNzmg924Ch5sRNPaoNCXodEYfQOQIEHS47XvI3V51D6PIxmR13UFirICOyi/JCqjnllK0Q+7Ru0J6lQ1ebZ8/Afu7eZQy0tf0VW1tSUAlrOp75ts6o/Z4iWPp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IETSoe8q1Y2YOdE/5azTTotdygv7XkaL5m5R71u6gY=;
 b=jJK9Vk9GmmM9s5zOqY05HfE9wVdUfp4Jl2na/nJOSA8VNhciT3ZBINX6yF3hA+TzwkyTUtNJwehG3ErCqfW0HzV84YCA1CA+34xhW+likHAhxUjRoDKb2VF2clZDi8v+YILC7l+qij0Pp8C/cgowudl6rZtq8mF/YToMIeyA+itKAuaoaFlnJcCQbaa0F7ZMu9HJUfRZsZHJIaPnWOTeSCkK5o9g0oc9SgZA2ZDf4mF1LJ1takSFzDf4r24sdugSGs3O7+9C497Dz1t8/2uh/DfYcd+SUnwSiNAI8XthRw51mDTlcTSUVbCw3Ml9ks3RnysxQbB+gS+nLMI1o1HoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IETSoe8q1Y2YOdE/5azTTotdygv7XkaL5m5R71u6gY=;
 b=x5TZ3GVT+3oqVz1NyLMeX0rcHEgv6ywbgluNIOKDLMSWLsgej5A56Ij9j/TpgoENLV7cwG9cg4ViWmIQ3XRelq2hj/aSyO4K7a4sIZqXmU0BQ4WfU/9JNooIuW1PV2NcGVMdk20ccMBjrgX8eCjE5RwYbD71XN+hNpA25PxOmN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 17:01:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 17:01:00 +0000
Message-ID: <3aa704b0-1142-8afe-b0f1-28bd2a254cc2@amd.com>
Date:   Thu, 16 Mar 2023 22:34:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-6-Vijendar.Mukunda@amd.com> <ZBGYubOYyu7E8ueo@matsya>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZBGYubOYyu7E8ueo@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: c28cd56d-2835-4523-a726-08db2640049f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ilnOmq9TBfXvtcEp7jSn5tyRKlyNXyKoPd0ecq6EdWZwlm5UnLGyI9eACnDXAFI0L8J3+IjdDUYU95c+/nj2wDQhpCHYiFhO46qhntT1Hj6meWippz81WotIDq6P4pI6tzWBBiSFGmas7f4QyEcN5JMV/CAoDaKO/L0r/Ug/QrpNQhECFzhjdSJWk4zEW8wCNxBND2UqOcuy+n/HJ6d+1QkLDIxeI2uAdTFiaHgA/r/SO3BhP3x0cg1A0HQ8DzQuVP4LU7HSpraVfFtCP53luNs101vgsLpL49KaJj5CwxZv+Ct0nE76XWMZl7eoVY84kP3NEDxTI2xyDnMb2p6D3xniah9J4JohO+3IGOZzroA4aj40Gf7wrDEzFzSqUqB48Jgte5ayoIePaRIGQaPTlKws31Bwot+1cEMEYPbOJR0ScTsSxqNM4uFUqdsfAaxZO0jXOs6J0eXAdFoBcmK2ODYf717w/OWFnsJH9oF7S6UqKKbFr0tJSz2GMrVq50muzwOQ33T2o7F4ZCNvj+Oyt/5W4Zn14WY+qv7AbzviZOTpMZ532nXTMHJbHMGf7c2pEAGZvkkHyOaFVEB8ynNRzlGjUvNrgj6PjE3toKEouuf4qIKwHdJ0Bfzwl7FV7FwUR0Lo6up2/fuELvbobuObsdZjxYvEfd7rLjMtNdxORsfSr4khPbgGa3jg70kKRk7DZUdi810m8MOr8h1GLWmvxzKoyKzCVDgPAMscUPjZrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(2906002)(41300700001)(8676002)(316002)(66556008)(38100700002)(36756003)(4326008)(54906003)(6916009)(86362001)(31696002)(66476007)(66946007)(478600001)(5660300002)(6486002)(966005)(26005)(53546011)(6506007)(6512007)(31686004)(2616005)(186003)(6666004)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1V3YllISTlXTldJQzBydVY3bWRxdzlvU0ZrNHBMdnVyRVY2UFdkckpUcXN5?=
 =?utf-8?B?bzZIOTlFODVWNS8rOHZSZzhxNDNMbHJSVnU3YWcwVENLT2xqZkRZaWpDTXFn?=
 =?utf-8?B?elFuWDhmbzlNdFZWY2NBNGVNbnRUNHJMVVZSWVd1VFY3OURUN0trVGYydWtM?=
 =?utf-8?B?aUc3ekhWWTlIVW5iNUFiVXJ3Z0plSnJqTlN2Ym8xWlhORHFMV0p0UTBCRitq?=
 =?utf-8?B?VXF4RTlrQ1JPVFBibldoM2RVRUJFRUhnZGdaUFQ2VFRXNVV1VHl6OTYrVEhq?=
 =?utf-8?B?eXZyWkRvRjdITDRuQTYrMXRQeFJmZysvODgzM3RxRHFZUWpXVWJkcGtsOFZu?=
 =?utf-8?B?d2xZLzZIamdYOUVpVCtIZ2p4SVN5c01UdFJJdWhRYjV1d0pJNlN5WFhIRy9q?=
 =?utf-8?B?eVBJdXVnbERhU20zUGl2aE8xelh3RXk5NGhaOTZoSWptY1hpNHptRURBVG04?=
 =?utf-8?B?ZXI3VVR5V2YzNS9MWEpxUThILzdiVjVvMDNIRXpUT2IyeWVxK2tjTGFHOVJx?=
 =?utf-8?B?ZVNwc2ZSWkpaVVlJdUd6aFI3TXpMa2dYOGZNWHhGUmxGVWZLNDBnajA2bHQr?=
 =?utf-8?B?ZEszbk1oWHQrUnlOUXhjVktoVk9NaHdWUUg4dEs1VmdXWlZMUlRqYWl4aCtD?=
 =?utf-8?B?RnIrdlpka2t1VTZ6Q1llK2FIVjNUTHNZVFR3cWtSL0N6WGtRamFHcUZXcWVL?=
 =?utf-8?B?Y2hxN0pPaS9GRzByRk4zbDVnbHV2QldzVjI2WVNTMmdNWGdnTUJLejZncTRq?=
 =?utf-8?B?cERkR2tLLzdMdWdGRnBJR2pSdlU4SCtFa0lldlgxUDdCMW4rSkdFcjh0TjBi?=
 =?utf-8?B?VWRkaWtoWWVMczdZdVpMQUN2TDJGTWtidnNvQmJUQllhZ0kvUjluemxySmFp?=
 =?utf-8?B?Y1BzZDFCYWdzZytqTnY0c3BhT2NkamdzUVN1WXEzdHA4T0NWTmJYanRoek01?=
 =?utf-8?B?VkNJYzU4bFRYUlVmUkRXVFFLUmt1akRQWVVaR1NpSXFSaU5tMm9WUXdPSE45?=
 =?utf-8?B?Rk1UbUxFOHdJZW5SczY1bjZhL01WZXk5TVZoTCtiYVBYbW5ldzBmOTRyT3dQ?=
 =?utf-8?B?aElTVFF2c0ZlMSthNXFTQ3puaTdGYTdqK0ZtbkdCbzVmZ1NXUTI5V0RRQ1RQ?=
 =?utf-8?B?RHpEVGRnY3VQQ21ZcmVzZE5PelVEZ3VVUEkrV0Z4MW00OGVaNUJrdXp5d2tk?=
 =?utf-8?B?alQvMHVhNW1nTlN3bVB1V3pGZTNucTFuMVNuTEVBUktwMTB3Q21aRFZQQnUz?=
 =?utf-8?B?OXZQaTV6RkxvU3Z3MlJLTk5PN0taMkhiYUI4MFh1ZSt6UC9rNUxzSTJKTlpO?=
 =?utf-8?B?T3RNaVFqSFp3QjhNLzc3ZlhHdTlxd3Zqem54Uyt6ajVIZTE2S2VDdlNod094?=
 =?utf-8?B?YnFydXIxTm1QcTdZcDMxK0hHZUszTFltNVlMNnpWYVQ0QS9CRHBYdzVjRXRu?=
 =?utf-8?B?ZHVEeHpyalMzM3NvajlHemM4a3JwOEQ5d2p6N1lSMytyd2hBUmxBbDZJZFdu?=
 =?utf-8?B?RlBjNmNEMGN4a3h5TGwrelhsZjd1b05HUGdPWU9Id3kwU0FrT0dqZ1IzZ1BF?=
 =?utf-8?B?UUltcGNkaGkyczJDM3Y1RGVIYVMrUjlZMTZWeUE4UTRGZVdvRk53VWtUYWV0?=
 =?utf-8?B?UXVBSTNzVHZtcVBUNWZ6c3N0L0VZT3RxUFphOFRoc1hpUWxJSThBRXRRaTBN?=
 =?utf-8?B?SzI3MTZTNHcvcDM0K09KMUd2SHBINlFpcDJ1Rjg2enFNSjFiOVdTSmhaZUdL?=
 =?utf-8?B?ZEZzbmdLQmtpRkRkVXBwb0x5Ti9DR0krNzErQ1VqbWhLOWJXZlFuMk5yOXps?=
 =?utf-8?B?Tkpvb0JHRUVndlc2ODgvMW1HSm1WSk1TcXpiUm5NSHdiN0JRM1ZMUkhBY01U?=
 =?utf-8?B?NTZiTW4yVGZ0NUVuUHZraVY1RXo5bWFwd05nUHNkMTBjajdMM0h5M1VpTTNt?=
 =?utf-8?B?V2hYWHN0SUR2S3pNN3ptUUxZeVhYd2RZM1RFSStCMUZ5VFpPR3JNTnRCL0hB?=
 =?utf-8?B?Z05OR08vdHhQYnVKbDRCSnFjZ29tNGRQNnRkUllrR2hDRTY4bGhKeHJqdnBt?=
 =?utf-8?B?djM3TVUwSFVWUE9yT2VGOEQ3aVpIRjBoN1puQWZLTVYvRVFPUkIxUzdDMFIw?=
 =?utf-8?Q?lpqCOn1Hxd0q4riCBBlDdf+zj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28cd56d-2835-4523-a726-08db2640049f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 17:01:00.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBuPP9uDmQKv9o7doxkZ0ju7qHj17DSvWIi6lTvdiGZRtPkupJtjjV0kkW5X2ssiEYJOxBMryLs5nwwkPVB62Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 15:36, Vinod Koul wrote:
> On 07-03-23, 19:01, Vijendar Mukunda wrote:
>> Add support for handling SoundWire manager interrupts.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Link: https://lore.kernel.org/lkml/20230227154801.50319-6-Vijendar.Mukunda@amd.com
>> ---
>>  drivers/soundwire/amd_manager.c   | 130 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.h   |   1 +
>>  include/linux/soundwire/sdw_amd.h |   7 ++
>>  3 files changed, 138 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index dd7fd4036d89..165078beca2e 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -357,6 +357,51 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
>>  	return SDW_CMD_OK;
>>  }
>>  
>> +static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
>> +{
>> +	switch (status) {
>> +	case SDW_SLAVE_ATTACHED:
>> +		amd_manager->status[index] = SDW_SLAVE_ATTACHED;
>> +		break;
>> +	case SDW_SLAVE_UNATTACHED:
>> +		amd_manager->status[index] = SDW_SLAVE_UNATTACHED;
>> +		break;
>> +	case SDW_SLAVE_ALERT:
>> +		amd_manager->status[index] = SDW_SLAVE_ALERT;
>> +		break;
> why not:
>
>         case SDW_SLAVE_ATTACHED:
>         case SDW_SLAVE_UNATTACHED:
>         case SDW_SLAVE_ALERT:
>                 amd_manager->status[index] = status;
>                 break;
>
> Will fix it.
>> +	default:
>> +		amd_manager->status[index] = SDW_SLAVE_RESERVED;
>> +		break;
>> +	}
>> +}
>> +
>> +static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 slave_stat;
>> +	u32 val;
>> +	u16 dev_index;
>> +
>> +	/* slave status response */
>> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
>> +	dev_dbg(amd_manager->dev, "slave_stat:0x%llx\n", slave_stat);
>> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
>> +		dev_dbg(amd_manager->dev, "val:0x%x\n", val);
>> +		amd_sdw_fill_slave_status(amd_manager, dev_index, val);
>> +	}
>> +}
>> +
>> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 response;
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
>> @@ -757,6 +802,89 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
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
>> +	/*
>> +	 * During the peripheral enumeration sequence, the SoundWire manager interrupts
>> +	 * are masked. Once the device number programming is done for all peripherals,
>> +	 * interrupts will be unmasked. Read the peripheral device status from ping command
>> +	 * and process the response. This sequence will ensure all peripheral devices enumerated
>> +	 * and initialized properly.
>> +	 */
>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>> +			goto update_status;
> goto are mostly used for error handling, i dont thing case here deserves
> a goto, can you please change this...
I agree. goto statements will be used mostly for error handling.
But this is a different scenario. We have used goto statement to call sdw_handle_slave_status()
from if statement to make sure all peripheral devices are enumerated and initialized properly.
Please let us know if you are expecting code to be modified as mentioned below.

sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);

if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
		       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
	amd_sdw_read_and_process_ping_status(amd_manager);
	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
}

We have to check any race conditions occurs or not if we implement code as mentioned
above.
IMHO, it is still good to go with goto statement implementation.
>> +		} else {
>> +			dev_err_ratelimited(amd_manager->dev,
>> +					    "Device0 detected after %d iterations\n",
>> +					    retry_count);
>> +		}
>> +	}
>> +}
>> +
>> +static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
>> +					struct amd_sdw_manager *amd_manager)
>> +{
>> +	u64 slave_stat;
>> +	u32 val;
>> +	int dev_index;
>> +
>> +	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
>> +		memset(amd_manager->status, 0, sizeof(amd_manager->status));
>> +	slave_stat = status_change_0to7;
>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
>> +	dev_dbg(amd_manager->dev, "status_change_0to7:0x%x status_change_8to11:0x%x\n",
>> +		status_change_0to7, status_change_8to11);
>> +	if (slave_stat) {
>> +		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>> +			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
>> +				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
>> +				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
>> +				amd_sdw_fill_slave_status(amd_manager, dev_index, val);
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
>> +	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>> +		amd_manager->instance, status_change_0to7, status_change_8to11);
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
>> +
>>  static void amd_sdw_probe_work(struct work_struct *work)
>>  {
>>  	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>> @@ -847,6 +975,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  	dev_set_drvdata(dev, amd_manager);
>> +	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>> +	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>>  	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>>  	/*
>>  	 * Instead of having lengthy probe sequence, use deferred probe.
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index cad26034087b..807bc5a314d8 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -185,6 +185,7 @@
>>  #define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
>>  #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
>>  #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
>> +#define AMD_SDW_PREQ_INTR_STAT				BIT(19)
>>  
>>  enum amd_sdw_cmd_type {
>>  	AMD_SDW_CMD_PING = 0,
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index ac537419301d..df60bc0de6fc 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -45,8 +45,11 @@ struct sdw_amd_dai_runtime {
>>   * @mmio: SoundWire registers mmio base
>>   * @acp_mmio: acp registers mmio base
>>   * @reg_mask: register mask structure per manager instance
>> + * @amd_sdw_irq_thread: SoundWire manager irq workqueue
>> + * @amd_sdw_work: peripheral status work queue
>>   * @probe_work: SoundWire manager probe workqueue
>>   * @acp_sdw_lock: mutex to protect acp share register access
>> + * @status: peripheral devices status array
>>   * @num_din_ports: number of input ports
>>   * @num_dout_ports: number of output ports
>>   * @cols_index: Column index in frame shape
>> @@ -65,10 +68,14 @@ struct amd_sdw_manager {
>>  	void __iomem *acp_mmio;
>>  
>>  	struct sdw_manager_reg_mask *reg_mask;
>> +	struct work_struct amd_sdw_irq_thread;
>> +	struct work_struct amd_sdw_work;
>>  	struct work_struct probe_work;
>>  	/* mutex to protect acp common register access */
>>  	struct mutex *acp_sdw_lock;
>>  
>> +	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
>> +
>>  	int num_din_ports;
>>  	int num_dout_ports;
>>  
>> -- 
>> 2.34.1

