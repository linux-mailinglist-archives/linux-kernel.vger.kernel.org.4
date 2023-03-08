Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8D6B02DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCHJ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:27:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A09E674
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678267616; i=efault@gmx.de;
        bh=ER4Eu0fA4q/SXb7pU+eeyUMVP9sVrB4pRnJFKxo7ZHQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HM2pMZQZOnbaWnFUiYLOZTpTEpJOUdkexQqFKvMvlKoOK+4Dmwr2YiN/iPM21AqRD
         F3ZyC+p0L6BVOfbZynvsHODgcWsp/2GPVd//ixmmFiYmsA+pR/9Q/FaNWsdnehpGWZ
         J9LKoS77dvcAYE50Im392ozPml0BfD4f3wIKAotZadSRDiJvlbbECBv5wnbLo/yf5u
         vTMmSBt7bDBLcdLJLYlZHcJSKTWWAjBHhAllEynb4mlP+Rp7N5ESKKCaCDmY3X7y+O
         zD0hSC/MSNT1H234MJ9gNhETBiYSr8JlHOzoBgMI32AhSskjIXnShCDx2mV1LypOhn
         sHQWM5KewEsAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1ptYmu0GwC-00OIT2; Wed, 08
 Mar 2023 10:26:56 +0100
Message-ID: <704b858792e48dbf4b45c9bf8f0529080acbe246.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Wed, 08 Mar 2023 10:26:52 +0100
In-Reply-To: <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:6rEQfGIHEF+LoIYC6dD4tHwExo6INP83NeVE5vdSHXcOmfp7zmg
 dcGFf5NJLwExmNvcAzU5+3AHYJRUCbCa3cG+2ALLAPdhNsAeU2CO/r8WzQx9dgJm5EzEoyF
 7XW04trkD+xflX+Cfovo5enM2JjVcKzwVo7Zz+S4ZW1JliYuCsAc7VRuOINOb6hjxyTH7ze
 cLxtC6XHkTtrIOsjfN5ew==
UI-OutboundReport: notjunk:1;M01:P0:n+2/amTIse4=;++m1kbZjMoiX+GOkrHW2H6XWUSD
 DtdkGldLi/ab5B7dAJj8rxeeQNkcIJYHdeFb424pRGeCxRQd/Pho0/K1L3gGJ0bkjyIjldZaS
 odu4FMwWefKis0Qf7QIluSRtiwJYl9SdgcaBdg86hMSHqGWNpeo/WKVQaMwHSJktYb+W2ZM6U
 LnaidMbdMzkxLcuIOtAS9RhqBvH+nAFR70SzTa1jHaHscH+7xK5FCdMFyiSVqyhLBgAg+Rb1l
 0Baqcyx3wNlKTA7VRsRy2FLCdKrl53EqIXVNlEXq/WgF4aUgVoqIbAOUkGQ41TS04hRbHan6+
 b06FZyrtQDDCf/yzXLyAg4QPUnEmuD8p/Rx3JDLY2+Zdi2IabkvYiJ5f+nx70ec1nCzXnlUfe
 q046VnrX442z05Z+VuYaz5X/8xNzJfRkLVorU8yRK2YpXIJorpl+gnWC4V61rgfX4vuN6QWh/
 qqnGAuOrSgO1Fel9CCQbOYnP8LnqZbaxp0D2MvX+7Cla7XNyJ/RTezXFAf/eRvyhwyJvpMoqD
 B+uKVUg5zs992fwluMiPGM/I7Axf7jLgNO6a3VVTuWSmzXm0Y2e97aIPl8hLHrp3WuivSCj7f
 e8knsVJmCmtrNN2RDK3JvJ8cCy/1IJ2rCDmybxW30gl9bgzRxSeZHrB+TutUeinhdSin1SRkK
 Wmw4FqJHtFN2p85jegP63SaFyN+hE61e/dXO9ePVxw7LqDaQMQCEH6p4xrsTBTomGesbfqFPh
 A0hpZ5JcgyVm3wY0gS9Hk0Ddff6HsaObnrvmeHebyNuWWzOQcV06dEv+J9Xr43EC1V8jciug9
 ikJlYAJK1kM3rRvqS0EJ/aGNDECLVJuf5e+NmRZUwgYfxOmrIWfiAOyHx2ibqfdrF1fXZzaBN
 wyPzV9l+0UvucjlAg/Qk9RBpeswxSOcUzILpcDKNyUKCTw6CZlxydqNY2FPypiuW0zEs21QZW
 QegejWrxSTfe4XirhocE8rtkdyw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDA5OjM5ICswMTAwLCBNaWtlIEdhbGJyYWl0aCB3cm90ZToN
Cj4gDQo+IG5ldHBlcmbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2ZzICtl
ZXZkZsKgIHZzIGNmcw0KPiBUQ1BfU0VOREZJTEUtMcKgwqDCoCBBdmc6wqAgODkyNTjCoCA5MjA4
MMKgwqAgMS4wMzENCj4gVENQX1NFTkRGSUxFLTLCoMKgwqAgQXZnOsKgIDgzMjcxwqAgODMzNzHC
oMKgIDEuMDAxDQo+IFRDUF9TRU5ERklMRS00wqDCoMKgIEF2ZzrCoCA1NjM5NcKgIDUzMDExwqDC
oMKgIC45MzkNCj4gVENQX1NFTkRGSUxFLTjCoMKgwqAgQXZnOsKgIDI2Mzg5wqAgMzk0NzDCoMKg
IDEuNDk1DQo+IFRDUF9TRU5ERklMRS0xNsKgwqAgQXZnOsKgIDEwMjUxwqAgMTk1OTDCoMKgIDEu
OTExDQoNCkZvcmdvdCB0byByZWNoZWNrIHRoaXMgbm90IHNvIG1vZGVzdCBjbGllbnRzID49IENQ
VVMgd2luLCBpdCdzIGFsc28NCnJlcGVhdGFibGUuDQoNCgktTWlrZQ0K
