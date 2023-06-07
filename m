Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB437263C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjFGPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjFGPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:10:21 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023101734;
        Wed,  7 Jun 2023 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1686150616;
        bh=EobN6Shy6YmwBECX8vJ30mW74AhlOJOLGmITM5vqgBQ=;
        h=Date:To:From:Subject:From;
        b=Yu9/VB3OLhLJzLk879e9NXBVbI4GZGtmSReAXb+vj5ZCxAssQ4q1InJ39WQN6KK/f
         nagIFLqnMQECDD+4Vm5P37y0VEGl7fOhPU6kXscedr3VcYYW7hJo7TiuCgLGisZUDC
         x1IPbZb7nxynMqKsnHDcQ3Vw1UxYvuZRIPZE0B4Gc5/XIix6JmzMCDfUcdbekXz0hq
         YMc/ozVIBbmUU/g3MNq9/GVtfVM1i+v3U4pwFYhcGgK+FEwoLMoebhGFDBMhtSKUuW
         bDxgdZk2z7CXa5P9smiknodxjCwfUhi8wzSz2u6Nwea8sBR6aB27521ekRGHZZLcCG
         PBeBV6hepXIiA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbrPN2ftJz16mt;
        Wed,  7 Jun 2023 11:10:16 -0400 (EDT)
Message-ID: <90f91bb9-e174-7e8e-6922-5a27cc0eede9@efficios.com>
Date:   Wed, 7 Jun 2023 11:10:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng UST 2.12.8/2.13.6 and LTTng modules 2.12.14/2.13.10
 tracers
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a stable release announcement for the LTTng UST and LTTng modules tracer projects.
Those contain mainly bug fixes and add support for recent distributions and upstream kernels.

What's new in both LTTng-UST 2.12.8 and 2.13.6:

- Fix: use unaligned pointer accesses for lttng_inline_memcpy
     
   lttng_inline_memcpy receives pointers which can be unaligned. This
   causes issues (traps) specifically on arm 32-bit with 8-byte strings
   (including \0).

- Fix: trace events in C constructors/destructors

   Adding a priority (150) to the tracepoint and tracepoint provider
   constructors/destructors ensures that we trace tracepoints located
   within C constructors/destructors with a higher priority value,
   including the default init priority of 65535, when the tracepoint vs
   tracepoint definition vs tracepoint probe provider are in different
   compile units (and in various link order one compared to another).

- Fix: Reevaluate LTTNG_UST_TRACEPOINT_DEFINE each time tracepoint.h is included

   Fix issues with missing symbols in use-cases where tracef.h is included
   before defining LTTNG_UST_TRACEPOINT_DEFINE

- Fix: segmentation fault on filter interpretation in "switch" mode

   Fix a bytecode interpreter crash when building with INTERPRETER_USE_SWITCH
   defined (used mainly for debugging purposes).


What's new specifically in LTTng-UST 2.13.6:

- Fix: `ip` context is expressed as a base-10 field

   The base for UST context field `ip` was changed from 16 (hexadecimal) to
   10 (decimal), most likely an unintentional copy&paste error in 4e48b5d.

- Various fixes to build with -std=c99.

- Fix: trace events in C++ constructors/destructors

   Wrap constructor and destructor functions to invoke them as functions with
   the constructor/destructor GNU C attributes, which ensures that those
   constructors/destructors are ordered before/after C++
   constructors/destructors.


What's new in LTTng modules 2.12.14 and 2.13.10:

- fix: kallsyms wrapper on CONFIG_PPC64_ELF_ABI_V1

   Work-around PPC64 ELF ABI v1 function descriptor issues when using kallsyms.

- Add support for RHEL 9.0 and 9.1.


What's new specifically in LTTng modules 2.12.14:

- Various tracepoint instrumentation fixes to support kernel v5.18.


What's new specifically in LTTng modules 2.13.10:

- Various tracepoint instrumentation fixes to support kernel v6.3.


Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
