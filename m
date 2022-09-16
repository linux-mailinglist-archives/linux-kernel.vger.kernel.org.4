Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23EE5BB0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIPP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:57:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A950AE9F2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:57:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 29so32107411edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IfmQcNO9QHg8j8Uhq3rncxzFznO0n0wkKmT507hfUL0=;
        b=awWsmrqEKgLSgD5R1Fy94Oa6IC1T/47utZnjlNP/H1225NlD5p8zzZjcF8GqyNmJfW
         exq1Jv/hjGh0J2WgSRbZpaB0is+jTKYBKVQdIGCCzhkOTRYqHFLsdfSJ7r7PD+cYvtIT
         h4ByV1L9DZUJAMApgnp3GaRlHgA/XMMdOaZqgb8dAYD76JcC+p6poBjcDGyebpFn6uBe
         kPzdDqXsy4KVb7PgmJ3ikS3XVdIHPJ45zDF7lXUTNrWmRZFGCO+QxY3i6/9BmIer8qCc
         u9WRrilyhNwE+y34RBAPLQQOxN0WqNyMgDBlzRNfLC323kVM7IIRrwk+QQdF9UmAv1/S
         FB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IfmQcNO9QHg8j8Uhq3rncxzFznO0n0wkKmT507hfUL0=;
        b=Adg7N5uEwOSsXbHypP+hagUilF2hZ+b4kz9Qnvic7o8r1/m91f1ZTD4WxAiw5QdyvI
         muhIhIK4gf5e3BOpzY5z/YpDu8KuTgoGpStMsRUg8m20sMOcLyiONQrAHrhHK9OUiupy
         E4cFt4Jxx1X2wdCNU2wwtBRT2EohFYOuEqz1nUPlyh+lnsrC/cpMqE24f+n9MI/tGiPS
         kRsqarEr4Jg28nK5wvRRTtAMbG4C8QrkvOG9jggo2xIg7g8esg3pdkGWsV5jdSdf93kp
         emxGjQ+kWWJnZM5c+Jd0htg7vePxAL1UWMd1R5z01SbK1k7X80qTEgAOx4X4e1mRpjlf
         Uf3A==
X-Gm-Message-State: ACrzQf1cv/RhLf5ojtVgCGCgmRk5hKT/blMOkjUocj5smRFiQjJ4P7y5
        BhsxTtwi4iMKs+QJnKAml7E0/cXbTq/NKkwOzr0C34zs
X-Google-Smtp-Source: AMsMyM5L4re5GU/y95IhllKLwkcK/qRyso0nHutS1g7jQ6l/AA3QQpHLCTIyY2iDyvmbN0eYsiuDsZrnyK2PQd7jhaM=
X-Received: by 2002:a05:6402:3508:b0:451:db83:b2a7 with SMTP id
 b8-20020a056402350800b00451db83b2a7mr4599042edd.266.1663343875857; Fri, 16
 Sep 2022 08:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164730.515767-1-e.shatokhin@yadro.com> <20220915164730.515767-2-e.shatokhin@yadro.com>
In-Reply-To: <20220915164730.515767-2-e.shatokhin@yadro.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Sep 2022 10:57:44 -0500
Message-ID: <CABb+yY06VZB8mk7S=N1LO=AcwyOH2nfuGo-eyxRdRx782jDB_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mailbox: Propagate errors from .send_data() callback
 to mbox_send_message()
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, Ilya Kuznetsov <ilya@yadro.com>,
        linux@yadro.com
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

On Thu, Sep 15, 2022 at 11:49 AM Evgenii Shatokhin
<e.shatokhin@yadro.com> wrote:
>
> msg_submit() calls .send_data() function from the mailbox controller driver
> to place the first of the queued messages to the mailbox. Depending on the
> actual driver used, this operation could fail.
>
> In this case, if mbox_send_message() is called in blocking mode, it will
> always return -ETIME rather than the actual error reported by the
> underlying driver. This could be confusing, so let us propagate the
> error from msg_submit() to mbox_send_message().
>
In blocking mode, the client gets -ETIME because the api waited long
enough for the transfer to be successful.
It is the job of the underlying controller driver to be in a
consistent state and recover from errors. It may print its own error
but the client shouldn't have to differentiate between failure causes.

thanks
