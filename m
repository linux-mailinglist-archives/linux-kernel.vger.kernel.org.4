Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0C705276
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjEPPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjEPPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEF1989;
        Tue, 16 May 2023 08:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911FD61B0D;
        Tue, 16 May 2023 15:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF3C433D2;
        Tue, 16 May 2023 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251757;
        bh=/4eCX/rOw6AlVX/hcqhfyVDRcwUOfZqMSsz45Vv4rMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbLTYIlaEpLHrhRRJEYtX/dvy1ZamGfUx0JkGuWLkkA2SnjDljYGJMdmSol/3hqun
         nfWZMT4/m3kq1iYVfYKioJUsz8puw5Wr+p9zR9EBQyy5ZTASVrREWV/2DpgUgWZZsg
         PgzT7mGYhbgupveN7fjkjsS8Ip5ismaGMnNAnmo/BqX0tTcKpqyUHdHnxfLlucaZ4W
         Rxf50+Z+wrsf6tzjiA4TBkcpxivsIqpf+oe1SdL+OgNtrtUPgnmALYr+/BO+hKoQXN
         9lVhifCVcFE8qU/YRibP6XlIkBus28DZ2lDlN+iRK23ZVFfT1f9JSq49F5hcHzhXJZ
         j6uqht2IbGjuw==
Date:   Tue, 16 May 2023 17:42:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ovl: Fix null ptr dereference at realinode in
 rcu-walk
Message-ID: <20230516-topografie-gejubelt-dba162b6e735@brauner>
References: <20230516141619.2160800-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516141619.2160800-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:16:16PM +0800, Zhihao Cheng wrote:
> v1->v2:
>   Extract a helper to get realpath and real inode from ovl inode.
>   Get realinode from realpath in do_ovl_get_acl().
> v2->v3:
>   Modify original helper ovl_i_path_real() to return the realinode.
> 
> Zhihao Cheng (3):
>   ovl: Let helper ovl_i_path_real() return the realinode
>   ovl: ovl_permission: Fix null pointer dereference at realinode in
>     rcu-walk mode
>   ovl: get_acl: Fix null pointer dereference at realinode in rcu-walk
>     mode
> 
>  fs/overlayfs/inode.c     | 17 ++++++++---------
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/util.c      |  7 ++++---
>  3 files changed, 13 insertions(+), 13 deletions(-)

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
