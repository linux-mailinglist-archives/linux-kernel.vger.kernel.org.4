Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB39B70DFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjEWO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjEWO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:57:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47CFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:57:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f60410106cso18148245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684853828; x=1687445828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1Wj0P6YeefVDWUhmrWZwCaqFzfv9dXPwxlScY7Er8M=;
        b=amAVpLeJyPwKhmefM8/EOAHIHLVYlyiJwOdyk6pFO51tvPzhlvX3vOOTggg8tP73YP
         xzBcgusJeBauUJv950RurKmsemJ2NIovZeXxHoSjgHPPXKwDHJOzF7ubHJypOLSO/94t
         fxh1gxyVKCabr2VdjelC711MlJn8t3xT0VqLz+t4luwAUZOkRnPLHWHNHnbv8WtviXub
         l9BC48BpOuZQWtJmqRXoSBdlhBJYqo3gS1F2xU4Q12EYp3piOG5NNY0Oik+Dv+wf1mUP
         d6DAqS4DQ+uhq4ZkhN31RUWDwQxpRS2MDrbKQQxtO7Ay2z84UfxDTggFZK1hQIE7NH7c
         Wm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853828; x=1687445828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1Wj0P6YeefVDWUhmrWZwCaqFzfv9dXPwxlScY7Er8M=;
        b=SVu4asozWogQ5jfhq0rMRHPmQ+0OhByhCD1KdqKXTShoevTXtCdluwRI4a/YTeXfXv
         X9631GNm1bhI2EoyK1vaGnyNvMOf7MkTJnxK/tVFV/guy76CltpNbwoKX3KlQjQP8sUN
         1z28fSr2JNGCgfdMOiPRP7DCwCUMncksaHbaViZfn5Dtsm3s82AtW3lGYX9EzTH8paQG
         p/aXRqh1Wpcx5vZdeFFRJDHG1MWAfL5x/SW/Mjjegns3ei0GhjGR9YD6M+00xV0BYXE7
         m3pOMuf6Ko846z0KXW4zRww3E5m4bLB4aeLYNez+ZkgOf+Bq7R5Ic+L+6+/vxJ2a02s5
         Q0Ww==
X-Gm-Message-State: AC+VfDxqtnzapHgrvNRdGs0AHJlEptwL7NI6Ye35kG33B1TP5qucDBtd
        h4x5nPDqvCQs5bpiNCl9OrMbuA==
X-Google-Smtp-Source: ACHHUZ4Tf0ls0pXCeCE4Vy0Kg1p+ousOsWikkiU/FrmHmlgOsVxZrCE7R6nE7OjJLyNkfOhVRDCXLQ==
X-Received: by 2002:a5d:4e8c:0:b0:306:37ec:656c with SMTP id e12-20020a5d4e8c000000b0030637ec656cmr10823357wru.66.1684853828416;
        Tue, 23 May 2023 07:57:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n1-20020adfe781000000b002c54c9bd71fsm11388835wrm.93.2023.05.23.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:57:05 -0700 (PDT)
Date:   Tue, 23 May 2023 17:57:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
Message-ID: <3c4b372f-db4b-43b4-b5ab-7f4860cf6f20@kili.mountain>
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
 <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
 <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
 <892bc614-9e2e-904b-29e0-62daeb855f79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892bc614-9e2e-904b-29e0-62daeb855f79@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 04:48:12PM +0200, Tomas Henzl wrote:
> On 5/8/23 16:38, Dan Carpenter wrote:
> > On Mon, May 08, 2023 at 09:40:41PM +0800, Dongliang Mu wrote:
> >>>>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> >>>>> index a6ab1db81167..c92e08c130b9 100644
> >>>>> --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> >>>>> +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> >>>>> @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
> >>>>>   void mpt3sas_init_debugfs(void)
> >>>>>   {
> >>>>>   	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
> >>>>> -	if (!mpt3sas_debugfs_root)
> >>>>> -		pr_info("mpt3sas: Cannot create debugfs root\n");
> >>>> Hi Jing,
> >>>> most drivers just ignore the return value but here the author wanted to
> >>>> have the information logged.
> >>>> Can you instead of removing the message modify the 'if' condition so it
> >>>> suits the author's intention?
> >>>
> >>> This code was always just wrong.
> >>>
> >>> The history of this is slightly complicated and boring.  These days it's
> >>> harmless dead code so I guess it's less bad than before.
> >>
> >> Hi Dan and Tomas,
> >>
> >> Any conclusion about this patch? The student Jing Xu is not sure about how
> >> to revise this patch.
> > 
> > The correct fix is to delete the code.
> > 
> > Debugfs code has error checking built in and was never supposed to be
> > checked for errors in normal driver code.
> > 
> > Originally, debugfs returned a mix of error pointers and NULL.  In the
> > kernel, when you have a mix of error pointers and NULL, then the NULL
> > means that the feature has been disabled deliberately.  It's not an
> > error, we should not print a message.
> > 
> > So a different, correct-ish way to write write debugfs error handling
> > was to say:
> > 
> > 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
> > 	if (IS_ERR(mpt3sas_debugfs_root))
> > 		return PTR_ERR(mpt3sas_debugfs_root);
> I'm fine with this as well, I could wish we get a fix for the exact same
> case of debugfs_create_dir in mpt3sas_setup_debugfs and ideally all the
> debugfs_create* in  mpt3sas_debugfs.c in a single patch. But this patch
> is ok even if that wasn't possible.
> tomash

No, you didn't read until the end.  That will break the driver badly.

This *used* to be a correct-ish way that *used* to work but it was never
the what Greg wanted.  So to discourage people from doing it, Greg made
it *impossible* to check for if debugfs has failed.  Literally, the only
correct thing to do now is to delete the debugfs checking.

regards,
dan carpenter


