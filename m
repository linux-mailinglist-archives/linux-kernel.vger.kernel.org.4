Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F05F9ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiJJMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiJJMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA251A23
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665405773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZsgFIaUtMtPOAUv6onkZwQ4ROTArLHZaqizv0UA7y8=;
        b=d7Xu1VY2eaKwpd7NBPP5uslkoZdpjWJHqCtysBG2qNOMEKyV8Hxcb9ch1vaBWLgsB+x4Nd
        3q4ohQj1eUTSVMNjme5rlIDF9PIPx5i+My3Yhmx8Cafo/qvyvgBepwYCv3KAiSKrhwFKWY
        SON8aqORJddJ2nFM0VHXMcngXzL2SZQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-JZ7A8OJQM6CxKAIYT4lcFg-1; Mon, 10 Oct 2022 08:42:48 -0400
X-MC-Unique: JZ7A8OJQM6CxKAIYT4lcFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEDEB3803903;
        Mon, 10 Oct 2022 12:42:47 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DBA541136E5;
        Mon, 10 Oct 2022 12:42:44 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        David.Laight@ACULAB.COM, carlos@redhat.com,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v4 01/25] rseq: Introduce feature size and alignment ELF
 auxiliary vector entries
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
        <20220922105941.237830-2-mathieu.desnoyers@efficios.com>
Date:   Mon, 10 Oct 2022 14:42:42 +0200
In-Reply-To: <20220922105941.237830-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Thu, 22 Sep 2022 06:59:16 -0400")
Message-ID: <877d1726kd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Export the rseq feature size supported by the kernel as well as the
> required allocation alignment for the rseq per-thread area to user-space
> through ELF auxiliary vector entries.
>
> This is part of the extensible rseq ABI.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  fs/binfmt_elf.c             | 5 +++++
>  include/uapi/linux/auxvec.h | 2 ++
>  include/uapi/linux/rseq.h   | 5 +++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 63c7ebb0da89..04fca1e4cbd2 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -46,6 +46,7 @@
>  #include <linux/cred.h>
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
> +#include <linux/rseq.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>=20=20
> @@ -288,6 +289,10 @@ create_elf_tables(struct linux_binprm *bprm, const s=
truct elfhdr *exec,
>  	if (bprm->have_execfd) {
>  		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
>  	}
> +#ifdef CONFIG_RSEQ
> +	NEW_AUX_ENT(AT_RSEQ_FEATURE_SIZE, offsetof(struct rseq, end));
> +	NEW_AUX_ENT(AT_RSEQ_ALIGN, __alignof__(struct rseq));
> +#endif
>  #undef NEW_AUX_ENT
>  	/* AT_NULL is zero; clear the rest too */
>  	memset(elf_info, 0, (char *)mm->saved_auxv +
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index c7e502bf5a6f..6991c4b8ab18 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -30,6 +30,8 @@
>  				 * differ from AT_PLATFORM. */
>  #define AT_RANDOM 25	/* address of 16 random bytes */
>  #define AT_HWCAP2 26	/* extension of AT_HWCAP */
> +#define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
> +#define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
>=20=20
>  #define AT_EXECFN  31	/* filename of program */

Do we need the alignment?  Or can we keep it perpetually at 32?  Or we
could steal some bits from AT_RSEQ_FEATURE_SIZE?  (Not the lower
bits=E2=80=94they aren't unused due to the way the feature size works.)

Thanks,
Florian

