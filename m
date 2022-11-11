Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA298625FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiKKQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiKKQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:42:08 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D1E014;
        Fri, 11 Nov 2022 08:42:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u11so5109927ljk.6;
        Fri, 11 Nov 2022 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmbzElWIeT+9vovZu3NB4TMayyZ9E599kQ0knoXnmdY=;
        b=nQVXiDD7vdxMGob6W0WyWaHRkFLJ6Y1EKZ4dXQCSjX7CqFUfpW/T0M0+u3R5cDfMBq
         wPq+xd8IGqiB9diKIMdTd6v901rXRUsA8KZk4WOdOkGnyG1tZk4kXgnz1vmxTxLPaYLR
         FOr1G5tmbQ6QgknxhOlJv0qX+7bMabwHTqyRX8jFwOgrujb2fNHzhnoyv/HW0Bf4Qw6m
         SXLys/o8Ke/OfVY0D4mCRRhYccK6F4nqSzUn9EZE7YxdehIrOEeaJ1nbzSPfBDbBcOUR
         TueGeU4DgfnkMSQHr6dfoqw2D5roWen6XQF0Tt2yvdoeAOEAPmXxFc8/UQyPo5wG4xkX
         eWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmbzElWIeT+9vovZu3NB4TMayyZ9E599kQ0knoXnmdY=;
        b=xbxiz03RJZA9p8n8EVPB6TgMMEpP7ZRZtrN4W4ojdQagJymAeGLpsfPZelas1ARJMW
         74Jr67phKrMbz32RycvzM1B9dVlr/m4Yo3pHTW+FpwSRLJhOlgNDKWRQnqxf/WaawVzk
         ROdWly8vRnmqwnlNkAjdpBvnMw3f6GzSzgjp1bQ6IfxT7jx7ux25HDzzHVIFOmXOvd47
         IdACZq93UYwvTie1UW5OBhh2PJm5GE2BfZGxjoYK7ZZgmY3HF3Q0y+mSPwD+RcZJOQ47
         7pR+OzBrtUYveTE4RvKwN2AqqSfMs0AWybSWcE2yGVY6fs64fXs6qyg0mxGKs2aOzQ+I
         T5JQ==
X-Gm-Message-State: ANoB5pmFk0cuerQ8PgdYm2JfPiwhlqjXb2YQRdnKbYkpjr+Rs7fev99r
        9YYbHh+rt3gp6u94Oo8JwrdYHkooGy0Zjg3FkIw=
X-Google-Smtp-Source: AA0mqf56MRUi7NfeRYzwyxEEmg227/GEXmrjKYYIOs0VD8J8ZbgXpV0Oc61plqmQ3z9zebJVT/l/zfU43umr3zV9O8k=
X-Received: by 2002:a2e:7007:0:b0:277:388:3fa5 with SMTP id
 l7-20020a2e7007000000b0027703883fa5mr978420ljc.41.1668184926004; Fri, 11 Nov
 2022 08:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221110113034.17563-1-jakub@cloudflare.com>
In-Reply-To: <20221110113034.17563-1-jakub@cloudflare.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 12 Nov 2022 01:41:53 +0900
Message-ID: <CAC5umyhw=V1O_cC+Q4=XSye7htJ1aSAhMmbqSe7TngsohhuQ6w@mail.gmail.com>
Subject: Re: [PATCH] fault-inject: Enable stacktrace filter for x86-64
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=E5=B9=B411=E6=9C=8810=E6=97=A5(=E6=9C=A8) 20:30 Jakub Sitnicki <jakub@=
cloudflare.com>:
>
> Stacktrace filtering for fault injection has been disabled on x86-64 sinc=
e
> 2007 due to the lack of a DWARF unwinder. See commit 6d690dcac92a ("fault
> injection: disable stacktrace filter for x86-64").
>
> In 2017, the ORC unwider, an alternative to DWARF unwinder has been added
> in commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder").
>
> We can now re-enable the stacktrace filter for x86-64.

The same change by Wei Yongjun is already in the linux-next via -mm tree.

But thank you for the good explanation.
