Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10271F5ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjFAW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFAW2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3212C;
        Thu,  1 Jun 2023 15:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A3364A7F;
        Thu,  1 Jun 2023 22:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C511C4339B;
        Thu,  1 Jun 2023 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685658516;
        bh=R7TPrCl84YiuCBQfEPy70uaHWlIn5vuvHUQAmc+LCvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oO9ExzI3xpC85rpluTYF03EIjweEG7BDEzkV4XmEOXEeRmHXV7eqb+Run/hlIrkoz
         q3toDgOfeP559QiU8jcSPuy+c4ng9vYCrIaUhBFfesCNAMYHASxFxIx+UeC+sXK0+i
         eylvQiqMvgmXERO3NQkYe/U7tu9F4AMKY+xrjDOe5QCHLtJST2/W7zci/+62/4UYEe
         OCEeJu4lIHeFXJtbqqoSAbvOmtiPBClrDufMhQFJOicZc9bIiFu5zffUco73gJGDoX
         83K5jXtsmhNuMY4pethqAZFJpnthtvFhkV8nECpzJaR+d8EE0TCoKV88H3hEqDKqFz
         ZM5FqjLX+uKDg==
Date:   Thu, 1 Jun 2023 16:29:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Message-ID: <ZHkbxyw8vLom2YEV@work>
References: <ZHZq7AV9Q2WG1xRB@work>
 <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
 <202305301529.1EEA11B@keescook>
 <25ef15e7601e1b4510cbbd40c6d1ab7c64213863.camel@linux.ibm.com>
 <202306010931.92796DC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202306010931.92796DC@keescook>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:48:55AM -0700, Kees Cook wrote:
> On Wed, May 31, 2023 at 10:56:50AM -0400, James Bottomley wrote:
> > On Tue, 2023-05-30 at 15:44 -0700, Kees Cook wrote:
> > > On Tue, May 30, 2023 at 05:36:06PM -0400, James Bottomley wrote:
> > > > On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > > > Avoid confusing the compiler about possible negative sizes.
> > > > > Use size_t instead of int for variables size and copied.
> > > > > 
> > > > > Address the following warning found with GCC-13:
> > > > > In function ‘lpfc_debugfs_ras_log_data’,
> > > > >     inlined from ‘lpfc_debugfs_ras_log_open’ at
> > > > > drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> > > > > drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’
> > > > > specified
> > > > > bound between 18446744071562067968 and 18446744073709551615
> > > > > exceeds
> > > > > maximum object size 9223372036854775807 [-Wstringop-overflow=]
> > > > >  2210 |                         memcpy(buffer + copied, dmabuf-
> > > > > >virt,
> > > > >       |                        
> > > > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >  2211 |                                size - copied - 1);
> > > > >       |                                ~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > 
> > > > This looks like a compiler bug to me and your workaround would have
> > > > us using unsigned types everywhere for sizes, which seems wrong. 
> > > > There are calls which return size or error for which we have
> > > > ssize_t and that type has to be usable in things like memcpy, so
> > > > the compiler must be fixed or the warning disabled.
> > > 
> > > The compiler is (correctly) noticing that the calculation involving
> > > "size" (from which "copied" is set) could go negative.
> > 
> > It can?  But if it can, then changing size and copied to unsigned
> > doesn't fix it, does it?
> 
> Yes:
> 
> 	(int)	(const expression 256 * 1024)		(u32)
>         size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
> 
> this can wrap to negative if cfg_ras_fwlog_buffsize is large enough. If
> "size" is size_t, it can't wrap, and is therefore never negative.
> 
> > So your claim is the compiler only gets it wrong in this one case and
> > if we just change this one case it will never get it wrong again?
> 
> What? No, I'm saying this is a legitimate diagnostic, and the wrong type
> was chosen for "size": it never needs to carry a negative value, and it
> potentially needs to handle values greater than u32.
> 
> But you're right -- there is still a potential for runtime confusion in
> that the return from lpfc_debugfs_ras_log_data() must be signed. So
> perhaps the best option is to check for overflow directly.
> 
> Gustavo, does this fix it?

Yep; it does.

I think we can go with this solution.

Thanks!
--
Gustavo

> 
> 
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index bdf34af4ef36..7f9b221e7c34 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -2259,11 +2259,15 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  	spin_unlock_irq(&phba->hbalock);
> -	debug = kmalloc(sizeof(*debug), GFP_KERNEL);
> +
> +	if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
> +			       phba->cfg_ras_fwlog_buffsize, &size))
> +		goto out;
> +
> +	debug = kzalloc(sizeof(*debug), GFP_KERNEL);
>  	if (!debug)
>  		goto out;
>  
> -	size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
>  	debug->buffer = vmalloc(size);
>  	if (!debug->buffer)
>  		goto free_debug;
> 
> 
> -Kees
> 
> -- 
> Kees Cook
