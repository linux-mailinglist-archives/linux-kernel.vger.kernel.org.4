Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369EA70C5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjEVTIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEVTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:08:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58308B0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:08:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so2270601b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684782530; x=1687374530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXfengDBQCUrKr3M+u68PKzklPcywUAkxq6DICSwzdE=;
        b=i657Phs/dxy79hUTzTdhMdU9fDmwozweb1FJARnrm+HtjZsxVm45R+1dY6Gnv8c81e
         4BT6uwL0Xsiqc2e4x6njetekkljB+wrQhgX/RuabIolQmqpD7+2L4U6WHWHNhOdU4z70
         b40q7b23FZ26OytMl62bVMPZxkCLhw/ae2n5ECioxb0E4Pg5T1fcB8LuyEOHQal+mXRn
         QeF4gr+4lZoCDoevrm+tuEPdlYOgkWhejBshhog1508yvvei1lrasj437QE6KsmJWox/
         d8mjVcNNLk2nDXOTW/m7rPSkIYTENLyNPQ5DxOLux2EZ1cnsQfAgdx2zlcUV9UXCAeH2
         wbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782530; x=1687374530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXfengDBQCUrKr3M+u68PKzklPcywUAkxq6DICSwzdE=;
        b=LkNrJ/x7gmJ8Jg5qJEbd6nI7Uh022OzUsb4kbtJYb4VbQUDkyhonW7QIaCnc/2wsDD
         uLR9/3m/jDPwsN1e9zGeANWbCYV2T3fn3ERb6t9bmZLoCju2uq8glgSUj2OcQRq6t0O8
         I/cI3xRLlRMFC77DXuhvB7MiFfH6CeMgs4C2Z6ZL6Qadv15M+zXHv4qwiVHJf8HasUXR
         G5myvFXbTU3c1KOUybtqkI6kFvfPHE3KM/RexvBu+HePUjoJaG6k6TtaYdAUc7FLipcA
         Thq083ypIgrKNM3V5ChGinHmDjQyiH8zJmh0j33ApWVHgdavgJG6loRs7r9r0ZXmuytH
         RUXg==
X-Gm-Message-State: AC+VfDxPpo+fMJjGK5fgg7HJL5+pRa9d0N7cPVh/ZQqjQVnA5q9QoK17
        Mb7UTFvkwifpeR8Phu4Fkr+nN8qfAyg=
X-Google-Smtp-Source: ACHHUZ69ZTgZhjNHB2YCwh0dv/tQCMnkYjBgDeYXgUrvFLsfFoqLbshv7t1xvwHEuCrVOHbzIxavIQ==
X-Received: by 2002:a17:903:2310:b0:1ae:1364:6079 with SMTP id d16-20020a170903231000b001ae13646079mr15171237plh.44.1684782529579;
        Mon, 22 May 2023 12:08:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001a9bfd4c5dfsm5192906plb.147.2023.05.22.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:08:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 09:08:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev
Subject: Re: [PATCH] kernfs: fix missing kernfs_idr_lock to remove an ID from
 the IDR
Message-ID: <ZGu9v3OA0wkhff7g@slm.duckdns.org>
References: <20230516034536.25548-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516034536.25548-1-songmuchun@bytedance.com>
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

On Tue, May 16, 2023 at 11:45:36AM +0800, Muchun Song wrote:
> @@ -655,7 +660,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	return kn;
>  
>   err_out3:
> -	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
> +	kernfs_idr_remove(root, kn);

Good catch but I'd just open code the locking here.

Thanks.

-- 
tejun
