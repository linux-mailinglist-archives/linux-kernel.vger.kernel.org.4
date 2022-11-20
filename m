Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E46312A4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 06:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiKTF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 00:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 00:58:45 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D6A4170
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 21:58:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7B2D2604E6;
        Sun, 20 Nov 2022 06:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668923920; bh=Gr/N/0FY1W9pWekVcWezPaYNxeNDefZb+QUa0u9rVYo=;
        h=Date:To:From:Subject:Cc:From;
        b=b8DJ+hGOuuQ+vY+/btgwhkzTPoU9OBw4KSKpN6dlJHUr27ef1E2zB8oNktrFpTEfa
         C7GcjI17/3BGVMbXySrYotRxnp0UJdrN5ZqoUVWKqqysYhouSdzPEhN2Ga9x++vX8s
         WJL93OwEywWs9CLpAFPRLONbXORG3/Gl3a/pXOoMU71MWVvhL+FaDZ0cTrS6m+1m4N
         qp3m6zvPuoAP958KJ7+sN2cnAjRP4S3V09l8SHgmhKssP1qItZ4Dwjr6uRQboW0ICJ
         z40TBhw3BdsI/jkyUldk4ZsX6SvnBZo+Wu7Z68PEyQx32vUS5MnisWXv0mLFoOPiS5
         ifpiljbSigtbg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MVQHL6lzOWT0; Sun, 20 Nov 2022 06:58:36 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.198])
        by domac.alu.hr (Postfix) with ESMTPSA id 3E523604E4;
        Sun, 20 Nov 2022 06:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668923916; bh=Gr/N/0FY1W9pWekVcWezPaYNxeNDefZb+QUa0u9rVYo=;
        h=Date:To:From:Subject:Cc:From;
        b=UkWFAQwXyUmYPuMCGoSA8qgj5DqeWOsawuUl7mVcQWN/dovG7vEEKpzYMoyyXt0wt
         qWnRTOX+6KgwFeOohHbqmLuI1P5eFRFNRwAVT8Hj6faE5m/w8hq8dbMWF7pUss9dkp
         yZm/mBYXHA4BNixYLkmjiQvvROG+8ISKfoxU12QmZ7QkRXCX3tTEoScCTd/97nnCuC
         AIHU9Mh9HMZao7vmbaGlLUuPPazrl28o6PnRShFpLMjGh98MMv+vcmniqRK1EgdB4l
         mtmRLcn9eJENofaZieEbHJWIP6yRZ2cC5JIS4ezwKkD6qKmEPNvWqEWY8tbmTBS301
         lwy3nEdRCvgqA==
Message-ID: <b6a5f822-f7a8-b0b4-233c-8915056dc656@alu.unizg.hr>
Date:   Sun, 20 Nov 2022 06:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Question re: building with cp -l (hard linked sources)
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mr. Bagas,

I am in process of bisecting another bug. Right now I take about 1h30m to build both
the good and bad version of a kernel in bisection.

It helped a great deal to do the following:

# time rm -rf linux_stable_build
# time cp -rp -l linux_stable linux_stable_build
# time diff -ur linux_stable linux_stable_build
# cd linux_stable_build
# rm .config
# cp /boot/config-EXAMPLE .config
# time nice make CC="ccache gcc" KBUILD_BUILD_TIMESTAMP="" -j20 bindeb-pkg |& tee ../error-${VER}.log

I've been doing the good and bad bisect build in the same directory, but is seems to me that
ccache then doesn't realise it compiles the same source twice?

I am not certai of the reliability of a build in a directory with hard links to the original local git
repo copy? How does it handle git checkouts and git bisect resets? Is it supported?

I am asking because I haven't found an answer in any available man pages, and the build and git checkout
process is rather obscure.

It seems to me that build in directory with hard link instead of copying is much faster, and I could
do simultaneous bad and good bisect build, for only one source file has to be fetched and loaded from
the disk into the cache and memory.

However, I cannot test that while bisecting, for it might interfere with some other fault in the tested
kernel.

Is it supported to bisection build in the same directory where the source is? And then do a make mrproper?

I don't know how git and ccache interoperate?

Any advice?

The current procedure works, but it is not time efficient (15 steps might take 30 hours).

Thank you,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union
