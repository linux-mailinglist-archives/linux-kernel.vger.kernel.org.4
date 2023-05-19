Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5681708DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjESCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESCp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:45:26 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB53DE4E;
        Thu, 18 May 2023 19:45:25 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d24136663so861719b3a.0;
        Thu, 18 May 2023 19:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684464325; x=1687056325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c1nbbCIKIRME1OUyJ8+uiganEQb54Z8X/TFo+TONq4=;
        b=hkYjRPdZeudUV7Qg50CKZlh9yVrzJXK5/TSY5VUYrUft5CYjsUJ4efbIU78ek2GmA1
         YoTmbsHYkqQlz0iNDE4+DMc8NscdpCbB+uEFqEieMjeO2HoleoRDYKTqPSP8pQyrjKmO
         tZIsm9F0vqNuwlFksMTIQnHFO9D+i7QW6St1GPtW20bsIg/IsFCQFigCKJltqzS8ixIW
         06S7TNqRf9bduGQj36WjK9POa/Et9SResbLP/sBooGxQCDBHB6gKfoJIpPbYS3pRkx2+
         DeYcXDa0nvRLCgwtnhKktGfLyxUtVR/Rntc8Z5K/QL4ZhTkiUjahvG1BzJ7sCyXPLMs6
         Q3Pw==
X-Gm-Message-State: AC+VfDyWypDubg4NokpZcCeJbIrFX27sL6Nfcj1kEa7oxeCRJmkWMWs6
        DHRtSrbmre/J+X+ovlXQZ6D4xAXOBC7vchhZ
X-Google-Smtp-Source: ACHHUZ7IC29lRhrJaA3/a5Lj1K67GGWxO0DXWqTK9gdDqllORTzhXJ5kwDqZPcQfy7iQSGK41/hxpQ==
X-Received: by 2002:a05:6a00:804:b0:63b:8423:9e31 with SMTP id m4-20020a056a00080400b0063b84239e31mr1267414pfk.11.1684464324881;
        Thu, 18 May 2023 19:45:24 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0063d2cd02d69sm1974894pfm.54.2023.05.18.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 19:45:24 -0700 (PDT)
Date:   Thu, 18 May 2023 19:45:22 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZGbiwqMxnFFvS7y8@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
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

On Thu, May 18, 2023 at 01:55:07PM +0300, Dan Carpenter wrote:
> On Thu, May 18, 2023 at 03:08:29AM -0700, Sukrut Bellary wrote:
> > smatch warning:
> > drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> > 
> > In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> > fastrpc_req_munmap_impl() if unmap is successful.
> > 
> > But in the end, there is an unconditional call to fastrpc_buf_free().
> > So the above case triggers the double free of fastrpc buf.
> > 
> > Fix this by avoiding the call to the second fastrpc_buf_free() if
> > fastrpc_req_munmap_impl() is successful.
> > 'err' is not updated as it needs to retain the err returned by
> > qcom_scm_assign_mem(), which is the starting point of this error path.
> > 
> > This is based on static analysis only. Compilation tested.
> 
> Please don't put this in the commit message.  We want everyone reading
> the git log to believe everything is 100% rock solid.  :P
> 
> We need a Fixes tag.
> Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
> 
> Let's add Abel to the CC list.
> 

Thank you for reviewing the patch.
I will add a Fixes tag and fix the commit message.

> > 
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> > ---
>   ^^^
> Put testing caveats here instead, where it will be removed from the
> git log.
>

Shall I add "This is based on static analysis only. Compilation tested"
here 
or 
is it not required to mention this for all the fixes?
Can you please recommend what's is the preferred method I need to follow?

> >  drivers/misc/fastrpc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index f48466960f1b..1c3ab78f274f 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -1921,7 +1921,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
> >  	return 0;
> >  
> >  err_assign:
> > -	fastrpc_req_munmap_impl(fl, buf);
> > +	if (!fastrpc_req_munmap_impl(fl, buf)) {
> > +		/* buf is freed */
> > +		return err;
> > +	}
> >  err_invoke:
> >  	fastrpc_buf_free(buf);
> 
> This bug is real but the fix is not complete.
> 
> drivers/misc/fastrpc.c
>   1911                  if (err) {
>   1912                          dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>   1913                                          buf->phys, buf->size, err);
>   1914                          goto err_assign;
>   1915                  }
>   1916          }
>   1917  
>   1918          spin_lock(&fl->lock);
>   1919          list_add_tail(&buf->node, &fl->mmaps);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> buf needs to be removed from the list before we free it, otherwise it
> leads to a use after free.  The fastrpc_req_munmap_impl() function does
> that but here this function just calls fastrpc_buf_free().
> 
>   1920          spin_unlock(&fl->lock);
>   1921  
>   1922          if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>   1923                  err = -EFAULT;
>   1924                  goto err_assign;
>   1925          }
>   1926  
>   1927          dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>   1928                  buf->raddr, buf->size);
>   1929  
>   1930          return 0;
>   1931  
>   1932  err_assign:
>   1933          fastrpc_req_munmap_impl(fl, buf);
>   1934  err_invoke:
>   1935          fastrpc_buf_free(buf);
>   1936  
>   1937          return err;
>   1938  }
> 

Nice catch!
I will address this in the next version.

Regards,
Sukrut Bellary

> regards,
> dan carpenter
