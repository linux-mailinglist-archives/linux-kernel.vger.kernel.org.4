Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB0733125
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbjFPMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbjFPMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:25:20 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97D30E1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686918319; x=1718454319;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=n05DoyrBHXKDdlB35pLlTDm+2JJfGoE+jXQtDXhbJms=;
  b=cTvzxs3/l+VBMDCbwE524IztZ2FgzQ02AY3CfDVJ9lZftzi8Kq662KLE
   rdB+WUD7pO2WutE/BM/LIU8pcAjGdr80qu1IZQwApWtYjOBF4m2yG0Doi
   uvwfsWXU6XAng3ITmOOF4vpwdzZg1QwqcaTIU8UZedYvtsM9DMz8gwERF
   U=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681171200"; 
   d="scan'208";a="587719517"
Subject: Re: [PATCH 0/3] Resend GIC-v3 LPIs on concurrent invoke
Thread-Topic: [PATCH 0/3] Resend GIC-v3 LPIs on concurrent invoke
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 12:25:17 +0000
Received: from EX19D014EUC003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 7EBEFE0DD3;
        Fri, 16 Jun 2023 12:25:15 +0000 (UTC)
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D014EUC003.ant.amazon.com (10.252.51.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 12:25:14 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Fri, 16 Jun 2023 12:25:14 +0000
From:   "Gowans, James" <jgowans@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "liaochang1@huawei.com" <liaochang1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHZmgEKR/AD3FMNjkCRB6yMZRAtzK+NJh6AgAAx5wCAAA8qAA==
Date:   Fri, 16 Jun 2023 12:25:14 +0000
Message-ID: <653de2e448ebe0e525cf31dd8feb269671a6350a.camel@amazon.com>
References: <20230608120021.3273400-1-jgowans@amazon.com>
         <d08bc249fcf25ab88ded1578e79997a25ab6ba93.camel@amazon.com>
         <875y7nr6dr.wl-maz@kernel.org>
In-Reply-To: <875y7nr6dr.wl-maz@kernel.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.222]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E6BDA3873643D4DA41F76E566CA7712@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDEyOjMwICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIEZyaSwgMTYgSnVuIDIwMjMgMDk6MzI6MzAgKzAxMDAsDQo+ICJHb3dhbnMsIEphbWVzIiA8
amdvd2Fuc0BhbWF6b24uY29tPiB3cm90ZToNCj4gPiBIaSBNYXJjIGFuZCBUb21hcywNCj4gPiBK
dXN0IGEgcGluZyBvbiB0aGlzIHNlcmllczsgd291bGQgYmUgZ3JlYXQgdG8gZ2V0IGFueSBtb3Jl
IGZlZWRiYWNrLCBvcg0KPiA+IGdldCB0aGlzIG1lcmdlZC4NCj4gDQo+IEp1c3QgZGlkLCBhZnRl
ciBjb252ZXJ0aW5nIGV2ZXJ5dGhpbmcgdG8gQklUKCkgYW5kIG1hc3NhZ2luZyB0aGUNCj4gY29t
bWl0IG1lc3NhZ2VzIHRvIG15IG93biBsaWtpbmcuDQoNClRoZSBjb21taXQgbWVzc2FnZSBpbXBy
b3ZlbWVudHMgYXJlIGZhbnRhc3RpYyEgVGhhbmtzIGZvciBtZXJnaW5nIGl0DQpNYXJjLg0KDQpD
aGVlcnMsDQpKRw0K
