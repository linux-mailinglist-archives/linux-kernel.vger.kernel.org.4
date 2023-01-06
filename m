Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911966086F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAFUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjAFUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:47:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2F73E16;
        Fri,  6 Jan 2023 12:47:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3025442pjf.1;
        Fri, 06 Jan 2023 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3K5fNM/nzv4n8frGSNTgnjfmQcbQ23OGBX1qT9ltz0=;
        b=bFuYjE2Pc/nTs6KfDZUI1NgEN+QcVUJw9fxK5BkxC/dkBUoP5RlBS6byXwPFiVHVHe
         9NyXx06z+Jrod0iXBxrlYGS87yyy+Ym8+WhuN8yWn8EJBT332qGl34XEIAVrpwyhnjU0
         1kfnmqX3QB15RuisdQM3y1eTpjUyFvW+ZKUyhUCz8ltfeBOkxaNs2wWkCpRY3i04lVgF
         i6i3iOSNtkMNmpk8T1qRIsxeB0+egcoa06KMLvi9grqUhulnMt7VuVBDhnz8Lr17VLW1
         i4a6B7LgtAYOOghp4PU2wKbmFb3B+aZPcH66DasP1QdQBn32fcRsuR5yIeeBR24DYwpo
         YelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3K5fNM/nzv4n8frGSNTgnjfmQcbQ23OGBX1qT9ltz0=;
        b=2dXRRCUBhPYtVqX5F/4LYvnKeZ4R4MdOwwWha52hppdLNPzTriKvJnHqyim6p9Xq4x
         cG1lZ9JJr9tAA1shU4FRNWUOc0tWAgsbr/pnD2rdIRjMJ+ZKAm03mfp1Ic7C3EUVIi4i
         NstEooSjw5EgkvjXt5IMVdmSncvKLcmP72CZIejfMLLOQ+e3arMpW2U6/L8nH11m4g4N
         kutIb5+OnQqYf0VNzl+zisi/CAkPuah++b+GWJqcCep+388E1RCQE4PnOwmd57xyzO6G
         BRvVSeo6vqnOMnGdUhxClnMSE8APA8iby958iUnTB4AjFgEN1RB/bh6B7eFMEyxE4+u0
         giaw==
X-Gm-Message-State: AFqh2kqnlYa97AjvY/+CSbnJy7EcnjFWhug0TOTUBSW27p06mjtDH6Oj
        H8mnPSn+VewHSFiFuCKMKWk=
X-Google-Smtp-Source: AMrXdXt7bIL3aFyfDi6qXalaT/9/Rwdp+Gzrb7mWBjKMJ8zexRBvSmMblBdIpzprXibods39fa9zbQ==
X-Received: by 2002:a17:902:d891:b0:189:d979:22a with SMTP id b17-20020a170902d89100b00189d979022amr59115032plz.29.1673038040372;
        Fri, 06 Jan 2023 12:47:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b00192d07b8222sm1371784plx.100.2023.01.06.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:47:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 10:47:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Message-ID: <Y7iI1gVcUHLwhQjl@slm.duckdns.org>
References: <Y7g3L6fntnTtOm63@kili>
 <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
 <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:45:12PM -0800, Luis Chamberlain wrote:
> *tons* has changed since e8c7d14ac6c3 and so the bots might think that
> *if* this patch is applied upstream it is justified for older kernels
> and I don't think that's yet been verified and doubt it.

Didn't look like anything relevant changed to me. Besides, all that the
patch does is removing a might_sleep() which can't hurt anything.

-- 
tejun
