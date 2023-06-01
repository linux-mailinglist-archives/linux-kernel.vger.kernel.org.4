Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEF7191F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFAEpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAEpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:45:44 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAAED1;
        Wed, 31 May 2023 21:45:43 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-39a523e8209so162263b6e.0;
        Wed, 31 May 2023 21:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685594742; x=1688186742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WpeAE4PXij0gZk/8nWMXmuPUKiYJwWRzyD9Us9My7A=;
        b=Z0Kg8yZjJriFXb/Qd4TzKWyk1eZhmlAnUNvRrBl2K8vurTfG2ChZX0/9FaZIp/iljN
         LIp6vQeC912mbwgm/+M92jwy5jOeXyv35dqRHd9PI/JauJgg4hWSrGAkndz/1GbMko8c
         IvNU0Ez3AnYCLz8hcMJ+2cUo3sAhO8+PHPC2ztGM0T58J63JgcnE5h0JskXBSs0c6zmZ
         SfqFJg1NkVm2qKS7PhCb7rn+8Aa/bHYEtMfqz/EyO9smqhYuVvHdDd/NxctxZocd4XPV
         SvqUmElKTRWhtdVOygnX8hMg5PvMx8wPrzO6idvIcOBTuo4TH5bgeysz7D1ijus5TCEz
         v7Kg==
X-Gm-Message-State: AC+VfDwDN4RUcr+aeUZJ4Tjhdxg1OOiQb5lSSi104tQ3IH3GBdYJih74
        1oR4JNcuWdZiLhgo7jpBr/PziUObg1npGA==
X-Google-Smtp-Source: ACHHUZ4xi8lNAhzp2c+awPc67XTrlWRgyNg6mn7/m6ghf5UG2qKpKSyYzoq33lCW3rCni+3hj4aL5w==
X-Received: by 2002:a05:6808:308c:b0:398:a09:3cb with SMTP id bl12-20020a056808308c00b003980a0903cbmr6807602oib.36.1685594742344;
        Wed, 31 May 2023 21:45:42 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0064f83595bbcsm4124460pfo.58.2023.05.31.21.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:45:41 -0700 (PDT)
Date:   Wed, 31 May 2023 21:45:38 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZHgicqL/TKuXHM0o@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <f47b17c1-1c02-2aa3-ba10-fcef70cb25a8@linaro.org>
 <b0115d7d-d15a-4948-8726-09a8b37f3f36@kili.mountain>
 <4aa42c38-e0e2-4d2d-bfe2-15bc151f7117@linaro.org>
 <ZGf+99vmXpN5nJ2f@dev-linux.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGf+99vmXpN5nJ2f@dev-linux.lan>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:57:59PM -0700, Sukrut Bellary wrote:
> On Fri, May 19, 2023 at 11:39:59AM +0100, Srinivas Kandagatla wrote:
> > 
> > 
> > On 19/05/2023 11:22, Dan Carpenter wrote:
> > > > ----------------------->cut<---------------------------
> > > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > > index f60bbf99485c..3fdd326e1ae8 100644
> > > > --- a/drivers/misc/fastrpc.c
> > > > +++ b/drivers/misc/fastrpc.c
> > > > @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > char __user *argp)
> > > >                                        &args[0]);
> > > >          if (err) {
> > > >                  dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> > > > -               goto err_invoke;
> > > > +               fastrpc_buf_free(buf);
> > > > +               return err;
> > > >          }
> > > > 
> > > >          /* update the buffer to be able to deallocate the memory on the DSP
> > > > */
> > > > @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > > char __user *argp)
> > > >          return 0;
> > > > 
> > > >   err_assign:
> > > > -       fastrpc_req_munmap_impl(fl, buf);
> > > > -err_invoke:
> > > > -       fastrpc_buf_free(buf);
> > > > -
> > > > -       return err;
> > > > +       return fastrpc_req_munmap_impl(fl, buf);
> > > 
> > > This will return success if copy_to_user() fails.
> > > 
> > that is true, using return value of fastrpc_req_munmap_impl does not really
> > make sense here we should just return err in either case to the user.
> >
>

I have one follow-up question before I send the v2 patch.
With the following approach, I do see one issue.

----------------------->cut<---------------------------
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f60bbf99485c..3fdd326e1ae8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
                                      &args[0]);
        if (err) {
                dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-               goto err_invoke;
+               fastrpc_buf_free(buf);
+               return err;
        }

        /* update the buffer to be able to deallocate the memory on the DSP */
@@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
        return 0;

 err_assign:
-       fastrpc_req_munmap_impl(fl, buf);
-err_invoke:
-       fastrpc_buf_free(buf);
-
-       return err;
+       fastrpc_req_munmap_impl(fl, buf);
+       return err;
 }
----------------------->cut<---------------------------

In this, if qcom_scm_assign_mem() fails, the buf is not added to the list.
But the call to fastrpc_req_munmap_impl() tries to delete the buf
from the list.

To avoid this, we can use the following approach.
Here we first add the buf to the list and fastrpc_req_munmap_impl() would
take care of deleting it in the failure path
Please let me know your review comments.

----------------------->cut<---------------------------
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..56751609f412 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1882,7 +1882,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
                                      &args[0]);
        if (err) {
                dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-               goto err_invoke;
+               fastrpc_buf_free(buf);
+               return err;
        }
 
        /* update the buffer to be able to deallocate the memory on the DSP */
@@ -1890,6 +1891,9 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
 
        /* let the client know the address to use */
        req.vaddrout = rsp_msg.vaddr;
+       spin_lock(&fl->lock);
+       list_add_tail(&buf->node, &fl->mmaps);
+       spin_unlock(&fl->lock);
 
        /* Add memory to static PD pool, protection thru hypervisor */
        if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
@@ -1906,9 +1910,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
                }
        }
 
-       spin_lock(&fl->lock);
-       list_add_tail(&buf->node, &fl->mmaps);
-       spin_unlock(&fl->lock);
 
        if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
                err = -EFAULT;
@@ -1922,10 +1923,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
char __user *argp)
 
 err_assign:
        fastrpc_req_munmap_impl(fl, buf);
-err_invoke:
-       fastrpc_buf_free(buf);
-
        return err;
+
 }
----------------------->cut<---------------------------

Regards,
Sukrut Bellary

> Thanks, Srini and Dan, for reviewing the patch and suggestions.
> I will add this in v2.
> 
> Regards,
> Sukrut Bellary
> 
> > --srini
> > 
> > > regards,
> > > dan carpenter
> > > 
