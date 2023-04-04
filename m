Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94996D5638
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjDDBop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjDDBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCBC9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB3961FCC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F47AC433EF;
        Tue,  4 Apr 2023 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680572681;
        bh=exwk2t7snWJmtT+uSVR7FwHn+JnLEMsJrmvzsUtNEWQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HHYYZ+MbOXgUJTKi7BtmUnpbJtRT5xsu6uRLk/uT6g6htCwCWG2r4f3iR1RwIWofg
         sLtEUuoU1bEjbzNOtraMo/pKj0zmGdRlIDFe9YqWrw6i55ptIruH4C5xGZxp+EM27S
         9pMWiOv9Jp57PRD/klLIptmf6ACEq1UUKQr/OVq1o7n3grvRYCzzC4VcybfLwtPZG9
         cd0PIuQUn7IQdXwnTU/uJluODwjBWFglpfM0HViscDR36J0f6xZyWhOBHQjhywUMrP
         RUKP4KhHULcXZow78Em2+LtwO615BNX0B2bDd2GRgvhsUg5xyZqeu6BnyYTvPk51ih
         /0daR/x4F400A==
Message-ID: <79aec97f-e49f-63c8-13a6-85e1207250d3@kernel.org>
Date:   Tue, 4 Apr 2023 09:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: support to show noage_extent_cache mount option
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230330173127.46900-1-frank.li@vivo.com>
 <ZCsPfukvFHhiI6vN@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZCsPfukvFHhiI6vN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 1:40, Jaegeuk Kim wrote:
> On 03/31, Yangtao Li wrote:
>> This patch support noage_extent_cache mount option.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   Documentation/filesystems/f2fs.rst | 2 ++
>>   fs/f2fs/super.c                    | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index a81c896464ff..75505ab88de8 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -352,6 +352,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
>>   			 data block update frequency of the extent per inode, in
>>   			 order to provide better temperature hints for data block
>>   			 allocation.
>> +noage_extent_cache		 Disable an age extent cache based on rb-tree, see
>> +			 the above age_extent_cache mount option.
> 
> Hmm, why do we need?

Hi Yangtao,

Please check the reason why we need to add no{inline_data, extent_cache, ...} mount
option as below:

commit 75342797988a0f9ebec400a2dde8d4de581c4079
Author: Wanpeng Li <wanpeng.li@linux.intel.com>
Date:   Tue Mar 24 10:20:27 2015 +0800

     f2fs: enable inline data by default

     Enable inline_data feature by default since it brings us better
     performance and space utilization and now has already stable.
     Add another option noinline_data to disable it during mount.

Thanks,

> 
>>   ======================== ============================================================
>>   
>>   Debugfs Entries
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b5828a67f7c1..8bd9953ea7e3 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -165,6 +165,7 @@ enum {
>>   	Opt_discard_unit,
>>   	Opt_memory_mode,
>>   	Opt_age_extent_cache,
>> +	Opt_noage_extent_cache,
>>   	Opt_err,
>>   };
>>   
>> @@ -244,6 +245,7 @@ static match_table_t f2fs_tokens = {
>>   	{Opt_discard_unit, "discard_unit=%s"},
>>   	{Opt_memory_mode, "memory=%s"},
>>   	{Opt_age_extent_cache, "age_extent_cache"},
>> +	{Opt_noage_extent_cache, "noage_extent_cache"},
>>   	{Opt_err, NULL},
>>   };
>>   
>> @@ -1269,6 +1271,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   		case Opt_age_extent_cache:
>>   			set_opt(sbi, AGE_EXTENT_CACHE);
>>   			break;
>> +		case Opt_noage_extent_cache:
>> +			clear_opt(sbi, AGE_EXTENT_CACHE);
>> +			break;
>>   		default:
>>   			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>>   				 p);
>> @@ -1974,6 +1979,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>   		seq_puts(seq, ",noextent_cache");
>>   	if (test_opt(sbi, AGE_EXTENT_CACHE))
>>   		seq_puts(seq, ",age_extent_cache");
>> +	else
>> +		seq_puts(seq, ",noage_extent_cache");
>>   	if (test_opt(sbi, DATA_FLUSH))
>>   		seq_puts(seq, ",data_flush");
>>   
>> -- 
>> 2.35.1
