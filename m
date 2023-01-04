Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AE65DC8E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjADTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjADTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:10:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF01B9E4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:10:24 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so20832142wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilj2KW0qjeWq4JNOJi01uQI8ke0CdNrLzaGwAQB1lz8=;
        b=Irszmc7MhAeQdY0r5fVuhZK/xadj3VjTXaYktC+rKyqC1hySLPBlui8Bbul/RhwtKr
         XgXE+9IbEI50+mDalR3GMcDY6xcOS00nigpWV3yv6bLGfDGU1KzuDMxQDFCnUicDjiwE
         fZmuSriWBlNMOnNpeLE3gbgMOIxcPogWEvf6fUQdOzLc0ALwgFrO5chHmuj45KImszfY
         0dhWhXvCq5pEYiuih+B6ReVaBbiLDco1Ndq+aSwljv7gbTz5MQF/MLQoCxHW4248Ru9B
         xZe1OCV3hZBjCj8ZTvUx7tEBx1uihq7YLhItsYmG2yDYPTa7eqSCgYAT6x9KzrkW6kkE
         Rw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ilj2KW0qjeWq4JNOJi01uQI8ke0CdNrLzaGwAQB1lz8=;
        b=HFtZ3W17d/qILsb8WpMcyZEJXiAxXlv3i69G5J1R/Q9cUKbSyVaRq0ktV6HhE+bbQF
         H1TCl7uTKVClA25ekzC8yWrBpPe5wB/ZRT+oebbRiRr/X8wcqbNyMYhxWelePA0L46i+
         H4UiI4NTXLB9wpmAG60rAY/mAlUdys9VRC90n3TQpavb/UQXEsI14v2Al6oq9t0V/sug
         clu4MIZ6t8Yu6yR2f1noaBoqWvTyOb9Kr4EVxcbHdaCrEy78+i0vD/6iruA2sLl3LvxE
         QHQNEWRx86myI1LFl0L1jB195eMtZXycBNNu9USlxnmzkRLLi+6uRyUUslWUHks/dlfv
         3XSw==
X-Gm-Message-State: AFqh2kqrJj9rxmxYKNYIsky7RMjImVNcNLqLN+rtzTCmquNX9G/X7ssN
        OAaEuydNQ+efR6tWSkLRZARnKC2Z6t0Tcj6KWAPkng==
X-Google-Smtp-Source: AMrXdXv1pyNrnbDRKSUV58PHbta29R1XIRpzZEghnd6kfbiYU6KKJ8yQxX33JH15ZTEw3xfLolLrpyj6BfBhxJlf5bE=
X-Received: by 2002:a05:6000:1367:b0:28c:295f:3369 with SMTP id
 q7-20020a056000136700b0028c295f3369mr745618wrz.355.1672859423016; Wed, 04 Jan
 2023 11:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7SA839SDcpf+Ll0@monkey> <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
 <Y7Sq+Rs9cpSaHZSk@monkey>
In-Reply-To: <Y7Sq+Rs9cpSaHZSk@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 4 Jan 2023 19:10:11 +0000
Message-ID: <CADrL8HV73m0nVJOK3uv4sbyGKOVZhVxSv2+i4pUV7tozu6vW5Q@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000abb96105f174efd4"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000abb96105f174efd4
Content-Type: text/plain; charset="UTF-8"

> > I'll see if I can confirm that this is indeed possible and send a
> > repro if it is.
>
> I think your analysis above is correct.  The key being the failure to unshare
> in the non-PUD_SIZE vma after the split.

I do indeed hit the WARN_ON_ONCE (repro attached), and the MADV wasn't
even needed (the UFFDIO_REGISTER does the VMA split before "unsharing
all PMDs"). With the fix, we avoid the WARN_ON_ONCE, but the behavior
is still incorrect: I expect the address range to be write-protected,
but it isn't.

The reason why is that hugetlb_change_protection uses huge_pte_offset,
even if it's being called for a UFFDIO_WRITEPROTECT with
UFFDIO_WRITEPROTECT_MODE_WP. In that particular case, I'm pretty sure
we should be using huge_pte_alloc, but even so, it's not trivial to
get an allocation failure back up to userspace. The non-hugetlb
implementation of UFFDIO_WRITEPROTECT seems to also have this problem.

Peter, what do you think?

>
> To me, the fact it was somewhat difficult to come up with this scenario is an
> argument what we should just unshare at split time as you propose.  Who
> knows what other issues may exist.
>
> > 60dfaad65a ("mm/hugetlb: allow uffd wr-protect none ptes") is the
> > commit that introduced the WARN_ON_ONCE; perhaps it's a good choice
> > for a Fixes: tag (if above is indeed true).
>
> If the key issue in your above scenario is indeed the failure of
> hugetlb_unshare_all_pmds in the non-PUD_SIZE vma, then perhaps we tag?
>
> 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when
> register wp")

SGTM. Thanks Mike.

--000000000000abb96105f174efd4
Content-Type: text/x-csrc; charset="US-ASCII"; name="pmd-share-repro.c"
Content-Disposition: attachment; filename="pmd-share-repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lci0rukw0>
X-Attachment-Id: f_lci0rukw0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8ZmNudGwu
aD4KI2luY2x1ZGUgPGxpbnV4L21lbWZkLmg+CiNpbmNsdWRlIDxsaW51eC9tbWFuLmg+CiNpbmNs
dWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8bGludXgvdXNlcmZhdWx0ZmQuaD4KI2luY2x1ZGUg
PGxpbnV4L2Vycm5vLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUg
PHN5cy9pb2N0bC5oPgoKI2RlZmluZSBQQUdFU19QRVJfR0lHIDUxMgojZGVmaW5lIEhVR0VfUEFH
RV9TSVpFICgyVUwgPDwgMjApCiNkZWZpbmUgR0lHX01BU0sgfihQQUdFU19QRVJfR0lHICogSFVH
RV9QQUdFX1NJWkUgLSAxKQoKdm9pZCBmYXVsdF9pbl93cml0ZShjaGFyICptYXBwaW5nLCBzaXpl
X3QgbGVuKQp7Cgl2b2xhdGlsZSBjaGFyICptYXBwaW5nX3YgPSBtYXBwaW5nOwoJZm9yIChzaXpl
X3QgaSA9IDA7IGkgPCBsZW47IGkgKz0gNDA5NikKCQltYXBwaW5nX3ZbaV0gPSAxOwp9CgppbnQg
bWFpbigpCnsKCWludCBmZCA9IG1lbWZkX2NyZWF0ZSgidGVzdCIsIE1GRF9IVUdFVExCKTsKCXNp
emVfdCBsZW4gPSAyICogUEFHRVNfUEVSX0dJRyAqIEhVR0VfUEFHRV9TSVpFOwoJY2hhciAqbWFw
cGluZzsKCWNoYXIgKm1hcHBpbmdfdG9fdXNlOwoJaW50IHVmZmQ7CglpbnQgcGlkOwoJc3RydWN0
IHVmZmRpb19hcGkgdWZmZGlvX2FwaTsKCXN0cnVjdCB1ZmZkaW9fcmVnaXN0ZXIgdWZmZGlvX3Jl
Z2lzdGVyOwoJc3RydWN0IHVmZmRpb193cml0ZXByb3RlY3QgdWZmZGlvX3dyaXRlcHJvdGVjdDsK
CglpZiAoZnRydW5jYXRlKGZkLCBsZW4pKSB7CgkJcGVycm9yKCJmdHJ1bmNhdGUgZmFpbGVkIik7
CgkJcmV0dXJuIC0xOwoJfQoJbWFwcGluZyA9IG1tYXAoTlVMTCwgbGVuLCBQUk9UX1dSSVRFIHwg
UFJPVF9SRUFELCBNQVBfU0hBUkVELCBmZCwgMCk7CglpZiAobWFwcGluZyA9PSBNQVBfRkFJTEVE
KSB7CgkJcGVycm9yKCJtbWFwIGZhaWxlZCIpOwoJCXJldHVybiAtMTsKCX0KCgltYXBwaW5nX3Rv
X3VzZSA9IG1hcHBpbmc7CglpZiAoKHVuc2lnbmVkIGxvbmcpbWFwcGluZyAmIH5HSUdfTUFTSykg
ewoJCW1hcHBpbmdfdG9fdXNlID0gKGNoYXIgKikoKHVuc2lnbmVkIGxvbmcpbWFwcGluZyAmIEdJ
R19NQVNLKSArIChsZW4vMik7Cgl9CgoJcGlkID0gZm9yaygpOwoJaWYgKHBpZCA8IDApIHsKCQlw
ZXJyb3IoImZvcmsgZmFpbGVkIik7CgkJcmV0dXJuIC0xOwoJfQoKCWZhdWx0X2luX3dyaXRlKG1h
cHBpbmcsIGxlbik7CgoJaWYgKHBpZCA+IDApIHsKCQlpbnQgc3RhdHVzOwoJCXdhaXRwaWQocGlk
LCAmc3RhdHVzLCAwKTsKCQlyZXR1cm4gV0VYSVRTVEFUVVMoc3RhdHVzKTsKCX0KCgl1ZmZkID0g
c3lzY2FsbChTWVNfdXNlcmZhdWx0ZmQsIE9fQ0xPRVhFQyk7Cgl1ZmZkaW9fYXBpLmFwaSA9IFVG
RkRfQVBJOwoJdWZmZGlvX2FwaS5mZWF0dXJlcyA9IFVGRkRfRkVBVFVSRV9TSUdCVVM7Cgl1ZmZk
aW9fYXBpLmlvY3RscyA9IDA7CglpZiAoaW9jdGwodWZmZCwgVUZGRElPX0FQSSwgJnVmZmRpb19h
cGkpKSB7CgkJcGVycm9yKCJVRkZESU9fQVBJIGZhaWxlZCIpOwoJCXJldHVybiAtMTsKCX0KCgl1
ZmZkaW9fcmVnaXN0ZXIucmFuZ2Uuc3RhcnQgPSAodW5zaWduZWQgbG9uZyltYXBwaW5nX3RvX3Vz
ZTsKCXVmZmRpb19yZWdpc3Rlci5yYW5nZS5sZW4gPSBsZW4vNDsKCXVmZmRpb19yZWdpc3Rlci5t
b2RlID0gVUZGRElPX1JFR0lTVEVSX01PREVfV1A7CgoJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19S
RUdJU1RFUiwgJnVmZmRpb19yZWdpc3RlcikpIHsKCQlwZXJyb3IoIlVGRkRJT19SRUdJU1RFUiBm
YWlsZWQiKTsKCQlyZXR1cm4gLTE7Cgl9CgoJdWZmZGlvX3dyaXRlcHJvdGVjdC5yYW5nZS5zdGFy
dCA9ICh1bnNpZ25lZCBsb25nKW1hcHBpbmdfdG9fdXNlOwoJdWZmZGlvX3dyaXRlcHJvdGVjdC5y
YW5nZS5sZW4gPSBsZW4vNDsKCXVmZmRpb193cml0ZXByb3RlY3QubW9kZSA9IFVGRkRJT19XUklU
RVBST1RFQ1RfTU9ERV9XUDsKCWlmIChpb2N0bCh1ZmZkLCBVRkZESU9fV1JJVEVQUk9URUNULCAm
dWZmZGlvX3dyaXRlcHJvdGVjdCkpIHsKCQlwZXJyb3IoIlVGRkRJT19XUklURVBST1RFQ1QgZmFp
bGVkIik7CgkJcmV0dXJuIC0xOwoJfQoKCS8qIElmIGNvcnJlY3Q6IHNob3VsZCBTSUdCVVMgKi8K
CWZhdWx0X2luX3dyaXRlKG1hcHBpbmdfdG9fdXNlLCAxKTsKCglwcmludGYoIkJVRzogbm8gc2ln
YnVzXG4iKTsKCXJldHVybiAwOwp9Cg==
--000000000000abb96105f174efd4--
