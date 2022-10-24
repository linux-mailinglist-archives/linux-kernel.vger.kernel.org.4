Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F860B01C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJXQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiJXP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7A23BC6;
        Mon, 24 Oct 2022 07:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CD0AB81132;
        Mon, 24 Oct 2022 11:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FC2C433D7;
        Mon, 24 Oct 2022 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612007;
        bh=pnOGLgH5gRMhfwXAarsnMQ3g6BWpSzwCy+mhmsk2EMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOPpq5aKDQ88/zqFaqTpYtPq+stRELuPZzsaq3OXBW0/1lq/4asmRAjoc2ezoLGhG
         R4thXBh7vuS0C1ZTx1+RFAxYJ7HzWqK8uiUB5p6/DLGN+SY+gM7Jd2JJ467lKH63D3
         iDxBulvQVtdjgm9rXo+bKNXro8Y5P2wK4Be0nvQYZUO3AvFBs8dphBGvR+VgbF7PRU
         y19AqoRVZlRBJETLvt97Af2A/4KDHh9NqAHYQIZeq0N31Kn6dT3E7dQfClEm4LHEPG
         aKpnTlkwi+GXl9yMWNYoqcMEDWl3CP90jZtEPsI8dwge58+A08Ph/PKByRb68lNxEq
         T2y5XDuU+wF2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E003B404BE; Mon, 24 Oct 2022 08:46:44 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:46:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf daemon: Check err before calling
 setup_server_config in __cmd_start
Message-ID: <Y1Z7JB/4t8sEJkV/@kernel.org>
References: <20221022092735.114967-1-yangjihong1@huawei.com>
 <20221022092735.114967-2-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022092735.114967-2-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 22, 2022 at 05:27:33PM +0800, Yang Jihong escreveu:
> If err!=0 before calling setup_server_config and reconfig==true,
> setup_server_config function may return 0 and err becomes 0.
> As a result, previous error is overwritten, need to check value of err first.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 6cb3f6cc36d0..b82bd902602a 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1333,7 +1333,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  			if (fda.entries[signal_pos].revents & POLLIN)
>  				err = handle_signalfd(daemon) < 0;
>  
> -			if (reconfig)
> +			if (!err && reconfig)
>  				err = setup_server_config(daemon);
>  		}

Expanding the context a bit:

        while (!done && !err) {
                err = daemon__reconfig(daemon);

                if (!err && fdarray__poll(&fda, -1)) {
                        bool reconfig = false;

                        if (fda.entries[sock_pos].revents & POLLIN)
                                err = handle_server_socket(daemon, sock_fd);
                        if (fda.entries[file_pos].revents & POLLIN)
                                err = handle_config_changes(daemon, conf_fd, &reconfig);
                        if (fda.entries[signal_pos].revents & POLLIN)
                                err = handle_signalfd(daemon) < 0;

                        if (!err && reconfig)
                                err = setup_server_config(daemon);
                }
        }

The err you're checking may be the last one, that may have overwritten
'err' from handle_config_changes(), perhaps moving things around helps?
I.e.:
                if (!err && fdarray__poll(&fda, -1)) {
                        bool reconfig = false;

                        if (fda.entries[sock_pos].revents & POLLIN)
                                err = handle_server_socket(daemon, sock_fd);
                        if (fda.entries[signal_pos].revents & POLLIN)
                                err = handle_signalfd(daemon) < 0;
                        if (fda.entries[file_pos].revents & POLLIN)
                                err = handle_config_changes(daemon, conf_fd, &reconfig);

                        if (!err && reconfig)
                                err = setup_server_config(daemon);
                }


?

Jiri?

- Arnaldo

>  	}
> -- 
> 2.30.GIT

-- 

- Arnaldo
