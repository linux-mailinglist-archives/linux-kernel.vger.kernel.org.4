Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823FF65C8FB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjACVgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjACVgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:36:09 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1F12D19
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 13:36:07 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35338)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pCox2-00DQGM-KE; Tue, 03 Jan 2023 14:36:04 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:38124 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pCox1-009hFk-GF; Tue, 03 Jan 2023 14:36:04 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Clement Leger <clement.leger@bootlin.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
        <20230103164359.24347-3-ysionneau@kalray.eu>
Date:   Tue, 03 Jan 2023 15:35:28 -0600
In-Reply-To: <20230103164359.24347-3-ysionneau@kalray.eu> (Yann Sionneau's
        message of "Tue, 3 Jan 2023 17:43:36 +0100")
Message-ID: <875ydnmhcv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pCox1-009hFk-GF;;;mid=<875ydnmhcv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18zTivb3taYGRDictjAGoI8aGmfYtFodes=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Yann Sionneau <ysionneau@kalray.eu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 564 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 10 (1.7%), parse: 0.91
        (0.2%), extract_message_metadata: 31 (5.5%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-2000: 35 (6.1%), tests_pri_-1000: 2.5 (0.4%),
        tests_pri_-950: 1.28 (0.2%), tests_pri_-900: 1.05 (0.2%),
        tests_pri_-200: 0.89 (0.2%), tests_pri_-100: 15 (2.6%), tests_pri_-90:
        93 (16.4%), check_bayes: 80 (14.2%), b_tokenize: 10 (1.7%),
        b_tok_get_all: 10 (1.8%), b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 54
        (9.6%), b_finish: 0.99 (0.2%), tests_pri_0: 346 (61.4%),
        check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 14 (2.6%),
        poll_dns_idle: 1.02 (0.2%), tests_pri_10: 3.2 (0.6%), tests_pri_500:
        20 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 02/25] kvx: Add ELF-related definitions
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yann Sionneau <ysionneau@kalray.eu> writes:

> Add ELF-related definitions for kvx, including: EM_KVX,
> AUDIT_ARCH_KVX and NT_KVX_TCA.

Has someone written an SYSVABI architecture specification for
your architecture?

I feel uncomfortable with the linux-kernel headers being the
authoritative place for the ELF abi definitions.

Especially since the linux kernel does not deal with relocations,
and the kernel headers could diverge from the real world and no one
would notice..

I know at least at one point the linux standards base was taking
up the work on collecting up some of these definitions.  I would
be happy if there was anything outside of the linux kernel that
people could refer too.

Eric

> CC: Paul Moore <paul@paul-moore.com>
> CC: Eric Paris <eparis@redhat.com>
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: linux-audit@redhat.com
> CC: linux-kernel@vger.kernel.org
> CC: linux-mm@kvack.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  include/uapi/linux/audit.h  | 1 +
>  include/uapi/linux/elf-em.h | 1 +
>  include/uapi/linux/elf.h    | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index d676ed2b246e..4db7aa3f84c7 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -402,6 +402,7 @@ enum {
>  #define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
>  #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_KVX		(EM_KVX|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_M32R		(EM_M32R)
>  #define AUDIT_ARCH_M68K		(EM_68K)
>  #define AUDIT_ARCH_MICROBLAZE	(EM_MICROBLAZE)
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index ef38c2bc5ab7..9cc348be7f86 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -51,6 +51,7 @@
>  #define EM_RISCV	243	/* RISC-V */
>  #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
>  #define EM_CSKY		252	/* C-SKY */
> +#define EM_KVX		256	/* Kalray VLIW Architecture */
>  #define EM_LOONGARCH	258	/* LoongArch */
>  #define EM_FRV		0x5441	/* Fujitsu FR-V */
>  
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c7b056af9ef0..49094f3be06c 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -444,6 +444,7 @@ typedef struct elf64_shdr {
>  #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
>  #define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
>  #define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
> +#define NT_KVX_TCA		0x900	/* kvx TCA registers */
>  
>  /* Note types with note name "GNU" */
>  #define NT_GNU_PROPERTY_TYPE_0	5
