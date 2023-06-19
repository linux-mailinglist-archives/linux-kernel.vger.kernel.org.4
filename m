Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B5734F63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFSJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjFSJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:14:16 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58560E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1687166054; x=1718702054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J8jp2nTwAqog3hsQFaaZoi0lNT87Il/rbv6iahgsNeg=;
  b=qU2z6J/xklQrPHsrwP1U8btau4+7+exIDOIeoyan2tKuxo07krs55ocr
   NAOM8kiBU5QF940xZ7gxBl8fFJTkLmNmFUYO00SFj3O+6gjuyzSYiJRH3
   ddSca8qyP8MWvczy0Ef+y6Di0Bb7Phc38Y3GvnlqVmzC5Dp/rh/EhUIeR
   I=;
X-IronPort-AV: E=Sophos;i="6.00,254,1681171200"; 
   d="scan'208";a="591361655"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 09:14:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 0DC3880492;
        Mon, 19 Jun 2023 09:14:10 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Jun 2023 09:14:10 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 19 Jun
 2023 09:14:08 +0000
Message-ID: <38b2d1b4-9a26-c6a3-cf8b-af5b3dcf5a9b@amazon.de>
Date:   Mon, 19 Jun 2023 11:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Content-Language: en-US
To:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <20230531095119.11202-2-bchalios@amazon.es>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDMxLjA1LjIzIDExOjUxLCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+IFdlIHJlY2VpdmUgYW4g
QUNQSSBub3RpZmljYXRpb24gZXZlcnkgdGltZSB0aGUgVk0gR2VuZXJhdGlvbiBJRCBjaGFuZ2Vz
Cj4gYW5kIHVzZSB0aGUgbmV3IElEIGFzIGZyZXNoIHJhbmRvbW5lc3MgYWRkZWQgdG8gdGhlIGVu
dHJvcHkgcG9vbC4gVGhpcwo+IGNvbW1pdHMgZW1pdHMgYSB1ZXZlbnQgZXZlcnkgdGltZSB3ZSBy
ZWNlaXZlIHRoZSBBQ1BJIG5vdGlmaWNhdGlvbiwgYXMgYQo+IG1lYW5zIHRvIG5vdGlmeSB0aGUg
dXNlciBzcGFjZSB0aGF0IGl0IG5vdyBpcyBpbiBhIG5ldyBWTS4KPgo+IFNpZ25lZC1vZmYtYnk6
IEJhYmlzIENoYWxpb3MgPGJjaGFsaW9zQGFtYXpvbi5lcz4KCgpUaGFua3MgQmFiaXMhIFN1cGVy
IHNpbXBsZSwgeWV0IHZlcnkgZWZmZWN0aXZlIHdheSB0byBub3RpZnkgc3lzdGVtIApzb2Z0d2Fy
ZSB0aGF0IGl0IG1heSBuZWVkIHRvIGFkb3B0IHRvIGEgbmV3IGVudmlyb25tZW50LiBJIGtub3cg
dGhhdCB0aGUgCnN5c3RlbWQgZm9sa3MgYXJlIHN1cGVyIGludGVyZXN0ZWQgaW4gdGhhdCB0byBm
b3IgZXhhbXBsZSByZWdlbmVyYXRlIApyYW5kb21seSBnZW5lcmF0ZWQgTUFDIGFkZHJlc3NlcyBh
ZnRlciBhIGNsb25lIG9wZXJhdGlvbi4KCgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIEdyYWYgPGdy
YWZAYW1hem9uLmNvbT4KCgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDI4OSAyMzcgODc5CgoK

