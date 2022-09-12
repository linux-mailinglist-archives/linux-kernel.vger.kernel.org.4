Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C345B5A34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:36:19 -0400
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07920BD7;
        Mon, 12 Sep 2022 05:36:17 -0700 (PDT)
Received: from [10.36.2.165] (unknown [178.232.223.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id BCB79260276;
        Mon, 12 Sep 2022 14:36:14 +0200 (CEST)
Message-ID: <baf121ae-a5a4-47a3-bc3a-9255708009b9@selasky.org>
Date:   Mon, 12 Sep 2022 14:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
To:     =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     0215yys@hanmail.net
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus>
 <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
 <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
 <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
 <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com>
 <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org>
In-Reply-To: <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro and YongSu,

Answering my own question: The reason nobody has triggered this yet, is 
because the buffer size used is power of two. Because unsigned modulus 
is used, the result becomes correct. See below. But if non-power of two 
ring-buffer is used, then the result becomes incorrect. There is no 
block for non-power of two sized buffers. See:

https://github.com/search?q=dvb_set_pesfilter&type=code

cat << EOF > testX.c
#include <stdio.h>

int
main()
{
int consumed_old;
int consumed_fix;
size_t idx = 3;
ssize_t pread = 15;
ssize_t size = 256;

consumed_old = (idx - pread) % size;

consumed_fix = (idx - pread);
if (consumed_fix < 0)
consumed_fix += size;

printf("old=%d new=%d size=%zd\n", consumed_old, consumed_fix, size);

size = 254;

consumed_old = (idx - pread) % size;

consumed_fix = (idx - pread);
if (consumed_fix < 0)
consumed_fix += size;

printf("old=%d new=%d size=%zd\n", consumed_old, consumed_fix, size);

return (0);
}
EOF

cc testX.c && ./a.out
old=244 new=244 size=256
old=244 new=242 size=254

So either push the suggested fix, or block non-power of two buffer sizes!

Best regards,
--HPS
