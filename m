Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC46BAA34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCOH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCOH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C442BCE;
        Wed, 15 Mar 2023 00:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED3561BDD;
        Wed, 15 Mar 2023 07:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFF9C433EF;
        Wed, 15 Mar 2023 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678867148;
        bh=vRFR481Q9774JGel+N5ZkZPT18QV5YRBoXfvxt1cumY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KcpVndpJ8/eCcRy26ZDTUjvEX040VPQs2cXEpNU5dnmaiN/nUoUS/z6GYvMmy5wm7
         Jqk36hLkhsvNuB40Q0+XYVAQ66E+z3lrgkeR1vgfC/VU1lirwRIP4iMmwmJj/DaENm
         7oypyGwzoZPtjGIu1tfA5PtzTWCPNmUhc0eRItCYxUKMmASDev/C8cx/fTQOiQ6Q5u
         jjXz73thMqRZO/dhRFG9vAGItnJSG1gHPtN9Q0tpnIXtZkoKkt/B2RJZ/7vdcEFL+P
         9YU4lRfVp5WlLrvoN1+JwyvNl51UGMlcIyVOiFZ2FtCirH034xozA/9yMI/CUnaGzn
         VWOW7UlgJDSFA==
Date:   Wed, 15 Mar 2023 16:59:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Heinz Wiesinger <pprkut@slackware.com>, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rjendra@quicinc.com, quic_saipraka@quicinc.com,
        quic_sibis@quicinc.com
Subject: Re: [PATCH] bootconfig: Fix testcase to increase max node
Message-Id: <20230315165905.4bb2a464b2ffe4fb640cfbdd@kernel.org>
In-Reply-To: <20230314111213.08f33839@gandalf.local.home>
References: <167871576880.783280.2390717518955954275.stgit@devnote2>
        <20230314111213.08f33839@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 11:12:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 13 Mar 2023 22:56:09 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -87,10 +88,16 @@ xfail grep -i "error" $OUTFILE
> >  
> >  echo "Max node number check"
> >  
> > -echo -n > $TEMPCONF
> > -for i in `seq 1 1024` ; do
> > -   echo "node$i" >> $TEMPCONF
> 
> Do you need this extra file?
> 
> > -done
> > +cat > $AWKFILE << EOF
> > +BEGIN {
> > +  for (i = 0; i < 26; i += 1)
> > +      printf("%c\n", 65 + i % 26)
> > +  for (i = 26; i < 8192; i += 1)
> > +      printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
> > +}
> > +EOF
> > +awk -f "$AWKFILE" > $TEMPCONF
> 
> Couldn't the above just be:
> 
> awk '
> 	BEGIN {
> 		for (i = 0; i < 26; i += 1)
> 			printf("%c\n", 65 + i % 26)
> 		for (i = 26; i < 8192; i += 1)
> 			printf("%c%c%c\n", 65 + i % 26, 65 + (i / 26) % 26, 65 + (i / 26 / 26))
> 	}
> ' > $TEMPCONF
> 
> and not need the extra file?

Indeed. Let me update this.

Thank you!

> 
> -- Steve
> 
> 
> >  xpass $BOOTCONF -a $TEMPCONF $INITRD
> >  
> >  echo "badnode" >> $TEMPCONF
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
