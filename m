Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3401971F2A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjFATKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFATJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:09:59 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C213E;
        Thu,  1 Jun 2023 12:09:58 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso1534394b3a.0;
        Thu, 01 Jun 2023 12:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685646598; x=1688238598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prM0tuKlBBKG5IevqlWAEtXhMFCl0wz5wWu0cFBWnos=;
        b=Z/xtv9Q9vzNgEo44ropTHFVgqnR0EUwwsoxitJtSuta+YykLQa/czQQ7c8A4di6dCv
         k+gLJS2gx8rdK57HNlFu2XAc+IHBzqpCLKq18P4M6OVIkKzeZ/8iN3NoQOKGKMuSyKja
         rLaUfo5nPPx68bp5/XI0iHDBriYGD7QQ2MPeL7hg0TptrYE6XddA/wB8Idv/eYwLT1A9
         WTL15/HnHqnT4kG2BH2cqML5uGMGlaJm2Nd511sXVWcouHOytuLaSP4K2LJXxFAgGiq+
         jegu0D1c/qsKfw2GtQe9utpeWp7/3dO7eOX/KINSQwXiFADJHQ0xlR8hMknRkH7bhjrq
         d2Lw==
X-Gm-Message-State: AC+VfDzqfDeF9nKoLHfXEsLPWOqKseMLzZMC0a30CB4OxpKQzHwrBkZR
        tnczpnNgo6j5i/FQu6Mxna4=
X-Google-Smtp-Source: ACHHUZ5TQRMB2GWJUD6fo3f13pKPUl5IwVeNt8wJwJ7QN5OXSo+0wJzUwDrP7i3rcjdyFziSEHxYjg==
X-Received: by 2002:a05:6a00:22c9:b0:652:98e9:fb1 with SMTP id f9-20020a056a0022c900b0065298e90fb1mr786888pfj.32.1685646597408;
        Thu, 01 Jun 2023 12:09:57 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id t4-20020aa79384000000b0064d57ecaa1dsm5449471pfe.28.2023.06.01.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:09:57 -0700 (PDT)
Date:   Thu, 1 Jun 2023 12:09:53 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZHjtAdHAwH7CAyAE@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <f47b17c1-1c02-2aa3-ba10-fcef70cb25a8@linaro.org>
 <b0115d7d-d15a-4948-8726-09a8b37f3f36@kili.mountain>
 <4aa42c38-e0e2-4d2d-bfe2-15bc151f7117@linaro.org>
 <ZGf+99vmXpN5nJ2f@dev-linux.lan>
 <ZHgicqL/TKuXHM0o@dev-linux.lan>
 <22f7e4db-1380-4326-906f-83a85447471a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f7e4db-1380-4326-906f-83a85447471a@kadam.mountain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:00:43AM +0300, Dan Carpenter wrote:
> On Wed, May 31, 2023 at 09:45:38PM -0700, Sukrut Bellary wrote:
> > On Fri, May 19, 2023 at 03:57:59PM -0700, Sukrut Bellary wrote:
> > > On Fri, May 19, 2023 at 11:39:59AM +0100, Srinivas Kandagatla wrote:
> > > > 
> > > > 
> > > > On 19/05/2023 11:22, Dan Carpenter wrote:
> > > > > > ----------------------->cut<---------------------------
> > > > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > > > index f60bbf99485c..3fdd326e1ae8 100644
> > > > > > --- a/drivers/misc/fastrpc.c
> > > > > > +++ b/drivers/misc/fastrpc.c
> > > > > > @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > > > char __user *argp)
> > > > > >                                        &args[0]);
> > > > > >          if (err) {
> > > > > >                  dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> > > > > > -               goto err_invoke;
> > > > > > +               fastrpc_buf_free(buf);
> > > > > > +               return err;
> > > > > >          }
> > > > > > 
> > > > > >          /* update the buffer to be able to deallocate the memory on the DSP
> > > > > > */
> > > > > > @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > > > char __user *argp)
> > > > > >          return 0;
> > > > > > 
> > > > > >   err_assign:
> > > > > > -       fastrpc_req_munmap_impl(fl, buf);
> > > > > > -err_invoke:
> > > > > > -       fastrpc_buf_free(buf);
> > > > > > -
> > > > > > -       return err;
> > > > > > +       return fastrpc_req_munmap_impl(fl, buf);
> > > > > 
> > > > > This will return success if copy_to_user() fails.
> > > > > 
> > > > that is true, using return value of fastrpc_req_munmap_impl does not really
> > > > make sense here we should just return err in either case to the user.
> > > >
> > >
> > 
> > I have one follow-up question before I send the v2 patch.
> > With the following approach, I do see one issue.
> > 
> > ----------------------->cut<---------------------------
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index f60bbf99485c..3fdd326e1ae8 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > char __user *argp)
> >                                       &args[0]);
> >         if (err) {
> >                 dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> > -               goto err_invoke;
> > +               fastrpc_buf_free(buf);
> > +               return err;
> >         }
> > 
> >         /* update the buffer to be able to deallocate the memory on the DSP */
> > @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > char __user *argp)
> >         return 0;
> > 
> >  err_assign:
> > -       fastrpc_req_munmap_impl(fl, buf);
> > -err_invoke:
> > -       fastrpc_buf_free(buf);
> > -
> > -       return err;
> > +       fastrpc_req_munmap_impl(fl, buf);
> > +       return err;
> >  }
> > ----------------------->cut<---------------------------
> > 
> > In this, if qcom_scm_assign_mem() fails, the buf is not added to the list.
> > But the call to fastrpc_req_munmap_impl() tries to delete the buf
> > from the list.
> > 
> > To avoid this, we can use the following approach.
> 
> The list is initialized in __fastrpc_buf_alloc().
> 
> 	INIT_LIST_HEAD(&buf->node);
> 
> So calling list_del(&buf->node); is fine.  It's not necessary but it's
> not harmful.
>

OK, Thanks Dan. I will submit the v2 with 1st approach.

Regards,
Sukrut Bellary

> regards,
> dan carpenter
> 
