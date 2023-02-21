Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C269E500
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjBUQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjBUQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:44:49 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A892DE40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676997881;
        bh=CnFyWkIvHcafJvzbfqX1d9XkFUX4UQDNkHJxmpws/rk=;
        h=Date:To:Cc:From:Subject:From;
        b=M9wmPDuA2WKwFuhPLhXkRx0IfGv0nWq2MDR7OJ6juLRyLxjbXoWw7vByd9gMhP54x
         0de+KHVvBDYjBbRJWr5InVJmZROVgB7wEhtm1MVY4Sw1DSfjSuKKqoZ5UZlXi0L24+
         H3EkVFVXh3bEbWB8S+XjqiEzYj3l7gVLiizQguf2svteM2jCha5UWPsLNCoz2KuEKq
         SiXz/7QMUf2ep87b6lVCbKFgHvqtisSkpzNp5/JQosMJxQ4l/RDaltKGUy4DGhYs8V
         r2TNNNtAP6wYVt4EQ+ZL7PMdA11uXbLrBMCyAKhITJxoZWQP/C+Kv+kS5XnJ5OXICj
         b6SUEeixqcLCw==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PLlWF4LmRzmNW;
        Tue, 21 Feb 2023 11:44:41 -0500 (EST)
Message-ID: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
Date:   Tue, 21 Feb 2023 11:44:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>, Olivier Dion <odion@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Official documentation from Intel stating that poking INT3
 (single-byte) concurrently is OK ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I have emails from you dating from a few years back unofficially stating
that it's OK to update the first byte of an instruction with a single-byte
int3 concurrently:

https://lkml.indiana.edu/hypermail/linux/kernel/1001.1/01530.html

It is referred in the original implementation of text_poke_bp():
commit fd4363fff3d9 ("x86: Introduce int3 (breakpoint)-based instruction patching")

Olivier Dion is working on the libpatch [1,2] project aiming to use this
property for low-latency/low-overhead live code patching in user-space as
well, but we cannot find an official statement from Intel that guarantees
this breakpoint-bypass technique is indeed OK without stopping the world
while patching.

Do you know where I could find an official statement of this guarantee ?

Thanks!

Mathieu

[1] https://www.dorsal.polymtl.ca/files/may2022/odion_may2022_libpatch_binary_patcher.pdf
[2] https://git.sr.ht/~old/libpatch

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
