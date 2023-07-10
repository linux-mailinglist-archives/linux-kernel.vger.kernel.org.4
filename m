Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0324B74D0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGJJDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGJJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:03:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B72119
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:02:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so6353476e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688979750; x=1691571750;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RY1Cf45ecIWbc7NEFgS5rEslIyMu9IK3gvaqBb6Duos=;
        b=Rbr7ix116IC3UXycX1Yvm0AS9UwmXGOaJGC+zn/J+Lk+p+rESDxtlvW5Lf5VTvzP8l
         0O/YVAPm/Oq7XbAPQllEfAjy6iZJHC1uozpAd5SAEZFCDfO2EdgggUg0FwkSvOvFXTyg
         mFVLKabEUf0OUMOcoynH8KCa/F5luTZfwtkeKpV5/KKOgX8hasRE2cD0+ZF6vVh7xei0
         1CxYHaZTj52h6+nBHZthpMTQd/v/4h8VjVspPu+Mo/mPD5sIJPRdBEDVfeQsVBSuTRmB
         SjRaDKgXQbS+tVcNcA2tC95EScaIEuaMedfmrmxMpfUeTx6Djg/U0kTL4/GHTQBE2Bi9
         IiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979750; x=1691571750;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY1Cf45ecIWbc7NEFgS5rEslIyMu9IK3gvaqBb6Duos=;
        b=N5T0vrsJpaWbNUw3iP+OCM3rNGJjW7pSD5/WFTdyeO88JQ3TbM9tWNO7hhybgn3Aof
         ztEavxLIJsYCC2v/WKOUcNJzYOOLcCQ5PvuIKtN1dUICTX1IemaM+/ssGbQWecoBjiGv
         X5qkc3n0qC/w/F9x7hQHc64v9cz7D9HnmyM2bE+9LuLTfAhvxNTbxF2iwpzupDVHvQ9o
         AxJMofE1CDFUeWIz2jsoBBBpChg1p7m18ANEgcx34MFOrD9HkQYMDOhWV7v7oFAeJAJu
         B4tq2pz1cKyQlpBt/UIi18QP9QkOrJwDeOuLQYSDrM1VF5f9O05su/zAH1yc/C0Rjctg
         Yh8A==
X-Gm-Message-State: ABy/qLZ2j8bQiDJFI3VDUVMjRN8QLUz84Bhqo5kDi5ltZbLfB5mF2NCE
        bsr4PNwURX24Lrcfv7+DeA==
X-Google-Smtp-Source: APBJJlG63m6dK9hI0i/Atwxqo1d1NMTXw1NIVOWVj0hS/ZK0vavx/VW2cjuvUHiDRizfVk6hz8xzgQ==
X-Received: by 2002:ac2:4eca:0:b0:4f8:5604:4b50 with SMTP id p10-20020ac24eca000000b004f856044b50mr8378739lfr.64.1688979750142;
        Mon, 10 Jul 2023 02:02:30 -0700 (PDT)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7ccc8000000b0051a2d2f82fdsm5488043edt.6.2023.07.10.02.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:02:29 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:02:28 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     lilinke99@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in
  hugetlbfs_file_mmap()
Message-ID: <36509a07-5ab0-44e8-85b3-5cf884a9aff4@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -157,7 +157,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
>  	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
>  	/* check for overflow */
> -	if (len < vma_len)
> +	if (vma_len > LLONG_MAX - ((loff_t)vma->vm_pgoff << PAGE_SHIFT))
>  		return -EINVAL;

Proper fix is to make everything unsigned probably.
