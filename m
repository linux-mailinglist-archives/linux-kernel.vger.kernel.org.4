Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51765699B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBPRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:48:55 -0500
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 09:48:53 PST
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D44C3F8;
        Thu, 16 Feb 2023 09:48:53 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:45302)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pSgqj-00EmG5-FB; Thu, 16 Feb 2023 09:11:09 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41456 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pSgqi-003fCi-F5; Thu, 16 Feb 2023 09:11:09 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230215131807.293556-1-omosnace@redhat.com>
        <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
Date:   Thu, 16 Feb 2023 10:07:53 -0600
In-Reply-To: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
        (Andrew Morton's message of "Wed, 15 Feb 2023 12:47:47 -0800")
Message-ID: <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pSgqi-003fCi-F5;;;mid=<87a61d7fvq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18qIEApqQSqpUxdzdLE40wBYa/0PtjN14E=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.67 (0.2%),
         extract_message_metadata: 11 (2.4%), get_uri_detail_list: 0.67 (0.2%),
         tests_pri_-2000: 3.9 (0.9%), tests_pri_-1000: 2.2 (0.5%),
        tests_pri_-950: 1.20 (0.3%), tests_pri_-900: 0.97 (0.2%),
        tests_pri_-200: 0.82 (0.2%), tests_pri_-100: 3.4 (0.8%),
        tests_pri_-90: 144 (32.7%), check_bayes: 135 (30.6%), b_tokenize: 4.2
        (0.9%), b_tok_get_all: 4.9 (1.1%), b_comp_prob: 1.54 (0.3%),
        b_tok_touch_all: 121 (27.5%), b_finish: 0.85 (0.2%), tests_pri_0: 153
        (34.6%), check_dkim_signature: 0.45 (0.1%), check_dkim_adsp: 3.4
        (0.8%), poll_dns_idle: 91 (20.7%), tests_pri_10: 3.1 (0.7%),
        tests_pri_500: 103 (23.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in
 __sys_setres[ug]id()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
>> 1. First determine if CAP_SET[UG]ID is required and only then call
>>    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
>
> Can we please have more details on the selinux failures?  Under what
> circumstances?  What is the end-user impact?

It is puzzling the structure with having the capability check first
dates to 2.1.104 (when a hand coded test for root was replaced
with capable(CAP_SETID).  Which means the basic structure and logic
of the code is even older than that.

Eric
