Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163A688628
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBBSMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBBSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:12:51 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3336DB24;
        Thu,  2 Feb 2023 10:12:51 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id q10so1460003qvt.10;
        Thu, 02 Feb 2023 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu2PIhqwB/jA5g6/FKXtK5UWNVrTlqF+m2/SNkuST3g=;
        b=faARiKxCZLzQbjD1qCCn6AklBNIT8mmv9blF5BevytlDpR1uj1tE8NO1fUZV+v5WTS
         J2uog8kc0KVMNGjE/zid1sFqF+luQBj6/lh9P6nRZrMAUz7TewfNzCo2/RbmKT1OK6ur
         wh5JxUjPNJL3xyaaEmV8eWeH/NXrykleEamy///m7ZhyVvFm5DwmD8nAXmTOSx6pNzsf
         CyXc268LHFZ6bOJv9QfAjsu3RqLx32qO8W0G1hyA/sIlH6B9KDFof0SaeUPTZOnfJCWL
         ZBbYcu3EPHWDoM9Unkhiq5Emrb+g40JMADDUD72Fdn5FMW79/AC5gJ8eF8bGy8cnvAi6
         Q6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vu2PIhqwB/jA5g6/FKXtK5UWNVrTlqF+m2/SNkuST3g=;
        b=eaEaUPI51gfISBKF36hNslFp0uTPANX43l+UdQyhstdJEzxU2VhOAWZ9yyOF7ZyFVI
         0ohnRYAn8foSi0+vX786mQXPfB7Rfp7vbJZC7qNi6boKFIB69VGWBoJMRiPWH5VqGgZj
         bc3lip8e+tviF1OwRjubmCKBt7mpUfCSQuBrtF6/x6nRNp/xhTQwZWjhI+xxtacIZ5Nh
         UmhpNiOY+QSJmiMgekwogyPl0k5Vjxn8iCNzRNcz82atyxxHSastHlarQu0sSW82YiZI
         fkZFf27HaVNwVUcvF/rF9un7dnP4c6sXDM9X4szUr8rpp7P7XLG2u9k6jxsAYH7AQLvY
         4S1A==
X-Gm-Message-State: AO0yUKVd6H+mhGIatPHw+ytvmoperD1F7ZQ8miNfKGAVhhiKdfEY3Zvo
        LaluMDKscCydznlQ/imfsThVFMVh2fJfXcQl07Y=
X-Google-Smtp-Source: AK7set8+ZIkl+bDv+TJMe38gRihkPFyCuXiMu+1Eel893PNKyOjjWb5MRcTIoJ1aRPPe4HVRC+Xvu15N4meyWWj/JuA=
X-Received: by 2002:a05:6214:a44:b0:537:7f85:22b7 with SMTP id
 ee4-20020a0562140a4400b005377f8522b7mr476625qvb.77.1675361570130; Thu, 02 Feb
 2023 10:12:50 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230126051713epcas1p10a9005ad21887893a486100cbbd376e5@epcas1p1.samsung.com>
 <20230126051657.163497-1-huijin.park@samsung.com> <20230126053136.GC28355@lst.de>
In-Reply-To: <20230126053136.GC28355@lst.de>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Fri, 3 Feb 2023 03:12:41 +0900
Message-ID: <CAMy0x0n_vWQrPwtzXCQ9v_-K89nYOHWL0mUf2LGwrOONx0x5hg@mail.gmail.com>
Subject: Re: [PATCH] loop: change fsync to fdatasync when update dio
To:     Christoph Hellwig <hch@lst.de>
Cc:     Huijin Park <huijin.park@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:31 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 26, 2023 at 02:16:57PM +0900, Huijin Park wrote:
> > In general, fsync has a larger overhead than fdatasync. And since the
> > dio option is for data, it seems like fdatasync is enough.
> > So this patch changes it to fdatasync which has little load relatively.
>
> The only difference is that fsync also syncs the timestamps.  So this
> change looks correct, but also a bit useless given that buffered to
> direct I/O or back changes aren't exactly a fast path.

Although the difference will be minimal, why I suggested it is because
it can reduce unnecessary metadata i/o (helpful on slow i/o devices),
and using fdatasync looked correct like your opinion.
In some environment cases, loop setup for mount is required when
application is initialized and this change will help.
