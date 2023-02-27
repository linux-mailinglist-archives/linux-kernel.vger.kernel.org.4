Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165D6A3E39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjB0JWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjB0JVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:21:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD74F779
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:20:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC7B61F8D4;
        Mon, 27 Feb 2023 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677489637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBd7m2KrlfppU2Ipuygy+vwFieaF96NsR9iYEStx6LM=;
        b=KbwCjZgPz3lGGV7WD79xSpz5awt0k8vlLeZ030q7Xn7pjUsSYX0sIF6Y3a/nl2D8SJWWTR
        oYNkN6NfmEKrkgU1O5YJlBRCggwzxxOeqcDfmTy0JYf605MRVQtTWApKz0/GI1xiERXKIQ
        KogICrl3UScF1jYlC7sVipslJ24X4fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677489637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBd7m2KrlfppU2Ipuygy+vwFieaF96NsR9iYEStx6LM=;
        b=ns9P7o013CdySPfLHHMJHAiSPdCN6dMd00a5O13DdQB8h9Qgast+cyIWRU0vrpiZLNFUCj
        1BolIwKGtXdAsEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E11213912;
        Mon, 27 Feb 2023 09:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDLYHeV1/GMrUwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 27 Feb 2023 09:20:37 +0000
Message-ID: <c9805cb3-33c9-44ea-dab9-ec2f0624588f@suse.de>
Date:   Mon, 27 Feb 2023 10:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
References: <20230205125124.2260-1-lina@asahilina.net>
 <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
 <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
 <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
 <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
 <ad89998c-0ede-72da-b8e6-fe1de0f009f1@asahilina.net>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <ad89998c-0ede-72da-b8e6-fe1de0f009f1@asahilina.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mw61RmEhoZvT0AN7NkxZrjoq"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mw61RmEhoZvT0AN7NkxZrjoq
Content-Type: multipart/mixed; boundary="------------0sdaxXuSWHTgXHOP46gNDTuc";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Asahi Lina <lina@asahilina.net>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?=
 <noralf@tronnes.org>, linux-kernel@vger.kernel.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Message-ID: <c9805cb3-33c9-44ea-dab9-ec2f0624588f@suse.de>
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
References: <20230205125124.2260-1-lina@asahilina.net>
 <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
 <cc1c34c6-18d1-a8c5-bf70-078e7b7205f8@suse.de>
 <e49127fb-abb9-16fc-42bd-2f380d1bd29d@asahilina.net>
 <3d94a119-dc83-aede-fd39-df7a3ee7cdc0@suse.de>
 <ad89998c-0ede-72da-b8e6-fe1de0f009f1@asahilina.net>
In-Reply-To: <ad89998c-0ede-72da-b8e6-fe1de0f009f1@asahilina.net>

--------------0sdaxXuSWHTgXHOP46gNDTuc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjcuMDIuMjMgdW0gMTA6MDcgc2NocmllYiBBc2FoaSBMaW5hOg0KPiBPbiAy
Ny8wMi8yMDIzIDE3LjA0LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+IEhpDQo+Pg0K
Pj4gQW0gMjcuMDIuMjMgdW0gMDg6NTUgc2NocmllYiBBc2FoaSBMaW5hOg0KPj4+IE9uIDI3
LzAyLzIwMjMgMTYuNDUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4+PiBIaQ0KPj4+
Pg0KPj4+PiBBbSAyNS4wMi4yMyB1bSAyMjo1MSBzY2hyaWViIERtaXRyeSBPc2lwZW5rbzoN
Cj4+Pj4+IE9uIDIvNS8yMyAxNTo1MSwgQXNhaGkgTGluYSB3cm90ZToNCj4+Pj4+PiAtRVhQ
T1JUX1NZTUJPTF9HUEwoZHJtX2dlbV9zaG1lbV9nZXRfcGFnZXNfc2d0KTsNCj4+Pj4+PiAr
RVhQT1JUX1NZTUJPTChkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19zZ3QpOw0KPj4+Pj4NCj4+
Pj4+IE5vdGUgaXQgd2FzIGEgR1BMIHN5bWJvbC4gSSBleHBlY3QgdGhhdCBhbGwgZHJtLXNo
bWVtIGV4cG9ydHMgc2hvdWxkIGJlIEdQTC4NCj4+Pj4NCj4+Pj4gUmlnaHQuIEkgZGlkbid0
IG5vdGljZSB0aGF0IGNoYW5nZSwgYnV0IGl0J3MgcHJvYmFibHkgbm90IGFsbG93ZWQuIFRo
aXMNCj4+Pj4gbmVlZHMgdG8gYmUgcmV2ZXJ0ZWQgdG8gYSBHUEwgZXhwb3J0DQo+Pj4NCj4+
PiBJJ20gc29ycnksIHRoaXMgd2FzIG5vdCBpbnRlbnRpb25hbCEgSSB0aGluayBJIHJlbW92
ZWQgYW5kIHJlLWFkZGVkIHRoZQ0KPj4+IGV4cG9ydCBhcyBwYXJ0IG9mIG1ha2luZyB0aGUg
d3JhcHBlciBhbmQgZGlkbid0IG5vdGljZSBpdCB1c2VkIHRvIGJlIF9HUEwuLi4NCj4+Pg0K
Pj4+IERvIHlvdSB3YW50IG1lIHRvIHNlbmQgYSBwYXRjaCB0byBhZGQgaXQgYmFjaz8NCj4+
DQo+PiBZZXMsIHBsZWFzZSBkby4gVGhlIEZpeGVzIHRhZyBpcw0KPj4NCj4+ICAgICBGaXhl
czogZGRkZGVkYWEwZGI5ICgiZHJtL3NobWVtLWhlbHBlcjogRml4IGxvY2tpbmcgZm9yDQo+
PiBkcm1fZ2VtX3NobWVtX2dldF9wYWdlc19zZ3QoKSIpDQo+Pg0KPj4gVGhpcyBjb21taXQg
aXMgaW4gZHJtLW1pc2MtbmV4dC1maXhlcy4gQnV0IHRoZSBicmFuY2ggaXMgY2xvc2VkIGFs
cmVhZHkNCj4+IGFzIHdlJ3JlIGluIHRoZSBtaWRkbGUgb2YgdGhlIG1lcmdlIHdpbmRvdy4g
SSB0aGluayBpdCdzIGJlc3QgdG8gbWVyZ2UNCj4+IHRoZSBmaXggdGhyb3VnaCBkcm0tbWlz
Yy1maXhlcyBhZnRlciB0aGUgLXJjMSBocyBiZWVuIHRhZ2dlZC4NCj4gDQo+IFNlbnQhIEkg
YWxzbyBub3RpY2VkIHRoYXQgdGhlcmUgYXJlIHF1aXRlIGEgZmV3IG90aGVyIG5vbi1HUEwg
ZXhwb3J0cyBpbg0KPiB0aGUgZmlsZSwgd2l0aCBubyByZWFsIGxvZ2ljIHRoYXQgSSBjYW4g
c2VlLi4uIEknbSBndWVzc2luZyBtb3N0IG9mDQo+IHRob3NlIHdlcmVuJ3QgaW50ZW50aW9u
YWwgZWl0aGVyPw0KDQpJIGRvbid0IGtub3cuIE15IGd1ZXNzIGlzIHRoYXQgc29tZSBhdXRo
b3JzIHVzZWQgRVhQT1JUX1NZTUJPTCgpIG91dCBvZiANCmhhYml0IGFuZCBvdGhlcnMgdXNl
ZCBFWFBPUlRfU1lNQk9MX0dQTCgpIGludGVudGlvbmFsbHkuIEFuZCBub3csIGl0J3MgDQpj
aGFvdGljLg0KDQpFdmVuIHRoZSBmaWxlJ3MgaW5pdGlhbCBjb21taXQgMjE5NGE2M2E4MThk
IGNvbnRhaW5zIGJvdGguIEkgYXNzdW1lIHRoYXQgDQpzb21lIG9mIHRoZSBjb2RlIGhhcyBi
ZWVuIHRha2VuIGZyb20gdGhlIERNQSBoZWxwZXJzLCB3aGljaCBkYXRlIGJhY2sgDQptdWNo
IGVhcmxpZXIgd2l0aCBfR1BMLW9ubHkgZXhwb3J0cyAoc2VlIGNvbW1pdCBiOWQ0NzQ1MDA1
NDYpLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiB+fiBMaW5hDQoNCi0tIA0K
VGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOkZnRz
ZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------0sdaxXuSWHTgXHOP46gNDTuc--

--------------mw61RmEhoZvT0AN7NkxZrjoq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmP8deUFAwAAAAAACgkQlh/E3EQov+CF
3A/+KXeeYWnQVaA2xRldLu2bj5JUcD7ELnYIMBq3RuR8rqZ/+Yd0EVkZMsZX9l/uVt/TE2KblDHD
MdICA2LHUaRqjvqUnsKrxOMMe1rWPATEiTlaSOI0nMZXrsU9DI2WfqJfjMcVLaYcE9rhhROKfDSy
/8wfGcPqaWENLL9E9NArYJfTYWt6MPmpscCuGMzHefzO0eF5deHHW1b4pi+unyZKVBtlfZjuaiYH
h2w6dahnLIipum/fOLsNYcPou3HdkDj4T/GEPLDNbmEwuiGqUOOLbr8SsFGl4gEfn1BToDMtBYsD
OfGdNXRMVoPnR4aqkpOAhBLDEQ4qhYx12/OoMueTh0c4Z4vd6MFq2iUccJI13Vim/L6ax0cInczi
RkAl7hcF0rYfF4CrDUh2a5aeD0aNxfBYc7pny2HBPup6ITg3AUR7ddGdSWMS+5z9cyi0Mvu+YbFW
W0l1dWwT8DwX6YDMSlnDThN8pWt8c6uIVdKtbTR9piaLS75CIxG9eFe+bWAhfYy0Lh2BnU3Cbocq
8stB4KBaV7zgBP7iOp2PqtEJHn7jhWbpIP6bxCIBnSPhMGRkENha+ki4aHuWU6QJYsjkY5FvrHl3
hykgQ6Jq02qdZFYRGr25tHkwv5iFrDhs3P4BIb1ZWau3aqiKRu+xWZpJHi+ar5qKzmNlgFzo205B
k1g=
=CqzL
-----END PGP SIGNATURE-----

--------------mw61RmEhoZvT0AN7NkxZrjoq--
