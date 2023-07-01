Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A990744A04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGAOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:43:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DCDB2;
        Sat,  1 Jul 2023 07:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx0r72CiVAgK9mPXqxehjsKAt2chu8DAQXFtOF4j7vcQiHBMQ+P0ICcEMQZ+xqy4aqDY9sOJ/AMomF4rGz6WCgBMKBkpAoyNYfeJxnvaQ0JqdAoeTC/W9CAk6vX5k+4EM9GkZGWDxvksrrdvt72m9ztcFKWHV1ny0TdpVfzZ57tTJzBVc9PL8m+4oxczWBZhAtAoiBb36wnFJX4GFgPuZHBOowPnG7V9WYgVfngRepKYTJQZJnxs/Vg7KJpzJIYsJn079E90DcOqD5rvB1NpT3ZH20OGPj9FvIz8o1jV50BRYytBmVR+NGQFkPnbTKkQ7YS7R15A6eq1ReBy1UWFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yehlVdTfScfNCWsxW2OKDVEL9V4QAO3g3pNhAFVS3mk=;
 b=XVFoJdWRp6bm5xpGoZLYH1RfYTcEmOTAwSwnK0KfyeirRJWyQB8vHuvLae0OG3yLej/fUe2Uj//pz33HlZUJXJr9T5jeEvL+IDQ809+yt0wrYiJ+tdUa74I/jFAmLHfc7a5bbFpyXeq7t6awlMhca4dq5/lyHpIq9YtiGNKBnBHVgsWNZUdXrDLH8Luu/NFs9Su8HHhlH/3KaaS5DUfIMkkyMyjbzaiAMf4R0dj5fR6LxSj6+HvKOp0iE3UeoUemIpbtmfYriCjTumhLgPu+94WiVF7S0iEglG91lQa9jKSKOtVVVIXbm7O0AVZE/2p2ufXILO8SXNgGEiX4tf6jOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW4PR01MB6244.prod.exchangelabs.com (2603:10b6:303:79::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Sat, 1 Jul 2023 14:43:19 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 14:43:18 +0000
Message-ID: <88381d01-f269-cf1b-00c0-ca5204f2a65e@talpey.com>
Date:   Sat, 1 Jul 2023 10:43:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230701055556.23632-1-machel@vivo.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230701055556.23632-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW4PR01MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: c54aef39-87b1-4a2d-0ccd-08db7a418185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NI88CvbkkypZqsBp+7pARME31DPsS5DBWz76oSYdFYZT4m0KaGUcT3rT/T6pBLjhE0hOSoHyqVRvaTdBaKH+mVJN1qgnH+t3rAe7t8L55U/ruLj/PqDTgqOQ5hrLhIGpMCS1yu52tnikE+OCsaQzb3GBwr0mrr9P6bzxagHw8GVyqfrp6GLkVJawqbONFi/AuR0mU1sxHv8rO20WURJzCLERH/JV4QO4pOyk7ZntMiaszjcWKC5l3wBOScAwddCbjoqtm2VACsA4w4VTQwILk/E8wYIlDiO4geXAOyQYF7qHwJOo+FKYZucFmEjsADbBzXtdmN/5JltEQxEM6LmxRj98t/wr8+bnJZNRdgplJMru0+XdhP/0yP1N8uuOAdStKK5qCiSHzaDt7a6e4gQzDuiN9fz8J3lRmH4UvWjJBdr1bKH/AKFpfJfg6sEqKQnew1MNdOzGWlZPF0G/1qORmLuzKIYI+eZeA2GfB0Ug4YLTdxMZVugEHPa4/0Nk/qdr1yqPkK7T+Q5COO07RLE0LJrf/GtZlReIaSWJp5hjNb1oEnvKKFqxqHhbxthiSqwQVutEl0DZyj7NjeqieyVN9nvqrWPekUeNHjO/vBQVcsEw+6k2kDXq17kPS7CYOoZXK4f8uZkesxeXD8KI0QFgDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(376002)(346002)(366004)(396003)(451199021)(31686004)(86362001)(8936002)(8676002)(5660300002)(110136005)(31696002)(26005)(6506007)(53546011)(52116002)(478600001)(6486002)(66946007)(66556008)(66476007)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0IrUWhoaUJaSE1XOGVmRVk4THpSQ05DanJxMWVDQjI5MzN5ejBqd2hMU1dJ?=
 =?utf-8?B?YjhvL1hRSWJUVWVSUlE5Mkx3bjA5NzlyUXY1MUxtZmJYTERxOTduUS91Witu?=
 =?utf-8?B?SWVkVzRWRWF2T2lrYlNjS2VvYmJ2dmNTeVQ4d0ZhdzFmb1k4KzAxNDNDUzFS?=
 =?utf-8?B?QW55V2NqS2t1Z2RjbXJIcEJiTk5vTGd5clVqbzBVdFFnbnFuc3kzVjNOdjlI?=
 =?utf-8?B?ZG5oOUtiTDFyNDVEdzlnK1ZzaGpWeVJQNHNXRnMzZFZOa3MyQnp6SmRucHQ0?=
 =?utf-8?B?V0E0R2NDdDJyYnZzS3B6SjlIWkg4VkJicUZPdi84ME9FSDRUWDV1czdoT3Zw?=
 =?utf-8?B?cXdieDZyS0VwOWF1SjZlL2g4cSs4enorWlVKMUNod0cwYzBBeVF4UnFyUnJ4?=
 =?utf-8?B?UFRyR1hKUXNGc0poaE1EcktRWTBLeVpGNXpXWHRZSkhzbklwcVdSRWZ0aTJR?=
 =?utf-8?B?RXRZTzhFUUVTTGhZa2d6d2lDL2JGSDUzTUdRaXh0UmtOblpyVStyQXVPdDJx?=
 =?utf-8?B?RGYzOVZHeDNjaWpzL1orTEJSNW1ySlh5Y2Nic1hoSXpYRjM0cGlDUWFKRWt2?=
 =?utf-8?B?cXVleHNPUlhqQWthbGRZVzlGb0xMV29pcVB6akI0dUhOV2hKSThjaXNBRjg5?=
 =?utf-8?B?TFczZ0FVVGwrV2FzQXFVZnBUckNxSlU1MlhkYTZvZFlRWmk0cHhnMU0rbTRn?=
 =?utf-8?B?Zm1hYytjV3RWcDJEeWkvWWpQeTBvNDJYSVJQdXo0VGsyd3dZNnQwSlJwYm1Z?=
 =?utf-8?B?NzNxeStpdFFSYnVaejZSWUc0OVI1U05mT0E2L1pydjBWTEZ2K1VnWmFIUzJq?=
 =?utf-8?B?NGd0QldoVHAzVDJ2dTM4WWF4SWdick5TM01uNXY5UXMzK21MaWRwbGx1QXlZ?=
 =?utf-8?B?WmV5OUQyODF3bDFNSUdycWFmaE4rdVdlZTlBcVBiM2pGTkdpY1VwSkJ2c01a?=
 =?utf-8?B?WjJSYStmcUtjTlFMSDlPSDFORUlwVURCUlBwQmpNamxlbkpQa21wR1FMOFJB?=
 =?utf-8?B?RXh2V1pZZEc2Szd0cnRGdlJqaFVmeDYxWVBWeTJCK09sU21GL3B1UmN1RXhC?=
 =?utf-8?B?ZERGWXRad25xWGdNakdDemIvb09Ec1pTNmJkZUY4bnpkbFNlYVNrdVA3RXZn?=
 =?utf-8?B?NlBmNkVpMXRFQm8wUVJoR09SUTdKTUNOL08yUkU0UkpzMkF2QmNqcFpZSHg4?=
 =?utf-8?B?Zk8wc1didnR1TU9xbWI1QkttZ2RkMTdHWW9WTkpvN2lQREtuTGMxdzhUZUZl?=
 =?utf-8?B?eHo4ZzJVQnkyMXhpaFIzMENHbXlucUxTc055eVpjbTh0bkZIOFVDODRxTUp5?=
 =?utf-8?B?eXkvQWdKZFNPRXhoL0ZDYk5GU0tZbW1ycFRMRklrYTc2dGhmZ0hnUEpsdHBi?=
 =?utf-8?B?OFBIT2Vzb2hxUzJNOWJSeURPdS81ZFVqbmxpMXVxY1NpVjM0bUdYaFppcUdE?=
 =?utf-8?B?d2hRcUtvMkN0cCtCaTNXWGpDb3RSeEdMQXZYS2Q3QTdIMTJBdDd4anM4SUJp?=
 =?utf-8?B?dXRvNHNGV0N4TWVSK0FVdDNzRE5UN1lJc3lyV2twOWszZDV1czY5THM3SDNH?=
 =?utf-8?B?ZkZOdWRvUUtMeE1ncXcyVGZuaENsdFZKMHJsZFdUcGxHd0FhUlRkTzdrN3FO?=
 =?utf-8?B?bytZaTBpNzk2T2daVEFlSm9MY2lJNlhnT3FkS21zb3FUL2NpVEVhQURPQUpM?=
 =?utf-8?B?UHpHSnNrSjR6ZVllVWs1MlFRUzZmVkU3eDVDS3JsQmkxcW9RRjRkMUFPb1Vy?=
 =?utf-8?B?ZCtxcTVlSTU5WFNaYWtHSGc1Z2ZIa0dCQWJ4K295TUlJOWl2UmZCSVhwMFFv?=
 =?utf-8?B?Ungxcm5CNzcreTRWem1IVE1kY0FPVDN3QUVpWGN5OC9tWEtYdmZRZjdFM1A3?=
 =?utf-8?B?VVArc0ErbWdvQW1zS1dHZEZUZ1BZQVN0b0pDRHBzNWE5anVrdlp0VjVFbXZt?=
 =?utf-8?B?akRRSzdzSENITVB4WHRYQmk1aS9XNi9wUWVzdy82ZUdUM1dZdUorNy9CYUox?=
 =?utf-8?B?bXVoSE44cTVrNXRUTzF4dWlKaHNLZjVtTitZSytsYUZPbkpHazdUU1ZnLzB0?=
 =?utf-8?B?R0p3QjFDZUlWK3YvWkltNS9qam43TFJXblVCeEJVa3NNVGhOUHF1ODY5Nith?=
 =?utf-8?Q?i0Qk7pkAFfMx/cVHPdK7lrsav?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54aef39-87b1-4a2d-0ccd-08db7a418185
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 14:43:17.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cK+SGeo+NfETTceVAlWWJjLbGHGXeRFT7gt2JwufW4IG8bbYV4HUCp6mwZ2yPwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6244
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/2023 1:55 AM, Wang Ming wrote:
> The return value of the ksmbd_vfs_getcasexattr() is long.
> However, the return value is being assigned to an unsignef
> long variable 'v_len',so making 'v_len' to long. Also, when
> comparing to zero in the following code, no type conversion
> is required.

I agree with the fix, but this commit message is confusing.
The type is strictly speaking not "long", it's ssize_t. And
the final sentence seems unnecessary.

"The return value of the ksmbd_vfs_getcasexattr() is signed.
  However, the return value is being assigned to an unsigned
  variable and subsequently recasted, causing warnings. Use
  a signed type."

or similar.

With this clarified...
Acked-by: Tom Talpey <tom@talpey.com>


> 
> silence the warning:
> ./fs/smb/server/vfs.c:WARNING: Unsigned expression compared
> with zero: v_len > 0
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>   fs/smb/server/vfs.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index e35914457..e605ee96b 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -412,7 +412,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
>   {
>          char *stream_buf = NULL, *wbuf;
>          struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
> -       size_t size, v_len;
> +       size_t size;
> +       ssize_t v_len;
>          int err = 0;
> 
>          ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
> @@ -429,9 +430,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
>                                         fp->stream.name,
>                                         fp->stream.size,
>                                         &stream_buf);
> -       if ((int)v_len < 0) {
> +       if (v_len < 0) {
>                  pr_err("not found stream in xattr : %zd\n", v_len);
> -               err = (int)v_len;
> +               err = v_len;
>                  goto out;
>          }
> 
> --
> 2.25.1
> 
> 
> ________________________________
> 本邮件及其附件内容可能含有机密和/或隐私信息，仅供指定个人或机构使用。若您非发件人指定收件人或其代理人，请勿使用、传播、复制或存储此邮件之任何内容或其附件。如您误收本邮件，请即以回复或电话方式通知发件人，并将原始邮件、附件及其所有复本删除。谢谢。
> The contents of this message and any attachments may contain confidential and/or privileged information and are intended exclusively for the addressee(s). If you are not the intended recipient of this message or their agent, please note that any use, dissemination, copying, or storage of this message or its attachments is not allowed. If you receive this message in error, please notify the sender by reply the message or phone and delete this message, any attachments and any copies immediately.
> Thank you
> 
