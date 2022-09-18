Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B595BC035
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIRVz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIRVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:55:52 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C317A94
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:55:51 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43960)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2GQ-008ozR-Sj; Sun, 18 Sep 2022 15:55:46 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:47224 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2GP-006HsH-VI; Sun, 18 Sep 2022 15:55:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Oleg Nesterov <oleg@redhat.com>
References: <1661842523-26716-1-git-send-email-zhaoyang.huang@unisoc.com>
        <CAGWkznE5LhYq6dWB0zFkF2XdD-gd3MBcQ9fnUJmW59YL1GisMQ@mail.gmail.com>
        <YyaFrarLHYW3HSnu@ZenIV>
Date:   Sun, 18 Sep 2022 16:55:17 -0500
In-Reply-To: <YyaFrarLHYW3HSnu@ZenIV> (Al Viro's message of "Sun, 18 Sep 2022
        03:42:53 +0100")
Message-ID: <87wna073ga.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oa2GP-006HsH-VI;;;mid=<87wna073ga.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/AkfaHDfpn6fLN77ooydSFsheLGKPGEa8=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 387 ms - load_scoreonly_sql: 0.20 (0.1%),
        signal_user_changed: 20 (5.1%), b_tie_ro: 17 (4.5%), parse: 1.10
        (0.3%), extract_message_metadata: 17 (4.3%), get_uri_detail_list: 1.35
        (0.3%), tests_pri_-1000: 34 (8.7%), tests_pri_-950: 1.52 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 80 (20.6%), check_bayes:
        78 (20.1%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 58 (15.1%), b_finish: 1.10
        (0.3%), tests_pri_0: 212 (54.8%), check_dkim_signature: 0.61 (0.2%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.84 (0.2%), tests_pri_10:
        2.9 (0.8%), tests_pri_500: 14 (3.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs: use kvmalloc for big coredump file
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Oleg as well.

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sun, Sep 18, 2022 at 10:29:10AM +0800, Zhaoyang Huang wrote:
>> loop Eric W
>> 
>> On Tue, Aug 30, 2022 at 2:56 PM zhaoyang.huang
>> <zhaoyang.huang@unisoc.com> wrote:
>> >
>> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> >
>> > High order page allocation observed which even introduce kernel panic when generating
>> > coredump file, use kvmalloc_array instead of kmalloc_array
>
> Frankly, I would rather cap argc here - if you are trying to feed that many arguments
> to your userland helper, your core_pattern is probably bogus.

Yes.  More than 512 arguments seems ridiculous.  I only count
16 different values that can be place in corename so frankly a cap
of about 20 seems sensible.

I would suggest counting the number of spaces in core pattern and not
allowing it to be set if the result would be more than
"PAGE_SIZE/sizeof(void *)" arguments.

I would reduce that by one more argument so that helper_argv is
completely unnecessary.  Unless I am misreading something the
only reason for helper_argv is to add a NULL at the end of
the argv array.  It should be no problem to have format_corename
do that work as well.


If you have a real world case where that is a problem please post
the useful corepattern so that we can stare in disbelief and finally
come around to figuring out how to support such a core pattern.

Thank you,
Eric



