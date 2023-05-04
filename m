Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07A16F6915
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjEDKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEDKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:32:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666A4684;
        Thu,  4 May 2023 03:32:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7EE3A209F6;
        Thu,  4 May 2023 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683196320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SysVoVEKW+NX4qyVGu/niFlwGn5aiW8M5/2sd3Frq6w=;
        b=juSzgQlFlUDuBImH9ZJN/4cvnNQiKW1CsIfyP7OnP0w5p0L5JLGR4eMvuerD53YtoDxppF
        iCPh2YubO9R5cvjksS70oKLJ4ICxj2GC8yaeouEoRVXZdyQ6AV7PLoLgCnqQ5JJ9R9/XXD
        TURNTorKdCr0S6/Vh9F0rphyrPDr8dI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C1EE133F7;
        Thu,  4 May 2023 10:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sf/UHJ+JU2ShewAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 04 May 2023 10:31:59 +0000
Message-ID: <edd4b974-08de-0769-0dba-f945ed06f222@suse.com>
Date:   Thu, 4 May 2023 12:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        xen-devel@lists.xenproject.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dy9uFmhcjqIP2UV6JYsq3Ms5"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dy9uFmhcjqIP2UV6JYsq3Ms5
Content-Type: multipart/mixed; boundary="------------ov0MDEHsfp47A5JSPZkJ0II7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Cc: Thomas Garnier <thgarnie@chromium.org>,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>, Kees Cook
 <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Kim Phillips <kim.phillips@amd.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Josh Poimboeuf <jpoimboe@kernel.org>, xen-devel@lists.xenproject.org,
 platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
Message-ID: <edd4b974-08de-0769-0dba-f945ed06f222@suse.com>
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>

--------------ov0MDEHsfp47A5JSPZkJ0II7
Content-Type: multipart/mixed; boundary="------------AE0inQaMWfJGKdJPNCVK0Np8"

--------------AE0inQaMWfJGKdJPNCVK0Np8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDQuMjMgMTE6NTAsIEhvdSBXZW5sb25nIHdyb3RlOg0KPiBGcm9tOiBCcmlhbiBH
ZXJzdCA8YnJnZXJzdEBnbWFpbC5jb20+DQo+IA0KPiBGcm9tOiBCcmlhbiBHZXJzdCA8YnJn
ZXJzdEBnbWFpbC5jb20+DQo+IA0KPiBJZiB0aGUgY29tcGlsZXIgc3VwcG9ydHMgaXQsIHVz
ZSBhIHN0YW5kYXJkIHBlci1jcHUgdmFyaWFibGUgZm9yIHRoZQ0KPiBzdGFjayBwcm90ZWN0
b3IgaW5zdGVhZCBvZiB0aGUgb2xkIGZpeGVkIGxvY2F0aW9uLiAgS2VlcCB0aGUgZml4ZWQN
Cj4gbG9jYXRpb24gY29kZSBmb3IgY29tcGF0aWJpbGl0eSB3aXRoIG9sZGVyIGNvbXBpbGVy
cy4NCj4gDQo+IFtIb3UgV2VubG9uZzogRGlzYWJsZSBpdCBvbiBDbGFuZywgYWRhcHQgbmV3
IGNvZGUgY2hhbmdlIGFuZCBhZGFwdA0KPiBtaXNzaW5nIEdTIHNldCB1cCBwYXRoIGluIHB2
aF9zdGFydF94ZW4oKV0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJyaWFuIEdlcnN0IDxicmdl
cnN0QGdtYWlsLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBIb3UgV2VubG9uZyA8aG91d2Vu
bG9uZy5od2xAYW50Z3JvdXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIb3UgV2VubG9uZyA8
aG91d2VubG9uZy5od2xAYW50Z3JvdXAuY29tPg0KPiBDYzogVGhvbWFzIEdhcm5pZXIgPHRo
Z2FybmllQGNocm9taXVtLm9yZz4NCj4gQ2M6IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbi5s
anNAYW50Z3JvdXAuY29tPg0KPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5v
cmc+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
fCAxMiArKysrKysrKysrKysNCj4gICBhcmNoL3g4Ni9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgYXJjaC94ODYvZW50cnkv
ZW50cnlfNjQuUyAgICAgICAgICAgICB8ICA2ICsrKysrLQ0KPiAgIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3Byb2Nlc3Nvci5oICAgICAgfCAxNyArKysrKysrKysrKystLS0tLQ0KPiAgIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL3N0YWNrcHJvdGVjdG9yLmggfCAxNiArKysrKysrLS0tLS0t
LS0tDQo+ICAgYXJjaC94ODYva2VybmVsL2FzbS1vZmZzZXRzXzY0LmMgICAgICB8ICAyICst
DQo+ICAgYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyAgICAgICAgICB8IDE1ICsrKysr
KystLS0tLS0tLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9oZWFkXzY0LlMgICAgICAgICAgICAg
fCAxNiArKysrKysrKysrLS0tLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRz
LlMgICAgICAgICB8ICA0ICsrKy0NCj4gICBhcmNoL3g4Ni9wbGF0Zm9ybS9wdmgvaGVhZC5T
ICAgICAgICAgIHwgIDggKysrKysrKysNCj4gICBhcmNoL3g4Ni94ZW4veGVuLWhlYWQuUyAg
ICAgICAgICAgICAgIHwgMTQgKysrKysrKysrLS0tLS0NCj4gICAxMSBmaWxlcyBjaGFuZ2Vk
LCA4OCBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gDQoNCi4uLg0KDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4veGVuLWhlYWQuUyBiL2FyY2gveDg2L3hlbi94ZW4t
aGVhZC5TDQo+IGluZGV4IDY0M2QwMjkwMGZiYi4uMDllYWY1OWU4MDY2IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni94ZW4veGVuLWhlYWQuUw0KPiArKysgYi9hcmNoL3g4Ni94ZW4veGVu
LWhlYWQuUw0KPiBAQCAtNTEsMTUgKzUxLDE5IEBAIFNZTV9DT0RFX1NUQVJUKHN0YXJ0dXBf
eGVuKQ0KPiAgIA0KPiAgIAlsZWFxCShfX2VuZF9pbml0X3Rhc2sgLSBQVFJFR1NfU0laRSko
JXJpcCksICVyc3ANCj4gICANCj4gLQkvKiBTZXQgdXAgJWdzLg0KPiAtCSAqDQo+IC0JICog
VGhlIGJhc2Ugb2YgJWdzIGFsd2F5cyBwb2ludHMgdG8gZml4ZWRfcGVyY3B1X2RhdGEuICBJ
ZiB0aGUNCj4gLQkgKiBzdGFjayBwcm90ZWN0b3IgY2FuYXJ5IGlzIGVuYWJsZWQsIGl0IGlz
IGxvY2F0ZWQgYXQgJWdzOjQwLg0KPiArCS8qDQo+ICsJICogU2V0IHVwIEdTIGJhc2UuDQo+
ICAgCSAqIE5vdGUgdGhhdCwgb24gU01QLCB0aGUgYm9vdCBjcHUgdXNlcyBpbml0IGRhdGEg
c2VjdGlvbiB1bnRpbA0KPiAgIAkgKiB0aGUgcGVyIGNwdSBhcmVhcyBhcmUgc2V0IHVwLg0K
PiAgIAkgKi8NCj4gICAJbW92bAkkTVNSX0dTX0JBU0UsJWVjeA0KPiAtCW1vdnEJJElOSVRf
UEVSX0NQVV9WQVIoZml4ZWRfcGVyY3B1X2RhdGEpLCVyYXgNCj4gKyNpZiBkZWZpbmVkKENP
TkZJR19TVEFDS1BST1RFQ1RPUl9GSVhFRCkNCj4gKwlsZWFxCUlOSVRfUEVSX0NQVV9WQVIo
Zml4ZWRfcGVyY3B1X2RhdGEpKCVyaXApLCAlcmR4DQo+ICsjZWxpZiBkZWZpbmVkKENPTkZJ
R19TTVApDQo+ICsJbW92YWJzCSRfX3Blcl9jcHVfbG9hZCwgJXJkeA0KDQpTaG91bGRuJ3Qg
YWJvdmUgMiB0YXJnZXRzIGJlICVyYXg/DQoNCj4gKyNlbHNlDQo+ICsJeG9ybAklZWF4LCAl
ZWF4DQo+ICsjZW5kaWYNCj4gICAJY2RxDQo+ICAgCXdybXNyDQo+ICAgDQoNCg0KSnVlcmdl
bg0K
--------------AE0inQaMWfJGKdJPNCVK0Np8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------AE0inQaMWfJGKdJPNCVK0Np8--

--------------ov0MDEHsfp47A5JSPZkJ0II7--

--------------dy9uFmhcjqIP2UV6JYsq3Ms5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRTiZ8FAwAAAAAACgkQsN6d1ii/Ey/C
/Qf7BVOcd5ra8zfx6EPiAv74I4RpWlIuL3rn0B5v6bOo0FFa4n4zj9VOvcYOUGlraDWF3O8GumNw
Cb2IMVqEVZErE9qRr7deURIsoKwrXg8XsZZjyjfJHu8zKP0vbrA0de6Vd5j4KtUt9Zbex5+iSI6o
znSFEHTx2lXV8YGE6XnBxHulxsAoSOpevs72mkXEZvqkplnfYYm1wbXEdHz1Kv7YDAzhn8sDHmIc
kXp/CLT/2dmoEhI/S5jdbBan7ywy6EL+49FsfPxbNoHu4grjSjXTW000ltfEWEQL8ZA3GPAsM3PX
xoMnuhBcTopWMqDtZyEsrsTuG79jnYi0WXwT9+wWmQ==
=o9bz
-----END PGP SIGNATURE-----

--------------dy9uFmhcjqIP2UV6JYsq3Ms5--
