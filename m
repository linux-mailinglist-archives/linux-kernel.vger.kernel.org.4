Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310A732F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbjFPKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbjFPKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:51:36 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24735BAD;
        Fri, 16 Jun 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1686912213; x=1718448213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=EiIlqK6AXKLA69qAfZC6rroRe+Mvb9mJJnlfOXkWQXg=;
  b=PHL4boeud1axHcDmuSrxVAsJlEOYPkDr6ICJw65QnTznQyro/wbXNxR4
   vPVgdZQHVQ1y4qr9TJJ9ULAiTJLD3gw16+fPZWrnwMHSBOPpekALj81fO
   E87D1dCaCJK/kHGpLVESbwJA/dYt2kGnbJBcoWmkrE/fs8DB1aWVN6ydT
   I=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681171200"; 
   d="scan'208";a="1137920555"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 10:42:47 +0000
Received: from EX19D003EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 6909760A0C;
        Fri, 16 Jun 2023 10:42:46 +0000 (UTC)
Received: from EX19D039EUC002.ant.amazon.com (10.252.61.208) by
 EX19D003EUA003.ant.amazon.com (10.252.50.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 10:42:44 +0000
Received: from EX19D039EUC004.ant.amazon.com (10.252.61.190) by
 EX19D039EUC002.ant.amazon.com (10.252.61.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 10:42:44 +0000
Received: from EX19D039EUC004.ant.amazon.com ([fe80::5319:6fc9:8bde:8a4]) by
 EX19D039EUC004.ant.amazon.com ([fe80::5319:6fc9:8bde:8a4%3]) with mapi id
 15.02.1118.026; Fri, 16 Jun 2023 10:42:44 +0000
From:   "Adam, Mahmoud" <mngyadam@amazon.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Mahmoud Adam <mngyadam@amazon.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: use kfree_sensitive with key
Thread-Topic: [PATCH v2] KEYS: use kfree_sensitive with key
Thread-Index: AQHZn4kY7Cu4TjVLJ0uBGHvJEhKlOa+NPD2AgAADNIA=
Date:   Fri, 16 Jun 2023 10:42:44 +0000
Message-ID: <09E6D7DF-8A97-4E18-BA22-CFEAC430996D@amazon.de>
References: <20230615125712.105873-1-mngyadam@amazon.com>
 <ZIw56UTG3fPtp/DM@gondor.apana.org.au>
In-Reply-To: <ZIw56UTG3fPtp/DM@gondor.apana.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.23]
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CC761A41CE68429138F3685EB80CAB@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTYuIEp1biAyMDIzLCBhdCAxMjozMSwgSGVyYmVydCBYdSA8aGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1PiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDE1LCAyMDIzIGF0IDEy
OjU3OjEzUE0gKzAwMDAsIE1haG1vdWQgQWRhbSB3cm90ZToNCj4+IGtleSBtaWdodCBjb250YWlu
IHByaXZhdGUgcGFydCBvZiB0aGUga2V5LCBzbyBiZXR0ZXIgdXNlDQo+PiBrZnJlZV9zZW5zaXRp
dmUgdG8gZnJlZSBpdA0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBNYWhtb3VkIEFkYW0gPG1uZ3lh
ZGFtQGFtYXpvbi5jb20+DQo+PiAtLS0NCj4+IHYyOiBrZnJlZV9zZW5zaXRpdmUgb25seSBwcml2
YXRlIGtleQ0KPj4gDQo+PiBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3B1YmxpY19rZXkuYyB8IDEx
ICsrKysrKystLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiANCj4gU29ycnksIEkgd2FzIGNvbmZ1c2VkIGJ5IHRoZSBuYW1pbmcgaW4gdGhp
cyBmaWxlLiAgVGhlc2UgcHVibGljX2tleXMNCj4gY2FuIGluZGVlZCBiZSBwcml2YXRlLiAgU28g
SSdsbCBqdXN0IHRha2UgeW91ciBvcmlnaW5hbCBwYXRjaC4NCg0KSXTigJlzIGluZGVlZCB2ZXJ5
IGNvbmZ1c2luZy4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpNYWhtb3VkIEFkYW0KCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

