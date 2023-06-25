Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC973D41F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjFYUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFYUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:32:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6809B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:32:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8054180acso2333795ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687725153; x=1690317153;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBlgshKH4iHZ6ZOz7biqH9hQXuaMYrjJzSIAurqMODo=;
        b=VgoYcJiDCA9DGjSnUwAzXIFvDLuky8NaN2eHCiI+14pkYfHQhIkbKIFbryfcUXDa+L
         Z+bfDkfwoFxG4yexzX9URk15JpC/YPxlTGeekdSB1gPW+Fbyi3Dl2bj3Y1I3ZzSs2kat
         /J0dW3iKdPSPIB4Spi5Yc+1clsviISldE/Ul/inCWn2ukasVlEg7rJHFLhO7SAOhDfNu
         efMPQX+HXaE11g5YtDTEI/jar6fGqau+HXCw9Ixt9Bpf8vIQpvGdBP7oFAmf6cJqXvhc
         Ct2ZlEqBV+kpRtSGM0wXYFQH6ljp3Gl3ubnO8TGwvzr0DVC6M2e+jjWK6GDbWufbb48I
         DDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687725153; x=1690317153;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBlgshKH4iHZ6ZOz7biqH9hQXuaMYrjJzSIAurqMODo=;
        b=PiY1nyK+uYh2S7ptyQC4nsSmrzKLt1G3fsWssvUsJzWNaNg7TwpPhKr6pFqOtDP/if
         0NrMkjZ5iKD2IKMxC/9zkjsnuAfhKq5lePR4YsrbuiKNYkqYNIdst+FfIzzv2smV6Teb
         nO+1x+vvO0FdH1ZSW6lJr69YGhdsn3e8keX1GtcYOP5PSpGAihW9R+rQTVk4KKaqUUPx
         btqdKN906DD0GsCOGbe7LzIE62Vnew4LBLivOyVN3+cnB939O54x7iIaGI6E4CoYT7NZ
         bu5xAp+sgNDNFGmcWorWccb1MfMoprEScY2tYFCt0VzJM0BhDpnmBt1LBoWUEMSY53l/
         XFMg==
X-Gm-Message-State: AC+VfDwVMP7rK52XszK2UIJ3LabWwKKl84cPMTTDN2jGztei2XkIp2Sm
        DQlybNd4/z5feOdc0PRvetjfrg==
X-Google-Smtp-Source: ACHHUZ6bcYS4/UaX8iSXpyadxQeExPfzsfqR9xq6pFt1YaUiqNjuA8+0Ohu9fS4bWAErBSH48Qjuiw==
X-Received: by 2002:a17:903:2306:b0:1b0:7123:6ee8 with SMTP id d6-20020a170903230600b001b071236ee8mr6606809plh.61.1687725153095;
        Sun, 25 Jun 2023 13:32:33 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001b51b3e84cesm2808774plb.166.2023.06.25.13.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:32:32 -0700 (PDT)
Date:   Sun, 25 Jun 2023 13:32:32 -0700 (PDT)
X-Google-Original-Date: Sun, 25 Jun 2023 13:31:47 PDT (-0700)
Subject:     Re: [PATCH V10 4/4] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
In-Reply-To: <CAAYs2=hd1geHCTGrO=JohTYtgu+yj+D7EPono-ADOGfjYnLfrA@mail.gmail.com>
CC:     rostedt@goodmis.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, guoren@kernel.org,
        jszhang@kernel.org, e.shatokhin@yadro.com,
        Bjorn Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     suagrfillet@gmail.com
Message-ID: <mhng-29a592bf-1b25-4c6c-8f37-0d05d39bc093@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 02:37:53 PDT (-0700), suagrfillet@gmail.com wrote:
> Steven Rostedt <rostedt@goodmis.org> 于2023年5月15日周一 18:37写道：
>>
>> On Thu, 11 May 2023 17:32:34 +0800
>> Song Shuai <suagrfillet@gmail.com> wrote:
>>
>> > select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>> > for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
>> > the ftrace-direct*.c files in samples/ftrace/.
>> >
>> > Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
>> > Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
>> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
>> > Tested-by: Guo Ren <guoren@kernel.org>
>> > Signed-off-by: Guo Ren <guoren@kernel.org>
>> > Acked-by: Björn Töpel <bjorn@rivosinc.com>
>> > ---
>> >  arch/riscv/Kconfig                          |  2 ++
>> >  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
>> >  samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
>> >  samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
>> >  samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
>> >  samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
>> >  6 files changed, 150 insertions(+)
>>
>> I acked v8 (which you will need my ack to get these in). Unless this patch
>> changed since v8, you should include my ack in further versions.
>>
> There were no changes in this patch, except for a few tab pretties since v8.
> your Acked-by will still be included.
>> Or you may be waiting longer for its acceptance.
>>
>> If the patch did change, please acknowledge that in the next version (or
>> this one if it did change), asking me to ack it again.

The samples fail to build on rv32, they're rv64-specific.  I think 
something like this should do it

diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 5c319db48af2..3707c447a42d 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -24,19 +24,19 @@ asm (
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
 "   my_tramp:\n"
-"       addi	sp,sp,-40\n"
-"       sd	a0,0(sp)\n"
-"       sd	a1,8(sp)\n"
-"       sd	a2,16(sp)\n"
-"       sd	t0,24(sp)\n"
-"       sd	ra,32(sp)\n"
+"       addi	sp,sp,-8*SZREG\n"
+"       REG_S 	a0,0*SZREG(sp)\n"
+"       REG_S 	a1,1*SZREG(sp)\n"
+"       REG_S 	a2,2*SZREG(sp)\n"
+"       REG_S 	t0,3*SZREG(sp)\n"
+"       REG_S 	ra,4*SZREG(sp)\n"
 "       call	my_direct_func\n"
-"       ld	a0,0(sp)\n"
-"       ld	a1,8(sp)\n"
-"       ld	a2,16(sp)\n"
-"       ld	t0,24(sp)\n"
-"       ld	ra,32(sp)\n"
-"       addi	sp,sp,40\n"
+"       REG_L 	a0,0*SZREG(sp)\n"
+"       REG_L 	a1,1*SZREG(sp)\n"
+"       REG_L 	a2,2*SZREG(sp)\n"
+"       REG_L 	t0,3*SZREG(sp)\n"
+"       REG_L 	ra,4*SZREG(sp)\n"
+"       addi	sp,sp,8*SZREG\n"
 "       jr	t0\n"
 "       .size           my_tramp, .-my_tramp\n"
 "       .popsection\n"

probably for all of them.  Do you mind sending a v11 with that fixed?  

>>
>> -- Steve
>
>
>
> -- 
> Thanks,
> Song
