Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DE717467
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjEaDcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjEaDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:32:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B4A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:32:32 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565a63087e9so68960547b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh-com.20221208.gappssmtp.com; s=20221208; t=1685503951; x=1688095951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwIn9A/3h6kb4VvZG2aUfPXs9cJPwe4RAvyyxJjYKPk=;
        b=2CNVHhuaVTG584FDACPkoosLtm5xST6kmLqLiv+9h42wJnfSaSf1kLL8OvTJSB6Bp3
         cukhpJId7lTytvkDhlOj/lVIiv9OBAOM7q8yDoP3qkuPNnESZOWuWnrEduVTKarKbzLd
         EHEES7P+R+DE7K2AycjgZPdPrtSJP5XqrEFm5kEtxlrG1WXGrx2RwH0hMzNJzl7ZKVLp
         ximLQN0W4UgszV1DBwK4v3Qb5YHhNLVIx5vO9cvFadr1P6rL+VuPd8nxu7vdsQo65G8j
         ejpqDUVBPoOgYfd1tvC2NfaQrFLpPQnqtXrkQLmPyIpF1N+YcG73/+JgwPK+UeitSiAz
         3MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685503951; x=1688095951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwIn9A/3h6kb4VvZG2aUfPXs9cJPwe4RAvyyxJjYKPk=;
        b=RHXjHOS4nDCT2Q5MmLCTCHTpyzmR7A4MZm0fyy8drsUWL5yyYhsys/JhknxO4w0SwX
         sDwavluCE6sVAAq8OyyFNvJm22FtF7T9LBt6Es3CXAylnpuY9uzmpv2Kx4cI6mJsSF8n
         9jv63ezizpP792/F9d7QgHDlw8zSrChhyn7o6Vi+9hgZCyuxvmWtJw4SrVZjpBFO9Qy+
         RBuna6Y7R9f4zjfpcGuZfXT/5xhHvlzqmpfnMY6z5fPn8FPuEPloGzbykAswLOho7M8c
         E3hZ8SVx5SH5jH0hYVi9etH0Qw0lRsG05KwJwSIrRSOiHDMJME6sbyWXaFw66x9lXVll
         66+w==
X-Gm-Message-State: AC+VfDy6eXQxU7aSV2pZnFCTPyvbWi56w2bAmtfSqCP9iUnKa4ha3oxi
        Pyur2trMc/mq3U3Jdsj43vzlPFBVfzjVU+r8W22yhA==
X-Google-Smtp-Source: ACHHUZ7EXnW0YcjSmJKT8Tx9qr3ImGNRICkccKl2sn7+ggBZczeplHrHQVfss+yln0MJrKESPw4iHtHFmQylrz1feaA=
X-Received: by 2002:a0d:d412:0:b0:565:8c16:a0e1 with SMTP id
 w18-20020a0dd412000000b005658c16a0e1mr5507264ywd.13.1685503951455; Tue, 30
 May 2023 20:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230529152645.32680-1-lhenriques@suse.de>
In-Reply-To: <20230529152645.32680-1-lhenriques@suse.de>
From:   Mark Fasheh <mark@fasheh.com>
Date:   Tue, 30 May 2023 20:32:20 -0700
Message-ID: <CAGe7X7kxfrTvg0s3JGasnhFOLFS9FR7uTjwp+YGG7hTNi2UULw@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: check new file size on fallocate call
To:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 8:26=E2=80=AFAM Lu=C3=ADs Henriques <lhenriques@sus=
e.de> wrote:
>
> When changing a file size with fallocate() the new size isn't being
> checked.  In particular, the FSIZE ulimit isn't being checked, which make=
s
> fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixe=
s
> this issue.
>
> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>

Looks good, thanks Luis.

Reviewed-by: Mark Fasheh <mark@fasheh.com>
