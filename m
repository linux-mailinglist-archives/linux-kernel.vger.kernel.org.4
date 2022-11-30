Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8E63D7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiK3OSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3OSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:18:14 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B094E416;
        Wed, 30 Nov 2022 06:18:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYsZor0vN+WP9zPT/madVkdUA5wrwFGNZ2Il6azGHdKhNbXt0aRh17l9oZIYi3wK+D2f9bDvHqZ8D1XAm9/4zLPV/Fxx+ZqFEWLXEondhayl7lPN78qXoOFIXY4C7YM33GoIcfUqqnL2feQtrRu+yCIbWiQnj7pmaGEkJBI0fgTDBGtn7PwKTSmEDMnyd2gSf6pQhkq75Jn+vXwlDTE/jzJq6DNomsJhlxp+iBgTdO8hmFW4lWX4FFzQ3FxaXPXVAY+v9CZJ1LNZF2CyUM1ci6yRF7as8+hBew5HfIEzIJSAtgD/PrQqRynailtjqncAKthDc95lMiX9p1xH7pIhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L9a/DwtVzcbI0SZs6p+1FcLGpm2jwidEaZ2TiS/gI8=;
 b=Yw8PRGcpsCqD9OSRbKeq8C9dZWT9WBqZR5AFkq36bIV/avjXJflnPhXJTyq/HyFQgr4ByurdWF6AYpwMnwRdFp7LI2odl0PJM8iEni2Wa2CFeGUZC63tNAiOX+r9BMxH6nghMpOuV4etubGy3UKm+TrGphjngRD4VeQgoUOpbeg7EikkZJ2osgBdLYl56NwLGVwWeP+lUGgzljoj/aOeEifUycD+w/Q3PSzNh9Zl1GhHDr6bm4Yqq2u9Izd1+1JZeVMh7vUosyDHAed+LXjryvBSDouP6fZaKy18HD+xmNKNDmtyvjoIRSSGJwdwAgzSUrlEzcdiCs6fJlA7W+OqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L9a/DwtVzcbI0SZs6p+1FcLGpm2jwidEaZ2TiS/gI8=;
 b=4wg9fxYT8o87i102NuixqDqNpTF5FYRvrvjoYoA6yB/VEt1Xit5wkQWkfToLzA5lSG8z0g3C99MzYKNGfaoqQ1OgARRy9racgdWwp6Y8hw0jian/hmqdgi4TrQdRLtR9rK/XZsbd011v+9zJQ8Gr5bD/xcIfSDCUibMYhvapHF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:18:09 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 14:18:09 +0000
Message-ID: <363d5190-3346-de1f-fe8a-85603b0eed11@amd.com>
Date:   Wed, 30 Nov 2022 08:18:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs: Integrate rustdoc-generated output to Rust docs
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20221128201932.168313-1-carlos.bilbao@amd.com>
 <87h6yi67mz.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87h6yi67mz.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6913cb1f-eddb-406e-f3c5-08dad2ddb507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJwiREONxDd+5VndM0T6NpySZ6YNtz/HDSRAcfuew8bjR4BAfBy17D2R5maNgSbTEih3yEUdSo5lk0O2GHlNBdNIJ9KcS2KXw9p/jiRL1XPxNfYuJ3qvWpDEUM/nsFtk0N5ph9qbLoYL4yf2e48Ulv6yQ5+WwJdAkRfxQoPTvlAV+piy/9jDU6z4lrYSPifqS/gFDn05ntDiuPPOYDYQh34hbkW5cmY1g+GD9ybkJh5putJpPfT7D216JjfBda6BbKfOutliFw6EtQ6PqWhQ1K5fZJ5GaAf8tpg0G05VMnfJYJEbqHB+dwCFegx8JlgnU7aX2bdHgnA5eL81+6iBbwn2RXbx0ipzYhto24VrhhkxR+DaufQUo5e5IFdiFP+fiqNKg35o8LcNK2p+jVo7P2LyuFuG6WSGfhPZsWtYbk9q865ZCVDcVieWMW5IzKRdTpOdwYagDQCx3dO0Ezvh+w6dCc3LQfQl6kQ1wZ4gFKMBCVWXhY83OAEhiBCURCyfotMmCpQhD/XbLliTyJ39adOg3LwMXsHRweFbVsFneRby8qKUmZXp+E6PP5XXQG9WLCcJJwU2vk5Bdr2TECU2Er9g0Ytm+G84bE7/cDTCcbF8dEvrtiaCKkuJaf52S/fFP479TJa9YI8K88vUyMOXKrzY9ex3zOEsH5ajl4UUrnfOfRgHtA0Iywo9SkSH2lKvfDVu+vxFGswXFITiVRG/fTVa1BNhLLaHbIFOdTilWFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(83380400001)(31696002)(86362001)(38100700002)(4326008)(66556008)(66946007)(66476007)(8676002)(8936002)(2906002)(5660300002)(6512007)(44832011)(186003)(6506007)(2616005)(41300700001)(6486002)(53546011)(478600001)(26005)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJTTWRoOUROemgvUXBXeW51aitYeWxqWUp2MlJ0MXdUMUtHdWRWTEp0Wmsy?=
 =?utf-8?B?bDVnWHYwdWoremFCdXgyZFYyakJ2MzVZTUMxSFJid0N2SnI4MVJwMngvQTRn?=
 =?utf-8?B?dUFHdHRCZFRDb0Rlek1HelpCWHZBWkN0RU5aVEI4Z1lCdm96UEZieW8rbmtQ?=
 =?utf-8?B?bzN5QVVmVkM0UVhlSzRNTVFOL3BpR0VRaGtwUlRpc3VGTm9TVlN2aExGTXRC?=
 =?utf-8?B?MzVmMmF3QTF5RUl5dllsOXB3SEFOa09nZ2dCUUxnaDdxbE0vK3lPelRpNDEr?=
 =?utf-8?B?N3lxYWZJcU5mUzVBT3NPTW8rYkw1NlhQMHI4bnFhNUdzMlRsb0hNb2VpNC83?=
 =?utf-8?B?aG5ZMFR4dWlpV2d6SFV3OGZYOU9Wckh4N1UvWngwQThzbHc2RXU0eXhJaGx2?=
 =?utf-8?B?bjNWV3ZSWHR5S05qUm05M2x5WVNmOXMvd2J5VWRlYXYrMzhUTXNLYWwzak5i?=
 =?utf-8?B?MkRyQXhYcDRhUmdhbDZQQTdZVUVxSzhoc2RIbTdBdU5mclpHMU5SeDJKdFZn?=
 =?utf-8?B?eWNvRG8zWFZKTlErTzNoaDhmajdqVzRMR2VtcTZWSUZNa0FSWGVhdXJrakM3?=
 =?utf-8?B?VmFseFhKQ1ExRzFCRklLenFzclU1eTFzc2U3VDh5VlRWbTMyWW5QYXJHSXdQ?=
 =?utf-8?B?c0wySU9TK3lCdnRuK1hKSG9zdmlTYytYaHVIU3pBbnRURG5zOVVLaWRTQmFX?=
 =?utf-8?B?K1ZwY3l4QWJKMGlnV05BYnBmMzZ1aUV2ZjF4QlMyNUhEZWRmU2VJVVVCSkVy?=
 =?utf-8?B?RHBReFZrYXNMN204RlZ2am9BRGVHL0RuRUhOYnJXNnBqSkNOaklsc0JDeit3?=
 =?utf-8?B?cVAxQWpINmNzWGw2YWt3RjhkUXlROWQ4WmMrZVFGZmMyOU01ZUtIMEZOK2Vx?=
 =?utf-8?B?TXhnUFJIdi9yblhQMXUyajBYODFWVEVOMllxSUU2UGovVTg0M2cvOVFVbWRV?=
 =?utf-8?B?a0ZrUFlIczdIa2FnNU96WC8rZXFENzJIekZOVnVWcVdRMktLUjQ3ZEptdzdY?=
 =?utf-8?B?SU4vai96RXVhK3hIdUtwcUU3STBNUkcycUZRUUE4UklRYjY2NERWakRKZHZl?=
 =?utf-8?B?TzB4Uk5ONnRYcCtNcW9JUUdINWNDYzVralN6UFcxUitNSU1mVmhRUVZ5YTd0?=
 =?utf-8?B?VnFTS3lVTEhPcnhTbC9CMDRDbXVURXI3VWJoaEttSGREeUFZenFpVzhNZ1VP?=
 =?utf-8?B?eDBlQTVPRnBRTTRWeXdYaVJreTQxeFBiT1lYTzEybzZoaEtLcXlRamdhRGc1?=
 =?utf-8?B?WUxoTnc1bWlpaTFRQURsL2c1Z29jM0NPM3BNOVRRcHM0QjEwQ2MzSjR4RW92?=
 =?utf-8?B?di8vV3p4VFp0aUVZa3JTVVowaG5RNzZlTmV4Qkp4SGdvdUF5dWl0N0NEUXJV?=
 =?utf-8?B?VVdhNGN0cGJTOWd3K3VndjRFSmF6SXFLb3h3cnd1S21YODhPV2RiSXJtcnM0?=
 =?utf-8?B?Zk9KR3JjZ2tITVI4azJWVUZiOVNWaGpaUFJEZXN6ZWRFVjRNdkwzTVlpSzMr?=
 =?utf-8?B?aG0xQkgxYTBMcTkvVU5ObHdhWCtuYTVlZjYxTzhZbFNnRTNTci8yZVRPM2RW?=
 =?utf-8?B?RkE3SXlSbHEzUEsreU5paWV1WDd4cVpWZ2dZejAvMDlha09qSWN2UG51SjB2?=
 =?utf-8?B?YmFhOC9pNU94eHBBSytLWTVFZFBBZjBrMUlCTDF1WTFzRHZKQ2dubGVhSGp2?=
 =?utf-8?B?YUdpTklmNi9Wb2VKTC9DSC8rM1JvR0Z2aDlBd1ljTnNPdkxQekhVUUJLU0h5?=
 =?utf-8?B?YjlpTGhpd0p0K2cxRjdCOG5jTEEwVHpZY2dPRlJMWW41MUNKWFNNMGYwaUpR?=
 =?utf-8?B?NG0wTk8zR2hxQmNVejM0MitEaU5OV1lwTXN1TExwTGd1VUxKVjFFN1VnUkJT?=
 =?utf-8?B?QndEeFpKN0daODlQZ3c3dkQrL0NiK2tpaHhuaDk3SmpQTncxSFZQTk1LdkJG?=
 =?utf-8?B?Y3JVS2ZnMEdSN2tOeGw0QUY1eUV2c3RsSWFVTnY0RjVHdDlDdXFoZnMzSFpy?=
 =?utf-8?B?OGZxZW5IQ0duUWNmTWJJUmsvQ3hvZTZ0WEpKWm9TaUdxZ1ZQQUNvZ29mdWtZ?=
 =?utf-8?B?emVOeTc2bW1rRFdGZkJGQkhoVUdEeUt1b1RjOHRVdHk2eDJJdTRsemRWdU14?=
 =?utf-8?Q?/znWqEsfAmzYtLkm/TKd7jYOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6913cb1f-eddb-406e-f3c5-08dad2ddb507
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:18:09.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrqLjwPQ2vNigqK/omV1fKUL+EFmf0IzgYvbKf4woIxuijyi/isYnKBBJMHiMSQtYR3f+LxjSctWwOFd33zFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 16:23, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Include HTML output generated from rustdoc into the Linux kernel
>> documentation on Rust. Add Makefile target `make htmlrust` to combine
>> make htmldocs and the generation of Rust documentation.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/Makefile         | 11 +++++++++++
>>   Documentation/rust/index.rst   |  1 +
>>   Documentation/rust/rustdoc.rst | 10 ++++++++++
>>   Makefile                       |  2 +-
>>   4 files changed, 23 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/rust/rustdoc.rst
> Thanks for doing this.  I do have a number of comments; please let me
> know if you think I'm missing something somewhere.
>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 64d44c1ecad3..02ed01fa3499 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -95,6 +95,17 @@ htmldocs:
>>   	@$(srctree)/scripts/sphinx-pre-install --version-check
>>   	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>>   
>> +ifdef CONFIG_RUST
>> +htmlrust:
>> +	@make rustavailable
>> +	@make LLVM=1 rustdoc
>> +	@cp -r rust/doc/* Documentation/output/
>> +	@make htmldocs
>> +else
>> +htmlrust:
>> +	@echo "Error: CONFIG_RUST must be defined (see .config)"
>> +endif
> First, if at all possible, the Rust documentation should just be built
> along with the rest; no need for a separate make command.  We don't have
> separate build commands for any other subsystem's docs, and Rust should
> be a first-class citizen here too.
>
> Second, I'm not a big fan of that "cp" command, for a couple of reasons:
>
> - It dumps a bunch of stuff into the main output directory, which risks
>    overwriting something someday.  It seems like
>    Documentation/output/html/rust might be a better place.
>
> - Rather than copying, I'd suggest changing the rustdoc command that
>    generates that output to just put it in the place where it should be.
>    Preferably it should work properly when people use separate build
>    trees as well.
>
> It would also be nice to set up proper dependencies so that the Rust
> docs are only regenerated if something has changed.
>
> Does this all make sense?  Sorry to come back with all this stuff...I
> really do want to see this happen.


Thanks for your feedback, Jon and Miguel. Looks like you both agree on two
things: htmldocs should be the place to generate the extra Rust
documentation, and this should be done by making rustdoc use the proper
path directly (rather than by moving those contents). I will send a new
patch instead of v2, since it will be a whole other thing.


>
> Thanks,
>
> jon


Thanks,

Carlos

