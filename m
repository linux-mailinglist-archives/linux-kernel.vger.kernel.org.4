Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FFA7170E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjE3Wow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjE3Wot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:44:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF36107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:44:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so1912382a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685486686; x=1688078686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lpvk61m8kV2Aob9IF7acV7Nqq1ETfXj91v2zUEXV06I=;
        b=FyuD76bD6Wx498UScEb7wg6Rz8mBirQ2uKMnwVjGlWl+JnnfoMVLYTLTLb6Dz7eCCx
         9sg+TmgYzSf87RA5ZS9sdKb8F3kyfoDx2e0u0CYpJVOUANBRnVDrnYwILvBO14qAm2XC
         0OdiEZ2im2nHX8lMWTLHHqtRq9xra53m1vgBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486686; x=1688078686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpvk61m8kV2Aob9IF7acV7Nqq1ETfXj91v2zUEXV06I=;
        b=MEl1f5sRruOY2PFqujG7AL/3lVFdsDkxgKNeRreQ8d+VchPyys9y25Fc54sAHP5TYV
         fS7sK26OO6GyadKbdqjEjNl3dcfQASTmMDsUUqZovJSTJiskvsTMOYuVgoFsbX6RE6ci
         XA9lyZpCRi8xsBZvPwSYsfmZyZytqOfUrJeGWDQRKF3SU/V9e1dD+nEetRIF87nj1UzM
         jT10tgPs5SNGpoB38VqshJQ2w9EC1h2nu9w9iZ4ornsfiHvyfQT90o98YSrSAVsKqnDd
         kGsgGzVDWUy4THDZeF8fg0gCOuAZ7yc6i/jdiR9qHRsVZQ3y1hds0k3s/IA0Qwqb2BID
         Af/w==
X-Gm-Message-State: AC+VfDzsGRLeIcJYzXZ2503cMNGqFT+6x08NMYB7YGQZGLZa+ExLipB4
        aGwQjbxvz8ySMQ4iYwtg7b/E4A==
X-Google-Smtp-Source: ACHHUZ4eSr7YyjxG6IwmG9+W0DZTBBwsbnm9MEeWUHeWyz1UYQNtYfRsgqJaKxB95SIn6RfICpOaSw==
X-Received: by 2002:a17:90a:f2c3:b0:256:7e70:309c with SMTP id gt3-20020a17090af2c300b002567e70309cmr3803420pjb.44.1685486686640;
        Tue, 30 May 2023 15:44:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090aa38200b0025069c8a151sm9285560pjp.53.2023.05.30.15.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:44:46 -0700 (PDT)
Date:   Tue, 30 May 2023 15:44:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Message-ID: <202305301529.1EEA11B@keescook>
References: <ZHZq7AV9Q2WG1xRB@work>
 <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 05:36:06PM -0400, James Bottomley wrote:
> On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > Avoid confusing the compiler about possible negative sizes.
> > Use size_t instead of int for variables size and copied.
> > 
> > Address the following warning found with GCC-13:
> > In function ‘lpfc_debugfs_ras_log_data’,
> >     inlined from ‘lpfc_debugfs_ras_log_open’ at
> > drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> > drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’ specified
> > bound between 18446744071562067968 and 18446744073709551615 exceeds
> > maximum object size 9223372036854775807 [-Wstringop-overflow=]
> >  2210 |                         memcpy(buffer + copied, dmabuf->virt,
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  2211 |                                size - copied - 1);
> >       |                                ~~~~~~~~~~~~~~~~~~
> > 
> 
> This looks like a compiler bug to me and your workaround would have us
> using unsigned types everywhere for sizes, which seems wrong.  There
> are calls which return size or error for which we have ssize_t and that
> type has to be usable in things like memcpy, so the compiler must be
> fixed or the warning disabled.

The compiler is (correctly) noticing that the calculation involving
"size" (from which "copied" is set) could go negative.

The "unsigned types everywhere" is a slippery slope argument that
doesn't apply: this is fixing a specific case of a helper taking a
size that is never expected to go negative in multiple places
(open-coded multiplication, vmalloc, lpfc_debugfs_ras_log_data, etc). It
should be bounds checked at the least...


struct lpfc_hba {
	...
	uint32_t cfg_ras_fwlog_buffsize;
	...
};

lpfc_debugfs_ras_log_open():
	...
        struct lpfc_hba *phba = inode->i_private;
        int size;
	...
	size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
        debug->buffer = vmalloc(size);
	...
        debug->len = lpfc_debugfs_ras_log_data(phba, debug->buffer, size);
	...

lpfc_debugfs_ras_log_data():
	...
                if ((copied + LPFC_RAS_MAX_ENTRY_SIZE) >= (size - 1)) {
                        memcpy(buffer + copied, dmabuf->virt,
                               size - copied - 1);

Honestly, the "if" above is the weirdest part, and perhaps that should
just be adjusted instead:

	if (size <= LPFC_RAS_MAX_ENTRY_SIZE)
		return -ENOMEM;
	...
		if (size - copied <= LPFC_RAS_MAX_ENTRY_SIZE) {
			memcpy(..., size - copied - 1);
                        copied += size - copied - 1;
                        break;
		}
		...
        }
        return copied;



-- 
Kees Cook
