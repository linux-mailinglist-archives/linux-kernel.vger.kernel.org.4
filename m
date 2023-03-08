Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F756B098F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCHNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCHNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:38:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A35980F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678282567; i=efault@gmx.de;
        bh=k0E1MFsw2CN+UHoFRqid3pqzDlRv4RPi3OLq48WTOJA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=QUSy3uHratAhmKgRSEsxnCi8n4LcJuFQN5i6PTi66ITHdMVELvo6lvtGqUHCp5Qfp
         64cKEMCUYagQNT8lG1MHEHrea5r+9b7ex4n+g9feKMHeNjFrc1eQ7yPT8e33qgJihX
         S73dHTa5TW669ehf8+HapgEJgWBvhphYtJBdY9BKYHm1f60/b8ZmBoxukk5xNk/7Cy
         kPxIy0VovOITrZjWruuqOGy1+ISwmnrhoK3ApWyqSS6H6tGYinc1qk7cfaSOLXvQ2r
         nN9OYoPVciiWDu5p2r/4UW63Uf1XfVmj+p0HyCcfPHFxLfOz3yN+Cmd2ftC5IxYnBu
         Nzs/bHSU6BvMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.250]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1qETVi3tBc-00esIc; Wed, 08
 Mar 2023 14:36:07 +0100
Message-ID: <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Wed, 08 Mar 2023 14:36:01 +0100
In-Reply-To: <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLeYb8WLCeYTC3yAZPdN//lpkvy0IlQPdBYRo79DNTjg0zwHDYO
 kKkPsp9t9agda9z8iKgy0o+EtjCdYPqZxoAE0kZRwRRM1PP8nGZYtePanh3obBhMYRoI3qi
 VaD9gKjt2A/7RM5dwZ+V/7Ec4ZMZsoT+7fuWQCOpEmjGwSK1bwy7LcyuOqVMljKgPE4wv8L
 D4oz/Ha3r+0Tx9RLgq7tA==
UI-OutboundReport: notjunk:1;M01:P0:khPj6n4i1q4=;GpJcHbgKEgv4BSiCUynICIsGSC/
 C7Zv44rywrwh40WmjXzhkU0hfayiRmnNmB74eLDgvUugl1oImgLC8oqjLuG7l4jOM82Byjkve
 J2Y9yog7AJxWRrdDYe/Vj7lY7Lb9qFfTzO93iLC+JralH623CnzhwUwd+7EeoDcFE2TyFo1q+
 5ILY5+BCJtv6a+XICb1ip9B+uhxhx4MPwonnripCTHs8j8pjp3IVaBP4ztyrok7McxLFbn66M
 cHkSK5CYIu6m33xx7otw0BpD+eqAblu9Z8YGcbBNVbdm+PtuaClfWClBSsmjyg5pGeLxOnZLe
 h1nEG+FDpVMuRjXSXI6JXiLKYY/fgGma22N36Y3RaiMbtZpUlbtVfs6f6GEpuYb8PYkwv9F4j
 n5QwtjoVym0oBGjDDgZCfKLdrRmv0EQ83sy6HF8o7KgzsJ+WkAysA/uqsspe1BLFNaP+wvP6A
 LT8WDv7nsjKtVsGO1a2KahMQ60xEy028btYCz55MRhf6zFRY/G4snIB2Dyrgr7jvm4S0i/PnE
 5QCf//j3QA0Z+MbLroDQDda+pVWuJvjjpwQ51NLPjE8MXLauryOlPs1Pfqbg+L0l7yGAroJds
 DOsJZCICRj7JLDY3G123T6VjCYHdnUm/KqHEl4D3eXM41OdTzbj+Fqt+faLq+KiH/IcGSMtRQ
 R/8Se5FS6ohjU/j8jKDh8BSgWvpS6rGFAgrcqRD7s7BQvEtdQQQ2tY9FoWFcc1qojyWnX/ubr
 thjGkfgASVlZe36oa2b+tpHafT9mqdXoHPFFIrYyG510IXBjimibi6qZoeFinwjqXh8CXpUR8
 FR+V95RUVA/9Y/j/XHe+8jcZ3qWXskjv0UBIXudG5tr2NmQL54eaxH/qOhTJUezqLiW9gmEzy
 0Gv95Lgj7ueICBo7BoXa7UpD1yo9+d/6gbnBfbaVzfmuLAkhl+kryilcoNpaSaP90lo1flJFy
 7tMBvDstYaQSPVDpmVSEzYkECzg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 09:39 +0100, Mike Galbraith wrote:
>
> Curiosity got the best of me...

Remember this little bugger, allegedly distilled from a real
application control thread starvation issue?

6.3.0.g8ca09d5-master
homer:/root # time taskset -c 3 starve
expecting to receive 10000000 signals

real    0m24.424s
user    0m4.468s
sys     0m18.957s

6.3.0.g8ca09d5-eevdf
homer:/root # time taskset -c 3 starve
expecting to receive 10000000 signals
zzzzzz
^C

real    15m24.115s
user    0m3.078s
sys     0m0.000s


#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/wait.h>

volatile unsigned long loop;

void handler(int n)
{
	if (loop > 0)
		--loop;
}

static int child(void)
{
	pid_t ppid =3D getppid();

	sleep(1);
	while (1)
		kill(ppid, SIGUSR1);
	return 0;
}

int main(int argc, char **argv)
{
	pid_t child_pid;
	int r;

	loop =3D argc > 1 ? strtoul(argv[1], NULL, 10) : 10000000;
	printf("expecting to receive %lu signals\n", loop);

	if ((child_pid =3D fork()) =3D=3D 0)
		exit(child());

	signal(SIGUSR1, handler);
	while (loop)
		sleep(1);
	r =3D kill(child_pid, SIGTERM);
	waitpid(child_pid, NULL, 0);
	return 0;
}

