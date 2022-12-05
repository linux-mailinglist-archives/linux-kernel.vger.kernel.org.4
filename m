Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB50E6423B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiLEHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLEHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:40:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA09FAFD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:40:08 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A29D21B3E;
        Mon,  5 Dec 2022 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670226007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D6Vf95su3VmrHCYkH/OlvY2CBKv1q8/+cyB1x34WCuU=;
        b=aLQCFyNF4IMydkQkgR5c/ngNnrXehxXPEigdNLJud+8SfCprlgHx+uAMC8/PRnXJtJw15U
        XjMLJySEfbpaXKWCW8pmb43+2skrPhR6RNL+NMlYPoWhcJLGkr6OFbOx0PfSM3Cmczi6d+
        FkreAtcYXznVTn8g6Ee7wwXVp1KbkS4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B47F61348F;
        Mon,  5 Dec 2022 07:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lzKYKlagjWNmKAAAGKfGzw
        (envelope-from <jgross@suse.com>); Mon, 05 Dec 2022 07:40:06 +0000
Message-ID: <cf7db285-deaf-8e3e-2b35-7cecbaff7d61@suse.com>
Date:   Mon, 5 Dec 2022 08:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
 <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
 <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
In-Reply-To: <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FFsnj7hIV1XStGP65ZkDO2st"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FFsnj7hIV1XStGP65ZkDO2st
Content-Type: multipart/mixed; boundary="------------hMom9wf9Vg0Oix5OdnPOWhAc";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <cf7db285-deaf-8e3e-2b35-7cecbaff7d61@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
 <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
 <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
In-Reply-To: <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>

--------------hMom9wf9Vg0Oix5OdnPOWhAc
Content-Type: multipart/mixed; boundary="------------YjfqT6cBFixHgJ94aO9qNzeG"

--------------YjfqT6cBFixHgJ94aO9qNzeG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjIgMTU6NTYsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDAyLjEyLjIy
IDE1OjMzLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+PiBPbiBGcmksIERlYyAwMiwg
MjAyMiBhdCAwMjozOTo1OFBNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IE9u
IDAyLjEyLjIyIDE0OjI3LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+Pj4+IE9uIEZy
aSwgRGVjIDAyLCAyMDIyIGF0IDA2OjU2OjQ3QU0gKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6DQo+Pj4+PiBPbiAwMi4xMi4yMiAwMDo1NywgS2lyaWxsIEEuIFNodXRlbW92IHdyb3Rl
Og0KPj4+Pj4+IE9uIFRodSwgRGVjIDAxLCAyMDIyIGF0IDA1OjMzOjI4UE0gKzAxMDAsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4+IE9uIDAxLjEyLjIyIDE3OjI2LCBLaXJpbGwg
QS4gU2h1dGVtb3Ygd3JvdGU6DQo+Pj4+Pj4+PiBPbiBXZWQsIE5vdiAwMiwgMjAyMiBhdCAw
ODo0NzoxMEFNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+Pj4+Pj4+IFRvZGF5
IFBBVCBpcyB1c2FibGUgb25seSB3aXRoIE1UUlIgYmVpbmcgYWN0aXZlLCB3aXRoIHNvbWUg
bmFzdHkgdHdlYWtzDQo+Pj4+Pj4+Pj4gdG8gbWFrZSBQQVQgdXNhYmxlIHdoZW4gcnVubmlu
ZyBhcyBYZW4gUFYgZ3Vlc3QsIHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydA0KPj4+Pj4+Pj4+IE1U
UlIuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBUaGUgcmVhc29uIGZvciB0aGlzIGNvdXBsaW5n
IGlzLCB0aGF0IGJvdGgsIFBBVCBNU1IgY2hhbmdlcyBhbmQgTVRSUg0KPj4+Pj4+Pj4+IGNo
YW5nZXMsIHJlcXVpcmUgYSBzaW1pbGFyIHNlcXVlbmNlIGFuZCBzbyBmdWxsIFBBVCBzdXBw
b3J0IHdhcyBhZGRlZA0KPj4+Pj4+Pj4+IHVzaW5nIHRoZSBhbHJlYWR5IGF2YWlsYWJsZSBN
VFJSIGhhbmRsaW5nLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gWGVuIFBWIFBBVCBoYW5kbGlu
ZyBjYW4gd29yayB3aXRob3V0IE1UUlIsIGFzIGl0IGp1c3QgbmVlZHMgdG8gY29uc3VtZQ0K
Pj4+Pj4+Pj4+IHRoZSBQQVQgTVNSIHNldHRpbmcgZG9uZSBieSB0aGUgaHlwZXJ2aXNvciB3
aXRob3V0IHRoZSBhYmlsaXR5IGFuZCBuZWVkDQo+Pj4+Pj4+Pj4gdG8gY2hhbmdlIGl0LiBU
aGlzIGluIHR1cm4gaGFzIHJlc3VsdGVkIGluIGEgY29udm9sdXRlZCBpbml0aWFsaXphdGlv
bg0KPj4+Pj4+Pj4+IHNlcXVlbmNlIGFuZCB3cm9uZyBkZWNpc2lvbnMgcmVnYXJkaW5nIGNh
Y2hlIG1vZGUgYXZhaWxhYmlsaXR5IGR1ZSB0bw0KPj4+Pj4+Pj4+IG1pc2d1aWRpbmcgUEFU
IGF2YWlsYWJpbGl0eSBmbGFncy4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEZpeCBhbGwgb2Yg
dGhhdCBieSBhbGxvd2luZyB0byB1c2UgUEFUIHdpdGhvdXQgTVRSUiBhbmQgYnkgcmV3b3Jr
aW5nDQo+Pj4+Pj4+Pj4gdGhlIGN1cnJlbnQgUEFUIGluaXRpYWxpemF0aW9uIHNlcXVlbmNl
IHRvIG1hdGNoIGJldHRlciB3aXRoIHRoZSBuZXdseQ0KPj4+Pj4+Pj4+IGludHJvZHVjZWQg
Z2VuZXJpYyBjYWNoZSBpbml0aWFsaXphdGlvbi4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFRo
aXMgcmVtb3ZlcyB0aGUgbmVlZCBvZiB0aGUgcmVjZW50bHkgYWRkZWQgcGF0X2ZvcmNlX2Rp
c2FibGVkIGZsYWcsIHNvDQo+Pj4+Pj4+Pj4gcmVtb3ZlIHRoZSByZW1uYW50cyBvZiB0aGUg
cGF0Y2ggYWRkaW5nIGl0Lg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRo
aXMgcGF0Y2ggYnJlYWtzIGJvb3QgZm9yIFREWCBndWVzdC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBLZXJuZWwgbm93IHRyaWVzIHRvIHNldCBDUjAuQ0Qgd2hpY2ggaXMgZm9yYmlkZGVuIGlu
IFREWCBndWVzdFsxXSBhbmQNCj4+Pj4+Pj4+IGNhdXNlcyAjVkU6DQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4gwqDCoMKgwqB0ZHg6IFVuZXhwZWN0ZWQgI1ZFOiAyOA0KPj4+Pj4+Pj4gwqDCoMKg
wqBWRSBmYXVsdDogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+Pj4+Pj4+PiDCoMKg
wqDCoENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCANCj4+Pj4+Pj4+
IDYuMS4wLXJjMS0wMDAxNS1nYWRmZTc1MTJlMWQwICMyNjQ2DQo+Pj4+Pj4+PiDCoMKgwqDC
oEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBC
SU9TIDAuMC4wIA0KPj4+Pj4+Pj4gMDIvMDYvMjAxNQ0KPj4+Pj4+Pj4gwqDCoMKgwqBSSVA6
IDAwMTA6bmF0aXZlX3dyaXRlX2NyMCAoYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYzo0
MjcpDQo+Pj4+Pj4+PiDCoMKgwqDCoCBDYWxsIFRyYWNlOg0KPj4+Pj4+Pj4gwqDCoMKgwqDC
oCA8VEFTSz4NCj4+Pj4+Pj4+IMKgwqDCoMKgID8gY2FjaGVfZGlzYWJsZSAoYXJjaC94ODYv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oOjE3MyANCj4+Pj4+Pj4+IGFyY2gveDg2L2tlcm5l
bC9jcHUvY2FjaGVpbmZvLmM6MTA4NSkNCj4+Pj4+Pj4+IMKgwqDCoMKgID8gY2FjaGVfY3B1
X2luaXQgKGFyY2gveDg2L2tlcm5lbC9jcHUvY2FjaGVpbmZvLmM6MTEzMiANCj4+Pj4+Pj4+
IChkaXNjcmltaW5hdG9yIDMpKQ0KPj4+Pj4+Pj4gwqDCoMKgwqAgPyBzZXR1cF9hcmNoIChh
cmNoL3g4Ni9rZXJuZWwvc2V0dXAuYzoxMDc5KQ0KPj4+Pj4+Pj4gwqDCoMKgwqAgPyBzdGFy
dF9rZXJuZWwgKGluaXQvbWFpbi5jOjI3OSAoZGlzY3JpbWluYXRvciAzKSBpbml0L21haW4u
Yzo0NzcgDQo+Pj4+Pj4+PiAoZGlzY3JpbWluYXRvciAzKSBpbml0L21haW4uYzo5NjAgKGRp
c2NyaW1pbmF0b3IgMykpDQo+Pj4+Pj4+PiDCoMKgwqDCoCA/IGxvYWRfdWNvZGVfYnNwIChh
cmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9jb3JlLmM6MTU1KQ0KPj4+Pj4+Pj4gwqDC
oMKgwqAgPyBzZWNvbmRhcnlfc3RhcnR1cF82NF9ub192ZXJpZnkgKGFyY2gveDg2L2tlcm5l
bC9oZWFkXzY0LlM6MzU4KQ0KPj4+Pj4+Pj4gwqDCoMKgwqDCoCA8L1RBU0s+DQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gQW55IHN1Z2dlc3Rpb24gaG93IHRvIGZpeCBpdD8NCj4+Pj4+Pj4+DQo+
Pj4+Pj4+PiBbMV0gU2VjdGlvbiAxMC42LjEuICJDUjAiLCBodHRwczovL2NkcmR2Mi5pbnRl
bC5jb20vdjEvZGwvZ2V0Q29udGVudC83MzM1NjgNCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2hhdCB3
YXMgdGhlIHNvbHV0aW9uIGJlZm9yZT8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSBndWVzcyBNVFJS
IHdhcyBkaXNhYmxlZCwgc28gdGhlcmUgd2FzIG5vIFBBVCwgdG9vPw0KPj4+Pj4+DQo+Pj4+
Pj4gUmlnaHQ6DQo+Pj4+Pj4NCj4+Pj4+PiBMaW51cycgdHJlZToNCj4+Pj4+Pg0KPj4+Pj4+
IFvCoMKgwqAgMC4wMDI1ODldIGxhc3RfcGZuID0gMHg0ODAwMDAgbWF4X2FyY2hfcGZuID0g
MHgxMDAwMDAwMDAwMA0KPj4+Pj4+IFvCoMKgwqAgMC4wMDM5NzZdIERpc2FibGVkDQo+Pj4+
Pj4gW8KgwqDCoCAwLjAwNDQ1Ml0geDg2L1BBVDogTVRSUnMgZGlzYWJsZWQsIHNraXBwaW5n
IFBBVCBpbml0aWFsaXphdGlvbiB0b28uDQo+Pj4+Pj4gW8KgwqDCoCAwLjAwNTg1Nl0gQ1BV
IE1UUlJzIGFsbCBibGFuayAtIHZpcnR1YWxpemVkIHN5c3RlbS4NCj4+Pj4+PiBbwqDCoMKg
IDAuMDA2OTE1XSB4ODYvUEFUOiBDb25maWd1cmF0aW9uIFswLTddOiBXQsKgIFdUwqAgVUMt
IFVDwqAgV0LCoCBXVMKgIFVDLSBVQw0KPj4+Pj4+DQo+Pj4+Pj4gdGlwL21hc3RlcjoNCj4+
Pj4+Pg0KPj4+Pj4+IFvCoMKgwqAgMC4wMDM0NDNdIGxhc3RfcGZuID0gMHgyMGI4ZSBtYXhf
YXJjaF9wZm4gPSAweDEwMDAwMDAwMDAwDQo+Pj4+Pj4gW8KgwqDCoCAwLjAwNTIyMF0gRGlz
YWJsZWQNCj4+Pj4+PiBbwqDCoMKgIDAuMDA1ODE4XSB4ODYvUEFUOiBDb25maWd1cmF0aW9u
IFswLTddOiBXQsKgIFdDwqAgVUMtIFVDwqAgV0LCoCBXUMKgIFVDLSBXVA0KPj4+Pj4+IFvC
oMKgwqAgMC4wMDc3NTJdIHRkeDogVW5leHBlY3RlZCAjVkU6IDI4DQo+Pj4+Pj4NCj4+Pj4+
PiBUaGUgZGFuZ2xpbmcgIkRpc2FibGVkIiBjb21lcyBtdHJyX2JwX2luaXQoKS4NCj4+Pj4+
Pg0KPj4+Pj4+DQo+Pj4+Pj4+IElmIHRoaXMgaXMgdGhlIGNhc2UsIHlvdSBjYW4gZ28gdGhl
IHNhbWUgcm91dGUgYXMgWGVuIFBWIGd1ZXN0cyBkby4NCj4+Pj4+Pg0KPj4+Pj4+IEFueSBy
ZWFzb24gWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUiBjYW5ub3QgYmUgdXNlZCBpbnN0ZWFkIG9m
DQo+Pj4+Pj4gWDg2X0ZFQVRVUkVfWEVOUFYgdGhlcmU/DQo+Pj4+Pj4NCj4+Pj4+PiBEbyB3
ZSBoYXZlIGFueSB2aXJ0dWFsaXplZCBwbGF0Zm9ybSB0aGF0IHN1cHBvcnRzIGl0Pw0KPj4+
Pj4NCj4+Pj4+IFllcywgb2YgY291cnNlLiBBbnkgaGFyZHdhcmUgdmlydHVhbGl6ZWQgZ3Vl
c3Qgc2hvdWxkIGJlIGFibGUgdG8gdXNlIGl0LA0KPj4+Pj4gb2J2aW91c2x5IFREWCBndWVz
dHMgYXJlIHRoZSBmaXJzdCBvbmVzIG5vdCBiZWluZyBhYmxlIHRvIGRvIHNvLg0KPj4+Pj4N
Cj4+Pj4+IEFuZCBhYm92ZSBkbWVzZyBzbmlwcGxldHMgYXJlIHNob3dpbmcgcmF0aGVyIG5p
Y2VseSB0aGF0IG5vdCBkaXNhYmxpbmcNCj4+Pj4+IFBBVCBjb21wbGV0ZWx5IHNob3VsZCBi
ZSBhIGJlbmVmaXQgZm9yIFREWCBndWVzdHMsIGFzIGFsbCBjYWNoaW5nIG1vZGVzDQo+Pj4+
PiB3b3VsZCBiZSB1c2FibGUgKHRoZSBQQVQgTVNSIHNlZW1zIHRvIGJlIGluaXRpYWxpemVk
IHF1aXRlIGZpbmUpLg0KPj4+Pj4NCj4+Pj4+IEluc3RlYWQgb2YgWDg2X0ZFQVRVUkVfWEVO
UFYgd2UgY291bGQgaW50cm9kdWNlIHNvbWV0aGluZyBsaWtlDQo+Pj4+PiBYODZfRkVBVFVS
RV9QQVRfUkVBRE9OTFksIHdoaWNoIGNvdWxkIGJlIHNldCBmb3IgWGVuIFBWIGd1ZXN0cyBh
bmQgZm9yDQo+Pj4+PiBURFggZ3Vlc3RzLg0KPj4+Pg0KPj4+PiBUZWNobmljYWxseSwgdGhl
IE1TUiBpcyB3cml0YWJsZSBvbiBURFguIEJ1dCBpdCBzZWVtcyB0aGVyZSdzIG5vIHdheSB0
bw0KPj4+PiBwcm9wZXJseSBjaGFuZ2UgaXQsIGZvbGxvd2luZyB0aGUgcHJvdG9jb2wgb2Yg
Y2hhbmdpbmcgb24gTVAgc3lzdGVtcy4NCj4+Pg0KPj4+IFdoeSBub3Q/IEkgZG9uJ3Qgc2Vl
IHdoeSBpdCBpcyBwb3NzaWJsZSBpbiBhIG5vbi1URFggc3lzdGVtLCBidXQgbm90IHdpdGhp
bg0KPj4+IGEgVERYIGd1ZXN0Lg0KPj4NCj4+IEJlY2F1c2UgdGhlIHByb3RvY29sIHlvdSBk
ZXNjcmliZWQgYmVsb3cgcmVxdWlyZXMgc2V0dGluZyBDUjAuQ0Qgd2hpY2ggaXMNCj4+IG5v
dCBhbGxvd2VkIGluIFREWCBndWVzdCBhbmQgY2F1c2VzICNWRS4NCj4gDQo+IEhtbSwgeWVz
LCBzZWVtcyB0byBiZSBhIHZhbGlkIHJlYXNvbi4gOi0pDQo+IA0KPj4NCj4+Pj4gQWx0aG91
Z2gsIEkgZG9uJ3QgcXVpdGUgZm9sbG93IHdoYXQgcm9sZSBjYWNoZSBkaXNhYmxpbmcgcGxh
eWluZyBvbiBzeXN0ZW0NCj4+Pj4gd2l0aCBzZWxmLXNub29wIHN1cHBvcnQuIEhtPw0KPj4+
DQo+Pj4gSXQgaXMgdGhlIHJlY29tbWVuZGVkIHdheSB0byBkbyBpdC4gU2VlIFNETSBWb2wu
IDMgQ2hhcHRlciAxMSAoIk1lbW9yeSBDYWNoZQ0KPj4+IENvbnRyb2wiKToNCj4+Pg0KPj4+
IFRoZSBvcGVyYXRpbmcgc3lzdGVtIGlzIHJlc3BvbnNpYmxlIGZvciBpbnN1cmluZyB0aGF0
IGNoYW5nZXMgdG8gYSBQQVQgZW50cnkNCj4+PiBvY2N1ciBpbiBhIG1hbm5lciB0aGF0IG1h
aW50YWlucyB0aGUgY29uc2lzdGVuY3kgb2YgdGhlIHByb2Nlc3NvciBjYWNoZXMgYW5kDQo+
Pj4gdHJhbnNsYXRpb24gbG9va2FzaWRlIGJ1ZmZlcnMgKFRMQikuIFRoaXMgaXMgYWNjb21w
bGlzaGVkIGJ5IGZvbGxvd2luZyB0aGUNCj4+PiBwcm9jZWR1cmUgYXMgc3BlY2lmaWVkIGlu
IFNlY3Rpb24gMTEuMTEuOCwg4oCcTVRSUiBDb25zaWRlcmF0aW9ucyBpbiBNUCBTeXN0ZW1z
LA0KPj4+IOKAnWZvciBjaGFuZ2luZyB0aGUgdmFsdWUgb2YgYW4gTVRSUiBpbiBhIG11bHRp
cGxlIHByb2Nlc3NvciBzeXN0ZW0uIEl0IHJlcXVpcmVzDQo+Pj4gYSBzcGVjaWZpYyBzZXF1
ZW5jZSBvZiBvcGVyYXRpb25zIHRoYXQgaW5jbHVkZXMgZmx1c2hpbmcgdGhlIHByb2Nlc3Nv
cnMgY2FjaGVzDQo+Pj4gYW5kIFRMQnMuDQo+Pj4NCj4+PiBBbmQgdGhlIHNlcXVlbmNlIGZv
ciB0aGUgTVRSUnMgaXM6DQo+Pj4NCj4+PiAxLiBCcm9hZGNhc3QgdG8gYWxsIHByb2Nlc3Nv
cnMgdG8gZXhlY3V0ZSB0aGUgZm9sbG93aW5nIGNvZGUgc2VxdWVuY2UuDQo+Pj4gMi4gRGlz
YWJsZSBpbnRlcnJ1cHRzLg0KPj4+IDMuIFdhaXQgZm9yIGFsbCBwcm9jZXNzb3JzIHRvIHJl
YWNoIHRoaXMgcG9pbnQuDQo+Pj4gNC4gRW50ZXIgdGhlIG5vLWZpbGwgY2FjaGUgbW9kZS4g
KFNldCB0aGUgQ0QgZmxhZyBpbiBjb250cm9sIHJlZ2lzdGVyIENSMCB0byAxDQo+Pj4gwqDC
oMKgIGFuZCB0aGUgTlcgZmxhZyB0byAwLikNCj4+PiA1LiBGbHVzaCBhbGwgY2FjaGVzIHVz
aW5nIHRoZSBXQklOVkQgaW5zdHJ1Y3Rpb25zLiBOb3RlIG9uIGEgcHJvY2Vzc29yIHRoYXQN
Cj4+PiDCoMKgwqAgc3VwcG9ydHMgc2VsZi1zbm9vcGluZywgQ1BVSUQgZmVhdHVyZSBmbGFn
IGJpdCAyNywgdGhpcyBzdGVwIGlzIHVubmVjZXNzYXJ5Lg0KPj4+IDYuIElmIHRoZSBQR0Ug
ZmxhZyBpcyBzZXQgaW4gY29udHJvbCByZWdpc3RlciBDUjQsIGZsdXNoIGFsbCBUTEJzIGJ5
IGNsZWFyaW5nDQo+Pj4gwqDCoMKgIHRoYXQgZmxhZy4NCj4+PiA3LiBJZiB0aGUgUEdFIGZs
YWcgaXMgY2xlYXIgaW4gY29udHJvbCByZWdpc3RlciBDUjQsIGZsdXNoIGFsbCBUTEJzIGJ5
IGV4ZWN1dGluZw0KPj4+IMKgwqDCoCBhIE1PViBmcm9tIGNvbnRyb2wgcmVnaXN0ZXIgQ1Iz
IHRvIGFub3RoZXIgcmVnaXN0ZXIgYW5kIHRoZW4gYSBNT1YgZnJvbSB0aGF0DQo+Pj4gwqDC
oMKgIHJlZ2lzdGVyIGJhY2sgdG8gQ1IzLg0KPj4+IDguIERpc2FibGUgYWxsIHJhbmdlIHJl
Z2lzdGVycyAoYnkgY2xlYXJpbmcgdGhlIEUgZmxhZyBpbiByZWdpc3RlciBNVFJSZGVmVHlw
ZSkuDQo+Pj4gwqDCoMKgIElmIG9ubHkgdmFyaWFibGUgcmFuZ2VzIGFyZSBiZWluZyBtb2Rp
ZmllZCwgc29mdHdhcmUgbWF5IGNsZWFyIHRoZSB2YWxpZCANCj4+PiBiaXRzDQo+Pj4gwqDC
oMKgIGZvciB0aGUgYWZmZWN0ZWQgcmVnaXN0ZXIgcGFpcnMgaW5zdGVhZC4NCj4+PiA5LiBV
cGRhdGUgdGhlIE1UUlJzLg0KPj4+IDEwLiBFbmFibGUgYWxsIHJhbmdlIHJlZ2lzdGVycyAo
Ynkgc2V0dGluZyB0aGUgRSBmbGFnIGluIHJlZ2lzdGVyIE1UUlJkZWZUeXBlKS4NCj4+PiDC
oMKgwqDCoCBJZiBvbmx5IHZhcmlhYmxlLXJhbmdlIHJlZ2lzdGVycyB3ZXJlIG1vZGlmaWVk
IGFuZCB0aGVpciBpbmRpdmlkdWFsIHZhbGlkDQo+Pj4gwqDCoMKgwqAgYml0cyB3ZXJlIGNs
ZWFyZWQsIHRoZW4gc2V0IHRoZSB2YWxpZCBiaXRzIGZvciB0aGUgYWZmZWN0ZWQgcmFuZ2Vz
IGluc3RlYWQuDQo+Pj4gMTEuIEZsdXNoIGFsbCBjYWNoZXMgYW5kIGFsbCBUTEJzIGEgc2Vj
b25kIHRpbWUuIChUaGUgVExCIGZsdXNoIGlzIHJlcXVpcmVkIGZvcg0KPj4+IMKgwqDCoMKg
IFBlbnRpdW0gNCwgSW50ZWwgWGVvbiwgYW5kIFA2IGZhbWlseSBwcm9jZXNzb3JzLiBFeGVj
dXRpbmcgdGhlIFdCSU5WRA0KPj4+IMKgwqDCoMKgIGluc3RydWN0aW9uIGlzIG5vdCBuZWVk
ZWQgd2hlbiB1c2luZyBQZW50aXVtIDQsIEludGVsIFhlb24sIGFuZCBQNiBmYW1pbHkNCj4+
PiDCoMKgwqDCoCBwcm9jZXNzb3JzLCBidXQgaXQgbWF5IGJlIG5lZWRlZCBpbiBmdXR1cmUg
c3lzdGVtcy4pDQo+Pj4gMTIuIEVudGVyIHRoZSBub3JtYWwgY2FjaGUgbW9kZSB0byByZS1l
bmFibGUgY2FjaGluZy4gKFNldCB0aGUgQ0QgYW5kIE5XIGZsYWdzDQo+Pj4gwqDCoMKgwqAg
aW4gY29udHJvbCByZWdpc3RlciBDUjAgdG8gMC4pDQo+Pj4gMTMuIFNldCBQR0UgZmxhZyBp
biBjb250cm9sIHJlZ2lzdGVyIENSNCwgaWYgY2xlYXJlZCBpbiBTdGVwIDYgKGFib3ZlKS4N
Cj4+PiAxNC4gV2FpdCBmb3IgYWxsIHByb2Nlc3NvcnMgdG8gcmVhY2ggdGhpcyBwb2ludC4N
Cj4+PiAxNS4gRW5hYmxlIGludGVycnVwdHMuDQo+Pj4NCj4+PiBTbyBjYWNoZSBkaXNhYmxp
bmcgaXMgcmVjb21tZW5kZWQuDQo+Pg0KPj4gWWVhaCwgSSByZWFkIHRoYXQuDQo+Pg0KPj4g
QnV0IHRoZSBxdWVzdGlvbiBpcyB3aGF0IGtpbmQgb2Ygc2NlbmFyaW8gY2FjaGUgZGlzYWJs
aW5nIGlzIGFjdHVhbGx5DQo+PiBwcmV2ZW50cyBpZiBzZWxmLXNub29wIGlzIHN1cHBvcnRl
ZD8gSW4gdGhpcyBjYXNlIGNhY2hlIHN0YXlzIGludGFjdCAobm8NCj4+IFdCSU5WRCkuIFRo
ZSBuZXh0IHRpbWUgYSBjYWNoZSBsaW5lIGdldHMgYWNjZXNzZWQgd2l0aCBkaWZmZXJlbnQg
Y2FjaGluZw0KPj4gbW9kZSB0aGUgb2xkIGxpbmUgZ2V0cyBzbm9vcGVkLCByaWdodD8NCj4+
DQo+PiBXb3VsZCBpdCBiZSB2YWxpZCB0byBhdm9pZCB0b3VjaGluZyBDUjAuQ0QgaWYgWDg2
X0ZFQVRVUkVfU0VMRlNOT09QPw0KPj4NCj4gDQo+IFRoYXQncyBhIHF1ZXN0aW9uIGZvciB0
aGUgSW50ZWwgYXJjaGl0ZWN0cywgSSBndWVzcy4NCj4gDQo+IEknZCBqdXN0IGFzayB0aGVt
IGhvdyB0byBzZXR1cCBQQVQgaW4gVERYIGd1ZXN0cy4gRWl0aGVyIHRoZXkgbmVlZCB0bw0K
PiBjaGFuZ2UgdGhlIHJlY29tbWVuZGVkIHNldHVwIHNlcXVlbmNlLCBvciB0aGUgUEFUIHN1
cHBvcnQgYml0IG5lZWRzIHRvDQo+IGJlIGNsZWFyZWQgSU1PLg0KDQpJJ3ZlIGZvcndhcmRl
ZCB0aGUgcXVlc3Rpb24gdG8gSW50ZWwsIEJUVy4NCg0KQW5vdGhlciBxdWVzdGlvbiB0byB5
b3U6IHdoZXJlIGRvZXMgdGhlIGluaXRpYWwgUEFUIE1TUiB2YWx1ZSBjb21lIGZyb20/DQpJ
IGd1ZXNzIGZyb20gVUVGST8NCg0KDQpKdWVyZ2VuDQo=
--------------YjfqT6cBFixHgJ94aO9qNzeG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------YjfqT6cBFixHgJ94aO9qNzeG--

--------------hMom9wf9Vg0Oix5OdnPOWhAc--

--------------FFsnj7hIV1XStGP65ZkDO2st
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmONoFYFAwAAAAAACgkQsN6d1ii/Ey99
ggf/fMtT9+uOLTT2g/5++DVWwy+JSUp19wfMYgXsq0lfF0+MuFSrSa1ARy7eFqjHoO0Yt3+nLXIY
wvENNeftW59tyCc2JkW56B+oFg91MzqZ4rRzm0/goY8+q6N5/v68x5CfnvAOgXGyetwvKfs3Wjk3
ATgP9KVPwP80+mKys22kOfzPd79okMcEZGBU3Or7JWAaDb0vTlTZVceLmn7rXv7J5etXi0lRgvgn
tJJmFcVPodiIw5WtQficAy/EeHgC1EhpfeiTMaTTcDr2Sby1YIfbWSXW0xWzs37fVsydQwSetH+h
4hwnIunvP3C9m8YykZiBGa/ixDR1Lzn7mEqLgZ5ReQ==
=meBv
-----END PGP SIGNATURE-----

--------------FFsnj7hIV1XStGP65ZkDO2st--
