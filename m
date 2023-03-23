Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F46C6F97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCWRoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:44:00 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D7819113
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1679593440; x=1711129440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uHbjUTn/Lf5sCirTIht51mLig6jyDesQcXu5whwpR4=;
  b=byufxgeMCOGNPrv6T01jFzb3glwCIwuVlQtsfIetJvVjR57HaS2bZ3W+
   2puS1B+YDhqW5V26x+VlKACq0X3mBiLgtMP2+Rq3PvK2Q7aTKTNyyGgkc
   VhO68mMy/uD2Wgp9QzdCaH0ApGmwWMU0xT5BDSj5iIHw3vrNhHeW3nvTG
   Y=;
X-IronPort-AV: E=Sophos;i="5.98,285,1673913600"; 
   d="scan'208";a="271887784"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 17:43:54 +0000
Received: from EX19D012EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 383C782D99;
        Thu, 23 Mar 2023 17:43:52 +0000 (UTC)
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 Mar 2023 17:43:51 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Thu, 23 Mar 2023 17:43:50 +0000
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com
 (10.13.225.85) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.22 via Frontend Transport; Thu, 23 Mar 2023 17:43:49 +0000
From:   Tomas Krcka <krckatom@amazon.de>
To:     <david@redhat.com>
CC:     Tomas Krcka <krckatom@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm: Be less noisy during memory hotplug
Date:   Thu, 23 Mar 2023 17:43:49 +0000
Message-ID: <20230323174349.35990-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <a9985035-237a-467c-6516-f996d56cb7e5@redhat.com>
References: <a9985035-237a-467c-6516-f996d56cb7e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VHVybiBhIHByX2luZm8oKSBpbnRvIGEgcHJfZGVidWcoKSB0byBwcmV2ZW50IGRtZXNnIHNwYW1t
aW5nIG9uIHN5c3RlbXMKd2hlcmUgbWVtb3J5IGhvdHBsdWcgaXMgYSBmcmVxdWVudCBvcGVyYXRp
b24uCgpTdWdnZXN0ZWQtYnk6IEphbiBILiBTY2jDtm5oZXJyIDxqc2Nob2VuaEBhbWF6b24uZGU+
ClNpZ25lZC1vZmYtYnk6IFRvbWFzIEtyY2thIDxrcmNrYXRvbUBhbWF6b24uZGU+Ci0tLQogbW0v
cGFnZV9hbGxvYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbW0vcGFnZV9hbGxvYy5jIGIvbW0vcGFnZV9hbGxvYy5j
CmluZGV4IGFjMWZjOTg2YWY0NC4uMTRkNzBmNGU2YzBhIDEwMDY0NAotLS0gYS9tbS9wYWdlX2Fs
bG9jLmMKKysrIGIvbW0vcGFnZV9hbGxvYy5jCkBAIC02OTU5LDcgKzY5NTksNyBAQCB2b2lkIF9f
cmVmIG1lbW1hcF9pbml0X3pvbmVfZGV2aWNlKHN0cnVjdCB6b25lICp6b25lLAogCQkJCSAgICAg
Y29tcG91bmRfbnJfcGFnZXMoYWx0bWFwLCBwZm5zX3Blcl9jb21wb3VuZCkpOwogCX0KIAotCXBy
X2luZm8oIiVzIGluaXRpYWxpc2VkICVsdSBwYWdlcyBpbiAldW1zXG4iLCBfX2Z1bmNfXywKKwlw
cl9kZWJ1ZygiJXMgaW5pdGlhbGlzZWQgJWx1IHBhZ2VzIGluICV1bXNcbiIsIF9fZnVuY19fLAog
CQlucl9wYWdlcywgamlmZmllc190b19tc2VjcyhqaWZmaWVzIC0gc3RhcnQpKTsKIH0KIAotLSAK
Mi4zOS4yCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vu
c3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFl
Z2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVu
YnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4
NzkKCgo=

