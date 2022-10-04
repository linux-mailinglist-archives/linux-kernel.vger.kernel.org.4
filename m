Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4815F49BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJDT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:28:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0299696D2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:28:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so398099pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xjSo2INdaTUjWFOLlUFz9Rasj3EDdp7SsPRO7zAKVVs=;
        b=AA++EJmO9JQQ6GdYSvziU2tKo81E6app2ZDepTKSIa/VguooGRqwVI5G2F851r0WpO
         L8yGm6c/8lN9gfZmKfAIWb4cjc15A8YKbAeXGUiyBIN9TldTglijNwWIqlV/U+mALKe2
         cPNWygdNgkXFxnhba14nlGPOoPwjndmJqGlAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xjSo2INdaTUjWFOLlUFz9Rasj3EDdp7SsPRO7zAKVVs=;
        b=kxUTr/mjLbB4yjTMFIkTuKWNdzJm5cX9BQMg7EoLnLY/n3m3/FEwxliBKIF0vpAjJK
         vMlQnxo/1IC22d3JJ0OPv7OKElFHP0GZA+SEMCGXp9yd9Q6uCc1+XlplNmAfQGx9If71
         Kk89sIi6dCmHyrJ3VF6dLCoaVQ5C5NS0w1Uk2cJR2wocaD4Dh5zNGq4xbiND9o0+dPlv
         TVGR5GK9z08I/l+38jhZP9BPl61wWFzZ0meoRu3l3SnSrwWzikZPKK6FkowRqMO9r+Vk
         vAH5kIaRQhDgtBEoUotFwRne+/pGbJVeJik0ttFkihTD7NvlcTP3OlX+oBo2Zr7fUaAD
         brkA==
X-Gm-Message-State: ACrzQf2inU4rPCZsy/bI6fpQRb0sHZmhnBACvxtseODhWa6v1ZQmHkgy
        uu14Zp8/nmR0ZigBSJ1riDpdvg==
X-Google-Smtp-Source: AMsMyM7BZ7FoubiMglZTA4Hnux2eE6e+AF4FV9cOawzVfOhytIauVDbq6j9P8ocpr0bZp9iRJ222AQ==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr4531547pgl.410.1664911691390;
        Tue, 04 Oct 2022 12:28:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n3-20020a622703000000b0053e85a4a2c9sm6115840pfn.5.2022.10.04.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:28:10 -0700 (PDT)
Date:   Tue, 4 Oct 2022 12:28:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jann Horn <jannh@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>
Subject: Re: [PATCH v2 00/39] Shadowstacks for userspace
Message-ID: <202210041224.8B7071AAD@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <202210030946.CB90B94C11@keescook>
 <CAG48ez2TGdwcr-jUPm1EL1D6X2a-wbx+gXLZUq46qxO-FTctHQ@mail.gmail.com>
 <202210032158.CE0941C4D@keescook>
 <752d296b68f04c2282bd898cf7ec3f0f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752d296b68f04c2282bd898cf7ec3f0f@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:57:48AM +0000, David Laight wrote:
> From: Kees Cook <keescook@chromium.org>
> ...
> > >
> > > If you don't want /proc/$pid/mem to be able to do stuff like that,
> > > then IMO the way to go is to change when /proc/$pid/mem uses
> > > FOLL_FORCE, or to limit overall write access to /proc/$pid/mem.
> > 
> > Yeah, all reasonable. I just wish we could ditch FOLL_FORCE; it continues
> > to weird me out how powerful that fd's side-effects are.
> 
> Could you remove FOLL_FORCE from /proc/$pid/mem and add a
> /proc/$pid/mem_force that enable FOLL_FORCE but requires root
> (or similar) access.
> 
> Although I suspect gdb may like to have write access to
> code?

As Jann has reminded me out of band, while FOLL_FORCE is still worrisome,
it's really /proc/$pid/mem access at all without an active ptrace
attachment (and to self).

Here's my totally untested idea to require access to /proc/$pid/mem
having an established ptrace relationship:

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index c952c5ba8fab..0393741eeabb 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,6 +64,7 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
 #define PTRACE_MODE_NOAUDIT	0x04
 #define PTRACE_MODE_FSCREDS	0x08
 #define PTRACE_MODE_REALCREDS	0x10
+#define PTRACE_MODE_ATTACHED	0x20
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..fadec587d133 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -826,7 +826,7 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 
 static int mem_open(struct inode *inode, struct file *file)
 {
-	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACHED);
 
 	/* OK to pass negative loff_t, we can catch out-of-range */
 	file->f_mode |= FMODE_UNSIGNED_OFFSET;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1893d909e45c..c97e6d734ae5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -304,6 +304,12 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 * or halting the specified task is impossible.
 	 */
 
+	/*
+	 * If an existing ptrace relationship is required, not even
+	 * introspection is allowed.
+	 */
+	if ((mode & PTRACE_MODE_ATTACHED) && ptrace_parent(task) != current)
+		return -EPERM;
 	/* Don't let security modules deny introspection */
 	if (same_thread_group(task, current))
 		return 0;

-- 
Kees Cook
