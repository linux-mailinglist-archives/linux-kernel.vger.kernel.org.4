Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0B74F7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGKSBZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGKSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:01:23 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF110EA;
        Tue, 11 Jul 2023 11:01:22 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98de322d11fso176025766b.1;
        Tue, 11 Jul 2023 11:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098481; x=1691690481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNKx5mecavZml9uTR11vqF7/iD9TRraZp4Mq7iPLb8U=;
        b=AdfxrTb/drhGsq6EcV84ut7S8djlyi3o5PLZ9RoMwp4LKuSy7C24te/WdYvnfDWBaI
         FNJlG7w2VMsNiIN7wjEy0m7PDCkdlmWl/lmJq8v4LibBckOl/bwqVB2ABZYNgvuij9Gd
         CbwWWdp/GsL5JvB3aCkuTAGvUTW2Me9LqKiv888ZBzcwlVqlIZsuOc7Elu3Mz4adBa0i
         TKC+vf3l6DH+n5BCHHJogLpgXUhwdUGgOo+RGOS4qhh9pc5j9jxsxJt0lDr0N9UqJ0lX
         DOWVdqn6HD/gSRm1GGJu6p7EjUkWAmi529bNMD7kzRGg10JWg2ksXkT4Vwm0T4Pef6lv
         DIPA==
X-Gm-Message-State: ABy/qLaUhfKBjcupNJTJsydQGs/raOcEm/QXqGMC3jEwkQLf0T1M7JnC
        TBUrWBe6WByfvPdzW0wmY7q66YmOnvwBsvMquqKq9aYN
X-Google-Smtp-Source: APBJJlHQeurNzvCSVY9X+6HO0XK3dMCno+JxeOpcvshtgwKA9wqbbbUuZIkkNmQn7xkaGqRq3kh+I77F25Ugf1r7zXM=
X-Received: by 2002:a17:906:74d0:b0:987:6960:36c8 with SMTP id
 z16-20020a17090674d000b00987696036c8mr17433246ejl.7.1689098480641; Tue, 11
 Jul 2023 11:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230711114821.1273-1-a3at.mail@gmail.com> <20230711120806.GA27809@lst.de>
In-Reply-To: <20230711120806.GA27809@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jul 2023 20:01:09 +0200
Message-ID: <CAJZ5v0gJcMKbwjrwwnMi7OD59DoOTm3EKZrdr4eYs05qP10v6A@mail.gmail.com>
Subject: Re: [PATCH] Fix writing maj:min to /sys/power/resume (fixes
 hiberation with systemd)
To:     Christoph Hellwig <hch@lst.de>, Azat Khuzhin <a3at.mail@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 2:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 11, 2023 at 01:48:12PM +0200, Azat Khuzhin wrote:
> > resume_store() first calls lookup_bdev() and after tries to handle
> > maj:min, but it does not reset the error before, hence if you will write
> > maj:min you will get ENOENT:
> >
> >     # echo 259:2 >| /sys/power/resume
> >     bash: echo: write error: No such file or directory
> >
> > This also should fix hiberation via systemd, since it uses this way.
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied as 6.5-rc material, thanks!
