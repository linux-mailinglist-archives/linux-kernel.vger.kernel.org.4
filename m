Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6EA74B3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGGPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:15:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73102130
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:15:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C6C822366;
        Fri,  7 Jul 2023 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688742935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZncDOKZ9x+kpnlS7bBEnKGfdCqfhcrTh2UKs90bTUE=;
        b=ZODyVr89B9bQ/GIAu+X0tgi8UQMKOy6NVDlObFNpxH8eZ+6ytVYu98Eu31mrpvk8JcKptc
        poVQTlg0yo1LWYJHrO52KX2XozK3YCQWuL7LKlFWaD2qvxwAmXgtxrCDUD6ErGdz2UYmfY
        PGqrbhAwWzR4bG7qTBIIADJhjKahrXE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2FC7139E0;
        Fri,  7 Jul 2023 15:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XxK8NRYsqGSNDQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 15:15:34 +0000
Message-ID: <90a9ef87-b5e7-63fb-49c1-3606cefef8a4@suse.com>
Date:   Fri, 7 Jul 2023 17:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
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
References: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
 <106781fe-992b-8609-fe37-17619b699353@suse.com>
 <ZKgrwvSO9MgLqXTn@MacBook-Air-de-Roger.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ZKgrwvSO9MgLqXTn@MacBook-Air-de-Roger.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gBQZQQLufC3OxQcZ7IVdlfQH"
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
--------------gBQZQQLufC3OxQcZ7IVdlfQH
Content-Type: multipart/mixed; boundary="------------90Ooqz7cF1y4zzZJzl5mQrRx";
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
Message-ID: <90a9ef87-b5e7-63fb-49c1-3606cefef8a4@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <ZKgkYKG11AWIUXuv@MacBook-Air-de-Roger.local>
 <106781fe-992b-8609-fe37-17619b699353@suse.com>
 <ZKgrwvSO9MgLqXTn@MacBook-Air-de-Roger.local>
In-Reply-To: <ZKgrwvSO9MgLqXTn@MacBook-Air-de-Roger.local>

--------------90Ooqz7cF1y4zzZJzl5mQrRx
Content-Type: multipart/mixed; boundary="------------ahTK0ozz3fzdSsZPePPRJ5hg"

--------------ahTK0ozz3fzdSsZPePPRJ5hg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTc6MTQsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIEZyaSwg
SnVsIDA3LCAyMDIzIGF0IDA1OjAxOjM4UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+PiBPbiAwNy4wNy4yMyAxNjo0MiwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+PiBP
biBGcmksIEp1bCAwNywgMjAyMyBhdCAwNDoxMDoxNFBNICswMjAwLCBKdWVyZ2VuIEdyb3Nz
IHdyb3RlOg0KPj4+PiBPbiAwNy4wNy4yMyAxMTo1MCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90
ZToNCj4+Pj4+IE9uIEZyaSwgSnVsIDA3LCAyMDIzIGF0IDA2OjM4OjQ4QU0gKzAyMDAsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gT24gMDYuMDcuMjMgMjM6NDksIFN0ZWZhbm8g
U3RhYmVsbGluaSB3cm90ZToNCj4+Pj4+Pj4gT24gVGh1LCA2IEp1bCAyMDIzLCBSb2dlciBQ
YXUgTW9ubsOpIHdyb3RlOg0KPj4+Pj4+Pj4gT24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDM6
NDE6MTBQTSAtMDcwMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4+Pj4+Pj4+IE9u
IFdlZCwgNSBKdWwgMjAyMywgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+Pj4+Pj4+Pj4g
T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDg6MTQ6NTlQTSArMDMwMCwgT2xla3NhbmRyIFR5
c2hjaGVua28gd3JvdGU6DQo+Pj4+Pj4+Pj4+PiBQYXJ0IDIgKGNsYXJpZmljYXRpb24pOg0K
Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IEkgdGhpbmsgdXNpbmcgYSBzcGVjaWFsIGNvbmZp
ZyBzcGFjZSByZWdpc3RlciBpbiB0aGUgcm9vdCBjb21wbGV4IHdvdWxkDQo+Pj4+Pj4+Pj4+
PiBub3QgYmUgdGVycmlibGUgaW4gdGVybXMgb2YgZ3Vlc3QgY2hhbmdlcyBiZWNhdXNlIGl0
IGlzIGVhc3kgdG8NCj4+Pj4+Pj4+Pj4+IGludHJvZHVjZSBhIG5ldyByb290IGNvbXBsZXgg
ZHJpdmVyIGluIExpbnV4IGFuZCBvdGhlciBPU2VzLiBUaGUgcm9vdA0KPj4+Pj4+Pj4+Pj4g
Y29tcGxleCB3b3VsZCBzdGlsbCBiZSBFQ0FNIGNvbXBhdGlibGUgc28gdGhlIHJlZ3VsYXIg
RUNBTSBkcml2ZXIgd291bGQNCj4+Pj4+Pj4+Pj4+IHN0aWxsIHdvcmsuIEEgbmV3IGRyaXZl
ciB3b3VsZCBvbmx5IGJlIG5lY2Vzc2FyeSBpZiB5b3Ugd2FudCB0byBiZSBhYmxlDQo+Pj4+
Pj4+Pj4+PiB0byBhY2Nlc3MgdGhlIHNwZWNpYWwgY29uZmlnIHNwYWNlIHJlZ2lzdGVyLg0K
Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBJJ20gc2xpZ2h0bHkgd29ycnkgb2YgdGhpcyBhcHBy
b2FjaCwgd2UgZW5kIHVwIG1vZGlmeWluZyBhIHJvb3QNCj4+Pj4+Pj4+Pj4gY29tcGxleCBl
bXVsYXRpb24gaW4gb3JkZXIgdG8gYXZvaWQgbW9kaWZ5aW5nIGEgUENJIGRldmljZSBlbXVs
YXRpb24NCj4+Pj4+Pj4+Pj4gb24gUUVNVSwgbm90IHN1cmUgdGhhdCdzIGEgZ29vZCB0cmFk
ZSBvZmYuDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IE5vdGUgYWxzbyB0aGF0IGRpZmZlcmVu
dCBhcmNoaXRlY3R1cmVzIHdpbGwgbGlrZWx5IGhhdmUgZGlmZmVyZW50IHJvb3QNCj4+Pj4+
Pj4+Pj4gY29tcGxleCwgYW5kIHNvIHlvdSBtaWdodCBuZWVkIHRvIG1vZGlmeSBzZXZlcmFs
IG9mIHRoZW0sIHBsdXMgdGhlbg0KPj4+Pj4+Pj4+PiBhcnJhbmdlIHRoZSBQQ0kgbGF5b3V0
IGNvcnJlY3RseSBpbiBvcmRlciB0byBoYXZlIHRoZSBwcm9wZXIgaGllcmFyY2h5DQo+Pj4+
Pj4+Pj4+IHNvIHRoYXQgZGV2aWNlcyBiZWxvbmdpbmcgdG8gZGlmZmVyZW50IGRyaXZlciBk
b21haW5zIGFyZSBhc3NpZ25lZCB0bw0KPj4+Pj4+Pj4+PiBkaWZmZXJlbnQgYnJpZGdlcy4N
Cj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEkgZG8gdGhpbmsgdGhhdCBhZGRpbmcgc29tZXRoaW5n
IHRvIHRoZSBQQ0kgY29uZiByZWdpc3RlciBzb21ld2hlcmUgaXMNCj4+Pj4+Pj4+PiB0aGUg
YmVzdCBvcHRpb24gYmVjYXVzZSBpdCBpcyBub3QgZGVwZW5kZW50IG9uIEFDUEkgYW5kIGl0
IGlzIG5vdA0KPj4+Pj4+Pj4+IGRlcGVuZGVudCBvbiB4ZW5zdG9yZSBib3RoIG9mIHdoaWNo
IGFyZSB2ZXJ5IHVuZGVzaXJhYmxlLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSSBhbSBub3Qg
c3VyZSB3aGVyZSBzcGVjaWZpY2FsbHkgaXMgdGhlIGJlc3QgcGxhY2UuIFRoZXNlIGFyZSAz
IGlkZWFzDQo+Pj4+Pj4+Pj4gd2UgY2FtZSB1cCB3aXRoOg0KPj4+Pj4+Pj4+IDEuIFBDSSBy
b290IGNvbXBsZXgNCj4+Pj4+Pj4+PiAyLiBhIHJlZ2lzdGVyIG9uIHRoZSBkZXZpY2UgaXRz
ZWxmDQo+Pj4+Pj4+Pj4gMy4gYSBuZXcgY2FwYWJpbGl0eSBvZiB0aGUgZGV2aWNlDQo+Pj4+
Pj4+Pj4gNC4gYWRkIG9uZSBleHRyYSBkdW1teSBQQ0kgZGV2aWNlIGZvciB0aGUgc29sZSBw
dXJwb3NlIG9mIGV4cG9zaW5nIHRoZQ0KPj4+Pj4+Pj4+ICAgICAgICBncmFudHMgY2FwYWJp
bGl0eQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBMb29raW5nIGF0IHRoZSBz
cGVjLCB0aGVyZSBpcyBhIHdheSB0byBhZGQgYSB2ZW5kb3Itc3BlY2lmaWMgY2FwYWJpbGl0
eQ0KPj4+Pj4+Pj4+IChjYXBfdm5kciA9IDB4OSkuIENvdWxkIHdlIHVzZSB0aGF0PyBJdCBk
b2Vzbid0IGxvb2sgbGlrZSBpdCBpcyB1c2VkDQo+Pj4+Pj4+Pj4gdG9kYXksIExpbnV4IGRv
ZXNuJ3QgcGFyc2UgaXQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSSBkaWQgd29uZGVyIHRoZSBz
YW1lIGZyb20gYSBxdWljayBsb29rIGF0IHRoZSBzcGVjLiAgVGhlcmUncyBob3dldmVyDQo+
Pj4+Pj4+PiBhIHRleHQgaW4gdGhlIHNwZWNpZmljYXRpb24gdGhhdCBzYXlzOg0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4+ICJUaGUgZHJpdmVyIFNIT1VMRCBOT1QgdXNlIHRoZSBWZW5kb3IgZGF0
YSBjYXBhYmlsaXR5IGV4Y2VwdCBmb3INCj4+Pj4+Pj4+IGRlYnVnZ2luZyBhbmQgcmVwb3J0
aW5nIHB1cnBvc2VzLiINCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTbyB3ZSB3b3VsZCBhdCBsZWFz
dCBuZWVkIHRvIGNoYW5nZSB0aGF0IGJlY2F1c2UgdGhlIGNhcGFiaWxpdHkgd291bGQNCj4+
Pj4+Pj4+IHRoZW4gYmUgdXNlZCBieSBvdGhlciBwdXJwb3NlcyBkaWZmZXJlbnQgdGhhbiBk
ZWJ1Z2dpbmcgYW5kIHJlcG9ydGluZy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTZWVtcyBsaWtl
IGEgbWlub3IgYWRqdXN0bWVudCwgc28gbWlnaHQgd2Ugd29ydGggYXNraW5nIHVwc3RyZWFt
IGFib3V0DQo+Pj4+Pj4+PiB0aGVpciBvcGluaW9uLCBhbmQgdG8gZ2V0IGEgY29udmVyc2F0
aW9uIHN0YXJ0ZWQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFdhaXQsIHdvdWxkbid0IHRoaXMgdXNl
LWNhc2UgZmFsbCB1bmRlciAicmVwb3J0aW5nIiA/IEl0IGlzIGV4YWN0bHkgd2hhdA0KPj4+
Pj4+PiB3ZSBhcmUgZG9pbmcsIHJpZ2h0Pw0KPj4+Pj4+DQo+Pj4+Pj4gSSdkIHVuZGVyc3Rh
bmQgInJlcG9ydGluZyIgYXMgZS5nLiBsb2dnaW5nLCB0cmFuc2ZlcnJpbmcgc3RhdGlzdGlj
cywgLi4uDQo+Pj4+Pj4NCj4+Pj4+PiBXZSdkIGxpa2UgdG8gdXNlIGl0IGZvciBjb25maWd1
cmF0aW9uIHB1cnBvc2VzLg0KPj4+Pj4NCj4+Pj4+IEkndmUgYWxzbyByZWFkIGl0IHRoYXQg
d2F5Lg0KPj4+Pj4NCj4+Pj4+PiBBbm90aGVyIGlkZWEgd291bGQgYmUgdG8gZW5oYW5jZSB0
aGUgdmlydGlvIElPTU1VIGRldmljZSB0byBzdWl0IG91ciBuZWVkczoNCj4+Pj4+PiB3ZSBj
b3VsZCBhZGQgdGhlIGRvbWlkIGFzIGFub3RoZXIgdmlydGlvIElPTU1VIGRldmljZSBjYXBh
YmlsaXR5IGFuZCAoZm9yIG5vdykNCj4+Pj4+PiB1c2UgYnlwYXNzIG1vZGUgZm9yIGFsbCAi
cHJvZHVjdGl2ZSIgZGV2aWNlcy4NCj4+Pj4+DQo+Pj4+PiBJZiB3ZSBoYXZlIHRvIHN0YXJ0
IGFkZGluZyBjYXBhYmlsdGllcywgd29uJ3QgaXQgYmUgZWFzaWVyIHRvIGp1c3QgYWRkDQo+
Pj4+PiBpdCB0byB0aGUgZWFjaCBkZXZpY2UgaW5zdGVhZCBvZiBhZGRpbmcgaXQgdG8gdmly
dGlvIElPTU1VLiAgT3IgaXMgdGhlDQo+Pj4+PiBwYXJzaW5nIG9mIGNhcGFiaWxpdGllcyBk
ZXZpY2Ugc3BlY2lmaWMsIGFuZCBoZW5jZSB3ZSB3b3VsZCBoYXZlIHRvDQo+Pj4+PiBpbXBs
ZW1lbnQgc3VjaCBwYXJzaW5nIGZvciBlYWNoIGRldmljZT8gIEkgd291bGQgZXhwZWN0IHNv
bWUNCj4+Pj4+IGNhcGFiaWxpdGllcyBhcmUgc2hhcmVkIGJldHdlZW4gYWxsIGRldmljZXMs
IGFuZCBhIFhlbiBjYXBhYmlsaXR5IGNvdWxkDQo+Pj4+PiBiZSBvbmUgb2YgdGhvc2UuDQo+
Pj4+DQo+Pj4+IEhhdmUgYSBsb29rIGF0IFsxXSwgd2hpY2ggaXMgZGVzY3JpYmluZyB0aGUg
Y29tbW9uIGRldmljZSBjb25maWcgbGF5b3V0Lg0KPj4+PiBUaGUgcHJvYmxlbSBoZXJlIGlz
IHRoYXQgd2UnZCBuZWVkIHRvIGFkZCB0aGUgZG9taWQgYWZ0ZXIgdGhlIHF1ZXVlIHNwZWNp
ZmljDQo+Pj4+IGRhdGEsIHJlc3VsdGluZyBpbiBhIG1lc3MgaWYgZnVydGhlciBxdWV1ZSBm
aWVsZHMgd291bGQgYmUgYWRkZWQgbGF0ZXIuDQo+Pj4+DQo+Pj4+IFdlIGNvdWxkIHRyeSB0
aGF0LCBvZiBjb3Vyc2UuDQo+Pj4NCj4+PiBSaWdodCwgd2UgbXVzdCBtYWtlIGl0IHBhcnQg
b2YgdGhlIHN0YW5kYXJkIGlmIHdlIG1vZGlmeQ0KPj4+IHZpcnRpb19wY2lfY29tbW9uX2Nm
Zywgb3IgZWxzZSBuZXdseSBhZGRlZCBmaWVsZHMgd291bGQgb3ZlcmxhcCB0aGUNCj4+PiBY
ZW4gc3BlY2lmaWMgb25lLg0KPj4+DQo+Pj4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gc2ln
bmFsIFhlbi1ncmFudHMgc3VwcG9ydCBpbiB0aGUNCj4+PiBgZGV2aWNlX2ZlYXR1cmVgIGZp
ZWxkLCBhbmQgdGhlbiBleHBvc2UgaXQgZnJvbSBhIHZlbmRvciBjYXBhYmlsaXR5Pw0KPj4+
IElPVywgd291bGQgaXQgYmUgcG9zc2libGUgdG8gYWRkIGEgWGVuLXNwZWNpZmljIGhvb2sg
aW4gdGhlIHBhcnNpbmcgb2YNCj4+PiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgdGhhdCB3b3Vs
ZCB0aGVuIGZldGNoIGFkZGl0aW9uYWwgZGF0YSBmcm9tIGENCj4+PiBjYXBhYmlsaXR5Pw0K
Pj4NCj4+IFRCSCwgSSBkb24ndCBrbm93LiBJdCBtaWdodCByZXF1aXJlIHNvbWUgY2hhbmdl
cyBpbiB0aGUgY2VudHJhbCBwYXJzaW5nDQo+PiBsb2dpYywgYnV0IHRoaXMgc2hvdWxkbid0
IGJlIHRvbyBoYXJkIHRvIGRvLg0KPj4NCj4+PiBUaGF0IHdvdWxkIGxpa2VseSBiZSBsZXNz
IGludHJ1c2l2ZSB0aGFuIGFkZGluZyBhIG5ldyBYZW4tc3BlY2lmaWMNCj4+PiBmaWVsZCB0
byB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgd2hpbGUgc3RpbGwgYWxsb3dpbmcgdXMgdG8gZG8g
WGVuDQo+Pj4gc3BlY2lmaWMgY29uZmlndXJhdGlvbiBmb3IgYWxsIFZpcnRJTyBkZXZpY2Vz
Lg0KPj4NCj4+IEluIGNhc2Ugd2Ugd2FudCB0byBnbyB0aGF0IHJvdXRlLCB0aGlzIHNob3Vs
ZCBiZSBpbiBhIG5ldyAicGxhdGZvcm0gY29uZmlnIg0KPj4gY2FwYWJpbGl0eSwgd2hpY2gg
bWlnaHQgYmUganVzdCBhbm90aGVyIGZvcm0gb2YgYSB2ZW5kb3IgY2FwYWJpbGl0eS4NCj4g
DQo+IEkgdGhpbmsgdGVsbGluZyBwZW9wbGUgdGhhdCB0aGV5IHdpbGwgbmVlZCB0byBpbXBs
ZW1lbnQgZ3JhbnRzLXYzIGluDQo+IG9yZGVyIHRvIHNvbHZlIHRoaXMgbWlnaHQgYmUgdG9v
IG11Y2guICBJIHdvdWxkIHJhdGhlciBwcmVmZXIgYSBtb3JlDQo+IGNvbmNyZXRlIHNvbHV0
aW9uIHRoYXQgZG9lc24ndCBoYXZlIHNvIG1hbnkgbG9vc2UgZW5kcy4NCj4gDQo+IEFueXdh
eSwgaXQncyB1cCB0byB0aGUgcGVyc29uIGRvaW5nIHRoZSBqb2IsIGJ1dCBzdGFydGluZyB3
aXRoICJ5b3UNCj4gd2lsbCBoYXZlIHRvIGltcGxlbWVudCBncmFudHMtdjMiIGlzIHF1aXRl
IGxpa2VseSB0byBkZXRlciBhbnlvbmUgZnJvbQ0KPiBhdHRlbXB0aW5nIHRvIHNvbHZlIHRo
aXMgSSdtIGFmcmFpZC4NCg0KRmFpciBlbm91Z2guIDotKQ0KDQoNCkp1ZXJnZW4NCg0K
--------------ahTK0ozz3fzdSsZPePPRJ5hg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ahTK0ozz3fzdSsZPePPRJ5hg--

--------------90Ooqz7cF1y4zzZJzl5mQrRx--

--------------gBQZQQLufC3OxQcZ7IVdlfQH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSoLBYFAwAAAAAACgkQsN6d1ii/Ey8m
CQf/Z/StDpMFgi/fp17fOXWy3N1Nw+0JUd0bXFmwdSy3rGPwfnmTPIxiIJyDxsOrfwejFFcqkrx4
YHf9THAOrfG+fUMlUYgFuEgLTPwwMWW9dEYpaDdadHS0c/CZDVozQoAMn80qJqfepz0QYKc7StmN
U0tEr4ZeZkhwOwnv63zGCKWdPS9T6sE1WCQk7QmaTFEYvCamy+HvPDb5UdTxVE0lnr8IewhrPFDD
iEgWVKHTp3HFjgQZPHOumQFwMNjqSCpdu4HQC8h4NX20HQxWQ9om0v0JkoYMWsQ5Dc1vrPk/9YWN
rrZr9s5cQz05zzyTAHBTtow3yEM1PrHOPHG0SMP1Cw==
=8fHh
-----END PGP SIGNATURE-----

--------------gBQZQQLufC3OxQcZ7IVdlfQH--
