Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0F6C36C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCUQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:17:50 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDF4E5C6;
        Tue, 21 Mar 2023 09:17:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E90AF8C1F62;
        Tue, 21 Mar 2023 16:17:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0719C8C14C8;
        Tue, 21 Mar 2023 16:17:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1679415462; a=rsa-sha256;
        cv=none;
        b=im42/b4NYaftWDMjUnXfbXkqNbrGgHbSzWBALlJPWvfPdkDD0j2pP+69TWFd7/DhxUxoyl
        kOudhEoe6TvaOwUj4cXYveCi65wBosuFZqrwyRGGuVLb+oEdAgyZHuaPVS4CBj1on32Gi4
        KkcISqH25xVmvvTFTOrJqlg6Us591ARNg8ujBpHcFv0FGsE7RXM03vPTuRb7/jTXGl0Etg
        n9ysQDyExGuq/PVi8tB7/wAEQKmkQ/2wRIWM6hDhhTUhKLGx3G16z7AmUqun0IwLR4D+uN
        HbR97/AI5C8kSAADhhnhmBmNsLaythyMBzVBsBUmtHJJXoQfUD0kluQH5Ir8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1679415462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LgIeV/RnLzoKhs4fAEGJ0HEnUigwpT/zK67qVE0bNRY=;
        b=12pVllTqsKY/BVBtcGcfzi5YezQaSJ1xqQLeYWTaGr7YGuKZoat6Nus2aCsdHLhbU40d8L
        PE8APdkMq5LkmcfartKr2KVq9+HEsoE3AMYrsiL2DB+SmVvMbCjJIT7YAG3jWA3N9VYW5N
        QUBS9peDONGcQXV1JMRFmDExpzEOQot5dQcSU8ggD3xkRDq/1vltOxqFEORnsVi6YKlQOn
        +e1nRJUtcOE8aICOMzYlHj1ugtsuV9PEIFTN+Zy0lO0U9lftD00Qypbl0+yuhISzIeGKBv
        +AMXOgH/uHWdZSKx0XkAb8T2ea2XcQxbm8iFf2f0ymLWlTbkXkUG2g3eKCIfLQ==
ARC-Authentication-Results: i=1;
        rspamd-766d96cb5b-6ttww;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Cure: 1227dd7b7cb2b2b9_1679415462375_470824012
X-MC-Loop-Signature: 1679415462375:2153808582
X-MC-Ingress-Time: 1679415462375
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.90 (trex/6.7.2);
        Tue, 21 Mar 2023 16:17:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Pgxb86T4zz3D;
        Tue, 21 Mar 2023 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1679415461;
        bh=LgIeV/RnLzoKhs4fAEGJ0HEnUigwpT/zK67qVE0bNRY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=FIeethWS3g+RCru4lodaRibeOjXSHZ7yemXj6ustnCiDTsHEZrU30hULhGv6VcBNe
         wMnd+PaFlyTRZnnvSEXgdunCZwBCEMYWcTp2jhmNq5+WfLkLDCS95VqsQKH/BHLzig
         2MM//kFtl4WOF3UVE/B+CWHTsUrM3XWyfrkjWBLCjrmNroISu1WfRdaCLbNkRZ04rk
         4qO5SCG/zG7mzG1uq2Gl0S/WTJMb+eo5XMaVq9XIaVWuPEK9BSHCeAJAo1H5XzHFxJ
         5mt13qGaKodlwDEb4LFiNn/rEg7er1fiWqsTU7Zu52sTi2AddhHClOiIpowio5q+Xw
         uPC+MznS7szgQ==
Date:   Tue, 21 Mar 2023 08:47:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <20230321154751.hgeppd5v327juc36@offworld>
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com>
 <20230321052337.26553-2-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230321052337.26553-2-qiuxu.zhuo@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023, Qiuxu Zhuo wrote:

>When running the 'kfree_rcu_test' test case with commands [1] the call
>trace [2] was thrown. This was because the kfree_scale_thread thread(s)
>still run after unloading rcuscale and torture modules. Fix the call
>trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
>removing the rcuscale module.
>
>[1] modprobe rcuscale kfree_rcu_test=1
>    // After some time
>    rmmod rcuscale
>    rmmod torture
>
>[2] BUG: unable to handle page fault for address: ffffffffc0601a87
>    #PF: supervisor instruction fetch in kernel mode
>    #PF: error_code(0x0010) - not-present page
>    PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
>    Oops: 0010 [#1] PREEMPT SMP NOPTI
>    CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>    RIP: 0010:0xffffffffc0601a87
>    Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
>    RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
>    RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
>    RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
>    RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
>    R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
>    FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <TASK>
>     ? kvfree_call_rcu+0xf0/0x3a0
>     ? kthread+0xf3/0x120
>     ? kthread_complete_and_exit+0x20/0x20
>     ? ret_from_fork+0x1f/0x30
>     </TASK>
>    Modules linked in: rfkill sunrpc ... [last unloaded: torture]
>    CR2: ffffffffc0601a87
>    ---[ end trace 0000000000000000 ]---
>
>Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
>Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
