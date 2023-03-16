Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046706BC75F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCPHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCPHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A948B133;
        Thu, 16 Mar 2023 00:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B4D61E4A;
        Thu, 16 Mar 2023 07:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B5C4339B;
        Thu, 16 Mar 2023 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678952300;
        bh=+4jwn3QqZ5K5vGm+sbwhzx/Jn1cyBnPfG3vpqKKXsmg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cdW2fMN2ZLL/SuMZxHU/G/Mg5aUZYSnbPiknVKkfgBARpbJe2/uatL21nvBTqNKKD
         VMOyv1HwmW4ynDhC27BFX37vUOnNpudwCKx0EbMZYtCdH3Gbibgbxyx2PZoCd1q3KQ
         JKL2DzCa3mVpHq5eWUS1JsUr3XjDOBOajs6dWWzlxn3eRmJCZhxQCSY5tZoJWzTOal
         nVPhEK2r0FhETU095ZTle7eh8yRj4yZ1XRnKJJokRJ0nUebd8QgBJ1fVuCNKKpn0EF
         vMPmpWt5abfBEfrXftCXgGTbrbOyRHTnaO/0L2QY5nt7eZ8NbUcFJVmJFrEgePSAoy
         C8pErrXVyCaaQ==
Message-ID: <4620911e-6fd5-542e-15d8-7849cc60780b@kernel.org>
Date:   Thu, 16 Mar 2023 08:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/14] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-3-joel@joelfernandes.org>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230315181902.4177819-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 19:18, Joel Fernandes (Google) wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> avoid accidental use of the single-argument forms, which can introduce
> functionality bugs in atomic contexts and latency bugs in non-atomic
> contexts.
> 
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/trace/trace_osnoise.c | 2 +-
>  kernel/trace/trace_probe.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 04f0fdae19a1..f68ca1e6460f 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -159,7 +159,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
>  	if (!found)
>  		return;
>  
> -	kvfree_rcu(inst);
> +	kvfree_rcu_mightsleep(inst);
>  }
>  
>  /*

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
