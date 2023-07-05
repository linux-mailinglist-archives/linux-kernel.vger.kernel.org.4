Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E2747C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGEErD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGEErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:47:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B6A1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:46:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E2EE21FEF;
        Wed,  5 Jul 2023 04:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688532415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aCGeCa7qbtPCvYkrWYPhbR/hRCyt//MCQhsux/9iG7A=;
        b=QOSdzGFeV2jv/2myrV6jC0O7zlUSQ7qkm0AyH1v8iXtMNXOHzN5Z4x47EzflHzfJ3dWCJV
        3jslnFnFgucw73GwIMeobMy+m425wxLL8Xykiugr3z/3LbxK3wy7KTnKiwND8c33w7J0Ng
        EEnXluq6xm5Kn+kss99+KowAOFVtQsM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4498134F3;
        Wed,  5 Jul 2023 04:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NUxpLr71pGTUZgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 05 Jul 2023 04:46:54 +0000
Message-ID: <b948ba7d-74f0-30e5-c4d2-4a4d83866d37@suse.com>
Date:   Wed, 5 Jul 2023 06:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qx8XvgczXPmsLWXaiKapfNYd"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qx8XvgczXPmsLWXaiKapfNYd
Content-Type: multipart/mixed; boundary="------------jUaAGbGpIYScoQIf0iA9PuiE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>
Cc: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 vikram.garhwal@amd.com
Message-ID: <b948ba7d-74f0-30e5-c4d2-4a4d83866d37@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com> <ZKQF8qq8Oh5E+Fxx@mail-itl>
 <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
In-Reply-To: <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>

--------------jUaAGbGpIYScoQIf0iA9PuiE
Content-Type: multipart/mixed; boundary="------------DUN3FKe397JPnfjf0FUM1kRY"

--------------DUN3FKe397JPnfjf0FUM1kRY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDcuMjMgMTk6MTQsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgNTo0OeKAr1BNIFJvZ2VyIFBhdSBNb25uw6kg
PHJvZ2VyLnBhdUBjaXRyaXguY29tIA0KPiA8bWFpbHRvOnJvZ2VyLnBhdUBjaXRyaXguY29t
Pj4gd3JvdGU6DQo+IA0KPiBIZWxsbyBhbGwuDQo+IA0KPiBbc29ycnkgZm9yIHRoZSBwb3Nz
aWJsZSBmb3JtYXQgaXNzdWVzXQ0KPiANCj4gDQo+ICAgICBPbiBUdWUsIEp1bCAwNCwgMjAy
MyBhdCAwMTo0Mzo0NlBNICswMjAwLCBNYXJlayBNYXJjenlrb3dza2ktR8OzcmVja2kgd3Jv
dGU6DQo+ICAgICAgPiBIaSwNCj4gICAgICA+DQo+ICAgICAgPiBGV0lXLCBJIGhhdmUgcmFu
IGludG8gdGhpcyBpc3N1ZSBzb21lIHRpbWUgYWdvIHRvby4gSSBydW4gWGVuIG9uIHRvcCBv
Zg0KPiAgICAgID4gS1ZNIGFuZCB0aGVuIHBhc3N0aHJvdWdoIHNvbWUgb2YgdGhlIHZpcnRp
byBkZXZpY2VzIChuZXR3b3JrIG9uZQ0KPiAgICAgID4gc3BlY2lmaWNhbGx5KSBpbnRvIGEg
KFBWKSBndWVzdC4gU28sIEkgaGl0IGJvdGggY2FzZXMsIHRoZSBkb20wIG9uZSBhbmQNCj4g
ICAgICA+IGRvbVUgb25lLiBBcyBhIHRlbXBvcmFyeSB3b3JrYXJvdW5kIEkgbmVlZGVkIHRv
IGRpc2FibGUNCj4gICAgICA+IENPTkZJR19YRU5fVklSVElPIGNvbXBsZXRlbHkgKGp1c3Qg
ZGlzYWJsaW5nDQo+ICAgICAgPiBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCB3YXMg
bm90IGVub3VnaCB0byBmaXggaXQpLg0KPiAgICAgID4gV2l0aCB0aGF0IGNvbnRleHQgaW4g
cGxhY2UsIHRoZSBhY3R1YWwgcmVzcG9uc2UgYmVsb3cuDQo+ICAgICAgPg0KPiAgICAgID4g
T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMTI6Mzk6NDBQTSArMDIwMCwgSnVlcmdlbiBHcm9z
cyB3cm90ZToNCj4gICAgICA+ID4gT24gMDQuMDcuMjMgMDk6NDgsIFJvZ2VyIFBhdSBNb25u
w6kgd3JvdGU6DQo+ICAgICAgPiA+ID4gT24gVGh1LCBKdW4gMjksIDIwMjMgYXQgMDM6NDQ6
MDRQTSAtMDcwMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPiAgICAgID4gPiA+ID4g
T24gVGh1LCAyOSBKdW4gMjAyMywgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6DQo+ICAg
ICAgPiA+ID4gPiA+IE9uIDI5LjA2LjIzIDA0OjAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3Jv
dGU6DQo+ICAgICAgPiA+ID4gPiA+ID4gSSB0aGluayB3ZSBuZWVkIHRvIGFkZCBhIHNlY29u
ZCB3YXk/IEl0IGNvdWxkIGJlIGFueXRoaW5nIHRoYXQNCj4gICAgIGNhbiBoZWxwDQo+ICAg
ICAgPiA+ID4gPiA+ID4gdXMgZGlzdGluZ3Vpc2ggYmV0d2VlbiBhIG5vbi1ncmFudHMtY2Fw
YWJsZSB2aXJ0aW8gYmFja2VuZCBhbmQgYQ0KPiAgICAgID4gPiA+ID4gPiA+IGdyYW50cy1j
YXBhYmxlIHZpcnRpbyBiYWNrZW5kLCBzdWNoIGFzOg0KPiAgICAgID4gPiA+ID4gPiA+IC0g
YSBzdHJpbmcgb24geGVuc3RvcmUNCj4gICAgICA+ID4gPiA+ID4gPiAtIGEgeGVuIHBhcmFt
DQo+ICAgICAgPiA+ID4gPiA+ID4gLSBhIHNwZWNpYWwgUENJIGNvbmZpZ3VyYXRpb24gcmVn
aXN0ZXIgdmFsdWUNCj4gICAgICA+ID4gPiA+ID4gPiAtIHNvbWV0aGluZyBpbiB0aGUgQUNQ
SSB0YWJsZXMNCj4gICAgICA+ID4gPiA+ID4gPiAtIHRoZSBRRU1VIG1hY2hpbmUgdHlwZQ0K
PiAgICAgID4gPiA+ID4gPg0KPiAgICAgID4gPiA+ID4gPg0KPiAgICAgID4gPiA+ID4gPiBZ
ZXMsIEkgcmVtZW1iZXIgdGhlcmUgd2FzIGEgZGlzY3Vzc2lvbiByZWdhcmRpbmcgdGhhdC4g
VGhlIHBvaW50DQo+ICAgICBpcyB0bw0KPiAgICAgID4gPiA+ID4gPiBjaG9vc2UgYSBzb2x1
dGlvbiB0byBiZSBmdW5jdGlvbmFsIGZvciBib3RoIFBWIGFuZCBIVk0gKmFuZCogdG8NCj4g
ICAgIGJlIGFibGUNCj4gICAgICA+ID4gPiA+ID4gdG8gc3VwcG9ydCBhIGhvdHBsdWcuIElJ
UkMsIHRoZSB4ZW5zdG9yZSBjb3VsZCBiZSBhIHBvc3NpYmxlDQo+ICAgICBjYW5kaWRhdGUu
DQo+ICAgICAgPiA+ID4gPg0KPiAgICAgID4gPiA+ID4geGVuc3RvcmUgd291bGQgYmUgYW1v
bmcgdGhlIGVhc2llc3QgdG8gbWFrZSB3b3JrLiBUaGUgb25seSBkb3duc2lkZSBpcw0KPiAg
ICAgID4gPiA+ID4gdGhlIGRlcGVuZGVuY3kgb24geGVuc3RvcmUgd2hpY2ggb3RoZXJ3aXNl
IHZpcnRpbytncmFudHMgZG9lc24ndCBoYXZlLg0KPiAgICAgID4gPiA+DQo+ICAgICAgPiA+
ID4gSSB3b3VsZCBhdm9pZCBpbnRyb2R1Y2luZyBhIGRlcGVuZGVuY3kgb24geGVuc3RvcmUs
IGlmIG5vdGhpbmcgZWxzZSB3ZQ0KPiAgICAgID4gPiA+IGtub3cgaXQncyBhIHBlcmZvcm1h
bmNlIGJvdHRsZW5lY2suDQo+ICAgICAgPiA+ID4NCj4gICAgICA+ID4gPiBXZSB3b3VsZCBh
bHNvIG5lZWQgdG8gbWFwIHRoZSB2aXJ0aW8gZGV2aWNlIHRvcG9sb2d5IGludG8geGVuc3Rv
cmUsIHNvDQo+ICAgICAgPiA+ID4gdGhhdCB3ZSBjYW4gcGFzcyBkaWZmZXJlbnQgb3B0aW9u
cyBmb3IgZWFjaCBkZXZpY2UuDQo+ICAgICAgPiA+DQo+ICAgICAgPiA+IFRoaXMgYXNwZWN0
IChkaWZmZXJlbnQgb3B0aW9ucykgaXMgaW1wb3J0YW50LiBIb3cgZG8geW91IHdhbnQgdG8g
cGFzcw0KPiAgICAgdmlydGlvDQo+ICAgICAgPiA+IGRldmljZSBjb25maWd1cmF0aW9uIHBh
cmFtZXRlcnMgZnJvbSBkb20wIHRvIHRoZSB2aXJ0aW8gYmFja2VuZCBkb21haW4/IFlvdQ0K
PiAgICAgID4gPiBwcm9iYWJseSBuZWVkIHNvbWV0aGluZyBsaWtlIFhlbnN0b3JlIChhIHZp
cnRpbyBiYXNlZCBhbHRlcm5hdGl2ZSBsaWtlDQo+ICAgICB2aXJ0aW9mcw0KPiAgICAgID4g
PiB3b3VsZCB3b3JrLCB0b28pIGZvciB0aGF0IHB1cnBvc2UuDQo+ICAgICAgPiA+DQo+ICAg
ICAgPiA+IE1hcHBpbmcgdGhlIHRvcG9sb2d5IHNob3VsZCBiZSByYXRoZXIgZWFzeSB2aWEg
dGhlIFBDSS1JZCwgZS5nLjoNCj4gICAgICA+ID4NCj4gICAgICA+ID4gL2xvY2FsL2RvbWFp
bi80Mi9kZXZpY2UvdmlydGlvLzAwMDA6MDA6MWMuMC9iYWNrZW5kDQo+ICAgICAgPg0KPiAg
ICAgID4gV2hpbGUgSSBhZ3JlZSB0aGlzIHdvdWxkIHByb2JhYmx5IGJlIHRoZSBzaW1wbGVz
dCB0byBpbXBsZW1lbnQsIEkgZG9uJ3QNCj4gICAgICA+IGxpa2UgaW50cm9kdWNpbmcgeGVu
c3RvcmUgZGVwZW5kZW5jeSBpbnRvIHZpcnRpbyBmcm9udGVuZCBlaXRoZXIuDQo+ICAgICAg
PiBUb29sc3RhY2sgLT4gYmFja2VuZCBjb21tdW5pY2F0aW9uIGlzIHByb2JhYmx5IGVhc2ll
ciB0byBzb2x2ZSwgYXMgaXQncw0KPiAgICAgID4gbXVjaCBtb3JlIGZsZXhpYmxlIChjb3Vs
ZCB1c2UgcWVtdSBjbWRsaW5lLCBRTVAsIG90aGVyIHNpbWlsYXINCj4gICAgICA+IG1lY2hh
bmlzbXMgZm9yIG5vbi1xZW11IGJhY2tlbmRzIGV0YykuDQo+IA0KPiAgICAgSSBhbHNvIHRo
aW5rIGZlYXR1cmVzIHNob3VsZCBiZSBleHBvc2VkIHVuaWZvcm1seSBmb3IgZGV2aWNlcywg
aXQncyBhdA0KPiAgICAgbGVhc3Qgd2VpcmQgdG8gaGF2ZSBjZXJ0YWluIGZlYXR1cmVzIGV4
cG9zZWQgaW4gdGhlIFBDSSBjb25maWcgc3BhY2UNCj4gICAgIHdoaWxlIG90aGVyIGZlYXR1
cmVzIGV4cG9zZWQgaW4geGVuc3RvcmUuDQo+IA0KPiAgICAgRm9yIHZpcnRpby1tbWlvIHRo
aXMgbWlnaHQgZ2V0IGEgYml0IGNvbmZ1c2luZywgYXJlIHdlIGdvaW5nIHRvIGFkZA0KPiAg
ICAgeGVuc3RvcmUgZW50cmllcyBiYXNlZCBvbiB0aGUgcG9zaXRpb24gb2YgdGhlIGRldmlj
ZSBjb25maWcgbW1pbw0KPiAgICAgcmVnaW9uPw0KPiANCj4gICAgIEkgdGhpbmsgb24gQXJt
IFBDSSBlbnVtZXJhdGlvbiBpcyBub3QgKHVzdWFsbHk/KSBkb25lIGJ5IHRoZSBmaXJtd2Fy
ZSwNCj4gICAgIGF0IHdoaWNoIHBvaW50IHRoZSBTQkRGIGV4cGVjdGVkIGJ5IHRoZSB0b29s
cy9iYWNrZW5kIG1pZ2h0IGJlDQo+ICAgICBkaWZmZXJlbnQgdGhhbiB0aGUgdmFsdWUgYXNz
aWduZWQgYnkgdGhlIGd1ZXN0IE9TLg0KPiANCj4gICAgIEkgdGhpbmsgdGhlcmUgYXJlIHR3
byBzbGlnaHRseSBkaWZmZXJlbnQgaXNzdWVzLCBvbmUgaXMgaG93IHRvIHBhc3MNCj4gICAg
IGluZm9ybWF0aW9uIHRvIHZpcnRpbyBiYWNrZW5kcywgSSB0aGluayBkb2luZyB0aGlzIGlu
aXRpYWxseSBiYXNlZCBvbg0KPiAgICAgeGVuc3RvcmUgaXMgbm90IHRoYXQgYmFkLCBiZWNh
dXNlIGl0J3MgYW4gaW50ZXJuYWwgZGV0YWlsIG9mIHRoZQ0KPiAgICAgYmFja2VuZCBpbXBs
ZW1lbnRhdGlvbi4gSG93ZXZlciBwYXNzaW5nIGluZm9ybWF0aW9uIHRvIHZpcnRpbw0KPiAg
ICAgZnJvbnRlbmRzIHVzaW5nIHhlbnN0b3JlIGlzIElNTyBhIGJhZCBpZGVhLCB0aGVyZSdz
IGFscmVhZHkgYSB3YXkgdG8NCj4gICAgIG5lZ290aWF0ZSBmZWF0dXJlcyBiZXR3ZWVuIHZp
cnRpbyBmcm9udGVuZHMgYW5kIGJhY2tlbmRzLCBhbmQgWGVuDQo+ICAgICBzaG91bGQganVz
dCBleHBhbmQgYW5kIHVzZSB0aGF0Lg0KPiANCj4gDQo+IA0KPiBPbiBBcm0gd2l0aCBkZXZp
Y2UtdHJlZSB3ZSBoYXZlIGEgc3BlY2lhbCBiaW5kaW5ncyB3aGljaCBwdXJwb3NlIGlzIHRv
IGluZm9ybSB1cyANCj4gd2hldGhlciB3ZSBuZWVkIHRvIHVzZSBncmFudHMgZm9yIHZpcnRp
byBhbmQgYmFja2VuZCBkb21pZCBmb3IgYSBwYXJ0aWN1bGFyIA0KPiBkZXZpY2UuSGVyZSBv
biB4ODYsIHdlIGRvbid0IGhhdmUgYSBkZXZpY2UgdHJlZSwgc28gY2Fubm90IChlYXNpbHk/
KSByZXVzZSB0aGlzIA0KPiBsb2dpYy4NCj4gDQo+IEkgaGF2ZSBqdXN0IHJlY29sbGVjdGVk
IG9uZSBpZGVhIHN1Z2dlc3RlZCBieSBTdGVmYW5vIHNvbWUgdGltZSBhZ28gWzFdLiBUaGUg
DQo+IGNvbnRleHQgb2YgZGlzY3Vzc2lvbiB3YXMgYWJvdXQgd2hhdCB0byBkbyB3aGVuIGRl
dmljZS10cmVlIGFuZCBBQ1BJIGNhbm5vdCBiZSANCj4gcmV1c2VkIChvciBzb21ldGhpbmcg
bGlrZSB0aGF0KS5UaGUgaWRlYSB3b24ndCBjb3ZlciB2aXJ0aW8tbW1pbywgYnV0IEkgaGF2
ZSANCj4gaGVhcmQgdGhhdCB2aXJ0aW8tbW1pbyB1c2FnZSB3aXRoIHg4NiBYZW4gaXMgcmF0
aGVyIHVudXN1YWwgY2FzZS4NCj4gDQo+IEkgd2lsbCBwYXN0ZSB0aGUgdGV4dCBiZWxvdyBm
b3IgY29udmVuaWVuY2UuDQo+IA0KPiAqKioqKioqKioqDQo+IA0KPiBQYXJ0IDEgKGludHJv
KToNCj4gDQo+IFdlIGNvdWxkIHJldXNlIGEgUENJIGNvbmZpZyBzcGFjZSByZWdpc3RlciB0
byBleHBvc2UgdGhlIGJhY2tlbmQgaWQuDQo+IEhvd2V2ZXIgdGhpcyBzb2x1dGlvbiByZXF1
aXJlcyBhIGJhY2tlbmQgY2hhbmdlIChRRU1VKSB0byBleHBvc2UgdGhlDQo+IGJhY2tlbmQg
aWQgdmlhIGFuIGVtdWxhdGVkIHJlZ2lzdGVyIGZvciBlYWNoIGVtdWxhdGVkIGRldmljZS4N
Cj4gDQo+IFRvIGF2b2lkIGhhdmluZyB0byBpbnRyb2R1Y2UgYSBzcGVjaWFsIGNvbmZpZyBz
cGFjZSByZWdpc3RlciBpbiBhbGwNCj4gZW11bGF0ZWQgUENJIGRldmljZXMgKHZpcnRpby1u
ZXQsIHZpcnRpby1ibG9jaywgZXRjKSBJIHdvbmRlciBpZiB3ZQ0KPiBjb3VsZCBhZGQgYSBz
cGVjaWFsIFBDSSBjb25maWcgc3BhY2UgcmVnaXN0ZXIgYXQgdGhlIGVtdWxhdGVkIFBDSSBS
b290DQo+IENvbXBsZXggbGV2ZWwuDQo+IA0KPiBCYXNpY2FsbHkgdGhlIHdvcmtmbG93IHdv
dWxkIGJlIGFzIGZvbGxvdzoNCj4gDQo+IC0gTGludXggcmVjb2duaXplcyB0aGUgUENJIFJv
b3QgQ29tcGxleCBhcyBhIFhlbiBQQ0kgUm9vdCBDb21wbGV4DQo+IC0gTGludXggd3JpdGVz
IHRvIHNwZWNpYWwgUENJIGNvbmZpZyBzcGFjZSByZWdpc3RlciBvZiB0aGUgWGVuIFBDSSBS
b290DQo+ICDCoCBDb21wbGV4IHRoZSBQQ0kgZGV2aWNlIGlkIChiYXNpY2FsbHkgdGhlIEJE
RikNCj4gLSBUaGUgWGVuIFBDSSBSb290IENvbXBsZXggZW11bGF0ZWQgYnkgWGVuIGFuc3dl
cnMgYnkgd3JpdGluZyBiYWNrIHRvDQo+ICDCoCB0aGUgc2FtZSBsb2NhdGlvbiB0aGUgYmFj
a2VuZCBpZCAoZG9taWQgb2YgdGhlIGJhY2tlbmQpDQo+IC0gTGludXggcmVhZHMgYmFjayB0
aGUgc2FtZSBQQ0kgY29uZmlnIHNwYWNlIHJlZ2lzdGVyIG9mIHRoZSBYZW4gUENJDQo+ICDC
oCBSb290IENvbXBsZXggYW5kIGxlYXJuIHRoZSByZWxldmFudCBkb21pZA0KPiANCj4gUGFy
dCAyIChjbGFyaWZpY2F0aW9uKToNCj4gDQo+IEkgdGhpbmsgdXNpbmcgYSBzcGVjaWFsIGNv
bmZpZyBzcGFjZSByZWdpc3RlciBpbiB0aGUgcm9vdCBjb21wbGV4IHdvdWxkDQo+IG5vdCBi
ZSB0ZXJyaWJsZSBpbiB0ZXJtcyBvZiBndWVzdCBjaGFuZ2VzIGJlY2F1c2UgaXQgaXMgZWFz
eSB0bw0KPiBpbnRyb2R1Y2UgYSBuZXcgcm9vdCBjb21wbGV4IGRyaXZlciBpbiBMaW51eCBh
bmQgb3RoZXIgT1Nlcy4gVGhlIHJvb3QNCj4gY29tcGxleCB3b3VsZCBzdGlsbCBiZSBFQ0FN
IGNvbXBhdGlibGUgc28gdGhlIHJlZ3VsYXIgRUNBTSBkcml2ZXIgd291bGQNCj4gc3RpbGwg
d29yay4gQSBuZXcgZHJpdmVyIHdvdWxkIG9ubHkgYmUgbmVjZXNzYXJ5IGlmIHlvdSB3YW50
IHRvIGJlIGFibGUNCj4gdG8gYWNjZXNzIHRoZSBzcGVjaWFsIGNvbmZpZyBzcGFjZSByZWdp
c3Rlci4NCj4gDQo+IA0KPiAqKioqKioqKioqDQo+IFdoYXQgZG/CoHlvdcKgdGhpbmsgYWJv
dXQgaXQ/IEFyZSB0aGVyZSBhbnkgcGl0ZmFsbHMsIGV0Yz8gVGhpcyBhbHNvIHJlcXVpcmVz
IA0KPiBzeXN0ZW0gY2hhbmdlcywgYnV0IGF0IGxlYXN0IHdpdGhvdXQgdmlydGlvIHNwZWMg
Y2hhbmdlcy4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRl
dmVsL2FscGluZS5ERUIuMi4yMi4zOTQuMjIxMDA2MTc0NzU5MC4zNjkwMTc5QHVidW50dS1s
aW51eC0yMC0wNC1kZXNrdG9wLyA8aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVs
L2FscGluZS5ERUIuMi4yMi4zOTQuMjIxMDA2MTc0NzU5MC4zNjkwMTc5QHVidW50dS1saW51
eC0yMC0wNC1kZXNrdG9wLz4NCg0KU291bmRzIGxpa2UgYSBnb29kIGlkZWEuIFRoZXJlIHdv
dWxkIGJlIG9uZSBQQ0kgcm9vdCBwZXIgYmFja2VuZCBkb21haW4gbmVlZGVkLA0KYnV0IHRo
YXQgc2hvdWxkIGJlIHBvc3NpYmxlLg0KDQoNCkp1ZXJnZW4NCg0K
--------------DUN3FKe397JPnfjf0FUM1kRY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------DUN3FKe397JPnfjf0FUM1kRY--

--------------jUaAGbGpIYScoQIf0iA9PuiE--

--------------qx8XvgczXPmsLWXaiKapfNYd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSk9b4FAwAAAAAACgkQsN6d1ii/Ey/X
7Qf+M/+32XzDj9Apu0VN3QhMqmIhy/Uw6hFSDD5rdGqYcoMAhmBbCpPMbezmjz5iHooz/iVYL/X7
8r1Tyt4Nz9Qb3VtWb949ECOcWwpG0WqPa2EuJmWMqp7tO80IPSWBquT8AAirAMawPZDTrXDhW4df
10TSzf4tZDPa+NCvWAKNqWpYcHVJCMh+1BczMJK+4W3/LYyRj/swqhfSRBp625GXaTSwzfl7QRs1
8TGro4jGs6JGnl8mif/ngDY+eA5uuNOynhTm9UX4/mXuwitB8IvkrIXKepSXldq7p9S46aVW9a5t
R3Pkfi95pgC4gE+5ILUDFqyskSTqukOHZhDtUMMu+w==
=pI1I
-----END PGP SIGNATURE-----

--------------qx8XvgczXPmsLWXaiKapfNYd--
