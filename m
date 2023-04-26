Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791BA6EFD10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjDZWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbjDZWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:08:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BB230EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:08:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51efefe7814so7708003a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682546880; x=1685138880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRRT1JLj5LjVJGBzDSlmTfM7cyr5YAX9h/3Myc2de1I=;
        b=pjQw7QYK9BB2pMV/QaLm+IMj83pHs4ZI2FsGlXF1qxQrOOs/kb37GCGIjRiPtSBplM
         HZFALGKiEPoDYjKrL/xmsBkYZ/eNEW8XaqWjZzW1iJfOrbZ5BfroedmAxhR5724JPORf
         DfXj5feRu/YwyI2vy0ucwMVdatNJGgLAskbx8IlgTOm/dscWl1QFOiROwGNVDN7uwjsT
         yIdPovwGCDW8FveLveGOXVUEC70eIW8bb/OPWGlPRI0iZHYmN+6TpLvrYzpXk1ArKbvJ
         RS+8H5OAzWFGjgqop/0FgmlgELJL7YhK73jYxsuWP3Lpp8ST7iqL+CJl3kRnvjacr7Vg
         l45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682546880; x=1685138880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRRT1JLj5LjVJGBzDSlmTfM7cyr5YAX9h/3Myc2de1I=;
        b=iWKb+8bIsq0ZDpFz+KTT1LTC3B6wzHqPjj57liPLoDSghy5lPlGzIGsY6VpMPP0zOU
         bPCrtR0O12Z8rb407vBy7QiY0Iw7C+LbPc8MNrflX89rsP3U0pVsJYh/UIWiF5LIVJIF
         aXfRbXFmHYncr3dlLF9B2BOeeswpuh220mx3WynoaQlUCSYyglPZ6+5JOBkGm0qmlJ0C
         AWb7TjB7trIutzE9lRJIfZ5NjXshgZWKohi5GUd4NpWiL+wSwkTYntUf7RN9dRCl9iTD
         jecOeUvLkFg7BdXp1FPxTSaGQbU3ZrInpmSefUPUk7fnKhQhAa1eP7qtCYiiqYHES4k3
         rByA==
X-Gm-Message-State: AAQBX9e1zrlVUUnh4RauS41c01Gw49m8t1vdzGdOyqL5uSVLkoH6tb2v
        RH0fXrR3DAPhKzPxtqYDHLPizyOENvKSDsSuJafS5OZH05s7F62woFCUqA==
X-Google-Smtp-Source: AKy350YEQK2YcFvxW+tZ4RwePGpH2SoL6ZVR2Ng7FDiNxIRK+3oqcHDH8LTMcodQMoXj3e++WVPh9YXcvWlgdyMnCHw=
X-Received: by 2002:a17:90b:143:b0:246:9a4f:8b2e with SMTP id
 em3-20020a17090b014300b002469a4f8b2emr21659612pjb.1.1682546879653; Wed, 26
 Apr 2023 15:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com> <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
In-Reply-To: <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 15:07:48 -0700
Message-ID: <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:33=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 26, 2023 at 11:22=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Ah, it does do something in the callee, not the caller:
>
> Ack, it does seem to have _some_ meaning for the return case, just not
> the one we'd be looking for as a way to find mistakes in the
> error-pointer case.

Is this what you had in mind?
```
$ cat linus.c
#define NULL ((void*)0)

void * _Nonnull foo (void) {
    return &foo;
}

void bar (void) {
    if (foo() =3D=3D NULL) // maybe should warn that foo() returns _Nonnull=
?
        bar();
}
$ clang linus.c -fsyntax-only
linus.c:8:15: warning: comparison of _Nonnull function call 'foo'
equal to a null pointer is always false
[-Wtautological-pointer-compare]
    if (foo() =3D=3D NULL) // maybe should warn that foo() returns _Nonnull=
?
              ^
linus.c:3:1: note: return type has '_Nonnull' nullability attribute
void * _Nonnull foo (void) {
^
1 warning generated.
```

Quick PoC, obviously incomplete.
```
diff --git a/clang/include/clang/Basic/DiagnosticSemaKinds.td
b/clang/include/clang/Basic/DiagnosticSemaKinds.td
index 18a0154b0041..10e405b1cf65 100644
--- a/clang/include/clang/Basic/DiagnosticSemaKinds.td
+++ b/clang/include/clang/Basic/DiagnosticSemaKinds.td
@@ -3975,8 +3975,9 @@ def note_xor_used_as_pow_silence : Note<
   "replace expression with '%0' %select{|or use 'xor' instead of '^'
}1to silence this warning">;

 def warn_null_pointer_compare : Warning<
-    "comparison of %select{address of|function|array}0 '%1' %select{not |}=
2"
-    "equal to a null pointer is always %select{true|false}2">,
+    "comparison of %select{address of|function|array|_Nonnull function cal=
l}0 "
+    "'%1' %select{not |}2equal to a null pointer is always "
+    "%select{true|false}2">,
     InGroup<TautologicalPointerCompare>;
 def warn_nonnull_expr_compare : Warning<
     "comparison of nonnull %select{function call|parameter}0 '%1' "
@@ -3992,6 +3993,8 @@ def warn_address_of_reference_null_compare : Warning<
   "code; comparison may be assumed to always evaluate to "
   "%select{true|false}0">,
   InGroup<TautologicalUndefinedCompare>;
+def note_return_type_nonnull :
+  Note<"return type has '_Nonnull' nullability attribute">;
 def note_reference_is_return_value : Note<"%0 returns a reference">;

 def note_pointer_declared_here : Note<
diff --git a/clang/lib/Sema/SemaChecking.cpp b/clang/lib/Sema/SemaChecking.=
cpp
index f66eb9fcf13d..9f6d326f5b72 100644
--- a/clang/lib/Sema/SemaChecking.cpp
+++ b/clang/lib/Sema/SemaChecking.cpp
@@ -13176,6 +13176,22 @@ static void AnalyzeImpConvsInComparison(Sema
&S, BinaryOperator *E) {
 ///
 /// \param E the binary operator to check for warnings
 static void AnalyzeComparison(Sema &S, BinaryOperator *E) {
+  if (auto Call =3D dyn_cast<CallExpr>(E->getLHS())) {
+    QualType RetType =3D Call->getCallReturnType(S.Context);
+    if (std::optional<NullabilityKind> NK =3D RetType->getNullability()) {
+      if (*NK =3D=3D NullabilityKind::NonNull &&
+        E->getRHS()->isNullPointerConstant(S.Context,
+
Expr::NPC_ValueDependentIsNotNull)) {
+        std::string result;
+        llvm::raw_string_ostream os(result);
+        Call->getDirectCallee()->getNameForDiagnostic(os,
S.getLangOpts(), true);
+        S.Diag(E->getExprLoc(), diag::warn_null_pointer_compare) << 3 <<
+          result << true;
+        S.Diag(Call->getDirectCallee()->getReturnTypeSourceRange().getBegi=
n(),
+               diag::note_return_type_nonnull);
+      }
+    }
+  }
   // The type the comparison is being performed in.
   QualType T =3D E->getLHS()->getType();


```


--=20
Thanks,
~Nick Desaulniers
