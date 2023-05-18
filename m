Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A50707E99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjERKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjERKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:55:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE6810C9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:55:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30949241c65so452085f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684407314; x=1686999314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMcqYvOV/DDzDm3ULLmvI4rkB/W5L6UYkp2ooKsRI20=;
        b=LBmkoaq6pirbGlhFNihSXHUTZLd+LN0tjSB0gOLNmadjCgpag8pyhyApkiDXdP+b1f
         9Kh3ylSo9gXLtkefNQUAk2QbRqiRx2WHmp3Boate6jifLi9c9cV2Mt8WD6+A8EMxJOFX
         pqxdOHvBLLUzeBHSDlYFlU+0tDZjz88oLT7uxiCuvIw+9zhoa9+EpUBda67XRSCd9Y0n
         VLJMjM3EEOabFDoVzF6OhpPu8Fv6sJ+rPgLZXf01mvp/PmaEo4zFmbzP3OzPsMzbOqlz
         McKAltiSpJGac0yKy7CpEYb1RR3Mg7cjT/3VC/7qSFScNv+15wIj40VyT7gEu79sZylL
         1Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684407314; x=1686999314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMcqYvOV/DDzDm3ULLmvI4rkB/W5L6UYkp2ooKsRI20=;
        b=GbkERu9s0y8cSj824YAPxY5jDicKK+3sP42IoIxLKgAPCZPjTWB5BjD4tcAp2awW7u
         qKDLllAfGRJqMvwHpmhqQjPHDU1gUj5NmVLXWlsexenOv9RysGLa3dPvi4nS9maPeI5i
         eX1pDep23BnrqFW4Ua/be9HBQWUxcuF2CAFTh3mNG0M53pb1npQEzj9Sm3JIsUbVSOyy
         eJkB3KeTbmJuIO2y7VCtTxt/9c8ohhuOoZyru8VYHf/z4rLCCLnAI4QC1FSW5n1Zl0zk
         56YeDnsu1FnfNdUbXKa58tJOB+YNk0U4/yHfj0okDkbkR/JB/940UFlF0OGYvS4yzqWT
         sZ1Q==
X-Gm-Message-State: AC+VfDwmzD2osRmMv9SJ8/WQ8IC4JBwEG1JU136r8T9NSz09izP5tzEL
        RUXyQ7uuB9jPPvwJ+ee2b9QiGg==
X-Google-Smtp-Source: ACHHUZ50xVsV4Bi+LS6CtjJ52WnW+axOFMr6u/Cg4D3UlKNEv5uJA4hwy7vmthITSO//KJfSXMJJbw==
X-Received: by 2002:adf:f64f:0:b0:2f8:33bd:a170 with SMTP id x15-20020adff64f000000b002f833bda170mr1179953wrp.32.1684407313958;
        Thu, 18 May 2023 03:55:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b003062b57ffd1sm1804632wrp.50.2023.05.18.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:55:12 -0700 (PDT)
Date:   Thu, 18 May 2023 13:55:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sukrut Bellary <sukrut.bellary@linux.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518100829.515143-1-sukrut.bellary@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 03:08:29AM -0700, Sukrut Bellary wrote:
> smatch warning:
> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> 
> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> fastrpc_req_munmap_impl() if unmap is successful.
> 
> But in the end, there is an unconditional call to fastrpc_buf_free().
> So the above case triggers the double free of fastrpc buf.
> 
> Fix this by avoiding the call to the second fastrpc_buf_free() if
> fastrpc_req_munmap_impl() is successful.
> 'err' is not updated as it needs to retain the err returned by
> qcom_scm_assign_mem(), which is the starting point of this error path.
> 
> This is based on static analysis only. Compilation tested.

Please don't put this in the commit message.  We want everyone reading
the git log to believe everything is 100% rock solid.  :P

We need a Fixes tag.
Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")

Let's add Abel to the CC list.

> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---
  ^^^
Put testing caveats here instead, where it will be removed from the
git log.

>  drivers/misc/fastrpc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f48466960f1b..1c3ab78f274f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1921,7 +1921,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  	return 0;
>  
>  err_assign:
> -	fastrpc_req_munmap_impl(fl, buf);
> +	if (!fastrpc_req_munmap_impl(fl, buf)) {
> +		/* buf is freed */
> +		return err;
> +	}
>  err_invoke:
>  	fastrpc_buf_free(buf);

This bug is real but the fix is not complete.

drivers/misc/fastrpc.c
  1911                  if (err) {
  1912                          dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
  1913                                          buf->phys, buf->size, err);
  1914                          goto err_assign;
  1915                  }
  1916          }
  1917  
  1918          spin_lock(&fl->lock);
  1919          list_add_tail(&buf->node, &fl->mmaps);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
buf needs to be removed from the list before we free it, otherwise it
leads to a use after free.  The fastrpc_req_munmap_impl() function does
that but here this function just calls fastrpc_buf_free().

  1920          spin_unlock(&fl->lock);
  1921  
  1922          if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
  1923                  err = -EFAULT;
  1924                  goto err_assign;
  1925          }
  1926  
  1927          dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
  1928                  buf->raddr, buf->size);
  1929  
  1930          return 0;
  1931  
  1932  err_assign:
  1933          fastrpc_req_munmap_impl(fl, buf);
  1934  err_invoke:
  1935          fastrpc_buf_free(buf);
  1936  
  1937          return err;
  1938  }

regards,
dan carpenter
