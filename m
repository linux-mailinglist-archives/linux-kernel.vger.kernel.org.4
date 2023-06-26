Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CF73DAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjFZJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFZJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:00:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C264693;
        Mon, 26 Jun 2023 01:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsEO4e8q0gibuBoYfGfCANjWUR0vznH/N8tcvzUFr0X7feR+jOvi5DLzj4tb9RfHRc6T6Cr92hqoD51mnVrDwUwJ0YA+Ax287FxxFYUqnNLd1Gin76vXGYEOIKoteng65r1tB4nxKPtswbmh86mpFZKlDTzpOya5Uzu1OYWx3HWQLj3VdcLKNGIufXQOQFNqu+6EgE04JJ8NKj8sbD9XA/cXEUlmgcAnCgy8ZFpp1wuhKWR4sHNMSPSGLFO2qTXUtbRac165aSWbMKx0po4EB6n+VTysVPliXi0aq9JIDe56zZLJjhUQ/ePq2lZGhyOym6cCbseCDkgIPJU6jH1xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L+zq38fp2M8Ugtr8/O2zCVrhdi2MBKVcQ8txfInd30=;
 b=Nh1ihuccD2aemieD8H8jXxakYUo1psJ0Vv3iUNQKMXuC/brP05+8DNpK0lfAhcIpqtiOYQZZoA64jgPEBuhD5/Vv8rms66iKYhhho3Hg987plmHy9EhhXxRX/VxPvYIJ9Ecwzw7ssB37QApEy4Egp538bTD+fpjl+DEKmMlvIj5BEwBr3y860ZQ/0S8cIbz/LrWJj/BVhHZdGzgZBAADm7vGttgsAHXHCmpZdzI5UQFqFkMcUBm2HQg37zHhh7i2WggbMoPLWk9DP+LG9exaBOz135KIcycn8J5R2FreJcbLTr32lPke+X1d//EnkSp2w5SrYq17K74VdVKLjKIpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L+zq38fp2M8Ugtr8/O2zCVrhdi2MBKVcQ8txfInd30=;
 b=JtORPzNZgL9YS4U1R3ig8bDk+LhypRzRSW2I1skrjSDzZEH1HGiEgeBCKvOjLrubVkpPqkno1MvAjluez3+eXiMncXrRdYUiIXXsycq0D5DPi841ZHELcGI00F/DDna8gPmN3vHvTmC4egYdcieFAFAe/CGtXxizItJOKkBoY5OfsePSY8D1o6nsxX50mYqKw7wYZQlHEQT0su7zSxsE5T8uNcYZcJX+zb5KqZBCbKX7a5We/XxWnxkRvGi8HSFDZCtx/JrZcJzC75cI6elUGYcTgJE34NNK3u/gB5LfJxG3Ue1ZlZCl3xoeJWalejSAUzG8UB5XkARmjsGgj/ve3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 08:55:57 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 08:55:56 +0000
Message-ID: <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
Date:   Mon, 26 Jun 2023 11:55:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230601161407.GA9253@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c94c461-58dc-4cdc-63f4-08db762327b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grDNIRtwT5gJH0gKhQXWnXYcZA+x0Ign48Rp2GxY9TInsKlME37NKiK6fR3WFkxHDvtGFFG0ME4DO61lnb4vsp2ndvBVcXQ6lYNuZLJGtDHTps52ZWmbkiR+plQxfk+xNG2nxcM8w9ZkAJT2dAncy02wKehqC7oNg+nQEKualRFDj8H5JUyIoSR5bw3eSGpvYBdDle4kTnGvfCfvN42krtJaqUjZwBk/E/WzFutArNRy8gCzrYquQceSjSCZb8la1vy5bBvvbNHdFALTk/45CWgpYaCGUIBCtBMuvSJFPlkVkez18QmCHhNY26bE+it0x/R7yuzfIg9TkILwdIyj2uGAq2qtC6n8r7sv9tFPYa3WvgsxGifqdjABQ1ExadUmq+OkLfc8tI1g/I5O5h65gNl5sTMxfd+wiCH+lN+09dxtYF5ZrGIzTM74LeAscjQQbPXhSSTr17y3y0e3A4WDejrSkuOlFopBqyoOnj4COjVagVruroPz3brPP4U16+cx9wFqVioZtiNOEvIAj0XlG5vsCGNzIS49fEqDKWUq1b37fgonRr0mYgCH+vWjaUmQwmRt58VyNtuCInXXFFv+MLJ8Krmz5lIErHtly/LXaS8t+uVZns+zIypHyVG9Y4Gh7TsU1JE0PRYnKW8xdA+ja7d+28FrpyuVaf+gcLsKRPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(451199021)(2906002)(6486002)(6666004)(921005)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(53546011)(186003)(41300700001)(31696002)(86362001)(478600001)(316002)(36756003)(66556008)(66946007)(66476007)(31686004)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZKNm5scHd6MndRMmdPSk4xdDBzWktvLzQ0S291b292ZVJ0aCtOOEZYMkxH?=
 =?utf-8?B?OC9TazI0a2xYNCsvWFRkbnRCUDBHZ3UzSmlzRjMxZndkakdTRHFKR2dBb1Rh?=
 =?utf-8?B?SmwzTHJ6T1NrQVNmWEhnMFRyZ3EvdXZLZ29nYWx4SVFLeXlUU2lXbmQ2Wmtz?=
 =?utf-8?B?OG9VeVJIYmVYdVZjY2dwUWdaZlBEUkkzK2hhTG5HSjJSS1cyQVVmM0p5Ukt5?=
 =?utf-8?B?Snhwbko3N1FHVU5CY3piZWluZHVXSi9tcW1MZXVUYlM3Ny9nS3FkbkRQeHpv?=
 =?utf-8?B?Qm9UWWJtb2R4dndrQ0VqQkRNL1pwOEJhQnRSb0IvR3l3VkJWbUpGSlZRcUd2?=
 =?utf-8?B?aUNTOGlXQUpjUDZHRHpGeTRQak4wck5sN00raEVJWGJ1WmFrWUR5bDhSYkhR?=
 =?utf-8?B?SU9Ea0J4WnJOdmVJRXI3V1FtNnNCdDZCZXc2bkYzcHc2dGtRTFNWZDUxUGNP?=
 =?utf-8?B?MEpkNEhqQ0pCZ0lmbHhrRi9pU2F3dlpBS1hHdVhMeXN3L283c2MzaTMrSFdi?=
 =?utf-8?B?dDJDSS9zWmY0TUJSQm9MY1ZVSVlZT3NwWmp3QVlGVmNNWlhYWSttVzM5bEFQ?=
 =?utf-8?B?TCtsRWNzbEFjTVByTjNsOU9MQlV5MTQwMFBxdTFkR1ZtSFlsa2krUkYrZ2Rk?=
 =?utf-8?B?UnpBVHJQNXEyNHJ5Umh0U1dOR1JPaU9KSDE4SkgwbmFSbG9QK3FjUUF4QWZz?=
 =?utf-8?B?VTBhN0VqZHAvYVhpQnk3UkgwcTdDZ0lTWHgwTUU5RjVaMmhqdFNieG1oanc3?=
 =?utf-8?B?NXVTaEZ4L3p2Yzkybkx4YUVlQnZBN1paUjhpV0lvc0lzTlJyWGxRR1k5NzVj?=
 =?utf-8?B?TzZMMlRZcTFGRUJBcGp4Z1NZZmp4WE5FdGZZNUdUaGJxOFU5TlpOaEFhcEJ4?=
 =?utf-8?B?K1NxMmZORDQ3MzRNa2hGUEkzS1YwMCtJaGVPb0lIMkgxTUNwYWNWWW5ha1NL?=
 =?utf-8?B?cUxHcEJwVWVVaVNQdWF1YW9PajFZdXhmN3RtVVZPaHdwZi9vZzNpSENYSUxp?=
 =?utf-8?B?RW4rWjNxZFV1ZU9qeno2aUFQMlhnZm9rbmtveWlZTGJTU2VyejdqcU1qOTNl?=
 =?utf-8?B?WnZESEgzM0lsL0c2M25XVkJiQzFQTVd4TlM3VEFWRWNVTzR5M0dXNjc4SmZl?=
 =?utf-8?B?a1kySG1QdFh1WnFuUzAza0JocjFTbWhlNXpZOE4zalVZUTFya3dXY1VvZEw3?=
 =?utf-8?B?cXJwM0xKK0FzUHI3ZG80UUttMEk5MytYcU8vZHZjUUlwV29YUkxPZFRtQ0NW?=
 =?utf-8?B?Y01qUm5YN0o0WjZXdmhmdDZUU1NaOVJGOGE5S0pYeUc3Q2JDc1JpbXBld0FE?=
 =?utf-8?B?V0gwSjRoeElmVFJ3b2pFZ0JJaTMxVEpRUXRSM2N5MXNPTjdlWGdHVFR5OEh4?=
 =?utf-8?B?UitMMTl2MGJJT0todkM3QnVCQ2thUFJ5Tlc5blAveS9QZW96ekZYaXZXNmlS?=
 =?utf-8?B?eTJwbUdDemMxdExWOXk2cERWdFZMWWFJL3R1RWhBQnZIY0VGSndkdHRXRE9p?=
 =?utf-8?B?QVZGcmpaSjJJVDhRVzJXbVZFbDRKSGR5TXBTL016Q3BxMXRKSXBNUkpOT1hO?=
 =?utf-8?B?R216dkpaQXlUR3Z2WVM3b0FtcjM0UG5lMzMweUl3cVpUdTJIS1ZWbmxJbEIy?=
 =?utf-8?B?L25kT1VlZ1JIMjFwT0E4aVlqWHgrbFYwVlpvckdXTnRaTXdPVklJUjBQM1ZI?=
 =?utf-8?B?WXFOU04zVzdCb09hWSt3OUxDY3NobEhaQVhaSGRtMlQ2S3huZzVjSzNTSWVX?=
 =?utf-8?B?NDAwbDB5cFBYYndwYnlJZ2FvY2s1eXhGOFBNYzJUZlRWemJzQisyUmxOV1M0?=
 =?utf-8?B?QnEwempEOHQ4R2hBU0xjU3pCc0VXY1RReW5BcWpLTGFQSHFrc25wZTIrcnZp?=
 =?utf-8?B?R29xWjZtRWFzMVRxL0xyTlg1M0IxWlpqUzNSNlNuVlB3cGZVek9sY005aUlG?=
 =?utf-8?B?OHRZK1ZNWTh2M3VuL2FLcFNkVzRqc09NODVrWnhIZTB6QUVzKzRpNW5WMFcw?=
 =?utf-8?B?RGZhdGVBNVNnVzdHcDA4RHlpdVV5T1ZERGNHOWgxelhBUGFpWHFwR1l4eXlu?=
 =?utf-8?B?a2RvN3RsWldFRGw2cWhzME9KS2FIUERZZEdaWi9aL0pBYzNlK1ZaSzhDK3BU?=
 =?utf-8?Q?qUWH/lzlQ6gQK6n+/Er0rU/8V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c94c461-58dc-4cdc-63f4-08db762327b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 08:55:56.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml2aFi9nI4ox91LJ+VdgEnGJd19XMGRxnNENfsBpBj0az8rwv5Fs3kZ2zcDQxsI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 19:14, Richard Gobert wrote:
> The GRO control block (NAPI_GRO_CB) is currently at its maximum size.
> This commit reduces its size by putting two groups of fields that are
> used only at different times into a union.
> 
> Specifically, the fields frag0 and frag0_len are the fields that make up
> the frag0 optimisation mechanism, which is used during the initial
> parsing of the SKB.
> 
> The fields last and age are used after the initial parsing, while the
> SKB is stored in the GRO list, waiting for other packets to arrive.
> 
> There was one location in dev_gro_receive that modified the frag0 fields
> after setting last and age. I changed this accordingly without altering
> the code behaviour.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Hello Richard,

I believe this commit broke gro over udp tunnels.
I'm running iperf tcp traffic over geneve interfaces and the bandwidth
is pretty much zero.

Turning off gro on the receiving side (or reverting this commit)
resolves the issue.
