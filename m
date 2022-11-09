Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24956227E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKIKDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKIKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:03:13 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0ADF8D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:03:11 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667988190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADn4I/gxfbeuOnqaEElLnAmP0TxvmbdlBGTXvh/CwBE=;
        b=QzMpOQA80Vm51iHnEAl41+F/SDOJU2nLlUHQlrlWDWFxTJOpDoqd3qmytaN1TlIfEHD5YX
        kG7h7BdLrCO1q5cxYB+a7TYhIwq8wfy4hxHTvB5fD/JzaufWewUf+VrD8Dqq5bPKebBRL0
        F3aQ591SupfQEf3UYReS8O4TYjokzb8=
Date:   Wed, 09 Nov 2022 10:03:03 +0000
Content-Type: multipart/mixed;
 boundary="--=_RainLoop_759_989495542.1667988183"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at 
 mm/memblock.c:519
To:     "Mike Rapoport" <rppt@linux.ibm.com>
Cc:     "Sachin Sant" <sachinp@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <Y2oLYB7Tu7J91tVm@linux.ibm.com>
References: <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----=_RainLoop_759_989495542.1667988183
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey Mike,=0A=0ACan you help me test the attached file? =0APlease use this=
 new patch instead of the one in memblock tree.=0A=0ANovember 8, 2022 3:5=
5 PM, "Mike Rapoport" <rppt@linux.ibm.com> wrote:=0A=0A> Hi Yajun,=0A> =
=0A> On Tue, Nov 08, 2022 at 02:27:53AM +0000, Yajun Deng wrote:=0A> =0A>=
> Hi Sachin,=0A>> I didn't have a powerpc architecture machine. I don't k=
now why this happened.=0A>> =0A>> Hi Mike,=0A>> Do you have any suggestio=
ns?=0A> =0A> You can try reproducing the bug qemu or work with Sachin to =
debug the=0A> issue.=0A> =0A>> I tested in tools/testing/memblock, and it=
 was successful.=0A> =0A> Memblock tests provide limited coverage still a=
nd they don't deal with all=0A> possible cases.=0A> =0A> For now I'm drop=
ping this patch from the memblock tree until the issue is=0A> fixed.=0A> =
=0A>> November 6, 2022 8:07 PM, "Sachin Sant" <sachinp@linux.ibm.com> wro=
te:=0A>> =0A>> While booting recent linux-next on a IBM Power10 Server LP=
AR=0A>> following crash is observed:=0A>> =0A>> [ 0.000000] numa: Partiti=
on configured for 32 NUMA nodes.=0A>> [ 0.000000] ------------[ cut here =
]------------=0A>> [ 0.000000] kernel BUG at mm/memblock.c:519!=0A>> [ 0.=
000000] Oops: Exception in kernel mode, sig: 5 [#1]=0A>> [ 0.000000] LE P=
AGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries=0A>> [ 0.00000=
0] Modules linked in:=0A>> [ 0.000000] CPU: 0 PID: 0 Comm: swapper Not ta=
inted 6.1.0-rc3-next-20221104 #1=0A>> [ 0.000000] Hardware name: IBM,9080=
-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1030.00=0A>> (NH1030_026) =
hv:phyp pSeries=0A>> [ 0.000000] NIP: c0000000004ba240 LR: c0000000004bb2=
40 CTR: c0000000004ba210=0A>> [ 0.000000] REGS: c000000002a8b7b0 TRAP: 07=
00 Not tainted (6.1.0-rc3-next-20221104)=0A>> [ 0.000000] MSR: 8000000000=
021033 <SF,ME,IR,DR,RI,LE> CR: 24042424 XER: 00000001=0A>> [ 0.000000] CF=
AR: c0000000004ba290 IRQMASK: 1=0A>> [ 0.000000] GPR00: c0000000004bb240 =
c000000002a8ba50 c00000000136ee00 c0000010f3ac00a8=0A>> [ 0.000000] GPR04=
: 0000000000000000 c0000010f3ac0090 00000010f3ac0000 0000000000000d00=0A>=
> [ 0.000000] GPR08: 0000000000000001 0000000000000007 0000000000000001 0=
000000000000081=0A>> [ 0.000000] GPR12: c0000000004ba210 c000000002e10000=
 0000000000000000 000000000000000d=0A>> [ 0.000000] GPR16: 000000000f6be6=
20 000000000f6be8e8 000000000f6be788 000000000f6bed58=0A>> [ 0.000000] GP=
R20: 000000000f6f6d58 c0000000029a8de8 00000010f3ad8800 0000000000000080=
=0A>> [ 0.000000] GPR24: 00000010f3ad7b00 0000000000000000 00000000000001=
00 0000000000000d00=0A>> [ 0.000000] GPR28: 00000010f3ad7b00 c0000000029a=
8de8 c0000000029a8e00 0000000000000006=0A>> [ 0.000000] NIP [c0000000004b=
a240] memblock_merge_regions.isra.12+0x40/0x130=0A>> [ 0.000000] LR [c000=
0000004bb240] memblock_add_range+0x190/0x300=0A>> [ 0.000000] Call Trace:=
=0A>> [ 0.000000] [c000000002a8ba50] [0000000000000100] 0x100 (unreliable=
)=0A>> [ 0.000000] [c000000002a8ba90] [c0000000004bb240] memblock_add_ran=
ge+0x190/0x300=0A>> [ 0.000000] [c000000002a8bb10] [c0000000004bb5e0] mem=
block_reserve+0x70/0xd0=0A>> [ 0.000000] [c000000002a8bba0] [c00000000204=
5234] memblock_alloc_range_nid+0x11c/0x1e8=0A>> [ 0.000000] [c000000002a8=
bc60] [c0000000020453a4] memblock_alloc_internal+0xa4/0x110=0A>> [ 0.0000=
00] [c000000002a8bcb0] [c0000000020456cc] memblock_alloc_try_nid+0x94/0xc=
c=0A>> [ 0.000000] [c000000002a8bd40] [c00000000200b570] alloc_paca_data+=
0x7c/0xcc=0A>> [ 0.000000] [c000000002a8bdb0] [c00000000200b770] allocate=
_paca+0x8c/0x28c=0A>> [ 0.000000] [c000000002a8be50] [c00000000200a26c] s=
etup_arch+0x1c4/0x4d8=0A>> [ 0.000000] [c000000002a8bed0] [c0000000020043=
78] start_kernel+0xb4/0xa84=0A>> [ 0.000000] [c000000002a8bf90] [c0000000=
0000da90] start_here_common+0x1c/0x20=0A>> [ 0.000000] Instruction dump:=
=0A>> [ 0.000000] 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 7c9e2378 3=
be00000 f8010010=0A>> [ 0.000000] f821ffc1 e9230000 3969ffff 4800000c <0b=
0a0000> 7d3f4b78 393f0001 7fbf5840=0A>> [ 0.000000] ---[ end trace 000000=
0000000000 ]---=0A>> [ 0.000000]=0A>> [ 0.000000] Kernel panic - not sync=
ing: Fatal exception=0A>> [ 0.000000] Rebooting in 180 seconds..=0A>> =0A=
>> This problem was introduced with next-20221101. Git bisect points to=
=0A>> following patch=0A>> =0A>> commit 3f82c9c4ac377082e1230f5299e0ccce0=
7b15e12=0A>> Date: Tue Oct 25 15:09:43 2022 +0800=0A>> memblock: don't ru=
n loop in memblock_add_range() twice=0A>> =0A>> Reverting this patch help=
s boot the kernel to login prompt.=0A>> =0A>> Have attached .config=0A>> =
=0A>> - Sachin=0A> =0A> --=0A> Sincerely yours,=0A> Mike.

----=_RainLoop_759_989495542.1667988183
Content-Type: application/octet-stream;
 name="0001-memblock-don-t-run-loop-in-memblock_add_range-twice-.patch"
Content-Disposition: attachment;
 filename="0001-memblock-don-t-run-loop-in-memblock_add_range-twice-.patch"
Content-Transfer-Encoding: base64

RnJvbSAwYTQ4OTgwZDczNDZjNTgyZWViNzE5OGQ4MjJkNTZhNGMxOTI2NjMyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBZYWp1biBEZW5nIDx5YWp1bi5kZW5nQGxpbnV4LmRl
dj4KRGF0ZTogV2VkLCA5IE5vdiAyMDIyIDE3OjM1OjI3ICswODAwClN1YmplY3Q6IFtQQVRD
SCB2M10gbWVtYmxvY2s6IGRvbid0IHJ1biBsb29wIGluIG1lbWJsb2NrX2FkZF9yYW5nZSgp
IHR3aWNlIGluCiBtb3N0IGNhc2UKClRoZXJlIGlzIG5vIG5lZWQgcm91bmQgdHdpY2UgaW4g
bWVtYmxvY2tfYWRkX3JhbmdlKCkgaW4gbW9zdCBjYXNlLgoKV2UgY2FuIGNhbGwgbWVtYmxv
Y2tfZG91YmxlX2FycmF5KCkgdG8gZXh0ZW5kIHRoZSBzaXplIGlmIHR5cGUtPmNudApncmVh
dGVyIG9yIGVxdWFsIHRvIHR5cGUtPm1heCBiZWZvcmUgbWVtYmxvY2tfaW5zZXJ0X3JlZ2lv
bigpOyBvdGhlcndpc2UsCndlIGNhbiBpbnNlcnQgdGhlIG5ldyByZWdpb24gZGlyZWN0bHku
CgpTcGVjaWFsOiBtZW1ibG9ja19kb3VibGVfYXJyYXkoKSB3b3VsZCBuZXN0ZWQgY2FsbCBt
ZW1ibG9ja19hZGRfcmFuZ2UoKQppZiBzbGFiX2lzX2F2YWlsYWJsZSgpIGlzIE5VTEwsIHNv
IHdlIHNob3VsZCByZXBlYXQgYWdhaW4gYmVmb3JlIGluc2VydAppbiB0aGF0IGNhc2UuCgp2
MzoKIC0gRml4IG5lc3RlZCBjYWxsIGluIG1lbWJsb2NrX2RvdWJsZV9hcnJheSgpLgoKdjI6
CiAtIEFkZCBhIGNvbW1lbnQgd2hlbiB0aGUgYWxsb2NhdGlvbiBpcyByZXF1aXJlZC4KClNp
Z25lZC1vZmYtYnk6IFlhanVuIERlbmcgPHlhanVuLmRlbmdAbGludXguZGV2PgotLS0KIG1t
L21lbWJsb2NrLmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA0MiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9tZW1ibG9jay5jIGIvbW0vbWVtYmxvY2su
YwppbmRleCA1MTFkNDc4M2RjZjEuLjQyZDNlNDE1N2Y0YSAxMDA2NDQKLS0tIGEvbW0vbWVt
YmxvY2suYworKysgYi9tbS9tZW1ibG9jay5jCkBAIC01NzgsMTEgKzU3OCwxMSBAQCBzdGF0
aWMgaW50IF9faW5pdF9tZW1ibG9jayBtZW1ibG9ja19hZGRfcmFuZ2Uoc3RydWN0IG1lbWJs
b2NrX3R5cGUgKnR5cGUsCiAJCQkJcGh5c19hZGRyX3QgYmFzZSwgcGh5c19hZGRyX3Qgc2l6
ZSwKIAkJCQlpbnQgbmlkLCBlbnVtIG1lbWJsb2NrX2ZsYWdzIGZsYWdzKQogewotCWJvb2wg
aW5zZXJ0ID0gZmFsc2U7CiAJcGh5c19hZGRyX3Qgb2Jhc2UgPSBiYXNlOwogCXBoeXNfYWRk
cl90IGVuZCA9IGJhc2UgKyBtZW1ibG9ja19jYXBfc2l6ZShiYXNlLCAmc2l6ZSk7Ci0JaW50
IGlkeCwgbnJfbmV3OworCXVuc2lnbmVkIGxvbmcgb2NudCA9IHR5cGUtPmNudDsKIAlzdHJ1
Y3QgbWVtYmxvY2tfcmVnaW9uICpyZ247CisJaW50IGlkeDsKIAogCWlmICghc2l6ZSkKIAkJ
cmV0dXJuIDA7CkBAIC01OTgsMjQgKzU5OCw4IEBAIHN0YXRpYyBpbnQgX19pbml0X21lbWJs
b2NrIG1lbWJsb2NrX2FkZF9yYW5nZShzdHJ1Y3QgbWVtYmxvY2tfdHlwZSAqdHlwZSwKIAkJ
cmV0dXJuIDA7CiAJfQogCi0JLyoKLQkgKiBUaGUgd29yc3QgY2FzZSBpcyB3aGVuIG5ldyBy
YW5nZSBvdmVybGFwcyBhbGwgZXhpc3RpbmcgcmVnaW9ucywKLQkgKiB0aGVuIHdlJ2xsIG5l
ZWQgdHlwZS0+Y250ICsgMSBlbXB0eSByZWdpb25zIGluIEB0eXBlLiBTbyBpZgotCSAqIHR5
cGUtPmNudCAqIDIgKyAxIGlzIGxlc3MgdGhhbiB0eXBlLT5tYXgsIHdlIGtub3cKLQkgKiB0
aGF0IHRoZXJlIGlzIGVub3VnaCBlbXB0eSByZWdpb25zIGluIEB0eXBlLCBhbmQgd2UgY2Fu
IGluc2VydAotCSAqIHJlZ2lvbnMgZGlyZWN0bHkuCi0JICovCi0JaWYgKHR5cGUtPmNudCAq
IDIgKyAxIDwgdHlwZS0+bWF4KQotCQlpbnNlcnQgPSB0cnVlOwotCiByZXBlYXQ6Ci0JLyoK
LQkgKiBUaGUgZm9sbG93aW5nIGlzIGV4ZWN1dGVkIHR3aWNlLiAgT25jZSB3aXRoICVmYWxz
ZSBAaW5zZXJ0IGFuZAotCSAqIHRoZW4gd2l0aCAldHJ1ZS4gIFRoZSBmaXJzdCBjb3VudHMg
dGhlIG51bWJlciBvZiByZWdpb25zIG5lZWRlZAotCSAqIHRvIGFjY29tbW9kYXRlIHRoZSBu
ZXcgYXJlYS4gIFRoZSBzZWNvbmQgYWN0dWFsbHkgaW5zZXJ0cyB0aGVtLgotCSAqLwogCWJh
c2UgPSBvYmFzZTsKLQlucl9uZXcgPSAwOwogCiAJZm9yX2VhY2hfbWVtYmxvY2tfdHlwZShp
ZHgsIHR5cGUsIHJnbikgewogCQlwaHlzX2FkZHJfdCByYmFzZSA9IHJnbi0+YmFzZTsKQEAg
LTYzNCwxMSArNjE4LDI1IEBAIHN0YXRpYyBpbnQgX19pbml0X21lbWJsb2NrIG1lbWJsb2Nr
X2FkZF9yYW5nZShzdHJ1Y3QgbWVtYmxvY2tfdHlwZSAqdHlwZSwKIAkJCVdBUk5fT04obmlk
ICE9IG1lbWJsb2NrX2dldF9yZWdpb25fbm9kZShyZ24pKTsKICNlbmRpZgogCQkJV0FSTl9P
TihmbGFncyAhPSByZ24tPmZsYWdzKTsKLQkJCW5yX25ldysrOwotCQkJaWYgKGluc2VydCkK
LQkJCQltZW1ibG9ja19pbnNlcnRfcmVnaW9uKHR5cGUsIGlkeCsrLCBiYXNlLAotCQkJCQkJ
ICAgICAgIHJiYXNlIC0gYmFzZSwgbmlkLAotCQkJCQkJICAgICAgIGZsYWdzKTsKKworCQkJ
LyoKKwkJCSAqIGlmIHR5cGUtPmNudCBncmVhdGVyIG9yIGVxdWFsIHRvIHR5cGUtPm1heCwK
KwkJCSAqIHJlc2l6ZSBhcnJheTsgb3RoZXJ3aXNlLCBpbnNlcnQgZGlyZWN0bHkuCisJCQkg
KgorCQkJICogc3BlY2lhbDogdGhlcmUgbWF5IGJlIG5lc3RlZCBjYWxsIHRoaXMgZnVuY3Rp
b24KKwkJCSAqIGluIG1lbWJsb2NrX2RvdWJsZV9hcnJheSgpLCBzbyBpdCBzaG91bGQgcmVw
ZWF0IGluCisJCQkgKiB0aGF0IGNhc2UuCisJCQkgKi8KKwkJCWlmICh0eXBlLT5jbnQgPj0g
dHlwZS0+bWF4KSB7CisJCQkJaWYgKG1lbWJsb2NrX2RvdWJsZV9hcnJheSh0eXBlLCBvYmFz
ZSwgc2l6ZSkpCisJCQkJCXJldHVybiAtRU5PTUVNOworCQkJCWVsc2UgaWYgKCFzbGFiX2lz
X2F2YWlsYWJsZSgpKQorCQkJCQlnb3RvIHJlcGVhdDsKKwkJCX0KKworCQkJbWVtYmxvY2tf
aW5zZXJ0X3JlZ2lvbih0eXBlLCBpZHgrKywgYmFzZSwKKwkJCQkJICAgICAgIHJiYXNlIC0g
YmFzZSwgbmlkLAorCQkJCQkgICAgICAgZmxhZ3MpOwogCQl9CiAJCS8qIGFyZWEgYmVsb3cg
QHJlbmQgaXMgZGVhbHQgd2l0aCwgZm9yZ2V0IGFib3V0IGl0ICovCiAJCWJhc2UgPSBtaW4o
cmVuZCwgZW5kKTsKQEAgLTY0NiwyOSArNjQ0LDIzIEBAIHN0YXRpYyBpbnQgX19pbml0X21l
bWJsb2NrIG1lbWJsb2NrX2FkZF9yYW5nZShzdHJ1Y3QgbWVtYmxvY2tfdHlwZSAqdHlwZSwK
IAogCS8qIGluc2VydCB0aGUgcmVtYWluaW5nIHBvcnRpb24gKi8KIAlpZiAoYmFzZSA8IGVu
ZCkgewotCQlucl9uZXcrKzsKLQkJaWYgKGluc2VydCkKLQkJCW1lbWJsb2NrX2luc2VydF9y
ZWdpb24odHlwZSwgaWR4LCBiYXNlLCBlbmQgLSBiYXNlLAotCQkJCQkgICAgICAgbmlkLCBm
bGFncyk7CisJCWlmICh0eXBlLT5jbnQgPj0gdHlwZS0+bWF4KSB7CisJCQlpZiAobWVtYmxv
Y2tfZG91YmxlX2FycmF5KHR5cGUsIG9iYXNlLCBzaXplKSkKKwkJCQlyZXR1cm4gLUVOT01F
TTsKKwkJCWVsc2UgaWYgKCFzbGFiX2lzX2F2YWlsYWJsZSgpKQorCQkJCWdvdG8gcmVwZWF0
OworCQl9CisKKwkJbWVtYmxvY2tfaW5zZXJ0X3JlZ2lvbih0eXBlLCBpZHgsIGJhc2UsIGVu
ZCAtIGJhc2UsCisJCQkJICAgICAgIG5pZCwgZmxhZ3MpOwogCX0KIAotCWlmICghbnJfbmV3
KQorCWlmIChvY250ID09IHR5cGUtPmNudCkKIAkJcmV0dXJuIDA7CiAKLQkvKgotCSAqIElm
IHRoaXMgd2FzIHRoZSBmaXJzdCByb3VuZCwgcmVzaXplIGFycmF5IGFuZCByZXBlYXQgZm9y
IGFjdHVhbAotCSAqIGluc2VydGlvbnM7IG90aGVyd2lzZSwgbWVyZ2UgYW5kIHJldHVybi4K
LQkgKi8KLQlpZiAoIWluc2VydCkgewotCQl3aGlsZSAodHlwZS0+Y250ICsgbnJfbmV3ID4g
dHlwZS0+bWF4KQotCQkJaWYgKG1lbWJsb2NrX2RvdWJsZV9hcnJheSh0eXBlLCBvYmFzZSwg
c2l6ZSkgPCAwKQotCQkJCXJldHVybiAtRU5PTUVNOwotCQlpbnNlcnQgPSB0cnVlOwotCQln
b3RvIHJlcGVhdDsKLQl9IGVsc2UgewotCQltZW1ibG9ja19tZXJnZV9yZWdpb25zKHR5cGUp
OwotCQlyZXR1cm4gMDsKLQl9CisJbWVtYmxvY2tfbWVyZ2VfcmVnaW9ucyh0eXBlKTsKKwor
CXJldHVybiAwOwogfQogCiAvKioKLS0gCjIuMjUuMQoK

----=_RainLoop_759_989495542.1667988183--
