Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F73714973
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjE2MYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjE2MYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D0AAB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685363006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=taQnrLJNFMICJ+bz3uciHbpmGjw4SP9pbQxjK9y88KA=;
        b=F4mB9kMfJ9lDd965cwSfLbW+QgExOV7r/r/riT1o65KKjJ8Qrlfs2OjUQpoRjDLh95hZ5t
        AuTquzhcUPZaBFmlMtlC3IxUpQOKW8bhg3iYkJfrifiP2ge/o5QRK6urMHbeC249wK2UxL
        N86bM7tbg9vVZuNoHY6aVoRo5Ok7D6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-O-uo7ttOOmq522hVu3kWNA-1; Mon, 29 May 2023 08:23:23 -0400
X-MC-Unique: O-uo7ttOOmq522hVu3kWNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E963811E78;
        Mon, 29 May 2023 12:23:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C3952166B2B;
        Mon, 29 May 2023 12:23:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 May 2023 14:23:03 +0200 (CEST)
Date:   Mon, 29 May 2023 14:22:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230529122256.GA588@redhat.com>
References: <20230516191441.34377-1-wander@redhat.com>
 <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17, Wander Lairson Costa wrote:
>
> On Wed, May 17, 2023 at 12:26 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > LGTM but we still need to understand the possible problems with CONFIG_PROVE_RAW_LOCK_NESTING ...
> >
> > Again, I'll try to investigate when I have time although I am not sure I can really help.
> >
> > Perhaps you too can try to do this ? ;)
> >
>
> FWIW, I tested this patch with CONFIG_PROVE_LOCK_NESTING in RT and
> stock kernels. No splat happened.

Strange... FYI, I am running the kernel with this patch

	diff --git a/kernel/sys.c b/kernel/sys.c
	index 339fee3eff6a..3169cceddf3b 100644
	--- a/kernel/sys.c
	+++ b/kernel/sys.c
	@@ -2412,6 +2412,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
	 
		error = 0;
		switch (option) {
	+	case 666: {
	+		static DEFINE_SPINLOCK(l);
	+		static DEFINE_RAW_SPINLOCK(r);
	+
	+		raw_spin_lock(&r);
	+		spin_lock(&l);
	+		spin_unlock(&l);
	+		raw_spin_unlock(&r);
	+
	+		break;
	+	}
		case PR_SET_PDEATHSIG:
			if (!valid_signal(arg2)) {
				error = -EINVAL;

applied (because I am too lazy to compile a module ;) and

	# perl -e 'syscall 157,666'

triggers the lockdep bug

	=============================
	[ BUG: Invalid wait context ]
	6.4.0-rc2-00018-g4d6d4c7f541d-dirty #1176 Not tainted
	-----------------------------
	perl/35 is trying to lock:
	ffffffff81c4cc18 (l){....}-{3:3}, at: __do_sys_prctl+0x21b/0x87b
	other info that might help us debug this:
	context-{5:5}
	...

as expected.

Looks like your testing was wrong... Or maybe you missed another lockdep problem ?
Did you check dmesg? Perhaps lockdep detected another bug,say, even at boot time ?
In this case debug_locks_off() sets debug_locks = 0 and this disables lockdep.

Oleg.

