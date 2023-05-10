Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B076FD380
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEJBYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJBYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:24:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A90E52
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:24:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52160f75920so4449884a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683681879; x=1686273879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igRRy0hX7f/8CQM1lxoKnRs6kwwNUxJvg8cGqw0HOuQ=;
        b=k1O+dADODFwAhrz4JbRuNYY+8NScyFBnJzcuqM1iWQ4IUs7H2EPDSAafNUd49nYt9X
         ORpfIMbhkA+ODuZoNhsJTMc8FjkeFDteswksik9ouMLRPd0Mw/2IIL8SuIRgNKHZOd3q
         iVEdBjcLKkLtrXTZFLmY+he37DpGG1gOSkZW0OrUe7n/hDPI0Mt5bwPTO8WWsCZ4xvtn
         zmmcuCRpDufO+Y+yy3NmdvThiyrnIvCqEAAzERKWMYqDS5yRQ2bvxtQQjCUPcKQjpwrf
         DDCcdyZyEsWzxu11yCiD+2W4U6Pie2VUbtpxw/sMOL7AAdWF694/56gGj35JRGUCg9/T
         PDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683681879; x=1686273879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igRRy0hX7f/8CQM1lxoKnRs6kwwNUxJvg8cGqw0HOuQ=;
        b=FZBTFT+NqlUgEjI8uYRhyVMj4rd6tJE52eHCsnySfdVdkXpupiI9Wl6oN4EoydTlVw
         idcmabXVRyoq5FxlONDaozquCGpVGXpOVxWlBGjhbw2JZOtCyVCUBUA6BA4XNhMFPoqy
         SQ8yMfEKIhsgozl6y3KOcM1F/joQ53qKBKWWUPySNpYnnckiGYVBl+yYLj9Bl3/VwYPY
         /p1DlFGdMqUnd3IDH3yeyVMgNyS+THq7ECHUqChbvhq6719G4DJJHpEbh0hnrIJLFiA1
         UxWjX7AgHkI5n8kc3rJmbbvmI0nZ11QqlkTgNDr6Xe5yVJ9ZWrZAEnpnKv3FSIXubQKV
         34rw==
X-Gm-Message-State: AC+VfDyH9Y8ixeONvYi+Q65tzFTEY1lMoUfX4alH9ZyqH5Z3GtFCeVsF
        8Jcb2FFgD7dviREX4HM6lbA=
X-Google-Smtp-Source: ACHHUZ6GTXyHapDnbueeMr+/heuvgq8+sYS6+2PYxm+oa36EdoJBtzUt+Ba2VWcrodtlqLOJkXTHKA==
X-Received: by 2002:a17:903:2347:b0:1a9:91d7:ba2 with SMTP id c7-20020a170903234700b001a991d70ba2mr19855801plh.48.1683681878925;
        Tue, 09 May 2023 18:24:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902a50800b001ac8e0ea157sm2298979plq.144.2023.05.09.18.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 18:24:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 15:24:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: Prefer strscpy over strlcpy calls
Message-ID: <ZFryVUHtkN5QbKTP@slm.duckdns.org>
References: <20230510011122.3040915-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510011122.3040915-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 01:11:22AM +0000, Azeem Shaikh wrote:
...
> +/* strscpy_mock_strlcpy - imitates strlcpy API but uses strscpy underneath. */
> +static size_t strscpy_mock_strlcpy(char *dest, const char *src, size_t count)
> +{
> +	strscpy(dest, src, count);
> +	return strlen(src);
> +}

I'm not sure this is a meaningful conversion. One benefit of strscpy() is
that it's less error-prone to check for overflows. What's the point of
removing strlcpy() if we end up sprinkling lesser duplicates in the tree?

>  static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
>  {
>  	if (!kn)
> -		return strlcpy(buf, "(null)", buflen);
> +		return strscpy_mock_strlcpy(buf, "(null)", buflen);
>  
> -	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> +	return strscpy_mock_strlcpy(buf, kn->parent ? kn->name : "/", buflen);
>  }

Can you follow the users and convert the users accordingly rather than
masking it from here? ie. make kernfs_name() and friends return -E2BIG when
source is too long like strscpy(). I don't think anybody cares, actually.

>  /* kernfs_node_depth - compute depth from @from to @to */
> @@ -141,13 +148,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>  	int i, j;
>  
>  	if (!kn_to)
> -		return strlcpy(buf, "(null)", buflen);
> +		return strscpy_mock_strlcpy(buf, "(null)", buflen);
>  
>  	if (!kn_from)
>  		kn_from = kernfs_root(kn_to)->kn;
>  
>  	if (kn_from == kn_to)
> -		return strlcpy(buf, "/", buflen);
> +		return strscpy_mock_strlcpy(buf, "/", buflen);
>  
>  	common = kernfs_common_ancestor(kn_from, kn_to);
>  	if (WARN_ON(!common))
> @@ -159,16 +166,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>  	buf[0] = '\0';
>  
>  	for (i = 0; i < depth_from; i++)
> -		len += strlcpy(buf + len, parent_str,
> +		len += strscpy_mock_strlcpy(buf + len, parent_str,
>  			       len < buflen ? buflen - len : 0);
>  
>  	/* Calculate how many bytes we need for the rest */
>  	for (i = depth_to - 1; i >= 0; i--) {
>  		for (kn = kn_to, j = 0; j < i; j++)
>  			kn = kn->parent;
> -		len += strlcpy(buf + len, "/",
> +		len += strscpy_mock_strlcpy(buf + len, "/",
>  			       len < buflen ? buflen - len : 0);
> -		len += strlcpy(buf + len, kn->name,
> +		len += strscpy_mock_strlcpy(buf + len, kn->name,
>  			       len < buflen ? buflen - len : 0);
>  	}

Ditto, please convert all the users accordingly. If that's not feasible, I
think it'd be better to leave it as-is. I don't see how the new code is
better.

> @@ -851,7 +858,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
>  
>  	spin_lock_irq(&kernfs_pr_cont_lock);
>  
> -	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
> +	len = strscpy_mock_strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
>  
>  	if (len >= sizeof(kernfs_pr_cont_buf)) {
>  		spin_unlock_irq(&kernfs_pr_cont_lock);

This is an easy conversion to strscpy().

Thanks.

-- 
tejun
