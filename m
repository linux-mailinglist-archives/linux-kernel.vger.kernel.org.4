Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3E74A9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGGEjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGEjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:39:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B71BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:38:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A917227BF;
        Fri,  7 Jul 2023 04:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688704729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kd5Msn99kxjmQQ5xZ5RN/FB7LBiCBkjNrXvyP7HqpFY=;
        b=rhw8ZE+iJu0Boy1jwQ1apRceFShohgzVBpU3hDM19x8gBcziIwXd4mT+flh9VF/hEY6E5K
        N1M3B4AvsMVF0oi12o9gfutwrfp52gNZTeoWBOSTgfufELKKWFx8RT1TLKgBe8MIV6A8HI
        8cGAkD4FxEEiP7fgqEKR4jaD6x1BRB4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D4BB1346D;
        Fri,  7 Jul 2023 04:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILemCdmWp2ScWAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 04:38:49 +0000
Message-ID: <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
Date:   Fri, 7 Jul 2023 06:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
References: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0zxCTWlRSlE359BNaPmE4m00"
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
--------------0zxCTWlRSlE359BNaPmE4m00
Content-Type: multipart/mixed; boundary="------------Asphqc9ReLTqJNRCJ1hcghNc";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 vikram.garhwal@amd.com
Message-ID: <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>

--------------Asphqc9ReLTqJNRCJ1hcghNc
Content-Type: multipart/mixed; boundary="------------j2xSVfZI8LfGeLTm6HMCHTsd"

--------------j2xSVfZI8LfGeLTm6HMCHTsd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDcuMjMgMjM6NDksIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVGh1
LCA2IEp1bCAyMDIzLCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPj4gT24gV2VkLCBKdWwg
MDUsIDIwMjMgYXQgMDM6NDE6MTBQTSAtMDcwMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3Rl
Og0KPj4+IE9uIFdlZCwgNSBKdWwgMjAyMywgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4+
Pj4gT24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMDg6MTQ6NTlQTSArMDMwMCwgT2xla3NhbmRy
IFR5c2hjaGVua28gd3JvdGU6DQo+Pj4+PiAqKioqKioqKioqDQo+Pj4+Pg0KPj4+Pj4gUGFy
dCAxIChpbnRybyk6DQo+Pj4+Pg0KPj4+Pj4gV2UgY291bGQgcmV1c2UgYSBQQ0kgY29uZmln
IHNwYWNlIHJlZ2lzdGVyIHRvIGV4cG9zZSB0aGUgYmFja2VuZCBpZC4NCj4+Pj4+IEhvd2V2
ZXIgdGhpcyBzb2x1dGlvbiByZXF1aXJlcyBhIGJhY2tlbmQgY2hhbmdlIChRRU1VKSB0byBl
eHBvc2UgdGhlDQo+Pj4+PiBiYWNrZW5kIGlkIHZpYSBhbiBlbXVsYXRlZCByZWdpc3RlciBm
b3IgZWFjaCBlbXVsYXRlZCBkZXZpY2UuDQo+Pj4+Pg0KPj4+Pj4gVG8gYXZvaWQgaGF2aW5n
IHRvIGludHJvZHVjZSBhIHNwZWNpYWwgY29uZmlnIHNwYWNlIHJlZ2lzdGVyIGluIGFsbA0K
Pj4+Pj4gZW11bGF0ZWQgUENJIGRldmljZXMgKHZpcnRpby1uZXQsIHZpcnRpby1ibG9jaywg
ZXRjKSBJIHdvbmRlciBpZiB3ZQ0KPj4+Pj4gY291bGQgYWRkIGEgc3BlY2lhbCBQQ0kgY29u
ZmlnIHNwYWNlIHJlZ2lzdGVyIGF0IHRoZSBlbXVsYXRlZCBQQ0kgUm9vdA0KPj4+Pj4gQ29t
cGxleCBsZXZlbC4NCj4+Pj4+DQo+Pj4+PiBCYXNpY2FsbHkgdGhlIHdvcmtmbG93IHdvdWxk
IGJlIGFzIGZvbGxvdzoNCj4+Pj4+DQo+Pj4+PiAtIExpbnV4IHJlY29nbml6ZXMgdGhlIFBD
SSBSb290IENvbXBsZXggYXMgYSBYZW4gUENJIFJvb3QgQ29tcGxleA0KPj4+Pj4gLSBMaW51
eCB3cml0ZXMgdG8gc3BlY2lhbCBQQ0kgY29uZmlnIHNwYWNlIHJlZ2lzdGVyIG9mIHRoZSBY
ZW4gUENJIFJvb3QNCj4+Pj4+ICAgIENvbXBsZXggdGhlIFBDSSBkZXZpY2UgaWQgKGJhc2lj
YWxseSB0aGUgQkRGKQ0KPj4+Pj4gLSBUaGUgWGVuIFBDSSBSb290IENvbXBsZXggZW11bGF0
ZWQgYnkgWGVuIGFuc3dlcnMgYnkgd3JpdGluZyBiYWNrIHRvDQo+Pj4+PiAgICB0aGUgc2Ft
ZSBsb2NhdGlvbiB0aGUgYmFja2VuZCBpZCAoZG9taWQgb2YgdGhlIGJhY2tlbmQpDQo+Pj4+
PiAtIExpbnV4IHJlYWRzIGJhY2sgdGhlIHNhbWUgUENJIGNvbmZpZyBzcGFjZSByZWdpc3Rl
ciBvZiB0aGUgWGVuIFBDSQ0KPj4+Pj4gICAgUm9vdCBDb21wbGV4IGFuZCBsZWFybiB0aGUg
cmVsZXZhbnQgZG9taWQNCj4+Pj4NCj4+Pj4gSU1PIHRoaXMgc2VlbXMgYXdmdWxseSBjb21w
bGV4LiAgSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBWaXJ0SU8NCj4+Pj4gc3BlYywgYnV0
IEkgc2VlIHRoZXJlJ3MgYSBWZW5kb3IgZGF0YSBjYXBhYmlsaXR5LCBjb3VsZCB3ZSBwb3Nz
aWJseQ0KPj4+PiBleHBvc2UgWGVuLXNwZWNpZmljIGluZm9ybWF0aW9uIG9uIHRoYXQgY2Fw
YWJpbGl0eT8NCj4+Pg0KPj4+IFRoYXQgaXMgYWxzbyBhIHBvc3NpYmlsaXR5IHRvby4gQWxz
byB3ZSBjb3VsZCB1c2UgYSBQQ0kgY29uZiByZWdpc3Rlcg0KPj4+IHdoaWNoIGlzIGtub3du
IHRvIGJlIHVudXNlZCBpbiB0aGUgVmlydGlvIHNwZWMgdG8gZXhwb3NlIHRoZSBncmFudA0K
Pj4+IGNhcGFiaWxpdHkgYW5kIGJhY2tlbmQgZG9taWQuDQo+Pg0KPj4gQ2FwYWJpbGl0aWVz
IGRvbid0IGhhdmUgYSBmaXhlZCBjb25maWcgc3BhY2UgcmVnaXN0ZXIsIHRoZXkgYXJlIGEN
Cj4+IGxpbmtlZCBsaXN0LCBhbmQgc28gY2FwYWJpbGl0aWVzIGVuZCB1cCBhdCBkaWZmZXJl
bnQgcG9zaXRpb25zDQo+PiBkZXBlbmRpbmcgb24gdGhlIHNwZWNpZmljIGRldmljZSBsYXlv
dXQuICBUaGUgb25seSBmaXhlZCBwYXJ0IGlzIHRoZQ0KPj4gcmFuZ2UgZnJvbSBbMCwgMHgz
RiksIGFuZCB0aGF0J3MgZnVsbHkgZGVmaW5lZCBpbiB0aGUgc3BlY2lmaWNhdGlvbi4NCj4+
DQo+PiBUcnlpbmcgdG8gZGVmaW5lIGEgZml4ZWQgYWRkcmVzcyBmb3IgWGVuIHVzZSBhZnRl
ciB0aGUgM2YgYm91bmRhcnkNCj4+IHNlZW1zIGxpa2UgYSBiYWQgaWRlYSwgYXMgaXQncyBn
b2luZyB0byBiZSBoYXJkIHRvIG1ha2Ugc3VyZSB0aGF0IHN1Y2gNCj4+IGFkZHJlc3MgaXMg
bm90IHVzZWQgb24gYWxsIHBvc3NpYmxlIGRldmljZXMuICBJTU8gdGhlIG9ubHkgd2F5IGlz
IHRvDQo+PiBwbGFjZSBzdWNoIGluZm9ybWF0aW9uIGluIGEgY2FwYWJpbGl0eSwgd2hldGhl
ciB0aGF0J3MgYW4gZXhpc3RpbmcNCj4+IGNhcGFiaWxpdHkgb3IgYSBuZXcgb25lIEkgZG9u
J3QgcmVhbGx5IGtub3cuDQo+IA0KPiBUaGF0IHNlZW1zIGxpa2UgYSBnb29kIGlkZWENCj4g
ICANCj4gICANCj4+Pj4+IFBhcnQgMiAoY2xhcmlmaWNhdGlvbik6DQo+Pj4+Pg0KPj4+Pj4g
SSB0aGluayB1c2luZyBhIHNwZWNpYWwgY29uZmlnIHNwYWNlIHJlZ2lzdGVyIGluIHRoZSBy
b290IGNvbXBsZXggd291bGQNCj4+Pj4+IG5vdCBiZSB0ZXJyaWJsZSBpbiB0ZXJtcyBvZiBn
dWVzdCBjaGFuZ2VzIGJlY2F1c2UgaXQgaXMgZWFzeSB0bw0KPj4+Pj4gaW50cm9kdWNlIGEg
bmV3IHJvb3QgY29tcGxleCBkcml2ZXIgaW4gTGludXggYW5kIG90aGVyIE9TZXMuIFRoZSBy
b290DQo+Pj4+PiBjb21wbGV4IHdvdWxkIHN0aWxsIGJlIEVDQU0gY29tcGF0aWJsZSBzbyB0
aGUgcmVndWxhciBFQ0FNIGRyaXZlciB3b3VsZA0KPj4+Pj4gc3RpbGwgd29yay4gQSBuZXcg
ZHJpdmVyIHdvdWxkIG9ubHkgYmUgbmVjZXNzYXJ5IGlmIHlvdSB3YW50IHRvIGJlIGFibGUN
Cj4+Pj4+IHRvIGFjY2VzcyB0aGUgc3BlY2lhbCBjb25maWcgc3BhY2UgcmVnaXN0ZXIuDQo+
Pj4+DQo+Pj4+IEknbSBzbGlnaHRseSB3b3JyeSBvZiB0aGlzIGFwcHJvYWNoLCB3ZSBlbmQg
dXAgbW9kaWZ5aW5nIGEgcm9vdA0KPj4+PiBjb21wbGV4IGVtdWxhdGlvbiBpbiBvcmRlciB0
byBhdm9pZCBtb2RpZnlpbmcgYSBQQ0kgZGV2aWNlIGVtdWxhdGlvbg0KPj4+PiBvbiBRRU1V
LCBub3Qgc3VyZSB0aGF0J3MgYSBnb29kIHRyYWRlIG9mZi4NCj4+Pj4NCj4+Pj4gTm90ZSBh
bHNvIHRoYXQgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMgd2lsbCBsaWtlbHkgaGF2ZSBkaWZm
ZXJlbnQgcm9vdA0KPj4+PiBjb21wbGV4LCBhbmQgc28geW91IG1pZ2h0IG5lZWQgdG8gbW9k
aWZ5IHNldmVyYWwgb2YgdGhlbSwgcGx1cyB0aGVuDQo+Pj4+IGFycmFuZ2UgdGhlIFBDSSBs
YXlvdXQgY29ycmVjdGx5IGluIG9yZGVyIHRvIGhhdmUgdGhlIHByb3BlciBoaWVyYXJjaHkN
Cj4+Pj4gc28gdGhhdCBkZXZpY2VzIGJlbG9uZ2luZyB0byBkaWZmZXJlbnQgZHJpdmVyIGRv
bWFpbnMgYXJlIGFzc2lnbmVkIHRvDQo+Pj4+IGRpZmZlcmVudCBicmlkZ2VzLg0KPj4+DQo+
Pj4gSSBkbyB0aGluayB0aGF0IGFkZGluZyBzb21ldGhpbmcgdG8gdGhlIFBDSSBjb25mIHJl
Z2lzdGVyIHNvbWV3aGVyZSBpcw0KPj4+IHRoZSBiZXN0IG9wdGlvbiBiZWNhdXNlIGl0IGlz
IG5vdCBkZXBlbmRlbnQgb24gQUNQSSBhbmQgaXQgaXMgbm90DQo+Pj4gZGVwZW5kZW50IG9u
IHhlbnN0b3JlIGJvdGggb2Ygd2hpY2ggYXJlIHZlcnkgdW5kZXNpcmFibGUuDQo+Pj4NCj4+
PiBJIGFtIG5vdCBzdXJlIHdoZXJlIHNwZWNpZmljYWxseSBpcyB0aGUgYmVzdCBwbGFjZS4g
VGhlc2UgYXJlIDMgaWRlYXMNCj4+PiB3ZSBjYW1lIHVwIHdpdGg6DQo+Pj4gMS4gUENJIHJv
b3QgY29tcGxleA0KPj4+IDIuIGEgcmVnaXN0ZXIgb24gdGhlIGRldmljZSBpdHNlbGYNCj4+
PiAzLiBhIG5ldyBjYXBhYmlsaXR5IG9mIHRoZSBkZXZpY2UNCj4+PiA0LiBhZGQgb25lIGV4
dHJhIGR1bW15IFBDSSBkZXZpY2UgZm9yIHRoZSBzb2xlIHB1cnBvc2Ugb2YgZXhwb3Npbmcg
dGhlDQo+Pj4gICAgIGdyYW50cyBjYXBhYmlsaXR5DQo+Pj4NCj4+Pg0KPj4+IExvb2tpbmcg
YXQgdGhlIHNwZWMsIHRoZXJlIGlzIGEgd2F5IHRvIGFkZCBhIHZlbmRvci1zcGVjaWZpYyBj
YXBhYmlsaXR5DQo+Pj4gKGNhcF92bmRyID0gMHg5KS4gQ291bGQgd2UgdXNlIHRoYXQ/IEl0
IGRvZXNuJ3QgbG9vayBsaWtlIGl0IGlzIHVzZWQNCj4+PiB0b2RheSwgTGludXggZG9lc24n
dCBwYXJzZSBpdC4NCj4+DQo+PiBJIGRpZCB3b25kZXIgdGhlIHNhbWUgZnJvbSBhIHF1aWNr
IGxvb2sgYXQgdGhlIHNwZWMuICBUaGVyZSdzIGhvd2V2ZXINCj4+IGEgdGV4dCBpbiB0aGUg
c3BlY2lmaWNhdGlvbiB0aGF0IHNheXM6DQo+Pg0KPj4gIlRoZSBkcml2ZXIgU0hPVUxEIE5P
VCB1c2UgdGhlIFZlbmRvciBkYXRhIGNhcGFiaWxpdHkgZXhjZXB0IGZvcg0KPj4gZGVidWdn
aW5nIGFuZCByZXBvcnRpbmcgcHVycG9zZXMuIg0KPj4NCj4+IFNvIHdlIHdvdWxkIGF0IGxl
YXN0IG5lZWQgdG8gY2hhbmdlIHRoYXQgYmVjYXVzZSB0aGUgY2FwYWJpbGl0eSB3b3VsZA0K
Pj4gdGhlbiBiZSB1c2VkIGJ5IG90aGVyIHB1cnBvc2VzIGRpZmZlcmVudCB0aGFuIGRlYnVn
Z2luZyBhbmQgcmVwb3J0aW5nLg0KPj4NCj4+IFNlZW1zIGxpa2UgYSBtaW5vciBhZGp1c3Rt
ZW50LCBzbyBtaWdodCB3ZSB3b3J0aCBhc2tpbmcgdXBzdHJlYW0gYWJvdXQNCj4+IHRoZWly
IG9waW5pb24sIGFuZCB0byBnZXQgYSBjb252ZXJzYXRpb24gc3RhcnRlZC4NCj4gDQo+IFdh
aXQsIHdvdWxkbid0IHRoaXMgdXNlLWNhc2UgZmFsbCB1bmRlciAicmVwb3J0aW5nIiA/IEl0
IGlzIGV4YWN0bHkgd2hhdA0KPiB3ZSBhcmUgZG9pbmcsIHJpZ2h0Pw0KDQpJJ2QgdW5kZXJz
dGFuZCAicmVwb3J0aW5nIiBhcyBlLmcuIGxvZ2dpbmcsIHRyYW5zZmVycmluZyBzdGF0aXN0
aWNzLCAuLi4NCg0KV2UnZCBsaWtlIHRvIHVzZSBpdCBmb3IgY29uZmlndXJhdGlvbiBwdXJw
b3Nlcy4NCg0KQW5vdGhlciBpZGVhIHdvdWxkIGJlIHRvIGVuaGFuY2UgdGhlIHZpcnRpbyBJ
T01NVSBkZXZpY2UgdG8gc3VpdCBvdXIgbmVlZHM6DQp3ZSBjb3VsZCBhZGQgdGhlIGRvbWlk
IGFzIGFub3RoZXIgdmlydGlvIElPTU1VIGRldmljZSBjYXBhYmlsaXR5IGFuZCAoZm9yIG5v
dykNCnVzZSBieXBhc3MgbW9kZSBmb3IgYWxsICJwcm9kdWN0aXZlIiBkZXZpY2VzLg0KDQpM
YXRlciB3ZSBjb3VsZCBldmVuIGFkZCBncmFudC1WMyBzdXBwb3J0IHRvIFhlbiBhbmQgdG8g
dGhlIHZpcnRpbyBJT01NVSBkZXZpY2UNCihzZWUgbXkgbGFzdCB5ZWFyIFhlbiBTdW1taXQg
ZGVzaWduIHNlc3Npb24pLiBUaGlzIGNvdWxkIGJlIHVzYWJsZSBmb3INCmRpc2FnZ3JlZ2F0
ZWQgS1ZNIHNldHVwcywgdG9vLCBzbyBJIGJlbGlldmUgdGhlcmUgaXMgYSBjaGFuY2UgdG8g
Z2V0IHRoaXMNCmFjY2VwdGVkLg0KDQo+Pj4+PiAqKioqKioqKioqDQo+Pj4+PiBXaGF0IGRv
IHlvdSB0aGluayBhYm91dCBpdD8gQXJlIHRoZXJlIGFueSBwaXRmYWxscywgZXRjPyBUaGlz
IGFsc28gcmVxdWlyZXMNCj4+Pj4+IHN5c3RlbSBjaGFuZ2VzLCBidXQgYXQgbGVhc3Qgd2l0
aG91dCB2aXJ0aW8gc3BlYyBjaGFuZ2VzLg0KPj4+Pg0KPj4+PiBXaHkgYXJlIHdlIHNvIHJl
bHVjdGFudCB0byBhZGQgc3BlYyBjaGFuZ2VzPyAgSSB1bmRlcnN0YW5kIHRoaXMgbWlnaHQN
Cj4+Pj4gdGFrZSB0aW1lIGFuIGVmZm9ydCwgYnV0IGl0J3MgdGhlIG9ubHkgd2F5IElNTyB0
byBidWlsZCBhIHN1c3RhaW5hYmxlDQo+Pj4+IFZpcnRJTyBYZW4gaW1wbGVtZW50YXRpb24u
ICBEaWQgd2UgYWxyZWFkeSBhdHRlbXB0IHRvIG5lZ290aWF0ZSB3aXRoDQo+Pj4+IE9hc2lz
IFhlbiByZWxhdGVkIHNwZWMgY2hhbmdlcyBhbmQgdGhvc2Ugd2hlcmUgcmVmdXNlZD8NCj4+
Pg0KPj4+IFRoYXQncyBiZWNhdXNlIHNwZWMgY2hhbmdlcyBjYW4gYmUgdmVyeSBzbG93LiBU
aGlzIGlzIGEgYnVnIHRoYXQgd2UgbmVlZA0KPj4+IGEgcmVsYXRpdmVseSBxdWljayBzb2x1
dGlvbiBmb3IgYW5kIHdhaXRpbmcgMTItMjQgbW9udGhzIGZvciBhIHNwZWMNCj4+PiB1cGRh
dGUgaXMgbm90IHJlYWxpc3RpYy4NCj4+Pg0KPj4+IEkgdGhpbmsgYSBzcGVjIGNoYW5nZSB3
b3VsZCBiZSBiZXN0IGFzIGEgbG9uZyB0ZXJtIHNvbHV0aW9uLiBXZSBhbHNvDQo+Pj4gbmVl
ZCBhIHNob3J0IHRlcm0gc29sdXRpb24uIFRoZSBzaG9ydCB0ZXJtIHNvbHV0aW9uIGRvZXNu
J3QgaGF2ZSB0byBiZQ0KPj4+IGlkZWFsIGJ1dCBpdCBoYXMgdG8gd29yayBub3cuDQo+Pg0K
Pj4gTXkgZmVhciB3aXRoIHN1Y2ggYXBwcm9hY2ggaXMgdGhhdCBvbmNlIGEgYm9kZ2UgaXMg
aW4gcGxhY2UgcGVvcGxlDQo+PiBtb3ZlIG9uIHRvIG90aGVyIHN0dWZmIGFuZCB0aGlzIG5l
dmVyIGdldHMgcHJvcGVybHkgZml4ZWQuDQo+Pg0KPj4gSSBrbm93IHRoaXMgbWlnaHQgbm90
IGJlIGEgd2VsbCByZWNlaXZlZCBvcGluaW9uLCBidXQgaXQgd291bGQgYmUNCj4+IGJldHRl
ciBpZiBzdWNoIGJvZGdlIGlzIGtlcHQgaW4gZWFjaCBpbnRlcmVzdGVkIHBhcnR5IHBhdGNo
cXVldWUgZm9yDQo+PiB0aGUgdGltZSBiZWluZywgdW50aWwgYSBwcm9wZXIgc29sdXRpb24g
aXMgaW1wbGVtZW50ZWQuICBUaGF0IHdheQ0KPj4gdGhlcmUncyBhbiBpbnRlcmVzdCBmcm9t
IHBhcnRpZXMgaW50byBwcm9wZXJseSBmaXhpbmcgaXQgdXBzdHJlYW0uDQo+IA0KPiBVbmZv
cnR1bmF0ZWx5IHdlIGFyZSBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIHdlIGhhdmUgYW4gb3V0
c3RhbmRpbmcNCj4gdXBzdHJlYW0gYnVnLCBzbyB3ZSBoYXZlIHRvIHRha2UgYWN0aW9uIG9u
ZSB3YXkgb3IgdGhlIG90aGVyLg0KDQpUaGUgcmVxdWlyZWQgdmlydGlvIElPTU1VIGRldmlj
ZSBtb2RpZmljYXRpb24gd291bGQgYmUgcmF0aGVyIHNtYWxsLCBzbw0KYWRkaW5nIGl0IG1h
eWJlIHVuZGVyIGEgQ09ORklHIG9wdGlvbiBkZWZhdWx0aW5nIHRvIG9mZiBtaWdodCBiZQ0K
YWNjZXB0YWJsZS4NCg0KDQpKdWVyZ2VuDQo=
--------------j2xSVfZI8LfGeLTm6HMCHTsd
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

--------------j2xSVfZI8LfGeLTm6HMCHTsd--

--------------Asphqc9ReLTqJNRCJ1hcghNc--

--------------0zxCTWlRSlE359BNaPmE4m00
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSnltgFAwAAAAAACgkQsN6d1ii/Ey9g
ygf+NAZxeBtmbA89mNlh8hm2pIT18GiomgxioL76DcMi5PhrWYe/c9xJNaDkhlUws4VMIx5iRWzq
avbi/cCdM6LBkR7Upi3A6wivNx8tdZ9NXK2OooGrpQb7D/KR9kWusAZj4GZF4+JM69cAVDFMi0LE
lNy9UO5AuaWyshvvM5lshq+GdaqTmHCg9SWVhauFcPew69zmTNg8w2Jkyn5jHVRUmLpHPFEl9Ysm
DcLW9pvSAePtvTijjwlU/yyBCFw92mepstsfboYL6Tb+iDUxLLDV8kxvCp5ELEvufRUI2r6wpVlP
+FreYUinkQQ3TNOdDQpS4UrTmrM3LdvZz/X3SdJdDA==
=9eJw
-----END PGP SIGNATURE-----

--------------0zxCTWlRSlE359BNaPmE4m00--
