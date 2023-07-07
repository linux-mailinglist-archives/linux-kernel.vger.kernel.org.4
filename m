Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9B74B3EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGGPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:14:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25682121
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:14:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 875862222A;
        Fri,  7 Jul 2023 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688742878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRTwrQger58FyJYzRjbRsv7XvEfRLUd+URadp+f150A=;
        b=raVSZgC1GBmI7GCoFBK6ta8mMU1GfnPkaoHFXs8dRpSKyKhpIeXWmWb9Bht4ptdFoflcqm
        8x0jJ8rtjMIV8ZwlgK0L3gC5sic5jDrbrT1kpj7giVY0O++R6wU+JUJjhEAX5BexeNdbmh
        SH1d7Xq/kH8frRtMT96UcNhA+ye9Q+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38C2D139E0;
        Fri,  7 Jul 2023 15:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mv5cDN4rqGQNDQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 15:14:38 +0000
Message-ID: <49666f77-9a09-c7ae-14aa-69abc283466f@suse.com>
Date:   Fri, 7 Jul 2023 17:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
References: <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
 <ZKglzGG6PeRPPtbT@MacBook-Air-de-Roger.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKglzGG6PeRPPtbT@MacBook-Air-de-Roger.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ocmhIf09ae6ZTIuu00mZXwXx"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ocmhIf09ae6ZTIuu00mZXwXx
Content-Type: multipart/mixed; boundary="------------WRdXqhg3WHnAK1RheeAQ0XId";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 vikram.garhwal@amd.com
Message-ID: <49666f77-9a09-c7ae-14aa-69abc283466f@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
 <ZKglzGG6PeRPPtbT@MacBook-Air-de-Roger.local>
In-Reply-To: <ZKglzGG6PeRPPtbT@MacBook-Air-de-Roger.local>

--------------WRdXqhg3WHnAK1RheeAQ0XId
Content-Type: multipart/mixed; boundary="------------BY9u42az07NLvopR7if6bw0b"

--------------BY9u42az07NLvopR7if6bw0b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTY6NDgsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIEZyaSwg
SnVsIDA3LCAyMDIzIGF0IDA0OjI3OjU5UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+PiBPbiAwNy4wNy4yMyAxNjoxMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+PiBPbiAw
Ny4wNy4yMyAxMTo1MCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+Pj4gT24gRnJpLCBK
dWwgMDcsIDIwMjMgYXQgMDY6Mzg6NDhBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+Pj4+IE9uIDA2LjA3LjIzIDIzOjQ5LCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+
Pj4+Pj4gT24gVGh1LCA2IEp1bCAyMDIzLCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4+
Pj4+PiBPbiBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwMzo0MToxMFBNIC0wNzAwLCBTdGVmYW5v
IFN0YWJlbGxpbmkgd3JvdGU6DQo+Pj4+Pj4+PiBPbiBXZWQsIDUgSnVsIDIwMjMsIFJvZ2Vy
IFBhdSBNb25uw6kgd3JvdGU6DQo+Pj4+Pj4+Pj4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQg
MDg6MTQ6NTlQTSArMDMwMCwgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6DQo+Pj4+Pj4+
Pj4+IFBhcnQgMiAoY2xhcmlmaWNhdGlvbik6DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEkg
dGhpbmsgdXNpbmcgYSBzcGVjaWFsIGNvbmZpZyBzcGFjZSByZWdpc3RlciBpbiB0aGUgcm9v
dCBjb21wbGV4IHdvdWxkDQo+Pj4+Pj4+Pj4+IG5vdCBiZSB0ZXJyaWJsZSBpbiB0ZXJtcyBv
ZiBndWVzdCBjaGFuZ2VzIGJlY2F1c2UgaXQgaXMgZWFzeSB0bw0KPj4+Pj4+Pj4+PiBpbnRy
b2R1Y2UgYSBuZXcgcm9vdCBjb21wbGV4IGRyaXZlciBpbiBMaW51eCBhbmQgb3RoZXIgT1Nl
cy4gVGhlIHJvb3QNCj4+Pj4+Pj4+Pj4gY29tcGxleCB3b3VsZCBzdGlsbCBiZSBFQ0FNIGNv
bXBhdGlibGUgc28gdGhlIHJlZ3VsYXIgRUNBTSBkcml2ZXIgd291bGQNCj4+Pj4+Pj4+Pj4g
c3RpbGwgd29yay4gQSBuZXcgZHJpdmVyIHdvdWxkIG9ubHkgYmUgbmVjZXNzYXJ5IGlmIHlv
dSB3YW50IHRvIGJlIGFibGUNCj4+Pj4+Pj4+Pj4gdG8gYWNjZXNzIHRoZSBzcGVjaWFsIGNv
bmZpZyBzcGFjZSByZWdpc3Rlci4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEknbSBzbGlnaHRs
eSB3b3JyeSBvZiB0aGlzIGFwcHJvYWNoLCB3ZSBlbmQgdXAgbW9kaWZ5aW5nIGEgcm9vdA0K
Pj4+Pj4+Pj4+IGNvbXBsZXggZW11bGF0aW9uIGluIG9yZGVyIHRvIGF2b2lkIG1vZGlmeWlu
ZyBhIFBDSSBkZXZpY2UgZW11bGF0aW9uDQo+Pj4+Pj4+Pj4gb24gUUVNVSwgbm90IHN1cmUg
dGhhdCdzIGEgZ29vZCB0cmFkZSBvZmYuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBOb3RlIGFs
c28gdGhhdCBkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlcyB3aWxsIGxpa2VseSBoYXZlIGRpZmZl
cmVudCByb290DQo+Pj4+Pj4+Pj4gY29tcGxleCwgYW5kIHNvIHlvdSBtaWdodCBuZWVkIHRv
IG1vZGlmeSBzZXZlcmFsIG9mIHRoZW0sIHBsdXMgdGhlbg0KPj4+Pj4+Pj4+IGFycmFuZ2Ug
dGhlIFBDSSBsYXlvdXQgY29ycmVjdGx5IGluIG9yZGVyIHRvIGhhdmUgdGhlIHByb3BlciBo
aWVyYXJjaHkNCj4+Pj4+Pj4+PiBzbyB0aGF0IGRldmljZXMgYmVsb25naW5nIHRvIGRpZmZl
cmVudCBkcml2ZXIgZG9tYWlucyBhcmUgYXNzaWduZWQgdG8NCj4+Pj4+Pj4+PiBkaWZmZXJl
bnQgYnJpZGdlcy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJIGRvIHRoaW5rIHRoYXQgYWRkaW5n
IHNvbWV0aGluZyB0byB0aGUgUENJIGNvbmYgcmVnaXN0ZXIgc29tZXdoZXJlIGlzDQo+Pj4+
Pj4+PiB0aGUgYmVzdCBvcHRpb24gYmVjYXVzZSBpdCBpcyBub3QgZGVwZW5kZW50IG9uIEFD
UEkgYW5kIGl0IGlzIG5vdA0KPj4+Pj4+Pj4gZGVwZW5kZW50IG9uIHhlbnN0b3JlIGJvdGgg
b2Ygd2hpY2ggYXJlIHZlcnkgdW5kZXNpcmFibGUuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSSBh
bSBub3Qgc3VyZSB3aGVyZSBzcGVjaWZpY2FsbHkgaXMgdGhlIGJlc3QgcGxhY2UuIFRoZXNl
IGFyZSAzIGlkZWFzDQo+Pj4+Pj4+PiB3ZSBjYW1lIHVwIHdpdGg6DQo+Pj4+Pj4+PiAxLiBQ
Q0kgcm9vdCBjb21wbGV4DQo+Pj4+Pj4+PiAyLiBhIHJlZ2lzdGVyIG9uIHRoZSBkZXZpY2Ug
aXRzZWxmDQo+Pj4+Pj4+PiAzLiBhIG5ldyBjYXBhYmlsaXR5IG9mIHRoZSBkZXZpY2UNCj4+
Pj4+Pj4+IDQuIGFkZCBvbmUgZXh0cmEgZHVtbXkgUENJIGRldmljZSBmb3IgdGhlIHNvbGUg
cHVycG9zZSBvZiBleHBvc2luZyB0aGUNCj4+Pj4+Pj4+ICDCoMKgwqDCoCBncmFudHMgY2Fw
YWJpbGl0eQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBMb29raW5nIGF0IHRoZSBz
cGVjLCB0aGVyZSBpcyBhIHdheSB0byBhZGQgYSB2ZW5kb3Itc3BlY2lmaWMgY2FwYWJpbGl0
eQ0KPj4+Pj4+Pj4gKGNhcF92bmRyID0gMHg5KS4gQ291bGQgd2UgdXNlIHRoYXQ/IEl0IGRv
ZXNuJ3QgbG9vayBsaWtlIGl0IGlzIHVzZWQNCj4+Pj4+Pj4+IHRvZGF5LCBMaW51eCBkb2Vz
bid0IHBhcnNlIGl0Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIGRpZCB3b25kZXIgdGhlIHNhbWUg
ZnJvbSBhIHF1aWNrIGxvb2sgYXQgdGhlIHNwZWMuwqAgVGhlcmUncyBob3dldmVyDQo+Pj4+
Pj4+IGEgdGV4dCBpbiB0aGUgc3BlY2lmaWNhdGlvbiB0aGF0IHNheXM6DQo+Pj4+Pj4+DQo+
Pj4+Pj4+ICJUaGUgZHJpdmVyIFNIT1VMRCBOT1QgdXNlIHRoZSBWZW5kb3IgZGF0YSBjYXBh
YmlsaXR5IGV4Y2VwdCBmb3INCj4+Pj4+Pj4gZGVidWdnaW5nIGFuZCByZXBvcnRpbmcgcHVy
cG9zZXMuIg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTbyB3ZSB3b3VsZCBhdCBsZWFzdCBuZWVkIHRv
IGNoYW5nZSB0aGF0IGJlY2F1c2UgdGhlIGNhcGFiaWxpdHkgd291bGQNCj4+Pj4+Pj4gdGhl
biBiZSB1c2VkIGJ5IG90aGVyIHB1cnBvc2VzIGRpZmZlcmVudCB0aGFuIGRlYnVnZ2luZyBh
bmQgcmVwb3J0aW5nLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTZWVtcyBsaWtlIGEgbWlub3IgYWRq
dXN0bWVudCwgc28gbWlnaHQgd2Ugd29ydGggYXNraW5nIHVwc3RyZWFtIGFib3V0DQo+Pj4+
Pj4+IHRoZWlyIG9waW5pb24sIGFuZCB0byBnZXQgYSBjb252ZXJzYXRpb24gc3RhcnRlZC4N
Cj4+Pj4+Pg0KPj4+Pj4+IFdhaXQsIHdvdWxkbid0IHRoaXMgdXNlLWNhc2UgZmFsbCB1bmRl
ciAicmVwb3J0aW5nIiA/IEl0IGlzIGV4YWN0bHkgd2hhdA0KPj4+Pj4+IHdlIGFyZSBkb2lu
ZywgcmlnaHQ/DQo+Pj4+Pg0KPj4+Pj4gSSdkIHVuZGVyc3RhbmQgInJlcG9ydGluZyIgYXMg
ZS5nLiBsb2dnaW5nLCB0cmFuc2ZlcnJpbmcgc3RhdGlzdGljcywgLi4uDQo+Pj4+Pg0KPj4+
Pj4gV2UnZCBsaWtlIHRvIHVzZSBpdCBmb3IgY29uZmlndXJhdGlvbiBwdXJwb3Nlcy4NCj4+
Pj4NCj4+Pj4gSSd2ZSBhbHNvIHJlYWQgaXQgdGhhdCB3YXkuDQo+Pj4+DQo+Pj4+PiBBbm90
aGVyIGlkZWEgd291bGQgYmUgdG8gZW5oYW5jZSB0aGUgdmlydGlvIElPTU1VIGRldmljZSB0
byBzdWl0IG91ciBuZWVkczoNCj4+Pj4+IHdlIGNvdWxkIGFkZCB0aGUgZG9taWQgYXMgYW5v
dGhlciB2aXJ0aW8gSU9NTVUgZGV2aWNlIGNhcGFiaWxpdHkgYW5kIChmb3Igbm93KQ0KPj4+
Pj4gdXNlIGJ5cGFzcyBtb2RlIGZvciBhbGwgInByb2R1Y3RpdmUiIGRldmljZXMuDQo+Pj4+
DQo+Pj4+IElmIHdlIGhhdmUgdG8gc3RhcnQgYWRkaW5nIGNhcGFiaWx0aWVzLCB3b24ndCBp
dCBiZSBlYXNpZXIgdG8ganVzdCBhZGQNCj4+Pj4gaXQgdG8gdGhlIGVhY2ggZGV2aWNlIGlu
c3RlYWQgb2YgYWRkaW5nIGl0IHRvIHZpcnRpbyBJT01NVS7CoCBPciBpcyB0aGUNCj4+Pj4g
cGFyc2luZyBvZiBjYXBhYmlsaXRpZXMgZGV2aWNlIHNwZWNpZmljLCBhbmQgaGVuY2Ugd2Ug
d291bGQgaGF2ZSB0bw0KPj4+PiBpbXBsZW1lbnQgc3VjaCBwYXJzaW5nIGZvciBlYWNoIGRl
dmljZT/CoCBJIHdvdWxkIGV4cGVjdCBzb21lDQo+Pj4+IGNhcGFiaWxpdGllcyBhcmUgc2hh
cmVkIGJldHdlZW4gYWxsIGRldmljZXMsIGFuZCBhIFhlbiBjYXBhYmlsaXR5IGNvdWxkDQo+
Pj4+IGJlIG9uZSBvZiB0aG9zZS4NCj4+Pg0KPj4+IEhhdmUgYSBsb29rIGF0IFsxXSwgd2hp
Y2ggaXMgZGVzY3JpYmluZyB0aGUgY29tbW9uIGRldmljZSBjb25maWcgbGF5b3V0Lg0KPj4+
IFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB3ZSdkIG5lZWQgdG8gYWRkIHRoZSBkb21pZCBh
ZnRlciB0aGUgcXVldWUgc3BlY2lmaWMNCj4+PiBkYXRhLCByZXN1bHRpbmcgaW4gYSBtZXNz
IGlmIGZ1cnRoZXIgcXVldWUgZmllbGRzIHdvdWxkIGJlIGFkZGVkIGxhdGVyLg0KPj4+DQo+
Pj4gV2UgY291bGQgdHJ5IHRoYXQsIG9mIGNvdXJzZS4NCj4+DQo+PiBUaGlua2luZyBtb3Jl
IGFib3V0IGl0LCB0aGUgdmlydGlvIElPTU1VIGRldmljZSBzZWVtcyB0byBiZSBhIGJldHRl
ciBmaXQ6DQo+Pg0KPj4gSW4gY2FzZSB3ZSdkIGFkZCB0aGUgZG9taWQgdG8gdGhlIGRldmlj
ZSdzIFBDSSBjb25maWcgc3BhY2UsIHRoZSB2YWx1ZSB3b3VsZA0KPj4gYmUgY29udHJvbGxl
ZCBieSB0aGUgYmFja2VuZCBkb21haW4uIElNTyB0aGUgZG9taWQgcGFzc2VkIHRvIHRoZSBm
cm9udGVuZA0KPj4gc2hvdWxkIGJlIGNvbnRyb2xsZWQgYnkgYSB0cnVzdGVkIGVudGl0eSAo
ZG9tMCBvciB0aGUgaHlwZXJ2aXNvciksIHdoaWNoDQo+PiB3b3VsZCBiZSB0aGUgbmF0dXJh
bCBiYWNrZW5kIG9mIHRoZSB2aXJ0aW8gSU9NTVUgZGV2aWNlLg0KPiANCj4gSG0sIHllcy4g
IEknbSBob3dldmVyIGZhaWxpbmcgdG8gc2VlIGhvdyBhIGJhY2tlZCBjb3VsZCBleHBsb2l0
IHRoYXQuDQo+IA0KPiBUaGUgZ3Vlc3Qgd291bGQgYmUgZ3JhbnRpbmcgbWVtb3J5IHRvIGEg
ZGlmZmVyZW50IGRvbWFpbiB0aGFuIHRoZSBvbmUNCj4gcnVubmluZyB0aGUgYmFja2VuZCwg
YnV0IG90aGVyd2lzZSB0aGF0IG1lbW9yeSB3b3VsZCBiZSBncmFudGVkIHRvIHRoZQ0KPiBi
YWNrZW5kIGRvbWFpbiwgd2hpY2ggY291bGQgdGhlbiBhbHNvIG1ha2UgaXQgYXZhaWxhYmxl
IHRvIG90aGVyDQo+IGRvbWFpbnMgKHdpdGhvdXQgaGF2aW5nIHRvIHBsYXkgd2l0aCB0aGUg
cmVwb3J0ZWQgYmFja2VuZCBkb21pZCkuDQoNCkkgYWdyZWUgdGhhdCBhbiBleHBsb2l0IGlz
IGF0IGxlYXN0IG5vdCBvYnZpb3VzLg0KDQpJdCBpcyBzdGlsbCBub3QgYSBjbGVhbiBzb2x1
dGlvbiwgdGhvdWdoLg0KDQpHaXZpbmcgdGhlIHdyb25nIGRvbWFpbiBkaXJlY3QgYWNjZXNz
IHRvIHNvbWUgb2YgdGhlIGd1ZXN0J3MgbWVtb3J5IGlzIHdvcnNlDQp0aGFuIHRoZSBhYmls
aXR5IHRvIHBhc3MgdGhlIGNvbnRlbnRzIGluZGlyZWN0bHkgdG8gdGhlIHdyb25nIGRvbWFp
biBJTUhPLg0KDQoNCkp1ZXJnZW4NCg==
--------------BY9u42az07NLvopR7if6bw0b
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BY9u42az07NLvopR7if6bw0b--

--------------WRdXqhg3WHnAK1RheeAQ0XId--

--------------ocmhIf09ae6ZTIuu00mZXwXx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSoK90FAwAAAAAACgkQsN6d1ii/Ey+p
Dgf/Um3UHSq2Is8ZwWA00WlHPw/TPUeCfGx3vdzGlvOMAULR9ln3FRgrZNqJ75C2WJLatRG3CkiW
YKqrbkFUtin1cSDIgfTsdA8BAkpAJAXqy/gPKGnkz3va5NbI+UNgatr60st4a2EaX6DHzg0WCGST
/bfenmKSdcemtonoI6PvACtjbpmbjmJbnCHyCESy1PM5vxF8ADE3MhsnLyETwAFeYqf9qthcPg1M
s4Ev4ROtzd4c4JGDwCi8vHc75FgjpHQZ6E+4LOxLY69DjK5N03knKppToBkVhUD0wIVTNciVjsQb
azjvdEDSHch9aBU1RERfu4tBZ7ZiGsBqlfED1di8SA==
=EDmY
-----END PGP SIGNATURE-----

--------------ocmhIf09ae6ZTIuu00mZXwXx--
