Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7160665E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJTQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:57:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94F19ABC5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:57:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 128so91180pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFTq/WIK6eSikdDroXyqrv1nIA6ghmcz645Ab1OBKa0=;
        b=s122gHWJxme/60Y80GhdZyHSn+u37v7Dxe/PvxdZbQEktqtueLTzy3bI0JLILZgcgK
         le5IP/WkExo4YBDmthx2rBu6h4nupHYwTOUuoSIKadTmLD23dwPWc7EP2sna1vzz6P5t
         ddwB6YBxyU2duwo/Rgi/1OweTMC+TmrMSr7iDqxnAfpvd9ZW4Cod0vC1DQDKRGtC1K41
         FQwi2vL3RKu4UXLt9Lt2JHo9KhdU4imU/fLD4FxZiOkqYjMsPXPGanDwE/KGA/N8eyxQ
         hJ3UQByyyRM/ak/unwfbUjnn6sSTApnW++sXhAfFnd4Coun2/l5Mq64PuAQOmLpBSYUH
         KcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFTq/WIK6eSikdDroXyqrv1nIA6ghmcz645Ab1OBKa0=;
        b=qJubuPg/WjHjpepy6j3uSDcXSFM8Hos4Dney3Wavqohvt1A0zA8Zz5y5Htar34qzFe
         AMpRKCdED/rsGzHfn4CNWk6KHmUw0ZWEKlusnqm3Es487/3XHJu+pNw34bqwTVb40Wml
         a5+mU0+PN/fdiBuExsznKYwVKYbwaspkq5L00D9KtfrGwHl+JXLX+PZexdrurO/LsWzO
         Zo/iQEPSPxEbV03y5EoZaFZxT/POzqXoNMbchEAafsNgS78CevqDd9D6+v3L0ZwPyMBU
         bOKahWHOnkc7NMOSYZ+i98VjBQnt8h1wvld7fKOK3SOKfJwPT6D6+LDfNhKGU+l7D4iI
         xioA==
X-Gm-Message-State: ACrzQf08xxLogvBQypRWceEUDhD+TRdCvxzYc+1rQ7aYSnzF4ylrygGc
        V0BTVN0UCUsQX6Bu8IZZJVqHJtPWgQDa8Hua1YH5eg==
X-Google-Smtp-Source: AMsMyM5d4FWOqTGLKMSHpiNBsxeQQ0LFCBLSJ/TvWYGCHSF7ONwpPcd9LxWrjIVverUcXo/WdruHLPXC2uEEnDpe+2E=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr14672773pfa.37.1666285022897; Thu, 20
 Oct 2022 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR03MB8319B83F92372CA86A42C089F3289@DU0PR03MB8319.eurprd03.prod.outlook.com>
 <CABCJKue6M4cXyTP9wgaBx0oZ+5K7sQna9UQF88Pxcknv-kzcMg@mail.gmail.com> <DU0PR03MB83196C180979F74ABEEB0562F32A9@DU0PR03MB8319.eurprd03.prod.outlook.com>
In-Reply-To: <DU0PR03MB83196C180979F74ABEEB0562F32A9@DU0PR03MB8319.eurprd03.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Oct 2022 09:56:50 -0700
Message-ID: <CAKwvOdncRqrTNqmiDhtkj74V4eU03FBgDr25H4+npwHYgrYQRw@mail.gmail.com>
Subject: Re: Update15.x/kcfi to LLVM 15.0.3 (ZSTD + DWARFv5)
To:     "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>,
        Fangrui Song <maskray@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e3197505eb7a3614"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e3197505eb7a3614
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 10:44 PM Sedat Dilek (DHL Supply Chain)
<sedat.dilek@dhl.com> wrote:
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Sami Tolvanen <samitolvanen@google.com>
> Gesendet: Dienstag, 18. Oktober 2022 18:00
> An: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> Betreff: Re: Update15.x/kcfi to LLVM 15.0.3
>
> On Tue, Oct 18, 2022 at 4:54 AM Sedat Dilek (DHL Supply Chain) <sedat.dil=
ek@dhl.com> wrote:
> >
> [ CC Nick + Fangrui ]
>
> You happen to know or use the ZSTD cmake-option (see [1] and [2]) - came =
in with changes post-15.0.2?
>
> AFAICS Fangrui Song had some patches to use ZSTD debug-compression with D=
WARFv5.
>
> Unsure, if that combination is now possible in v15.0.3 or is a feature of=
 LLVM-16.
>
> [3] says:
>
> [ lib/Kconfig.debug ]
>
> config DEBUG_INFO_COMPRESSED
>         bool "Compressed debugging information"
>         depends on $(cc-option,-gz=3Dzlib)
>         depends on $(ld-option,--compress-debug-sections=3Dzlib)
>         help
>           Compress the debug information using zlib.  Requires GCC 5.0+ o=
r Clang
>           5.0+, binutils 2.26+, and zlib.
>
>           Users of dpkg-deb via scripts/package/builddeb may find an incr=
ease in
>           size of their debug .deb packages with this config set, due to =
the
>           debug info being compressed with zlib, then the object files be=
ing
>           recompressed with a different compression scheme. But this is s=
till
>           preferable to setting $KDEB_COMPRESS to "none" which would be e=
ven
>           larger.
>
> I am interested in the equivalent changes to cc-option/ld-option with ZST=
D (usable with DWARFv5).

Good idea.  It looks like there's still a blocker to using -gz=3Dzstd with =
clang:
$ clang -gz=3Dzstd -x c - < /dev/null
clang-16: warning: cannot compress debug sections (zstd not enabled)
[-Wdebug-compression-unavailable]

https://github.com/facebook/zstd/issues/3271

Attaching a WIP patch.

>
> Thanks.
>
> Best regards,
> -Sedat-
>
> [1] https://github.com/llvm/llvm-project/commit/6fba7854a2f0b6b3899bb156c=
1a0c4ae35c96e24
> [2] https://github.com/llvm/llvm-project/commit/b4840279846e1eea44c3dca57=
5395a90c9d77ca0
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/lib/Kconfig.debug#n315
> [4] https://metadata.ftp-master.debian.org/changelogs//main/l/llvm-toolch=
ain-15/llvm-toolchain-15_15.0.3-1~exp1_changelog
>
>
>


--=20
Thanks,
~Nick Desaulniers

--000000000000e3197505eb7a3614
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-WIP-Makefile.debug-support-for-gz-zstd.patch"
Content-Disposition: attachment; 
	filename="0001-WIP-Makefile.debug-support-for-gz-zstd.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l9hb29yn0>
X-Attachment-Id: f_l9hb29yn0

RnJvbSBjOWNjZjg0YzFhM2ZjNzQyMTIzZGNjNmI3Nzg5MjA2NTA2MTkwMjYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xl
LmNvbT4KRGF0ZTogVGh1LCAyMCBPY3QgMjAyMiAwOTo1NDoyMiAtMDcwMApTdWJqZWN0OiBbUEFU
Q0hdIFdJUDogTWFrZWZpbGUuZGVidWc6IHN1cHBvcnQgZm9yIC1nej16c3RkCgpNYWtlIERFQlVH
X0lORk9fQ09NUFJFU1NFRCBhIGNob2ljZTsgREVCVUdfSU5GT19VTkNPTVBSRVNTRUQgaXMgdGhl
CmRlZmF1bHQsIERFQlVHX0lORk9fQ09NUFJFU1NFRCB1c2VzIHpsaWIsIERFQlVHX0lORk9fQ09N
UFJFU1NFRF9aU1RECnVzZXMgenN0ZC4KClRPRE86IG1lYXN1cmVtZW50cwoKTGluazogaHR0cHM6
Ly9tYXNrcmF5Lm1lL2Jsb2cvMjAyMi0wOS0wOS16c3RkLWNvbXByZXNzZWQtZGVidWctc2VjdGlv
bnMKTGluazogaHR0cHM6Ly9tYXNrcmF5Lm1lL2Jsb2cvMjAyMi0wMS0yMy1jb21wcmVzc2VkLWRl
YnVnLXNlY3Rpb25zClN1Z2dlc3RlZC1ieTogU2VkYXQgRGlsZWsgKERITCBTdXBwbHkgQ2hhaW4p
IDxzZWRhdC5kaWxla0BkaGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxu
ZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KLS0tCiBsaWIvS2NvbmZpZy5kZWJ1ZyAgICAgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKysrKy0KIHNjcmlwdHMvTWFrZWZpbGUuZGVidWcgfCAgNCAr
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9saWIvS2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRlYnVnCmluZGV4IDNm
YzdhYmZmYzdhYS4uNDA4NWFjNzdkYzEyIDEwMDY0NAotLS0gYS9saWIvS2NvbmZpZy5kZWJ1Zwor
KysgYi9saWIvS2NvbmZpZy5kZWJ1ZwpAQCAtMzEyLDggKzMxMiwyMiBAQCBjb25maWcgREVCVUdf
SU5GT19SRURVQ0VECiAJICBERUJVR19JTkZPIGJ1aWxkIGFuZCBjb21waWxlIHRpbWVzIGFyZSBy
ZWR1Y2VkIHRvby4KIAkgIE9ubHkgd29ya3Mgd2l0aCBuZXdlciBnY2MgdmVyc2lvbnMuCiAKK2No
b2ljZQorCXByb21wdCAiQ29tcHJlc3NlZCBEZWJ1ZyBpbmZvcm1hdGlvbiIKKwlkZXBlbmRzIG9u
IERFQlVHX0tFUk5FTAorCWhlbHAKKwkgIENvbXByZXNzIHRoZSByZXN1bHRpbmcgZGVidWcgaW5m
by4gUmVzdWx0cyBpbiBzbWFsbGVyIGRlYnVnIGluZm8gc2VjdGlvbnMsCisJICBidXQgcmVxdWly
ZXMgdGhhdCBjb25zdW1lcnMgYXJlIGFibGUgdG8gZGVjb21wcmVzcyB0aGUgcmVzdWx0cy4KKwor
CSAgSWYgdW5zdXJlLCBjaG9vc2UgREVCVUdfSU5GT19VTkNPTVBSRVNTRUQuCisKK2NvbmZpZyBE
RUJVR19JTkZPX1VOQ09NUFJFU1NFRAorCWJvb2wgIkRvbid0IGNvbXByZXNzIGRlYnVnIGluZm9y
bWF0aW9uIgorCWhlbHAKKwkgIERvbid0IGNvbXByZXNzIGRlYnVnIGluZm8gc2VjdGlvbnMuCisK
IGNvbmZpZyBERUJVR19JTkZPX0NPTVBSRVNTRUQKLQlib29sICJDb21wcmVzc2VkIGRlYnVnZ2lu
ZyBpbmZvcm1hdGlvbiIKKwlib29sICJDb21wcmVzcyBkZWJ1Z2dpbmcgaW5mb3JtYXRpb24gd2l0
aCB6bGliIgogCWRlcGVuZHMgb24gJChjYy1vcHRpb24sLWd6PXpsaWIpCiAJZGVwZW5kcyBvbiAk
KGxkLW9wdGlvbiwtLWNvbXByZXNzLWRlYnVnLXNlY3Rpb25zPXpsaWIpCiAJaGVscApAQCAtMzI3
LDYgKzM0MSwxNiBAQCBjb25maWcgREVCVUdfSU5GT19DT01QUkVTU0VECiAJICBwcmVmZXJhYmxl
IHRvIHNldHRpbmcgJEtERUJfQ09NUFJFU1MgdG8gIm5vbmUiIHdoaWNoIHdvdWxkIGJlIGV2ZW4K
IAkgIGxhcmdlci4KIAorY29uZmlnIERFQlVHX0lORk9fQ09NUFJFU1NFRF9aU1RECisJYm9vbCAi
Q29tcHJlc3MgZGVidWdnaW5nIGluZm9ybWF0aW9uIHdpdGggenN0ZCIKKwlkZXBlbmRzIG9uICQo
Y2Mtb3B0aW9uLC1nej16c3RkKQorCWRlcGVuZHMgb24gJChsZC1vcHRpb24sLS1jb21wcmVzcy1k
ZWJ1Zy1zZWN0aW9ucz16c3RkKQorCWhlbHAKKwkgIENvbXByZXNzIHRoZSBkZWJ1ZyBpbmZvcm1h
dGlvbiB1c2luZyB6c3RkLiAgUmVxdWlyZXMgR0NDIDEzLjArIG9yIENsYW5nCisJICAxNi4wKywg
YmludXRpbHMgMi40MCssIGFuZCB6c3RkLgorCitlbmRjaG9pY2UgIyAiQ29tcHJlc3NlZCBEZWJ1
ZyBpbmZvcm1hdGlvbiIKKwogY29uZmlnIERFQlVHX0lORk9fU1BMSVQKIAlib29sICJQcm9kdWNl
IHNwbGl0IGRlYnVnaW5mbyBpbiAuZHdvIGZpbGVzIgogCWRlcGVuZHMgb24gJChjYy1vcHRpb24s
LWdzcGxpdC1kd2FyZikKZGlmZiAtLWdpdCBhL3NjcmlwdHMvTWFrZWZpbGUuZGVidWcgYi9zY3Jp
cHRzL01ha2VmaWxlLmRlYnVnCmluZGV4IDMzMmM0ODZmNzA1Zi4uOGFjMzM3OWQyMjU1IDEwMDY0
NAotLS0gYS9zY3JpcHRzL01ha2VmaWxlLmRlYnVnCisrKyBiL3NjcmlwdHMvTWFrZWZpbGUuZGVi
dWcKQEAgLTMxLDYgKzMxLDEwIEBAIGlmZGVmIENPTkZJR19ERUJVR19JTkZPX0NPTVBSRVNTRUQK
IERFQlVHX0NGTEFHUwkrPSAtZ3o9emxpYgogS0JVSUxEX0FGTEFHUwkrPSAtZ3o9emxpYgogS0JV
SUxEX0xERkxBR1MJKz0gLS1jb21wcmVzcy1kZWJ1Zy1zZWN0aW9ucz16bGliCitlbHNlIGlmZGVm
IENPTkZJR19ERUJVR19JTkZPX0NPTVBSRVNTRURfWlNURAorREVCVUdfQ0ZMQUdTCSs9IC1nej16
c3RkCitLQlVJTERfQUZMQUdTCSs9IC1nej16c3RkCitLQlVJTERfTERGTEFHUwkrPSAtLWNvbXBy
ZXNzLWRlYnVnLXNlY3Rpb25zPXpzdGQKIGVuZGlmCiAKIEtCVUlMRF9DRkxBR1MJKz0gJChERUJV
R19DRkxBR1MpCi0tIAoyLjM4LjAuMTM1Lmc5MDg1MGEyMjExLWdvb2cKCg==
--000000000000e3197505eb7a3614--
