Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEA607D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJURMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJURMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:12:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517D27211F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:12:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so2215139qvn.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fA23PvnW2TkEor3AGh4qqWJ27zBPKP6Rq7CyNG5ZoaQ=;
        b=F9iesT9sVOBML10kVss+fxf/+/rIWx7ZVI0+qHddifn2dCRWDIjFZFYxS5vQRMMowi
         fH1ez7hyh0pthAxEdO8vzPtuVNHasINp6Ow6mf9CF9QMw+xAdkzSsS8d6HT3ohx92eY1
         73gEQNXDvyI8VcMSyIyjBwhbaVSF4uw2hPjP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fA23PvnW2TkEor3AGh4qqWJ27zBPKP6Rq7CyNG5ZoaQ=;
        b=D0n421RgJVkzBgozB4RVUSwdmvHtCNy1OEcaUjsiOOCI7Z8g7+Otl0DWAGjW6CpPQD
         uYdsPhYpwUkM54TJ76y9sonFkA7i3jKtH+xQub3Bw6ZninGwaKX2yk/NtBUl9NrBT3fA
         bX9HPfR0cJclBZKR5ZEwyQzCKUTj/I0GqCtaRxwewStd6KvMOpuKtKbiwdaC1QPriMLJ
         osJNI/5CkN/czvEgPjZcDQsE+vFst3ccACL04JA2eewV+czfKQBe5zto/2a06sr/ns2a
         0ef5Fv07Z6oTsK9dwkLjDoSCvIfehDXqU3sFuCzXCMiHw/u8d5KipvfkhrUmyXCGd+3B
         AW2g==
X-Gm-Message-State: ACrzQf39iiZot5FnILXGgPsStYKovGTuMs7fHShmDWZV7v+AoGWwWQ0N
        jj5TVoXyLd29MWfPzNePyq1v1D+69bK5Lg==
X-Google-Smtp-Source: AMsMyM56TjjeQ4lzXVGmE6JWk+IyAZNicSA01x0WbxjDxrRHRSCVRBev7TKkBzL1+DnMLHUA30bI7w==
X-Received: by 2002:a0c:e2c8:0:b0:4b7:c1bf:784a with SMTP id t8-20020a0ce2c8000000b004b7c1bf784amr9983306qvl.17.1666372331444;
        Fri, 21 Oct 2022 10:12:11 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm9710236qko.6.2022.10.21.10.12.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 10:12:09 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-36a4b86a0abso13492087b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:12:08 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr17690127ywr.401.1666372328545; Fri, 21
 Oct 2022 10:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com> <Y1I1S86zbBmeJ+jq@localhost.localdomain>
In-Reply-To: <Y1I1S86zbBmeJ+jq@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 10:11:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb3RYTPd24rXs8dRdiqiPAzq7uc4Suxu1On6_DTDnf5g@mail.gmail.com>
Message-ID: <CAHk-=wgb3RYTPd24rXs8dRdiqiPAzq7uc4Suxu1On6_DTDnf5g@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
Content-Type: multipart/mixed; boundary="000000000000b548f505eb8e8ad9"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b548f505eb8e8ad9
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 10:59 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> It is very entertaining, i've given up and started patching sparse
> but it needs more because char constants are ints:

I think you can fix that by simply warning about character constants
with the high bit set.

Something like this..

              Linus

--000000000000b548f505eb8e8ad9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l9ir1rfw0>
X-Attachment-Id: f_l9ir1rfw0

IGNoYXIuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2NoYXIuYyBiL2NoYXIuYwppbmRleCA3MzBhZTNmNS4uMzcwNmUwMzMgMTAwNjQ0Ci0t
LSBhL2NoYXIuYworKysgYi9jaGFyLmMKQEAgLTkzLDYgKzkzLDEwIEBAIHZvaWQgZ2V0X2NoYXJf
Y29uc3RhbnQoc3RydWN0IHRva2VuICp0b2tlbiwgdW5zaWduZWQgbG9uZyBsb25nICp2YWwpCiAJ
aWYgKHAgIT0gZW5kKQogCQl3YXJuaW5nKHRva2VuLT5wb3MsCiAJCQkibXVsdGktY2hhcmFjdGVy
IGNoYXJhY3RlciBjb25zdGFudCIpOworCWlmICh2ICYgMHg4MCkgeworCQlpZiAodHlwZSA+PSBU
T0tFTl9DSEFSICYmIHR5cGUgPD0gVE9LRU5fQ0hBUl9FTUJFRERFRF8zKQorCQkJd2FybmluZyh0
b2tlbi0+cG9zLCAiY2hhcmFjdGVyIGNvbnN0YW50IHdpdGggc2lnbiBiaXQgc2V0Iik7CisJfQog
CSp2YWwgPSB2OwogfQogCg==
--000000000000b548f505eb8e8ad9--
