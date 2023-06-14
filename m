Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE773061B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFNRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CE12A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686764073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAXXvSnFs/Po7rny8aWKtEVp5uqN8B8FKxx/CoYzPWc=;
        b=BaakpkbTbwqCg/TN1S8sCk3rJRaF1HXkjkq8TpAB0YmI2diu775+RL1CWpTXN8Ra7x4fNf
        52YONTrNWwKY2VXdWKtVP65RsgiztgPqN9A8+zwIQgFcqMOx2NJ9X+a6DotavosxGIAUIf
        YEIp3P0l7Vav1bauTB+F9aqdpj693qE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-Ty9R975wOD29qWXd9yh9Ug-1; Wed, 14 Jun 2023 13:34:31 -0400
X-MC-Unique: Ty9R975wOD29qWXd9yh9Ug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50CBB1C0754B;
        Wed, 14 Jun 2023 17:34:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEB50492CA6;
        Wed, 14 Jun 2023 17:34:30 +0000 (UTC)
Date:   Wed, 14 Jun 2023 18:34:30 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614173430.GB10301@redhat.com>
References: <20230614103953.GM7912@redhat.com>
 <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
 <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
 <20230614153108.GC1640563@hirez.programming.kicks-ass.net>
 <20230614155016.GI7636@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20230614155016.GI7636@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


FWIW attached is a test program that runs the qemu instances in
parallel (up to 8 threads), which seems to be a quicker way to hit the
problem for me.  Even on Intel, with this test I can hit the bug in a
few hundred iteration.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

--opJtzjQTFsWo+cga
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

--opJtzjQTFsWo+cga--

