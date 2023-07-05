Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A096574866F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGEOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGEOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A8199D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688567617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrDW3FvXxO43Yo+LpdBvy45NnDg2y1LTlrt8vexkZfI=;
        b=SND++LWf99mRF0T2ic7q8R4V0vSD9EbE0ng2b2uszBBwZoxGMfEWGAb63lpIIFrmfPpmR3
        3mODM70Jvfb72YNrExGBlvWSE1PHFMqLBelAJ2Y/o1Aw3Z+N9Ou44rXzVuLS5YAr9OqitZ
        hP9hteh2tDYj5PRN11IKtkyWqn8o460=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-XmMucG25PtSOXJWr6hrVwg-1; Wed, 05 Jul 2023 10:32:36 -0400
X-MC-Unique: XmMucG25PtSOXJWr6hrVwg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a1c2d69709so5999429b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567547; x=1691159547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrDW3FvXxO43Yo+LpdBvy45NnDg2y1LTlrt8vexkZfI=;
        b=l/bHnG8rk7R0Nhry47yCmZzlMFKK1OyDhDaf2NQgNWTXKblP8I1VdC+BAgAzaEEUIT
         QK+9HMMWb2e5AIzM5jNbzPHxSEY4MrqddadVoM6C0o4bWjWlFqBxngaOZbGh7vVrBVyo
         v3lg8KH6rxW44riC69p6hnJSfappoiATnaE8hguXtcIxh7pTgM37TBWK8slvs2KWrE8N
         4s1BZ/l7TNq35mg7oLsgQa31zssJMxVWdL42fyGG7Hj7rklOxSW8ndTQMBQz1A3own8W
         6yBq88pAOcRUAvvf2/QMZ7v4GOJgRnAuTWhLiEDht4nXgfj1+T9pQS8poEEaGI/VWHA6
         P2dw==
X-Gm-Message-State: ABy/qLYydKvCrcSwJZlFa0S0KyoFrf20hDUPf0Vvy/MmArA00MHY5POU
        YOn9JCHEPHvh5vgIhGGyrraniz0gHdh3dhfMBc1fhCgbigyZq8Ol6ZNBS8M4j06Vuu4BKa5IjdL
        6OpcUsdiEEPgYYdAlTnL0xaNh
X-Received: by 2002:a05:6358:614d:b0:134:fdfc:4319 with SMTP id 13-20020a056358614d00b00134fdfc4319mr9810407rwt.20.1688567547479;
        Wed, 05 Jul 2023 07:32:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGzUGAKG/6tRM2MKYnWVk5HWYKe2HUGrmjZ2lr16rPJhV3/ZTaeZ6D9NovuGdoSgAdfat24bA==
X-Received: by 2002:a05:6358:614d:b0:134:fdfc:4319 with SMTP id 13-20020a056358614d00b00134fdfc4319mr9810379rwt.20.1688567547153;
        Wed, 05 Jul 2023 07:32:27 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:7f10:16a0:5672:9abf? ([2600:6c64:4e7f:603b:7f10:16a0:5672:9abf])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cf8c4000000b0062ff0dd0332sm8036650qvo.38.2023.07.05.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:32:26 -0700 (PDT)
Message-ID: <92beb7aa971b2fb600e4d47158b66bfe660d3c89.camel@redhat.com>
Subject: Re: [PATCH v2] scsi: bnx2fc: Remove a duplicate assignment in two
 functions
From:   Laurence Oberman <loberman@redhat.com>
To:     Minjie Du <duminjie@vivo.com>, Markus.Elfring@web.de,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        "supporter:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
Date:   Wed, 05 Jul 2023 10:32:25 -0400
In-Reply-To: <20230705115236.16571-1-duminjie@vivo.com>
References: <20230705115236.16571-1-duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTA1IGF0IDE5OjUyICswODAwLCBNaW5qaWUgRHUgd3JvdGU6Cj4gRGVs
ZXRlIGEgZHVwbGljYXRlIHN0YXRlbWVudCBmcm9tIHRoZXNlIGZ1bmN0aW9uIGltcGxlbWVudGF0
aW9ucy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaW5qaWUgRHUgPGR1bWluamllQHZpdm8uY29tPgo+
IC0tLQo+IMKgZHJpdmVycy9zY3NpL2JueDJmYy9ibngyZmNfaHdpLmMgfCAzIC0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS9ibngyZmMvYm54MmZjX2h3aS5jCj4gYi9kcml2ZXJzL3Njc2kvYm54MmZjL2JueDJmY19od2ku
Ywo+IGluZGV4IDc3NjU0NDM4NS4uMDQ3NGZlODhhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2Nz
aS9ibngyZmMvYm54MmZjX2h3aS5jCj4gKysrIGIvZHJpdmVycy9zY3NpL2JueDJmYy9ibngyZmNf
aHdpLmMKPiBAQCAtMTUyMSw4ICsxNTIxLDYgQEAgdm9pZCBibngyZmNfaW5pdF9zZXFfY2xlYW51
cF90YXNrKHN0cnVjdAo+IGJueDJmY19jbWQgKnNlcV9jbG5wX3JlcSwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRkNPRV9U
Q0VfVFhfV1JfUlhfUkRfQ09OU1RfQ0xBU1NfVFlQRQo+IF9TSElGVDsKPiDCoMKgwqDCoMKgwqDC
oMKgdGFzay0+cnh3cl90eHJkLmNvbnN0X2N0eC5pbml0X2ZsYWdzID0gY29udGV4dF9pZCA8PAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBGQ09FX1RDRV9SWF9XUl9UWF9SRF9DT05TVF9DSURfU0hJRlQ7Cj4gLcKgwqDCoMKg
wqDCoMKgdGFzay0+cnh3cl90eHJkLmNvbnN0X2N0eC5pbml0X2ZsYWdzID0gY29udGV4dF9pZCA8
PAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoEZDT0VfVENFX1JYX1dSX1RYX1JEX0NPTlNUX0NJRF9TSElGVDsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqB0YXNrLT50eHdyX3J4cmQudW5pb25fY3R4LmNsZWFudXAuY3R4LmNsZWFu
ZWRfdGFza19pZCA9Cj4gb3JpZ194aWQ7Cj4gwqAKPiBAQCAtMTc2Myw3ICsxNzYxLDYgQEAgdm9p
ZCBibngyZmNfaW5pdF90YXNrKHN0cnVjdCBibngyZmNfY21kCj4gKmlvX3JlcSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
RkNPRV9UQVNLX0RFVl9UWVBFX1RBUEUgPDwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRkNPRV9UQ0VfVFhfV1JfUlhfUkRf
Q09OU1RfREVWX1RZUEVfUwo+IEhJRlQ7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpb19yZXEtPnJlY19yZXRyeSA9IDA7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlvX3JlcS0+cmVjX3JldHJ5ID0gMDsKPiDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0YXNrLT50eHdyX3J4cmQuY29uc3RfY3R4LmluaXRf
ZmxhZ3MgfD0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgRkNPRV9UQVNLX0RFVl9UWVBFX0RJU0sgPDwKCkxvb2tzIGdvb2Qg
dG8gbWU6CgpSZXZpZXdlZC1ieTogTGF1cmVuY2UgT2Jlcm1hbiA8bG9iZXJtYW5AcmVkaGF0LmNv
bT4KCgo=

