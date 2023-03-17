Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691276BEB57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCQOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCQOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:33:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98761AA7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CEDB825D1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4115BC433A1;
        Fri, 17 Mar 2023 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679063607;
        bh=53j9p3OHoAI+PGZYPMlMcpu+VNaa0nVHUAUhmn0hpxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gf57b+Y3HNie1X1+4Ctks74ZjmyS0VjcUpN+TPomNk67GXHJX6MKBJclB7q/ypmZY
         8yqWTGEx7M2iDRFwCCce9Bf03X+MT057qFKBGmZvu1r9EbjdOE8rSsx2tFY+RU9qxt
         gK9JyMqmoOcuDwJxQlp6pmm5ZSAt78V4l6KsGoCo=
Date:   Fri, 17 Mar 2023 15:33:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Thomas Heim <questioneight@gmail.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: extract a fxn to improve clarity
Message-ID: <ZBR6MZifQBMLV8Ps@kroah.com>
References: <20230317141756.GA43753@pikachu-Z97-D3H>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317141756.GA43753@pikachu-Z97-D3H>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 08:17:56AM -0600, Mark Thomas Heim wrote:
> The gb_audio_gb_get_topology function at the top of the file
> needs to be split per a TODO comment above the function. It
> is necessary to refactor the code to pull out a method
> that has fewer parameters to improve readability. A
> prototype for the new function is now in the relevant header,
> and the simpler function calls replace the old ones.

Note, you have a full 72 characters to use for a changelog, please use
the whole line.

And what is "fxn" in the subject line?  Ironic you use an abbreviation
when trying to improve clarity :)

> Signed-off-by: Mark Thomas Heim <questioneight@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.h |  2 ++
>  drivers/staging/greybus/audio_gb.c    | 21 +++++++++++----------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index ce15e800e607..a2e8361952b8 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -177,6 +177,8 @@ int gbaudio_register_module(struct gbaudio_module_info *module);
>  void gbaudio_unregister_module(struct gbaudio_module_info *module);
>  
>  /* protocol related */
> +int fetch_gb_audio_data(struct gb_connection *connection, int type,
> +			void *response, int response_size);

Why is this a global function?

And why if it is a global function, are you not using the gb_audio_*
prefix?  Be aware of the global namespace please.

>  int gb_audio_gb_get_topology(struct gb_connection *connection,
>  			     struct gb_audio_topology **topology);
>  int gb_audio_gb_get_control(struct gb_connection *connection,
> diff --git a/drivers/staging/greybus/audio_gb.c b/drivers/staging/greybus/audio_gb.c
> index 9d8994fdb41a..3c924d13f0e7 100644
> --- a/drivers/staging/greybus/audio_gb.c
> +++ b/drivers/staging/greybus/audio_gb.c
> @@ -8,7 +8,13 @@
>  #include <linux/greybus.h>
>  #include "audio_codec.h"
>  
> -/* TODO: Split into separate calls */
> +int fetch_gb_audio_data(struct gb_connection *connection,
> +			int type, void *response, int response_size)
> +{
> +	return gb_operation_sync(connection, type, NULL, 0,
> +				 response, response_size);
> +}
> +
>  int gb_audio_gb_get_topology(struct gb_connection *connection,
>  			     struct gb_audio_topology **topology)
>  {
> @@ -17,28 +23,23 @@ int gb_audio_gb_get_topology(struct gb_connection *connection,
>  	u16 size;
>  	int ret;
>  
> -	ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
> -				NULL, 0, &size_resp, sizeof(size_resp));
> +	ret = fetch_gb_audio_data(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
> +				  &size_resp, sizeof(size_resp));

What are you actually changing here besides the name?

How did this fix up the TODO at all?

confused,

greg k-h
