Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E560C524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiJYH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiJYH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:29:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8784414EC51
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 312E4B81A99
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D7C433C1;
        Tue, 25 Oct 2022 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666682949;
        bh=Gv+wL2UYnkvCCSfsrxAR0k2V1PI7nMZ5YN27pTjKFDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NkYcHkrAiFGBHaDCZbtg2xV4WxvmHEhemBJcYL1zXrnRa5GJxUW2QhIxFYaAuIjsS
         S7sipVaLzJMCSBkGh/P0cySaBCCBWQbjCTXqmuSxUf0yHV/NPPEBYh6zdODRseQ6K/
         JTKibZXeX6mpZCceolxI0GWSQYN0atY6CegWnpCoIdxcpwyFKRzzxBZS466AFa0z1w
         XAsFJT34HBo+QNa0IBKz22tK13lq0ujS0zf6JnVhjY1NV9iJtnz/SPfXRFWJ0cxOMA
         R+XG4VY7ZcqLSQWTsu5THL1NcJ1jkyV73+0xdi54KEGlmji0DmguWHpNoOAP3w8vhR
         Hm8ddZkNAtYNA==
Message-ID: <b19175cf-7f87-03c0-a129-716f9bb5e16d@kernel.org>
Date:   Tue, 25 Oct 2022 15:29:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: remove redundant return in
 f2fs_create_flush_cmd_control()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <bfae3198-7557-f984-200c-2c677881f462@kernel.org>
 <20221025070817.37391-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025070817.37391-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 15:08, Yangtao Li wrote:
> Hi Chao,
> 
> In my point of view, it should not return 0. Because calling kthread_run()
> to create a kernel thread may fails, and err is assigned a value.

I commented on last 'return err' rather than the one in error path...

Maybe:

---
  fs/f2fs/segment.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 81aadfc06c89..25ee8c8cb2cf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -634,12 +634,12 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  {
  	dev_t dev = sbi->sb->s_bdev->bd_dev;
  	struct flush_cmd_control *fcc;
-	int err = 0;
+	int err;

  	if (SM_I(sbi)->fcc_info) {
  		fcc = SM_I(sbi)->fcc_info;
  		if (fcc->f2fs_issue_flush)
-			return err;
+			return 0;
  		goto init_thread;
  	}

@@ -652,7 +652,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  	init_llist_head(&fcc->issue_list);
  	SM_I(sbi)->fcc_info = fcc;
  	if (!test_opt(sbi, FLUSH_MERGE))
-		return err;
+		return 0;

  init_thread:
  	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
@@ -664,7 +664,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  		return err;
  	}

-	return err;
+	return 0;
  }

  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
-- 
2.25.1



> 
> Thanks,
