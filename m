Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC06982D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBOSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOSCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:02:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0327D6E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:02:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA9DA33A99;
        Wed, 15 Feb 2023 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676484125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qvpaDE7pP9kYrxJJ/rFu8B2/wCkV0YkxUTGhw9OFfY=;
        b=uZRe8M604r6nQ4mhNI+blWC+aFNOJo4PAFkCQ6tZFiad3g3cym+kiU7xS6AYkyXZmHS/e3
        93Qh0K98IUH8AXRG8Yr7xulZMECI3vMGLsp7fESkEzViuOW/hwO96L6NgLU6YtbrXPtuPc
        NvaOpw9QFYZy6kyZpAKlLSn0SL0u7sA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E3F3134BA;
        Wed, 15 Feb 2023 18:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id szucIR0e7WP0ZgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Feb 2023 18:02:05 +0000
Date:   Wed, 15 Feb 2023 19:02:04 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/5] workqueue: Warn when a new worker could not be created
Message-ID: <20230215180204.GP1757@blackbody.suse.cz>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mpb+VUhBqKoEsre9"
Content-Disposition: inline
In-Reply-To: <20230201134543.13687-3-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mpb+VUhBqKoEsre9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Feb 01, 2023 at 02:45:40PM +0100, Petr Mladek <pmladek@suse.com> wrote:
>    + the system reached PID limit
or threads-max limit.

FTR, I was once considering something like

--->8---
diff --git a/kernel/fork.c b/kernel/fork.c
index 867b46d6fd0a..bba05ecc3765 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1684,8 +1684,10 @@ static __latent_entropy struct task_struct *copy_process(
         * to stop root fork bombs.
         */
        retval = -EAGAIN;
-       if (nr_threads >= max_threads)
+       if (nr_threads >= max_threads) {
+               printk_once(KERN_INFO "clone failed due to threads-max limit\n");
                goto bad_fork_cleanup_count;
+       }

        delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
        p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
@@ -1816,6 +1818,7 @@ static __latent_entropy struct task_struct *copy_process(
        if (pid != &init_struct_pid) {
                pid = alloc_pid(p->nsproxy->pid_ns_for_children);
                if (IS_ERR(pid)) {
+                       printk_once(KERN_INFO "fork failed to find pid\n");
                        retval = PTR_ERR(pid);
                        goto bad_fork_cleanup_thread;
                }
--->8---

Effects of the global limits on anything but kthreads should be much less
important and easier to troubleshoot anyway.
Covering kworkers with your changes should be useful and substitute my idea
above. Take that as my support for this patch (from my perspective reporting
*_once would be enough to guide a troubleshooter).

Thanks,
Michal



--mpb+VUhBqKoEsre9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+0eGAAKCRAkDQmsBEOq
udq6AQDJHBf9yqR7SzRvyYs0R3i6CkLEF38vzQGxlJtWN/jIIAEA9SXWqtC+MDbm
0AsyAyjDR1MosTpj7KN+jnFU592eYgQ=
=9OTT
-----END PGP SIGNATURE-----

--mpb+VUhBqKoEsre9--
