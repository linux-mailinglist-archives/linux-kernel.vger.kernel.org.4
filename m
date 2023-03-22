Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDE6C4E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCVOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:48:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EA69217
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jo4szZ4FZcTQ+zI+smakOHqo+Q6smmJ4l5cIPdumn/Y=; b=f0L1C07DEYVBTLW160fPMk8G3J
        BscFktQ/PN0rta7oVdlKWTvsbPvyADPog47HHmCz5br5qSSjPh6n/VN2BL5zolOUBlNGj2Ak/XxLo
        74WMK6Kb0hITbNi2MRngKfnW0ni6Fz0vrlPBfDZWK/fBY+yo3nGDjYpoL5j4xK05ukpzvxcKYogdj
        69wcpfBRTPJfkKZZbxN7HvvwqRYK0s/56cvOB0gKRGDzAVNGhaKkCr+UUZWx+rB1kuCahB9UtaNaX
        0+2HAxtoHCH265pS9xFh3mbKWE2RmGLGEqOL4U7l9FpGiuYg8INnSD/PpRA6o7+plf6ridGBgno3W
        EunR2Kkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pezik-004ZrU-2H;
        Wed, 22 Mar 2023 14:45:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7207430035F;
        Wed, 22 Mar 2023 15:45:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E0F3201FFA49; Wed, 22 Mar 2023 15:45:45 +0100 (CET)
Date:   Wed, 22 Mar 2023 15:45:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Message-ID: <20230322144545.GE2357380@hirez.programming.kicks-ass.net>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:00:15PM -0700, Josh Poimboeuf wrote:
> + *   or using static_call_update() with a NULL function pointer. In both cases
> + *   the HAVE_STATIC_CALL implementation will patch the trampoline with a RET
> +*    instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
> +*    architectures can patch the trampoline call to a NOP.
>   *
>   *   In all cases, any argument evaluation is unconditional. Unlike a regular
>   *   conditional function pointer call:

you wrecked the indent there ;-)
