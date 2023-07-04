Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC0746793
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGDCaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGDCaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:30:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1FE59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:30:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98df3dea907so594410266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688437807; x=1691029807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aO7eVml/O3X6+0FbiNIO683uCX1yJlTsFWTwSAnwfZw=;
        b=SL8qA8aTYyLZtPQIBrBzUgO8eWCCxqiLdnKYPvDnOCCAuIoTpBSwRftLEhxWwN+ZLW
         7zWghFJjCwFWbCEZ77hGR/2EAhjZciJ76YXnffYImtyKNbhJBUNSDk9BJGx4unDJGMTZ
         suPcOn2OXDj0IWQU9j8EpWIQqybEtaG55qCl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688437807; x=1691029807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aO7eVml/O3X6+0FbiNIO683uCX1yJlTsFWTwSAnwfZw=;
        b=eaXESoAZuwQNW1Ji369s4uI0uE+ssUwF8R4dubnbS86X2CY4LdGkfa9RWJwbYwuijT
         pj8LJHV1FQAnCa0zmEsU9YoN4a66tmaLNhaQDq+Cmb77/A9nXCSbwINXhXbR48Vr7uIy
         DtDSMK3I72FhinT0eaF/NeQOPiRHtXKfPHVCqFlOsn+svOnJdoxYRiB0XaV40dzugXd1
         95BXO1mlM75ndmY6c7+Fq3IXPCHZXLta3AP+4J57nKXekDqP0bu0xzqv+DsvbULpIn1H
         f0ZHhnyt1LGj0vmBMSbbcrv75X2eno8o6R3JpxzkEJuEFo0VBrl/Wp8pzogkCTFTpHNl
         xlEw==
X-Gm-Message-State: AC+VfDyNoq+HxhW0fZ/ab0RGrIKvJwFIhT4lHPoFuYg6gKa8rvKOWHRi
        o03TK/58qgIabFzvIUUCIsLW2ehfYoVT3HKKMGPTKCl3
X-Google-Smtp-Source: APBJJlH5A55D9ai0xwlnZ8gexQcNjrzuY2lsMZQm23VRsHsYvFRuccgMS1TqXYLgzAIn25gAb+EojA==
X-Received: by 2002:a17:906:4e06:b0:992:2c5a:808e with SMTP id z6-20020a1709064e0600b009922c5a808emr9020722eju.7.1688437807227;
        Mon, 03 Jul 2023 19:30:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906831200b0098733a40bb7sm12673099ejx.155.2023.07.03.19.30.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 19:30:06 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so5723653a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 19:30:05 -0700 (PDT)
X-Received: by 2002:aa7:d8d9:0:b0:51d:e498:201 with SMTP id
 k25-20020aa7d8d9000000b0051de4980201mr8047997eds.27.1688437805666; Mon, 03
 Jul 2023 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020> <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
In-Reply-To: <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 19:29:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
Message-ID: <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: multipart/mixed; boundary="000000000000a1f7f705ffa00fe0"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a1f7f705ffa00fe0
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jul 2023 at 18:48, Oliver Sang <oliver.sang@intel.com> wrote:
>
> by patch [1], we found the warning is not fixed.

Hmm. I already committed that "fix" as obvious, since the main
difference in commit 408579cd627a ("mm: Update do_vmi_align_munmap()
return semantics") around that validate_mm() call was how it did that
mmap_read_unlock().

> we also found there are some changes in stack backtrace. now it's as below:
> (detail dmesg is attached)
>
> [   26.412372][    T1] stack backtrace:
> [   26.412846][    T1] CPU: 0 PID: 1 Comm: systemd Not tainted 6.4.0-09908-gcb226fb1fb7a #1
> [   26.413506][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   26.414326][    T1] Call Trace:
> [   26.414605][    T1]  <TASK>
> [   26.414847][    T1]  dump_stack_lvl+0x73/0xc0
> [   26.415225][    T1]  lockdep_rcu_suspicious+0x1b7/0x280
> [   26.415669][    T1]  mas_start+0x280/0x400
> [   26.416037][    T1]  mas_find+0x27a/0x400
> [   26.416391][    T1]  validate_mm+0x8b/0x2c0
> [   26.416757][    T1]  __se_sys_brk+0xa35/0xc00

Ok, that is indeed a very different stack trace.

So maybe the fix is a real fix, but the first complaint shut up
lockdep, so this is the *second* and unrelated complaint.

And indeed: it turns out that do_vma_munmap() does this:

        ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
        validate_mm(mm);

and so we have *another* validate_mm() that is now done outside the lock.

That one is actually pretty pointless. We've *just* validated the mm
already inside do_vmi_align_munmap(), except we only did it in one of
the two return cases.

So I think the fix is to just move that validate_mm() into the other
return case of do_vmi_align_munmap(), and remove it from the caller.

IOW, something like the attached (NOTE! This is in *addition* to the
previous patch, which is the same as the one you quoted, just with
slightly different whitespace as commit ae80b4041984: "mm: validate
the mm before dropping the mmap lock").

               Linus

--000000000000a1f7f705ffa00fe0
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljno9i7t0>
X-Attachment-Id: f_ljno9i7t0

IG1tL21tYXAuYyB8IDYgKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYwppbmRleCA1
NDdiNDA1MzE3OTEuLjIwNGRkY2Q1MjYyNSAxMDA2NDQKLS0tIGEvbW0vbW1hcC5jCisrKyBiL21t
L21tYXAuYwpAQCAtMjU3MSw2ICsyNTcxLDcgQEAgZG9fdm1pX2FsaWduX211bm1hcChzdHJ1Y3Qg
dm1hX2l0ZXJhdG9yICp2bWksIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCV9fbXRfZGVz
dHJveSgmbXRfZGV0YWNoKTsKIHN0YXJ0X3NwbGl0X2ZhaWxlZDoKIG1hcF9jb3VudF9leGNlZWRl
ZDoKKwl2YWxpZGF0ZV9tbShtbSk7CiAJcmV0dXJuIGVycm9yOwogfQogCkBAIC0zMDE5LDEyICsz
MDIwLDkgQEAgaW50IGRvX3ZtYV9tdW5tYXAoc3RydWN0IHZtYV9pdGVyYXRvciAqdm1pLCBzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKIAkJYm9vbCB1bmxvY2spCiB7CiAJc3RydWN0IG1tX3N0
cnVjdCAqbW0gPSB2bWEtPnZtX21tOwotCWludCByZXQ7CiAKIAlhcmNoX3VubWFwKG1tLCBzdGFy
dCwgZW5kKTsKLQlyZXQgPSBkb192bWlfYWxpZ25fbXVubWFwKHZtaSwgdm1hLCBtbSwgc3RhcnQs
IGVuZCwgdWYsIHVubG9jayk7Ci0JdmFsaWRhdGVfbW0obW0pOwotCXJldHVybiByZXQ7CisJcmV0
dXJuIGRvX3ZtaV9hbGlnbl9tdW5tYXAodm1pLCB2bWEsIG1tLCBzdGFydCwgZW5kLCB1ZiwgdW5s
b2NrKTsKIH0KIAogLyoK
--000000000000a1f7f705ffa00fe0--
