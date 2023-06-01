Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F385771EF7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFAQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFAQs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:48:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A994D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:48:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b01d3bb571so5382025ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638137; x=1688230137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I7sIZxy7gcUStde8URE/x1USu0Ac7NEoHkxfkIRrq8Q=;
        b=O5v9C+cpDpBpGItvH0zQNTTgjJRbBzUAAX5rLRQAlChNgLThGeWZ8wMHpncPDsbdhJ
         0KADHgqApvBqugAsYXvWIIbtTQQc+if/6nCKJj0ogUPsLWEohV0AOTOXPf7TbnVme6vq
         MWD0zkQymoph8GAivP/P+Twa2BLHeK4c8Bi2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638137; x=1688230137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7sIZxy7gcUStde8URE/x1USu0Ac7NEoHkxfkIRrq8Q=;
        b=MePvqAUw9TSktiSwg6pP8ylCt4Tl+lXpMcCmF2z/jrr8WxEAMZZ6PV+ZqHu4gMtbto
         aaTRxLfw4tVypdZ9AjLCzXkV3uYra7kdqIhNrkrIewEp9/ZjAOm0MQx1QXVQIvlEh5hj
         6obr9Fb4UZnfez99rI4e6av+9u3Et4CqlzN7sH4oA8JGRPrClP5Kof7trXZyHBwA+tO5
         0jUYIyiUnJkYQdgzEKyckFcBESo7j5sL772BuP+1TPyyGeLFM9x8UC7fO8bR9x3l3Gse
         PnOi2w9s2xVoI9nrQ6r22CPFruxGyaFAIPXYgnneozbGMcmVK5Wk2LFKFJRA5/RoV0OT
         TF7Q==
X-Gm-Message-State: AC+VfDy1pbDbN/dPjOupUjqepuMyOEp2jGP4Iv14wNvzO1yAbDE96DXk
        hKmilJqWi60wwADwGDecFVzCww==
X-Google-Smtp-Source: ACHHUZ6el6CagK7aXG5sNb126VxFGEOTWEKUyFtRTxw5GCMxYH7KhJqdaBU6w7GCuHNGGh667Yxm6w==
X-Received: by 2002:a17:903:18c:b0:1ae:50cc:45b with SMTP id z12-20020a170903018c00b001ae50cc045bmr6738733plg.36.1685638136955;
        Thu, 01 Jun 2023 09:48:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001af98dcf958sm3684665plr.288.2023.06.01.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:48:56 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:48:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Message-ID: <202306010931.92796DC@keescook>
References: <ZHZq7AV9Q2WG1xRB@work>
 <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
 <202305301529.1EEA11B@keescook>
 <25ef15e7601e1b4510cbbd40c6d1ab7c64213863.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25ef15e7601e1b4510cbbd40c6d1ab7c64213863.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:56:50AM -0400, James Bottomley wrote:
> On Tue, 2023-05-30 at 15:44 -0700, Kees Cook wrote:
> > On Tue, May 30, 2023 at 05:36:06PM -0400, James Bottomley wrote:
> > > On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > > Avoid confusing the compiler about possible negative sizes.
> > > > Use size_t instead of int for variables size and copied.
> > > > 
> > > > Address the following warning found with GCC-13:
> > > > In function ‘lpfc_debugfs_ras_log_data’,
> > > >     inlined from ‘lpfc_debugfs_ras_log_open’ at
> > > > drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> > > > drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’
> > > > specified
> > > > bound between 18446744071562067968 and 18446744073709551615
> > > > exceeds
> > > > maximum object size 9223372036854775807 [-Wstringop-overflow=]
> > > >  2210 |                         memcpy(buffer + copied, dmabuf-
> > > > >virt,
> > > >       |                        
> > > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >  2211 |                                size - copied - 1);
> > > >       |                                ~~~~~~~~~~~~~~~~~~
> > > > 
> > > 
> > > This looks like a compiler bug to me and your workaround would have
> > > us using unsigned types everywhere for sizes, which seems wrong. 
> > > There are calls which return size or error for which we have
> > > ssize_t and that type has to be usable in things like memcpy, so
> > > the compiler must be fixed or the warning disabled.
> > 
> > The compiler is (correctly) noticing that the calculation involving
> > "size" (from which "copied" is set) could go negative.
> 
> It can?  But if it can, then changing size and copied to unsigned
> doesn't fix it, does it?

Yes:

	(int)	(const expression 256 * 1024)		(u32)
        size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;

this can wrap to negative if cfg_ras_fwlog_buffsize is large enough. If
"size" is size_t, it can't wrap, and is therefore never negative.

> So your claim is the compiler only gets it wrong in this one case and
> if we just change this one case it will never get it wrong again?

What? No, I'm saying this is a legitimate diagnostic, and the wrong type
was chosen for "size": it never needs to carry a negative value, and it
potentially needs to handle values greater than u32.

But you're right -- there is still a potential for runtime confusion in
that the return from lpfc_debugfs_ras_log_data() must be signed. So
perhaps the best option is to check for overflow directly.

Gustavo, does this fix it?


diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index bdf34af4ef36..7f9b221e7c34 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2259,11 +2259,15 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	spin_unlock_irq(&phba->hbalock);
-	debug = kmalloc(sizeof(*debug), GFP_KERNEL);
+
+	if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
+			       phba->cfg_ras_fwlog_buffsize, &size))
+		goto out;
+
+	debug = kzalloc(sizeof(*debug), GFP_KERNEL);
 	if (!debug)
 		goto out;
 
-	size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
 	debug->buffer = vmalloc(size);
 	if (!debug->buffer)
 		goto free_debug;


-Kees

-- 
Kees Cook
