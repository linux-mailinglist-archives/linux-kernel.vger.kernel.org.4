Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7D6D3538
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 04:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDBCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 22:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5C1C1C9;
        Sat,  1 Apr 2023 19:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37619B80DD1;
        Sun,  2 Apr 2023 02:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5470C433EF;
        Sun,  2 Apr 2023 02:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680401658;
        bh=7qOh6FrZEi1CltCGNz4psM3uRmFlrePMFwKwuHPQHEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PyTgGMxaNx+m8I5dUe06gzYW2Gwvwo/OFMeuZF1J4FB/fxWCJFLKCChqdJu8YF4VB
         qNJ56KYli0omQhzXyv9N0HRxOIt/csbj7iiLlwMcsTOg0ivGRhEx565qy9nMHuQwuo
         AxjUd+d5FO/YRWrXbiq8i21C1QMyVSp98/J+/xK7UChabLMNFF8/nWbOXMmW6eS663
         ZZgopeJA95xpRosfPpWpkloGFR88mftulXy5119HU8VPAbTTDyLIRtTrIzXJd0M0RG
         88bgLAiuL6C2+q9v/ywgGH+oaq8deSLbd3Rg/97HDXI5GULI7hOr+czQi0T+ke3aM4
         FV9mv/aFQ1DgA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17aeb49429eso27252372fac.6;
        Sat, 01 Apr 2023 19:14:18 -0700 (PDT)
X-Gm-Message-State: AO0yUKXHidxZsUuatMmAXQWCJgm6gW4unTrUiZnC6sWcCKWS6oFZoo3c
        Z+wKw6w+FFyxz8Z7Uu2oFiEzLRZMvw6Yz7AUs/E=
X-Google-Smtp-Source: AKy350bbKksUsNPFvKrvrRs8k157noGQyUlneadyI1G8NxKLHPSv0nchvZBtXeSGTYM5fCVI192Yyt6ZfrSWF13hHus=
X-Received: by 2002:a05:6870:a2a:b0:177:aff1:a393 with SMTP id
 bf42-20020a0568700a2a00b00177aff1a393mr7925345oac.11.1680401657977; Sat, 01
 Apr 2023 19:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230325141909.2512452-1-masahiroy@kernel.org>
 <ZCSZTLjhLshLBKWM@bergen.fjasle.eu> <CAK7LNAQkKE8X3n6Tyw1oX2g-TsLqpY54yi=ObCHfARdm02Gvyw@mail.gmail.com>
 <ZChvkdnWpYkzKKQ5@fjasle.eu>
In-Reply-To: <ZChvkdnWpYkzKKQ5@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 2 Apr 2023 11:13:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShbZ56gSh9PrbLnBDYKnjtTkHMoCXeGrhcxMvqXGq9=g@mail.gmail.com>
Message-ID: <CAK7LNAShbZ56gSh9PrbLnBDYKnjtTkHMoCXeGrhcxMvqXGq9=g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix package build error due to broken symlinks
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/mixed; boundary="000000000000e7b1ba05f850fff2"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e7b1ba05f850fff2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 2, 2023 at 2:53=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> w=
rote:
>
> On Sat, Apr 01, 2023 at 11:55:44PM +0900 Masahiro Yamada wrote:
> > On Thu, Mar 30, 2023 at 5:02=E2=80=AFAM Nicolas Schier <nicolas@fjasle.=
eu> wrote:
> > >
> > > On Sat 25 Mar 2023 23:19:09 GMT, Masahiro Yamada wrote:
> > > > 'make deb-pkg' and 'make rpm-pkg' fail if a broken symlink exists i=
n
> > > > a dirty source tree. Handle symlinks properly, and also, keep the
> > > > executable permission.
> > > >
> > > > Fixes: 05e96e96a315 ("kbuild: use git-archive for source package cr=
eation")
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  scripts/package/gen-diff-patch | 36 +++++++++++++++++++++++++-----=
----
> > > >  1 file changed, 27 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-d=
iff-patch
> > > > index f842ab50a780..23551de92e1b 100755
> > > > --- a/scripts/package/gen-diff-patch
> > > > +++ b/scripts/package/gen-diff-patch
> > > > @@ -23,16 +23,34 @@ fi
> > > >  git -C ${srctree} status --porcelain --untracked-files=3Dall |
> > > >  while read stat path
> > > >  do
> > > > -     if [ "${stat}" =3D '??' ]; then
> > > > -
> > > > -             if ! diff -u /dev/null "${srctree}/${path}" > .tmp_di=
ff &&
> > > > -                     ! head -n1 .tmp_diff | grep -q "Binary files"=
; then
> > > > -                     {
> > > > -                             echo "--- /dev/null"
> > > > -                             echo "+++ linux/$path"
> > > > -                             cat .tmp_diff | tail -n +3
> > > > -                     } >> ${untracked_patch}
> > > > +     if [ "${stat}" !=3D '??' ]; then
> > > > +             continue
> > > > +     fi
> > > > +
> > > > +     if [ -L "${path}" ]; then
> > > > +             {
> > > > +                     echo "diff --git a/${path} b/${path}"
> > > > +                     echo "new file mode 120000"
> > > > +                     echo "--- /dev/null"
> > > > +                     echo "+++ b/$path"
> > > > +                     echo "@@ -0,0 +1 @@"
> > > > +                     printf "+"; readlink ${path}
> > >
> > > Better quote "${path}"?
> >
> >
> > Thanks for the suggestion.
> >
> > Quoting variables are correct in most cases.
> > But, that is not enough to generate a valid
> > patch when a file path contains spaces.
> >
> >
> >
> > 'git format-patch' produces a patch that
> > is accepted by GNU patch and also by dpkg-source.
> >
> > I learned a trick from GIT source code.
> >
> >
> > If you are interested, what GIT does [1].
> >
> >
> > [1] https://github.com/git/git/commit/1a9eb3b9d50367bee8fe85022684d8128=
16fe531
>
> thanks for the pointer, that is really interesting!
>
> Kind regards,
> Nicolas
>
>
> > I will send v2 later, where I made some more efforts
> > to fix several corner cases even if that is not perfect.


I wrote a patch (attached to this email) but I am
still thinking if this is worth the complicated scripting...

Another approach would be to stop caring untracked files.


--=20
Best Regards
Masahiro Yamada

--000000000000e7b1ba05f850fff2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-kbuild-make-package-builds-more-robust.patch"
Content-Disposition: attachment; 
	filename="0001-kbuild-make-package-builds-more-robust.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lfyrparj0>
X-Attachment-Id: f_lfyrparj0

RnJvbSA0YjkxYWUzZjQ4Mjk1MDIwOWMzNTZhOThiNzk2MDQzOTRmMTY3NjVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBTYXQsIDEgQXByIDIwMjMgMDM6NTc6MzEgKzA5MDAKU3ViamVjdDogW1BBVENIXSBr
YnVpbGQ6IG1ha2UgcGFja2FnZSBidWlsZHMgbW9yZSByb2J1c3QKClJ1bm5pbmcgJ21ha2UgZGVi
LXBrZycgaW4gYSBkaXJ0eSByZXBvc2l0b3J5ICh0aGF0IGlzLCAnZ2l0IGRpZmYnCm91dHB1dHMg
c29tZXRoaW5nKSBoYXMgc29tZSBwcm9ibGVtcy4KClsxXSBJZiBhIGZpbGUgcGF0aCBjb250YWlu
cyB3aGl0ZXNwYWNlcywgJ21ha2UgZGViLXBrZycgZmFpbHMgd2l0aAphbiBlcnJvciBtZXNzYWdl
IGxpa2UgZm9sbG93czoKCiAgZGlmZjogLi9zY3JpcHRzL3BhY2thZ2UvLi4vLi4vImEgYiI6IE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICAgIFtzbmlwXQogIGRwa2ctc291cmNlOiBlcnJvcjog
ZXhwZWN0ZWQgXkBAIGF0IGxpbmUgMiBvZiBkaWZmIC4uLgoKJ2dpdCBzdGF0dXMgLS1wb3JjZWxh
aW4nIGRvdWJsZS1xdW90ZXMgYSBmaWxlIHBhdGggdGhhdCBjb250YWlucwp3aGl0ZXNwYWNlcy4g
UmVtb3ZlIHRoZSBzdXJyb3VuZGluZyBkb3VibGUtcXVvdGVzLCBhbmQgYWRkIFRBQiB0byB0aGUK
JysrKycgbGluZSB0byBtYWtlIGl0IGEgdmFsaWQgcGF0Y2guIFRoaXMgaXMgdGhlIHNhbWUgYXMg
d2hhdCBHSVQgZG9lcy4KClNlZSBHSVQgY29tbWl0IDFhOWViM2I5ZDUwMyAoImdpdC1kaWZmL2dp
dC1hcHBseTogbWFrZSBkaWZmIG91dHB1dCBhCmJpdCBmcmllbmRsaWVyIHRvIEdOVSBwYXRjaCAo
cGFydCAyKSIpIGZvciByZWZlcmVuY2UuCgpJIGdhdmUgdXAgb3RoZXIgc3BlY2lhbCBjaGFyYWN0
ZXJzIHN1Y2ggYXMgVEFCLCBuZXcgbGluZS4gSXQgd291bGQgYmUKcG9zc2libGUgdG8gY3JlYXRl
IGEgcGF0Y2ggdGhhdCBHTlUgcGF0Y2ggYWNjZXB0cyBieSBxdW90aW5nIHRoZSBmaWxlCnBhdGhz
IChhbmQgJ2dpdCBkaWZmJyBkb2VzIHRoaXMpLCBidXQgZHBrZy1zb3VyY2UgZmFpbHMgYW55d2F5
LgoKWzJdIFRoZSBleGVjdXRhYmxlIGJpdCBpcyBsb3N0LgoKWzNdIFN5bWJvbGljIGxpbmtzIGFy
ZSBub3QgaGFuZGxlZC4KClJld3JpdGUgdGhlIGNvZGUgdG8gbWFrZSBpdCB3b3JrIG1vcmUgY29y
cmVjdGx5LgoKU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVs
Lm9yZz4KLS0tCiBzY3JpcHRzL3BhY2thZ2UvZ2VuLWRpZmYtcGF0Y2ggfCA3OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9wYWNrYWdlL2dlbi1kaWZm
LXBhdGNoIGIvc2NyaXB0cy9wYWNrYWdlL2dlbi1kaWZmLXBhdGNoCmluZGV4IGY4NDJhYjUwYTc4
MC4uNDA1YjdkMTkyNWE1IDEwMDc1NQotLS0gYS9zY3JpcHRzL3BhY2thZ2UvZ2VuLWRpZmYtcGF0
Y2gKKysrIGIvc2NyaXB0cy9wYWNrYWdlL2dlbi1kaWZmLXBhdGNoCkBAIC0yMSwyNCArMjEsNzcg
QEAgaWYgWyAhIC1zICIke2RpZmZfcGF0Y2h9IiBdOyB0aGVuCiBmaQogCiBnaXQgLUMgJHtzcmN0
cmVlfSBzdGF0dXMgLS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9YWxsIHwKLXdoaWxlIHJl
YWQgc3RhdCBwYXRoCit3aGlsZSByZWFkIC1yIHN0YXQgcGF0aAogZG8KLQlpZiBbICIke3N0YXR9
IiA9ICc/PycgXTsgdGhlbgotCi0JCWlmICEgZGlmZiAtdSAvZGV2L251bGwgIiR7c3JjdHJlZX0v
JHtwYXRofSIgPiAudG1wX2RpZmYgJiYKLQkJCSEgaGVhZCAtbjEgLnRtcF9kaWZmIHwgZ3JlcCAt
cSAiQmluYXJ5IGZpbGVzIjsgdGhlbgotCQkJewotCQkJCWVjaG8gIi0tLSAvZGV2L251bGwiCi0J
CQkJZWNobyAiKysrIGxpbnV4LyRwYXRoIgotCQkJCWNhdCAudG1wX2RpZmYgfCB0YWlsIC1uICsz
Ci0JCQl9ID4+ICR7dW50cmFja2VkX3BhdGNofQotCQlmaQorCWlmIFsgIiR7c3RhdH0iICE9ICc/
PycgXTsgdGhlbgorCQljb250aW51ZQogCWZpCi1kb25lCisKKwkjIHBhdGggbWF5IGJlIHF1b3Rl
ZCBpZiBpdCBjb250YWlucyB3aGl0ZXNwYWNlcy4gVW5xdW90ZSBpdAorCXBhdGg9IiR7cGF0aCNc
In0iCisJcGF0aD0iJHtwYXRoJVwifSIKKworCWNhc2UgIiR7cGF0aH0iIGluCisJKlxcKikKKwkJ
IyBHaXZlIHVwIGVzY2FwZSBzZXF1ZW5jZXMgc3VjaCBhcyBcbiwgXHQuCisJCSMgSXQgaXMgcG9z
c2libGUgdG8gY3JlYXRlIGEgcGF0Y2ggYnkgcXVvdGluZyBmaWxlIHBhdGhzCisJCSMgKGFuZCBp
dCBpcyB3aGF0IEdJVCBkb2VzKSBidXQgZHBrZy1zb3VyY2UgZmFpbHMgd2l0aAorCQkjICIuLi4g
cGF0Y2hlcyBmaWxlIHdpdGggQy1zdHlsZSBlbmNvZGVkIGZpbGVuYW1lIiBlcnJvci4KKwkJY29u
dGludWUKKwkJOzsKKwkqXCAqKQorCQkjIEdOVSBwYXRjaCBleHBlY3RzIFRBQiBvbiAtLS0vKysr
IGxpbmVzIGZvciBwYXRocyB3aXRoIHNwYWNlcy4KKwkJdGFiPSIkKHByaW50ZiAnXHQnKSIKKwkJ
OzsKKwkqKQorCQl0YWI9CisJCTs7CisJZXNhYworCisJaWYgWyAhIC1mICIke3BhdGh9IiBdOyB0
aGVuCisJCWNvbnRpbnVlCisJZmkKKworCWlmIFsgLUwgIiR7cGF0aH0iIF07IHRoZW4KKwkJZWNo
byAiZGlmZiAtLWdpdCBhLyR7cGF0aH0gYi8ke3BhdGh9IgorCQllY2hvICJuZXcgZmlsZSBtb2Rl
IDEyMDAwMCIKKwkJZWNobyAiLS0tIC9kZXYvbnVsbCIKKwkJZWNobyAiKysrIGIvJHtwYXRofSR7
dGFifSIKKwkJZWNobyAiQEAgLTAsMCArMSBAQCIKKwkJcHJpbnRmICIrIjsgcmVhZGxpbmsgIiR7
cGF0aH0iCisJCWVjaG8gJ1wgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZScKKwkJY29udGludWUK
KwlmaQorCisJaWYgWyAteCAiJHtwYXRofSIgXTsgdGhlbgorCQltb2RlPTEwMDc1NQorCWVsc2UK
KwkJbW9kZT0xMDA2NDQKKwlmaQorCisJaWYgWyAhIC1zICIke3BhdGh9IiBdOyB0aGVuCisJCWVj
aG8gImRpZmYgLS1naXQgYS8ke3BhdGh9IGIvJHtwYXRofSIKKwkJZWNobyAibmV3IGZpbGUgbW9k
ZSAke21vZGV9IgorCQljb250aW51ZQorCWZpCisKKwlpZiBkaWZmIC11IC9kZXYvbnVsbCAiJHtz
cmN0cmVlfS8ke3BhdGh9IiA+IC50bXBfZGlmZiB8fCBbICIkPyIgIT0gMSBdOyB0aGVuCisJCWNv
bnRpbnVlCisJZmkKKworCWlmIFsgIiQoaGVhZCAtbjYgLnRtcF9kaWZmKSIgPSBCaW5hcnkgXSA7
IHRoZW4KKwkJY29udGludWUKKwlmaQorCisJZWNobyAiZGlmZiAtLWdpdCBhLyR7cGF0aH0gYi8k
e3BhdGh9IgorCWVjaG8gIm5ldyBmaWxlIG1vZGUgJHttb2RlfSIKKwllY2hvICItLS0gL2Rldi9u
dWxsIgorCWVjaG8gIisrKyBiLyR7cGF0aH0ke3RhYn0iCisJY2F0IC50bXBfZGlmZiB8IHRhaWwg
LW4gKzMKK2RvbmUgPiAiJHt1bnRyYWNrZWRfcGF0Y2h9IgogCiBybSAtZiAudG1wX2RpZmYKIAog
aWYgWyAhIC1zICIke2RpZmZfcGF0Y2h9IiBdOyB0aGVuCiAJcm0gLWYgIiR7ZGlmZl9wYXRjaH0i
Ci0JZXhpdAogZmkKLS0gCjIuMzcuMgoK
--000000000000e7b1ba05f850fff2--
