Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250CA6FBD40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjEICbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEICa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:30:58 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF09EF2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:30:41 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4QFhwF6jrKz9scb;
        Tue,  9 May 2023 04:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683599437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lblEB/8CjWj68Z7t1pjGvP0WwFE9mZblpubO/yWwhHs=;
        b=Wutb+4BgRI1QBFPqzTAREV9kJi9gvzCUmAn9ZPnO2dZO5cr1bBlsqATDH6/Xfhcm3gs/C8
        cybHz+i8B012CjZajOW0QiUqiUtvVQ64j6hAQtXhNoNJw+XWvGglA1N9oncdirk5TiJfG9
        X/1YTeFsqVWZEtCJ1PsRWmMDJgisgHmZhN/rd5W2qr+BmKsvSO4KaO7ECPIT0ZMcPCE7yd
        jWA/D5ru1m8DjOZZJKrRKV00l3PZ2cM7Gz+K6LZlHTCdQaGA/nNkglBTYgP6Rfi0l2vK1q
        WC2H+1aZEf7WqNZMkzXsVtz2w3hQ5HM2NmmZBVCURxBvbAhNPqaZ/0SRLfGnMw==
Message-ID: <8a7be6b8d2601dcd0b570c1456ae3dbcc3782bb7.camel@mailbox.org>
Subject: Re: Library: [RFC PATCH] btree_blue - A simple btree with fast
 linear travesal and more. V4. and test data
From:   liuwf <liuwf@mailbox.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joern@purestorage.com,
        torvalds@linux-foundation.org
Date:   Mon, 08 May 2023 22:29:48 -0400
In-Reply-To: <ZFY9IFM9zjFhvyPF@pc636>
References: <48d6f5a9788af056a212d0d5ba08219fdd592fbb.camel@mailbox.org>
         <ZFY9IFM9zjFhvyPF@pc636>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2e56a738b36e6f9e5af
X-MBO-RS-META: mn7igy4t3zqbezgzwybob6q9ip4wk9c5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-06 at 13:42 +0200, Uladzislau Rezki wrote:
> Hello, Liu.
> 
> Just one question. I tried to run your test-suite that compares
> mapple_tree, btree, rb-tree and btree_blue. Also i wanted to have a
> look at its performance in other workloads. Thus, i have one question:
> 
> > 
> > +void *btree_blue_remove(struct btree_blue_head *head, unsigned long *key)
> > +{
> > +       if (head->height == 0)
> > +               return NULL;
> > +
> > +       return btree_blue_remove_level(head, key, 1);
> > +}
> > +EXPORT_SYMBOL_GPL(btree_blue_remove);
> > 
> I added a small change:
> 
> <snip>
> diff --git a/lib/btree_blue_test.c b/lib/btree_blue_test.c
> index b0a73836523d..9dfbe9e6b8d5 100644
> --- a/lib/btree_blue_test.c
> +++ b/lib/btree_blue_test.c
> @@ -530,6 +530,7 @@ static int btree_blue_test_init(void)
>  
>         t0 = ktime_get_ns();
>         for (long i = 0; i < RANDOM_NR; i++) {
> +               unsigned long *tmp_ptr;
>                 val_ptr =
>                         btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
>                 if (!val_ptr) {
> @@ -539,6 +540,14 @@ static int btree_blue_test_init(void)
>                                i);
>                         goto exit;
>                 }
> +
> +               tmp_ptr = btree_blue_remove(&btree_blue_root, &(data_set_2[i].k));
> +               if (tmp_ptr) {
> +                       err = -1;
> +                       pr_err("btree_blue_remove %ld, val_ptr: 0x%lu, tmp_ptr: 0x%lu\n",
> +                               i, (unsigned long) val_ptr, (unsigned long) tmp_ptr);
> +                       goto exit;
> +               }
>         }
>         t0 = ktime_get_ns() - t0;
>         printk(KERN_EMERG "btree_blue %lu deletes use time: %lu ns\n",
> <snip>
> 
> it removes two times same key. On a second removal i suspect
> a ptr_val to be NULL but it is not:
> 
> <snip>
> [   20.598023] btree 1000000 deletes use time: 251484314 ns
> [   20.599360] btree_blue_remove 0, val_ptr: 0x17259549162592618731, tmp_ptr: 0x18273237390749509852
> <snip>
> 
> Any thoughts?
> 
> Thanks!
> 
> --
> Uladzislau Rezki

Hi Uladzislau Rezki

	Thank you very much for testing and feedback. The issue you
found is related with a bug in btree_blue code. The bug let remove 
function to see a phantom of a removed key A in some cases, which if
is really removed by second time, will bring an error and result in 
the removing of another key B.

I saw your report half day ago and I have fixed the bug now, thanks a
lot! 

BTY, the lastest version of btree_blue is also posted this time, which
is V7.2 and would be better after V4, V5, V6, V7.


Liu Weifeng

