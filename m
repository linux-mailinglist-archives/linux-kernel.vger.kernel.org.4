Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931046137DC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJaNY2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Oct 2022 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiJaNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:24:24 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90E1004D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:24:18 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id EE73280A5D;
        Mon, 31 Oct 2022 13:24:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 777D51B;
        Mon, 31 Oct 2022 13:23:56 +0000 (UTC)
Date:   Mon, 31 Oct 2022 09:24:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Roland Ruckerbauer <roland.rucky@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BBUG=5D_NULL_pointer_dereference_proba?= =?US-ASCII?Q?bly_caused_by_kernel/trace/ring=5Fbuffer=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
References: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
Message-ID: <A4AF246E-EC34-4672-9E7A-ECD8B15D0A49@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Queue-Id: 777D51B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: pp7yykohp7dximue6sy3rw338xtxhemr
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JWIMfsVGhR6qrXYwvJMt+AAJo7YAh6Jg=
X-HE-Tag: 1667222636-585017
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it's been reported. At my next layover, I'll take a look at it.

-- Steve 

On October 31, 2022 9:02:12 AM EDT, Roland Ruckerbauer <roland.rucky@gmail.com> wrote:
>Somewhere between kernel 6.0.2 and 6.0.5 I started getting crashes
>when https://github.com/mchehab/rasdaemon is starting.
>
>After investigating a bit, I found the following commits:
>a6b4d8d6656f ring-buffer: Fix race between reset page and reading page
>fa76ee6fea9c ring-buffer: Add ring_buffer_wake_waiters()
>7bf3c4d84204 ring-buffer: Check pending waiters when doing wake ups as well
>692cc072c800 ring-buffer: Have the shortest_full queue be the shortest
>not longest
>57af2334ca70 ring-buffer: Allow splice to read previous partially read pages
>
>I guess one of them must have broken something rasdaemon is using,
>since the crash is in ring_buffer_wake_waiters(), and it was first
>introduced by this commit series.
>
>The crash report is attached in dmesg.log.
>
>For me the crash is easily reproducible. For testing I run 6.0.5
>upstream kernel, but I guess everything since 6.0.3 is affected as
>well.
>
>My hardware (hopefully irrelevant): x570 amd platform (ryzen 5000)
>
>If I can help in any way, please say so (testing patches etc ...).
>
>Thanks,
>Roland Ruckerbauer

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
