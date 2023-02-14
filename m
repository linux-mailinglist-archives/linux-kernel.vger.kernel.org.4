Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358D8695B16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjBNHvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBNHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:51:20 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0275320062
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIXDbNT9EAX8U/Jlfbf0/EPyZOVzXHqQ1AkGl+fYd8FP6OjaFQyrPPv9/kS9018uy49g1eeV/Gie1AreoQSvervGQmfd5Jbw9A1JYZg5kO3hWao2MHjDgPWT7hNRJmunVY686iieXtjFcGq2/r9h0eGnRiyMKYQQTGgkZZVNLgxnsfz8BTja+V/L8xg0zeAtwg5HBj160F/BAVOeJSboqr6JRsiUSnWTSYX1C+Q/zKYoBgH5Pk+78Q3mKc41hFoH8VCSZytZGSLnjncfRP4SMSuMgTV4cLZBu5762Vf0GDcAQ6+DFdqL5j9+a9vC7aO2LcN5+Ebdv0Cw9XEgNS39fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYKbTmJ/BzzrFySna5WkHLo6bhfWfhl6IbUl/9d4K9o=;
 b=HFoIM1RtQAxDn4zfLOnx4glRTPE+W88l4L2oruT/krsV2NPLJIgJd9duHcbHgV1q3BsjrouElcozYC26sv6YN29hQjwZ1BeKifpw9Qs+Gkg5Cw4QA6WQsMxJ/soSQWS4k1+I5Lbv+vwN2xtCQJoZvJj/kEPAbPZ2XoT3m42GN3UA6hvpin1X48rq8cFuFy6+/8o+K4MtY1DtnQEK9RdFzLwVZE4voBBeyCgS8j9wwMp6PWV9gamAsYn5dNEMP6DbBrzDRk4lTt+8qhAVLl4PtiysE3+2Qyyt/3sL9KMp0ksoz4AjK6FTJASrCrdXxt+24dTur2H5EhgUvyr/mtMzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYKbTmJ/BzzrFySna5WkHLo6bhfWfhl6IbUl/9d4K9o=;
 b=0cAN/26xYCjF8LHOc8GxvJKRRDjNV5ZatIHLkLH4Il5OIWajEMy4Ciq6hhTL8GPd0PIKJhigxgenLJPHMPNOCi7My0dw1mXs8sNda1aB6VDQS+DFbZyJ/B7KW4i4n31yhMZd8I8ywF+qnuAR2kVFzpWCFWfYig7mzgfFB0rSTrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 07:51:15 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 07:51:15 +0000
Message-ID: <f739053c-d19b-f773-cead-77abad53feec@amd.com>
Date:   Tue, 14 Feb 2023 13:24:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 5/8] soundwire: amd: add soundwire manager interrupt
 handling
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
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
 <2fc1191d-e57d-4b76-1c9c-088e33f2ad45@amd.com>
In-Reply-To: <2fc1191d-e57d-4b76-1c9c-088e33f2ad45@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::9) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: fac0ecdd-e653-452c-1dec-08db0e603f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0Ud7fKZ7ig/bFJxaFq2VjSlKPi4EpHRA0xSiMuBSfOvwnB5RRm5O4Rbj3XDcjOvpG2gupKs5vrJmaF1xv/Kbz7T0IC90CLmXKz5YeHkabLOBjd303K1Lu/8tSJfj79Vu1giKE8itZrJjhj5DsWkrxTGyMhxO2bERxnjsLooHX01sYrocr6XezF4UWWqdcH6VPI3M29r6fx95KIICUDwD8wZoeJkduUVGfZRPSw7sRxg+iQ6Fx++j6viTNk/6Ss3IpE/kfReYSNEWegTpj417MA4LXp9dB/EmcQHSoa0hbPORbOrHWUGLDYsIfVD0pFyXJdoiNb2owUKHfKkKAFBHs3VkZZYMatdPJvDhzw3Vb6rL1e0O17GtII4syXEmsu4iCmrxS+g7d5VHRIIktFDcKWYUo+M2jqd9csn6e8mIryd6T+AEi7FJT/DcXJED4XmtqBKTC00f1CHg1TWWlKbzzmWIsE3whu+EwDLS3mgYgtB2+nDJn3/F7B2PNrS294hdYjW5EG9Wn2rieuWcPGMG6ZqBMYJ4e+Klf6upANjlfk8vyNBxu+OAVOp59wxjDZDgN8Ujf1mG3oGh51ssu6TupI8Ln615pae02wUGWBknVWkA+IGzEVWVrqsZN48Ie/cVkzlHV7QdtbFuXyQPODEQE65tFlU/WVpHQE3r5OWUh8tlsS5dP0qXxN5sklNdQ+4eGzTpw/Vls7JgGX8vcE2lGYsPnikxzmSRfEavB0tdnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(31686004)(31696002)(2616005)(83380400001)(6486002)(2906002)(26005)(8676002)(6666004)(478600001)(53546011)(41300700001)(6506007)(186003)(86362001)(4326008)(38100700002)(6512007)(8936002)(36756003)(316002)(5660300002)(66556008)(54906003)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNRQzFnZ0RNMHZHOGhPWnU0ajRpVGhmSDJJMEFOV2c3UithUVE2Yzh2RERF?=
 =?utf-8?B?U3MxalBRaVZ0ejBZbzJ1YTJTZU02b2RVVFlhZXVSYWJDemo2MUZzL2tkRnBz?=
 =?utf-8?B?eDI1WnA3THRBZGd2T0JGQWltTzdobUNpUU53T2EyWFI1NE52cjFqbS9nQlZ5?=
 =?utf-8?B?cWg0K0hiK2FsRjJMVU5kblVJTkNDYnJhWmNhZ1hueEcvL0QrSDVmdDIxMHhY?=
 =?utf-8?B?TUhrNDIzbHluL2srNmxLeS9sMmEycHFhV3FQRHVaVEc3T3hsUHZjMkZzMk14?=
 =?utf-8?B?V2s4dXpRY1puTmJRSVBibnRyU2tDSHR4NEdSVUhGY3FRWk1NR0tuaUwzQmlO?=
 =?utf-8?B?VE9vaEYzbHpEdmd0azdzQ1Rha1BJUDdFU0pVR0Jjcmh2N2QybVFtb0hGajFZ?=
 =?utf-8?B?Y3VmajhhcEh2VkZKMnd5Y0MzZUFQc3FIVGFwN0JmTC9SdjgxWFQyYkpmdXhu?=
 =?utf-8?B?SmFhTXJFMlBwTmY5YWJ3WFpwOUdOclR2NnlVK3dzS01DNjJWWFdsQ2hGakFD?=
 =?utf-8?B?UHBIMnN0TkhzT1ZZRkdqTFA0TkUxNmhwSUFidkF5ZERCdDA4d0Y2eksyM0FS?=
 =?utf-8?B?dHpZQ2Rya0IvWEY5R0NhSDBuSTRrVVc3aExDZ290SFNxSU81YmZtTzlxb1lu?=
 =?utf-8?B?RzlrYnhBMVJJbTR3aHN2MiszUWZULzFzNm1hN2xSOUtreEFURGV2YUdOWVg5?=
 =?utf-8?B?MlNkYVpBWlJmN1ArRnlDUENkNlF5VXhnUU81ejFzeFY1eWtiZ296UGhSQ09G?=
 =?utf-8?B?QWJUQkh1YkpYRVJsZVpic0dTcVhTNW94N05zNVJ4R01QY0M0NmduT1IvcDVo?=
 =?utf-8?B?cVg2cUc1K09DV2NaSVlaV1Zlc0x2SGlBV1VLaTZSanZ2UVpyalM3RUo0enpG?=
 =?utf-8?B?RlF3SWhQbEFSREVKYmdMcGo0V3lzdDV2bW53V2l1UnlJeVk0TDZnNWVhVVZj?=
 =?utf-8?B?VVZjRkRzUTRycXI4N3Baai9YbHFZbGF1TlRLWDRsai96bFpWMWx6QXF6QWR6?=
 =?utf-8?B?TTU5UjNIVzdvS1dXNE5zRE5qWmVXVFVTRWxTZlRqZ20xeDNSMGIyaitlTHF3?=
 =?utf-8?B?WkpLbkQ1M24zUGVMamEwY0lkak5scUo4T0RjLy9iRk4yZnVJTm5WYmRnQ2xK?=
 =?utf-8?B?czR6Wm9rbXJUbktqTXN2M2RKY2tWbitjMGVLREwySXZ2Z21IT3g0bWQvUWhx?=
 =?utf-8?B?R25BZXVpcnFPZHUxZWI1ZnU3VWZrOGpSczhSMDhodVQxaDVhcW5QTGxDTHFK?=
 =?utf-8?B?QW9YTkdaZityKzJ2OTYzMnM4YUtYVWZoSG41MGxkazB5WHFBUGxUR1pvcVVK?=
 =?utf-8?B?dENJM0dRU0dtaVhBT1V5cWMzMGVMUWd6N2ExV0g2L084TFNqMXBUSDZVNmw5?=
 =?utf-8?B?RVBKNS9aWGVUOWpYb3RSM21mZlM4Y29vNE5IWjBKRTRveWVyK2NhNmRXUHF4?=
 =?utf-8?B?NHhiZVE2Y1F5ZFZBK1g0ZXpPQWF6RHc0Sm5jWVFLajIwa3V5WlpXYkJhbkJF?=
 =?utf-8?B?UEhXd3R4R2RveXh2aC84WEZNb05WcFlITDY2TXh2aEsrbnViZWxLa3RsMWNH?=
 =?utf-8?B?bVowU2lnV1k5WjhlSlN2Y0hROGxMd0NvbWtuWFNyZGthcUpzY3dwb3h2aWh3?=
 =?utf-8?B?MnN1Qytsd2M3U3luSURtS3p2VzBPSlBBNWZRU2Jxc3gwZ1FEeDhkNDlwTGhD?=
 =?utf-8?B?cUdBZkNNbnBLRVZlTWZZekhmcUwvbnM1aUIrWkE1empFVFpJWlk5RUFBQmNq?=
 =?utf-8?B?bUZDVm9GamVsVE1hTHE0Y0M1YS9EOTVxQTkzMjFpa1gwK3JQMTdEY3pwa051?=
 =?utf-8?B?ditzdG4vc1R2YW9SWVdveDFVQ3RtWWk3czFtYVRKMGRlM1JxZGRzQ0k2VUJn?=
 =?utf-8?B?MGhSRkQyTVRNUVNtZWpqNlpXT0gvanlqSmVaRDg0MnlqK0hkWFNmNkY3b2th?=
 =?utf-8?B?Zm80OVk1T3lnS0ZscGpwM2xSdUpVeENma1ZqK0h0Um84RkZKbjNnYWxpR25J?=
 =?utf-8?B?cE8rY0U3dTI0eHNuY2RGVmFLdWRuL2J5Q3R5d2EzeXBobXVaK2loZUxYRDg2?=
 =?utf-8?B?cnkyQkxWTFVlendBajhRd3h3eTNmdXlqSTRnWXJWalZRcHRXQWFQd2ZldEhk?=
 =?utf-8?Q?Gf+4hcS1J68ADhxyMPBN7Nvz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac0ecdd-e653-452c-1dec-08db0e603f8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 07:51:15.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xag3eZj8Y6O87d8u9gaSS9hlOznVxktdElZzIypPHVq4xOC0fCRISOWoyeRdxpP7vFhBiFq/qD+q1YXzuxKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 11:26, Mukunda,Vijendar wrote:
> On 13/02/23 23:45, Pierre-Louis Bossart wrote:
>> On 2/13/23 03:40, Vijendar Mukunda wrote:
>>> Add support for handling soundwire manager interrupts.
>> Try using the MIPI spelling: SoundWire
> Will fix it.
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>>> ---
>>>  drivers/soundwire/amd_manager.c   | 132 ++++++++++++++++++++++++++++++
>>>  drivers/soundwire/amd_manager.h   |   1 +
>>>  include/linux/soundwire/sdw_amd.h |   7 ++
>>>  3 files changed, 140 insertions(+)
>>>
>>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>>> index 14c88b80ab6d..87f9a987d93a 100644
>>> --- a/drivers/soundwire/amd_manager.c
>>> +++ b/drivers/soundwire/amd_manager.c
>>> @@ -417,6 +417,47 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
>>>  	return SDW_CMD_OK;
>>>  }
>>>  
>>> +static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u64 slave_stat = 0;
>> useless init
> will fix it.
>>> +	u32 val = 0;
>> useless init
> will fix it.
>>> +	u16 dev_index;
>>> +
>>> +	/* slave status response*/
>> response */
> will fix it.
>>> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
>>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
>>> +
>>> +	dev_dbg(amd_manager->dev, "%s: slave_stat:0x%llx\n", __func__, slave_stat);
>> newline?
> will remove it.
>>> +	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>>> +		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
>>> +		dev_dbg(amd_manager->dev, "%s val:0x%x\n", __func__, val);
>> you don't need __func__ in dev_dbg() logs, they can be added e.g. with
>> the option dyndbg=+pmf
> it's overlooked. we will modify it.
>>> +		switch (val) {
>>> +		case SDW_SLAVE_ATTACHED:
>>> +			amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
>>> +			break;
>>> +		case SDW_SLAVE_UNATTACHED:
>>> +			amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
>>> +			break;
>>> +		case SDW_SLAVE_ALERT:
>>> +			amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
>>> +			break;
>>> +		default:
>>> +			amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u64 response = 0;
>> useless init
> will fix it
>>> +
>>> +	mutex_lock(&amd_manager->bus.msg_lock);
>>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
>>> +	mutex_unlock(&amd_manager->bus.msg_lock);
>>> +	amd_sdw_process_ping_status(response, amd_manager);
>>> +}
>>> +
>>>  static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>>>  {
>>>  	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>>> @@ -817,6 +858,95 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
>>>  					       dais, num_dais);
>>>  }
>>>  
>>> +static void amd_sdw_update_slave_status_work(struct work_struct *work)
>>> +{
>>> +	struct amd_sdw_manager *amd_manager =
>>> +		container_of(work, struct amd_sdw_manager, amd_sdw_work);
>>> +	int retry_count = 0;
>>> +
>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>> +		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>> +	}
>>> +
>>> +update_status:
>>> +	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
>>> +	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
>>> +		if (retry_count++ < SDW_MAX_DEVICES) {
>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>>> +				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>>> +			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
>>> +				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>>> +			amd_sdw_read_and_process_ping_status(amd_manager);
>>> +			goto update_status;
>>> +		} else {
>>> +			dev_err_ratelimited(amd_manager->dev,
>>> +					    "Device0 detected after %d iterations\n",
>>> +					    retry_count);
>>> +		}
>>> +	}
>> this seems rather inspired by the Cadence code, but is there really a
>> case where you need to re-check for devices? In the Cadence case, this
>> was added because we have a logical OR and new devices would not be handled.
> As mentioned in V1 set, we have corner cases during enumeration sequence.
> We observed device alerts are missing during peripheral enumeration sequence
> when multiple peripheral devices are connected over the same link.
> This is not inspired by Intel code.
>
> As per V1 version review comment, we have included retry_count logic to address
> faulty case.
>
> We forgot to include comment. we will fix it.
Slight correction in the explanation.

During the peripheral enumeration sequence, the soundwire peripheral interrupts
are masked.
If soundwire interrupts are not masked, it will cause side effects when multiple
peripheral devices connected over the same link.
As interrupts are masked, during device slot programming for each peripheral,
soundwire manager driver won't receive any interrupts.

Once the device number programming is done for all peripherals, the soundwire
interrupts will be unmasked. Read the peripheral device status from ping command
and process the response, which will invoke the peripheral device initialization sequence.
This sequence will ensure all peripheral devices enumerated and initialized
properly.







>>> +}
>>> +
>>> +static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
>>> +					struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u64 slave_stat = 0;
>> useless init
> will fix it.
>>> +	u32 val = 0;
>> useless init
> will fix it.
>>> +	int dev_index;
>>> +
>>> +	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
>>> +		memset(amd_manager->status, 0, sizeof(amd_manager->status));
>>> +	slave_stat = status_change_0to7;
>>> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
>>> +	dev_dbg(amd_manager->dev, "%s: status_change_0to7:0x%x status_change_8to11:0x%x\n",
>>> +		__func__, status_change_0to7, status_change_8to11);
>>> +	if (slave_stat) {
>>> +		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
>>> +			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
>>> +				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
>>> +				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
>>> +				switch (val) {
>>> +				case SDW_SLAVE_ATTACHED:
>>> +					amd_manager->status[dev_index] = SDW_SLAVE_ATTACHED;
>>> +					break;
>>> +				case SDW_SLAVE_UNATTACHED:
>>> +					amd_manager->status[dev_index] = SDW_SLAVE_UNATTACHED;
>>> +					break;
>>> +				case SDW_SLAVE_ALERT:
>>> +					amd_manager->status[dev_index] = SDW_SLAVE_ALERT;
>>> +					break;
>>> +				default:
>>> +					amd_manager->status[dev_index] = SDW_SLAVE_RESERVED;
>>> +					break;
>>> +				}
>> the code seems identical to that in amd_sdw_process_ping_status(), is
>> there a need for a helper function?
> will use helper function for status update.
>>> +			}
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void amd_sdw_irq_thread(struct work_struct *work)
>>> +{
>>> +	struct amd_sdw_manager *amd_manager =
>>> +			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
>>> +	u32 status_change_8to11;
>>> +	u32 status_change_0to7;
>>> +
>>> +	status_change_8to11 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>>> +	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>> +	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>>> +		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
>> remove __func__
> will fix it.
>>> +	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
>>> +		amd_sdw_read_and_process_ping_status(amd_manager);
>>> +	} else {
>>> +		/* Check for the updated status on peripheral device */
>>> +		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
>>> +	}
>>> +	if (status_change_8to11 || status_change_0to7)
>>> +		schedule_work(&amd_manager->amd_sdw_work);
>>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>> +}

