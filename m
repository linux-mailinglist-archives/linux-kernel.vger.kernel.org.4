Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF074B2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGGOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGGOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:10:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542FE3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:10:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B01CD2275C;
        Fri,  7 Jul 2023 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688739015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iHOxAAF00A30k/+j6nHhWMpnOAG7uUYP/V8Vk7LQupw=;
        b=oabo90RBI7k5CoA4kvwPKUm7FmAFf16m85vdVif2oCddAaZ4shY0dAEoUUU1ZUTBPckQzi
        HHckCnco570z7qciDuAp9D5UL+op/RwvSDhIj7NK3Rzba9Shrz2hIChhw2buxM0034UiGB
        vZwnYKi8i+zQ6KlsPi0oDwLuKDD3zZE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61AC01346D;
        Fri,  7 Jul 2023 14:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LmRFFsccqGQMbQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 14:10:15 +0000
Message-ID: <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
Date:   Fri, 7 Jul 2023 16:10:14 +0200
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0YWzv9r376Qj34YgvQLmAgcL"
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
--------------0YWzv9r376Qj34YgvQLmAgcL
Content-Type: multipart/mixed; boundary="------------Z0NhCYu4dYSsTtrATMQiKS1o";
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
Message-ID: <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
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
In-Reply-To: <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>

--------------Z0NhCYu4dYSsTtrATMQiKS1o
Content-Type: multipart/mixed; boundary="------------MXYfnUjLHQcYPbl2eTMn8Q9N"

--------------MXYfnUjLHQcYPbl2eTMn8Q9N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTE6NTAsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIEZyaSwg
SnVsIDA3LCAyMDIzIGF0IDA2OjM4OjQ4QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6
DQo+PiBPbiAwNi4wNy4yMyAyMzo0OSwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4+
IE9uIFRodSwgNiBKdWwgMjAyMywgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+Pj4gT24g
V2VkLCBKdWwgMDUsIDIwMjMgYXQgMDM6NDE6MTBQTSAtMDcwMCwgU3RlZmFubyBTdGFiZWxs
aW5pIHdyb3RlOg0KPj4+Pj4gT24gV2VkLCA1IEp1bCAyMDIzLCBSb2dlciBQYXUgTW9ubsOp
IHdyb3RlOg0KPj4+Pj4+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDA4OjE0OjU5UE0gKzAz
MDAsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPj4+Pj4+PiBQYXJ0IDIgKGNsYXJp
ZmljYXRpb24pOg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIHRoaW5rIHVzaW5nIGEgc3BlY2lhbCBj
b25maWcgc3BhY2UgcmVnaXN0ZXIgaW4gdGhlIHJvb3QgY29tcGxleCB3b3VsZA0KPj4+Pj4+
PiBub3QgYmUgdGVycmlibGUgaW4gdGVybXMgb2YgZ3Vlc3QgY2hhbmdlcyBiZWNhdXNlIGl0
IGlzIGVhc3kgdG8NCj4+Pj4+Pj4gaW50cm9kdWNlIGEgbmV3IHJvb3QgY29tcGxleCBkcml2
ZXIgaW4gTGludXggYW5kIG90aGVyIE9TZXMuIFRoZSByb290DQo+Pj4+Pj4+IGNvbXBsZXgg
d291bGQgc3RpbGwgYmUgRUNBTSBjb21wYXRpYmxlIHNvIHRoZSByZWd1bGFyIEVDQU0gZHJp
dmVyIHdvdWxkDQo+Pj4+Pj4+IHN0aWxsIHdvcmsuIEEgbmV3IGRyaXZlciB3b3VsZCBvbmx5
IGJlIG5lY2Vzc2FyeSBpZiB5b3Ugd2FudCB0byBiZSBhYmxlDQo+Pj4+Pj4+IHRvIGFjY2Vz
cyB0aGUgc3BlY2lhbCBjb25maWcgc3BhY2UgcmVnaXN0ZXIuDQo+Pj4+Pj4NCj4+Pj4+PiBJ
J20gc2xpZ2h0bHkgd29ycnkgb2YgdGhpcyBhcHByb2FjaCwgd2UgZW5kIHVwIG1vZGlmeWlu
ZyBhIHJvb3QNCj4+Pj4+PiBjb21wbGV4IGVtdWxhdGlvbiBpbiBvcmRlciB0byBhdm9pZCBt
b2RpZnlpbmcgYSBQQ0kgZGV2aWNlIGVtdWxhdGlvbg0KPj4+Pj4+IG9uIFFFTVUsIG5vdCBz
dXJlIHRoYXQncyBhIGdvb2QgdHJhZGUgb2ZmLg0KPj4+Pj4+DQo+Pj4+Pj4gTm90ZSBhbHNv
IHRoYXQgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMgd2lsbCBsaWtlbHkgaGF2ZSBkaWZmZXJl
bnQgcm9vdA0KPj4+Pj4+IGNvbXBsZXgsIGFuZCBzbyB5b3UgbWlnaHQgbmVlZCB0byBtb2Rp
Znkgc2V2ZXJhbCBvZiB0aGVtLCBwbHVzIHRoZW4NCj4+Pj4+PiBhcnJhbmdlIHRoZSBQQ0kg
bGF5b3V0IGNvcnJlY3RseSBpbiBvcmRlciB0byBoYXZlIHRoZSBwcm9wZXIgaGllcmFyY2h5
DQo+Pj4+Pj4gc28gdGhhdCBkZXZpY2VzIGJlbG9uZ2luZyB0byBkaWZmZXJlbnQgZHJpdmVy
IGRvbWFpbnMgYXJlIGFzc2lnbmVkIHRvDQo+Pj4+Pj4gZGlmZmVyZW50IGJyaWRnZXMuDQo+
Pj4+Pg0KPj4+Pj4gSSBkbyB0aGluayB0aGF0IGFkZGluZyBzb21ldGhpbmcgdG8gdGhlIFBD
SSBjb25mIHJlZ2lzdGVyIHNvbWV3aGVyZSBpcw0KPj4+Pj4gdGhlIGJlc3Qgb3B0aW9uIGJl
Y2F1c2UgaXQgaXMgbm90IGRlcGVuZGVudCBvbiBBQ1BJIGFuZCBpdCBpcyBub3QNCj4+Pj4+
IGRlcGVuZGVudCBvbiB4ZW5zdG9yZSBib3RoIG9mIHdoaWNoIGFyZSB2ZXJ5IHVuZGVzaXJh
YmxlLg0KPj4+Pj4NCj4+Pj4+IEkgYW0gbm90IHN1cmUgd2hlcmUgc3BlY2lmaWNhbGx5IGlz
IHRoZSBiZXN0IHBsYWNlLiBUaGVzZSBhcmUgMyBpZGVhcw0KPj4+Pj4gd2UgY2FtZSB1cCB3
aXRoOg0KPj4+Pj4gMS4gUENJIHJvb3QgY29tcGxleA0KPj4+Pj4gMi4gYSByZWdpc3RlciBv
biB0aGUgZGV2aWNlIGl0c2VsZg0KPj4+Pj4gMy4gYSBuZXcgY2FwYWJpbGl0eSBvZiB0aGUg
ZGV2aWNlDQo+Pj4+PiA0LiBhZGQgb25lIGV4dHJhIGR1bW15IFBDSSBkZXZpY2UgZm9yIHRo
ZSBzb2xlIHB1cnBvc2Ugb2YgZXhwb3NpbmcgdGhlDQo+Pj4+PiAgICAgIGdyYW50cyBjYXBh
YmlsaXR5DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IExvb2tpbmcgYXQgdGhlIHNwZWMsIHRoZXJl
IGlzIGEgd2F5IHRvIGFkZCBhIHZlbmRvci1zcGVjaWZpYyBjYXBhYmlsaXR5DQo+Pj4+PiAo
Y2FwX3ZuZHIgPSAweDkpLiBDb3VsZCB3ZSB1c2UgdGhhdD8gSXQgZG9lc24ndCBsb29rIGxp
a2UgaXQgaXMgdXNlZA0KPj4+Pj4gdG9kYXksIExpbnV4IGRvZXNuJ3QgcGFyc2UgaXQuDQo+
Pj4+DQo+Pj4+IEkgZGlkIHdvbmRlciB0aGUgc2FtZSBmcm9tIGEgcXVpY2sgbG9vayBhdCB0
aGUgc3BlYy4gIFRoZXJlJ3MgaG93ZXZlcg0KPj4+PiBhIHRleHQgaW4gdGhlIHNwZWNpZmlj
YXRpb24gdGhhdCBzYXlzOg0KPj4+Pg0KPj4+PiAiVGhlIGRyaXZlciBTSE9VTEQgTk9UIHVz
ZSB0aGUgVmVuZG9yIGRhdGEgY2FwYWJpbGl0eSBleGNlcHQgZm9yDQo+Pj4+IGRlYnVnZ2lu
ZyBhbmQgcmVwb3J0aW5nIHB1cnBvc2VzLiINCj4+Pj4NCj4+Pj4gU28gd2Ugd291bGQgYXQg
bGVhc3QgbmVlZCB0byBjaGFuZ2UgdGhhdCBiZWNhdXNlIHRoZSBjYXBhYmlsaXR5IHdvdWxk
DQo+Pj4+IHRoZW4gYmUgdXNlZCBieSBvdGhlciBwdXJwb3NlcyBkaWZmZXJlbnQgdGhhbiBk
ZWJ1Z2dpbmcgYW5kIHJlcG9ydGluZy4NCj4+Pj4NCj4+Pj4gU2VlbXMgbGlrZSBhIG1pbm9y
IGFkanVzdG1lbnQsIHNvIG1pZ2h0IHdlIHdvcnRoIGFza2luZyB1cHN0cmVhbSBhYm91dA0K
Pj4+PiB0aGVpciBvcGluaW9uLCBhbmQgdG8gZ2V0IGEgY29udmVyc2F0aW9uIHN0YXJ0ZWQu
DQo+Pj4NCj4+PiBXYWl0LCB3b3VsZG4ndCB0aGlzIHVzZS1jYXNlIGZhbGwgdW5kZXIgInJl
cG9ydGluZyIgPyBJdCBpcyBleGFjdGx5IHdoYXQNCj4+PiB3ZSBhcmUgZG9pbmcsIHJpZ2h0
Pw0KPj4NCj4+IEknZCB1bmRlcnN0YW5kICJyZXBvcnRpbmciIGFzIGUuZy4gbG9nZ2luZywg
dHJhbnNmZXJyaW5nIHN0YXRpc3RpY3MsIC4uLg0KPj4NCj4+IFdlJ2QgbGlrZSB0byB1c2Ug
aXQgZm9yIGNvbmZpZ3VyYXRpb24gcHVycG9zZXMuDQo+IA0KPiBJJ3ZlIGFsc28gcmVhZCBp
dCB0aGF0IHdheS4NCj4gDQo+PiBBbm90aGVyIGlkZWEgd291bGQgYmUgdG8gZW5oYW5jZSB0
aGUgdmlydGlvIElPTU1VIGRldmljZSB0byBzdWl0IG91ciBuZWVkczoNCj4+IHdlIGNvdWxk
IGFkZCB0aGUgZG9taWQgYXMgYW5vdGhlciB2aXJ0aW8gSU9NTVUgZGV2aWNlIGNhcGFiaWxp
dHkgYW5kIChmb3Igbm93KQ0KPj4gdXNlIGJ5cGFzcyBtb2RlIGZvciBhbGwgInByb2R1Y3Rp
dmUiIGRldmljZXMuDQo+IA0KPiBJZiB3ZSBoYXZlIHRvIHN0YXJ0IGFkZGluZyBjYXBhYmls
dGllcywgd29uJ3QgaXQgYmUgZWFzaWVyIHRvIGp1c3QgYWRkDQo+IGl0IHRvIHRoZSBlYWNo
IGRldmljZSBpbnN0ZWFkIG9mIGFkZGluZyBpdCB0byB2aXJ0aW8gSU9NTVUuICBPciBpcyB0
aGUNCj4gcGFyc2luZyBvZiBjYXBhYmlsaXRpZXMgZGV2aWNlIHNwZWNpZmljLCBhbmQgaGVu
Y2Ugd2Ugd291bGQgaGF2ZSB0bw0KPiBpbXBsZW1lbnQgc3VjaCBwYXJzaW5nIGZvciBlYWNo
IGRldmljZT8gIEkgd291bGQgZXhwZWN0IHNvbWUNCj4gY2FwYWJpbGl0aWVzIGFyZSBzaGFy
ZWQgYmV0d2VlbiBhbGwgZGV2aWNlcywgYW5kIGEgWGVuIGNhcGFiaWxpdHkgY291bGQNCj4g
YmUgb25lIG9mIHRob3NlLg0KDQpIYXZlIGEgbG9vayBhdCBbMV0sIHdoaWNoIGlzIGRlc2Ny
aWJpbmcgdGhlIGNvbW1vbiBkZXZpY2UgY29uZmlnIGxheW91dC4NClRoZSBwcm9ibGVtIGhl
cmUgaXMgdGhhdCB3ZSdkIG5lZWQgdG8gYWRkIHRoZSBkb21pZCBhZnRlciB0aGUgcXVldWUg
c3BlY2lmaWMNCmRhdGEsIHJlc3VsdGluZyBpbiBhIG1lc3MgaWYgZnVydGhlciBxdWV1ZSBm
aWVsZHMgd291bGQgYmUgYWRkZWQgbGF0ZXIuDQoNCldlIGNvdWxkIHRyeSB0aGF0LCBvZiBj
b3Vyc2UuDQoNCj4gDQo+PiBMYXRlciB3ZSBjb3VsZCBldmVuIGFkZCBncmFudC1WMyBzdXBw
b3J0IHRvIFhlbiBhbmQgdG8gdGhlIHZpcnRpbyBJT01NVSBkZXZpY2UNCj4+IChzZWUgbXkg
bGFzdCB5ZWFyIFhlbiBTdW1taXQgZGVzaWduIHNlc3Npb24pLiBUaGlzIGNvdWxkIGJlIHVz
YWJsZSBmb3INCj4+IGRpc2FnZ3JlZ2F0ZWQgS1ZNIHNldHVwcywgdG9vLCBzbyBJIGJlbGll
dmUgdGhlcmUgaXMgYSBjaGFuY2UgdG8gZ2V0IHRoaXMNCj4+IGFjY2VwdGVkLg0KPj4NCj4+
Pj4+Pj4gKioqKioqKioqKg0KPj4+Pj4+PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBpdD8g
QXJlIHRoZXJlIGFueSBwaXRmYWxscywgZXRjPyBUaGlzIGFsc28gcmVxdWlyZXMNCj4+Pj4+
Pj4gc3lzdGVtIGNoYW5nZXMsIGJ1dCBhdCBsZWFzdCB3aXRob3V0IHZpcnRpbyBzcGVjIGNo
YW5nZXMuDQo+Pj4+Pj4NCj4+Pj4+PiBXaHkgYXJlIHdlIHNvIHJlbHVjdGFudCB0byBhZGQg
c3BlYyBjaGFuZ2VzPyAgSSB1bmRlcnN0YW5kIHRoaXMgbWlnaHQNCj4+Pj4+PiB0YWtlIHRp
bWUgYW4gZWZmb3J0LCBidXQgaXQncyB0aGUgb25seSB3YXkgSU1PIHRvIGJ1aWxkIGEgc3Vz
dGFpbmFibGUNCj4+Pj4+PiBWaXJ0SU8gWGVuIGltcGxlbWVudGF0aW9uLiAgRGlkIHdlIGFs
cmVhZHkgYXR0ZW1wdCB0byBuZWdvdGlhdGUgd2l0aA0KPj4+Pj4+IE9hc2lzIFhlbiByZWxh
dGVkIHNwZWMgY2hhbmdlcyBhbmQgdGhvc2Ugd2hlcmUgcmVmdXNlZD8NCj4+Pj4+DQo+Pj4+
PiBUaGF0J3MgYmVjYXVzZSBzcGVjIGNoYW5nZXMgY2FuIGJlIHZlcnkgc2xvdy4gVGhpcyBp
cyBhIGJ1ZyB0aGF0IHdlIG5lZWQNCj4+Pj4+IGEgcmVsYXRpdmVseSBxdWljayBzb2x1dGlv
biBmb3IgYW5kIHdhaXRpbmcgMTItMjQgbW9udGhzIGZvciBhIHNwZWMNCj4+Pj4+IHVwZGF0
ZSBpcyBub3QgcmVhbGlzdGljLg0KPj4+Pj4NCj4+Pj4+IEkgdGhpbmsgYSBzcGVjIGNoYW5n
ZSB3b3VsZCBiZSBiZXN0IGFzIGEgbG9uZyB0ZXJtIHNvbHV0aW9uLiBXZSBhbHNvDQo+Pj4+
PiBuZWVkIGEgc2hvcnQgdGVybSBzb2x1dGlvbi4gVGhlIHNob3J0IHRlcm0gc29sdXRpb24g
ZG9lc24ndCBoYXZlIHRvIGJlDQo+Pj4+PiBpZGVhbCBidXQgaXQgaGFzIHRvIHdvcmsgbm93
Lg0KPj4+Pg0KPj4+PiBNeSBmZWFyIHdpdGggc3VjaCBhcHByb2FjaCBpcyB0aGF0IG9uY2Ug
YSBib2RnZSBpcyBpbiBwbGFjZSBwZW9wbGUNCj4+Pj4gbW92ZSBvbiB0byBvdGhlciBzdHVm
ZiBhbmQgdGhpcyBuZXZlciBnZXRzIHByb3Blcmx5IGZpeGVkLg0KPj4+Pg0KPj4+PiBJIGtu
b3cgdGhpcyBtaWdodCBub3QgYmUgYSB3ZWxsIHJlY2VpdmVkIG9waW5pb24sIGJ1dCBpdCB3
b3VsZCBiZQ0KPj4+PiBiZXR0ZXIgaWYgc3VjaCBib2RnZSBpcyBrZXB0IGluIGVhY2ggaW50
ZXJlc3RlZCBwYXJ0eSBwYXRjaHF1ZXVlIGZvcg0KPj4+PiB0aGUgdGltZSBiZWluZywgdW50
aWwgYSBwcm9wZXIgc29sdXRpb24gaXMgaW1wbGVtZW50ZWQuICBUaGF0IHdheQ0KPj4+PiB0
aGVyZSdzIGFuIGludGVyZXN0IGZyb20gcGFydGllcyBpbnRvIHByb3Blcmx5IGZpeGluZyBp
dCB1cHN0cmVhbS4NCj4+Pg0KPj4+IFVuZm9ydHVuYXRlbHkgd2UgYXJlIGluIHRoZSBzaXR1
YXRpb24gd2hlcmUgd2UgaGF2ZSBhbiBvdXRzdGFuZGluZw0KPj4+IHVwc3RyZWFtIGJ1Zywg
c28gd2UgaGF2ZSB0byB0YWtlIGFjdGlvbiBvbmUgd2F5IG9yIHRoZSBvdGhlci4NCj4+DQo+
PiBUaGUgcmVxdWlyZWQgdmlydGlvIElPTU1VIGRldmljZSBtb2RpZmljYXRpb24gd291bGQg
YmUgcmF0aGVyIHNtYWxsLCBzbw0KPj4gYWRkaW5nIGl0IG1heWJlIHVuZGVyIGEgQ09ORklH
IG9wdGlvbiBkZWZhdWx0aW5nIHRvIG9mZiBtaWdodCBiZQ0KPj4gYWNjZXB0YWJsZS4NCj4g
DQo+IFdvdWxkIHlvdSB0aGVuIGRvIHRoZSBncmFudCBhbGxvY2F0aW9uIGFzIHBhcnQgb2Yg
dmlydGlvIElPTU1VPw0KDQpMb25nIHRlcm0sIG1heWJlLiBEbyB5b3UgcmVtZW1iZXIgbXkg
R3JhbnQtVjMgZGVzaWduIHNlc3Npb24gbGFzdCB5ZWFyPyBCZWluZw0KYWJsZSB0byByZXVz
ZSB0aGUgc2FtZSBsYXlvdXQgZm9yIHZpcnRpbyBJT01NVSB3YXMgb25lIG9mIHRoZSBiYXNp
YyBpZGVhcyBmb3INCnRoYXQgbGF5b3V0ICh0aGlzIHdvdWxkIG5lZWQgc29tZSBoZWF2eSB3
b3JrIG9uIHRoZSB2aXJ0aW8gSU9NTVUgZnJvbnRlbmQgYW5kDQpiYWNrZW5kLCBvZiBjb3Vy
c2UpLg0KDQoNCkp1ZXJnZW4NCg0KWzFdOiANCmh0dHA6Ly9kb2NzLm9hc2lzLW9wZW4ub3Jn
L3ZpcnRpby92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5wZGYjc3Vic3Vic2VjdGlvbi40LjEu
NC4zDQo=
--------------MXYfnUjLHQcYPbl2eTMn8Q9N
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------MXYfnUjLHQcYPbl2eTMn8Q9N--

--------------Z0NhCYu4dYSsTtrATMQiKS1o--

--------------0YWzv9r376Qj34YgvQLmAgcL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSoHMYFAwAAAAAACgkQsN6d1ii/Ey/+
Mgf9EPOtq/i+HhpVcnzN9udysPk9Q7bQCvOrbl83vg5vsgVNq+NQPhFjl43g2vOxP6uSaZc784hl
xX71ZVJRNyICsZ1rxt3Ex0We5E1e5fgdizic1Q9IhvFaiYhRgch6NyxpxH7c6lwwu/Kdb2QCjXuw
+v1EirflHDirShhGJ2sqG6gDKnFoBoZZWkSZB54zR2+Ee42a8pUxespliXNW0mncR6dGPNf08uRa
0P7NeOpACLCJLpJl6BdP1tDc6xGwFbKHhp7wPNqC+xL4B4+NxLDeVrpR9kFlPKdpqc48JtNFbw3M
AbCIa6wGs+Si6QS4+RVyQbvkhosHmeK0Bo1cZaduHQ==
=Jots
-----END PGP SIGNATURE-----

--------------0YWzv9r376Qj34YgvQLmAgcL--
