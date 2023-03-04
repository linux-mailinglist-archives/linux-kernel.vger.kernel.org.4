Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38A6AA784
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCDCOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 21:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDCOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:14:17 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFDEC51;
        Fri,  3 Mar 2023 18:14:16 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id v101so3635634ybi.2;
        Fri, 03 Mar 2023 18:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677896056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1yLHbAV+7B2knDNBaMWNhfWUYdQQ918iFTfAlED59Y=;
        b=rm/FblwMjWJvk2qB1/4/+6yZMWOXhpGx8NFdEkucimQv+GRELvPZTzvvQQAw+VmMVH
         yKH12HJjgo2czRO72Sv8tYTV8s2l1HjUNUIaNGINJHK1PpOaq3bn+Jr71OFSv+uyaQVc
         j5e3RLV7fO2/9P49RrsYGPekJmutsG5SxkROzrXrXNbjmsGC/1N6OpuMoLeVeAJr7KKW
         6d2QTXVP5cpMdHw3psw+qH2KaekWkR5BLD+7RCibXYmSboNjRKM37DNx7+jmkq5iyfqx
         CiFaoPUb4CFO4ODk/QDn0yEQ7NTaTBL0bJB5vUFIr17RR5H+HTh9y9D1IetiOq2Qje7g
         qdQQ==
X-Gm-Message-State: AO0yUKWKu/SHjXwh2u5uFNvKeP6GuyEJngIJ6mdFQ9rVjwJb/vOowmM2
        XtOy7Ogvjtamn2NvXAbKGc1/e31s5ARQwJMN9mE=
X-Google-Smtp-Source: AK7set8mLbJrCdsH2Pp8WQMr/QNrtGftdxDpKpf9NyWzbnV7rhli39Jy1HnO3qeASTqxoUlXqD8C+qxgHapy7u7hvag=
X-Received: by 2002:a5b:384:0:b0:a65:8cd3:fc4 with SMTP id k4-20020a5b0384000000b00a658cd30fc4mr2187171ybp.5.1677896055840;
 Fri, 03 Mar 2023 18:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20230303114637.4015916-1-zangchunxin@lixiang.com>
In-Reply-To: <20230303114637.4015916-1-zangchunxin@lixiang.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Mar 2023 18:14:03 -0800
Message-ID: <CAM9d7cjnkPduqCLTow1m6U2C7dVM5tsu5k42heh8G568-8Jd8Q@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Fix sched latency analysis incorrect
To:     Chunxin Zang <zangchunxin@lixiang.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Zhou <zhouchunhua@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIEZyaSwgTWFyIDMsIDIwMjMgYXQgMzo1MyBBTSBDaHVueGluIFphbmcgPHph
bmdjaHVueGluQGxpeGlhbmcuY29tPiB3cm90ZToNCj4NCj4gJ3BlcmYgc2NoZWQgbGF0ZW5jeScg
aXMgaW5jb3JyZWN0IHRvIGdldCBwcm9jZXNzIHNjaGVkdWxlIGxhdGVuY3kNCj4gd2hlbiBpdCB1
c2VkICdzY2hlZDpzY2hlZF93YWtldXAnIHRvIGFuYWx5c2lzIHBlcmYuZGF0YS4NCj4NCj4gQmVj
YXVzZSAncGVyZiByZWNvcmQnIHByZWZlciB1c2UgJ3NjaGVkOnNjaGVkX3dha2luZycgdG8NCj4g
J3NjaGVkOnNjaGVkX3dha2V1cCcgc2luY2UgY29tbWl0IGQ1NjZhOWMyZDQ4MiAoInBlcmYgc2No
ZWQ6IFByZWZlcg0KPiBzY2hlZF93YWtpbmcgZXZlbnQgd2hlbiBpdCBleGlzdHMiKS4gSXQncyB2
ZXJ5IHJlYXNvbmFibGUgdG8NCj4gZXZhbHVhdGUgcHJvY2VzcyBzY2hlZHVsZSBsYXRlbmN5Lg0K
Pg0KPiBTaW1pbGFybHksIHVwZGF0ZSBzY2hlZCBsYXRlbmN5L21hcC9yZXBsYXkgdG8gdXNlIHNj
aGVkX3dha2luZyBldmVudHMuDQoNCkhhdmUgeW91IGNoZWNrZWQgaWYgaXQgd29ya3Mgb2sgd2hl
biBkYXRhIGhhcyBib3RoIHdha2V1cCBhbmQNCndha2luZyBldmVudHM/DQoNCj4NCj4gU2lnbmVk
LW9mZi1ieTogQ2h1bnhpbiBaYW5nDQo+IFNpZ25lZC1vZmYtYnk6IEplcnJ5IFpob3UNCg0KTWlz
c2luZyBlbWFpbCBhZGRyZXNzZXMuDQoNCk90aGVyd2lzZSBsb29rcyBnb29kLg0KDQpUaGFua3Ms
DQpOYW1oeXVuZw0KDQoNCj4gLS0tDQo+IHRvb2xzL3BlcmYvYnVpbHRpbi1zY2hlZC5jIHwgMSAr
DQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvcGVyZi9idWlsdGluLXNjaGVkLmMgYi90b29scy9wZXJmL2J1aWx0aW4tc2NoZWQuYw0KPiBp
bmRleCA4NmUxODU3NWM5YmUuLjFhZjRlYzFhYzgyNCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVy
Zi9idWlsdGluLXNjaGVkLmMNCj4gKysrIGIvdG9vbHMvcGVyZi9idWlsdGluLXNjaGVkLmMNCj4g
QEAgLTE4MTksNiArMTgxOSw3IEBAIHN0YXRpYyBpbnQgcGVyZl9zY2hlZF9fcmVhZF9ldmVudHMo
c3RydWN0IHBlcmZfc2NoZWQgKnNjaGVkKQ0KPiBjb25zdCBzdHJ1Y3QgZXZzZWxfc3RyX2hhbmRs
ZXIgaGFuZGxlcnNbXSA9IHsNCj4geyAic2NoZWQ6c2NoZWRfc3dpdGNoIiwgcHJvY2Vzc19zY2hl
ZF9zd2l0Y2hfZXZlbnQsIH0sDQo+IHsgInNjaGVkOnNjaGVkX3N0YXRfcnVudGltZSIsIHByb2Nl
c3Nfc2NoZWRfcnVudGltZV9ldmVudCwgfSwNCj4gKyB7ICJzY2hlZDpzY2hlZF93YWtpbmciLCBw
cm9jZXNzX3NjaGVkX3dha2V1cF9ldmVudCwgfSwNCj4geyAic2NoZWQ6c2NoZWRfd2FrZXVwIiwg
cHJvY2Vzc19zY2hlZF93YWtldXBfZXZlbnQsIH0sDQo+IHsgInNjaGVkOnNjaGVkX3dha2V1cF9u
ZXciLCBwcm9jZXNzX3NjaGVkX3dha2V1cF9ldmVudCwgfSwNCj4geyAic2NoZWQ6c2NoZWRfbWln
cmF0ZV90YXNrIiwgcHJvY2Vzc19zY2hlZF9taWdyYXRlX3Rhc2tfZXZlbnQsIH0sDQo+IC0tDQo+
IDIuMjUuMQ0KPg0KPg0KPiDlo7DmmI7vvJrov5nlsIHpgq7ku7blj6rlhYHorrjmlofku7bmjqXm
lLbogIXpmIXor7vvvIzmnInlvojpq5jnmoTmnLrlr4bmgKfopoHmsYLjgILnpoHmraLlhbbku5bk
urrkvb/nlKjjgIHmiZPlvIDjgIHlpI3liLbmiJbovazlj5Hph4zpnaLnmoTku7vkvZXlhoXlrrnj
gILlpoLmnpzmnKzpgq7ku7bplJnor6/lnLDlj5Hnu5nkuobkvaDvvIzor7fogZTns7vpgq7ku7bl
j5Hlh7rogIXlubbliKDpmaTov5nkuKrmlofku7bjgILmnLrlr4blj4rms5XlvovnmoTnibnmnYPl
ubbkuI3lm6DkuLror6/lj5Hpgq7ku7bogIzmlL7lvIPmiJbkuKflpLHjgILku7vkvZXmj5Dlh7rn
moTop4LngrnmiJbmhI/op4Hlj6rlsZ7kuo7kvZzogIXnmoTkuKrkurrop4Hop6PvvIzlubbkuI3k
uIDlrprku6PooajmnKzlhazlj7jjgIINCg==
