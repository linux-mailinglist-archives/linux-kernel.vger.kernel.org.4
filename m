Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F86C922E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCZDIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:08:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6E211E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:08:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so5476853pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679800095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haiHSIXyTrgs+nuMuGJ9uAsYLTzypzPClX75p2zdkII=;
        b=OzELbhN3X+YAej5ML0RVHSfuCdukvlLnpP0NlS1Cpbe3GvmV0qwE9FCZ1wEY3HfcFE
         bJPdtr4L+1YQmA63TEJq592M+mqxrw34NpadrLIDdPgsdxy68US2kIgzsTspnwG2bOcj
         nDa8PNpfTn7uqznhso9JlD8l6c3oATx1SXIcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679800095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haiHSIXyTrgs+nuMuGJ9uAsYLTzypzPClX75p2zdkII=;
        b=eNoqQzsxLvyKQsxhfqO4HtziGDdcADmcKOZKFe5bvOafaW7rwI4dZSsjzSzlIWroU2
         MAT9gnwp1sHPrB9TFfUJEPbKjfVp7+DiQ2NZU7H15UemlS/rU6FXIlalU1WSiTHCqn18
         ELMkN5qIWxQTDMXVOP/4/osMgDb1fRC6S2PcTZ/dF/7o+kAJ+ZNljw5OuT1YNY8K86ag
         zX/P8ugpiKL5qlKABq6z2CwzGyk5uByQlfG12SY89glm3F2tG4T7NwQ07riM2xkE1GLD
         u7Y81UzPqv3rD3m13z3NfAou7ByJ5hA1eC5NE6LPP+1st6BoqrcLh4NsMxuPcKD/391x
         BnUA==
X-Gm-Message-State: AAQBX9fIvIpKhSRv6wtvUN6mNXSKM9XY0d+DUk0PVEUlWsqD44vm5gld
        qYb9MSWDduMeWiVNuLg/LoH5dA==
X-Google-Smtp-Source: AKy350YD0Fczy/2vkTKdMdzOk7dPmf/iPpSLqWljQuyjHcAbRs+8LJkVFeTMQJ2VGaM78e3s+ZydiQ==
X-Received: by 2002:a17:902:f0cb:b0:1a1:aa68:7e61 with SMTP id v11-20020a170902f0cb00b001a1aa687e61mr6827103pla.33.1679800095682;
        Sat, 25 Mar 2023 20:08:15 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b0019e88453492sm16730366plb.4.2023.03.25.20.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:08:15 -0700 (PDT)
Date:   Sun, 26 Mar 2023 12:08:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged
 parameter
Message-ID: <20230326030810.GC3269998@google.com>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
 <20230325071420.2246461-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325071420.2246461-3-liushixin2@huawei.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/25 15:14), Liu Shixin wrote:
> +++ b/mm/zswap.c
> @@ -761,15 +761,15 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  	char *s = strstrip((char *)val);
>  	int ret;
>  
> +	/* no change required */
> +	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
> +		return 0;
> +
>  	if (zswap_init_failed) {
>  		pr_err("can't set param, initialization failed\n");
>  		return -ENODEV;
>  	}
>  
> -	/* no change required */
> -	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
> -		return 0;

I probably would suggest to simply remove `*(char **)kp->arg`
from zswap code entirely, it doesn't solve any real problem
(as far as I can tell).
