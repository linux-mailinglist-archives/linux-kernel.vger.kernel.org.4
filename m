Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F645F0175
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiI2Xgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiI2Xgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:36:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8814C075
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:36:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w2so2807437pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Xbz67oZK82CtGclYCJkU8C5apLwvJO6ocDW2GQnKsP0=;
        b=AUn3kZDM5lNvy5m2+3Ts9Kl9mS+Bt4VFAtsVryc4ezGL1WMAmzOAlrP87i9nHVp7A5
         VZZypx1I4Z/tOJTTDsGmlHyxag27HLBJi+gMYjZEt7Tg9PggmlXUdJpR0sRwSOp2Ab7O
         cqN4IvhgOSoj5j1zwMctOnj01LrTNiFVO6lJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xbz67oZK82CtGclYCJkU8C5apLwvJO6ocDW2GQnKsP0=;
        b=wUUXH0g1ZqvjTPzwbLyvpKpHin2y9g6LtqDvCd6nhZ87IaipipbIH7EbD7sLgPXCUr
         yAc1OKjtZUsO3prdtIQFgZg8tZCCrhggpgh4attZROe27T25tmCHDMzERG6Bm21YdOBX
         t2i5PPAQDJcnR4yfh3m/jc5b6C+cdxQ8sryvV0W23QZ8uoYr5EpTQFxdPaUihW8+oOdA
         exiGjAKQQ6qxeR+/IApFJ4C58oiF3a6oquKCMMHnPBnzZvcQq5uEbrIdbq7Dcgs3py7g
         bwUO62otaOkpJ6SgWhRVb7x8XtBNtWDfnr+SKca9C/GC7z6LKGVMxlipOsM1XeGNqW3r
         poww==
X-Gm-Message-State: ACrzQf1PL90EJh7jdodK8D4uoNCcKg157oxK6wTuzO3xUGpQk1O7AT50
        zaJNOxgo+584JmurBwRcYtjO6g==
X-Google-Smtp-Source: AMsMyM5unEH1nAScJeckvDRNethcxnyDUrHMMmmroXgAknht8ekkwWtouSRGGxJA4MKsFbroz9alPw==
X-Received: by 2002:a63:f518:0:b0:43c:403:9833 with SMTP id w24-20020a63f518000000b0043c04039833mr4829720pgh.461.1664494589889;
        Thu, 29 Sep 2022 16:36:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00178af82a000sm452969plb.122.2022.09.29.16.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:36:29 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:36:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt: remove taso from linux_binprm struct
Message-ID: <202209291635.EA24FCEA@keescook>
References: <20220929203903.9475-1-lukas.bulwahn@gmail.com>
 <87tu4p3jwn.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu4p3jwn.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:17:28PM -0500, Eric W. Biederman wrote:
> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
> 
> > With commit 987f20a9dcce ("a.out: Remove the a.out implementation"), the
> > use of the special taso flag for alpha architectures in the linux_binprm
> > struct is gone.
> >
> > Remove the definition of taso in the linux_binprm struct.
> >
> > No functional change.
> 
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Alphas binfmt_loader is the only use I can find of that variable
> so let's kill it as well.

I can't find anything using "taso". Where are you looking?

-- 
Kees Cook
