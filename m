Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5362CA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiKPUPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKPUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:15:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BAC1F2EA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC0061F89
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB46C433C1;
        Wed, 16 Nov 2022 20:15:25 +0000 (UTC)
Date:   Wed, 16 Nov 2022 15:16:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, ribalda@google.com,
        zwisler@google.com, robdclark@gmail.com,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
Message-ID: <20221116151610.7294a9e8@gandalf.local.home>
In-Reply-To: <20221116195624.124092-1-joel@joelfernandes.org>
References: <20221116195624.124092-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 19:56:24 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
>  	} else
>  #endif
>  	{
> +		error = freeze_processes();
> +		if (error) {
> +			error = -EBUSY;
> +			goto Unlock;
> +		}

If this is the path of a kernel panic, do we really want to check the
return error of freeze_processes()? We are panicing, there's not much more
we can do.

-- Steve


> +
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
