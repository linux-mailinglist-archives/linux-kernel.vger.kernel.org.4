Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FF686EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBATZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBATZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:25:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF383051;
        Wed,  1 Feb 2023 11:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62E2AB8228B;
        Wed,  1 Feb 2023 19:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AF5C433D2;
        Wed,  1 Feb 2023 19:25:32 +0000 (UTC)
Date:   Wed, 1 Feb 2023 14:25:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/6] rtla/osnoise: Add helper functions to manipulate
 osnoise/options
Message-ID: <20230201142530.61b5ac00@gandalf.local.home>
In-Reply-To: <930c4ef71c7bcb1158d2a8cad905f4de425b8d1e.1675181734.git.bristot@kernel.org>
References: <cover.1675181734.git.bristot@kernel.org>
        <930c4ef71c7bcb1158d2a8cad905f4de425b8d1e.1675181734.git.bristot@kernel.org>
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

On Tue, 31 Jan 2023 17:30:02 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> +#define	OSNOISE_OPTION(name, option_str)						\
> +static int osnoise_get_##name(struct osnoise_context *context)				\
> +{											\
> +	if (context->opt_##name != OSNOISE_OPTION_INIT_VAL)				\
> +		return context->opt_##name;						\
> +											\
> +	if (context->orig_opt_##name != OSNOISE_OPTION_INIT_VAL)			\
> +		return context->orig_opt_##name;					\
> +											\
> +	context->orig_opt_##name = osnoise_options_get_option(option_str);		\
> +											\
> +	return context->orig_opt_##name;						\
> +}											\
> +											\

What you could have done is not make this into a super macro (as there's
only one instance of it). And then add a patch that turns it into this
macro as the first patch of a series that adds another user.

Because I don't understand why this exists when it only has one user.

-- Steve
