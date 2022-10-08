Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB85F899D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJIGQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Oct 2022 02:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJIGQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:16:09 -0400
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Oct 2022 23:16:06 PDT
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4D332B9A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:16:06 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 56F2B1613CB;
        Sun,  9 Oct 2022 06:05:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 373F220024;
        Sun,  9 Oct 2022 06:05:42 +0000 (UTC)
Date:   Sat, 08 Oct 2022 17:59:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Youssef Esmat' <youssefesmat@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
User-Agent: K-9 Mail for Android
In-Reply-To: <39d4ea27cfce4b7d977605f37f6da6fb@AcuMS.aculab.com>
References: <20220925143908.10846-1-vincent.guittot@linaro.org> <20220925143908.10846-8-vincent.guittot@linaro.org> <CA+q576OoP6Ebax8aGM234JRf+WOJFEwChs25qB9M_rt7+r1wuA@mail.gmail.com> <39d4ea27cfce4b7d977605f37f6da6fb@AcuMS.aculab.com>
Message-ID: <257E96C2-6ABD-4DD6-9B7F-771DA3D1BAAA@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FORGED_SPF_HELO,KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: cyc6noeo5g3c4eqkrhbkxiwc3f66kg9c
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 373F220024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XhhVD35EfmLizu6qrdXCxDgPd/Tr9QVo=
X-HE-Tag: 1665295542-118199
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 8, 2022 5:14:54 PM EDT, David Laight <David.Laight@ACULAB.COM> wrote:
>...
>> Have we considered an approach where the task that is marked as
>> latency sensitive gets a boosted nice value when it sleeps and is
>> either scaled down exponentially as it runs, or immediately reset to
>> its default when it runs for one tick?
>
>Or use the RT scheduler for anything that requires low latency.
>Isn't that what it is for?
>

The RT scheduler is for tasks that require strick scheduling requirements over all else, including performance.

But we are seeing latency issues for tasks that don't have such requirements but this latency effects its quality.

-- Steve

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
