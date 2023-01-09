Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BED662353
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjAIKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjAIKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2418B16
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BD660FD9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1FFC433D2;
        Mon,  9 Jan 2023 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673260516;
        bh=YmOTwEg410xLry6JPtWUVue+KxFnjS0fs4qiJfMqPn0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t4U47ptgIoaLdfE+zHI0kATbQY0S6DflXlbgdgW/lTXMo1nFa4mJ1oXvx1jpZ2K1Z
         TxATEvh2KtoECvYtsn1WfOhPkYqo5FxMxlOHPpUL+s3ZDmYaGceBENP+BNtP1Jdx6X
         i5EPcLOZOF3WNHgkJnVunnwkL3TDLK1N7W4TJw9e5vOC697Mi1Js+EQUYKJqZDdt3K
         m9zodUU9vaB4Q0EaPo4QpbVXTyGA5HJMe/jNfH2k7okhju6/X75p3OiL2zNx/r1375
         rrXqR/wFqWlL2hfwOwiWZy+1qcsK2iAF5dd38dHw9/7j3zLPtKE08urje/hdxh6t1s
         faa5jrMbpguiQ==
Message-ID: <ee7bb35d-aa28-48b0-9877-c6d0881dbe64@kernel.org>
Date:   Mon, 9 Jan 2023 18:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] erofs/zmap.c: Fix incorrect offset calculation
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
References: <20221209102151.311049-1-code@siddh.me>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221209102151.311049-1-code@siddh.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/9 18:21, Siddh Raman Pant wrote:
> Effective offset to add to length was being incorrectly calculated,
> which resulted in iomap->length being set to 0, triggering a WARN_ON
> in iomap_iter_done().
> 
> Fix that, and describe it in comments.
> 
> This was reported as a crash by syzbot under an issue about a warning
> encountered in iomap_iter_done(), but unrelated to erofs.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
