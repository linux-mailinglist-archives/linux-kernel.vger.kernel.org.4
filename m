Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505C61374C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiJaNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJaNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:02:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3929FD33
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:02:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o12so19104767lfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLVcoqpda9WXLbTxvt1aLp1xf9f2vRmXolzmjthgV6M=;
        b=O8+99K5CFVmy1gN0OapG7xawCWdpZPA060WuGuN4CQk5sHF3YOMU4oU9FieQaCYPUI
         jTh+/nr49U0cykj7m3+8rq5OoIOM8gpFSJG1Vucz7SJXi61jM3ca9zD7IH6U0GiMa3mo
         4jUi1OBXGmXlm6UEe/lQgt6gvKo9h+gqkvl6fmEY8za51i6jAHbhqlMdvb5AAexqsAMr
         3qPWPh/CNTbqw1z1SLvT8W5YOVYTV/VSsL/RAXYfeYmh85PY2Mi3z+juZ8t3NwoVrXre
         4w7S2+fjSSos79rTXcEMcDvFscmp1d3dt2/xmnlsZHf7uL2NptOc/NBjHoFl0/Q5k1BS
         8f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLVcoqpda9WXLbTxvt1aLp1xf9f2vRmXolzmjthgV6M=;
        b=BbeKafqkpdGbrRKhDTlrTp6fehT9e1/ltPmd0Bi/azKCK0bqXFamzy3KmrlvD8L2oC
         3spPoib3NT2eX6MlxOvu7knmxJ5QOIc4R+WnWgIjJIbrpcb4Fb71HxUkU4/K85oh4X3H
         sdmWjejcdt4E9hnxtLmhLh8qxntBVfLp1iswaZVB8WUWctPUPfUViYFihA7UeMCL2AyE
         Nn9GDTDPGULDwbfEe5bIb34cDMUzOqikBMtCQElPlInNKxsVxq3NiIRcw1lrKXyMdxUl
         0MC8exWV96PxYNpvuU52EDDm7F9pYOvGL0EOKCSDd3NE4majByImO1YyryVT5t1v4WCf
         +0Jw==
X-Gm-Message-State: ACrzQf1MBnaKRxJEDOI+vNz0daaE+6X9cnt32tdHItZrAEcYHDbg8yKh
        nplUwSFIA1O0GoVKQMiSXuhu8uAPd1/yRI0/CsIBJofOI90=
X-Google-Smtp-Source: AMsMyM4PSfvTbLUYHkehhaHlLNgmT4fgbvkC2nHgo1BGTk8Ds+FEuThlMqWk1VOARYPZ5ARQ4DqjHvvezBFFIFoUVJ8=
X-Received: by 2002:a05:6512:33d1:b0:4a2:119e:1887 with SMTP id
 d17-20020a05651233d100b004a2119e1887mr5154509lfg.85.1667221343812; Mon, 31
 Oct 2022 06:02:23 -0700 (PDT)
MIME-Version: 1.0
From:   Roland Ruckerbauer <roland.rucky@gmail.com>
Date:   Mon, 31 Oct 2022 14:02:12 +0100
Message-ID: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
Subject: [BUG] NULL pointer dereference probably caused by kernel/trace/ring_buffer.c
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f5e1c805ec54372b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f5e1c805ec54372b
Content-Type: text/plain; charset="UTF-8"

Somewhere between kernel 6.0.2 and 6.0.5 I started getting crashes
when https://github.com/mchehab/rasdaemon is starting.

After investigating a bit, I found the following commits:
a6b4d8d6656f ring-buffer: Fix race between reset page and reading page
fa76ee6fea9c ring-buffer: Add ring_buffer_wake_waiters()
7bf3c4d84204 ring-buffer: Check pending waiters when doing wake ups as well
692cc072c800 ring-buffer: Have the shortest_full queue be the shortest
not longest
57af2334ca70 ring-buffer: Allow splice to read previous partially read pages

I guess one of them must have broken something rasdaemon is using,
since the crash is in ring_buffer_wake_waiters(), and it was first
introduced by this commit series.

The crash report is attached in dmesg.log.

For me the crash is easily reproducible. For testing I run 6.0.5
upstream kernel, but I guess everything since 6.0.3 is affected as
well.

My hardware (hopefully irrelevant): x570 amd platform (ryzen 5000)

If I can help in any way, please say so (testing patches etc ...).

Thanks,
Roland Ruckerbauer

--000000000000f5e1c805ec54372b
Content-Type: text/x-log; charset="US-ASCII"; name="dmesg.log"
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64
Content-ID: <f_l9ws76210>
X-Attachment-Id: f_l9ws76210

QlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAw
MDAwMWM4CiNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKI1BGOiBl
cnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdlClBHRCAwIFA0RCAwIApPb3BzOiAw
MDAyIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkKQ1BVOiAxOSBQSUQ6IDY4MyBDb21tOiByYXNkYWVt
b24gTm90IHRhaW50ZWQgNi4wLjUtYXJjaDEtMSAjMSAwMGQyMTUyYWFiODhjMTdkMTgyODIyNmM5
YzhiZDJhYWY4YTI1OWZjCkhhcmR3YXJlIG5hbWU6IFN5c3RlbSBtYW51ZmFjdHVyZXIgU3lzdGVt
IFByb2R1Y3QgTmFtZS9UVUYgR0FNSU5HIFg1NzAtUExVUywgQklPUyA0MDIxIDA4LzA5LzIwMjEK
UklQOiAwMDEwOnJpbmdfYnVmZmVyX3dha2Vfd2FpdGVycysweDI2LzB4YjAKQ29kZTogMGIgZWIg
ZTkgOTAgNjYgMGYgMWYgMDAgNDEgNTQgNGMgOGQgNjcgMTAgNTUgNDggODkgZmQgNTMgNDggNjMg
ZGUgODMgZmIgZmYgNzQgMzggNDggOGIgNDcgNjAgNDggOGIgMmMgZDggNDggODEgYzUgNzggMDEg
MDAgMDAgPDQ4PiA4MyA0NSA1MCAwMSAzMSBjOSAzMSBkMiA0OCA4ZCA3ZCAyMCBiZSAwMyAwMCAw
MCAwMCBlOCBiMyBiYiBmNApSU1A6IDAwMTg6ZmZmZmE4MTVjMWFlN2U4MCBFRkxBR1M6IDAwMDEw
MjA2ClJBWDogZmZmZjhmMGY1Y2RlZWQwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMTggUkNYOiAwMDAw
MDAwMDAwMDAwMDEzClJEWDogZmZmZjhmMGY0MTNiMjAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMTgg
UkRJOiBmZmZmOGYwZjVjZGVmZjAwClJCUDogMDAwMDAwMDAwMDAwMDE3OCBSMDg6IGZmZmY4ZjBm
NGJiMDI0NTAgUjA5OiBmZmZmOGYwZjg2YWMyMzcwClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6
IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiBmZmZmOGYwZjVjZGVmZjEwClIxMzogZmZmZjhmMGY0Mzlk
ZGNlMCBSMTQ6IGZmZmY4ZjBmODZhNTQ3ODAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwCkZTOiAgMDAw
MDdmZDIwMTI5Mjc0MCgwMDAwKSBHUzpmZmZmOGYxNjRlZWMwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMwpDUjI6IDAwMDAwMDAwMDAwMDAxYzggQ1IzOiAwMDAwMDAwMTNhMmQwMDAwIENSNDogMDAw
MDAwMDAwMDc1MGVlMApQS1JVOiA1NTU1NTU1NApDYWxsIFRyYWNlOgogPFRBU0s+CiB0cmFjaW5n
X2J1ZmZlcnNfcmVsZWFzZSsweDRkLzB4OTAKIF9fZnB1dCsweDg5LzB4MjUwCiB0YXNrX3dvcmtf
cnVuKzB4NjAvMHg5MAogZXhpdF90b191c2VyX21vZGVfcHJlcGFyZSsweDFhNy8weDFkMAogc3lz
Y2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDFiLzB4NDAKIGRvX3N5c2NhbGxfNjQrMHg2Yi8weDkw
CiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2My8weGNkClJJUDogMDAzMzoweDdm
ZDIwMTQ3NDc3NApDb2RlOiBlYiBiMiA2NyBlOCAxZSAwMiAwMiAwMCA2NiAyZSAwZiAxZiA4NCAw
MCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAwMCBmMyAwZiAxZSBmYSA4MCAzZCBhZCA4ZCAwZSAwMCAw
MCA3NCAxMyBiOCAwMyAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAwIGYwIGZmIGZmIDc3IDQ0IGMz
IDBmIDFmIDAwIDQ4IDgzIGVjIDE4IDg5IDdjIDI0IDBjIGU4IGQzClJTUDogMDAyYjowMDAwN2Zm
ZTFmNjA5ODU4IEVGTEFHUzogMDAwMDAyMDIgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDMKUkFY
OiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAxOCBSQ1g6IDAwMDA3ZmQyMDE0
NzQ3NzQKUkRYOiAwMDAwMDAwMDAwMDAwMDIxIFJTSTogMDAwMDdmZmUxZjYwOWFlMCBSREk6IDAw
MDAwMDAwMDAwMDAwMWQKUkJQOiAwMDAwN2ZmZTFmNjBhZmIwIFIwODogMDAwMDU2MzRhODdmNTI3
MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAwMDA4IFIxMTogMDAwMDAw
MDAwMDAwMDIwMiBSMTI6IDAwMDA3ZmZlMWY2MDk4ZTAKUjEzOiAwMDAwMDAwMDAwMDAwMDAxIFIx
NDogMDAwMDAwMDAwMDAwMDAyMSBSMTU6IDAwMDA1NjM0YTg3Zjk3MjAKIDwvVEFTSz4KTW9kdWxl
cyBsaW5rZWQgaW46IGJ0dXNiKCspIHV2Y3ZpZGVvKCspIGJ0cnRsIHZpZGVvYnVmMl92bWFsbG9j
IGJ0YmNtIHZpZGVvYnVmMl9tZW1vcHMgYnRpbnRlbCB2aWRlb2J1ZjJfdjRsMiBidG10ayB2aWRl
b2J1ZjJfY29tbW9uIG5jdDY3NzUgc25kX3VzYl9hdWRpbygrKSBuY3Q2Nzc1X2NvcmUgYmx1ZXRv
b3RoIGh3bW9uX3ZpZCBzbmRfdXNibWlkaV9saWIgc25kX3Jhd21pZGkgdmlkZW9kZXYgZWNkaF9n
ZW5lcmljIHNuZF9zZXFfZGV2aWNlIGNyYzE2IG1jIGludGVsX3JhcGxfbXNyIGhpZF9sb2dpdGVj
aF9oaWRwcCBqb3lkZXYgbW91c2VkZXYgaW50ZWxfcmFwbF9jb21tb24gZWVlcGNfd21pIGFzdXNf
d21pIG5sc19pc284ODU5XzEgc3BhcnNlX2tleW1hcCBwbGF0Zm9ybV9wcm9maWxlIHZmYXQgZWRh
Y19tY2VfYW1kIGZhdCBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsga3ZtX2FtZCBzbmRfaGRhX2NvZGVj
X2dlbmVyaWMgYW1kZ3B1IGxlZHRyaWdfYXVkaW8ga3ZtIHNuZF9oZGFfY29kZWNfaGRtaSB3YWNv
bSBzbmRfaGRhX2ludGVsIHJma2lsbCBpcnFieXBhc3MgY3JjdDEwZGlmX3BjbG11bCBoaWRfbG9n
aXRlY2hfZGogdmlkZW8gY3JjMzJfcGNsbXVsIGdwdV9zY2hlZCBzbmRfaW50ZWxfZHNwY2ZnIHdt
aV9ibW9mIHBvbHl2YWxfY2xtdWxuaSBwb2x5dmFsX2dlbmVyaWMgc25kX2ludGVsX3Nkd19hY3Bp
IGRybV9idWRkeSBnZjEyOG11bCBzbmRfaGRhX2NvZGVjIGdoYXNoX2NsbXVsbmlfaW50ZWwgZHJt
X3R0bV9oZWxwZXIgYWVzbmlfaW50ZWwgc25kX2hkYV9jb3JlIHI4MTY5IGNyeXB0b19zaW1kIGNy
eXB0ZCB0dG0gc25kX2h3ZGVwIHNuZF9wY20gZHJtX2Rpc3BsYXlfaGVscGVyIHJhcGwgdXNiaGlk
IHNuZF90aW1lciBwY3Nwa3IgcmVhbHRlayBjZWMgazEwdGVtcCBtZGlvX2RldnJlcyBzbmQgc291
bmRjb3JlIGNjcCBzcDUxMDBfdGNvIHRwbV9jcmIgbGlicGh5IGkyY19waWl4NCB0cG1fdGlzIHRw
bV90aXNfY29yZSB3bWkKIHRwbSBybmdfY29yZSBtYWNfaGlkIGFjcGlfY3B1ZnJlcSB1c2JpcF9o
b3N0IHVzYmlwX2NvcmUgZG1fbXVsdGlwYXRoIGRtX21vZCBzZyBjcnlwdG9fdXNlciBmdXNlIGJw
Zl9wcmVsb2FkIGlwX3RhYmxlcyB4X3RhYmxlcyBidHJmcyBibGFrZTJiX2dlbmVyaWMgbGliY3Jj
MzJjIGNyYzMyY19nZW5lcmljIHhvciByYWlkNl9wcSBudm1lIG52bWVfY29yZSBjcmMzMmNfaW50
ZWwgeGhjaV9wY2kgbnZtZV9jb21tb24geGhjaV9wY2lfcmVuZXNhcwpDUjI6IDAwMDAwMDAwMDAw
MDAxYzgKLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tClJJUDogMDAxMDpyaW5n
X2J1ZmZlcl93YWtlX3dhaXRlcnMrMHgyNi8weGIwCkNvZGU6IDBiIGViIGU5IDkwIDY2IDBmIDFm
IDAwIDQxIDU0IDRjIDhkIDY3IDEwIDU1IDQ4IDg5IGZkIDUzIDQ4IDYzIGRlIDgzIGZiIGZmIDc0
IDM4IDQ4IDhiIDQ3IDYwIDQ4IDhiIDJjIGQ4IDQ4IDgxIGM1IDc4IDAxIDAwIDAwIDw0OD4gODMg
NDUgNTAgMDEgMzEgYzkgMzEgZDIgNDggOGQgN2QgMjAgYmUgMDMgMDAgMDAgMDAgZTggYjMgYmIg
ZjQKUlNQOiAwMDE4OmZmZmZhODE1YzFhZTdlODAgRUZMQUdTOiAwMDAxMDIwNgpSQVg6IGZmZmY4
ZjBmNWNkZWVkMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDE4IFJDWDogMDAwMDAwMDAwMDAwMDAxMwpS
RFg6IGZmZmY4ZjBmNDEzYjIwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDE4IFJESTogZmZmZjhmMGY1
Y2RlZmYwMApSQlA6IDAwMDAwMDAwMDAwMDAxNzggUjA4OiBmZmZmOGYwZjRiYjAyNDUwIFIwOTog
ZmZmZjhmMGY4NmFjMjM3MApSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAw
MDAxIFIxMjogZmZmZjhmMGY1Y2RlZmYxMApSMTM6IGZmZmY4ZjBmNDM5ZGRjZTAgUjE0OiBmZmZm
OGYwZjg2YTU0NzgwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApGUzogIDAwMDA3ZmQyMDEyOTI3NDAo
MDAwMCkgR1M6ZmZmZjhmMTY0ZWVjMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCkNT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKQ1IyOiAwMDAw
MDAwMDAwMDAwMWM4IENSMzogMDAwMDAwMDEzYTJkMDAwMCBDUjQ6IDAwMDAwMDAwMDA3NTBlZTAK
UEtSVTogNTU1NTU1NTQKCg==
--000000000000f5e1c805ec54372b--
