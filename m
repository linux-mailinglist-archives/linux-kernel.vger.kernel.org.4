Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEFF7127D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbjEZN5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:57:29 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1DDF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685109447; x=1716645447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oBqZOBHuiqIEWF5UrD9YR5/Y0jvlkS5A+MMqZPCEAqs=;
  b=MvRFh8/EV9b2cbpToHaeXoH7jYwrhCnEsPCrJIa8rsAt/gl7sO7QJkQR
   bLXsYNKasNT+c3cBMBENHBIyz7oLk9YGQbhPVmZNigj03ROZYjGWtSF3l
   S7v+3iCMuMhRevJDCTdxbNwaqg59ittOX/13LkJ9GDqFqYnYWFVPBAzNs
   U=;
X-IronPort-AV: E=Sophos;i="6.00,194,1681171200"; 
   d="scan'208";a="333831818"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 13:57:22 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 845CE8064D;
        Fri, 26 May 2023 13:57:20 +0000 (UTC)
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:57:20 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:57:19 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Fri, 26 May 2023 13:57:18 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jason.zeng@intel.com" <jason.zeng@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lei.l.li@intel.com" <lei.l.li@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuleixzhang@tencent.com" <yuleixzhang@tencent.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
Thread-Topic: [RFC v3 00/21] Preserved-over-Kexec RAM
Thread-Index: AQHZfMp2lJg8EKfTcU+6dylzOaNCcq9sul0A
Date:   Fri, 26 May 2023 13:57:18 +0000
Message-ID: <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.223]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1652FBAFA9EDC04894CB1A78E19DF4F0@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTI2IGF0IDE3OjA4IC0wNzAwLCBBbnRob255IFl6bmFnYSB3cm90ZToN
Cj4gU2VuZGluZyBvdXQgdGhpcyBSRkMgaW4gcGFydCB0byBndWFnZSBjb21tdW5pdHkgaW50ZXJl
c3QuDQo+IFRoaXMgcGF0Y2hzZXQgaW1wbGVtZW50cyBwcmVzZXJ2ZWQtb3Zlci1rZXhlYyBtZW1v
cnkgc3RvcmFnZSBvciBQS1JBTSBhcyBhDQo+IG1ldGhvZCBmb3Igc2F2aW5nIG1lbW9yeSBwYWdl
cyBvZiB0aGUgY3VycmVudGx5IGV4ZWN1dGluZyBrZXJuZWwgc28gdGhhdA0KPiB0aGV5IG1heSBi
ZSByZXN0b3JlZCBhZnRlciBrZXhlYyBpbnRvIGEgbmV3IGtlcm5lbC4gVGhlIHBhdGNoZXMgYXJl
IGFkYXB0ZWQNCj4gZnJvbSBhbiBSRkMgcGF0Y2hzZXQgc2VudCBvdXQgaW4gMjAxMyBieSBWbGFk
aW1pciBEYXZ5ZG92IFsxXS4gVGhleQ0KPiBpbnRyb2R1Y2UgdGhlIFBLUkFNIGtlcm5lbCBBUEku
DQo+IA0KPiBPbmUgdXNlIGNhc2UgZm9yIFBLUkFNIGlzIHByZXNlcnZpbmcgZ3Vlc3QgbWVtb3J5
IGFuZC9vciBhdXhpbGxhcnkNCj4gc3VwcG9ydGluZyBkYXRhIChlLmcuIGlvbW11IGRhdGEpIGFj
cm9zcyBrZXhlYyB0byBzdXBwb3J0IHJlYm9vdCBvZiB0aGUNCj4gaG9zdCB3aXRoIG1pbmltYWwg
ZGlzcnVwdGlvbiB0byB0aGUgZ3Vlc3QuDQoNCkhpIEFudGhvbnksDQoNClRoYW5rcyBmb3IgcmUt
cG9zdGluZyB0aGlzIC0gSSdtIGJlZW4gd2FudGluZyB0byByZS1raW5kbGUgdGhlIGRpc2N1c3Np
b24NCm9uIHByZXNlcnZpbmcgbWVtb3J5IGFjcm9zcyBrZXhlYyBmb3IgYSB3aGlsZSBub3cuDQoN
ClRoZXJlIGFyZSBhIGZldyBhc3BlY3RzIGF0IHBsYXkgaW4gdGhpcyBzcGFjZSBvZiBtZW1vcnkg
bWFuYWdlbWVudA0KZGVzaWduZWQgc3BlY2lmaWNhbGx5IGZvciB0aGUgdmlydHVhbGlzYXRpb24g
YW5kIGxpdmUgdXBkYXRlIChrZXhlYykgdXNlLQ0KY2FzZSB3aGljaCBJIHRoaW5rIHdlIHNob3Vs
ZCBjb25zaWRlcjoNCg0KMS4gUHJlc2VydmluZyB1c2Vyc3BhY2UtYWNjZXNzaWJsZSBtZW1vcnkg
YWNyb3NzIGtleGVjOiB0aGlzIGlzIHdoYXQgcGtyYW0NCmFkZHJlc3Nlcy4NCg0KMi4gUHJlc2Vy
dmluZyBrZXJuZWwgc3RhdGU6IFRoaXMgd291bGQgaW5jbHVkZSBtZW1vcnkgcmVxdWlyZWQgZm9y
IGtleGVjDQp3aXRoIERNQSBwYXNzdGhyb3VnaCBkZXZpY2VzLCBsaWtlIElPTU1VIHJvb3QgcGFn
ZSBhbmQgcGFnZSB0YWJsZXMsIERNQS0NCmFibGUgYnVmZmVycyBmb3IgZHJpdmVycywgZXRjLiBB
bHNvIGNlcnRhaW4gc3RydWN0dXJlcyBmb3IgaW1wcm92ZWQga2VybmVsDQpib290IHBlcmZvcm1h
bmNlIGFmdGVyIGtleGVjLCBsaWtlIGEgUENJIGRldmljZSBjYWNoZSwgY2xvY2sgTFBKIGFuZA0K
cG9zc2libGUgb3RoZXJzLCBzb3J0IG9mIHdoYXQgWGVuIGJyZWFkY3J1bWJzIFswXSBhY2hpZXZl
cy4gVGhlIHBrcmFtIFJGQw0KaW5kaWNhdGVzIHRoYXQgdGhpcyBzaG91bGQgYmUgcG9zc2libGUs
IHRob3VnaCBJTU8gdGhpcyBjb3VsZCBiZSBtb3JlDQpzdHJhaWdodCBmb3J3YXJkIHRvIGRvIHdp
dGggYSBuZXcgZmlsZXN5c3RlbSB3aXRoIGZpcnN0LWNsYXNzIHN1cHBvcnQgZm9yDQprZXJuZWwg
cGVyc2lzdGVuY2UgdmlhIHNvbWV0aGluZyBsaWtlIGlub2RlIHR5cGVzIGZvciBrZXJuZWwgZGF0
YS4NCg0KMy4gRW5zdXJpbmcgaHVnZS9naWdhbnRpYyBtZW1vcnkgYWxsb2NhdGlvbnM6IHRvIGlt
cHJvdmUgdGhlIFRMQiBwZXJmIG9mDQoyLXN0YWdlIHRyYW5zbGF0aW9ucyBpdCdzIGJlbmVmaWNp
YWwgdG8gYWxsb2NhdGUgZ3Vlc3QgbWVtb3J5IGluIGxhcmdlDQpjb250aWd1b3VzIGJsb2Nrcywg
cHJlZmVyYWJseSBQVUQtbGV2ZWwgYmxvY2tzIGZvciBtdWx0aS1HaUIgZ3Vlc3RzLiBJZg0KdGhl
IGJ1ZGR5IGFsbG9jYXRvciBpcyB1c2VkIHRoaXMgbWF5IGJlIGEgY2hhbGxlbmdlIGJvdGggZnJv
bSBhbg0KaW1wbGVtZW50YXRpb24gYW5kIGEgZnJhZ21lbnRhdGlvbiBwZXJzcGVjdGl2ZSwgYW5k
IGl0IG1heSBiZSBkZXNpcmFibGUgdG8NCmhhdmUgc3Ryb25nZXIgZ3VhcmFudGVlcyBhYm91dCBh
bGxvY2F0aW9uIHNpemVzLg0KDQo0LiBSZW1vdmluZyBzdHJ1Y3QgcGFnZSBvdmVyaGVhZDogV2hl
biBkb2luZyB0aGUgaHVnZS9naWdhbnRpYw0KYWxsb2NhdGlvbnMsIGluIGdlbmVyYWxseSBpdCB3
b24ndCBiZSBuZWNlc3NhcnkgdG8gaGF2ZSA0IEtpQiBzdHJ1Y3QNCnBhZ2VzLiBUaGlzIGlzIHNv
bWV0aGluZyB3aXRoIGRtZW1mcyBbMSwgMl0gdHJpZXMgdG8gYWNoaWV2ZSBieSB1c2luZyBhDQps
YXJnZSBjaHVuayBvZiByZXNlcnZlZCBtZW1vcnkgYW5kIG1hbmFnaW5nIHRoYXQgYnkgYSBuZXcg
ZmlsZXN5c3RlbS4NCg0KNS4gTW9yZSAiYWR2YW5jZWQiIG1lbW9yeSBtYW5hZ2VtZW50IEFQSXMv
aW9jdGxzIGZvciB2aXJ0dWFsaXNhdGlvbjogQmVpbmcNCmFibGUgdG8gc3VwcG9ydCB0aGluZ3Mg
bGlrZSBETUEtZHJpdmVuIHBvc3QtY29weSBsaXZlIG1pZ3JhdGlvbiwgbWVtb3J5DQpvdmVyc3Vi
c2NyaXB0aW9uLCBjYXJ2aW5nIG91dCBjaHVua3Mgb2YgbWVtb3J5IGZyb20gYSBWTSB0byBsYXVu
Y2ggc2lkZS0NCmNhciBWTXMsIG1vcmUgZmluZS1ncmFpbiBjb250cm9sIG9mIElPTU1VIG9yIE1N
VSBwZXJtaXNzaW9ucywgZXRjLiBUaGlzDQptYXkgYmUgZWFzaWVyIHRvIGFjaGlldmUgd2l0aCBh
IG5ldyBmaWxlc3lzdGVtLCByYXRoZXIgdGhhbiBjb3VwbGluZyB0bw0KdGVtcGZzIHNlbWFudGlj
cyBhbmQgaW9jdGxzLg0KDQpPdmVyYWxsLCB3aXRoIHRoZSBhYm92ZSBpbiBtaW5kLCBteSB0YWtl
IGlzIHRoYXQgd2UgbWF5IGhhdmUgYSBzbW9vdGhlcg0KcGF0aCB0byBpbXBsZW1lbnQgYSBtb3Jl
IGNvbXByZWhlbnNpdmUgc29sdXRpb24gYnkgZ29pbmcgdGhlIHJvdXRlIG9mIGENCm5ldyBwdXJw
b3NlLWJ1aWx0IGZpbGUgc3lzdGVtIG9uIHRvcCBvZiByZXNlcnZlZCBtZW1vcnkuIFNvcnQgb2Yg
bGlrZQ0KZG1lbWZzIHdpdGggcGVyc2lzdGVuY2UgYW5kIHNwZWNpZmljYWxseSBzdXBwb3J0IGZv
ciBrZXJuZWwgcGVyc2lzdGVuY2UuDQoNCkRvZXMgbXkgdGFrZSBoZXJlIG1ha2Ugc2Vuc2U/DQoN
CkknbSBob3BpbmcgdG8gcHV0IHRvZ2V0aGVyIGFuIFJGQyBmb3Igc29tZXRoaW5nIGxpa2UgdGhl
IGFib3ZlIChkbWVtZnMNCndpdGggcGVyc2lzdGVuY2UpIHNvb24sIGZvY3VzaW5nIG9uIGhvdyB0
aGUgSU9NTVUgcGVyc2lzdGVuY2Ugd2lsbCB3b3JrLg0KVGhpcyBpcyBhbiBpbXBvcnRhbnQgZGlm
ZmVyZW50aWF0aW5nIGZhY3RvciB0byBjb3ZlciBpbiB0aGUgUkZDLCBJTU8uDQoNCj4gUEtSQU0g
cHJvdmlkZXMgYSBmbGV4aWJsZSB3YXkNCj4gZm9yIGRvaW5nIHRoaXMgd2l0aG91dCByZXF1aXJp
bmcgdGhhdCB0aGUgYW1vdW50IG9mIG1lbW9yeSB1c2VkIGJ5IGEgZml4ZWQNCj4gc2l6ZSBjcmVh
dGVkIGEgcHJpb3IuDQoNCkFGQUlDVCB0aGUgbWFpbiBkb3duLXNpZGUgb2Ygd2hhdCBJJ20gc3Vn
Z2VzdGluZyBoZXJlIGNvbXBhcmVkIHRvIHBrcmFtLA0KaXMgdGhhdCBhcyB5b3Ugc2F5IGhlcmU6
IHBrcmFtIGRvZXNuJ3QgcmVxdWlyZSB0aGUgdXAtZnJvbnQgcmVzZXJ2aW5nIG9mDQptZW1vcnkg
LSBhbGxvY2F0aW9ucyBmcm9tIHRoZSBnbG9iYWwgc2hhcmVkIHBvb2wgYXJlIGR5bmFtaWMuIEkn
bSBvbiB0aGUNCmZlbmNlIGFzIHRvIHdoZXRoZXIgdGhpcyBpcyBhY3R1YWxseSBhIGRlc2lyYWJs
ZSBwcm9wZXJ0eSB0aG91Z2guIENhcnZpbmcNCm91dCBhIGxhcmdlIGNodW5rIG9mIHN5c3RlbSBt
ZW1vcnkgYXMgcmVzZXJ2ZWQgbWVtb3J5IGZvciBhIHBlcnNpc3RlZA0KZmlsZXN5c3RlbSAoYXMg
SSdtIHN1Z2dlc3RpbmcpIGhhcyB0aGUgYWR2YW50YWdlcyBvZiByZW1vdmluZyBzdHJ1Y3QgcGFn
ZQ0Kb3ZlcmhlYWQsIHByb3ZpZGluZyBiZXR0ZXIgZ3VhcmFudGVlcyBhYm91dCBodWdlL2dpZ2Fu
dGljIHBhZ2UNCmFsbG9jYXRpb25zLCBhbmQgcHJvYmFibHkgbWFrZXMgdGhlIGtleGVjIHJlc3Rv
cmUgcGF0aCBzaW1wbGVyIGFuZCBtb3JlDQpzZWxmIGNvbnRhaW5lZC4NCg0KSSB0aGluayB0aGVy
ZSdzIGFuIGFyZ3VtZW50IHRvIGJlIG1hZGUgdGhhdCBoYXZpbmcgYSBjbGVhcmx5LWRlZmluZWQg
bGFyZ2UNCnJhbmdlIG9mIG1lbW9yeSB3aGljaCBpcyBwZXJzaXN0ZWQsIGFuZCB0aGUgcmVzdCBp
cyBub3JtYWwgImVwaGVtZXJhbCINCmtlcm5lbCBtZW1vcnkgbWF5IGJlIHByZWZlcmFibGUuDQoN
CktlZW4gdG8gaGVhciB5b3VyIChhbmQgb3RoZXJzKSB0aG91Z2h0cyENCg0KSkcNCg0KWzBdIGh0
dHA6Ly9kYXZpZC53b29kaG91LnNlL2xpdmUtdXBkYXRlLWhhbmRvdmVyLnBkZg0KWzFdIGh0dHBz
Oi8vbHduLm5ldC9BcnRpY2xlcy84MzkyMTYvDQpbMl0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MjAvMTIvNy8zNDINCg==
