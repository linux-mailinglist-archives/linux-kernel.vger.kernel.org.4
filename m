Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8FB6C9274
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 06:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCZExg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 00:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjCZExe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 00:53:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD1270B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 21:53:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q102so4946192pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 21:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679806413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QM1QHLHovDhJzAjlOXny2HDNK64Zjmklql6ekR44ec=;
        b=IcxZxSEHYLzyIPpHba6988UhJUOlViWxxsBecBnsuL8YEk7IOr6zBxV8En2Gn5XPVf
         qbvs9f7/6TVaV0SWoS/CM/yc6P8P9onTMCQ80z43nBhpoUtIAWIBln37NHnpcA/5mu+4
         k2Y/Xd4RYb6lr7IjelqZIR9yFoHBBj5IY4RoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679806413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QM1QHLHovDhJzAjlOXny2HDNK64Zjmklql6ekR44ec=;
        b=oj9dR+tKr+3hd3owCxrKFep8A4UItnDYdRLxCgmeJiZEx+Ij2VtGTn+ztszxZ4kSIa
         OwW8OUSatWAzjLJbCZhhRpUlbEqUjiowZyA4oB5JgutPQ8anNd2IxYDjYPt68Avs3QY+
         WqtyDvN+PVRiHmeNfGoj8Frpca3p7b7Lc/z9jY0mEPGIDbm8iM/4UUtQZjQGVbq+UOXT
         zhCrR+xwBKYZRoMJEQsFNhpqbIciVeqdfFLCrw//IAgkG6LdRxK9BZzG62ASad6p3nwT
         EbnMjLCScXIzYmHaA9p0zZkIn9PhhbFmEv3shtBCx0b8Pt/S5M4xnltgvvT3LvZGYvRz
         xXug==
X-Gm-Message-State: AO0yUKUzjAlNfPoR4BILCL2XT+N198cy4dnzx615p429cu2FcedC0gB6
        8UdiXKIDiJwgXV99B7IrLCcsbg==
X-Google-Smtp-Source: AK7set+ujvoRYM+0LuG/siQmSb0xloLA4K5Y35QLXraN+IKqGx9DHvLNuKbNLWwmAGQcwy3OJ2wkbQ==
X-Received: by 2002:a05:6a20:3f0c:b0:db:4c00:7918 with SMTP id az12-20020a056a203f0c00b000db4c007918mr7132697pzb.0.1679806413373;
        Sat, 25 Mar 2023 21:53:33 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id bn10-20020a056a00324a00b005a8aab9ae7esm16467454pfb.216.2023.03.25.21.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 21:53:32 -0700 (PDT)
Date:   Sun, 26 Mar 2023 13:53:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged
 parameter
Message-ID: <20230326045327.GE3269998@google.com>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
 <20230325071420.2246461-3-liushixin2@huawei.com>
 <20230326031723.GD3269998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326031723.GD3269998@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/26 12:17), Sergey Senozhatsky wrote:
> On (23/03/25 15:14), Liu Shixin wrote:
> >  static int zswap_enabled_param_set(const char *val,
> >  				   const struct kernel_param *kp)
> >  {
> > +	bool res;
> > +
> > +	if (kstrtobool(val, &res))
> > +		return -EINVAL;
> > +
> > +	/* no change required */
> > +	if (res == *(bool *)kp->arg)
> > +		return 0;
> 
> Bool kernel param can be any of these letters 'YyTt1NnFf0'. Doing things
> to kp->arg outside of kernel/params.c is not going to be easy, let's not
> even try.

Please disregard my previous email. kp->arg is always true or false
at this point. I'd still prefer to not do kp->arg in zswap.
