Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD55BC038
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRV5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:57:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708713E9C;
        Sun, 18 Sep 2022 14:57:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46946)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2I7-00H6nJ-LN; Sun, 18 Sep 2022 15:57:31 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:37784 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2I6-000NTr-Dr; Sun, 18 Sep 2022 15:57:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     cgel.zte@gmail.com
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, hannes@cmpxchg.org,
        catalin.marinas@arm.com, peterx@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220918152912.210112-1-xu.panda@zte.com.cn>
Date:   Sun, 18 Sep 2022 16:57:23 -0500
In-Reply-To: <20220918152912.210112-1-xu.panda@zte.com.cn> (cgel zte's message
        of "Sun, 18 Sep 2022 15:29:12 +0000")
Message-ID: <87o7vc73cs.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oa2I6-000NTr-Dr;;;mid=<87o7vc73cs.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/VZT8JqQYpxHjHa1CUgrbhpMzcpaRkL8g=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;cgel.zte@gmail.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 677 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 16 (2.4%), b_tie_ro: 13 (2.0%), parse: 1.60
        (0.2%), extract_message_metadata: 15 (2.3%), get_uri_detail_list: 1.56
        (0.2%), tests_pri_-1000: 5 (0.8%), tests_pri_-950: 1.39 (0.2%),
        tests_pri_-900: 1.32 (0.2%), tests_pri_-90: 106 (15.6%), check_bayes:
        102 (15.1%), b_tokenize: 10 (1.4%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 1.95 (0.3%), b_tok_touch_all: 77 (11.4%), b_finish: 1.36
        (0.2%), tests_pri_0: 288 (42.6%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 3.6 (0.5%), poll_dns_idle: 200 (29.6%), tests_pri_10:
        3.7 (0.5%), tests_pri_500: 234 (34.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH linu-next V2] mm/fault: fix comparing pointer to 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Xu Panda <xu.panda@zte.com.cn>
>
> Do not use assignment in if condition,
> and comparing pointer whith NULL instead of comparing pointer to 0.

Then sensible thing to do if fixup is a pointer value is to just say:

"if (fixup) {"

That will be clearer and not match the pattern you are trying to avoid.

Eric

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  arch/alpha/mm/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index ef427a6bdd1a..bb3fe2949313 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -194,7 +194,8 @@ do_page_fault(unsigned long address, unsigned long
> mmcsr,
>
>   no_context:
>         /* Are we prepared to handle this fault as an exception?  */
> -       if ((fixup = search_exception_tables(regs->pc)) != 0) {
> +       fixup = search_exception_tables(regs->pc);
> +       if (fixup != NULL) {
>                 unsigned long newpc;
>                 newpc = fixup_exception(dpf_reg, fixup, regs->pc);
>                 regs->pc = newpc;
