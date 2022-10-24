Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52560A449
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiJXMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiJXMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:05:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED87D7B3;
        Mon, 24 Oct 2022 04:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B2FEB811A6;
        Mon, 24 Oct 2022 11:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B172EC433C1;
        Mon, 24 Oct 2022 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612224;
        bh=G+CUiQUJ1bZrDrtFfptsL95qRNAeWuDsQo98fY38vHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lboxBCI1uZp7dqHyNgbq/Tsb1EzRMKiAXaoJGxoX2Lic709NQpDfLIIp2TTHsJY5o
         K1LK82nj9+J/j46Zb7zYIqy6uNToxFlPMa+zv5z6Oy8K2CzM3caJhCuaSmJYIjESns
         TdzHLr2SKKWLmzXjAOzxKc44f0VgWVixqbA1Vdz7/zyhq0j5ICE0Jq5VIsEJ5oOua0
         tuyV0w9Km5yYLSK0UpDLSwtHgKQK4PJ/pOYv2sPnOhN3SRsEI1YHxMXNE0Le2ij89L
         YO6d0a4vhFIfIRNzKq+8TDuEdI4PhlMJSNX218lx4lJkg5YtTchd8MWN9YSoFyPLD9
         0cBD0wixZYJgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B966A404BE; Mon, 24 Oct 2022 08:50:21 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:50:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf daemon: Check err before calling
 setup_server_config in __cmd_start
Message-ID: <Y1Z7/U0ld3QBSHol@kernel.org>
References: <20221022092735.114967-1-yangjihong1@huawei.com>
 <20221022092735.114967-2-yangjihong1@huawei.com>
 <Y1Z7JB/4t8sEJkV/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Z7JB/4t8sEJkV/@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 08:46:44AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Oct 22, 2022 at 05:27:33PM +0800, Yang Jihong escreveu:
> > If err!=0 before calling setup_server_config and reconfig==true,
> > setup_server_config function may return 0 and err becomes 0.
> > As a result, previous error is overwritten, need to check value of err first.

Applied patches 2 and 3 meanwhile, thanks.

- Arnaldo

> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >  tools/perf/builtin-daemon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 6cb3f6cc36d0..b82bd902602a 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -1333,7 +1333,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> >  			if (fda.entries[signal_pos].revents & POLLIN)
> >  				err = handle_signalfd(daemon) < 0;
> >  
> > -			if (reconfig)
> > +			if (!err && reconfig)
> >  				err = setup_server_config(daemon);
> >  		}
> 
> Expanding the context a bit:
> 
>         while (!done && !err) {
>                 err = daemon__reconfig(daemon);
> 
>                 if (!err && fdarray__poll(&fda, -1)) {
>                         bool reconfig = false;
> 
>                         if (fda.entries[sock_pos].revents & POLLIN)
>                                 err = handle_server_socket(daemon, sock_fd);
>                         if (fda.entries[file_pos].revents & POLLIN)
>                                 err = handle_config_changes(daemon, conf_fd, &reconfig);
>                         if (fda.entries[signal_pos].revents & POLLIN)
>                                 err = handle_signalfd(daemon) < 0;
> 
>                         if (!err && reconfig)
>                                 err = setup_server_config(daemon);
>                 }
>         }
> 
> The err you're checking may be the last one, that may have overwritten
> 'err' from handle_config_changes(), perhaps moving things around helps?
> I.e.:
>                 if (!err && fdarray__poll(&fda, -1)) {
>                         bool reconfig = false;
> 
>                         if (fda.entries[sock_pos].revents & POLLIN)
>                                 err = handle_server_socket(daemon, sock_fd);
>                         if (fda.entries[signal_pos].revents & POLLIN)
>                                 err = handle_signalfd(daemon) < 0;
>                         if (fda.entries[file_pos].revents & POLLIN)
>                                 err = handle_config_changes(daemon, conf_fd, &reconfig);
> 
>                         if (!err && reconfig)
>                                 err = setup_server_config(daemon);
>                 }
> 
> 
> ?
> 
> Jiri?
> 
> - Arnaldo
> 
> >  	}
> > -- 
> > 2.30.GIT
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
