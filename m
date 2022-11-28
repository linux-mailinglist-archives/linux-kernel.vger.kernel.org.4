Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8663B44D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiK1Vjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiK1Vjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:39:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8833B2B615;
        Mon, 28 Nov 2022 13:39:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1454861487;
        Mon, 28 Nov 2022 21:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD8DC433D6;
        Mon, 28 Nov 2022 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669671571;
        bh=+iGaNGL/hq1R2stU0J1peDhuCuQTsMSXjSkHqLjkOQE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AMarH7AUrqIGM6fvRI2Bfh7pVKQVtteizXkhfgv/IB/teARzs/tnjTekU5l0LjQKy
         fqOwByPaIvN44OhCML+wFbZdMkWaMdYgZrImW3FtMP+tSx0hRlm9IIJflEdM+xc5yh
         bs5mXnJw6eAbDdz6xCpmmdpcv/IdPFTKDMPhDKaMSkVkthFwzQIka+ACjPqWTQgf12
         6Fw+x9qicdsUZGBwyrjIDaY4sfDUor1ZCRveJa+owqCXsrhf83xnxelpyJ3WH/6Wqr
         acQNgs/Up1y5y9JAWjhSgxa2dlDZOjDxt5tsjv+zzLgBFbxx2/DhUaRTCKtWImEBF7
         EBJPfHrHIQWDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E7C6F5C0BA0; Mon, 28 Nov 2022 13:39:30 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:39:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 rcu 12/16] scsi/scsi_error: Use call_rcu_flush()
 instead of call_rcu()
Message-ID: <20221128213930.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-12-paulmck@kernel.org>
 <3dbfae56-918f-d850-11b4-5c98e3baae05@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dbfae56-918f-d850-11b4-5c98e3baae05@acm.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 04:11:26PM -0800, Bart Van Assche wrote:
> On 11/21/22 17:04, Paul E. McKenney wrote:
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 6995c89792300..634672e67c81f 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
> >   	 * Ensure that all tasks observe the host state change before the
> >   	 * host_failed change.
> >   	 */
> > -	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> > +	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
> >   }
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thank you both, I will apply these on the next rebase.

							Thanx, Paul
