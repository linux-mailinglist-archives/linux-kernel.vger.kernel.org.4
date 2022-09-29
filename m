Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27865F0199
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiI2X6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiI2X6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:58:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F0DD351
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:58:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so7448905pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=BxDGR1WvgjKrBhJw6cyiVAQVtKbUU/nQwv2StZb0cVo=;
        b=QufG7IdzNKypsywKUg1oxcHaqMXJmy7xEkdUuxH6St6W6HKzRSZJv4b7arBCg+L/8/
         4EVeCVP1XGK0EAX7fNV5ejcNtzxrZtsVTISl3ZANaD6uEdGDDOjh7vv3El6jb24ydXO3
         ruEoAbMVZYYsOyWxpaZ1GcQE5Bj1/XmHpzMVGqHRJ89zs9q2qJUDZgGaNVMgpWbsSpRG
         poQ9cTrKXrqS0Y1VAo9I81KPbTbhcfnGfO022FNu5hfFrlYIOus+OwnzERlwOPMwSiFt
         38SQRRtpv+SgHKVdK4lAPPS7uH/9cGrqtzorbx4L1iLKq5cIQL3l5QAzTrJNsDTwJud9
         1dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BxDGR1WvgjKrBhJw6cyiVAQVtKbUU/nQwv2StZb0cVo=;
        b=dtO2i9gUc03tzG58U9ddA48iq0sRf67CZLj3gpGvamjocWPktRnDX0zIfQqegzDpQA
         w+CDqmJvWRiWwU3cPMGrMbNtc62plWR2EIKkW7f4n25YOXMia4cyZmQ/Pu0GQetssijk
         NJGCIEx2o5mWYAqy49JGPR75f6YDtPR9rnJTr6R8/zBNW+kU72+/mJjTCOZpXhlN+tUt
         oCnPRJwHsr39JnH9T5Hu+N1oNCHxC4VNYvPkRrCOOqwsdZopxa/TRvor0zKeKzHwFk7n
         q+KkVFDwqcWVa/6rWgem+mQYCHzelwRVfEUKds39AlO3JjuGER6OEdIxA5YLPELWnuxQ
         TyHA==
X-Gm-Message-State: ACrzQf3Jj4ZK0QOTGlG7DN3kYtw1jau2cXaF1G8pyOzDwEgcaZHCgWAF
        EHa1VGQgiAWzoOpAbr8MFxVf1A==
X-Google-Smtp-Source: AMsMyM46NzOkXRtY9l0v4AoEqmQm8aFSFaVxv8RWvFPd7j56uIqpPIPfYlng4lihPhFxcdax937zgQ==
X-Received: by 2002:a17:90b:2785:b0:203:6279:f03a with SMTP id pw5-20020a17090b278500b002036279f03amr19139930pjb.36.1664495922428;
        Thu, 29 Sep 2022 16:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b00172f4835f53sm457627plg.192.2022.09.29.16.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:58:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Hugh Dickins <hughd@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <9c2038a7-cdc5-5ee-854c-fbc6168bf16@google.com>
References: <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com> <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
 <20220926114416.t7t65u66ze76aiz7@quack3> <4539e48-417-edae-d42-9ef84602af0@google.com>
 <20220927103123.cvjbdx6lqv7jxa2w@quack3> <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
 <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com> <9f68731-e699-5679-6a71-77634767b8dd@google.com>
 <20220929083939.ioytch563qikyflz@quack3> <9c2038a7-cdc5-5ee-854c-fbc6168bf16@google.com>
Subject: Re: [PATCH next v3] sbitmap: fix lockup while swapping
Message-Id: <166449592135.4485.5114483552637281957.b4-ty@kernel.dk>
Date:   Thu, 29 Sep 2022 17:58:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 12:50:12 -0700 (PDT), Hugh Dickins wrote:
> Commit 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> is a big improvement: without it, I had to revert to before commit
> 040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
> to avoid the high system time and freezes which that had introduced.
> 
> Now okay on the NVME laptop, but 4acb83417cad is a disaster for heavy
> swapping (kernel builds in low memory) on another: soon locking up in
> sbitmap_queue_wake_up() (into which __sbq_wake_up() is inlined), cycling
> around with waitqueue_active() but wait_cnt 0 .  Here is a backtrace,
> showing the common pattern of outer sbitmap_queue_wake_up() interrupted
> before setting wait_cnt 0 back to wake_batch (in some cases other CPUs
> are idle, in other cases they're spinning for a lock in dd_bio_merge()):
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix lockup while swapping
      commit: 30514bd2dd4e86a3ecfd6a93a3eadf7b9ea164a0

Best regards,
-- 
Jens Axboe


