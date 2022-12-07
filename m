Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52C645B60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLGNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLGNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:49:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00455C82;
        Wed,  7 Dec 2022 05:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR6oLjD6TmjpRdeRsym8TzBik01ehIwnY9XoIYDGGoy43m4Sk7MRu5DSr5pdzbDPWk7x/KkWCX1J0MyubCR886ozQrGhpCVkm4B+fyu5NdmGoTpNI3pwS+47sGYqHbRSJLudU2n4ZZuIhi/XIJDUMgGbaLnVYKbr2Cm2F/KRmMH506/T8LNmwYwjm9NiqBqZwNi+2x5qS2v/IVRTz9JfXnEn5+wsCLG6cYs1uzKkZVqktQlBVlM5RL3WEdhdcUKNy+nDo7sHDQj4LKzcn4O/14cfAisnweGOgTw1kxIubEZHhpV/QQpZ4ypKltMH1AmbE23keHhxKf/UvjiQE+uH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uI7JSAhw4ecGfU1CI/jBM+BJhntBrol08gu9ZMoNNU=;
 b=V3vgf/l7Go1coQJiQRJ2FT0XfPzYG9hssfyZ2d8nsKt/5QeyogNzZDGOw1rMzs2GNSU5QYbt6+ssfpqlcmCfYRkhyAWmUMtJDj2msADDORRD4GsgXWldk/YPkJGSY8jH6Pr01diBEhQ71SMOiRAshtBEtujmpb/p0xDMOChfsR0P3OFsLuzkunE7eRB0B1ICQNDNneX91tBJvfPwxHEzIgrkA4h3SGSx3TDJo4s8Anyv/w8y6v8kORdoIyOaPB3HZQlFPIOQj3U4QDLXDre3Pkc07NHHBsUIDj28D9p+a+TouQEAmCJ8NOre4s3OKEK5c83Ly388PvS0bqUU0EYqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uI7JSAhw4ecGfU1CI/jBM+BJhntBrol08gu9ZMoNNU=;
 b=qyy2LWi0YfutK7mRZHycW9Nh+F8ktY5HEzCkDu5PDNuWqdUZpwb0Xik5lLA7oZSoNKkLVks3ggM5oI07znMaTTubxUEo771dh5qimSXcHIeQ563RX5dJYpctb0+p9+DwUtDySXMPSeCS3UbO+dva22DQWRNMK5iOlp6K1+G6KK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 13:49:28 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 13:49:28 +0000
Message-ID: <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com>
Date:   Wed, 7 Dec 2022 07:49:25 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>, corbet@lwn.net,
        akiyks@gmail.com, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com> <87359r39gg.fsf@intel.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87359r39gg.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6bf6de-295c-43eb-45ea-08dad859dc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcYV3TF0E/jUxkq53ACBBJk5WbqFfgbt7FppnuPBApTQPoL2RXTawUh3pQ0pxFArbbFX63n5ePIjF6eiWUDmSQg9X5IGi7lJ3w68ASe/2lbFZ8oE4/qw8YMFhnjJNF43WLJ4SfO4hS5dFFHajRxTHhMVPC1wPs03+Y/sLsfx+fBz3EA5I11kLVJ+nSwQ92uX6wol1pwWlh7RImiZY9A+6KUe+4Hbp+DHgNSr1Puc12NNQFa2a53RjlDvJI5uOxpcNTvavM3wv8xFjyneykugjuBIKyTGZlkp/iYLGBzgsiIRrUJXgb42fK3usQ6YmX4EG/lTZvZmDtBBTLPSFsdtgvUFtadoZ7d1HrbfHoelMAd6uzT4cr/KfjkGA/E68e5phdIFBBZanbgxfeHMrPctdC69nv73OLhXNZFZNCCSVdUQBqKZdP11NTsR3xFvxuN3R2RNIuKs49fvgwFREzNQBlm9bEdVpiQ8UzzV2mMurJolS3eODr7MZcC/n0GQeCk6PmGIDe+vv2bqlpLMMRl3ijGJT2IfYT7kTztt3gY/5zSQZnJh5JhamRDkchFdd7Y5V5ipqIs1s+jJPcexyfOzWHO9jvB5ENjZCNKXlygIJKy4n9xVdkwHYFHwlluOw8EbpuKgL9eKJ6y0f82fwY93E/LL/062CC06qQJt2EvZrhBurCERYH8uheGRvNskgqxrWS6fuWCcMFq0GpWb5YhEFPHksmP1Rr/KOOw05hSWv1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(86362001)(31696002)(66476007)(36756003)(41300700001)(2616005)(186003)(66946007)(5660300002)(4326008)(44832011)(8936002)(8676002)(478600001)(53546011)(66556008)(316002)(6486002)(6666004)(6506007)(38100700002)(6512007)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlIR0g1d3N4WTNlWUdNemFLWVVaajhnOUg1YlFyVkk0c0dTbHQzby9BU2Ni?=
 =?utf-8?B?OFRpM0Rsc1NlZFBpZVg5YVduQ0IyejgvbW9aS0VwTzB2N1llNWljbDUxOStt?=
 =?utf-8?B?ajZDcHpWU1A2bnZLY3pRRXl3QjJmZGxKTlR6Vzlqay9HZ3kweTF2QVlVTGVD?=
 =?utf-8?B?U0wzaXJqa3hWcXN5YlFXT0lYNzB5UEQzMHBKeUxXLzJ3T2JweHZ0WXNJb3Fs?=
 =?utf-8?B?bU94VERHVmNyNzBWNjRNelpyK3ZSRUJBRkhhVGVZVm1ndlppdjdxQU02TGFB?=
 =?utf-8?B?NGJsTnVoY3Q0bWl5VWtzWExQWE8zS1pmMEFsMDRndVFpOUNvVnh0akpseXpF?=
 =?utf-8?B?ZDVWelFEc2J4ZzJpcy80Y1YyTXlJQ1FIQlVoQWlZYm9oUHBHN0FmSjd5cTNl?=
 =?utf-8?B?SkpuMU1mcWJQVzhGNU16MWE2cS9FMitkaHJvYlNuRjAyQlRlc0ZpbTQ2bXFx?=
 =?utf-8?B?cGo2MFNjcTgvN01iVWs5QlRmdUNNT3BrdWJTanJ3UnZlenhLK0NuSW55dU1i?=
 =?utf-8?B?OGNIQk9BdjduK3prRURtS3o1RmJtRk9pRGh3K2xtVkM1UGdIL3BFQUJxckRF?=
 =?utf-8?B?N0JwQ1d6ZzQwaDY5a2pIN1B6U2J3QkhWYlVFeWloZTg5STlVZTgrZ2lyemYz?=
 =?utf-8?B?ZzAxOGFuWlczUjIvVXlraXhscHNnRkR1WnhyancveVVUQWttUUIvQW9BVUoy?=
 =?utf-8?B?bXR6TUg3dGk3OWtrYnBBSEx6NXUva251M3lMQjFqREpYelBOTGI3MytndWZX?=
 =?utf-8?B?b0NMMHBNa1Y0ZlB2dlRtRjRzUDUzNm0vSWI0RE9GQkd5clVqbldnaVhYRWw3?=
 =?utf-8?B?U0tXYVNLZDhkdU8xRmhHY3RWTnhlL1RJUlNNMm5BMWgxS25hanByaWJuQngz?=
 =?utf-8?B?TUQzU1Evd2wxNVFBYlBPNkVKVkxMazFEbzZQQXFiV2tuVENRZkpsUytWcFpi?=
 =?utf-8?B?bVkwc0FPelJHZmZyRFVPM0Jva3J3WHV4QzEydmJ4MS9PUEhVZlBHUlg2NzN3?=
 =?utf-8?B?REl6SHBQWlJkMnJlYzQwMUNjc2dVSk8xQ1FyRkNLc1BUUTFOSmQxaXA1NnlP?=
 =?utf-8?B?UDJEL0NOeHh4WDV0M0IxMjZIdlRRMzFLYWN6S2Y0T25oMkw3YzJWU2lucVp3?=
 =?utf-8?B?T2QrMDZiL3QvSzYvUzJiRm9pSjZOOTRzemRLdDhwTjlkODlkajVzNzVpY1pL?=
 =?utf-8?B?UnFaa1NnUlB5MTVaRHdSMnkwcGIyNE1UaEdIWHRnTFd1QS9BbWxoNTk1MVFX?=
 =?utf-8?B?dm5HaFFQN1ovUTEyTkdOMlRkNDRxeVRZRGM1OXpRVVN5MG1ybzJxU2lpbW5n?=
 =?utf-8?B?dHVwV3JPeHhadm8rZyt2Z1ZlOVpCeUhGSnVhSVM3QWxoZU4yNXBGdFVpdkZn?=
 =?utf-8?B?cld6RmFQSlV5cldydzNPVk9wRzcvQzVpV0ZjZFRrQTVmVnVjNUtwYWViUTFV?=
 =?utf-8?B?cS9rbHdjNVRKcjZnMzkycnIyRmRVVDBWMkRwZk9EaGpQZUphaWtCZXo5c09L?=
 =?utf-8?B?bUJjRWRLcmNwTHJKdzV1TG9RT0hrZXNwZm9WSG94ei9QdEJLT21WNjBsNndY?=
 =?utf-8?B?UHZVdTRuOWhDZUd2bW16bm93dC9TZCtyWUE0OG9Vc3VCSENhZGZnb3IwdWFv?=
 =?utf-8?B?VWxhelluT0MvUDR1bHB0RzFpT2ZvSmc1ZzVnQzdoaURrTVZPaHZ6YUFEQzdp?=
 =?utf-8?B?Uzh0MFdDSjdxcEYrYlJTRVo2cDFVVE9oVEdJYUczQ0tYdlJ1WkNZT0QwQnVw?=
 =?utf-8?B?Wmo0YitUaXErN0wxMHh6TEdUR0JjVlptUFBkckFGVXJjV3hvMGtIQVBNRExV?=
 =?utf-8?B?dFQrNy9Wa1dLNjJxa3RrM1hJWXdONVVCVW45cFRaUktFa3VtTVFxNWtxNWV0?=
 =?utf-8?B?VXM3OTJIc2Y2M1R1RGpoYjdZblFaU0h0aUxPL29TUnNmODViQXE1d3JITVdy?=
 =?utf-8?B?QWZFYk5Qb0xrSXUvc21xSWkvdTRrVTA2WWdlQ3hFa3A3akNoY1l2b3dsTjJn?=
 =?utf-8?B?TVBHZHp4N0VqZUgzVUpKYlV1MmxJL1JiYTlXQ2dBc1d2K2tmUTBaS2piR1hp?=
 =?utf-8?B?Yy8vNXlJcy8yaU5xVURVa3g1WHdLUzNMNG1JNzZHVlpNc0hYd1FCbGd1ZEND?=
 =?utf-8?B?TmcrOTNRb0JCNnpkNTNCUUVHNmNYQWEzcHlGU2lpVlZOYWRkNnFnaFlYRmtH?=
 =?utf-8?Q?FYzR7NstYpavj+5PiKzt7Y3IY3zEizXJjAlQX35ia2at?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6bf6de-295c-43eb-45ea-08dad859dc1e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 13:49:28.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrxL0lpjDUcMjoew801eGkD9eLfAXqPKMWeykWB/oLcr0CtZtpugP1Mi1Pl0a7hBYZ32T2T9RBukdew/+X4WQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 2:27 AM, Jani Nikula wrote:
> On Tue, 06 Dec 2022, Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>> Generate rustdoc documentation with the rest of subsystem's documentation
>> in Documentation/output. Add a cross reference to the generated rustdoc in
>> Documentation/rust/index.rst.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  Documentation/rust/index.rst |  5 +++++
>>  rust/Makefile                | 15 +++++++++------
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> index 4ae8c66b94fa..416d6b3de1e4 100644
>> --- a/Documentation/rust/index.rst
>> +++ b/Documentation/rust/index.rst
>> @@ -6,6 +6,11 @@ Rust
>>  Documentation related to Rust within the kernel. To start using Rust
>>  in the kernel, please read the quick-start.rst guide.
>>  
>> +.. only:: html
>> +
>> +	If this documentation includes rustdoc-generated HTML, the entry
>> +	point can be found `here <rustdoc/kernel/index.html>`_.
>> +
> 
> It's a bit meh to have documentation that points to places that might
> 404 and the user has to figure it out.
> 
> We can do better than that.
> 
> You could use CONFIG_RUST to pass e.g. "-t rustdoc" to Sphinx in the
> Makefile, and use:
> 
> .. only:: rustdoc
> 
> and
> 
> .. only:: not rustdoc
> 
> And document accordingly.
> 
> Also, please don't use "here" as the link text.

Why not?

> 
> BR,
> Jani.
> 
> 
>>  .. toctree::
>>      :maxdepth: 1
>>  
>> diff --git a/rust/Makefile b/rust/Makefile
>> index 7700d3853404..080c07048065 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -1,5 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> +# Where to place rustdoc generated documentation
>> +RUSTDOC_OUTPUT = $(objtree)/Documentation/output/rust/rustdoc
>> +
>>  always-$(CONFIG_RUST) += target.json
>>  no-clean-files += target.json
>>  
>> @@ -58,7 +61,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>  	OBJTREE=$(abspath $(objtree)) \
>>  	$(RUSTDOC) $(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) \
>>  		$(rustc_target_flags) -L$(objtree)/$(obj) \
>> -		--output $(objtree)/$(obj)/doc \
>> +		--output $(RUSTDOC_OUTPUT) \
>>  		--crate-name $(subst rustdoc-,,$@) \
>>  		@$(objtree)/include/generated/rustc_cfg $<
>>  
>> @@ -75,15 +78,15 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>>  # and then retouch the generated files.
>>  rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
>>      rustdoc-alloc rustdoc-kernel
>> -	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
>> -	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
>> -	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>> +	$(Q)cp $(srctree)/Documentation/images/logo.svg $(RUSTDOC_OUTPUT)
>> +	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(RUSTDOC_OUTPUT)
>> +	$(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
>>  		-e 's:rust-logo\.svg:logo.svg:g' \
>>  		-e 's:rust-logo\.png:logo.svg:g' \
>>  		-e 's:favicon\.svg:logo.svg:g' \
>>  		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
>>  	$(Q)echo '.logo-container > img { object-fit: contain; }' \
>> -		>> $(objtree)/$(obj)/doc/rustdoc.css
>> +		>> $(RUSTDOC_OUTPUT)/rustdoc.css
>>  
>>  rustdoc-macros: private rustdoc_host = yes
>>  rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
>> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>>  		@$(objtree)/include/generated/rustc_cfg \
>>  		$(rustc_target_flags) $(rustdoc_test_target_flags) \
>>  		--sysroot $(objtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
>> -		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>> +		-L$(objtree)/$(obj)/test --output $(RUSTDOC_OUTPUT) \
>>  		--crate-name $(subst rusttest-,,$@) $<
>>  
>>  # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
> 

Thanks,
Carlos
