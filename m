Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238B46CB0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC0VtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC0Vsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7859D9;
        Mon, 27 Mar 2023 14:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 543CE6151F;
        Mon, 27 Mar 2023 21:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86892C4339B;
        Mon, 27 Mar 2023 21:48:46 +0000 (UTC)
Date:   Mon, 27 Mar 2023 17:48:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <20230327174844.15305988@gandalf.local.home>
In-Reply-To: <ZBnKKZsSpI8aAk9W@pc636>
References: <20230321102748.127923-1-urezki@gmail.com>
        <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
        <ZBnKKZsSpI8aAk9W@pc636>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 16:15:53 +0100
Uladzislau Rezki <urezki@gmail.com> wrote:

> Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> Next problem is how to parse it. Of course you will not be able to parse
> megabytes of traces. For that purpose i use a special C trace parser.
> If you need an example please let me know i can show here.

Not sure if you are familiar with trace-cmd, but the above could have been:

 # trace-cmd record -e rcu sleep 10

and then you get the trace.dat file, which reports as:

 # trace-cmd report

If you need special parsing, there's a libtracecmd library that lets you do
all that!

  https://www.trace-cmd.org/Documentation/libtracecmd/

And for parsing events:

  https://www.trace-cmd.org/Documentation/libtraceevent/


Basically have:

struct my_info {
	/* store state info here */
};

int main(...) {
	struct tracecmd_input *handle;
	struct my_info info;
	char *file = argv[1];

	handle = tracecmd_open(file);

	tracecmd_follow_event(handle, "rcu", "rcu_batch_start",
			batch_start, &info);

	tracecmd_follow_event(handle, "rcu", "rcu_batch_end",
			batch_end, &info);

	tracecmd_follow_event(handle, "rcu", "rcu_invoke_callback",
			invoke_callback, &info);

	tracecmd_iterate_events(handle, NULL, 0, NULL, NULL);

	tracecmd_close(handle);
}

Where it will iterate the "trace.dat" file passed it, and every time it
hits an event registered by follow_event it will call that function:

static int batch_start(struct tracecmd_input *handle, struct tep_event *event,
		struct tep_record *record, int cpu, void *data)
{
	struct my_info *info = data;

	info->start_timestamp = record->ts;

	return 0;
}

static int batch_end(struct tracecmd_input *handle, struct tep_event *event,
		struct tep_record *record, int cpu, void *data)
{
	struct my_info *info = data;


	printf("time = %lld -> %lld\n", info->start_timestapm,
				record->ts);
	return 0;
}

static int invoke_callback(struct tracecmd_input *handle, struct tep_event *event,
		struct tep_record *record, int cpu, void *data)
{
	struct my_info *info = data;
	struct tep_handle *tep = tracecmd_get_tep(handle);
	static struct tep_format_field *ip_field;
	unsigned long long ip;
	const char *func;
	int pid;

	if (!ip_field)
		ip_field = tep_find_field(event, "func");

	tep_read_number_field(ip_field, record->data, &ip);
	func = tep_find_function(tep, ip);

	pid = tep_data_pid(tep, record);

	if (func)
		printf("Processing function %s for pid %d\n", func, pid);
	else
		printf("Processing address 0x%llx for pid %d\n", ip, pid);

	return 0;
}


And much more ;-)

Oh, and if you just want to read the live trace without recording, you
could always use libtracefs:

 https://www.trace-cmd.org/Documentation/libtracefs/

And instead of using tracecmd_follow_event() with
tracecmd_iterate_events(), you can use:

	const char *systems = { "rcu" };

	tep = tracefs_local_events_systems(NULL, systems);

	tracefs_follow_event(tep, NULL, "rcu", "rcu_invoke_callback",
			invoke_callback, &info);

and iterate the live events with:

	tracefs_iterate_raw_events(tep, NULL, NULL, 0, NULL, NULL);


With the callback for this being (very similar):

static int invoke_callback(struct tep_event *event,
		struct tep_record *record, int cpu, void *data)
{
	struct my_info *info = data;
	struct tep_handle *tep = event->tep;
	static struct tep_format_field *ip_field;
	unsigned long long ip;
	const char *func;
	int pid;

	if (!ip_field)
		ip_field = tep_find_field(event, "func");

	tep_read_number_field(ip_field, record->data, &ip);
	func = tep_find_function(tep, ip);

	pid = tep_data_pid(tep, record);

	if (func)
		printf("Processing function %s for pid %d\n", func, pid);
	else
		printf("Processing address 0x%llx for pid %d\n", ip, pid);

	return 0;
}


-- Steve
