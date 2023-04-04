Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079B86D5DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjDDKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjDDKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4951BD9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E9463169
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674D4C433EF;
        Tue,  4 Apr 2023 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680605222;
        bh=JPysGGnjPgbO37ueoLHh8BTscsjnrGxScIvFiCFfWmE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NFExaqm1mj5IDOgU1XgXIB2mUqyeogLfTPoTKFQX8GDMXSjqSwmCPNYh7vs+Jifut
         LsRpNfb7K/mP9UFHLTYdfeblz46J20zF/WNZ75tLCZjgaHOf0l17FUkSsLZByY3GvG
         8Tz5WQK7wpYcJGW3LUunkp+5flwTYD49AhFBxcS17c2INK07AmkiOTCk45kV6PtXMd
         HMbGF+w67fFW7enkVzTnu5Mg/i15gtEZ2AcRG3NPAZPzdBn5Pyt+I4P2SEp210BKsD
         AtVt7ql2/9fOX1njdXsw/7w5NuHLg2Xk+sbwm//L6WDhRODKAkWjmgT2A64cIlCfLE
         jB9eB2oiufEOw==
Message-ID: <08259184-d3c1-cb46-9751-e32e1bc6eb87@kernel.org>
Date:   Tue, 4 Apr 2023 18:46:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCsXRin7symPxIrn@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZCsXRin7symPxIrn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/4 2:13, Jaegeuk Kim wrote:
> On 03/24, Chao Yu wrote:
>> In order to reclaim free blocks in prefree sections before latter use.
> 
> We were supposed to do checkpoint as is?

It seems commit 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
changed that logic? It caused that if has_not_enough_free_secs() returns false,
it missed to call f2fs_write_checkpoint() before exit f2fs_gc()?

@@ -1110,15 +1116,23 @@ gc_more:
  	if (gc_type == FG_GC)
  		sbi->cur_victim_sec = NULL_SEGNO;

-	if (!sync) {
-		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
-			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
-				skipped_round * 2 >= round)
-				f2fs_drop_inmem_pages_all(sbi, true);
+	if (sync)
+		goto stop;
+
+	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
+		if (skipped_round <= MAX_SKIP_GC_COUNT ||
+					skipped_round * 2 < round) {
  			segno = NULL_SEGNO;
  			goto gc_more;
  		}

+		if (first_skipped < last_skipped &&
+				(last_skipped - first_skipped) >
+						sbi->skipped_gc_rwsem) {
+			f2fs_drop_inmem_pages_all(sbi, true);
+			segno = NULL_SEGNO;
+			goto gc_more;
+		}
  		if (gc_type == FG_GC)
  			ret = f2fs_write_checkpoint(sbi, &cpc);
  	}

> 
>>
>> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h    | 1 +
>>   fs/f2fs/gc.c      | 8 ++++++++
>>   fs/f2fs/segment.c | 1 +
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 53a005b420cf..b1515375cb4c 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1269,6 +1269,7 @@ struct f2fs_gc_control {
>>   	unsigned int victim_segno;	/* target victim segment number */
>>   	int init_gc_type;		/* FG_GC or BG_GC */
>>   	bool no_bg_gc;			/* check the space and stop bg_gc */
>> +	bool reclaim_space;		/* trigger checkpoint to reclaim space */
>>   	bool should_migrate_blocks;	/* should migrate blocks */
>>   	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
>>   	unsigned int nr_free_secs;	/* # of free sections to do GC */
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 2996d38aa89c..5a451d3d512d 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -132,6 +132,7 @@ static int gc_thread_func(void *data)
>>   
>>   		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
>>   		gc_control.no_bg_gc = foreground;
>> +		gc_control.reclaim_space = foreground;
>>   		gc_control.nr_free_secs = foreground ? 1 : 0;
>>   
>>   		/* if return value is not zero, no victim was selected */
>> @@ -1880,6 +1881,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>   				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
>>   		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
>>   			goto go_gc_more;
>> +
>> +		/*
>> +		 * trigger a checkpoint in the end of foreground garbage
>> +		 * collection.
>> +		 */
>> +		if (gc_control->reclaim_space)
>> +			ret = f2fs_write_checkpoint(sbi, &cpc);
>>   		goto stop;
>>   	}
>>   
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6c11789da884..b62af2ae1685 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -421,6 +421,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>>   				.victim_segno = NULL_SEGNO,
>>   				.init_gc_type = BG_GC,
>>   				.no_bg_gc = true,
>> +				.reclaim_space = true,
>>   				.should_migrate_blocks = false,
>>   				.err_gc_skipped = false,
>>   				.nr_free_secs = 1 };
>> -- 
>> 2.25.1
