Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E05EBFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiI0Kae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiI0Ka1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:30:27 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041532BB8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:30:23 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664274621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esqu8+UwsC7tgIwe7xnMAjuuZB/8PI4fbKpvYtEEQ68=;
        b=OfjHFS/6reWKrzmG4K1oA1YjIWYgJ9EcfhBvoeuzFtYJjWBxO5gPXhNP6Rk+zVuYEEJI3/
        apYhVEd8Dtf+SF1M9PC9bJRgo2CQVHVPBEZARemHlZx4hpUTmCuFEFDoGAYgCiIw5p2VjN
        cczepjOjnmKc1CUl5Nb/qyYb81erYdU=
Date:   Tue, 27 Sep 2022 10:30:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <59951c46c30608a0909632828102bce1@linux.dev>
Subject: Re: [PATCH] mm/early_ioremap: Combine two loops to improve
 performance
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <f06b9b34-bb74-4d15-88a6-b44de2adcc3a@csgroup.eu>
References: <f06b9b34-bb74-4d15-88a6-b44de2adcc3a@csgroup.eu>
 <20220927075239.270583-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

September 27, 2022 4:47 PM, "Christophe Leroy" <christophe.leroy@csgroup.=
eu> wrote:=0A=0A> Le 27/09/2022 =C3=A0 09:52, Yajun Deng a =C3=A9crit :=
=0A> =0A>> The first loop will waring once if prev_map is init, we can ad=
d a=0A>> boolean variable to do that. So those two loops can be combined =
to=0A>> improve performance.=0A> =0A> Do you have evidence of the improve=
d performance ?=0A> =0A> Looking at the generated code, I have the fealin=
g that the performance=0A> is reduced by the !init_prev_map that is check=
ed at every lap.=0A> =0A> Before the patch:=0A> =0A> 00000250 <early_iore=
map_setup>:=0A> 250: 3d 20 00 00 lis r9,0=0A> 252: R_PPC_ADDR16_HA .init.=
data=0A> 254: 39 29 00 00 addi r9,r9,0=0A> 256: R_PPC_ADDR16_LO .init.dat=
a=0A> 258: 38 e0 00 10 li r7,16=0A> 25c: 39 09 00 04 addi r8,r9,4=0A> 260=
: 39 40 00 00 li r10,0=0A> 264: 7c e9 03 a6 mtctr r7=0A> =0A> ---- First =
loop : ----=0A> 268: 55 47 10 3a rlwinm r7,r10,2,0,29=0A> 26c: 7c e7 40 2=
e lwzx r7,r7,r8=0A> 270: 2c 07 00 00 cmpwi r7,0=0A> 274: 41 a2 00 08 beq =
27c <early_ioremap_setup+0x2c>=0A> 278: 0f e0 00 00 twui r0,0=0A> 27c: 39=
 4a 00 01 addi r10,r10,1=0A> 280: 42 00 ff e8 bdnz 268 <early_ioremap_set=
up+0x18>=0A> =0A> 284: 39 00 00 10 li r8,16=0A> 288: 39 29 00 84 addi r9,=
r9,132=0A> 28c: 3d 40 ff b0 lis r10,-80=0A> 290: 7d 09 03 a6 mtctr r8=0A>=
 =0A> ---- Second loop : ----=0A> 294: 95 49 00 04 stwu r10,4(r9)=0A> 298=
: 3d 4a 00 04 addis r10,r10,4=0A> 29c: 42 00 ff f8 bdnz 294 <early_iorema=
p_setup+0x44>=0A> =0A> 2a0: 4e 80 00 20 blr=0A> =0A> After the patch:=0A>=
 =0A> 00000250 <early_ioremap_setup>:=0A> 250: 3d 20 00 00 lis r9,0=0A> 2=
52: R_PPC_ADDR16_HA .init.data=0A> 254: 39 29 00 00 addi r9,r9,0=0A> 256:=
 R_PPC_ADDR16_LO .init.data=0A> 258: 39 00 00 10 li r8,16=0A> 25c: 38 c9 =
00 04 addi r6,r9,4=0A> 260: 39 40 00 00 li r10,0=0A> 264: 39 29 00 88 add=
i r9,r9,136=0A> 268: 38 e0 00 00 li r7,0=0A> 26c: 7d 09 03 a6 mtctr r8=0A=
> =0A> --- Loop ---=0A> 270: 70 e8 00 01 andi. r8,r7,1=0A> 274: 40 82 00 =
18 bne 28c <early_ioremap_setup+0x3c>=0A> 278: 7d 0a 30 2e lwzx r8,r10,r6=
=0A> 27c: 2c 08 00 00 cmpwi r8,0=0A> 280: 41 a2 00 0c beq 28c <early_iore=
map_setup+0x3c>=0A> 284: 0f e0 00 00 twui r0,0=0A> 288: 38 e0 00 01 li r7=
,1=0A> 28c: 55 48 80 1e rlwinm r8,r10,16,0,15=0A> 290: 3d 08 ff b0 addis =
r8,r8,-80=0A> 294: 7d 0a 49 2e stwx r8,r10,r9=0A> 298: 39 4a 00 04 addi r=
10,r10,4=0A> 29c: 42 00 ff d4 bdnz 270 <early_ioremap_setup+0x20>=0A> =0A=
> 2a0: 4e 80 00 20 blr=0A> =0A=0AYes, I do it.=0A=0Atest1.c:=0A<=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>=0A#include <stdio.h>=0A=
#include <stdlib.h>=0A=0A#define FIX_BTMAPS_SLOTS 8=0A=0Astatic void *pre=
v_map[FIX_BTMAPS_SLOTS];=0Astatic unsigned long slot_virt[FIX_BTMAPS_SLOT=
S];=0A=0Aint main(void)=0A{=0A        int i;=0A=0A        for (i =3D 0; i=
 < FIX_BTMAPS_SLOTS; i++)=0A                if (prev_map[i]) {=0A        =
                printf("warning!\n");=0A                        break;=0A=
                }=0A=0A        for (i =3D 0; i < FIX_BTMAPS_SLOTS; i++)=
=0A                slot_virt[i] =3D FIX_BTMAPS_SLOTS * i;=0A=0A        re=
turn 0;=0A}=0A<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>=
=0A=0Atest2.c=0A=0A<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>=0A#include <stdio.h>=0A#include <stdlib.h>=0A#include <stdbool.h>=
=0A=0A#define FIX_BTMAPS_SLOTS 8=0A=0Astatic void *prev_map[FIX_BTMAPS_SL=
OTS];=0Astatic unsigned long slot_virt[FIX_BTMAPS_SLOTS];=0A=0Aint main(v=
oid)=0A{=0A        bool init_prev_map =3D false;=0A        int i;=0A=0A  =
      for (i =3D 0; i < FIX_BTMAPS_SLOTS; i++) {=0A                if (!i=
nit_prev_map && prev_map[i])=0A                        init_prev_map =3D =
true;=0A=0A                slot_virt[i] =3D FIX_BTMAPS_SLOTS * i;=0A     =
   }=0A=0A        return 0;=0A}=0A<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D>=0A=0A$ gcc test1.c -o test1  && gcc test2.c -o tes=
t2=0A<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>=0A=0A$ p=
erf stat ./test1   =0A=0A Performance counter stats for './test1':=0A=0A =
             0.17 msec task-clock:u              #    0.444 CPUs utilized=
          =0A                 0      context-switches:u        #    0.000=
 K/sec                  =0A                 0      cpu-migrations:u      =
    #    0.000 K/sec                  =0A                43      page-fau=
lts:u             #    0.246 M/sec                  =0A           154,813=
      cycles:u                  #    0.885 GHz                    =0A    =
       106,234      instructions:u            #    0.69  insn per cycle  =
       =0A            21,510      branches:u                #  122.990 M/=
sec                  =0A             1,409      branch-misses:u          =
 #    6.55% of all branches        =0A=0A       0.000393857 seconds time =
elapsed=0A=0A       0.000420000 seconds user=0A       0.000000000 seconds=
 sys=0A=0A=0A=0A$ perf stat ./test2=0A=0A Performance counter stats for '=
./test2':=0A=0A              0.17 msec task-clock:u              #    0.4=
39 CPUs utilized          =0A                 0      context-switches:u  =
      #    0.000 K/sec                  =0A                 0      cpu-mi=
grations:u          #    0.000 K/sec                  =0A                =
43      page-faults:u             #    0.249 M/sec                  =0A  =
         152,744      cycles:u                  #    0.884 GHz           =
         =0A           105,282      instructions:u            #    0.69  =
insn per cycle         =0A            21,342      branches:u             =
   #  123.545 M/sec                  =0A             1,334      branch-mi=
sses:u           #    6.25% of all branches        =0A=0A       0.0003930=
84 seconds time elapsed=0A=0A       0.000412000 seconds user=0A       0.0=
00000000 seconds sys=0A=0A<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D>=0AIt seems almost the same. If we change FIX_BTMAPS_SLOTS f=
rom 8 to 80000, =0AIt takes less time after the patch.=0A<=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>=0A=0A$ perf stat ./test1=0A=
=0A Performance counter stats for './test1':=0A=0A              0.73 msec=
 task-clock:u              #    0.768 CPUs utilized          =0A         =
        0      context-switches:u        #    0.000 K/sec                =
  =0A                 0      cpu-migrations:u          #    0.000 K/sec  =
                =0A               355      page-faults:u             #   =
 0.484 M/sec                  =0A         1,532,520      cycles:u        =
          #    2.087 GHz                    =0A         1,786,378      in=
structions:u            #    1.17  insn per cycle         =0A           2=
61,798      branches:u                #  356.594 M/sec                  =
=0A             1,580      branch-misses:u           #    0.60% of all br=
anches        =0A=0A       0.000956129 seconds time elapsed=0A=0A       0=
.000000000 seconds user=0A       0.000981000 seconds sys=0A=0A=0A$ perf s=
tat ./test2=0A=0A Performance counter stats for './test2':=0A=0A         =
     0.60 msec task-clock:u              #    0.732 CPUs utilized        =
  =0A                 0      context-switches:u        #    0.000 K/sec  =
                =0A                 0      cpu-migrations:u          #   =
 0.000 K/sec                  =0A               355      page-faults:u   =
          #    0.589 M/sec                  =0A         1,066,851      cy=
cles:u                  #    1.769 GHz                    =0A         1,8=
65,418      instructions:u            #    1.75  insn per cycle         =
=0A           261,630      branches:u                #  433.808 M/sec    =
              =0A             1,369      branch-misses:u           #    0=
.52% of all branches        =0A=0A       0.000824064 seconds time elapsed=
=0A=0A       0.000846000 seconds user=0A       0.000000000 seconds sys=0A=
=0A=0A=0A=0A=0A=0A> Maybe using WARN_ON_ONCE() could be the solution. But=
 looking at the=0A> code generated if using it, I still have the feeling =
that GCC has a=0A> better code with the original code.=0A> =0A>> Signed-o=
ff-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>> mm/early_ioremap.c=
 | 9 +++++----=0A>> 1 file changed, 5 insertions(+), 4 deletions(-)=0A>> =
=0A>> diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c=0A>> index 9bc=
12e526ed0..3076fb47c685 100644=0A>> --- a/mm/early_ioremap.c=0A>> +++ b/m=
m/early_ioremap.c=0A>> @@ -70,14 +70,15 @@ static unsigned long slot_virt=
[FIX_BTMAPS_SLOTS] __initdata;=0A>> =0A>> void __init early_ioremap_setup=
(void)=0A>> {=0A>> + bool init_prev_map =3D false;=0A>> int i;=0A>> =0A>>=
 - for (i =3D 0; i < FIX_BTMAPS_SLOTS; i++)=0A>> - if (WARN_ON(prev_map[i=
]))=0A>> - break;=0A>> + for (i =3D 0; i < FIX_BTMAPS_SLOTS; i++) {=0A>> =
+ if (!init_prev_map && WARN_ON(prev_map[i]))=0A>> + init_prev_map =3D tr=
ue;=0A>> =0A>> - for (i =3D 0; i < FIX_BTMAPS_SLOTS; i++)=0A>> slot_virt[=
i] =3D __fix_to_virt(FIX_BTMAP_BEGIN - NR_FIX_BTMAPS*i);=0A>> + }=0A>> }=
=0A>> =0A>> static int __init check_early_ioremap_leak(void)
