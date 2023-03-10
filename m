Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE56B32EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCJAvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCJAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:51:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242BF98DF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678409505; x=1709945505;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IAX0pKv08V96FMycHCETaHqY8v/n951tko15wnXyZdI=;
  b=fyHtig60ZcMxv9qkEscix9qITSsSnEYiqTzRd7gVeoRu98dcji2jIeVZ
   ocYuGQfaRVViQOL4/v/0pr2lPqKBzFgErHFN1Z+Qsvpz/cHanECIVLgb+
   8EuvHz8XyzhV0pmksf7HtzwfXBi1QPadJzsA0ZdV9SS1Ltkbfj0sr+byA
   3MQSyZy9JhJqCvjPWw6jYfVyNzKyjSx4LTULCeu/npSVKatVVissRtm+U
   +lmOPR0Sfbai3hBZ7c9BLbS6mtF5uLewf5EYj2vLsjIqlV1pNHlJrjWcZ
   842y/7D2yv+hWTGYFSPYyObDC7h1tjKhrRB7+F4cBRrMMe6t2KtvyUTka
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401472285"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="401472285"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 16:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="766641778"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="766641778"
Received: from sbtolent-mobl5.amr.corp.intel.com (HELO [10.213.181.108]) ([10.213.181.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 16:51:36 -0800
Message-ID: <9f3688d2d44ae766069487858bd28b5d49c19575.camel@linux.intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Date:   Thu, 09 Mar 2023 16:51:35 -0800
In-Reply-To: <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
         <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTA2IGF0IDIwOjU4IC0wODAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6Cj4g
VXNpbmcgYXN5bV9wYWNraW5nIHByaW9yaXRpZXMgd2l0aGluIGFuIFNNVCBjb3JlIGlzIHN0cmFp
Z2h0Zm9yd2FyZC4KPiBKdXN0Cj4gZm9sbG93IHRoZSBwcmlvcml0aWVzIHRoYXQgaGFyZHdhcmUg
aW5kaWNhdGVzLgo+IAo+IFdoZW4gYmFsYW5jaW5nIGxvYWQgZnJvbSBhbiBTTVQgY29yZSwgYWxz
byBjb25zaWRlciB0aGUgaWRsZSBvZiBpdHMKPiBzaWJsaW5ncy4gUHJpb3JpdGllcyBkbyBub3Qg
cmVmbGVjdCB0aGF0IGFuIFNNVCBjb3JlIGRpdmlkZXMgaXRzCj4gdGhyb3VnaHB1dAo+IGFtb25n
IGFsbCBpdHMgYnVzeSBzaWJsaW5ncy4gVGhleSBvbmx5IG1ha2VzIHNlbnNlIHdoZW4gZXhhY3Rs
eSBvbmUKPiBzaWJsaW5nCj4gaXMgYnVzeS4KPiAKPiBJbmRpY2F0ZSB0aGF0IGFjdGl2ZSBiYWxh
bmNlIGlzIG5lZWRlZCBpZiB0aGUgZGVzdGluYXRpb24gQ1BVIGhhcwo+IGxvd2VyCj4gcHJpb3Jp
dHkgdGhhbiB0aGUgc291cmNlIENQVSBidXQgdGhlIGxhdHRlciBoYXMgYnVzeSBTTVQgc2libGlu
Z3MuCj4gCj4gTWFrZSBmaW5kX2J1c2llc3RfcXVldWUoKSBub3Qgc2tpcCBoaWdoZXItcHJpb3Jp
dHkgU01UIGNvcmVzIHdpdGgKPiBtb3JlIHRoYW4KPiBidXN5IHNpYmxpbmcuCj4gCj4gQ2M6IEJl
biBTZWdhbGwgPGJzZWdhbGxAZ29vZ2xlLmNvbT4KPiBDYzogRGFuaWVsIEJyaXN0b3QgZGUgT2xp
dmVpcmEgPGJyaXN0b3RAcmVkaGF0LmNvbT4KPiBDYzogRGlldG1hciBFZ2dlbWFubiA8ZGlldG1h
ci5lZ2dlbWFubkBhcm0uY29tPgo+IENjOiBMZW4gQnJvd24gPGxlbi5icm93bkBpbnRlbC5jb20+
Cj4gQ2M6IE1lbCBHb3JtYW4gPG1nb3JtYW5Ac3VzZS5kZT4KPiBDYzogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgo+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRh
IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KPiBDYzogU3RldmVuIFJvc3Rl
ZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+Cj4gQ2M6IFRpbSBDLiBDaGVuIDx0aW0uYy5jaGVuQGlu
dGVsLmNvbT4KPiBDYzogVmFsZW50aW4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPgo+
IENjOiB4ODZAa2VybmVsLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g
U3VnZ2VzdGVkLWJ5OiBWYWxlbnRpbiBTY2huZWlkZXIgPHZzY2huZWlkQHJlZGhhdC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmktY2FsZGVyb25AbGludXgu
aW50ZWwuY29tPgo+IC0tLQo+IENoYW5nZXMgc2luY2UgdjI6Cj4gwqAqIEludHJvZHVjZWQgdGhp
cyBwYXRjaC4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYxOgo+IMKgKiBOL0EKPiAtLS0KPiDCoGtlcm5l
bC9zY2hlZC9mYWlyLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMKPiBpbmRl
eCA4MGM4NjQ2MmM2ZjYuLmM5ZDBkZGZkMTFmMiAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvc2NoZWQv
ZmFpci5jCj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYwo+IEBAIC0xMDQzNiwxMSArMTA0MzYs
MjAgQEAgc3RhdGljIHN0cnVjdCBycSAqZmluZF9idXNpZXN0X3F1ZXVlKHN0cnVjdAo+IGxiX2Vu
diAqZW52LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5yX3J1bm5p
bmcgPT0gMSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb250aW51ZTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBNYWtl
IHN1cmUgd2Ugb25seSBwdWxsIHRhc2tzIGZyb20gYSBDUFUgb2YgbG93ZXIKPiBwcmlvcml0eSAq
Lwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBNYWtlIHN1cmUgd2Ugb25seSBwdWxsIHRhc2tzIGZyb20gYSBDUFUg
b2YgbG93ZXIKPiBwcmlvcml0eQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB3
aGVuIGJhbGFuY2luZyBiZXR3ZWVuIFNNVCBzaWJsaW5ncy4KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSWYgYmFs
YW5jaW5nIGJldHdlZW4gY29yZXMsIGxldCBsb3dlciBwcmlvcml0eQo+IENQVXMgaGVscAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBTTVQgY29yZXMgd2l0aCBtb3JlIHRoYW4g
b25lIGJ1c3kgc2libGluZy4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKGVudi0+c2QtPmZsYWdzICYgU0Rf
QVNZTV9QQUNLSU5HKSAmJgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNjaGVkX2FzeW1fcHJlZmVyKGksIGVudi0+ZHN0X2NwdSkgJiYKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5yX3J1bm5pbmcgPT0gMSkKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnJfcnVubmluZyA9PSAxKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZW52LT5zZC0+ZmxhZ3MgJiBT
RF9TSEFSRV9DUFVDQVBBQ0lUWSB8fAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICghKGVudi0+c2QtPmZsYWdzICYgU0RfU0hBUkVfQ1BVQ0FQ
QUNJVFkpCj4gJiYgaXNfY29yZV9pZGxlKGkpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzd2l0Y2ggKGVudi0+bWlncmF0aW9uX3R5cGUpIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNhc2UgbWlncmF0ZV9sb2FkOgo+IEBAIC0xMDUzMCw4ICsxMDUzOSwy
MCBAQCBhc3ltX2FjdGl2ZV9iYWxhbmNlKHN0cnVjdCBsYl9lbnYgKmVudikKPiDCoMKgwqDCoMKg
wqDCoMKgICogbG93ZXIgcHJpb3JpdHkgQ1BVcyBpbiBvcmRlciB0byBwYWNrIGFsbCB0YXNrcyBp
biB0aGUKPiDCoMKgwqDCoMKgwqDCoMKgICogaGlnaGVzdCBwcmlvcml0eSBDUFVzLgo+IMKgwqDC
oMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gZW52LT5pZGxlICE9IENQVV9O
T1RfSURMRSAmJiAoZW52LT5zZC0+ZmxhZ3MgJgo+IFNEX0FTWU1fUEFDS0lORykgJiYKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRfYXN5bV9wcmVmZXIoZW52LT5kc3RfY3B1LCBl
bnYtPnNyY19jcHUpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChlbnYtPmlkbGUgIT0gQ1BVX05PVF9J
RExFICYmIChlbnYtPnNkLT5mbGFncyAmCj4gU0RfQVNZTV9QQUNLSU5HKSkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBBbHdheXMgb2JleSBwcmlvcml0aWVzIGJldHdlZW4g
U01UIHNpYmxpbmdzLiAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZW52
LT5zZC0+ZmxhZ3MgJiBTRF9TSEFSRV9DUFVDQVBBQ0lUWSkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzY2hlZF9hc3ltX3ByZWZlcihlbnYt
PmRzdF9jcHUsIGVudi0KPiA+c3JjX2NwdSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBBIGxvd2VyIHBy
aW9yaXR5IENQVSBjYW4gaGVscCBhbiBTTVQgY29yZSB3aXRoCj4gbW9yZSB0aGFuIG9uZQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBidXN5IHNpYmxpbmcuCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gc2NoZWRfYXN5bV9wcmVmZXIoZW52LT5kc3RfY3B1LCBlbnYtPnNyY19jcHUpCj4g
fHwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICFpc19jb3Jl
X2lkbGUoZW52LT5zcmNfY3B1KTsKPiArwqDCoMKgwqDCoMKgwqB9CgpTdXBwb3NlIHdlIGhhdmUg
dGhlIEF0b20gY29yZXMgaW4gYSBzY2hlZCBncm91cCAoZS5nLiBhIGNsdXN0ZXIpLAp0aGlzIHdp
bGwgcHVsbCB0aGUgdGFza3MgZnJvbSB0aG9zZSBjb3JlIHRvIGEgU01UIHRocmVhZCBldmVuIGlm
Cml0cyBzaWJsaW5nIHRocmVhZCBpcyBidXN5LiAgU3VnZ2VzdCB0aGlzIGNoYW5nZQoKZGlmZiAt
LWdpdCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jCmluZGV4IGRh
MWFmYTk5Y2Q1NS4uYjY3MWNiMGQ3YWIzIDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5j
CisrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMKQEAgLTEwNDczLDkgKzEwNDczLDExIEBAIGFzeW1f
YWN0aXZlX2JhbGFuY2Uoc3RydWN0IGxiX2VudiAqZW52KQogICAgICAgICAgICAgICAgLyoKICAg
ICAgICAgICAgICAgICAqIEEgbG93ZXIgcHJpb3JpdHkgQ1BVIGNhbiBoZWxwIGFuIFNNVCBjb3Jl
IHdpdGggbW9yZSB0aGFuIG9uZQogICAgICAgICAgICAgICAgICogYnVzeSBzaWJsaW5nLgorICAg
ICAgICAgICAgICAgICogUHVsbCBvbmx5IGlmIG5vIFNNVCBzaWJsaW5nIGJ1c3kuCiAgICAgICAg
ICAgICAgICAgKi8KLSAgICAgICAgICAgICAgIHJldHVybiBzY2hlZF9hc3ltX3ByZWZlcihlbnYt
PmRzdF9jcHUsIGVudi0+c3JjX2NwdSkgfHwKLSAgICAgICAgICAgICAgICAgICAgICAhaXNfY29y
ZV9pZGxlKGVudi0+c3JjX2NwdSk7CisgICAgICAgICAgICAgICBpZiAoaXNfY29yZV9pZGxlKGVu
di0+ZHN0X2NwdSkpCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBzY2hlZF9hc3ltX3By
ZWZlcihlbnYtPmRzdF9jcHUsIGVudi0+c3JjX2NwdSkgfHwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICFpc19jb3JlX2lkbGUoZW52LT5zcmNfY3B1KTsKICAgICAgICB9CgoKVGltCgo+
ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gZmFsc2U7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBp
bmxpbmUgYm9vbAoK

