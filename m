Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE71469F1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjBVJi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjBVJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:38:29 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923A86A1;
        Wed, 22 Feb 2023 01:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln9emNSOCAp0CtkAe/YN2iZH169+QITq5kP/pyG4tJOBXR1XJhEBmVauGDOd61Dqw0ZZIAMzKPJXiqsje5Qtaf4PbcHamtEbzpKpvlHC5odx1XNejw/V2MmFqHoTTKn76hz6bJzciM8XzEN/xbQf0l6xomG3uyIQCzauIToEgYOD1SQ2xGzKwdEpmVtCwIJucKGecqoFba8k9V0pinoYECGaFdPYhdWVQY5AeGsGH2IrW6Z5i69LIbBlGfOeTRGAGhr29bWHggo3KOCbOsgXuC+J1rqenkZUmNF7a2BX4A/8NMPETs24MZUwDo5h/apWeRc5r66mK8P9JpAxHN7oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+jFSBTagmCyAr1Fpq3faIHE1GB/9oZ4S2tmQNrABdo=;
 b=TNFy8DZ61YHOGaTVCgVMcK0q6TIAC6aj2/2g9wCX69vW9ISVsmsSP1Enavl+QUhwLy+TiJRWqWegWpwD2pRQlxjzbPHbqbR/cQ6RCXJlWr9NPvYWu+8+tPHFd02iRMB0oVCMB/OJMb7VEw3NgMV3qhVY+2nwTsR/bs0OawN2/Hbw8Px4S6YSQJ1zhuLA8iSYyG/aw1GaEAPF/mAbGq9L8yXNuiBmfT4gTUgizsXy4P8N1VGleuqR9X8eFgRqrlupBCm6T9aXPGyp9DZoTCnnzKYucc5psPvf6W1aD9bDhwq4rVJcFY/c+lhoCj03H5x/oIf9hqqiUc2NguF59hbCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+jFSBTagmCyAr1Fpq3faIHE1GB/9oZ4S2tmQNrABdo=;
 b=DW48rQr4IyrctZxctLmz7v9OQpaBVFOMuqZ+ZGU/v4vN+ANwxmNcnMCgn6nVysuPaUZtNbTjPBgLCf0jbNNLT70wc0UNdZiMKvYTBokL3j7SrvwKQzD9BrZaQ3qE2BDVSszOfn7xVcbrjxpFqXIOuXaZZ8jq+xxx3AkqFZMfw/fjLQAOUcByEBohXxq5jSucVVdFzQ0M+kUPQQx2Y9VfXHyPUktYr0Bp/BptMhm+ql4Hi76nzwu8NsSl+LiTaHDHQpBQFeUq+8c6GOgyCJ2K1XZI2LsMvXShyLZEtDLAUTyLZT8our8r4I5JczfLeu8c9TcCKvaonsUPLIUsp7HM5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 09:34:20 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc%7]) with mapi id 15.20.6134.018; Wed, 22 Feb 2023
 09:34:19 +0000
Message-ID: <ef80c145-e33f-4aa8-c9e8-c77f34b1bb0e@suse.com>
Date:   Wed, 22 Feb 2023 10:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222013944.31095-1-michael@allwinnertech.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230222013944.31095-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 74682711-2f48-40a4-0b6c-08db14b7f930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF1zul9bUBmZRxY5XbEdS1d20aVxu4ocCck0/oPNA8/MI9+3N45odVESQ0tsX4Ry8qEePdkBqEJtUNbYuBfZ0IJ+jaXIo9SuE0pS/q4mrX8pZ8H0/FO1TIjmDxje87RHCDCnCqkCcECxtk1YqQ0ExcL+89+KmAsbqH1yFlRGxv0ypL8XYCVZQxQJqKxb7/qhfkgXRW9kq/9V+Mpt/Fv7OGjBAXLEf+0n+FT/xECPHvq8uky4aka0F6+re0zAig1bjUXgQmaLWuyQ0tJslmC68MboFjPcDj/RPJPDyxOO0Nt8HPHcI9R84HOsfPlhKpQjQInpvMo9ZvixzYrTiqCBan4h0RV6aPSSe0iEqkLwmgHCfh1rqIRa8rOuaMyD3oQev7GjWgki2Ox7GzCop3ftYQasVxpXjAXXgU3h9PVpfmSAZT9ssxrDn1MQVnf5rRatZyVVhBuQcuqkxq+IYmj6Nt1vP7Q7kEN1poWc+/0ZQ0JDTkmEFGOPoWvsDJUWk+bf8H3lJhTwr85lVE4sy+l19+7FlAS+nPEYwKJS106TjZIbsmMPhJdBF5IZmmt1Cpq+YYWctvMO0zYwAffdmJ0xkQtdrkPqj71pwknAF7o0/4LJ1VN7FsK5Br/Mm21KWQkNLrzvBMTskR4K/OPIapw04jvVcXRbis5rNqNiiryTEIGNskDfzjLEV+TtrpPvSey8q2VVSSYqSC4A2md5EHUAIu4yIgbcnTbnYOj9go9Q3Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(31686004)(36756003)(86362001)(31696002)(41300700001)(4744005)(2906002)(8936002)(38100700002)(83380400001)(5660300002)(66946007)(8676002)(478600001)(66476007)(66556008)(6486002)(53546011)(6512007)(186003)(316002)(6506007)(2616005)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDlXZ3ZyNC9tM2tkYVM5YVdrbWsxbDdscW5VQ2M0SEpZS2xKUWcvcnRPWGE1?=
 =?utf-8?B?SnVjQTZqRmxGZUtNbG9uMzlzLzdTS1c2c0ZoeE9qUnllL1pqU1pLeGRzOXEr?=
 =?utf-8?B?d3BkZ05nL3V0ZUZhVXNaV3pnUHNDVFdnSnBKTzA1VURuSmdkUUcrMjJoZVpO?=
 =?utf-8?B?ZVZoN2tZRkJCZEpUNE9aRXkvc05JVFBNQno2eEhod3VPQWNabDBkUHlKalJw?=
 =?utf-8?B?bWRLaloyQ0E4dDk3ZHBoZTJ3bnlVRjFXOVRsMGEzMDluY2hWM3FHNFFnV1Vz?=
 =?utf-8?B?eVd0anRMM1Z2VHhRdUZOYlBaZ0FNMStNblNEZENVMzMrOU5zaGNSSjNwTTNo?=
 =?utf-8?B?K1VRUDg3eHowQWtHYmxkVEdvZzlua3R4ekltOTFJNWRBV2tycXhqTy9Ddmgw?=
 =?utf-8?B?OTZJbTlJV0ZGTDBEZmhnOUVsRUxDUC9BNTNZYk54OWZZN21SOSs1V1RWTlJT?=
 =?utf-8?B?YXZ2N2FqbWJPWmZlZnkrVTB0dGZiUmlXeWpWNEx6djNrcVNYb3JaZ0NkMXk1?=
 =?utf-8?B?Y2xxcE1JZGJsNkdIWHZvamthWXhIcVFlNW1uMjAycTRPN2plc1pNeTE5V2l6?=
 =?utf-8?B?am52WStqa1RBTFJuUnU3S3luSFF5RVlJT0ZoQ245L2NlUGMrOHFrSE9XY1Ra?=
 =?utf-8?B?RUpETmVjTVNBSnBjN285L1h1Vmg2SGs2U1VmNEpOU0ppV2V5SVNuVXV4dE9u?=
 =?utf-8?B?dVQyQlJzRG0vcTNXYVNLQ3NMbGNiN09yY3RjVGhJSGNpTXh3R0oxb0hNRmRY?=
 =?utf-8?B?OVJWZVArZGRQTnpwcTYwT2dBM084SjhlbTRsZWhUS2lONUhIcm9VVy9JQkhr?=
 =?utf-8?B?RUt4R25YUElMYlRnNXRUOFNGRTc5bFFKVVdXM05vMUp3cWFGWmRkZDdTNE1r?=
 =?utf-8?B?UEpKNHBpNjZuRkg0M1pHU1ErRXlIc1dqczlDc0dQNHA4K2MycHF5Y1EvZFV2?=
 =?utf-8?B?cStyZE5OYnRwZ09Ldy85Wkx4MlF2NG5kRjlGT0FzcFJvTzk1cGZvUDgvaWJa?=
 =?utf-8?B?RGRUeVBZUVFHZ2N3V2VWR3FzUTJlTk9wNU1JMlUxKy9HWnkvd2tpUDV6Ym5Z?=
 =?utf-8?B?T0VJYXk5amxIazg3MHBjd3RSU1NsWkFWTG03MmdyeDZGVXZ3ZEFkTnRhRWZK?=
 =?utf-8?B?OEkvdzI2d3R6OFpnc1BTZi9abFYrdnF0Mmw1K3VVdm1qblMraGxueFZGcVJL?=
 =?utf-8?B?UytoN1FiN2dvNWRJajYyaytKVWgyN095WTU1dWVJd0VjcmVEd1Y2YUkrangz?=
 =?utf-8?B?ZDcrcWptV1pxR05ZRit6RitobXNSZkQ0QU9vL0pxd25ENU5iOHEzMStTSXda?=
 =?utf-8?B?ZFhEYy91dVlQcm9UL2lQaUx5WGdPL09KZFNTM3dYRDRydmQ2RXFES0dGQzk5?=
 =?utf-8?B?QmlqbHp2QjhQRVlyN3VxYWRpbW9tZkpSUFNlNVFvVXpSZ1NEWnR1TDVkRXNa?=
 =?utf-8?B?dkY4Q1AvaEJaYy8yT3JuWWZMMGl3ais1QmFLQTN3STdldk1rckxGQ1BWZFY4?=
 =?utf-8?B?b3FVWkQ3YldxblZ6bnBYVStpbmhsSFRwclk1dXVqVmtjaCtiUVMyUE90VERi?=
 =?utf-8?B?d3VrYTVTc2NHOVduQjJzWkFGNnEvVldNT2RLMXA5SU1tTmNGekFLWFBKRFJw?=
 =?utf-8?B?UHJyZ2kvQlV4QmRacXk1ODlubzlzRkhOckdVYi84QVJDSWhTVmgrM2NTWi9U?=
 =?utf-8?B?RGVUYkFXclRVZTRrSlpJV3JPem9hTGRRVnlDSHhmMmM0cFhaOXNTeStPbEVv?=
 =?utf-8?B?NzUycFd4WGpIVWtzbXFUalR6SmhXNExDbmdnVEZWakJBbjBHTGVGODdPbzJM?=
 =?utf-8?B?dkFjaUwzWEtXQXhGMmN5bGQ4SzNOeWpHdWs3NlNNeUE4OURyUVdma3pZcmN3?=
 =?utf-8?B?aGRMMzVPZ0JBTjdFSURRSW9PaWNMcHdpVTNLRVhNNGlJSDJScmFJNmptRDNt?=
 =?utf-8?B?bkYwb3lubVFJeitMRUhBMEJ5d0MvelV4V2l1VjBMdWNiY090NzhTeWdiZUVo?=
 =?utf-8?B?a1hLUy9BSzI3NjNDMmtZbFBQcnlPWWFmekVNbGlGemJ2eUg5MmYzdUM1a2lV?=
 =?utf-8?B?MHJCN0dtTjMxSU1vam5JWUlSSTN5bzBWaWhBRXhqajZNSzkybVFoeWs5Qmph?=
 =?utf-8?B?N3BPbUJRWEZIS2pVYjBSKzduNjFjYmpTdzFTb0Y5dUxtUGQ4MGJ0eUxXdUVu?=
 =?utf-8?Q?FkoNcIYbIeu5y8nwx3UXYNqqYFXRJgFumKB+XEjZ6YPA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74682711-2f48-40a4-0b6c-08db14b7f930
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 09:34:19.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/TNU2mjEU4AfbmM8jQqSNztlxodQehTiwmdQ/Rf/mIgcleZAXuGQcO4wcGFy9gApWlyAVCzvzFTxjjmPBSTIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.23 02:39, Michael Wu wrote:
> This patch fixes a problem that USB mouse can't wake up the device that
> enters standby.

Hi,

I am afraid I need to ask you to be a bit more precise here.
Are you referring to USB mice being unable to wake up a system,
even if you so request via sysfs, or that they won't by default?

	Regards
		Oliver
