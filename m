Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDF6A12F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBWWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBWWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90355C17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677192362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltjU0AEByvYhW8L9le+BBUG7BfzHsx3kNMdCFV+tZss=;
        b=P6aR8V9NzlDJ1XhEGuzJiFXL6wajlJLRgJDq5BiaFxQuN2dNrod1SOxRDBG8/ALEOJgMM/
        fT2yAvlJ33K8dep2g0YB7sMfrbJhY7/ostcKNLtl3nwPSwK1TFXFb6rcVvIZ89rdPHlM+T
        DWlBPJXFhT06eE2FwTS46Yafho8Ihj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-ipVKtSPJPn2K2fgHgv6xTg-1; Thu, 23 Feb 2023 17:45:57 -0500
X-MC-Unique: ipVKtSPJPn2K2fgHgv6xTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA76F85A5B1;
        Thu, 23 Feb 2023 22:45:56 +0000 (UTC)
Received: from [10.22.16.134] (unknown [10.22.16.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86DC52166B29;
        Thu, 23 Feb 2023 22:45:56 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------L1fi1h6cQLywMen5qReHDFEZ"
Message-ID: <0be586e4-8c08-63ff-a78d-ffb5ae37adc3@redhat.com>
Date:   Thu, 23 Feb 2023 17:45:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/6] locking/rwsem: Unify wait loop
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
 <20230223123319.608133045@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230223123319.608133045@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------L1fi1h6cQLywMen5qReHDFEZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/23/23 07:26, Peter Zijlstra wrote:
> Now that the reader and writer wait loops are identical, share the
> code.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/locking/rwsem.c |  117 +++++++++++++++++++------------------------------
>   1 file changed, 47 insertions(+), 70 deletions(-)
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -650,13 +650,11 @@ static void rwsem_mark_wake(struct rw_se
>    * optionally wake up waiters before it returns.
>    */
>   static inline void
> -rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
> -		      struct wake_q_head *wake_q)
> +rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
>   		      __releases(&sem->wait_lock)
>   {
>   	bool first = rwsem_first_waiter(sem) == waiter;
> -
> -	wake_q_init(wake_q);
> +	DEFINE_WAKE_Q(wake_q);
>   
>   	/*
>   	 * If the wait_list isn't empty and the waiter to be deleted is
> @@ -664,10 +662,10 @@ rwsem_del_wake_waiter(struct rw_semaphor
>   	 * be eligible to acquire or spin on the lock.
>   	 */
>   	if (rwsem_del_waiter(sem, waiter) && first)
> -		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
> +		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>   	raw_spin_unlock_irq(&sem->wait_lock);
> -	if (!wake_q_empty(wake_q))
> -		wake_up_q(wake_q);
> +	if (!wake_q_empty(&wake_q))
> +		wake_up_q(&wake_q);
>   }
>   
>   /*
> @@ -993,6 +991,46 @@ static inline void rwsem_cond_wake_waite
>   	rwsem_mark_wake(sem, wake_type, wake_q);
>   }
>   
> +#define waiter_type(_waiter, _r, _w)	\
> +	((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
> +
> +static __always_inline struct rw_semaphore *
> +rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter *waiter, int state)
> +{
> +	trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, LCB_F_WRITE));
> +
> +	/* wait to be given the lock */
> +	for (;;) {
> +		set_current_state(state);
> +		if (!smp_load_acquire(&waiter->task)) {
> +			/* Matches rwsem_waiter_wake()'s smp_store_release(). */
> +			break;
> +		}
> +		if (signal_pending_state(state, current)) {
> +			raw_spin_lock_irq(&sem->wait_lock);
> +			if (waiter->task)
> +				goto out_nolock;
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			/* Ordered by sem->wait_lock against rwsem_mark_wake(). */
> +			break;
> +		}
> +		schedule_preempt_disabled();
> +		lockevent_inc(waiter_type(waiter, rwsem_sleep_reader, rwsem_sleep_writer));
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +	lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
> +	trace_contention_end(sem, 0);
> +	return sem;
> +
> +out_nolock:
> +	rwsem_del_wake_waiter(sem, waiter);
> +	__set_current_state(TASK_RUNNING);

Similar to boqun's comment, we should move __set_current_state() before 
rwsem_del_wake_waiter().

Unfortunately, lockevent_inc() doesn't work with waiter_type() like that 
as the compilation will fail if CONFIG_LOCK_EVENT_COUNTS is enabled.  
Could you include the attached patch in your series and make the 
following changes?

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index deb0d016a6ce..5b14b0d076fd 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1021,13 +1021,14 @@ static inline void rwsem_cond_wake_waiter(struct 
rw_semaphore *sem, long count,
         rwsem_mark_wake(sem, wake_type, wake_q);
  }

-#define waiter_type(_waiter, _r, _w)   \
-       ((_waiter)->type == RWSEM_WAITING_FOR_READ ? (_r) : (_w))
+#define waiter_type(_reader, _r, _w)   ((_reader) ? (_r) : (_w))

  static __always_inline struct rw_semaphore *
  rwsem_waiter_wait(struct rw_semaphore *sem, struct rwsem_waiter 
*waiter, int state)
  {
-       trace_contention_begin(sem, waiter_type(waiter, LCB_F_READ, 
LCB_F_WRITE));
+       bool reader = waiter->type == RWSEM_WAITING_FOR_READ;
+
+       trace_contention_begin(sem, waiter_type(reader, LCB_F_READ, 
LCB_F_WRITE));

         /* wait to be given the lock */
         for (;;) {
@@ -1045,18 +1046,18 @@ rwsem_waiter_wait(struct rw_semaphore *sem, 
struct rwsem_waiter *waiter, int sta
                         break;
                 }
                 schedule_preempt_disabled();
-               lockevent_inc(waiter_type(waiter, rwsem_sleep_reader, 
rwsem_sleep_writer));
+               lockevent_cond_inc2(reader, rwsem_sleep_reader, 
rwsem_sleep_writer);
         }

         __set_current_state(TASK_RUNNING);
-       lockevent_inc(waiter_type(waiter, rwsem_rlock, rwsem_wlock));
+       lockevent_cond_inc2(reader, rwsem_rlock, rwsem_wlock);
         trace_contention_end(sem, 0);
         return sem;

  out_nolock:
         rwsem_del_wake_waiter(sem, waiter);
         __set_current_state(TASK_RUNNING);
-       lockevent_inc(waiter_type(waiter, rwsem_rlock_fail, 
rwsem_wlock_fail));
+       lockevent_cond_inc2(reader, rwsem_rlock_fail, rwsem_wlock_fail);
         trace_contention_end(sem, -EINTR);
         return ERR_PTR(-EINTR);
  }

Thanks,
Longman

lockevent_inc

--------------L1fi1h6cQLywMen5qReHDFEZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-locking-lock_events-Add-a-new-lockevent_cond_inc2-he.patch"
Content-Disposition: attachment;
 filename*0="0001-locking-lock_events-Add-a-new-lockevent_cond_inc2-he.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0OTBmYjE1MzAwNjk0MWVjN2I1NzZjOWU4OWNiMjIwYTA3MzlhOTVjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29t
PgpEYXRlOiBUaHUsIDIzIEZlYiAyMDIzIDE3OjMyOjA2IC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gbG9ja2luZy9sb2NrX2V2ZW50czogQWRkIGEgbmV3IGxvY2tldmVudF9jb25kX2luYzIo
KSBoZWxwZXIKCkFkZCBhIG5ldyBsb2NrZXZlbnRfY29uZF9pbmMyKGNvbmQsIHRydWVfZXZl
bnQsIGZhbHNlX2V2ZW50KSBoZWxwZXIKdG8gY29uZGl0aW9uYWxseSBpbmNyZW1lbnQgb25l
IG9mIHRoZSAyIGdpdmVuIGV2ZW50cy4KClNpZ25lZC1vZmYtYnk6IFdhaW1hbiBMb25nIDxs
b25nbWFuQHJlZGhhdC5jb20+Ci0tLQoga2VybmVsL2xvY2tpbmcvbG9ja19ldmVudHMuaCB8
IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEva2VybmVsL2xvY2tpbmcvbG9ja19ldmVudHMuaCBiL2tlcm5lbC9s
b2NraW5nL2xvY2tfZXZlbnRzLmgKaW5kZXggOGM3ZTdkMjVmMDljLi42NjhjMmYxMzk3ZjYg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9sb2NraW5nL2xvY2tfZXZlbnRzLmgKKysrIGIva2VybmVs
L2xvY2tpbmcvbG9ja19ldmVudHMuaApAQCAtNDMsNiArNDMsMjEgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIF9fbG9ja2V2ZW50X2luYyhlbnVtIGxvY2tfZXZlbnRzIGV2ZW50LCBib29sIGNv
bmQpCiAjZGVmaW5lIGxvY2tldmVudF9pbmMoZXYpCSAgX19sb2NrZXZlbnRfaW5jKExPQ0tF
VkVOVF8gIyNldiwgdHJ1ZSkKICNkZWZpbmUgbG9ja2V2ZW50X2NvbmRfaW5jKGV2LCBjKSBf
X2xvY2tldmVudF9pbmMoTE9DS0VWRU5UXyAjI2V2LCBjKQogCisvKgorICogSW5jcmVtZW50
IGVpdGhlciB0aGUgdGV2ZW50IChjb25kIHRydWUpIG9yIGZldmVudCAoY29uZCBmYWxzZSkK
KyAqLworc3RhdGljIGlubGluZSB2b2lkIF9fbG9ja2V2ZW50X2NvbmRfaW5jMihib29sIGNv
bmQsIGVudW0gbG9ja19ldmVudHMgdGV2ZW50LAorCQkJCSAgICAgICAgIGVudW0gbG9ja19l
dmVudHMgZmV2ZW50KQoreworCWlmIChjb25kKQorCQlyYXdfY3B1X2luYyhsb2NrZXZlbnRz
W3RldmVudF0pOworCWVsc2UKKwkJcmF3X2NwdV9pbmMobG9ja2V2ZW50c1tmZXZlbnRdKTsK
KworfQorI2RlZmluZSBsb2NrZXZlbnRfY29uZF9pbmMyKGMsIHRldiwgZmV2KQlcCisJX19s
b2NrZXZlbnRfY29uZF9pbmMyKGMsIExPQ0tFVkVOVF8gIyN0ZXYsIExPQ0tFVkVOVF8gIyNm
ZXYpCisKIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2xvY2tldmVudF9hZGQoZW51bSBsb2NrX2V2
ZW50cyBldmVudCwgaW50IGluYykKIHsKIAlyYXdfY3B1X2FkZChsb2NrZXZlbnRzW2V2ZW50
XSwgaW5jKTsKQEAgLTU1LDYgKzcwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fbG9ja2V2
ZW50X2FkZChlbnVtIGxvY2tfZXZlbnRzIGV2ZW50LCBpbnQgaW5jKQogI2RlZmluZSBsb2Nr
ZXZlbnRfaW5jKGV2KQogI2RlZmluZSBsb2NrZXZlbnRfYWRkKGV2LCBjKQogI2RlZmluZSBs
b2NrZXZlbnRfY29uZF9pbmMoZXYsIGMpCisjZGVmaW5lIGxvY2tldmVudF9jb25kX2luYzIo
YywgdGV2LCBmZXYpCiAKICNlbmRpZiAvKiBDT05GSUdfTE9DS19FVkVOVF9DT1VOVFMgKi8K
ICNlbmRpZiAvKiBfX0xPQ0tJTkdfTE9DS19FVkVOVFNfSCAqLwotLSAKMi4zMS4xCgo=

--------------L1fi1h6cQLywMen5qReHDFEZ--

