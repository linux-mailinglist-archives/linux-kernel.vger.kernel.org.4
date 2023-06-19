Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F37356CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFSM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjFSM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:27:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58638E73;
        Mon, 19 Jun 2023 05:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW0LRvGwO2+yQ/nTQoc/4IQzz+50EEkQkL3RMpRe9nzuWAppAgxa7rN1tgRtuJyDo7Zhp/UBkhdSqTYZ1WLKFDHZTEJPGsslXA9wD6/xO7klRpyJ9HJRaj+ybv0kTWD0xWeCA4l4Y4cwoyfirW2dkaTmu/Wy8F07fh33amU4VjTBFO2OGPGP5jOKDDSecK3Jj/2ENozkqn2j4Sans6Tv7YYPLeeJ8v46X7wQJ81FtjNAe+kanTp9zD2a7jca81kiEx/rrM3CFmVjCW1eY6EoNY3gXA4qhkMJsrpwhdZjvpSM1QB9zqAK49j3NAI5WGBsOkpHREDJjxH3B3WkH5dSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RZVwlv9MFI+QC9G4Fo0BGa9nOSduQ7EZjTZwrFmJWk=;
 b=l/tU8cwSsOD8iqtLK/yt378b6/yEGwFp0g48TGKNf12BEud6NGEJm36OjyQt0Bmcqfrdg2P/ndHEnjj0aoANAL2rdNxuS8PJ00k/CHunXyDFCl7aaXZBqloqg4gEPqVEXmdFbuRG1sucAoskES+lG+G7zs8GG81a0/GS+UL2brrT0re2PQeXRYcmf3P1kTh6/ihH9l+DrarVDgY+lQ6fQyly5ZhNc3D1HycNvjolyi+Gvx3bortptY7aUc4jQLesHLhilTlRBGONQLRoh5upDh1oRQz7T1rpn22PSL2l6qQP9wQvwjJGMC8NHp+r6RNHR96o15QGxYcwQClSDsaYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW6PR01MB8319.prod.exchangelabs.com (2603:10b6:303:241::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 12:26:31 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 12:26:29 +0000
Message-ID: <930c76ab-89a9-3b03-7436-50bfb5696d0c@talpey.com>
Date:   Mon, 19 Jun 2023 08:26:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] [v2] smb: avoid field overflow warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230619082019.656605-1-arnd@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230619082019.656605-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW6PR01MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2593ba8e-04f2-441b-339d-08db70c06887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWLCMSJiCJ1qbWkGwvkf2OZhUBVjTS5EPTzcRAGW1BSab4lBt08Yga/pKpdMozvdpzYgSNQloi1eEIrE45lsIUn8Ge/8B69CmyfJ+IFDkfBMZ3QiJEGDBinMruufHku1fqOdcjlj/on/wOPztISIblazEy++XYxV38F6jCKpPDR/4xdG2l2R0dUqSMLvR0jVcWADWWsAEMkA9VNahQCzM8SG5jkzaxvflc6wldutwd0E2ZDwK7M410zEgBs2E4j4PjTj2lWov3eOOldrdY2LoC9NKu9j1VKzdzppt7ppxSrx5oBVtJoFSZ619968FR+b+ztsuw0cnc3SKTTdDa4qIDMriEV2llx0oijCXogkAjY6QatsiblmAo9n/cAB0/LFjUPqF8R5Z+dGNRySJ8qlS92Ji1FMCfH/AnYgTTBRjWMqOJC1j1AZVDaTi7x3SOQ0+apUTMRBJOlkSW+viuZ5BIuyRcwA3U6azrgYjeneZl6JxbZ+jDznR7ZShPTw8ZUb+Ip/nD56vyli06MKshT6zjUCUduNGLVQQL25mGrdjD0KdedW5s8qbIFCyksJQbZuVh04sOFXnSnelgAwNQ2YbctEY/vhpCNIuU1zyBtDgcmQ8EcDq258c7PQzdOfyT6nEUjvLV+XZtT6luLiSt7MsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39830400003)(366004)(136003)(346002)(451199021)(186003)(66946007)(8936002)(8676002)(66556008)(5660300002)(66476007)(110136005)(54906003)(52116002)(6486002)(316002)(38350700002)(38100700002)(478600001)(41300700001)(36756003)(26005)(53546011)(6506007)(6512007)(4326008)(7416002)(2906002)(31696002)(86362001)(83380400001)(31686004)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNLVGRZSDE1V3dNR3I0QjhzVGhrZmJmaHpqdEFFd0RVWDMrb3JuOExvdkxn?=
 =?utf-8?B?bHJsSk8zNmM4VjE5ZDRLeVlackkwVnpKRFN5ejV2UnFvWm1wTU4yRXp2ZHR0?=
 =?utf-8?B?VnltVkUyZXVSSDJrNE4wbEFPYm1UQXNIWkh0VFlocUdhY3lrUXdDdXFyM2hW?=
 =?utf-8?B?UytxVGp5QmFyYXNwRlRDRnE0MlRXMmd3M1BpOE1rbU9XZmtlT2FXZkF1ZzFO?=
 =?utf-8?B?ZGpoSStoM0NkQU1LbkxDa1dmOHNvSVVTY3dDSXpFbVhyQUkyUFRwUC93Tk1s?=
 =?utf-8?B?dkJjeElLRG10SUd5ejRVT3lPUlM4UDZTYUdSaU9ld3ZZKzBjSTBBT2doVzA0?=
 =?utf-8?B?RSt5L0EwVFVBREw1akRQaDhaWnV0UGZyVm4rU0xha3hrK010dlMzSnFkVjJp?=
 =?utf-8?B?Qlc4bVY0UktWNGhjMjMyWG5SWFgvSVpHRVowL0dESmsxUS9heWRRVHNLb2Rj?=
 =?utf-8?B?eHFTc0hlUmZ3cUxDcHZtKzVBS0RpNHNOenlZMW5Qdk1uZDAvUE1yUWswbk93?=
 =?utf-8?B?Z2huS3dBUGZhVGw5QWtkVE5yQXFPYzJ6WGNwNlNvR1B1TWtBbkxpTC8zcU91?=
 =?utf-8?B?WDZNYm00ckpOUmVHSndIeWZId3BCUDJReWs4YXl0VGpMSmp6c1ZrQ1E5K2Z2?=
 =?utf-8?B?eDFIYWU1VzhRZGFNMldGaGlaMUsrV2RNUGJ2bHAxRmhKU0p4andjRHFqTXRs?=
 =?utf-8?B?eXdkUkVZd2ZNSmlpVnFzaUZxTHBpSUdWQWo2MDRvcDU3SFIwRlk2cmRvQTEw?=
 =?utf-8?B?d0RaY1dmV2Rvb20wZjZhbHhKckxFUm03SlNndWxudDFLRXJ2dG9EeDRHNmt5?=
 =?utf-8?B?OTFxT1dobDg2MWcrbEdBZ2JQUVdSWTdJQld1aVNDWGgrZWcyTjVXVEk0WVRM?=
 =?utf-8?B?bFp5VFFNVmhlWEVtYlBYTC9wNVVhV2VlRjRGdklpOVA4SXh2ZWp5R0JIaDFG?=
 =?utf-8?B?YlFudnc1Z0NWV0ZlNTUyUHgxNkZlc05OSHFPRkVRREdWcW8wT3QvVGNMVUxC?=
 =?utf-8?B?YWViV2pBeFlkdkdrbFRXOHU1SzMwRUxUK1dZdFcrR1d2QUNjTkc4UGczQk5q?=
 =?utf-8?B?N1JxVjIya3ltRlZ6UE1oZEJQeWdzQURhREF2TWNkWFpkcEpldnBKNzQ4NFBR?=
 =?utf-8?B?alprOStEZ3M0bG9qV2VMU0Voa2F2QndCQlczc3JBOWNRYy9lNGNjUU9YdnV2?=
 =?utf-8?B?ZjM0NGhHcmtubEJYc0pZSEQzZk90OUdOZUcva3l0WW9PeGxDVS9vb1VhbEhP?=
 =?utf-8?B?WnpGNWo3elpGMURCTDJRekZzQUMvSU4rMkkwR1NJNk1Db3NZTkJFWkltVlRY?=
 =?utf-8?B?YktuQ2IwRXpFNnZEaE5RMXc1Rm9EOUNqTlZ5L0F5RnFBVGtiTXVyVmtFNUZ2?=
 =?utf-8?B?L1JkRlY1c2dFekdjUlNJWHlSUkFKV21jc3h0SndrOXcwOXBWNlBmWXJnK0VB?=
 =?utf-8?B?VFRWMFF6S3VkVWhTM2xKRloxQ1VTcGQ3bmJYSFpmMEQvQTA2U2ZEN2VJd1NP?=
 =?utf-8?B?aThwZzkvZFVBdmVKSE9TRWpSQ1lvZlpxQi9iTC9QZjFNOGgrRFQxSVNnbmg3?=
 =?utf-8?B?aU92WUk5a3Z0VDZEOEQzT2tubjBGQXJhSmdYMHVEM1REbU5NczhWa0NDa3VD?=
 =?utf-8?B?QnBrUHJPSzUrZFllNnZGN1lLNEFPeWtHSnFTdjB1RHBHb2MzYitEY0RmRVJ5?=
 =?utf-8?B?bGtRQkZybmdKakFGWTFWVWxIempIS0N5MlczelUxMTBibVNNYjhrQjBOdThv?=
 =?utf-8?B?NEtVejNwemFwOWxYRWI1UDVzSC9hVGRydi9IQStBKzBJKzZ6WUFCdElnM2RF?=
 =?utf-8?B?NkVyUklXU05KT3g2NzhyTHFUSEsvS3hKTzRnVzZBZlZ3eTZtZjRtTzJ4TGpP?=
 =?utf-8?B?cW9XWVpCbnpoM3RYVjJmQy9SY1E5SmtLd3J4WFpGRTg0R1krL01yY0pVQ25C?=
 =?utf-8?B?NjcrcWwrM29DOWI3SDI4NVdnQkVBSEpLT29pK1hrY3BMSlYrUDJDQ1NnUHY0?=
 =?utf-8?B?b3MvYmp5ZURjbXp1bTJ2VDRtQkZPNFZDYmZQOGttRG5YTGhzTGpsK0JaVUk4?=
 =?utf-8?B?UjQvQmI3UTQ5ODFNaVV6bzFhbDhEOXBZdTRwUnJTM0tJQTVHRFpnMS9UYkJE?=
 =?utf-8?Q?18HUvzi+igPxnn/9ni5G262Z8?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2593ba8e-04f2-441b-339d-08db70c06887
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:26:29.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBs6ald7a4S6Oa7RSCdXeElilmJG/khBgBgeTuUHyVvzVnX3LMZmGZ5GSmMDPWLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8319
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2023 4:19 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about a possible field overflow in a memcpy:
> 
> In file included from fs/smb/server/smb_common.c:7:
> include/linux/fortify-string.h:583:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>                          __write_overflow_field(p_size_field, size);
> 
> It appears to interpret the "&out[baselen + 4]" as referring to a single
> byte of the character array, while the equivalen "out + baselen + 4" is
> seen as an offset into the array.
> 
> I don't see that kind of warning elsewhere, so just go with the simple
> rework.
> 
> Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: fix typo in array length, and make sure it still addresses the warning
> ---
>   fs/smb/server/smb_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index a7e81067bc991..39c6c8d7d0623 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -536,7 +536,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
>   	out[baselen + 3] = PERIOD;
>   
>   	if (dot_present)
> -		memcpy(&out[baselen + 4], extension, 4);
> +		memcpy(out + baselen + 4, extension, 4);
>   	else
>   		out[baselen + 4] = '\0';
>   	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,

It'd be really confusing to have the other two out[baselen + foo] = bar
in the lines above and below.

Can this be fixed more clearly with a new pointer, like
	char *q = &out[baselen + 4];
	memcpy(q, extension, 4);
??

Tom.
