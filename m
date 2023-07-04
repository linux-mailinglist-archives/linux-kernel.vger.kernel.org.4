Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B7746735
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGDCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDCQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:16:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ED136;
        Mon,  3 Jul 2023 19:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr/Czz8/R9p4hO3sbXQQbxbQb8E7OGrbZ9nJtMQ+HeAVBXXuaFEsJodD7wEy9EMdTWnN88PpsL7WDxGcJHT8mCubpvlh065A6PV5bIz/fO+crT4JixqB6TXoGR+JQd1dsjiEC97hKXAGYPzpugUJrSfHKEEwkfwe2RHLev7XPxlsNElfszHgx+q56eERQcm3CLTD5oKyiFW/oB+aoX89hqfid06PWIEkglpDouI3heDvMxiaAKynddmU+WB88tmS1kxRTfUoIa5wxg232RvieB2g0Yj9rbRhGKMnjyNLXZ/zcPlGwnRcKQgFJHKihEnJSlMbiLHG7djDgRNPEwmEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Tb8wAYfY5YtF6mbFl/YCcKllVLcXwXAoQTXAYms7Zo=;
 b=Ux8PVPk6wcd1XkgtkxQEpymqj8Ux0Y6l+3sbijnHMr6rO00uS7MnR6r9vd8Y/yoojzeNjnByaRCiWUyu5DmTM/1fvQrwXyitNopF+zUMwVWpdWjXiGlC4t1ejb3PhWEVJ8/VlS2DVot2y92D8R1uQZ67XNIQyh1Uzu+MPLh/S1UwPilU0sjP9QNvE76vpF0PbE94iyBvDz0Pf4jy1V18EeNjdf/A/zVYTQEh+nPqR0+VO3bdYDHYn8ExtrwVF3yq0qVf89n5JJ+4uPMB5YO0NHYWoEy8OzPfTg6vbalZ51I8+jK/K6RRc3c5iIbJB8lE1Wg4w4F1PpplmBTVNuaT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Tb8wAYfY5YtF6mbFl/YCcKllVLcXwXAoQTXAYms7Zo=;
 b=xdXjjuIhnGn1OT72P+0JYGczpYRj2IWda5SDbjNXKs4SCCbyvdBQR+Moj1Nx9zpHTW1aPtT0RyMKxmbpKU1PJ4AN+NeEo8b9SfoG3A+fSMcCtRWvMcwCDnQsklmGVvCr1TH2tDabj2J8kDtfzC+8pwydE4Z8VjK7l/BxlALsHdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:16:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:16:21 +0000
Message-ID: <acf1de10-d705-6b38-59fd-e2f7374f1e13@amd.com>
Date:   Mon, 3 Jul 2023 21:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] pinctrl: amd: Unify debounce handling into
 amd_pinconf_set()
Content-Language: en-US
To:     andy.shevchenko@gmail.com
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-4-mario.limonciello@amd.com>
 <ZKM-rde5VyTScJHC@surfacebook>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZKM-rde5VyTScJHC@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c11724-9641-433c-b088-08db7c34a8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3RuXoQFHMjJEnnKpcF+J2WMOSnoZvL0QXddW2BjuLTB8tQ5nJH0LkrIacJ/4HGCVH+pHgqukha/AKwkb3QuwC/h3iWGSl81i5iqayz8A76P92EYG0/eSRvuAJfbfAJA/MknrCwLHoCNm56RZ856nEafqNKSxMFnSiMDv/bmFwhzhqtpdxg77ksIdSM8u6PuM+jHVFaqQahH+YT4Ig6Xtruxr3W59J7+obAjut++6KYQBDzGjaMvFKf8tiEnGdr3A7vXnPRz6vEH9CK7g9Z8PaaU+XK3k7lHtjMQ4NU/4Ykt2RSZmHjqH9j6XysXiFIDa5M8b1Wiudx/1dX4HQhNj3IZH1799aAB9TLpKG6yFyjfui7o2wue6QQ9jreTeB4b6fQ/6SfE2jLv20SO7tTpoRUio7KLc9Y9Gq3UeirrhZjNbU1bn48BYu+gxGZX9aAjcsxLXu+SOtTAxrIUr3kTu+ypBGo/ZhODwnwOlDt8SC/r5As1Nx7mxq29veek512Id1+lR9IXNBUk9uYcDAW/qyYRX+raLum2WgnUqcISuZZdt5IuV+/jIxp4H292D/1bJq5ygp0ddBZpcCfTZEPy4VLAOvoc/qoWbvVhkvvXRm94+V34JJSwN+X8aQhCzP7vA/spHrUs9ibPa5PtA2WMrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(6916009)(478600001)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(6666004)(6486002)(4744005)(38100700002)(53546011)(6506007)(186003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FYQVNZdXd2eTgrVGtIdmxXdnRPUEJ1VHJTZC84eVZtc0RTWTIrQ054cnFI?=
 =?utf-8?B?QXZRczRHczlSWUNJRDFaQll1M3ZTTEJDOWErSHFLeTRxL3M0NkhEVkpXbVlC?=
 =?utf-8?B?MkJnWC90Ymg2WkZVdkR4akdqb0d5djNiM0l6SjNybjJqcndMTWk5T3FieEdF?=
 =?utf-8?B?eTRHU0xvaTFTYnpxcGc4WG9CM25uVldxNWQyMWlScTRJZHZVYzlBYnNWKzJI?=
 =?utf-8?B?ZzRwWjNJSkl0RWxyVFpaMUprNHlVZTJrMFR1Q2U4cE1SWi9KNkhsU1E2d0Iz?=
 =?utf-8?B?Z0hlcHhzM3BhSU1pc3FPVk1jNnl5TmhDWDl4THJkWUZ6YXI1dFdPdFZPRlRk?=
 =?utf-8?B?MHhFbGR6VC9XSytQY1QyZXBIc2N5Q2g0WE1IUmg1VkNaTWN0RzZac1ZyMVNt?=
 =?utf-8?B?NkIyUzBPbEFKdTE1aVhaZlppU3l1YnRRTjdpQ1UxeDZGTVBmR01odXBZWklN?=
 =?utf-8?B?RVAzOVpHOVN6dHN4d3AvYTR6WmZtQWVvTmQyQnRhWmlZSytqT1NxdGJGK3FZ?=
 =?utf-8?B?S2Q0bTF5YmZEZEFQWDFINmliMWxSR0ZNU21PUWFZcW91VGVuVGdDeENFcGRj?=
 =?utf-8?B?aEt4MTYzV29obHJCMjBxT094SkhaRWI2YnlyQ0JEdG5YK3IrOWs0RkdkSkJx?=
 =?utf-8?B?YVArczJ6ZDYrSU9icGZLdG50aE9hem9oejBRZHYzcDF6dlJvSThmWDE5aUFS?=
 =?utf-8?B?VTk5VDZmQi9qUCtGdktmbTdmdzg4SjNldjRBeXRTZGV0WUpPNmNpUDBobDE0?=
 =?utf-8?B?dklETktPOFFwYjM0d0lQV3UxdUkwd08vVXY3ME42dXQ4VytzS2ptUE9aQXFD?=
 =?utf-8?B?MEFtRTAyQ2V3cnhwblhLNWYxczRYWkpsVEVuMkIvYVBNZm9tc3Q1cHpQa2Vm?=
 =?utf-8?B?TGRaMkl0UVZKdkwwQW9OMERSdCtDL2w4WWxtbG5BTFZMRCs2cUdFNUVlRTJI?=
 =?utf-8?B?TUM2TStTc3d0Mmd4d20rZDA3elFYKzUxNFFMcFgzeHpFcGpTQUh5eFZnVUV4?=
 =?utf-8?B?NGhUdExHSTZ2VDZpOFh0bWc3emI3eFl1RE5pMVdsVXdIS3JyZndsdHFSdHZP?=
 =?utf-8?B?WDNuM3lwR3A2MDJDc2EzM21QdGg0dVl1dk1mWm14c0JjYkdTV3VScXh1WTNy?=
 =?utf-8?B?bEc4c2V2WFV5RnB1Yk1RY0M0UkxPNHVXT1BlcUtqRGFHVjRkcXk1VmE4SUFX?=
 =?utf-8?B?ajYydjREbTdOS1hCWHFnaGIyYi9sYkc1dnYvQUNJTkhUYk5IcmQvOHVtSUNz?=
 =?utf-8?B?NGVucGRDSUozc2Z2MndJTXhuL1NzZ3dIUkxIYWFjR0FHTHNpZm5SdlpocCsr?=
 =?utf-8?B?UWE2WWpvMHNuMzBseHJwVEZOcTMxM1FBZS9QODhZOU95UFBCcU1tcDlmaXJK?=
 =?utf-8?B?Zkl6RlBiOGdpWmdnKzZUUlczRkVIeGVMUFNwS1ZrSmxLUU51M2o5QnpCaXVH?=
 =?utf-8?B?ek9xNEttMjlONkE2VVdJQ083Q0FqWFcrVGVQbFYrOUhVQlRRVG5wMGpuRWcz?=
 =?utf-8?B?VHVjZEMxaW1TM3dOeUp3enc0MVVkTVJnOEFrZlBsay9WUlkyTENRUWJNTDBp?=
 =?utf-8?B?SDBudDVHMElqYTVXWFVlaGtiOURrZjJSdnFxZmsxOHlOemdjb3A3NUY4eUxK?=
 =?utf-8?B?eUdocTk0dDBuSTY2Tkh5T3VhLzI3ZzlscEtFZHFHMitHZmJhOXVCaStqK0tV?=
 =?utf-8?B?dks5T1JqMWgyTS85bC9VZXNoL3Q5N2VVRHovejdKa2ozUGI4SFpDTWp2K2Fx?=
 =?utf-8?B?eFliaStmTTVpalBsVzZTaTVWdXZTY2JSTnlDd05MamR3SE5kSkZLYWtEVFZo?=
 =?utf-8?B?aDlpQnUrNjZ0OHFjQTVneW01a1ZsYmhZM2lNSDkxeDhNREVOMStqNHV5NkJP?=
 =?utf-8?B?VUdJSzBGbDRUdTk3UlRZRFdwemQ4cVVkaUZTb2JScU9UaUdObnFIYmY0MHky?=
 =?utf-8?B?WVgrT1hhYnM1aHlEQ0gwbnVCS0VkNDdaemR1S3NxWVJqOVVJMHNLdXpiaFU2?=
 =?utf-8?B?QnppRDZqVW5nRGRwSHA3ZkpsSHZkeVdta05OYTR2cERJVWNiR3NlVHE5TFhm?=
 =?utf-8?B?WTZ3V016S2ZvUkZLS2hrUy9HU2gwSnhPa2pPTXJJVWdJeEIyOFVMVGJxZG04?=
 =?utf-8?B?Q09QbzFIR3dwOXR0NEl2RUsranU0bTR5SW5GS0JjMWtiSHQwNWprYWhnUFAy?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c11724-9641-433c-b088-08db7c34a8ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:16:21.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9BUmsEDBpFwEpTOlh/Ibmo/v9dx2MFBs1iWKGPXWT9i+hpLNYeomjA0XydFlw7kQMrJ6iCW9a3hh4j1ctSo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 16:33, andy.shevchenko@gmail.com wrote:
> Fri, Jun 30, 2023 at 02:47:15PM -0500, Mario Limonciello kirjoitti:
>> Debounce handling is done in two different entry points in the driver.
>> Unify this to make sure that it's always handled the same.
> 
> ...
> 
>> -static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
>> -		unsigned debounce)
>> +static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned offset,
>> +				 unsigned debounce)
> 
> Side note: Are you going to fix unsigned --> unsigned int?
> The former is discouraged.
> 
> ...
> 
>> +out:
> 
> out_unlock: ?
> 
>>   	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
>>   
>>   	return ret;
> 

Ack, thanks will adjust both.
