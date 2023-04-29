Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBED46F26A2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjD2VsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:48:22 -0400
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1910F1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:48:21 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682804899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeEJr4NqU/Ww/AxE6IB8tbd9JvoM0OEBTeBY+6h2h0s=;
        b=cIE/xFyH3GJrLkVkx5RnJe2vOFyel94XhEc9lUhaIf7PJN9h3peroK0zGl9BTNAD2TKGIc
        B00+gc5LOTSJQ3NoBaCC8k+pcDWN9NauhzyA5addWdvIzktlBgpdGmKVS6MJ/80Hwn91MI
        I1DQ8/fcVXxz+j29r1InLnO34Rgg9OQ=
Date:   Sat, 29 Apr 2023 21:48:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <5fe1484b4f2b4ae960a9b599c4ab3ace@linux.dev>
Subject: Re: [PATCH] RISC-V: fixup in-flight collision with
 ARCH_WANT_OPTIMIZE_VMEMMAP rename
To:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Conor Dooley" <conor@kernel.org>
Cc:     "Conor Dooley" <conor.dooley@microchip.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
In-Reply-To: <mhng-b5a20207-95a2-4607-9e6c-52396d569d91@palmer-ri-x1c9a>
References: <mhng-b5a20207-95a2-4607-9e6c-52396d569d91@palmer-ri-x1c9a>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 29, 2023 4:17 PM, "Palmer Dabbelt" <palmer@dabbelt.com> wrote:=0A>>=
> I guess you picking this up for your second PR makes the most sense=0A>=
>> Palmer?=0A> =0A> Yep, except it crashes b4=0A> =0A> $ b4 shazam -lts h=
ttps://lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d62d@spud=0A> G=
rabbing thread from lore.kernel.org/all/20230429-trilogy-jolly-12bf5c53d6=
2d%40spud/t.mbox.gz=0A> Analyzing 2 messages in the thread=0A> Checking a=
ttestation on all messages, may take a moment...=0A> Traceback (most rece=
nt call last):=0A> File "/home/palmer/.local/src/b4/b4/command.py", line =
383, in <module>=0A> cmd()=0A> File "/home/palmer/.local/src/b4/b4/comman=
d.py", line 366, in cmd=0A> cmdargs.func(cmdargs)=0A> File "/home/palmer/=
.local/src/b4/b4/command.py", line 100, in cmd_shazam=0A> b4.mbox.main(cm=
dargs)=0A> File "/home/palmer/.local/src/b4/b4/mbox.py", line 713, in mai=
n=0A> make_am(msgs, cmdargs, msgid)=0A> File "/home/palmer/.local/src/b4/=
b4/mbox.py", line 101, in make_am=0A> am_msgs =3D lser.get_am_ready(noadd=
trailers=3Dcmdargs.noaddtrailers,=0A> File "/home/palmer/.local/src/b4/b4=
/__init__.py", line 552, in get_am_ready=0A> checkmark, trailers, attcrit=
 =3D lmsg.get_attestation_trailers(attpolicy, maxdays)=0A> File "/home/pa=
lmer/.local/src/b4/b4/__init__.py", line 1319, in get_attestation_trailer=
s=0A> for attestor in self.attestors:=0A> File "/home/palmer/.local/src/b=
4/b4/__init__.py", line 1158, in attestors=0A> self._load_patatt_attestor=
s()=0A> File "/home/palmer/.local/src/b4/b4/__init__.py", line 1261, in _=
load_patatt_attestors=0A> patatt_config =3D patatt.get_config_from_git(r'=
patatt\..*', multivals=3D['keyringsrc'])=0A> AttributeError: module 'pata=
tt' has no attribute 'get_config_from_git'=0A> =0A> So I probably need to=
 just go update my setup, I've got a bunch of wacky stuff.=0A> I'll try a=
nd remember to do so, but I'm going to scrub through other bits=0A> first=
...=0A=0AIndeed, you have a newer version of b4 without also updating the=
 patatt dependency. If you're using b4 from git, you need to "git submodu=
le update".=0A=0ARegards,=0A-K
