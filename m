Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF586E68D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDRQBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjDRQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:01:12 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809E1730
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681833667;
        bh=dzB0cfSNW+51bgYW+r0ws6Sh8v0+AeUupiTWqYBhdtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N0OXmZc6H3AFW6n2csk7CsJtnNT/ledNj7SEoyOUsdJP7+YifrR291XUw1XZoh6iz
         b61G0EopbELJaO9tJnPmm8jYjbaqMMeQ+PZAKzZBy5IRK3/dp+T0rJmdxb8URrNuQD
         PveatLPPxKJz4JWz8J01f2Rhcmyccuknt6VpOGJ77ZKiuFsDRoHochqzTonB1KaLx1
         V7YT9FJFBIFVseJzH0XHHCmfMtBWcijYHYzcCFVnGQXtakYiotkAja/aCGZPWQ1nYe
         GOD4C43u2SSBIt//9yNaq8c4QqwLMDZeXUQXckoGZqtsPvfJ4F1/2JfR1MlFXlhugx
         tOD40WTjm78dA==
Received: from [172.16.0.98] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q17v7483zzvWL;
        Tue, 18 Apr 2023 12:01:07 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------VzfqmiLne2Xl47nvRjeVKmV6"
Message-ID: <40689cd1-af60-542d-2245-c6362c73a365@efficios.com>
Date:   Tue, 18 Apr 2023 12:01:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
 <20230418112151.GA565498@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230418112151.GA565498@ziqianlu-desk2>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------VzfqmiLne2Xl47nvRjeVKmV6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-18 07:21, Aaron Lu wrote:
> On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:
>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>> sysbench regression reported by Aaron Lu.
> 
> For postgres_sysbench on SPR:
> sched_mm_cid_migrate_to() is in the range of 0.1x% - 0.4x%, mm_cid_get()
> is in the range of 0.1x% - 0.3x%. Other cid functions are pretty minor.
> 
> For hackbench on SPR:
> ched_mm_cid_migrate_to() is about 3%-4%, mm_cid_get() is about 7%-8%,
> other cid functions are pretty minor.

It's a bit higher than I would have expected for hackbench.

Can you run with the attached schedstats patch applied and boot
with schedstats=enable ? Let me know how the counters behave please,
because I cannot reproduce anything unexpected on my machine.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

--------------VzfqmiLne2Xl47nvRjeVKmV6
Content-Type: text/x-patch; charset=UTF-8; name="schedstat-mm-cid.patch"
Content-Disposition: attachment; filename="schedstat-mm-cid.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IDZjZjYwMDViOWM1ZDY5ZTBmOGQ5ODkwMGU5Mzk3NDAxYmY4MDRmYTQKQXV0aG9y
OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgpE
YXRlOiAgIFR1ZSBBcHIgMTggMTE6MTU6NTAgMjAyMyAtMDQwMAoKICAgIHNjaGVkc3RhdHMg
bW1fY2lkCgpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUuYyBiL2tlcm5lbC9zY2hl
ZC9jb3JlLmMKaW5kZXggY2UwOGNhNjhmZGY0Li45M2M1NjUxMmYwZDggMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9zY2hlZC9jb3JlLmMKKysrIGIva2VybmVsL3NjaGVkL2NvcmUuYwpAQCAtMTE2
NTgsMTIgKzExNjU4LDE1IEBAIHZvaWQgc2NoZWRfbW1fY2lkX21pZ3JhdGVfdG8oc3RydWN0
IHJxICpkc3RfcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqdCkKIAlzcmNfY2lkID0gX19zY2hl
ZF9tbV9jaWRfbWlncmF0ZV9mcm9tX3RyeV9zdGVhbF9jaWQodCwgc3JjX2NpZCk7CiAJaWYg
KHNyY19jaWQgPT0gLTEpCiAJCXJldHVybjsKKwlzY2hlZHN0YXRfaW5jKGRzdF9ycS0+bW1f
Y2lkX21pZ3JhdGVfc3RlYWwpOwogCWlmICghbW1fY2lkX2lzX3Vuc2V0KGRzdF9jaWQpKSB7
CisJCXNjaGVkc3RhdF9pbmMoZHN0X3JxLT5tbV9jaWRfbWlncmF0ZV9jbGVhcik7CiAJCV9f
bW1fY2lkX3B1dChtbSwgc3JjX2NpZCk7CiAJCXJldHVybjsKIAl9CiAJLyogTW92ZSBzcmNf
Y2lkIHRvIGRzdCBjcHUuICovCiAJbW1fY2lkX3NuYXBzaG90X3RpbWUobW0pOworCXNjaGVk
c3RhdF9pbmMoZHN0X3JxLT5tbV9jaWRfbWlncmF0ZV9tb3ZlKTsKIAlXUklURV9PTkNFKGRz
dF9wY3B1X2NpZC0+Y2lkLCBzcmNfY2lkKTsKIH0KIApAQCAtMTE3NDEsNiArMTE3NDQsNyBA
QCBzdGF0aWMgdm9pZCBzY2hlZF9tbV9jaWRfcmVtb3RlX2NsZWFyX29sZChzdHJ1Y3QgbW1f
c3RydWN0ICptbSwgaW50IGNwdSkKIAlwY3B1X2NpZCA9IHBlcl9jcHVfcHRyKG1tLT5wY3B1
X2NpZCwgY3B1KTsKIAlpZiAocnFfY2xvY2sgPCBwY3B1X2NpZC0+dGltZSArIFNDSEVEX01N
X0NJRF9QRVJJT0RfTlMpCiAJCXJldHVybjsKKwlzY2hlZHN0YXRfaW5jKHJxLT5tbV9jaWRf
dGFza193b3JrX2NsZWFyX29sZCk7CiAJc2NoZWRfbW1fY2lkX3JlbW90ZV9jbGVhcihtbSwg
Y3B1KTsKIH0KIApAQCAtMTE3NTQsNiArMTE3NTgsNyBAQCBzdGF0aWMgdm9pZCBzY2hlZF9t
bV9jaWRfcmVtb3RlX2NsZWFyX3dlaWdodChzdHJ1Y3QgbW1fc3RydWN0ICptbSwgaW50IGNw
dSwKIAljaWQgPSBSRUFEX09OQ0UocGNwdV9jaWQtPmNpZCk7CiAJaWYgKCFtbV9jaWRfaXNf
dmFsaWQoY2lkKSB8fCBjaWQgPCB3ZWlnaHQpCiAJCXJldHVybjsKKwlzY2hlZHN0YXRfaW5j
KHRoaXNfcnEoKS0+bW1fY2lkX3Rhc2tfd29ya19jbGVhcl9jb21wYWN0KTsKIAlzY2hlZF9t
bV9jaWRfcmVtb3RlX2NsZWFyKG1tLCBjcHUpOwogfQogCkBAIC0xMTc4OSw2ICsxMTc5NCw3
IEBAIHN0YXRpYyB2b2lkIHRhc2tfbW1fY2lkX3dvcmsoc3RydWN0IGNhbGxiYWNrX2hlYWQg
KndvcmspCiAJCXJldHVybjsKIAlpZiAoIXRyeV9jbXB4Y2hnKCZtbS0+bW1fY2lkX25leHRf
c2NhbiwgJm9sZF9zY2FuLCBuZXh0X3NjYW4pKQogCQlyZXR1cm47CisJc2NoZWRzdGF0X2lu
Yyh0aGlzX3JxKCktPm1tX2NpZF90YXNrX3dvcmtfbnJfcnVuKTsKIAljaWRtYXNrID0gbW1f
Y2lkbWFzayhtbSk7CiAJLyogQ2xlYXIgY2lkcyB0aGF0IHdlcmUgbm90IHJlY2VudGx5IHVz
ZWQuICovCiAJZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkKZGlmZiAtLWdpdCBhL2tlcm5l
bC9zY2hlZC9zY2hlZC5oIGIva2VybmVsL3NjaGVkL3NjaGVkLmgKaW5kZXggOGNlNDhiMjQy
MjFlLi5iOWE1ZTgyMDE5MjIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC9zY2hlZC5oCisr
KyBiL2tlcm5lbC9zY2hlZC9zY2hlZC5oCkBAIC0xMTU0LDYgKzExNTQsMTggQEAgc3RydWN0
IHJxIHsKIAl1NjQJCQljb3JlX2ZvcmNlaWRsZV9zdGFydDsKICNlbmRpZgogCisJdW5zaWdu
ZWQgaW50CQltbV9jaWRfdGFza193b3JrX25yX3J1bjsKKwl1bnNpZ25lZCBpbnQJCW1tX2Np
ZF90YXNrX3dvcmtfY2xlYXJfb2xkOworCXVuc2lnbmVkIGludAkJbW1fY2lkX3Rhc2tfd29y
a19jbGVhcl9jb21wYWN0OworCXVuc2lnbmVkIGludAkJbW1fY2lkX2dldF9jYWNoZWQ7CisJ
dW5zaWduZWQgaW50CQltbV9jaWRfZ2V0X2FsbG9jOworCXVuc2lnbmVkIGludAkJbW1fY2lk
X2dldF9wdXRfbGF6eTsKKwl1bnNpZ25lZCBpbnQJCW1tX2NpZF9wdXRfbGF6eTsKKwl1bnNp
Z25lZCBpbnQJCW1tX2NpZF9wdXQ7CisJdW5zaWduZWQgaW50CQltbV9jaWRfbWlncmF0ZV9z
dGVhbDsKKwl1bnNpZ25lZCBpbnQJCW1tX2NpZF9taWdyYXRlX2NsZWFyOworCXVuc2lnbmVk
IGludAkJbW1fY2lkX21pZ3JhdGVfbW92ZTsKKwogCS8qIFNjcmF0Y2ggY3B1bWFzayB0byBi
ZSB0ZW1wb3JhcmlseSB1c2VkIHVuZGVyIHJxX2xvY2sgKi8KIAljcHVtYXNrX3Zhcl90CQlz
Y3JhdGNoX21hc2s7CiAKQEAgLTMyODUsNiArMzI5Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCBtbV9jaWRfcHV0X2xhenkoc3RydWN0IHRhc2tfc3RydWN0ICp0KQogCWlmICghbW1fY2lk
X2lzX2xhenlfcHV0KGNpZCkgfHwKIAkgICAgIXRyeV9jbXB4Y2hnKCZwY3B1X2NpZC0+Y2lk
LCAmY2lkLCBNTV9DSURfVU5TRVQpKQogCQlyZXR1cm47CisJc2NoZWRzdGF0X2luYyh0aGlz
X3JxKCktPm1tX2NpZF9wdXRfbGF6eSk7CiAJX19tbV9jaWRfcHV0KG1tLCBtbV9jaWRfY2xl
YXJfbGF6eV9wdXQoY2lkKSk7CiB9CiAKQEAgLTMzMTgsNiArMzMzMSw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBtbV9jaWRfcHV0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQogCWNpZCA9IG1t
X2NpZF9wY3B1X3Vuc2V0KHBjcHVfY2lkKTsKIAlpZiAoY2lkID09IE1NX0NJRF9VTlNFVCkK
IAkJcmV0dXJuOworCXNjaGVkc3RhdF9pbmModGhpc19ycSgpLT5tbV9jaWRfcHV0KTsKIAlf
X21tX2NpZF9wdXQobW0sIG1tX2NpZF9jbGVhcl9sYXp5X3B1dChjaWQpKTsKIH0KIApAQCAt
MzQyMSwxNCArMzQzNSwxOCBAQCBzdGF0aWMgaW5saW5lIGludCBtbV9jaWRfZ2V0KHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKQogCXBjcHVfY2lkID0gdGhpc19jcHVfcHRyKG1tLT5wY3B1X2Np
ZCk7CiAJY2lkID0gUkVBRF9PTkNFKHBjcHVfY2lkLT5jaWQpOwogCWlmIChtbV9jaWRfaXNf
dmFsaWQoY2lkKSkgeworCQlzY2hlZHN0YXRfaW5jKHJxLT5tbV9jaWRfZ2V0X2NhY2hlZCk7
CiAJCW1tX2NpZF9zbmFwc2hvdF90aW1lKG1tKTsKIAkJcmV0dXJuIGNpZDsKIAl9CiAJaWYg
KG1tX2NpZF9pc19sYXp5X3B1dChjaWQpKSB7Ci0JCWlmICh0cnlfY21weGNoZygmcGNwdV9j
aWQtPmNpZCwgJmNpZCwgTU1fQ0lEX1VOU0VUKSkKKwkJaWYgKHRyeV9jbXB4Y2hnKCZwY3B1
X2NpZC0+Y2lkLCAmY2lkLCBNTV9DSURfVU5TRVQpKSB7CisJCQlzY2hlZHN0YXRfaW5jKHJx
LT5tbV9jaWRfZ2V0X3B1dF9sYXp5KTsKIAkJCV9fbW1fY2lkX3B1dChtbSwgbW1fY2lkX2Ns
ZWFyX2xhenlfcHV0KGNpZCkpOworCQl9CiAJfQogCWNpZCA9IF9fbW1fY2lkX2dldChtbSk7
CisJc2NoZWRzdGF0X2luYyhycS0+bW1fY2lkX2dldF9hbGxvYyk7CiAJV1JJVEVfT05DRShw
Y3B1X2NpZC0+Y2lkLCBjaWQpOwogCXJldHVybiBjaWQ7CiB9CmRpZmYgLS1naXQgYS9rZXJu
ZWwvc2NoZWQvc3RhdHMuYyBiL2tlcm5lbC9zY2hlZC9zdGF0cy5jCmluZGV4IDg1N2Y4Mzdm
NTJjYi4uN2M5NDdhMWJlYWZhIDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvc3RhdHMuYwor
KysgYi9rZXJuZWwvc2NoZWQvc3RhdHMuYwpAQCAtMTMzLDEyICsxMzMsMzQgQEAgc3RhdGlj
IGludCBzaG93X3NjaGVkc3RhdChzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwgdm9pZCAqdikKIAog
CQkvKiBydW5xdWV1ZS1zcGVjaWZpYyBzdGF0cyAqLwogCQlzZXFfcHJpbnRmKHNlcSwKLQkJ
ICAgICJjcHUlZCAldSAwICV1ICV1ICV1ICV1ICVsbHUgJWxsdSAlbHUiLAorCQkgICAgImNw
dSVkICV1IDAgJXUgJXUgJXUgJXUgJWxsdSAlbGx1ICVsdSAiCisJCSAgICAibW1fY2lkX3Rh
c2tfd29ya19ucl9ydW46ICV1ICIKKwkJICAgICJtbV9jaWRfdGFza193b3JrX2NsZWFyX29s
ZDogJXUgIgorCQkgICAgIm1tX2NpZF90YXNrX3dvcmtfY2xlYXJfY29tcGFjdDogJXUgIgor
CQkgICAgIm1tX2NpZF9nZXRfY2FjaGVkOiAldSAiCisJCSAgICAibW1fY2lkX2dldF9hbGxv
YzogJXUgIgorCQkgICAgIm1tX2NpZF9nZXRfcHV0X2xhenk6ICV1ICIKKwkJICAgICJtbV9j
aWRfcHV0X2xhenk6ICV1ICIKKwkJICAgICJtbV9jaWRfcHV0OiAldSAiCisJCSAgICAibW1f
Y2lkX21pZ3JhdGVfc3RlYWw6ICV1ICIKKwkJICAgICJtbV9jaWRfbWlncmF0ZV9jbGVhcjog
JXUgIgorCQkgICAgIm1tX2NpZF9taWdyYXRlX21vdmU6ICV1IiwKIAkJICAgIGNwdSwgcnEt
PnlsZF9jb3VudCwKIAkJICAgIHJxLT5zY2hlZF9jb3VudCwgcnEtPnNjaGVkX2dvaWRsZSwK
IAkJICAgIHJxLT50dHd1X2NvdW50LCBycS0+dHR3dV9sb2NhbCwKIAkJICAgIHJxLT5ycV9j
cHVfdGltZSwKLQkJICAgIHJxLT5ycV9zY2hlZF9pbmZvLnJ1bl9kZWxheSwgcnEtPnJxX3Nj
aGVkX2luZm8ucGNvdW50KTsKKwkJICAgIHJxLT5ycV9zY2hlZF9pbmZvLnJ1bl9kZWxheSwg
cnEtPnJxX3NjaGVkX2luZm8ucGNvdW50LAorCQkgICAgcnEtPm1tX2NpZF90YXNrX3dvcmtf
bnJfcnVuLAorCQkgICAgcnEtPm1tX2NpZF90YXNrX3dvcmtfY2xlYXJfb2xkLAorCQkgICAg
cnEtPm1tX2NpZF90YXNrX3dvcmtfY2xlYXJfY29tcGFjdCwKKwkJICAgIHJxLT5tbV9jaWRf
Z2V0X2NhY2hlZCwKKwkJICAgIHJxLT5tbV9jaWRfZ2V0X2FsbG9jLAorCQkgICAgcnEtPm1t
X2NpZF9nZXRfcHV0X2xhenksCisJCSAgICBycS0+bW1fY2lkX3B1dF9sYXp5LAorCQkgICAg
cnEtPm1tX2NpZF9wdXQsCisJCSAgICBycS0+bW1fY2lkX21pZ3JhdGVfc3RlYWwsCisJCSAg
ICBycS0+bW1fY2lkX21pZ3JhdGVfY2xlYXIsCisJCSAgICBycS0+bW1fY2lkX21pZ3JhdGVf
bW92ZSk7CiAKIAkJc2VxX3ByaW50ZihzZXEsICJcbiIpOwogCg==

--------------VzfqmiLne2Xl47nvRjeVKmV6--
