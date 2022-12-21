Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68558653249
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLUOOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiLUOOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:14:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B6F2BC0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 06:14:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w20so9042703ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 06:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37lNoQq1RpE7D88vghh65+GrfN54fVBslwF0L9xaF0c=;
        b=xZ6bVGYT/Cy/hyUlm2lLnDs6b1x9D3i9M4l/SxjCFtp1vmITg9gJ4SxQbhMeM4CcU0
         Kkk9M7NWHDx+cU0ohA+Vfsx0SdM+04+/MO+aW1xrli0V1kA8VucH0N0ILbSWI+ofyDwL
         g6usPvs9WdIaWazoD5uE+AE2wn9qXZ/QaDEht3qJDGwiphspdXqswdEG6alCupUldf62
         QABx/qOWAeAbenKDgDfgn5PCi3rSVqaKxnDWO4zNvlI2xUUMXk3O0lpNWgOk3B4kYg9P
         5fXAKJ/45GNVf0KdMuYIWVWwuCaZoCp93f4kojv66l+rZXGdqN+z4MoaILkPug+NS2lX
         Ww/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37lNoQq1RpE7D88vghh65+GrfN54fVBslwF0L9xaF0c=;
        b=SglhelAuLDP11dzTht/gqin/V0Tp/AZ6Hnf8va36ffQOTusamkYMcmqvmjsmTJvcQ7
         mEHJWo70bFY3MKoYdRuIQLpEbLnXplsaUR2U+nGf+J06wk1KYeAAQFZJvooJiCKuIp5Q
         95gS+eWnaX3qtaZ2noMRYszZI4Hc/0ntXD9LJWQSzyZfrAXuJaqAu1fO38xITx7XENWA
         dE+HM2mQWvLlr0r9FeH5URvXjMO40n/Tj5BSJSVpi+wF0PfYj2yuMvFuKiNtsYL3eTZi
         4i/TMfc6NGlGAXkLnnYZg1vyHlG2hDC+YHMwv2o3ouUvKdG2FBTbecVzQim51jqc9hfG
         Iqrg==
X-Gm-Message-State: AFqh2kqOmkRTSygGJGDwCf9XXwrRGwodxKRYtSe2qjp3VPlioY606g7j
        QJyOqj9Tue6mtYwjIlRIgbIxdQ==
X-Google-Smtp-Source: AMrXdXu35UlMwrogJQXaPIzwp+iYHSfmxfpCb0jfsXBqoAAphZ7pKu2csUeD7UWVnWcF0N6uqfRU1A==
X-Received: by 2002:a17:903:285:b0:189:cb1a:7eee with SMTP id j5-20020a170903028500b00189cb1a7eeemr492176plr.1.1671632087392;
        Wed, 21 Dec 2022 06:14:47 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b001897a8b537asm11599308plf.221.2022.12.21.06.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 06:14:46 -0800 (PST)
Message-ID: <11a32a29-fbe6-3e00-9f76-36bcd305ea94@kernel.dk>
Date:   Wed, 21 Dec 2022 07:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [syzbot] WARNING in io_cqring_overflow_flush
To:     syzbot <syzbot+cf6ea1d6bb30a4ce10b2@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000cb143a05f04eee15@google.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000cb143a05f04eee15@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 9:24 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e722d7880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=334a10f27a9ee2e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf6ea1d6bb30a4ce10b2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112eeb13880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b78bdb880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/84863f051feb/disk-77856d91.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/87614e2a8a26/vmlinux-77856d91.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cb76bad63a90/bzImage-77856d91.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf6ea1d6bb30a4ce10b2@syzkaller.appspotmail.com

#syz test: git://git.kernel.dk/linux.git io_uring-6.2

-- 
Jens Axboe


