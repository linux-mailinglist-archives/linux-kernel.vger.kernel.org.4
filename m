Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D86FB315
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjEHOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjEHOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:39:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF74C08
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:39:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so7307675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683556750; x=1686148750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKa3M9jBMdQPBsXGj4GG7TDDf9/LBhAgzA2/jVjGDng=;
        b=UC6m4w4u7QpQUbESbXOteX0ljEB1v/64kDiKb/nTQIcuqxofVL7yw65jwvdLAVpB1j
         jisG0AH6+vlgwVWsly70tcniAFKF6MPPk7RUfaQ92k+2/KdDh/+ozsZT/HTtALlh3tGx
         beKipMR0g4gFfPEX4czqEBi7ZAGtMtVKHXtkUS3IQE+3+H4WaiK911e2kmjFeUobD159
         HU5rnIriqxHlm7KCRmm1/7fnByfGOMDqldG/X1TZmu8KCfEeU4edPqZDAmaiEdmOfGW5
         NecwP2G0Rcp7ixH6hGbgg6rAIbki/l3vbf/2hJCs0kTo1qmsUxkiditxV3+aVYj19pZq
         7TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556750; x=1686148750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKa3M9jBMdQPBsXGj4GG7TDDf9/LBhAgzA2/jVjGDng=;
        b=YSF5JrKoyQCm4oTvXQe0JP2Z+qIUxpv0OptiOx9rxThXs4iX5nBxz5s6BRItSbOxm0
         SaDQo/MuK4FWwuGefuZTaERJgrapQByEsVGkETIFtgF6VlWPAk8qe4oTReMU6/1NJ2Ql
         JOWp46DJJITj2dO72wP77jO+9OPq+fG0546Ci7E8/o9Xie57d9N18/fNf6mcBNZDrrLH
         MEoHLxgAPhdvjzQaD0dlfLOh6zDjVHf5dk47VTr74zD2oVuE30r2prauuIggMjrx5FVB
         K35ivMg0VmUuLJfjnGZVs5EhN6CJOxq57wqeCGb+faX+Ux4XdX9qUCvR8XNDXmKxaQQL
         0MaQ==
X-Gm-Message-State: AC+VfDxKDWrOBf0MTWjBrhaTJd9v4nsxHfUNM6Uf4gaSz/g//XaRrfcF
        SaP4YIf5Lw7Ek6eqXaDaK1vAug==
X-Google-Smtp-Source: ACHHUZ7e1NO1n+801sRZRPy5/spMBxkJtnkeTCGiE4m4ao4b80MPhoPOpj4jejdZ9SjI8LBNXBsG0Q==
X-Received: by 2002:a1c:cc14:0:b0:3f4:20bd:ba46 with SMTP id h20-20020a1ccc14000000b003f420bdba46mr4579620wmb.5.1683556749876;
        Mon, 08 May 2023 07:39:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003f423508c6bsm4886169wmd.44.2023.05.08.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:39:07 -0700 (PDT)
Date:   Mon, 8 May 2023 17:38:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Tomas Henzl <thenzl@redhat.com>, Jing Xu <U202112064@hust.edu.cn>,
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
Message-ID: <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
 <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:40:41PM +0800, Dongliang Mu wrote:
> > > > diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> > > > index a6ab1db81167..c92e08c130b9 100644
> > > > --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> > > > +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
> > > > @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
> > > >   void mpt3sas_init_debugfs(void)
> > > >   {
> > > >   	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
> > > > -	if (!mpt3sas_debugfs_root)
> > > > -		pr_info("mpt3sas: Cannot create debugfs root\n");
> > > Hi Jing,
> > > most drivers just ignore the return value but here the author wanted to
> > > have the information logged.
> > > Can you instead of removing the message modify the 'if' condition so it
> > > suits the author's intention?
> > 
> > This code was always just wrong.
> > 
> > The history of this is slightly complicated and boring.  These days it's
> > harmless dead code so I guess it's less bad than before.
> 
> Hi Dan and Tomas,
> 
> Any conclusion about this patch? The student Jing Xu is not sure about how
> to revise this patch.

The correct fix is to delete the code.

Debugfs code has error checking built in and was never supposed to be
checked for errors in normal driver code.

Originally, debugfs returned a mix of error pointers and NULL.  In the
kernel, when you have a mix of error pointers and NULL, then the NULL
means that the feature has been disabled deliberately.  It's not an
error, we should not print a message.

So a different, correct-ish way to write write debugfs error handling
was to say:

	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
	if (IS_ERR(mpt3sas_debugfs_root))
		return PTR_ERR(mpt3sas_debugfs_root);

However, in those days, a lot of people didn't understand error pointers
and thought that "if (IS_ERR_OR_NULL(mpt3sas_debugfs_root)) {" was a
super secure way to check for errors.  Or they just got it wrong and
checked for NULL instead of error pointers.  Any of the checks are
wrong, but if (IS_ERR()) check was at least correct-ish.

I dealt with this a lot because of my work with Smatch.  I used to be
happy if I could persuade someone to write at least correct-ish code,
but it was pretty painful to try explain this over and over and very few
people deleted the checks.

Eventually Greg changed the code to never return NULL and mass deleted
the IS_ERR() checks.  Not returning NULL makes it simpler to understand.
And it makes it impossible to check in the correct-ish way so it kind of
forces people to just delete the error handling.

regards,
dan carpenter
