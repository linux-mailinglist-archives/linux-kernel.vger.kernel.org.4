Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66D670A304
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjESW6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:58:12 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B1E46;
        Fri, 19 May 2023 15:58:02 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d247a023aso1663259b3a.2;
        Fri, 19 May 2023 15:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537082; x=1687129082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT3nVX8BOP6xdFUAxxsGq0VwKjJtQEdxnV8AqojOVvE=;
        b=G4zQo875H6QgGCt/ELHZWPc5M13RsMIMJUenfmaNPxgrTdnvpli3cJ5sKr1qpgurNx
         f/Frs0t8etXo5EjkBgXJsuB5loRA4uqRsQEqh+4GHlurCVCCSMFXLct0mS3vP18ylg3i
         ykpedVuBytPy1c7+dxGr4+TWeif95YpsQigav/oDY7utpu4WDx/YtadLsL/OuiQfj9AP
         aSzfW2QtZDhnKIfODzqZLacTKkd1ydOuPNN+DTbMNvsAAErHY3D3KTXqw0VMqHu3k5j6
         1d216j+6xkRxWHfmMJmlLle07TUZ3Gi6ZmCwMnkn7KC21XHU90OAbQTPs45L3759Ng6C
         hhzw==
X-Gm-Message-State: AC+VfDzLTWFRrQRAkOB4W1I1oA0HFbBeULZMq5NVd9Ilgw1GU0SAlH2D
        eVVocdfxZuWf/63bwV891kc=
X-Google-Smtp-Source: ACHHUZ4dpJa1bPQdCUzlU6b8KGnb61gD8PYkuxGZtcIWM6wwJnGwKzbgeY8t6vG1yKx/SWkXHSVUuA==
X-Received: by 2002:a05:6a00:1914:b0:648:b185:efd9 with SMTP id y20-20020a056a00191400b00648b185efd9mr4424120pfi.11.1684537081838;
        Fri, 19 May 2023 15:58:01 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b0064d3a9def35sm166486pff.188.2023.05.19.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:58:01 -0700 (PDT)
Date:   Fri, 19 May 2023 15:57:59 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZGf+99vmXpN5nJ2f@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <f47b17c1-1c02-2aa3-ba10-fcef70cb25a8@linaro.org>
 <b0115d7d-d15a-4948-8726-09a8b37f3f36@kili.mountain>
 <4aa42c38-e0e2-4d2d-bfe2-15bc151f7117@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa42c38-e0e2-4d2d-bfe2-15bc151f7117@linaro.org>
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

On Fri, May 19, 2023 at 11:39:59AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 19/05/2023 11:22, Dan Carpenter wrote:
> > > ----------------------->cut<---------------------------
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index f60bbf99485c..3fdd326e1ae8 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -1891,7 +1891,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > char __user *argp)
> > >                                        &args[0]);
> > >          if (err) {
> > >                  dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> > > -               goto err_invoke;
> > > +               fastrpc_buf_free(buf);
> > > +               return err;
> > >          }
> > > 
> > >          /* update the buffer to be able to deallocate the memory on the DSP
> > > */
> > > @@ -1930,11 +1931,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl,
> > > char __user *argp)
> > >          return 0;
> > > 
> > >   err_assign:
> > > -       fastrpc_req_munmap_impl(fl, buf);
> > > -err_invoke:
> > > -       fastrpc_buf_free(buf);
> > > -
> > > -       return err;
> > > +       return fastrpc_req_munmap_impl(fl, buf);
> > 
> > This will return success if copy_to_user() fails.
> > 
> that is true, using return value of fastrpc_req_munmap_impl does not really
> make sense here we should just return err in either case to the user.
>

Thanks, Srini and Dan, for reviewing the patch and suggestions.
I will add this in v2.

Regards,
Sukrut Bellary

> --srini
> 
> > regards,
> > dan carpenter
> > 
