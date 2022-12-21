Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3C65339B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiLUPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:44:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F782E08
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:44:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l10so15886946plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZBFIqT10H+4UsayRiUEr9+GQIHOydECslxG/sJlSmw=;
        b=3HNbaurNAkTYR1KCD2VvPneuM3GJ2mdEHl1Bw3SqP94M6L8NabiSawtp1B+yTb6PpV
         7E7Xwd2FMVuxNS1mjjdh+7UzxKEe5v9sjYJnf1cxBnV4vgzH5ddkVMt+ZdYEEgTLRfko
         plz8mOP/nI1tdzk+xITX72tQOsg0sGx8We5s7QQoGXRj4CTMP50NphCcyk1s9hnJA7tH
         YiGuo/P7i4YEo3RUbhFbziayeuR5xH+ouM6irRl3JV35hJzeVTKumtAQaldO/KiPOrop
         nFxfidcBz/HVgOuO+t4DjNHnfNeg7RdkCDYfZZrrdy+O+jenHohgYAJnA9jYfIivG9A9
         ThtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZBFIqT10H+4UsayRiUEr9+GQIHOydECslxG/sJlSmw=;
        b=6jDspitEHQmDiqcedTGQsHHZT8EY2mr1qcdfUIFrKtzncL/dzT+h1r7Me8w75absEH
         Fs5nuWafXg3kY0bhR0JSWDzE3U3dUGRsrr43YB8ktg537w4hArnoA0QxbM/OBpatamaZ
         VPzVkNozsaP8BUdnTOJeulSusQ5jXJHKtNnNPdn9YvjbktFpwKr7l8jqhTFV5g8HBi1O
         4Xu9RNmnYTgxrQ7Wi56B55illngZF3lm5qAJV4vxf491HYdv76a6rtxie8Lc9iZsx9YQ
         OLeHPiMNfsijW9NogrBBULkXSVzkzJz9TZwGf13eHXBN2r3qENjASQk1W6aq8xudRu9/
         g2bw==
X-Gm-Message-State: AFqh2kqXtUmPiN3Jvjo5RhD+KFYEus9UkyIjVNVF3OrkkG7IHj9BGqZo
        sX3K9np+et5o4V45MPS7stFgAs9UzgN9lmBT
X-Google-Smtp-Source: AMrXdXtDYhES3XntKcIT5CzNq2CaOgU5xgI4oqyb0N1mgaTOjEWbRaxIHgW4R0BikSsie2GP6NYamQ==
X-Received: by 2002:a17:902:8644:b0:189:b74f:46ad with SMTP id y4-20020a170902864400b00189b74f46admr575210plt.3.1671637481784;
        Wed, 21 Dec 2022 07:44:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b001869b988d93sm11649622plk.187.2022.12.21.07.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:44:41 -0800 (PST)
Message-ID: <7c89b1c8-f012-3965-ab77-3bc19b3cedaa@kernel.dk>
Date:   Wed, 21 Dec 2022 08:44:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [syzbot] WARNING in io_sync_cancel
Content-Language: en-US
To:     syzbot <syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000069608005f0580c52@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00000000000069608005f0580c52@google.com>
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

On 12/21/22 8:17 AM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in corrupted
> 
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5788 } 2646 jiffies s: 2841 root: 0x0/T
> rcu: blocking rcu_node structures (internal RCU debug):

#syz test: git://git.kernel.dk/linux.git io_uring-6.2

-- 
Jens Axboe


