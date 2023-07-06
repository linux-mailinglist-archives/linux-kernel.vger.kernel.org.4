Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93294749E90
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjGFOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGFOFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:05:46 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A51BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:05:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:44850)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHPbv-00FFkD-Ij; Thu, 06 Jul 2023 08:05:31 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42136 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHPbu-007MP1-At; Thu, 06 Jul 2023 08:05:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, brgerst@gmail.com
References: <20230706052231.2183-1-xin3.li@intel.com>
Date:   Thu, 06 Jul 2023 09:05:22 -0500
In-Reply-To: <20230706052231.2183-1-xin3.li@intel.com> (Xin Li's message of
        "Wed, 5 Jul 2023 22:22:31 -0700")
Message-ID: <87v8exgmot.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qHPbu-007MP1-At;;;mid=<87v8exgmot.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/GHU/enSRgZM3J+lB0AWqM08S41uJozwc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Xin Li <xin3.li@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 663 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 0.86 (0.1%),
         extract_message_metadata: 11 (1.7%), get_uri_detail_list: 1.49 (0.2%),
         tests_pri_-2000: 4.6 (0.7%), tests_pri_-1000: 2.4 (0.4%),
        tests_pri_-950: 1.21 (0.2%), tests_pri_-900: 0.96 (0.1%),
        tests_pri_-200: 0.78 (0.1%), tests_pri_-100: 4.6 (0.7%),
        tests_pri_-90: 284 (42.9%), check_bayes: 274 (41.3%), b_tokenize: 6
        (1.0%), b_tok_get_all: 7 (1.1%), b_comp_prob: 2.1 (0.3%),
        b_tok_touch_all: 254 (38.3%), b_finish: 1.18 (0.2%), tests_pri_0: 280
        (42.3%), check_dkim_signature: 0.74 (0.1%), check_dkim_adsp: 9 (1.4%),
        poll_dns_idle: 48 (7.2%), tests_pri_10: 2.1 (0.3%), tests_pri_500: 55
        (8.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Li <xin3.li@intel.com> writes:

> When a null selector is to be loaded into a segment register,
> reload_segments() sets its DPL bits to 3. Later when an IRET
> instruction loads it, it zeros the segment register. The two
> operations offset each other to actually effect a nop.
>
> Fix it by not modifying the DPL bits for a null selector.

Maybe this is the right thing but this needs some serious comments
about what is going on.

In particular how does sel <= 3 equate to a null selector?  Is that
defined somewhere?  At a minimum you should have static asserts to make
certain no one redefines the first 4 segment selectors as anything else,
if you want to refer to them by number instead of testing for specific
properties.

As written this looks like it requires an enormous amount of knowledge
about how other parts of the code works, to be comprehensible or to
change safely.  That level of non-local knowledge should be unnecessary.

Eric


> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/kernel/signal_32.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index 9027fc088f97..7796cf84fca2 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
> @@ -36,22 +36,27 @@
>  #ifdef CONFIG_IA32_EMULATION
>  #include <asm/ia32_unistd.h>
>  
> +static inline u16 usrseg(u16 sel)
> +{
> +	return sel <= 3 ? sel : sel | 3;
> +}
> +
>  static inline void reload_segments(struct sigcontext_32 *sc)
>  {
>  	unsigned int cur;
>  
>  	savesegment(gs, cur);
> -	if ((sc->gs | 0x03) != cur)
> -		load_gs_index(sc->gs | 0x03);
> +	if (usrseg(sc->gs) != cur)
> +		load_gs_index(usrseg(sc->gs));
>  	savesegment(fs, cur);
> -	if ((sc->fs | 0x03) != cur)
> -		loadsegment(fs, sc->fs | 0x03);
> +	if (usrseg(sc->fs) != cur)
> +		loadsegment(fs, usrseg(sc->fs));
>  	savesegment(ds, cur);
> -	if ((sc->ds | 0x03) != cur)
> -		loadsegment(ds, sc->ds | 0x03);
> +	if (usrseg(sc->ds) != cur)
> +		loadsegment(ds, usrseg(sc->ds));
>  	savesegment(es, cur);
> -	if ((sc->es | 0x03) != cur)
> -		loadsegment(es, sc->es | 0x03);
> +	if (usrseg(sc->es) != cur)
> +		loadsegment(es, usrseg(sc->es));
>  }
>  
>  #define sigset32_t			compat_sigset_t
