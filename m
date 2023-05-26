Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93194712CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbjEZS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbjEZS67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:58:59 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BB13A;
        Fri, 26 May 2023 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685127536;
        bh=n8UtLLL7MeH+WxjGi6mdHGUgV4zOAdY84/FWBVF10eQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EXAclzRSVyyGe4sxzeUw0gc1ic+L1C5A4r32bT+JVI5YkECYJPLa4XZQLvbgu08aU
         2QMp7vFHEtW7KDcMynH/YPycEalNlBxrUt3FKyV9Rlp49M8UIgAMJ8J2jtTHqT4QDY
         u2RogTX9vIX7qCF6taEdkcgh6hvt++Oa5V86UdXIajCV+IwBGsSMN1lwi2OAT0IJGl
         +cQS15x6sVeuG4oTD7T2fXlRX0oXBagHm1WzxgcntvfArglXd/wxLboFubhEKJ0Ak/
         gmYQAttcKBxYo1rqSxH7M+LOSwuI15zs/JIi3ULoDWCI7DMK+LF5zup6igmRPdL9V8
         T3uWAGYHakHeg==
Received: from [IPV6:2605:8d80:581:38b8:cb6e:1465:9ef2:4900] (unknown [IPv6:2605:8d80:581:38b8:cb6e:1465:9ef2:4900])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSZ2k1x5kz1604;
        Fri, 26 May 2023 14:58:54 -0400 (EDT)
Message-ID: <e63ca3f4-283a-05fb-d637-c7428d87c8f2@efficios.com>
Date:   Fri, 26 May 2023 14:58:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
 <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 14:49, Waiman Long wrote:
[...]
> 
> BTW, do we have a use case for double_lock_guard/double_lock_scope? I 
> can envision a nested lock_scope inside a lock_scope, but taking 2 auto 
> locks of the same type at init time and then unlock them at exit just 
> doesn't make sense to me.

AFAIU taking both runqueue locks for source and destination runqueues on 
migration is one use-case for double_lock_guard/scope.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

