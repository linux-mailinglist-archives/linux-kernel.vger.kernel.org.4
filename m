Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24B074955B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjGFGJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjGFGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:09:31 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2031BFC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:08:36 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-47e655e9a9aso106825e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688623713; x=1691215713;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doo7kCKfYk1JgvOlCvyucqyNgrNQ1nxYBU2jybx/DOs=;
        b=Ac05jFv9m3ZF7xsdd7GbFxj750YodX+64Md6wbEtO728d51SlPMO4MSh52UP7RCmzn
         hnbk83543daTfB+VMQehCASRk3MS0jE+GOFSjHOqWXq+69Zntf1XYAxnQaEyMblP7oOE
         BiR4EBXuB1C0CSqCpj9GI89aM42Xem4BPmMo8HysTtqjjuhmaK1/7OKrR1nlsb9H1SJR
         7xlch4SJmvA6bSpwIzYUU8WbrAaGc4XAs0EmKaDYAvxo2RUs5LN8hEGxPLZv0sKGWHKG
         PLohZPp/54CW1JhbZ/i2DgObE59C+vO/hWfwDuqfbrOaz49d+66vY8KJdguA5O8KS3Wz
         yuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623713; x=1691215713;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doo7kCKfYk1JgvOlCvyucqyNgrNQ1nxYBU2jybx/DOs=;
        b=JLdCduHJhw7UC0wfA63czdPs1c33+YIa5BiGIfFOflS8UeAhm9r/I4z7HeP1bKlR2b
         gNn0oDOWsc3XtE2l5V5n4LWuhD8+TDDBHKgjynZFmpf9EfUZu6nVn+AhMzG/HAykYuyj
         sIzXqKHNDlmseU5MvD7Cw1Q1CWdyBXhrcZ8DHlIehwc6hjnpsY3nJr6UFoUHmNNpU0A1
         05CrN+QNbBWpUFD57CBM/XD8TuEnFP/WSQZRt49BnXBuyDx+8kEDmFmtXXOa+WFu2vVK
         zLolanui9YnTbBx0kKcoGiBbhiTkqSf08Ke8vWaCCBTmZzeHc0IvnsOrXnTF+zZOlAqf
         zPlQ==
X-Gm-Message-State: ABy/qLaRgXml5pE9dkDBwxGocq2A01Dyh0UgEurCPuNEy3kGelap0slJ
        7SsBL/G+VpOaI7sW8NaEI0kCyR32TF9U6GIsHVIQqAGdPWFuEA==
X-Google-Smtp-Source: APBJJlG2aIr+qlPvVB0F9xQM8S0Zibdvuyp6avz4hew6Ch6HU0M1OkogT1vzal+gtp2nR0cGxyznLomfkjZ8o55im3o=
X-Received: by 2002:a1f:bf4e:0:b0:47e:1105:1f5e with SMTP id
 p75-20020a1fbf4e000000b0047e11051f5emr689734vkf.1.1688623713559; Wed, 05 Jul
 2023 23:08:33 -0700 (PDT)
MIME-Version: 1.0
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Thu, 6 Jul 2023 14:08:20 +0800
Message-ID: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
Subject: Possible race in rt_mutex_adjust_prio_chain
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org
Content-Type: multipart/mixed; boundary="0000000000009b445605ffcb5896"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009b445605ffcb5896
Content-Type: text/plain; charset="UTF-8"

Hi,

I found that it's not safe to change waiter->prio after waiter
dequeued from mutex's waiter rbtree because it's still on owner's
pi_waiters rbtree. From my analysis, waiters on pi_waiters rbtree
should be protected by pi_lock of task which have pi_waiters and
corresponding rt_mutex's wait_lock, but pi_waiters is shared by many
locks owned by this task, so actually we serialize changes on
pi_waiters only by pi_lock.

`rt_mutex_adjust_prio_chain' changes key of nodes of pi_waiters rbtree
without pi_lock and pi_waiters rbtree's invariant is violated. Maybe
we are enqueuing waiter on other cpu and pi_waiters rbtree will be
corrupted.

I attach a source file which can trigger this violation. I tested it
on Ubuntu 20.04 LTS with 5.4 kernel.

$ sudo ./a.out
pid: 39949
prio: 39
    PID     LWP TTY          TIME CMD
  39949   39949 pts/1    00:00:00 a.out
  39949   39950 pts/1    00:00:00 waiter-0
  39949   39951 pts/1    00:00:00 waiter-1
.............
prio: 20
prio: 20
prio: 20
prio: 20
prio: 20
prio: 20
prio: 20
.............
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
prio: 21
    PID     LWP TTY          TIME CMD
  39949   39949 pts/1    00:00:00 a.out
  39949   39950 pts/1    00:00:00 waiter-0
  39949   39951 pts/1    00:00:00 waiter-1
  39949   39952 pts/1    00:00:00 waiter-2
  39949   39953 pts/1    00:00:00 waiter-3
  39949   39954 pts/1    00:00:00 waiter-4
  39949   39955 pts/1    00:00:00 waiter-5
  39949   39956 pts/1    00:00:00 waiter-6
  39949   39957 pts/1    00:00:00 waiter-7
  39949   39958 pts/1    00:00:00 waiter-8
  39949   39959 pts/1    00:00:00 waiter-9
  39949   39960 pts/1    00:00:00 waiter-10
  39949   39961 pts/1    00:00:00 waiter-11
  39949   39962 pts/1    00:00:00 waiter-12
  39949   39963 pts/1    00:00:00 waiter-13
  39949   39964 pts/1    00:00:00 waiter-14
  39949   39965 pts/1    00:00:00 waiter-15
  39949   39966 pts/1    00:00:00 waiter-16
  39949   39967 pts/1    00:00:00 waiter-17
  39949   39968 pts/1    00:00:00 waiter-18
  39949   39969 pts/1    00:00:00 changer-0
  39949   39970 pts/1    00:00:00 changer-1
  39949   39971 pts/1    00:00:00 changer-2
  39949   39972 pts/1    00:00:00 changer-3
  39949   39973 pts/1    00:00:00 changer-4
  39949   39974 pts/1    00:00:00 changer-5
  39949   39975 pts/1    00:00:00 changer-6
  39949   39976 pts/1    00:00:00 changer-7
  39949   39977 pts/1    00:00:00 changer-8
  39949   39978 pts/1    00:00:00 changer-9
  39949   39979 pts/1    00:00:00 changer-10
  39949   39980 pts/1    00:00:00 changer-11
  39949   39981 pts/1    00:00:00 changer-12
  39949   39982 pts/1    00:00:00 changer-13
  39949   39983 pts/1    00:00:00 changer-14
  39949   39984 pts/1    00:00:00 changer-15
  39949   39985 pts/1    00:00:00 changer-16
  39949   39986 pts/1    00:00:00 changer-17
  39949   39987 pts/1    00:00:00 changer-18
found race, hang...

$ crash
crash> task -R prio,normal_prio,pi_waiters 39949
PID: 39949  TASK: ffff956a5c8b2f00  CPU: 2   COMMAND: "a.out"
  prio = 121,
  normal_prio = 139,
  pi_waiters = {
    rb_root = {
      rb_node = 0xffffb24941f43d40
    },
    rb_leftmost = 0xffffb24941f8bd40
  },

crash> print (struct rb_node *)0xffffb24941f43d40
$62 = (struct rb_node *) 0xffffb24941f43d40
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$63 = {
  tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0x0
  },
  pi_tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0xffffb24941f13d40,
    rb_left = 0xffffb24941f4bd40
  },
  task = 0xffff956a6c008000,
  lock = 0xffff956920b80970,
  prio = 130,
  deadline = 0
}
crash> print $62->rb_left
$64 = (struct rb_node *) 0xffffb24941f4bd40
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$65 = {
  tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0x0
  },
  pi_tree_entry = {
    __rb_parent_color = 18446658626441723201,
    rb_right = 0xffffb24941f63d40,
    rb_left = 0xffffb24941f5bd40
  },
  task = 0xffff956a594baf00,
  lock = 0xffff956920b80190,
  prio = 126,
  deadline = 0
}
crash> print $62->rb_left->rb_left
$66 = (struct rb_node *) 0xffffb24941f5bd40
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$67 = {
  tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0x0
  },
  pi_tree_entry = {
    __rb_parent_color = 18446658626441755968,
    rb_right = 0xffffb24941f73d40,
    rb_left = 0xffffb24941f2bd40
  },
  task = 0xffff956a64edaf00,
  lock = 0xffff956a8d481670,
  prio = 123,
  deadline = 0
}
crash> print $62->rb_left->rb_left->rb_left
$68 = (struct rb_node *) 0xffffb24941f2bd40
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$69 = {
  tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0x0
  },
  pi_tree_entry = {
    __rb_parent_color = 18446658626441821505,
    rb_right = 0xffffb24940e47d40,
    rb_left = 0xffffb24941f8bd40
  },
  task = 0xffff956a62ae0000,
  lock = 0xffff956a76c5c250,
  prio = 120,
  deadline = 0
}
crash> print $62->rb_left->rb_left->rb_left->rb_left
$70 = (struct rb_node *) 0xffffb24941f8bd40
crash> print *(struct rt_mutex_waiter *)((void *)$ - 24)
$71 = {
  tree_entry = {
    __rb_parent_color = 1,
    rb_right = 0x0,
    rb_left = 0x0
  },
  pi_tree_entry = {
    __rb_parent_color = 18446658626441624896,
    rb_right = 0x0,
    rb_left = 0x0
  },
  task = 0xffff956a597dc680,
  lock = 0xffff956920b802b0,
  prio = 121,
  deadline = 0
}
crash>

From the last two rt_mutex_waiter we see that leftmost waiter's prio
is 121 but it's parent is 120.

Sorry for the inconvenience if I made a mistake. Thanks!

Henry

--0000000000009b445605ffcb5896
Content-Type: text/x-csrc; charset="US-ASCII"; name="pi.c"
Content-Disposition: attachment; filename="pi.c"
Content-Transfer-Encoding: base64
Content-ID: <f_ljqqr66v0>
X-Attachment-Id: f_ljqqr66v0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Rk
aW50Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxl
cnJuby5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KCiNkZWZpbmUgUENPVU5UIDE5CgovLyBD
b3BpZWQgZnJvbSByZWxhdGVkIGhlYWRlci4Kc3RydWN0IHNjaGVkX2F0dHIgewoJdWludDMyX3Qg
c2l6ZTsKCgl1aW50MzJfdCBzY2hlZF9wb2xpY3k7Cgl1aW50NjRfdCBzY2hlZF9mbGFnczsKCgkv
KiBTQ0hFRF9OT1JNQUwsIFNDSEVEX0JBVENIICovCglpbnQzMl90IHNjaGVkX25pY2U7CgoJLyog
U0NIRURfRklGTywgU0NIRURfUlIgKi8KCXVpbnQzMl90IHNjaGVkX3ByaW9yaXR5OwoKCS8qIFND
SEVEX0RFQURMSU5FICovCgl1aW50NjRfdCBzY2hlZF9ydW50aW1lOwoJdWludDY0X3Qgc2NoZWRf
ZGVhZGxpbmU7Cgl1aW50NjRfdCBzY2hlZF9wZXJpb2Q7CgoJLyogVXRpbGl6YXRpb24gaGludHMg
Ki8KCXVpbnQzMl90IHNjaGVkX3V0aWxfbWluOwoJdWludDMyX3Qgc2NoZWRfdXRpbF9tYXg7Cn07
CgpzdGF0aWMgcHRocmVhZF9tdXRleF90IG11dGV4ZXNbUENPVU5UXTsKCnN0YXRpYyB2b2lkIGlu
aXRfbXV0ZXgocHRocmVhZF9tdXRleF90ICptdXRleCkgewoJcHRocmVhZF9tdXRleGF0dHJfdCBh
dHRyOwoJaW50IHJldDsKCglyZXQgPSBwdGhyZWFkX211dGV4YXR0cl9pbml0KCZhdHRyKTsKCWFz
c2VydCghcmV0KTsKCXJldCA9IHB0aHJlYWRfbXV0ZXhhdHRyX3NldHByb3RvY29sKCZhdHRyLCBQ
VEhSRUFEX1BSSU9fSU5IRVJJVCk7Cglhc3NlcnQoIXJldCk7CgoJcmV0ID0gcHRocmVhZF9tdXRl
eF9pbml0KG11dGV4LCAmYXR0cik7Cglhc3NlcnQoIXJldCk7CgoJcHRocmVhZF9tdXRleGF0dHJf
ZGVzdHJveSgmYXR0cik7Cn0KCmVudW0gdGhyZWFkX3R5cGUgewoJV0FJVEVSLAoJUFJJT19DSEFO
R0VSLAp9OwoKc3RhdGljIHN0cnVjdCB0aHJlYWRfc3BlYyB7CgllbnVtIHRocmVhZF90eXBlIHR5
cGU7CglpbnQgbmFtZV9pbmRleDsKCWludCBuaWNlOwoJcHRocmVhZF9iYXJyaWVyX3QgKmJhcnJp
ZXI7CgoJLy8gVXNlZCBieSB3YWl0ZXIuCglwdGhyZWFkX211dGV4X3QgKndhaXRfbXV0ZXg7Cglw
aWRfdCBwaWRfc2F2ZTsKCQoJLy8gVXNlZCBieSBwcmlvIGNoYW5nZXIuCglwaWRfdCAqd2FpdGVy
X3BpZDsKfSB0aHJlYWRfc3BlY3NbUENPVU5UICogMl07CgpzdGF0aWMgcHRocmVhZF90IHRocmVh
ZHNbUENPVU5UICogMl07CnN0YXRpYyBpbnQgdGhyZWFkX2NvdW50ID0gMDsKCnN0YXRpYyBpbnQg
YmFycmllcl93YWl0KHB0aHJlYWRfYmFycmllcl90ICpiYXJyaWVyKSB7CglpZiAoIWJhcnJpZXIp
IHsKCQlyZXR1cm4gMDsKCX0KCglpbnQgcmV0ID0gcHRocmVhZF9iYXJyaWVyX3dhaXQoYmFycmll
cik7Cglhc3NlcnQoIXJldCB8fCByZXQgPT0gUFRIUkVBRF9CQVJSSUVSX1NFUklBTF9USFJFQUQp
OwoKCXJldHVybiByZXQ7Cn0KCnN0YXRpYyBpbnQgc2NoZWRfZ2V0YXR0cihwaWRfdCBwaWQsIHN0
cnVjdCBzY2hlZF9hdHRyICphdHRyLCBpbnQgZmxhZ3MpIHsKCXJldHVybiBzeXNjYWxsKFNZU19z
Y2hlZF9nZXRhdHRyLCBwaWQsIGF0dHIsIHNpemVvZigqYXR0ciksIGZsYWdzKTsKfQoKc3RhdGlj
IGludCBzY2hlZF9zZXRhdHRyKHBpZF90IHBpZCwgc3RydWN0IHNjaGVkX2F0dHIgKmF0dHIsIGlu
dCBmbGFncykgewoJcmV0dXJuIHN5c2NhbGwoU1lTX3NjaGVkX3NldGF0dHIsIHBpZCwgYXR0ciwg
ZmxhZ3MpOwp9CgpzdGF0aWMgdm9pZCAqcHJpb19jaGFuZ2VfbG9vcChzdHJ1Y3QgdGhyZWFkX3Nw
ZWMgKnNwZWMpIHsKCXN0cnVjdCBzY2hlZF9hdHRyIGF0dHI7CglpbnQgcmV0OwoKCWZvciAoOzsp
IHsKCQliYXJyaWVyX3dhaXQoc3BlYy0+YmFycmllcik7CgoJCXJldCA9IHNjaGVkX2dldGF0dHIo
KnNwZWMtPndhaXRlcl9waWQsICZhdHRyLCAwKTsKCQlpZiAocmV0IDwgMCkgewoJCQlwZXJyb3Io
InNjaGVkX2dldGF0dHIiKTsKCQkJYXNzZXJ0KDApOwoJCX0KCQkKCQlhdHRyLnNjaGVkX25pY2Ug
PSBzcGVjLT5uaWNlOwoJCgkJcmV0ID0gc2NoZWRfc2V0YXR0cigqc3BlYy0+d2FpdGVyX3BpZCwg
JmF0dHIsIDApOwoJCWlmIChyZXQgPCAwKSB7CgkJCXBlcnJvcigic2NoZWRfc2V0YXR0ciIpOwoJ
CQlleGl0KDEpOwoJCX0KCgkJYmFycmllcl93YWl0KHNwZWMtPmJhcnJpZXIpOwoJfQp9CgpzdGF0
aWMgdm9pZCAqdGhyZWFkKHZvaWQgKmFyZykgewoJc3RydWN0IHRocmVhZF9zcGVjICpzcGVjID0g
YXJnOwoJY2hhciBuYW1lWzY0XTsKCWludCByZXQ7CgkKCXNucHJpbnRmKG5hbWUsIHNpemVvZihu
YW1lKSwgIiVzLSVkIiwgCgkJCXNwZWMtPnR5cGUgPT0gV0FJVEVSID8gIndhaXRlciIgOiAiY2hh
bmdlciIsIAoJCQlzcGVjLT5uYW1lX2luZGV4KTsKCXJldCA9IHB0aHJlYWRfc2V0bmFtZV9ucChw
dGhyZWFkX3NlbGYoKSwgbmFtZSk7Cglhc3NlcnQoIXJldCk7CgoJc3dpdGNoIChzcGVjLT50eXBl
KSB7CgljYXNlIFdBSVRFUjoKCQlzcGVjLT5waWRfc2F2ZSA9IGdldHRpZCgpOwoKCQliYXJyaWVy
X3dhaXQoc3BlYy0+YmFycmllcik7CgoJCXJldCA9IG5pY2Uoc3BlYy0+bmljZSk7CgkJYXNzZXJ0
KHJldCA+PSAwKTsKCgkJcmV0ID0gcHRocmVhZF9tdXRleF9sb2NrKHNwZWMtPndhaXRfbXV0ZXgp
OwoJCWFzc2VydCghcmV0KTsKCQlicmVhazsKCWNhc2UgUFJJT19DSEFOR0VSOgoJCXByaW9fY2hh
bmdlX2xvb3Aoc3BlYyk7CgkJYnJlYWs7CglkZWZhdWx0OgoJCWFzc2VydCgwKTsKCQlicmVhazsK
CX0KCglyZXR1cm4gTlVMTDsKfQoKc3RhdGljIHZvaWQgY3JlYXRlX3RocmVhZChzdHJ1Y3QgdGhy
ZWFkX3NwZWMgKnNwZWMpIHsKCWludCByZXQ7CgoJcmV0ID0gcHRocmVhZF9jcmVhdGUoJnRocmVh
ZHNbdGhyZWFkX2NvdW50KytdLCBOVUxMLCB0aHJlYWQsIHNwZWMpOwoJYXNzZXJ0KCFyZXQpOwp9
CgpzdGF0aWMgaW50IHByaW50X3ByaW8oKSB7CglGSUxFICpmaWxlID0gZm9wZW4oIi9wcm9jL3Nl
bGYvc3RhdCIsICJyIik7Cglhc3NlcnQoZmlsZSk7CgoJY2hhciBjb21tWzY0XTsKCWludCB0bXAs
IHByaW8sIHJldDsKCXJldCA9IGZzY2FuZihmaWxlLCAiJWQgJXMgJWMgJWQgJWQgJWQgJWQgJWQg
JWQgJWQgJWQgJWQgJWQgJWQgJWQgJWQgJWQgJWQiLAoJCQkmdG1wLCBjb21tLCBjb21tLCAmdG1w
LCAmdG1wLCAmdG1wLCAmdG1wLCAmdG1wLCAmdG1wLAoJCQkmdG1wLCAmdG1wLCAmdG1wLCAmdG1w
LCAmdG1wLCAmdG1wLCAmdG1wLCAmdG1wLCAmcHJpbyk7Cglhc3NlcnQocmV0ID09IDE4KTsKCglw
cmludGYoInByaW86ICVkXG4iLCBwcmlvKTsKCglmY2xvc2UoZmlsZSk7CgoJcmV0dXJuIHByaW87
Cn0KCnN0YXRpYyB2b2lkIHByaW50X3RocmVhZHMocGlkX3QgcHJvY2Vzc19waWQpIHsKCWNoYXIg
Y21kWzEyOF07CglzbnByaW50ZihjbWQsIHNpemVvZihjbWQpLCAicHMgLUwgLXAgJWQiLCBwcm9j
ZXNzX3BpZCk7CglzeXN0ZW0oY21kKTsKfQoKaW50IG1haW4odm9pZCkgewoJcGlkX3QgcGlkOwoJ
aW50IHJldDsKCglwaWQgPSBnZXRwaWQoKTsKCXByaW50ZigicGlkOiAlZFxuIiwgcGlkKTsKCglm
b3IgKGludCBpID0gMDsgaSA8IHNpemVvZihtdXRleGVzKSAvIHNpemVvZihtdXRleGVzWzBdKTsg
KytpKSB7CgkJaW5pdF9tdXRleCgmbXV0ZXhlc1tpXSk7CgkJcmV0ID0gcHRocmVhZF9tdXRleF9s
b2NrKCZtdXRleGVzW2ldKTsKCQlhc3NlcnQoIXJldCk7Cgl9CgoJcHRocmVhZF9iYXJyaWVyX3Qg
YmFycmllcjsKCXJldCA9IHB0aHJlYWRfYmFycmllcl9pbml0KCZiYXJyaWVyLCBOVUxMLCBQQ09V
TlQgKyAxKTsKCWFzc2VydCghcmV0KTsKCglmb3IgKGludCBpID0gMDsgaSA8IFBDT1VOVDsgKytp
KSB7CgkJc3RydWN0IHRocmVhZF9zcGVjICpzcGVjID0gJnRocmVhZF9zcGVjc1tpXTsKCQkKCQlz
cGVjLT50eXBlID0gV0FJVEVSOwoJCXNwZWMtPm5hbWVfaW5kZXggPSBpOwoJCXNwZWMtPm5pY2Ug
PSAxODsKCQlzcGVjLT53YWl0X211dGV4ID0gJm11dGV4ZXNbaV07CgkJc3BlYy0+YmFycmllciA9
ICZiYXJyaWVyOwoKCQljcmVhdGVfdGhyZWFkKHNwZWMpOwoJfQoKCS8vIFdhaXQgZm9yIGZpbGxp
bmcgb2YgcGlkX3NhdmUuCgliYXJyaWVyX3dhaXQoJmJhcnJpZXIpOwoKCWZvciAoaW50IGkgPSAw
OyBpIDwgUENPVU5UOyArK2kpIHsKCQlzdHJ1Y3QgdGhyZWFkX3NwZWMgKnNwZWMgPSAmdGhyZWFk
X3NwZWNzW2kgKyAxOV07CgoJCXNwZWMtPnR5cGUgPSBQUklPX0NIQU5HRVI7IAoJCXNwZWMtPm5h
bWVfaW5kZXggPSBpOwoJCXNwZWMtPm5pY2UgPSAwOwoJCXNwZWMtPmJhcnJpZXIgPSAmYmFycmll
cjsKCQlzcGVjLT53YWl0ZXJfcGlkID0gJnRocmVhZF9zcGVjc1tpXS5waWRfc2F2ZTsKCgkJY3Jl
YXRlX3RocmVhZChzcGVjKTsKCX0KCgluaWNlKDE5KTsKCglwcmludF9wcmlvKCk7CglwcmludF90
aHJlYWRzKHBpZCk7CgoJLy9zbGVlcCg2MCk7CgkvL3ByaW50ZigibGF1bmNoIVxuIik7CgoJc3Jh
bmRvbSh0aW1lKE5VTEwpKTsKCWludCBpdGVyID0gMDsKCWZvciAoOzspIHsKCQkrK2l0ZXI7CgkJ
Zm9yIChpbnQgaSA9IDA7IGkgPCBQQ09VTlQ7ICsraSkgewoJCQl0aHJlYWRfc3BlY3NbaSArIDE5
XS5uaWNlID0gKGl0ZXIgJSAyKSA/IGkgOiAxOCAtIGk7CgkJfQoKCQlmb3IgKGludCBpID0gMDsg
aSA8IFBDT1VOVDsgKytpKSB7CgkJCWludCBwb3MgPSByYW5kb20oKSAlIFBDT1VOVDsKCQkJaW50
IHRtcCA9IHRocmVhZF9zcGVjc1twb3MgKyAxOV0ubmljZTsKCQkJdGhyZWFkX3NwZWNzW3BvcyAr
IDE5XS5uaWNlID0gdGhyZWFkX3NwZWNzWzE5XS5uaWNlOwoJCQl0aHJlYWRfc3BlY3NbMTldLm5p
Y2UgPSB0bXA7CgkJfQoKCQliYXJyaWVyX3dhaXQoJmJhcnJpZXIpOwoJCWJhcnJpZXJfd2FpdCgm
YmFycmllcik7CgoJCS8vc3lzdGVtKCJlY2hvIGl0ZXJhdGlvbiA+IC9zeXMva2VybmVsL2RlYnVn
L3RyYWNpbmcvdHJhY2VfbWFya2VyIik7CgoJCWludCBwcmlvLCB1bmV4cGVjdGVkX3RpbWVzID0g
MDsKCQlkbyB7CgkJCXByaW8gPSBwcmludF9wcmlvKCk7CgkJCWlmIChwcmlvICE9IDIwKSB7CgkJ
CQkrK3VuZXhwZWN0ZWRfdGltZXM7CgkJCQlpZiAodW5leHBlY3RlZF90aW1lcyA+IDEwKSB7CgkJ
CQkJcHJpbnRfdGhyZWFkcyhwaWQpOwoJCQkJCXByaW50ZigiZm91bmQgcmFjZSwgaGFuZy4uLlxu
Iik7CgkJCQkJd2hpbGUgKDEpIHsKCQkJCQkJc2xlZXAoMzYwMCk7CgkJCQkJfQoJCQkJfQoJCQl9
CgkJfSB3aGlsZSAocHJpbyAhPSAyMCk7Cgl9CgoJZm9yIChpbnQgaSA9IDA7IGkgPCB0aHJlYWRf
Y291bnQ7ICsraSkgewoJCXB0aHJlYWRfam9pbih0aHJlYWRzW2ldLCBOVUxMKTsKCX0KCglyZXR1
cm4gMDsKfQoK
--0000000000009b445605ffcb5896--
