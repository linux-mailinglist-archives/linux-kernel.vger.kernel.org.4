Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBCB74B710
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjGGT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjGGT1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:27:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF726AB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:25:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76754b9eac0so208552685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688757910; x=1691349910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+r3jktYVc7BJ0t7RIvh+DPkaX+O9am5ilz167T+8Rw=;
        b=VksFiZLUMkRUpHwPfLwxO749mxs+riqT1fz/v77lK8YECz2jLXyeBn36G1BTzde71m
         inTJDBVSJy+4wRdAg9ThlFwOCDK+wsUjCHVejqJ3AWaJ4XD6jA/KEb2XIgKfEoQIKcn3
         hFPQMjfsrUT00FQ7KEPSGGVRmabgmg1Xq6ypk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757910; x=1691349910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+r3jktYVc7BJ0t7RIvh+DPkaX+O9am5ilz167T+8Rw=;
        b=dAHRA+GXGktJMBFf61UNXi+UMSdXYUzZEqXg8ALPmB2OefsewunugmIhEV0lAGQWJ4
         XdzcGR3eX8yBGOzNDBB+/qqJxOi45K5HrWmF5weRcpTgI91TMHjlxABB6gD3BDM3xB+q
         cGKzZW+3sCwSTvRrlvory5+KSSeM93ZSPzASiaXnIcRXgLmpwCNygTIzManzXtvdIzQD
         t1m5pq2YxyYSbu8w9xpmEYlyYqKjZRLhvsyTRyrKAJ6u3yqdwp612bn+dj345j4MJiDA
         IJZI9C/a3x2LOe6fWf2lnhKUVvuEJcwTDH+yxbyIgUfi+f4nZ5K/+6kodfHXMcIpdnum
         p2Yg==
X-Gm-Message-State: ABy/qLZ5ITO715HT8nV2JIv4fXvrIWEr2/rchXU9tzQZfvabg1gv83KC
        6SpEu/n7qpv6k2EUhhTRvhqFZg==
X-Google-Smtp-Source: APBJJlGdt9CR1Br+OTI2jKF07n0KLFWGh5RQtRs6GLBBfCJFzu9aHwdJgrx+H0iU0UDJuixZQMchUw==
X-Received: by 2002:a05:620a:28c4:b0:767:3b7d:687c with SMTP id l4-20020a05620a28c400b007673b7d687cmr7479809qkp.15.1688757909831;
        Fri, 07 Jul 2023 12:25:09 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.223])
        by smtp.gmail.com with ESMTPSA id ou30-20020a05620a621e00b00754b7ee6922sm2131293qkn.9.2023.07.07.12.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:25:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Date:   Fri, 7 Jul 2023 15:24:58 -0400
Message-Id: <140FCD95-052F-4DA9-AA5A-374D417490A9@joelfernandes.org>
References: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 7, 2023, at 10:56 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> =EF=BB=BFOn 7/7/23 10:07, Davidlohr Bueso wrote:
>>> On Thu, 06 Jul 2023, Waiman Long wrote:
>>>=20
>>> It was found that running the refscale test might sometimes crash the
>>> kernel with the following error:
>>>=20
>>> [ 8569.952896] BUG: unable to handle page fault for address: fffffffffff=
fffe8
>>> [ 8569.952900] #PF: supervisor read access in kernel mode
>>> [ 8569.952902] #PF: error_code(0x0000) - not-present page
>>> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>>> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>>> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.=
4 05/28/2021
>>> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>>>  :
>>> [ 8569.952940] Call Trace:
>>> [ 8569.952941]  <TASK>
>>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>>> [ 8569.952959]  kthread+0x10e/0x130
>>> [ 8569.952966]  ret_from_fork+0x1f/0x30
>>> [ 8569.952973]  </TASK>
>>>=20
>>> This is likely caused by the fact that init_waitqueue_head() is called
>>> after the ref_scale_reader kthread is created. So the kthread may try
>>> to use the waitqueue head before it is properly initialized. Fix this
>>> by initializing the waitqueue head first before kthread creation.
>>>=20
>>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read=
-side synchronization")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>=20
>> Strange this wasn't reported sooner.
>=20
> Red Hat does have a pretty large QE organization that run all sort of test=
s include this one pretty frequently. The race window is pretty small, but t=
hey did hit this once in a while.

Having worked on this test initially, I am happy to hear that Redhat runs th=
is test!

Thanks for fixing this issue.
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

-Joel

>=20
> Cheers,
> Longman
>=20
