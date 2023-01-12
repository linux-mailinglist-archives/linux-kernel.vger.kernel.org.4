Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50252667DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbjALSPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbjALSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:14:04 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E86438
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u8so9679976ilq.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzqVGx+RTtSS9GRNBgNTR4BsLR3daQR6tFe62fjHtgc=;
        b=fV+5chRigo5Wu3gApESBg0WazdgspK7whWO/QDK4LRFQ59MkvDTe/NfHxiGHHjkuOj
         JxVvvOnIGhDQDeTrIx39lyeigKHRoLjd2xJ6L4yZWAn+Ee9qVBHRdBVdoUApmsryf5Xk
         GcOIJe5sD32IJ7RX3sVlWfei+j8Y0PnM7AoWGi9NUWA1a218GF9rrL9DtgOEqCwUDPcr
         3guR2I1BiGesH5fXQ4pOz0HEzjQiW80X1ibK9ZY2idy1E2uYiFVRI+4ZCtYwLFX07L3z
         x2IadbtK0+ZBUzWj+g8FlINDK5sOduTODM+WPm6WcP+FGb8WdY8RRIak+/HNEpfiwsi4
         9msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzqVGx+RTtSS9GRNBgNTR4BsLR3daQR6tFe62fjHtgc=;
        b=uL5eg1837nFSoXLqPBb8LAjLZuBpRrwTY+VcQzP2p9ZxT/4srskFMAiTx4ioC+VMUG
         tBDHZTg/jWIJMiRl92y9ChAmFL3CgUSdbv19CvEFZy1OkovBaPreXmxChhleNtggCOhA
         IozbBhalHo94PUBlqVv32PpH8JZcHJXaImlxf2lLGmFUJyeVlu1jjT+P4gQmGzzATSEP
         7qv/mljKHnl/3wurPtLx28GTUgEV2i7nXgvwnUec/AaqhR+bREtv5fBgXumDgODzSbjL
         eK7ihd6E4j/QZnEmyyFGmfkGr8zwABIbbiYp252qAyf2x0R1nBdqN0LAj/a475jtsdoC
         dWSw==
X-Gm-Message-State: AFqh2ko42Fg8jAWlZ3DAvzreqo0eycS7Fs1lcQQm/khlpHUofUNI8wF6
        FT2SgdaSSzIPduKKn/h/H/zlrw==
X-Google-Smtp-Source: AMrXdXtyeEtntZ/kY6MQX3mlMceExdQ7NKGz34dYswJWOBvc9ZlDGSABXHnMYCdYchYcbY0sJ3DStw==
X-Received: by 2002:a92:cda4:0:b0:30d:95cd:c5f2 with SMTP id g4-20020a92cda4000000b0030d95cdc5f2mr4116009ild.0.1673545434927;
        Thu, 12 Jan 2023 09:43:54 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o20-20020a02a1d4000000b0038a87954f81sm5434977jah.31.2023.01.12.09.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:43:54 -0800 (PST)
Message-ID: <a6225d05-3e75-5a0c-1998-c34e7db6950c@kernel.dk>
Date:   Thu, 12 Jan 2023 10:43:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in __io_req_task_work_add
Content-Language: en-US
To:     syzbot <syzbot+01db4d8aed628ede44b1@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000044bca05f20e8e16@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000044bca05f20e8e16@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 3:26 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=111a5a86480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=01db4d8aed628ede44b1
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

#syz test: git://git.kernel.dk/linux.git for-next

-- 
Jens Axboe


