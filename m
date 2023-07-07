Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB474B307
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGGO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjGGO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:28:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513AB11B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:28:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D4B811FDA8;
        Fri,  7 Jul 2023 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688740080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDaG49MjZZ9m6rAsgdhSgUWt0nb0O6bInSa3AoannsE=;
        b=fZOF2qUCjwV+xQr8V7MSqKPKHfuznzo01lfvFBPGCGfpXBYBdI6I4gvOXxtmW94JmZap5L
        CVePKAPRJgYQPmu/VMKwDm+Xt5cFfUjeN5F2uFHisCE9J2ZsKI2Hq5gJ65D+Ze0lm30E9j
        jL3K/xOKH244Oqsiyn1Zm5E77YQYZRc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E144139E0;
        Fri,  7 Jul 2023 14:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q6ZFHfAgqGS0dQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 14:28:00 +0000
Message-ID: <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
Date:   Fri, 7 Jul 2023 16:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
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
References: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
In-Reply-To: <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Rn6WLhPRazTf0w0yBOa9MskN"
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
--------------Rn6WLhPRazTf0w0yBOa9MskN
Content-Type: multipart/mixed; boundary="------------0aHEKMBKGLFCUAXrXu1i8iGv";
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
Message-ID: <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
In-Reply-To: <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>

--------------0aHEKMBKGLFCUAXrXu1i8iGv
Content-Type: multipart/mixed; boundary="------------XUZAguPkyzrC4lcfNeo16yqk"

--------------XUZAguPkyzrC4lcfNeo16yqk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTY6MTAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDA3LjA3LjIz
IDExOjUwLCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4gT24gRnJpLCBKdWwgMDcsIDIw
MjMgYXQgMDY6Mzg6NDhBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+PiBPbiAw
Ni4wNy4yMyAyMzo0OSwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4+PiBPbiBUaHUs
IDYgSnVsIDIwMjMsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIEp1
bCAwNSwgMjAyMyBhdCAwMzo0MToxMFBNIC0wNzAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3Jv
dGU6DQo+Pj4+Pj4gT24gV2VkLCA1IEp1bCAyMDIzLCBSb2dlciBQYXUgTW9ubsOpIHdyb3Rl
Og0KPj4+Pj4+PiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwODoxNDo1OVBNICswMzAwLCBP
bGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+Pj4+Pj4+IFBhcnQgMiAoY2xhcmlmaWNh
dGlvbik6DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSSB0aGluayB1c2luZyBhIHNwZWNpYWwgY29u
ZmlnIHNwYWNlIHJlZ2lzdGVyIGluIHRoZSByb290IGNvbXBsZXggd291bGQNCj4+Pj4+Pj4+
IG5vdCBiZSB0ZXJyaWJsZSBpbiB0ZXJtcyBvZiBndWVzdCBjaGFuZ2VzIGJlY2F1c2UgaXQg
aXMgZWFzeSB0bw0KPj4+Pj4+Pj4gaW50cm9kdWNlIGEgbmV3IHJvb3QgY29tcGxleCBkcml2
ZXIgaW4gTGludXggYW5kIG90aGVyIE9TZXMuIFRoZSByb290DQo+Pj4+Pj4+PiBjb21wbGV4
IHdvdWxkIHN0aWxsIGJlIEVDQU0gY29tcGF0aWJsZSBzbyB0aGUgcmVndWxhciBFQ0FNIGRy
aXZlciB3b3VsZA0KPj4+Pj4+Pj4gc3RpbGwgd29yay4gQSBuZXcgZHJpdmVyIHdvdWxkIG9u
bHkgYmUgbmVjZXNzYXJ5IGlmIHlvdSB3YW50IHRvIGJlIGFibGUNCj4+Pj4+Pj4+IHRvIGFj
Y2VzcyB0aGUgc3BlY2lhbCBjb25maWcgc3BhY2UgcmVnaXN0ZXIuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IEknbSBzbGlnaHRseSB3b3JyeSBvZiB0aGlzIGFwcHJvYWNoLCB3ZSBlbmQgdXAgbW9k
aWZ5aW5nIGEgcm9vdA0KPj4+Pj4+PiBjb21wbGV4IGVtdWxhdGlvbiBpbiBvcmRlciB0byBh
dm9pZCBtb2RpZnlpbmcgYSBQQ0kgZGV2aWNlIGVtdWxhdGlvbg0KPj4+Pj4+PiBvbiBRRU1V
LCBub3Qgc3VyZSB0aGF0J3MgYSBnb29kIHRyYWRlIG9mZi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
Tm90ZSBhbHNvIHRoYXQgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMgd2lsbCBsaWtlbHkgaGF2
ZSBkaWZmZXJlbnQgcm9vdA0KPj4+Pj4+PiBjb21wbGV4LCBhbmQgc28geW91IG1pZ2h0IG5l
ZWQgdG8gbW9kaWZ5IHNldmVyYWwgb2YgdGhlbSwgcGx1cyB0aGVuDQo+Pj4+Pj4+IGFycmFu
Z2UgdGhlIFBDSSBsYXlvdXQgY29ycmVjdGx5IGluIG9yZGVyIHRvIGhhdmUgdGhlIHByb3Bl
ciBoaWVyYXJjaHkNCj4+Pj4+Pj4gc28gdGhhdCBkZXZpY2VzIGJlbG9uZ2luZyB0byBkaWZm
ZXJlbnQgZHJpdmVyIGRvbWFpbnMgYXJlIGFzc2lnbmVkIHRvDQo+Pj4+Pj4+IGRpZmZlcmVu
dCBicmlkZ2VzLg0KPj4+Pj4+DQo+Pj4+Pj4gSSBkbyB0aGluayB0aGF0IGFkZGluZyBzb21l
dGhpbmcgdG8gdGhlIFBDSSBjb25mIHJlZ2lzdGVyIHNvbWV3aGVyZSBpcw0KPj4+Pj4+IHRo
ZSBiZXN0IG9wdGlvbiBiZWNhdXNlIGl0IGlzIG5vdCBkZXBlbmRlbnQgb24gQUNQSSBhbmQg
aXQgaXMgbm90DQo+Pj4+Pj4gZGVwZW5kZW50IG9uIHhlbnN0b3JlIGJvdGggb2Ygd2hpY2gg
YXJlIHZlcnkgdW5kZXNpcmFibGUuDQo+Pj4+Pj4NCj4+Pj4+PiBJIGFtIG5vdCBzdXJlIHdo
ZXJlIHNwZWNpZmljYWxseSBpcyB0aGUgYmVzdCBwbGFjZS4gVGhlc2UgYXJlIDMgaWRlYXMN
Cj4+Pj4+PiB3ZSBjYW1lIHVwIHdpdGg6DQo+Pj4+Pj4gMS4gUENJIHJvb3QgY29tcGxleA0K
Pj4+Pj4+IDIuIGEgcmVnaXN0ZXIgb24gdGhlIGRldmljZSBpdHNlbGYNCj4+Pj4+PiAzLiBh
IG5ldyBjYXBhYmlsaXR5IG9mIHRoZSBkZXZpY2UNCj4+Pj4+PiA0LiBhZGQgb25lIGV4dHJh
IGR1bW15IFBDSSBkZXZpY2UgZm9yIHRoZSBzb2xlIHB1cnBvc2Ugb2YgZXhwb3NpbmcgdGhl
DQo+Pj4+Pj4gwqDCoMKgwqAgZ3JhbnRzIGNhcGFiaWxpdHkNCj4+Pj4+Pg0KPj4+Pj4+DQo+
Pj4+Pj4gTG9va2luZyBhdCB0aGUgc3BlYywgdGhlcmUgaXMgYSB3YXkgdG8gYWRkIGEgdmVu
ZG9yLXNwZWNpZmljIGNhcGFiaWxpdHkNCj4+Pj4+PiAoY2FwX3ZuZHIgPSAweDkpLiBDb3Vs
ZCB3ZSB1c2UgdGhhdD8gSXQgZG9lc24ndCBsb29rIGxpa2UgaXQgaXMgdXNlZA0KPj4+Pj4+
IHRvZGF5LCBMaW51eCBkb2Vzbid0IHBhcnNlIGl0Lg0KPj4+Pj4NCj4+Pj4+IEkgZGlkIHdv
bmRlciB0aGUgc2FtZSBmcm9tIGEgcXVpY2sgbG9vayBhdCB0aGUgc3BlYy7CoCBUaGVyZSdz
IGhvd2V2ZXINCj4+Pj4+IGEgdGV4dCBpbiB0aGUgc3BlY2lmaWNhdGlvbiB0aGF0IHNheXM6
DQo+Pj4+Pg0KPj4+Pj4gIlRoZSBkcml2ZXIgU0hPVUxEIE5PVCB1c2UgdGhlIFZlbmRvciBk
YXRhIGNhcGFiaWxpdHkgZXhjZXB0IGZvcg0KPj4+Pj4gZGVidWdnaW5nIGFuZCByZXBvcnRp
bmcgcHVycG9zZXMuIg0KPj4+Pj4NCj4+Pj4+IFNvIHdlIHdvdWxkIGF0IGxlYXN0IG5lZWQg
dG8gY2hhbmdlIHRoYXQgYmVjYXVzZSB0aGUgY2FwYWJpbGl0eSB3b3VsZA0KPj4+Pj4gdGhl
biBiZSB1c2VkIGJ5IG90aGVyIHB1cnBvc2VzIGRpZmZlcmVudCB0aGFuIGRlYnVnZ2luZyBh
bmQgcmVwb3J0aW5nLg0KPj4+Pj4NCj4+Pj4+IFNlZW1zIGxpa2UgYSBtaW5vciBhZGp1c3Rt
ZW50LCBzbyBtaWdodCB3ZSB3b3J0aCBhc2tpbmcgdXBzdHJlYW0gYWJvdXQNCj4+Pj4+IHRo
ZWlyIG9waW5pb24sIGFuZCB0byBnZXQgYSBjb252ZXJzYXRpb24gc3RhcnRlZC4NCj4+Pj4N
Cj4+Pj4gV2FpdCwgd291bGRuJ3QgdGhpcyB1c2UtY2FzZSBmYWxsIHVuZGVyICJyZXBvcnRp
bmciID8gSXQgaXMgZXhhY3RseSB3aGF0DQo+Pj4+IHdlIGFyZSBkb2luZywgcmlnaHQ/DQo+
Pj4NCj4+PiBJJ2QgdW5kZXJzdGFuZCAicmVwb3J0aW5nIiBhcyBlLmcuIGxvZ2dpbmcsIHRy
YW5zZmVycmluZyBzdGF0aXN0aWNzLCAuLi4NCj4+Pg0KPj4+IFdlJ2QgbGlrZSB0byB1c2Ug
aXQgZm9yIGNvbmZpZ3VyYXRpb24gcHVycG9zZXMuDQo+Pg0KPj4gSSd2ZSBhbHNvIHJlYWQg
aXQgdGhhdCB3YXkuDQo+Pg0KPj4+IEFub3RoZXIgaWRlYSB3b3VsZCBiZSB0byBlbmhhbmNl
IHRoZSB2aXJ0aW8gSU9NTVUgZGV2aWNlIHRvIHN1aXQgb3VyIG5lZWRzOg0KPj4+IHdlIGNv
dWxkIGFkZCB0aGUgZG9taWQgYXMgYW5vdGhlciB2aXJ0aW8gSU9NTVUgZGV2aWNlIGNhcGFi
aWxpdHkgYW5kIChmb3Igbm93KQ0KPj4+IHVzZSBieXBhc3MgbW9kZSBmb3IgYWxsICJwcm9k
dWN0aXZlIiBkZXZpY2VzLg0KPj4NCj4+IElmIHdlIGhhdmUgdG8gc3RhcnQgYWRkaW5nIGNh
cGFiaWx0aWVzLCB3b24ndCBpdCBiZSBlYXNpZXIgdG8ganVzdCBhZGQNCj4+IGl0IHRvIHRo
ZSBlYWNoIGRldmljZSBpbnN0ZWFkIG9mIGFkZGluZyBpdCB0byB2aXJ0aW8gSU9NTVUuwqAg
T3IgaXMgdGhlDQo+PiBwYXJzaW5nIG9mIGNhcGFiaWxpdGllcyBkZXZpY2Ugc3BlY2lmaWMs
IGFuZCBoZW5jZSB3ZSB3b3VsZCBoYXZlIHRvDQo+PiBpbXBsZW1lbnQgc3VjaCBwYXJzaW5n
IGZvciBlYWNoIGRldmljZT/CoCBJIHdvdWxkIGV4cGVjdCBzb21lDQo+PiBjYXBhYmlsaXRp
ZXMgYXJlIHNoYXJlZCBiZXR3ZWVuIGFsbCBkZXZpY2VzLCBhbmQgYSBYZW4gY2FwYWJpbGl0
eSBjb3VsZA0KPj4gYmUgb25lIG9mIHRob3NlLg0KPiANCj4gSGF2ZSBhIGxvb2sgYXQgWzFd
LCB3aGljaCBpcyBkZXNjcmliaW5nIHRoZSBjb21tb24gZGV2aWNlIGNvbmZpZyBsYXlvdXQu
DQo+IFRoZSBwcm9ibGVtIGhlcmUgaXMgdGhhdCB3ZSdkIG5lZWQgdG8gYWRkIHRoZSBkb21p
ZCBhZnRlciB0aGUgcXVldWUgc3BlY2lmaWMNCj4gZGF0YSwgcmVzdWx0aW5nIGluIGEgbWVz
cyBpZiBmdXJ0aGVyIHF1ZXVlIGZpZWxkcyB3b3VsZCBiZSBhZGRlZCBsYXRlci4NCj4gDQo+
IFdlIGNvdWxkIHRyeSB0aGF0LCBvZiBjb3Vyc2UuDQoNClRoaW5raW5nIG1vcmUgYWJvdXQg
aXQsIHRoZSB2aXJ0aW8gSU9NTVUgZGV2aWNlIHNlZW1zIHRvIGJlIGEgYmV0dGVyIGZpdDoN
Cg0KSW4gY2FzZSB3ZSdkIGFkZCB0aGUgZG9taWQgdG8gdGhlIGRldmljZSdzIFBDSSBjb25m
aWcgc3BhY2UsIHRoZSB2YWx1ZSB3b3VsZA0KYmUgY29udHJvbGxlZCBieSB0aGUgYmFja2Vu
ZCBkb21haW4uIElNTyB0aGUgZG9taWQgcGFzc2VkIHRvIHRoZSBmcm9udGVuZA0Kc2hvdWxk
IGJlIGNvbnRyb2xsZWQgYnkgYSB0cnVzdGVkIGVudGl0eSAoZG9tMCBvciB0aGUgaHlwZXJ2
aXNvciksIHdoaWNoDQp3b3VsZCBiZSB0aGUgbmF0dXJhbCBiYWNrZW5kIG9mIHRoZSB2aXJ0
aW8gSU9NTVUgZGV2aWNlLg0KDQoNCkp1ZXJnZW4NCg==
--------------XUZAguPkyzrC4lcfNeo16yqk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------XUZAguPkyzrC4lcfNeo16yqk--

--------------0aHEKMBKGLFCUAXrXu1i8iGv--

--------------Rn6WLhPRazTf0w0yBOa9MskN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSoIO8FAwAAAAAACgkQsN6d1ii/Ey8+
igf/YjozvDjTT9kxQ8QX9wWc53sCrD4GUm+mbOU7Vs1u8mv7lXghI9FV4AWSfh9ivTooCmyCHHzn
+ReSltsXL2RA8g/WPMzkOlHuNc+XnQ7IXqULbo2YmnMbfHRRpUJnVQIgsvw2vwvAG3aNYGCqGimC
E7JI0B7NJbTzpq9wdK0rIlpjoVkPtMOXLBGGMkzK4V0KMNCra/x76GnQocoOUzoULTqlvxLpkctR
/Uifpaa0D4+5fdT+GXW6YLs8WudbanEadyHPZk3FBa6a5wfeHbMFUKi6YOvz6X6bzV/L6LYbYm4I
42d/xj0+NwTw3Mh3/c2Xn2j2PrW5EmPkTic1fEDT9A==
=T4SZ
-----END PGP SIGNATURE-----

--------------Rn6WLhPRazTf0w0yBOa9MskN--
