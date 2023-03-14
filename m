Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A26B989F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCNPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCNPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444685B2A;
        Tue, 14 Mar 2023 08:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB65617E0;
        Tue, 14 Mar 2023 15:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C66EC433D2;
        Tue, 14 Mar 2023 15:12:16 +0000 (UTC)
Date:   Tue, 14 Mar 2023 11:12:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Heinz Wiesinger <pprkut@slackware.com>, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rjendra@quicinc.com, quic_saipraka@quicinc.com,
        quic_sibis@quicinc.com
Subject: Re: [PATCH] bootconfig: Fix testcase to increase max node
Message-ID: <20230314111213.08f33839@gandalf.local.home>
In-Reply-To: <167871576880.783280.2390717518955954275.stgit@devnote2>
References: <167871576880.783280.2390717518955954275.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 22:56:09 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -87,10 +88,16 @@ xfail grep -i "error" $OUTFILE
>  
>  echo "Max node number check"
>  
> -echo -n > $TEMPCONF
> -for i in `seq 1 1024` ; do
> -   echo "node$i" >> $TEMPCONF

Do you need this extra file?

> -done
> +cat > $AWKFILE << EOF
> +BEGIN {
> +  for (i = 0; i < 26; i += 1)
> +      printf("%c\n", 65 + i % 26)
> +  for (i = 26; i < 8192; i += 1)
> +      printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
> +}
> +EOF
> +awk -f "$AWKFILE" > $TEMPCONF

Couldn't the above just be:

awk '
	BEGIN {
		for (i = 0; i < 26; i += 1)
			printf("%c\n", 65 + i % 26)
		for (i = 26; i < 8192; i += 1)
			printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
	}
' > $TEMPCONF

and not need the extra file?

-- Steve


>  xpass $BOOTCONF -a $TEMPCONF $INITRD
>  
>  echo "badnode" >> $TEMPCONF

