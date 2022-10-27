Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E560FCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiJ0QKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiJ0QKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:10:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA5646E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bs14so3375793ljb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TE3cF0mw0pliGS33L8WCWsjoAKodOQ0aEEbBLS35gEA=;
        b=LSTO3MG8PFUwo1K2U5EbkAGHDC/vgeZ5jlbNGqOwlTeHizDaVhrLMl563UdOJ26Dmu
         xMRXXmEtRGIqJNdZ6hzrKdpWJ5W+UWC2tnCsfgGMEdEPuosXM1yXqz7Y18PI4blAx1QO
         /IoZQme5G7D/HQuU9/FvQgpYT60EkFcscIJf5DydD3OhIfbx3/XOkBOTsiHRetyrjgMK
         VfGx/chzBa1HeMgqhCy37no8LI3Fa22UKh1TnwJc5LaotWJSYFxvt/0xY8NygtTgz5Cq
         P5ojPM/TsAU3fKo2W2cCra8JfxjJvPMOGkvIkWMHN/AH3ikSQ1Rh3aIG8buAdOeZPCpe
         lGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TE3cF0mw0pliGS33L8WCWsjoAKodOQ0aEEbBLS35gEA=;
        b=qkgxjtbIfDJ3tX4Wjs/Pj1w1optI/vJWtdy2MrZZBw2d6VSPrpOtij2kRmbiZ3wp2z
         6T9/xF9dELpOsL6L0pfK848mpjbCrMNHLIfp4Wlwvf+Vnc0IyY8iMP3rYJOgaPwlfiZ5
         /G7iNQGHPoHc8k0LUbJuSDqqIRfBWfXm8xauHnqk+a1jgzZf4qHZD3LluXEFnWwedyRV
         +QZTBk9vtpiTbbFAxR+WiRU6kkDFFXSGzarQumcz6r9hK02do0B5+LoK5jQTobQ5xvkY
         EU2Zma6eDJ/hmEX9tq+bBRuEselHyO1ARFfKmWG3fZ403xe0AAt2qXP5BVRTiC99xTd5
         Db5Q==
X-Gm-Message-State: ACrzQf3zgij5CT1BK+7BhPWyHW+Eqifv8qR6/fVlNCTpJjtmPhKLma90
        Z/rpMqK36oI1Jiwu0t6EnLbRBo+V/CvisY8EvrbiaQ==
X-Google-Smtp-Source: AMsMyM573hFTMp8fbXvHmeFaiLrHKhsXKKdjfRDRu7xeSmu35yi+JAD4ZXBGoG20oSgYIDqjO6wfGKdiPppXmhhlz/w=
X-Received: by 2002:a2e:58e:0:b0:277:9f5:3538 with SMTP id 136-20020a2e058e000000b0027709f53538mr8446535ljf.445.1666887006729;
 Thu, 27 Oct 2022 09:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com> <20221024224657.2917482-3-dionnaglaze@google.com>
In-Reply-To: <20221024224657.2917482-3-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 27 Oct 2022 10:09:55 -0600
Message-ID: <CAMkAt6qFiF2J+eBu0kv77yJyLbiKjs5cjsa4Qg6zVeR1AKuy3A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] x86/sev: Change snp_guest_issue_request's fw_err
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:47 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
>
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's previous unsigned long*.
> The signature change requires the follow-up change to
> drivers/virt/coco/sev-guest to use the new expected type in order to
> compile.
>
> The firmware might not even be called, so we bookend the call with the
> no firmware call error and clearing the error.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  arch/x86/include/asm/sev.h |  4 ++--
>  arch/x86/kernel/sev.c      | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..8ebd78b6a57c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>  void snp_set_wakeup_secondary_cpu(void);
>  bool snp_init(struct boot_params *bp);
>  void __init __noreturn snp_abort(void);
> -int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -217,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
>  static inline bool snp_init(struct boot_params *bp) { return false; }
>  static inline void snp_abort(void) { }
>  static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
> -                                         unsigned long *fw_err)
> +                                         u64 *exitinfo2)
>  {
>         return -ENOTTY;
>  }

In another thread Borislav suggested we edit snp_issue_guest_request()
to take a parameter struct pointer instead of a long list of args.
Should we use the opportunity to do this instead of making this list
longer?
