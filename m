Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F2730C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjFOBao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjFOBal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:30:41 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002532126
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-555508fd7f9so929133eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686792639; x=1689384639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqTJGy1pP+37M23cEv9MnGAr7eJIKEBvtZw/Ram/MfI=;
        b=OQlly79gtFjEuGauGHsbJ315q4qG6PgFUovF0wRl1/ibOrpOs7xMRQEx6wnUVX8eqH
         5GA2VmYqzZmjXYLA1WfVDeNE3KPC0kYsmXGqUMQpQysyqc3gseUC7jQ2VxvriDMQ0Txr
         VcwfU7eZRZaOvA0Aa8Rb3z5isaR+Q0qa0jxGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686792639; x=1689384639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqTJGy1pP+37M23cEv9MnGAr7eJIKEBvtZw/Ram/MfI=;
        b=PdQvGpZoBaxEbK6LHE4gquDNo9BPrrFBj/4zBGeFQM92lCG7JisdQPMtcrjzef5UfL
         6CDmM5WpgJ+ULiXlZlYnyRfdJ9y53o5Gt/X94zCSk0R8TKxWZbuUjTWH2BhV2hOg+QcM
         RshSKU7kssTR/7+J4bnm0+wMC52XP45dRtMQWtiYbSAx4qhbZmb4M3esl4OwyyOqJ/sL
         Z2dy/AoLfe5lVUF8Bow6RJB00BPsUATwjAFUR7ZWz1NyyW9T7s2dDZzaQrwR0oNj9IgL
         7+bsDwFYztHPntOG/OUkgKIN9SpiyHAU15bT+dUV0HlI0Qli62S8XuBQKZahceuznvm7
         vgqg==
X-Gm-Message-State: AC+VfDxVZ35rL40QK+K5oLlNJiKtAbYijU42Tvglvx2b0XQ3/nDSVWkk
        1+upFexIiZ6+lz2vJt/pFSEs7w==
X-Google-Smtp-Source: ACHHUZ4rHxRNcRyejiJWzUKFbQsjRt6L83CuzA68ynRIGlPyDfAZlE1xaWh7moM4leJgwDqpB3cwXQ==
X-Received: by 2002:a05:6358:f1d:b0:12b:d5bf:5a99 with SMTP id b29-20020a0563580f1d00b0012bd5bf5a99mr3420625rwj.10.1686792639186;
        Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d36-20020a634f24000000b0050fa6546a45sm11755234pgb.6.2023.06.14.18.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 18:30:38 -0700 (PDT)
Date:   Thu, 15 Jun 2023 10:30:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH] zram: further limit recompression threshold
Message-ID: <20230615013033.GA1488555@google.com>
References: <20230614141338.3480029-1-senozhatsky@chromium.org>
 <20230614125210.3c6b5c1e34e18fbca7f59dae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614125210.3c6b5c1e34e18fbca7f59dae@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/14 12:52), Andrew Morton wrote:
> On Wed, 14 Jun 2023 23:13:12 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > Recompression threshold should be below huge-size-class
> > watermark.
> 
> The changelog explains what the code does, but not why it does it?

Good point. Let me send out a V2 quickly.
