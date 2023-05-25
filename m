Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734377118DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjEYVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEYVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:13:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E89E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:13:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so2966994e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685049208; x=1687641208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9SZgJkEuk57kDCIrdJoLldT8KXfqYqeFjG76R55NgrE=;
        b=JaqdJoj9FHwmqSNvGCTLn6JkyfBJXC2SvUwAMk/jEV2ZshDAV0tXnrE12dQqxrI18Z
         /E6pgcbNwp5Qz6XhHWMAw6TpizGL5QO5arU/UQJmWffUcqub9HRQl1tcR5PEdTFy4DU+
         xFZuQuCeSExnUERqP9+oy5Vc5i9LZzisLqRHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049208; x=1687641208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SZgJkEuk57kDCIrdJoLldT8KXfqYqeFjG76R55NgrE=;
        b=OcANQ5sYClEYqYNpggE/xbgHcH9zi64u0lKWPpPu/zkBFRvsHdj5NtlR77xLTGO2ic
         SScoNjiPnlunNNlf7RZXE7WBhn7fQ3oxrneDpZuevtGHqKkizYP37xxdNJ1q8IZgyt74
         lpwmEzjGuHkKNDQLhlSHGYp64st7QswcwfYDg4ENEK1xngW20e0hk0/T/8KjoAHCJrxv
         MfPQDoJH15pB9i1/1zXsT23BlxxreIhiQdKyOxFaK3NREnCalzjosfgq49DOG4wKCg1A
         WSL3kIBUPYyo+6uRqFDAPUQRiLMhnmsiX3DBWdKZgq9W6BLznk81HjRtQ8sdoyqAk6OJ
         u6NA==
X-Gm-Message-State: AC+VfDxUagl3kHWfdp+ytShmZ5FSH4B4MFlTss+3Iqge2LKYvIIlR1hn
        /5cMP5ZhRahelUL5QLGoEz1x9tUDx14mDFTnvPqX2qwi
X-Google-Smtp-Source: ACHHUZ7ZDQKGdjlsym0W31pqwfVwogd+mYhbts97YQDT0bFQbbDetflOnPJtfX78U6pJUgD4v5hZpg==
X-Received: by 2002:ac2:5fe4:0:b0:4f2:5338:d0a8 with SMTP id s4-20020ac25fe4000000b004f25338d0a8mr7375877lfg.56.1685049208378;
        Thu, 25 May 2023 14:13:28 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j28-20020ac2551c000000b004f399531e8csm338457lfk.226.2023.05.25.14.13.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 14:13:27 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso2950967e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:13:27 -0700 (PDT)
X-Received: by 2002:a17:907:1628:b0:973:8edc:5a3a with SMTP id
 hb40-20020a170907162800b009738edc5a3amr82698ejc.30.1685049186309; Thu, 25 May
 2023 14:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
In-Reply-To: <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 14:12:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
Message-ID: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: multipart/mixed; boundary="0000000000002e29d205fc8b1635"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002e29d205fc8b1635
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 11:45=E2=80=AFAM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> Are you willig to merge (a possibly improved version of) your patch
> or the userspace change is still something that would be desired?

I think a user space change should still be something that people
should look at, particularly as the kernel side patch I'm willing to
accept doesn't catch the "completely serial" cases, only the "trying
to load at the same time that the same module is literally busy being
loaded".

But I've cleaned up my patch a bit, and while the cleaned-up version
is rather larger as a patch (mainly because of just also re-organizing
the finit_module() code to do all the 'struct file' prep), I'm
actually pretty happy with this attached patch conceptually.

In this form, it actually "makes sense" to me, rather than being just
clearly a workaround.  Also, unlike the previous patch, this doesn't
actually make any changes to the basic kernel_read_file() set of
functions, it's all done by the module loading code itself.

Luis, would you mind testing this version on your load? It still won't
actually handle the purely serial case, so there *will* be those
spurious double module reads from different CPU's just doing the
things serially, but the exclusive file access region has been
extended to not just cover the actual file content reading, but to
cover the whole "turn it into a a real module" part too.

Also, this does *not* update some of the comments in the module
loading. I changed finit_module to use "kernel_read_file()" instead of
"kernel_read_file_from_fd()", since it actually now has to look up the
file descriptor anyway. But the comments still talk about that
"from_fd" thing.

Anyway, this is back to "ENTIRELY UNTESTED" territory, in that I've
compiled this, but haven't booted it. The changes look obvious, but
hey, mistakes happen.

And the commit message is just a place-holder. Obviously. I won't sign
off on this or write more of a commit message until it has had some
real testing.

                  Linus

--0000000000002e29d205fc8b1635
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Attempt-at-workaround-for-horrible-udev-module-loadi.patch"
Content-Disposition: attachment; 
	filename="0001-Attempt-at-workaround-for-horrible-udev-module-loadi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_li3mpxbp0>
X-Attachment-Id: f_li3mpxbp0

RnJvbSBlMzIyM2JmYmRkNTQ1NWYwYjExMzM3YTU5MWZhZDNhMTgxNmI5ZDA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjUgTWF5IDIwMjMgMDk6MzI6MjUgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBBdHRlbXB0IGF0IHdvcmthcm91bmQgZm9yIGhvcnJpYmxlIHVkZXYgbW9kdWxlIGxv
YWRpbmcKIGJlaGF2aW9yCgotLS0KIGluY2x1ZGUvbGludXgvZnMuaCAgIHwgIDYgKysrKwoga2Vy
bmVsL21vZHVsZS9tYWluLmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2Zz
LmgKaW5kZXggMjFhOTgxNjgwODU2Li43MjJiNDJhNzdkNTEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgvZnMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgKQEAgLTI1NjYsNiArMjU2NiwxMiBA
QCBzdGF0aWMgaW5saW5lIGludCBkZW55X3dyaXRlX2FjY2VzcyhzdHJ1Y3QgZmlsZSAqZmlsZSkK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKIAlyZXR1cm4gYXRvbWlj
X2RlY191bmxlc3NfcG9zaXRpdmUoJmlub2RlLT5pX3dyaXRlY291bnQpID8gMCA6IC1FVFhUQlNZ
OwogfQorc3RhdGljIGlubGluZSBpbnQgZXhjbHVzaXZlX2Rlbnlfd3JpdGVfYWNjZXNzKHN0cnVj
dCBmaWxlICpmaWxlKQoreworCWludCBvbGQgPSAwOworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBm
aWxlX2lub2RlKGZpbGUpOworCXJldHVybiBhdG9taWNfdHJ5X2NtcHhjaGcoJmlub2RlLT5pX3dy
aXRlY291bnQsICZvbGQsIC0xKSA/IDAgOiAtRVRYVEJTWTsKK30KIHN0YXRpYyBpbmxpbmUgdm9p
ZCBwdXRfd3JpdGVfYWNjZXNzKHN0cnVjdCBpbm9kZSAqIGlub2RlKQogewogCWF0b21pY19kZWMo
Jmlub2RlLT5pX3dyaXRlY291bnQpOwpkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9tYWluLmMg
Yi9rZXJuZWwvbW9kdWxlL21haW4uYwppbmRleCAwNDRhYTJjOWUzY2IuLmI0YzdlOTI1ZmRiMCAx
MDA2NDQKLS0tIGEva2VybmVsL21vZHVsZS9tYWluLmMKKysrIGIva2VybmVsL21vZHVsZS9tYWlu
LmMKQEAgLTMwNTcsMTEgKzMwNTcsNTMgQEAgU1lTQ0FMTF9ERUZJTkUzKGluaXRfbW9kdWxlLCB2
b2lkIF9fdXNlciAqLCB1bW9kLAogCXJldHVybiBsb2FkX21vZHVsZSgmaW5mbywgdWFyZ3MsIDAp
OwogfQogCi1TWVNDQUxMX0RFRklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFy
IF9fdXNlciAqLCB1YXJncywgaW50LCBmbGFncykKK3N0YXRpYyBpbnQgZmlsZV9pbml0X21vZHVs
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKiB1YXJncywgaW50IGZsYWdz
KQogewogCXN0cnVjdCBsb2FkX2luZm8gaW5mbyA9IHsgfTsKIAl2b2lkICpidWYgPSBOVUxMOwog
CWludCBsZW47CisKKwlsZW4gPSBrZXJuZWxfcmVhZF9maWxlKGZpbGUsIDAsICZidWYsIElOVF9N
QVgsIE5VTEwsCisJCQkJICAgICAgIFJFQURJTkdfTU9EVUxFKTsKKwlpZiAobGVuIDwgMCkgewor
CQltb2Rfc3RhdF9pbmMoJmZhaWxlZF9rcmVhZHMpOworCQltb2Rfc3RhdF9hZGRfbG9uZyhsZW4s
ICZpbnZhbGlkX2tyZWFkX2J5dGVzKTsKKwkJcmV0dXJuIGxlbjsKKwl9CisKKwlpZiAoZmxhZ3Mg
JiBNT0RVTEVfSU5JVF9DT01QUkVTU0VEX0ZJTEUpIHsKKwkJaW50IGVyciA9IG1vZHVsZV9kZWNv
bXByZXNzKCZpbmZvLCBidWYsIGxlbik7CisJCXZmcmVlKGJ1Zik7IC8qIGNvbXByZXNzZWQgZGF0
YSBpcyBubyBsb25nZXIgbmVlZGVkICovCisJCWlmIChlcnIpIHsKKwkJCW1vZF9zdGF0X2luYygm
ZmFpbGVkX2RlY29tcHJlc3MpOworCQkJbW9kX3N0YXRfYWRkX2xvbmcobGVuLCAmaW52YWxpZF9k
ZWNvbXByZXNzX2J5dGVzKTsKKwkJCXJldHVybiBlcnI7CisJCX0KKwl9IGVsc2UgeworCQlpbmZv
LmhkciA9IGJ1ZjsKKwkJaW5mby5sZW4gPSBsZW47CisJfQorCisJcmV0dXJuIGxvYWRfbW9kdWxl
KCZpbmZvLCB1YXJncywgZmxhZ3MpOworfQorCisvKgorICoga2VybmVsX3JlYWRfZmlsZSgpIHdp
bGwgYWxyZWFkeSBkZW55IHdyaXRlIGFjY2VzcywgYnV0IG1vZHVsZQorICogbG9hZGluZyB3YW50
cyBfZXhjbHVzaXZlXyBhY2Nlc3MgdG8gdGhlIGZpbGUsIHNvIHdlIGRvIHRoYXQKKyAqIGhlcmUs
IGFsb25nIHdpdGggYmFzaWMgc2FuaXR5IGNoZWNrcy4KKyAqLworc3RhdGljIGludCBwcmVwYXJl
X2ZpbGVfZm9yX21vZHVsZV9sb2FkKHN0cnVjdCBmaWxlICpmaWxlKQoreworCWlmICghZmlsZSB8
fCAhKGZpbGUtPmZfbW9kZSAmIEZNT0RFX1JFQUQpKQorCQlyZXR1cm4gLUVCQURGOworCWlmICgh
U19JU1JFRyhmaWxlX2lub2RlKGZpbGUpLT5pX21vZGUpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwly
ZXR1cm4gZXhjbHVzaXZlX2Rlbnlfd3JpdGVfYWNjZXNzKGZpbGUpOworfQorCitTWVNDQUxMX0RF
RklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFyIF9fdXNlciAqLCB1YXJncywg
aW50LCBmbGFncykKK3sKKwlzdHJ1Y3QgZmQgZjsKIAlpbnQgZXJyOwogCiAJZXJyID0gbWF5X2lu
aXRfbW9kdWxlKCk7CkBAIC0zMDc1LDI4ICszMTE3LDE0IEBAIFNZU0NBTExfREVGSU5FMyhmaW5p
dF9tb2R1bGUsIGludCwgZmQsIGNvbnN0IGNoYXIgX191c2VyICosIHVhcmdzLCBpbnQsIGZsYWdz
KQogCQkgICAgICB8TU9EVUxFX0lOSVRfQ09NUFJFU1NFRF9GSUxFKSkKIAkJcmV0dXJuIC1FSU5W
QUw7CiAKLQlsZW4gPSBrZXJuZWxfcmVhZF9maWxlX2Zyb21fZmQoZmQsIDAsICZidWYsIElOVF9N
QVgsIE5VTEwsCi0JCQkJICAgICAgIFJFQURJTkdfTU9EVUxFKTsKLQlpZiAobGVuIDwgMCkgewot
CQltb2Rfc3RhdF9pbmMoJmZhaWxlZF9rcmVhZHMpOwotCQltb2Rfc3RhdF9hZGRfbG9uZyhsZW4s
ICZpbnZhbGlkX2tyZWFkX2J5dGVzKTsKLQkJcmV0dXJuIGxlbjsKKwlmID0gZmRnZXQoZmQpOwor
CWVyciA9IHByZXBhcmVfZmlsZV9mb3JfbW9kdWxlX2xvYWQoZi5maWxlKTsKKwlpZiAoIWVycikg
eworCQllcnIgPSBmaWxlX2luaXRfbW9kdWxlKGYuZmlsZSwgdWFyZ3MsIGZsYWdzKTsKKwkJYWxs
b3dfd3JpdGVfYWNjZXNzKGYuZmlsZSk7CiAJfQotCi0JaWYgKGZsYWdzICYgTU9EVUxFX0lOSVRf
Q09NUFJFU1NFRF9GSUxFKSB7Ci0JCWVyciA9IG1vZHVsZV9kZWNvbXByZXNzKCZpbmZvLCBidWYs
IGxlbik7Ci0JCXZmcmVlKGJ1Zik7IC8qIGNvbXByZXNzZWQgZGF0YSBpcyBubyBsb25nZXIgbmVl
ZGVkICovCi0JCWlmIChlcnIpIHsKLQkJCW1vZF9zdGF0X2luYygmZmFpbGVkX2RlY29tcHJlc3Mp
OwotCQkJbW9kX3N0YXRfYWRkX2xvbmcobGVuLCAmaW52YWxpZF9kZWNvbXByZXNzX2J5dGVzKTsK
LQkJCXJldHVybiBlcnI7Ci0JCX0KLQl9IGVsc2UgewotCQlpbmZvLmhkciA9IGJ1ZjsKLQkJaW5m
by5sZW4gPSBsZW47Ci0JfQotCi0JcmV0dXJuIGxvYWRfbW9kdWxlKCZpbmZvLCB1YXJncywgZmxh
Z3MpOworCWZkcHV0KGYpOworCXJldHVybiBlcnI7CiB9CiAKIC8qIEtlZXAgaW4gc3luYyB3aXRo
IE1PRFVMRV9GTEFHU19CVUZfU0laRSAhISEgKi8KLS0gCjIuNDEuMC5yYzEuNC5nYjRkYWU3NTA1
MAoK
--0000000000002e29d205fc8b1635--
