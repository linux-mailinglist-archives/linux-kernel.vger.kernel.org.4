Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888756F26FE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjD2Wbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2Wbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:31:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5B18B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:31:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a6670671e3so10357695ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682807502; x=1685399502;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPHsDpkGlPsUeymJHmip8825ZqzKSXSliZm57TlwjvQ=;
        b=OFkAUE/ZjnCUb9a0kpq5KQP//BxcdTW++AyWH6rq/D9WK9XtvkJ09tekM1DEkHWvry
         OfKR/rKqvlIk1pIhGjRSmZypireApgMBf+lcB4VG7Ir3RvnIbmBSc7te7r63ZlHwqsfa
         OUhLcxwKvCTxp7lix4KVWv9WccxiPRIjt1Ml/tEC3pyMpdTPdYAmeaCpbTvR+e1omwdw
         MpJGE2mT+meXC911Neu67LeG0kvqL3XvmtLmkt1fHdBIsX+B9SpcaVYj/GVDvqnACe8e
         KBOhnJyGkYbREmrVsPug31iPFvHJmpXwXzSYmVhh9fg6nv2YPPBB5qU8TOBqqNDxxjII
         +Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682807502; x=1685399502;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPHsDpkGlPsUeymJHmip8825ZqzKSXSliZm57TlwjvQ=;
        b=L5v8T+Et+zptkROAhObE5SRjikRgph5yw3NnJhYFQoPy6UG+WV3PeBj/mlfyOTGj7c
         uVfonb7K9iWh178DX0B00b/zdMjAP5KqEPtmjlDB6VyKu/4QcM/l57Bj381AJxIjmYXZ
         VxBUEyIwQwT63M0UvXwVUqgfWpt85FJnEYsbH13/72zyNQteimmGvpMNG6hCZLbefJEs
         Q8tMqyXtxCq9oawS5YcjXpoOOSkxl5ob8kKP4daVMbTYUQY2TZDhQL11KoDdtXjjkfNA
         PCx7DcgrjGiuSiD+xFJeT7re9Huqvzl0u3F6L/6TIYPfu5iZyQJZuMxiP+1gPFD3IGoM
         b2JA==
X-Gm-Message-State: AC+VfDxZXKYxvFdmADpROz8WRcBeepfJ4JaNfxTidAACmrS4YqFgA811
        rRyJZ3uUgwTGcVqa/s76/1bbGA==
X-Google-Smtp-Source: ACHHUZ6hqMeAHWypNk2/udmWcpEssqk/qIzLMjqRGYwvz2Y10ylroswUy4NiR+4Bcbs59WH1sk8GPg==
X-Received: by 2002:a17:903:2312:b0:1a6:82a7:6e60 with SMTP id d18-20020a170903231200b001a682a76e60mr11048331plh.47.1682807502286;
        Sat, 29 Apr 2023 15:31:42 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b001a9567dc731sm12644148plb.24.2023.04.29.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 15:31:41 -0700 (PDT)
Date:   Sat, 29 Apr 2023 15:31:41 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 15:31:25 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
In-Reply-To: <5fe1484b4f2b4ae960a9b599c4ab3ace@linux.dev>
CC:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     konstantin.ryabitsev@linux.dev
Message-ID: <mhng-539ec982-8235-478e-b695-ee6253b5308c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 14:48:18 PDT (-0700), konstantin.ryabitsev@linux.dev wrote:
>> April 29, 2023 4:17 PM, "Palmer Dabbelt" <palmer@dabbelt.com> wrote:
>>>> I guess you picking this up for your second PR makes the most sense
>>>> Palmer?
>> 
>> Yep, except it crashes b4
>> 
>> $ b4 shazam -lts https://lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d62d@spud
>> Grabbing thread from lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d62d%40spud/t.mbox.gz
>> Analyzing 2 messages in the thread
>> Checking attestation on all messages, may take a moment...
>> Traceback (most recent call last):
>> File "/home/palmer/.local/src/b4/b4/command.py", line 383, in <module>
>> cmd()
>> File "/home/palmer/.local/src/b4/b4/command.py", line 366, in cmd
>> cmdargs.func(cmdargs)
>> File "/home/palmer/.local/src/b4/b4/command.py", line 100, in cmd_shazam
>> b4.mbox.main(cmdargs)
>> File "/home/palmer/.local/src/b4/b4/mbox.py", line 713, in main
>> make_am(msgs, cmdargs, msgid)
>> File "/home/palmer/.local/src/b4/b4/mbox.py", line 101, in make_am
>> am_msgs = lser.get_am_ready(noaddtrailers=cmdargs.noaddtrailers,
>> File "/home/palmer/.local/src/b4/b4/__init__.py", line 552, in get_am_ready
>> checkmark, trailers, attcrit = lmsg.get_attestation_trailers(attpolicy, maxdays)
>> File "/home/palmer/.local/src/b4/b4/__init__.py", line 1319, in get_attestation_trailers
>> for attestor in self.attestors:
>> File "/home/palmer/.local/src/b4/b4/__init__.py", line 1158, in attestors
>> self._load_patatt_attestors()
>> File "/home/palmer/.local/src/b4/b4/__init__.py", line 1261, in _load_patatt_attestors
>> patatt_config = patatt.get_config_from_git(r'patatt\..*', multivals=['keyringsrc'])
>> AttributeError: module 'patatt' has no attribute 'get_config_from_git'
>> 
>> So I probably need to just go update my setup, I've got a bunch of wacky stuff.
>> I'll try and remember to do so, but I'm going to scrub through other bits
>> first...
>
> Indeed, you have a newer version of b4 without also updating the 
> patatt dependency. If you're using b4 from git, you need to "git 
> submodule update".

Thanks, it's fixed.  This one's in the queue for testing, but it looks 
generally fine.  Might be a bit slower than usual, as I'm also running 
the glibc tests.
