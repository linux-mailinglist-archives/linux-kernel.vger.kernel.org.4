Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405BC653247
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiLUOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:14:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06FE16;
        Wed, 21 Dec 2022 06:14:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF938B81B5D;
        Wed, 21 Dec 2022 14:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F6C433F0;
        Wed, 21 Dec 2022 14:14:38 +0000 (UTC)
Date:   Wed, 21 Dec 2022 09:14:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <20221221091435.5ed368cb@gandalf.local.home>
In-Reply-To: <20221114-disable-kexec-reset-v4-3-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
        <20221114-disable-kexec-reset-v4-3-ab809c8d988c@chromium.org>
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

On Wed, 21 Dec 2022 13:50:03 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> @@ -941,6 +995,20 @@ static struct ctl_table kexec_core_sysctls[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "kexec_load_limit_panic",
> +		.data		= &load_limit_panic,
> +		.maxlen		= sizeof(load_limit_panic),

If I understand the sysctl logic correctly, the .maxlen is the maxlen of
the input to the sysctl, and not the data. Usually set to sizeof(data)
because most proc_handlers write to data directly.

In this case, I believe it's not even used (you override it with the
struct ctl_table tmp). I guess it doesn't really matter what it's set to.
Perhaps just set it to zero and leave it out?

> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
> +	{
> +		.procname	= "kexec_load_limit_reboot",
> +		.data		= &load_limit_reboot,
> +		.maxlen		= sizeof(load_limit_reboot),

Same here.

-- Steve

> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
>  	{ }
>  };
>  
