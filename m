Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106BC6D45F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjDCNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:39:32 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4310AA7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1680529169; x=1712065169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MFp0NBlRTSPl9yMe4HnP5/qIEhWqx7j0K1JhJq5qvzg=;
  b=A2ifxcFfg9kVggCoGc4tPUBgo4XcAZ5IHxZ+cX5adHo5soNEiDOeTCj4
   R8771MNxCui45bXaC9aXy593cXaAZhKhagw0Cee1l+hoJx695J8iREVMB
   c4ez1B0b5kzOOoOcfowfUeDo5GzUjTLbKK0IfeFBi8VDZtrSGxvrR5Cmw
   k=;
X-IronPort-AV: E=Sophos;i="5.98,314,1673913600"; 
   d="scan'208";a="200376828"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:39:26 +0000
Received: from EX19D001EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id A713F40D7C;
        Mon,  3 Apr 2023 13:39:25 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D001EUB004.ant.amazon.com (10.252.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Apr 2023 13:39:24 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Mon, 3 Apr 2023 13:39:24 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "chris.zjh@huawei.com" <chris.zjh@huawei.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Topic: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Thread-Index: AQHZZjGz4tFdaT8/uEu93/6Orjmm0g==
Date:   Mon, 3 Apr 2023 13:39:24 +0000
Message-ID: <a2a5a6274dce7a68c657f6a9c2b0c22e23d91950.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
         <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
         <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
         <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
         <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
         <871qlh9imb.ffs@tglx> <1a974f41-83ec-9c7f-ddf1-cb093ae95046@huawei.com>
         <546fbd173aec3b7fc07d253393920bf5@kernel.org>
In-Reply-To: <546fbd173aec3b7fc07d253393920bf5@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B09BBEA74EA3DB4591059BAA505C0D1A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDE0OjE5ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE5laXRoZXIgc29sdXRpb25zIGFyZSByZW1vdGVseSBhY2NlcHRhYmxlLg0KPiBJJ2xsIGxvb2sg
YXQgc29tZXRoaW5nIGEgYml0IG1vcmUgcGFsYXRhYmxlLg0KDQpUaGFua3MgTWFyYywgdGhhdCB3
aWxsIGJlIG11Y2ggYXBwcmVjaWF0ZWQuDQoNCk91dCBvZiBpbnRlcmVzdCB0aG91Z2gsIHdoeSBp
cyB0aGUgc3VnZ2VzdGlvbiB0byBtYXJrIHRoZSBpcnFfZGVzYyBhcyBwZW5kaW5nDQphbmQgcmUt
cnVuIHRoZSBoYW5kbGVyIG5vdCBhY2NlcHRhYmxlPw0KDQpKRw0K
