Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92569AD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBQNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBQNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:49:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41224AFFB;
        Fri, 17 Feb 2023 05:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVlbcNifP6Mz3LxjZq02QerH9H56WvlizQeEtkklKraUYscw9/gjsrm4C6Oi4ed4G+9wLl/KR5jiiMOG9iRytsJdFZPSvK0VgdrMal3DUsz5gF0W4I4lnZTd/bPtlsCZyFoGIZFuY0dQTOKY069l5hml19+HxLXd//ztcNx1TqLPyJou/Ms5c/uivuYpOj7P04YpTu/J7nOY0S9YxiVIvp2toMoTGycO7RJQDZ/uQHlTsm80JYsGFs+/h3re8qeU5+mU340OlxKaiuAVKRoNjERWi0bJj3Hl54/uUXww8e/4G4AFKfolk9k3RgGw8A5mr1/BImYuhuMZuosQE7bXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cd8wSHtKVySyYd9FJeNU+nmIWbrPtlFXyQA2BPoSPw=;
 b=gl67BmGK6+5eErfwkkbAI2HOSxyhE6Rbr/PjRWu80LdSSHslfyb6m9eLjuy1hmP8OyVKBtHvr8dgSICKxEzfwQwrKl5XDwCc2Ru9wr+enTAwbCCjqNOK7vd6BnjiykXNTwhJq3GQpV1w2cF1YXHjE28WZZ2UOMaq1CRe31Xay+gErRV7GX8hxqVDJPf/4gCThlaU37C8uy/a4jzFhYthHk/jq3p6DmexaGRMjzzkDmEN2ac/xo8HHHkgQX6C7/rtND1X4Qek1l/U2z2TdcynwQ3m9qx7X2yCytfEVCk41V4BGN8ig+WE23j4Z0JfbMoE7vWkbYsEIbD/L8r7cIvO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cd8wSHtKVySyYd9FJeNU+nmIWbrPtlFXyQA2BPoSPw=;
 b=q4co+ZxA+T+/o4fWILNIfnfCnhI04vjNOsbqk0RS/28+cGzf4Jwli447PQy7xbnN4iWVL+wWzRPQDGN7y17sHOankpsD1/I8eY2lwLBZGMrnjIZW94vDM2Y+Y1PjfgMY7T6L/cVCjq70TzH1pYnpABcMm1Ok3brbfWA84XUQ3uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 13:49:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 13:49:24 +0000
Message-ID: <828b4e9a-9e1f-a643-7fed-d4d33e8d8d8e@amd.com>
Date:   Fri, 17 Feb 2023 07:49:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] thunderbolt: Refactor DROM reading
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, Sanju.Mehta@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230216201910.12370-1-mario.limonciello@amd.com>
 <20230216201910.12370-4-mario.limonciello@amd.com>
 <Y++C4gWAfbw2rQUt@black.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Y++C4gWAfbw2rQUt@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:805:ca::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 237e033d-3d7c-41f8-16d9-08db10edc754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0+Y4OAjzVsSwJfzgF2+wnZDHHodUobBtwzLHVbq7VM5cCYBHMojsaeSm35EgxMfW3Griy7gBKToR0nHNU7DGvVx7RSzVpt3jQnQF4P0qhFDH5zWk5zku8T40EY5d8WYPPvJVfIgq7P6/PVIs66Savls/71OyNJE49zZdD+o382oRH/LuW4Mg1JWK3jdiSZj2MMZE42h9l2s1mvRykEJRYRT5enx6NHxFfxZCz6zng0wstNSvSyWFMwHbSuohM+tjbx3Ws8HfZp2SnM8VYxTLDsjIwQdlUWTBPwKXOR6xpl/PhbQHOaWC0zzo4s8s0ZvNwvSRKiqdm0Tjbxd8bqTr0klMl3y+KPEKreX5wp+RZyEAGGqwLCvGfeQCemh7jSoh3wazWKuKQRDFS1uJGgFl9g0YDwYqgULPOABwyq/4nH9HcGkC/n2V7ad1gquvrz8S7IaRny/VOoYRx7ILst+85APC/2L0m+3CMXn9VkdAvjg4CToY4qNrH2sSmkJZ1BQ+9jc+eookQE9MupVNzowj8qcvldIsyuL3rDpkTf0VczhArpSCslMfC3OAXyvw3zqEUi1W8jBoC1/UzA+jqQlZOcZaprWxHSxsGyDQO7Oh1J5dw/bUdHvozvuYW5/QGRxIKqbHbfBgFOzwX/PqnGCqH+PTRw5UaWHuIjXoniQZXIIWFTTLXyoRTTLoB1sj7BHR4W3vccPgpJs8zOBCHgg7XHq/Mtma6VupO+ksh85W9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(5660300002)(31686004)(8936002)(316002)(44832011)(54906003)(66899018)(41300700001)(86362001)(2906002)(83380400001)(31696002)(53546011)(6506007)(6916009)(6666004)(186003)(26005)(6512007)(4326008)(2616005)(6486002)(66574015)(66476007)(478600001)(8676002)(66556008)(66946007)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBzQ0h6RXpVUEFGNGplbDZpd3BvY3RzTHBzdnhGMllCVHAvTkdTU2VLT3Q4?=
 =?utf-8?B?OHFkUTBZME9xbWZqekZLQkNvNTdERWhnUVZSOWhINVYvRnovRnlnQTVlUGlC?=
 =?utf-8?B?Slg0YVRSUllRdkY4U1NCKzVlWm0vdVIyaTdaa3AxbnBqMTAwZGdzM21OWnpm?=
 =?utf-8?B?RjM4TmU3ZThIVlJmNFhNbWhDeDJubEcyR1pCekk1OTBDSG5PUEd4OXlQU2c0?=
 =?utf-8?B?L1lONzRwUUtOdGpDQlJmYmNJUDlOYnZXTkl6K3FBSEZFenY4K2hHdVdFZVZs?=
 =?utf-8?B?aFVGNGQyekNwK2wvUTJZWFdzUitMZ3JWQThPd0RvZFZJK1ZuYnJPUlpteDlN?=
 =?utf-8?B?RlBDKzkyYnhQOUhqMkhWSDRHRWgzU0FCK3ZOUXkveWlIUlFLWSsvQURPZ3FR?=
 =?utf-8?B?OXBXUkcwdDJkTFJER1dTaDlnRzRpK1g1S0pLbUdtMzRKN2hCbit4ajZnREVD?=
 =?utf-8?B?NVNmOHlWZWpTWU9QRjA3SzU4ZVdEcnJoUzd1aWFUYTlYUm5nY3VVa2I2aDBt?=
 =?utf-8?B?Skdhd2FKbXN4VnI5MjZOYVlqYVVJS1pOWlBUUyt3c0d1eWtZNUdzK0VaMTUz?=
 =?utf-8?B?KzB6clVLUWVwZFdMTU9aOFpsd28vY3k3WGgxUU1tYWdHWU9xSldPNUc5L1RL?=
 =?utf-8?B?L2ptaWhXUUtFSTRJWkFycFh1QTV4Z01aUjkzR1J6YVM1LzhBVXN0akpYWGZQ?=
 =?utf-8?B?Sm5nNVV6WkxZREZ6QTYwRGtpUTNsY1NYVHM0Zkp3bGNhR1l0WCs4Nk8xSGwy?=
 =?utf-8?B?bXlHSzlwSnFtYXJ6WWsyODZETS9kaUI0WHF6ZDBTSmRVVXUzTzBzVTdRVEpq?=
 =?utf-8?B?OEhDK1N0dFQ1REh4MmpTeVZkRC81am0vMURPY0VTRmgwdWlJVUw4K1ladTBP?=
 =?utf-8?B?M3puSHN6b3IrWXM1OXlRVjlMUDlyZFY1Mlg0eUN5Y0FSaStjd3I2L0x3Lzdy?=
 =?utf-8?B?OHVaMCt0bzEzeVNodGZaNXV0Q1I4TFppY1hmS1NXMDQ4WG41Qk1BRllzSjhx?=
 =?utf-8?B?eStiTVBhREhMUHhQcyt5NGc0MlVxMGFpRHVlUUlIQVNPUVJCNElDM3g3WXJO?=
 =?utf-8?B?aExod09MWlJiNE5RM0pHenNRTTdiVDkxdFY5WFU5dVkxUE0xK0RydFlDd1RP?=
 =?utf-8?B?OUZrNDl6TVdoTEYvTTkwaURSUmFPSEhyZFNnYzVWV1JzOUxlQVVtVG02bkRX?=
 =?utf-8?B?U01jeHc2N0dxdzUyay84aTdzek14WElmR0ZTMVd2Y3JPZjdhdlFYSUNHMU4w?=
 =?utf-8?B?dC8xMk8zNnJFNmFXVFJHTHpGTThiTG56QUhrMFlKa3JJRzlYNUFOUU12SmVH?=
 =?utf-8?B?WGhKTGMyc3B1SUlXTkdzYmp1anQ4cW51Wi9MeThaakFhMU5FUlJaczJLdUlp?=
 =?utf-8?B?diszbmNXZXZ1NFRtQmdLWjRCRWJTa1h6UkYzeEhkajZLZlQraXhHSC9mampX?=
 =?utf-8?B?ZlpYZnhLa1lpa2xDeWhjM1V2NllZckE2emxxbVdOaUMvbS9KUUhnQWcyQit1?=
 =?utf-8?B?N2tucW9ZL2FYbXdhRGFSV3ozeFcrTGxGMVVtdHVVeEdURWFKTzAwSTlWZ1Bq?=
 =?utf-8?B?cmVnTFZ5dTZIZ1F4MDVEQ0VvWU80anY3cGQ2U2NxOThmNHRQNTNRSHZYaVJH?=
 =?utf-8?B?Nkx2VU1Wcm1BNnZtRlluVjJhemRUS0tqTUlNamxaRmNNczd2UnF6WjV5Yjhm?=
 =?utf-8?B?VWpzVTF6QUtyblJKc2NONGNCdnA2c0x4dU8rQ2Z3MVdKSW5YUnMveldZTmpM?=
 =?utf-8?B?eGVnRVpLamR1QmFaRzVCcnBtTXVGZDZsZEZaRDZ4MS8vMTJsT2FBQzFjelBw?=
 =?utf-8?B?eDlHd1czUFZtQTRWSmdob3RobWlCd01hVFJRZ2J5SlhObWdWYWVQb2YwQ3Fz?=
 =?utf-8?B?QWZ1L1QrVnVpdDRmc0dSdXJDcytjSkpSNnJ1VjVvNWJNRUJEdUoyUlEyTFBF?=
 =?utf-8?B?K1hDY05MWHZVZjlMTXQxME9GUS9oWkJaVENrVUtOV21uN1BxbElqemVqV015?=
 =?utf-8?B?NHFjTmdWQ1hwVk8xM3JVRHNRdHBESi9lWEtON0k0Q0srL0sxKzZQOHFrdzh2?=
 =?utf-8?B?WnIwNy9hS1RvVEtLRU9xdUNOZ0hNL1ZYOUJJem94RFNwUkIvMW5GankwMDhK?=
 =?utf-8?Q?MFeVY77I3hMcDuFzwM1Ki+DXB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237e033d-3d7c-41f8-16d9-08db10edc754
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:49:24.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/kaHfdDAS0BNK7g9IsCA8nH0Fz9HjHguH9EOOZrKmc/V1fwdDRSuFJw6VqDr2SPfMdARoRUZplzlZbq5c6IXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/23 07:36, Mika Westerberg wrote:
> Hi Mario,
>
> On Thu, Feb 16, 2023 at 02:19:10PM -0600, Mario Limonciello wrote:
>> The NVM reading code has a series of gotos that potentially introduce
>> unexpected behaviors with retries if something unexpected has failed
>> to parse.
>>
>> Additionally the retry logic introduced in commit f022ff7bf377
>> ("thunderbolt: Retry DROM read once if parsing fails") was added from
>> failures in bit banging, which aren't expected to be present when the
>> DROM is fetched directly from the NVM.
> Okay that's why you remove the EILSEQ returns below, right?


Yep, that's right.


>> Refactor the code to remove the gotos and drop the retry logic.
> Thanks for doing this.


Sure.


> Few minor stylistic comments below. I can also
> fix these myself when applying if you prefer.


If there is any other feedback on the other patches in the series from 
you or anyone else before 6.3-rc1 I'll send out a v4 fixup the style 
stuff outlined below.

Otherwise, I'll take up your offer thanks for that.


> Note I will be on vacation next week but will be picking up patches once
> v6.3-rc1 is released.

OK, appreciated.


>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>      * Split out refactor
>> ---
>>   drivers/thunderbolt/eeprom.c | 147 +++++++++++++++++++----------------
>>   1 file changed, 79 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
>> index a326cf16ca3d..2a078c69f0d2 100644
>> --- a/drivers/thunderbolt/eeprom.c
>> +++ b/drivers/thunderbolt/eeprom.c
>> @@ -416,7 +416,7 @@ static int tb_drom_parse_entries(struct tb_switch *sw, size_t header_size)
>>   		if (pos + 1 == drom_size || pos + entry->len > drom_size
>>   				|| !entry->len) {
>>   			tb_sw_warn(sw, "DROM buffer overrun\n");
>> -			return -EILSEQ;
>> +			return -EIO;
>>   		}
>>   
>>   		switch (entry->type) {
>> @@ -543,7 +543,37 @@ static int tb_drom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
>>   	return tb_eeprom_read_n(sw, offset, val, count);
>>   }
>>   
>> -static int tb_drom_parse(struct tb_switch *sw)
>> +static int tb_drom_bit_bang(struct tb_switch *sw, u16 *size)
>> +{
>> +	int res;
> ret
>
>> +
>> +	res = tb_drom_read_n(sw, 14, (u8 *) size, 2);
>> +	if (res)
>> +		return res;
> empty line here.
>
>> +	*size &= 0x3ff;
>> +	*size += TB_DROM_DATA_START;
> here too.
>
>> +	tb_sw_dbg(sw, "reading drom (length: %#x)\n", *size);
>> +	if (*size < sizeof(struct tb_drom_header)) {
>> +		tb_sw_warn(sw, "drom too small, aborting\n");
> DROM
>
>> +		return -EIO;
>> +	}
>> +
>> +	sw->drom = kzalloc(*size, GFP_KERNEL);
>> +	if (!sw->drom)
>> +		return -ENOMEM;
>> +
>> +	res = tb_drom_read_n(sw, 0, sw->drom, *size);
>> +	if (res)
>> +		goto err;
>> +
>> +	return 0;
> empty line
>
>> +err:
>> +	kfree(sw->drom);
>> +	sw->drom = NULL;
> empty line
>
>> +	return res;
>> +}
>> +
>> +static int tb_drom_parse_v1(struct tb_switch *sw)
>>   {
>>   	const struct tb_drom_header *header =
>>   		(const struct tb_drom_header *)sw->drom;
>> @@ -554,7 +584,7 @@ static int tb_drom_parse(struct tb_switch *sw)
>>   		tb_sw_warn(sw,
>>   			"DROM UID CRC8 mismatch (expected: %#x, got: %#x)\n",
>>   			header->uid_crc8, crc);
>> -		return -EILSEQ;
>> +		return -EIO;
>>   	}
>>   	if (!sw->uid)
>>   		sw->uid = header->uid;
>> @@ -588,6 +618,43 @@ static int usb4_drom_parse(struct tb_switch *sw)
>>   	return tb_drom_parse_entries(sw, USB4_DROM_HEADER_SIZE);
>>   }
>>   
>> +static int tb_drom_parse(struct tb_switch *sw, u16 *size)
>> +{
>> +	struct tb_drom_header *header = (void *) sw->drom;
>> +	int res;
> ret
>
>> +
>> +	if (header->data_len + TB_DROM_DATA_START != *size) {
>> +		tb_sw_warn(sw, "drom size mismatch\n");
> DROM
>
>> +		goto err;
>> +	}
>> +
>> +	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
>> +
>> +	switch (header->device_rom_revision) {
>> +	case 3:
>> +		res = usb4_drom_parse(sw);
>> +		break;
>> +	default:
>> +		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
>> +			   header->device_rom_revision);
>> +		fallthrough;
>> +	case 1:
>> +		res = tb_drom_parse_v1(sw);
>> +		break;
>> +	}
>> +
>> +	if (res) {
>> +		tb_sw_warn(sw, "parsing DROM failed\n");
>> +		goto err;
>> +	}
>> +
>> +	return 0;
> empty line
>
>> +err:
>> +	kfree(sw->drom);
>> +	sw->drom = NULL;
> empty line
>
>> +	return -EIO;
>> +}
>> +
>>   /**
>>    * tb_drom_read() - Copy DROM to sw->drom and parse it
>>    * @sw: Router whose DROM to read and parse
>> @@ -601,8 +668,7 @@ static int usb4_drom_parse(struct tb_switch *sw)
>>   int tb_drom_read(struct tb_switch *sw)
>>   {
>>   	u16 size;
>> -	struct tb_drom_header *header;
>> -	int res, retries = 1;
>> +	int res;
>>   
>>   	if (sw->drom)
>>   		return 0;
>> @@ -613,11 +679,11 @@ int tb_drom_read(struct tb_switch *sw)
>>   		 * in a device property. Use it if available.
>>   		 */
>>   		if (tb_drom_copy_efi(sw, &size) == 0)
>> -			goto parse;
>> +			return tb_drom_parse(sw, &size);
>>   
>>   		/* Non-Apple hardware has the DROM as part of NVM */
>>   		if (tb_drom_copy_nvm(sw, &size) == 0)
>> -			goto parse;
>> +			return tb_drom_parse(sw, &size);
>>   
>>   		/*
>>   		 * USB4 hosts may support reading DROM through router
>> @@ -626,7 +692,7 @@ int tb_drom_read(struct tb_switch *sw)
>>   		if (tb_switch_is_usb4(sw)) {
>>   			usb4_switch_read_uid(sw, &sw->uid);
>>   			if (!usb4_copy_host_drom(sw, &size))
>> -				goto parse;
>> +				return tb_drom_parse(sw, &size);
>>   		} else {
>>   			/*
>>   			 * The root switch contains only a dummy drom
>> @@ -640,67 +706,12 @@ int tb_drom_read(struct tb_switch *sw)
>>   	}
>>   
>>   	/* We can use LC to get UUID later */
>> -	if (sw->cap_lc && tb_drom_copy_nvm(sw, &size) == 0)
>> -		goto parse;
>> -
>> -	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
>> +	if (sw->cap_lc)
>> +		res = tb_drom_copy_nvm(sw, &size);
>> +	else
>> +		res = tb_drom_bit_bang(sw, &size);
>>   	if (res)
>>   		return res;
>> -	size &= 0x3ff;
>> -	size += TB_DROM_DATA_START;
>> -	tb_sw_dbg(sw, "reading drom (length: %#x)\n", size);
>> -	if (size < sizeof(*header)) {
>> -		tb_sw_warn(sw, "drom too small, aborting\n");
>> -		return -EIO;
>> -	}
>> -
>> -	sw->drom = kzalloc(size, GFP_KERNEL);
>> -	if (!sw->drom)
>> -		return -ENOMEM;
>> -read:
>> -	res = tb_drom_read_n(sw, 0, sw->drom, size);
>> -	if (res)
>> -		goto err;
>> -
>> -parse:
>> -	header = (void *) sw->drom;
>> -
>> -	if (header->data_len + TB_DROM_DATA_START != size) {
>> -		tb_sw_warn(sw, "drom size mismatch\n");
>> -		if (retries--) {
>> -			msleep(100);
>> -			goto read;
>> -		}
>> -		goto err;
>> -	}
>> -
>> -	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
>> -
>> -	switch (header->device_rom_revision) {
>> -	case 3:
>> -		res = usb4_drom_parse(sw);
>> -		break;
>> -	default:
>> -		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
>> -			   header->device_rom_revision);
>> -		fallthrough;
>> -	case 1:
>> -		res = tb_drom_parse(sw);
>> -		break;
>> -	}
>> -
>> -	/* If the DROM parsing fails, wait a moment and retry once */
>> -	if (res == -EILSEQ && retries--) {
>> -		tb_sw_warn(sw, "parsing DROM failed\n");
>> -		msleep(100);
>> -		goto read;
>> -	}
>>   
>> -	if (!res)
>> -		return 0;
>> -
>> -err:
>> -	kfree(sw->drom);
>> -	sw->drom = NULL;
>> -	return -EIO;
>> +	return tb_drom_parse(sw, &size);
>>   }
>> -- 
>> 2.34.1
