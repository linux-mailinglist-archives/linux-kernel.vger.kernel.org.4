Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAF6B6F58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMGCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:02:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D13E091;
        Sun, 12 Mar 2023 23:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B66B80DDF;
        Mon, 13 Mar 2023 06:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B67C433D2;
        Mon, 13 Mar 2023 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678687337;
        bh=QvN99wbsfsOdgiEtkZdCtrzsvmSned3arXSblYeg4zI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H4KB6v35P8uu5YE65R89Dha0tfPZtAIzs51PpXyyYrW/eb9Yf+ggajypFgbHyehmL
         Lz+Tn1SyWjGkhLeSK4HBvVh+mjpsefFljRgFDVmoqwADRzOvLoEj8zdJC4ckuecmk6
         z2FifxjJrVbOFPbqWp5c0idaZipEkqPQS8b9EfLoLfWg8AFPA8kqj0fZrSA6PYpHjL
         EIltdF5CTPbFVfUczzm4jSuDD9uuld0rgclCmEWnq+J4gvu9cArnlpxXbzsPNoXMqB
         s5kNVl5zZibmasjNxfDqQqxvqYVgZflg8LtTUqABVeyHUtEPiMz+UMikyJk+MK0Jiy
         86e7bzto4wchw==
Date:   Mon, 13 Mar 2023 15:02:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Heinz Wiesinger <pprkut@slackware.com>
Cc:     quic_schowdhu@quicinc.com, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com, quic_sibis@quicinc.com
Subject: Re: [PATCH V1] bootconfig: Increase max nodes of bootconfig from
 1024 to 8192 for DCC support
Message-Id: <20230313150212.4ff2bc19f36469b9f9304605@kernel.org>
In-Reply-To: <2463802.XAFRqVoOGU@amaterasu.liwjatan.org>
References: <1674536682-18404-1-git-send-email-quic_schowdhu@quicinc.com>
        <2463802.XAFRqVoOGU@amaterasu.liwjatan.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 12 Mar 2023 12:49:44 +0100
Heinz Wiesinger <pprkut@slackware.com> wrote:

> Hi everyone,

Oops, thanks for pointing it out. I have to run the test in the test environment...


> 
> It looks like this broke the bootconfig tests (tools/bootconfig/test-
> bootconfig.sh), tested on 6.1.18:
> 
> Max node number check
> test case 12 (./bootconfig -a ./temp-HCfT.bconf ./initrd-NGHv)...
> Apply ./temp-HCfT.bconf to ./initrd-NGHv
>         Number of nodes: 1024
>         Size: 8110 bytes
>         Checksum: 599485
> \t\t[OK]
> test case 13 (./bootconfig -a ./temp-HCfT.bconf ./initrd-NGHv)...
> Apply ./temp-HCfT.bconf to ./initrd-NGHv
>         Number of nodes: 1025
>         Size: 8118 bytes
>         Checksum: 600212
> \t\t[NG]

Yes, it needs to test with 8192 and 8193 nodes. Those are
boundary checker.

Thanks!

> 
> When I adjust the max node number for the tests to 8192, test case 13 passes, 
> but test case 12 then fails:
> 
> Max node number check
> test case 12 (./bootconfig -a ./temp-qZHF.bconf ./initrd-0v99)...
> Error: Config data is too big.
> \t\t[NG]
> test case 13 (./bootconfig -a ./temp-qZHF.bconf ./initrd-0v99)...
> Error: Config data is too big.
> \t\t[OK]

Ah, it hits the size limitation. :D

Each node consumes "node%d\n" = 6-11 bytes, and 11 bytes*8k = 88k bytes > 32K bytes.
So, for making 8k nodes (including delimiter), we need to use 3 random alphabets for
node name. (26^3 = 17576)

Let me fix that and thanks for report!



> 
> Grs,
> Heinz


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
