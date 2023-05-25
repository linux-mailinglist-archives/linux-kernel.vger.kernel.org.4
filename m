Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E0711785
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbjEYTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjEYTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:41:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F37D9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:40:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so113778b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685043601; x=1687635601;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEmGAtI8oiBqs6giQHMETTrfUYXqluc/PIUvscfOPi4=;
        b=P4M7mwBvmlH+1usS9OQSoRiOO+sCqH+eyrMaDmkVrnfSiusVXbWv27kJ/Etgagw4fY
         ZiVQU+bmR4U0b0V1cuxRplj3PtCAhdthVLYhHvWcQe6H4FF4gskz/HKiUi0rbCRLi8L0
         LcgIFa+57igPZ/VDJPemugLnNtHkvAVSTdZOdXPI6YEXLrj0Jhom6TMJoeoUE05cu433
         vWTwXdv69td1SeuldtjxMrdtzISADgu1trMKIGP+mRdUk+ylSu3P8FZ8ajcqspmvQVlw
         v7kMVk9+YMfvGsdyAmlA3x1GPAoTw9GIltVkgEE6t3E4IXbb1JWln1nKcTdDCl0+d6pX
         lHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685043601; x=1687635601;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEmGAtI8oiBqs6giQHMETTrfUYXqluc/PIUvscfOPi4=;
        b=DhsAOmnn3NfmP6THk+p01BkPkaNsU3R+IK/aDlPq5NITisA1pX/+MEYSuyk8NLa3pI
         F/tyVnO6QF4a5KvnZyd+0K3rvPN7E0cxyObMcTTVTc9BAcgHJOpA0aLCoRLq7dL3f0Gh
         +xeaVUHFQ553tGYsQVJOVsFsVQwFOLAriKQmZN5hfVyv6V6ead0jYmwDP+WUiGlDs7j+
         bJAGrcMvQU0mYDvppCu1/PRy0ir/Rg9u2THDT7NGe8PFRCfsyJPJX+36KxyF+oj/ULlv
         PWC/bP2Z8sSQA4AgLHtCoKAlR2mcyunZBRPAGC9ap/gydwHwbELtCgGI54ZMu2nf77o8
         YTiQ==
X-Gm-Message-State: AC+VfDwLGoc/tahAvDOvG3qg4Dq0EBDIEN8mLuzYCgksaSfFVkwJw0og
        mNMZD1XnwZcNRQoEigIyduE=
X-Google-Smtp-Source: ACHHUZ7sYotBdfnfVrPJoKfln6f0PaD5Dlbm/jyziOdlPS/iT6D6ixQHBvRFw+YO9E6I4pG72SEJLg==
X-Received: by 2002:a05:6a00:218b:b0:64d:2487:5b20 with SMTP id h11-20020a056a00218b00b0064d24875b20mr10545315pfi.9.1685043600470;
        Thu, 25 May 2023 12:40:00 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id r2-20020a654982000000b0050bc4ca9024sm1368748pgs.65.2023.05.25.12.39.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 12:39:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
Date:   Thu, 25 May 2023 12:39:47 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jirislaby@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 25, 2023, at 12:05 PM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 5/25/23 11:42, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> When SYM_CODE_START_LOCAL() is used, the symbols are local but need =
to
>> be preserved in the object. However, using the ".L" label prefix does
>> not retain the symbol in the object.
>>=20
>> It is beneficial to be able to map instruction pointers back to =
symbols,
>> for instance for profiling. Otherwise, there are code addresses that =
do
>> not map back to any symbol.  Consequently, the ".L" label prefix =
should
>> not be used when SYM_CODE_START_LOCAL() is used.
>>=20
>> Few symbols, such as .Lbad_put_user_clac and currently have both the
>> SYM_CODE_START_LOCAL() invocation and the ".L" prefix.  This commit
>> removes the ".L" prefix from these symbols.
>>=20
>> No functional change, other then emitting these symbols into the =
object,
>> is intended.
>=20
> Nadav, could you perhaps do a bit of research on how this situation =
came
> to be?  Was it an accident or on purpose that these symbols came to be
> .L?  Then, could you CC the folks who made this change and ask them
> directly if they intended to induce the effects that you find =
undesirable?

Fair enough. I actually thought it is an oversight, but it now seems
intentional (although I am not sure I understand/agree with the reason).=20=


So apparently, for one of the symbols from my v1 (which was already
removed), I see that Borislav Petkov suggested to prepend the =E2=80=9C.L=E2=
=80=9D in
order to for them not to be visible [1].

The reason that is given for not making the functions visible is that
these are "functions with very local names=E2=80=9D.

I do not think in this tradeoff not exposing local names worth
preventing profilers (and their users) from understanding where a
sample/trace is was taken. If for instance you look at a branch
trace (e.g., using Intel PT) you want to see the symbol to which a
branch goes to.

Borislav, Jiri - do you agree?


[1] https://lore.kernel.org/all/20190906075550.23435-2-jslaby@suse.cz/

