Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EF74A1C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGFQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:06:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1403B9D;
        Thu,  6 Jul 2023 09:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7zUShQGGlm50inc+9Y6JE0auW3XXCBRI3hTDsDq9DNtH9FjIBLvgRkqo/jOIEYbnX7va0ZSY/lXrhiSdoGAt7o8y3R7w7zBJQ9l6t/n9p41hxmgYHckAHIlNQuuPSUTwyrKwegQofo7inJgfQ9fIssjcW/mrxhKW3c8L7yJbY3tL6FVnIDN0ypjkVjbeF9+ZDgckLOW4mZ0A5mJ5OZX85VYLf+KnaZe8d043RoaRZkzv2S9wlVPevoSGyYI3VGu60ojvqjzEeG8hN2XnzY1Qd+rBkSD/DZ9AFhSjPtwScYuoiQOgvzuaRujyeCSt4GFoP772xfTIyXDQZYwK5ltNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySFKKRSos1O8H1O5MqvN62W5lnlIKzoCWC0faNZZdCI=;
 b=LtrWD+yFTqpv2K0gcfPUYa3GfXMiNgTeeRFt8pl5QVFzV8CFY7xh+9c/D8zjUXspcsvhCZegdSnUhDZ6vXdunt6fgQNNl8RL7G/56d5sYpao/+wKIwwWKB0Ei+gUzhpHcN1JHeRvYkBxW+HQr6paM7+pGcN87aOiapAYUTZSOI+w8bbxb/YC1hw3Dl0Zz3Sn0AhGs3jgEFmiSc+oCKvHGmoTYX42tWhfyNKXrSRPjxXVEkIqtorqt43UDZgQDBPXyqB+XiKe18b/v/1DiBJkby9rOqiUqmKUpM75mbxOwyaO0gdCmLws/CrMvC+fQWMHMCiQ6n8xxZvdqlmLnD95tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySFKKRSos1O8H1O5MqvN62W5lnlIKzoCWC0faNZZdCI=;
 b=hxUdAjMQLnxPgtw6I3w/asthjcH4Um1w/Ry0J6DZzYULUFAX8dtILXGTENg0/ToTzlGqz0HBsKfRZKr/SWCQQQVZqvI/RksM/n+mdI/79qRxrgW/cr7T7XuJnAjx/LfWby985sbqIMVav3RfG+HAem0I+nR8VyI958YfiZ8jbb9vmp31qzdUcGujCxYMuLA5K4dV1x6hjH6qCIoaFeyd7XrNtRD+eFnPOkRZMKsAjmk8jG5V2cL5qY4oZPjBHbojne/1sOzVP4yRNDrwMnnYV7hYeTmHzLbYUgK+909MAJc65EkR7R2980SoAk7L4bWVO3acc/vES6GhNQOUVGJEhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:06:35 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:06:35 +0000
Message-ID: <38a4e188-239c-a0a8-5204-8e8e001f062f@nvidia.com>
Date:   Thu, 6 Jul 2023 19:06:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 3/3] nvme/{041,042,043,044,045}: Use default
 hostnqn and hostid
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-4-dwagner@suse.de>
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230620132703.20648-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d309b72-4c3a-4df4-7985-08db7e3af8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLUTbDTTTXb3Q0f8s+UBb0kR1TPyOzu83Co7/r0QlG3NpvqYmhjTt6xV6FXUewiAgfnARK5dSej6ay4mWPaBspPpZVfKAYvjb4i8VNf+2cdl+grGVqIYd3SzCL3sbCqfR0fdLbc/zoVY8cwHU4gyvRBD4Y5XrnTx691unp2ZQsUqifRwsLYHSRqWdLWzokj/qFnCRJ9TpXe6hEJ52PkY9FS2oXKTPPse0EHrgepF90ch1F+7DKtA+cvcp+wQGYdviuZ/iBDl6cIt73Xvj3SLaTkTHMWeTj1gP3e1Sbk6zN+CmljAe9VKFtfhaYfgFGKKXyoC4noosXIx3fMTGgHeCzVTwuoHaYvELH6yugLnYYYitNSlzzuJJw7+wZQRPHsr+SAEcO9b983SMnbsZro89Ykf4AdoI4hqZVZVyBph7HzSypPFuHSj9oA5UOYh2GYd2bjGCrckk8x7zR8pRDKA4Dn4ZC+BZqutAFGZCrYol+KV2i54Ywq3MV3/MNrN6zA1xXNOdRW4bTwh8MBwyXNL+P3bvcuWm90YAreqFkn1LnQqxrA7WUEL9Zxh50Jg78stTXRv2pBah4NGSTlOIt8BqFGEuzcutoUQWnW97cUJTh9YKfZUXVzMlAFBBd/zOl48w+0MaLY12tUQ/TmUQJbzbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(478600001)(6666004)(54906003)(53546011)(186003)(6512007)(2906002)(66556008)(66946007)(66476007)(41300700001)(316002)(5660300002)(8676002)(8936002)(38100700002)(4326008)(36756003)(31696002)(2616005)(83380400001)(6506007)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxVMnZGbDVOMGdhaDZzeW43UEkxeWJBSzFuUWs5cGc4c3FDWFhqaE1mVlJD?=
 =?utf-8?B?QmJVV2N6WFVWcXlEY1pMbThSVE96UHpYUWpwUEhNUjRGVGdtYlBtbWtWcG1B?=
 =?utf-8?B?K3Npb3FpRlEvR1dkYlBocE1zbTRVWW13NjdtWE14Si9KZGNzRlVlaDE5Qm5Q?=
 =?utf-8?B?Ui9mTi9kc2JHcmI3V0FTLzZqNDkvVTQ3b2ZlaVlCb3dxWWtYZXZDSm5XRnJB?=
 =?utf-8?B?VStvYmIvcjNZKzVIWE5ZUGZmbFpXTEJYL3BMdlRhQ29La3FoUldqTFJpMmpS?=
 =?utf-8?B?c0FwSlBqZGY1d3RtVnNDWXdYV1lZZzZxZUtNQTljM1lnVWNPME43SXdBVjhM?=
 =?utf-8?B?bFE2K1lVeGI2b3ZhOGxJVXVTQ0N6MHBROXI2Y3ZObHRXTVVEOFpKZmd3SHlE?=
 =?utf-8?B?NFBHRG13VGRoR0ozSHNRd25qZkJvajlrVXpWdk5ONFkyVnZZOTI4Z1VSdkZT?=
 =?utf-8?B?a3FPc0hhVCs1aDhiVk54YStYd1lYdGhrUEFXQk5pQ2UwL1BUUTJqKzdqTEcr?=
 =?utf-8?B?ckxUbVpicHRtd1lkVXVSUzdJSEFZN1l1RmZkZHVwVDArdmRBZVpoYTNmZjBC?=
 =?utf-8?B?eUtsZ3lrbTA1NFJvMGhWSFhqSkxleWpHLzE2a2Q0NVc0UzNCUFpLT1ZvNldt?=
 =?utf-8?B?dGZrYlZQOTN0RnB4NzJKd0JwS1JpR3djTjdtcktVYkZxcDVGeWVBQ1diU0RU?=
 =?utf-8?B?dThqbk5uSTlOTDk2eEVkN09aSlJNYXl5eVFlMVZ0VjFlNlYxbGNvVzZ5MlI5?=
 =?utf-8?B?VzZBbHZYR0xibmFrZXJiaEJ4UnF6cXV6VUNUb3VpeEZpa1dXb0M3cWdZSjFG?=
 =?utf-8?B?NTdnWXhuWFJCV3UzbUc0Z2d1WVY0bGc5aEFnZ2pZZFZyRUNCeEVqWG82Mkt4?=
 =?utf-8?B?K2NnazZLM3Y4R3VVbktYb2FvZi9Iamd0eU9IVnpBRTg0SUorbEJQVktzY0hs?=
 =?utf-8?B?UEgyTHhYYWt0S0pzSGt3djBDSWRIMDcyZVdiSVl6N1VtN295bFpPR21GREF2?=
 =?utf-8?B?YXUyaFQvc1lnaUFlSkhBRkE0VVhiallYVG80MHlHQTZtRkR5S0JWcHI1Ny9F?=
 =?utf-8?B?SkNDWmUxRUVPSWY4T2kxanJYUG9hTUJiRnNJT21EU24rbytqMWxTbmt3VWZh?=
 =?utf-8?B?RUxsdUJrbVcyOVEzVko3enFSLzFlUUtpNDdGN0FxQXM1WTVTeGNGRTBQeDNh?=
 =?utf-8?B?L09WNEhISjU3enZiUGRROFV4L1E1cGY3SnlKM29YZVY5elJHOHdHQjRwdWF1?=
 =?utf-8?B?cXZPTVMrbmMyMGEwUHV6T28vbzM4NzJXVmVKdVAycEpqVVlhR1NZVm5MaUF6?=
 =?utf-8?B?enMxVWRwZmErSzBldmJVS1RuK1gwQXZHd1ZtbHZ5MkJrOVdoNHpwSDZaOXhj?=
 =?utf-8?B?a0dyeVY0aThQa0JSajc5QmRiL1BKTTNtY2RrYXd5ZGRJYTV4OWtxM0QvMDFP?=
 =?utf-8?B?OTJ6QlZ1bk5PSU9vdkJIOWdPcnVmMTBxaVRwV0QvSE9SVFFCaDRxNWp3bDJu?=
 =?utf-8?B?Sm0yNi81bWJvTk52QWZiTFNRSDdRakFKb1FMVy8rU3k5RjNzRU8vNFlqbGdH?=
 =?utf-8?B?RzAvRkhreXQwRjBqZVo2UjBrdmx4elpTdVU2WGRSQzhSVTJZMVV5b05DdTRY?=
 =?utf-8?B?MDFPaHA1WSt5Q1UxdTRQT3I2c3ZsbkJyejV0N0lnRGwwSi96RFhVSFNERmxz?=
 =?utf-8?B?QXFzKzV3dURmRkZDaTcyVXB1c3JocXdodmRjUXlYbHNqaG1IazlKWTljbndN?=
 =?utf-8?B?eUR5d05qdGc4a1VsczhjWU5iWmtaMndDclBKMEd6VXJadGlKMWo0SzUrbTFW?=
 =?utf-8?B?QnZ1SVp6V1hueDV6QnZaY1Z3QXZsZ3dQNmxxU0ZMcGVXZVFxR0ZqTlJSeXc4?=
 =?utf-8?B?UDhQeHdCeWEyb2FrNnE3OGVUS0hlT2dhSUp5MXlRbWpTQTVIR1QzNFY4RWlz?=
 =?utf-8?B?TCtmU2pvSzVsUFZhNXNiM2VueFdnRlVBM3dhYnFSNDBDeHB6NUtlTi9CWlg1?=
 =?utf-8?B?aDJYbXZ5M296N3dHaWJJNGlPM0NkdjV1VmFPTjZuSSt6bk5UTkUzeWw4TUNS?=
 =?utf-8?B?K3dBNFV0R1hDSmlkSUs1S0dRT3B2NWtBUlpTc0QzUFg0ak9tL0JtejQ0dG1U?=
 =?utf-8?B?bitXUnd5NHpudksxMVJDN0ZZNWN6dzBGeDNuTVdYKzAxcWpFUlZwb3phWGNM?=
 =?utf-8?Q?XzEYBzd4HMtvtvg/CfrEFJl2anvMZym8uhSPKEfPywKr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d309b72-4c3a-4df4-7985-08db7e3af8ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:06:35.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nJNGhPIq4ymw25eon/fNkLKs6zUGFMK+JhE1YjFj4s4eAWUonNQ+8robsD7HJGKRQBAcA8Fzh1ugzw+YvLOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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



On 20/06/2023 16:27, Daniel Wagner wrote:
> The host might have enabled the udev/systemd auto connect feature.
> This disturbs the blktests for the fc transport. nvme-cli is able
> to distinguish between the different invocations via the --context
> option. In order to get this working we have to use the default
> hostnqn and hostid and not randon generated IDs for every single
> run.
> 

In the bellow tests the hostnqn and hostid are randomly generated for 
each test, so how will it disturb the udev/systemd ?
I'm not sure how will this change fix something and not sure why 
--context is mentioned here.

Seems like a good explanation to this patch is to used a dedicated 
hostnqn and hostid for blktests instead of randomly generate it.

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/041 | 8 ++------
>   tests/nvme/042 | 8 ++------
>   tests/nvme/043 | 8 ++------
>   tests/nvme/044 | 8 ++------
>   tests/nvme/045 | 8 ++------
>   5 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index 308655dd6090..5b04b99b128e 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -30,12 +30,8 @@ test() {
>   
>   	echo "Running ${TEST_NAME}"
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>   	if [ -z "$hostkey" ] ; then
>   		echo "nvme gen-dhchap-key failed"
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index fed2efead013..8df5ed37aacc 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -32,12 +32,8 @@ test() {
>   
>   	echo "Running ${TEST_NAME}"
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	_setup_nvmet
>   
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index a030884aa4ed..b591e39d0706 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -33,12 +33,8 @@ test() {
>   
>   	echo "Running ${TEST_NAME}"
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	_setup_nvmet
>   
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index 9928bcc55397..fca0897af27b 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -32,12 +32,8 @@ test() {
>   
>   	echo "Running ${TEST_NAME}"
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>   	if [ -z "$hostkey" ] ; then
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 26a55335a92c..eca629a18691 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -36,12 +36,8 @@ test() {
>   
>   	echo "Running ${TEST_NAME}"
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>   	if [ -z "$hostkey" ] ; then
