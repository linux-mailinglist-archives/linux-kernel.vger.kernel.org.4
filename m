Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD63F669CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjAMPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjAMPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:51:55 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6959FBA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:44:28 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id g25so913675uaw.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=louRFlczbHZKp7oWi8fHTGyEElKoYHfYjEnBI1fU9DA=;
        b=GlmfmHkbgpbw//xLUj6hA1h1DpPvtz7hnG1zmWoOIR5wsX/dKjQnZHoCIP1flGwxe2
         1CZmoDoWv5q+nLFSyLDk934BFVxLUxX89dbGAXfBiR5j6Fxhs1qBqX4RO1ZcWwBDx72e
         6nOlKuAgD6q/V1mxaNseFJLXjK5lbZKKu0zyLJdo8KZU2SqoRN18xNxH+Y0jJPrG693G
         A4sYqEyMFn4FkW5SCpVc6iwc8CWtaF7s02Hg8JH36dPUoWV1NlO6UND9EonsETkQ3cQG
         3ue/qUzhb5fZXuV+GzkWEG59s9CPrgG08sJqzPtToA+xamd9uVBfAhpNUhHO+d9WIxWk
         l1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=louRFlczbHZKp7oWi8fHTGyEElKoYHfYjEnBI1fU9DA=;
        b=sLJX8/1ylhG3SbkdLLriCDVnBaHidtK/ITzHsPzp0HMJT36bAmpfNlCDuJskvVLHxM
         Mvmaq+1pyL1jbkkCVjxre2sGy3uyAlSIcuU08qQ6RcZzyA9zOqRBU9RyUdk3WBFQYK1C
         gxCLrXom7cIoWLysSXyw9oejuewQ2kfqVGZGuSNmjtJYq6CJaRU8EOkp8rWByhIOc1cv
         DE+HdOzZdZW4nDaL+ZCZF2bO/SPohmkmaa6Deimr5KDBh/DzxTgwFq0JcS0XMnWVMFV2
         gBiM2N7Gy7McWO6Y55H9LVkYrvRcxRwXblmOkbklj3wl8i4bP35BlhWmI/kPAxW9YeYA
         83hw==
X-Gm-Message-State: AFqh2kprZmUqXDhl5Ma8+iFbMuFkNKuSZjI8RGmDeJ0MSXpHl6+XDucd
        0A6d6XxUMcnqXLPSCYIWUcECPIcMUOzUfBwoIPO+gg==
X-Google-Smtp-Source: AMrXdXub6rc4BX/OLf54aaEu8/kkq9BlswO8nAnrfWnXISGiF9zLh0Ps455WeL0CEfNt9/aKWiE40X4hPqtnkG7bhGw=
X-Received: by 2002:ab0:251a:0:b0:5d5:d02:8626 with SMTP id
 j26-20020ab0251a000000b005d50d028626mr3273638uan.115.1673624667512; Fri, 13
 Jan 2023 07:44:27 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
 <Y8Fkjxsq5EOtGiql@casper.infradead.org>
In-Reply-To: <Y8Fkjxsq5EOtGiql@casper.infradead.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Jan 2023 21:14:15 +0530
Message-ID: <CA+G9fYuahjaNs6ia1UOeF98hUhonAt0Z4YOFGcqOKt3J4tRvTw@mail.gmail.com>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000cbe25205f2271b2e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cbe25205f2271b2e
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

On Fri, 13 Jan 2023 at 19:32, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 06:53:01PM +0530, Naresh Kamboju wrote:
> > Linux next tag 20230113 boot failed on x86_64, arm64, arm and i386.
>
> Why are you still not running these stack dumps through
> scripts/decode_stacktrace.sh ?  That seems like it's much easier for you
> to do than expecting everybody who might be interested in investigating
> your reports to pull down enough of the build artifacts to make it work.

Hope this will help you.

# ./scripts/decode_stacktrace.sh vmlinux  < input.txt > output.txt

stack dumps:
------------------
[   15.945626] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   15.952588] #PF: supervisor read access in kernel mode
[   15.957720] #PF: error_code(0x0000) - not-present page
[   15.962850] PGD 8000000103213067 P4D 8000000103213067 PUD 103212067 PMD 0
[   15.969724] Oops: 0000 [#1] PREEMPT SMP PTI
[   15.973909] CPU: 3 PID: 1 Comm: init Not tainted 6.2.0-rc3-next-20230113 #1
[   15.980869] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   15.988336] RIP: 0010:do_wp_page (memory.c:?)
[ 15.992611] Code: 83 ea 01 49 89 d7 48 85 d2 0f 85 00 ff ff ff 49 8b
7c 24 60 e8 0b f2 e9 00 41 8b 44 24 28 4d 8b 74 24 50 4d 8b 2c 24 89
45 88 <49> 8b 46 08 49 8b 5d 10 a8 01 0f 85 78 02 00 00 0f 1f 44 00 00
4c
All code
========
   0: 83 ea 01              sub    $0x1,%edx
   3: 49 89 d7              mov    %rdx,%r15
   6: 48 85 d2              test   %rdx,%rdx
   9: 0f 85 00 ff ff ff    jne    0xffffffffffffff0f
   f: 49 8b 7c 24 60        mov    0x60(%r12),%rdi
  14: e8 0b f2 e9 00        callq  0xe9f224
  19: 41 8b 44 24 28        mov    0x28(%r12),%eax
  1e: 4d 8b 74 24 50        mov    0x50(%r12),%r14
  23: 4d 8b 2c 24          mov    (%r12),%r13
  27: 89 45 88              mov    %eax,-0x78(%rbp)
  2a:* 49 8b 46 08          mov    0x8(%r14),%rax <-- trapping instruction
  2e: 49 8b 5d 10          mov    0x10(%r13),%rbx
  32: a8 01                test   $0x1,%al
  34: 0f 85 78 02 00 00    jne    0x2b2
  3a: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  3f: 4c                    rex.WR

Code starting with the faulting instruction
===========================================
   0: 49 8b 46 08          mov    0x8(%r14),%rax
   4: 49 8b 5d 10          mov    0x10(%r13),%rbx
   8: a8 01                test   $0x1,%al
   a: 0f 85 78 02 00 00    jne    0x288
  10: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  15: 4c                    rex.WR
[   16.011356] RSP: 0000:ffffb3f640027d18 EFLAGS: 00010286
[   16.016583] RAX: 0000000000000a55 RBX: 0400000000000080 RCX: 0000000000000000
[   16.023715] RDX: 0000000000000000 RSI: ffffffff8d3d2bd5 RDI: ffffffff8e271dfa
[   16.030838] RBP: ffffb3f640027db0 R08: 8000000432ee9225 R09: ffff8ac3431e3100
[   16.037962] R10: 0000000000000000 R11: 00007fe169f2f598 R12: ffffb3f640027de0
[   16.045087] R13: ffff8ac3431e2000 R14: 0000000000000000 R15: 0400000000000000
[   16.052211] FS:  00007fe16973e800(0000) GS:ffff8ac69fd80000(0000)
knlGS:0000000000000000
[   16.060319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.066060] CR2: 0000000000000008 CR3: 00000001008d4002 CR4: 00000000003706e0
[   16.073183] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.080322] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.087446] Call Trace:
[   16.089893]  <TASK>
[   16.091991] ? trace_preempt_off (??:?)
[   16.096087] ? __handle_mm_fault (memory.c:?)
[   16.100439] __handle_mm_fault (memory.c:?)
[   16.104617] handle_mm_fault (??:?)
[   16.108457] do_user_addr_fault (fault.c:?)
[   16.112642] exc_page_fault (??:?)
[   16.116394] asm_exc_page_fault (??:?)
[   16.120408] RIP: 0033:0x7fe169dbf31e
[ 16.123986] Code: ba ff ff ff ff 0f 9f c0 0f b6 c0 0f 4c c2 c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 00 41 54 31 c0 ba ff ff ff ff 53 48 83
ec 08 <f0> 0f b1 15 72 02 17 00 83 f8 ff 74 35 41 89 c4 85 c0 75 21 31
c0
All code
========
   0: ba ff ff ff ff        mov    $0xffffffff,%edx
   5: 0f 9f c0              setg   %al
   8: 0f b6 c0              movzbl %al,%eax
   b: 0f 4c c2              cmovl  %edx,%eax
   e: c3                    retq
   f: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
  16: 00 00 00
  19: 0f 1f 00              nopl   (%rax)
  1c: 41 54                push   %r12
  1e: 31 c0                xor    %eax,%eax
  20: ba ff ff ff ff        mov    $0xffffffff,%edx
  25: 53                    push   %rbx
  26: 48 83 ec 08          sub    $0x8,%rsp
  2a:* f0 0f b1 15 72 02 17 lock cmpxchg %edx,0x170272(%rip)        #
0x1702a4 <-- trapping instruction
  31: 00
  32: 83 f8 ff              cmp    $0xffffffff,%eax
  35: 74 35                je     0x6c
  37: 41 89 c4              mov    %eax,%r12d
  3a: 85 c0                test   %eax,%eax
  3c: 75 21                jne    0x5f
  3e: 31 c0                xor    %eax,%eax

Code starting with the faulting instruction
===========================================
   0: f0 0f b1 15 72 02 17 lock cmpxchg %edx,0x170272(%rip)        # 0x17027a
   7: 00
   8: 83 f8 ff              cmp    $0xffffffff,%eax
   b: 74 35                je     0x42
   d: 41 89 c4              mov    %eax,%r12d
  10: 85 c0                test   %eax,%eax
  12: 75 21                jne    0x35
  14: 31 c0                xor    %eax,%eax
[   16.142724] RSP: 002b:00007ffcd0edec80 EFLAGS: 00010202
[   16.147948] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000555bd8
[   16.155074] RDX: 00000000ffffffff RSI: 00007ffcd0edefa8 RDI: 0000000000000001
[   16.162198] RBP: 00007ffcd0edefa8 R08: 00007fe169bc5a10 R09: 00007fe169f37a10
[   16.169319] R10: 00007fe169adf3ee R11: 0000000000000246 R12: 00007ffcd0edefa8
[   16.176445] R13: 000000000041b9a0 R14: 0000000000555bd8 R15: 00007fe169f69000
[   16.183569]  </TASK>
[   16.185752] Modules linked in:
[   16.188803] CR2: 0000000000000008
[   16.192114] ---[ end trace 0000000000000000 ]---

ref:
https://lore.kernel.org/linux-next/CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com/

- Naresh

--000000000000cbe25205f2271b2e
Content-Type: text/plain; charset="US-ASCII"; name="output.txt"
Content-Disposition: attachment; filename="output.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lcuotkxh0>
X-Attachment-Id: f_lcuotkxh0

WyAgIDE1Ljk0NTYyNl0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRy
ZXNzOiAwMDAwMDAwMDAwMDAwMDA4ClsgICAxNS45NTI1ODhdICNQRjogc3VwZXJ2aXNvciByZWFk
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbICAgMTUuOTU3NzIwXSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgIDE1Ljk2Mjg1MF0gUEdEIDgwMDAwMDAxMDMyMTMw
NjcgUDREIDgwMDAwMDAxMDMyMTMwNjcgUFVEIDEwMzIxMjA2NyBQTUQgMApbICAgMTUuOTY5NzI0
XSBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgUFRJClsgICAxNS45NzM5MDldIENQVTogMyBQ
SUQ6IDEgQ29tbTogaW5pdCBOb3QgdGFpbnRlZCA2LjIuMC1yYzMtbmV4dC0yMDIzMDExMyAjMQpb
ICAgMTUuOTgwODY5XSBIYXJkd2FyZSBuYW1lOiBTdXBlcm1pY3JvIFNZUy01MDE5Uy1NTC9YMTFT
U0gtRiwgQklPUyAyLjBiIDA3LzI3LzIwMTcKWyAgIDE1Ljk4ODMzNl0gUklQOiAwMDEwOmRvX3dw
X3BhZ2UgKG1lbW9yeS5jOj8pIApbIDE1Ljk5MjYxMV0gQ29kZTogODMgZWEgMDEgNDkgODkgZDcg
NDggODUgZDIgMGYgODUgMDAgZmYgZmYgZmYgNDkgOGIgN2MgMjQgNjAgZTggMGIgZjIgZTkgMDAg
NDEgOGIgNDQgMjQgMjggNGQgOGIgNzQgMjQgNTAgNGQgOGIgMmMgMjQgODkgNDUgODggPDQ5PiA4
YiA0NiAwOCA0OSA4YiA1ZCAxMCBhOCAwMSAwZiA4NSA3OCAwMiAwMCAwMCAwZiAxZiA0NCAwMCAw
MCA0YwpBbGwgY29kZQo9PT09PT09PQogICAwOgk4MyBlYSAwMSAgICAgICAgICAgICAJc3ViICAg
ICQweDEsJWVkeAogICAzOgk0OSA4OSBkNyAgICAgICAgICAgICAJbW92ICAgICVyZHgsJXIxNQog
ICA2Ogk0OCA4NSBkMiAgICAgICAgICAgICAJdGVzdCAgICVyZHgsJXJkeAogICA5OgkwZiA4NSAw
MCBmZiBmZiBmZiAgICAJam5lICAgIDB4ZmZmZmZmZmZmZmZmZmYwZgogICBmOgk0OSA4YiA3YyAy
NCA2MCAgICAgICAJbW92ICAgIDB4NjAoJXIxMiksJXJkaQogIDE0OgllOCAwYiBmMiBlOSAwMCAg
ICAgICAJY2FsbHEgIDB4ZTlmMjI0CiAgMTk6CTQxIDhiIDQ0IDI0IDI4ICAgICAgIAltb3YgICAg
MHgyOCglcjEyKSwlZWF4CiAgMWU6CTRkIDhiIDc0IDI0IDUwICAgICAgIAltb3YgICAgMHg1MCgl
cjEyKSwlcjE0CiAgMjM6CTRkIDhiIDJjIDI0ICAgICAgICAgIAltb3YgICAgKCVyMTIpLCVyMTMK
ICAyNzoJODkgNDUgODggICAgICAgICAgICAgCW1vdiAgICAlZWF4LC0weDc4KCVyYnApCiAgMmE6
Kgk0OSA4YiA0NiAwOCAgICAgICAgICAJbW92ICAgIDB4OCglcjE0KSwlcmF4CQk8LS0gdHJhcHBp
bmcgaW5zdHJ1Y3Rpb24KICAyZToJNDkgOGIgNWQgMTAgICAgICAgICAgCW1vdiAgICAweDEwKCVy
MTMpLCVyYngKICAzMjoJYTggMDEgICAgICAgICAgICAgICAgCXRlc3QgICAkMHgxLCVhbAogIDM0
OgkwZiA4NSA3OCAwMiAwMCAwMCAgICAJam5lICAgIDB4MmIyCiAgM2E6CTBmIDFmIDQ0IDAwIDAw
ICAgICAgIAlub3BsICAgMHgwKCVyYXgsJXJheCwxKQogIDNmOgk0YyAgICAgICAgICAgICAgICAg
ICAJcmV4LldSCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgMDoJNDkgOGIgNDYg
MDggICAgICAgICAgCW1vdiAgICAweDgoJXIxNCksJXJheAogICA0Ogk0OSA4YiA1ZCAxMCAgICAg
ICAgICAJbW92ICAgIDB4MTAoJXIxMyksJXJieAogICA4OglhOCAwMSAgICAgICAgICAgICAgICAJ
dGVzdCAgICQweDEsJWFsCiAgIGE6CTBmIDg1IDc4IDAyIDAwIDAwICAgIAlqbmUgICAgMHgyODgK
ICAxMDoJMGYgMWYgNDQgMDAgMDAgICAgICAgCW5vcGwgICAweDAoJXJheCwlcmF4LDEpCiAgMTU6
CTRjICAgICAgICAgICAgICAgICAgIAlyZXguV1IKWyAgIDE2LjAxMTM1Nl0gUlNQOiAwMDAwOmZm
ZmZiM2Y2NDAwMjdkMTggRUZMQUdTOiAwMDAxMDI4NgpbICAgMTYuMDE2NTgzXSBSQVg6IDAwMDAw
MDAwMDAwMDBhNTUgUkJYOiAwNDAwMDAwMDAwMDAwMDgwIFJDWDogMDAwMDAwMDAwMDAwMDAwMApb
ICAgMTYuMDIzNzE1XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZjhkM2QyYmQ1
IFJESTogZmZmZmZmZmY4ZTI3MWRmYQpbICAgMTYuMDMwODM4XSBSQlA6IGZmZmZiM2Y2NDAwMjdk
YjAgUjA4OiA4MDAwMDAwNDMyZWU5MjI1IFIwOTogZmZmZjhhYzM0MzFlMzEwMApbICAgMTYuMDM3
OTYyXSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwN2ZlMTY5ZjJmNTk4IFIxMjogZmZm
ZmIzZjY0MDAyN2RlMApbICAgMTYuMDQ1MDg3XSBSMTM6IGZmZmY4YWMzNDMxZTIwMDAgUjE0OiAw
MDAwMDAwMDAwMDAwMDAwIFIxNTogMDQwMDAwMDAwMDAwMDAwMApbICAgMTYuMDUyMjExXSBGUzog
IDAwMDA3ZmUxNjk3M2U4MDAoMDAwMCkgR1M6ZmZmZjhhYzY5ZmQ4MDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwClsgICAxNi4wNjAzMTldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAw
MCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWyAgIDE2LjA2NjA2MF0gQ1IyOiAwMDAwMDAwMDAwMDAw
MDA4IENSMzogMDAwMDAwMDEwMDhkNDAwMiBDUjQ6IDAwMDAwMDAwMDAzNzA2ZTAKWyAgIDE2LjA3
MzE4M10gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAw
MDAwMDAwMDAwMDAwMDAKWyAgIDE2LjA4MDMyMl0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjog
MDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKWyAgIDE2LjA4NzQ0Nl0gQ2Fs
bCBUcmFjZToKWyAgIDE2LjA4OTg5M10gIDxUQVNLPgpbICAgMTYuMDkxOTkxXSA/IHRyYWNlX3By
ZWVtcHRfb2ZmICg/Pzo/KSAKWyAgIDE2LjA5NjA4N10gPyBfX2hhbmRsZV9tbV9mYXVsdCAobWVt
b3J5LmM6PykgClsgICAxNi4xMDA0MzldIF9faGFuZGxlX21tX2ZhdWx0IChtZW1vcnkuYzo/KSAK
WyAgIDE2LjEwNDYxN10gaGFuZGxlX21tX2ZhdWx0ICg/Pzo/KSAKWyAgIDE2LjEwODQ1N10gZG9f
dXNlcl9hZGRyX2ZhdWx0IChmYXVsdC5jOj8pIApbICAgMTYuMTEyNjQyXSBleGNfcGFnZV9mYXVs
dCAoPz86PykgClsgICAxNi4xMTYzOTRdIGFzbV9leGNfcGFnZV9mYXVsdCAoPz86PykgClsgICAx
Ni4xMjA0MDhdIFJJUDogMDAzMzoweDdmZTE2OWRiZjMxZQpbIDE2LjEyMzk4Nl0gQ29kZTogYmEg
ZmYgZmYgZmYgZmYgMGYgOWYgYzAgMGYgYjYgYzAgMGYgNGMgYzIgYzMgNjYgMmUgMGYgMWYgODQg
MDAgMDAgMDAgMDAgMDAgMGYgMWYgMDAgNDEgNTQgMzEgYzAgYmEgZmYgZmYgZmYgZmYgNTMgNDgg
ODMgZWMgMDggPGYwPiAwZiBiMSAxNSA3MiAwMiAxNyAwMCA4MyBmOCBmZiA3NCAzNSA0MSA4OSBj
NCA4NSBjMCA3NSAyMSAzMSBjMApBbGwgY29kZQo9PT09PT09PQogICAwOgliYSBmZiBmZiBmZiBm
ZiAgICAgICAJbW92ICAgICQweGZmZmZmZmZmLCVlZHgKICAgNToJMGYgOWYgYzAgICAgICAgICAg
ICAgCXNldGcgICAlYWwKICAgODoJMGYgYjYgYzAgICAgICAgICAgICAgCW1vdnpibCAlYWwsJWVh
eAogICBiOgkwZiA0YyBjMiAgICAgICAgICAgICAJY21vdmwgICVlZHgsJWVheAogICBlOgljMyAg
ICAgICAgICAgICAgICAgICAJcmV0cSAgIAogICBmOgk2NiAyZSAwZiAxZiA4NCAwMCAwMCAJbm9w
dyAgICVjczoweDAoJXJheCwlcmF4LDEpCiAgMTY6CTAwIDAwIDAwIAogIDE5OgkwZiAxZiAwMCAg
ICAgICAgICAgICAJbm9wbCAgICglcmF4KQogIDFjOgk0MSA1NCAgICAgICAgICAgICAgICAJcHVz
aCAgICVyMTIKICAxZToJMzEgYzAgICAgICAgICAgICAgICAgCXhvciAgICAlZWF4LCVlYXgKICAy
MDoJYmEgZmYgZmYgZmYgZmYgICAgICAgCW1vdiAgICAkMHhmZmZmZmZmZiwlZWR4CiAgMjU6CTUz
ICAgICAgICAgICAgICAgICAgIAlwdXNoICAgJXJieAogIDI2Ogk0OCA4MyBlYyAwOCAgICAgICAg
ICAJc3ViICAgICQweDgsJXJzcAogIDJhOioJZjAgMGYgYjEgMTUgNzIgMDIgMTcgCWxvY2sgY21w
eGNoZyAlZWR4LDB4MTcwMjcyKCVyaXApICAgICAgICAjIDB4MTcwMmE0CQk8LS0gdHJhcHBpbmcg
aW5zdHJ1Y3Rpb24KICAzMToJMDAgCiAgMzI6CTgzIGY4IGZmICAgICAgICAgICAgIAljbXAgICAg
JDB4ZmZmZmZmZmYsJWVheAogIDM1Ogk3NCAzNSAgICAgICAgICAgICAgICAJamUgICAgIDB4NmMK
ICAzNzoJNDEgODkgYzQgICAgICAgICAgICAgCW1vdiAgICAlZWF4LCVyMTJkCiAgM2E6CTg1IGMw
ICAgICAgICAgICAgICAgIAl0ZXN0ICAgJWVheCwlZWF4CiAgM2M6CTc1IDIxICAgICAgICAgICAg
ICAgIAlqbmUgICAgMHg1ZgogIDNlOgkzMSBjMCAgICAgICAgICAgICAgICAJeG9yICAgICVlYXgs
JWVheAoKQ29kZSBzdGFydGluZyB3aXRoIHRoZSBmYXVsdGluZyBpbnN0cnVjdGlvbgo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgIDA6CWYwIDBmIGIxIDE1IDcy
IDAyIDE3IAlsb2NrIGNtcHhjaGcgJWVkeCwweDE3MDI3MiglcmlwKSAgICAgICAgIyAweDE3MDI3
YQogICA3OgkwMCAKICAgODoJODMgZjggZmYgICAgICAgICAgICAgCWNtcCAgICAkMHhmZmZmZmZm
ZiwlZWF4CiAgIGI6CTc0IDM1ICAgICAgICAgICAgICAgIAlqZSAgICAgMHg0MgogICBkOgk0MSA4
OSBjNCAgICAgICAgICAgICAJbW92ICAgICVlYXgsJXIxMmQKICAxMDoJODUgYzAgICAgICAgICAg
ICAgICAgCXRlc3QgICAlZWF4LCVlYXgKICAxMjoJNzUgMjEgICAgICAgICAgICAgICAgCWpuZSAg
ICAweDM1CiAgMTQ6CTMxIGMwICAgICAgICAgICAgICAgIAl4b3IgICAgJWVheCwlZWF4ClsgICAx
Ni4xNDI3MjRdIFJTUDogMDAyYjowMDAwN2ZmY2QwZWRlYzgwIEVGTEFHUzogMDAwMTAyMDIKWyAg
IDE2LjE0Nzk0OF0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBS
Q1g6IDAwMDAwMDAwMDA1NTViZDgKWyAgIDE2LjE1NTA3NF0gUkRYOiAwMDAwMDAwMGZmZmZmZmZm
IFJTSTogMDAwMDdmZmNkMGVkZWZhOCBSREk6IDAwMDAwMDAwMDAwMDAwMDEKWyAgIDE2LjE2MjE5
OF0gUkJQOiAwMDAwN2ZmY2QwZWRlZmE4IFIwODogMDAwMDdmZTE2OWJjNWExMCBSMDk6IDAwMDA3
ZmUxNjlmMzdhMTAKWyAgIDE2LjE2OTMxOV0gUjEwOiAwMDAwN2ZlMTY5YWRmM2VlIFIxMTogMDAw
MDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA3ZmZjZDBlZGVmYTgKWyAgIDE2LjE3NjQ0NV0gUjEzOiAw
MDAwMDAwMDAwNDFiOWEwIFIxNDogMDAwMDAwMDAwMDU1NWJkOCBSMTU6IDAwMDA3ZmUxNjlmNjkw
MDAKWyAgIDE2LjE4MzU2OV0gIDwvVEFTSz4KWyAgIDE2LjE4NTc1Ml0gTW9kdWxlcyBsaW5rZWQg
aW46ClsgICAxNi4xODg4MDNdIENSMjogMDAwMDAwMDAwMDAwMDAwOApbICAgMTYuMTkyMTE0XSAt
LS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0K
--000000000000cbe25205f2271b2e
Content-Type: text/plain; charset="US-ASCII"; name="input.txt"
Content-Disposition: attachment; filename="input.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lcuotkxm1>
X-Attachment-Id: f_lcuotkxm1

WyAgIDE1Ljk0NTYyNl0gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRy
ZXNzOiAwMDAwMDAwMDAwMDAwMDA4ClsgICAxNS45NTI1ODhdICNQRjogc3VwZXJ2aXNvciByZWFk
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbICAgMTUuOTU3NzIwXSAjUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgIDE1Ljk2Mjg1MF0gUEdEIDgwMDAwMDAxMDMyMTMw
NjcgUDREIDgwMDAwMDAxMDMyMTMwNjcgUFVEIDEwMzIxMjA2NyBQTUQgMCAKWyAgIDE1Ljk2OTcy
NF0gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQpbICAgMTUuOTczOTA5XSBDUFU6IDMg
UElEOiAxIENvbW06IGluaXQgTm90IHRhaW50ZWQgNi4yLjAtcmMzLW5leHQtMjAyMzAxMTMgIzEK
WyAgIDE1Ljk4MDg2OV0gSGFyZHdhcmUgbmFtZTogU3VwZXJtaWNybyBTWVMtNTAxOVMtTUwvWDEx
U1NILUYsIEJJT1MgMi4wYiAwNy8yNy8yMDE3ClsgICAxNS45ODgzMzZdIFJJUDogMDAxMDpkb193
cF9wYWdlKzB4MjM2LzB4ZWYwClsgICAxNS45OTI2MTFdIENvZGU6IDgzIGVhIDAxIDQ5IDg5IGQ3
IDQ4IDg1IGQyIDBmIDg1IDAwIGZmIGZmIGZmIDQ5IDhiIDdjIDI0IDYwIGU4IDBiIGYyIGU5IDAw
IDQxIDhiIDQ0IDI0IDI4IDRkIDhiIDc0IDI0IDUwIDRkIDhiIDJjIDI0IDg5IDQ1IDg4IDw0OT4g
OGIgNDYgMDggNDkgOGIgNWQgMTAgYTggMDEgMGYgODUgNzggMDIgMDAgMDAgMGYgMWYgNDQgMDAg
MDAgNGMKWyAgIDE2LjAxMTM1Nl0gUlNQOiAwMDAwOmZmZmZiM2Y2NDAwMjdkMTggRUZMQUdTOiAw
MDAxMDI4NgpbICAgMTYuMDE2NTgzXSBSQVg6IDAwMDAwMDAwMDAwMDBhNTUgUkJYOiAwNDAwMDAw
MDAwMDAwMDgwIFJDWDogMDAwMDAwMDAwMDAwMDAwMApbICAgMTYuMDIzNzE1XSBSRFg6IDAwMDAw
MDAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZjhkM2QyYmQ1IFJESTogZmZmZmZmZmY4ZTI3MWRmYQpb
ICAgMTYuMDMwODM4XSBSQlA6IGZmZmZiM2Y2NDAwMjdkYjAgUjA4OiA4MDAwMDAwNDMyZWU5MjI1
IFIwOTogZmZmZjhhYzM0MzFlMzEwMApbICAgMTYuMDM3OTYyXSBSMTA6IDAwMDAwMDAwMDAwMDAw
MDAgUjExOiAwMDAwN2ZlMTY5ZjJmNTk4IFIxMjogZmZmZmIzZjY0MDAyN2RlMApbICAgMTYuMDQ1
MDg3XSBSMTM6IGZmZmY4YWMzNDMxZTIwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDQw
MDAwMDAwMDAwMDAwMApbICAgMTYuMDUyMjExXSBGUzogIDAwMDA3ZmUxNjk3M2U4MDAoMDAwMCkg
R1M6ZmZmZjhhYzY5ZmQ4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwClsgICAxNi4w
NjAzMTldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMK
WyAgIDE2LjA2NjA2MF0gQ1IyOiAwMDAwMDAwMDAwMDAwMDA4IENSMzogMDAwMDAwMDEwMDhkNDAw
MiBDUjQ6IDAwMDAwMDAwMDAzNzA2ZTAKWyAgIDE2LjA3MzE4M10gRFIwOiAwMDAwMDAwMDAwMDAw
MDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKWyAgIDE2LjA4
MDMyMl0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAw
MDAwMDAwMDAwMDA0MDAKWyAgIDE2LjA4NzQ0Nl0gQ2FsbCBUcmFjZToKWyAgIDE2LjA4OTg5M10g
IDxUQVNLPgpbICAgMTYuMDkxOTkxXSAgPyB0cmFjZV9wcmVlbXB0X29mZisweDJkLzB4ZDAKWyAg
IDE2LjA5NjA4N10gID8gX19oYW5kbGVfbW1fZmF1bHQrMHg3ZWUvMHgxMmYwClsgICAxNi4xMDA0
MzldICBfX2hhbmRsZV9tbV9mYXVsdCsweGFiZi8weDEyZjAKWyAgIDE2LjEwNDYxN10gIGhhbmRs
ZV9tbV9mYXVsdCsweGY4LzB4MzIwClsgICAxNi4xMDg0NTddICBkb191c2VyX2FkZHJfZmF1bHQr
MHgxZDkvMHg2NTAKWyAgIDE2LjExMjY0Ml0gIGV4Y19wYWdlX2ZhdWx0KzB4NmIvMHgxNzAKWyAg
IDE2LjExNjM5NF0gIGFzbV9leGNfcGFnZV9mYXVsdCsweDJiLzB4MzAKWyAgIDE2LjEyMDQwOF0g
UklQOiAwMDMzOjB4N2ZlMTY5ZGJmMzFlClsgICAxNi4xMjM5ODZdIENvZGU6IGJhIGZmIGZmIGZm
IGZmIDBmIDlmIGMwIDBmIGI2IGMwIDBmIDRjIGMyIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAw
IDAwIDAwIDBmIDFmIDAwIDQxIDU0IDMxIGMwIGJhIGZmIGZmIGZmIGZmIDUzIDQ4IDgzIGVjIDA4
IDxmMD4gMGYgYjEgMTUgNzIgMDIgMTcgMDAgODMgZjggZmYgNzQgMzUgNDEgODkgYzQgODUgYzAg
NzUgMjEgMzEgYzAKWyAgIDE2LjE0MjcyNF0gUlNQOiAwMDJiOjAwMDA3ZmZjZDBlZGVjODAgRUZM
QUdTOiAwMDAxMDIwMgpbICAgMTYuMTQ3OTQ4XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAw
MDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMDAwMDU1NWJkOApbICAgMTYuMTU1MDc0XSBSRFg6
IDAwMDAwMDAwZmZmZmZmZmYgUlNJOiAwMDAwN2ZmY2QwZWRlZmE4IFJESTogMDAwMDAwMDAwMDAw
MDAwMQpbICAgMTYuMTYyMTk4XSBSQlA6IDAwMDA3ZmZjZDBlZGVmYTggUjA4OiAwMDAwN2ZlMTY5
YmM1YTEwIFIwOTogMDAwMDdmZTE2OWYzN2ExMApbICAgMTYuMTY5MzE5XSBSMTA6IDAwMDA3ZmUx
NjlhZGYzZWUgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDdmZmNkMGVkZWZhOApbICAg
MTYuMTc2NDQ1XSBSMTM6IDAwMDAwMDAwMDA0MWI5YTAgUjE0OiAwMDAwMDAwMDAwNTU1YmQ4IFIx
NTogMDAwMDdmZTE2OWY2OTAwMApbICAgMTYuMTgzNTY5XSAgPC9UQVNLPgpbICAgMTYuMTg1NzUy
XSBNb2R1bGVzIGxpbmtlZCBpbjoKWyAgIDE2LjE4ODgwM10gQ1IyOiAwMDAwMDAwMDAwMDAwMDA4
ClsgICAxNi4xOTIxMTRdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo=
--000000000000cbe25205f2271b2e--
