Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7056DA49A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDFVWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjDFVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964EA26B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680816112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypZ6J/8kKOUhNSpcfi/rUYcvKjrOw0+NLSHUJaCfgZQ=;
        b=hOuPp3PngA/fFior4g/aTqVyV6dtS5TZkKv5Q/gf/a1aBetWmmeLuZogQOIcgsiV7SZiDs
        I/R1wgYdL2V7moeEI4GUtAqhlJ4gi4IKVQRsy8+VZrGOpnb8xcqr1BbgjaEJv1a3P17feF
        lypCRAXgYjMEPaILd42YxKh1sk8ZEUE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-4NL1ZrWCNkSYLTK99e9E-g-1; Thu, 06 Apr 2023 17:21:51 -0400
X-MC-Unique: 4NL1ZrWCNkSYLTK99e9E-g-1
Received: by mail-qt1-f200.google.com with SMTP id c14-20020ac87d8e000000b003e38726ec8bso27554469qtd.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypZ6J/8kKOUhNSpcfi/rUYcvKjrOw0+NLSHUJaCfgZQ=;
        b=c01KquDjVlI9rSWLRDM7RyPM1OH+zG/6f/Jk/B+KvtROrQnMMIoQfnukXqMu+66hI+
         8+OyjbkhRp8EkR9kHZsi4UcSVVSEmTdC1eiio3mr7SJ8wLWAAcGfbjm5yvM3sai3bTXy
         tV/P0kBvrlJOIJji5eW3VDZotjjfTRvdrXl5YG3WuN6EU9jFg4ldu7Y8WhJVgfFk9Ljh
         CYZSsqEdqMct4nheYNDS4qNL1RrFD9YMikWimW469+BiUZVB7OagdO3yGWbUEcllqFm/
         pWTyYQQkF3eIb106UcWhokWmVdp9OCLwXgvl1LpBRixZtR+GubPQJ/9YP7bGsJgExPBR
         GVTQ==
X-Gm-Message-State: AAQBX9fOULtViIO03uYb/gTHRMRwLrYE+BftsXeWoCTuSAu0QG5Fda0E
        UaPPRaI/ZzK+NK3MBYcr3pXv3BX4y0iFo+ytW3j1dzOteI7Fa7O2Tmb/19ubdwgy2ETARmZiRL3
        ryw4Sc0Lewl6wDDP7RbHJVeLY7XY5/Jgz
X-Received: by 2002:a05:622a:1b86:b0:3e4:ea7c:dac4 with SMTP id bp6-20020a05622a1b8600b003e4ea7cdac4mr13295427qtb.31.1680816110689;
        Thu, 06 Apr 2023 14:21:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGug1/C/RYLgC/646Jf3986NzGisymCFjw8sTbIhYYdyYJGw3ZUkaho7MsBNn40OIfXQmhkg==
X-Received: by 2002:a05:622a:1b86:b0:3e4:ea7c:dac4 with SMTP id bp6-20020a05622a1b8600b003e4ea7cdac4mr13295400qtb.31.1680816110452;
        Thu, 06 Apr 2023 14:21:50 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id d125-20020a37b483000000b007426ec97253sm755099qkf.111.2023.04.06.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:21:50 -0700 (PDT)
Message-ID: <04a6394d3a80e911d9d1ea3362c96ed5a808e09d.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] cacheinfo: Add arch specific early level
 initializer
From:   Radu Rendec <rrendec@redhat.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 06 Apr 2023 17:21:48 -0400
In-Reply-To: <10dd6c41-b09b-624c-ba1b-183f4e879ff6@arm.com>
References: <20230403231551.1090704-1-rrendec@redhat.com>
         <20230403231551.1090704-2-rrendec@redhat.com>
         <10dd6c41-b09b-624c-ba1b-183f4e879ff6@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGllcnJlLAoKT24gVGh1LCAyMDIzLTA0LTA2IGF0IDEwOjE3ICswMjAwLCBQaWVycmUg
R29uZG9pcyB3cm90ZToKPiBbc3RhcnRdCj4gPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQg
ZWFybHlfbGVhdmVzID0gY2FjaGVfbGVhdmVzKGNwdSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50
IHJldDsKPiA+IMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIFNpbmNlIGVhcmx5IGluaXRpYWxp
emF0aW9uL2FsbG9jYXRpb24gb2YgdGhlIGNhY2hlaW5mbyBpcyBhbGxvd2VkCj4gPiDCoMKgwqDC
oMKgwqDCoMKgICogdmlhIGZldGNoX2NhY2hlX2luZm8oKSBhbmQgdGhpcyBhbHNvIGdldHMgY2Fs
bGVkIGFzIENQVSBob3RwbHVnCj4gPiDCoMKgwqDCoMKgwqDCoMKgICogY2FsbGJhY2tzIHZpYSBj
YWNoZWluZm9fY3B1X29ubGluZSwgdGhlIGluaXQvYWxsb2MgY2FuIGJlIHNraXBwZWQKPiA+IMKg
wqDCoMKgwqDCoMKgwqAgKiBhcyBpdCB3aWxsIGhhcHBlbiBvbmx5IG9uY2UgKHRoZSBjYWNoZWlu
Zm8gbWVtb3J5IGlzIG5ldmVyIGZyZWVkKS4KPiA+IC3CoMKgwqDCoMKgwqDCoCAqIEp1c3QgcG9w
dWxhdGUgdGhlIGNhY2hlaW5mby4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIEp1c3QgcG9wdWxhdGUg
dGhlIGNhY2hlaW5mby4gSG93ZXZlciwgaWYgdGhlIGNhY2hlaW5mbyBoYXMgYmVlbgo+ID4gK8Kg
wqDCoMKgwqDCoMKgICogYWxsb2NhdGVkIGVhcmx5IHRocm91Z2ggdGhlIGFyY2gtc3BlY2lmaWMg
ZWFybHlfY2FjaGVfbGV2ZWwoKSBjYWxsLAo+ID4gK8KgwqDCoMKgwqDCoMKgICogdGhlcmUgaXMg
YSBjaGFuY2UgdGhlIGluZm8gaXMgd3JvbmcgKHRoaXMgY2FuIGhhcHBlbiBvbiBhcm02NCkuIElu
Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiB0aGF0IGNhc2UsIGNhbGwgaW5pdF9jYWNoZV9sZXZlbCgp
IGFueXdheSB0byBnaXZlIHRoZSBhcmNoLXNwZWNpZmljCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBj
b2RlIGEgY2hhbmNlIHRvIG1ha2UgdGhpbmdzIHJpZ2h0Lgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHBlcl9jcHVfY2FjaGVpbmZvKGNwdSkpCj4gPiArwqDC
oMKgwqDCoMKgwqBpZiAocGVyX2NwdV9jYWNoZWluZm8oY3B1KSAmJiAhY2lfY2FjaGVpbmZvKGNw
dSktPmVhcmx5X2FyY2hfaW5mbykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBwb3B1bGF0ZV9sZWF2ZXM7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaW5p
dF9jYWNoZV9sZXZlbChjcHUpIHx8ICFjYWNoZV9sZWF2ZXMoY3B1KSkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9FTlQ7Cj4gPiDCoCAKPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChjYWNoZV9sZWF2ZXMoY3B1KSA8PSBlYXJseV9sZWF2ZXMpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBwb3B1bGF0ZV9sZWF2ZXM7Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqBrZnJlZShwZXJfY3B1X2NhY2hlaW5mbyhjcHUpKQo+ID4gCj4gPiDCoMKg
wqDCoMKgwqDCoMKgcmV0ID0gYWxsb2NhdGVfY2FjaGVfaW5mbyhjcHUpOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoGlmIChyZXQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biByZXQ7Cj4gW3N0b3BdCj4gCj4gTWF5YmUgdGhpcyB3b3VsZCBiZSB0aGUgb2NjYXNpb24gdG8g
cHV0IHRoZSBjb2RlIGJldHdlZW4gdGhlIHN0YXJ0L3N0b3AgaW4gYSBzZXBhcmF0ZQo+IGZ1bmN0
aW9uIGFuZCByZW1vdmUgdGhlICdwb3B1bGF0ZV9sZWF2ZXMnIGxhYmVsLiBUaGUgY29kZSBzZWVt
cyBjb3JyZWN0LCBidXQgaXQgd2FzCj4gYWxyZWFkeSBhIGJpdCBjb21wbGV4IHRvIHJlYWQgYmVm
b3JlIHRoZSBwYXRjaC4KClllcywgdGhhdCBtYWtlcyBzZW5zZS4gSSB3aWxsIGFkZHJlc3MgdGhp
cyAoYW5kIHlvdXIgb3RoZXIgY29tbWVudAphYm91dCB0aGUgYnJhY2VzKSBhbmQgcG9zdCB2MyBz
aG9ydGx5LiBUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0Y2gKYW5kIGZvciB0aGUgZmVlZGJh
Y2shCgpBZnRlciBJIGhhZCBzZW50IHYyLCBJIHJlYWxpemVkIHRoZXJlIHdhcyBzb21ldGhpbmcg
bWlzc2luZyBmcm9tIHRoYXQKY29kZSBiZXR3ZWVuIHN0YXJ0L3N0b3AuIEkgdGhpbmsgd2Ugc2hv
dWxkIGFsc28gc2V0IHRoZSBlYXJseV9hcmNoX2luZm8KZmxhZyBiYWNrIHRvIGZhbHNlIHRvIHBy
ZXZlbnQgYW5vdGhlciBkZXRlY3Rpb24vcmVhbGxvY2F0aW9uIGluIGNhc2UKZGV0ZWN0X2NhY2hl
X2F0dHJpYnV0ZXMoKSBpcyBjYWxsZWQgYWdhaW4gKEknbSB0aGlua2luZyBDUFUgaG90cGx1Zyku
Ckkgd2lsbCBhZGRyZXNzIHRoaXMgYXMgd2VsbCBpbiB2My4KCkJlc3QgcmVnYXJkcywKUmFkdQoK


