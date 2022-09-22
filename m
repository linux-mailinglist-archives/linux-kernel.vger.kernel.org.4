Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E15E5A52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIVEnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIVEnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:43:13 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521391D33
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:43:10 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j17so9065892vsp.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0U1WxYq40AAgBK4bZqBofScwl1/9WJx0tRRhfYQRLfM=;
        b=LQL4bsUytcpqdjBB3AiHn2RQpTtGxgvpa6h10kjOmK1ccUNdDcFvPhP/Ds1yNrqO8c
         V/HoSjugg+NNvb2yegfrV+CvpM9d5RcUEfG+iTvszutRjTBY51+cF9MEtGNRLDSF+Ug7
         fGdltD+96jmDkN+XzUJX5/7SgMVdR2US9Z0OZ+tESDmtH3WxdANdbgfmVjPBH2FNt4+R
         0SBwxwcXktysX3F5c08kfcYoD2BWPny1Qnw/YKH2EMNmsv5Tr/vV3S8t5Co/yNit6sly
         u3sT9cJJOz7G4IVrK/Zi9QUYIPa2vVry/Lgml6dK6ej1TaH7+cDwHAgrRSSzStcHiOr/
         ezKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0U1WxYq40AAgBK4bZqBofScwl1/9WJx0tRRhfYQRLfM=;
        b=LxxTIeCI49qrZ4EWjI/cG7DlXUzkAGCv35eHIAPj2NI+/KGRG2v1N19VbTk4W40h4R
         IwcZOs9ryGG70c8/YsTMolh9qC49Q0P4FGxMn5omKvhmvrROJfs3itdjGTHoPpxWMquq
         qNdUqcajf8aG4BnYURO/fkTb9+cDlb+Mbh8Z9gtbFBPfC88EN3eDLNGlm5hmGXdlvkpL
         faGezxs9Gq0CM1+7oGsZxwubON2NCQKSNPjUGMPtcYcRZlq18ORgJ6AAIs+M50nDHqVL
         LpCrwutXcCn0jWK1tFXX+JG/xCBnWnKHB9DNPWaVZGXpZay/ZYdySA4z21KLXqTwJBvS
         xy0w==
X-Gm-Message-State: ACrzQf2rL3ffCkiFXHSWrrsnpExp79mkIHuvV1ZcTOo7Cuu7aMz0RceH
        HqDX9ZdRxWj3cXCcEEXFHoHyJggIGiyJogJgon7w7g==
X-Google-Smtp-Source: AMsMyM5kLyaz1U/FO5bZl9wkYv0DGr9Bypgpz/3fk6hoX4sYGz7WbcY39imzvESsweGye7WRkfcatjaOmHauOPT1WfY=
X-Received: by 2002:a67:fb8a:0:b0:398:9d72:bddf with SMTP id
 n10-20020a67fb8a000000b003989d72bddfmr561911vsr.38.1663821789458; Wed, 21 Sep
 2022 21:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220921064855.2841607-1-davidgow@google.com> <CAKwvOdnLaDn=EfGFhjhcZe4EzvjU7Cws3z3KjLGwW=xnqnmHyw@mail.gmail.com>
In-Reply-To: <CAKwvOdnLaDn=EfGFhjhcZe4EzvjU7Cws3z3KjLGwW=xnqnmHyw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Sep 2022 12:42:58 +0800
Message-ID: <CABVgOSmw5KVfFU7GHZNMEReVYiX228p2yMZ77YoJzPHoZKXkOw@mail.gmail.com>
Subject: Re: [PATCH v2] arch: um: Mark the stack non-executable to fix a
 binutils warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>, x86@kernel.org,
        Lukas Straub <lukasstraub2@web.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c02b0605e93cb2f9"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c02b0605e93cb2f9
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 22, 2022 at 1:47 AM 'Nick Desaulniers' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Tue, Sep 20, 2022 at 11:49 PM David Gow <davidgow@google.com> wrote:
> >
> > Since binutils 2.39, ld will print a warning if any stack section is
> > executable, which is the default for stack sections on files without a
> > .note.GNU-stack section.
> >
> > This was fixed for x86 in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments"),
> > but remained broken for UML, resulting in several warnings:
> >
> > /usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
> > /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
> > /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
> > /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
> > /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
> > /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
> >
> > Link both the VDSO and vmlinux with -z noexecstack, fixing the warnings
> > about .note.GNU-stack sections. In addition, pass --no-warn-rwx-segments
> > to dodge the remaining warnings about LOAD segments with RWX permissions
> > in the kallsyms objects. (Note that this flag is apparently not
> > available on lld, so hide it behind a test for BFD, which is what the
> > x86 patch does.)
> >
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
> > Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
> > Signed-off-by: David Gow <davidgow@google.com>
> > Reviewed-by: Lukas Straub <lukasstraub2@web.de>
> > Tested-by: Lukas Straub <lukasstraub2@web.de>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > ---
> >
> > Note that this still doesn't seem to be working properly with make
> > LLVM=1. It doesn't appear to break anything, and still is an improvement
> > for gcc, so seems worthwhile anyway...
>
> Hi David,
> Do you have more info about this comment?  Perhaps there's more
> hermiticity issues with ARCH=um when a linker is explicitly specified
> via LD= or HOSTLD=, or implied via LLVM=1.
>
> Looking at our CI for ARCH=um builds...
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/3095779516/jobs/5012260390
> warnings from /usr/bin/ld. That's...unexpected.
> I've filed https://github.com/ClangBuiltLinux/linux/issues/1715 to
> follow up on this.
>

Thanks for following up on this.

Yeah: what I'm seeing seems to match  it does look like ld is being
used instead of lld.

I tried -fuse-ld=lld via the following patch, though, and got a whole
bunch of "error: relocation R_X86_64_64 cannot be used against local
symbol; recompile with -fPIC" errors, so I think there's probably more
issues with UML and LLD that need working out. (I had no luck with
CONFIG_STATIC_LINK=y, nor with an attempt to use $(LD) directly,
instead of via $(CC)).

---
diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..01d9eae736be 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -139,6 +139,9 @@ ifeq ($(CONFIG_LD_IS_BFD),y)
LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
endif

+# Since we're using CC as the driver, we need to force LLD if it is requested.
+LINK-$(CONFIG_LD_IS_LLD) += $(call cc-option,--ld-path=$(LD),-fuse-ld=lld)
+
LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))

# Used by link-vmlinux.sh which has special support for um link

---

I'll update the GitHub issue with these notes as well, but I
definitely think it'd be best not to make UML use lld here until it
actually builds something: even with the warnings, ld is at least
latting us run at all.

Cheers,
-- David

> >
> > Changes since v1:
> > http://lists.infradead.org/pipermail/linux-um/2022-August/004234.html
> > - Pass the -z noexecstack and --no-warn-rwx-segments flags as LDFLAGS,
> >   rather than as CFLAGS via -Wl
> > - Check that --no-warn-rwx-segments exists with the ld-option function
> >   (Thanks Richard)
> > - Add Lukas and Randy's tags.
> >
> >
> >  arch/um/Makefile          | 8 ++++++++
> >  arch/x86/um/vdso/Makefile | 2 +-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/um/Makefile b/arch/um/Makefile
> > index f2fe63bfd819..f1d4d67157be 100644
> > --- a/arch/um/Makefile
> > +++ b/arch/um/Makefile
> > @@ -132,10 +132,18 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
> >  # The wrappers will select whether using "malloc" or the kernel allocator.
> >  LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
> >
> > +# Avoid binutils 2.39+ warnings by marking the stack non-executable and
> > +# ignorning warnings for the kallsyms sections.
> > +LDFLAGS_EXECSTACK = -z noexecstack
> > +ifeq ($(CONFIG_LD_IS_BFD),y)
> > +LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
> > +endif
> > +
> >  LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
> >
> >  # Used by link-vmlinux.sh which has special support for um link
> >  export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
> > +export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
> >
> >  # When cleaning we don't include .config, so we don't include
> >  # TT or skas makefiles and don't clean skas_ptregs.h.
> > diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> > index 8c0396fd0e6f..6fbe97c52c99 100644
> > --- a/arch/x86/um/vdso/Makefile
> > +++ b/arch/x86/um/vdso/Makefile
> > @@ -65,7 +65,7 @@ quiet_cmd_vdso = VDSO    $@
> >                        -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
> >                  sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
> >
> > -VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
> > +VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
> >  GCOV_PROFILE := n
> >
> >  #
> > --
> > 2.37.3.968.ga6b4b080e4-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAKwvOdnLaDn%3DEfGFhjhcZe4EzvjU7Cws3z3KjLGwW%3DxnqnmHyw%40mail.gmail.com.

--000000000000c02b0605e93cb2f9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDx
wa22JvzOY3r0Bp7l1jvQV5pX5gLtFmP+3vYOUNvFZTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MjIwNDQzMDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAvbWK3rHexz5Y+fAhqr3
Mt96lOmiCjaxdsaf4kQhNSMpGvil/KQvjrJo9CQOylRnEK1E9XwSZNm1IZJuXi/ufImzRj40Y4XH
l+bzqNrzzVzxOuSE8FYYbBvVF+gxBsyiIDYPutcmOaBnrwQeJKNIQrolJTMM+EY5p94QjnIjNQGB
RXCw5TRMxcDQjFK71R2mU8PZYrmbo2Qp+qSWoZ1fLbI3i426qJQK4iomwNuAPcHFZsFzBia2ystC
Y+yDuBCre5bz+8WG9841N6IBlM0lQO0a/UP3tVT+mv7rKL46tT/pZTbkq171VcDaa0WTO+29CEGr
286+bDNVlovIJgMDxQ==
--000000000000c02b0605e93cb2f9--
