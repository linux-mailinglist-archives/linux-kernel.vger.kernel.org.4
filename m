Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2047200FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjFBLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFBLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:55:28 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C7FE6F;
        Fri,  2 Jun 2023 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685706899;
  x=1717242899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W1xXe/waVmb1aDIOpwF/BjEtm6vCVUCNsctp6WPrBrk=;
  b=SU4/+Sg6Yn8N8JClkFiXgGbEdpF397QlCE+QnrgjmavNpLK+MDWd9VHW
   IawCgUUoggmO2XDU49jtGeMHZx2adcybTp9Jtn9Kv2xpKN42p/H+23Alm
   FPn+32chBIVNpOsQ6nDPTqqWTup5QbrOrRR44WAzJEmhRr7J8xR8Pqj0a
   8ddETJqfYlS0tNm5wRd99V/jUQnDhdFAjMsAY6g1qXbLiYyiy2fR9o6TM
   v+RpIS+YuTA7INpQzyc8Fop5ealuEzGPb3bHHZ1ynnXpE0V/HRC0Qyi7M
   c3QxFkH79DJZo+qhwQSjIAViNEEs6HSDXUAUsSZy5ElfEBL3MisJO1QXw
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW+dhrQxPQojoN1lKrNDuqQjcMosPZW+4SnbNBIiGyLIMwSxtJ7E/qs84us81Qm2OM0b6u/UdFA3CQYFcx9oj5WUamcsdkX9LEOYY/yPhLsku2l3pZxzWU36vZ7mXVsObfZvE+NOSNn/HbS6xokOz+os/mZ9WY/uvikfHDhxZHK/iwxfKH3k6stwCDfZGrwmAhYp1NwBX9llMd9KO9WF2si7e/m7Id/+2uWefdSNDpXTKQhi3ykNM7Jhru/af2YWhsAxdcuMBQr1AHi+jXvhxh/dSJW/q1thIZiMorA3NLk24ImJSdC9lF2DsArIBKZWqz7GN9f0sojPMdi8O6FPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1xXe/waVmb1aDIOpwF/BjEtm6vCVUCNsctp6WPrBrk=;
 b=PzUtUud9/LQWhWkFOvCfd1dRhTX5WvKFGrABOpHA1PIyLCw5aViTvng+CnF8nABjKQ7qOx8emixcGQHkVMnJw+djaV4IfQJnO8BRaQVikWOWnh2xlWV7m4JWf0FxFXoh6FaUkqXp9DMQjbyPzP+GlJveCh94lmn8aITdsq8eoOhTEHL8c1x6OcoMl4C/7lWSgRsiu0TONCj7f/uX7YiljfR6RxLI5fyK0sDs2P+FmDMDyEZnjjUfwp96Lp6q5byfN+c0PtKfLL/GxBmHsGcXUjkGyjYqYRbdK/7/kAxmGVfVZemqpR45kPFLrKueyid21OBsIi7cIQsZK5+67kHnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1xXe/waVmb1aDIOpwF/BjEtm6vCVUCNsctp6WPrBrk=;
 b=uywIer6dCNmWvSM8mAn1pMAfZoMniwZuk8eKQydKvbezVaU2S2eVvLTI9v68cirsDKy2E88dwVbdnBodESttk6omwcl+1U/MsKshdkKlAEWl020Wh6PTYhqVMXPsXqt2GPSe05zrUBi5RUX7h/Joz/pJfpSJNDKxP+xJXquVj/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <c2420c01-1402-cc32-edae-228ef5b8506d@axis.com>
Date:   Fri, 2 Jun 2023 13:54:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] spi: spl022: Probe defer is no error
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230602-pl022-defer-fix-v1-1-b80bfca3e1b4@axis.com>
 <b1c53730-6675-4c91-b891-cdbe57576759@sirena.org.uk>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <b1c53730-6675-4c91-b891-cdbe57576759@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0011.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::33) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AS8PR02MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb82f10-dbda-4a0f-3eea-08db636013e5
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQyIf62w13Ca6wEkJL7+zUYz07uRJEeq9OR7wP9banBHdz/2zbK6b2xR6B8T6Lu1VVuKebNWPYzzoIflFlUYeIp2kaciRITY8UCmGUGxcr9dmQwpGQr+2JoU31iIMY8LvjoWANPhATSIvinuWjr9d0/TGv8ZHSx3fQLRXnrv7m5q6SbRddL2wckG4U1zCdWP3tra8oGy/Aezv562wM4RxJob9j65X3KpiONJyZDYbv5tFYiLFof23CX7ApFpNyHexkyUn9QYQTd+ThVIxKtSFw28M0Vf1y0yIKxw1VAElb2FWlzfZYS2iSzSMxX29h2zwYfmUVmwvJSmjbKdEbJgLWgoWITXJ9Pc50z9sHlIo3/nngTHaGSBa/+75lVWkMVBWiyf2p5lPxeC35lAQhfFCB0o9zxQ0zUH5VklkOKiErYlh3IOjT5+gBW1cYfJDWknfTmjCmSgkNLo4FqPVRzd6XsllKtc5YMeD3Q+wzWMRRhA+tA+yEMO60X7IOm54n/42+rPdi6H3IQsyTdUI2R08oWNuQUHjQ+fRoxog03RktKL+ErI6RjL4rnEjZaB+JQY7H+bKNqT4MamPeCTpxw91rKocY3IWQsmJrNCJDxNI6GsdpDrlO8Bs17RRq1jTric9gcTDemAz/LLVeY2A5h4Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(31686004)(31696002)(38100700002)(8676002)(110136005)(36756003)(66476007)(66946007)(66556008)(6636002)(4326008)(478600001)(6486002)(186003)(6512007)(26005)(107886003)(6506007)(53546011)(4744005)(2616005)(2906002)(5660300002)(8936002)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpIWjN6N1VMTVloSUhlcE5ELzBPV2VRbDZEL2xNajFKdXBGeHYvWDgva2ZG?=
 =?utf-8?B?ejB6enR3ZmhJaENGSXB2YVFxdHpWN3NNaHlkL1RmbDBEdDNsdUxXSkQwNjVj?=
 =?utf-8?B?OEpyQ3cyempNWGJEUk9Fakh2QUJpRWNBc0p5d0s4YXEveVBzd295YmVYdS8r?=
 =?utf-8?B?a09OaWpyRm90dEg4L1Mya0hYMzJ3SWFhRkdDMUgxV0M3eWFSblZEc2Zma3BD?=
 =?utf-8?B?dVdEMlcvenFMUnBLbzFBWk5leXQzc1hnNTlYc0IvZmRpY2pQSnBnVFBDTStP?=
 =?utf-8?B?TG1MdFJnS2I3bGdlZkhqOGtXY0dCdnowWWg1cWhBRjZtZjdGOW5tSGxuMzJ5?=
 =?utf-8?B?djNCbitFczhPWXQyNmJId0xzaEhIbUtPWUZ5YmduU2Y0WVZCMmNsTGhWNjlo?=
 =?utf-8?B?Q05IRS9nZjdMZG8wVUhweGxERzR0aWMxSnc3ejc0UkdEU2hTekh2VlZFbW5W?=
 =?utf-8?B?dkE5N2prZHp3aW9Ramx6Z0NHUktnMXY5eEthYkZHVzByMU4weTJYZ2ZuV0du?=
 =?utf-8?B?ZFF1ZEhqZVE2MXg2blVKdUVvRlR1eTZLdWZZL21QVStzS0ZWallqRXlTdjBM?=
 =?utf-8?B?RDlRRll3bWhESVFvUElxZzFkQkg2Y1RQOXFka2NQODZsSUZSNUtWaFJNajZX?=
 =?utf-8?B?dENWZE5oSFI4Y0paTjFzSkN3aFB1d2tBalMvSWUrOWVkSVZxUHM1b1dLWWxZ?=
 =?utf-8?B?WnZyd3Jpb2NmOWhsK01OMUhac2dpTU55T250dTFuUmdaRERqUjZLSTlqYmVu?=
 =?utf-8?B?ZU9rZW5qUmU3Vm9zSkFYTk0wZ0YvQ0I0SHhOKzRvSVJZYWc0cGJYMm45S1o5?=
 =?utf-8?B?QmtvK1JqSmZaL3ZxcmdYVXZYSFB6ano4MTBjL3ppMHl5WURKQWQ1RVpsWXhj?=
 =?utf-8?B?ZzBvZlo2OXBuYmdYSkY4WkpuelduVEYwQ3hCUEh5a1MzcmJwRm9VYWFLcGJx?=
 =?utf-8?B?SGNJZDk4VHRUakhKeDZaMm5HZFJVWG50R1B1dXJUUkFvcFZ0Rkt1ZzdkcGEx?=
 =?utf-8?B?Y2UvZlR0NHpUd3JXV2gwZTVOMmFjTUR3RDVaZW1jWlovcXQzUUVkd0EzcXgy?=
 =?utf-8?B?U2pDcXZqSWFqU3hCMEkvMVAxOU94MDUwbVM1dnpXalBvS2JJbWtueGRLOS92?=
 =?utf-8?B?NjZrNGF3UkxQeGZ3NlVBb3JvaFhEZHYvampZNEFJUXdkbEFubDgydmd6bG44?=
 =?utf-8?B?UFBYVy9FcGhZOFZ1eXE1VVlFWmF0YWtXODArQmpwdVA1MmRjMUtZVlc1Y2xj?=
 =?utf-8?B?b2toWDNzUkRXV01YZE5jclhCRjZnOUxhZytDVzFrZ3VWMGRSSXgvZUt6Y3o4?=
 =?utf-8?B?Mzl4emNreEg2bDNCNGE3a0gxOGpNUTMzRmhVRTlPL1hzVDI2bktoQVFhUWoz?=
 =?utf-8?B?cStoa0dmQ1V5Qmd6UFpEZ1A5L0hXS2lLQnVnYk9vM0RhazlNbXJnWDNkcGRW?=
 =?utf-8?B?N3hTZzJKOEt4SEZVRjNrdWZvMEgxZ0xtKytINUhQQXdwWXdZTUpNWHB1TEZG?=
 =?utf-8?B?NXNIcEpPSHpMSmMxNWxKTEVpem5zZ011MzRYUk1DOVZVN3hIRmg1UVJ5cGls?=
 =?utf-8?B?YVcySXR5bUZaWndvUDJKZEZKd01kWGszemtuL1RIYndnTFJCYm4zQ05QWUlv?=
 =?utf-8?B?Vmp3NkhRMEZWTGVjdG5OVmd3b09kSVFMcGNPWjZQUVdRTkRyeE5jMTJndkVv?=
 =?utf-8?B?NFpPaHN4czl3Mm9EY2ViVUMvWmUrV2NwQWt0d1F6bVRsMjlucndTRmFPMm9P?=
 =?utf-8?B?bXRiTFAweGlTbGFoS0xpN2U4YXh1ME9Yc0N5aStNQ05lNStJQXp4bUkwSU1m?=
 =?utf-8?B?aGRXTzNCVlIrM3g2ZjRHMks5Zk5pMit1S3pmVWxCdzlrMWN2ZlZWdkh1T2ZW?=
 =?utf-8?B?aENraHdkd3Qya1VWNld3VTM3VnA5VXZHNnRhdVhKRzZyRktJQXA1b0hxa2ls?=
 =?utf-8?B?MklVQzNNeUVsTFlndUhaMzNxNmE5M284dzdwOUlUUGF0a1VUc1lyeUE4SUt2?=
 =?utf-8?B?OVhPb0FhblI1ekVqMGVZTnFpUVNHNFJIbTdSdURiQTNKVXhlODBiUTErVEND?=
 =?utf-8?B?eDlIOXIvSDBBLzlSeWNla1g3QXcvZWsxY3oxQ3dsa2gzaDZkMlZ4dENsYitS?=
 =?utf-8?Q?Tjb8GJP+c45Jnz/YViVdcnyeR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb82f10-dbda-4a0f-3eea-08db636013e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:54:10.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LUJXJV+Y0UtkUI4fHxEPlKnESpMhTxkxJ92cwDb/2TmF62dCi5Mx2WYzjhOjKBcN+yaepcRSE8IU+EwMiBJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8366
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 13:44, Mark Brown wrote:
> On Fri, Jun 02, 2023 at 01:11:51PM +0200, Mårten Lindahl wrote:
>
>>   	if (status != 0) {
>> -		dev_err(&adev->dev,
>> -			"probe - problem registering spi master\n");
>> +		if (status != -EPROBE_DEFER)
>> +			dev_err(&adev->dev,
>> +				"probe - problem registering spi master\n");
> dev_err_probe().

Hi Mark!

Yes, that's even better. Thanks!

Kind regards

Mårten

