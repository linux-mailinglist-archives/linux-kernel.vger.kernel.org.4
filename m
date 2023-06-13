Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6A72D856
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjFMEOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:14:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A81B3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Doax24JwnLJyvh4cltZNIiZr6a145H6qCIM8/13UNIbDlKhweICMVspKL5IQJCB2uO1P3icqelFpMH7ibsHn/sjXXO4bCShp8heyfroqGzPeaoJoInIRlkhDSBHsUGavpvzlfcEi2d002doSa6S9eBmZhtmJ5n/jkzJdhgUs9oAF5d4MyhDlM4pBzn3WlYguqtokjIRCE2p9shVrtLvY054BNI9+iwXf1zwMHyzDHd+5bftvQWJdROiUofM0ErXMpIY+0LKtLWWFl4y0DDOhd/70dFx9NhyD7ao8H0rDLhYdHJ+FAZeAZqb8VfF1eCaew5ZPgR5BtfnAqnjIdvIwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RdESJ6VupJCCNC7WtfoUgADXEL+mT0Ue8aSFRuO4YE=;
 b=b3Rr4tnGMNW0dLoCjPu0rAUg8D7EIp8iRVRlnUychlYmgpp2gkpNmV0WlxK2xtSwaK+wg3eL8he9MNP/TLshJA3S0skc517hJ3klkvlAJNfD1f5d/PDqKSiVCEjmmMrWVRpPpIbOVHiEjs9FTRPvywajUvV+OaPQU6tXHPC5SlepZn/NXdJU6LH3wo/x7UVxgz5Q2dqV9XIW4IZ00gmLrpIbz2vQgRxp183yltKQXTWm2LTVo//MF9oCFplUcXU/NWozGjRVnhaJDd0LxdXHz9jDeltZUj+BINh6XZqDKajkQsGT/iXlLMaL7xKAVURIEGruZREtsocDGo0C0IT2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RdESJ6VupJCCNC7WtfoUgADXEL+mT0Ue8aSFRuO4YE=;
 b=bKyBqyfwdJ0ZsePS3NNzzvfJuTXyAAptoNn07Ll8imqA2phRa0yvejoWOCmpwQzF6FoqCIVr/WqrK6GXDuNUDXIyKEyNWZYAbAh4hlNgZJQctyrYTJT3BMPhnsyJyVgXiBjNnuHeIsNOrvNJ3AsV/yykmpesRWW/iN22MAxLDlQzRfj51GQo1L95OSVvRKNbTDBlyUFM8VpxZqvhfGt+Q01R6/UJx+MZlALq7T69bSBnSSPen2sbKy/fwbInGqGONaaUcbuMf5+cac+EOQnaGYC/4qE2oqKDvAdsosGAdlyrr+Et6ZaCMUP6dvUM87CVfr04caAOWJ8iDVSdylOwSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5038.apcprd06.prod.outlook.com (2603:1096:101:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 04:14:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 04:14:26 +0000
Message-ID: <dde6972a-e98c-8a6e-493b-9aff5668101d@vivo.com>
Date:   Tue, 13 Jun 2023 12:14:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] f2fs: compress: don't force buffered io when in
 COMPR_MODE_USER mode
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230609131555.56651-1-frank.li@vivo.com>
 <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: eaafd070-f958-4f79-99e2-08db6bc4ad15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+d6DSkEYaHrRB76rhP7iFonc/B4mbalxyGOQIHoTfvRxNFJehy5UIt/EVjttzffQPQMB68FxR4zDtK3+CLOrplWBRJtNdKOmzOqHZNAHb/hkmuKOHjlNn3NZVFgnwwNQlBCCEWPQoU7x58e3+3p9V+moeXqjya+e/Y2URV50+KKzdwNABV2LheGFkeDqvKOzEdE8r0edM+jCqXFWyupawfYvrc+Bh8nXdHTuyBLoCgxI6eTN0SeB+Ju6nCx1tALA+GE+K9fqi9t5mM0GaJdKNC4nX0/3UkjNs/vbaKUHvpMdHfO3ImDYlapFTcqgtHQIrmGksz+Q/A7Va+lbtHomkJUNBecM1/Jxc0+U4fCxAxMrqxJLrTPCL3BgauD4dk1qiRCoB2xw1q4L2dF6mLG0PNFgSbr+HohVkaVP6Z/1JbyEG6hJHrH3cGCtkXUDp7hE4JqoQHBR5TYKPcraP6pAl940shZ9ZatsvISHgQXiZ2qxJtjCbiwZCWXSm+po68omRH5WtqYt/cA77DDvDpYVQG2Qt5IXFdPtFhwSF7wV3RAjepgszEE4sWQbgqV9nfWeQ6lhuZeQ8/1uOqO6geh5QAmQ8mdlB5q0GipanAy1PcxyPpNwIOChzZgTypfQdzktXetey1ApP5QSDsjsEks1243FCFFE+IRp0+5P/K8ECXgviPEWqiFRqFNShupq98C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(53546011)(26005)(6506007)(6512007)(31696002)(86362001)(186003)(40140700001)(36756003)(83380400001)(2616005)(38350700002)(38100700002)(5660300002)(478600001)(316002)(110136005)(2906002)(41300700001)(31686004)(4326008)(8676002)(66556008)(66946007)(66476007)(8936002)(6666004)(52116002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3k0VUtCSVF5SnpSSEYrYVQ4WVVpSWIxKzI2ejVIUlB6QzJLSTRQTEdYdXlC?=
 =?utf-8?B?Ri82YmpjSzFDZ0NTcmo3eVRqVktSWHhJVUVocVZWcUJQWXdlRUl2MWhDMmZp?=
 =?utf-8?B?cmZWL0ZnZHhKM2x5MVRHZ1Y0VEVZSDNiSHpxNDU3NWFtc3ByZm01WDJoMnpz?=
 =?utf-8?B?TzhCQWk3SjRTUmpHK1pnbE9ici84alRjYUwreWllK0dBWEpyUXZkSUpOcUVB?=
 =?utf-8?B?dW5QV1lmc0JYdFNqY2VMU1BEWnBTNmo4ZXpmVUcreUJkNU5EUG91cC96NFlw?=
 =?utf-8?B?SllhM0F1STJjUUJXTExMbVpQaENjUFJPVThZQnMySlZEbXRVUWUyeDFwNnRU?=
 =?utf-8?B?b2FaYmZlN2hadlJndGpJTjkvNWQzR2h4cWZLUlF2OHRZdGhvbllXbUI4cHdh?=
 =?utf-8?B?SjlFY2U0NWJDVDVLMHYvVExsR2FOYnBDNlpjQXYrbldjQTBEU1Z3VWdaU0x3?=
 =?utf-8?B?L2dobzFQQWpkTlMyb1FhRWxrbGtnV1RhelhJVFBVNWNkaGRlUnlsNlQzMDla?=
 =?utf-8?B?SXhxSmNWNHNnT2E1Vk5RU3RIOG9rQk1JQUtIWkI3OE1iNmRaWEpReUtkWGUx?=
 =?utf-8?B?ZjNCakZVTzF4Yk43bFIzRUdsVWxCY3pvMEhwYTdEWlUrTXdLbm5reXQ2blNo?=
 =?utf-8?B?NmRYUEpTTjBuTjdVeTBtcE1kSGNnMlRTRUU1b1pDbUd4L0xWc1RxMjI2akpJ?=
 =?utf-8?B?R0lKWTFnQ0lOTXd1Zk43UWwza3U5dEhLUEhzSVUvamRUbTgva1BmYkE2cjZF?=
 =?utf-8?B?VHUzeFhtYlB2YjBJaVBxT0VPeDRORnpjTEIzeU4va1IxbTYxcFp2cEFuL2k2?=
 =?utf-8?B?elhiMUtEMERoeENqZzNlZ1FjOVRmSnBEbTJ3ZVE4Rk8wK24rOTF1ZVZTY21z?=
 =?utf-8?B?TS9Vd1NrMmY4MEw0UEtmM25aSkhRaTFvMEozS0hyWGdveWRjcFh6RWFIRk5X?=
 =?utf-8?B?dzh1TlY2cHFlY2NkNkN4OWp3bnBXMWZzZXQrU3c1YktwczRJUnBvSkwyWEdj?=
 =?utf-8?B?WjlsZjBpemVPZHAyRnVUNjJ0VCtDc0V3VGhwc2psbTlDTERlclpiUnkzL2Z3?=
 =?utf-8?B?ZFJ1c2NWZFV4clhYSTRzZmRZb2JVMDNFVlc1b3E3ak5XNFB4N256RXdZZGZ2?=
 =?utf-8?B?eXNpREppQzBqWEFQZUUxZk5uSGZMT0ZhZVZBQXV4bC9sYWp3TzdRcnd3bnBJ?=
 =?utf-8?B?VXdzcEJLZUg4UUZJUlljazVHWGl0LzV5UFBkTTlNeldPWGdpbWF6Sklab0RQ?=
 =?utf-8?B?aDVKdGE4b28xTGtJUUdQak5kM2paZlRpdm1mWmZGWFdvWnZNSHEvUWFYdkVI?=
 =?utf-8?B?R1M4bk1YaUR2cHRrY2YzZ2hSMGx0cHdwaCs1aFlMRisrR3hxWGdReHRBWTFm?=
 =?utf-8?B?eDQwdjVnSG1FMk5nemFnbkQzRFpNeE9MVUlMczY4eEtUOHo0ZWZuM2dkT09q?=
 =?utf-8?B?a1hGYkVTWkRlSnkyRkZJakY2VlI2U1loUWFLTTVQclV4Mk4weXloN083RlJ4?=
 =?utf-8?B?UnRDSUhTVTB1R1M2cTc3MXVMTUJ5WFRWZ1lVSnFZV1hOd1VQbnR4WjNvWW1z?=
 =?utf-8?B?Y2o1NVcvcFB1ZmtRUkMxS0ZVM3NOdHprM0VPSmNaS01vS3hYaGJnOCtrMVlR?=
 =?utf-8?B?MzZhOGdPSjR3Umh0Vm0yaG1Ma0huQWRZc3hTNDR4MmFpVU5YeGRVVWluNU1a?=
 =?utf-8?B?T3N3RGYwbzdyTmVZazE3dmExdll0emNONVpjR0YyQnJPOXkvdldQeDZwQnND?=
 =?utf-8?B?dnhraGN6WTA3Y2J6cXhtUG5hTXBwY1ByeDViKy9RMUthaXBzaTRzU1JINkd2?=
 =?utf-8?B?enpwS2xRMjA2d1Vqa2FMN1oybURxcnVkdG9YdC81SzZEdVhNemtlTWlJRmV2?=
 =?utf-8?B?eGtIb090Zm1mUkRxcTFxTU9Eb3NvM09qR1duazkwZXpiMndVRTdzN3Y4OTVt?=
 =?utf-8?B?OE5ralJyblJPQklKb1RPRTNaS3dlYTYvcGtHRDBydnVHemUwYWxqdXRuR1V3?=
 =?utf-8?B?MnZXNStIblJtMFNDWGdjOFNFSzFEWTZxTzVFQlZ2cUlHZ0tYZ25vWHRocWJj?=
 =?utf-8?B?MU1CVlF5RGNobXRuNHpjdUw0RkVQM3l6NGdPcUNTbFNoNFU3ZFBHczFhK2lN?=
 =?utf-8?Q?lblGTMAW/pigtdSlV5z9L3+3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaafd070-f958-4f79-99e2-08db6bc4ad15
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 04:14:26.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uETMpZMVtY4SqLlpQWqgzmLO1f+FLsvRDSsh8e3U1n3NeKLLJcnN8PPcnz1uu3WJomh2pF9+uCSlAcaouJxhxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5038
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/12 22:38, Chao Yu wrote:
> On 2023/6/9 21:15, Yangtao Li wrote:
>> It is observed that when in user compression mode 
>> (compress_extension=*),
>> even though the file is not compressed, the file is still forced to use
>> buffer io, which makes the AndroBench sequential read and write drop
>> significantly. In fact, when the file is not compressed, we don't need
>> to force it to buffer io.
>>
>>                   | w/o patch | w/ patch |
>> seq read  (MB/s) | 1320.068  | 3696.154 |
>> seq write (MB/s) | 617.996   | 2978.478 |
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Qi Han <hanqi@vivo.com>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/f2fs/f2fs.h | 14 ++++++++++++++
>>   fs/f2fs/file.c |  2 +-
>>   2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 1efcfd9e5a99..7f5472525310 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct 
>> inode *inode)
>>           is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>>   }
>>   +static inline bool f2fs_is_compressed_file(struct inode *inode)
>> +{
>> +    int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>> +
>> +    if (compress_mode == COMPR_MODE_FS)
>> +        return f2fs_compressed_file(inode);
>> +    else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||
>
> Should check dirty page as well? i_compr_blocks may increase after
> data writeback.
>
IIUC, in COMPR_MODE_USER mode, i_compr_blocks will only be updated when 
FI_ENABLE_COMPRESS is enabled.

If FI_ENABLE_COMPRESS is not enabled, i_compr_blocks will never be 
updated after data writeback.

So there is no need to additionally judge whether there is a dirty page?


Thanks,

> Thanks,
>
>> +        is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
>> +        is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>>   static inline bool f2fs_need_compress_data(struct inode *inode)
>>   {
>>       int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 74ecc9e20619..0698129b2165 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode 
>> *inode, int rw)
>>           return true;
>>       if (fsverity_active(inode))
>>           return true;
>> -    if (f2fs_compressed_file(inode))
>> +    if (f2fs_is_compressed_file(inode))
>>           return true;
>>         /* disallow direct IO if any of devices has unaligned blksize */
