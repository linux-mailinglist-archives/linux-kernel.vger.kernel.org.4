Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C25F8776
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJHVPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJHVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 17:15:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F1192A8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:14:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-10-4BZ_u1ECPiKZR92da4QZfw-1; Sat, 08 Oct 2022 22:14:55 +0100
X-MC-Unique: 4BZ_u1ECPiKZR92da4QZfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sat, 8 Oct
 2022 22:14:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Sat, 8 Oct 2022 22:14:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Youssef Esmat' <youssefesmat@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "joshdon@google.com" <joshdon@google.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: RE: [PATCH v5 7/7] sched/fair: Add latency list
Thread-Topic: [PATCH v5 7/7] sched/fair: Add latency list
Thread-Index: AQHY2rIAyP0XtowKMkW9rg2afxL7iK4FAFWg
Date:   Sat, 8 Oct 2022 21:14:54 +0000
Message-ID: <39d4ea27cfce4b7d977605f37f6da6fb@AcuMS.aculab.com>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-8-vincent.guittot@linaro.org>
 <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
In-Reply-To: <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+IEhhdmUgd2UgY29uc2lkZXJlZCBhbiBhcHByb2FjaCB3aGVyZSB0aGUgdGFzayB0aGF0
IGlzIG1hcmtlZCBhcw0KPiBsYXRlbmN5IHNlbnNpdGl2ZSBnZXRzIGEgYm9vc3RlZCBuaWNlIHZh
bHVlIHdoZW4gaXQgc2xlZXBzIGFuZCBpcw0KPiBlaXRoZXIgc2NhbGVkIGRvd24gZXhwb25lbnRp
YWxseSBhcyBpdCBydW5zLCBvciBpbW1lZGlhdGVseSByZXNldCB0bw0KPiBpdHMgZGVmYXVsdCB3
aGVuIGl0IHJ1bnMgZm9yIG9uZSB0aWNrPw0KDQpPciB1c2UgdGhlIFJUIHNjaGVkdWxlciBmb3Ig
YW55dGhpbmcgdGhhdCByZXF1aXJlcyBsb3cgbGF0ZW5jeS4NCklzbid0IHRoYXQgd2hhdCBpdCBp
cyBmb3I/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

