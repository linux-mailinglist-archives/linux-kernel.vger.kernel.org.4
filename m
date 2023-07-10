Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D474DF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGJUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:40:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265B127
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:40:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6687446eaccso4318967b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689021644; x=1691613644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yI/5JzDunfxYzTEyK6SV0vTMPUwE4Tukc49pveSo/g=;
        b=W3jRSblvR5/Es3K43OV+c3nJakIgwR8KvNLXHzcW7LNonTpf//oTsHtc917FOH2Ilm
         6mMQMq5J1h0SXAp2IfKfy6G2c6+dee7L8u7A4YPUP3MKB7GYkOCsKxDfPKoE3s0GvoS0
         0d/wUP6MYFHx8v2/RbmTnVg+LKJNzJM7PeNpiY1LcyL7LOFtVHT9y28Lp62j/0x8def6
         o5LovdF0I9gpxU62RdlXGiaZlue1OsQWCA98fAr/M3rC0qTvCGE+KAvOuIPDO5Zt87aT
         D32gfDO9FevhawHCQ6VUZxflWct9ti9BhrhTDS22XuVLKAsBgBYWG43/9u/T2COjEzmz
         oJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021644; x=1691613644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yI/5JzDunfxYzTEyK6SV0vTMPUwE4Tukc49pveSo/g=;
        b=kyON7UBm0+zyYFpU7ADfnNos5/AbF5aa+HY2IwOZkE5sOGSSECkWXxc/X7WrZIReL5
         2DsFK96rh6PNZbtk9PyarPoa96BKjUt8B8Z691owdq/oc6g5drQW6jntkoTtESOYa3dt
         lbIk5g8kb10CNAzwBe+PVjv2LSuCsnmBduRA+n5k9WrrOky7BefHAKdjI8YHGgq63q0d
         9XRkBAv9jNf8QftOJFk9IZNYrDrJK8pV35MAGgkAcagkV2vwCPl7zwUFiAkptDNS92bf
         sYJpA7Iw3THMP468rJtTzHiLdod/ZKYJrWDOHuuEN7OBty3+cq6NcMluAv6cO8nnZpfV
         BZpA==
X-Gm-Message-State: ABy/qLbVU/E8jWj0XIQH2HjD9du7d89avznrs9GIF6C3kV5RlrJ3z9uh
        ycYuSUNh0kA12db+My2WzpA=
X-Google-Smtp-Source: APBJJlHXIRJGksqXH3W73+/BWvjbHF6UQDAqXWrzFG3wH/VgGdOzQdEyelm/bHcwkwREmCkgFOSH9g==
X-Received: by 2002:a05:6a00:2d20:b0:67a:a906:9edb with SMTP id fa32-20020a056a002d2000b0067aa9069edbmr18019684pfb.30.1689021644476;
        Mon, 10 Jul 2023 13:40:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7828e000000b0063d24fcc2b7sm228483pfm.1.2023.07.10.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:40:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:40:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.5] workqueue: Warn attempt to flush system-wide
 workqueues.
Message-ID: <ZKxsyh0QlqQfQRD0@slm.duckdns.org>
References: <42f1067f-3232-0a64-4c19-6165dabf46d0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f1067f-3232-0a64-4c19-6165dabf46d0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:28:53PM +0900, Tetsuo Handa wrote:
> Based on commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using
> a macro"), all in-tree users stopped flushing system-wide workqueues.
> Therefore, start emitting runtime message so that all out-of-tree users
> will understand that they need to update their code.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to wq/for-6.6.

> After this patch, flush_workqueue(wq) where wq cannot be determined at build
> time will not get runtime warning. Should we now start checking wq at run time
> so that we get runtime warning when wq is system-wide?

Yeah, we can add an internal flag for these standard workqueues and trigger
warning when somebody tries to flush them.

Thanks.

-- 
tejun
