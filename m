Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5E731301
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbjFOJEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbjFOJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65541FCC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686819842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaTSzitIpa5FU8GhGJUOowmMnFGdZBSv3GY+LLgvqd4=;
        b=TH/IvQR7tBDAIlmMqIRzi5gZzz928mHn6HtatHQNbL5C+LzV2zzrC39/UjEMyzEDm9PHBN
        nzgVvYGvVzv30R9hPUHOvcvPtrNXlJuzAFnWJiTufUKe0GcBhHaIb70+EgSKCQ+p+JWs3c
        3tF1v2AV2igRsdCvbwNq9rjltCFxLDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-uy7OXsghMvGuV55MU0K69Q-1; Thu, 15 Jun 2023 05:03:58 -0400
X-MC-Unique: uy7OXsghMvGuV55MU0K69Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4634101A592;
        Thu, 15 Jun 2023 09:03:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30C109E9C;
        Thu, 15 Jun 2023 09:03:57 +0000 (UTC)
Date:   Thu, 15 Jun 2023 10:03:56 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Gusenleitner Klaus <gus@keba.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ tick.
 -- regression report
Message-ID: <20230615090356.GD10301@redhat.com>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx>
 <20230406150254.ZrawA2Y-@linutronix.de>
 <87jzypq6gq.ffs@tglx>
 <20230418122639.ikgfvu3f@linutronix.de>
 <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:59:46AM +0200, Mathias Krause wrote:
> This patch causes VM boot hangs for us. It took a while to identify as 
> the boot hangs were only ~1 out of 30 but it's clearly it. Reverting 
> the commit got me 100 boots in a row without any issue.

FWIW I have quite a nice test program for catching these sorts of boot
hangs, see attached.  You need to change the VMLINUX define to point
to your vmlinux or vmlinuz file.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bootbootboot.c"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <error.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pthread.h>

#define NR_ITERATIONS 10000
#define MAX_THREADS 8
#define MAX_TIME 60 /* max time to wait for qemu to complete */

//#define VMLINUX "/home/rjones/d/linux/vmlinux"
#define VMLINUX "vmlinux"
//#define QEMU "/home/rjones/d/qemu/build/qemu-system-x86_64"
#define QEMU "qemu-system-x86_64"
#define QEMU_COMMAND \
  QEMU " -no-user-config -nodefaults -display none " \
  "-machine accel=kvm:tcg,graphics=off -cpu max,la57=off -m 1280 " \
  "-no-reboot " \
  "-rtc driftfix=slew -no-hpet -global kvm-pit.lost_tick_policy=discard " \
  "-kernel " VMLINUX " " \
  "-serial stdio " \
  "-append \"panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 selinux=0 TERM=xterm-256color\""

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
static unsigned iterations;

static void *start_thread (void *);

int
main (int argc, char *argv[])
{
	long n, i;
	int r;
	pthread_t thread[MAX_THREADS];

	n = sysconf (_SC_NPROCESSORS_ONLN);
	if (n == -1) error (EXIT_FAILURE, errno, "sysconf");

	if (n > MAX_THREADS)
		n = MAX_THREADS;

	for (i = 0; i < n; ++i) {
		r = pthread_create (&thread[i], NULL, start_thread, NULL);
		if (r != 0) error (EXIT_FAILURE, r, "pthread_create");
	}
	for (i = 0; i < n; ++i) {
		r = pthread_join (thread[i], NULL);
		if (r != 0) error (EXIT_FAILURE, r, "pthread_join");
	}
	printf ("\n");
	printf ("\n");
	printf ("test ok\n");
	exit (EXIT_SUCCESS);
}

static void *
start_thread (void *vp)
{
	pid_t pid;
	char tmp[] = "/tmp/kernel.out.XXXXXX";
	char cmd[1024];
	int i, r, status;

	if (mkstemp (tmp) == -1)
		error (EXIT_FAILURE, errno, "mkstemp: %s", tmp);

	snprintf (cmd, sizeof cmd, QEMU_COMMAND " >& %s", tmp);

	/* This basically runs a loop starting qemu. */
	for (;;) {
		pthread_mutex_lock (&lock);
		if (iterations >= NR_ITERATIONS) {
			pthread_mutex_unlock (&lock);
			return NULL;
		}
		if (iterations <= MAX_THREADS) { // stagger the start times
			pthread_mutex_unlock (&lock);
			usleep (rand () % 3000000);
			pthread_mutex_lock (&lock);
		}
		iterations++;
		printf ("%d... ", iterations); fflush (stdout);
		pthread_mutex_unlock (&lock);

		pid = fork ();
		if (pid == -1) error (EXIT_FAILURE, errno, "fork");
		if (pid == 0) {
			/* Child process, run qemu and wait. */
			if (system (cmd) != 0)
				_exit (EXIT_FAILURE);
			else
				_exit (EXIT_SUCCESS);
		}

		/* In the parent wait up to MAX_TIME seconds. */
		for (i = 0; i < MAX_TIME; ++i) {
			r = waitpid (pid, &status, WNOHANG);
			if (r == -1) error (EXIT_FAILURE, errno, "waitpid");
			if (r > 0) break;
			sleep (1);
		}

		if (i == MAX_TIME || status != 0) {
			/* Something failed in qemu (or it didn't
			 * exit), dump the whole log and exit with
			 * error.
			 */
			printf ("\n");
			printf ("\n");
			snprintf (cmd, sizeof cmd, "tail -20 %s", tmp);
			system (cmd);
			fprintf (stderr, "*** ERROR OR HANG ***\n");
			exit (EXIT_FAILURE);
		}
	}

	unlink (tmp);
}

--eJnRUKwClWJh1Khz--

