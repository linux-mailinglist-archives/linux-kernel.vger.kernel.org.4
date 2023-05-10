Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAF6FD931
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjEJIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjEJIZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:25:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906BA171B;
        Wed, 10 May 2023 01:25:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3078cc99232so3888082f8f.3;
        Wed, 10 May 2023 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683707115; x=1686299115;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KLIVhK0Yp9xjk8c1Z2hzmB9QxMCsfDdqY5Th7VSf/7w=;
        b=qkg1BlE5ntbk5jTX2sivdRVeO5qbpvyEwz93bd3pP45QShyzY9EFUcT3tu364RwwtE
         5b44bTQAt6nhjr2r8/CR4pA3PdE766I0F1JYyYavR/KN84+Q0YxZRfcoCEjQWORbgVt4
         Z1mcAvWez0BPr33Yai2AFswToO3fDogZGHgClfd7F8aFmV+DNmWekmSBF+jbB1oSO9qc
         9j+k2LD0iQB9UWdJHsdynd9htNK9/G+Bs3UUZCF1yEyzLsJxx8kY8dNRT+S8wBd4ZnAR
         vvw3CWTeUvrWmwycbzimEiqmKcirIiJiDhQg6nKd9G2sVi/uIon5SR8CLiISCfjlHQag
         tW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707115; x=1686299115;
        h=mime-version:user-agent:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLIVhK0Yp9xjk8c1Z2hzmB9QxMCsfDdqY5Th7VSf/7w=;
        b=YpxfjxLPRDxGioUkKode3+YQjcgoLKIkoi/E6v/GeCozeEl/b58VYP7ZTfqGVrfc4v
         sUx3JMc3kZO88gvdDrL8vDq2R1+3r2VBHIQ/Cq4mlWX3UD6eIzM0mZzqf4UDXVyggV4M
         3VWicp/nNnhJkYOhbr2nr9gi6oRh85m5JnEtF9qp4+6zbugDDH/mf2tgZKoSPwIOwO/x
         BuRvvFAia8WG7z9V7Un1GRW2H6oVIm8n4UXZQ/0jr6O+zBQXdrGbk+emsDcXEj6uEUPx
         TtS6RogABEgwfW+VuM+ERv1xiqvHHiC7pW1fS1rtBfOzuCNFdXXo5uzv7F2VR9e9XHYi
         TBFA==
X-Gm-Message-State: AC+VfDy8/lJAWdVISyc+DH9F9GOjReyNtqeE6lGHYqP7h0SivHsx2PfM
        CdRzQrJzMIFlmYIMU5WELfKt5ArY9biF0Q==
X-Google-Smtp-Source: ACHHUZ7YiSC8XEZvjIS1auRj3I9d/IDWjHB+0KdqqZQgXC4DxEaqOLnbxyXNg5aU2J6m5w1GIUofXA==
X-Received: by 2002:a5d:6751:0:b0:307:7c2d:dc80 with SMTP id l17-20020a5d6751000000b003077c2ddc80mr11784385wrw.34.1683707114830;
        Wed, 10 May 2023 01:25:14 -0700 (PDT)
Received: from [192.168.8.84] (213-225-15-168.nat.highway.a1.net. [213.225.15.168])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b00307972e46fasm8313307wrx.107.2023.05.10.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:25:14 -0700 (PDT)
Message-ID: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
Subject: [REGRESSION] wifi: brcmfmac: add firmware vendor info in driver info
From:   Felix <nimrod4garoa@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     regressions@lists.linux.dev,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Date:   Wed, 10 May 2023 10:25:12 +0200
Content-Type: multipart/mixed; boundary="=-4Yv0aQnA60OXIoYx5DFN"
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-4Yv0aQnA60OXIoYx5DFN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changes made by the mentioned commit lead to Oops when waking up after
suspend to RAM.

When waking up a Dell XPS 13 9350 with BCM4350 wifi card after suspend
to RAM,=C2=A0the kernel hangs with a NULL pointer dereference and Oops. The
issues was introduced by commit
da6d9c8ecd00e20218461007948f2b0a8e7fa242 and only happens when the
brcmfmac module is loaded. This issue is the reason we could not
upgrade to newer kernels than the 6.1 series on the affected machine.


Details:

On a Dell XPS 13 9350 laptop with Broadcom BCM4350 wifi card (according
to lspci), every kernel starting with 6.2 hangs when waking up after
suspend to RAM. The issue persisted as of May 2nd (last tested commit
was 348551ddaf311c76b01cdcbaf61b6fef06a49144). Passing the debug and
no_console_suspend parameters to the kernel show that a NULL pointer
dereference and an Oops happen at wakeup. Please find the kernel
messages readable on the screen at this point attached
(kernel_log_after_suspend.txt).

A bisection was successful and produced the first bad commit
[da6d9c8ecd00e20218461007948f2b0a8e7fa242]=C2=A0wifi: brcmfmac: add firmwar=
e
vendor info in driver info
I've attached the bisection log as well (bisect.txt).

Suspend to RAM works on this machine on newer kernels once the brcmfmac
module is unloaded.

Distribution: Arch Linux
Architecture: x86_64
Device: Dell XPS 13 9350 with BCM4350 wifi card
Kernel config used at compilation (created using the Arch Linux default
config and make olddefconfig):
https://gist.githubusercontent.com/maclomhair/e33fa7eece8f8c77e5a88c4eede2f=
523/raw/429dfb022498c026225865dbb3ab2f75d5030a54/config
Dmesg output after boot:
https://gist.githubusercontent.com/maclomhair/47c75fa759d93800e7fb5e937fabe=
f3e/raw/10750996a1ea9dcb3fa14d9b94e11fedd3abf280/dmesg

#regzbot introduced da6d9c8ecd00e20218461007948f2b0a8e7fa242

Thank you for your time,
Felix



--=-4Yv0aQnA60OXIoYx5DFN
Content-Disposition: attachment; filename="kernel_log_after_suspend.txt"
Content-Type: text/plain; name="kernel_log_after_suspend.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBzZWQgMC4wMDAuIHNl
Y29uZHMpIGRvbmUuCkFDUEk6IEVDOiBpbnRlcnJ1cHQgYmxvY2tlZApBQ1BJOiBQTTogUHJlcGFy
aW5nIHRvIGVudGVyIHN5c3RlbiBzbGVlcCBzdGF0ZSBTMwpBQ1BJOiBFQzogZXZlbnQgYmxvY2tl
ZApBQ1BJOiBFQzogRUMgc3RvcHBlZApBQ1BJOiBQTTogU2F2aW5nIHBsYXRmb3JtIE5WUyBtZW1v
cnkKRGlzYWJsaW5nIG5vbi1ib290IENQVXMgLi4uCnNtcGJvb3Q6IENQVSAxIGlzIG5vdyBvZmZs
aW5lCnNtcGJvb3Q6IENQVSAyIGlzIG5vdyBvZmZsaW5lCnNtcGJvb3Q6IENQVSAzIGlzIG5vdyBv
ZmZsaW5lCkFDUEk6IFBNOiBMb3ctbGV2ZWwgcmVzdW1lIGNvbXBsZXRlCkFDUEk6IEVDOiBFQyBz
dGFydGVkCkFDUEk6IFBNOiBSZXN0b3JpbmcgcGxhdGZvcm0gTlZTIG1lbW9yeQpFbmFibGluZyBu
b24tYm9vdCBDUFVzIC4uLgp4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246CnNtcGJvb3Q6
IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAxIEFQSUMgT3gyCkNQVTEgaXMgdXAKc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDIgQVBJQyAweDEKQ1BVMiBpcyB1cApzbXBib290OiBC
b290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMyBBUElDIDB4MwpDUFUzIGlzIHVwCkFDUEk6IFBNOiBX
YWtpbmcgdXAgZnJvbSBzeXN0ZW0gc2xlZXAgc3RhdGUgUzMKQUNQSTogRUM6IGludGVycnVwdCB1
bmJsb2NrZWQKQUNQSTogRUM6IGV2ZW50IHVuYmxvY2tlZAp4aGNpIGhjZCAwMDAwOjAwOjE0LjA6
IHhIQyBlcnJvciBpbiByZXN1bWUsIFVTQlNUUyBPeDQxMSwgUmVpbml0CnVzYiB1c2IxOiByb290
IGh1YiBsb3N0IHBvd2VyIG9yIHdhcyByZXNldAp1c2IgdXNiMjogcm9vdCBodWIgbG9zdCBwb3dl
ciBvciB3YXMgcmVzZXQKaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIFtFTkNPREVSOjk0OkRESSBB
L1BIWSBBXSBpcyBkaXNhYmxlZC9pbiBEU0kgbm9kZSB3aXRoIGFuIHVuZ2F0ZWQgRERJIGNsb2Nr
LCBnYXRlIGl0Cmk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSBbRU5DT0RFUjoxMDI6RERJIEIvUEhZ
IEJdIGlzIGRpc2FibGVkL2luIERTSSBtb2RlIHdpdGggYW4gdW5nYXRlZCBEREkgY2xvY2ssIGdh
dGUgaXQKaTkxNSAwMDAwOjAwOjAyLjA6IFtkcm1dIFtFTkNPREVSOjExNzpEREkgQy9QSFkgQzEg
aXMgZGlzYWJsZWQvaW4gRFNJIG5vZGUgd2l0aCBhbiB1bmdhdGVkIERESSBjbG9jaywgZ2F0ZSBp
dApudm1lIG52bWUwOiA0LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMKQlVHOiBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDE4CiNQRjog
c3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQojUEY6IGVycm9yX2NvZGUoMHgw
MDAwKSDigJQgbm90LXByZXNlbnQgcGFnZQpQR0QgMCBQNEQgMApPb3BzOiAwMDAwIFsjMV0gUFJF
RU1QVCBTTVAgUFRJCkNQVTogMyBQSUQ6IDU3NiBDb21tOiBrd29ya2VyL3VCOjE4IFRhaW50ZWQ6
IEcgICAgICAgICBJICAgICAgICAgNi4xLjAtcmM3LTEtZ2l0LTAxNzY2LWdkYTZkOWM4ZWNkMDAg
IzIwIGZhMmUzMmZmYWQwYjM5ZDUzYjVlNTJlYTlmOWU1OTkxMjNiMWQxMTIKSGFyZHdhcmUgbmFt
ZTogRGVsbCBJbmMuIFhQUyAxMyA5MzUwLzBQV05DUiwgQklEUyAxLjEzLjAgMDIvMTAvMjAyMApX
b3JrZ3VldWU6IGV2ZW50c191bmJvdW5kIGFzeW5jX3J1bl9lbnRyeV9mbgpSSVA6IDAwMTA6YnJj
bWZfcGNpZV9wcm9iZStPeDE2Yi8weDdhMCBbYnJjbWZtYWNdCkNvZGU6IDQ5IDg5IDQ0IDI0IDQ4
IDQ4IDg1IGMwIE9mIDg0IGY0IDA1IDAwIDAwIDQ4IDhkIDg1IGQwIDAwIDAwIDAwIDQ4IDhiIDM0
IDI0IDQ4IDg5IGVmIDQ5IGM3IDQ0IDI0IDQwIGUwIDM5IDBkIGMxIDQ5IDg5IDQ0IDI0IDEwIDw0
OT4gOGIgNDUgMTggNDggODkgNWUgMDggNDEgODkgNDQgMjQgMzggOGIgODMgMDAgMDQgMDAgMDAg
NGMgODkgMjYKUlNQOiAwMDAwOmZmZmZiZDgwNDE4NTNkNzggRUZMQUdTOiAwMDAxMDI4NgpSQVg6
IGZmZmY5N2ExMDE1NGYwZDAgUkJYOiBmZmZmOTdhMTA1ZmMyODAwIFJDWDogMDAwMDAwMDAwMDAw
MDAwMQpSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmOTdhMjc1ZjA0ZmYwIFJESTogZmZm
Zjk3YTEwMTU0ZjAwMApSQlA6IGZmZmY5N2ExMDE1NGYwMDAgUk84OiAwMDAwMDAwMDAwMDAwMDQw
IFIwOTogZmZmZjk3YTEwMmJlYzBjMApSMTA6IDAwMDAwMDAwNjYwMDAwNTAgUjExOiBmZmZmZmZm
ZmE2MDAwMDMxIFIxMjogZmZmZjk3YTEwNDkzNzljMApSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0
OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogZmZmZjk3YTEwNDMwYzFhOApGUzogIDAwMDAwMDAwMDAw
MDAwMDAoMDAwMCkgR1M6ZmZmZjk3YTI3NmQ4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAw
MDAwCkNTOiAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDAwODAwNTAwMzMKQ1Iy
OiAwMDAwMDAwMDAwMDAwMDE4IENSMzogMDAwMDAwMDE3NzgxMDAwMSBDUjQ6IDAwMDAwMDAwMDAz
NzA2ZTAKQ2FsbCBUcmFjZToKIDxUQVNLPgogYnJjbWZfcGNpZV9wbV9sZWF2ZV9EMysweGM1Lzh4
MWEwIFticmNtZm1hYyBiZTNiNGNlZmNhNDUxZTE5MGZhMzViZThmMDBkYjFiYmVjMjkzODg3XQog
PyBwY2lfcG1fcmVzdW1lKzB4NWIvMHhmMAogPyBwY2lfbGVnYWN5X3Jlc3VtZSsweDgwLzB4ODAK
IGRwbV9ydW5fY2FsbGJhY2srMHg0Ny8weDE1MAogZGV2aWNlX3Jlc3VtZSsweGEyLzB4MWYwCiBh
c3luY19yZXN1bWUrMHgxZC8weDMwCiBhc3luY19ydW5fZW50cnlfZm4rMHgzMS8weDEzMAogcHJv
Y2Vzc19vbmVfd29yaysweDFjNC8weDM4MAogd29ya2VyX3RocmVhZCsweDUxLzB4MzkwCiA/IHJl
c2N1ZXJfdGhyZWFkKzB4M2IwLzB4M2IwCiBrdGhyZWFkK094ZGIvMHgxMTAKID8ga3RocmVhZF9j
b21wbGV0ZV9hbmRfZXhpdCsweDIwLzB4MjAKdXNiIDEtMzogcmVzZXQgZnVsbC1zcGVlZCBVU0Ig
ZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkNzA2ZTAwMDAwMDAwMDAwMDQgMjQgNDggODkg
ZWYgNDkgYzcgNDQgMjQgNDAgZTAgMzkgMGQgYzEgNDkgODkgNDQgMjQgMTAgPDQ5PiA4YiA0NSAx
OCA0OCA4OSA1ZSAwOCA0MSA4OSA0NCAyNCAzOCA4YiA4MyAwMCAwNCAwMCAwMCA0YyA4OSAyNnZp
ZGVvIGk4MDMyIHNlcmlvIHdtaXNoX2NsCnVzYiAxLTU6IHJlc2V0IGhpZ2gtc3BlZWQgVVNCIGRl
dmljZSBudW1iZXIgMyB1c2luZyB4aGNpX2hjZAo=


--=-4Yv0aQnA60OXIoYx5DFN
Content-Disposition: attachment; filename="bisect.log"
Content-Type: text/x-log; name="bisect.log"; charset="UTF-8"
Content-Transfer-Encoding: base64

IyBiYWQ6IFtjOWMzMzk1ZDVlM2RjYzZkYWVlNjZjNjkwODM1NGQ0N2JmOThjYjBjXSBMaW51eCA2
LjIKIyBnb29kOiBbODMwYjNjNjhjMWZiMWU5MTc2MDI4ZDAyZWY4NmYzY2Y3NmFhMjQ3Nl0gTGlu
dXggNi4xCmdpdCBiaXNlY3Qgc3RhcnQgJ3Y2LjInICd2Ni4xJwojIGdvb2Q6IFsxY2EwNmYxYzFh
Y2VjYmUwMjEyNGYxNGEzN2NjZTM0N2I4YzFhOTBjXSBNZXJnZSB0YWcgJ3h0ZW5zYS0yMDIyMTIx
Mycgb2YgaHR0cHM6Ly9naXRodWIuY29tL2pjbXZia2JjL2xpbnV4LXh0ZW5zYQpnaXQgYmlzZWN0
IGdvb2QgMWNhMDZmMWMxYWNlY2JlMDIxMjRmMTRhMzdjY2UzNDdiOGMxYTkwYwojIGJhZDogW2I4
M2E3MDgwZDMwMDMyY2Y3MDgzMmJjMmJiMDRjYzM0MmUyMDNiODhdIE1lcmdlIHRhZyAnc3RhZ2lu
Zy02LjItcmMxJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvZ3JlZ2toL3N0YWdpbmcKZ2l0IGJpc2VjdCBiYWQgYjgzYTcwODBkMzAwMzJjZjcwODMyYmMy
YmIwNGNjMzQyZTIwM2I4OAojIGJhZDogWzdlNjhkZDdkMDdhMjhmYWEyZTY1NzRkZDZiOWRiZDkw
Y2RlYWFlOTFdIE1lcmdlIHRhZyAnbmV0LW5leHQtNi4yJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0CmdpdCBiaXNlY3QgYmFk
IDdlNjhkZDdkMDdhMjhmYWEyZTY1NzRkZDZiOWRiZDkwY2RlYWFlOTEKIyBnb29kOiBbYzYwOWQ3
Mzk5NDc4OTRkNzM3MGVhZTRjZjA0ZWIyYzQ5ZTkxMGJjZl0gTWVyZ2UgdGFnICd3aXJlbGVzcy1u
ZXh0LTIwMjItMTEtMTgnIG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC93aXJlbGVzcy93aXJlbGVzcy1uZXh0CmdpdCBiaXNlY3QgZ29vZCBjNjA5ZDczOTk0
Nzg5NGQ3MzcwZWFlNGNmMDRlYjJjNDllOTEwYmNmCiMgZ29vZDogWzMyMTYzNDkxYzBjMjA1ZmZi
MTU5NmJhZjljMzA4ZGVlNTMzOGFlOTRdIE1lcmdlIGJyYW5jaCAncjgxNjktaXJxLWNvYWxlc2Nl
JwpnaXQgYmlzZWN0IGdvb2QgMzIxNjM0OTFjMGMyMDVmZmIxNTk2YmFmOWMzMDhkZWU1MzM4YWU5
NAojIGdvb2Q6IFtiMmI1MDlmYjVhMWU2YWYxZTYzMGE3NTViMzJjNDY1ODA5OWRmNzBiXSBNZXJn
ZSB0YWcgJ2xpbnV4LWNhbi1uZXh0LWZvci02LjItMjAyMjEyMTInIG9mIGdpdDovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ta2wvbGludXgtY2FuLW5leHQKZ2l0IGJp
c2VjdCBnb29kIGIyYjUwOWZiNWExZTZhZjFlNjMwYTc1NWIzMmM0NjU4MDk5ZGY3MGIKIyBiYWQ6
IFtmOWM1Y2JkNTJjNjJmMmZhOWQyZGZiZTFhZjhmYjAwZTUwNTZhZWZlXSBidHVzYjogQXZvaWQg
cmVzZXQgb2YgSVNPQyBlbmRwb2ludCBhbHQgc2V0dGluZ3MgdG8gemVybwpnaXQgYmlzZWN0IGJh
ZCBmOWM1Y2JkNTJjNjJmMmZhOWQyZGZiZTFhZjhmYjAwZTUwNTZhZWZlCiMgZ29vZDogWzZiNzVi
ZDNkMDM2NzQ1YjliZTMwOTE3OTA5ZjAzNjAyMDk5YWRiZGJdIGJwZjogUmVmYWN0b3IgQVJHX1BU
Ul9UT19EWU5QVFIgY2hlY2tzIGludG8gcHJvY2Vzc19keW5wdHJfZnVuYwpnaXQgYmlzZWN0IGdv
b2QgNmI3NWJkM2QwMzY3NDViOWJlMzA5MTc5MDlmMDM2MDIwOTlhZGJkYgojIGJhZDogWzY5NWM1
ZDNhODA1NWRjYjk3OTY2NDk2YWRlNTE5NjhjOWE3NWY1YzZdIHdpZmk6IHJ0bDh4eHh1OiBmaXhp
bmcgSVFLIGZhaWx1cmVzIGZvciBydGw4MTkyZXUKZ2l0IGJpc2VjdCBiYWQgNjk1YzVkM2E4MDU1
ZGNiOTc5NjY0OTZhZGU1MTk2OGM5YTc1ZjVjNgojIGJhZDogW2Q1OTJiOWY3NDI2NDNmMDdkYjUz
YWMzNGJhZjZiYmQzY2U5NDc4ZGNdIHdpZmk6IHJ0dzg5OiBzdG9wIG1hYyBwb3J0IGZ1bmN0aW9u
IHdoZW4gc3RvcF9hcCgpCmdpdCBiaXNlY3QgYmFkIGQ1OTJiOWY3NDI2NDNmMDdkYjUzYWMzNGJh
ZjZiYmQzY2U5NDc4ZGMKIyBiYWQ6IFs4MDQxZjJiZmZiZjFjMDg1NGQ5ZjY2NzVhZDAxZGM2Y2E3
MmY3MWRkXSB3aWZpOiBicmNtZm1hYzogaW50cm9kdWNlIEJSQ01GTUFDIGV4cG9ydGVkIHN5bWJv
bHMgbmFtZXNwYWNlCmdpdCBiaXNlY3QgYmFkIDgwNDFmMmJmZmJmMWMwODU0ZDlmNjY3NWFkMDFk
YzZjYTcyZjcxZGQKIyBiYWQ6IFtkNmE1YzU2MjIxNGYyNmU0NDJjOGVjM2ZmMWUyOGUxNjY3NWQx
YmNmXSB3aWZpOiBicmNtZm1hYzogYWRkIHN1cHBvcnQgZm9yIHZlbmRvci1zcGVjaWZpYyBmaXJt
d2FyZSBhcGkKZ2l0IGJpc2VjdCBiYWQgZDZhNWM1NjIyMTRmMjZlNDQyYzhlYzNmZjFlMjhlMTY2
NzVkMWJjZgojIGdvb2Q6IFs3NjgyMWFhZDQ5Y2ViYzY5ZWNhODY4MDBmNDFlODEzMzEwNGU5MWQz
XSB3aWZpOiBicmNtZm1hYzogYWRkIGZ1bmN0aW9uIHRvIHVuYmluZCBkZXZpY2UgdG8gYnVzIGxh
eWVyIGFwaQpnaXQgYmlzZWN0IGdvb2QgNzY4MjFhYWQ0OWNlYmM2OWVjYTg2ODAwZjQxZTgxMzMx
MDRlOTFkMwojIGJhZDogW2RhNmQ5YzhlY2QwMGUyMDIxODQ2MTAwNzk0OGYyYjBhOGU3ZmEyNDJd
IHdpZmk6IGJyY21mbWFjOiBhZGQgZmlybXdhcmUgdmVuZG9yIGluZm8gaW4gZHJpdmVyIGluZm8K
Z2l0IGJpc2VjdCBiYWQgZGE2ZDljOGVjZDAwZTIwMjE4NDYxMDA3OTQ4ZjJiMGE4ZTdmYTI0Mgoj
IGZpcnN0IGJhZCBjb21taXQ6IFtkYTZkOWM4ZWNkMDBlMjAyMTg0NjEwMDc5NDhmMmIwYThlN2Zh
MjQyXSB3aWZpOiBicmNtZm1hYzogYWRkIGZpcm13YXJlIHZlbmRvciBpbmZvIGluIGRyaXZlciBp
bmZvCg==


--=-4Yv0aQnA60OXIoYx5DFN--
