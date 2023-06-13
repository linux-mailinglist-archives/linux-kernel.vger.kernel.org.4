Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8F72E60E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjFMOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjFMOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:42:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7DE55;
        Tue, 13 Jun 2023 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1ZebDa7Kz76JvAh7re62vgIonWyfZe/pNIHd3eKVHuo=; b=fCCXvj9aHuxjbZny0qIfOV5tQF
        PQnP9RE4hpKI7jkXarKXiUMhvJ/pHxCtMDBjrloK1BKOKsrmr2EjJAL7Oi1NbPc1GtbaVzEj3QepZ
        Pxsl79tkv9u6+GmWV4waiHMg4OhUdhlC2VHYgNYhcppjRsWElrGJQd7cGuYnwTkqKQG4j+gkGR9PC
        aXQG0wD7AgJhs7AMHRDLFwmOHuY8EyAn5DfSb2Vuj72qO/5b94cZ4DlzsMjB/00oNz4o/K95H9BDe
        a5VEE+/2VsjAlt1t3bv5O8/67Tb5OA8nlHuAdQ7nOzUr6MJx/ULtM1K7ubIxZTc/XEgrQZZRUj1uh
        6vfKiS7w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q95Du-008MOX-1D;
        Tue, 13 Jun 2023 14:42:18 +0000
Message-ID: <a3952f99-7ae9-8f8f-d87a-713690cbe1fb@infradead.org>
Date:   Tue, 13 Jun 2023 07:42:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] rcuscale: fix building with RCU_TINY
Content-Language: en-US
To:     paulmck@kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609120522.3921015-1-arnd@kernel.org>
 <9fd81723-4ba2-4a0b-a7da-f9fb121021de@paulmck-laptop>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9fd81723-4ba2-4a0b-a7da-f9fb121021de@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul-

On 6/9/23 15:51, Paul E. McKenney wrote:
> On Fri, Jun 09, 2023 at 02:05:14PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Both the CONFIG_TASKS_RCU and CONFIG_TASKS_RUDE_RCU options
>> are broken when RCU_TINY is enabled as well, as some functions
>> are missing a declaration.
>>
>> In file included from kernel/rcu/update.c:649:
>> kernel/rcu/tasks.h:1271:21: error: no previous prototype for 'get_rcu_tasks_rude_gp_kthread' [-Werror=missing-prototypes]
>>  1271 | struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
>>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/rcu/rcuscale.c:330:27: error: 'get_rcu_tasks_rude_gp_kthread' undeclared here (not in a function); did you mean 'get_rcu_tasks_trace_gp_kthread'?
>>   330 |         .rso_gp_kthread = get_rcu_tasks_rude_gp_kthread,
>>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                           get_rcu_tasks_trace_gp_kthread
>>
>> In file included from /home/arnd/arm-soc/kernel/rcu/update.c:649:
>> kernel/rcu/tasks.h:1113:21: error: no previous prototype for 'get_rcu_tasks_gp_kthread' [-Werror=missing-prototypes]
>>  1113 | struct task_struct *get_rcu_tasks_gp_kthread(void)
>>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Also, building with CONFIG_TASKS_RUDE_RCU but not CONFIG_TASKS_RCU is
>> broken because of some missing stub functions:
>>
>> kernel/rcu/rcuscale.c:322:27: error: 'tasks_scale_read_lock' undeclared here (not in a function); did you mean 'srcu_scale_read_lock'?
>>   322 |         .readlock       = tasks_scale_read_lock,
>>       |                           ^~~~~~~~~~~~~~~~~~~~~
>>       |                           srcu_scale_read_lock
>> kernel/rcu/rcuscale.c:323:27: error: 'tasks_scale_read_unlock' undeclared here (not in a function); did you mean 'srcu_scale_read_unlock'?
>>   323 |         .readunlock     = tasks_scale_read_unlock,
>>       |                           ^~~~~~~~~~~~~~~~~~~~~~~
>>       |                           srcu_scale_read_unlock
>>
>> Move the declarations outside of the RCU_TINY #ifdef and duplicate the
>> shared stub functions to address all of the above.
>>
>> Fixes: 88d7ff818f0ce ("rcuscale: Add RCU Tasks Rude testing")
>> Fixes: 755f1c5eb416b ("rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Queued and pushed, thank you!
> 
> I clearly need to improve my Kconfig coverage here...
> 

Pushed where. I'm still seeing this build error in linux-next 20230613.

Thanks.

> 
>> ---
>>  kernel/rcu/rcu.h      | 14 ++++++++------
>>  kernel/rcu/rcuscale.c | 13 +++++++++++--
>>  2 files changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index 9829d8161b213..5befd8780dcd3 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -505,18 +505,20 @@ void rcu_async_relax(void);
>>  void rcupdate_announce_bootup_oddness(void);
>>  #ifdef CONFIG_TASKS_RCU_GENERIC
>>  void show_rcu_tasks_gp_kthreads(void);
>> -# ifdef CONFIG_TASKS_RCU
>> -struct task_struct *get_rcu_tasks_gp_kthread(void);
>> -# endif // # ifdef CONFIG_TASKS_RCU
>> -# ifdef CONFIG_TASKS_RUDE_RCU
>> -struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
>> -# endif // # ifdef CONFIG_TASKS_RUDE_RCU
>>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>>  static inline void show_rcu_tasks_gp_kthreads(void) {}
>>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>>  void rcu_request_urgent_qs_task(struct task_struct *t);
>>  #endif /* #else #ifdef CONFIG_TINY_RCU */
>>  
>> +#ifdef CONFIG_TASKS_RCU
>> +struct task_struct *get_rcu_tasks_gp_kthread(void);
>> +#endif // # ifdef CONFIG_TASKS_RCU
>> +
>> +#ifdef CONFIG_TASKS_RUDE_RCU
>> +struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
>> +#endif // # ifdef CONFIG_TASKS_RUDE_RCU
>> +
>>  #define RCU_SCHEDULER_INACTIVE	0
>>  #define RCU_SCHEDULER_INIT	1
>>  #define RCU_SCHEDULER_RUNNING	2
>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>> index 5ce3b4e7ce711..a0eae19007088 100644
>> --- a/kernel/rcu/rcuscale.c
>> +++ b/kernel/rcu/rcuscale.c
>> @@ -316,11 +316,20 @@ static struct rcu_scale_ops tasks_ops = {
>>   * Definitions for RCU-tasks-rude scalability testing.
>>   */
>>  
>> +static int tasks_rude_scale_read_lock(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void tasks_rude_scale_read_unlock(int idx)
>> +{
>> +}
>> +
>>  static struct rcu_scale_ops tasks_rude_ops = {
>>  	.ptype		= RCU_TASKS_RUDE_FLAVOR,
>>  	.init		= rcu_sync_scale_init,
>> -	.readlock	= tasks_scale_read_lock,
>> -	.readunlock	= tasks_scale_read_unlock,
>> +	.readlock	= tasks_rude_scale_read_lock,
>> +	.readunlock	= tasks_rude_scale_read_unlock,
>>  	.get_gp_seq	= rcu_no_completed,
>>  	.gp_diff	= rcu_seq_diff,
>>  	.async		= call_rcu_tasks_rude,
>> -- 
>> 2.39.2
>>

-- 
~Randy
