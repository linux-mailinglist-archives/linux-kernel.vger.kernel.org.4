Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D76FE1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjEJPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjEJPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:45:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89A94
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:45:18 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38472)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pwm0C-009f3m-Tj; Wed, 10 May 2023 09:45:16 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:51364 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pwm0B-006uPF-RI; Wed, 10 May 2023 09:45:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230509104127.1997562-1-chenhuacai@loongson.cn>
Date:   Wed, 10 May 2023 10:44:43 -0500
In-Reply-To: <20230509104127.1997562-1-chenhuacai@loongson.cn> (Huacai Chen's
        message of "Tue, 9 May 2023 18:41:27 +0800")
Message-ID: <87ild0w5qs.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pwm0B-006uPF-RI;;;mid=<87ild0w5qs.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/6Az45sWJkYuh4JpbrMsGatRFJzZ3Jt1c=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.9%), b_tie_ro: 8 (1.6%), parse: 1.16 (0.2%),
        extract_message_metadata: 17 (3.6%), get_uri_detail_list: 1.36 (0.3%),
        tests_pri_-2000: 18 (3.7%), tests_pri_-1000: 2.4 (0.5%),
        tests_pri_-950: 1.19 (0.2%), tests_pri_-900: 1.00 (0.2%),
        tests_pri_-200: 0.82 (0.2%), tests_pri_-100: 3.3 (0.7%),
        tests_pri_-90: 131 (27.2%), check_bayes: 119 (24.7%), b_tokenize: 4.7
        (1.0%), b_tok_get_all: 6 (1.2%), b_comp_prob: 1.61 (0.3%),
        b_tok_touch_all: 104 (21.5%), b_finish: 0.97 (0.2%), tests_pri_0: 190
        (39.5%), check_dkim_signature: 0.72 (0.1%), check_dkim_adsp: 4.6
        (1.0%), poll_dns_idle: 85 (17.7%), tests_pri_10: 2.3 (0.5%),
        tests_pri_500: 99 (20.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai Chen <chenhuacai@loongson.cn> writes:

> Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> and umh") introduces a new function user_mode_thread() for init and umh.
> But the name is a bit confusing because init and umh are indeed kernel
> threads at creation time, the real difference is "they will become user
> processes".

No they are not "kernel threads" at creation time.  At creation time
init and umh are threads running in the kernel.

It is a very important distinction and you are loosing it.

Because they don't have a kthread_struct such tasks in the kernel
are not allowed to depend on anything that is ``kthread''.

Having this a separate function highlights the distinction.
Highlighting should hopefully cause people to ask why there is a
distinction, and what is going on.

> So let's unify the kernel_thread() and user_mode_thread() to
> kernel_thread() again, and add a new 'user' parameter for init and
> umh

Now that is confusing.

Eric
