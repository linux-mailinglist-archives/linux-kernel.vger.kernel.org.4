Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4064272A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiLELIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiLELIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:08:16 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 03:08:09 PST
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDBB634E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
        s=20180406; h=Content-Transfer-Encoding:Content-Type:From:Subject:To:
        MIME-Version:Date:Message-ID; bh=O0asCsN6BdHsqtktdXlPEelrlKhkpuIcISMGMItnDvA=
        ; t=1670238489; x=1670670489; b=SHAbPmmR7UPgu4TGDtVS5rQnqG/tUDRq8150XlGYVtFgI
        30w9M533EMYBmbFxfNaKPNzJUqlo4c+OEL60sKmwY3jsBmWh0sG6a8RkEFqV54lQ/c7yqAc3qOo1q
        SMf5KZ/EYnkhYjGVEzabaUAWqO9APpbLY+8vFq0o/mqsqIQvCH4nAk5uddGBYsx1BO7UVoaFDf5KI
        FWwqOzyD6gdCILxUymr7Us4H/aCL4PsVzTRVqmo4BzTxoJckCCw5t1hJ52uFH1TyGFcoRNlF6WBkN
        6zZcIfTM/B6XnhaUrWX80B8RLTs3ADH97GICP2vWEjAC7dirtHoa6w1DzLCky0lLnQ==;
X-STU-Diag: 7e4d5b0da15a19f0 (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
        by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (envelope-from <matus.jokay@stuba.sk>)
        id 1p28Rw-00078i-8G; Mon, 05 Dec 2022 11:11:48 +0100
Message-ID: <52f31c6f-7adb-78a4-dec5-8da524b4efa6@stuba.sk>
Date:   Mon, 5 Dec 2022 11:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kernel-team@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, sdf@google.com, song@kernel.org, tj@kernel.org,
        yhs@fb.com, "Ploszek, Roderik" <roderik.ploszek@stuba.sk>
References: <20221120051004.3605026-4-void@manifault.com>
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfuncs for storing struct
 task_struct * as a kptr
Content-Language: en-US
From:   Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <20221120051004.3605026-4-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Your idea behind this patch is cool, but I'm afraid that the
implementation is incorrect.

As you can see, the task_struct:rcu_users member shares the same memory
area with the task_struct:rcu (the head of an RCU CB).
Consequence: *violated invariant* that the reference counter will
remain zero after reaching zero!!!
After reaching zero the task_struct:rcu head is set, so further attempts
to access the task_struct:rcu_users may lead to a non-zero value.
For more information see
https://lore.kernel.org/lkml/CAHk-=wjT6LG6sDaZtfeT80B9RaMP-y7RNRM4F5CX2v2Z=o8e=A@mail.gmail.com/
In my opinion, the decision about task_struct:rcu and
task_struct:rcu_users union is very bad, but you should probably consult
the memory separation with authors of the actual implementation.

For now, in our project, we use the following approach:

1) get a reference to a valid task within RCU read-side with
   get_task_struct()
2) in the release function:
    2.1) enter RCU read-side
    2.2) if the task state is not TASK_DEAD: use put_task_struct()
         Note: In the case of a race with an exiting task it's OK to
         call put_task_struct(), because task_struct will be freed
         *after* the current RCU GP thanks to the task_struct:rcu_users
         mechanism.
    2.3) otherwise if test_and_set(my_cb_flag): call_rcu(my_cb)
         Note1: With respect to the RCU CB API you should guarantee that
         your CB will be installed only once within a given RCU GP. For
         that purpose we use my_cb_flag.
         Note2: This code will race with the task_struct:rcu_users
         mechanism [delayed_put_task_struct()], but it's OK. Either the
         delayed_put_task_struct() or my_cb() can be the last to call
         final put_task_struct() after the current RCU GP.
    2.4) otherwise: call put_task_struct()
         Note: The my_cb() is already installed, so within the current
         RCU GP we can invoke put_task_struct() and the ref counter of
         the task_struct will not reach zero.
    2.5) release the RCU read-side
3) The RCU CB my_cb() should set the my_cb_flag to False and call
put_task_struct().

If the release function is called within RCU read-side, the task_struct
is guaranteed to remain valid until the end of the current RCU GP.

Good luck,
mY
