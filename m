Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FD6BB5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjCOOWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjCOOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CDE69CEC;
        Wed, 15 Mar 2023 07:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 514A961DC1;
        Wed, 15 Mar 2023 14:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB2C433EF;
        Wed, 15 Mar 2023 14:22:36 +0000 (UTC)
Date:   Wed, 15 Mar 2023 10:22:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Heinz Wiesinger <pprkut@slackware.com>, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rjendra@quicinc.com, quic_saipraka@quicinc.com,
        quic_sibis@quicinc.com
Subject: Re: [PATCH v2] bootconfig: Fix testcase to increase max node
Message-ID: <20230315102232.0a67e109@gandalf.local.home>
In-Reply-To: <167888844790.791176.670805252426835131.stgit@devnote2>
References: <167888844790.791176.670805252426835131.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 22:54:08 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit 6c40624930c5 ("bootconfig: Increase max nodes of bootconfig
> from 1024 to 8192 for DCC support") increased the max number of bootconfig
> node to 8192, the bootconfig testcase of the max number of nodes fails.
> To fix this issue, we can not simply increase the number in the test script
> because the test bootconfig file becomes too big (>32KB). To fix that, we
> can use a combination of three alphabets (26^3 = 17576). But with that,
> we can not express the 8193 (just one exceed from the limitation) because
> it also exceeds the max size of bootconfig. So, the first 26 nodes will just
> use one alphabet.
> 
> With this fix, test-bootconfig.sh passes all tests.
> 
> Reported-by: Heinz Wiesinger <pprkut@slackware.com>
> Link: https://lore.kernel.org/all/2463802.XAFRqVoOGU@amaterasu.liwjatan.org
> Fixes: 6c40624930c5 ("bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  tools/bootconfig/test-bootconfig.sh |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index f68e2e9eef8b..a2c484c243f5 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -87,10 +87,14 @@ xfail grep -i "error" $OUTFILE
>  
>  echo "Max node number check"
>  
> -echo -n > $TEMPCONF
> -for i in `seq 1 1024` ; do
> -   echo "node$i" >> $TEMPCONF
> -done
> +awk '
> +BEGIN {
> +  for (i = 0; i < 26; i += 1)
> +      printf("%c\n", 65 + i % 26)
> +  for (i = 26; i < 8192; i += 1)
> +      printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
> +}
> +' > $TEMPCONF
>  xpass $BOOTCONF -a $TEMPCONF $INITRD
>  
>  echo "badnode" >> $TEMPCONF

