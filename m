Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59223643791
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLEWAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLEWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:00:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B4388;
        Mon,  5 Dec 2022 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670277620; x=1701813620;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=26w5Qk0mw1pq4C2adTNF7rCV7moHaCoFedV/pTnaEpg=;
  b=Ce1eAKbDjfcEqHrwH/UkUMIjoLeyGlFR8DcOEtrACVOtrJwLkq0QGCNF
   spf7axlfAmHpKfW+iHjJGJy2FoaEgiUFBX9TmSmuuZC01uoDRweXwxaW7
   yHXjEG7LiGgYLoedzyTXdlFKbRL4/rspZAZ7Sa2PRM1V8TLflndbHkxix
   /7U3rJvK2pU1/JGtmnB7Op9iSXA9LiEmzJcVxD8EcwVN2da9wZSIGyODI
   BpqZ179q2MdC/1iy1vn7iNswW1E887WfFDsyY2syY32puoOYfbiXhGh8U
   SLc0oDkKRnbbXlYtOGK5gtkEPxuMFjQKXOm86VG3AZ0EzhDuVgWk3vJT+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317617585"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317617585"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 14:00:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="714562862"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="714562862"
Received: from han1-mobl4.jf.intel.com (HELO [10.54.74.10]) ([10.54.74.10])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 14:00:19 -0800
Message-ID: <576a57c3e8d9f7ad5bc28637ceac36d576309ca9.camel@linux.intel.com>
Subject: Re: [PATCH] Bluetooth: btintel: Fix missing free skb in
 btintel_setup_combined()
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 05 Dec 2022 14:00:18 -0800
In-Reply-To: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
References: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhb0JvLAoKT24gTW9uLCAyMDIyLTEyLTA1IGF0IDIxOjUzICswODAwLCBXYW5nIFNoYW9C
byB3cm90ZToKPiBza2IgYWxsb2NhdGVkIGJ5IF9faGNpX2NtZF9zeW5jIHdvdWxkIG5vdCBiZSB1
c2VkIHdoZXRoZXIgaW4gY2hlY2tpbmcKPiBmb3Igc3VwcG9ydGVkIGlCVCBoYXJkd2FyZSB2YXJp
YW50cyBvciBhZnRlciwgd2Ugc2hvdWxkIGZyZWUgaXQgaW4gYWxsCj4gZXJyb3IgYnJhbmNoZXMs
IHRoaXMgcGF0Y2ggbWFrZXMgdGhlIGNhc2UgcmVhZCB2ZXJzaW9uIGZhaWxlZCBvciBkZWZhdWx0
Cj4gZXJyb3IgY2FzZSBmcmVlIHNrYiBiZWZvcmUgcmV0dXJuLgo+IAo+IEZpeGVzOiBjODZjNzI4
NWJiMDggKCJCbHVldG9vdGg6IGJ0aW50ZWw6IEZpeCB0aGUgbGVnYWN5IGJvb3Rsb2FkZXIgcmV0
dXJucyB0bHYgYmFzZWQgdmVyc2lvbiIpCj4gRml4ZXM6IDAxOWExY2FhN2ZkMiAoIkJsdWV0b290
aDogYnRpbnRlbDogUmVmYWN0b3Jpbmcgc2V0dXAgcm91dGluZSBmb3IgYm9vdGxvYWRlciBkZXZp
Y2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFNoYW9CbyA8Ym9iby5zaGFvYm93YW5nQGh1YXdl
aS5jb20+CgpSZXZpZXdlZC1ieTogVGVkZCBIby1KZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+
Cgo+IC0tLQo+IMKgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIHwgNSArKystLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jCj4gaW5kZXggYTY1N2U5YTNlOTZhLi5mNmI0YjdhMWJlNGMgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRp
bnRlbC5jCj4gQEAgLTI1MjQsNyArMjUyNCw3IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9zZXR1cF9j
b21iaW5lZChzdHJ1Y3QgaGNpX2RldiAqaGRldikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gYnRpbnRl
bF9yZWFkX3ZlcnNpb24oaGRldiwgJnZlcik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoZXJyKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIGVycjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
KiBBcHBseSB0aGUgZGV2aWNlIHNwZWNpZmljIEhDSSBxdWlya3MKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqCj4gQEAgLTI1NjYsNyArMjU2Niw4IEBAIHN0YXRpYyBpbnQgYnRp
bnRlbF9zZXR1cF9jb21iaW5lZChzdHJ1Y3QgaGNpX2RldiAqaGRldikKPiDCoMKgwqDCoMKgwqDC
oMKgZGVmYXVsdDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ0X2Rldl9lcnIo
aGRldiwgIlVuc3VwcG9ydGVkIEludGVsIGh3IHZhcmlhbnQgKCV1KSIsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTlRFTF9IV19WQVJJQU5U
KHZlcl90bHYuY252aV9idCkpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gLUVJTlZB
TDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoAo+IMKgZXhpdF9lcnJvcjoKClJlZ2FyZHMsClRlZGQgSG8tSmVvbmcgQW4K

