Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9C74B37C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjGGPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjGGPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:01:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED67A1FE2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:01:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DC7D21FDA;
        Fri,  7 Jul 2023 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688742099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4EqfZJRTxbQuGVjSPLr63ME7XafOxIVx9aKgPnt0iI=;
        b=QXlUv1AZALz90FOznmXs8QKIXIDubSQJY04EbTEGaOkzZYseGoib0SbW9zHsctuNHP7FkZ
        B4/ns5qVWwbM6nZ1l9m+HGDXZRZLwVi2n1n3Nt6MuGslE2Fob01PViRH7agJPt6xewg5Vl
        39v8diqI3T+guS0mnJraQtMBzt7un3c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39306139E0;
        Fri,  7 Jul 2023 15:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q+x6DNMoqGRHBwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 15:01:39 +0000
Message-ID: <106781fe-992b-8609-fe37-17619b699353@suse.com>
Date:   Fri, 7 Jul 2023 17:01:38 +0200
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
References: <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nhuD3mfs5ESRhYQN0JOgqySB"
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
--------------nhuD3mfs5ESRhYQN0JOgqySB
Content-Type: multipart/mixed; boundary="------------8xnNKwnpjYsQU5Wv6RIpCTmH";
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
Message-ID: <106781fe-992b-8609-fe37-17619b699353@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
In-Reply-To: <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>

--------------8xnNKwnpjYsQU5Wv6RIpCTmH
Content-Type: multipart/mixed; boundary="------------Th0Hc0gn0HmlyNGGZo5YwJr6"

--------------Th0Hc0gn0HmlyNGGZo5YwJr6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTY6NDIsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIEZyaSwg
SnVsIDA3LCAyMDIzIGF0IDA0OjEwOjE0UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+PiBPbiAwNy4wNy4yMyAxMTo1MCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+PiBP
biBGcmksIEp1bCAwNywgMjAyMyBhdCAwNjozODo0OEFNICswMjAwLCBKdWVyZ2VuIEdyb3Nz
IHdyb3RlOg0KPj4+PiBPbiAwNi4wNy4yMyAyMzo0OSwgU3RlZmFubyBTdGFiZWxsaW5pIHdy
b3RlOg0KPj4+Pj4gT24gVGh1LCA2IEp1bCAyMDIzLCBSb2dlciBQYXUgTW9ubsOpIHdyb3Rl
Og0KPj4+Pj4+IE9uIFdlZCwgSnVsIDA1LCAyMDIzIGF0IDAzOjQxOjEwUE0gLTA3MDAsIFN0
ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+Pj4+Pj4gT24gV2VkLCA1IEp1bCAyMDIzLCBS
b2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4+Pj4+Pj4gT24gVHVlLCBKdWwgMDQsIDIwMjMg
YXQgMDg6MTQ6NTlQTSArMDMwMCwgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6DQo+Pj4+
Pj4+Pj4gUGFydCAyIChjbGFyaWZpY2F0aW9uKToNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEkg
dGhpbmsgdXNpbmcgYSBzcGVjaWFsIGNvbmZpZyBzcGFjZSByZWdpc3RlciBpbiB0aGUgcm9v
dCBjb21wbGV4IHdvdWxkDQo+Pj4+Pj4+Pj4gbm90IGJlIHRlcnJpYmxlIGluIHRlcm1zIG9m
IGd1ZXN0IGNoYW5nZXMgYmVjYXVzZSBpdCBpcyBlYXN5IHRvDQo+Pj4+Pj4+Pj4gaW50cm9k
dWNlIGEgbmV3IHJvb3QgY29tcGxleCBkcml2ZXIgaW4gTGludXggYW5kIG90aGVyIE9TZXMu
IFRoZSByb290DQo+Pj4+Pj4+Pj4gY29tcGxleCB3b3VsZCBzdGlsbCBiZSBFQ0FNIGNvbXBh
dGlibGUgc28gdGhlIHJlZ3VsYXIgRUNBTSBkcml2ZXIgd291bGQNCj4+Pj4+Pj4+PiBzdGls
bCB3b3JrLiBBIG5ldyBkcml2ZXIgd291bGQgb25seSBiZSBuZWNlc3NhcnkgaWYgeW91IHdh
bnQgdG8gYmUgYWJsZQ0KPj4+Pj4+Pj4+IHRvIGFjY2VzcyB0aGUgc3BlY2lhbCBjb25maWcg
c3BhY2UgcmVnaXN0ZXIuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSSdtIHNsaWdodGx5IHdvcnJ5
IG9mIHRoaXMgYXBwcm9hY2gsIHdlIGVuZCB1cCBtb2RpZnlpbmcgYSByb290DQo+Pj4+Pj4+
PiBjb21wbGV4IGVtdWxhdGlvbiBpbiBvcmRlciB0byBhdm9pZCBtb2RpZnlpbmcgYSBQQ0kg
ZGV2aWNlIGVtdWxhdGlvbg0KPj4+Pj4+Pj4gb24gUUVNVSwgbm90IHN1cmUgdGhhdCdzIGEg
Z29vZCB0cmFkZSBvZmYuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gTm90ZSBhbHNvIHRoYXQgZGlm
ZmVyZW50IGFyY2hpdGVjdHVyZXMgd2lsbCBsaWtlbHkgaGF2ZSBkaWZmZXJlbnQgcm9vdA0K
Pj4+Pj4+Pj4gY29tcGxleCwgYW5kIHNvIHlvdSBtaWdodCBuZWVkIHRvIG1vZGlmeSBzZXZl
cmFsIG9mIHRoZW0sIHBsdXMgdGhlbg0KPj4+Pj4+Pj4gYXJyYW5nZSB0aGUgUENJIGxheW91
dCBjb3JyZWN0bHkgaW4gb3JkZXIgdG8gaGF2ZSB0aGUgcHJvcGVyIGhpZXJhcmNoeQ0KPj4+
Pj4+Pj4gc28gdGhhdCBkZXZpY2VzIGJlbG9uZ2luZyB0byBkaWZmZXJlbnQgZHJpdmVyIGRv
bWFpbnMgYXJlIGFzc2lnbmVkIHRvDQo+Pj4+Pj4+PiBkaWZmZXJlbnQgYnJpZGdlcy4NCj4+
Pj4+Pj4NCj4+Pj4+Pj4gSSBkbyB0aGluayB0aGF0IGFkZGluZyBzb21ldGhpbmcgdG8gdGhl
IFBDSSBjb25mIHJlZ2lzdGVyIHNvbWV3aGVyZSBpcw0KPj4+Pj4+PiB0aGUgYmVzdCBvcHRp
b24gYmVjYXVzZSBpdCBpcyBub3QgZGVwZW5kZW50IG9uIEFDUEkgYW5kIGl0IGlzIG5vdA0K
Pj4+Pj4+PiBkZXBlbmRlbnQgb24geGVuc3RvcmUgYm90aCBvZiB3aGljaCBhcmUgdmVyeSB1
bmRlc2lyYWJsZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSBhbSBub3Qgc3VyZSB3aGVyZSBzcGVj
aWZpY2FsbHkgaXMgdGhlIGJlc3QgcGxhY2UuIFRoZXNlIGFyZSAzIGlkZWFzDQo+Pj4+Pj4+
IHdlIGNhbWUgdXAgd2l0aDoNCj4+Pj4+Pj4gMS4gUENJIHJvb3QgY29tcGxleA0KPj4+Pj4+
PiAyLiBhIHJlZ2lzdGVyIG9uIHRoZSBkZXZpY2UgaXRzZWxmDQo+Pj4+Pj4+IDMuIGEgbmV3
IGNhcGFiaWxpdHkgb2YgdGhlIGRldmljZQ0KPj4+Pj4+PiA0LiBhZGQgb25lIGV4dHJhIGR1
bW15IFBDSSBkZXZpY2UgZm9yIHRoZSBzb2xlIHB1cnBvc2Ugb2YgZXhwb3NpbmcgdGhlDQo+
Pj4+Pj4+ICAgICAgIGdyYW50cyBjYXBhYmlsaXR5DQo+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+
Pj4+IExvb2tpbmcgYXQgdGhlIHNwZWMsIHRoZXJlIGlzIGEgd2F5IHRvIGFkZCBhIHZlbmRv
ci1zcGVjaWZpYyBjYXBhYmlsaXR5DQo+Pj4+Pj4+IChjYXBfdm5kciA9IDB4OSkuIENvdWxk
IHdlIHVzZSB0aGF0PyBJdCBkb2Vzbid0IGxvb2sgbGlrZSBpdCBpcyB1c2VkDQo+Pj4+Pj4+
IHRvZGF5LCBMaW51eCBkb2Vzbid0IHBhcnNlIGl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gSSBkaWQg
d29uZGVyIHRoZSBzYW1lIGZyb20gYSBxdWljayBsb29rIGF0IHRoZSBzcGVjLiAgVGhlcmUn
cyBob3dldmVyDQo+Pj4+Pj4gYSB0ZXh0IGluIHRoZSBzcGVjaWZpY2F0aW9uIHRoYXQgc2F5
czoNCj4+Pj4+Pg0KPj4+Pj4+ICJUaGUgZHJpdmVyIFNIT1VMRCBOT1QgdXNlIHRoZSBWZW5k
b3IgZGF0YSBjYXBhYmlsaXR5IGV4Y2VwdCBmb3INCj4+Pj4+PiBkZWJ1Z2dpbmcgYW5kIHJl
cG9ydGluZyBwdXJwb3Nlcy4iDQo+Pj4+Pj4NCj4+Pj4+PiBTbyB3ZSB3b3VsZCBhdCBsZWFz
dCBuZWVkIHRvIGNoYW5nZSB0aGF0IGJlY2F1c2UgdGhlIGNhcGFiaWxpdHkgd291bGQNCj4+
Pj4+PiB0aGVuIGJlIHVzZWQgYnkgb3RoZXIgcHVycG9zZXMgZGlmZmVyZW50IHRoYW4gZGVi
dWdnaW5nIGFuZCByZXBvcnRpbmcuDQo+Pj4+Pj4NCj4+Pj4+PiBTZWVtcyBsaWtlIGEgbWlu
b3IgYWRqdXN0bWVudCwgc28gbWlnaHQgd2Ugd29ydGggYXNraW5nIHVwc3RyZWFtIGFib3V0
DQo+Pj4+Pj4gdGhlaXIgb3BpbmlvbiwgYW5kIHRvIGdldCBhIGNvbnZlcnNhdGlvbiBzdGFy
dGVkLg0KPj4+Pj4NCj4+Pj4+IFdhaXQsIHdvdWxkbid0IHRoaXMgdXNlLWNhc2UgZmFsbCB1
bmRlciAicmVwb3J0aW5nIiA/IEl0IGlzIGV4YWN0bHkgd2hhdA0KPj4+Pj4gd2UgYXJlIGRv
aW5nLCByaWdodD8NCj4+Pj4NCj4+Pj4gSSdkIHVuZGVyc3RhbmQgInJlcG9ydGluZyIgYXMg
ZS5nLiBsb2dnaW5nLCB0cmFuc2ZlcnJpbmcgc3RhdGlzdGljcywgLi4uDQo+Pj4+DQo+Pj4+
IFdlJ2QgbGlrZSB0byB1c2UgaXQgZm9yIGNvbmZpZ3VyYXRpb24gcHVycG9zZXMuDQo+Pj4N
Cj4+PiBJJ3ZlIGFsc28gcmVhZCBpdCB0aGF0IHdheS4NCj4+Pg0KPj4+PiBBbm90aGVyIGlk
ZWEgd291bGQgYmUgdG8gZW5oYW5jZSB0aGUgdmlydGlvIElPTU1VIGRldmljZSB0byBzdWl0
IG91ciBuZWVkczoNCj4+Pj4gd2UgY291bGQgYWRkIHRoZSBkb21pZCBhcyBhbm90aGVyIHZp
cnRpbyBJT01NVSBkZXZpY2UgY2FwYWJpbGl0eSBhbmQgKGZvciBub3cpDQo+Pj4+IHVzZSBi
eXBhc3MgbW9kZSBmb3IgYWxsICJwcm9kdWN0aXZlIiBkZXZpY2VzLg0KPj4+DQo+Pj4gSWYg
d2UgaGF2ZSB0byBzdGFydCBhZGRpbmcgY2FwYWJpbHRpZXMsIHdvbid0IGl0IGJlIGVhc2ll
ciB0byBqdXN0IGFkZA0KPj4+IGl0IHRvIHRoZSBlYWNoIGRldmljZSBpbnN0ZWFkIG9mIGFk
ZGluZyBpdCB0byB2aXJ0aW8gSU9NTVUuICBPciBpcyB0aGUNCj4+PiBwYXJzaW5nIG9mIGNh
cGFiaWxpdGllcyBkZXZpY2Ugc3BlY2lmaWMsIGFuZCBoZW5jZSB3ZSB3b3VsZCBoYXZlIHRv
DQo+Pj4gaW1wbGVtZW50IHN1Y2ggcGFyc2luZyBmb3IgZWFjaCBkZXZpY2U/ICBJIHdvdWxk
IGV4cGVjdCBzb21lDQo+Pj4gY2FwYWJpbGl0aWVzIGFyZSBzaGFyZWQgYmV0d2VlbiBhbGwg
ZGV2aWNlcywgYW5kIGEgWGVuIGNhcGFiaWxpdHkgY291bGQNCj4+PiBiZSBvbmUgb2YgdGhv
c2UuDQo+Pg0KPj4gSGF2ZSBhIGxvb2sgYXQgWzFdLCB3aGljaCBpcyBkZXNjcmliaW5nIHRo
ZSBjb21tb24gZGV2aWNlIGNvbmZpZyBsYXlvdXQuDQo+PiBUaGUgcHJvYmxlbSBoZXJlIGlz
IHRoYXQgd2UnZCBuZWVkIHRvIGFkZCB0aGUgZG9taWQgYWZ0ZXIgdGhlIHF1ZXVlIHNwZWNp
ZmljDQo+PiBkYXRhLCByZXN1bHRpbmcgaW4gYSBtZXNzIGlmIGZ1cnRoZXIgcXVldWUgZmll
bGRzIHdvdWxkIGJlIGFkZGVkIGxhdGVyLg0KPj4NCj4+IFdlIGNvdWxkIHRyeSB0aGF0LCBv
ZiBjb3Vyc2UuDQo+IA0KPiBSaWdodCwgd2UgbXVzdCBtYWtlIGl0IHBhcnQgb2YgdGhlIHN0
YW5kYXJkIGlmIHdlIG1vZGlmeQ0KPiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIG9yIGVsc2Ug
bmV3bHkgYWRkZWQgZmllbGRzIHdvdWxkIG92ZXJsYXAgdGhlDQo+IFhlbiBzcGVjaWZpYyBv
bmUuDQo+IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBzaWduYWwgWGVuLWdyYW50cyBz
dXBwb3J0IGluIHRoZQ0KPiBgZGV2aWNlX2ZlYXR1cmVgIGZpZWxkLCBhbmQgdGhlbiBleHBv
c2UgaXQgZnJvbSBhIHZlbmRvciBjYXBhYmlsaXR5Pw0KPiBJT1csIHdvdWxkIGl0IGJlIHBv
c3NpYmxlIHRvIGFkZCBhIFhlbi1zcGVjaWZpYyBob29rIGluIHRoZSBwYXJzaW5nIG9mDQo+
IHZpcnRpb19wY2lfY29tbW9uX2NmZyB0aGF0IHdvdWxkIHRoZW4gZmV0Y2ggYWRkaXRpb25h
bCBkYXRhIGZyb20gYQ0KPiBjYXBhYmlsaXR5Pw0KDQpUQkgsIEkgZG9uJ3Qga25vdy4gSXQg
bWlnaHQgcmVxdWlyZSBzb21lIGNoYW5nZXMgaW4gdGhlIGNlbnRyYWwgcGFyc2luZw0KbG9n
aWMsIGJ1dCB0aGlzIHNob3VsZG4ndCBiZSB0b28gaGFyZCB0byBkby4NCg0KPiBUaGF0IHdv
dWxkIGxpa2VseSBiZSBsZXNzIGludHJ1c2l2ZSB0aGFuIGFkZGluZyBhIG5ldyBYZW4tc3Bl
Y2lmaWMNCj4gZmllbGQgdG8gdmlydGlvX3BjaV9jb21tb25fY2ZnIHdoaWxlIHN0aWxsIGFs
bG93aW5nIHVzIHRvIGRvIFhlbg0KPiBzcGVjaWZpYyBjb25maWd1cmF0aW9uIGZvciBhbGwg
VmlydElPIGRldmljZXMuDQoNCkluIGNhc2Ugd2Ugd2FudCB0byBnbyB0aGF0IHJvdXRlLCB0
aGlzIHNob3VsZCBiZSBpbiBhIG5ldyAicGxhdGZvcm0gY29uZmlnIg0KY2FwYWJpbGl0eSwg
d2hpY2ggbWlnaHQgYmUganVzdCBhbm90aGVyIGZvcm0gb2YgYSB2ZW5kb3IgY2FwYWJpbGl0
eS4NCg0KPiANCj4+Pg0KPj4+PiBMYXRlciB3ZSBjb3VsZCBldmVuIGFkZCBncmFudC1WMyBz
dXBwb3J0IHRvIFhlbiBhbmQgdG8gdGhlIHZpcnRpbyBJT01NVSBkZXZpY2UNCj4+Pj4gKHNl
ZSBteSBsYXN0IHllYXIgWGVuIFN1bW1pdCBkZXNpZ24gc2Vzc2lvbikuIFRoaXMgY291bGQg
YmUgdXNhYmxlIGZvcg0KPj4+PiBkaXNhZ2dyZWdhdGVkIEtWTSBzZXR1cHMsIHRvbywgc28g
SSBiZWxpZXZlIHRoZXJlIGlzIGEgY2hhbmNlIHRvIGdldCB0aGlzDQo+Pj4+IGFjY2VwdGVk
Lg0KPj4+Pg0KPj4+Pj4+Pj4+ICoqKioqKioqKioNCj4+Pj4+Pj4+PiBXaGF0IGRvIHlvdSB0
aGluayBhYm91dCBpdD8gQXJlIHRoZXJlIGFueSBwaXRmYWxscywgZXRjPyBUaGlzIGFsc28g
cmVxdWlyZXMNCj4+Pj4+Pj4+PiBzeXN0ZW0gY2hhbmdlcywgYnV0IGF0IGxlYXN0IHdpdGhv
dXQgdmlydGlvIHNwZWMgY2hhbmdlcy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBXaHkgYXJlIHdl
IHNvIHJlbHVjdGFudCB0byBhZGQgc3BlYyBjaGFuZ2VzPyAgSSB1bmRlcnN0YW5kIHRoaXMg
bWlnaHQNCj4+Pj4+Pj4+IHRha2UgdGltZSBhbiBlZmZvcnQsIGJ1dCBpdCdzIHRoZSBvbmx5
IHdheSBJTU8gdG8gYnVpbGQgYSBzdXN0YWluYWJsZQ0KPj4+Pj4+Pj4gVmlydElPIFhlbiBp
bXBsZW1lbnRhdGlvbi4gIERpZCB3ZSBhbHJlYWR5IGF0dGVtcHQgdG8gbmVnb3RpYXRlIHdp
dGgNCj4+Pj4+Pj4+IE9hc2lzIFhlbiByZWxhdGVkIHNwZWMgY2hhbmdlcyBhbmQgdGhvc2Ug
d2hlcmUgcmVmdXNlZD8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhhdCdzIGJlY2F1c2Ugc3BlYyBj
aGFuZ2VzIGNhbiBiZSB2ZXJ5IHNsb3cuIFRoaXMgaXMgYSBidWcgdGhhdCB3ZSBuZWVkDQo+
Pj4+Pj4+IGEgcmVsYXRpdmVseSBxdWljayBzb2x1dGlvbiBmb3IgYW5kIHdhaXRpbmcgMTIt
MjQgbW9udGhzIGZvciBhIHNwZWMNCj4+Pj4+Pj4gdXBkYXRlIGlzIG5vdCByZWFsaXN0aWMu
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkgdGhpbmsgYSBzcGVjIGNoYW5nZSB3b3VsZCBiZSBiZXN0
IGFzIGEgbG9uZyB0ZXJtIHNvbHV0aW9uLiBXZSBhbHNvDQo+Pj4+Pj4+IG5lZWQgYSBzaG9y
dCB0ZXJtIHNvbHV0aW9uLiBUaGUgc2hvcnQgdGVybSBzb2x1dGlvbiBkb2Vzbid0IGhhdmUg
dG8gYmUNCj4+Pj4+Pj4gaWRlYWwgYnV0IGl0IGhhcyB0byB3b3JrIG5vdy4NCj4+Pj4+Pg0K
Pj4+Pj4+IE15IGZlYXIgd2l0aCBzdWNoIGFwcHJvYWNoIGlzIHRoYXQgb25jZSBhIGJvZGdl
IGlzIGluIHBsYWNlIHBlb3BsZQ0KPj4+Pj4+IG1vdmUgb24gdG8gb3RoZXIgc3R1ZmYgYW5k
IHRoaXMgbmV2ZXIgZ2V0cyBwcm9wZXJseSBmaXhlZC4NCj4+Pj4+Pg0KPj4+Pj4+IEkga25v
dyB0aGlzIG1pZ2h0IG5vdCBiZSBhIHdlbGwgcmVjZWl2ZWQgb3BpbmlvbiwgYnV0IGl0IHdv
dWxkIGJlDQo+Pj4+Pj4gYmV0dGVyIGlmIHN1Y2ggYm9kZ2UgaXMga2VwdCBpbiBlYWNoIGlu
dGVyZXN0ZWQgcGFydHkgcGF0Y2hxdWV1ZSBmb3INCj4+Pj4+PiB0aGUgdGltZSBiZWluZywg
dW50aWwgYSBwcm9wZXIgc29sdXRpb24gaXMgaW1wbGVtZW50ZWQuICBUaGF0IHdheQ0KPj4+
Pj4+IHRoZXJlJ3MgYW4gaW50ZXJlc3QgZnJvbSBwYXJ0aWVzIGludG8gcHJvcGVybHkgZml4
aW5nIGl0IHVwc3RyZWFtLg0KPj4+Pj4NCj4+Pj4+IFVuZm9ydHVuYXRlbHkgd2UgYXJlIGlu
IHRoZSBzaXR1YXRpb24gd2hlcmUgd2UgaGF2ZSBhbiBvdXRzdGFuZGluZw0KPj4+Pj4gdXBz
dHJlYW0gYnVnLCBzbyB3ZSBoYXZlIHRvIHRha2UgYWN0aW9uIG9uZSB3YXkgb3IgdGhlIG90
aGVyLg0KPj4+Pg0KPj4+PiBUaGUgcmVxdWlyZWQgdmlydGlvIElPTU1VIGRldmljZSBtb2Rp
ZmljYXRpb24gd291bGQgYmUgcmF0aGVyIHNtYWxsLCBzbw0KPj4+PiBhZGRpbmcgaXQgbWF5
YmUgdW5kZXIgYSBDT05GSUcgb3B0aW9uIGRlZmF1bHRpbmcgdG8gb2ZmIG1pZ2h0IGJlDQo+
Pj4+IGFjY2VwdGFibGUuDQo+Pj4NCj4+PiBXb3VsZCB5b3UgdGhlbiBkbyB0aGUgZ3JhbnQg
YWxsb2NhdGlvbiBhcyBwYXJ0IG9mIHZpcnRpbyBJT01NVT8NCj4+DQo+PiBMb25nIHRlcm0s
IG1heWJlLiBEbyB5b3UgcmVtZW1iZXIgbXkgR3JhbnQtVjMgZGVzaWduIHNlc3Npb24gbGFz
dCB5ZWFyPyBCZWluZw0KPj4gYWJsZSB0byByZXVzZSB0aGUgc2FtZSBsYXlvdXQgZm9yIHZp
cnRpbyBJT01NVSB3YXMgb25lIG9mIHRoZSBiYXNpYyBpZGVhcyBmb3INCj4+IHRoYXQgbGF5
b3V0ICh0aGlzIHdvdWxkIG5lZWQgc29tZSBoZWF2eSB3b3JrIG9uIHRoZSB2aXJ0aW8gSU9N
TVUgZnJvbnRlbmQgYW5kDQo+PiBiYWNrZW5kLCBvZiBjb3Vyc2UpLg0KPiANCj4gV2hpbGUg
dGhpcyBtaWdodCB3ZWxsIGJlIHRoZSBiZXN0IG9wdGlvbiwgZG8gd2UgaGF2ZSBhbnlvbmUg
d2l0aCB0aGUNCj4gdGltZSBhbmQgZXhwZXJ0aXNlIHRvIHdvcmsgb24gdGhpcz8gIEkgbWln
aHQgYmUgd3JvbmcsIGJ1dCBpdCBzZWVtcw0KPiBsaWtlIGEgaHVnZSB0YXNrLg0KDQpBcyBh
IGJhY2tncm91bmQgcHJvamVjdCBJJ2QgbGlrZSB0byBwdXJzdWUgaXQuIE9UT0ggSSdtIG5v
dCBzdXJlIGhvdyBtdWNoIHRpbWUNCkkgY291bGQgc3BlbmQgb24gaXQuDQoNCg0KSnVlcmdl
bg0K
--------------Th0Hc0gn0HmlyNGGZo5YwJr6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Th0Hc0gn0HmlyNGGZo5YwJr6--

--------------8xnNKwnpjYsQU5Wv6RIpCTmH--

--------------nhuD3mfs5ESRhYQN0JOgqySB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSoKNIFAwAAAAAACgkQsN6d1ii/Ey/+
sgf/bIDj/f2TsUiA0LwTt5HHGfbfb4BwgYPX7umelulWnIU/2321JCzJWm/z7GpXPHYPBK0bZQ+I
fQxQZZizGXxBIElXxlh6GX3Tiu9Nl+sveQVtSRezpof6I3mrGTajc3ixX+P8RGhwUWR4TOtU7fwW
7+ukLuOZ6DVGr65yGFDpjPE8cxQgeUwwJ8Qum4i5sXb+3lKWZc9A9Sa8ypOQeRu0IRsQVhaHvfVu
nid8sZkzJzA2iHfTvwH9gLOM7a9yGCBr/fzTOl397Aw73eQgzM5xt1t/yjrFQEKBT559R4eW7ATz
uyl9pbUXmzuvVKcczOO/+yyWkQMCf8MBhJqR+a2VsA==
=ITor
-----END PGP SIGNATURE-----

--------------nhuD3mfs5ESRhYQN0JOgqySB--
